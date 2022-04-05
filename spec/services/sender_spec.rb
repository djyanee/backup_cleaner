# frozen_string_literal: true

require './src/services/sender'

RSpec.describe Sender do
  subject(:sender) { described_class.new(backup: backup) }

  let(:backup) do
    Backup.new(id: 'a810', created_at: '2019-07-10 00:08:02 +0000', status: 'Completed 2019-07-10 00:18:53 +0000',
               backup_size: '482.43MB', database: 'DATABASE')
  end

  describe '#call' do
    let(:response_struct) { Struct.new(:code, :body) }

    let(:response_double) { response_struct.new(code, body) }

    context 'when server responds' do
      before do
        allow(Net::HTTP)
          .to receive(:start).with('www.example.com', 443, use_ssl: true, open_timeout: 15).and_return(response_double)
      end

      context 'with status 200' do
        let(:code) { '200' }
        let(:body) { '' }

        let(:response_message) do
          ResponseMessage.new(
            id: backup.id,
            created_at: backup.created_at,
            status: 'Removed',
            code: code,
            body: body
          )
        end

        it 'returns response message instance with correct data' do
          expect(sender.call).to eq(response_message)
        end
      end

      context 'when server responds with different status' do
        let(:code) { '500' }
        let(:body) { "{error: 'invalid ID' }" }

        let(:response_message) do
          ResponseMessage.new(
            id: backup.id,
            created_at: backup.created_at,
            status: 'Error',
            code: code,
            body: "\"#{body}\""
          )
        end

        it 'returns response message instance with correct data' do
          expect(sender.call).to eq(response_message)
        end
      end

      context 'when server responds with different status' do
        let(:code) { '500' }
        let(:body) { "{error: 'invalid ID' }" }

        let(:response_message) do
          ResponseMessage.new(
            id: backup.id,
            created_at: backup.created_at,
            status: 'Error',
            code: code,
            body: "\"#{body}\""
          )
        end

        it 'returns response message instance with correct data' do
          expect(sender.call).to eq(response_message)
        end
      end
    end

    context "when server doesn't respond" do
      before do
        allow(Net::HTTP).to receive(:start).with(
          'www.example.com', 443, use_ssl: true, open_timeout: 15
        ).and_raise(Errno::EHOSTUNREACH)
      end

      let(:code) { '500' }
      let(:body) { 'No route to host' }

      let(:response_message) do
        ResponseMessage.new(
          id: backup.id,
          created_at: backup.created_at,
          status: 'Error',
          code: code,
          body: "\"#{body}\""
        )
      end

      it 'returns response message instance with correct data' do
        expect(sender.call).to eq(response_message)
      end
    end
  end
end

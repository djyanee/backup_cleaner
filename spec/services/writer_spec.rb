# frozen_string_literal: true

require './src/services/writer'

RSpec.describe Writer do
  subject(:writer) { described_class.new(response_messages: response_messages) }

  let(:response_messages) do
    [
      ResponseMessage.new(
        id: 'a810',
        created_at: '2019-07-10 00:08:02 +0000',
        status: 'Removed',
        code: '200',
        body: ''
      ),
      ResponseMessage.new(
        id: 'a179',
        created_at: '2019-07-09 00:06:19 +0000',
        status: 'Error',
        code: '500',
        body: "\"{error: 'invalid ID' }\""
      ),
      ResponseMessage.new(
        id: 'a827',
        created_at: '2019-07-07 00:08:02 +0000',
        status: 'Error',
        code: '500',
        body: '"No route to host"'
      )
    ]
  end

  before { allow(File).to receive(:write).with('cleanup_log.txt', output).and_return(output.length) }

  describe '#call' do
    let(:output) do
      "a810  2019-07-10 00:08:02 +0000  Removed  200  \n" \
        "a179  2019-07-09 00:06:19 +0000  Error  500  \"{error: 'invalid ID' }\"\n" \
        "a827  2019-07-07 00:08:02 +0000  Error  500  \"No route to host\"\n"
    end

    it 'writes correct text to the file' do
      expect(writer.call).to eq(output.length)
    end
  end
end

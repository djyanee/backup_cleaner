# Backup cleaner

Probably the implementation could've been done much easier, but I had fun while checking out things and playing with code.

---

## Prerequisites

- Ruby 3.1.0

---

Run the script with:

```bash
ruby run.rb
```

---

## Some final thoughts:

- I wasn't trying to implement code for every case that could happen here. The context was too wide for this.
- I assumed that the only thing that could happen to the server is a simple timeout, but of course, there are more possible situations not covered here.
- File namings, timeout values, response text, etc. should be more customizable, but I went with constant values, because of the lack of context.
- Rubocop and Pry were added just for my sake, without any real config.
- Normally the code should be split into descriptive commits :)

---

Cheers!

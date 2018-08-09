# calibre-alpine

A simple **Docker** container that runs a [_calibre_](https://calibre-ebook.com/) server. Every single minute, it **checks for _incoming_ books** and adds them to the library (via [_calibredb_](https://manual.calibre-ebook.com/generated/en/calibredb.html) command).

Inspired by [ljnelson/docker-calibre-alpine](https://github.com/ljnelson/docker-calibre-alpine)

## Usage

Let's consider that your Calibre library is in the _library_ directory, and incoming books are put in _incoming_ directory.
Also, it doesn't matter if you already have an existing Calibre library (*calibre.db*): if not, one is created with a sample book.

Run the following command:
```
docker run --name calibre -p 8080:8080 -d -v $(pwd)/library:/library -v $(pwd)/incoming:/incoming lmorel3/calibre-alpine
```

Then, open _http://localhost:8080/_ and enjoy your books. If you want more, put some books in _./incoming_!

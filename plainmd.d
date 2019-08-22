// Convert a markdown document to html, with rather plain CSS, but more
// readable than unstyled html. Requires pandoc to be installed.
import std.file, std.path, std.process, std.stdio;

void main(string[] args) {
	assert(args.length > 1, "Need to provide the name of the file");
	string fn = setExtension(args[1], ".md");
	string f = readText(fn);
	std.file.write("__tmp.md", `
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta name="generator" content="pandoc" />
  <title></title>
  <style type="text/css">code{white-space: pre;}</style>
	<style>
body {
    margin: auto;
    max-width: 800px;
    font-size: 120%;
    margin-top: 20px;
}

a {
    text-decoration: none;
}

pre > code {
  padding: .2rem .5rem;
  margin: 0 .2rem;
  font-size: 90%;
  white-space: nowrap;
  background: #F1F1F1;
  border: 1px solid #E1E1E1;
  border-radius: 4px; 
  display: block;
  padding: 1rem 1.5rem;
  white-space: pre; 
}

code {
	font-family: Ubuntu Mono;
	font-size: 110%;
}

h1 {
	font-family: sans;
	font-size: 150%;
	border-bottom: 2px solid;
}

h2, h3 {
	font-family: sans;
	font-size: 125%;
}

.header {
	border-bottom: 1px solid;
	font-size: 160%;
	font-family: sans;
	color: blue;
	padding-bottom: 5px;
	border-bottom-color: rgb(190, 190, 190);
	margin-left: 0px;
}
	</style>
</head>
<body>` ~ f ~ "</body>");
	string cmd = `pandoc __tmp.md -o ` ~ setExtension(args[1], ".html");
	writeln(cmd);
	executeShell(cmd);
	executeShell("rm __tmp.md");
}
	

# VHDL Projekt - Vysílač a přijímač Morseova kódu

### Členové týmu
* Filip Tůma (230896) - šéf týmu, nejlepší
* Viktor Vlček (240709) - svačinář
* Roman Vaněk (240707) - osciloskop master

## Teoretický úvod
:blue_square: 1 ČÁRKA     :yellow_square: 0 TEČKA

![image](https://github.com/vanekroman/digital-electronics-project/blob/main/Morse_abeceda.png)

## Popis hardwaru
![Period check](doc/period_cnt.svg)


<style>
.hljs {
  color: #383a42;
  background: #fafafa;
}

.hljs-comment,
.hljs-quote {
  color: #a0a1a7;
  font-style: italic;
}

.hljs-doctag,
.hljs-keyword,
.hljs-formula {
  color: #a626a4;
}

.hljs-section,
.hljs-name,
.hljs-selector-tag,
.hljs-deletion,
.hljs-subst {
  color: #e45649;
}

.hljs-literal {
  color: #0184bb;
}

.hljs-string,
.hljs-regexp,
.hljs-addition,
.hljs-attribute,
.hljs-meta .hljs-string {
  color: #50a14f;
}

.hljs-attr,
.hljs-variable,
.hljs-template-variable,
.hljs-type,
.hljs-selector-class,
.hljs-selector-attr,
.hljs-selector-pseudo,
.hljs-number {
  color: #986801;
}

.hljs-symbol,
.hljs-bullet,
.hljs-link,
.hljs-meta,
.hljs-selector-id,
.hljs-title {
  color: #4078f2;
}

.hljs-built_in,
.hljs-title.class_,
.hljs-class .hljs-title {
  color: #c18401;
}

.hljs-emphasis {
  font-style: italic;
}

.hljs-strong {
  font-weight: bold;
}

.hljs-link {
  text-decoration: underline;
}

.markdown-body .octicon {
  display: inline-block;
  fill: currentColor;
  vertical-align: text-bottom;
}

#descriptions{
  margin-left:5.5%;
  margin-right:3%;
}

.markdown-body .anchor {
  float: left;
  line-height: 1;
  margin-left: -20px;
  padding-right: 4px;
}

.markdown-body .anchor:focus {
  outline: none;
}

.markdown-body h1 .octicon-link,
.markdown-body h2 .octicon-link,
.markdown-body h3 .octicon-link,
.markdown-body h4 .octicon-link,
.markdown-body h5 .octicon-link,
.markdown-body h6 .octicon-link {
  color: #1b1f23;
  vertical-align: middle;
  visibility: hidden;
}

.markdown-body h1:hover .anchor,
.markdown-body h2:hover .anchor,
.markdown-body h3:hover .anchor,
.markdown-body h4:hover .anchor,
.markdown-body h5:hover .anchor,
.markdown-body h6:hover .anchor {
  text-decoration: none;
}

.markdown-body h1:hover .anchor .octicon-link,
.markdown-body h2:hover .anchor .octicon-link,
.markdown-body h3:hover .anchor .octicon-link,
.markdown-body h4:hover .anchor .octicon-link,
.markdown-body h5:hover .anchor .octicon-link,
.markdown-body h6:hover .anchor .octicon-link {
  visibility: visible;
}

.markdown-body h1:hover .anchor .octicon-link:before,
.markdown-body h2:hover .anchor .octicon-link:before,
.markdown-body h3:hover .anchor .octicon-link:before,
.markdown-body h4:hover .anchor .octicon-link:before,
.markdown-body h5:hover .anchor .octicon-link:before,
.markdown-body h6:hover .anchor .octicon-link:before {
  width: 16px;
  height: 16px;
  content: ' ';
  display: inline-block;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true'%3E%3Cpath fill-rule='evenodd' d='M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z'%3E%3C/path%3E%3C/svg%3E");
}.markdown-body {
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%;
  line-height: 1.5;
  color: #24292e;
  font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Helvetica,Arial,sans-serif,Apple Color Emoji,Segoe UI Emoji;
  font-size: 16px;
  line-height: 1.5;
  word-wrap: break-word;
}

.markdown-body details {
  display: block;
}

.markdown-body summary {
  display: list-item;
}

.markdown-body a {
  background-color: initial;
}

.markdown-body a:active,
.markdown-body a:hover {
  outline-width: 0;
}

.markdown-body strong {
  font-weight: inherit;
  font-weight: bolder;
}

.markdown-body h1 {
  font-size: 2em;
  margin: .67em 0;
}

.markdown-body img {
  border-style: none;
}

.markdown-body code,
.markdown-body kbd,
.markdown-body pre {
  font-family: monospace,monospace;
  font-size: 1em;
}

.markdown-body hr {
  box-sizing: initial;
  height: 0;
  overflow: visible;
}

.markdown-body input {
  font: inherit;
  margin: 0;
}

.markdown-body input {
  overflow: visible;
}

.markdown-body [type=checkbox] {
  box-sizing: border-box;
  padding: 0;
}

.markdown-body * {
  box-sizing: border-box;
}

.markdown-body input {
  font-family: inherit;
  font-size: inherit;
  line-height: inherit;
}

.markdown-body a {
  color: #0366d6;
  text-decoration: none;
}

.markdown-body a:hover {
  text-decoration: underline;
}

.markdown-body strong {
  font-weight: 600;
}

.markdown-body hr {
  height: 0;
  margin: 15px 0;
  overflow: hidden;
  background: transparent;
  border: 0;
  border-bottom: 1px solid #dfe2e5;
}

.markdown-body hr:after,
.markdown-body hr:before {
  display: table;
  content: "";
}

.markdown-body hr:after {
  clear: both;
}

.markdown-body table {
  width:100%;
  border-spacing: 0;
  border-collapse: collapse;
}

.markdown-body td,
.markdown-body th {
  padding: 0;
}

.markdown-body th {
    background-color: #ffd78c;
}

.markdown-body details summary {
  cursor: pointer;
}

.markdown-body kbd {
  display: inline-block;
  padding: 3px 5px;
  font: 11px SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
  line-height: 10px;
  color: #444d56;
  vertical-align: middle;
  background-color: #fafbfc;
  border: 1px solid #d1d5da;
  border-radius: 3px;
  box-shadow: inset 0 -1px 0 #d1d5da;
}

.markdown-body h1,
.markdown-body h2,
.markdown-body h3,
.markdown-body h4,
.markdown-body h5,
.markdown-body h6 {
  margin-top: 0;
  margin-bottom: 0;
}

.markdown-body h1 {
  font-size: 32px;
}

.markdown-body h1,
.markdown-body h2 {
  font-weight: 600;
}

.markdown-body h2 {
  font-size: 24px;
}

.markdown-body h3 {
  font-size: 20px;
}

.markdown-body h3,
.markdown-body h4 {
  font-weight: 600;
}

.markdown-body h4 {
  font-size: 16px;
}

.markdown-body h5 {
  font-size: 14px;
}

.markdown-body h5,
.markdown-body h6 {
  font-weight: 600;
}

.markdown-body h6 {
  font-size: 12px;
}

.markdown-body p {
  margin-top: 0;
  margin-bottom: 10px;
}

.markdown-body blockquote {
  margin: 0;
}

.markdown-body ol,
.markdown-body ul {
  padding-left: 0;
  margin-top: 0;
  margin-bottom: 0;
}

.markdown-body ol ol,
.markdown-body ul ol {
  list-style-type: lower-roman;
}

.markdown-body ol ol ol,
.markdown-body ol ul ol,
.markdown-body ul ol ol,
.markdown-body ul ul ol {
  list-style-type: lower-alpha;
}

.markdown-body dd {
  margin-left: 0;
}

.markdown-body code,
.markdown-body pre {
  font-family: SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
  font-size: 12px;
}

.markdown-body pre {
  margin-top: 0;
  margin-bottom: 0;
}

.markdown-body input::-webkit-inner-spin-button,
.markdown-body input::-webkit-outer-spin-button {
  margin: 0;
  -webkit-appearance: none;
  appearance: none;
}

.markdown-body :checked+.radio-label {
  position: relative;
  z-index: 1;
  border-color: #0366d6;
}

.markdown-body .border {
  border: 1px solid #e1e4e8!important;
}

.markdown-body .border-0 {
  border: 0!important;
}

.markdown-body .border-bottom {
  border-bottom: 1px solid #e1e4e8!important;
}

.markdown-body .rounded-1 {
  border-radius: 3px!important;
}

.markdown-body .bg-white {
  background-color: #fff!important;
}

.markdown-body .bg-gray-light {
  background-color: #fafbfc!important;
}

.markdown-body .text-gray-light {
  color: #6a737d!important;
}

.markdown-body .mb-0 {
  margin-bottom: 0!important;
}

.markdown-body .my-2 {
  margin-top: 8px!important;
  margin-bottom: 8px!important;
}

.markdown-body .pl-0 {
  padding-left: 0!important;
}

.markdown-body .py-0 {
  padding-top: 0!important;
  padding-bottom: 0!important;
}

.markdown-body .pl-1 {
  padding-left: 4px!important;
}

.markdown-body .pl-2 {
  padding-left: 8px!important;
}

.markdown-body .py-2 {
  padding-top: 8px!important;
  padding-bottom: 8px!important;
}

.markdown-body .pl-3,
.markdown-body .px-3 {
  padding-left: 16px!important;
}

.markdown-body .px-3 {
  padding-right: 16px!important;
}

.markdown-body .pl-4 {
  padding-left: 24px!important;
}

.markdown-body .pl-5 {
  padding-left: 32px!important;
}

.markdown-body .pl-6 {
  padding-left: 40px!important;
}

.markdown-body .f6 {
  font-size: 12px!important;
}

.markdown-body .lh-condensed {
  line-height: 1.25!important;
}

.markdown-body .text-bold {
  font-weight: 600!important;
}

.markdown-body .pl-c {
  color: #6a737d;
}

.markdown-body .pl-c1,
.markdown-body .pl-s .pl-v {
  color: #005cc5;
}

.markdown-body .pl-e,
.markdown-body .pl-en {
  color: #6f42c1;
}

.markdown-body .pl-s .pl-s1,
.markdown-body .pl-smi {
  color: #24292e;
}

.markdown-body .pl-ent {
  color: #22863a;
}

.markdown-body .pl-k {
  color: #d73a49;
}

.markdown-body .pl-pds,
.markdown-body .pl-s,
.markdown-body .pl-s .pl-pse .pl-s1,
.markdown-body .pl-sr,
.markdown-body .pl-sr .pl-cce,
.markdown-body .pl-sr .pl-sra,
.markdown-body .pl-sr .pl-sre {
  color: #032f62;
}

.markdown-body .pl-smw,
.markdown-body .pl-v {
  color: #e36209;
}

.markdown-body .pl-bu {
  color: #b31d28;
}

.markdown-body .pl-ii {
  color: #fafbfc;
  background-color: #b31d28;
}

.markdown-body .pl-c2 {
  color: #fafbfc;
  background-color: #d73a49;
}

.markdown-body .pl-c2:before {
  content: "^M";
}

.markdown-body .pl-sr .pl-cce {
  font-weight: 700;
  color: #22863a;
}

.markdown-body .pl-ml {
  color: #735c0f;
}

.markdown-body .pl-mh,
.markdown-body .pl-mh .pl-en,
.markdown-body .pl-ms {
  font-weight: 700;
  color: #005cc5;
}

.markdown-body .pl-mi {
  font-style: italic;
  color: #24292e;
}

.markdown-body .pl-mb {
  font-weight: 700;
  color: #24292e;
}

.markdown-body .pl-md {
  color: #b31d28;
  background-color: #ffeef0;
}

.markdown-body .pl-mi1 {
  color: #22863a;
  background-color: #f0fff4;
}

.markdown-body .pl-mc {
  color: #e36209;
  background-color: #ffebda;
}

.markdown-body .pl-mi2 {
  color: #f6f8fa;
  background-color: #005cc5;
}

.markdown-body .pl-mdr {
  font-weight: 700;
  color: #6f42c1;
}

.markdown-body .pl-ba {
  color: #586069;
}

.markdown-body .pl-sg {
  color: #959da5;
}

.markdown-body .pl-corl {
  text-decoration: underline;
  color: #032f62;
}

.markdown-body .mb-0 {
  margin-bottom: 0!important;
}

.markdown-body .my-2 {
  margin-bottom: 8px!important;
}

.markdown-body .my-2 {
  margin-top: 8px!important;
}

.markdown-body .pl-0 {
  padding-left: 0!important;
}

.markdown-body .py-0 {
  padding-top: 0!important;
  padding-bottom: 0!important;
}

.markdown-body .pl-1 {
  padding-left: 4px!important;
}

.markdown-body .pl-2 {
  padding-left: 8px!important;
}

.markdown-body .py-2 {
  padding-top: 8px!important;
  padding-bottom: 8px!important;
}

.markdown-body .pl-3 {
  padding-left: 16px!important;
}

.markdown-body .pl-4 {
  padding-left: 24px!important;
}

.markdown-body .pl-5 {
  padding-left: 32px!important;
}

.markdown-body .pl-6 {
  padding-left: 40px!important;
}

.markdown-body .pl-7 {
  padding-left: 48px!important;
}

.markdown-body .pl-8 {
  padding-left: 64px!important;
}

.markdown-body .pl-9 {
  padding-left: 80px!important;
}

.markdown-body .pl-10 {
  padding-left: 96px!important;
}

.markdown-body .pl-11 {
  padding-left: 112px!important;
}

.markdown-body .pl-12 {
  padding-left: 128px!important;
}

.markdown-body hr {
  border-bottom-color: #eee;
}

.markdown-body kbd {
  display: inline-block;
  padding: 3px 5px;
  font: 11px SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
  line-height: 10px;
  color: #444d56;
  vertical-align: middle;
  background-color: #fafbfc;
  border: 1px solid #d1d5da;
  border-radius: 3px;
  box-shadow: inset 0 -1px 0 #d1d5da;
}

.markdown-body:after,
.markdown-body:before {
  display: table;
  content: "";
}

.markdown-body:after {
  clear: both;
}

.markdown-body>:first-child {
  margin-top: 0!important;
}

.markdown-body>:last-child {
  margin-bottom: 0!important;
}

.markdown-body a:not([href]) {
  color: inherit;
  text-decoration: none;
}

.markdown-body blockquote,
.markdown-body details,
.markdown-body dl,
.markdown-body ol,
.markdown-body p,
.markdown-body pre,
.markdown-body table,
.markdown-body ul {
  width:100%;

  margin-top: 0;
  margin-bottom: 16px;
}

.markdown-body hr {
  height: .25em;
  padding: 0;
  margin: 24px 0;
  background-color: #e1e4e8;
  border: 0;
}

.markdown-body blockquote {
  padding: 0 1em;
  color: #6a737d;
  border-left: .25em solid #dfe2e5;
}

.markdown-body blockquote>:first-child {
  margin-top: 0;
}

.markdown-body blockquote>:last-child {
  margin-bottom: 0;
}

.markdown-body h1,
.markdown-body h2,
.markdown-body h3,
.markdown-body h4,
.markdown-body h5,
.markdown-body h6 {
  margin-top: 24px;
  margin-bottom: 16px;
  font-weight: 600;
  line-height: 1.25;
}

.markdown-body h1 {
  font-size: 2em;
}

.markdown-body h1,
.markdown-body h2 {
  padding-bottom: .3em;
  border-bottom: 1px solid #eaecef;
}

.markdown-body h2 {
  font-size: 1.5em;
}

.markdown-body h3 {
  font-size: 1.25em;
}

.markdown-body h4 {
  font-size: 1em;
}

.markdown-body h5 {
  font-size: .875em;
}

.markdown-body h6 {
  font-size: .85em;
  color: #6a737d;
}

.markdown-body ol,
.markdown-body ul {
  padding-left: 2em;
}

.markdown-body ol ol,
.markdown-body ol ul,
.markdown-body ul ol,
.markdown-body ul ul {
  margin-top: 0;
  margin-bottom: 0;
}

.markdown-body li {
  word-wrap: break-all;
}

.markdown-body li>p {
  margin-top: 16px;
}

.markdown-body li+li {
  margin-top: .25em;
}

.markdown-body dl {
  padding: 0;
}

.markdown-body dl dt {
  padding: 0;
  margin-top: 16px;
  font-size: 1em;
  font-style: italic;
  font-weight: 600;
}

.markdown-body dl dd {
  padding: 0 16px;
  margin-bottom: 16px;
}

.markdown-body table {
  width: 100%;
}

.markdown-body table th {
  font-weight: 600;
}

.markdown-body table td,
.markdown-body table th {
  padding: 6px 13px;
  border: 1px solid #dfe2e5;
}

.markdown-body table tr {
  background-color: #fff;
  border-top: 1px solid #c6cbd1;
}

.markdown-body table tr:nth-child(2n) {
  background-color: #f6f8fa;
}

.markdown-body img {
  max-width: 100%;
  box-sizing: initial;
  background-color: #fff;
}

.markdown-body img[align=right] {
  padding-left: 20px;
}

.markdown-body img[align=left] {
  padding-right: 20px;
}

.markdown-body code {
  padding: .2em .4em;
  margin: 0;
  font-size: 85%;
  background-color: rgba(27,31,35,.05);
  border-radius: 3px;
}

.markdown-body pre {
  word-wrap: normal;
}

.markdown-body pre>code {
  padding: 0;
  margin: 0;
  font-size: 100%;
  word-break: normal;
  white-space: pre;
  background: transparent;
  border: 0;
}

.markdown-body .highlight {
  margin-bottom: 16px;
}

.markdown-body .highlight pre {
  margin-bottom: 0;
  word-break: normal;
}

.markdown-body .highlight pre,
.markdown-body pre {
  padding: 16px;
  overflow: auto;
  font-size: 85%;
  line-height: 1.45;
  background-color: #f6f8fa;
  border-radius: 3px;
}

.markdown-body pre code {
  display: inline;
  max-width: auto;
  padding: 0;
  margin: 0;
  overflow: visible;
  line-height: inherit;
  word-wrap: normal;
  background-color: initial;
  border: 0;
}

.markdown-body .commit-tease-sha {
  display: inline-block;
  font-family: SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
  font-size: 90%;
  color: #444d56;
}

.markdown-body .full-commit .btn-outline:not(:disabled):hover {
  color: #005cc5;
  border-color: #005cc5;
}

.markdown-body .blob-wrapper {
  overflow-x: auto;
  overflow-y: hidden;
}

.markdown-body .blob-wrapper-embedded {
  max-height: 240px;
  overflow-y: auto;
}

.markdown-body .blob-num {
  width: 1%;
  min-width: 50px;
  padding-right: 10px;
  padding-left: 10px;
  font-family: SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
  font-size: 12px;
  line-height: 20px;
  color: rgba(27,31,35,.3);
  text-align: right;
  white-space: nowrap;
  vertical-align: top;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

.markdown-body .blob-num:hover {
  color: rgba(27,31,35,.6);
}

.markdown-body .blob-num:before {
  content: attr(data-line-number);
}

.markdown-body .blob-code {
  position: relative;
  padding-right: 10px;
  padding-left: 10px;
  line-height: 20px;
  vertical-align: top;
}

.markdown-body .blob-code-inner {
  overflow: visible;
  font-family: SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
  font-size: 12px;
  color: #24292e;
  word-wrap: normal;
  white-space: pre;
}

.markdown-body .pl-token.active,
.markdown-body .pl-token:hover {
  cursor: pointer;
  background: #ffea7f;
}

.markdown-body .tab-size[data-tab-size="1"] {
  -moz-tab-size: 1;
  tab-size: 1;
}

.markdown-body .tab-size[data-tab-size="2"] {
  -moz-tab-size: 2;
  tab-size: 2;
}

.markdown-body .tab-size[data-tab-size="3"] {
  -moz-tab-size: 3;
  tab-size: 3;
}

.markdown-body .tab-size[data-tab-size="4"] {
  -moz-tab-size: 4;
  tab-size: 4;
}

.markdown-body .tab-size[data-tab-size="5"] {
  -moz-tab-size: 5;
  tab-size: 5;
}

.markdown-body .tab-size[data-tab-size="6"] {
  -moz-tab-size: 6;
  tab-size: 6;
}

.markdown-body .tab-size[data-tab-size="7"] {
  -moz-tab-size: 7;
  tab-size: 7;
}

.markdown-body .tab-size[data-tab-size="8"] {
  -moz-tab-size: 8;
  tab-size: 8;
}

.markdown-body .tab-size[data-tab-size="9"] {
  -moz-tab-size: 9;
  tab-size: 9;
}

.markdown-body .tab-size[data-tab-size="10"] {
  -moz-tab-size: 10;
  tab-size: 10;
}

.markdown-body .tab-size[data-tab-size="11"] {
  -moz-tab-size: 11;
  tab-size: 11;
}

.markdown-body .tab-size[data-tab-size="12"] {
  -moz-tab-size: 12;
  tab-size: 12;
}

.markdown-body .task-list-item {
  list-style-type: none;
}

.markdown-body .task-list-item+.task-list-item {
  margin-top: 3px;
}

.markdown-body .task-list-item input {
  margin: 0 .2em .25em -1.6em;
  vertical-align: middle;
}
.markdown-body .description {
  margin: 0 .2em .25em -1.6em;
  vertical-align: middle;
}

</style>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimal-ui">
    <title>TerosHDL</title>
  <style>
    body {
      box-sizing: border-box;
      min-width: 200px;
      max-width: 1080px;
      margin: 0 auto;
      padding: 45px;
    }
  </style>
  </head>
  <body>
  <article class="markdown-body">

<div id="teroshdl" class='templateTerosHDL'>
<a id=Clock enable><h1 id="clock-enable">Clock enable</h1></a><ul>
<li><strong>File</strong>: period_cnt.vhd</li>
</ul><ul>
<li><strong>Copyright:</strong> (c) 2023 Roman Vanek<br />
This work is licensed under the terms of the MIT license</li>
<li><strong>Author:</strong> Roman Vanek</li>
</ul><h2 id="diagram">Diagram</h2><p><svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" viewBox="0 0 695 110"><svg id="SvgjsSvg1002" width="2" height="0" focusable="false" style="overflow:hidden;top:-100%;left:-100%;position:absolute;opacity:0"><polyline id="SvgjsPolyline1003" points="135,0 150,0"></polyline><path id="SvgjsPath1004" d="M0 0 "></path></svg><rect id="SvgjsRect1006" width="220" height="30" fill="black" x="150" y="0"></rect><rect id="SvgjsRect1007" width="216" height="25" fill="#bdecb6" x="152" y="2"></rect><text id="SvgjsText1008" font-family="Helvetica" x="130" y="-5.698437500000001" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1009" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   natural </tspan></text><text id="SvgjsText1010" font-family="Helvetica" x="165" y="-5.698437500000001" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1011" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   g_dot_length </tspan></text><line id="SvgjsLine1012" x1="135" y1="15" x2="150" y2="15" stroke-linecap="rec" stroke="black" stroke-width="5"></line><rect id="SvgjsRect1013" width="220" height="70" fill="black" x="150" y="35"></rect><rect id="SvgjsRect1014" width="216" height="65" fill="#fdfd96" x="152" y="37"></rect><text id="SvgjsText1015" font-family="Helvetica" x="130" y="29.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1016" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1017" font-family="Helvetica" x="165" y="29.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1018" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   clk </tspan></text><line id="SvgjsLine1019" x1="135" y1="50" x2="150" y2="50" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1020" font-family="Helvetica" x="130" y="49.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1021" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1022" font-family="Helvetica" x="165" y="49.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1023" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   i_space </tspan></text><line id="SvgjsLine1024" x1="135" y1="70" x2="150" y2="70" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1025" font-family="Helvetica" x="130" y="69.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1026" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1027" font-family="Helvetica" x="165" y="69.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1028" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   i_logic </tspan></text><line id="SvgjsLine1029" x1="135" y1="90" x2="150" y2="90" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1030" font-family="Helvetica" x="390" y="29.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1031" dy="26" x="390" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(3 downto 0) </tspan></text><text id="SvgjsText1032" font-family="Helvetica" x="355" y="29.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1033" dy="26" x="355" svgjs:data="{&quot;newLined&quot;:true}">   o_morse </tspan></text><line id="SvgjsLine1034" x1="370" y1="50" x2="385" y2="50" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1035" font-family="Helvetica" x="390" y="49.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1036" dy="26" x="390" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(2 downto 0) </tspan></text><text id="SvgjsText1037" font-family="Helvetica" x="355" y="49.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1038" dy="26" x="355" svgjs:data="{&quot;newLined&quot;:true}">   o_cnt </tspan></text><line id="SvgjsLine1039" x1="370" y1="70" x2="385" y2="70" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1040" font-family="Helvetica" x="390" y="69.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1041" dy="26" x="390" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1042" font-family="Helvetica" x="355" y="69.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1043" dy="26" x="355" svgjs:data="{&quot;newLined&quot;:true}">   o_read </tspan></text><line id="SvgjsLine1044" x1="370" y1="90" x2="385" y2="90" stroke-linecap="rec" stroke="black" stroke-width="5"></line></svg></p><h2 id="description">Description</h2><div id="teroshdl_description"><p>Counting period of input signal i_logic then assigns it either '0' or '1'  if it is shorter then g_dot_length respectively longer then g_dot_length.  Output will be provided when i_space changes to '1' as n-bit value of o_morse.  n (number of bits to read) is stored in o_cnt  !! Read output values only when o_read is '1' !!</p></div><h2 id="generics">Generics</h2>
<table>
<thead>
<tr>
<th id="generic_name">Generic name</th>
<th id="type">Type</th>
<th id="value">Value</th>
<th id="description">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>g_dot_length</td>
<td>natural</td>
<td>5</td>
<td>Number of clk pulses to generate one enable signal period</td>
</tr>
</tbody>
</table>
<h2 id="ports">Ports</h2>
<table>
<thead>
<tr>
<th id="port_name">Port name</th>
<th id="direction">Direction</th>
<th id="type">Type</th>
<th id="description">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>clk</td>
<td>in</td>
<td>std_logic</td>
<td></td>
</tr>
<tr>
<td>i_space</td>
<td>in</td>
<td>std_logic</td>
<td></td>
</tr>
<tr>
<td>i_logic</td>
<td>in</td>
<td>std_logic</td>
<td></td>
</tr>
<tr>
<td>o_morse</td>
<td>out</td>
<td>std_logic_vector(3 downto 0)</td>
<td></td>
</tr>
<tr>
<td>o_cnt</td>
<td>out</td>
<td>std_logic_vector(2 downto 0)</td>
<td></td>
</tr>
<tr>
<td>o_read</td>
<td>out</td>
<td>std_logic</td>
<td></td>
</tr>
</tbody>
</table><h2 id="signals">Signals</h2>
<table>
<thead>
<tr>
<th id="name">Name</th>
<th id="type">Type</th>
<th id="description">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>sig_counter</td>
<td>unsigned(31 downto 0)</td>
<td>Local counter</td>
</tr>
<tr>
<td>sig_morse</td>
<td>unsigned(3 downto 0)</td>
<td>Local counter</td>
</tr>
<tr>
<td>sig_cnt</td>
<td>natural</td>
<td>Local counter</td>
</tr>
<tr>
<td>sig_read</td>
<td>std_logic</td>
<td></td>
</tr>
</tbody>
</table><h2 id="processes">Processes</h2><ul>
<li>p_clk_enable: ( clk )</li>
</ul><br><br><br><br><br><br>
</article class="markdown-body">

</body>
    
    


## Popis softwaru
### Simulace

## Instrukce k používání

## Reference


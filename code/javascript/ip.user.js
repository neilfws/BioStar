// ==UserScript==
// @name          BioStar IP
// @namespace     http://twitter.com/neilfws
// @description   Get IP address from BioStar user page if logged in as moderator
// @include       http://biostar.stackexchange.com/users/*
// @exclude       
// ==/UserScript==

d = document.evaluate("//div[@class='summaryinfo']",document,null,XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE,null);
console.log(d.snapshotItem(0).innerText);

From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 10:49:28 +0000
In-Reply-To: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
References: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <87e7cebc24e9dfe525396ac9bb7e58d0bdb9f873-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IBS6s9/wuT0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tun: Refactor BSD
 write_tun/read_tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IBS6s9/wuT0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1378?usp=3Demail )

Change subject: tun: Refactor BSD write_tun/read_tun
......................................................................


Patch Set 5: Code-Review-1

Copied votes on follow-up patch sets have been updated:
* Code-Review-1 has been copied to patch set 6 (copy condition: "changekind=
:NO_CHANGE OR changekind:TRIVIAL_REBASE OR is:MIN").

(3 comments)

Patchset:

PS5:
I think this is a good change and BB confirms that it works (or worked, a f=
ew weeks ago).  I think the comments could be improved a bit more...


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/1378/comment/9197213b_fa155467?usp=3D=
email :
PS5, Line 1705:  * go away for TAP devices.
I think this should be reworded ("we *have* tested") to be something like

```
 * For TAP devices, no extra header is needed, so we need to check for DEV_=
TYPE_TUN
```

or so?  Or maybe even shorter "For TAP devices, this is not needed and must=
 not be done" or so (so it's clear "even if we wanted to keep the code the =
same, we can't").


http://gerrit.openvpn.net/c/openvpn/+/1378/comment/0f65128b_1360ae44?usp=3D=
email :
PS5, Line 1785: #if !defined(TARGET_DARWIN)
I think this also warrants a comment

```
/* MacOS is slightly different again (extra variant for UTUN) so this platf=
orm
 * has its own read_tun()/write_tun() with the necessary conditionals below
 */
```

(it took me a while to remember and find the specifics, someone else will b=
e even more confused)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c
Gerrit-Change-Number: 1378
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 09 Dec 2025 10:49:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--IBS6s9/wuT0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1378?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think th=
is is a good change and BB confirms that it works (or worked, a few weeks a=
go).  I think the comments could be improved a bit more...</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1378/comment/9197213b_fa155467?usp=3Demail">Patch Set #5, L=
ine 1705:</a> <code style=3D"font-family:monospace,monospace"> * go away fo=
r TAP devices.</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I think this should be reworded (&quot;we *have* =
tested&quot;) to be something like</p><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">```<br> * For TAP devic=
es, no extra header is needed, so we need to check for DEV_TYPE_TUN<br>```<=
/pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">or so?  Or maybe even shorter &quot;For TAP devices, this is not need=
ed and must not be done&quot; or so (so it&#39;s clear &quot;even if we wan=
ted to keep the code the same, we can&#39;t&quot;).</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1378/comment/0f65128b_1360ae44?usp=3D=
email">Patch Set #5, Line 1785:</a> <code style=3D"font-family:monospace,mo=
nospace">#if !defined(TARGET_DARWIN)</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">I think this also warrants =
a comment</p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">```<br>/* MacOS is slightly different again (ext=
ra variant for UTUN) so this platform<br> * has its own read_tun()/write_tu=
n() with the necessary conditionals below<br> */<br>```</pre><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">(it took me a=
 while to remember and find the specifics, someone else will be even more c=
onfused)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1378?usp=3Demail">change 1378</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1378?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd9384287648d1f37a625d9ed6a=
09733208fa56c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1378 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Dec 2025 10:49:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--IBS6s9/wuT0=--


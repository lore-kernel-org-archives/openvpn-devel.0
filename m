From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jan 2024 22:45:10 +0000
In-Reply-To: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6d1b9c0efaac3dc6cd3bbffa812b8ede9f26b2db-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XwQxwCeEpF8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check PRF
 availability on initialisation and add --force-tls-key-mate...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XwQxwCeEpF8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/460?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: Check PRF availability on initialisation and add --force-tl=
s-key-material-export
......................................................................


Patch Set 8: Code-Review-2

(2 comments)

Patchset:

PS8:
sorry... found another one :-(


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/460/comment/131b2f38_d4640bad :
PS8, Line 1809:     return (ret && memcmp(out, expected_out, sizeof(out)) !=
=3D 0);
It pains me to return to "-2" again, but there is something really weird go=
ing on here - to see what happens if the PRF fails, I changed "expected_out=
[3] to "2" in my tree, and it still succeeds.  Wat.  So I look at the compa=
rison, and we should be checking for `=3D=3D 0` here ("out =3D=3D expected_=
out", this is not strcmp()...).

So I fired up gdb with -O0, and this is what it says...

```
(gdb) print ret
$1 =3D 1
(gdb) print out
$2 =3D "qD\376%@su\225"
(gdb) print expected_out
$3 =3D "\340_\037\001\000\000\000"
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee6ca89c7e86c70
Gerrit-Change-Number: 460
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 03 Jan 2024 22:45:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--XwQxwCeEpF8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p>The change is no longer submittable: Code-Review is unsatisfied now.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/460?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">sorry... found another one :-(</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/460/comment/131b2f38_d4640bad">Patch Set #8, Line 1809=
:</a> <code style=3D"font-family:monospace,monospace">    return (ret &amp;=
&amp; memcmp(out, expected_out, sizeof(out)) !=3D 0);</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">It pains me to return to &q=
uot;-2&quot; again, but there is something really weird going on here - to =
see what happens if the PRF fails, I changed &quot;expected_out[3] to &quot=
;2&quot; in my tree, and it still succeeds.  Wat.  So I look at the compari=
son, and we should be checking for `=3D=3D 0` here (&quot;out =3D=3D expect=
ed_out&quot;, this is not strcmp()...).</p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">So I fired up gdb with -O0, and this is what it =
says...</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<b=
r>(gdb) print ret<br>$1 =3D 1<br>(gdb) print out<br>$2 =3D &quot;qD\376%@su=
\225&quot;<br>(gdb) print expected_out<br>$3 =3D &quot;\340_\037\001\000\00=
0\000&quot;<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">change 460</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/460?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee=
6ca89c7e86c70 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 460 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 03 Jan 2024 22:45:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--XwQxwCeEpF8=--


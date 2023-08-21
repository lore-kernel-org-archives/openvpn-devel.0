From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 21 Aug 2023 09:26:40 +0000
In-Reply-To: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
References: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fae0cc753da60d1da7048b7a761053d930d20b78-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Opyfxis9JDs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove ability to
 use configurations without TLS by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Opyfxis9JDs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/325?usp=3Demail )

Change subject: Remove ability to use configurations without TLS by default
......................................................................


Patch Set 2: Code-Review-1

(7 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/379190bd_a9c3fa7a :
PS2, Line 12: line or the configuration itself. This will server as a last =
and final
"serve"


Patchset:

PS2:
Some documentation fixes required. But overall looks okay.


File doc/man-sections/protocol-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/f506bc1e_c4d07ee5 :
PS2, Line 237: --secret args
I think we should at least add a basic documentation for the "allow-depreca=
ted-insecure-static-crypto" to the man page. I think there should be some d=
ocumentation where people can look up what it means when they encounter it.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/2666ce9a_7234c17d :
PS2, Line 618: ,\
Change trailing comma to full stop.


http://gerrit.openvpn.net/c/openvpn/+/325/comment/5089d435_2a81c525 :
PS2, Line 756: secret
Should be we change the "secret" here?


http://gerrit.openvpn.net/c/openvpn/+/325/comment/310f2f25_827ef514 :
PS2, Line 2843:             "OpenVPN 2.7 allow using this configuration whe=
n using "
"allows"


http://gerrit.openvpn.net/c/openvpn/+/325/comment/3b4c5d7f_d4849c88 :
PS2, Line 2845: configuration
"proper configuration" =3D> "TLS mode"?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5
Gerrit-Change-Number: 325
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 21 Aug 2023 09:26:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Opyfxis9JDs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/325/comment/379190bd_a9c3fa7a">Patch Set #2, Line 12:</a> <code s=
tyle=3D"font-family:monospace,monospace">line or the configuration itself. =
This will server as a last and final</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">&quot;serve&quot;</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?tab=
=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Some documentation fixes required. But overall looks oka=
y.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-s=
ections/protocol-options.rst:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/f506bc1e=
_c4d07ee5">Patch Set #2, Line 237:</a> <code style=3D"font-family:monospace=
,monospace">--secret args</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">I think we should at least add a basic documentation fo=
r the &quot;allow-deprecated-insecure-static-crypto&quot; to the man page. =
I think there should be some documentation where people can look up what it=
 means when they encounter it.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comm=
ent/2666ce9a_7234c17d">Patch Set #2, Line 618:</a> <code style=3D"font-fami=
ly:monospace,monospace">,\</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Change trailing comma to full stop.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/5089d435_2a81c525">=
Patch Set #2, Line 756:</a> <code style=3D"font-family:monospace,monospace"=
>secret</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Should be we change the &quot;secret&quot; here?</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/325/comment/310f2f25_827ef514">Patch S=
et #2, Line 2843:</a> <code style=3D"font-family:monospace,monospace">     =
       &quot;OpenVPN 2.7 allow using this configuration when using &quot;</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;a=
llows&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
25/comment/3b4c5d7f_d4849c88">Patch Set #2, Line 2845:</a> <code style=3D"f=
ont-family:monospace,monospace">configuration</code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">&quot;proper configuration&quot; =
=3D&gt; &quot;TLS mode&quot;?</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">change 325</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/325?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da4=
4073ad96d0ff5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Aug 2023 09:26:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Opyfxis9JDs=--


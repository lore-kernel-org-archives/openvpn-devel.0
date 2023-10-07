From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 7 Oct 2023 13:10:11 +0000
In-Reply-To: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
References: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <57888bd2610ef1975441f43a7c25635a30cd2e0f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Muq1GZfYRQ0="; charset=UTF-8
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

--Muq1GZfYRQ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/325?usp=3Demail )

Change subject: Remove ability to use configurations without TLS by default
......................................................................


Patch Set 3: Code-Review+1

(7 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/240de6f3_09e6b00f :
PS2, Line 12: line or the configuration itself. This will server as a last =
and final
> "serve"
Done


Patchset:

PS3:
All my comments were addressed. Need to do another round of review.


File doc/man-sections/protocol-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/59638422_e998b483 :
PS2, Line 237: --secret args
> I think we should at least add a basic documentation for the "allow-depre=
cated-insecure-static-crypt [=E2=80=A6]
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/f7e4e3df_016c1f63 :
PS2, Line 618: ,\
> Change trailing comma to full stop.
Done


http://gerrit.openvpn.net/c/openvpn/+/325/comment/93f51a69_84b70446 :
PS2, Line 756: secret
> Should be we change the "secret" here?
Done


http://gerrit.openvpn.net/c/openvpn/+/325/comment/9e7b128f_da4157a2 :
PS2, Line 2843:             "OpenVPN 2.7 allow using this configuration whe=
n using "
> "allows"
Done


http://gerrit.openvpn.net/c/openvpn/+/325/comment/4a4aa10d_f2e05c22 :
PS2, Line 2845: configuration
> "proper configuration" =3D> "TLS mode"?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5
Gerrit-Change-Number: 325
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Sat, 07 Oct 2023 13:10:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--Muq1GZfYRQ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/325/comment/240de6f3_09e6b00f">Patch Set #2, Line 12:</a> <code s=
tyle=3D"font-family:monospace,monospace">line or the configuration itself. =
This will server as a last and final</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;serve&quot=
;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/325?tab=3Dcomments">Patch Set #3:</a> </p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">All my comments were add=
ressed. Need to do another round of review.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File doc/man-sections/protocol-options.rst:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/325/comment/59638422_e998b483">Patch Set #2, Line 237:=
</a> <code style=3D"font-family:monospace,monospace">--secret args</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">I think we should at least add a basic documentation for the =
&quot;allow-deprecated-insecure-static-crypt [=E2=80=A6]</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/325/comment/f7e4e3df_016c1f63">Patch Set #2, Line 61=
8:</a> <code style=3D"font-family:monospace,monospace">,\</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Change trailing comma to full stop.</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/325/comment/93f51a69_84b70446">Patch Set #2=
, Line 756:</a> <code style=3D"font-family:monospace,monospace">secret</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Should be we change the &quot;secret&quot; here?</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/9e7b1=
28f_da4157a2">Patch Set #2, Line 2843:</a> <code style=3D"font-family:monos=
pace,monospace">            &quot;OpenVPN 2.7 allow using this configuratio=
n when using &quot;</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">&quot;allows&quot;</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/4a4aa10d_f2=
e05c22">Patch Set #2, Line 2845:</a> <code style=3D"font-family:monospace,m=
onospace">configuration</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;proper configuration&qu=
ot; =3D&gt; &quot;TLS mode&quot;?</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">chan=
ge 325</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da4=
4073ad96d0ff5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 07 Oct 2023 13:10:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Muq1GZfYRQ0=--


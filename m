From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 23 Apr 2025 11:06:25 +0000
In-Reply-To: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
References: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f488de7c6ec5bf87cf1439b6dfa9797699c5aeb8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gk4qbRBWv9s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make dh none
 behaviour default if not specific and add dh auto
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

--Gk4qbRBWv9s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/945?usp=3Demail )

Change subject: Make dh none behaviour default if not specific and add dh a=
uto
......................................................................


Patch Set 1: Code-Review-1

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/945/comment/e1153c4e_50db37a0 :
PS1, Line 7: Make dh none behaviour default if not specific and add dh auto
Do you mean "specified" instead of "specific"?


File doc/man-sections/tls-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/945/comment/b9aff705_92f37f5f :
PS1, Line 183:   Set ``file`` to :code:`auto` enables using builtin Diffie =
Hellman
"Setting"


http://gerrit.openvpn.net/c/openvpn/+/945/comment/7b830145_762c2aad :
PS1, Line 188:   use the public well-known parameter or using ``none``.
"parameters"


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/945/comment/c4fa3ce2_91eeefc1 :
PS1, Line 3716:             o->dh_file =3D "auto";
It is already "auto", so this seems redundant.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
Gerrit-Change-Number: 945
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 23 Apr 2025 11:06:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Gk4qbRBWv9s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/945/comment/e1153c4e_50db37a0">Patch Set #1, Line 7:</a> <code st=
yle=3D"font-family:monospace,monospace">Make dh none behaviour default if n=
ot specific and add dh auto</code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Do you mean &quot;specified&quot; instead of &quot;sp=
ecific&quot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e doc/man-sections/tls-options.rst:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/945/comment/b9=
aff705_92f37f5f">Patch Set #1, Line 183:</a> <code style=3D"font-family:mon=
ospace,monospace">  Set ``file`` to :code:`auto` enables using builtin Diff=
ie Hellman</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">&quot;Setting&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/945/comment/7b830145_762c2aad">Patch Set #1, Line 188:</a> <code=
 style=3D"font-family:monospace,monospace">  use the public well-known para=
meter or using ``none``.</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">&quot;parameters&quot;</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/945/comment/c4fa3ce2_91eeefc1">Patch Set #1, Line 3716:</a> <code style=
=3D"font-family:monospace,monospace">            o-&gt;dh_file =3D &quot;au=
to&quot;;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">It is already &quot;auto&quot;, so this seems redundant.</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/945?usp=3Demail">change 945</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940f=
da9d900465289 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Apr 2025 11:06:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Gk4qbRBWv9s=--


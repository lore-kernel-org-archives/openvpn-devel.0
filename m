From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sat, 8 Nov 2025 00:07:29 +0000
In-Reply-To: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5b5bfb2ba0cd4c3f152de48c7b355113fdc97d1e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FYwpj5BpTDM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
 validate openvpn-gui process path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FYwpj5BpTDM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

d12fk has posted comments on this change by stipa. ( http://gerrit.openvpn.=
net/c/openvpn/+/1333?usp=3Demail )

Change subject: openvpnserv: validate openvpn-gui process path
......................................................................


Patch Set 2:

(3 comments)

File src/openvpnserv/validate.c:

http://gerrit.openvpn.net/c/openvpn/+/1333/comment/8a56b40a_84d5cd59?usp=3D=
email :
PS2, Line 350:     if (!GetNamedPipeClientProcessId(pipe, &clientPID))
I remember we looked at this back when the reports from Microsoft came in. =
Not sure if I recall correctly, but wasn't it this API which always reporte=
d the same PID no matter which process connected to the pipe second?


http://gerrit.openvpn.net/c/openvpn/+/1333/comment/6c18fe77_e5aadcaa?usp=3D=
email :
PS2, Line 371:         HRESULT hr =3D PathCchCanonicalizeEx(bin_dir, _count=
of(bin_dir), s->bin_dir,
dirs will always have a trailing slash with #1336


http://gerrit.openvpn.net/c/openvpn/+/1333/comment/a4c3a93c_555a1a40?usp=3D=
email :
PS2, Line 373:         if ((hr =3D=3D S_OK) && wcsncmp(bin_dir, path, wcsle=
n(bin_dir)) =3D=3D 0)
Compare case-insesitive here, to get no false positives



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie990f4dd10094810d6632f8dedfa261727ebfbcb
Gerrit-Change-Number: 1333
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sat, 08 Nov 2025 00:07:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--FYwpj5BpTDM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/validate.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1333/comment/8a56b40a_84d5cd59?usp=3Demail">Patch S=
et #2, Line 350:</a> <code style=3D"font-family:monospace,monospace">    if=
 (!GetNamedPipeClientProcessId(pipe, &amp;clientPID))</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I remember=
 we looked at this back when the reports from Microsoft came in. Not sure i=
f I recall correctly, but wasn&#39;t it this API which always reported the =
same PID no matter which process connected to the pipe second?</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1333/comment/6c18fe77_e5aa=
dcaa?usp=3Demail">Patch Set #2, Line 371:</a> <code style=3D"font-family:mo=
nospace,monospace">        HRESULT hr =3D PathCchCanonicalizeEx(bin_dir, _c=
ountof(bin_dir), s-&gt;bin_dir,</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">dirs will always have a trailing=
 slash with #1336</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1333/comment/a4c3a93c_555a1a40?usp=3Demail">Patch Set #2, Line 373:</a>=
 <code style=3D"font-family:monospace,monospace">        if ((hr =3D=3D S_O=
K) &amp;&amp; wcsncmp(bin_dir, path, wcslen(bin_dir)) =3D=3D 0)</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Compare case-insesitive here, to get no false positives</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1333=
?usp=3Demail">change 1333</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1333?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie990f4dd10094810d6632f8dedf=
a261727ebfbcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1333 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 08 Nov 2025 00:07:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--FYwpj5BpTDM=--


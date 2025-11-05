From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 5 Nov 2025 00:11:50 +0000
In-Reply-To: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
References: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e0eb0b3c8d291e92649e6ae31668a9566fd41743-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JciPBDCvpvU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add option to check
 tls-crypt-v2 key timestamps
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JciPBDCvpvU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

MaxF has posted comments on this change by MaxF. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1304?usp=3Demail )

Change subject: Add option to check tls-crypt-v2 key timestamps
......................................................................


Patch Set 5:

(3 comments)

File doc/man-sections/tls-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1304/comment/ce9f65dd_da5e5dc5?usp=3D=
email :
PS4, Line 573:   no timestamp.
> should add in the description what happen if tls-crypt-v2 client keys are=
 used that don't use the ti [=E2=80=A6]
Not sure what you mean. It says that keys without timestamp are rejected.


File src/openvpn/tls_crypt.c:

http://gerrit.openvpn.net/c/openvpn/+/1304/comment/6cce571b_0e82e17f?usp=3D=
email :
PS4, Line 537:         msg(M_WARN, "ERROR: Client key doesn't have a timest=
amp.");
> I would go for the bit more formal form here and use "does not" instead o=
f the short form "doesn't"
Done


http://gerrit.openvpn.net/c/openvpn/+/1304/comment/eb1c0953_574a54a0?usp=3D=
email :
PS4, Line 541:     memcpy(&timestamp, metadata + 1, sizeof(int64_t));
> I think we should add a length check here to ensure that the metadata is =
long enough.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0579d18c784e2ac16973d5553992c28f281a0900
Gerrit-Change-Number: 1304
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 05 Nov 2025 00:11:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--JciPBDCvpvU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/tls-options.=
rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1304/comment/ce9f65dd_da5e5dc5?usp=3Demail">P=
atch Set #4, Line 573:</a> <code style=3D"font-family:monospace,monospace">=
  no timestamp.</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">should add in the description what ha=
ppen if tls-crypt-v2 client keys are used that don&#39;t use the ti [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Not sure what you mean. It says that keys without tim=
estamp are rejected.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/tls_crypt.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304/comment/6cc=
e571b_0e82e17f?usp=3Demail">Patch Set #4, Line 537:</a> <code style=3D"font=
-family:monospace,monospace">        msg(M_WARN, &quot;ERROR: Client key do=
esn&#39;t have a timestamp.&quot;);</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I would go for th=
e bit more formal form here and use &quot;does not&quot; instead of the sho=
rt form &quot;doesn&#39;t&quot;</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1304/comment/eb1c0953_574a54a0?=
usp=3Demail">Patch Set #4, Line 541:</a> <code style=3D"font-family:monospa=
ce,monospace">    memcpy(&amp;timestamp, metadata + 1, sizeof(int64_t));</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">I think we should add a length check here to ensure tha=
t the metadata is long enough.</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?us=
p=3Demail">change 1304</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0579d18c784e2ac16973d555399=
2c28f281a0900 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1304 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Nov 2025 00:11:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--JciPBDCvpvU=--


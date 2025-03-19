From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 19 Mar 2025 22:45:41 +0000
In-Reply-To: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
References: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3dcf58cc8d2674e6899cb1ca77171b96593fe9e6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RjUexaqktm8="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: win: implement
 --dns option support with NRPT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RjUexaqktm8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/837?usp=3Demail )

Change subject: win: implement --dns option support with NRPT
......................................................................


Patch Set 13:

(2 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/837/comment/b96c8df4_7beb686c :
PS13, Line 2602:     free(wide_domains);
> If domains is not set, we're freeing stack-allocated wide_domains (PWSTR =
wide_domains =3D L".\0";).
Done


http://gerrit.openvpn.net/c/openvpn/+/837/comment/8eed4464_e3ea759f :
PS13, Line 2782:     DWORD iid_err =3D InterfaceIdString(msg->iface.name, i=
id, sizeof(iid));
> We pass sizeof(iid) as count to wcsncpy and it should be count of wide ch=
ars, not the buffer size. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5adbebaaf209cc
Gerrit-Change-Number: 837
Gerrit-PatchSet: 13
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 19 Mar 2025 22:45:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--RjUexaqktm8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/837/comment/b96c8df4_7beb686c">Patch Set #13, Lin=
e 2602:</a> <code style=3D"font-family:monospace,monospace">    free(wide_d=
omains);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">If domains is not set, we&#39;re freeing sta=
ck-allocated wide_domains (PWSTR wide_domains =3D L&quot;.\0&quot;;).</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837/comment/8e=
ed4464_e3ea759f">Patch Set #13, Line 2782:</a> <code style=3D"font-family:m=
onospace,monospace">    DWORD iid_err =3D InterfaceIdString(msg-&gt;iface.n=
ame, iid, sizeof(iid));</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">We pass sizeof(iid) as count =
to wcsncpy and it should be count of wide chars, not the buffer size. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/837?usp=3Demail">change 837</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/837?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5=
adbebaaf209cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Mar 2025 22:45:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RjUexaqktm8=--


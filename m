From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 22 May 2025 13:35:11 +0000
In-Reply-To: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
References: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c33f22e8d87156c49c42c3fce1848a8ea7156687-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k4o9IXYPR2o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use
 mbedtls_ssl_export_keying_material()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--k4o9IXYPR2o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/1041?usp=3Demail )

Change subject: Use mbedtls_ssl_export_keying_material()
......................................................................


Patch Set 2:

(1 comment)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/1041/comment/48dc00df_b6879caa :
PS2, Line 305:     check_symbol_exists(mbedtls_ssl_export_keying_material m=
bedtls/ssl.h HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL)
> shouldn't we rather rely on the mbed TLS configuration define MBEDTLS_SSL=
_KEYING_MATERIAL_EXPORT to  [=E2=80=A6]
In configure.ac, we need to check if one of the key exporting callbacks exi=
sts, or if mbedtls_ssl_export_keying_material() exists, to determine if we =
should set HAVE_EXPORT_KEYING_MATERIAL. Is it possible to check that a defi=
ne exists in autoconf?

Alternatively, we could just refuse to compile if there's no way to export =
keying material, but I think I would rather do that in a different commit.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Gerrit-Change-Number: 1041
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 22 May 2025 13:35:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--k4o9IXYPR2o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1041/comment/48dc00df_b6879caa">Patch Set #2, Line 305:</a> <c=
ode style=3D"font-family:monospace,monospace">    check_symbol_exists(mbedt=
ls_ssl_export_keying_material mbedtls/ssl.h HAVE_MBEDTLS_SSL_EXPORT_KEYING_=
MATERIAL)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">shouldn&#39;t we rather rely on the mbed TL=
S configuration define MBEDTLS_SSL_KEYING_MATERIAL_EXPORT to  [=E2=80=A6]</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
n configure.ac, we need to check if one of the key exporting callbacks exis=
ts, or if mbedtls_ssl_export_keying_material() exists, to determine if we s=
hould set HAVE_EXPORT_KEYING_MATERIAL. Is it possible to check that a defin=
e exists in autoconf?</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Alternatively, we could just refuse to compile if there&#39;s no w=
ay to export keying material, but I think I would rather do that in a diffe=
rent commit.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1041?usp=3Demail">change 1041</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1041?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1c=
aae90e5065bc4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1041 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 22 May 2025 13:35:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--k4o9IXYPR2o=--


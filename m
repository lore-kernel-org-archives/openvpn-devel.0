From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 12:48:16 +0000
In-Reply-To: <gerrit.1752495948000.I152577b7d9b3b3a0d298971f47ba412d3f43d50d@...2715...>
References: <gerrit.1752495948000.I152577b7d9b3b3a0d298971f47ba412d3f43d50d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <93822ea0fddb9dcfbbba611bd1338c5b760935bf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xOeKWTrSqjg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not check for
 pkcs11-helper when pkcs11 is not enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xOeKWTrSqjg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1085?usp=3Demail )

Change subject: Do not check for pkcs11-helper when pkcs11 is not enabled
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
> We should dig deeper. [=E2=80=A6]
This is not limited to mbed TLS.

The test ldflags/cflags will also automatically add the PKCS11 LIBS/CFLAG f=
lags if they are present.

TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OP=
TIONAL_LIBCAPNG_LIBS}"
TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} $=
{OPTIONAL_LIBCAPNG_CFLAGS}"

It felt easier to just not do the pkg config check and define the variables=
 then do an if/fi around all the other uses.

For mbed + pkcs11, see this commit: https://github.com/openvpn/openvpn/comm=
it/9a3f670248d6f519a399e65a7232e2196b5115db



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I152577b7d9b3b3a0d298971f47ba412d3f43d50d
Gerrit-Change-Number: 1085
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 14 Jul 2025 12:48:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--xOeKWTrSqjg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1085?tab=3Dcomments">Patch Set #1:</a> </p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We should dig deeper=
. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">This is not limited to mbed TLS. </p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">The test ldflags/cflags will also automa=
tically add the PKCS11 LIBS/CFLAG flags if they are present.</p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">TEST_LDFLAGS=3D&quot;${OPTI=
ONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}&=
quot;<br>TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HE=
LPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">It felt easier to just not do the pkg con=
fig check and define the variables then do an if/fi around all the other us=
es.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">For mbed =
+ pkcs11, see this commit: https://github.com/openvpn/openvpn/commit/9a3f67=
0248d6f519a399e65a7232e2196b5115db</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail">change =
1085</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I152577b7d9b3b3a0d298971f47b=
a412d3f43d50d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1085 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 14 Jul 2025 12:48:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--xOeKWTrSqjg=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 30 Apr 2024 16:14:57 +0000
In-Reply-To: <gerrit.1714407751000.I5bfa3630ad4dff2807705658bc877c4a429a39ce@...2715...>
References: <gerrit.1714407751000.I5bfa3630ad4dff2807705658bc877c4a429a39ce@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2098b75100eaed18164318fe4a2f59bd315c7efd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vf81qIVc0Jo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove custom TLS
 1.0 PRF implementation only used by LibreSSL/wolfSSL
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

--vf81qIVc0Jo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/560?usp=3Demail )

Change subject: Remove custom TLS 1.0 PRF implementation only used by Libre=
SSL/wolfSSL
......................................................................


Patch Set 3: Code-Review-2

(1 comment)

File tests/unit_tests/openvpn/test_crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/560/comment/365ef4c9_dafb7fea :
PS3, Line 163:     bool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret=
_len, out, sizeof(out));
This change causes build failures:

```
test_crypto.c: In function =E2=80=98crypto_test_tls_prf=E2=80=99:
test_crypto.c:163:10: error: unused variable =E2=80=98ret=E2=80=99 [-Werror=
=3Dunused-variable]
  163 |     bool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, o=
ut, sizeof(out));
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/560?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5bfa3630ad4dff2807705658bc877c4a429a39ce
Gerrit-Change-Number: 560
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 30 Apr 2024 16:14:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--vf81qIVc0Jo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/560?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/te=
st_crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/560/comment/365ef4c9_dafb7fea">Patch =
Set #3, Line 163:</a> <code style=3D"font-family:monospace,monospace">    b=
ool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(ou=
t));</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
his change causes build failures:</p><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">```<br>test_crypto.c: In function =E2=80=
=98crypto_test_tls_prf=E2=80=99:<br>test_crypto.c:163:10: error: unused var=
iable =E2=80=98ret=E2=80=99 [-Werror=3Dunused-variable]<br>  163 |     bool=
 ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out))=
;<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/560?usp=3Demail">change 560</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/560?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5bfa3630ad4dff2807705658bc8=
77c4a429a39ce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 560 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 30 Apr 2024 16:14:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--vf81qIVc0Jo=--


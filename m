From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 1 May 2024 16:37:48 +0000
In-Reply-To: <gerrit.1714486272000.I5d70198f6adbee8add619ee8a0bd6b5b1f61e506@...2715...>
References: <gerrit.1714486272000.I5d70198f6adbee8add619ee8a0bd6b5b1f61e506@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4d834904776c5e6036ed291cc76ea660d131fd72-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="921517Yh66g="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add missing
 EVP_KDF_CTX_free in ssl_tls1_PRF
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--921517Yh66g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add missing EVP_KDF_CTX_free in ssl_tls1_PRF
......................................................................

Add missing EVP_KDF_CTX_free in ssl_tls1_PRF

This is just missing in the function. Found by clang+ASAN.

Change-Id: I5d70198f6adbee8add619ee8a0bd6b5b1f61e506
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240501121819.12805-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
591.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/581/2

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b2c4eb6..61c6518 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1372,6 +1372,7 @@
 err:
     ret =3D false;
 out:
+    EVP_KDF_CTX_free(kctx);
     EVP_KDF_free(kdf);

     return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5d70198f6adbee8add619ee8a0bd6b5b1f61e506
Gerrit-Change-Number: 581
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--921517Yh66g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
581?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add missing EVP_KDF_CTX_free in ssl_tls1_PRF<=
br><br>This is just missing in the function. Found by clang+ASAN.<br><br>Ch=
ange-Id: I5d70198f6adbee8add619ee8a0bd6b5b1f61e506<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Message-Id: &lt;20240501121819.12805-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
28591.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/crypto_openssl.c<br>1 file changed, 1 insertion(+), 0 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/81/581/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn=
/crypto_openssl.c</span><br><span>index b2c4eb6..61c6518 100644</span><br><=
span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/c=
rypto_openssl.c</span><br><span>@@ -1372,6 +1372,7 @@</span><br><span> err:=
</span><br><span>     ret =3D false;</span><br><span> out:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_CTX_free(kctx);</span><b=
r><span>     EVP_KDF_free(kdf);</span><br><span> </span><br><span>     retu=
rn ret;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail">change 581</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/581?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d70198f6adbee8add619ee8a0b=
d6b5b1f61e506 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 581 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--921517Yh66g=--


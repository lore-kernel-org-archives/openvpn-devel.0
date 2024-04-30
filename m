From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 30 Apr 2024 14:11:13 +0000
References: <gerrit.1714486272000.I5d70198f6adbee8add619ee8a0bd6b5b1f61e506@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5fd5f770af789f38b9b4a47a8b762789d0fa30fe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="me/Z9GU7oQk="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--me/Z9GU7oQk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail

to review the following change.


Change subject: Add missing EVP_KDF_CTX_free in ssl_tls1_PRF
......................................................................

Add missing EVP_KDF_CTX_free in ssl_tls1_PRF

This is just missing in the function. Found by clang+ASAN.

Change-Id: I5d70198f6adbee8add619ee8a0bd6b5b1f61e506
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/581/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--me/Z9GU7oQk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add missing EVP_KDF_CTX_free in ssl_tls1_PRF<br><br>This is j=
ust missing in the function. Found by clang+ASAN.<br><br>Change-Id: I5d7019=
8f6adbee8add619ee8a0bd6b5b1f61e506<br>Signed-off-by: Arne Schwabe &lt;arne@=
...1227...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>1 file changed, =
1 insertion(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/81/581/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto=
_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index b2c4eb6..61=
c6518 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><=
span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -1372,6 +1372,7 =
@@</span><br><span> err:</span><br><span>     ret =3D false;</span><br><spa=
n> out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_=
CTX_free(kctx);</span><br><span>     EVP_KDF_free(kdf);</span><br><span> </=
span><br><span>     return ret;</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail">c=
hange 581</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/581?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d70198f6adbee8add619ee8a0b=
d6b5b1f61e506 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 581 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--me/Z9GU7oQk=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Apr 2024 12:56:41 +0000
In-Reply-To: <gerrit.1712017317000.I911e25949a8647b567fd4178683534d4404ab469@...2715...>
References: <gerrit.1712017317000.I911e25949a8647b567fd4178683534d4404ab469@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <91611df18fe69f0342fceb20855598b6fea3f633-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/u8msTZRfUU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove/combine
 redundant call of EVP_CipherInit before EVP_CipherInit_Ex
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/u8msTZRfUU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Remove/combine redundant call of EVP_CipherInit before EVP_=
CipherInit_Ex
......................................................................

Remove/combine redundant call of EVP_CipherInit before EVP_CipherInit_Ex

EVP_CipherInit basically is the same EVP_CipherInit_ex except that it
in some instances it resets/inits the ctx parameter first. We already
call EVP_CIPHER_CTX_reset to reset/init the ctx before. Also ensure that
EVP_CipherInit_Ex gets the cipher to actually be able to initialise the
context.

OpenSSL 1.0.2:

https://github.com/openssl/openssl/blob/OpenSSL_1_0_2-stable/crypto/evp/evp=
_enc.c#L94

EVP_CipherInit calls first EVP_CIPHER_CTX_init and then EVP_CipherInit_ex

Our openssl_compat.h has

for these older OpenSSL versions

OpenSSL 3.0:

https://github.com/openssl/openssl/blob/openssl-3.2/crypto/evp/evp_enc.c#L4=
50

basically the same as 1.0.2. Just that method names have been changed.

Change-Id: I911e25949a8647b567fd4178683534d4404ab469
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 1 insertion(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/552/3

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index bfc5e37..b2c4eb6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -846,11 +846,7 @@
     evp_cipher_type *kt =3D cipher_get(ciphername);

     EVP_CIPHER_CTX_reset(ctx);
-    if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
-    {
-        crypto_msg(M_FATAL, "EVP cipher init #1");
-    }
-    if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL, enc))
+    if (!EVP_CipherInit_ex(ctx, kt, NULL, key, NULL, enc))
     {
         crypto_msg(M_FATAL, "EVP cipher init #2");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I911e25949a8647b567fd4178683534d4404ab469
Gerrit-Change-Number: 552
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--/u8msTZRfUU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove/combine redundant call of EVP_CipherInit befo=
re EVP_CipherInit_Ex<br><br>EVP_CipherInit basically is the same EVP_Cipher=
Init_ex except that it<br>in some instances it resets/inits the ctx paramet=
er first. We already<br>call EVP_CIPHER_CTX_reset to reset/init the ctx bef=
ore. Also ensure that<br>EVP_CipherInit_Ex gets the cipher to actually be a=
ble to initialise the<br>context.<br><br>OpenSSL 1.0.2:<br><br>https://gith=
ub.com/openssl/openssl/blob/OpenSSL_1_0_2-stable/crypto/evp/evp_enc.c#L94<b=
r><br>EVP_CipherInit calls first EVP_CIPHER_CTX_init and then EVP_CipherIni=
t_ex<br><br>Our openssl_compat.h has<br><br>for these older OpenSSL version=
s<br><br>OpenSSL 3.0:<br><br>https://github.com/openssl/openssl/blob/openss=
l-3.2/crypto/evp/evp_enc.c#L450<br><br>basically the same as 1.0.2. Just th=
at method names have been changed.<br><br>Change-Id: I911e25949a8647b567fd4=
178683534d4404ab469<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<=
br>---<br>M src/openvpn/crypto_openssl.c<br>1 file changed, 1 insertion(+),=
 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/52/552/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/sr=
c/openvpn/crypto_openssl.c</span><br><span>index bfc5e37..b2c4eb6 100644</s=
pan><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/=
openvpn/crypto_openssl.c</span><br><span>@@ -846,11 +846,7 @@</span><br><sp=
an>     evp_cipher_type *kt =3D cipher_get(ciphername);</span><br><span> </=
span><br><span>     EVP_CIPHER_CTX_reset(ctx);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;EVP=
 cipher init #1&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_C=
ipherInit_ex(ctx, NULL, NULL, key, NULL, enc))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!EVP_CipherInit_ex(ctx, kt, NULL, key, N=
ULL, enc))</span><br><span>     {</span><br><span>         crypto_msg(M_FAT=
AL, &quot;EVP cipher init #2&quot;);</span><br><span>     }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/552?usp=3Demail">change 552</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/552?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I911e25949a8647b567fd4178683=
534d4404ab469 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 552 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--/u8msTZRfUU=--


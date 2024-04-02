From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Apr 2024 00:22:02 +0000
References: <gerrit.1712017317000.I911e25949a8647b567fd4178683534d4404ab469@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6eee5b0654aece503b1a0da0cdd5ff4f7aa65ae6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iuX4Qh7wzag="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove redundant
 call of EVP_CipherInit before EVP_CipherInit_Ex
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

--iuX4Qh7wzag=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail

to review the following change.


Change subject: Remove redundant call of EVP_CipherInit before EVP_CipherIn=
it_Ex
......................................................................

Remove redundant call of EVP_CipherInit before EVP_CipherInit_Ex

EVP_CipherInit basically is the same EVP_CipherInit_ex except that it
in some instances it resets/inits the ctx parameter first. We already
call EVP_CIPHER_CTX_reset to reset/init the ctx before so this call does
not do anything useful

Change-Id: I911e25949a8647b567fd4178683534d4404ab469
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 0 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/552/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index bfc5e37..13dfa8c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -846,10 +846,6 @@
     evp_cipher_type *kt =3D cipher_get(ciphername);
=20
     EVP_CIPHER_CTX_reset(ctx);
-    if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
-    {
-        crypto_msg(M_FATAL, "EVP cipher init #1");
-    }
     if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL, enc))
     {
         crypto_msg(M_FATAL, "EVP cipher init #2");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I911e25949a8647b567fd4178683534d4404ab469
Gerrit-Change-Number: 552
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--iuX4Qh7wzag=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove redundant call of EVP_CipherInit before EVP_CipherInit=
_Ex<br><br>EVP_CipherInit basically is the same EVP_CipherInit_ex except th=
at it<br>in some instances it resets/inits the ctx parameter first. We alre=
ady<br>call EVP_CIPHER_CTX_reset to reset/init the ctx before so this call =
does<br>not do anything useful<br><br>Change-Id: I911e25949a8647b567fd41786=
83534d4404ab469<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>-=
--<br>M src/openvpn/crypto_openssl.c<br>1 file changed, 0 insertions(+), 4 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/52/552/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/o=
penvpn/crypto_openssl.c</span><br><span>index bfc5e37..13dfa8c 100644</span=
><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/ope=
nvpn/crypto_openssl.c</span><br><span>@@ -846,10 +846,6 @@</span><br><span>=
     evp_cipher_type *kt =3D cipher_get(ciphername);</span><br><span> </spa=
n><br><span>     EVP_CIPHER_CTX_reset(ctx);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;EVP ci=
pher init #1&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span>     if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL=
, enc))</span><br><span>     {</span><br><span>         crypto_msg(M_FATAL,=
 &quot;EVP cipher init #2&quot;);</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail"=
>change 552</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/552?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I911e25949a8647b567fd4178683=
534d4404ab469 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 552 </div>
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


--iuX4Qh7wzag=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 13:44:43 +0000
References: <gerrit.1742996678000.If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ce83c0ce4b5f3133acf807fe1b9f37a2569f752c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="giDCatwd7Mk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix mbed TLS key
 exporter functionality in 3.6.x and cmake
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

--giDCatwd7Mk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail

to review the following change.


Change subject: Fix mbed TLS key exporter functionality in 3.6.x and cmake
......................................................................

Fix mbed TLS key exporter functionality in 3.6.x and cmake

Cmake did not check for the mbedtls_ssl_set_export_keys_cb symbol
when generating an mbed TLS configuration. This cause no actual
working key exporter to be in the binary.

Also add an explicit #error to catch this situation during compilation.

Change-Id: If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/ssl_mbedtls.c
2 files changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/920/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b04adce..a8fb64b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -275,6 +275,7 @@
     set(CMAKE_REQUIRED_LIBRARIES "mbedtls;mbedx509;mbedcrypto")
     check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET)
     check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
+    check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_=
MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
     check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)
 endfunction()

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 92b52fe..9e83252 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -253,6 +253,8 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;
 }
+#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
+#error either HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL=
_CONF_EXPORT_KEYS_EXT_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL i=
s defined
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

 bool

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0
Gerrit-Change-Number: 920
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--giDCatwd7Mk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix mbed TLS key exporter functionality in 3.6.x and cmake<br=
><br>Cmake did not check for the mbedtls_ssl_set_export_keys_cb symbol<br>w=
hen generating an mbed TLS configuration. This cause no actual<br>working k=
ey exporter to be in the binary.<br><br>Also add an explicit #error to catc=
h this situation during compilation.<br><br>Change-Id: If38e80e268dc0ee7e57=
de2c175c5b4db0ce55ed0<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>---<br>M CMakeLists.txt<br>M src/openvpn/ssl_mbedtls.c<br>2 files chan=
ged, 3 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/20/920/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.t=
xt b/CMakeLists.txt</span><br><span>index b04adce..a8fb64b 100644</span><br=
><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br>=
<span>@@ -275,6 +275,7 @@</span><br><span>     set(CMAKE_REQUIRED_LIBRARIES=
 &quot;mbedtls;mbedx509;mbedcrypto&quot;)</span><br><span>     check_symbol=
_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRB=
G_UPDATE_RET)</span><br><span>     check_symbol_exists(mbedtls_ssl_conf_exp=
ort_keys_ext_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists=
(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_SET_EXPORT_K=
EYS_CB)</span><br><span>     check_include_files(psa/crypto.h HAVE_MBEDTLS_=
PSA_CRYPTO_H)</span><br><span> endfunction()</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</spa=
n><br><span>index 92b52fe..9e83252 100644</span><br><span>--- a/src/openvpn=
/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><s=
pan>@@ -253,6 +253,8 @@</span><br><span>     memcpy(cache-&gt;master_secret=
, secret, sizeof(cache-&gt;master_secret));</span><br><span>     cache-&gt;=
tls_prf_type =3D tls_prf_type;</span><br><span> }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEY=
S_EXT_CB */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#error e=
ither HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL_CONF_EXP=
ORT_KEYS_EXT_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL is defined=
</span><br><span> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</sp=
an><br><span> </span><br><span> bool</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Dema=
il">change 920</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If38e80e268dc0ee7e57de2c175c=
5b4db0ce55ed0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 920 </div>
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


--giDCatwd7Mk=--


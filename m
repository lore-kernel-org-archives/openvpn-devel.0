From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 25 Apr 2025 13:22:07 +0000
In-Reply-To: <gerrit.1742996678000.If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0@...2715...>
References: <gerrit.1742996678000.If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <f64724aac3a9bbfb6a93883dbbe68d2ae6ee1fdc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="khuNkDROUa4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, MaxF <max@...2606...>

--khuNkDROUa4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Fix mbed TLS key exporter functionality in 3.6.x and cmake
......................................................................

Fix mbed TLS key exporter functionality in 3.6.x and cmake

Cmake did not check for the mbedtls_ssl_set_export_keys_cb symbol
when generating an mbed TLS configuration. This causes no actual
working key exporter to be in the binary.

Also add an explicit #error to catch this situation during compilation.

Change-Id: If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250425131002.21772-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
510.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/ssl_mbedtls.c
2 files changed, 3 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/920/4

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
index e15c391..ec3135a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -253,6 +253,8 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;
 }
+#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
+#error either HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL=
_SET_EXPORT_KEYS_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL is def=
ined
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--khuNkDROUa4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
920?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix mbed TLS key exporter functionality in 3.=
6.x and cmake<br><br>Cmake did not check for the mbedtls_ssl_set_export_key=
s_cb symbol<br>when generating an mbed TLS configuration. This causes no ac=
tual<br>working key exporter to be in the binary.<br><br>Also add an explic=
it #error to catch this situation during compilation.<br><br>Change-Id: If3=
8e80e268dc0ee7e57de2c175c5b4db0ce55ed0<br>Signed-off-by: Arne Schwabe &lt;a=
rne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>Message-Id: &lt;20250425131002.21772-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31510.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeList=
s.txt<br>M src/openvpn/ssl_mbedtls.c<br>2 files changed, 3 insertions(+), 0=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/20/920/4</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</sp=
an><br><span>index b04adce..a8fb64b 100644</span><br><span>--- a/CMakeLists=
.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -275,6 +275,7 =
@@</span><br><span>     set(CMAKE_REQUIRED_LIBRARIES &quot;mbedtls;mbedx509=
;mbedcrypto&quot;)</span><br><span>     check_symbol_exists(mbedtls_ctr_drb=
g_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br=
><span>     check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls=
/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    check_symbol_exists(mbedtls_ssl_set_export=
_keys_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)</span><br><span=
>     check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)</span><br=
><span> endfunction()</span><br><span> </span><br><span>diff --git a/src/op=
envpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index e15c3=
91..ec3135a 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><b=
r><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -253,6 +253,8 @@=
</span><br><span>     memcpy(cache-&gt;master_secret, secret, sizeof(cache-=
&gt;master_secret));</span><br><span>     cache-&gt;tls_prf_type =3D tls_pr=
f_type;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#error either HAVE_MBEDTLS_SSL_=
CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB must be defi=
ned when HAVE_EXPORT_KEYING_MATERIAL is defined</span><br><span> #endif /* =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </span><br><sp=
an> bool</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail">change 920</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/920?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If38e80e268dc0ee7e57de2c175c=
5b4db0ce55ed0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 920 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--khuNkDROUa4=--


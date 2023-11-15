From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 16:14:31 +0000
In-Reply-To: <gerrit.1699630545000.If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708@...2715...>
References: <gerrit.1699630545000.If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <1908ed1b9b272b4a0d65046984b00795047081ce-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E+zWCASIQgE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Disable TLS 1.3
 support with mbed TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--E+zWCASIQgE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/403?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Disable TLS 1.3 support with mbed TLS
......................................................................

Disable TLS 1.3 support with mbed TLS

As of version 3.5.0 the TLS-Exporter function is not yet implemented in
mbed TLS, and the exporter_master_secret is not exposed to the
application either. Falling back to an older PRF when claiming to use
TLS1.3 seems like false advertising.

Change-Id: If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231115151740.23948-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
453.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M README.mbedtls
M src/openvpn/ssl_mbedtls.c
2 files changed, 6 insertions(+), 29 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/403/6

diff --git a/README.mbedtls b/README.mbedtls
index 9b75c2b..ed9d369 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -43,19 +43,5 @@

 *************************************************************************

-Mbed TLS 3 supports the TLS 1.3 protocol, but the implementation is not yet
-complete. Therefore, using TLS 1.3 in the mbed TLS build of OpenVPN is not=
 yet
-supported.
-
-Nevertheless, here are some pointers to make it work with mbed TLS 3.5.0:
-
- * The stock configuration of mbed TLS does not support TLS 1.3. To enable=
 it,
-   uncomment `#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h b=
efore
-   compiling the library.
- * An OpenVPN client with mbed TLS cannot connect to a server with OpenSSL
-   using TLS 1.3.
- * An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS=
 with
-   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` =
has
-   been uncommented in mbedtls_config.h.
-
-Note that none of these limitations apply to TLS 1.2.
+Mbed TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have di=
sabled
+support in OpenVPN because the TLS-Exporter function is not yet implemente=
d.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4ece37e..6a3cd44 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -980,17 +980,15 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
-    return TLS_VER_1_3;
-#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
 #elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
     return TLS_VER_1_1;
 #elif defined(MBEDTLS_SSL_PROTO_TLS1)
     return TLS_VER_1_0;
-#else /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */
-    #error "mbedtls is compiled without support for any version of TLS."
-#endif
+#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
+    #error "mbedtls is compiled without support for TLS 1.0, 1.1 and 1.2."
+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
 }

 /**
@@ -1032,13 +1030,6 @@
             break;
 #endif

-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
-        case TLS_VER_1_3:
-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_4;
-            break;
-#endif
-
         default:
             msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __fu=
nc__, tls_ver);
             break;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/403?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708
Gerrit-Change-Number: 403
Gerrit-PatchSet: 6
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--E+zWCASIQgE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by MaxF.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/403?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Disable TLS 1.3 support with mbed TLS<br><br>=
As of version 3.5.0 the TLS-Exporter function is not yet implemented in<br>=
mbed TLS, and the exporter_master_secret is not exposed to the<br>applicati=
on either. Falling back to an older PRF when claiming to use<br>TLS1.3 seem=
s like false advertising.<br><br>Change-Id: If4e1c4af9831eb1090ccb3a3c4d3e7=
6b413f0708<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2754...=
...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-=
Id: &lt;20231115151740.23948-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg27453.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M README.mbedtls<br>M =
src/openvpn/ssl_mbedtls.c<br>2 files changed, 6 insertions(+), 29 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
03/403/6</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/README.mbedtls b/README.mbedtls</span><br><sp=
an>index 9b75c2b..ed9d369 100644</span><br><span>--- a/README.mbedtls</span=
><br><span>+++ b/README.mbedtls</span><br><span>@@ -43,19 +43,5 @@</span><b=
r><span> </span><br><span> ************************************************=
*************************</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-Mbed TLS 3 supports the TLS 1.3 protocol, but the imp=
lementation is not yet</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-complete. Therefore, using TLS 1.3 in the mbed TLS build of OpenVPN is not=
 yet</span><br><span style=3D"color: hsl(0, 100%, 40%);">-supported.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-Nevertheless, here are some pointers to make it w=
ork with mbed TLS 3.5.0:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The stock confi=
guration of mbed TLS does not support TLS 1.3. To enable it,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   uncomment `#define MBEDTLS_SSL_PR=
OTO_TLS1_3` in your mbedtls_config.h before</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   compiling the library.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * An OpenVPN client with mbed TLS cannot connect=
 to a server with OpenSSL</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   using TLS 1.3.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS =
with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   TLS 1.3, but *=
only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` has</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   been uncommented in mbedtls_confi=
g.h.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-Note that none of these limitations ap=
ply to TLS 1.2.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Mbed=
 TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have disable=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+support in OpenVPN=
 because the TLS-Exporter function is not yet implemented.</span><br><span>=
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><b=
r><span>index 4ece37e..6a3cd44 100644</span><br><span>--- a/src/openvpn/ssl=
_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>=
@@ -980,17 +980,15 @@</span><br><span> int</span><br><span> tls_version_max=
(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return TLS_VER_1_3;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS=
1_2)</span><br><span>     return TLS_VER_1_2;</span><br><span> #elif define=
d(MBEDTLS_SSL_PROTO_TLS1_1)</span><br><span>     return TLS_VER_1_1;</span>=
<br><span> #elif defined(MBEDTLS_SSL_PROTO_TLS1)</span><br><span>     retur=
n TLS_VER_1_0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /=
* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    #error &quot;mbedtls is compiled without support fo=
r any version of TLS.&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /=
* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    #error &quot;mbedtls is compiled without support for=
 TLS 1.0, 1.1 and 1.2.&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span>@@ -1032,13 +1030,6 =
@@</span><br><span>             break;</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(MBED=
TLS_SSL_PROTO_TLS1_3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case TLS_VER_1_3:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            *minor =3D MBEDTLS_SSL_MINOR_=
VERSION_4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         def=
ault:</span><br><span>             msg(M_FATAL, &quot;%s: invalid or unsupp=
orted TLS version %d&quot;, __func__, tls_ver);</span><br><span>           =
  break;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/403?usp=3Demail">change 403</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/403?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4e1c4af9831eb1090ccb3a3c4d=
3e76b413f0708 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--E+zWCASIQgE=--


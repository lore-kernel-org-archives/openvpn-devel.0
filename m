From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 13 Nov 2023 16:33:05 +0000
In-Reply-To: <gerrit.1699630545000.If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708@...2715...>
References: <gerrit.1699630545000.If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <89c089cf35fd65f804e6176f338f84b01e477b14-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D77kFU8JH9A="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D77kFU8JH9A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/403?usp=3Demail

to look at the new patch set (#4).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Disable TLS 1.3 support with mbed TLS
......................................................................

Disable TLS 1.3 support with mbed TLS

As of version 3.5.0 the TLS-Exporter function is not yet implemented in
mbed TLS, and the exporter_master_secret is not exposed to the
application either. Falling back to an older PRF when claiming to use
TLS1.3 seems like false advertising.

Change-Id: If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M README.mbedtls
M src/openvpn/ssl_mbedtls.c
2 files changed, 6 insertions(+), 29 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/403/4

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
index 5168484..9c9167d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1037,17 +1037,15 @@
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
@@ -1089,13 +1087,6 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--D77kFU8JH9A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, plaisthos. </p>
<p>MaxF <strong>uploaded patch set #4</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/403?usp=3Demail">View Change</a>=
</p><p>The change is no longer submittable: checks~ChecksSubmitRule is unsa=
tisfied now.</p><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Disable TLS 1.3 support with mbed TLS<br><br>As of version 3.5=
.0 the TLS-Exporter function is not yet implemented in<br>mbed TLS, and the=
 exporter_master_secret is not exposed to the<br>application either. Fallin=
g back to an older PRF when claiming to use<br>TLS1.3 seems like false adve=
rtising.<br><br>Change-Id: If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708<br>Sig=
ned-off-by: Max Fillinger &lt;maximilian.fillinger@...2507...&gt;<br>---<br=
>M README.mbedtls<br>M src/openvpn/ssl_mbedtls.c<br>2 files changed, 6 inse=
rtions(+), 29 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/03/403/4</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/README.mbedtls b/READM=
E.mbedtls</span><br><span>index 9b75c2b..ed9d369 100644</span><br><span>---=
 a/README.mbedtls</span><br><span>+++ b/README.mbedtls</span><br><span>@@ -=
43,19 +43,5 @@</span><br><span> </span><br><span> *************************=
************************************************</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-Mbed TLS 3 supports the TLS 1.=
3 protocol, but the implementation is not yet</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-complete. Therefore, using TLS 1.3 in the mbed TLS =
build of OpenVPN is not yet</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-supported.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Nevertheless, here are som=
e pointers to make it work with mbed TLS 3.5.0:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * The stock configuration of mbed TLS does not support TLS 1.3. To en=
able it,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   uncomment =
`#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   compiling the library.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * An OpenVPN client with =
mbed TLS cannot connect to a server with OpenSSL</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   using TLS 1.3.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * An OpenVPN client with OpenSSL *can* connect to a=
 server using mbed TLS with</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_M=
ODE` has</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   been uncom=
mented in mbedtls_config.h.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Note that none =
of these limitations apply to TLS 1.2.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+Mbed TLS 3 has implemented (parts of) the TLS 1.3 protoc=
ol, but we have disabled</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+support in OpenVPN because the TLS-Exporter function is not yet implem=
ented.</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn=
/ssl_mbedtls.c</span><br><span>index 5168484..9c9167d 100644</span><br><spa=
n>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbe=
dtls.c</span><br><span>@@ -1037,17 +1037,15 @@</span><br><span> int</span><=
br><span> tls_version_max(void)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return TLS_VER_1_3;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(MBEDTLS_SSL_PR=
OTO_TLS1_2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>     return TLS_VER_1_2;</spa=
n><br><span> #elif defined(MBEDTLS_SSL_PROTO_TLS1_1)</span><br><span>     r=
eturn TLS_VER_1_1;</span><br><span> #elif defined(MBEDTLS_SSL_PROTO_TLS1)</=
span><br><span>     return TLS_VER_1_0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#else /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    #error &quot;mbedtls is co=
mpiled without support for any version of TLS.&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    #error &quot;mbedtls is co=
mpiled without support for TLS 1.0, 1.1 and 1.2.&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1=
_2) */</span><br><span> }</span><br><span> </span><br><span> /**</span><br>=
<span>@@ -1089,13 +1087,6 @@</span><br><span>             break;</span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        case TLS_VER_1_3:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            *major =3D MBEDTLS_SSL_MAJOR_VE=
RSION_3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *=
minor =3D MBEDTLS_SSL_MINOR_VERSION_4;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>         default:</span><br><span>             msg(M_FATAL,=
 &quot;%s: invalid or unsupported TLS version %d&quot;, __func__, tls_ver);=
</span><br><span>             break;</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/403?usp=3Dema=
il">change 403</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/403?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4e1c4af9831eb1090ccb3a3c4d=
3e76b413f0708 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--D77kFU8JH9A=--


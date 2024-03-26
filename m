From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Mar 2024 11:28:39 +0000
In-Reply-To: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
References: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <33be386a6fe9088a164e43693c2ad81d590d228b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g0L5VDR4i7w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix
 snprintf/swnprintf related compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--g0L5VDR4i7w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/54=
9?usp=3Demail )

Change subject: Fix snprintf/swnprintf related compiler warnings
......................................................................

Fix snprintf/swnprintf related compiler warnings

When openvpn_snprintf is replaced by snprintf the GCC/MSVC compiler
will perform additional checks that the result is not truncated.

This warning can be avoid by either explicitly checking the return value
of snprintf (proxy) or ensuring that it is never truncated(tls crypt)

Change-Id: If23988a05dd53a519c5e57f2aa3b2d10bd29df1d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240326104101.531291-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
475.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/proxy.c
M src/openvpn/socks.c
M src/openvpn/ssl_openssl.c
M src/openvpn/tls_crypt.c
M src/openvpnserv/interactive.c
5 files changed, 25 insertions(+), 17 deletions(-)




diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c904301..5c1cdcb 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -948,17 +948,21 @@
                 }

                 /* send digest response */
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: D=
igest username=3D\"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=
=3D%s, nc=3D%s, cnonce=3D\"%s\", response=3D\"%s\"%s",
-                                 username,
-                                 realm,
-                                 nonce,
-                                 uri,
-                                 qop,
-                                 nonce_count,
-                                 cnonce,
-                                 response,
-                                 opaque_kv
-                                 );
+                int sret =3D openvpn_snprintf(buf, sizeof(buf), "Proxy-Aut=
horization: Digest username=3D\"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=
=3D\"%s\", qop=3D%s, nc=3D%s, cnonce=3D\"%s\", response=3D\"%s\"%s",
+                                            username,
+                                            realm,
+                                            nonce,
+                                            uri,
+                                            qop,
+                                            nonce_count,
+                                            cnonce,
+                                            response,
+                                            opaque_kv
+                                            );
+                if (sret >=3D sizeof(buf))
+                {
+                    goto error;
+                }
                 msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
                 {
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d842666..b046910 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -109,8 +109,11 @@
             "Authentication not possible.");
         goto cleanup;
     }
-    openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int) strle=
n(creds.username),
-                     creds.username, (int) strlen(creds.password), creds.p=
assword);
+    int sret =3D openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s",
+                                (int) strlen(creds.username), creds.userna=
me,
+                                (int) strlen(creds.password), creds.passwo=
rd);
+    ASSERT(sret <=3D sizeof(to_send));
+
     size =3D send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);

     if (size !=3D strlen(to_send))
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 4383e98..6f29c3d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2069,7 +2069,7 @@
 #endif

 #ifndef OPENSSL_NO_EC
-    char groupname[256];
+    char groupname[64];
     if (is_ec)
     {
         size_t len;
@@ -2130,7 +2130,7 @@
 print_cert_details(X509 *cert, char *buf, size_t buflen)
 {
     EVP_PKEY *pkey =3D X509_get_pubkey(cert);
-    char pkeybuf[128] =3D { 0 };
+    char pkeybuf[64] =3D { 0 };
     print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));

     char sig[128] =3D { 0 };
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 975d31f..6ef1c7d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -575,7 +575,7 @@

     char metadata_type_str[4] =3D { 0 }; /* Max value: 255 */
     openvpn_snprintf(metadata_type_str, sizeof(metadata_type_str),
-                     "%i", metadata_type);
+                     "%i", (uint8_t) metadata_type);
     struct env_set *es =3D env_set_create(NULL);
     setenv_str(es, "script_type", "tls-crypt-v2-verify");
     setenv_str(es, "metadata_type", metadata_type_str);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 452633c..d32223c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
 #include <sddl.h>
 #include <shellapi.h>
 #include <mstcpip.h>
+#include <inttypes.h>

 #include <versionhelpers.h>

@@ -2002,7 +2003,7 @@
         ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %l=
u",
+    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %"=
 PRIuPTR,
                      sud.options, svc_pipe);

     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If23988a05dd53a519c5e57f2aa3b2d10bd29df1d
Gerrit-Change-Number: 549
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--g0L5VDR4i7w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/549?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix snprintf/swnprintf related compiler warnin=
gs<br><br>When openvpn_snprintf is replaced by snprintf the GCC/MSVC compil=
er<br>will perform additional checks that the result is not truncated.<br><=
br>This warning can be avoid by either explicitly checking the return value=
<br>of snprintf (proxy) or ensuring that it is never truncated(tls crypt)<b=
r><br>Change-Id: If23988a05dd53a519c5e57f2aa3b2d10bd29df1d<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Message-Id: &lt;20240326104101.531291-1-frank@...2716...=
1...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg28475.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/proxy.c<br>M src/openvpn/socks.c<br>M src/openvpn/=
ssl_openssl.c<br>M src/openvpn/tls_crypt.c<br>M src/openvpnserv/interactive=
.c<br>5 files changed, 25 insertions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>i=
ndex c904301..5c1cdcb 100644</span><br><span>--- a/src/openvpn/proxy.c</spa=
n><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -948,17 +948,21 @@=
</span><br><span>                 }</span><br><span> </span><br><span>     =
            /* send digest response */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                openvpn_snprintf(buf, sizeof(buf), &quot;P=
roxy-Authorization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&=
quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s,=
 cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
 username,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                      realm,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                 nonce,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                 uri,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                 q=
op,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
               nonce_count,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                 cnonce,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                 response,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
    opaque_kv</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                         );</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                int sret =3D openvpn_snprintf(buf, sizeof(buf), &qu=
ot;Proxy-Authorization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;=
%s\&quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=
=3D%s, cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                    username,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                            realm,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
          nonce,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                         uri,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                            qop,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                        nonce_count,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            cnonce,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  response,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                            opaque_kv</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (sret &gt;=3D sizeof(buf))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    goto error;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                }</span><br><span>           =
      msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</spa=
n><br><span>                 if (!send_line_crlf(sd, buf))</span><br><span>=
                 {</span><br><span>diff --git a/src/openvpn/socks.c b/src/o=
penvpn/socks.c</span><br><span>index d842666..b046910 100644</span><br><spa=
n>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c</span=
><br><span>@@ -109,8 +109,11 @@</span><br><span>             &quot;Authenti=
cation not possible.&quot;);</span><br><span>         goto cleanup;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    op=
envpn_snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&quot;, (int) st=
rlen(creds.username),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                     creds.username, (int) strlen(creds.password), creds.pa=
ssword);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sre=
t =3D openvpn_snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
            (int) strlen(creds.username), creds.username,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                (int)=
 strlen(creds.password), creds.password);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(sret &lt;=3D sizeof(to_send));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     size =3D =
send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);</span><br><span> </span><=
br><span>     if (size !=3D strlen(to_send))</span><br><span>diff --git a/s=
rc/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index =
4383e98..6f29c3d 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</sp=
an><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2069,7 +20=
69,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #ifndef =
OPENSSL_NO_EC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char=
 groupname[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char groupname[64];</span><br><span>     if (is_ec)</span><br><span>     {=
</span><br><span>         size_t len;</span><br><span>@@ -2130,7 +2130,7 @@=
</span><br><span> print_cert_details(X509 *cert, char *buf, size_t buflen)<=
/span><br><span> {</span><br><span>     EVP_PKEY *pkey =3D X509_get_pubkey(=
cert);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char pkeybu=
f[128] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char pkeybuf[64] =3D { 0 };</span><br><span>     print_pkey_details(pkey,=
 pkeybuf, sizeof(pkeybuf));</span><br><span> </span><br><span>     char sig=
[128] =3D { 0 };</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src=
/openvpn/tls_crypt.c</span><br><span>index 975d31f..6ef1c7d 100644</span><b=
r><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls=
_crypt.c</span><br><span>@@ -575,7 +575,7 @@</span><br><span> </span><br><s=
pan>     char metadata_type_str[4] =3D { 0 }; /* Max value: 255 */</span><b=
r><span>     openvpn_snprintf(metadata_type_str, sizeof(metadata_type_str),=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
&quot;%i&quot;, metadata_type);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     &quot;%i&quot;, (uint8_t) metadata_type);<=
/span><br><span>     struct env_set *es =3D env_set_create(NULL);</span><br=
><span>     setenv_str(es, &quot;script_type&quot;, &quot;tls-crypt-v2-veri=
fy&quot;);</span><br><span>     setenv_str(es, &quot;metadata_type&quot;, m=
etadata_type_str);</span><br><span>diff --git a/src/openvpnserv/interactive=
.c b/src/openvpnserv/interactive.c</span><br><span>index 452633c..d32223c 1=
00644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+=
++ b/src/openvpnserv/interactive.c</span><br><span>@@ -33,6 +33,7 @@</span>=
<br><span> #include &lt;sddl.h&gt;</span><br><span> #include &lt;shellapi.h=
&gt;</span><br><span> #include &lt;mstcpip.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><span> <=
/span><br><span> #include &lt;versionhelpers.h&gt;</span><br><span> </span>=
<br><span>@@ -2002,7 +2003,7 @@</span><br><span>         ReturnLastError(pi=
pe, L&quot;malloc&quot;);</span><br><span>         goto out;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_s=
wprintf(cmdline, cmdline_size, L&quot;openvpn %ls --msg-channel %lu&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprintf=
(cmdline, cmdline_size, L&quot;openvpn %ls --msg-channel %&quot; PRIuPTR,</=
span><br><span>                      sud.options, svc_pipe);</span><br><spa=
n> </span><br><span>     if (!CreateEnvironmentBlock(&amp;user_env, imp_tok=
en, FALSE))</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail">change 549</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/549?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If23988a05dd53a519c5e57f2aa3=
b2d10bd29df1d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 549 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--g0L5VDR4i7w=--


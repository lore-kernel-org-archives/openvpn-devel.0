From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 18:04:53 +0000
References: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a3688f176c3072e590cc96515592951150ce0ea9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CSMJ89CnNfc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CSMJ89CnNfc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail

to review the following change.


Change subject: Fix snprintf/swnprintf related compiler warnings
......................................................................

Fix snprintf/swnprintf related compiler warnings

When openvpn_snprintf is replaced by snprintf the GCC/MSVC compiler
will perform additional checks that the result is not truncated.

This warning can be avoid by either explicitly the return value
of snprintf (proxy) or ensuring that it is never truncated(tls crypt)

Change-Id: If23988a05dd53a519c5e57f2aa3b2d10bd29df1d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/proxy.c
M src/openvpn/socks.c
M src/openvpn/ssl_openssl.c
M src/openvpn/tls_crypt.c
M src/openvpnserv/interactive.c
5 files changed, 25 insertions(+), 17 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/549/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--CSMJ89CnNfc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix snprintf/swnprintf related compiler warnings<br><br>When =
openvpn_snprintf is replaced by snprintf the GCC/MSVC compiler<br>will perf=
orm additional checks that the result is not truncated.<br><br>This warning=
 can be avoid by either explicitly the return value<br>of snprintf (proxy) =
or ensuring that it is never truncated(tls crypt)<br><br>Change-Id: If23988=
a05dd53a519c5e57f2aa3b2d10bd29df1d<br>Signed-off-by: Arne Schwabe &lt;arne@=
...1227...&gt;<br>---<br>M src/openvpn/proxy.c<br>M src/openvpn/socks.c<br>=
M src/openvpn/ssl_openssl.c<br>M src/openvpn/tls_crypt.c<br>M src/openvpnse=
rv/interactive.c<br>5 files changed, 25 insertions(+), 17 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/549/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><=
span>index c904301..5c1cdcb 100644</span><br><span>--- a/src/openvpn/proxy.=
c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -948,17 +948=
,21 @@</span><br><span>                 }</span><br><span> </span><br><span=
>                 /* send digest response */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                openvpn_snprintf(buf, sizeof(buf), &=
quot;Proxy-Authorization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quo=
t;%s\&quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=
=3D%s, cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       username,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                            realm,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                 nonce,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                 uri,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
      qop,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                      nonce_count,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                 cnonce,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                 response,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
           opaque_kv</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                );</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                int sret =3D openvpn_snprintf(buf, sizeof(bu=
f), &quot;Proxy-Authorization: Digest username=3D\&quot;%s\&quot;, realm=3D=
\&quot;%s\&quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%=
s, nc=3D%s, cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                         username,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                            realm,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
               nonce,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                            uri,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                            =
qop,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                             nonce_count,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                            cnonce,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                       response,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                            opaque_kv</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               if (sret &gt;=3D sizeof(buf))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    goto error;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span>      =
           msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);=
</span><br><span>                 if (!send_line_crlf(sd, buf))</span><br><=
span>                 {</span><br><span>diff --git a/src/openvpn/socks.c b/=
src/openvpn/socks.c</span><br><span>index d842666..b046910 100644</span><br=
><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c<=
/span><br><span>@@ -109,8 +109,11 @@</span><br><span>             &quot;Aut=
hentication not possible.&quot;);</span><br><span>         goto cleanup;</s=
pan><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   openvpn_snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&quot;, (in=
t) strlen(creds.username),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                     creds.username, (int) strlen(creds.password), cre=
ds.password);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t sret =3D openvpn_snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                 (int) strlen(creds.username), creds.username,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
(int) strlen(creds.password), creds.password);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(sret &lt;=3D sizeof(to_send));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     size=
 =3D send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);</span><br><span> </s=
pan><br><span>     if (size !=3D strlen(to_send))</span><br><span>diff --gi=
t a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>i=
ndex 4383e98..6f29c3d 100644</span><br><span>--- a/src/openvpn/ssl_openssl.=
c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2069,=
7 +2069,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #if=
ndef OPENSSL_NO_EC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 char groupname[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char groupname[64];</span><br><span>     if (is_ec)</span><br><span> =
    {</span><br><span>         size_t len;</span><br><span>@@ -2130,7 +2130=
,7 @@</span><br><span> print_cert_details(X509 *cert, char *buf, size_t buf=
len)</span><br><span> {</span><br><span>     EVP_PKEY *pkey =3D X509_get_pu=
bkey(cert);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char p=
keybuf[128] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char pkeybuf[64] =3D { 0 };</span><br><span>     print_pkey_details(=
pkey, pkeybuf, sizeof(pkeybuf));</span><br><span> </span><br><span>     cha=
r sig[128] =3D { 0 };</span><br><span>diff --git a/src/openvpn/tls_crypt.c =
b/src/openvpn/tls_crypt.c</span><br><span>index 975d31f..6ef1c7d 100644</sp=
an><br><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvp=
n/tls_crypt.c</span><br><span>@@ -575,7 +575,7 @@</span><br><span> </span><=
br><span>     char metadata_type_str[4] =3D { 0 }; /* Max value: 255 */</sp=
an><br><span>     openvpn_snprintf(metadata_type_str, sizeof(metadata_type_=
str),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
     &quot;%i&quot;, metadata_type);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     &quot;%i&quot;, (uint8_t) metadata_ty=
pe);</span><br><span>     struct env_set *es =3D env_set_create(NULL);</spa=
n><br><span>     setenv_str(es, &quot;script_type&quot;, &quot;tls-crypt-v2=
-verify&quot;);</span><br><span>     setenv_str(es, &quot;metadata_type&quo=
t;, metadata_type_str);</span><br><span>diff --git a/src/openvpnserv/intera=
ctive.c b/src/openvpnserv/interactive.c</span><br><span>index 452633c..d322=
23c 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><s=
pan>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -33,6 +33,7 @@</=
span><br><span> #include &lt;sddl.h&gt;</span><br><span> #include &lt;shell=
api.h&gt;</span><br><span> #include &lt;mstcpip.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><sp=
an> </span><br><span> #include &lt;versionhelpers.h&gt;</span><br><span> </=
span><br><span>@@ -2002,7 +2003,7 @@</span><br><span>         ReturnLastErr=
or(pipe, L&quot;malloc&quot;);</span><br><span>         goto out;</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    open=
vpn_swprintf(cmdline, cmdline_size, L&quot;openvpn %ls --msg-channel %lu&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_swp=
rintf(cmdline, cmdline_size, L&quot;openvpn %ls --msg-channel %&quot; PRIuP=
TR,</span><br><span>                      sud.options, svc_pipe);</span><br=
><span> </span><br><span>     if (!CreateEnvironmentBlock(&amp;user_env, im=
p_token, FALSE))</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail">change 549</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/549?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If23988a05dd53a519c5e57f2aa3=
b2d10bd29df1d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 549 </div>
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


--CSMJ89CnNfc=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 06:45:15 +0000
In-Reply-To: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
References: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <586a7767566e546435775bd03fc66eb9d8f18866-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="35RvkfNTfzk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: remove
 --opt-verify functionality
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--35RvkfNTfzk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: options: remove --opt-verify functionality
......................................................................

options: remove --opt-verify functionality

As previously agreed, the --opt-verify directive is deprecated
and can be fully removed as of OpenVPN 2.7.0.

GitHub: closes OpenVPN/openvpn#901
Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1375
Message-Id: <20251113212143.30034-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
403.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M doc/man-sections/unsupported-options.rst
M src/openvpn/options.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
6 files changed, 10 insertions(+), 28 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1375/3

diff --git a/Changes.rst b/Changes.rst
index 8bdb2b0..457d3a7 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -236,6 +236,9 @@
 ``--reneg-bytes`` and ``--reneg-packets`` do not work in DCO mode, and will
     now print an appropriate warning.

+``--opt-verify`` feature removed
+    This option was already deprecated and it is now being converted to a
+    no-op. Using this option will only print a warning.

 User-visible Changes
 --------------------
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index ade4d41..5243a06 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -413,19 +413,6 @@
   Note that this directive affects OpenVPN's internal routing table, not
   the kernel routing table.

---opt-verify
-  **DEPRECATED** Clients that connect with options that are incompatible w=
ith
-  those of the server will be disconnected.
-
-  Options that will be compared for compatibility include ``dev-type``,
-  ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
-  ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``,
-  ``tls-auth``, ``key-method``, ``tls-server``
-  and ``tls-client``.
-
-  This option requires that ``--disable-occ`` NOT be used.
-
 --override-username username
   Sets the username of a connection to the specified username.  This usern=
ame
   will also be used by ``--auth-gen-token``. However, the overridden
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index 11467ca..e8e76eb 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -44,4 +44,8 @@
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.

 --persist-key
-  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts.
\ No newline at end of file
+  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts.
+
+--opt-verify
+  Removed in OpenVPN 2.7.  This option does not make sense anymore as opti=
on
+  strings may not match due to the introduction of parameters negotiation.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ecf9374..683543a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -472,8 +472,6 @@
     "                  OTP based two-factor auth mechanisms are in use and=
\n"
     "                  --reneg-* options are enabled. Optionally a lifetim=
e in seconds\n"
     "                  for generated tokens can be set.\n"
-    "--opt-verify    : (DEPRECATED) Clients that connect with options that=
 are incompatible\n"
-    "                  with those of the server will be disconnected.\n"
     "--auth-user-pass-optional : Allow connections by clients that don't\n"
     "                  specify a username/password.\n"
     "--no-name-remapping : (DEPRECATED) Allow Common Name and X509 Subject=
 to include\n"
@@ -2666,7 +2664,6 @@
                       "verify-client-cert");
         MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME, "=
username-as-common-name");
         MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL, "=
auth-user-pass-optional");
-        MUST_BE_FALSE(options->ssl_flags & SSLF_OPT_VERIFY, "opt-verify");
         if (options->server_flags & SF_TCP_NODELAY_HELPER)
         {
             msg(M_WARN, "WARNING: setting tcp-nodelay on the client side w=
ill not "
@@ -7450,9 +7447,7 @@
     else if (streq(p[0], "opt-verify") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        msg(M_INFO, "DEPRECATION: opt-verify is deprecated and will be rem=
oved "
-                    "in OpenVPN 2.7");
-        options->ssl_flags |=3D SSLF_OPT_VERIFY;
+        msg(M_INFO, "DEPRECATED OPTION: --opt-verify was removed in OpenVP=
N 2.7.");
     }
     else if (streq(p[0], "auth-user-pass-verify") && p[1])
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d7f55dd..896fd65 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2334,13 +2334,6 @@
 #endif

         options_warning(options, remote_options);
-
-        if (session->opt->ssl_flags & SSLF_OPT_VERIFY)
-        {
-            msg(D_TLS_ERRORS,
-                "Option inconsistency warnings triggering disconnect due t=
o --opt-verify");
-            ks->authenticated =3D KS_AUTH_FALSE;
-        }
     }

     buf_clear(buf);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index de89d30..23da8cf 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -425,7 +425,7 @@
 #define SSLF_CLIENT_CERT_OPTIONAL     (1u << 1)
 #define SSLF_USERNAME_AS_COMMON_NAME  (1u << 2)
 #define SSLF_AUTH_USER_PASS_OPTIONAL  (1u << 3)
-#define SSLF_OPT_VERIFY               (1u << 4)
+/* (1u << 4) free for usage */
 #define SSLF_CRL_VERIFY_DIR           (1u << 5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
 #define SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to 9) =
*/

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Gerrit-Change-Number: 1375
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--35RvkfNTfzk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by ordex.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: remove --opt-verify functi=
onality<br><br>As previously agreed, the --opt-verify directive is deprecat=
ed<br>and can be fully removed as of OpenVPN 2.7.0.<br><br>GitHub: closes O=
penVPN/openvpn#901<br>Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1375<br>Message-Id: &lt;20251113212143.30034-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg34403.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M Changes.rst<br>M doc/man-sections/server-options.rst<br>M doc/=
man-sections/unsupported-options.rst<br>M src/openvpn/options.c<br>M src/op=
envpn/ssl.c<br>M src/openvpn/ssl_common.h<br>6 files changed, 10 insertions=
(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/75/1375/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rs=
t b/Changes.rst</span><br><span>index 8bdb2b0..457d3a7 100644</span><br><sp=
an>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -=
236,6 +236,9 @@</span><br><span> ``--reneg-bytes`` and ``--reneg-packets`` =
do not work in DCO mode, and will</span><br><span>     now print an appropr=
iate warning.</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+``--opt-verify`` feature removed</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    This option was already deprecated and it is n=
ow being converted to a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    no-op. Using this option will only print a warning.</span><br><span=
> </span><br><span> User-visible Changes</span><br><span> -----------------=
---</span><br><span>diff --git a/doc/man-sections/server-options.rst b/doc/=
man-sections/server-options.rst</span><br><span>index ade4d41..5243a06 1006=
44</span><br><span>--- a/doc/man-sections/server-options.rst</span><br><spa=
n>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -413,19 +413=
,6 @@</span><br><span>   Note that this directive affects OpenVPN&#39;s int=
ernal routing table, not</span><br><span>   the kernel routing table.</span=
><br><span> </span><br><span>---opt-verify</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  **DEPRECATED** Clients that connect with options tha=
t are incompatible with</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  those of the server will be disconnected.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  Options that will be compared for compatibility include ``dev-type``,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``link-mtu``, ``tun-=
mtu``, ``proto``, ``ifconfig``,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  ``auth``, ``keysize``,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  ``tls-auth``, ``key-method``=
, ``tls-server``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  and=
 ``tls-client``.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option requires tha=
t ``--disable-occ`` NOT be used.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> --override-username username</span><br><span> =
  Sets the username of a connection to the specified username.  This userna=
me</span><br><span>   will also be used by ``--auth-gen-token``. However, t=
he overridden</span><br><span>diff --git a/doc/man-sections/unsupported-opt=
ions.rst b/doc/man-sections/unsupported-options.rst</span><br><span>index 1=
1467ca..e8e76eb 100644</span><br><span>--- a/doc/man-sections/unsupported-o=
ptions.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rst</=
span><br><span>@@ -44,4 +44,8 @@</span><br><span>   Removed in OpenVPN 2.6.=
  We now always use the PRNG of the SSL library.</span><br><span> </span><b=
r><span> --persist-key</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts=
.</span><br><span>\ No newline at end of file</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Ignored since OpenVPN 2.7. Keys are now always =
persisted across restarts.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--opt-verify=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVP=
N 2.7.  This option does not make sense anymore as option</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  strings may not match due to the in=
troduction of parameters negotiation.</span><br><span>diff --git a/src/open=
vpn/options.c b/src/openvpn/options.c</span><br><span>index ecf9374..683543=
a 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/=
src/openvpn/options.c</span><br><span>@@ -472,8 +472,6 @@</span><br><span> =
    &quot;                  OTP based two-factor auth mechanisms are in use=
 and\n&quot;</span><br><span>     &quot;                  --reneg-* options=
 are enabled. Optionally a lifetime in seconds\n&quot;</span><br><span>    =
 &quot;                  for generated tokens can be set.\n&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--opt-verify    : (DE=
PRECATED) Clients that connect with options that are incompatible\n&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;             =
     with those of the server will be disconnected.\n&quot;</span><br><span=
>     &quot;--auth-user-pass-optional : Allow connections by clients that d=
on&#39;t\n&quot;</span><br><span>     &quot;                  specify a use=
rname/password.\n&quot;</span><br><span>     &quot;--no-name-remapping : (D=
EPRECATED) Allow Common Name and X509 Subject to include\n&quot;</span><br>=
<span>@@ -2666,7 +2664,6 @@</span><br><span>                       &quot;ve=
rify-client-cert&quot;);</span><br><span>         MUST_BE_FALSE(options-&gt=
;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME, &quot;username-as-common-nam=
e&quot;);</span><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags &amp=
; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;auth-user-pass-optional&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_FALSE(optio=
ns-&gt;ssl_flags &amp; SSLF_OPT_VERIFY, &quot;opt-verify&quot;);</span><br>=
<span>         if (options-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)</s=
pan><br><span>         {</span><br><span>             msg(M_WARN, &quot;WAR=
NING: setting tcp-nodelay on the client side will not &quot;</span><br><spa=
n>@@ -7450,9 +7447,7 @@</span><br><span>     else if (streq(p[0], &quot;opt=
-verify&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_INFO, &quot;DEPRECATION: opt-verify is depr=
ecated and will be removed &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    &quot;in OpenVPN 2.7&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ssl_flags |=3D S=
SLF_OPT_VERIFY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_INFO, &quot;DEPRECATED OPTION: --opt-verify was removed in OpenVP=
N 2.7.&quot;);</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;auth-user-pass-verify&quot;) &amp;&amp; p[1])</span><br><span>  =
   {</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</sp=
an><br><span>index d7f55dd..896fd65 100644</span><br><span>--- a/src/openvp=
n/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2334,13=
 +2334,6 @@</span><br><span> #endif</span><br><span> </span><br><span>     =
    options_warning(options, remote_options);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (session-&gt;opt-&gt;ssl_flags &amp; SSLF_OPT_VERIFY)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Option inco=
nsistency warnings triggering disconnect due to --opt-verify&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;authentic=
ated =3D KS_AUTH_FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span>     }</span><br><span> </span><br><span>     b=
uf_clear(buf);</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/=
openvpn/ssl_common.h</span><br><span>index de89d30..23da8cf 100644</span><b=
r><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ss=
l_common.h</span><br><span>@@ -425,7 +425,7 @@</span><br><span> #define SSL=
F_CLIENT_CERT_OPTIONAL     (1u &lt;&lt; 1)</span><br><span> #define SSLF_US=
ERNAME_AS_COMMON_NAME  (1u &lt;&lt; 2)</span><br><span> #define SSLF_AUTH_U=
SER_PASS_OPTIONAL  (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define SSLF_OPT_VERIFY               (1u &lt;&lt; 4)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* (1u &lt;&lt; 4) free for =
usage */</span><br><span> #define SSLF_CRL_VERIFY_DIR           (1u &lt;&lt=
; 5)</span><br><span> #define SSLF_TLS_VERSION_MIN_SHIFT    6</span><br><sp=
an> #define SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to =
9) */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail">change 1375</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1375?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia60a393a296f23ac1090d0f2016=
b5682649ed490 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1375 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--35RvkfNTfzk=--


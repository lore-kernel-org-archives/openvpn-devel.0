From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 06:45:19 +0000
In-Reply-To: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
References: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <586a7767566e546435775bd03fc66eb9d8f18866-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qb+c//wGas0="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qb+c//wGas0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
75?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Gerrit-Change-Number: 1375
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qb+c//wGas0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1375?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: remove --opt-verify functionality<br><b=
r>As previously agreed, the --opt-verify directive is deprecated<br>and can=
 be fully removed as of OpenVPN 2.7.0.<br><br>GitHub: closes OpenVPN/openvp=
n#901<br>Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490<br>Signed-off=
-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1375<br>Message-Id: &lt;20251113212143.30034-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg344=
03.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
Changes.rst<br>M doc/man-sections/server-options.rst<br>M doc/man-sections/=
unsupported-options.rst<br>M src/openvpn/options.c<br>M src/openvpn/ssl.c<b=
r>M src/openvpn/ssl_common.h<br>6 files changed, 10 insertions(+), 28 delet=
ions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 8bdb2b0..45=
7d3a7 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -236,6 +236,9 @@</span><br><span> ``--reneg-bytes`=
` and ``--reneg-packets`` do not work in DCO mode, and will</span><br><span=
>     now print an appropriate warning.</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+``--opt-verify`` feature removed</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    This option was alre=
ady deprecated and it is now being converted to a</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    no-op. Using this option will only print =
a warning.</span><br><span> </span><br><span> User-visible Changes</span><b=
r><span> --------------------</span><br><span>diff --git a/doc/man-sections=
/server-options.rst b/doc/man-sections/server-options.rst</span><br><span>i=
ndex ade4d41..5243a06 100644</span><br><span>--- a/doc/man-sections/server-=
options.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</span=
><br><span>@@ -413,19 +413,6 @@</span><br><span>   Note that this directive=
 affects OpenVPN&#39;s internal routing table, not</span><br><span>   the k=
ernel routing table.</span><br><span> </span><br><span>---opt-verify</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  **DEPRECATED** Clients tha=
t connect with options that are incompatible with</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  those of the server will be disconnected.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  Options that will be compared for compatibil=
ity include ``dev-type``,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  ``comp-lzo``, ``fragment``, ``keydir`=
`, ``cipher``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``aut=
h``, ``keysize``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``=
tls-auth``, ``key-method``, ``tls-server``</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  and ``tls-client``.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  This option requires that ``--disable-occ`` NOT be used.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --override-username =
username</span><br><span>   Sets the username of a connection to the specif=
ied username.  This username</span><br><span>   will also be used by ``--au=
th-gen-token``. However, the overridden</span><br><span>diff --git a/doc/ma=
n-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.r=
st</span><br><span>index 11467ca..e8e76eb 100644</span><br><span>--- a/doc/=
man-sections/unsupported-options.rst</span><br><span>+++ b/doc/man-sections=
/unsupported-options.rst</span><br><span>@@ -44,4 +44,8 @@</span><br><span>=
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.<=
/span><br><span> </span><br><span> --persist-key</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  Ignored since OpenVPN 2.7. Keys are now always=
 persisted across restarts.</span><br><span>\ No newline at end of file</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ignored since OpenVPN=
 2.7. Keys are now always persisted across restarts.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+--opt-verify</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  Removed in OpenVPN 2.7.  This option does not make sense anymore =
as option</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  strings =
may not match due to the introduction of parameters negotiation.</span><br>=
<span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br>=
<span>index ecf9374..683543a 100644</span><br><span>--- a/src/openvpn/optio=
ns.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -472,8 =
+472,6 @@</span><br><span>     &quot;                  OTP based two-factor=
 auth mechanisms are in use and\n&quot;</span><br><span>     &quot;        =
          --reneg-* options are enabled. Optionally a lifetime in seconds\n=
&quot;</span><br><span>     &quot;                  for generated tokens ca=
n be set.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&quot;--opt-verify    : (DEPRECATED) Clients that connect with options that=
 are incompatible\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &quot;                  with those of the server will be disconnect=
ed.\n&quot;</span><br><span>     &quot;--auth-user-pass-optional : Allow co=
nnections by clients that don&#39;t\n&quot;</span><br><span>     &quot;    =
              specify a username/password.\n&quot;</span><br><span>     &qu=
ot;--no-name-remapping : (DEPRECATED) Allow Common Name and X509 Subject to=
 include\n&quot;</span><br><span>@@ -2666,7 +2664,6 @@</span><br><span>    =
                   &quot;verify-client-cert&quot;);</span><br><span>       =
  MUST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME, &=
quot;username-as-common-name&quot;);</span><br><span>         MUST_BE_FALSE=
(options-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;auth-user-=
pass-optional&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        MUST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_OPT_VERIFY, &quot;op=
t-verify&quot;);</span><br><span>         if (options-&gt;server_flags &amp=
; SF_TCP_NODELAY_HELPER)</span><br><span>         {</span><br><span>       =
      msg(M_WARN, &quot;WARNING: setting tcp-nodelay on the client side wil=
l not &quot;</span><br><span>@@ -7450,9 +7447,7 @@</span><br><span>     els=
e if (streq(p[0], &quot;opt-verify&quot;) &amp;&amp; !p[1])</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;DEPR=
ECATION: opt-verify is deprecated and will be removed &quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    &quot;in OpenVPN=
 2.7&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
ptions-&gt;ssl_flags |=3D SSLF_OPT_VERIFY;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;DEPRECATED OPTION: --opt-v=
erify was removed in OpenVPN 2.7.&quot;);</span><br><span>     }</span><br>=
<span>     else if (streq(p[0], &quot;auth-user-pass-verify&quot;) &amp;&am=
p; p[1])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ss=
l.c b/src/openvpn/ssl.c</span><br><span>index d7f55dd..896fd65 100644</span=
><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c<=
/span><br><span>@@ -2334,13 +2334,6 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span>         options_warning(options, remote_options);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (session-&gt;opt-&gt;ssl_flags &=
amp; SSLF_OPT_VERIFY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            &quot;Option inconsistency warnings triggering disconnect due t=
o --opt-verify&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            ks-&gt;authenticated =3D KS_AUTH_FALSE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>     }</span><br>=
<span> </span><br><span>     buf_clear(buf);</span><br><span>diff --git a/s=
rc/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index de=
89d30..23da8cf 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span>=
<br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -425,7 +425,7 @=
@</span><br><span> #define SSLF_CLIENT_CERT_OPTIONAL     (1u &lt;&lt; 1)</s=
pan><br><span> #define SSLF_USERNAME_AS_COMMON_NAME  (1u &lt;&lt; 2)</span>=
<br><span> #define SSLF_AUTH_USER_PASS_OPTIONAL  (1u &lt;&lt; 3)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_OPT_VERIFY         =
      (1u &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* (1u &lt;&lt; 4) free for usage */</span><br><span> #define SSLF_CRL_VE=
RIFY_DIR           (1u &lt;&lt; 5)</span><br><span> #define SSLF_TLS_VERSIO=
N_MIN_SHIFT    6</span><br><span> #define SSLF_TLS_VERSION_MIN_MASK     0xF=
u /* (uses bit positions 6 to 9) */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Dema=
il">change 1375</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--qb+c//wGas0=--


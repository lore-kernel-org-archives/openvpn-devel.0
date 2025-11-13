From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 13 Nov 2025 14:04:21 +0000
In-Reply-To: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
References: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <90f87508282ba29275ca7039fe493f1dc400a4b0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NT5eXDGzSTQ="; charset=UTF-8
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

--NT5eXDGzSTQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: options: remove --opt-verify functionality
......................................................................

options: remove --opt-verify functionality

As previously agreed, the --opt-verify directive is deprecated
and can be fully removed as of OpenVPN 2.7.0.

GitHub: closes OpenVPN/openvpn#901
Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M doc/man-sections/unsupported-options.rst
M src/openvpn/options.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
6 files changed, 10 insertions(+), 28 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1375/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <antonio@...2726...>

--NT5eXDGzSTQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: remove --opt-verify functi=
onality<br><br>As previously agreed, the --opt-verify directive is deprecat=
ed<br>and can be fully removed as of OpenVPN 2.7.0.<br><br>GitHub: closes O=
penVPN/openvpn#901<br>Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M =
Changes.rst<br>M doc/man-sections/server-options.rst<br>M doc/man-sections/=
unsupported-options.rst<br>M src/openvpn/options.c<br>M src/openvpn/ssl.c<b=
r>M src/openvpn/ssl_common.h<br>6 files changed, 10 insertions(+), 28 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/75/1375/2</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.r=
st</span><br><span>index 8bdb2b0..457d3a7 100644</span><br><span>--- a/Chan=
ges.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -236,6 +236,9 =
@@</span><br><span> ``--reneg-bytes`` and ``--reneg-packets`` do not work i=
n DCO mode, and will</span><br><span>     now print an appropriate warning.=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+`=
`--opt-verify`` feature removed</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    This option was already deprecated and it is now being conv=
erted to a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    no-op=
. Using this option will only print a warning.</span><br><span> </span><br>=
<span> User-visible Changes</span><br><span> --------------------</span><br=
><span>diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/=
server-options.rst</span><br><span>index ade4d41..5243a06 100644</span><br>=
<span>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/m=
an-sections/server-options.rst</span><br><span>@@ -413,19 +413,6 @@</span><=
br><span>   Note that this directive affects OpenVPN&#39;s internal routing=
 table, not</span><br><span>   the kernel routing table.</span><br><span> <=
/span><br><span>---opt-verify</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  **DEPRECATED** Clients that connect with options that are incompa=
tible with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  those of =
the server will be disconnected.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Options =
that will be compared for compatibility include ``dev-type``,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  ``link-mtu``, ``tun-mtu``, ``prot=
o``, ``ifconfig``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  `=
`comp-lzo``, ``fragment``, ``keydir``, ``cipher``,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  ``auth``, ``keysize``,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``tls-auth``, ``key-method``, ``tls-serve=
r``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  and ``tls-client=
``.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  This option requires that ``--disable=
-occ`` NOT be used.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> --override-username username</span><br><span>   Sets the us=
ername of a connection to the specified username.  This username</span><br>=
<span>   will also be used by ``--auth-gen-token``. However, the overridden=
</span><br><span>diff --git a/doc/man-sections/unsupported-options.rst b/do=
c/man-sections/unsupported-options.rst</span><br><span>index 11467ca..e8e76=
eb 100644</span><br><span>--- a/doc/man-sections/unsupported-options.rst</s=
pan><br><span>+++ b/doc/man-sections/unsupported-options.rst</span><br><spa=
n>@@ -44,4 +44,8 @@</span><br><span>   Removed in OpenVPN 2.6.  We now alwa=
ys use the PRNG of the SSL library.</span><br><span> </span><br><span> --pe=
rsist-key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Ignored si=
nce OpenVPN 2.7. Keys are now always persisted across restarts.</span><br><=
span>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  Ignored since OpenVPN 2.7. Keys are now always persisted acr=
oss restarts.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+--opt-verify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.7.  This =
option does not make sense anymore as option</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  strings may not match due to the introduction of=
 parameters negotiation.</span><br><span>diff --git a/src/openvpn/options.c=
 b/src/openvpn/options.c</span><br><span>index ecf9374..683543a 100644</spa=
n><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/o=
ptions.c</span><br><span>@@ -472,8 +472,6 @@</span><br><span>     &quot;   =
               OTP based two-factor auth mechanisms are in use and\n&quot;<=
/span><br><span>     &quot;                  --reneg-* options are enabled.=
 Optionally a lifetime in seconds\n&quot;</span><br><span>     &quot;      =
            for generated tokens can be set.\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;--opt-verify    : (DEPRECATED) Cl=
ients that connect with options that are incompatible\n&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  with th=
ose of the server will be disconnected.\n&quot;</span><br><span>     &quot;=
--auth-user-pass-optional : Allow connections by clients that don&#39;t\n&q=
uot;</span><br><span>     &quot;                  specify a username/passwo=
rd.\n&quot;</span><br><span>     &quot;--no-name-remapping : (DEPRECATED) A=
llow Common Name and X509 Subject to include\n&quot;</span><br><span>@@ -26=
66,7 +2664,6 @@</span><br><span>                       &quot;verify-client-=
cert&quot;);</span><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags &=
amp; SSLF_USERNAME_AS_COMMON_NAME, &quot;username-as-common-name&quot;);</s=
pan><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_AUTH_=
USER_PASS_OPTIONAL, &quot;auth-user-pass-optional&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_FALSE(options-&gt;ssl_f=
lags &amp; SSLF_OPT_VERIFY, &quot;opt-verify&quot;);</span><br><span>      =
   if (options-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)</span><br><spa=
n>         {</span><br><span>             msg(M_WARN, &quot;WARNING: settin=
g tcp-nodelay on the client side will not &quot;</span><br><span>@@ -7450,9=
 +7447,7 @@</span><br><span>     else if (streq(p[0], &quot;opt-verify&quot=
;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY=
_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_INFO, &quot;DEPRECATION: opt-verify is deprecated and w=
ill be removed &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    &quot;in OpenVPN 2.7&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;ssl_flags |=3D SSLF_OPT_VERI=
FY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_IN=
FO, &quot;DEPRECATED OPTION: --opt-verify was removed in OpenVPN 2.7.&quot;=
);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;a=
uth-user-pass-verify&quot;) &amp;&amp; p[1])</span><br><span>     {</span><=
br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span=
>index d7f55dd..896fd65 100644</span><br><span>--- a/src/openvpn/ssl.c</spa=
n><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2334,13 +2334,6 @@<=
/span><br><span> #endif</span><br><span> </span><br><span>         options_=
warning(options, remote_options);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (session-&gt;opt-&gt;ssl_flags &amp; SSLF_OPT_VERIFY)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;Option inconsistency =
warnings triggering disconnect due to --opt-verify&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;authenticated =3D K=
S_AUTH_FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span>     }</span><br><span> </span><br><span>     buf_clear(b=
uf);</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ss=
l_common.h</span><br><span>index de89d30..23da8cf 100644</span><br><span>--=
- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h=
</span><br><span>@@ -425,7 +425,7 @@</span><br><span> #define SSLF_CLIENT_C=
ERT_OPTIONAL     (1u &lt;&lt; 1)</span><br><span> #define SSLF_USERNAME_AS_=
COMMON_NAME  (1u &lt;&lt; 2)</span><br><span> #define SSLF_AUTH_USER_PASS_O=
PTIONAL  (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define SSLF_OPT_VERIFY               (1u &lt;&lt; 4)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* (1u &lt;&lt; 4) free for usage */</=
span><br><span> #define SSLF_CRL_VERIFY_DIR           (1u &lt;&lt; 5)</span=
><br><span> #define SSLF_TLS_VERSION_MIN_SHIFT    6</span><br><span> #defin=
e SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to 9) */</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1375?usp=3Demail">change 1375</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1375?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia60a393a296f23ac1090d0f2016=
b5682649ed490 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1375 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--NT5eXDGzSTQ=--


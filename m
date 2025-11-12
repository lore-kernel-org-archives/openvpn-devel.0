From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 14:35:40 +0000
References: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <41bb3183ace32cd9c43e5fe881ad93e5e1ddae2a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W/RTb3cyD4w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: drop --opt-verify
 functionality
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

--W/RTb3cyD4w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail

to review the following change.


Change subject: drop --opt-verify functionality
......................................................................

drop --opt-verify functionality

As previously agreed, the --opt-verify directive is deprecated
and can be fully removed as of 2.7.0.

GitHub: closes OpenVPN/openvpn#901
Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/options.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
3 files changed, 1 insertion(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1375/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ecf9374..9308bc3 100644
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
@@ -7447,13 +7444,6 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->ssl_flags |=3D SSLF_AUTH_USER_PASS_OPTIONAL;
     }
-    else if (streq(p[0], "opt-verify") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        msg(M_INFO, "DEPRECATION: opt-verify is deprecated and will be rem=
oved "
-                    "in OpenVPN 2.7");
-        options->ssl_flags |=3D SSLF_OPT_VERIFY;
-    }
     else if (streq(p[0], "auth-user-pass-verify") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SCRIPT);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 398c9ae..2f08c43 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2343,13 +2343,6 @@
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
index de89d30..4c8efd5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -425,7 +425,7 @@
 #define SSLF_CLIENT_CERT_OPTIONAL     (1u << 1)
 #define SSLF_USERNAME_AS_COMMON_NAME  (1u << 2)
 #define SSLF_AUTH_USER_PASS_OPTIONAL  (1u << 3)
-#define SSLF_OPT_VERIFY               (1u << 4)
+/* (1u << 4) OPT_VERIFY removed in 2.7, bit can be reused */
 #define SSLF_CRL_VERIFY_DIR           (1u << 5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
 #define SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to 9) =
*/

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Gerrit-Change-Number: 1375
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--W/RTb3cyD4w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ordex would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">drop --opt-verify functionality<br><br>As p=
reviously agreed, the --opt-verify directive is deprecated<br>and can be fu=
lly removed as of 2.7.0.<br><br>GitHub: closes OpenVPN/openvpn#901<br>Chang=
e-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490<br>Signed-off-by: Antonio Q=
uartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/options.c<br>M =
src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>3 files changed, 1 inser=
tion(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/75/1375/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index ecf9374..9308=
bc3 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -472,8 +472,6 @@</span><br><span=
>     &quot;                  OTP based two-factor auth mechanisms are in u=
se and\n&quot;</span><br><span>     &quot;                  --reneg-* optio=
ns are enabled. Optionally a lifetime in seconds\n&quot;</span><br><span>  =
   &quot;                  for generated tokens can be set.\n&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--opt-verify    : (=
DEPRECATED) Clients that connect with options that are incompatible\n&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;           =
       with those of the server will be disconnected.\n&quot;</span><br><sp=
an>     &quot;--auth-user-pass-optional : Allow connections by clients that=
 don&#39;t\n&quot;</span><br><span>     &quot;                  specify a u=
sername/password.\n&quot;</span><br><span>     &quot;--no-name-remapping : =
(DEPRECATED) Allow Common Name and X509 Subject to include\n&quot;</span><b=
r><span>@@ -2666,7 +2664,6 @@</span><br><span>                       &quot;=
verify-client-cert&quot;);</span><br><span>         MUST_BE_FALSE(options-&=
gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME, &quot;username-as-common-n=
ame&quot;);</span><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags &a=
mp; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;auth-user-pass-optional&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_FALSE(opt=
ions-&gt;ssl_flags &amp; SSLF_OPT_VERIFY, &quot;opt-verify&quot;);</span><b=
r><span>         if (options-&gt;server_flags &amp; SF_TCP_NODELAY_HELPER)<=
/span><br><span>         {</span><br><span>             msg(M_WARN, &quot;W=
ARNING: setting tcp-nodelay on the client side will not &quot;</span><br><s=
pan>@@ -7447,13 +7444,6 @@</span><br><span>         VERIFY_PERMISSION(OPT_P=
_GENERAL);</span><br><span>         options-&gt;ssl_flags |=3D SSLF_AUTH_US=
ER_PASS_OPTIONAL;</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (streq(p[0], &quot;opt-verify&quot;) &amp;&a=
mp; !p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(O=
PT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_INFO, &quot;DEPRECATION: opt-verify is deprecated and will be remove=
d &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       &quot;in OpenVPN 2.7&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        options-&gt;ssl_flags |=3D SSLF_OPT_VERIFY;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else=
 if (streq(p[0], &quot;auth-user-pass-verify&quot;) &amp;&amp; p[1])</span>=
<br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_SCRIPT);<=
/span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><b=
r><span>index 398c9ae..2f08c43 100644</span><br><span>--- a/src/openvpn/ssl=
.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2343,13 +234=
3,6 @@</span><br><span> #endif</span><br><span> </span><br><span>         o=
ptions_warning(options, remote_options);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (session-&gt;opt-&gt;ssl_flags &amp; SSLF_OPT_VERIFY)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                &quot;Option inconsist=
ency warnings triggering disconnect due to --opt-verify&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;authenticated =
=3D KS_AUTH_FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span>     }</span><br><span> </span><br><span>     buf_cl=
ear(buf);</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openv=
pn/ssl_common.h</span><br><span>index de89d30..4c8efd5 100644</span><br><sp=
an>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_com=
mon.h</span><br><span>@@ -425,7 +425,7 @@</span><br><span> #define SSLF_CLI=
ENT_CERT_OPTIONAL     (1u &lt;&lt; 1)</span><br><span> #define SSLF_USERNAM=
E_AS_COMMON_NAME  (1u &lt;&lt; 2)</span><br><span> #define SSLF_AUTH_USER_P=
ASS_OPTIONAL  (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define SSLF_OPT_VERIFY               (1u &lt;&lt; 4)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* (1u &lt;&lt; 4) OPT_VERIFY rem=
oved in 2.7, bit can be reused */</span><br><span> #define SSLF_CRL_VERIFY_=
DIR           (1u &lt;&lt; 5)</span><br><span> #define SSLF_TLS_VERSION_MIN=
_SHIFT    6</span><br><span> #define SSLF_TLS_VERSION_MIN_MASK     0xFu /* =
(uses bit positions 6 to 9) */</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail">c=
hange 1375</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1375?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia60a393a296f23ac1090d0f2016=
b5682649ed490 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1375 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--W/RTb3cyD4w=--


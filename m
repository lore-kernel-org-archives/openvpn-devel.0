From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Jan 2025 12:12:34 +0000
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <232dbf2b8e18146cc35b60c0f93f1c9b4d022ef6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YK7hz0ZI1lg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement
 override-user
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

--YK7hz0ZI1lg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail

to review the following change.


Change subject: Implement override-user
......................................................................

Implement override-user

Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M src/openvpn/auth_token.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/push.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
11 files changed, 126 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/1

diff --git a/Changes.rst b/Changes.rst
index 16ae6fc..d7def7c 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -36,6 +36,10 @@
     add an allowed cipher without having to spell out the default ciphers.


+Allow overriding username with ``--override-username``
+    This is intended to allow using auth-gen-token in scenarios where the
+    client use certificates and multi-factor authentication.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 3fe9862..2b2c262 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -670,6 +670,31 @@
   AND the ``--auth-user-pass-verify`` script will need to succeed in order
   for a client to be authenticated and accepted onto the VPN.

+--override-username
+  Sets the username of a connection the specified username.  This username
+  will also be used by the by ``--auth-gen-token``. However, the overridden
+  username comes only into effect *after* the ``--client-connect``,
+  ``--client-config-dir`` and the ``--auth-user-pass-verify`` script have
+  been run.
+
+  Also ``username-as-common-name`` will use the client provided username
+  as common-name. It is recommended to avoid the use of the
+  ``--override-username`` option if  the option ``username-as-common-name``
+  is being used.
+
+  The changed username will be picked up by the status output and also by
+  the the ``--auth-gen-token`` option. It will also be pushed to the client
+  using ``--auth-token-user``.
+
+  Special care has to be taken that the initial username of the client is
+  correctly handled with these options to avoid authentication/authorisati=
on
+  bypasses.
+
+  This option is mainly intended for use cases that use certificates and
+  multi factor authentication and therefore do not provide a username that
+  can be used for ``--auth-gen-token`` to allow providing a username in
+  these scenarios.
+
 --vlan-tagging
   Server-only option. Turns the OpenVPN server instance into a switch that
   understands VLAN-tagging, based on IEEE 802.1Q.
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 3cf55e8..312474c 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -330,10 +330,19 @@
     timestamp_initial =3D ntohll(timestamp_initial);

     hmac_ctx_t *ctx =3D multi->opt.auth_token_key.hmac;
+
     if (check_hmac_token(ctx, b64decoded, up->username))
     {
         ret |=3D AUTH_TOKEN_HMAC_OK;
     }
+    else if (multi->locked_original_username && multi->locked_username
+             && check_hmac_token(ctx, b64decoded, multi->locked_username))
+    {
+        /* if the username has been overridden, check with the overridden
+         * username and ignore the sent username in case the client does n=
ot
+         * support auth-token-user */
+        ret |=3D AUTH_TOKEN_HMAC_OK;
+    }
     else if (check_hmac_token(ctx, b64decoded, ""))
     {
         ret |=3D AUTH_TOKEN_HMAC_OK;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f426b46..03e6b6e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -42,7 +42,9 @@
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
 #include "vlan.h"
+#include "auth_token.h"
 #include <inttypes.h>
+#include <string.h>

 #include "memdbg.h"

@@ -2663,6 +2665,41 @@
     NULL,
 };

+/**
+ *
+ * @param mi
+ */
+static void
+override_locked_username(struct multi_instance *mi)
+{
+    struct tls_multi *multi =3D mi->context.c2.tls_multi;
+
+    struct options *options =3D &mi->context.options;
+
+    if (!multi->locked_original_username
+        && strcmp(multi->locked_username, options->override_username) !=3D=
 0)
+    {
+        multi->locked_original_username =3D multi->locked_username;
+        multi->locked_username =3D strdup(options->override_username);
+
+        /* Regenerate the auth-token if enabled */
+        if (multi->auth_token_initial)
+        {
+            struct user_pass up;
+            CLEAR(up);
+            strncpynt(up.username, multi->locked_username,
+                      sizeof(up.username));
+
+            generate_auth_token(&up, multi);
+        }
+
+        msg(D_MULTI_LOW, "MULTI: Note, override-username changes username "
+            "from '%s' to '%s'",
+            multi->locked_original_username,
+            multi->locked_username);
+
+    }
+}
 /*
  * Called as soon as the SSL/TLS connection is authenticated.
  *
@@ -2766,6 +2803,11 @@
         (*cur_handler_index)++;
     }

+    if (mi->context.options.override_username)
+    {
+        override_locked_username(mi);
+    }
+
     /* Check if we have forbidding options in the current mode */
     if (dco_enabled(&mi->context.options)
         && !dco_check_option(D_MULTI_ERRORS, &mi->context.options))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ef4d78..bf966f3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7847,6 +7847,23 @@
         VERIFY_PERMISSION(OPT_P_INSTANCE);
         options->disable =3D true;
     }
+    else if (streq(p[0], "override-username") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+        if (strlen(p[1]) > TLS_USERNAME_LEN)
+        {
+            msg(msglevel, "override-username exceeds the maximum length of=
 %d "
+                "characters", TLS_USERNAME_LEN);
+
+            /* disable the connection since ignoring the request to
+             * set another username might serious problems */
+            options->disable =3D true;
+        }
+        else
+        {
+            options->override_username =3D p[1];
+        }
+    }
     else if (streq(p[0], "tcp-nodelay") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 55f12dd..274f282 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -492,6 +492,7 @@
     const char *client_config_dir;
     bool ccd_exclusive;
     bool disable;
+    const char *override_username;
     int n_bcast_buf;
     int tcp_queue_limit;
     struct iroute *iroutes;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a7cd3bf..5ccd7d8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -595,9 +595,19 @@
      */
     if (tls_multi->auth_token)
     {
-        push_option_fmt(gc, push_list, M_USAGE,
-                        "auth-token %s",
+        push_option_fmt(gc, push_list, M_USAGE, "auth-token %s",
                         tls_multi->auth_token);
+
+        char *base64user;
+        int ret =3D openvpn_base64_encode(tls_multi->locked_username,
+                                        (int)strlen(tls_multi->locked_user=
name),
+                                        &base64user);
+        if (ret < USER_PASS_LEN && ret > 0)
+        {
+            push_option_fmt(gc, push_list, M_USAGE, "auth-token-user %s",
+                            base64user);
+        }
+        free(base64user);
     }
 }

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4a7b57..e548299 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1260,6 +1260,7 @@
     free(multi->peer_info);
     free(multi->locked_cn);
     free(multi->locked_username);
+    free(multi->locked_original_username);

     cert_hash_free(multi->locked_cert_hash_set);

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e092472..79d0575 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -625,7 +625,15 @@
      * Our locked common name, username, and cert hashes (cannot change du=
ring the life of this tls_multi object)
      */
     char *locked_cn;
+
+    /** The locked username is the username that the client used for initi=
al
+     * authentication */
     char *locked_username;
+
+    /** The username that client initial used before being overrriden by
+     * by override-user */
+    char *locked_original_username;
+
     struct cert_hash_set *locked_cert_hash_set;
=20
     /** Time of last when we updated the cached state of
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e7d7ed6..158fe19 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -48,9 +48,6 @@
 #include "push.h"
 #include "ssl_util.h"

-/** Maximum length of common name */
-#define TLS_USERNAME_LEN 64
-
 static void
 string_mod_remap_name(char *str)
 {
@@ -153,7 +150,10 @@
 {
     if (multi->locked_username)
     {
-        if (strcmp(username, multi->locked_username) !=3D 0)
+        /* If the username has been overridden, we accept both the original
+         * username and the changed username */
+        if (strcmp(username, multi->locked_username) !=3D 0
+            &&  (!multi->locked_original_username || strcmp(username, mult=
i->locked_original_username) !=3D 0))
         {
             msg(D_TLS_ERRORS, "TLS Auth Error: username attempted to chang=
e from '%s' to '%s' -- tunnel disabled",
                 multi->locked_username,
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index cd2ec24..77e814a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -51,6 +51,9 @@
 /** Maximum certificate depth we will allow */
 #define MAX_CERT_DEPTH 16

+/** Maximum length of common name */
+#define TLS_USERNAME_LEN 64
+
 /** Structure containing the hash for a single certificate */
 struct cert_hash {
     unsigned char sha256_hash[256/8];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Gerrit-Change-Number: 872
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--YK7hz0ZI1lg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement override-user<br><br>Change-Id: Ia4095518d5e4447992=
a2974e0d7a159d79ba6b6f<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&g=
t;<br>---<br>M Changes.rst<br>M doc/man-sections/server-options.rst<br>M sr=
c/openvpn/auth_token.c<br>M src/openvpn/multi.c<br>M src/openvpn/options.c<=
br>M src/openvpn/options.h<br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<b=
r>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn=
/ssl_verify.h<br>11 files changed, 126 insertions(+), 6 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 16ae6fc=
..d7def7c 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Ch=
anges.rst</span><br><span>@@ -36,6 +36,10 @@</span><br><span>     add an al=
lowed cipher without having to spell out the default ciphers.</span><br><sp=
an> </span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Allow overriding username with ``--override-username``</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    This is intended to allow using a=
uth-gen-token in scenarios where the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    client use certificates and multi-factor authenticatio=
n.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 Deprecated features</span><br><span> -------------------</span><br><span> =
``secret`` support has been removed by default.</span><br><span>diff --git =
a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst=
</span><br><span>index 3fe9862..2b2c262 100644</span><br><span>--- a/doc/ma=
n-sections/server-options.rst</span><br><span>+++ b/doc/man-sections/server=
-options.rst</span><br><span>@@ -670,6 +670,31 @@</span><br><span>   AND th=
e ``--auth-user-pass-verify`` script will need to succeed in order</span><b=
r><span>   for a client to be authenticated and accepted onto the VPN.</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--over=
ride-username</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets=
 the username of a connection the specified username.  This username</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  will also be used by the=
 by ``--auth-gen-token``. However, the overridden</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  username comes only into effect *after* the=
 ``--client-connect``,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  ``--client-config-dir`` and the ``--auth-user-pass-verify`` script hav=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  been run.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  Also ``username-as-common-name`` will use t=
he client provided username</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  as common-name. It is recommended to avoid the use of the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--override-username`` o=
ption if  the option ``username-as-common-name``</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  is being used.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  The changed username will be picked up by the status output and al=
so by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the the ``--=
auth-gen-token`` option. It will also be pushed to the client</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  using ``--auth-token-user``.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Special care has to be taken that the i=
nitial username of the client is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  correctly handled with these options to avoid authentication=
/authorisation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  byp=
asses.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  This option is mainly intended=
 for use cases that use certificates and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  multi factor authentication and therefore do not pro=
vide a username that</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  can be used for ``--auth-gen-token`` to allow providing a username in</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  these scenarios.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --vla=
n-tagging</span><br><span>   Server-only option. Turns the OpenVPN server i=
nstance into a switch that</span><br><span>   understands VLAN-tagging, bas=
ed on IEEE 802.1Q.</span><br><span>diff --git a/src/openvpn/auth_token.c b/=
src/openvpn/auth_token.c</span><br><span>index 3cf55e8..312474c 100644</spa=
n><br><span>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src/openvp=
n/auth_token.c</span><br><span>@@ -330,10 +330,19 @@</span><br><span>     t=
imestamp_initial =3D ntohll(timestamp_initial);</span><br><span> </span><br=
><span>     hmac_ctx_t *ctx =3D multi-&gt;opt.auth_token_key.hmac;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (ch=
eck_hmac_token(ctx, b64decoded, up-&gt;username))</span><br><span>     {</s=
pan><br><span>         ret |=3D AUTH_TOKEN_HMAC_OK;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (multi-&=
gt;locked_original_username &amp;&amp; multi-&gt;locked_username</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; check_=
hmac_token(ctx, b64decoded, multi-&gt;locked_username))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* if the username has been overridden, check=
 with the overridden</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * username and ignore the sent username in case the client does n=
ot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * suppor=
t auth-token-user */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ret |=3D AUTH_TOKEN_HMAC_OK;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span>     else if (check_hmac_token(ctx,=
 b64decoded, &quot;&quot;))</span><br><span>     {</span><br><span>        =
 ret |=3D AUTH_TOKEN_HMAC_OK;</span><br><span>diff --git a/src/openvpn/mult=
i.c b/src/openvpn/multi.c</span><br><span>index f426b46..03e6b6e 100644</sp=
an><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mu=
lti.c</span><br><span>@@ -42,7 +42,9 @@</span><br><span> #include &quot;ssl=
_verify.h&quot;</span><br><span> #include &quot;ssl_ncp.h&quot;</span><br><=
span> #include &quot;vlan.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;auth_token.h&quot;</span><br><span> #include &=
lt;inttypes.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;string.h&gt;</span><br><span> </span><br><span> #include &quot;m=
emdbg.h&quot;</span><br><span> </span><br><span>@@ -2663,6 +2665,41 @@</spa=
n><br><span>     NULL,</span><br><span> };</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param mi</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+override_locked_usernam=
e(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_multi *multi =3D mi-&gt;context.c2.tls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct options *options =3D &amp;mi-&gt;context.options;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;locked_original_use=
rname</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&=
amp; strcmp(multi-&gt;locked_username, options-&gt;override_username) !=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locked_origin=
al_username =3D multi-&gt;locked_username;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        multi-&gt;locked_username =3D strdup(options=
-&gt;override_username);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Reg=
enerate the auth-token if enabled */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (multi-&gt;auth_token_initial)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            struct user_pass up;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(up);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            strncpynt(up.usern=
ame, multi-&gt;locked_username,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                      sizeof(up.username));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            generate_auth_token(&amp;up, multi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;MULTI: Note, override-usern=
ame changes username &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;from &#39;%s&#39; to &#39;%s&#39;&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;locked=
_original_username,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi-&gt;locked_username);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span> /*</span><br><span>  * Called as soon as the SSL/TLS connection is au=
thenticated.</span><br><span>  *</span><br><span>@@ -2766,6 +2803,11 @@</sp=
an><br><span>         (*cur_handler_index)++;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
mi-&gt;context.options.override_username)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        override_locked_username(mi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     /* Check if we have forbidding options in=
 the current mode */</span><br><span>     if (dco_enabled(&amp;mi-&gt;conte=
xt.options)</span><br><span>         &amp;&amp; !dco_check_option(D_MULTI_E=
RRORS, &amp;mi-&gt;context.options))</span><br><span>diff --git a/src/openv=
pn/options.c b/src/openvpn/options.c</span><br><span>index 3ef4d78..bf966f3=
 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/s=
rc/openvpn/options.c</span><br><span>@@ -7847,6 +7847,23 @@</span><br><span=
>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>         optio=
ns-&gt;disable =3D true;</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;override-usernam=
e&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (strlen(p[1]) &gt; TLS_USERNAM=
E_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgleve=
l, &quot;override-username exceeds the maximum length of %d &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;charac=
ters&quot;, TLS_USERNAME_LEN);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* disable the connection since ignoring the request to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * set another username=
 might serious problems */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            options-&gt;disable =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            options-&gt;override_username =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &qu=
ot;tcp-nodelay&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><s=
pan>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a=
/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 55f12d=
d..274f282 100644</span><br><span>--- a/src/openvpn/options.h</span><br><sp=
an>+++ b/src/openvpn/options.h</span><br><span>@@ -492,6 +492,7 @@</span><b=
r><span>     const char *client_config_dir;</span><br><span>     bool ccd_e=
xclusive;</span><br><span>     bool disable;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *override_username;</span><br><span=
>     int n_bcast_buf;</span><br><span>     int tcp_queue_limit;</span><br>=
<span>     struct iroute *iroutes;</span><br><span>diff --git a/src/openvpn=
/push.c b/src/openvpn/push.c</span><br><span>index a7cd3bf..5ccd7d8 100644<=
/span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/=
push.c</span><br><span>@@ -595,9 +595,19 @@</span><br><span>      */</span>=
<br><span>     if (tls_multi-&gt;auth_token)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        push_option_fmt(gc, p=
ush_list, M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     &quot;auth-token %s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE,=
 &quot;auth-token %s&quot;,</span><br><span>                         tls_mu=
lti-&gt;auth_token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *base=
64user;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int =
ret =3D openvpn_base64_encode(tls_multi-&gt;locked_username,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
      (int)strlen(tls_multi-&gt;locked_username),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                        &amp;=
base64user);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (ret &lt; USER_PASS_LEN &amp;&amp; ret &gt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            push_option_fmt(gc, push_list, M_USAGE, &q=
uot;auth-token-user %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            base64user);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        free(base64user);</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/ss=
l.c b/src/openvpn/ssl.c</span><br><span>index e4a7b57..e548299 100644</span=
><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c<=
/span><br><span>@@ -1260,6 +1260,7 @@</span><br><span>     free(multi-&gt;p=
eer_info);</span><br><span>     free(multi-&gt;locked_cn);</span><br><span>=
     free(multi-&gt;locked_username);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    free(multi-&gt;locked_original_username);</span><br><=
span> </span><br><span>     cert_hash_free(multi-&gt;locked_cert_hash_set);=
</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_common.h b/=
src/openvpn/ssl_common.h</span><br><span>index e092472..79d0575 100644</spa=
n><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvp=
n/ssl_common.h</span><br><span>@@ -625,7 +625,15 @@</span><br><span>      *=
 Our locked common name, username, and cert hashes (cannot change during th=
e life of this tls_multi object)</span><br><span>      */</span><br><span> =
    char *locked_cn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The locked=
 username is the username that the client used for initial</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * authentication */</span><br><=
span>     char *locked_username;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
* The username that client initial used before being overrriden by</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * by override-user */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *locked_orig=
inal_username;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     struct cert_hash_set *locked_cert_hash_set;</span><br><spa=
n> </span><br><span>     /** Time of last when we updated the cached state =
of</span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_=
verify.c</span><br><span>index e7d7ed6..158fe19 100644</span><br><span>--- =
a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</=
span><br><span>@@ -48,9 +48,6 @@</span><br><span> #include &quot;push.h&quo=
t;</span><br><span> #include &quot;ssl_util.h&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Maximum length of commo=
n name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TLS_=
USERNAME_LEN 64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static void</span><br><span> string_mod_remap_name(char *str)</=
span><br><span> {</span><br><span>@@ -153,7 +150,10 @@</span><br><span> {</=
span><br><span>     if (multi-&gt;locked_username)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strcmp(user=
name, multi-&gt;locked_username) !=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* If the username has been overridden, we acc=
ept both the original</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * username and the changed username */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (strcmp(username, multi-&gt;locked=
_username) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &amp;&amp;  (!multi-&gt;locked_original_username || strcmp(userna=
me, multi-&gt;locked_original_username) !=3D 0))</span><br><span>         {=
</span><br><span>             msg(D_TLS_ERRORS, &quot;TLS Auth Error: usern=
ame attempted to change from &#39;%s&#39; to &#39;%s&#39; -- tunnel disable=
d&quot;,</span><br><span>                 multi-&gt;locked_username,</span>=
<br><span>diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h<=
/span><br><span>index cd2ec24..77e814a 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify.h</span><br><span>+++ b/src/openvpn/ssl_verify.h</span><br>=
<span>@@ -51,6 +51,9 @@</span><br><span> /** Maximum certificate depth we w=
ill allow */</span><br><span> #define MAX_CERT_DEPTH 16</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum length of=
 common name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine TLS_USERNAME_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /** Structure containing the hash for a single certif=
icate */</span><br><span> struct cert_hash {</span><br><span>     unsigned =
char sha256_hash[256/8];</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">change 8=
72</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
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


--YK7hz0ZI1lg=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Jan 2025 13:24:46 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0e911732c95a9affd2cb12f544ce8fbae7937d58-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vmkMZMwsXQk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement
 override-username
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

--vmkMZMwsXQk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Implement override-username
......................................................................

Implement override-username

This is intended to allow using auth-gen-token in scenarios where the
client use certificates and multi-factor authentication.

It allows a client to successfully roam to a different server and have
a correct username and auth-token that can be accepted by that server as
fully authenticated user without requiring MFA again.

The scenario that this feature is probably most useful
when --management-client-auth is in use as in this mode the OpenVPN
server can accept clients without username/password but still use
--auth-gen-token with username and password to accept auth-token as
alternative authentication.

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
11 files changed, 132 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/2

diff --git a/Changes.rst b/Changes.rst
index 16ae6fc..8543113 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -36,6 +36,10 @@
     add an allowed cipher without having to spell out the default ciphers.


+Allow overriding username with ``--override-username``
+    This is intended to allow using auth-gen-token in scenarios where the
+    clients use certificates and multi-factor authentication.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 3fe9862..79b1bfa 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -89,6 +89,9 @@
   will lead to authentication bypass (as does returning success on a wrong
   password from a script).

+  **Note:** the username for ``--auth-gen-token`` can be overridden by
+  ``--override-user``.
+
 --auth-gen-token-secret file
   Specifies a file that holds a secret for the HMAC used in
   ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a
@@ -412,6 +415,31 @@

   This option requires that ``--disable-occ`` NOT be used.

+--override-username
+  Sets the username of a connection to the specified username.  This usern=
ame
+  will also be used by ``--auth-gen-token``. However, the overridden
+  username comes only into effect *after* the ``--client-config-dir`` has =
been
+  read and the ``--auth-user-pass-verify`` and ``--client-connect`` scripts
+  have been run.
+
+  Also ``username-as-common-name`` will use the client provided username
+  as common-name. It is recommended to avoid the use of the
+  ``--override-username`` option if  the option ``--username-as-common-nam=
e``
+  is being used.
+
+  The changed username will be picked up by the status output and also by
+  the ``--auth-gen-token`` option. It will also be pushed to the client
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
 --port-share args
   Share OpenVPN TCP with another service

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
index f426b46..5d464e0 100644
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
+ * Overrides the locked username with the username of --override-username
+ * @param mi the multi instance that should be modified.
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
index 3ef4d78..93b8417 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -440,6 +440,8 @@
     "                  Only valid in a client-specific config file.\n"
     "--disable       : Client is disabled.\n"
     "                  Only valid in a client-specific config file.\n"
+    "--override-username: Overrides the client-specific username to be use=
d.\n"
+    "                  Only valid in a client-specific config file.\n"
     "--verify-client-cert [none|optional|require] : perform no, optional o=
r\n"
     "                  mandatory client certificate verification.\n"
     "                  Default is to require the client to supply a certif=
icate.\n"
@@ -7847,6 +7849,23 @@
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
+             * set another username might cause serious problems */
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
index e092472..2efeb6a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -625,7 +625,16 @@
      * Our locked common name, username, and cert hashes (cannot change du=
ring the life of this tls_multi object)
      */
     char *locked_cn;
+
+    /** The locked username is the username we assume the client is using.
+     * Normally the username used for initial authentication unless
+     * overridden by --override-username */
     char *locked_username;
+
+    /** The username that client initially used before being overridden
+     * by --override-user */
+    char *locked_original_username;
+
     struct cert_hash_set *locked_cert_hash_set;

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--vmkMZMwsXQk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement override-username<br><br>This is in=
tended to allow using auth-gen-token in scenarios where the<br>client use c=
ertificates and multi-factor authentication.<br><br>It allows a client to s=
uccessfully roam to a different server and have<br>a correct username and a=
uth-token that can be accepted by that server as<br>fully authenticated use=
r without requiring MFA again.<br><br>The scenario that this feature is pro=
bably most useful<br>when --management-client-auth is in use as in this mod=
e the OpenVPN<br>server can accept clients without username/password but st=
ill use<br>--auth-gen-token with username and password to accept auth-token=
 as<br>alternative authentication.<br><br>Change-Id: Ia4095518d5e4447992a29=
74e0d7a159d79ba6b6f<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<=
br>---<br>M Changes.rst<br>M doc/man-sections/server-options.rst<br>M src/o=
penvpn/auth_token.c<br>M src/openvpn/multi.c<br>M src/openvpn/options.c<br>=
M src/openvpn/options.h<br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<br>M=
 src/openvpn/ssl_common.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ss=
l_verify.h<br>11 files changed, 132 insertions(+), 6 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 16ae6fc..8=
543113 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Chang=
es.rst</span><br><span>@@ -36,6 +36,10 @@</span><br><span>     add an allow=
ed cipher without having to spell out the default ciphers.</span><br><span>=
 </span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Allow overriding username with ``--override-username``</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    This is intended to allow using auth=
-gen-token in scenarios where the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    clients use certificates and multi-factor authentication.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> D=
eprecated features</span><br><span> -------------------</span><br><span> ``=
secret`` support has been removed by default.</span><br><span>diff --git a/=
doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst</=
span><br><span>index 3fe9862..79b1bfa 100644</span><br><span>--- a/doc/man-=
sections/server-options.rst</span><br><span>+++ b/doc/man-sections/server-o=
ptions.rst</span><br><span>@@ -89,6 +89,9 @@</span><br><span>   will lead t=
o authentication bypass (as does returning success on a wrong</span><br><sp=
an>   password from a script).</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  **Note:** the username for ``--auth-gen-toke=
n`` can be overridden by</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  ``--override-user``.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> --auth-gen-token-secret file</span><br><span>   S=
pecifies a file that holds a secret for the HMAC used in</span><br><span>  =
 ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a</s=
pan><br><span>@@ -412,6 +415,31 @@</span><br><span> </span><br><span>   Thi=
s option requires that ``--disable-occ`` NOT be used.</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+--override-username</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the username of =
a connection to the specified username.  This username</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  will also be used by ``--auth-gen-toke=
n``. However, the overridden</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  username comes only into effect *after* the ``--client-config-di=
r`` has been</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  read =
and the ``--auth-user-pass-verify`` and ``--client-connect`` scripts</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  have been run.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Also ``username-as-common-name`` will use the =
client provided username</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  as common-name. It is recommended to avoid the use of the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  ``--override-username`` opti=
on if  the option ``--username-as-common-name``</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  is being used.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  The changed username will be picked up by the status output and als=
o by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the ``--auth-=
gen-token`` option. It will also be pushed to the client</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  using ``--auth-token-user``.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  Special care has to be taken that the initia=
l username of the client is</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  correctly handled with these options to avoid authentication/auth=
orisation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  bypasses=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  This option is mainly intended for =
use cases that use certificates and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  multi factor authentication and therefore do not provide =
a username that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ca=
n be used for ``--auth-gen-token`` to allow providing a username in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  these scenarios.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --port-sha=
re args</span><br><span>   Share OpenVPN TCP with another service</span><br=
><span> </span><br><span>diff --git a/src/openvpn/auth_token.c b/src/openvp=
n/auth_token.c</span><br><span>index 3cf55e8..312474c 100644</span><br><spa=
n>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src/openvpn/auth_tok=
en.c</span><br><span>@@ -330,10 +330,19 @@</span><br><span>     timestamp_i=
nitial =3D ntohll(timestamp_initial);</span><br><span> </span><br><span>   =
  hmac_ctx_t *ctx =3D multi-&gt;opt.auth_token_key.hmac;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (check_hmac_t=
oken(ctx, b64decoded, up-&gt;username))</span><br><span>     {</span><br><s=
pan>         ret |=3D AUTH_TOKEN_HMAC_OK;</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (multi-&gt;locked_=
original_username &amp;&amp; multi-&gt;locked_username</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; check_hmac_token=
(ctx, b64decoded, multi-&gt;locked_username))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* if the username has been overridden, check with the =
overridden</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* username and ignore the sent username in case the client does not</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * support auth-tok=
en-user */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
et |=3D AUTH_TOKEN_HMAC_OK;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     else if (check_hmac_token(ctx, b64decode=
d, &quot;&quot;))</span><br><span>     {</span><br><span>         ret |=3D =
AUTH_TOKEN_HMAC_OK;</span><br><span>diff --git a/src/openvpn/multi.c b/src/=
openvpn/multi.c</span><br><span>index f426b46..5d464e0 100644</span><br><sp=
an>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</spa=
n><br><span>@@ -42,7 +42,9 @@</span><br><span> #include &quot;ssl_verify.h&=
quot;</span><br><span> #include &quot;ssl_ncp.h&quot;</span><br><span> #inc=
lude &quot;vlan.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;auth_token.h&quot;</span><br><span> #include &lt;inttype=
s.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt=
;string.h&gt;</span><br><span> </span><br><span> #include &quot;memdbg.h&qu=
ot;</span><br><span> </span><br><span>@@ -2663,6 +2665,41 @@</span><br><spa=
n>     NULL,</span><br><span> };</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Overrides the locked username with the username of --over=
ride-username</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram mi the multi instance that should be modified.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+override_locked_username(struct multi_instance *mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct tls_multi *multi =3D mi-&gt;context.c2.tls_=
multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct options *options =3D =
&amp;mi-&gt;context.options;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
ulti-&gt;locked_original_username</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &amp;&amp; strcmp(multi-&gt;locked_username, options-=
&gt;override_username) !=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     multi-&gt;locked_original_username =3D multi-&gt;locked_username;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locked=
_username =3D strdup(options-&gt;override_username);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* Regenerate the auth-token if enabled */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;auth_to=
ken_initial)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struc=
t user_pass up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        CLEAR(up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           strncpynt(up.username, multi-&gt;locked_username,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      sizeof(up.us=
ername));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            generate_auth_tok=
en(&amp;up, multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quo=
t;MULTI: Note, override-username changes username &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;from &#39;%s&#39; to=
 &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            multi-&gt;locked_original_username,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            multi-&gt;locked_username);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span> /*</span><br><span>  * Called as soon as=
 the SSL/TLS connection is authenticated.</span><br><span>  *</span><br><sp=
an>@@ -2766,6 +2803,11 @@</span><br><span>         (*cur_handler_index)++;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (mi-&gt;context.options.override_username)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        override_locked_username(mi);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Check if =
we have forbidding options in the current mode */</span><br><span>     if (=
dco_enabled(&amp;mi-&gt;context.options)</span><br><span>         &amp;&amp=
; !dco_check_option(D_MULTI_ERRORS, &amp;mi-&gt;context.options))</span><br=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index 3ef4d78..93b8417 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -440,6=
 +440,8 @@</span><br><span>     &quot;                  Only valid in a cli=
ent-specific config file.\n&quot;</span><br><span>     &quot;--disable     =
  : Client is disabled.\n&quot;</span><br><span>     &quot;                =
  Only valid in a client-specific config file.\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;--override-username: Overrides=
 the client-specific username to be used.\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;                  Only valid in a c=
lient-specific config file.\n&quot;</span><br><span>     &quot;--verify-cli=
ent-cert [none|optional|require] : perform no, optional or\n&quot;</span><b=
r><span>     &quot;                  mandatory client certificate verificat=
ion.\n&quot;</span><br><span>     &quot;                  Default is to req=
uire the client to supply a certificate.\n&quot;</span><br><span>@@ -7847,6=
 +7849,23 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</s=
pan><br><span>         options-&gt;disable =3D true;</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;override-username&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_INSTAN=
CE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str=
len(p[1]) &gt; TLS_USERNAME_LEN)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(msglevel, &quot;override-username exceeds the maximum le=
ngth of %d &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              &quot;characters&quot;, TLS_USERNAME_LEN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* disable the connection since ignoring the =
request to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    * set another username might cause serious problems */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;disable =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;override_username=
 =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an>     else if (streq(p[0], &quot;tcp-nodelay&quot;) &amp;&amp; !p[1])</sp=
an><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERA=
L);</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/option=
s.h</span><br><span>index 55f12dd..274f282 100644</span><br><span>--- a/src=
/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><s=
pan>@@ -492,6 +492,7 @@</span><br><span>     const char *client_config_dir;=
</span><br><span>     bool ccd_exclusive;</span><br><span>     bool disable=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ov=
erride_username;</span><br><span>     int n_bcast_buf;</span><br><span>    =
 int tcp_queue_limit;</span><br><span>     struct iroute *iroutes;</span><b=
r><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><spa=
n>index a7cd3bf..5ccd7d8 100644</span><br><span>--- a/src/openvpn/push.c</s=
pan><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -595,9 +595,19 @@=
</span><br><span>      */</span><br><span>     if (tls_multi-&gt;auth_token=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        push_option_fmt(gc, push_list, M_USAGE,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        &quot;auth-token %s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_op=
tion_fmt(gc, push_list, M_USAGE, &quot;auth-token %s&quot;,</span><br><span=
>                         tls_multi-&gt;auth_token);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        char *base64user;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int ret =3D openvpn_base64_encode(tls_multi-&g=
t;locked_username,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                       (int)strlen(tls_multi-&gt;locked_use=
rname),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                            &amp;base64user);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (ret &lt; USER_PASS_LEN &amp;&amp; ret=
 &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push_opti=
on_fmt(gc, push_list, M_USAGE, &quot;auth-token-user %s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            base=
64user);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(base64us=
er);</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>in=
dex e4a7b57..e548299 100644</span><br><span>--- a/src/openvpn/ssl.c</span><=
br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1260,6 +1260,7 @@</spa=
n><br><span>     free(multi-&gt;peer_info);</span><br><span>     free(multi=
-&gt;locked_cn);</span><br><span>     free(multi-&gt;locked_username);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;locke=
d_original_username);</span><br><span> </span><br><span>     cert_hash_free=
(multi-&gt;locked_cert_hash_set);</span><br><span> </span><br><span>diff --=
git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>i=
ndex e092472..2efeb6a 100644</span><br><span>--- a/src/openvpn/ssl_common.h=
</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -625,7 +=
625,16 @@</span><br><span>      * Our locked common name, username, and cer=
t hashes (cannot change during the life of this tls_multi object)</span><br=
><span>      */</span><br><span>     char *locked_cn;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** The locked username is the username we assume the cl=
ient is using.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* Normally the username used for initial authentication unless</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * overridden by --override-=
username */</span><br><span>     char *locked_username;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /** The username that client initially used before bei=
ng overridden</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 by --override-user */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *locked_original_username;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     struct cert_hash_set *locked_cert_=
hash_set;</span><br><span> </span><br><span>     /** Time of last when we u=
pdated the cached state of</span><br><span>diff --git a/src/openvpn/ssl_ver=
ify.c b/src/openvpn/ssl_verify.c</span><br><span>index e7d7ed6..158fe19 100=
644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify.c</span><br><span>@@ -48,9 +48,6 @@</span><br><span> #=
include &quot;push.h&quot;</span><br><span> #include &quot;ssl_util.h&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
 Maximum length of common name */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define TLS_USERNAME_LEN 64</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> static void</span><br><span> string_mod=
_remap_name(char *str)</span><br><span> {</span><br><span>@@ -153,7 +150,10=
 @@</span><br><span> {</span><br><span>     if (multi-&gt;locked_username)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (strcmp(username, multi-&gt;locked_username) !=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* If the username has=
 been overridden, we accept both the original</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * username and the changed username */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(us=
ername, multi-&gt;locked_username) !=3D 0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &amp;&amp;  (!multi-&gt;locked_original_u=
sername || strcmp(username, multi-&gt;locked_original_username) !=3D 0))</s=
pan><br><span>         {</span><br><span>             msg(D_TLS_ERRORS, &qu=
ot;TLS Auth Error: username attempted to change from &#39;%s&#39; to &#39;%=
s&#39; -- tunnel disabled&quot;,</span><br><span>                 multi-&gt=
;locked_username,</span><br><span>diff --git a/src/openvpn/ssl_verify.h b/s=
rc/openvpn/ssl_verify.h</span><br><span>index cd2ec24..77e814a 100644</span=
><br><span>--- a/src/openvpn/ssl_verify.h</span><br><span>+++ b/src/openvpn=
/ssl_verify.h</span><br><span>@@ -51,6 +51,9 @@</span><br><span> /** Maximu=
m certificate depth we will allow */</span><br><span> #define MAX_CERT_DEPT=
H 16</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** Maximum length of common name */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define TLS_USERNAME_LEN 64</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /** Structure containing the =
hash for a single certificate */</span><br><span> struct cert_hash {</span>=
<br><span>     unsigned char sha256_hash[256/8];</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
72?usp=3Demail">change 872</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--vmkMZMwsXQk=--


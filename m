From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 11 Mar 2025 11:08:07 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181..., gert@...1296...
Message-ID: <9678149036e8386d2cfc142ab163a2873ae688b4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R8pweAy5kWo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--R8pweAy5kWo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, ordex, plaisthos=
, stipa.

Hello cron2, d12fk, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail

to look at the new patch set (#9).

The following approvals got outdated and were removed:
Code-Review+2 by d12fk


Change subject: Implement override-username
......................................................................

Implement override-username

This allow the server to set and override the username that is assumed
for the client for interaction with the client after the authentication.

This is especially intended to allow the of use auth-gen-token in
scenarios where the clients use certificates and multi-factor
authentication.

It allows a client to successfully roam to a different server and have
a correct username and auth-token that can be accepted by that server as
fully authenticated user without requiring MFA again.

The scenario that this feature is probably most useful
when --management-client-auth is in use as in this mode the OpenVPN
server can accept clients without username/password but still use
--auth-gen-token with username and password to accept auth-token as
alternative authentication. A client without a username will also not
use the pushed auth-token. So setting/pushing an auth-token-user
will ensure that the client has a username.

Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/push.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
10 files changed, 173 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/9

diff --git a/Changes.rst b/Changes.rst
index e011811..d6a0ba6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -49,6 +49,12 @@
     - IV constructed with XOR instead of concatenation to not have (parts)=
 of
       the real IV on the wire

+Allow overriding username with ``--override-username``
+    This is intended to allow using auth-gen-token in scenarios where the
+    clients use certificates and multi-factor authentication.  This will
+    also generate a 'push "auth-token-user newusername"' directives in
+    push replies.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 3fe9862..e93b04d 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -89,6 +89,12 @@
   will lead to authentication bypass (as does returning success on a wrong
   password from a script).

+  **Note:** the username for ``--auth-gen-token`` can be overridden by
+  ``--override-user``. In this case the client will be pushed also the
+  ``--auth-token-user`` option and an auth token that is valid for that
+  username instead of the original username that the client authenticated
+  with.
+
 --auth-gen-token-secret file
   Specifies a file that holds a secret for the HMAC used in
   ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a
@@ -412,6 +418,32 @@

   This option requires that ``--disable-occ`` NOT be used.

+--override-username username
+  Sets the username of a connection to the specified username.  This usern=
ame
+  will also be used by ``--auth-gen-token``. However, the overridden
+  username comes only into effect *after* the ``--client-config-dir`` has =
been
+  read and the ``--auth-user-pass-verify`` and ``--client-connect`` scripts
+  have been run.
+
+  Also ``--username-as-common-name`` will use the client provided username
+  as common-name. It is recommended to avoid the use of the
+  ``--override-username`` option if the option ``--username-as-common-name=
``
+  is being used.
+
+  The changed username will be picked up by the status output and also by
+  the ``--auth-gen-token`` option. It will also be pushed to the client
+  using ``--auth-token-user``.
+
+  Special care should be taken that both the initial username of the client
+  and the overridden username are handled correctly when using
+  ``--override-username`` and the related options to avoid
+  authentication/authorisation bypasses.
+
+  This option is mainly intended for use cases that use certificates and
+  multi factor authentication and therefore do not provide a username that
+  can be used for ``--auth-gen-token`` to allow providing a username in
+  these scenarios.
+
 --port-share args
   Share OpenVPN TCP with another service

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f76dad8..13874a4 100644
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

@@ -2675,6 +2677,60 @@
     NULL,
 };

+/**
+ * Overrides the locked username with the username of --override-username
+ * @param mi the multi instance that should be modified.
+ */
+static bool
+override_locked_username(struct multi_instance *mi)
+{
+    struct tls_multi *multi =3D mi->context.c2.tls_multi;
+    struct options *options =3D &mi->context.options;
+    struct tls_session *session =3D &multi->session[TM_ACTIVE];
+
+    if (!multi->locked_username)
+    {
+        msg(D_MULTI_ERRORS, "MULTI: Ignoring override-username as no "
+            "user/password method is enabled. Enable "
+            "--management-client-auth, --auth-user-pass-verify, or a "
+            "plugin with user/password verify capability.");
+        return false;
+    }
+
+    if (!multi->locked_original_username
+        && strcmp(multi->locked_username, options->override_username) !=3D=
 0)
+    {
+        multi->locked_original_username =3D multi->locked_username;
+        multi->locked_username =3D strdup(options->override_username);
+
+        /* Override also the common name if username should be set as comm=
on
+         * name */
+        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
+        {
+            set_common_name(session, multi->locked_username);
+            free(multi->locked_cn);
+            multi->locked_cn =3D NULL;
+            tls_lock_common_name(multi);
+        }
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
+    }
+    return true;
+}
 /*
  * Called as soon as the SSL/TLS connection is authenticated.
  *
@@ -2778,6 +2834,14 @@
         (*cur_handler_index)++;
     }

+    if (mi->context.options.override_username)
+    {
+        if (!override_locked_username(mi))
+        {
+            cc_succeeded =3D false;
+        }
+    }
+
     /* Check if we have forbidding options in the current mode */
     if (dco_enabled(&mi->context.options)
         && !dco_check_option(D_MULTI_ERRORS, &mi->context.options))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ae44db..5b8d121 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -452,6 +452,8 @@
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
@@ -7955,6 +7957,23 @@
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
index 3f4cb90..0b2a9f3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -504,6 +504,7 @@
     const char *client_config_dir;
     bool ccd_exclusive;
     bool disable;
+    const char *override_username;
     int n_bcast_buf;
     int tcp_queue_limit;
     struct iroute *iroutes;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a7cd3bf..894d85b 100644
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
+        char *base64user =3D NULL;
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
index 439ce79..16fa4cd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1262,6 +1262,7 @@
     free(multi->peer_info);
     free(multi->locked_cn);
     free(multi->locked_username);
+    free(multi->locked_original_username);

     cert_hash_free(multi->locked_cert_hash_set);

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9625a99..411b64f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -628,7 +628,16 @@
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
index e7d7ed6..dd230e8 100644
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
@@ -85,10 +82,7 @@
     }
 }

-/*
- * Set the given session's common_name
- */
-static void
+void
 set_common_name(struct tls_session *session, const char *common_name)
 {
     if (session->common_name)
@@ -153,7 +147,10 @@
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
@@ -1613,6 +1610,17 @@
      */
     bool skip_auth =3D false;

+    /* Replace username early if override-username is in effect but only
+     * if client is sending the original username */
+    if (multi->locked_original_username
+        && strncmp(up->username, multi->locked_original_username, sizeof(u=
p->username)) =3D=3D 0)
+    {
+        msg(D_MULTI_LOW, "TLS: Replacing client provided username '%s' wit=
h "
+            "username from override-user '%s'", up->username,
+            multi->locked_username);
+        strncpy(up->username, multi->locked_username, sizeof(up->username)=
);
+    }
+
     /*
      * If server is configured with --auth-gen-token and the client sends
      * something that looks like an authentication token, this
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index cd2ec24..eba3832 100644
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
@@ -146,6 +149,16 @@
  */
 const char *tls_common_name(const struct tls_multi *multi, const bool null=
);

+
+/**
+ * Sets the common name field for the given tunnel
+ *
+ * @param multi         The tunnel to set the common name for
+ * @param common_name   The name to set the common name to
+ */
+void
+set_common_name(struct tls_session *session, const char *common_name);
+
 /**
  * Returns the username field for the given tunnel
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Gerrit-Change-Number: 872
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--R8pweAy5kWo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, ordex, plais=
thos, stipa. </p>
<p>plaisthos <strong>uploaded patch set #9</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by d12fk</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Implement override-username<br><br>This allow the se=
rver to set and override the username that is assumed<br>for the client for=
 interaction with the client after the authentication.<br><br>This is espec=
ially intended to allow the of use auth-gen-token in<br>scenarios where the=
 clients use certificates and multi-factor<br>authentication.<br><br>It all=
ows a client to successfully roam to a different server and have<br>a corre=
ct username and auth-token that can be accepted by that server as<br>fully =
authenticated user without requiring MFA again.<br><br>The scenario that th=
is feature is probably most useful<br>when --management-client-auth is in u=
se as in this mode the OpenVPN<br>server can accept clients without usernam=
e/password but still use<br>--auth-gen-token with username and password to =
accept auth-token as<br>alternative authentication. A client without a user=
name will also not<br>use the pushed auth-token. So setting/pushing an auth=
-token-user<br>will ensure that the client has a username.<br><br>Change-Id=
: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f<br>Signed-off-by: Arne Schwabe =
&lt;arne@...1227...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/serve=
r-options.rst<br>M src/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/=
openvpn/options.h<br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<br>M src/o=
penvpn/ssl_common.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_veri=
fy.h<br>10 files changed, 173 insertions(+), 10 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/9</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/Changes.rst b/Changes.rst</span><br><span>index e011811..d6a0ba=
6 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rs=
t</span><br><span>@@ -49,6 +49,12 @@</span><br><span>     - IV constructed =
with XOR instead of concatenation to not have (parts) of</span><br><span>  =
     the real IV on the wire</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+Allow overriding username with ``--override-user=
name``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    This is i=
ntended to allow using auth-gen-token in scenarios where the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    clients use certificates and m=
ulti-factor authentication.  This will</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    also generate a &#39;push &quot;auth-token-user newu=
sername&quot;&#39; directives in</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    push replies.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> Deprecated features</span><br><span> ---------=
----------</span><br><span> ``secret`` support has been removed by default.=
</span><br><span>diff --git a/doc/man-sections/server-options.rst b/doc/man=
-sections/server-options.rst</span><br><span>index 3fe9862..e93b04d 100644<=
/span><br><span>--- a/doc/man-sections/server-options.rst</span><br><span>+=
++ b/doc/man-sections/server-options.rst</span><br><span>@@ -89,6 +89,12 @@=
</span><br><span>   will lead to authentication bypass (as does returning s=
uccess on a wrong</span><br><span>   password from a script).</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  **Note:** the=
 username for ``--auth-gen-token`` can be overridden by</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ``--override-user``. In this case the=
 client will be pushed also the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  ``--auth-token-user`` option and an auth token that is valid =
for that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  username =
instead of the original username that the client authenticated</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  with.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> --auth-gen-token-secret fi=
le</span><br><span>   Specifies a file that holds a secret for the HMAC use=
d in</span><br><span>   ``--auth-gen-token`` If ``file`` is not present Ope=
nVPN will generate a</span><br><span>@@ -412,6 +418,32 @@</span><br><span> =
</span><br><span>   This option requires that ``--disable-occ`` NOT be used=
.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
--override-username username</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Sets the username of a connection to the specified username.  Th=
is username</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  will a=
lso be used by ``--auth-gen-token``. However, the overridden</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  username comes only into effect =
*after* the ``--client-config-dir`` has been</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  read and the ``--auth-user-pass-verify`` and ``-=
-client-connect`` scripts</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  have been run.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Also ``--usern=
ame-as-common-name`` will use the client provided username</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  as common-name. It is recommended =
to avoid the use of the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  ``--override-username`` option if the option ``--username-as-common-n=
ame``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is being use=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  The changed username will be picke=
d up by the status output and also by</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  the ``--auth-gen-token`` option. It will also be pushed=
 to the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  usi=
ng ``--auth-token-user``.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Special car=
e should be taken that both the initial username of the client</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  and the overridden username ar=
e handled correctly when using</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  ``--override-username`` and the related options to avoid</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  authentication/authoris=
ation bypasses.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  This option is mainly=
 intended for use cases that use certificates and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  multi factor authentication and therefore d=
o not provide a username that</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  can be used for ``--auth-gen-token`` to allow providing a usern=
ame in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  these scena=
rios.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> --port-share args</span><br><span>   Share OpenVPN TCP with another ser=
vice</span><br><span> </span><br><span>diff --git a/src/openvpn/multi.c b/s=
rc/openvpn/multi.c</span><br><span>index f76dad8..13874a4 100644</span><br>=
<span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</=
span><br><span>@@ -42,7 +42,9 @@</span><br><span> #include &quot;ssl_verify=
.h&quot;</span><br><span> #include &quot;ssl_ncp.h&quot;</span><br><span> #=
include &quot;vlan.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;auth_token.h&quot;</span><br><span> #include &lt;intt=
ypes.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;string.h&gt;</span><br><span> </span><br><span> #include &quot;memdbg.h=
&quot;</span><br><span> </span><br><span>@@ -2675,6 +2677,60 @@</span><br><=
span>     NULL,</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Overrides the locked username with the username of --o=
verride-username</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param mi the multi instance that should be modified.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+override_locked_username(struct multi_instance *mi)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D mi-&gt;context.c2.t=
ls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 options *options =3D &amp;mi-&gt;context.options;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct tls_session *session =3D &amp;mul=
ti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mul=
ti-&gt;locked_username)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_MULTI_ERRORS, &quot;MULTI: Ignoring override-username as no &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;user/p=
assword method is enabled. Enable &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;--management-client-auth, --auth-use=
r-pass-verify, or a &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;plugin with user/password verify capability.&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!multi-&gt;locked_original_username</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; strcm=
p(multi-&gt;locked_username, options-&gt;override_username) !=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locked_original_usernam=
e =3D multi-&gt;locked_username;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        multi-&gt;locked_username =3D strdup(options-&gt;overr=
ide_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Override also=
 the common name if username should be set as common</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * name */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ((session-&gt;opt-&gt;ssl_flag=
s &amp; SSLF_USERNAME_AS_COMMON_NAME))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            set_common_name(session, multi-&gt;locked_username);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(mult=
i-&gt;locked_cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          multi-&gt;locked_cn =3D NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            tls_lock_common_name(multi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* Regenerate the auth-token if enabled */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;auth_token=
_initial)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct u=
ser_pass up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     CLEAR(up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        strncpynt(up.username, multi-&gt;locked_username,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                      sizeof(up.usern=
ame));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            generate_auth_token(=
&amp;up, multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;M=
ULTI: Note, override-username changes username &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;from &#39;%s&#39; to &#=
39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          multi-&gt;locked_original_username,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            multi-&gt;locked_username);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span> /*</span><br><span>  * Ca=
lled as soon as the SSL/TLS connection is authenticated.</span><br><span>  =
*</span><br><span>@@ -2778,6 +2834,14 @@</span><br><span>         (*cur_han=
dler_index)++;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context.options.override=
_username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!override_l=
ocked_username(mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  cc_succeeded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    /* Check if we have forbidding options in the current mode */</span><br=
><span>     if (dco_enabled(&amp;mi-&gt;context.options)</span><br><span>  =
       &amp;&amp; !dco_check_option(D_MULTI_ERRORS, &amp;mi-&gt;context.opt=
ions))</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opt=
ions.c</span><br><span>index 3ae44db..5b8d121 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -452,6 +452,8 @@</span><br><span>     &quot;                  Onl=
y valid in a client-specific config file.\n&quot;</span><br><span>     &quo=
t;--disable       : Client is disabled.\n&quot;</span><br><span>     &quot;=
                  Only valid in a client-specific config file.\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--override-use=
rname: Overrides the client-specific username to be used.\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  O=
nly valid in a client-specific config file.\n&quot;</span><br><span>     &q=
uot;--verify-client-cert [none|optional|require] : perform no, optional or\=
n&quot;</span><br><span>     &quot;                  mandatory client certi=
ficate verification.\n&quot;</span><br><span>     &quot;                  D=
efault is to require the client to supply a certificate.\n&quot;</span><br>=
<span>@@ -7955,6 +7957,23 @@</span><br><span>         VERIFY_PERMISSION(OPT=
_P_INSTANCE);</span><br><span>         options-&gt;disable =3D true;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (streq(p[0], &quot;override-username&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISS=
ION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (strlen(p[1]) &gt; TLS_USERNAME_LEN)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(msglevel, &quot;override-username exceed=
s the maximum length of %d &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                &quot;characters&quot;, TLS_USERNAME_LEN);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* disable the connection sin=
ce ignoring the request to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * set another username might cause serious problems */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-=
&gt;disable =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;o=
verride_username =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span>     else if (streq(p[0], &quot;tcp-nodelay&quot;) &amp;=
&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/options.h b/sr=
c/openvpn/options.h</span><br><span>index 3f4cb90..0b2a9f3 100644</span><br=
><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/option=
s.h</span><br><span>@@ -504,6 +504,7 @@</span><br><span>     const char *cl=
ient_config_dir;</span><br><span>     bool ccd_exclusive;</span><br><span> =
    bool disable;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *override_username;</span><br><span>     int n_bcast_buf;</spa=
n><br><span>     int tcp_queue_limit;</span><br><span>     struct iroute *i=
routes;</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.=
c</span><br><span>index a7cd3bf..894d85b 100644</span><br><span>--- a/src/o=
penvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -=
595,9 +595,19 @@</span><br><span>      */</span><br><span>     if (tls_mult=
i-&gt;auth_token)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        push_option_fmt(gc, push_list, M_USAGE,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;=
auth-token %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        push_option_fmt(gc, push_list, M_USAGE, &quot;auth-token %s&quot;,=
</span><br><span>                         tls_multi-&gt;auth_token);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        char *base64user =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        int ret =3D openvpn_ba=
se64_encode(tls_multi-&gt;locked_username,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                        (int)strlen(=
tls_multi-&gt;locked_username),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                        &amp;base64user);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ret &lt; USER=
_PASS_LEN &amp;&amp; ret &gt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            push_option_fmt(gc, push_list, M_USAGE, &quot;auth-token-use=
r %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    base64user);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        free(base64user);</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/=
ssl.c</span><br><span>index 439ce79..16fa4cd 100644</span><br><span>--- a/s=
rc/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@=
 -1262,6 +1262,7 @@</span><br><span>     free(multi-&gt;peer_info);</span><=
br><span>     free(multi-&gt;locked_cn);</span><br><span>     free(multi-&g=
t;locked_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    free(multi-&gt;locked_original_username);</span><br><span> </span><br><=
span>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br><span> =
</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_co=
mmon.h</span><br><span>index 9625a99..411b64f 100644</span><br><span>--- a/=
src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</sp=
an><br><span>@@ -628,7 +628,16 @@</span><br><span>      * Our locked common=
 name, username, and cert hashes (cannot change during the life of this tls=
_multi object)</span><br><span>      */</span><br><span>     char *locked_c=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /** The locked username is the u=
sername we assume the client is using.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * Normally the username used for initial authentica=
tion unless</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * o=
verridden by --override-username */</span><br><span>     char *locked_usern=
ame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /** The username that client i=
nitially used before being overridden</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * by --override-user */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *locked_original_username;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct cer=
t_hash_set *locked_cert_hash_set;</span><br><span> </span><br><span>     /*=
* Time of last when we updated the cached state of</span><br><span>diff --g=
it a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>in=
dex e7d7ed6..dd230e8 100644</span><br><span>--- a/src/openvpn/ssl_verify.c<=
/span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -48,9 +48=
,6 @@</span><br><span> #include &quot;push.h&quot;</span><br><span> #includ=
e &quot;ssl_util.h&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/** Maximum length of common name */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define TLS_USERNAME_LEN 64</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</sp=
an><br><span> string_mod_remap_name(char *str)</span><br><span> {</span><br=
><span>@@ -85,10 +82,7 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Set the given session&#39;s=
 common_name</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> set_common_na=
me(struct tls_session *session, const char *common_name)</span><br><span> {=
</span><br><span>     if (session-&gt;common_name)</span><br><span>@@ -153,=
7 +147,10 @@</span><br><span> {</span><br><span>     if (multi-&gt;locked_u=
sername)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (strcmp(username, multi-&gt;locked_username) !=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* If the use=
rname has been overridden, we accept both the original</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * username and the changed user=
name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
strcmp(username, multi-&gt;locked_username) !=3D 0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &amp;&amp;  (!multi-&gt;locked_o=
riginal_username || strcmp(username, multi-&gt;locked_original_username) !=
=3D 0))</span><br><span>         {</span><br><span>             msg(D_TLS_E=
RRORS, &quot;TLS Auth Error: username attempted to change from &#39;%s&#39;=
 to &#39;%s&#39; -- tunnel disabled&quot;,</span><br><span>                =
 multi-&gt;locked_username,</span><br><span>@@ -1613,6 +1610,17 @@</span><b=
r><span>      */</span><br><span>     bool skip_auth =3D false;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Replac=
e username early if override-username is in effect but only</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * if client is sending the ori=
ginal username */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (multi-&gt;locked_original_username</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        &amp;&amp; strncmp(up-&gt;username, multi-&gt;=
locked_original_username, sizeof(up-&gt;username)) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;TLS: Replacing cl=
ient provided username &#39;%s&#39; with &quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot;username from override-user &=
#39;%s&#39;&quot;, up-&gt;username,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            multi-&gt;locked_username);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        strncpy(up-&gt;username, multi-=
&gt;locked_username, sizeof(up-&gt;username));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     /*</span><br><span>      * If server is =
configured with --auth-gen-token and the client sends</span><br><span>     =
 * something that looks like an authentication token, this</span><br><span>=
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h</span><br>=
<span>index cd2ec24..eba3832 100644</span><br><span>--- a/src/openvpn/ssl_v=
erify.h</span><br><span>+++ b/src/openvpn/ssl_verify.h</span><br><span>@@ -=
51,6 +51,9 @@</span><br><span> /** Maximum certificate depth we will allow =
*/</span><br><span> #define MAX_CERT_DEPTH 16</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum length of common na=
me */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLS_US=
ERNAME_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /** Structure containing the hash for a single certificate */</=
span><br><span> struct cert_hash {</span><br><span>     unsigned char sha25=
6_hash[256/8];</span><br><span>@@ -146,6 +149,16 @@</span><br><span>  */</s=
pan><br><span> const char *tls_common_name(const struct tls_multi *multi, c=
onst bool null);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets the common n=
ame field for the given tunnel</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram multi         The tunnel to set the common name for</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param common_name   The name to set=
 the common name to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+set_common_name(struct tls_sess=
ion *session, const char *common_name);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Returns the u=
sername field for the given tunnel</span><br><span>  *</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/872?usp=3Demail">change 872</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--R8pweAy5kWo=--


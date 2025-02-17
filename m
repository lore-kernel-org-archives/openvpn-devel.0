From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 17 Feb 2025 12:05:27 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277..., a@...2181...
Message-ID: <93df19ba15aa5961abb37f68e48c3827569f8507-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7xG0MeYNogs="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--7xG0MeYNogs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail

to look at the new patch set (#6).


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
10 files changed, 160 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/6

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
index 3fe9862..a76de67 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -89,6 +89,12 @@
   will lead to authentication bypass (as does returning success on a wrong
   password from a script).

+  **Note:** the username for ``--auth-gen-token`` can be overridden by
+  ``--override-user``. In this case the client will be pushed also the
+  ``--auth-token-user`` option and and an auth token that is valid for
+  that username instead of the original username that the client
+  authenticated with.
+
 --auth-gen-token-secret file
   Specifies a file that holds a secret for the HMAC used in
   ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a
@@ -412,6 +418,32 @@

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
+  ``--override-username`` option if the option ``--username-as-common-name=
``
+  is being used.
+
+  The changed username will be picked up by the status output and also by
+  the ``--auth-gen-token`` option. It will also be pushed to the client
+  using ``--auth-token-user``.
+
+  Special care has to be taken both the initial username of the client and=
 the
+  overridden username are  correctly handled when using ``--override-usern=
ame``
+  and the related options to avoid authentication/authorisation
+  bypasses.
+
+  This option is mainly intended for use cases that use certificates and
+  multi factor authentication and therefore do not provide a username that
+  can be used for ``--auth-gen-token`` to allow providing a username in
+  these scenarios.
+
 --port-share args
   Share OpenVPN TCP with another service

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f76dad8..8163f42 100644
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

@@ -2675,6 +2677,50 @@
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
+    struct options *options =3D &mi->context.options;
+    struct tls_session *session =3D &multi->session[TM_ACTIVE];
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
+}
 /*
  * Called as soon as the SSL/TLS connection is authenticated.
  *
@@ -2778,6 +2824,11 @@
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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Gerrit-Change-Number: 872
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--7xG0MeYNogs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement override-username<br><br>This allow the server to set and o=
verride the username that is assumed<br>for the client for interaction with=
 the client after the authentication.<br><br>This is especially intended to=
 allow the of use auth-gen-token in<br>scenarios where the clients use cert=
ificates and multi-factor<br>authentication.<br><br>It allows a client to s=
uccessfully roam to a different server and have<br>a correct username and a=
uth-token that can be accepted by that server as<br>fully authenticated use=
r without requiring MFA again.<br><br>The scenario that this feature is pro=
bably most useful<br>when --management-client-auth is in use as in this mod=
e the OpenVPN<br>server can accept clients without username/password but st=
ill use<br>--auth-gen-token with username and password to accept auth-token=
 as<br>alternative authentication. A client without a username will also no=
t<br>use the pushed auth-token. So setting/pushing an auth-token-user<br>wi=
ll ensure that the client has a username.<br><br>Change-Id: Ia4095518d5e444=
7992a2974e0d7a159d79ba6b6f<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/server-options.rst<br>=
M src/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h=
<br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common=
.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify.h<br>10 files =
changed, 160 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/72/872/6</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Chang=
es.rst b/Changes.rst</span><br><span>index e011811..d6a0ba6 100644</span><b=
r><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span=
>@@ -49,6 +49,12 @@</span><br><span>     - IV constructed with XOR instead =
of concatenation to not have (parts) of</span><br><span>       the real IV =
on the wire</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+Allow overriding username with ``--override-username``</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    This is intended to allow =
using auth-gen-token in scenarios where the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    clients use certificates and multi-factor authe=
ntication.  This will</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    also generate a &#39;push &quot;auth-token-user newusername&quot;&#39=
; directives in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
push replies.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> Deprecated features</span><br><span> -------------------</span>=
<br><span> ``secret`` support has been removed by default.</span><br><span>=
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst</span><br><span>index 3fe9862..a76de67 100644</span><br><span>-=
-- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/man-sect=
ions/server-options.rst</span><br><span>@@ -89,6 +89,12 @@</span><br><span>=
   will lead to authentication bypass (as does returning success on a wrong=
</span><br><span>   password from a script).</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  **Note:** the username for ``-=
-auth-gen-token`` can be overridden by</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  ``--override-user``. In this case the client will be p=
ushed also the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``-=
-auth-token-user`` option and and an auth token that is valid for</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  that username instead of th=
e original username that the client</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  authenticated with.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> --auth-gen-token-secret file</span><br>=
<span>   Specifies a file that holds a secret for the HMAC used in</span><b=
r><span>   ``--auth-gen-token`` If ``file`` is not present OpenVPN will gen=
erate a</span><br><span>@@ -412,6 +418,32 @@</span><br><span> </span><br><s=
pan>   This option requires that ``--disable-occ`` NOT be used.</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--override-us=
ername</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Sets the us=
ername of a connection to the specified username.  This username</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  will also be used by ``--aut=
h-gen-token``. However, the overridden</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  username comes only into effect *after* the ``--client=
-config-dir`` has been</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  read and the ``--auth-user-pass-verify`` and ``--client-connect`` scri=
pts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  have been run.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Also ``username-as-common-name`` wil=
l use the client provided username</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  as common-name. It is recommended to avoid the use of the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--override-usern=
ame`` option if the option ``--username-as-common-name``</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  is being used.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  The changed username will be picked up by the status outpu=
t and also by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the =
``--auth-gen-token`` option. It will also be pushed to the client</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  using ``--auth-token-user``=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  Special care has to be taken both t=
he initial username of the client and the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  overridden username are  correctly handled when usi=
ng ``--override-username``</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  and the related options to avoid authentication/authorisation</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  bypasses.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  This option is mainly intended for use cases that=
 use certificates and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  multi factor authentication and therefore do not provide a username tha=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  can be used for =
``--auth-gen-token`` to allow providing a username in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  these scenarios.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --port-share args</span=
><br><span>   Share OpenVPN TCP with another service</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><b=
r><span>index f76dad8..8163f42 100644</span><br><span>--- a/src/openvpn/mul=
ti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -42,7 +42=
,9 @@</span><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #=
include &quot;ssl_ncp.h&quot;</span><br><span> #include &quot;vlan.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;auth_=
token.h&quot;</span><br><span> #include &lt;inttypes.h&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br>=
<span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </s=
pan><br><span>@@ -2675,6 +2677,50 @@</span><br><span>     NULL,</span><br><=
span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Overri=
des the locked username with the username of --override-username</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param mi the multi instanc=
e that should be modified.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+override_locked_u=
sername(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tls_multi *multi =3D mi-&gt;context.c2.tls_multi;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct options *options =3D &amp;=
mi-&gt;context.options;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct tls_session *session =3D &amp;multi-&gt;session[TM_ACTIVE];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;locked_original_user=
name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; strcmp(multi-&gt;locked_username, options-&gt;override_username) !=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locked_origina=
l_username =3D multi-&gt;locked_username;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        multi-&gt;locked_username =3D strdup(options-=
&gt;override_username);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Over=
ride also the common name if username should be set as common</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * name */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if ((session-&gt;opt-&gt;s=
sl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            set_common_name(session, multi-&gt;locked_usern=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fr=
ee(multi-&gt;locked_cn);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;locked_cn =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            tls_lock_common_name(multi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* Regenerate the auth-token if enabled */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;aut=
h_token_initial)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
truct user_pass up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            CLEAR(up);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            strncpynt(up.username, multi-&gt;locked_username,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                      sizeof(u=
p.username));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            generate_auth=
_token(&amp;up, multi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, =
&quot;MULTI: Note, override-username changes username &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;from &#39;%s&#39=
; to &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;locked_original_username,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;locked_username);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> /*</span><br><sp=
an>  * Called as soon as the SSL/TLS connection is authenticated.</span><br=
><span>  *</span><br><span>@@ -2778,6 +2824,11 @@</span><br><span>         =
(*cur_handler_index)++;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context.options=
.override_username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        overri=
de_locked_username(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     /* Check if we have forbidding options in the current mode */</=
span><br><span>     if (dco_enabled(&amp;mi-&gt;context.options)</span><br>=
<span>         &amp;&amp; !dco_check_option(D_MULTI_ERRORS, &amp;mi-&gt;con=
text.options))</span><br><span>diff --git a/src/openvpn/options.c b/src/ope=
nvpn/options.c</span><br><span>index 3ae44db..5b8d121 100644</span><br><spa=
n>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</=
span><br><span>@@ -452,6 +452,8 @@</span><br><span>     &quot;             =
     Only valid in a client-specific config file.\n&quot;</span><br><span> =
    &quot;--disable       : Client is disabled.\n&quot;</span><br><span>   =
  &quot;                  Only valid in a client-specific config file.\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--over=
ride-username: Overrides the client-specific username to be used.\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;           =
       Only valid in a client-specific config file.\n&quot;</span><br><span=
>     &quot;--verify-client-cert [none|optional|require] : perform no, opti=
onal or\n&quot;</span><br><span>     &quot;                  mandatory clie=
nt certificate verification.\n&quot;</span><br><span>     &quot;           =
       Default is to require the client to supply a certificate.\n&quot;</s=
pan><br><span>@@ -7955,6 +7957,23 @@</span><br><span>         VERIFY_PERMIS=
SION(OPT_P_INSTANCE);</span><br><span>         options-&gt;disable =3D true=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (streq(p[0], &quot;override-username&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY=
_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (strlen(p[1]) &gt; TLS_USERNAME_LEN)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;override-usernam=
e exceeds the maximum length of %d &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                &quot;characters&quot;, TLS_USERNAME_=
LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* disable the connec=
tion since ignoring the request to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             * set another username might cause serious prob=
lems */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
options-&gt;disable =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            optio=
ns-&gt;override_username =3D p[1];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     else if (streq(p[0], &quot;tcp-nodelay&quot=
;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY=
_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/option=
s.h b/src/openvpn/options.h</span><br><span>index 3f4cb90..0b2a9f3 100644</=
span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvp=
n/options.h</span><br><span>@@ -504,6 +504,7 @@</span><br><span>     const =
char *client_config_dir;</span><br><span>     bool ccd_exclusive;</span><br=
><span>     bool disable;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *override_username;</span><br><span>     int n_bcast_b=
uf;</span><br><span>     int tcp_queue_limit;</span><br><span>     struct i=
route *iroutes;</span><br><span>diff --git a/src/openvpn/push.c b/src/openv=
pn/push.c</span><br><span>index a7cd3bf..5ccd7d8 100644</span><br><span>---=
 a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><s=
pan>@@ -595,9 +595,19 @@</span><br><span>      */</span><br><span>     if (=
tls_multi-&gt;auth_token)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        push_option_fmt(gc, push_list, M_USAGE,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  &quot;auth-token %s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;auth-token %=
s&quot;,</span><br><span>                         tls_multi-&gt;auth_token)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        char *base64user;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        int ret =3D openvpn_bas=
e64_encode(tls_multi-&gt;locked_username,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                        (int)strlen(t=
ls_multi-&gt;locked_username),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                        &amp;base64user);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ret &lt; USER_=
PASS_LEN &amp;&amp; ret &gt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            push_option_fmt(gc, push_list, M_USAGE, &quot;auth-token-user=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                   base64user);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        free(base64user);</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/s=
sl.c</span><br><span>index 439ce79..16fa4cd 100644</span><br><span>--- a/sr=
c/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ =
-1262,6 +1262,7 @@</span><br><span>     free(multi-&gt;peer_info);</span><b=
r><span>     free(multi-&gt;locked_cn);</span><br><span>     free(multi-&gt=
;locked_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free(multi-&gt;locked_original_username);</span><br><span> </span><br><s=
pan>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_com=
mon.h</span><br><span>index 9625a99..411b64f 100644</span><br><span>--- a/s=
rc/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</spa=
n><br><span>@@ -628,7 +628,16 @@</span><br><span>      * Our locked common =
name, username, and cert hashes (cannot change during the life of this tls_=
multi object)</span><br><span>      */</span><br><span>     char *locked_cn=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /** The locked username is the us=
ername we assume the client is using.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * Normally the username used for initial authenticat=
ion unless</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ov=
erridden by --override-username */</span><br><span>     char *locked_userna=
me;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /** The username that client in=
itially used before being overridden</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * by --override-user */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *locked_original_username;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct cert=
_hash_set *locked_cert_hash_set;</span><br><span> </span><br><span>     /**=
 Time of last when we updated the cached state of</span><br><span>diff --gi=
t a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>ind=
ex e7d7ed6..dd230e8 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</=
span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -48,9 +48,=
6 @@</span><br><span> #include &quot;push.h&quot;</span><br><span> #include=
 &quot;ssl_util.h&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/** Maximum length of common name */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define TLS_USERNAME_LEN 64</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</spa=
n><br><span> string_mod_remap_name(char *str)</span><br><span> {</span><br>=
<span>@@ -85,10 +82,7 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Set the given session&#39;s =
common_name</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> set_common_nam=
e(struct tls_session *session, const char *common_name)</span><br><span> {<=
/span><br><span>     if (session-&gt;common_name)</span><br><span>@@ -153,7=
 +147,10 @@</span><br><span> {</span><br><span>     if (multi-&gt;locked_us=
ername)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (strcmp(username, multi-&gt;locked_username) !=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* If the user=
name has been overridden, we accept both the original</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * username and the changed usern=
ame */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s=
trcmp(username, multi-&gt;locked_username) !=3D 0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &amp;&amp;  (!multi-&gt;locked_or=
iginal_username || strcmp(username, multi-&gt;locked_original_username) !=
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
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--7xG0MeYNogs=--


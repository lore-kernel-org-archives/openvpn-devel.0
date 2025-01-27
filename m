From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 10:40:42 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <be2da84d1c7100ac216855be1c5b047a5da24e64-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hlxGTP+57XQ="; charset=UTF-8
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

--hlxGTP+57XQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail

to look at the new patch set (#5).


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
11 files changed, 159 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/872/5

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

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 3cf55e8..f51c42e 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -330,6 +330,7 @@
     timestamp_initial =3D ntohll(timestamp_initial);

     hmac_ctx_t *ctx =3D multi->opt.auth_token_key.hmac;
+
     if (check_hmac_token(ctx, b64decoded, up->username))
     {
         ret |=3D AUTH_TOKEN_HMAC_OK;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9c8c014..24bdedd 100644
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

@@ -2665,6 +2667,50 @@
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
@@ -2768,6 +2814,11 @@
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
index bd5c056..a10b2b5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -450,6 +450,8 @@
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
@@ -7954,6 +7956,23 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--hlxGTP+57XQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement override-username<br><br>This is intended to allow using au=
th-gen-token in scenarios where the<br>client use certificates and multi-fa=
ctor authentication.<br><br>It allows a client to successfully roam to a di=
fferent server and have<br>a correct username and auth-token that can be ac=
cepted by that server as<br>fully authenticated user without requiring MFA =
again.<br><br>The scenario that this feature is probably most useful<br>whe=
n --management-client-auth is in use as in this mode the OpenVPN<br>server =
can accept clients without username/password but still use<br>--auth-gen-to=
ken with username and password to accept auth-token as<br>alternative authe=
ntication.<br><br>Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f<br>S=
igned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Changes.rst<=
br>M doc/man-sections/server-options.rst<br>M src/openvpn/auth_token.c<br>M=
 src/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<=
br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.=
h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify.h<br>11 files c=
hanged, 159 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/72/872/5</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Change=
s.rst b/Changes.rst</span><br><span>index 16ae6fc..8543113 100644</span><br=
><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>=
@@ -36,6 +36,10 @@</span><br><span>     add an allowed cipher without havin=
g to spell out the default ciphers.</span><br><span> </span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+Allow overriding userna=
me with ``--override-username``</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    This is intended to allow using auth-gen-token in scenarios=
 where the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clien=
ts use certificates and multi-factor authentication.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecated features</sp=
an><br><span> -------------------</span><br><span> ``secret`` support has b=
een removed by default.</span><br><span>diff --git a/doc/man-sections/serve=
r-options.rst b/doc/man-sections/server-options.rst</span><br><span>index 3=
fe9862..a76de67 100644</span><br><span>--- a/doc/man-sections/server-option=
s.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</span><br><=
span>@@ -89,6 +89,12 @@</span><br><span>   will lead to authentication bypa=
ss (as does returning success on a wrong</span><br><span>   password from a=
 script).</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  **Note:** the username for ``--auth-gen-token`` can be overridden=
 by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--override-u=
ser``. In this case the client will be pushed also the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``--auth-token-user`` option and and a=
n auth token that is valid for</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  that username instead of the original username that the client=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  authenticated wit=
h.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 --auth-gen-token-secret file</span><br><span>   Specifies a file that hold=
s a secret for the HMAC used in</span><br><span>   ``--auth-gen-token`` If =
``file`` is not present OpenVPN will generate a</span><br><span>@@ -412,6 +=
418,32 @@</span><br><span> </span><br><span>   This option requires that ``=
--disable-occ`` NOT be used.</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+--override-username</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Sets the username of a connection to the speci=
fied username.  This username</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  will also be used by ``--auth-gen-token``. However, the overrid=
den</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  username comes=
 only into effect *after* the ``--client-config-dir`` has been</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  read and the ``--auth-user-pas=
s-verify`` and ``--client-connect`` scripts</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  have been run.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  Also ``username-as-common-name`` will use the client provided username<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as common-name. It=
 is recommended to avoid the use of the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  ``--override-username`` option if the option ``--user=
name-as-common-name``</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  is being used.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The changed userna=
me will be picked up by the status output and also by</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  the ``--auth-gen-token`` option. It wil=
l also be pushed to the client</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  using ``--auth-token-user``.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  Special care has to be taken both the initial username of the client a=
nd the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  overridden =
username are  correctly handled when using ``--override-username``</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  and the related options to=
 avoid authentication/authorisation</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  bypasses.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This opti=
on is mainly intended for use cases that use certificates and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  multi factor authentication and=
 therefore do not provide a username that</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  can be used for ``--auth-gen-token`` to allow provi=
ding a username in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 these scenarios.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> --port-share args</span><br><span>   Share OpenVPN TCP with=
 another service</span><br><span> </span><br><span>diff --git a/src/openvpn=
/auth_token.c b/src/openvpn/auth_token.c</span><br><span>index 3cf55e8..f51=
c42e 100644</span><br><span>--- a/src/openvpn/auth_token.c</span><br><span>=
+++ b/src/openvpn/auth_token.c</span><br><span>@@ -330,6 +330,7 @@</span><b=
r><span>     timestamp_initial =3D ntohll(timestamp_initial);</span><br><sp=
an> </span><br><span>     hmac_ctx_t *ctx =3D multi-&gt;opt.auth_token_key.=
hmac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     if (check_hmac_token(ctx, b64decoded, up-&gt;username))</span><br><=
span>     {</span><br><span>         ret |=3D AUTH_TOKEN_HMAC_OK;</span><br=
><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><sp=
an>index 9c8c014..24bdedd 100644</span><br><span>--- a/src/openvpn/multi.c<=
/span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -42,7 +42,9 @@=
</span><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #inclu=
de &quot;ssl_ncp.h&quot;</span><br><span> #include &quot;vlan.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;auth_token=
.h&quot;</span><br><span> #include &lt;inttypes.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span=
> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><=
br><span>@@ -2665,6 +2667,50 @@</span><br><span>     NULL,</span><br><span>=
 };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Overrides t=
he locked username with the username of --override-username</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param mi the multi instance tha=
t should be modified.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+override_locked_userna=
me(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct tls_multi *multi =3D mi-&gt;context.c2.tls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct options *options =3D &amp;mi-&=
gt;context.options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct tls_session *session =3D &amp;multi-&gt;session[TM_ACTIVE];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;locked_original_userna=
me</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp=
; strcmp(multi-&gt;locked_username, options-&gt;override_username) !=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locked_original_=
username =3D multi-&gt;locked_username;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        multi-&gt;locked_username =3D strdup(options-&g=
t;override_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Overri=
de also the common name if username should be set as common</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * name */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if ((session-&gt;opt-&gt;ssl=
_flags &amp; SSLF_USERNAME_AS_COMMON_NAME))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            set_common_name(session, multi-&gt;locked_usernam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            free=
(multi-&gt;locked_cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            multi-&gt;locked_cn =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            tls_lock_common_name(multi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Regenerate the auth-token if enabled */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;auth_=
token_initial)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            str=
uct user_pass up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          CLEAR(up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            strncpynt(up.username, multi-&gt;locked_username,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      sizeof(up.=
username));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            generate_auth_t=
oken(&amp;up, multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &q=
uot;MULTI: Note, override-username changes username &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;from &#39;%s&#39; =
to &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            multi-&gt;locked_original_username,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            multi-&gt;locked_username);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> /*</span><br><span>=
  * Called as soon as the SSL/TLS connection is authenticated.</span><br><s=
pan>  *</span><br><span>@@ -2768,6 +2814,11 @@</span><br><span>         (*c=
ur_handler_index)++;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context.options.ov=
erride_username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        override_=
locked_username(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     /* Check if we have forbidding options in the current mode */</spa=
n><br><span>     if (dco_enabled(&amp;mi-&gt;context.options)</span><br><sp=
an>         &amp;&amp; !dco_check_option(D_MULTI_ERRORS, &amp;mi-&gt;contex=
t.options))</span><br><span>diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c</span><br><span>index bd5c056..a10b2b5 100644</span><br><span>-=
-- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</spa=
n><br><span>@@ -450,6 +450,8 @@</span><br><span>     &quot;                =
  Only valid in a client-specific config file.\n&quot;</span><br><span>    =
 &quot;--disable       : Client is disabled.\n&quot;</span><br><span>     &=
quot;                  Only valid in a client-specific config file.\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--overrid=
e-username: Overrides the client-specific username to be used.\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;              =
    Only valid in a client-specific config file.\n&quot;</span><br><span>  =
   &quot;--verify-client-cert [none|optional|require] : perform no, optiona=
l or\n&quot;</span><br><span>     &quot;                  mandatory client =
certificate verification.\n&quot;</span><br><span>     &quot;              =
    Default is to require the client to supply a certificate.\n&quot;</span=
><br><span>@@ -7954,6 +7956,23 @@</span><br><span>         VERIFY_PERMISSIO=
N(OPT_P_INSTANCE);</span><br><span>         options-&gt;disable =3D true;</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (streq(p[0], &quot;override-username&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PE=
RMISSION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (strlen(p[1]) &gt; TLS_USERNAME_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;override-username e=
xceeds the maximum length of %d &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                &quot;characters&quot;, TLS_USERNAME_LEN=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* disable the connectio=
n since ignoring the request to</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * set another username might cause serious problem=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            opt=
ions-&gt;disable =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-=
&gt;override_username =3D p[1];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span>     else if (streq(p[0], &quot;tcp-nodelay&quot;) =
&amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/options.h=
 b/src/openvpn/options.h</span><br><span>index 3f4cb90..0b2a9f3 100644</spa=
n><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/o=
ptions.h</span><br><span>@@ -504,6 +504,7 @@</span><br><span>     const cha=
r *client_config_dir;</span><br><span>     bool ccd_exclusive;</span><br><s=
pan>     bool disable;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *override_username;</span><br><span>     int n_bcast_buf;=
</span><br><span>     int tcp_queue_limit;</span><br><span>     struct irou=
te *iroutes;</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/=
push.c</span><br><span>index a7cd3bf..5ccd7d8 100644</span><br><span>--- a/=
src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span=
>@@ -595,9 +595,19 @@</span><br><span>      */</span><br><span>     if (tls=
_multi-&gt;auth_token)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        push_option_fmt(gc, push_list, M_USAGE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        &=
quot;auth-token %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;auth-token %s&q=
uot;,</span><br><span>                         tls_multi-&gt;auth_token);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        char *base64user;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int ret =3D openvpn_base64=
_encode(tls_multi-&gt;locked_username,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                        (int)strlen(tls_=
multi-&gt;locked_username),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                        &amp;base64user);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (ret &lt; USER_PAS=
S_LEN &amp;&amp; ret &gt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           push_option_fmt(gc, push_list, M_USAGE, &quot;auth-token-user %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                base64user);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       free(base64user);</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.=
c</span><br><span>index e4a7b57..e548299 100644</span><br><span>--- a/src/o=
penvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -12=
60,6 +1260,7 @@</span><br><span>     free(multi-&gt;peer_info);</span><br><=
span>     free(multi-&gt;locked_cn);</span><br><span>     free(multi-&gt;lo=
cked_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
free(multi-&gt;locked_original_username);</span><br><span> </span><br><span=
>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common=
.h</span><br><span>index e092472..2efeb6a 100644</span><br><span>--- a/src/=
openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><=
br><span>@@ -625,7 +625,16 @@</span><br><span>      * Our locked common nam=
e, username, and cert hashes (cannot change during the life of this tls_mul=
ti object)</span><br><span>      */</span><br><span>     char *locked_cn;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /** The locked username is the usern=
ame we assume the client is using.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * Normally the username used for initial authentication=
 unless</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * overr=
idden by --override-username */</span><br><span>     char *locked_username;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /** The username that client initi=
ally used before being overridden</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * by --override-user */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *locked_original_username;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct cert_ha=
sh_set *locked_cert_hash_set;</span><br><span> </span><br><span>     /** Ti=
me of last when we updated the cached state of</span><br><span>diff --git a=
/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index =
e7d7ed6..dd230e8 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</spa=
n><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -48,9 +48,6 @=
@</span><br><span> #include &quot;push.h&quot;</span><br><span> #include &q=
uot;ssl_util.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/** Maximum length of common name */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define TLS_USERNAME_LEN 64</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><=
br><span> string_mod_remap_name(char *str)</span><br><span> {</span><br><sp=
an>@@ -85,10 +82,7 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Set the given session&#39;s com=
mon_name</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> set_common_name(s=
truct tls_session *session, const char *common_name)</span><br><span> {</sp=
an><br><span>     if (session-&gt;common_name)</span><br><span>@@ -153,7 +1=
47,10 @@</span><br><span> {</span><br><span>     if (multi-&gt;locked_usern=
ame)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (strcmp(username, multi-&gt;locked_username) !=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* If the usernam=
e has been overridden, we accept both the original</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * username and the changed username=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strc=
mp(username, multi-&gt;locked_username) !=3D 0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &amp;&amp;  (!multi-&gt;locked_origi=
nal_username || strcmp(username, multi-&gt;locked_original_username) !=3D 0=
))</span><br><span>         {</span><br><span>             msg(D_TLS_ERRORS=
, &quot;TLS Auth Error: username attempted to change from &#39;%s&#39; to &=
#39;%s&#39; -- tunnel disabled&quot;,</span><br><span>                 mult=
i-&gt;locked_username,</span><br><span>@@ -1613,6 +1610,17 @@</span><br><sp=
an>      */</span><br><span>     bool skip_auth =3D false;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Replace use=
rname early if override-username is in effect but only</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * if client is sending the original=
 username */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(multi-&gt;locked_original_username</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &amp;&amp; strncmp(up-&gt;username, multi-&gt;locke=
d_original_username, sizeof(up-&gt;username)) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;TLS: Replacing client =
provided username &#39;%s&#39; with &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;username from override-user &#39;%=
s&#39;&quot;, up-&gt;username,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            multi-&gt;locked_username);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        strncpy(up-&gt;username, multi-&gt;l=
ocked_username, sizeof(up-&gt;username));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     /*</span><br><span>      * If server is confi=
gured with --auth-gen-token and the client sends</span><br><span>      * so=
mething that looks like an authentication token, this</span><br><span>diff =
--git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h</span><br><span=
>index cd2ec24..eba3832 100644</span><br><span>--- a/src/openvpn/ssl_verify=
.h</span><br><span>+++ b/src/openvpn/ssl_verify.h</span><br><span>@@ -51,6 =
+51,9 @@</span><br><span> /** Maximum certificate depth we will allow */</s=
pan><br><span> #define MAX_CERT_DEPTH 16</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/** Maximum length of common name */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLS_USERNAM=
E_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /** Structure containing the hash for a single certificate */</span>=
<br><span> struct cert_hash {</span><br><span>     unsigned char sha256_has=
h[256/8];</span><br><span>@@ -146,6 +149,16 @@</span><br><span>  */</span><=
br><span> const char *tls_common_name(const struct tls_multi *multi, const =
bool null);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets the common name f=
ield for the given tunnel</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m=
ulti         The tunnel to set the common name for</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param common_name   The name to set the =
common name to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+set_common_name(struct tls_session *=
session, const char *common_name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /**</span><br><span>  * Returns the userna=
me field for the given tunnel</span><br><span>  *</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
872?usp=3Demail">change 872</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hlxGTP+57XQ=--


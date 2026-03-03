From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 3 Mar 2026 13:45:48 +0000
In-Reply-To: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <1f364765e08a1f613aff2d2c6a7cc9a6c7a33e55-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6krMHs8+kVU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add an optional
 username-only flag for auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6krMHs8+kVU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, selvanair.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Add an optional username-only flag for auth-user-pass
......................................................................

Add an optional username-only flag for auth-user-pass

Specify "--auth-user-pass username-only" for openvpn to prompt
for only username, not password. Prompt via management interface
uses the usual ">PASSWORD 'Auth' " prompt with type "username"
instead of "username/password".

Internally, the password gets set as "[[BLANK]]" which is currently
used as tag for blank password.

Not compatible with --static-challenge or when username and
password are inlined or read from a file. In such cases, the user
hard-code a dummy password in the file instead.

Change-Id: I788f76e6a70a9c20bca3367140d2741bd0551582
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/client-options.rst
M doc/management-notes.txt
M src/openvpn/init.c
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_common.h
12 files changed, 92 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1548/7

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index b9ae7ce..0b7c308 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -68,7 +68,9 @@
       auth-user-pass up

   If ``up`` is present, it must be a file containing username/password on 2
-  lines. If the password line is missing, OpenVPN will prompt for one.
+  lines or a flag named :code:`username-only` to indicate no password
+  should be prompted for. In the former case, if the password line is miss=
ing
+  in the file, OpenVPN will prompt for one.

   If ``up`` is omitted, username/password will be prompted from the
   console.
@@ -84,6 +86,20 @@
   where password is optional, and will be prompted from the console if
   missing.

+  The :code:`username-only` flag is meant to be used with SSO authenticati=
on.
+  In this case the user will be asked for a username but not password. Ins=
tead,
+  a dummy password :code:`[[BLANK]]` is generated internally and submitted=
 to
+  the server. See management-notes.txt for how this option affects usernam=
e/password
+  prompt via the management interface. For the console, it simply eliminat=
es
+  the password prompt.
+
+  The :code:`username-only` flag cannot be used along with embedding usern=
ame and/or
+  password in the config file, or while reading them from an external file=
. In
+  such cases, if only username is relevant and no password prompt is desir=
ed, a
+  dummy password like 'no_passsword' should be embedded as well. This flag=
 is also
+  incompatible with the ``--static-challenge`` option and legacy ``dynamic=
 challenge``
+  protocol.
+
   The server configuration must specify an ``--auth-user-pass-verify``
   script to verify the username/password provided by the client.

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 41e2a91..7da4aaf 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -304,6 +304,19 @@
     username "Auth" foo
     password "Auth" bar

+  Example 3:
+
+    >PASSWORD:Need 'Auth' username
+
+  OpenVPN needs a --auth-user-pass username.  The
+  management interface client should respond:
+
+    username "Auth" foo
+
+  In this case the user should not be prompted for a password.
+  Support for such username-only prompting is conditional on the
+  client announcing a version >=3D 4.
+
   The username/password itself can be in quotes, and special
   characters such as double quote or backslash must be escaped,
   for example,
@@ -499,6 +512,7 @@
 Minimum client version required for certain features is listed below:
     >PK_SIGN:[base64]           -- version 2 or greater
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
+    >PASSWORD:Need 'Auth' username -- version 4 or greater

 COMMAND -- auth-retry
 ---------------------
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1391aa85..4948b8d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -655,10 +655,10 @@
         enable_auth_user_pass();
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(c->options.auth_user_pass_file, c->options.au=
th_user_pass_file_inline,
-                             &c->options.sc_info);
+                             c->options.auth_user_pass_username_only, &c->=
options.sc_info);
 #else
         auth_user_pass_setup(c->options.auth_user_pass_file, c->options.au=
th_user_pass_file_inline,
-                             NULL);
+                             c->options.auth_user_pass_username_only, NULL=
);
 #endif
     }
 }
@@ -3376,6 +3376,7 @@
     }
     to.auth_user_pass_file =3D options->auth_user_pass_file;
     to.auth_user_pass_file_inline =3D options->auth_user_pass_file_inline;
+    to.auth_user_pass_username_only =3D options->auth_user_pass_username_o=
nly;
     to.auth_token_generate =3D options->auth_token_generate;
     to.auth_token_lifetime =3D options->auth_token_lifetime;
     to.auth_token_renewal =3D options->auth_token_renewal;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d26c9b2..9e77031 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -58,9 +58,6 @@
 #define MANAGEMENT_ECHO_FLAGS 0
 #endif

-/* tag for blank username/password */
-static const char blank_up[] =3D "[[BLANK]]";
-
 /*
  * Management client versions indicating feature support in client.
  * Append new values as needed but do not change exisiting ones.
@@ -70,6 +67,7 @@
     MCV_DEFAULT =3D 1,
     MCV_PKSIGN =3D 2,
     MCV_PKSIGN_ALG =3D 3,
+    MCV_USERNAME_ONLY =3D 4,
 };

 struct management *management; /* GLOBAL */
@@ -740,6 +738,13 @@
 {
     switch (man->connection.up_query_mode)
     {
+        case UP_QUERY_USERNAME:
+            if (strlen(man->connection.up_query.username))
+            {
+                man->connection.up_query.defined =3D true;
+            }
+            break;
+
         case UP_QUERY_USER_PASS:
             if (!strlen(man->connection.up_query.username))
             {
@@ -794,7 +799,9 @@
 man_query_username(struct management *man, const char *type, const char *s=
tring)
 {
     const bool needed =3D
-        ((man->connection.up_query_mode =3D=3D UP_QUERY_USER_PASS) && man-=
>connection.up_query_type);
+        ((man->connection.up_query_mode =3D=3D UP_QUERY_USER_PASS
+          || man->connection.up_query_mode =3D=3D UP_QUERY_USERNAME)
+         && man->connection.up_query_type);
     man_query_user_pass(man, type, string, needed, "username", man->connec=
tion.up_query.username,
                         USER_PASS_LEN);
 }
@@ -3558,6 +3565,12 @@
             prefix =3D "PASSWORD";
             alert_type =3D "password";
         }
+        else if ((man->connection.client_version >=3D MCV_USERNAME_ONLY) &=
& (flags & GET_USER_PASS_USERNAME_ONLY))
+        {
+            up_query_mode =3D UP_QUERY_USERNAME;
+            prefix =3D "PASSWORD";
+            alert_type =3D "username";
+        }
         else
         {
             up_query_mode =3D UP_QUERY_USER_PASS;
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 38f437f..e5ad23f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -264,6 +264,7 @@
 #define UP_QUERY_PASS      2
 #define UP_QUERY_NEED_OK   3
 #define UP_QUERY_NEED_STR  4
+#define UP_QUERY_USERNAME  5

 /* states */
 #define MS_INITIAL       0 /* all sockets are closed */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 9ff281c..c00a3ce 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -215,7 +215,6 @@
         {
             msg(M_WARN, "Note: previous '%s' credentials failed", prefix);
         }
-
 #ifdef ENABLE_MANAGEMENT
         /*
          * Get username/password from management interface?
@@ -389,7 +388,7 @@
                     query_user_add(BSTR(&user_prompt), up->username, USER_=
PASS_LEN, true);
                 }

-                if (password_from_stdin)
+                if (password_from_stdin && !(flags & GET_USER_PASS_USERNAM=
E_ONLY))
                 {
                     query_user_add(BSTR(&pass_prompt), up->password, USER_=
PASS_LEN, false);
                 }
@@ -451,6 +450,12 @@
             }
         }

+        /* Use tag for blank password if we are not prompting for one */
+        if (flags & GET_USER_PASS_USERNAME_ONLY)
+        {
+            strncpy(up->password, blank_up, sizeof(up->password));
+        }
+
         string_mod(up->username, CC_PRINT, CC_CRLF, 0);
         string_mod(up->password, CC_PRINT, CC_CRLF, 0);

diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index e9cfadb..76bcac3 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -48,6 +48,9 @@
  * Get and store a username/password
  */

+/* tag for blank username/password */
+static const char blank_up[] =3D "[[BLANK]]";
+
 struct user_pass
 {
     bool defined;
@@ -123,6 +126,8 @@
 #define GET_USER_PASS_INLINE_CREDS            (1 << 10)
 /** indicates password and response should be concatenated */
 #define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1 << 11)
+/** indicate that only username should be prompted for auth-user-pass */
+#define GET_USER_PASS_USERNAME_ONLY           (1 << 12)

 /**
  * Retrieves the user credentials from various sources depending on the fl=
ags.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fdbc678..d266c3e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -510,7 +510,8 @@
     "                  up is a file containing the username on the first l=
ine,\n"
     "                  and a password on the second. If either the passwor=
d or both\n"
     "                  the username and the password are omitted OpenVPN w=
ill prompt\n"
-    "                  for them from console.\n"
+    "                  for them from console. If [up] is 'username-only', =
only username\n"
+    "                  will be prompted for from console or management int=
erface.\n"
     "--pull           : Accept certain config file options from the peer a=
s if they\n"
     "                  were part of the local config file.  Must be specif=
ied\n"
     "                  when connecting to a '--mode server' remote host.\n"
@@ -3909,6 +3910,12 @@
     {
         o->auth_token_renewal =3D o->renegotiate_seconds;
     }
+#if ENABLE_MANAGEMENT
+    if (o->auth_user_pass_username_only && o->sc_info.challenge_text)
+    {
+        msg(M_USAGE, "'auth-user-pass username-only' cannot be used with s=
tatic challenge");
+    }
+#endif
     pre_connect_save(o);
 }

@@ -7705,7 +7712,13 @@
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
-        if (p[1])
+        options->auth_user_pass_username_only =3D false;
+        if (p[1] && streq(p[1], "username-only"))
+        {
+            options->auth_user_pass_username_only =3D true;
+            options->auth_user_pass_file =3D "stdin";
+        }
+        else if (p[1])
         {
             options->auth_user_pass_file =3D p[1];
             options->auth_user_pass_file_inline =3D is_inline;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b505..f4a36fc 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -557,6 +557,7 @@
     unsigned int push_update_options_found; /* tracks which option types h=
ave been reset in current PUSH_UPDATE sequence */
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
+    bool auth_user_pass_username_only;
     struct options_pre_connect *pre_connect;

     int scheduled_exit_interval;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..962f5df 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -290,7 +290,8 @@
 }

 void
-auth_user_pass_setup(const char *auth_file, bool is_inline, const struct s=
tatic_challenge_info *sci)
+auth_user_pass_setup(const char *auth_file, bool is_inline, bool username_=
only,
+                     const struct static_challenge_info *sci)
 {
     unsigned int flags =3D GET_USER_PASS_MANAGEMENT;

@@ -298,6 +299,10 @@
     {
         flags |=3D GET_USER_PASS_INLINE_CREDS;
     }
+    if (username_only)
+    {
+        flags |=3D GET_USER_PASS_USERNAME_ONLY;
+    }

     if (!auth_user_pass.defined && !auth_token.defined)
     {
@@ -2099,10 +2104,12 @@
     {
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(session->opt->auth_user_pass_file,
-                             session->opt->auth_user_pass_file_inline, ses=
sion->opt->sci);
+                             session->opt->auth_user_pass_file_inline,
+                             session->opt->auth_user_pass_username_only, s=
ession->opt->sci);
 #else
         auth_user_pass_setup(session->opt->auth_user_pass_file,
-                             session->opt->auth_user_pass_file_inline, NUL=
L);
+                             session->opt->auth_user_pass_file_inline,
+                             session->opt->auth_user_pass_username_only, N=
ULL);
 #endif
         struct user_pass *up =3D &auth_user_pass;

diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 28a3b78..5822336 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -389,7 +389,7 @@
  * credentials stored in the file, however, if is_inline is true then auth=
_file
  * contains the username/password inline.
  */
-void auth_user_pass_setup(const char *auth_file, bool is_inline,
+void auth_user_pass_setup(const char *auth_file, bool is_inline, bool user=
name_only,
                           const struct static_challenge_info *sc_info);

 /*
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index fba01bb..6f310a5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -396,6 +396,7 @@
     const char *export_peer_cert_dir;
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
+    bool auth_user_pass_username_only;

     bool auth_token_generate;  /**< Generate auth-tokens on successful
                                 * user/pass auth,seet via

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I788f76e6a70a9c20bca3367140d2741bd0551582
Gerrit-Change-Number: 1548
Gerrit-PatchSet: 7
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: selvanair <selva.nair@...277...>

--6krMHs8+kVU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, selvanair. </p>
<p>selvanair <strong>uploaded patch set #7</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><p>The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ad=
d an optional username-only flag for auth-user-pass<br><br>Specify &quot;--=
auth-user-pass username-only&quot; for openvpn to prompt<br>for only userna=
me, not password. Prompt via management interface<br>uses the usual &quot;&=
gt;PASSWORD &#39;Auth&#39; &quot; prompt with type &quot;username&quot;<br>=
instead of &quot;username/password&quot;.<br><br>Internally, the password g=
ets set as &quot;[[BLANK]]&quot; which is currently<br>used as tag for blan=
k password.<br><br>Not compatible with --static-challenge or when username =
and<br>password are inlined or read from a file. In such cases, the user<br=
>hard-code a dummy password in the file instead.<br><br>Change-Id: I788f76e=
6a70a9c20bca3367140d2741bd0551582<br>Signed-off-by: Selva Nair &lt;selva.na=
ir@...277...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M doc/m=
anagement-notes.txt<br>M src/openvpn/init.c<br>M src/openvpn/manage.c<br>M =
src/openvpn/manage.h<br>M src/openvpn/misc.c<br>M src/openvpn/misc.h<br>M s=
rc/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/ssl.c<br>M=
 src/openvpn/ssl.h<br>M src/openvpn/ssl_common.h<br>12 files changed, 92 in=
sertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/48/1548/7</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/do=
c/man-sections/client-options.rst b/doc/man-sections/client-options.rst</sp=
an><br><span>index b9ae7ce..0b7c308 100644</span><br><span>--- a/doc/man-se=
ctions/client-options.rst</span><br><span>+++ b/doc/man-sections/client-opt=
ions.rst</span><br><span>@@ -68,7 +68,9 @@</span><br><span>       auth-user=
-pass up</span><br><span> </span><br><span>   If ``up`` is present, it must=
 be a file containing username/password on 2</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  lines. If the password line is missing, OpenVPN wi=
ll prompt for one.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 lines or a flag named :code:`username-only` to indicate no password</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  should be prompted for. =
In the former case, if the password line is missing</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  in the file, OpenVPN will prompt for on=
e.</span><br><span> </span><br><span>   If ``up`` is omitted, username/pass=
word will be prompted from the</span><br><span>   console.</span><br><span>=
@@ -84,6 +86,20 @@</span><br><span>   where password is optional, and will =
be prompted from the console if</span><br><span>   missing.</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The :code:`user=
name-only` flag is meant to be used with SSO authentication.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  In this case the user will be as=
ked for a username but not password. Instead,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  a dummy password :code:`[[BLANK]]` is generated=
 internally and submitted to</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  the server. See management-notes.txt for how this option affects=
 username/password</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 prompt via the management interface. For the console, it simply eliminates=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the password prom=
pt.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  The :code:`username-only` flag ca=
nnot be used along with embedding username and/or</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  password in the config file, or while readi=
ng them from an external file. In</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  such cases, if only username is relevant and no password pr=
ompt is desired, a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 dummy password like &#39;no_passsword&#39; should be embedded as well. Thi=
s flag is also</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  inc=
ompatible with the ``--static-challenge`` option and legacy ``dynamic chall=
enge``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  protocol.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   T=
he server configuration must specify an ``--auth-user-pass-verify``</span><=
br><span>   script to verify the username/password provided by the client.<=
/span><br><span> </span><br><span>diff --git a/doc/management-notes.txt b/d=
oc/management-notes.txt</span><br><span>index 41e2a91..7da4aaf 100644</span=
><br><span>--- a/doc/management-notes.txt</span><br><span>+++ b/doc/managem=
ent-notes.txt</span><br><span>@@ -304,6 +304,19 @@</span><br><span>     use=
rname &quot;Auth&quot; foo</span><br><span>     password &quot;Auth&quot; b=
ar</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Example 3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#3=
9;Auth&#39; username</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN needs a =
--auth-user-pass username.  The</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  management interface client should respond:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    username &quot;Auth&quot; foo</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  In this case the user should not be prompted for a passwor=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Support for suc=
h username-only prompting is conditional on the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  client announcing a version &gt;=3D 4.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The us=
ername/password itself can be in quotes, and special</span><br><span>   cha=
racters such as double quote or backslash must be escaped,</span><br><span>=
   for example,</span><br><span>@@ -499,6 +512,7 @@</span><br><span> Minimu=
m client version required for certain features is listed below:</span><br><=
span>     &gt;PK_SIGN:[base64]           -- version 2 or greater</span><br>=
<span>     &gt;PK_SIGN:[base64],[alg]     -- version 3 or greater</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;Au=
th&#39; username -- version 4 or greater</span><br><span> </span><br><span>=
 COMMAND -- auth-retry</span><br><span> ---------------------</span><br><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex 1391aa85..4948b8d 100644</span><br><span>--- a/src/openvpn/init.c</span>=
<br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -655,10 +655,10 @@</s=
pan><br><span>         enable_auth_user_pass();</span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span>         auth_user_pass_setup(c-&gt;options.=
auth_user_pass_file, c-&gt;options.auth_user_pass_file_inline,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                             &amp;=
c-&gt;options.sc_info);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                             c-&gt;options.auth_user_pass_username_only=
, &amp;c-&gt;options.sc_info);</span><br><span> #else</span><br><span>     =
    auth_user_pass_setup(c-&gt;options.auth_user_pass_file, c-&gt;options.a=
uth_user_pass_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                             NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                             c-&gt;options.auth_user_p=
ass_username_only, NULL);</span><br><span> #endif</span><br><span>     }</s=
pan><br><span> }</span><br><span>@@ -3376,6 +3376,7 @@</span><br><span>    =
 }</span><br><span>     to.auth_user_pass_file =3D options-&gt;auth_user_pa=
ss_file;</span><br><span>     to.auth_user_pass_file_inline =3D options-&gt=
;auth_user_pass_file_inline;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    to.auth_user_pass_username_only =3D options-&gt;auth_user_pass=
_username_only;</span><br><span>     to.auth_token_generate =3D options-&gt=
;auth_token_generate;</span><br><span>     to.auth_token_lifetime =3D optio=
ns-&gt;auth_token_lifetime;</span><br><span>     to.auth_token_renewal =3D =
options-&gt;auth_token_renewal;</span><br><span>diff --git a/src/openvpn/ma=
nage.c b/src/openvpn/manage.c</span><br><span>index d26c9b2..9e77031 100644=
</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openv=
pn/manage.c</span><br><span>@@ -58,9 +58,6 @@</span><br><span> #define MANA=
GEMENT_ECHO_FLAGS 0</span><br><span> #endif</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* tag for blank username/password =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char b=
lank_up[] =3D &quot;[[BLANK]]&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> /*</span><br><span>  * Management client v=
ersions indicating feature support in client.</span><br><span>  * Append ne=
w values as needed but do not change exisiting ones.</span><br><span>@@ -70=
,6 +67,7 @@</span><br><span>     MCV_DEFAULT =3D 1,</span><br><span>     MC=
V_PKSIGN =3D 2,</span><br><span>     MCV_PKSIGN_ALG =3D 3,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    MCV_USERNAME_ONLY =3D 4,</span><=
br><span> };</span><br><span> </span><br><span> struct management *manageme=
nt; /* GLOBAL */</span><br><span>@@ -740,6 +738,13 @@</span><br><span> {</s=
pan><br><span>     switch (man-&gt;connection.up_query_mode)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e UP_QUERY_USERNAME:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (strlen(man-&gt;connection.up_query.username))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection.up_=
query.defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>         case UP_QUERY_USER_PASS:</span><br><span>           =
  if (!strlen(man-&gt;connection.up_query.username))</span><br><span>      =
       {</span><br><span>@@ -794,7 +799,9 @@</span><br><span> man_query_use=
rname(struct management *man, const char *type, const char *string)</span><=
br><span> {</span><br><span>     const bool needed =3D</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ((man-&gt;connection.up_query_mode=
 =3D=3D UP_QUERY_USER_PASS) &amp;&amp; man-&gt;connection.up_query_type);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ((man-&gt;con=
nection.up_query_mode =3D=3D UP_QUERY_USER_PASS</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          || man-&gt;connection.up_query_mode =
=3D=3D UP_QUERY_USERNAME)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         &amp;&amp; man-&gt;connection.up_query_type);</span><br><spa=
n>     man_query_user_pass(man, type, string, needed, &quot;username&quot;,=
 man-&gt;connection.up_query.username,</span><br><span>                    =
     USER_PASS_LEN);</span><br><span> }</span><br><span>@@ -3558,6 +3565,12=
 @@</span><br><span>             prefix =3D &quot;PASSWORD&quot;;</span><br=
><span>             alert_type =3D &quot;password&quot;;</span><br><span>  =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e if ((man-&gt;connection.client_version &gt;=3D MCV_USERNAME_ONLY) &amp;&a=
mp; (flags &amp; GET_USER_PASS_USERNAME_ONLY))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            up_query_mode =3D UP_QUERY_USERNAME;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            prefix =3D &quot;=
PASSWORD&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        alert_type =3D &quot;username&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         else</span><br>=
<span>         {</span><br><span>             up_query_mode =3D UP_QUERY_US=
ER_PASS;</span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/ma=
nage.h</span><br><span>index 38f437f..e5ad23f 100644</span><br><span>--- a/=
src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><=
span>@@ -264,6 +264,7 @@</span><br><span> #define UP_QUERY_PASS      2</spa=
n><br><span> #define UP_QUERY_NEED_OK   3</span><br><span> #define UP_QUERY=
_NEED_STR  4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 UP_QUERY_USERNAME  5</span><br><span> </span><br><span> /* states */</span=
><br><span> #define MS_INITIAL       0 /* all sockets are closed */</span><=
br><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><sp=
an>index 9ff281c..c00a3ce 100644</span><br><span>--- a/src/openvpn/misc.c</=
span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -215,7 +215,6 @@=
</span><br><span>         {</span><br><span>             msg(M_WARN, &quot;=
Note: previous &#39;%s&#39; credentials failed&quot;, prefix);</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         /*</span><br><=
span>          * Get username/password from management interface?</span><br=
><span>@@ -389,7 +388,7 @@</span><br><span>                     query_user_=
add(BSTR(&amp;user_prompt), up-&gt;username, USER_PASS_LEN, true);</span><b=
r><span>                 }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                if (password_from_stdin)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                if (password_fr=
om_stdin &amp;&amp; !(flags &amp; GET_USER_PASS_USERNAME_ONLY))</span><br><=
span>                 {</span><br><span>                     query_user_add=
(BSTR(&amp;pass_prompt), up-&gt;password, USER_PASS_LEN, false);</span><br>=
<span>                 }</span><br><span>@@ -451,6 +450,12 @@</span><br><sp=
an>             }</span><br><span>         }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Use tag for blank pas=
sword if we are not prompting for one */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (flags &amp; GET_USER_PASS_USERNAME_ONLY)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            strncpy(up-&gt;pass=
word, blank_up, sizeof(up-&gt;password));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>         string_mod(up-&gt;username, CC_PRINT,=
 CC_CRLF, 0);</span><br><span>         string_mod(up-&gt;password, CC_PRINT=
, CC_CRLF, 0);</span><br><span> </span><br><span>diff --git a/src/openvpn/m=
isc.h b/src/openvpn/misc.h</span><br><span>index e9cfadb..76bcac3 100644</s=
pan><br><span>--- a/src/openvpn/misc.h</span><br><span>+++ b/src/openvpn/mi=
sc.h</span><br><span>@@ -48,6 +48,9 @@</span><br><span>  * Get and store a =
username/password</span><br><span>  */</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* tag for blank username/password */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char bl=
ank_up[] =3D &quot;[[BLANK]]&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> struct user_pass</span><br><span> {</span=
><br><span>     bool defined;</span><br><span>@@ -123,6 +126,8 @@</span><br=
><span> #define GET_USER_PASS_INLINE_CREDS            (1 &lt;&lt; 10)</span=
><br><span> /** indicates password and response should be concatenated */</=
span><br><span> #define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1 &lt;&lt; 1=
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** indicate that=
 only username should be prompted for auth-user-pass */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define GET_USER_PASS_USERNAME_ONLY    =
       (1 &lt;&lt; 12)</span><br><span> </span><br><span> /**</span><br><sp=
an>  * Retrieves the user credentials from various sources depending on the=
 flags.</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/op=
tions.c</span><br><span>index fdbc678..d266c3e 100644</span><br><span>--- a=
/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><b=
r><span>@@ -510,7 +510,8 @@</span><br><span>     &quot;                  up=
 is a file containing the username on the first line,\n&quot;</span><br><sp=
an>     &quot;                  and a password on the second. If either the=
 password or both\n&quot;</span><br><span>     &quot;                  the =
username and the password are omitted OpenVPN will prompt\n&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  for=
 them from console.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;                  for them from console. If [up] is &#39;=
username-only&#39;, only username\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;                  will be prompted for from=
 console or management interface.\n&quot;</span><br><span>     &quot;--pull=
           : Accept certain config file options from the peer as if they\n&=
quot;</span><br><span>     &quot;                  were part of the local c=
onfig file.  Must be specified\n&quot;</span><br><span>     &quot;         =
         when connecting to a &#39;--mode server&#39; remote host.\n&quot;<=
/span><br><span>@@ -3909,6 +3910,12 @@</span><br><span>     {</span><br><sp=
an>         o-&gt;auth_token_renewal =3D o-&gt;renegotiate_seconds;</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (o-&gt;auth_user_pass_username_only &amp;&amp; o-&gt;sc_info.challenge=
_text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;=
&#39;auth-user-pass username-only&#39; cannot be used with static challenge=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>  =
   pre_connect_save(o);</span><br><span> }</span><br><span> </span><br><spa=
n>@@ -7705,7 +7712,13 @@</span><br><span>     else if (streq(p[0], &quot;au=
th-user-pass&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (p[1])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        options-&gt;auth_user_pass_user=
name_only =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (p[1] &amp;&amp; streq(p[1], &quot;username-only&quot;))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;auth_user_pa=
ss_username_only =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            options-&gt;auth_user_pass_file =3D &quot;stdin&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else if (p[1])</span><b=
r><span>         {</span><br><span>             options-&gt;auth_user_pass_=
file =3D p[1];</span><br><span>             options-&gt;auth_user_pass_file=
_inline =3D is_inline;</span><br><span>diff --git a/src/openvpn/options.h b=
/src/openvpn/options.h</span><br><span>index 3d8b505..f4a36fc 100644</span>=
<br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/opt=
ions.h</span><br><span>@@ -557,6 +557,7 @@</span><br><span>     unsigned in=
t push_update_options_found; /* tracks which option types have been reset i=
n current PUSH_UPDATE sequence */</span><br><span>     const char *auth_use=
r_pass_file;</span><br><span>     bool auth_user_pass_file_inline;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool auth_user_pass_user=
name_only;</span><br><span>     struct options_pre_connect *pre_connect;</s=
pan><br><span> </span><br><span>     int scheduled_exit_interval;</span><br=
><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>i=
ndex 69d0e4e..962f5df 100644</span><br><span>--- a/src/openvpn/ssl.c</span>=
<br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -290,7 +290,8 @@</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-auth_user_pass_setup(const char *auth_file,=
 bool is_inline, const struct static_challenge_info *sci)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+auth_user_pass_setup(const char *auth=
_file, bool is_inline, bool username_only,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     const struct static_challenge_i=
nfo *sci)</span><br><span> {</span><br><span>     unsigned int flags =3D GE=
T_USER_PASS_MANAGEMENT;</span><br><span> </span><br><span>@@ -298,6 +299,10=
 @@</span><br><span>     {</span><br><span>         flags |=3D GET_USER_PAS=
S_INLINE_CREDS;</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (username_only)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        flags |=3D GET_USER_PASS_USERNAME_ONLY;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span=
>     if (!auth_user_pass.defined &amp;&amp; !auth_token.defined)</span><br=
><span>     {</span><br><span>@@ -2099,10 +2104,12 @@</span><br><span>     =
{</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         auth_u=
ser_pass_setup(session-&gt;opt-&gt;auth_user_pass_file,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                             session-&gt;=
opt-&gt;auth_user_pass_file_inline, session-&gt;opt-&gt;sci);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                             sess=
ion-&gt;opt-&gt;auth_user_pass_file_inline,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                             session-&gt;opt-&gt;au=
th_user_pass_username_only, session-&gt;opt-&gt;sci);</span><br><span> #els=
e</span><br><span>         auth_user_pass_setup(session-&gt;opt-&gt;auth_us=
er_pass_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                     session-&gt;opt-&gt;auth_user_pass_file_inline, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
          session-&gt;opt-&gt;auth_user_pass_file_inline,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                             session-=
&gt;opt-&gt;auth_user_pass_username_only, NULL);</span><br><span> #endif</s=
pan><br><span>         struct user_pass *up =3D &amp;auth_user_pass;</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ss=
l.h</span><br><span>index 28a3b78..5822336 100644</span><br><span>--- a/src=
/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -=
389,7 +389,7 @@</span><br><span>  * credentials stored in the file, however=
, if is_inline is true then auth_file</span><br><span>  * contains the user=
name/password inline.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void auth_user_pass_setup(const char *auth_file, bool =
is_inline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void auth=
_user_pass_setup(const char *auth_file, bool is_inline, bool username_only,=
</span><br><span>                           const struct static_challenge_i=
nfo *sc_info);</span><br><span> </span><br><span> /*</span><br><span>diff -=
-git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>=
index fba01bb..6f310a5 100644</span><br><span>--- a/src/openvpn/ssl_common.=
h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -396,6 =
+396,7 @@</span><br><span>     const char *export_peer_cert_dir;</span><br>=
<span>     const char *auth_user_pass_file;</span><br><span>     bool auth_=
user_pass_file_inline;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool auth_user_pass_username_only;</span><br><span> </span><br><span=
>     bool auth_token_generate;  /**&lt; Generate auth-tokens on successful=
</span><br><span>                                 * user/pass auth,seet via=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1548?usp=3Demail">change 1548</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1548?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I788f76e6a70a9c20bca3367140d=
2741bd0551582 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1548 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>

</body></html>=

--6krMHs8+kVU=--


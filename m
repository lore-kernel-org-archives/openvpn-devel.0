From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 11:34:06 +0000
References: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <baed64673b4d9f130644694fb3f9fd148c43ff02-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bLQ0K82mDfY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: platform: Do not
 assume uid_t/gid_t are signed
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

--bLQ0K82mDfY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail

to review the following change.


Change subject: platform: Do not assume uid_t/gid_t are signed
......................................................................

platform: Do not assume uid_t/gid_t are signed

uid_t/gid_t are int on many platform but unsigned
on at least Linux. So rewrite the code in a way that
does not make any assumptions about the types. Mainly
this means storing the information whether the value
is valid in a separate bool and not in the value
itself.

Note that this changes the return behavior of
platform_{user,group}_get but a review of the
callers determined that this makes no actual
difference.

Change-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/platform.c
M src/openvpn/platform.h
M src/openvpn/socket.c
M src/openvpn/socket.h
6 files changed, 29 insertions(+), 64 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1206/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c675e95..bc1631c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1838,25 +1838,26 @@
 static bool
 man_verify_unix_peer_uid_gid(struct management *man, const socket_descript=
or_t sd)
 {
-    if (socket_defined(sd) && (man->settings.client_uid !=3D -1 || man->se=
ttings.client_gid !=3D -1))
+    if (socket_defined(sd) && (man->settings.user.user_valid || man->setti=
ngs.group.group_valid))
     {
         static const char err_prefix[] =3D
             "MANAGEMENT: unix domain socket client connection rejected --";
-        int uid, gid;
+        uid_t uid;
+        gid_t gid;
         if (unix_socket_get_peer_uid_gid(man->connection.sd_cli, &uid, &gi=
d))
         {
-            if (man->settings.client_uid !=3D -1 && man->settings.client_u=
id !=3D uid)
+            if (man->settings.user.user_valid && man->settings.user.uid !=
=3D uid)
             {
                 msg(D_MANAGEMENT,
                     "%s UID of socket peer (%d) doesn't match required val=
ue (%d) as given by --management-client-user",
-                    err_prefix, uid, man->settings.client_uid);
+                    err_prefix, uid, man->settings.user.uid);
                 return false;
             }
-            if (man->settings.client_gid !=3D -1 && man->settings.client_g=
id !=3D gid)
+            if (man->settings.group.group_valid && man->settings.group.gid=
 !=3D gid)
             {
                 msg(D_MANAGEMENT,
                     "%s GID of socket peer (%d) doesn't match required val=
ue (%d) as given by --management-client-group",
-                    err_prefix, gid, man->settings.client_gid);
+                    err_prefix, gid, man->settings.group.gid);
                 return false;
             }
         }
@@ -2524,8 +2525,6 @@
         CLEAR(*ms);

         ms->flags =3D flags;
-        ms->client_uid =3D -1;
-        ms->client_gid =3D -1;

         /*
          * Get username/password
@@ -2535,27 +2534,21 @@
             get_user_pass(&ms->up, pass_file, "Management", GET_USER_PASS_=
PASSWORD_ONLY);
         }

+#if UNIX_SOCK_SUPPORT
         /*
          * lookup client UID/GID if specified
          */
         if (client_user)
         {
-            struct platform_state_user s;
-            platform_user_get(client_user, &s);
-            ms->client_uid =3D platform_state_user_uid(&s);
-            msg(D_MANAGEMENT, "MANAGEMENT: client_uid=3D%d", ms->client_ui=
d);
-            ASSERT(ms->client_uid >=3D 0);
+            ASSERT(platform_user_get(client_user, &ms->user));
+            msg(D_MANAGEMENT, "MANAGEMENT: client_uid=3D%d", ms->user.uid);
         }
         if (client_group)
         {
-            struct platform_state_group s;
-            platform_group_get(client_group, &s);
-            ms->client_gid =3D platform_state_group_gid(&s);
-            msg(D_MANAGEMENT, "MANAGEMENT: client_gid=3D%d", ms->client_gi=
d);
-            ASSERT(ms->client_gid >=3D 0);
+            ASSERT(platform_group_get(client_group, &ms->group));
+            msg(D_MANAGEMENT, "MANAGEMENT: client_gid=3D%d", ms->group.gid=
);
         }

-#if UNIX_SOCK_SUPPORT
         if (ms->flags & MF_UNIX_SOCK)
         {
             sockaddr_unix_init(&ms->local_unix, addr);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index bff96d3..a31eb06 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -242,14 +242,14 @@
     struct addrinfo *local;
 #if UNIX_SOCK_SUPPORT
     struct sockaddr_un local_unix;
+    struct platform_state_user user;
+    struct platform_state_group group;
 #endif
     bool management_over_tunnel;
     struct user_pass up;
     int log_history_cache;
     int echo_buffer_size;
     int state_buffer_size;
-    int client_uid;
-    int client_gid;

 /* flags for handling the management interface "signal" command */
 #define MANSIG_IGNORE_USR1_HUP  (1u << 0)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 880d14e..a1ffdaf 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -39,7 +39,7 @@

 #include "platform.h"

-#if _WIN32
+#ifdef _WIN32
 #include <direct.h>
 #endif

@@ -79,12 +79,10 @@
 bool
 platform_user_get(const char *username, struct platform_state_user *state)
 {
-    bool ret =3D false;
     CLEAR(*state);
     if (username)
     {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-        state->uid =3D -1;
         const struct passwd *pw =3D getpwnam(username);
         if (!pw)
         {
@@ -93,23 +91,23 @@
         else
         {
             state->uid =3D pw->pw_uid;
+            state->user_valid =3D true;
         }
         state->username =3D username;
-        ret =3D true;
 #else /* if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID) */
         msg(M_FATAL,
             "cannot get UID for user %s -- platform lacks getpwname() or s=
etuid() system calls",
             username);
 #endif
     }
-    return ret;
+    return state->user_valid;
 }

 static void
 platform_user_set(const struct platform_state_user *state)
 {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-    if (state->username && state->uid >=3D 0)
+    if (state->username && state->user_valid)
     {
         if (setuid(state->uid))
         {
@@ -125,12 +123,10 @@
 bool
 platform_group_get(const char *groupname, struct platform_state_group *sta=
te)
 {
-    bool ret =3D false;
     CLEAR(*state);
     if (groupname)
     {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-        state->gid =3D -1;
         const struct group *gr =3D getgrnam(groupname);
         if (!gr)
         {
@@ -139,23 +135,23 @@
         else
         {
             state->gid =3D gr->gr_gid;
+            state->group_valid =3D true;
         }
         state->groupname =3D groupname;
-        ret =3D true;
 #else /* if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID) */
         msg(M_FATAL,
             "cannot get GID for group %s -- platform lacks getgrnam() or s=
etgid() system calls",
             groupname);
 #endif
     }
-    return ret;
+    return state->group_valid;
 }

 static void
 platform_group_set(const struct platform_state_group *state)
 {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-    if (state->groupname && state->gid >=3D 0)
+    if (state->groupname && state->group_valid)
     {
         if (setgid(state->gid))
         {
@@ -237,13 +233,13 @@
      * new_uid/new_gid defaults to -1, which will not make
      * libcap-ng change the UID/GID unless configured
      */
-    if (group_state->groupname && group_state->gid >=3D 0)
+    if (group_state->groupname && group_state->group_valid)
     {
-        new_gid =3D group_state->gid;
+        new_gid =3D (int)group_state->gid;
     }
-    if (user_state->username && user_state->uid >=3D 0)
+    if (user_state->username && user_state->user_valid)
     {
-        new_uid =3D user_state->uid;
+        new_uid =3D (int)user_state->uid;
     }

     /* Prepare capabilities before dropping UID/GID */
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index f1a2b01..0cb25f5 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -64,9 +64,8 @@
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
     const char *username;
     uid_t uid;
-#else
-    int dummy;
 #endif
+    bool user_valid;
 };

 /* Get/Set GID of process */
@@ -76,9 +75,8 @@
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
     const char *groupname;
     gid_t gid;
-#else
-    int dummy;
 #endif
+    bool group_valid;
 };

 bool platform_user_get(const char *username, struct platform_state_user *s=
tate);
@@ -89,28 +87,6 @@
                              const struct platform_state_group *group_stat=
e, struct context *c);


-/*
- * Extract UID or GID
- */
-
-static inline int
-platform_state_user_uid(const struct platform_state_user *s)
-{
-#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-    return s->uid;
-#endif
-    return -1;
-}
-
-static inline int
-platform_state_group_gid(const struct platform_state_group *s)
-{
-#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-    return s->gid;
-#endif
-    return -1;
-}
-
 void platform_chroot(const char *path);

 void platform_nice(int niceval);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index afedf5d..94f16c7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3073,7 +3073,7 @@
 }

 bool
-unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *=
gid)
+unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, uid_t *uid, gid=
_t *gid)
 {
 #ifdef HAVE_GETPEEREID
     uid_t u;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e45981f..2c79a11 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -371,7 +371,7 @@

 void socket_delete_unix(const struct sockaddr_un *local);

-bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, =
int *gid);
+bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, uid_t *uid=
, gid_t *gid);

 #endif /* if UNIX_SOCK_SUPPORT */


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3
Gerrit-Change-Number: 1206
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--bLQ0K82mDfY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">platform: Do not assume uid_t/gid_t are signed<br><br>uid_t/=
gid_t are int on many platform but unsigned<br>on at least Linux. So rewrit=
e the code in a way that<br>does not make any assumptions about the types. =
Mainly<br>this means storing the information whether the value<br>is valid =
in a separate bool and not in the value<br>itself.<br><br>Note that this ch=
anges the return behavior of<br>platform_{user,group}_get but a review of t=
he<br>callers determined that this makes no actual<br>difference.<br><br>Ch=
ange-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/manage.c<br>M =
src/openvpn/manage.h<br>M src/openvpn/platform.c<br>M src/openvpn/platform.=
h<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>6 files changed, 2=
9 insertions(+), 64 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/06/1206/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/man=
age.c b/src/openvpn/manage.c</span><br><span>index c675e95..bc1631c 100644<=
/span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvp=
n/manage.c</span><br><span>@@ -1838,25 +1838,26 @@</span><br><span> static =
bool</span><br><span> man_verify_unix_peer_uid_gid(struct management *man, =
const socket_descriptor_t sd)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (socket_defined(sd) &amp;&amp; (man-&gt;s=
ettings.client_uid !=3D -1 || man-&gt;settings.client_gid !=3D -1))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (socket_defined(sd) =
&amp;&amp; (man-&gt;settings.user.user_valid || man-&gt;settings.group.grou=
p_valid))</span><br><span>     {</span><br><span>         static const char=
 err_prefix[] =3D</span><br><span>             &quot;MANAGEMENT: unix domai=
n socket client connection rejected --&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int uid, gid;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uid_t uid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gid_t gid;</span><br><span>         if (un=
ix_socket_get_peer_uid_gid(man-&gt;connection.sd_cli, &amp;uid, &amp;gid))<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (man-&gt;settings.client_uid !=3D -1 &amp;&amp; man-&gt=
;settings.client_uid !=3D uid)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (man-&gt;settings.user.user_valid &amp;&amp; man-=
&gt;settings.user.uid !=3D uid)</span><br><span>             {</span><br><s=
pan>                 msg(D_MANAGEMENT,</span><br><span>                    =
 &quot;%s UID of socket peer (%d) doesn&#39;t match required value (%d) as =
given by --management-client-user&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    err_prefix, uid, man-&gt;settings.cl=
ient_uid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           err_prefix, uid, man-&gt;settings.user.uid);</span><br><span>   =
              return false;</span><br><span>             }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (man-&gt;settings.clien=
t_gid !=3D -1 &amp;&amp; man-&gt;settings.client_gid !=3D gid)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;settings=
.group.group_valid &amp;&amp; man-&gt;settings.group.gid !=3D gid)</span><b=
r><span>             {</span><br><span>                 msg(D_MANAGEMENT,</=
span><br><span>                     &quot;%s GID of socket peer (%d) doesn&=
#39;t match required value (%d) as given by --management-client-group&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
err_prefix, gid, man-&gt;settings.client_gid);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    err_prefix, gid, man-&gt;set=
tings.group.gid);</span><br><span>                 return false;</span><br>=
<span>             }</span><br><span>         }</span><br><span>@@ -2524,8 =
+2525,6 @@</span><br><span>         CLEAR(*ms);</span><br><span> </span><br=
><span>         ms-&gt;flags =3D flags;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ms-&gt;client_uid =3D -1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ms-&gt;client_gid =3D -1;</span><br=
><span> </span><br><span>         /*</span><br><span>          * Get userna=
me/password</span><br><span>@@ -2535,27 +2534,21 @@</span><br><span>       =
      get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_=
USER_PASS_PASSWORD_ONLY);</span><br><span>         }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</s=
pan><br><span>         /*</span><br><span>          * lookup client UID/GID=
 if specified</span><br><span>          */</span><br><span>         if (cli=
ent_user)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            struct platform_state_user s;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            platform_user_get(client_use=
r, &amp;s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  ms-&gt;client_uid =3D platform_state_user_uid(&amp;s);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(D_MANAGEMENT, &quot;MANA=
GEMENT: client_uid=3D%d&quot;, ms-&gt;client_uid);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            ASSERT(ms-&gt;client_uid &gt;=3D 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSER=
T(platform_user_get(client_user, &amp;ms-&gt;user));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT, &quot;MANAG=
EMENT: client_uid=3D%d&quot;, ms-&gt;user.uid);</span><br><span>         }<=
/span><br><span>         if (client_group)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct platform=
_state_group s;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      platform_group_get(client_group, &amp;s);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            ms-&gt;client_gid =3D platform_state_=
group_gid(&amp;s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(D_MANAGEMENT, &quot;MANAGEMENT: client_gid=3D%d&quot;, ms-&gt;=
client_gid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   ASSERT(ms-&gt;client_gid &gt;=3D 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            ASSERT(platform_group_get(client_group, &am=
p;ms-&gt;group));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(D_MANAGEMENT, &quot;MANAGEMENT: client_gid=3D%d&quot;, ms-&gt=
;group.gid);</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if UNIX_SOCK_SUPPORT</span><br><span> =
        if (ms-&gt;flags &amp; MF_UNIX_SOCK)</span><br><span>         {</sp=
an><br><span>             sockaddr_unix_init(&amp;ms-&gt;local_unix, addr);=
</span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</=
span><br><span>index bff96d3..a31eb06 100644</span><br><span>--- a/src/open=
vpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ =
-242,14 +242,14 @@</span><br><span>     struct addrinfo *local;</span><br><=
span> #if UNIX_SOCK_SUPPORT</span><br><span>     struct sockaddr_un local_u=
nix;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct plat=
form_state_user user;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct platform_state_group group;</span><br><span> #endif</span><br>=
<span>     bool management_over_tunnel;</span><br><span>     struct user_pa=
ss up;</span><br><span>     int log_history_cache;</span><br><span>     int=
 echo_buffer_size;</span><br><span>     int state_buffer_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int client_uid;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int client_gid;</span><br><span>=
 </span><br><span> /* flags for handling the management interface &quot;sig=
nal&quot; command */</span><br><span> #define MANSIG_IGNORE_USR1_HUP  (1u &=
lt;&lt; 0)</span><br><span>diff --git a/src/openvpn/platform.c b/src/openvp=
n/platform.c</span><br><span>index 880d14e..a1ffdaf 100644</span><br><span>=
--- a/src/openvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c</=
span><br><span>@@ -39,7 +39,7 @@</span><br><span> </span><br><span> #includ=
e &quot;platform.h&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if _WIN32</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef _WIN32</span><br><span> #include &lt;direct.h&gt;</span>=
<br><span> #endif</span><br><span> </span><br><span>@@ -79,12 +79,10 @@</sp=
an><br><span> bool</span><br><span> platform_user_get(const char *username,=
 struct platform_state_user *state)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span>  =
   CLEAR(*state);</span><br><span>     if (username)</span><br><span>     {=
</span><br><span> #if defined(HAVE_GETPWNAM) &amp;&amp; defined(HAVE_SETUID=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        state-&gt;ui=
d =3D -1;</span><br><span>         const struct passwd *pw =3D getpwnam(use=
rname);</span><br><span>         if (!pw)</span><br><span>         {</span>=
<br><span>@@ -93,23 +91,23 @@</span><br><span>         else</span><br><span=
>         {</span><br><span>             state-&gt;uid =3D pw-&gt;pw_uid;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            state-&gt=
;user_valid =3D true;</span><br><span>         }</span><br><span>         s=
tate-&gt;username =3D username;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        ret =3D true;</span><br><span> #else /* if defined(HAVE_G=
ETPWNAM) &amp;&amp; defined(HAVE_SETUID) */</span><br><span>         msg(M_=
FATAL,</span><br><span>             &quot;cannot get UID for user %s -- pla=
tform lacks getpwname() or setuid() system calls&quot;,</span><br><span>   =
          username);</span><br><span> #endif</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return state-&gt;user_valid;<=
/span><br><span> }</span><br><span> </span><br><span> static void</span><br=
><span> platform_user_set(const struct platform_state_user *state)</span><b=
r><span> {</span><br><span> #if defined(HAVE_GETPWNAM) &amp;&amp; defined(H=
AVE_SETUID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (st=
ate-&gt;username &amp;&amp; state-&gt;uid &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (state-&gt;username &amp;&amp; sta=
te-&gt;user_valid)</span><br><span>     {</span><br><span>         if (setu=
id(state-&gt;uid))</span><br><span>         {</span><br><span>@@ -125,12 +1=
23,10 @@</span><br><span> bool</span><br><span> platform_group_get(const ch=
ar *groupname, struct platform_state_group *state)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</sp=
an><br><span>     CLEAR(*state);</span><br><span>     if (groupname)</span>=
<br><span>     {</span><br><span> #if defined(HAVE_GETGRNAM) &amp;&amp; def=
ined(HAVE_SETGID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    state-&gt;gid =3D -1;</span><br><span>         const struct group *gr =
=3D getgrnam(groupname);</span><br><span>         if (!gr)</span><br><span>=
         {</span><br><span>@@ -139,23 +135,23 @@</span><br><span>         e=
lse</span><br><span>         {</span><br><span>             state-&gt;gid =
=3D gr-&gt;gr_gid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           state-&gt;group_valid =3D true;</span><br><span>         }</span=
><br><span>         state-&gt;groupname =3D groupname;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ret =3D true;</span><br><span> #el=
se /* if defined(HAVE_GETGRNAM) &amp;&amp; defined(HAVE_SETGID) */</span><b=
r><span>         msg(M_FATAL,</span><br><span>             &quot;cannot get=
 GID for group %s -- platform lacks getgrnam() or setgid() system calls&quo=
t;,</span><br><span>             groupname);</span><br><span> #endif</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n state-&gt;group_valid;</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span> platform_group_set(const struct platform_s=
tate_group *state)</span><br><span> {</span><br><span> #if defined(HAVE_GET=
GRNAM) &amp;&amp; defined(HAVE_SETGID)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (state-&gt;groupname &amp;&amp; state-&gt;gid &gt;=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (state=
-&gt;groupname &amp;&amp; state-&gt;group_valid)</span><br><span>     {</sp=
an><br><span>         if (setgid(state-&gt;gid))</span><br><span>         {=
</span><br><span>@@ -237,13 +233,13 @@</span><br><span>      * new_uid/new_=
gid defaults to -1, which will not make</span><br><span>      * libcap-ng c=
hange the UID/GID unless configured</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (group_state-&gt;groupname &a=
mp;&amp; group_state-&gt;gid &gt;=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (group_state-&gt;groupname &amp;&amp; group_stat=
e-&gt;group_valid)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        new_gid =3D group_state-&gt;gid;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        new_gid =3D (int)group_sta=
te-&gt;gid;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (user_state-&gt;username &amp;&amp; user_state-&gt;uid =
&gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (u=
ser_state-&gt;username &amp;&amp; user_state-&gt;user_valid)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        new_u=
id =3D user_state-&gt;uid;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        new_uid =3D (int)user_state-&gt;uid;</span><br><span>     }<=
/span><br><span> </span><br><span>     /* Prepare capabilities before dropp=
ing UID/GID */</span><br><span>diff --git a/src/openvpn/platform.h b/src/op=
envpn/platform.h</span><br><span>index f1a2b01..0cb25f5 100644</span><br><s=
pan>--- a/src/openvpn/platform.h</span><br><span>+++ b/src/openvpn/platform=
.h</span><br><span>@@ -64,9 +64,8 @@</span><br><span> #if defined(HAVE_GETP=
WNAM) &amp;&amp; defined(HAVE_SETUID)</span><br><span>     const char *user=
name;</span><br><span>     uid_t uid;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int dummy;</span><br><span> #endif</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool user_valid;</span><br><span> };</span><br><span=
> </span><br><span> /* Get/Set GID of process */</span><br><span>@@ -76,9 +=
75,8 @@</span><br><span> #if defined(HAVE_GETGRNAM) &amp;&amp; defined(HAVE=
_SETGID)</span><br><span>     const char *groupname;</span><br><span>     g=
id_t gid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int dummy;</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
group_valid;</span><br><span> };</span><br><span> </span><br><span> bool pl=
atform_user_get(const char *username, struct platform_state_user *state);</=
span><br><span>@@ -89,28 +87,6 @@</span><br><span>                         =
     const struct platform_state_group *group_state, struct context *c);</s=
pan><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Extr=
act UID or GID</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-platform_state_user_uid(const struct platform_stat=
e_user *s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_GETPWNAM) &amp=
;&amp; defined(HAVE_SETUID)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return s-&gt;uid;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-platform_state_group_gid(const struct platform_state_group *s=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_GETGRNAM) &amp;&amp; de=
fined(HAVE_SETGID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return s-&gt;gid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return -1;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void platform_chroot(cons=
t char *path);</span><br><span> </span><br><span> void platform_nice(int ni=
ceval);</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/soc=
ket.c</span><br><span>index afedf5d..94f16c7 100644</span><br><span>--- a/s=
rc/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><s=
pan>@@ -3073,7 +3073,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unix_socket_=
get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *gid)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+unix_socket_get_peer_uid_gid=
(const socket_descriptor_t sd, uid_t *uid, gid_t *gid)</span><br><span> {</=
span><br><span> #ifdef HAVE_GETPEEREID</span><br><span>     uid_t u;</span>=
<br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><b=
r><span>index e45981f..2c79a11 100644</span><br><span>--- a/src/openvpn/soc=
ket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -371,7 =
+371,7 @@</span><br><span> </span><br><span> void socket_delete_unix(const =
struct sockaddr_un *local);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-bool unix_socket_get_peer_uid_gid(const socket_desc=
riptor_t sd, int *uid, int *gid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool unix_socket_get_peer_uid_gid(const socket_descriptor_t s=
d, uid_t *uid, gid_t *gid);</span><br><span> </span><br><span> #endif /* if=
 UNIX_SOCK_SUPPORT */</span><br><span> </span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=
=3Demail">change 1206</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc79=
4c7abd12408f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1206 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--bLQ0K82mDfY=--


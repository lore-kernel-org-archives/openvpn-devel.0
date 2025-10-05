From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 5 Oct 2025 20:42:00 +0000
In-Reply-To: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
References: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <16ed8382eabf91b899a071f5ecb68975a2f771dd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohEuSQkNqlE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ohEuSQkNqlE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


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
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1206
Message-Id: <20251003100602.375062-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
266.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/platform.c
M src/openvpn/platform.h
M src/openvpn/socket.c
M src/openvpn/socket.h
6 files changed, 29 insertions(+), 64 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1206/3

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5a41a0f..1cb5c63 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1847,25 +1847,26 @@
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
@@ -2542,8 +2543,6 @@
         CLEAR(*ms);

         ms->flags =3D flags;
-        ms->client_uid =3D -1;
-        ms->client_gid =3D -1;

         /*
          * Get username/password
@@ -2553,27 +2552,21 @@
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
index 5fcf820..f71d891 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3082,7 +3082,7 @@
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3
Gerrit-Change-Number: 1206
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ohEuSQkNqlE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by MaxF</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">platform: Do not assume uid_t/gid_t =
are signed<br><br>uid_t/gid_t are int on many platform but unsigned<br>on a=
t least Linux. So rewrite the code in a way that<br>does not make any assum=
ptions about the types. Mainly<br>this means storing the information whethe=
r the value<br>is valid in a separate bool and not in the value<br>itself.<=
br><br>Note that this changes the return behavior of<br>platform_{user,grou=
p}_get but a review of the<br>callers determined that this makes no actual<=
br>difference.<br><br>Change-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: M=
axF &lt;max@...2606...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1206<br>Message-Id: &lt;20251003100602.375062-1-frank@...2641...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g33266.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/platfor=
m.c<br>M src/openvpn/platform.h<br>M src/openvpn/socket.c<br>M src/openvpn/=
socket.h<br>6 files changed, 29 insertions(+), 64 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/06/1206/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c=
</span><br><span>index 5a41a0f..1cb5c63 100644</span><br><span>--- a/src/op=
envpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@=
@ -1847,25 +1847,26 @@</span><br><span> static bool</span><br><span> man_ve=
rify_unix_peer_uid_gid(struct management *man, const socket_descriptor_t sd=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (socket_defined(sd) &amp;&amp; (man-&gt;settings.client_uid !=3D -1 |=
| man-&gt;settings.client_gid !=3D -1))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (socket_defined(sd) &amp;&amp; (man-&gt;settings=
.user.user_valid || man-&gt;settings.group.group_valid))</span><br><span>  =
   {</span><br><span>         static const char err_prefix[] =3D</span><br>=
<span>             &quot;MANAGEMENT: unix domain socket client connection r=
ejected --&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    int uid, gid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uid_t uid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     gid_t gid;</span><br><span>         if (unix_socket_get_peer_uid_gid(m=
an-&gt;connection.sd_cli, &amp;uid, &amp;gid))</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (man-&gt=
;settings.client_uid !=3D -1 &amp;&amp; man-&gt;settings.client_uid !=3D ui=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (m=
an-&gt;settings.user.user_valid &amp;&amp; man-&gt;settings.user.uid !=3D u=
id)</span><br><span>             {</span><br><span>                 msg(D_M=
ANAGEMENT,</span><br><span>                     &quot;%s UID of socket peer=
 (%d) doesn&#39;t match required value (%d) as given by --management-client=
-user&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           err_prefix, uid, man-&gt;settings.client_uid);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    err_prefix, uid, =
man-&gt;settings.user.uid);</span><br><span>                 return false;<=
/span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (man-&gt;settings.client_gid !=3D -1 &amp;&amp; man=
-&gt;settings.client_gid !=3D gid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (man-&gt;settings.group.group_valid &amp;&amp=
; man-&gt;settings.group.gid !=3D gid)</span><br><span>             {</span=
><br><span>                 msg(D_MANAGEMENT,</span><br><span>             =
        &quot;%s GID of socket peer (%d) doesn&#39;t match required value (=
%d) as given by --management-client-group&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    err_prefix, gid, man-&gt;set=
tings.client_gid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   err_prefix, gid, man-&gt;settings.group.gid);</span><br>=
<span>                 return false;</span><br><span>             }</span><=
br><span>         }</span><br><span>@@ -2542,8 +2543,6 @@</span><br><span> =
        CLEAR(*ms);</span><br><span> </span><br><span>         ms-&gt;flags=
 =3D flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
-&gt;client_uid =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ms-&gt;client_gid =3D -1;</span><br><span> </span><br><span>     =
    /*</span><br><span>          * Get username/password</span><br><span>@@=
 -2553,27 +2552,21 @@</span><br><span>             get_user_pass(&amp;ms-&g=
t;up, pass_file, &quot;Management&quot;, GET_USER_PASS_PASSWORD_ONLY);</spa=
n><br><span>         }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span>         /*</spa=
n><br><span>          * lookup client UID/GID if specified</span><br><span>=
          */</span><br><span>         if (client_user)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            str=
uct platform_state_user s;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            platform_user_get(client_user, &amp;s);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ms-&gt;client_uid =3D platfo=
rm_state_user_uid(&amp;s);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(D_MANAGEMENT, &quot;MANAGEMENT: client_uid=3D%d&quot;,=
 ms-&gt;client_uid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           ASSERT(ms-&gt;client_uid &gt;=3D 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            ASSERT(platform_user_get(client_use=
r, &amp;ms-&gt;user));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_MANAGEMENT, &quot;MANAGEMENT: client_uid=3D%d&quot;, m=
s-&gt;user.uid);</span><br><span>         }</span><br><span>         if (cl=
ient_group)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            struct platform_state_group s;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            platform_group_get(client=
_group, &amp;s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       ms-&gt;client_gid =3D platform_state_group_gid(&amp;s);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MANAGEMENT, &quo=
t;MANAGEMENT: client_gid=3D%d&quot;, ms-&gt;client_gid);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ASSERT(ms-&gt;client_gid &gt=
;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ASSERT(platform_group_get(client_group, &amp;ms-&gt;group));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT, &qu=
ot;MANAGEMENT: client_gid=3D%d&quot;, ms-&gt;group.gid);</span><br><span>  =
       }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if UNIX_SOCK_SUPPORT</span><br><span>         if (ms-&gt;flags &amp; =
MF_UNIX_SOCK)</span><br><span>         {</span><br><span>             socka=
ddr_unix_init(&amp;ms-&gt;local_unix, addr);</span><br><span>diff --git a/s=
rc/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index bff96d3..a=
31eb06 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><span>++=
+ b/src/openvpn/manage.h</span><br><span>@@ -242,14 +242,14 @@</span><br><s=
pan>     struct addrinfo *local;</span><br><span> #if UNIX_SOCK_SUPPORT</sp=
an><br><span>     struct sockaddr_un local_unix;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct platform_state_user user;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct platform_state_gro=
up group;</span><br><span> #endif</span><br><span>     bool management_over=
_tunnel;</span><br><span>     struct user_pass up;</span><br><span>     int=
 log_history_cache;</span><br><span>     int echo_buffer_size;</span><br><s=
pan>     int state_buffer_size;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int client_uid;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int client_gid;</span><br><span> </span><br><span> /* flags for=
 handling the management interface &quot;signal&quot; command */</span><br>=
<span> #define MANSIG_IGNORE_USR1_HUP  (1u &lt;&lt; 0)</span><br><span>diff=
 --git a/src/openvpn/platform.c b/src/openvpn/platform.c</span><br><span>in=
dex 880d14e..a1ffdaf 100644</span><br><span>--- a/src/openvpn/platform.c</s=
pan><br><span>+++ b/src/openvpn/platform.c</span><br><span>@@ -39,7 +39,7 @=
@</span><br><span> </span><br><span> #include &quot;platform.h&quot;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if _WIN32=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span=
><br><span> #include &lt;direct.h&gt;</span><br><span> #endif</span><br><sp=
an> </span><br><span>@@ -79,12 +79,10 @@</span><br><span> bool</span><br><s=
pan> platform_user_get(const char *username, struct platform_state_user *st=
ate)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    bool ret =3D false;</span><br><span>     CLEAR(*state);</span><br><sp=
an>     if (username)</span><br><span>     {</span><br><span> #if defined(H=
AVE_GETPWNAM) &amp;&amp; defined(HAVE_SETUID)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        state-&gt;uid =3D -1;</span><br><span>     =
    const struct passwd *pw =3D getpwnam(username);</span><br><span>       =
  if (!pw)</span><br><span>         {</span><br><span>@@ -93,23 +91,23 @@</=
span><br><span>         else</span><br><span>         {</span><br><span>   =
          state-&gt;uid =3D pw-&gt;pw_uid;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            state-&gt;user_valid =3D true;</span><br=
><span>         }</span><br><span>         state-&gt;username =3D username;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D true;=
</span><br><span> #else /* if defined(HAVE_GETPWNAM) &amp;&amp; defined(HAV=
E_SETUID) */</span><br><span>         msg(M_FATAL,</span><br><span>        =
     &quot;cannot get UID for user %s -- platform lacks getpwname() or setu=
id() system calls&quot;,</span><br><span>             username);</span><br>=
<span> #endif</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return state-&gt;user_valid;</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span> platform_user_set(const=
 struct platform_state_user *state)</span><br><span> {</span><br><span> #if=
 defined(HAVE_GETPWNAM) &amp;&amp; defined(HAVE_SETUID)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (state-&gt;username &amp;&amp; sta=
te-&gt;uid &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (state-&gt;username &amp;&amp; state-&gt;user_valid)</span><br><sp=
an>     {</span><br><span>         if (setuid(state-&gt;uid))</span><br><sp=
an>         {</span><br><span>@@ -125,12 +123,10 @@</span><br><span> bool</=
span><br><span> platform_group_get(const char *groupname, struct platform_s=
tate_group *state)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    bool ret =3D false;</span><br><span>     CLEAR(*state);=
</span><br><span>     if (groupname)</span><br><span>     {</span><br><span=
> #if defined(HAVE_GETGRNAM) &amp;&amp; defined(HAVE_SETGID)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        state-&gt;gid =3D -1;</span>=
<br><span>         const struct group *gr =3D getgrnam(groupname);</span><b=
r><span>         if (!gr)</span><br><span>         {</span><br><span>@@ -13=
9,23 +135,23 @@</span><br><span>         else</span><br><span>         {</s=
pan><br><span>             state-&gt;gid =3D gr-&gt;gr_gid;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            state-&gt;group_valid =
=3D true;</span><br><span>         }</span><br><span>         state-&gt;gro=
upname =3D groupname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ret =3D true;</span><br><span> #else /* if defined(HAVE_GETGRNAM) &=
amp;&amp; defined(HAVE_SETGID) */</span><br><span>         msg(M_FATAL,</sp=
an><br><span>             &quot;cannot get GID for group %s -- platform lac=
ks getgrnam() or setgid() system calls&quot;,</span><br><span>             =
groupname);</span><br><span> #endif</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return state-&gt;group_valid;</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span>=
 platform_group_set(const struct platform_state_group *state)</span><br><sp=
an> {</span><br><span> #if defined(HAVE_GETGRNAM) &amp;&amp; defined(HAVE_S=
ETGID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (state-&=
gt;groupname &amp;&amp; state-&gt;gid &gt;=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (state-&gt;groupname &amp;&amp; state-&=
gt;group_valid)</span><br><span>     {</span><br><span>         if (setgid(=
state-&gt;gid))</span><br><span>         {</span><br><span>@@ -237,13 +233,=
13 @@</span><br><span>      * new_uid/new_gid defaults to -1, which will no=
t make</span><br><span>      * libcap-ng change the UID/GID unless configur=
ed</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (group_state-&gt;groupname &amp;&amp; group_state-&gt;gid &gt;=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (group=
_state-&gt;groupname &amp;&amp; group_state-&gt;group_valid)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        new_g=
id =3D group_state-&gt;gid;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        new_gid =3D (int)group_state-&gt;gid;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (user_state-&=
gt;username &amp;&amp; user_state-&gt;uid &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (user_state-&gt;username &amp;&amp=
; user_state-&gt;user_valid)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        new_uid =3D user_state-&gt;uid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        new_uid =3D (in=
t)user_state-&gt;uid;</span><br><span>     }</span><br><span> </span><br><s=
pan>     /* Prepare capabilities before dropping UID/GID */</span><br><span=
>diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h</span><br><sp=
an>index f1a2b01..0cb25f5 100644</span><br><span>--- a/src/openvpn/platform=
.h</span><br><span>+++ b/src/openvpn/platform.h</span><br><span>@@ -64,9 +6=
4,8 @@</span><br><span> #if defined(HAVE_GETPWNAM) &amp;&amp; defined(HAVE_=
SETUID)</span><br><span>     const char *username;</span><br><span>     uid=
_t uid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int dummy;</span><br><span=
> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool us=
er_valid;</span><br><span> };</span><br><span> </span><br><span> /* Get/Set=
 GID of process */</span><br><span>@@ -76,9 +75,8 @@</span><br><span> #if d=
efined(HAVE_GETGRNAM) &amp;&amp; defined(HAVE_SETGID)</span><br><span>     =
const char *groupname;</span><br><span>     gid_t gid;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int dummy;</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool group_valid;</span><br><span> =
};</span><br><span> </span><br><span> bool platform_user_get(const char *us=
ername, struct platform_state_user *state);</span><br><span>@@ -89,28 +87,6=
 @@</span><br><span>                              const struct platform_sta=
te_group *group_state, struct context *c);</span><br><span> </span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Extract UID or GID</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-platf=
orm_state_user_uid(const struct platform_state_user *s)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(HAVE_GETPWNAM) &amp;&amp; defined(HAVE_SETUID)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return s-&gt;uid;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return -1;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-platform_state_g=
roup_gid(const struct platform_state_group *s)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(HAVE_GETGRNAM) &amp;&amp; defined(HAVE_SETGID)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return s-&gt;gid;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return -1;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> void platform_chroot(const char *path);</span><br><span> =
</span><br><span> void platform_nice(int niceval);</span><br><span>diff --g=
it a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 5fcf=
820..f71d891 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><s=
pan>+++ b/src/openvpn/socket.c</span><br><span>@@ -3082,7 +3082,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-unix_socket_get_peer_uid_gid(const socket_d=
escriptor_t sd, int *uid, int *gid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, =
uid_t *uid, gid_t *gid)</span><br><span> {</span><br><span> #ifdef HAVE_GET=
PEEREID</span><br><span>     uid_t u;</span><br><span>diff --git a/src/open=
vpn/socket.h b/src/openvpn/socket.h</span><br><span>index e45981f..2c79a11 =
100644</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src=
/openvpn/socket.h</span><br><span>@@ -371,7 +371,7 @@</span><br><span> </sp=
an><br><span> void socket_delete_unix(const struct sockaddr_un *local);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool un=
ix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *gid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool unix_socket_=
get_peer_uid_gid(const socket_descriptor_t sd, uid_t *uid, gid_t *gid);</sp=
an><br><span> </span><br><span> #endif /* if UNIX_SOCK_SUPPORT */</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail">change 1206</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc79=
4c7abd12408f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1206 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ohEuSQkNqlE=--


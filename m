From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 10:06:03 +0000
References: <gerrit.1753437961000.Id61df43bd79fc794a55e107daa0218c8441c2b2c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c9e1d96d7d1fc99b5df177e684ac30049e1011e5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UCRv1PdwR64="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: plugins: Clean up
 -Wconversion warnings
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

--UCRv1PdwR64=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1111?usp=3Demail

to review the following change.


Change subject: plugins: Clean up -Wconversion warnings
......................................................................

plugins: Clean up -Wconversion warnings

Most of the are actually the same ones copied to every
single plugin.

Some drive-by fixes of other warnings and some
conversion cleanups that had no warnings because
they were suppressed by casts.

Change-Id: Id61df43bd79fc794a55e107daa0218c8441c2b2c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M sample/sample-plugins/client-connect/sample-client-connect.c
M sample/sample-plugins/defer/multi-auth.c
M sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporte=
r.c
M sample/sample-plugins/log/log.c
M sample/sample-plugins/log/log_v3.c
M sample/sample-plugins/simple/base64.c
M sample/sample-plugins/simple/simple.c
M src/plugins/auth-pam/auth-pam.c
M src/plugins/auth-pam/utils.c
M src/plugins/down-root/down-root.c
10 files changed, 42 insertions(+), 54 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1111/1

diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b=
/sample/sample-plugins/client-connect/sample-client-connect.c
index 18c2c6f..5194270 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -86,9 +86,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -309,7 +308,7 @@

     /* do mighty complicated work that will really take time here... */
     plugin_log(PLOG_NOTE, MODULE, "in async/deferred handler, sleep(%d)", =
seconds);
-    sleep(seconds);
+    sleep((unsigned int)seconds);

     /* write config options to openvpn */
     int ret =3D write_cc_options_file(name, envp);
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugi=
ns/defer/multi-auth.c
index 38db07f..c458346 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -124,9 +124,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -170,7 +169,7 @@

 /* Require a minimum OpenVPN Plugin API */
 OPENVPN_EXPORT int
-openvpn_plugin_min_version_required_v1()
+openvpn_plugin_min_version_required_v1(void)
 {
     return OPENVPN_PLUGIN_VERSION_MIN;
 }
@@ -349,9 +348,9 @@
      */

     /* do mighty complicated work that will really take time here... */
-    plog(context, PLOG_NOTE, "in async/deferred handler, usleep(%d)",
-         context->test_deferred_auth*1000);
-    usleep(context->test_deferred_auth*1000);
+    useconds_t wait_time =3D (useconds_t)context->test_deferred_auth*1000;
+    plog(context, PLOG_NOTE, "in async/deferred handler, usleep(%u)", wait=
_time);
+    usleep(wait_time);

     /* now signal success state to openvpn */
     int fd =3D open(auth_control_file, O_WRONLY);
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmate=
rialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keying=
materialexporter.c
index cc256dd..f1f8868 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
@@ -69,9 +69,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/lo=
g.c
index 82595cf..b304f16 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -52,9 +52,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log=
/log_v3.c
index c90cc3d..a024027 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -55,9 +55,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/=
simple/base64.c
index 6855966..e1cc791 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -59,9 +59,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -175,7 +174,7 @@

     /* test the BASE64 encode function */
     char *buf =3D NULL;
-    int r =3D ovpn_base64_encode(clcert_cn, strlen(clcert_cn), &buf);
+    int r =3D ovpn_base64_encode(clcert_cn, (int)strlen(clcert_cn), &buf);
     ovpn_log(PLOG_NOTE, PLUGIN_NAME, "BASE64 encoded '%s' (return value %i=
):  '%s'",
              clcert_cn, r, buf);

diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/=
simple/simple.c
index e17f3fa..2c096e2 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -54,9 +54,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c
index 8692806..7264f95 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -165,31 +165,30 @@
     }
 }

-static int
-recv_string(int fd, char *buffer, int len)
+static ssize_t
+recv_string(int fd, char *buffer, size_t len)
 {
     if (len > 0)
     {
-        ssize_t size;
         memset(buffer, 0, len);
-        size =3D read(fd, buffer, len);
+        ssize_t size =3D read(fd, buffer, len);
         buffer[len-1] =3D 0;
         if (size >=3D 1)
         {
-            return (int)size;
+            return size;
         }
     }
     return -1;
 }

-static int
+static ssize_t
 send_string(int fd, const char *string)
 {
-    const int len =3D strlen(string) + 1;
+    const size_t len =3D strlen(string) + 1;
     const ssize_t size =3D write(fd, string, len);
     if (size =3D=3D len)
     {
-        return (int) size;
+        return size;
     }
     else
     {
@@ -645,27 +644,26 @@
  * PAM conversation function
  */
 static int
-my_conv(int n, const struct pam_message **msg_array,
+my_conv(int num_msg, const struct pam_message **msg_array,
         struct pam_response **response_array, void *appdata_ptr)
 {
     const struct user_pass *up =3D ( const struct user_pass *) appdata_ptr;
     struct pam_response *aresp;
-    int i;
     int ret =3D PAM_SUCCESS;
=20
     *response_array =3D NULL;

-    if (n <=3D 0 || n > PAM_MAX_NUM_MSG)
+    if (num_msg <=3D 0 || num_msg > PAM_MAX_NUM_MSG)
     {
         return (PAM_CONV_ERR);
     }
-    if ((aresp =3D calloc(n, sizeof *aresp)) =3D=3D NULL)
+    if ((aresp =3D calloc((size_t)num_msg, sizeof *aresp)) =3D=3D NULL)
     {
         return (PAM_BUF_ERR);
     }

     /* loop through each PAM-module query */
-    for (i =3D 0; i < n; ++i)
+    for (int i =3D 0; i < num_msg; ++i)
     {
         const struct pam_message *msg =3D msg_array[i];
         aresp[i].resp_retcode =3D 0;
@@ -683,9 +681,9 @@
         {
             /* use name/value list match method */
             const struct name_value_list *list =3D up->name_value_list;
-            int j;

             /* loop through name/value pairs */
+            int j; /* checked after loop */
             for (j =3D 0; j < list->len; ++j)
             {
                 const char *match_name =3D list->data[j].name;
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index a6ccfbf..ab5e17e 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -79,7 +79,7 @@

     while (scratch)
     {
-        strncat(temp, searching, scratch-searching);
+        strncat(temp, searching, (size_t)(scratch-searching));
         strcat(temp, replacewith);

         searching =3D scratch+strlen(searchfor);
@@ -93,9 +93,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down=
-root.c
index 253adcd..2c0faf4 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -88,9 +88,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
+        const size_t namelen =3D strlen(name);
+        for (int i =3D 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -108,10 +107,10 @@
 /*
  * Return the length of a string array
  */
-static int
+static size_t
 string_array_len(const char *array[])
 {
-    int i =3D 0;
+    size_t i =3D 0;
     if (array)
     {
         while (array[i])
@@ -141,14 +140,14 @@
     }
 }

-static int
+static ssize_t
 send_control(int fd, int code)
 {
     unsigned char c =3D (unsigned char) code;
     const ssize_t size =3D write(fd, &c, sizeof(c));
     if (size =3D=3D sizeof(c))
     {
-        return (int) size;
+        return size;
     }
     else
     {
@@ -281,7 +280,6 @@
 openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const =
char *envp[])
 {
     struct down_root_context *context;
-    int i =3D 0;

     /*
      * Allocate our context
@@ -320,7 +318,7 @@
     }

     /* Ignore argv[0], as it contains just the plug-in file name */
-    for (i =3D 1; i < string_array_len(argv); i++)
+    for (int i =3D 1; i < string_array_len(argv); i++)
     {
         context->command[i-1] =3D (char *) argv[i];
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1111?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id61df43bd79fc794a55e107daa0218c8441c2b2c
Gerrit-Change-Number: 1111
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--UCRv1PdwR64=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1111?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">plugins: Clean up -Wconversion warnings<br><br>Most of the a=
re actually the same ones copied to every<br>single plugin.<br><br>Some dri=
ve-by fixes of other warnings and some<br>conversion cleanups that had no w=
arnings because<br>they were suppressed by casts.<br><br>Change-Id: Id61df4=
3bd79fc794a55e107daa0218c8441c2b2c<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M sample/sample-plugins/client-connect/sampl=
e-client-connect.c<br>M sample/sample-plugins/defer/multi-auth.c<br>M sampl=
e/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c<br>=
M sample/sample-plugins/log/log.c<br>M sample/sample-plugins/log/log_v3.c<b=
r>M sample/sample-plugins/simple/base64.c<br>M sample/sample-plugins/simple=
/simple.c<br>M src/plugins/auth-pam/auth-pam.c<br>M src/plugins/auth-pam/ut=
ils.c<br>M src/plugins/down-root/down-root.c<br>10 files changed, 42 insert=
ions(+), 54 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/11/1111/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/sample/sample-plugins/c=
lient-connect/sample-client-connect.c b/sample/sample-plugins/client-connec=
t/sample-client-connect.c</span><br><span>index 18c2c6f..5194270 100644</sp=
an><br><span>--- a/sample/sample-plugins/client-connect/sample-client-conne=
ct.c</span><br><span>+++ b/sample/sample-plugins/client-connect/sample-clie=
nt-connect.c</span><br><span>@@ -86,9 +86,8 @@</span><br><span> {</span><br=
><span>     if (envp)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const int namelen =3D strlen(name);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t =
namelen =3D strlen(name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (int i =3D 0; envp[i]; ++i)</span><br><span>         {</s=
pan><br><span>             if (!strncmp(envp[i], name, namelen))</span><br>=
<span>             {</span><br><span>@@ -309,7 +308,7 @@</span><br><span> <=
/span><br><span>     /* do mighty complicated work that will really take ti=
me here... */</span><br><span>     plugin_log(PLOG_NOTE, MODULE, &quot;in a=
sync/deferred handler, sleep(%d)&quot;, seconds);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    sleep(seconds);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    sleep((unsigned int)seconds);</span><br><sp=
an> </span><br><span>     /* write config options to openvpn */</span><br><=
span>     int ret =3D write_cc_options_file(name, envp);</span><br><span>di=
ff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins=
/defer/multi-auth.c</span><br><span>index 38db07f..c458346 100644</span><br=
><span>--- a/sample/sample-plugins/defer/multi-auth.c</span><br><span>+++ b=
/sample/sample-plugins/defer/multi-auth.c</span><br><span>@@ -124,9 +124,8 =
@@</span><br><span> {</span><br><span>     if (envp)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        const int namelen =
=3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const size_t namelen =3D strlen(name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; envp[i]; +=
+i)</span><br><span>         {</span><br><span>             if (!strncmp(en=
vp[i], name, namelen))</span><br><span>             {</span><br><span>@@ -1=
70,7 +169,7 @@</span><br><span> </span><br><span> /* Require a minimum Open=
VPN Plugin API */</span><br><span> OPENVPN_EXPORT int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-openvpn_plugin_min_version_required_v1()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_min_ver=
sion_required_v1(void)</span><br><span> {</span><br><span>     return OPENV=
PN_PLUGIN_VERSION_MIN;</span><br><span> }</span><br><span>@@ -349,9 +348,9 =
@@</span><br><span>      */</span><br><span> </span><br><span>     /* do mi=
ghty complicated work that will really take time here... */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    plog(context, PLOG_NOTE, &quot;in=
 async/deferred handler, usleep(%d)&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         context-&gt;test_deferred_auth*1000);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    usleep(context-&gt;test_d=
eferred_auth*1000);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    useconds_t wait_time =3D (useconds_t)context-&gt;test_deferred_auth*100=
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    plog(context,=
 PLOG_NOTE, &quot;in async/deferred handler, usleep(%u)&quot;, wait_time);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    usleep(wait_time=
);</span><br><span> </span><br><span>     /* now signal success state to op=
envpn */</span><br><span>     int fd =3D open(auth_control_file, O_WRONLY);=
</span><br><span>diff --git a/sample/sample-plugins/keying-material-exporte=
r-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exp=
orter-demo/keyingmaterialexporter.c</span><br><span>index cc256dd..f1f8868 =
100644</span><br><span>--- a/sample/sample-plugins/keying-material-exporter=
-demo/keyingmaterialexporter.c</span><br><span>+++ b/sample/sample-plugins/=
keying-material-exporter-demo/keyingmaterialexporter.c</span><br><span>@@ -=
69,9 +69,8 @@</span><br><span> {</span><br><span>     if (envp)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int=
 namelen =3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const size_t namelen =3D strlen(name);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; e=
nvp[i]; ++i)</span><br><span>         {</span><br><span>             if (!s=
trncmp(envp[i], name, namelen))</span><br><span>             {</span><br><s=
pan>diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/lo=
g/log.c</span><br><span>index 82595cf..b304f16 100644</span><br><span>--- a=
/sample/sample-plugins/log/log.c</span><br><span>+++ b/sample/sample-plugin=
s/log/log.c</span><br><span>@@ -52,9 +52,8 @@</span><br><span> {</span><br>=
<span>     if (envp)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        const int namelen =3D strlen(name);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; ++i)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t n=
amelen =3D strlen(name);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (int i =3D 0; envp[i]; ++i)</span><br><span>         {</sp=
an><br><span>             if (!strncmp(envp[i], name, namelen))</span><br><=
span>             {</span><br><span>diff --git a/sample/sample-plugins/log/=
log_v3.c b/sample/sample-plugins/log/log_v3.c</span><br><span>index c90cc3d=
..a024027 100644</span><br><span>--- a/sample/sample-plugins/log/log_v3.c</=
span><br><span>+++ b/sample/sample-plugins/log/log_v3.c</span><br><span>@@ =
-55,9 +55,8 @@</span><br><span> {</span><br><span>     if (envp)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
nt i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const in=
t namelen =3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        const size_t namelen =3D strlen(name);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; =
envp[i]; ++i)</span><br><span>         {</span><br><span>             if (!=
strncmp(envp[i], name, namelen))</span><br><span>             {</span><br><=
span>diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plu=
gins/simple/base64.c</span><br><span>index 6855966..e1cc791 100644</span><b=
r><span>--- a/sample/sample-plugins/simple/base64.c</span><br><span>+++ b/s=
ample/sample-plugins/simple/base64.c</span><br><span>@@ -59,9 +59,8 @@</spa=
n><br><span> {</span><br><span>     if (envp)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        const int namelen =3D strle=
n(name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (=
i =3D 0; envp[i]; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const size_t namelen =3D strlen(name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (int i =3D 0; envp[i]; ++i)</span=
><br><span>         {</span><br><span>             if (!strncmp(envp[i], na=
me, namelen))</span><br><span>             {</span><br><span>@@ -175,7 +174=
,7 @@</span><br><span> </span><br><span>     /* test the BASE64 encode func=
tion */</span><br><span>     char *buf =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int r =3D ovpn_base64_encode(clcert_cn, strl=
en(clcert_cn), &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int r =3D ovpn_base64_encode(clcert_cn, (int)strlen(clcert_cn), &=
amp;buf);</span><br><span>     ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;BASE6=
4 encoded &#39;%s&#39; (return value %i):  &#39;%s&#39;&quot;,</span><br><s=
pan>              clcert_cn, r, buf);</span><br><span> </span><br><span>dif=
f --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/sim=
ple/simple.c</span><br><span>index e17f3fa..2c096e2 100644</span><br><span>=
--- a/sample/sample-plugins/simple/simple.c</span><br><span>+++ b/sample/sa=
mple-plugins/simple/simple.c</span><br><span>@@ -54,9 +54,8 @@</span><br><s=
pan> {</span><br><span>     if (envp)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const int namelen =3D strlen(name);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0;=
 envp[i]; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const size_t namelen =3D strlen(name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int i =3D 0; envp[i]; ++i)</span><br><sp=
an>         {</span><br><span>             if (!strncmp(envp[i], name, name=
len))</span><br><span>             {</span><br><span>diff --git a/src/plugi=
ns/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c</span><br><span>in=
dex 8692806..7264f95 100644</span><br><span>--- a/src/plugins/auth-pam/auth=
-pam.c</span><br><span>+++ b/src/plugins/auth-pam/auth-pam.c</span><br><spa=
n>@@ -165,31 +165,30 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-recv_string(int fd, char=
 *buffer, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic ssize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+recv_s=
tring(int fd, char *buffer, size_t len)</span><br><span> {</span><br><span>=
     if (len &gt; 0)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ssize_t size;</span><br><span>         memset=
(buffer, 0, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    size =3D read(fd, buffer, len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ssize_t size =3D read(fd, buffer, len);</span><br><=
span>         buffer[len-1] =3D 0;</span><br><span>         if (size &gt;=
=3D 1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            return (int)size;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return size;</span><br><span>         }</=
span><br><span>     }</span><br><span>     return -1;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static ssize_t<=
/span><br><span> send_string(int fd, const char *string)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D=
 strlen(string) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const size_t len =3D strlen(string) + 1;</span><br><span>     const ss=
ize_t size =3D write(fd, string, len);</span><br><span>     if (size =3D=3D=
 len)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return (int) size;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return size;</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>@@ -645,27 +644,26 @@</span=
><br><span>  * PAM conversation function</span><br><span>  */</span><br><sp=
an> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-my_conv=
(int n, const struct pam_message **msg_array,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+my_conv(int num_msg, const struct pam_message **m=
sg_array,</span><br><span>         struct pam_response **response_array, vo=
id *appdata_ptr)</span><br><span> {</span><br><span>     const struct user_=
pass *up =3D ( const struct user_pass *) appdata_ptr;</span><br><span>     =
struct pam_response *aresp;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int i;</span><br><span>     int ret =3D PAM_SUCCESS;</span><br><s=
pan> </span><br><span>     *response_array =3D NULL;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n &lt;=3D 0 || n &=
gt; PAM_MAX_NUM_MSG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (num_msg &lt;=3D 0 || num_msg &gt; PAM_MAX_NUM_MSG)</span><br><span=
>     {</span><br><span>         return (PAM_CONV_ERR);</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((aresp =3D=
 calloc(n, sizeof *aresp)) =3D=3D NULL)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if ((aresp =3D calloc((size_t)num_msg, sizeof *ares=
p)) =3D=3D NULL)</span><br><span>     {</span><br><span>         return (PA=
M_BUF_ERR);</span><br><span>     }</span><br><span> </span><br><span>     /=
* loop through each PAM-module query */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; num_msg; ++i)</=
span><br><span>     {</span><br><span>         const struct pam_message *ms=
g =3D msg_array[i];</span><br><span>         aresp[i].resp_retcode =3D 0;</=
span><br><span>@@ -683,9 +681,9 @@</span><br><span>         {</span><br><sp=
an>             /* use name/value list match method */</span><br><span>    =
         const struct name_value_list *list =3D up-&gt;name_value_list;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            int j;</span>=
<br><span> </span><br><span>             /* loop through name/value pairs *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int j;=
 /* checked after loop */</span><br><span>             for (j =3D 0; j &lt;=
 list-&gt;len; ++j)</span><br><span>             {</span><br><span>        =
         const char *match_name =3D list-&gt;data[j].name;</span><br><span>=
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c</s=
pan><br><span>index a6ccfbf..ab5e17e 100644</span><br><span>--- a/src/plugi=
ns/auth-pam/utils.c</span><br><span>+++ b/src/plugins/auth-pam/utils.c</spa=
n><br><span>@@ -79,7 +79,7 @@</span><br><span> </span><br><span>     while =
(scratch)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        strncat(temp, searching, scratch-searching);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        strncat(temp, searching=
, (size_t)(scratch-searching));</span><br><span>         strcat(temp, repla=
cewith);</span><br><span> </span><br><span>         searching =3D scratch+s=
trlen(searchfor);</span><br><span>@@ -93,9 +93,8 @@</span><br><span> {</spa=
n><br><span>     if (envp)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        const int namelen =3D strlen(name);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const si=
ze_t namelen =3D strlen(name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (int i =3D 0; envp[i]; ++i)</span><br><span>        =
 {</span><br><span>             if (!strncmp(envp[i], name, namelen))</span=
><br><span>             {</span><br><span>diff --git a/src/plugins/down-roo=
t/down-root.c b/src/plugins/down-root/down-root.c</span><br><span>index 253=
adcd..2c0faf4 100644</span><br><span>--- a/src/plugins/down-root/down-root.=
c</span><br><span>+++ b/src/plugins/down-root/down-root.c</span><br><span>@=
@ -88,9 +88,8 @@</span><br><span> {</span><br><span>     if (envp)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const =
int namelen =3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const size_t namelen =3D strlen(name);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0=
; envp[i]; ++i)</span><br><span>         {</span><br><span>             if =
(!strncmp(envp[i], name, namelen))</span><br><span>             {</span><br=
><span>@@ -108,10 +107,10 @@</span><br><span> /*</span><br><span>  * Return=
 the length of a string array</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static size_t</span><br><span> string_array_len(const c=
har *array[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t i =3D 0;</span><br><span>     if (array)</span><br><span=
>     {</span><br><span>         while (array[i])</span><br><span>@@ -141,1=
4 +140,14 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</span><br><span> s=
end_control(int fd, int code)</span><br><span> {</span><br><span>     unsig=
ned char c =3D (unsigned char) code;</span><br><span>     const ssize_t siz=
e =3D write(fd, &amp;c, sizeof(c));</span><br><span>     if (size =3D=3D si=
zeof(c))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return (int) size;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return size;</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span>@@ -281,7 +280,6 @@</spa=
n><br><span> openvpn_plugin_open_v1(unsigned int *type_mask, const char *ar=
gv[], const char *envp[])</span><br><span> {</span><br><span>     struct do=
wn_root_context *context;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int i =3D 0;</span><br><span> </span><br><span>     /*</span><br><s=
pan>      * Allocate our context</span><br><span>@@ -320,7 +318,7 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     /* Ignore argv[0], =
as it contains just the plug-in file name */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    for (i =3D 1; i &lt; string_array_len(argv); i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 1; i &lt; string_array_len(argv); i++)</span><br><span>     {</span><br><s=
pan>         context-&gt;command[i-1] =3D (char *) argv[i];</span><br><span=
>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1111?usp=3Demail">change 1111</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1111?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id61df43bd79fc794a55e107daa0=
218c8441c2b2c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1111 </div>
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


--UCRv1PdwR64=--


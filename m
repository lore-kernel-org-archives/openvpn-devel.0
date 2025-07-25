From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 15:40:08 +0000
In-Reply-To: <gerrit.1753437961000.Id61df43bd79fc794a55e107daa0218c8441c2b2c@...2715...>
References: <gerrit.1753437961000.Id61df43bd79fc794a55e107daa0218c8441c2b2c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <eb83beb2641a0f2caa9e77d652fd50081b085337-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w8Z41hf7e3k="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w8Z41hf7e3k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
11?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250725124415.20645-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
330.html
Signed-off-by: Gert Doering <gert@...1296...>
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
=20
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--w8Z41hf7e3k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1111?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">plugins: Clean up -Wconversion warnings<br><b=
r>Most of the are actually the same ones copied to every<br>single plugin.<=
br><br>Some drive-by fixes of other warnings and some<br>conversion cleanup=
s that had no warnings because<br>they were suppressed by casts.<br><br>Cha=
nge-Id: Id61df43bd79fc794a55e107daa0218c8441c2b2c<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Message-Id: &lt;20250725124415.20645-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
2330.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M sample/sample-plugins/client-connect/sample-client-connect.c<br>M sample/=
sample-plugins/defer/multi-auth.c<br>M sample/sample-plugins/keying-materia=
l-exporter-demo/keyingmaterialexporter.c<br>M sample/sample-plugins/log/log=
.c<br>M sample/sample-plugins/log/log_v3.c<br>M sample/sample-plugins/simpl=
e/base64.c<br>M sample/sample-plugins/simple/simple.c<br>M src/plugins/auth=
-pam/auth-pam.c<br>M src/plugins/auth-pam/utils.c<br>M src/plugins/down-roo=
t/down-root.c<br>10 files changed, 42 insertions(+), 54 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/sample/sample-plugins/client-connect/sample-client-connect.=
c b/sample/sample-plugins/client-connect/sample-client-connect.c</span><br>=
<span>index 18c2c6f..5194270 100644</span><br><span>--- a/sample/sample-plu=
gins/client-connect/sample-client-connect.c</span><br><span>+++ b/sample/sa=
mple-plugins/client-connect/sample-client-connect.c</span><br><span>@@ -86,=
9 +86,8 @@</span><br><span> {</span><br><span>     if (envp)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int na=
melen =3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const size_t namelen =3D strlen(name);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; envp=
[i]; ++i)</span><br><span>         {</span><br><span>             if (!strn=
cmp(envp[i], name, namelen))</span><br><span>             {</span><br><span=
>@@ -309,7 +308,7 @@</span><br><span> </span><br><span>     /* do mighty co=
mplicated work that will really take time here... */</span><br><span>     p=
lugin_log(PLOG_NOTE, MODULE, &quot;in async/deferred handler, sleep(%d)&quo=
t;, seconds);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    slee=
p(seconds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    slee=
p((unsigned int)seconds);</span><br><span> </span><br><span>     /* write c=
onfig options to openvpn */</span><br><span>     int ret =3D write_cc_optio=
ns_file(name, envp);</span><br><span>diff --git a/sample/sample-plugins/def=
er/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c</span><br><span>=
index 38db07f..c458346 100644</span><br><span>--- a/sample/sample-plugins/d=
efer/multi-auth.c</span><br><span>+++ b/sample/sample-plugins/defer/multi-a=
uth.c</span><br><span>@@ -124,9 +124,8 @@</span><br><span> {</span><br><spa=
n>     if (envp)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        const int namelen =3D strlen(name);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; ++i)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t namel=
en =3D strlen(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        for (int i =3D 0; envp[i]; ++i)</span><br><span>         {</span><=
br><span>             if (!strncmp(envp[i], name, namelen))</span><br><span=
>             {</span><br><span>@@ -170,7 +169,7 @@</span><br><span> </span=
><br><span> /* Require a minimum OpenVPN Plugin API */</span><br><span> OPE=
NVPN_EXPORT int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvp=
n_plugin_min_version_required_v1()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+openvpn_plugin_min_version_required_v1(void)</span><br><span=
> {</span><br><span>     return OPENVPN_PLUGIN_VERSION_MIN;</span><br><span=
> }</span><br><span>@@ -349,9 +348,9 @@</span><br><span>      */</span><br>=
<span> </span><br><span>     /* do mighty complicated work that will really=
 take time here... */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    plog(context, PLOG_NOTE, &quot;in async/deferred handler, usleep(%d)&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         context-=
&gt;test_deferred_auth*1000);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    usleep(context-&gt;test_deferred_auth*1000);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    useconds_t wait_time =3D (useconds=
_t)context-&gt;test_deferred_auth*1000;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    plog(context, PLOG_NOTE, &quot;in async/deferred ha=
ndler, usleep(%u)&quot;, wait_time);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    usleep(wait_time);</span><br><span> </span><br><span> =
    /* now signal success state to openvpn */</span><br><span>     int fd =
=3D open(auth_control_file, O_WRONLY);</span><br><span>diff --git a/sample/=
sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sam=
ple/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c</=
span><br><span>index cc256dd..f1f8868 100644</span><br><span>--- a/sample/s=
ample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c</span>=
<br><span>+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingm=
aterialexporter.c</span><br><span>@@ -69,9 +69,8 @@</span><br><span> {</spa=
n><br><span>     if (envp)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        const int namelen =3D strlen(name);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const si=
ze_t namelen =3D strlen(name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (int i =3D 0; envp[i]; ++i)</span><br><span>        =
 {</span><br><span>             if (!strncmp(envp[i], name, namelen))</span=
><br><span>             {</span><br><span>diff --git a/sample/sample-plugin=
s/log/log.c b/sample/sample-plugins/log/log.c</span><br><span>index 82595cf=
..b304f16 100644</span><br><span>--- a/sample/sample-plugins/log/log.c</spa=
n><br><span>+++ b/sample/sample-plugins/log/log.c</span><br><span>@@ -52,9 =
+52,8 @@</span><br><span> {</span><br><span>     if (envp)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int name=
len =3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const size_t namelen =3D strlen(name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; envp[i=
]; ++i)</span><br><span>         {</span><br><span>             if (!strncm=
p(envp[i], name, namelen))</span><br><span>             {</span><br><span>d=
iff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/=
log_v3.c</span><br><span>index c90cc3d..a024027 100644</span><br><span>--- =
a/sample/sample-plugins/log/log_v3.c</span><br><span>+++ b/sample/sample-pl=
ugins/log/log_v3.c</span><br><span>@@ -55,9 +55,8 @@</span><br><span> {</sp=
an><br><span>     if (envp)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const int namelen =3D strlen(name);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const s=
ize_t namelen =3D strlen(name);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (int i =3D 0; envp[i]; ++i)</span><br><span>       =
  {</span><br><span>             if (!strncmp(envp[i], name, namelen))</spa=
n><br><span>             {</span><br><span>diff --git a/sample/sample-plugi=
ns/simple/base64.c b/sample/sample-plugins/simple/base64.c</span><br><span>=
index 6855966..e1cc791 100644</span><br><span>--- a/sample/sample-plugins/s=
imple/base64.c</span><br><span>+++ b/sample/sample-plugins/simple/base64.c<=
/span><br><span>@@ -59,9 +59,8 @@</span><br><span> {</span><br><span>     i=
f (envp)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const int namelen =3D strlen(name);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[i]; ++i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const size_t namelen =3D s=
trlen(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (int i =3D 0; envp[i]; ++i)</span><br><span>         {</span><br><span=
>             if (!strncmp(envp[i], name, namelen))</span><br><span>       =
      {</span><br><span>@@ -175,7 +174,7 @@</span><br><span> </span><br><sp=
an>     /* test the BASE64 encode function */</span><br><span>     char *bu=
f =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r =
=3D ovpn_base64_encode(clcert_cn, strlen(clcert_cn), &amp;buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int r =3D ovpn_base64_encod=
e(clcert_cn, (int)strlen(clcert_cn), &amp;buf);</span><br><span>     ovpn_l=
og(PLOG_NOTE, PLUGIN_NAME, &quot;BASE64 encoded &#39;%s&#39; (return value =
%i):  &#39;%s&#39;&quot;,</span><br><span>              clcert_cn, r, buf);=
</span><br><span> </span><br><span>diff --git a/sample/sample-plugins/simpl=
e/simple.c b/sample/sample-plugins/simple/simple.c</span><br><span>index e1=
7f3fa..2c096e2 100644</span><br><span>--- a/sample/sample-plugins/simple/si=
mple.c</span><br><span>+++ b/sample/sample-plugins/simple/simple.c</span><b=
r><span>@@ -54,9 +54,8 @@</span><br><span> {</span><br><span>     if (envp)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const int namelen =3D strlen(name);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        for (i =3D 0; envp[i]; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const size_t namelen =3D strlen(n=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i=
nt i =3D 0; envp[i]; ++i)</span><br><span>         {</span><br><span>      =
       if (!strncmp(envp[i], name, namelen))</span><br><span>             {=
</span><br><span>diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins=
/auth-pam/auth-pam.c</span><br><span>index 8692806..7264f95 100644</span><b=
r><span>--- a/src/plugins/auth-pam/auth-pam.c</span><br><span>+++ b/src/plu=
gins/auth-pam/auth-pam.c</span><br><span>@@ -165,31 +165,30 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-recv_string(int fd, char *buffer, int len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static ssize_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+recv_string(int fd, char *buffer, size_t =
len)</span><br><span> {</span><br><span>     if (len &gt; 0)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssize=
_t size;</span><br><span>         memset(buffer, 0, len);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        size =3D read(fd, buffer, len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ssize_t siz=
e =3D read(fd, buffer, len);</span><br><span>         buffer[len-1] =3D 0;<=
/span><br><span>         if (size &gt;=3D 1)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            return (int)s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn size;</span><br><span>         }</span><br><span>     }</span><br><span=
>     return -1;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static ssize_t</span><br><span> send_string(int fd, =
const char *string)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const int len =3D strlen(string) + 1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const size_t len =3D strlen(stri=
ng) + 1;</span><br><span>     const ssize_t size =3D write(fd, string, len)=
;</span><br><span>     if (size =3D=3D len)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return (int) size;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return size;</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span>@@ -645,27 +644,26 @@</span><br><span>  * PAM conversation funct=
ion</span><br><span>  */</span><br><span> static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-my_conv(int n, const struct pam_message **m=
sg_array,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+my_conv(in=
t num_msg, const struct pam_message **msg_array,</span><br><span>         s=
truct pam_response **response_array, void *appdata_ptr)</span><br><span> {<=
/span><br><span>     const struct user_pass *up =3D ( const struct user_pas=
s *) appdata_ptr;</span><br><span>     struct pam_response *aresp;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>   =
  int ret =3D PAM_SUCCESS;</span><br><span> </span><br><span>     *response=
_array =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (n &lt;=3D 0 || n &gt; PAM_MAX_NUM_MSG)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (num_msg &lt;=3D 0 || num_ms=
g &gt; PAM_MAX_NUM_MSG)</span><br><span>     {</span><br><span>         ret=
urn (PAM_CONV_ERR);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if ((aresp =3D calloc(n, sizeof *aresp)) =3D=3D NU=
LL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((aresp =
=3D calloc((size_t)num_msg, sizeof *aresp)) =3D=3D NULL)</span><br><span>  =
   {</span><br><span>         return (PAM_BUF_ERR);</span><br><span>     }<=
/span><br><span> </span><br><span>     /* loop through each PAM-module quer=
y */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0;=
 i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; num_msg; ++i)</span><br><span>     {</span><br><sp=
an>         const struct pam_message *msg =3D msg_array[i];</span><br><span=
>         aresp[i].resp_retcode =3D 0;</span><br><span>@@ -683,9 +681,9 @@<=
/span><br><span>         {</span><br><span>             /* use name/value l=
ist match method */</span><br><span>             const struct name_value_li=
st *list =3D up-&gt;name_value_list;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            int j;</span><br><span> </span><br><span>       =
      /* loop through name/value pairs */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            int j; /* checked after loop */</span><br=
><span>             for (j =3D 0; j &lt; list-&gt;len; ++j)</span><br><span=
>             {</span><br><span>                 const char *match_name =3D=
 list-&gt;data[j].name;</span><br><span>diff --git a/src/plugins/auth-pam/u=
tils.c b/src/plugins/auth-pam/utils.c</span><br><span>index a6ccfbf..ab5e17=
e 100644</span><br><span>--- a/src/plugins/auth-pam/utils.c</span><br><span=
>+++ b/src/plugins/auth-pam/utils.c</span><br><span>@@ -79,7 +79,7 @@</span=
><br><span> </span><br><span>     while (scratch)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncat(temp, se=
arching, scratch-searching);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        strncat(temp, searching, (size_t)(scratch-searching));</sp=
an><br><span>         strcat(temp, replacewith);</span><br><span> </span><b=
r><span>         searching =3D scratch+strlen(searchfor);</span><br><span>@=
@ -93,9 +93,8 @@</span><br><span> {</span><br><span>     if (envp)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const =
int namelen =3D strlen(name);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        for (i =3D 0; envp[i]; ++i)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const size_t namelen =3D strlen(name);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0=
; envp[i]; ++i)</span><br><span>         {</span><br><span>             if =
(!strncmp(envp[i], name, namelen))</span><br><span>             {</span><br=
><span>diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-ro=
ot/down-root.c</span><br><span>index 253adcd..2c0faf4 100644</span><br><spa=
n>--- a/src/plugins/down-root/down-root.c</span><br><span>+++ b/src/plugins=
/down-root/down-root.c</span><br><span>@@ -88,9 +88,8 @@</span><br><span> {=
</span><br><span>     if (envp)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        const int namelen =3D strlen(name);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; envp[=
i]; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st size_t namelen =3D strlen(name);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (int i =3D 0; envp[i]; ++i)</span><br><span>   =
      {</span><br><span>             if (!strncmp(envp[i], name, namelen))<=
/span><br><span>             {</span><br><span>@@ -108,10 +107,10 @@</span>=
<br><span> /*</span><br><span>  * Return the length of a string array</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static size_t</=
span><br><span> string_array_len(const char *array[])</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t i =3D 0;</span><=
br><span>     if (array)</span><br><span>     {</span><br><span>         wh=
ile (array[i])</span><br><span>@@ -141,14 +140,14 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static ssize_t</span><br><span> send_control(int fd, int code)</span=
><br><span> {</span><br><span>     unsigned char c =3D (unsigned char) code=
;</span><br><span>     const ssize_t size =3D write(fd, &amp;c, sizeof(c));=
</span><br><span>     if (size =3D=3D sizeof(c))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return (int) size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return siz=
e;</span><br><span>     }</span><br><span>     else</span><br><span>     {<=
/span><br><span>@@ -281,7 +280,6 @@</span><br><span> openvpn_plugin_open_v1=
(unsigned int *type_mask, const char *argv[], const char *envp[])</span><br=
><span> {</span><br><span>     struct down_root_context *context;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int i =3D 0;</span><br><spa=
n> </span><br><span>     /*</span><br><span>      * Allocate our context</s=
pan><br><span>@@ -320,7 +318,7 @@</span><br><span>     }</span><br><span> <=
/span><br><span>     /* Ignore argv[0], as it contains just the plug-in fil=
e name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 1; i &lt; string_array_len(argv); i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 1; i &lt; string_array_len(argv);=
 i++)</span><br><span>     {</span><br><span>         context-&gt;command[i=
-1] =3D (char *) argv[i];</span><br><span>     }</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
111?usp=3Demail">change 1111</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1111?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id61df43bd79fc794a55e107daa0=
218c8441c2b2c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1111 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--w8Z41hf7e3k=--


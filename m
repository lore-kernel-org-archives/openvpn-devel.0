From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 1 Feb 2025 18:37:54 +0000
In-Reply-To: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
References: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <10977ca928d0eeb596226c3209f0d3b0891406c5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rDaFsUKv03I="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Improve error
 reporting from AF_UNIX tun/tap support
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

--rDaFsUKv03I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/85=
5?usp=3Demail )

Change subject: Improve error reporting from AF_UNIX tun/tap support
......................................................................

Improve error reporting from AF_UNIX tun/tap support

When having a non-existent lwipovpn binary or similar problems, the
error reporting would often only report read error that were harder to
identify the real problem.  Add the openvpn_waitpid_check method
that checks for error conditions and reports a better message in cases
of problems.

Change-Id: I81cbecd19018290d85c6c77fba7769f040d66233
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250201122006.32098-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
782.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/run_command.c
M src/openvpn/run_command.h
M src/openvpn/tun_afunix.c
3 files changed, 81 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index d757823..192c8e6 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -106,6 +106,47 @@
     return (const char *)out.data;
 }

+#ifndef WIN32
+bool
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel)
+{
+    if (pid =3D=3D 0)
+    {
+        return false;
+    }
+    int status;
+    pid_t pidret =3D waitpid(pid, &status, WNOHANG);
+    if (pidret !=3D pid)
+    {
+        return true;
+    }
+
+    if (WIFEXITED(status))
+    {
+        int exitcode =3D WEXITSTATUS(status);
+
+        if (exitcode =3D=3D OPENVPN_EXECVE_FAILURE)
+        {
+            msg(msglevel, "%scould not execute external program (exit code=
 127)",
+                msg_prefix);
+        }
+        else
+        {
+            msg(msglevel, "%sexternal program exited with error status: %d=
",
+                msg_prefix, exitcode);
+        }
+
+    }
+    else if (WIFSIGNALED(status))
+    {
+        msg(msglevel, "%sexternal program received signal %d",
+            msg_prefix, WTERMSIG(status));
+    }
+
+    return false;
+}
+#endif /* ifndef WIN32 */
+
 bool
 openvpn_execve_allowed(const unsigned int flags)
 {
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index c92edbc..b0b51c3 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -59,6 +59,26 @@
 int openvpn_execve_check(const struct argv *a, const struct env_set *es,
                          const unsigned int flags, const char *error_messa=
ge);

+
+#ifndef WIN32
+/** Checks if a running process is still running. This is mainly useful
+ * for processes started with \c S_NOWAITPID
+ *
+ * This function is currently not implemented for Windows as the helper
+ * macros used by this function are not available.
+ *
+ * @param pid               pid of the process to be checked
+ * @param msg_prefix     prefixed of the message that be printed
+ * @param msglevel          msglevel of the messages to be printed
+ * @return                  true if the process is still running, false if
+ *                          an error condition occurred
+ */
+bool
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix,
+                      int msglevel);
+
+#endif
+
 /**
  * Will run a script and return the exit code of the script if between
  * 0 and 255, -1 otherwise
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 6b6c159..c626993 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -47,9 +47,12 @@
 #include <signal.h>
 #include <stdlib.h>

+
+
 static void
 tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_=
set *env)
 {
+    const char *msgprefix =3D "ERROR: failure executing process for tun:";
     struct argv argv =3D argv_new();

     /* since we know that dev-node starts with unix: we can just skip that
@@ -58,10 +61,12 @@

     argv_printf(&argv, "%s", program);

-    argv_msg(M_INFO, &argv);
     tt->afunix.childprocess =3D openvpn_execve_check(&argv, env, S_NOWAITP=
ID,
-                                                   "ERROR: failure executi=
ng "
-                                                   "process for tun");
+                                                   msgprefix);
+    if (!openvpn_waitpid_check(tt->afunix.childprocess, msgprefix, M_WARN))
+    {
+        tt->afunix.childprocess =3D 0;
+    }
     argv_free(&argv);
 }

@@ -138,20 +143,27 @@
 ssize_t
 write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
 {
-    int ret;
-    pid_t pidret =3D waitpid(tt->afunix.childprocess, &ret, WNOHANG);
-    if (pidret =3D=3D tt->afunix.childprocess)
+    const char *msg =3D "ERROR: failure during write to AF_UNIX socket: ";
+    if (!openvpn_waitpid_check(tt->afunix.childprocess, msg, M_WARN))
     {
-        msg(M_INFO, "Child process PID %d for afunix dead? Return code: %d=
",
-            tt->afunix.childprocess, ret);
+        tt->afunix.childprocess =3D 0;
         return -ENXIO;
     }
+
     return write(tt->fd, buf, len);
 }

 ssize_t
 read_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
 {
+    const char *msg =3D "ERROR: failure during read from AF_UNIX socket: ";
+    if (!openvpn_waitpid_check(tt->afunix.childprocess, msg, M_WARN))
+    {
+        tt->afunix.childprocess =3D 0;
+    }
+    /* do an actual read on the file descriptor even in the error case sin=
ce
+     * we otherwise loop on this on this from select and spam the console
+     * with error messages */
     return read(tt->fd, buf, len);
 }
 #else  /* ifndef WIN32 */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81cbecd19018290d85c6c77fba7769f040d66233
Gerrit-Change-Number: 855
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--rDaFsUKv03I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/855?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Improve error reporting from AF_UNIX tun/tap s=
upport<br><br>When having a non-existent lwipovpn binary or similar problem=
s, the<br>error reporting would often only report read error that were hard=
er to<br>identify the real problem.  Add the openvpn_waitpid_check method<b=
r>that checks for error conditions and reports a better message in cases<br=
>of problems.<br><br>Change-Id: I81cbecd19018290d85c6c77fba7769f040d66233<b=
r>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250201122006.32098-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg30782.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/run_command.c<br>M src/openvpn/run_command.=
h<br>M src/openvpn/tun_afunix.c<br>3 files changed, 81 insertions(+), 8 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c</span=
><br><span>index d757823..192c8e6 100644</span><br><span>--- a/src/openvpn/=
run_command.c</span><br><span>+++ b/src/openvpn/run_command.c</span><br><sp=
an>@@ -106,6 +106,47 @@</span><br><span>     return (const char *)out.data;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef WIN32</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ope=
nvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (pid =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    pid_t pidret =3D waitpid(pid, &amp;status, WNOHANG);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (pidret !=3D pid)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (WIFEXITED(status))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   int exitcode =3D WEXITSTATUS(status);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (exitcode =3D=3D OPENVPN_EXECVE_FAILURE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;%scould not execute=
 external program (exit code 127)&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                msg_prefix);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(msglevel, &quot;%sexternal program exited with error sta=
tus: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           msg_prefix, exitcode);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (WIFSIGNALED(stat=
us))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%=
sexternal program received signal %d&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg_prefix, WTERMSIG(status));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f /* ifndef WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> bool</span><br><span> openvpn_execve_allowed(const unsig=
ned int flags)</span><br><span> {</span><br><span>diff --git a/src/openvpn/=
run_command.h b/src/openvpn/run_command.h</span><br><span>index c92edbc..b0=
b51c3 100644</span><br><span>--- a/src/openvpn/run_command.h</span><br><spa=
n>+++ b/src/openvpn/run_command.h</span><br><span>@@ -59,6 +59,26 @@</span>=
<br><span> int openvpn_execve_check(const struct argv *a, const struct env_=
set *es,</span><br><span>                          const unsigned int flags=
, const char *error_message);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** Checks if a running process is still running. This is mainly useful<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for processes sta=
rted with \c S_NOWAITPID</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This func=
tion is currently not implemented for Windows as the helper</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * macros used by this function are=
 not available.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid        =
       pid of the process to be checked</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param msg_prefix     prefixed of the message that b=
e printed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
msglevel          msglevel of the messages to be printed</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return                  true if th=
e process is still running, false if</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                          an error condition occurred</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+openvpn_waitpid_check(pid_t pid, const char *msg_pref=
ix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Will run a script and return the exit code of the script if betw=
een</span><br><span>  * 0 and 255, -1 otherwise</span><br><span>diff --git =
a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c</span><br><span>index=
 6b6c159..c626993 100644</span><br><span>--- a/src/openvpn/tun_afunix.c</sp=
an><br><span>+++ b/src/openvpn/tun_afunix.c</span><br><span>@@ -47,9 +47,12=
 @@</span><br><span> #include &lt;signal.h&gt;</span><br><span> #include &l=
t;stdlib.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> static void</span><br><span> tun_afunix_exec_child(const char *=
dev_node, struct tuntap *tt, struct env_set *env)</span><br><span> {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *msgprefix =
=3D &quot;ERROR: failure executing process for tun:&quot;;</span><br><span>=
     struct argv argv =3D argv_new();</span><br><span> </span><br><span>   =
  /* since we know that dev-node starts with unix: we can just skip that</s=
pan><br><span>@@ -58,10 +61,12 @@</span><br><span> </span><br><span>     ar=
gv_printf(&amp;argv, &quot;%s&quot;, program);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp;argv);=
</span><br><span>     tt-&gt;afunix.childprocess =3D openvpn_execve_check(&=
amp;argv, env, S_NOWAITPID,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                                   &quot;ERROR: failu=
re executing &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                                 &quot;process for tun&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                   msgprefix);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_check(tt-&gt;afunix.chi=
ldprocess, msgprefix, M_WARN))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tt-&gt;afunix.childprocess =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span>     argv_free(&amp;argv);</span><=
br><span> }</span><br><span> </span><br><span>@@ -138,20 +143,27 @@</span><=
br><span> ssize_t</span><br><span> write_tun_afunix(struct tuntap *tt, uint=
8_t *buf, int len)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int ret;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    pid_t pidret =3D waitpid(tt-&gt;afunix.childprocess, &amp;ret, W=
NOHANG);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (pidre=
t =3D=3D tt-&gt;afunix.childprocess)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *msg =3D &quot;ERROR: failure during write =
to AF_UNIX socket: &quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!openvpn_waitpid_check(tt-&gt;afunix.childprocess, msg, M_WA=
RN))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_INFO, &quot;Child process PID %d for afunix dead? Retur=
n code: %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        tt-&gt;afunix.childprocess, ret);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        tt-&gt;afunix.childprocess =3D 0;</span><br><=
span>         return -ENXIO;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return write(tt-&gt=
;fd, buf, len);</span><br><span> }</span><br><span> </span><br><span> ssize=
_t</span><br><span> read_tun_afunix(struct tuntap *tt, uint8_t *buf, int le=
n)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *msg =3D &quot;ERROR: failure during read from AF_UNIX soc=
ket: &quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!openvpn_waitpid_check(tt-&gt;afunix.childprocess, msg, M_WARN))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;afunix.childprocess =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* do an actual read on the f=
ile descriptor even in the error case since</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * we otherwise loop on this on this from selec=
t and spam the console</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * with error messages */</span><br><span>     return read(tt-&gt;fd=
, buf, len);</span><br><span> }</span><br><span> #else  /* ifndef WIN32 */<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/855?usp=3Demail">change 855</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/855?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81cbecd19018290d85c6c77fba7=
769f040d66233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--rDaFsUKv03I=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 26 Jan 2025 15:11:01 +0000
In-Reply-To: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
References: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <3300917f3d42eef8bb88811b938db53d173a795f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TN+Nr4PxZcY="; charset=UTF-8
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
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TN+Nr4PxZcY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demail

to look at the new patch set (#3).


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
---
M src/openvpn/run_command.c
M src/openvpn/run_command.h
M src/openvpn/tun_afunix.c
3 files changed, 81 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/855/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--TN+Nr4PxZcY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Improve error reporting from AF_UNIX tun/tap support<br><br>When havi=
ng a non-existent lwipovpn binary or similar problems, the<br>error reporti=
ng would often only report read error that were harder to<br>identify the r=
eal problem.  Add the openvpn_waitpid_check method<br>that checks for error=
 conditions and reports a better message in cases<br>of problems.<br><br>Ch=
ange-Id: I81cbecd19018290d85c6c77fba7769f040d66233<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/run_command.c<br>M s=
rc/openvpn/run_command.h<br>M src/openvpn/tun_afunix.c<br>3 files changed, =
81 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/55/855/3</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/run_=
command.c b/src/openvpn/run_command.c</span><br><span>index d757823..192c8e=
6 100644</span><br><span>--- a/src/openvpn/run_command.c</span><br><span>++=
+ b/src/openvpn/run_command.c</span><br><span>@@ -106,6 +106,47 @@</span><b=
r><span>     return (const char *)out.data;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef WIN32<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+openvpn_waitpid_check(pid_t pid, co=
nst char *msg_prefix, int msglevel)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (pid =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    pid_t pidret =3D waitpid(p=
id, &amp;status, WNOHANG);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (pidret !=3D pid)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (WIFEXITED(status))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int exitcode =3D WEXITSTATUS(stat=
us);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (exitcode =3D=3D OPENVP=
N_EXECVE_FAILURE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;%scould not execute external program (exit code 127)&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 msg_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;%=
sexternal program exited with error status: %d&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg_prefix, exitcode);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (WIFSIGNALED(status))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(msglevel, &quot;%sexternal program received signal %d=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg_prefix, WTERMSIG(status));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef WIN32 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><s=
pan> openvpn_execve_allowed(const unsigned int flags)</span><br><span> {</s=
pan><br><span>diff --git a/src/openvpn/run_command.h b/src/openvpn/run_comm=
and.h</span><br><span>index c92edbc..b0b51c3 100644</span><br><span>--- a/s=
rc/openvpn/run_command.h</span><br><span>+++ b/src/openvpn/run_command.h</s=
pan><br><span>@@ -59,6 +59,26 @@</span><br><span> int openvpn_execve_check(=
const struct argv *a, const struct env_set *es,</span><br><span>           =
               const unsigned int flags, const char *error_message);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef WIN32</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Checks if a running process i=
s still running. This is mainly useful</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * for processes started with \c S_NOWAITPID</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * This function is currently not implemented fo=
r Windows as the helper</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * macros used by this function are not available.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param pid               pid of the process to be chec=
ked</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msg_pr=
efix     prefixed of the message that be printed</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param msglevel          msglevel of the me=
ssages to be printed</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return                  true if the process is still running, false if=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 =
         an error condition occurred</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_waitpi=
d_check(pid_t pid, const char *msg_prefix,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      int msglevel);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /**</span><br><span>  * Will run a script and ret=
urn the exit code of the script if between</span><br><span>  * 0 and 255, -=
1 otherwise</span><br><span>diff --git a/src/openvpn/tun_afunix.c b/src/ope=
nvpn/tun_afunix.c</span><br><span>index 6b6c159..c626993 100644</span><br><=
span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/src/openvpn/tun_a=
funix.c</span><br><span>@@ -47,9 +47,12 @@</span><br><span> #include &lt;si=
gnal.h&gt;</span><br><span> #include &lt;stdlib.h&gt;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct=
 env_set *env)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *msgprefix =3D &quot;ERROR: failure executing =
process for tun:&quot;;</span><br><span>     struct argv argv =3D argv_new(=
);</span><br><span> </span><br><span>     /* since we know that dev-node st=
arts with unix: we can just skip that</span><br><span>@@ -58,10 +61,12 @@</=
span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s&quot;=
, program);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    argv_msg(M_INFO, &amp;argv);</span><br><span>     tt-&gt;afunix=
.childprocess =3D openvpn_execve_check(&amp;argv, env, S_NOWAITPID,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
                      &quot;ERROR: failure executing &quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
              &quot;process for tun&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                                   =
msgprefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!openvpn_waitpid_check(tt-&gt;afunix.childprocess, msgprefix, M_WARN))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;afunix.childprocess =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     argv_free(&amp;argv);</span><br><span> }</span><br><span> </span=
><br><span>@@ -138,20 +143,27 @@</span><br><span> ssize_t</span><br><span> =
write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    pid_t pidret =3D waitpid=
(tt-&gt;afunix.childprocess, &amp;ret, WNOHANG);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (pidret =3D=3D tt-&gt;afunix.childprocess=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ms=
g =3D &quot;ERROR: failure during write to AF_UNIX socket: &quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_che=
ck(tt-&gt;afunix.childprocess, msg, M_WARN))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Chi=
ld process PID %d for afunix dead? Return code: %d&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            tt-&gt;afunix.childprocess,=
 ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&g=
t;afunix.childprocess =3D 0;</span><br><span>         return -ENXIO;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</s=
pan><br><span> </span><br><span> ssize_t</span><br><span> read_tun_afunix(s=
truct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *msg =3D &quot;ERROR=
: failure during read from AF_UNIX socket: &quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_check(tt-&gt;afunix=
.childprocess, msg, M_WARN))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   tt-&gt;afunix.childprocess =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* do an actual read on the file descriptor even in the error case s=
ince</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we other=
wise loop on this on this from select and spam the console</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * with error messages */</span>=
<br><span>     return read(tt-&gt;fd, buf, len);</span><br><span> }</span><=
br><span> #else  /* ifndef WIN32 */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demai=
l">change 855</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81cbecd19018290d85c6c77fba7=
769f040d66233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--TN+Nr4PxZcY=--


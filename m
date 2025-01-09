From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 14:42:44 +0000
References: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <857ead877a63a88afb17be062d04275cc49d1a51-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PowZIPkgqtc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PowZIPkgqtc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demail

to review the following change.


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
3 files changed, 62 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/855/1

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index d757823..7f2cfb3 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -107,6 +107,35 @@
 }

 bool
+openvpn_waitpid_check(pid_t pid, const char  *error_message, int msglevel)
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
+        msg(msglevel, "%sexternal program exited with error status: %d",
+            error_message, WEXITSTATUS(status));
+
+    }
+    else if (WIFSIGNALED(status))
+    {
+        msg(msglevel, "%sexternal program received signal %d",
+            error_message, WTERMSIG(status));
+    }
+
+    return false;
+}
+
+bool
 openvpn_execve_allowed(const unsigned int flags)
 {
     if (flags & S_SCRIPT)
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index c92edbc..366acaa 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -59,6 +59,19 @@
 int openvpn_execve_check(const struct argv *a, const struct env_set *es,
                          const unsigned int flags, const char *error_messa=
ge);

+
+/** Checks if a running process is still running. This is mainly useful
+ * for processes started with \c S_NOWAITPID
+ * @param pid               pid of the process to be checked
+ * @param error_message     prefixed of the message that be printed
+ * @param msglevel          msglevel of the messages to be printed
+ * @return                  true if the process is still running, false if
+ *                          an error condition occurred
+ */
+bool
+openvpn_waitpid_check(pid_t pid, const char  *error_message,
+                      int msglevel);
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--PowZIPkgqtc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Improve error reporting from AF_UNIX tun/tap support<br><br>W=
hen having a non-existent lwipovpn binary or similar problems, the<br>error=
 reporting would often only report read error that were harder to<br>identi=
fy the real problem.  Add the openvpn_waitpid_check method<br>that checks f=
or error conditions and reports a better message in cases<br>of problems.<b=
r><br>Change-Id: I81cbecd19018290d85c6c77fba7769f040d66233<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/run_command.=
c<br>M src/openvpn/run_command.h<br>M src/openvpn/tun_afunix.c<br>3 files c=
hanged, 62 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/55/855/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/run_command.c b/src/openvpn/run_command.c</span><br><span>index d757823=
..7f2cfb3 100644</span><br><span>--- a/src/openvpn/run_command.c</span><br>=
<span>+++ b/src/openvpn/run_command.c</span><br><span>@@ -107,6 +107,35 @@<=
/span><br><span> }</span><br><span> </span><br><span> bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+openvpn_waitpid_check(pid_t pid, con=
st char  *error_message, int msglevel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (pid =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    pid_t pidret =3D waitpi=
d(pid, &amp;status, WNOHANG);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (pidret !=3D pid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (WIFEXITED(status))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%sexternal=
 program exited with error status: %d&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            error_message, WEXITSTATUS(status));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (WIFSIGNALED(status))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(msglevel, &quot;%sexternal program receive=
d signal %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           error_message, WTERMSIG(status));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span> openvpn_execve_allowed(co=
nst unsigned int flags)</span><br><span> {</span><br><span>     if (flags &=
amp; S_SCRIPT)</span><br><span>diff --git a/src/openvpn/run_command.h b/src=
/openvpn/run_command.h</span><br><span>index c92edbc..366acaa 100644</span>=
<br><span>--- a/src/openvpn/run_command.h</span><br><span>+++ b/src/openvpn=
/run_command.h</span><br><span>@@ -59,6 +59,19 @@</span><br><span> int open=
vpn_execve_check(const struct argv *a, const struct env_set *es,</span><br>=
<span>                          const unsigned int flags, const char *error=
_message);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Checks=
 if a running process is still running. This is mainly useful</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * for processes started with \c =
S_NOWAITPID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m pid               pid of the process to be checked</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param error_message     prefixed of t=
he message that be printed</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param msglevel          msglevel of the messages to be printed</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return           =
       true if the process is still running, false if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                          an error cond=
ition occurred</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+openvpn_waitpid_check(pid_t pid, con=
st char  *error_message,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                      int msglevel);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Will run a =
script and return the exit code of the script if between</span><br><span>  =
* 0 and 255, -1 otherwise</span><br><span>diff --git a/src/openvpn/tun_afun=
ix.c b/src/openvpn/tun_afunix.c</span><br><span>index 6b6c159..c626993 1006=
44</span><br><span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/src=
/openvpn/tun_afunix.c</span><br><span>@@ -47,9 +47,12 @@</span><br><span> #=
include &lt;signal.h&gt;</span><br><span> #include &lt;stdlib.h&gt;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static voi=
d</span><br><span> tun_afunix_exec_child(const char *dev_node, struct tunta=
p *tt, struct env_set *env)</span><br><span> {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *msgprefix =3D &quot;ERROR: failu=
re executing process for tun:&quot;;</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span> </span><br><span>     /* since we know tha=
t dev-node starts with unix: we can just skip that</span><br><span>@@ -58,1=
0 +61,12 @@</span><br><span> </span><br><span>     argv_printf(&amp;argv, &=
quot;%s&quot;, program);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp;argv);</span><br><span>     =
tt-&gt;afunix.childprocess =3D openvpn_execve_check(&amp;argv, env, S_NOWAI=
TPID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                                   &quot;ERROR: failure executing &quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
                           &quot;process for tun&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
             msgprefix);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!openvpn_waitpid_check(tt-&gt;afunix.childprocess, msgprefix, =
M_WARN))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;afunix.chi=
ldprocess =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span>     argv_free(&amp;argv);</span><br><span> }</span><br>=
<span> </span><br><span>@@ -138,20 +143,27 @@</span><br><span> ssize_t</spa=
n><br><span> write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pid_t pidre=
t =3D waitpid(tt-&gt;afunix.childprocess, &amp;ret, WNOHANG);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (pidret =3D=3D tt-&gt;afunix=
.childprocess)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *msg =3D &quot;ERROR: failure during write to AF_UNIX socket: &qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvp=
n_waitpid_check(tt-&gt;afunix.childprocess, msg, M_WARN))</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_IN=
FO, &quot;Child process PID %d for afunix dead? Return code: %d&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            tt-&gt;afunix.=
childprocess, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        tt-&gt;afunix.childprocess =3D 0;</span><br><span>         return -=
ENXIO;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     return write(tt-&gt;fd, buf, len);</span><b=
r><span> }</span><br><span> </span><br><span> ssize_t</span><br><span> read=
_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *msg =
=3D &quot;ERROR: failure during read from AF_UNIX socket: &quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_chec=
k(tt-&gt;afunix.childprocess, msg, M_WARN))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        tt-&gt;afunix.childprocess =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* do an actual read on the file descriptor even in=
 the error case since</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * we otherwise loop on this on this from select and spam the console=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * with error m=
essages */</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br=
><span> }</span><br><span> #else  /* ifndef WIN32 */</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/855?usp=3Demail">change 855</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/855?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81cbecd19018290d85c6c77fba7=
769f040d66233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--PowZIPkgqtc=--


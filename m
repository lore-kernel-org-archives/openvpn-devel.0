From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 08:26:40 +0000
References: <gerrit.1727166388000.I188923efc0f72b2038f1470740415ce50d07580b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f63815f62b09c7b4ff26937ab9200d8b032b407a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0h3VTt3HlQM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: WIP print child exit
 code
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

--0h3VTt3HlQM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/767?usp=3Demail

to review the following change.


Change subject: WIP print child exit code
......................................................................

WIP print child exit code

Change-Id: I188923efc0f72b2038f1470740415ce50d07580b
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/tun_afunix.c
1 file changed, 30 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/767/1

diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index a2d8552..e26e1d8 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -48,6 +48,31 @@
 #include <stdlib.h>

 static void
+child_handler(int sig)
+{
+    int status;
+    pid_t pid;
+
+    /* EEEEXTEERMINAAATE! */
+    while ((pid =3D waitpid(-1, &status, WNOHANG)) > 0)
+    {
+        msg(M_INFO, "Child process PID %d died with status code %d", pid, =
status);
+    }
+}
+
+static void
+enable_signal_handler(void)
+{
+    /* Establish handler. */
+    struct sigaction sa;
+    sigemptyset(&sa.sa_mask);
+    sa.sa_flags =3D 0;
+    sa.sa_handler =3D child_handler;
+
+    sigaction(SIGCHLD, &sa, NULL);
+}
+
+static void
 tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_=
set *env)
 {
     struct argv argv =3D argv_new();
@@ -59,10 +84,13 @@
     argv_printf(&argv, "%s", program);

     argv_msg(M_INFO, &argv);
+
+    enable_signal_handler();
     tt->afunix.childprocess =3D openvpn_execve_check(&argv, env, S_NOWAITP=
ID,
                                                    "ERROR: failure executi=
ng "
                                                    "process for tun");
     argv_free(&argv);
+
 }

 void
@@ -120,6 +148,8 @@
     gc_free(&gc);
 }

+
+
 void
 close_tun_afunix(struct tuntap *tt)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/767?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I188923efc0f72b2038f1470740415ce50d07580b
Gerrit-Change-Number: 767
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0h3VTt3HlQM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/767?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">WIP print child exit code<br><br>Change-Id: I188923efc0f72b20=
38f1470740415ce50d07580b<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...=
&gt;<br>---<br>M src/openvpn/tun_afunix.c<br>1 file changed, 30 insertions(=
+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/67/767/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun_afunix.c b/src=
/openvpn/tun_afunix.c</span><br><span>index a2d8552..e26e1d8 100644</span><=
br><span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/src/openvpn/t=
un_afunix.c</span><br><span>@@ -48,6 +48,31 @@</span><br><span> #include &l=
t;stdlib.h&gt;</span><br><span> </span><br><span> static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+child_handler(int sig)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    pid_t pid;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* EEEEXTEERMINAAATE! */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    while ((pid =3D waitpid(-1, &amp;status, WNOHANG)) &gt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Child proces=
s PID %d died with status code %d&quot;, pid, status);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+enable_signal_handler(vo=
id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Establish handler. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sigaction sa;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sigemptyset(&amp=
;sa.sa_mask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa=
.sa_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 sa.sa_handler =3D child_handler;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
igaction(SIGCHLD, &amp;sa, NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span> tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct=
 env_set *env)</span><br><span> {</span><br><span>     struct argv argv =3D=
 argv_new();</span><br><span>@@ -59,10 +84,13 @@</span><br><span>     argv_=
printf(&amp;argv, &quot;%s&quot;, program);</span><br><span> </span><br><sp=
an>     argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  enable_signal_handler();</span><br><span>     tt-&gt;afunix.childprocess =
=3D openvpn_execve_check(&amp;argv, env, S_NOWAITPID,</span><br><span>     =
                                               &quot;ERROR: failure executi=
ng &quot;</span><br><span>                                                 =
   &quot;process for tun&quot;);</span><br><span>     argv_free(&amp;argv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> }=
</span><br><span> </span><br><span> void</span><br><span>@@ -120,6 +148,8 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><sp=
an> close_tun_afunix(struct tuntap *tt)</span><br><span> {</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/767?usp=3Demail">change 767</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/767?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I188923efc0f72b2038f14707404=
15ce50d07580b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 767 </div>
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


--0h3VTt3HlQM=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 28 Jan 2026 13:28:22 +0000
In-Reply-To: <gerrit.1769550961000.Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb@...2715...>
References: <gerrit.1769550961000.Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <807ab047c56d4658a5f8104ebfa5a5a3f1944373-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G337y/iYBSs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tunnel_server():
 close correct inotify fd
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

--G337y/iYBSs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: tunnel_server(): close correct inotify fd
......................................................................

tunnel_server(): close correct inotify fd

On a full SIGUSR1 restart of a p2mp server compiled with
--enable-async-push, tunnel_server() will try to close and reopen
the "inotify" control file descriptor.  For whatever reason, the
original code referenced the wrong context, always closing fd 0.

As a consequence of this, on the second SIGUSR1 restart, the server
will close() the first active socket file descriptor, and if there
are active DCO clients, the resulting event confusion will lead to
an ASSERT(!mi->halt).

Fix by closing the correct FD. Add logging.

Github: fixes OpenVPN/openvpn#966

Change-Id: Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1497
Message-Id: <20260128110425.24350-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
478.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1497/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2af49d2..d983793 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4244,7 +4244,9 @@
     tunnel_server_loop(&multi);

 #ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
+    msg(D_LOW, "%s: close multi.top.c2.inotify_fd (%d)",
+        __func__, multi.top.c2.inotify_fd);
+    close(multi.top.c2.inotify_fd);
 #endif

     /* shut down management interface */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb
Gerrit-Change-Number: 1497
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G337y/iYBSs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1497?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">tunnel_server(): close correct =
inotify fd<br><br>On a full SIGUSR1 restart of a p2mp server compiled with<=
br>--enable-async-push, tunnel_server() will try to close and reopen<br>the=
 &quot;inotify&quot; control file descriptor.  For whatever reason, the<br>=
original code referenced the wrong context, always closing fd 0.<br><br>As =
a consequence of this, on the second SIGUSR1 restart, the server<br>will cl=
ose() the first active socket file descriptor, and if there<br>are active D=
CO clients, the resulting event confusion will lead to<br>an ASSERT(!mi-&gt=
;halt).<br><br>Fix by closing the correct FD. Add logging.<br><br>Github: f=
ixes OpenVPN/openvpn#966<br><br>Change-Id: Iabc117848ad7b67d240c392f1a6aa2d=
7531fd5bb<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-b=
y: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1497<br>Message-Id: &lt;20260128110425.24350-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg35478.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 3 insertions(=
+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/97/1497/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/m=
ulti.c b/src/openvpn/multi.c</span><br><span>index 2af49d2..d983793 100644<=
/span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn=
/multi.c</span><br><span>@@ -4244,7 +4244,9 @@</span><br><span>     tunnel_=
server_loop(&amp;multi);</span><br><span> </span><br><span> #ifdef ENABLE_A=
SYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close(to=
p-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_LOW, &quot;%s: close multi.top.c2.inotify_fd (%d)&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, multi.to=
p.c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  close(multi.top.c2.inotify_fd);</span><br><span> #endif</span><br><span> =
</span><br><span>     /* shut down management interface */</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1497?usp=3Demail">change 1497</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1497?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabc117848ad7b67d240c392f1a6=
aa2d7531fd5bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1497 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--G337y/iYBSs=--


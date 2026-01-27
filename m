From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 21:56:06 +0000
References: <gerrit.1769550961000.Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7bba68a6742af281782608b763e040deae2479e3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OudBk3QZi/o="; charset=UTF-8
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

--OudBk3QZi/o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail

to review the following change.


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
---
M src/openvpn/multi.c
1 file changed, 3 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1497/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2af49d2..8f903a4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4244,7 +4244,9 @@
     tunnel_server_loop(&multi);

 #ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
+    msg(D_LOW, "%s: close multi.top.c2.inotify_fd (%d)",
+                __func__, multi.top.c2.inotify_fd );
+    close(multi.top.c2.inotify_fd);
 #endif

     /* shut down management interface */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb
Gerrit-Change-Number: 1497
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--OudBk3QZi/o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tunnel_server(): close correct inotify fd<b=
r><br>On a full SIGUSR1 restart of a p2mp server compiled with<br>--enable-=
async-push, tunnel_server() will try to close and reopen<br>the &quot;inoti=
fy&quot; control file descriptor.  For whatever reason, the<br>original cod=
e referenced the wrong context, always closing fd 0.<br><br>As a consequenc=
e of this, on the second SIGUSR1 restart, the server<br>will close() the fi=
rst active socket file descriptor, and if there<br>are active DCO clients, =
the resulting event confusion will lead to<br>an ASSERT(!mi-&gt;halt).<br><=
br>Fix by closing the correct FD. Add logging.<br><br>Github: fixes OpenVPN=
/openvpn#966<br><br>Change-Id: Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/multi.c<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97=
/1497/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</spa=
n><br><span>index 2af49d2..8f903a4 100644</span><br><span>--- a/src/openvpn=
/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -4244=
,7 +4244,9 @@</span><br><span>     tunnel_server_loop(&amp;multi);</span><b=
r><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c2.inotify_fd);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s: clos=
e multi.top.c2.inotify_fd (%d)&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                __func__, multi.top.c2.inotify_fd );</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(multi.top.c2.i=
notify_fd);</span><br><span> #endif</span><br><span> </span><br><span>     =
/* shut down management interface */</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Dem=
ail">change 1497</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabc117848ad7b67d240c392f1a6=
aa2d7531fd5bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1497 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--OudBk3QZi/o=--


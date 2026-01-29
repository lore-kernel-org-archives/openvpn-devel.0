From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 29 Jan 2026 17:40:06 +0000
In-Reply-To: <gerrit.1769611655000.Idcb1421b9f7fcbee9620fd1d45cceab050751373@...2715...>
References: <gerrit.1769611655000.Idcb1421b9f7fcbee9620fd1d45cceab050751373@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d6ae306c753f6f14daa421d15fc652a08ed00008-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="So26Pr4+x08="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]:
 tunnel_server_*(): close correct inotify fd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--So26Pr4+x08=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
99?usp=3Demail )

Change subject: tunnel_server_*(): close correct inotify fd
......................................................................

tunnel_server_*(): close correct inotify fd

On a full SIGUSR1 restart of a p2mp server compiled with
--enable-async-push, tunnel_server_{udp,tcp}() will try to close and
reopen the "inotify" control file descriptor.  For whatever reason,
the original code referenced the wrong context, always closing fd 0.

As a consequence of this, on the second SIGUSR1 restart, the server
will close() the first active socket file descriptor, and if there
are active DCO clients, the resulting event confusion will lead to
an ASSERT(!mi->halt).

Fix by closing the correct FD. Add logging.

This is a backport of commit 5521872f80313060 to the "old p2mp code"
with a separate mudp.c and mtcp.c for UDP and TCP servers, respectively.

Github: fixes OpenVPN/openvpn#966

Change-Id: Idcb1421b9f7fcbee9620fd1d45cceab050751373
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1499
Message-Id: <20260128150640.13867-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
493.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
2 files changed, 6 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 96408d1..3e33b15 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -850,7 +850,9 @@
     }

 #ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
+    msg(D_LOW, "%s: close multi.top.c2.inotify_fd (%d)",
+        __func__, multi.top.c2.inotify_fd);
+    close(multi.top.c2.inotify_fd);
 #endif

     /* shut down management interface */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 0492311..f7c9ffd 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -524,7 +524,9 @@
     }

 #ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
+    msg(D_LOW, "%s: close multi.top.c2.inotify_fd (%d)",
+        __func__, multi.top.c2.inotify_fd);
+    close(multi.top.c2.inotify_fd);
 #endif

     /* shut down management interface */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1499?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Idcb1421b9f7fcbee9620fd1d45cceab050751373
Gerrit-Change-Number: 1499
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--So26Pr4+x08=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1499?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tunnel_server_*(): close correct inotify fd<br><=
br>On a full SIGUSR1 restart of a p2mp server compiled with<br>--enable-asy=
nc-push, tunnel_server_{udp,tcp}() will try to close and<br>reopen the &quo=
t;inotify&quot; control file descriptor.  For whatever reason,<br>the origi=
nal code referenced the wrong context, always closing fd 0.<br><br>As a con=
sequence of this, on the second SIGUSR1 restart, the server<br>will close()=
 the first active socket file descriptor, and if there<br>are active DCO cl=
ients, the resulting event confusion will lead to<br>an ASSERT(!mi-&gt;halt=
).<br><br>Fix by closing the correct FD. Add logging.<br><br>This is a back=
port of commit 5521872f80313060 to the &quot;old p2mp code&quot;<br>with a =
separate mudp.c and mtcp.c for UDP and TCP servers, respectively.<br><br>Gi=
thub: fixes OpenVPN/openvpn#966<br><br>Change-Id: Idcb1421b9f7fcbee9620fd1d=
45cceab050751373<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1499<br>Message-Id: &lt;20260128150640.13=
867-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg35493.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br=
>2 files changed, 6 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>ind=
ex 96408d1..3e33b15 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><=
br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -850,7 +850,9 @@</span=
><br><span>     }</span><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PU=
SH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c=
2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_LOW, &quot;%s: close multi.top.c2.inotify_fd (%d)&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        __func__, multi.top.c2.in=
otify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close=
(multi.top.c2.inotify_fd);</span><br><span> #endif</span><br><span> </span>=
<br><span>     /* shut down management interface */</span><br><span>diff --=
git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 0492311=
..f7c9ffd 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+=
++ b/src/openvpn/mudp.c</span><br><span>@@ -524,7 +524,9 @@</span><br><span=
>     }</span><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c2.inotify_=
fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, =
&quot;%s: close multi.top.c2.inotify_fd (%d)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        __func__, multi.top.c2.inotify_fd=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(multi.t=
op.c2.inotify_fd);</span><br><span> #endif</span><br><span> </span><br><spa=
n>     /* shut down management interface */</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1499?u=
sp=3Demail">change 1499</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1499?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idcb1421b9f7fcbee9620fd1d45c=
ceab050751373 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1499 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--So26Pr4+x08=--


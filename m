From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 29 Jan 2026 17:40:02 +0000
In-Reply-To: <gerrit.1769611655000.Idcb1421b9f7fcbee9620fd1d45cceab050751373@...2715...>
References: <gerrit.1769611655000.Idcb1421b9f7fcbee9620fd1d45cceab050751373@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d6ae306c753f6f14daa421d15fc652a08ed00008-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cqN1PYS/ccM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cqN1PYS/ccM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1499?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1499/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Idcb1421b9f7fcbee9620fd1d45cceab050751373
Gerrit-Change-Number: 1499
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cqN1PYS/ccM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1499?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">tunnel_server_*(): close correc=
t inotify fd<br><br>On a full SIGUSR1 restart of a p2mp server compiled wit=
h<br>--enable-async-push, tunnel_server_{udp,tcp}() will try to close and<b=
r>reopen the &quot;inotify&quot; control file descriptor.  For whatever rea=
son,<br>the original code referenced the wrong context, always closing fd 0=
.<br><br>As a consequence of this, on the second SIGUSR1 restart, the serve=
r<br>will close() the first active socket file descriptor, and if there<br>=
are active DCO clients, the resulting event confusion will lead to<br>an AS=
SERT(!mi-&gt;halt).<br><br>Fix by closing the correct FD. Add logging.<br><=
br>This is a backport of commit 5521872f80313060 to the &quot;old p2mp code=
&quot;<br>with a separate mudp.c and mtcp.c for UDP and TCP servers, respec=
tively.<br><br>Github: fixes OpenVPN/openvpn#966<br><br>Change-Id: Idcb1421=
b9f7fcbee9620fd1d45cceab050751373<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1499<br>Message-Id: &lt;=
20260128150640.13867-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg35493.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/mtcp.c<br>M src/=
openvpn/mudp.c<br>2 files changed, 6 insertions(+), 2 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/99/1499/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c=
</span><br><span>index 96408d1..3e33b15 100644</span><br><span>--- a/src/op=
envpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -8=
50,7 +850,9 @@</span><br><span>     }</span><br><span> </span><br><span> #i=
fdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    close(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_LOW, &quot;%s: close multi.top.c2.inotify_fd (%d)&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __fun=
c__, multi.top.c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    close(multi.top.c2.inotify_fd);</span><br><span> #endif</spa=
n><br><span> </span><br><span>     /* shut down management interface */</sp=
an><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br=
><span>index 0492311..f7c9ffd 100644</span><br><span>--- a/src/openvpn/mudp=
.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -524,7 +524,=
9 @@</span><br><span>     }</span><br><span> </span><br><span> #ifdef ENABL=
E_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close=
(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_LOW, &quot;%s: close multi.top.c2.inotify_fd (%d)&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, multi=
.top.c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    close(multi.top.c2.inotify_fd);</span><br><span> #endif</span><br><spa=
n> </span><br><span>     /* shut down management interface */</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1499?usp=3Demail">change 1499</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1499?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--cqN1PYS/ccM=--


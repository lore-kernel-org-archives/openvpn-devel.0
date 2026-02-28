From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 28 Feb 2026 09:38:41 +0000
In-Reply-To: <gerrit.1771685160000.I84fe7a11391eafde3660d25a3c99094a0c525f3d@...2715...>
References: <gerrit.1771685160000.I84fe7a11391eafde3660d25a3c99094a0c525f3d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <3f9d7aa9998dad965c1c2d28e4a1851335fc8365-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sH4htSD82jI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_freebsd: use
 AF_LOCAL sockets for ioctl() communication with DCO ...
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

--sH4htSD82jI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1551?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by ordex


Change subject: dco_freebsd: use AF_LOCAL sockets for ioctl() communication=
 with DCO driver
......................................................................

dco_freebsd: use AF_LOCAL sockets for ioctl() communication with DCO driver

DCO FreeBSD uses ioctl() calls for userland -> driver communication, on
a socket() file descriptor.  The original code uses AF_INET sockets,
which fails if using a kernel compiled without IPv4 support.

The kernel side ioctl() handling does not differentiate between AF_INET,
AF_INET6 and AF_LOCAL sockets, and only the latter are guaranteed to be
present.

While add it, add a clear message if the socket() call in dco_available()
fails (it will lead to disabling of DCO).

FreeBSD PR: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D286263
Reported-by: Marek Zarychta <zarychtam@...2997...>

Change-Id: I84fe7a11391eafde3660d25a3c99094a0c525f3d
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1551
Message-Id: <20260227224745.3175-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
795.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 3 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1551/2

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index ee3a5d0..718cd8b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -205,7 +205,7 @@
         return -1;
     }

-    dco->fd =3D socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+    dco->fd =3D socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
     if (dco->fd !=3D -1)
     {
         dco->open =3D true;
@@ -715,9 +715,10 @@
      * loaded, or built into the kernel. */
     (void)kldload("if_ovpn");

-    fd =3D socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+    fd =3D socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
     if (fd < 0)
     {
+        msg(M_WARN | M_ERRNO, "%s: socket() failed, disabling data channel=
 offload", __func__);
         return false;
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1551?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I84fe7a11391eafde3660d25a3c99094a0c525f3d
Gerrit-Change-Number: 1551
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sH4htSD82jI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1551?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dco_freebsd: use AF_LOCAL sockets f=
or ioctl() communication with DCO driver<br><br>DCO FreeBSD uses ioctl() ca=
lls for userland -&gt; driver communication, on<br>a socket() file descript=
or.  The original code uses AF_INET sockets,<br>which fails if using a kern=
el compiled without IPv4 support.<br><br>The kernel side ioctl() handling d=
oes not differentiate between AF_INET,<br>AF_INET6 and AF_LOCAL sockets, an=
d only the latter are guaranteed to be<br>present.<br><br>While add it, add=
 a clear message if the socket() call in dco_available()<br>fails (it will =
lead to disabling of DCO).<br><br>FreeBSD PR: https://bugs.freebsd.org/bugz=
illa/show_bug.cgi?id=3D286263<br>Reported-by: Marek Zarychta &lt;zarychtam@=
...2997...&gt;<br><br>Change-Id: I84fe7a11391eafde3660d25a3c99094a0c525f3d<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Antonio=
 Quartulli &lt;antonio@...2726...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1551<br>Message-Id: &lt;20260227224745.3175-1-gert@...1726...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg35795.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/dco_freebsd.c<br>1 file changed, 3 insertions(+), 2=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/51/1551/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_f=
reebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index ee3a5d0..718cd8b=
 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++=
 b/src/openvpn/dco_freebsd.c</span><br><span>@@ -205,7 +205,7 @@</span><br>=
<span>         return -1;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;fd =3D socket(AF_I=
NET, SOCK_DGRAM | SOCK_CLOEXEC, 0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    dco-&gt;fd =3D socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEX=
EC, 0);</span><br><span>     if (dco-&gt;fd !=3D -1)</span><br><span>     {=
</span><br><span>         dco-&gt;open =3D true;</span><br><span>@@ -715,9 =
+715,10 @@</span><br><span>      * loaded, or built into the kernel. */</sp=
an><br><span>     (void)kldload(&quot;if_ovpn&quot;);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    fd =3D socket(AF_INET=
, SOCK_DGRAM | SOCK_CLOEXEC, 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    fd =3D socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);</sp=
an><br><span>     if (fd &lt; 0)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s:=
 socket() failed, disabling data channel offload&quot;, __func__);</span><b=
r><span>         return false;</span><br><span>     }</span><br><span> </sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1551?usp=3Demail">change 1551</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1551?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I84fe7a11391eafde3660d25a3c9=
9094a0c525f3d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1551 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--sH4htSD82jI=--


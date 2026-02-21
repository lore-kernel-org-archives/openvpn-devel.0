From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 21 Feb 2026 14:46:02 +0000
References: <gerrit.1771685160000.I84fe7a11391eafde3660d25a3c99094a0c525f3d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <59941536208e0a4d2d2615dfe02132ca95742dae-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SK+u899Ruzs="; charset=UTF-8
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

--SK+u899Ruzs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1551?usp=3Demail

to review the following change.


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
---
M src/openvpn/dco_freebsd.c
1 file changed, 3 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1551/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I84fe7a11391eafde3660d25a3c99094a0c525f3d
Gerrit-Change-Number: 1551
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--SK+u899Ruzs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1551?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco_freebsd: use AF_LOCAL sockets for ioctl=
() communication with DCO driver<br><br>DCO FreeBSD uses ioctl() calls for =
userland -&gt; driver communication, on<br>a socket() file descriptor.  The=
 original code uses AF_INET sockets,<br>which fails if using a kernel compi=
led without IPv4 support.<br><br>The kernel side ioctl() handling does not =
differentiate between AF_INET,<br>AF_INET6 and AF_LOCAL sockets, and only t=
he latter are guaranteed to be<br>present.<br><br>While add it, add a clear=
 message if the socket() call in dco_available()<br>fails (it will lead to =
disabling of DCO).<br><br>FreeBSD PR: https://bugs.freebsd.org/bugzilla/sho=
w_bug.cgi?id=3D286263<br>Reported-by: Marek Zarychta &lt;zarychtam@...3004...=
..&gt;<br><br>Change-Id: I84fe7a11391eafde3660d25a3c99094a0c525f3d<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_=
freebsd.c<br>1 file changed, 3 insertions(+), 2 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/5=
1/1551/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_f=
reebsd.c</span><br><span>index ee3a5d0..718cd8b 100644</span><br><span>--- =
a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c=
</span><br><span>@@ -205,7 +205,7 @@</span><br><span>         return -1;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    dco-&gt;fd =3D socket(AF_INET, SOCK_DGRAM | SOCK_CLOEX=
EC, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;=
fd =3D socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);</span><br><span>    =
 if (dco-&gt;fd !=3D -1)</span><br><span>     {</span><br><span>         dc=
o-&gt;open =3D true;</span><br><span>@@ -715,9 +715,10 @@</span><br><span> =
     * loaded, or built into the kernel. */</span><br><span>     (void)kldl=
oad(&quot;if_ovpn&quot;);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    fd =3D socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC,=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fd =3D sock=
et(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);</span><br><span>     if (fd &lt=
; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: socket() failed, disabling =
data channel offload&quot;, __func__);</span><br><span>         return fals=
e;</span><br><span>     }</span><br><span> </span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1551?u=
sp=3Demail">change 1551</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1551?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I84fe7a11391eafde3660d25a3c9=
9094a0c525f3d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1551 </div>
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

--SK+u899Ruzs=--


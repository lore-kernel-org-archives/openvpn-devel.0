From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 14 Jun 2024 12:55:14 +0000
References: <gerrit.1718369712000.I913bb70c5e527e78e7cdb43110e23a8944f35a22@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8a97a2c846c3307974268b2232e5c1420e53fe00-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pCb6sMrskiA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove
 "experimental" denotation for --fast-io
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

--pCb6sMrskiA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail

to review the following change.


Change subject: Remove "experimental" denotation for --fast-io
......................................................................

Remove "experimental" denotation for --fast-io

This option is very old (from SVN days) and has been
used by Access Server for many years. I don't think it
makes sense to claim that it is "experimental" at this
point.

Change-Id: I913bb70c5e527e78e7cdb43110e23a8944f35a22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/generic-options.rst
M src/openvpn/options.c
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/664/1

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index f8a0f48..eb9cf28 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -215,7 +215,7 @@
   are supported by OpenSSL.

 --fast-io
-  (Experimental) Optimize TUN/TAP/UDP I/O writes by avoiding a call to
+  Optimize TUN/TAP/UDP I/O writes by avoiding a call to
   poll/epoll/select prior to the write operation. The purpose of such a
   call would normally be to block until the device or socket is ready to
   accept the write. Such blocking is unnecessary on some platforms which
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index abcde89..f2c7536 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -268,7 +268,7 @@
 #if ENABLE_IP_PKTINFO
     "--multihome     : Configure a multi-homed UDP server.\n"
 #endif
-    "--fast-io       : (experimental) Optimize TUN/TAP/UDP writes.\n"
+    "--fast-io       : Optimize TUN/TAP/UDP writes.\n"
     "--remap-usr1 s  : On SIGUSR1 signals, remap signal (s=3D'SIGHUP' or '=
SIGTERM').\n"
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-r=
estart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping=
-restart.\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I913bb70c5e527e78e7cdb43110e23a8944f35a22
Gerrit-Change-Number: 664
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--pCb6sMrskiA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove &quot;experimental&quot; denotation for --fast-io<br><=
br>This option is very old (from SVN days) and has been<br>used by Access S=
erver for many years. I don&#39;t think it<br>makes sense to claim that it =
is &quot;experimental&quot; at this<br>point.<br><br>Change-Id: I913bb70c5e=
527e78e7cdb43110e23a8944f35a22<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M doc/man-sections/generic-options.rst<br>M src/=
openvpn/options.c<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/664/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/doc/man-sections/generic-options.rst b/doc/man-section=
s/generic-options.rst</span><br><span>index f8a0f48..eb9cf28 100644</span><=
br><span>--- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/d=
oc/man-sections/generic-options.rst</span><br><span>@@ -215,7 +215,7 @@</sp=
an><br><span>   are supported by OpenSSL.</span><br><span> </span><br><span=
> --fast-io</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (Experim=
ental) Optimize TUN/TAP/UDP I/O writes by avoiding a call to</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Optimize TUN/TAP/UDP I/O writes =
by avoiding a call to</span><br><span>   poll/epoll/select prior to the wri=
te operation. The purpose of such a</span><br><span>   call would normally =
be to block until the device or socket is ready to</span><br><span>   accep=
t the write. Such blocking is unnecessary on some platforms which</span><br=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index abcde89..f2c7536 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -268,7=
 +268,7 @@</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>     &quo=
t;--multihome     : Configure a multi-homed UDP server.\n&quot;</span><br><=
span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot=
;--fast-io       : (experimental) Optimize TUN/TAP/UDP writes.\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--fast-io     =
  : Optimize TUN/TAP/UDP writes.\n&quot;</span><br><span>     &quot;--remap=
-usr1 s  : On SIGUSR1 signals, remap signal (s=3D&#39;SIGHUP&#39; or &#39;S=
IGTERM&#39;).\n&quot;</span><br><span>     &quot;--persist-tun   : Keep tun=
/tap device open across SIGUSR1 or --ping-restart.\n&quot;</span><br><span>=
     &quot;--persist-remote-ip : Keep remote IP address across SIGUSR1 or -=
-ping-restart.\n&quot;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail">change 664=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I913bb70c5e527e78e7cdb43110e=
23a8944f35a22 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 664 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--pCb6sMrskiA=--


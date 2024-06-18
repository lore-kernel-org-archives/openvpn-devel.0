From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 18 Jun 2024 16:37:11 +0000
In-Reply-To: <gerrit.1718369712000.I913bb70c5e527e78e7cdb43110e23a8944f35a22@...2715...>
References: <gerrit.1718369712000.I913bb70c5e527e78e7cdb43110e23a8944f35a22@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e959c719acf263bf99c78cb1f994e2f2703f644a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mCcGdT/6/Ck="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mCcGdT/6/Ck=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Remove "experimental" denotation for --fast-io
......................................................................

Remove "experimental" denotation for --fast-io

This option is very old (from SVN days) and has been
used by Access Server for many years. I don't think it
makes sense to claim that it is "experimental" at this
point.

Change-Id: I913bb70c5e527e78e7cdb43110e23a8944f35a22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240618120156.4836-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
772.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/generic-options.rst
M src/openvpn/options.c
2 files changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/664/2

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/664?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I913bb70c5e527e78e7cdb43110e23a8944f35a22
Gerrit-Change-Number: 664
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--mCcGdT/6/Ck=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/664?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove &quot;experimental&quot; denotation for -=
-fast-io<br><br>This option is very old (from SVN days) and has been<br>use=
d by Access Server for many years. I don&#39;t think it<br>makes sense to c=
laim that it is &quot;experimental&quot; at this<br>point.<br><br>Change-Id=
: I913bb70c5e527e78e7cdb43110e23a8944f35a22<br>Signed-off-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1186...=
.1227...&gt;<br>Message-Id: &lt;20240618120156.4836-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
28772.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M doc/man-sections/generic-options.rst<br>M src/openvpn/options.c<br>2 fil=
es changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/64/664/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/m=
an-sections/generic-options.rst b/doc/man-sections/generic-options.rst</spa=
n><br><span>index f8a0f48..eb9cf28 100644</span><br><span>--- a/doc/man-sec=
tions/generic-options.rst</span><br><span>+++ b/doc/man-sections/generic-op=
tions.rst</span><br><span>@@ -215,7 +215,7 @@</span><br><span>   are suppor=
ted by OpenSSL.</span><br><span> </span><br><span> --fast-io</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  (Experimental) Optimize TUN/TAP/UD=
P I/O writes by avoiding a call to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  Optimize TUN/TAP/UDP I/O writes by avoiding a call to</spa=
n><br><span>   poll/epoll/select prior to the write operation. The purpose =
of such a</span><br><span>   call would normally be to block until the devi=
ce or socket is ready to</span><br><span>   accept the write. Such blocking=
 is unnecessary on some platforms which</span><br><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index abcde89..f2c7=
536 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -268,7 +268,7 @@</span><br><span=
> #if ENABLE_IP_PKTINFO</span><br><span>     &quot;--multihome     : Config=
ure a multi-homed UDP server.\n&quot;</span><br><span> #endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &quot;--fast-io       : (experi=
mental) Optimize TUN/TAP/UDP writes.\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;--fast-io       : Optimize TUN/TAP/UDP w=
rites.\n&quot;</span><br><span>     &quot;--remap-usr1 s  : On SIGUSR1 sign=
als, remap signal (s=3D&#39;SIGHUP&#39; or &#39;SIGTERM&#39;).\n&quot;</spa=
n><br><span>     &quot;--persist-tun   : Keep tun/tap device open across SI=
GUSR1 or --ping-restart.\n&quot;</span><br><span>     &quot;--persist-remot=
e-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\n&quot;</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/664?usp=3Demail">change 664</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/664?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I913bb70c5e527e78e7cdb43110e=
23a8944f35a22 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 664 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--mCcGdT/6/Ck=--


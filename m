From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Nov 2024 20:19:07 +0000
References: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0c672d80dbb4ba15fff71ff55d3afeafe7237bec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rOFlnlkBL7I="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: send uname()
 release as IV_PLAT_VER= on non-windows versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rOFlnlkBL7I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail

to review the following change.


Change subject: send uname() release as IV_PLAT_VER=3D on non-windows versi=
ons
......................................................................

send uname() release as IV_PLAT_VER=3D on non-windows versions

This is highly system specific, as the content of the uname()
structure elements is not specified very well - uname(3) says:

      release       Release level of the operating system

which translates to "IV_PLAT_VER=3D13.3-RELEASE-p6" (FreeBSD) or
"IV_PLAT_VER=3D22.6.0" (macOS) - the latter being the "Mach Kernel
version", not what Apple calls the OS.

It's still useful if a server operator needs to keep track of
client versions (and the GUI does not set the corresponding
environment variable, which neither Tunnelblick nor NM do).

Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
M src/openvpn/syshead.h
2 files changed, 8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/793/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8040e7b..8632832 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2010,6 +2010,10 @@
             buf_printf(&out, "IV_SSL=3D%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
             buf_printf(&out, "IV_PLAT_VER=3D%s\n", win32_version_string(&g=
c, false));
+#else
+	    struct utsname u;
+	    uname(&u);
+            buf_printf(&out, "IV_PLAT_VER=3D%s\n", u.release);
 #endif
         }

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 83a48fc..33a90c1 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -331,6 +331,10 @@
 #include <sys/mman.h>
 #endif

+#ifndef _WIN32
+#include <sys/utsname.h>
+#endif
+
 /*
  * Pedantic mode is meant to accomplish lint-style program checking,
  * not to build a working executable.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169
Gerrit-Change-Number: 793
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--rOFlnlkBL7I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">send uname() release as IV_PLAT_VER=3D on non-windows version=
s<br><br>This is highly system specific, as the content of the uname()<br>s=
tructure elements is not specified very well - uname(3) says:<br><br>      =
release       Release level of the operating system<br><br>which translates=
 to &quot;IV_PLAT_VER=3D13.3-RELEASE-p6&quot; (FreeBSD) or<br>&quot;IV_PLAT=
_VER=3D22.6.0&quot; (macOS) - the latter being the &quot;Mach Kernel<br>ver=
sion&quot;, not what Apple calls the OS.<br><br>It&#39;s still useful if a =
server operator needs to keep track of<br>client versions (and the GUI does=
 not set the corresponding<br>environment variable, which neither Tunnelbli=
ck nor NM do).<br><br>Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/ssl.c<br>M src/openvpn/syshead.h<br>2 files changed, 8 insertions(+), 0=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/93/793/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl=
.c</span><br><span>index 8040e7b..8632832 100644</span><br><span>--- a/src/=
openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2=
010,6 +2010,10 @@</span><br><span>             buf_printf(&amp;out, &quot;I=
V_SSL=3D%s\n&quot;, get_ssl_library_version() );</span><br><span> #if defin=
ed(_WIN32)</span><br><span>             buf_printf(&amp;out, &quot;IV_PLAT_=
VER=3D%s\n&quot;, win32_version_string(&amp;gc, false));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	    struct utsname u;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	    uname(&amp;u);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;IV_PLAT_VE=
R=3D%s\n&quot;, u.release);</span><br><span> #endif</span><br><span>       =
  }</span><br><span> </span><br><span>diff --git a/src/openvpn/syshead.h b/=
src/openvpn/syshead.h</span><br><span>index 83a48fc..33a90c1 100644</span><=
br><span>--- a/src/openvpn/syshead.h</span><br><span>+++ b/src/openvpn/sysh=
ead.h</span><br><span>@@ -331,6 +331,10 @@</span><br><span> #include &lt;sy=
s/mman.h&gt;</span><br><span> #endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;sys/utsname.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Pedant=
ic mode is meant to accomplish lint-style program checking,</span><br><span=
>  * not to build a working executable.</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3D=
email">change 793</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2b0c5a517f02e5c219fea2ae3e=
f2bdef7690169 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 793 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--rOFlnlkBL7I=--


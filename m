From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 6 Nov 2024 07:05:07 +0000
In-Reply-To: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
References: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <08472c8aecf3d724ba6479d66a3c03823587746d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QVe40IgzecU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: send uname() release
 as IV_PLAT_VER= on non-windows versions
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

--QVe40IgzecU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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

v2: manpage amendments
v3: whitespace
v4: reword manpage

Github: OpenVPN/openvpn#637

Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <a@...2181...>
Message-Id: <20241104085808.17039-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
699.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
M src/openvpn/ssl.c
M src/openvpn/syshead.h
3 files changed, 12 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/793/5

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index a06948e..5ca85e0 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -430,7 +430,10 @@
         The version of the operating system, e.g. 6.1 for Windows 7.
         This may be set by the client UI/GUI using ``--setenv``.
         On Windows systems it is automatically determined by openvpn
-        itself.
+        itself.  On other platforms OpenVPN will default to sending
+        the information returned by the `uname()` system call in
+        the `release` field, which is usually the currently running
+        kernel version.  This is highly system specific, though.

   :code:`UV_<name>=3D<value>`
         Client environment variables whose names start with
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8040e7b..93e31f1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2010,6 +2010,10 @@
             buf_printf(&out, "IV_SSL=3D%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
             buf_printf(&out, "IV_PLAT_VER=3D%s\n", win32_version_string(&g=
c, false));
+#else
+            struct utsname u;
+            uname(&u);
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
Gerrit-PatchSet: 5
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--QVe40IgzecU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">send uname() release as IV_PLAT_VER=3D on non-window=
s versions<br><br>This is highly system specific, as the content of the una=
me()<br>structure elements is not specified very well - uname(3) says:<br><=
br>      release       Release level of the operating system<br><br>which t=
ranslates to &quot;IV_PLAT_VER=3D13.3-RELEASE-p6&quot; (FreeBSD) or<br>&quo=
t;IV_PLAT_VER=3D22.6.0&quot; (macOS) - the latter being the &quot;Mach Kern=
el<br>version&quot;, not what Apple calls the OS.<br><br>It&#39;s still use=
ful if a server operator needs to keep track of<br>client versions (and the=
 GUI does not set the corresponding<br>environment variable, which neither =
Tunnelblick nor NM do).<br><br>v2: manpage amendments<br>v3: whitespace<br>=
v4: reword manpage<br><br>Github: OpenVPN/openvpn#637<br><br>Change-Id: Id2=
b0c5a517f02e5c219fea2ae3ef2bdef7690169<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...2181...&gt;<br>M=
essage-Id: &lt;20241104085808.17039-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29699.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-secti=
ons/client-options.rst<br>M src/openvpn/ssl.c<br>M src/openvpn/syshead.h<br=
>3 files changed, 12 insertions(+), 1 deletion(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/93/793/5</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rs=
t</span><br><span>index a06948e..5ca85e0 100644</span><br><span>--- a/doc/m=
an-sections/client-options.rst</span><br><span>+++ b/doc/man-sections/clien=
t-options.rst</span><br><span>@@ -430,7 +430,10 @@</span><br><span>        =
 The version of the operating system, e.g. 6.1 for Windows 7.</span><br><sp=
an>         This may be set by the client UI/GUI using ``--setenv``.</span>=
<br><span>         On Windows systems it is automatically determined by ope=
nvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        itself.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        itself.  On o=
ther platforms OpenVPN will default to sending</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        the information returned by the `uname()=
` system call in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     the `release` field, which is usually the currently running</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        kernel version.  This =
is highly system specific, though.</span><br><span> </span><br><span>   :co=
de:`UV_&lt;name&gt;=3D&lt;value&gt;`</span><br><span>         Client enviro=
nment variables whose names start with</span><br><span>diff --git a/src/ope=
nvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 8040e7b..93e31f1 10064=
4</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn=
/ssl.c</span><br><span>@@ -2010,6 +2010,10 @@</span><br><span>             =
buf_printf(&amp;out, &quot;IV_SSL=3D%s\n&quot;, get_ssl_library_version() )=
;</span><br><span> #if defined(_WIN32)</span><br><span>             buf_pri=
ntf(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, win32_version_string(&amp;gc,=
 false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct utsna=
me u;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            un=
ame(&amp;u);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     buf_printf(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, u.release);</span=
><br><span> #endif</span><br><span>         }</span><br><span> </span><br><=
span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><=
span>index 83a48fc..33a90c1 100644</span><br><span>--- a/src/openvpn/syshea=
d.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -331,6 +=
331,10 @@</span><br><span> #include &lt;sys/mman.h&gt;</span><br><span> #en=
dif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;sys/utsname.h&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /*</span><br><span>  * Pedantic mode is meant to accomplish li=
nt-style program checking,</span><br><span>  * not to build a working execu=
table.</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail">change 793</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/793?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2b0c5a517f02e5c219fea2ae3e=
f2bdef7690169 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 793 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--QVe40IgzecU=--


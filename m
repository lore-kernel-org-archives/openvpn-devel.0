From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 6 Nov 2024 07:05:11 +0000
In-Reply-To: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
References: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <08472c8aecf3d724ba6479d66a3c03823587746d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dKgUPR7lx6U="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dKgUPR7lx6U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/79=
3?usp=3Demail )

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
Gerrit-MessageType: merged

--dKgUPR7lx6U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/793?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">send uname() release as IV_PLAT_VER=3D on non-=
windows versions<br><br>This is highly system specific, as the content of t=
he uname()<br>structure elements is not specified very well - uname(3) says=
:<br><br>      release       Release level of the operating system<br><br>w=
hich translates to &quot;IV_PLAT_VER=3D13.3-RELEASE-p6&quot; (FreeBSD) or<b=
r>&quot;IV_PLAT_VER=3D22.6.0&quot; (macOS) - the latter being the &quot;Mac=
h Kernel<br>version&quot;, not what Apple calls the OS.<br><br>It&#39;s sti=
ll useful if a server operator needs to keep track of<br>client versions (a=
nd the GUI does not set the corresponding<br>environment variable, which ne=
ither Tunnelblick nor NM do).<br><br>v2: manpage amendments<br>v3: whitespa=
ce<br>v4: reword manpage<br><br>Github: OpenVPN/openvpn#637<br><br>Change-I=
d: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...2181...&gt=
;<br>Message-Id: &lt;20241104085808.17039-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29699.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man=
-sections/client-options.rst<br>M src/openvpn/ssl.c<br>M src/openvpn/syshea=
d.h<br>3 files changed, 12 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/clie=
nt-options.rst</span><br><span>index a06948e..5ca85e0 100644</span><br><spa=
n>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b/doc/man-s=
ections/client-options.rst</span><br><span>@@ -430,7 +430,10 @@</span><br><=
span>         The version of the operating system, e.g. 6.1 for Windows 7.<=
/span><br><span>         This may be set by the client UI/GUI using ``--set=
env``.</span><br><span>         On Windows systems it is automatically dete=
rmined by openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    itself.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
itself.  On other platforms OpenVPN will default to sending</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        the information returned by=
 the `uname()` system call in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        the `release` field, which is usually the currently runni=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        kernel ve=
rsion.  This is highly system specific, though.</span><br><span> </span><br=
><span>   :code:`UV_&lt;name&gt;=3D&lt;value&gt;`</span><br><span>         =
Client environment variables whose names start with</span><br><span>diff --=
git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 8040e7b..=
93e31f1 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ =
b/src/openvpn/ssl.c</span><br><span>@@ -2010,6 +2010,10 @@</span><br><span>=
             buf_printf(&amp;out, &quot;IV_SSL=3D%s\n&quot;, get_ssl_librar=
y_version() );</span><br><span> #if defined(_WIN32)</span><br><span>       =
      buf_printf(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, win32_version_st=
ring(&amp;gc, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 struct utsname u;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           uname(&amp;u);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_printf(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, u.re=
lease);</span><br><span> #endif</span><br><span>         }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.=
h</span><br><span>index 83a48fc..33a90c1 100644</span><br><span>--- a/src/o=
penvpn/syshead.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><spa=
n>@@ -331,6 +331,10 @@</span><br><span> #include &lt;sys/mman.h&gt;</span><=
br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;sys/utsname.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /*</span><br><span>  * Pedantic mode is meant to =
accomplish lint-style program checking,</span><br><span>  * not to build a =
working executable.</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail">change 793</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/793?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--dKgUPR7lx6U=--


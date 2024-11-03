From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Nov 2024 20:23:21 +0000
In-Reply-To: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
References: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <58bd07c0255ef37b3ee65a53c0ee695b4333a5e5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DTASTC33gc8="; charset=UTF-8
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

--DTASTC33gc8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail

to look at the new patch set (#2).


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

Github: OpenVPN/openvpn#637

Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
M src/openvpn/ssl.c
M src/openvpn/syshead.h
3 files changed, 12 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/793/2

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index a06948e..2f8d962 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -430,7 +430,10 @@
         The version of the operating system, e.g. 6.1 for Windows 7.
         This may be set by the client UI/GUI using ``--setenv``.
         On Windows systems it is automatically determined by openvpn
-        itself.
+        itself.  On other platforms OpenVPN will send the information
+        returned by the `uname(3)` system call, in the `release`
+        field.  Quite often this is the operation system kernel
+        version, but this is highly system specific.

   :code:`UV_<name>=3D<value>`
         Client environment variables whose names start with
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
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--DTASTC33gc8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">send uname() release as IV_PLAT_VER=3D on non-windows versions<br><br>Thi=
s is highly system specific, as the content of the uname()<br>structure ele=
ments is not specified very well - uname(3) says:<br><br>      release     =
  Release level of the operating system<br><br>which translates to &quot;IV=
_PLAT_VER=3D13.3-RELEASE-p6&quot; (FreeBSD) or<br>&quot;IV_PLAT_VER=3D22.6.=
0&quot; (macOS) - the latter being the &quot;Mach Kernel<br>version&quot;, =
not what Apple calls the OS.<br><br>It&#39;s still useful if a server opera=
tor needs to keep track of<br>client versions (and the GUI does not set the=
 corresponding<br>environment variable, which neither Tunnelblick nor NM do=
).<br><br>v2: manpage amendments<br><br>Github: OpenVPN/openvpn#637<br><br>=
Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/client-option=
s.rst<br>M src/openvpn/ssl.c<br>M src/openvpn/syshead.h<br>3 files changed,=
 12 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/93/793/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections=
/client-options.rst b/doc/man-sections/client-options.rst</span><br><span>i=
ndex a06948e..2f8d962 100644</span><br><span>--- a/doc/man-sections/client-=
options.rst</span><br><span>+++ b/doc/man-sections/client-options.rst</span=
><br><span>@@ -430,7 +430,10 @@</span><br><span>         The version of the=
 operating system, e.g. 6.1 for Windows 7.</span><br><span>         This ma=
y be set by the client UI/GUI using ``--setenv``.</span><br><span>         =
On Windows systems it is automatically determined by openvpn</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        itself.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        itself.  On other platforms Open=
VPN will send the information</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        returned by the `uname(3)` system call, in the `release`<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        field.  Quit=
e often this is the operation system kernel</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        version, but this is highly system specific=
.</span><br><span> </span><br><span>   :code:`UV_&lt;name&gt;=3D&lt;value&g=
t;`</span><br><span>         Client environment variables whose names start=
 with</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</s=
pan><br><span>index 8040e7b..8632832 100644</span><br><span>--- a/src/openv=
pn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2010,6=
 +2010,10 @@</span><br><span>             buf_printf(&amp;out, &quot;IV_SSL=
=3D%s\n&quot;, get_ssl_library_version() );</span><br><span> #if defined(_W=
IN32)</span><br><span>             buf_printf(&amp;out, &quot;IV_PLAT_VER=
=3D%s\n&quot;, win32_version_string(&amp;gc, false));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	    struct utsname u;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	    uname(&amp;u);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;IV_PLAT_VER=
=3D%s\n&quot;, u.release);</span><br><span> #endif</span><br><span>        =
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/syshead.h b/s=
rc/openvpn/syshead.h</span><br><span>index 83a48fc..33a90c1 100644</span><b=
r><span>--- a/src/openvpn/syshead.h</span><br><span>+++ b/src/openvpn/syshe=
ad.h</span><br><span>@@ -331,6 +331,10 @@</span><br><span> #include &lt;sys=
/mman.h&gt;</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;sys/utsname.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Pedanti=
c mode is meant to accomplish lint-style program checking,</span><br><span>=
  * not to build a working executable.</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3De=
mail">change 793</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/793?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2b0c5a517f02e5c219fea2ae3e=
f2bdef7690169 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 793 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DTASTC33gc8=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 15:05:17 +0000
In-Reply-To: <gerrit.1732799652000.I41eeae35ab23d9fb2512f33086f20f54c2d4f6df@...2715...>
References: <gerrit.1732799652000.I41eeae35ab23d9fb2512f33086f20f54c2d4f6df@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b36a9cfaeaf99a358f8a60679f0201ca81f453fa-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8fCbzQ0Qhdk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: macOS: Assume that
 net/if_utun.h is always present
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

--8fCbzQ0Qhdk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/823?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: macOS: Assume that net/if_utun.h is always present
......................................................................

macOS: Assume that net/if_utun.h is always present

Has been present in all releases since 10.7,
i.e. about 13 years ago. At this point the check
just makes the code uglier for no actual benefit.

Change-Id: I41eeae35ab23d9fb2512f33086f20f54c2d4f6df
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20241128142708.14665-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
963.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M src/openvpn/tun.c
4 files changed, 14 insertions(+), 25 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/823/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..ca58cd7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -145,7 +145,6 @@
     set(ENABLE_DCO YES)
 elseif (APPLE)
     set(TARGET_DARWIN YES)
-    set(HAVE_NET_IF_UTUN_H YES)
 else()
     message(FATAL_ERROR "Unknown system name: \"${CMAKE_SYSTEM_NAME}\"")
 endif ()
@@ -223,7 +222,6 @@
 check_include_files(net/if.h HAVE_NET_IF_H)
 check_include_files("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
 check_include_files(arpa/inet.h HAVE_ARPA_INET_H)
-check_include_files(net/if_utun.h HAVE_NET_UTUN_H)
 check_include_files(sys/ioctl.h HAVE_SYS_IOCTL_H)
 check_include_files(sys/inotify.h HAVE_SYS_INOTIFY_H)
 check_include_files("${NETEXTRA};sys/uio.h" HAVE_SYS_UIO_H)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 18af5e9..3c517d7 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -202,9 +202,6 @@
 /* Define to 1 if you have the <net/if_tun.h> header file. */
 #cmakedefine HAVE_NET_IF_TUN_H

-/* Define to 1 if you have the <net/if_utun.h> header file. */
-#cmakedefine01 HAVE_NET_IF_UTUN_H
-
 /* Define to 1 if you have the <net/tun/if_tun.h> header file. */
 #cmakedefine HAVE_NET_TUN_IF_TUN_H

diff --git a/configure.ac b/configure.ac
index 7f6e43d..9777e36 100644
--- a/configure.ac
+++ b/configure.ac
@@ -502,7 +502,7 @@
 "

 AC_CHECK_HEADERS(
-	[net/if.h netinet/ip.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h=
],
+	[net/if.h netinet/ip.h resolv.h sys/un.h sys/kern_control.h],
 	,
 	,
 	[[${SOCKET_INCLUDES}]]
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 29d823d..1e67d37 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -437,7 +437,7 @@
 #include <stropts.h>
 #endif

-#if defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H
+#if defined(TARGET_DARWIN)
 #include <sys/kern_control.h>
 #include <net/if_utun.h>
 #include <sys/sys_domain.h>
@@ -1782,7 +1782,7 @@
 #endif
 }

-#if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTU=
N_H)
+#if defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)

 /*
  * OpenBSD and Mac OS X when using utun
@@ -1871,7 +1871,7 @@
         return read(tt->fd, buf, len);
     }
 }
-#endif /* if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_N=
ET_IF_UTUN_H) */
+#endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */

 bool
 tun_name_is_fixed(const char *dev)
@@ -3215,14 +3215,12 @@
  * (http://newosxbook.com/src.jl?tree=3Dlistings&file=3D17-15-utun.c)
  */

-#ifdef HAVE_NET_IF_UTUN_H
-
 /* Helper functions that tries to open utun device
  * return -2 on early initialization failures (utun not supported
- * at all (old OS X) and -1 on initlization failure of utun
- * device (utun works but utunX is already used */
-static
-int
+ * at all) and -1 on initlization failure of utun
+ * device (utun works but utunX is already used)
+ */
+static int
 utun_open_helper(struct ctl_info ctlInfo, int utunnum)
 {
     struct sockaddr_ctl sc;
@@ -3346,13 +3344,10 @@
     tt->backend_driver =3D DRIVER_UTUN;
 }

-#endif /* ifdef HAVE_NET_IF_UTUN_H */
-
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, stru=
ct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-#ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
     if ((!dev_node && tt->type=3D=3DDEV_TYPE_TUN)
         || (dev_node && !strncmp(dev_node, "utun", 4)))
@@ -3387,7 +3382,6 @@
         }
     }
     else
-#endif /* ifdef HAVE_NET_IF_UTUN_H */
     {

         /* Use plain dev-node tun to select /dev/tun style
@@ -3431,27 +3425,27 @@
 int
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
-#ifdef HAVE_NET_IF_UTUN_H
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
         return write_tun_header(tt, buf, len);
     }
     else
-#endif
-    return write(tt->fd, buf, len);
+    {
+        return write(tt->fd, buf, len);
+    }
 }

 int
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
-#ifdef HAVE_NET_IF_UTUN_H
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
         return read_tun_header(tt, buf, len);
     }
     else
-#endif
-    return read(tt->fd, buf, len);
+    {
+        return read(tt->fd, buf, len);
+    }
 }

 #elif defined(TARGET_AIX)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/823?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41eeae35ab23d9fb2512f33086f20f54c2d4f6df
Gerrit-Change-Number: 823
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--8fCbzQ0Qhdk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/823?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">macOS: Assume that net/if_utun.h is always prese=
nt<br><br>Has been present in all releases since 10.7,<br>i.e. about 13 yea=
rs ago. At this point the check<br>just makes the code uglier for no actual=
 benefit.<br><br>Change-Id: I41eeae35ab23d9fb2512f33086f20f54c2d4f6df<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne S=
chwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20241128142708.14=
665-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg29963.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M co=
nfigure.ac<br>M src/openvpn/tun.c<br>4 files changed, 14 insertions(+), 25 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/23/823/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</spa=
n><br><span>index 5db207d..ca58cd7 100644</span><br><span>--- a/CMakeLists.=
txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -145,7 +145,6 @=
@</span><br><span>     set(ENABLE_DCO YES)</span><br><span> elseif (APPLE)<=
/span><br><span>     set(TARGET_DARWIN YES)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    set(HAVE_NET_IF_UTUN_H YES)</span><br><span> else=
()</span><br><span>     message(FATAL_ERROR &quot;Unknown system name: \&qu=
ot;${CMAKE_SYSTEM_NAME}\&quot;&quot;)</span><br><span> endif ()</span><br><=
span>@@ -223,7 +222,6 @@</span><br><span> check_include_files(net/if.h HAVE=
_NET_IF_H)</span><br><span> check_include_files(&quot;${NETEXTRA};netinet/i=
p.h&quot; HAVE_NETINET_IP_H)</span><br><span> check_include_files(arpa/inet=
.h HAVE_ARPA_INET_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
heck_include_files(net/if_utun.h HAVE_NET_UTUN_H)</span><br><span> check_in=
clude_files(sys/ioctl.h HAVE_SYS_IOCTL_H)</span><br><span> check_include_fi=
les(sys/inotify.h HAVE_SYS_INOTIFY_H)</span><br><span> check_include_files(=
&quot;${NETEXTRA};sys/uio.h&quot; HAVE_SYS_UIO_H)</span><br><span>diff --gi=
t a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index 18af5e9..3c=
517d7 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/=
config.h.cmake.in</span><br><span>@@ -202,9 +202,6 @@</span><br><span> /* D=
efine to 1 if you have the &lt;net/if_tun.h&gt; header file. */</span><br><=
span> #cmakedefine HAVE_NET_IF_TUN_H</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;net/if_=
utun.h&gt; header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#cmakedefine01 HAVE_NET_IF_UTUN_H</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;net/t=
un/if_tun.h&gt; header file. */</span><br><span> #cmakedefine HAVE_NET_TUN_=
IF_TUN_H</span><br><span> </span><br><span>diff --git a/configure.ac b/conf=
igure.ac</span><br><span>index 7f6e43d..9777e36 100644</span><br><span>--- =
a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -502,7=
 +502,7 @@</span><br><span> &quot;</span><br><span> </span><br><span> AC_CH=
ECK_HEADERS(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[net/if.=
h netinet/ip.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	[net/if.h netinet/ip.h res=
olv.h sys/un.h sys/kern_control.h],</span><br><span> 	,</span><br><span> 	,=
</span><br><span> 	[[${SOCKET_INCLUDES}]]</span><br><span>diff --git a/src/=
openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 29d823d..1e67d37 10=
0644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/open=
vpn/tun.c</span><br><span>@@ -437,7 +437,7 @@</span><br><span> #include &lt=
;stropts.h&gt;</span><br><span> #endif</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_DARWIN) &amp;&amp; HA=
VE_NET_IF_UTUN_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(TARGET_DARWIN)</span><br><span> #include &lt;sys/kern_control.h&gt=
;</span><br><span> #include &lt;net/if_utun.h&gt;</span><br><span> #include=
 &lt;sys/sys_domain.h&gt;</span><br><span>@@ -1782,7 +1782,7 @@</span><br><=
span> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined (TARGET_OPENBSD) || (defined(TARGET=
_DARWIN) &amp;&amp; HAVE_NET_IF_UTUN_H)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)</=
span><br><span> </span><br><span> /*</span><br><span>  * OpenBSD and Mac OS=
 X when using utun</span><br><span>@@ -1871,7 +1871,7 @@</span><br><span>  =
       return read(tt-&gt;fd, buf, len);</span><br><span>     }</span><br><=
span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if d=
efined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) &amp;&amp; HAVE_NET_IF_U=
TUN_H) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span> <=
/span><br><span> bool</span><br><span> tun_name_is_fixed(const char *dev)</=
span><br><span>@@ -3215,14 +3215,12 @@</span><br><span>  * (http://newosxbo=
ok.com/src.jl?tree=3Dlistings&amp;file=3D17-15-utun.c)</span><br><span>  */=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def HAVE_NET_IF_UTUN_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /* Helper functions that tries to open utun device</span=
><br><span>  * return -2 on early initialization failures (utun not support=
ed</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * at all (old OS X=
) and -1 on initlization failure of utun</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * device (utun works but utunX is already used */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * at all) and -1 on initlization failure of utun</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * device (utun works but ut=
unX is already used)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</spa=
n><br><span> utun_open_helper(struct ctl_info ctlInfo, int utunnum)</span><=
br><span> {</span><br><span>     struct sockaddr_ctl sc;</span><br><span>@@=
 -3346,13 +3344,10 @@</span><br><span>     tt-&gt;backend_driver =3D DRIVER=
_UTUN;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif /* ifdef HAVE_NET_IF_UTUN_H */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><spa=
n> open_tun(const char *dev, const char *dev_type, const char *dev_node, st=
ruct tuntap *tt,</span><br><span>          openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE=
_NET_IF_UTUN_H</span><br><span>     /* If dev_node does not start start wit=
h utun assume regular tun/tap */</span><br><span>     if ((!dev_node &amp;&=
amp; tt-&gt;type=3D=3DDEV_TYPE_TUN)</span><br><span>         || (dev_node &=
amp;&amp; !strncmp(dev_node, &quot;utun&quot;, 4)))</span><br><span>@@ -338=
7,7 +3382,6 @@</span><br><span>         }</span><br><span>     }</span><br>=
<span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
 /* ifdef HAVE_NET_IF_UTUN_H */</span><br><span>     {</span><br><span> </s=
pan><br><span>         /* Use plain dev-node tun to select /dev/tun style</=
span><br><span>@@ -3431,27 +3425,27 @@</span><br><span> int</span><br><span=
> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_NET_IF_UTUN_=
H</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span>=
<br><span>     {</span><br><span>         return write_tun_header(tt, buf, =
len);</span><br><span>     }</span><br><span>     else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return write(tt-&gt;fd, buf, len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return write(tt-&gt;fd, buf, len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</spa=
n><br><span> </span><br><span> int</span><br><span> read_tun(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef HAVE_NET_IF_UTUN_H</span><br><span>     if =
(tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br=
><span>         return read_tun_header(tt, buf, len);</span><br><span>     =
}</span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n read(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return read(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span=
> #elif defined(TARGET_AIX)</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/823?usp=3Demail">chang=
e 823</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/823?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41eeae35ab23d9fb2512f33086f=
20f54c2d4f6df </div>
<div style=3D"display:none"> Gerrit-Change-Number: 823 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8fCbzQ0Qhdk=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 22 Nov 2023 13:09:34 +0000
References: <gerrit.1700658573000.I66e3dd7b7166459526824fe5ae81a449b375b8db@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d7f8728b18f2d0f617b7b703e4b419545aba36e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wBPUxxrFrc8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Minimal
 Solaris/OpenIndiana support to Cmake and clean up -Werror
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wBPUxxrFrc8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/458?usp=3Demail

to review the following change.


Change subject: Minimal Solaris/OpenIndiana support to Cmake and clean up -=
Werror
......................................................................

Minimal Solaris/OpenIndiana support to Cmake and clean up -Werror

Change-Id: I66e3dd7b7166459526824fe5ae81a449b375b8db
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M config.h.cmake.in
M src/openvpn/route.c
M src/openvpn/tun.c
4 files changed, 18 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/458/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..c3a55ab 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -121,11 +121,17 @@
     set(TARGET_FREEBSD YES)
     set(ENABLE_DCO YES)
     link_libraries(-lnv)
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "SunOS")
+    set(TARGET_SOLARIS YES)
+    set(HAVE_SYS_SOCKIO_H 1)
+    link_libraries(-lnsl -lsocket -lresolv)
 elseif (WIN32)
     set(ENABLE_DCO YES)
 elseif (APPLE)
     set(TARGET_DARWIN YES)
     set(HAVE_NET_IF_UTUN_H YES)
+else()
+    message(FATAL_ERROR "Unknown system name: \"${CMAKE_SYSTEM_NAME}\"")
 endif ()

 if (UNIX)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..5b93fc5 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -336,7 +336,7 @@
 #cmakedefine HAVE_SYS_SOCKET_H

 /* Define to 1 if you have the <sys/sockio.h> header file. */
-#undef HAVE_SYS_SOCKIO_H
+#cmakedefine HAVE_SYS_SOCKIO_H

 /* Define to 1 if you have the <sys/stat.h> header file. */
 #define HAVE_SYS_STAT_H 1
@@ -443,6 +443,9 @@
 /* Are we running on Linux? */
 #cmakedefine TARGET_LINUX

+/* Are we running on Solaris/OpenIndiana? */
+#cmakedefine TARGET_SOLARIS
+
 /* Are we running WIN32? */
 #cmakedefine TARGET_WIN32

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ff64938..6cc112c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2342,12 +2342,11 @@
         return;
     }

-#ifndef _WIN32
+#if !defined(_WIN32)
 #if !defined(TARGET_LINUX)
     const char *gateway;
-#else
-    int metric;
 #endif
+#if !defined(TARGET_SOLARIS)
     bool gateway_needed =3D false;
     const char *device =3D tt->actual_name;
     if (r6->iface !=3D NULL)              /* vpn server special route */
@@ -2365,6 +2364,7 @@
         gateway_needed =3D true;
     }
 #endif
+#endif

     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();
@@ -2395,7 +2395,7 @@
     msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );

 #if defined(TARGET_LINUX)
-    metric =3D -1;
+    int metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         metric =3D r6->metric;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 82ab6c0..f1b8699 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1900,7 +1900,7 @@
 #endif


-#if !(defined(_WIN32) || defined(TARGET_LINUX))
+#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_no=
de,
                  struct tuntap *tt)
@@ -2061,7 +2061,7 @@
 }
 #endif /* TARGET_LINUX || TARGET_FREEBSD*/

-#if !defined(_WIN32)
+#if !(defined(_WIN32) || defined(TARGET_SOLARIS))
 static void
 close_tun_generic(struct tuntap *tt)
 {
@@ -2398,13 +2398,12 @@
 open_tun(const char *dev, const char *dev_type, const char *dev_node, stru=
ct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    int if_fd, ip_muxid, arp_muxid, arp_fd, ppa =3D -1;
+    int if_fd =3D -1, ip_muxid =3D -1, arp_muxid =3D -1, arp_fd =3D -1, pp=
a =3D -1;
     struct lifreq ifr;
     const char *ptr;
-    const char *ip_node, *arp_node;
+    const char *ip_node =3D NULL, *arp_node =3D NULL;
     const char *dev_tuntap_type;
     int link_type;
-    bool is_tun;
     struct strioctl strioc_if, strioc_ppa;
=20
     /* improved generic TUN/TAP driver from
@@ -2428,7 +2427,6 @@
         }
         dev_tuntap_type =3D "tun";
         link_type =3D I_PLINK;
-        is_tun =3D true;
     }
     else if (tt->type =3D=3D DEV_TYPE_TAP)
     {
@@ -2440,7 +2438,6 @@
         arp_node =3D dev_node;
         dev_tuntap_type =3D "tap";
         link_type =3D I_PLINK; /* was: I_LINK */
-        is_tun =3D false;
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/458?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I66e3dd7b7166459526824fe5ae81a449b375b8db
Gerrit-Change-Number: 458
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--wBPUxxrFrc8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/458?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Minimal Solaris/OpenIndiana support to Cmake and clean up -We=
rror<br><br>Change-Id: I66e3dd7b7166459526824fe5ae81a449b375b8db<br>Signed-=
off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>=
M config.h.cmake.in<br>M src/openvpn/route.c<br>M src/openvpn/tun.c<br>4 fi=
les changed, 18 insertions(+), 12 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/58/458/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CM=
akeLists.txt b/CMakeLists.txt</span><br><span>index d21c9bd..c3a55ab 100644=
</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt<=
/span><br><span>@@ -121,11 +121,17 @@</span><br><span>     set(TARGET_FREEB=
SD YES)</span><br><span>     set(ENABLE_DCO YES)</span><br><span>     link_=
libraries(-lnv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else=
if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;SunOS&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set(TARGET_SOLARIS YES)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    set(HAVE_SYS_SOCKIO_H 1)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    link_libraries(-lnsl=
 -lsocket -lresolv)</span><br><span> elseif (WIN32)</span><br><span>     se=
t(ENABLE_DCO YES)</span><br><span> elseif (APPLE)</span><br><span>     set(=
TARGET_DARWIN YES)</span><br><span>     set(HAVE_NET_IF_UTUN_H YES)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+else()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    message(FATAL_ERROR &quot;Unknown sy=
stem name: \&quot;${CMAKE_SYSTEM_NAME}\&quot;&quot;)</span><br><span> endif=
 ()</span><br><span> </span><br><span> if (UNIX)</span><br><span>diff --git=
 a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index 19b79bc..5b9=
3fc5 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/c=
onfig.h.cmake.in</span><br><span>@@ -336,7 +336,7 @@</span><br><span> #cmak=
edefine HAVE_SYS_SOCKET_H</span><br><span> </span><br><span> /* Define to 1=
 if you have the &lt;sys/sockio.h&gt; header file. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYS_SOCKIO_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_SOCKIO_H</span><=
br><span> </span><br><span> /* Define to 1 if you have the &lt;sys/stat.h&g=
t; header file. */</span><br><span> #define HAVE_SYS_STAT_H 1</span><br><sp=
an>@@ -443,6 +443,9 @@</span><br><span> /* Are we running on Linux? */</spa=
n><br><span> #cmakedefine TARGET_LINUX</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Are we running on Solaris/OpenIndia=
na? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine =
TARGET_SOLARIS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /* Are we running WIN32? */</span><br><span> #cmakedefine TARG=
ET_WIN32</span><br><span> </span><br><span>diff --git a/src/openvpn/route.c=
 b/src/openvpn/route.c</span><br><span>index ff64938..6cc112c 100644</span>=
<br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route=
.c</span><br><span>@@ -2342,12 +2342,11 @@</span><br><span>         return;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifndef _WIN32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if !defined(_WIN32)</span><br><span> #if !defined(TARGET_LI=
NUX)</span><br><span>     const char *gateway;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int metric;</span><br><span> #endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if !defined(TARGET_SOLARIS)</span><br><span> =
    bool gateway_needed =3D false;</span><br><span>     const char *device =
=3D tt-&gt;actual_name;</span><br><span>     if (r6-&gt;iface !=3D NULL)   =
           /* vpn server special route */</span><br><span>@@ -2365,6 +2364,=
7 @@</span><br><span>         gateway_needed =3D true;</span><br><span>    =
 }</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> </span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span>@@ -2395,7 +2395,7 @@</span><br><span>     msg( M_INFO, &quot;delete_=
route_ipv6(%s/%d)&quot;, network, r6-&gt;netbits );</span><br><span> </span=
><br><span> #if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    metric =3D -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int metric =3D -1;</span><br><span>     if ((r6-&gt;flag=
s &amp; RT_METRIC_DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br><sp=
an>     {</span><br><span>         metric =3D r6-&gt;metric;</span><br><spa=
n>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index =
82ab6c0..f1b8699 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><=
span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1900,7 +1900,7 @@</span><b=
r><span> #endif</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if !(defined(_WIN32) || defined(TARGET_LIN=
UX))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !(defined(_=
WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))</span><br><span=
> static void</span><br><span> open_tun_generic(const char *dev, const char=
 *dev_type, const char *dev_node,</span><br><span>                  struct =
tuntap *tt)</span><br><span>@@ -2061,7 +2061,7 @@</span><br><span> }</span>=
<br><span> #endif /* TARGET_LINUX || TARGET_FREEBSD*/</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(_WIN32)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !(defined(_WIN32) ||=
 defined(TARGET_SOLARIS))</span><br><span> static void</span><br><span> clo=
se_tun_generic(struct tuntap *tt)</span><br><span> {</span><br><span>@@ -23=
98,13 +2398,12 @@</span><br><span> open_tun(const char *dev, const char *de=
v_type, const char *dev_node, struct tuntap *tt,</span><br><span>          =
openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int if_fd, ip_muxid, arp_muxid, arp_fd, ppa =3D -1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int if_fd =3D =
-1, ip_muxid =3D -1, arp_muxid =3D -1, arp_fd =3D -1, ppa =3D -1;</span><br=
><span>     struct lifreq ifr;</span><br><span>     const char *ptr;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *ip_node, *ar=
p_node;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *ip_node =3D NULL, *arp_node =3D NULL;</span><br><span>     const char *=
dev_tuntap_type;</span><br><span>     int link_type;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool is_tun;</span><br><span>     struc=
t strioctl strioc_if, strioc_ppa;</span><br><span> </span><br><span>     /*=
 improved generic TUN/TAP driver from</span><br><span>@@ -2428,7 +2427,6 @@=
</span><br><span>         }</span><br><span>         dev_tuntap_type =3D &q=
uot;tun&quot;;</span><br><span>         link_type =3D I_PLINK;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        is_tun =3D true;</span><br=
><span>     }</span><br><span>     else if (tt-&gt;type =3D=3D DEV_TYPE_TAP=
)</span><br><span>     {</span><br><span>@@ -2440,7 +2438,6 @@</span><br><s=
pan>         arp_node =3D dev_node;</span><br><span>         dev_tuntap_typ=
e =3D &quot;tap&quot;;</span><br><span>         link_type =3D I_PLINK; /* w=
as: I_LINK */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
is_tun =3D false;</span><br><span>     }</span><br><span>     else</span><b=
r><span>     {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/458?usp=3Demail">change 458</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/458?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I66e3dd7b7166459526824fe5ae8=
1a449b375b8db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 458 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--wBPUxxrFrc8=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 15:25:07 +0000
References: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <eafe408ad49c84f86ff6a0c02d53b5f6ab662e74-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EXSA7728tv0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix warnings on
 Android about unused variables/methods
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

--EXSA7728tv0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail

to review the following change.


Change subject: Fix warnings on Android about unused variables/methods
......................................................................

Fix warnings on Android about unused variables/methods

The changes to route.c are a bit messy but they mostly modify already
existing ifdefs

Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/route.c
M src/openvpn/tun.c
2 files changed, 13 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/894/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d895e1c..1601275 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -104,6 +104,7 @@
 #define RTA_SUCCESS 1   /* route addition succeeded */
 #define RTA_EEXIST  2   /* route not added as it already exists */

+#ifndef TARGET_ANDROID
 static bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)
 {
@@ -125,6 +126,7 @@
         return false;
     }
 }
+#endif /* ifndef TARGET_ANDROID */

 struct route_option_list *
 new_route_option_list(struct gc_arena *a)
@@ -750,6 +752,7 @@
  * (not the most beautiful implementation in the world, but portable and
  * "good enough")
  */
+#ifndef TARGET_ANDROID
 static bool
 route_ipv6_match_host( const struct route_ipv6 *r6,
                        const struct in6_addr *host )
@@ -785,6 +788,7 @@

     return false;
 }
+#endif /* ifndef TARGET_ANDROID */

 bool
 init_route_ipv6_list(struct route_ipv6_list *rl6,
@@ -2183,7 +2187,7 @@
              const struct env_set *es,
              openvpn_net_ctx_t *ctx)
 {
-#if !defined(TARGET_LINUX)
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *network;
 #if !defined(TARGET_AIX)
     const char *netmask;
@@ -2191,9 +2195,11 @@
 #if !defined(TARGET_ANDROID)
     const char *gateway;
 #endif
-#else  /* if !defined(TARGET_LINUX) */
+#else  /* if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID) */
+#if !defined(TARGET_ANDROID)
     int metric;
 #endif
+#endif
     int is_local_route;

     if ((r->flags & (RT_DEFINED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))
@@ -2204,7 +2210,7 @@
     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();

-#if !defined(TARGET_LINUX)
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     network =3D print_in_addr_t(r->network, 0, &gc);
 #if !defined(TARGET_AIX)
     netmask =3D print_in_addr_t(r->netmask, 0, &gc);
@@ -2394,10 +2400,10 @@
     }

 #if !defined(_WIN32)
-#if !defined(TARGET_LINUX)
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *gateway;
 #endif
-#if !defined(TARGET_SOLARIS)
+#if !defined(TARGET_SOLARIS) && !defined(TARGET_ANDROID)
     bool gateway_needed =3D false;
     const char *device =3D tt->actual_name;
     if (r6->iface !=3D NULL)              /* vpn server special route */
@@ -2421,7 +2427,7 @@
     struct argv argv =3D argv_new();

     network =3D print_in6_addr( r6->network, 0, &gc);
-#if !defined(TARGET_LINUX) && !defined(_WIN32)
+#if !defined(TARGET_LINUX) && !defined(_WIN32) && !defined(TARGET_ANDROID)
     gateway =3D print_in6_addr( r6->gateway, 0, &gc);
 #endif

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 80f5dff..d2c5191 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1888,7 +1888,7 @@
 #endif


-#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))
+#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS) =
|| defined(TARGET_ANDROID))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_no=
de,
                  struct tuntap *tt)
@@ -2062,7 +2062,6 @@
          openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
-    struct user_pass up;
     struct gc_arena gc =3D gc_new();
     bool opentun;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Gerrit-Change-Number: 894
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--EXSA7728tv0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix warnings on Android about unused variables/methods<br><br=
>The changes to route.c are a bit messy but they mostly modify already<br>e=
xisting ifdefs<br><br>Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07<=
br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/open=
vpn/route.c<br>M src/openvpn/tun.c<br>2 files changed, 13 insertions(+), 8 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/94/894/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c b/src/openvpn/ro=
ute.c</span><br><span>index d895e1c..1601275 100644</span><br><span>--- a/s=
rc/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><spa=
n>@@ -104,6 +104,7 @@</span><br><span> #define RTA_SUCCESS 1   /* route add=
ition succeeded */</span><br><span> #define RTA_EEXIST  2   /* route not ad=
ded as it already exists */</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifndef TARGET_ANDROID</span><br><span> static bo=
ol</span><br><span> add_bypass_address(struct route_bypass *rb, const in_ad=
dr_t a)</span><br><span> {</span><br><span>@@ -125,6 +126,7 @@</span><br><s=
pan>         return false;</span><br><span>     }</span><br><span> }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef TARGET_AN=
DROID */</span><br><span> </span><br><span> struct route_option_list *</spa=
n><br><span> new_route_option_list(struct gc_arena *a)</span><br><span>@@ -=
750,6 +752,7 @@</span><br><span>  * (not the most beautiful implementation =
in the world, but portable and</span><br><span>  * &quot;good enough&quot;)=
</span><br><span>  */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifndef TARGET_ANDROID</span><br><span> static bool</span><br><span> rout=
e_ipv6_match_host( const struct route_ipv6 *r6,</span><br><span>           =
             const struct in6_addr *host )</span><br><span>@@ -785,6 +788,7=
 @@</span><br><span> </span><br><span>     return false;</span><br><span> }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef TA=
RGET_ANDROID */</span><br><span> </span><br><span> bool</span><br><span> in=
it_route_ipv6_list(struct route_ipv6_list *rl6,</span><br><span>@@ -2183,7 =
+2187,7 @@</span><br><span>              const struct env_set *es,</span><b=
r><span>              openvpn_net_ctx_t *ctx)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX=
) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span>     const char *netw=
ork;</span><br><span> #if !defined(TARGET_AIX)</span><br><span>     const c=
har *netmask;</span><br><span>@@ -2191,9 +2195,11 @@</span><br><span> #if !=
defined(TARGET_ANDROID)</span><br><span>     const char *gateway;</span><br=
><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  =
/* if !defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#else  /* if !defined(TARGET_LINUX) &amp;&amp; !defined(TARGET_=
ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !def=
ined(TARGET_ANDROID)</span><br><span>     int metric;</span><br><span> #end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span>     int is_local_route;</span><br><span> </span><br><span>     if ((=
r-&gt;flags &amp; (RT_DEFINED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))</span>=
<br><span>@@ -2204,7 +2210,7 @@</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(T=
ARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !de=
fined(TARGET_LINUX) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span>   =
  network =3D print_in_addr_t(r-&gt;network, 0, &amp;gc);</span><br><span> =
#if !defined(TARGET_AIX)</span><br><span>     netmask =3D print_in_addr_t(r=
-&gt;netmask, 0, &amp;gc);</span><br><span>@@ -2394,10 +2400,10 @@</span><b=
r><span>     }</span><br><span> </span><br><span> #if !defined(_WIN32)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET=
_LINUX) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span>     const char=
 *gateway;</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if !defined(TARGET_SOLARIS)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if !defined(TARGET_SOLARIS) &amp;&amp; !defined(TARG=
ET_ANDROID)</span><br><span>     bool gateway_needed =3D false;</span><br><=
span>     const char *device =3D tt-&gt;actual_name;</span><br><span>     i=
f (r6-&gt;iface !=3D NULL)              /* vpn server special route */</spa=
n><br><span>@@ -2421,7 +2427,7 @@</span><br><span>     struct argv argv =3D=
 argv_new();</span><br><span> </span><br><span>     network =3D print_in6_a=
ddr( r6-&gt;network, 0, &amp;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if !defined(TARGET_LINUX) &amp;&amp; !defined(_WIN32)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX) &=
amp;&amp; !defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><br><s=
pan>     gateway =3D print_in6_addr( r6-&gt;gateway, 0, &amp;gc);</span><br=
><span> #endif</span><br><span> </span><br><span>diff --git a/src/openvpn/t=
un.c b/src/openvpn/tun.c</span><br><span>index 80f5dff..d2c5191 100644</spa=
n><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c=
</span><br><span>@@ -1888,7 +1888,7 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !(defined(_WIN=
32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS) || defined(TARGET_A=
NDROID))</span><br><span> static void</span><br><span> open_tun_generic(con=
st char *dev, const char *dev_type, const char *dev_node,</span><br><span> =
                 struct tuntap *tt)</span><br><span>@@ -2062,7 +2062,6 @@</=
span><br><span>          openvpn_net_ctx_t *ctx)</span><br><span> {</span><=
br><span> #define ANDROID_TUNNAME &quot;vpnservice-tun&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct user_pass up;</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     bool opentu=
n;</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail">change 894</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/894?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33d1d04b59c62e87ab61d768a72=
01124ccdabd07 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 894 </div>
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


--EXSA7728tv0=--


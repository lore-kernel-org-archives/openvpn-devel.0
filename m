From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 15:32:47 +0000
In-Reply-To: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
References: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <dee09b02eb4f634a1ced113d457f57fe9d6fac86-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T9a61sMeG+4="; charset=UTF-8
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

--T9a61sMeG+4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail

to look at the new patch set (#4).


Change subject: Fix warnings on Android about unused variables/methods
......................................................................

Fix warnings on Android about unused variables/methods

The changes to route.c are a bit messy but they mostly modify already
existing ifdefs

Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
M src/openvpn/route.c
M src/openvpn/tun.c
3 files changed, 14 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/894/4

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b1af7ec..ce0fb74 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -61,7 +61,7 @@
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
-        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAK=
E_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ mat=
rix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE=
_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno
+        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAK=
E_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ mat=
rix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE=
_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse
       - name: Build OpenVPN Android binary with cmake
         run: cmake --build openvpn-build

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--T9a61sMeG+4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Fix warnings on Android about unused variables/methods<br><br>The cha=
nges to route.c are a bit messy but they mostly modify already<br>existing =
ifdefs<br><br>Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07<br>Signe=
d-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M .github/workflow=
s/build.yaml<br>M src/openvpn/route.c<br>M src/openvpn/tun.c<br>3 files cha=
nged, 14 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/94/894/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/wo=
rkflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index b1a=
f7ec..ce0fb74 100644</span><br><span>--- a/.github/workflows/build.yaml</sp=
an><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -61,7 +6=
1,7 @@</span><br><span>       - name: Install dependencies</span><br><span>=
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><spa=
n>       - name: configure OpenVPN with cmake</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        run: cmake -S . -B openvpn-build -DUNSUPPOR=
TED_BUILDS=3Dyes -DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG=
_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD=
_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=
=3Dfalse -DUSE_WERROR=3Dno</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes =
-DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/$=
{{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -=
DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse</span><br>=
<span>       - name: Build OpenVPN Android binary with cmake</span><br><spa=
n>         run: cmake --build openvpn-build</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex d895e1c..1601275 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -104,6 +104,7 @@</=
span><br><span> #define RTA_SUCCESS 1   /* route addition succeeded */</spa=
n><br><span> #define RTA_EEXIST  2   /* route not added as it already exist=
s */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef TARGET_ANDROID</span><br><span> static bool</span><br><span> add=
_bypass_address(struct route_bypass *rb, const in_addr_t a)</span><br><span=
> {</span><br><span>@@ -125,6 +126,7 @@</span><br><span>         return fal=
se;</span><br><span>     }</span><br><span> }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* ifndef TARGET_ANDROID */</span><br><spa=
n> </span><br><span> struct route_option_list *</span><br><span> new_route_=
option_list(struct gc_arena *a)</span><br><span>@@ -750,6 +752,7 @@</span><=
br><span>  * (not the most beautiful implementation in the world, but porta=
ble and</span><br><span>  * &quot;good enough&quot;)</span><br><span>  */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TARGET_ANDROI=
D</span><br><span> static bool</span><br><span> route_ipv6_match_host( cons=
t struct route_ipv6 *r6,</span><br><span>                        const stru=
ct in6_addr *host )</span><br><span>@@ -785,6 +788,7 @@</span><br><span> </=
span><br><span>     return false;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef TARGET_ANDROID */</span>=
<br><span> </span><br><span> bool</span><br><span> init_route_ipv6_list(str=
uct route_ipv6_list *rl6,</span><br><span>@@ -2183,7 +2187,7 @@</span><br><=
span>              const struct env_set *es,</span><br><span>              =
openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX) &amp;&amp; !defined(=
TARGET_ANDROID)</span><br><span>     const char *network;</span><br><span> =
#if !defined(TARGET_AIX)</span><br><span>     const char *netmask;</span><b=
r><span>@@ -2191,9 +2195,11 @@</span><br><span> #if !defined(TARGET_ANDROID=
)</span><br><span>     const char *gateway;</span><br><span> #endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if !defined(TARGET_=
LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* =
if !defined(TARGET_LINUX) &amp;&amp; !defined(TARGET_ANDROID) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_ANDROID)</=
span><br><span>     int metric;</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     int is_loca=
l_route;</span><br><span> </span><br><span>     if ((r-&gt;flags &amp; (RT_=
DEFINED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))</span><br><span>@@ -2204,7 +=
2210,7 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>     struct argv argv =3D argv_new();</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX) &a=
mp;&amp; !defined(TARGET_ANDROID)</span><br><span>     network =3D print_in=
_addr_t(r-&gt;network, 0, &amp;gc);</span><br><span> #if !defined(TARGET_AI=
X)</span><br><span>     netmask =3D print_in_addr_t(r-&gt;netmask, 0, &amp;=
gc);</span><br><span>@@ -2394,10 +2400,10 @@</span><br><span>     }</span><=
br><span> </span><br><span> #if !defined(_WIN32)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX) &amp;&amp; !de=
fined(TARGET_ANDROID)</span><br><span>     const char *gateway;</span><br><=
span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defi=
ned(TARGET_SOLARIS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if !defined(TARGET_SOLARIS) &amp;&amp; !defined(TARGET_ANDROID)</span><br>=
<span>     bool gateway_needed =3D false;</span><br><span>     const char *=
device =3D tt-&gt;actual_name;</span><br><span>     if (r6-&gt;iface !=3D N=
ULL)              /* vpn server special route */</span><br><span>@@ -2421,7=
 +2427,7 @@</span><br><span>     struct argv argv =3D argv_new();</span><br=
><span> </span><br><span>     network =3D print_in6_addr( r6-&gt;network, 0=
, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defin=
ed(TARGET_LINUX) &amp;&amp; !defined(_WIN32)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX) &amp;&amp; !defined(_WI=
N32) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span>     gateway =3D p=
rint_in6_addr( r6-&gt;gateway, 0, &amp;gc);</span><br><span> #endif</span><=
br><span> </span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun=
.c</span><br><span>index 80f5dff..d2c5191 100644</span><br><span>--- a/src/=
openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1=
888,7 +1888,7 @@</span><br><span> #endif</span><br><span> </span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !(defined(_WIN32=
) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if !(defined(_WIN32) || defined(TARGET_=
LINUX) || defined(TARGET_SOLARIS) || defined(TARGET_ANDROID))</span><br><sp=
an> static void</span><br><span> open_tun_generic(const char *dev, const ch=
ar *dev_type, const char *dev_node,</span><br><span>                  struc=
t tuntap *tt)</span><br><span>@@ -2062,7 +2062,6 @@</span><br><span>       =
   openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #define ANDR=
OID_TUNNAME &quot;vpnservice-tun&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct user_pass up;</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>     bool opentun;</span><br><span> </=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/894?usp=3Demail">change 894</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/894?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33d1d04b59c62e87ab61d768a72=
01124ccdabd07 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 894 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--T9a61sMeG+4=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 18 Dec 2025 17:44:56 +0000
In-Reply-To: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
References: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <cfabb8bbeb88e9954fa688295acacc15bc425bf7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xhJDTYk2YRo="; charset=UTF-8
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

--xhJDTYk2YRo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Fix warnings on Android about unused variables/methods
......................................................................

Fix warnings on Android about unused variables/methods

Add the things we do not use to the print message to
avoid ifdefs around the otherwise unused variables.

Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
M src/openvpn/route.c
M src/openvpn/tun.c
3 files changed, 13 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/894/5

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ce730f6..11c2d65 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -58,7 +58,7 @@
             -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \
             -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} \
             -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_t=
riplet }} \
-            -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3D=
false -DUSE_WERROR=3Dno
+            -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3D=
false
       - name: Build OpenVPN Android binary with cmake
         run: cmake --build openvpn-build

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 770300a..222a0fa 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -102,6 +102,7 @@
 #define RTA_SUCCESS 1 /* route addition succeeded */
 #define RTA_EEXIST  2 /* route not added as it already exists */

+#ifndef TARGET_ANDROID
 static bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)
 {
@@ -123,6 +124,7 @@
         return false;
     }
 }
+#endif

 struct route_option_list *
 new_route_option_list(struct gc_arena *a)
@@ -2035,9 +2037,7 @@
 #if !defined(TARGET_AIX)
     const char *netmask;
 #endif
-#if !defined(TARGET_ANDROID)
     const char *gateway;
-#endif
 #else /* if !defined(TARGET_LINUX) */
     int metric;
 #endif
@@ -2056,10 +2056,8 @@
 #if !defined(TARGET_AIX)
     netmask =3D print_in_addr_t(r->netmask, 0, &gc);
 #endif
-#if !defined(TARGET_ANDROID)
     gateway =3D print_in_addr_t(r->gateway, 0, &gc);
 #endif
-#endif

     is_local_route =3D local_route(r->network, r->netmask, r->gateway, rgi=
);
     if (is_local_route =3D=3D LR_ERROR)
@@ -2165,9 +2163,13 @@
     openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete=
 command failed");

 #elif defined(TARGET_ANDROID)
+    /* Avoids the unused variables warnings that all other platforms use
+     * by adding them to the error message. */
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
                        "needed. The VpnService API allows routes to be set=
 "
-                       "on connect only and will clean up automatically.");
+                       "on connect only and will clean up automatically. "
+                       "Tried to delete route %s netmask %s gateway %s",
+        network, netmask, gateway);
 #elif defined(TARGET_AIX)

     {
@@ -2349,7 +2351,10 @@
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
                        "needed. The VpnService API allows routes to be set=
 "
-                       "on connect only and will clean up automatically.");
+                       "on connect only and will clean up automatically. "
+                       "Tried to delete %s gateway %s",
+        network,
+        gateway_needed ? gateway : "(not needed)");
 #elif defined(TARGET_HAIKU)

     /* ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixl=
en 64 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 409cecb..263c965 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1806,7 +1806,7 @@
 #endif


-#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))
+#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS) =
|| defined(TARGET_ANDROID))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_no=
de, struct tuntap *tt)
 {
@@ -1973,7 +1973,6 @@
          openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
-    struct user_pass up;
     struct gc_arena gc =3D gc_new();
     bool opentun;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Gerrit-Change-Number: 894
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--xhJDTYk2YRo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Fix warnings on Android abou=
t unused variables/methods<br><br>Add the things we do not use to the print=
 message to<br>avoid ifdefs around the otherwise unused variables.<br><br>C=
hange-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br=
>M src/openvpn/route.c<br>M src/openvpn/tun.c<br>3 files changed, 13 insert=
ions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/94/894/5</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/=
workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index c=
e730f6..11c2d65 100644</span><br><span>--- a/.github/workflows/build.yaml</=
span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -58,7 =
+58,7 @@</span><br><span>             -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE=
_SYSTEM_VERSION=3D28 \</span><br><span>             -DCMAKE_ANDROID_ARCH_AB=
I=3D${{ matrix.abi }} \</span><br><span>             -DOPENSSL_ROOT_DIR=3D$=
{VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            -DENABLE_PKCS11=3Dfalse -DBUILD=
_TESTING=3Dtrue -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            -DENABLE_PKCS11=3Dfalse -DBU=
ILD_TESTING=3Dtrue -DENABLE_LZO=3Dfalse</span><br><span>       - name: Buil=
d OpenVPN Android binary with cmake</span><br><span>         run: cmake --b=
uild openvpn-build</span><br><span> </span><br><span>diff --git a/src/openv=
pn/route.c b/src/openvpn/route.c</span><br><span>index 770300a..222a0fa 100=
644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/ope=
nvpn/route.c</span><br><span>@@ -102,6 +102,7 @@</span><br><span> #define R=
TA_SUCCESS 1 /* route addition succeeded */</span><br><span> #define RTA_EE=
XIST  2 /* route not added as it already exists */</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TARGET_ANDROID</sp=
an><br><span> static bool</span><br><span> add_bypass_address(struct route_=
bypass *rb, const in_addr_t a)</span><br><span> {</span><br><span>@@ -123,6=
 +124,7 @@</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span> </span><br><span> struct route_option_list *</span><br=
><span> new_route_option_list(struct gc_arena *a)</span><br><span>@@ -2035,=
9 +2037,7 @@</span><br><span> #if !defined(TARGET_AIX)</span><br><span>    =
 const char *netmask;</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if !defined(TARGET_ANDROID)</span><br><span>     c=
onst char *gateway;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span> #else /* if !defined(TARGET_LINUX) */</span><br><span=
>     int metric;</span><br><span> #endif</span><br><span>@@ -2056,10 +2056=
,8 @@</span><br><span> #if !defined(TARGET_AIX)</span><br><span>     netmas=
k =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span> #endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_AND=
ROID)</span><br><span>     gateway =3D print_in_addr_t(r-&gt;gateway, 0, &a=
mp;gc);</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span> </span><br><span>     is_local_route =3D =
local_route(r-&gt;network, r-&gt;netmask, r-&gt;gateway, rgi);</span><br><s=
pan>     if (is_local_route =3D=3D LR_ERROR)</span><br><span>@@ -2165,9 +21=
63,13 @@</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;=
ERROR: OpenBSD/NetBSD route delete command failed&quot;);</span><br><span> =
</span><br><span> #elif defined(TARGET_ANDROID)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Avoids the unused variables warnings tha=
t all other platforms use</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * by adding them to the error message. */</span><br><span>     m=
sg(D_ROUTE_DEBUG, &quot;Deleting routes on Android is not possible/not &quo=
t;</span><br><span>                        &quot;needed. The VpnService API=
 allows routes to be set &quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                       &quot;on connect only and will clean up au=
tomatically.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       &quot;on connect only and will clean up automatical=
ly. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              &quot;Tried to delete route %s netmask %s gateway %s&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        network, netm=
ask, gateway);</span><br><span> #elif defined(TARGET_AIX)</span><br><span> =
</span><br><span>     {</span><br><span>@@ -2349,7 +2351,10 @@</span><br><s=
pan> #elif defined(TARGET_ANDROID)</span><br><span>     msg(D_ROUTE_DEBUG, =
&quot;Deleting routes on Android is not possible/not &quot;</span><br><span=
>                        &quot;needed. The VpnService API allows routes to =
be set &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
               &quot;on connect only and will clean up automatically.&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      &quot;on connect only and will clean up automatically. &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                       &quo=
t;Tried to delete %s gateway %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        network,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        gateway_needed ? gateway : &quot;(not needed)&quot;=
);</span><br><span> #elif defined(TARGET_HAIKU)</span><br><span> </span><br=
><span>     /* ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef::cafe =
prefixlen 64 */</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvp=
n/tun.c</span><br><span>index 409cecb..263c965 100644</span><br><span>--- a=
/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>=
@@ -1806,7 +1806,7 @@</span><br><span> #endif</span><br><span> </span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !(defined(_=
WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if !(defined(_WIN32) || defined(TA=
RGET_LINUX) || defined(TARGET_SOLARIS) || defined(TARGET_ANDROID))</span><b=
r><span> static void</span><br><span> open_tun_generic(const char *dev, con=
st char *dev_type, const char *dev_node, struct tuntap *tt)</span><br><span=
> {</span><br><span>@@ -1973,7 +1973,6 @@</span><br><span>          openvpn=
_net_ctx_t *ctx)</span><br><span> {</span><br><span> #define ANDROID_TUNNAM=
E &quot;vpnservice-tun&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct user_pass up;</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     bool opentun;</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/894?usp=3Demail">change 894</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/894?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33d1d04b59c62e87ab61d768a72=
01124ccdabd07 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 894 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--xhJDTYk2YRo=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Dec 2025 16:09:31 +0000
In-Reply-To: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
References: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6e0919efb81a2a4e45749c03d09a10c96e3779a4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3UH1lv72+3o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3UH1lv72+3o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Fix warnings on Android about unused variables/methods
......................................................................

Fix warnings on Android about unused variables/methods

Add the things we do not use to the print message to
avoid ifdefs around the otherwise unused variables.

Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/894
Message-Id: <20251219134706.164040-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
156.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M src/openvpn/route.c
M src/openvpn/tun.c
3 files changed, 13 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/894/6

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
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3UH1lv72+3o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail">Vie=
w Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Fix warnings on Android abou=
t unused variables/methods<br><br>Add the things we do not use to the print=
 message to<br>avoid ifdefs around the otherwise unused variables.<br><br>C=
hange-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/894<br>M=
essage-Id: &lt;20251219134706.164040-1-frank@...2641...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35156.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/wor=
kflows/build.yaml<br>M src/openvpn/route.c<br>M src/openvpn/tun.c<br>3 file=
s changed, 13 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/894/6</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</sp=
an><br><span>index ce730f6..11c2d65 100644</span><br><span>--- a/.github/wo=
rkflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span=
><br><span>@@ -58,7 +58,7 @@</span><br><span>             -DCMAKE_SYSTEM_NA=
ME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \</span><br><span>             -DC=
MAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} \</span><br><span>             -D=
OPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            -DENABLE_PKCS=
11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            -DENABLE_P=
KCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3Dfalse</span><br><span> =
      - name: Build OpenVPN Android binary with cmake</span><br><span>     =
    run: cmake --build openvpn-build</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 77=
0300a..222a0fa 100644</span><br><span>--- a/src/openvpn/route.c</span><br><=
span>+++ b/src/openvpn/route.c</span><br><span>@@ -102,6 +102,7 @@</span><b=
r><span> #define RTA_SUCCESS 1 /* route addition succeeded */</span><br><sp=
an> #define RTA_EEXIST  2 /* route not added as it already exists */</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
TARGET_ANDROID</span><br><span> static bool</span><br><span> add_bypass_add=
ress(struct route_bypass *rb, const in_addr_t a)</span><br><span> {</span><=
br><span>@@ -123,6 +124,7 @@</span><br><span>         return false;</span><=
br><span>     }</span><br><span> }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span> </span><br><span> struct route_optio=
n_list *</span><br><span> new_route_option_list(struct gc_arena *a)</span><=
br><span>@@ -2035,9 +2037,7 @@</span><br><span> #if !defined(TARGET_AIX)</s=
pan><br><span>     const char *netmask;</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_ANDROID)</spa=
n><br><span>     const char *gateway;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span> #else /* if !defined(TARGET_LINUX) =
*/</span><br><span>     int metric;</span><br><span> #endif</span><br><span=
>@@ -2056,10 +2056,8 @@</span><br><span> #if !defined(TARGET_AIX)</span><br=
><span>     netmask =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><=
br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !=
defined(TARGET_ANDROID)</span><br><span>     gateway =3D print_in_addr_t(r-=
&gt;gateway, 0, &amp;gc);</span><br><span> #endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span>     i=
s_local_route =3D local_route(r-&gt;network, r-&gt;netmask, r-&gt;gateway, =
rgi);</span><br><span>     if (is_local_route =3D=3D LR_ERROR)</span><br><s=
pan>@@ -2165,9 +2163,13 @@</span><br><span>     openvpn_execve_check(&amp;a=
rgv, es, 0, &quot;ERROR: OpenBSD/NetBSD route delete command failed&quot;);=
</span><br><span> </span><br><span> #elif defined(TARGET_ANDROID)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Avoids the unused vari=
ables warnings that all other platforms use</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * by adding them to the error message. */</spa=
n><br><span>     msg(D_ROUTE_DEBUG, &quot;Deleting routes on Android is not=
 possible/not &quot;</span><br><span>                        &quot;needed. =
The VpnService API allows routes to be set &quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                       &quot;on connect only an=
d will clean up automatically.&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                       &quot;on connect only and will cl=
ean up automatically. &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                       &quot;Tried to delete route %s netmask %s g=
ateway %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     network, netmask, gateway);</span><br><span> #elif defined(TARGET_AIX)=
</span><br><span> </span><br><span>     {</span><br><span>@@ -2349,7 +2351,=
10 @@</span><br><span> #elif defined(TARGET_ANDROID)</span><br><span>     m=
sg(D_ROUTE_DEBUG, &quot;Deleting routes on Android is not possible/not &quo=
t;</span><br><span>                        &quot;needed. The VpnService API=
 allows routes to be set &quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                       &quot;on connect only and will clean up au=
tomatically.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       &quot;on connect only and will clean up automatical=
ly. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              &quot;Tried to delete %s gateway %s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        network,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gateway_needed ? gateway : &quot;=
(not needed)&quot;);</span><br><span> #elif defined(TARGET_HAIKU)</span><br=
><span> </span><br><span>     /* ex: route delete /dev/net/ipro1000/0 inet6=
 :: gw beef::cafe prefixlen 64 */</span><br><span>diff --git a/src/openvpn/=
tun.c b/src/openvpn/tun.c</span><br><span>index 409cecb..263c965 100644</sp=
an><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.=
c</span><br><span>@@ -1806,7 +1806,7 @@</span><br><span> #endif</span><br><=
span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !(defined(_WI=
N32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS) || defined(TARGET_=
ANDROID))</span><br><span> static void</span><br><span> open_tun_generic(co=
nst char *dev, const char *dev_type, const char *dev_node, struct tuntap *t=
t)</span><br><span> {</span><br><span>@@ -1973,7 +1973,6 @@</span><br><span=
>          openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #def=
ine ANDROID_TUNNAME &quot;vpnservice-tun&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct user_pass up;</span><br><span>     stru=
ct gc_arena gc =3D gc_new();</span><br><span>     bool opentun;</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/894?usp=3Demail">change 894</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/894?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33d1d04b59c62e87ab61d768a72=
01124ccdabd07 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 894 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--3UH1lv72+3o=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 14:35:24 +0000
In-Reply-To: <gerrit.1758282060000.I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1@...2715...>
References: <gerrit.1758282060000.I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <32c0b3a71b5781eea99888b398e36994e55ad379-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+9P+8ypMPKw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Enable a subset of
 -Wextra
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

--+9P+8ypMPKw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1202?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Enable a subset of -Wextra
......................................................................

Enable a subset of -Wextra

- Includes fixes for
  - -Wimplicit-fallthrough=3D2
    (=3D3 is default but requires replacing all
     fallthrough comments)
  - -Wmissing-field-initializers
  - -Wold-style-declaration
- All other warnings that would need fixes are
  disabled for now.

Change-Id: I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1202
Message-Id: <20250923140854.21766-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59237558/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M configure.ac
M src/openvpn/misc.c
M src/openvpn/tun.c
M src/tapctl/tap.c
M tests/unit_tests/openvpn/test_pkt.c
6 files changed, 22 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1202/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index f027b01..fdc0162 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -114,7 +114,14 @@
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     # We are not ready for this
-    #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
+    #add_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-un=
used-parameter)
+    # clang doesn't have the different levels but also doesn't include it =
in -Wextra
+    check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFall=
through)
+    if (WIN32)
+        # Not sure how to deal with GetProcAddress
+        add_compile_options(-Wno-cast-function-type)
+    endif ()
     if (USE_WERROR)
         add_compile_options(-Werror)
     endif ()
diff --git a/configure.ac b/configure.ac
index 0fc21ee..c2feeea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1398,6 +1398,13 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -W=
no-unused-parameter])
+# clang doesn't have the different levels but also doesn't include it in -=
Wextra
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=3D2])
+if test "${WIN32}" =3D "yes"; then
+        # Not sure how to deal with GetProcAddress
+	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])
+fi

 if test "${enable_pedantic}" =3D "yes"; then
 	enable_strict=3D"yes"
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index e0b5da1..d3d316d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -733,7 +733,7 @@
                 {
                     return false;
                 }
-
+                /* Intentional [[fallthrough]]; */
             case 2:
                 /* after the '=3D', replace non-printable or shell meta wi=
th '_' */
                 if (!isprint(c) || isspace(c) || c =3D=3D '$' || c =3D=3D =
'(' || c =3D=3D '`')
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9618301..c213c4b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -84,10 +84,10 @@

 #ifdef _WIN32

-const static GUID GUID_DEVCLASS_NET =3D {
+static const GUID GUID_DEVCLASS_NET =3D {
     0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x0=
3, 0x18 }
 };
-const static GUID GUID_DEVINTERFACE_NET =3D {
+static const GUID GUID_DEVINTERFACE_NET =3D {
     0xcac88484, 0x7515, 0x4c03, { 0x82, 0xe6, 0x71, 0xa8, 0x7a, 0xba, 0xc3=
, 0x61 }
 };

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index b633e77..9731602 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -40,11 +40,11 @@
 #endif


-const static GUID GUID_DEVCLASS_NET =3D {
+static const GUID GUID_DEVCLASS_NET =3D {
     0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x0=
3, 0x18 }
 };

-const static WCHAR szAdapterRegKeyPathTemplate[] =3D
+static const WCHAR szAdapterRegKeyPathTemplate[] =3D
     L"SYSTEM\\CurrentControlSet\\Control\\Network\\%ls\\%ls\\Connection";
 #define ADAPTER_REGKEY_PATH_MAX                                           =
                     \
     (_countof(L"SYSTEM\\CurrentControlSet\\Control\\Network\\") - 1 + 38 +=
 _countof(L"\\") - 1 \
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index b5211cd..1423d46 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -164,7 +164,7 @@
 init_tas_auth(int key_direction)
 {
     struct tls_auth_standalone tas =3D { 0 };
-    struct frame frame =3D { { .headroom =3D 200, .payload_size =3D 1400 }=
, 0 };
+    struct frame frame =3D { .buf =3D { .headroom =3D 200, .payload_size =
=3D 1400 }, 0 };
     tas.frame =3D frame;

     tas.tls_wrap.mode =3D TLS_WRAP_AUTH;
@@ -591,7 +591,7 @@
     enum first_packet_verdict verdict;

     tas.tls_wrap.mode =3D TLS_WRAP_NONE;
-    struct frame frame =3D { { .headroom =3D 200, .payload_size =3D 1400 }=
, 0 };
+    struct frame frame =3D { .buf =3D { .headroom =3D 200, .payload_size =
=3D 1400 }, 0 };
     tas.frame =3D frame;
     tas.workbuf =3D alloc_buf(1600);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1202?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1
Gerrit-Change-Number: 1202
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+9P+8ypMPKw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1202?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Enable a subset of -Wextra<br><br>- Includes fixes f=
or<br>  - -Wimplicit-fallthrough=3D2<br>    (=3D3 is default but requires r=
eplacing all<br>     fallthrough comments)<br>  - -Wmissing-field-initializ=
ers<br>  - -Wold-style-declaration<br>- All other warnings that would need =
fixes are<br>  disabled for now.<br><br>Change-Id: I9ce664d073a4e6a6d433e9e=
6f986a5086dae8aa1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/1202<br>Message-Id: &lt;20250923140854.217=
66-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/=
message/59237558/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M CMakeLists.txt<br>M configure.ac<br>M src/openvpn/misc.c<br>M src=
/openvpn/tun.c<br>M src/tapctl/tap.c<br>M tests/unit_tests/openvpn/test_pkt=
.c<br>6 files changed, 22 insertions(+), 8 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1202/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index f027b01..fdc0=
162 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMake=
Lists.txt</span><br><span>@@ -114,7 +114,14 @@</span><br><span>     check_a=
nd_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)</span><br><span>=
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)=
</span><br><span>     # We are not ready for this</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    #add_compile_options(-Wconversion -Wno-sign=
-conversion -Wsign-compare)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    #add_compile_options(-Wconversion -Wno-sign-conversion)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    add_compile_options(-We=
xtra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    # clang doesn&#39;t have the=
 different levels but also doesn&#39;t include it in -Wextra</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    check_and_add_compiler_flag(-W=
implicit-fallthrough=3D2 GCCImplicitFallthrough)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (WIN32)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # Not sure how to deal with GetProcAddress<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_compile_=
options(-Wno-cast-function-type)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    endif ()</span><br><span>     if (USE_WERROR)</span><br><s=
pan>         add_compile_options(-Werror)</span><br><span>     endif ()</sp=
an><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index=
 0fc21ee..c2feeea 100644</span><br><span>--- a/configure.ac</span><br><span=
>+++ b/configure.ac</span><br><span>@@ -1398,6 +1398,13 @@</span><br><span>=
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</span><br><span> ACL_CH=
ECK_ADD_COMPILE_FLAGS([-Wold-style-definition])</span><br><span> ACL_CHECK_=
ADD_COMPILE_FLAGS([-Wall])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-lim=
its -Wno-unused-parameter])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# clang doesn&#39;t have the different levels but also doesn&#39;t =
include it in -Wextra</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=3D2])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+if test &quot;${WIN32}&quot; =3D &q=
uot;yes&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        # Not sure how to deal with GetProcAddress</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-func=
tion-type])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span=
><br><span> </span><br><span> if test &quot;${enable_pedantic}&quot; =3D &q=
uot;yes&quot;; then</span><br><span> 	enable_strict=3D&quot;yes&quot;</span=
><br><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><=
span>index e0b5da1..d3d316d 100644</span><br><span>--- a/src/openvpn/misc.c=
</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -733,7 +733,7 =
@@</span><br><span>                 {</span><br><span>                     =
return false;</span><br><span>                 }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* Intentional [[fallthrough]]; */</span><br><span>=
             case 2:</span><br><span>                 /* after the &#39;=3D=
&#39;, replace non-printable or shell meta with &#39;_&#39; */</span><br><s=
pan>                 if (!isprint(c) || isspace(c) || c =3D=3D &#39;$&#39; =
|| c =3D=3D &#39;(&#39; || c =3D=3D &#39;`&#39;)</span><br><span>diff --git=
 a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 9618301..c21=
3c4b 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/s=
rc/openvpn/tun.c</span><br><span>@@ -84,10 +84,10 @@</span><br><span> </spa=
n><br><span> #ifdef _WIN32</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-const static GUID GUID_DEVCLASS_NET =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static const GUID GUID_DEVCLAS=
S_NET =3D {</span><br><span>     0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1,=
 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 }</span><br><span> };</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-const static GUID GUID_DEVINTERFACE_NET=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const =
GUID GUID_DEVINTERFACE_NET =3D {</span><br><span>     0xcac88484, 0x7515, 0=
x4c03, { 0x82, 0xe6, 0x71, 0xa8, 0x7a, 0xba, 0xc3, 0x61 }</span><br><span> =
};</span><br><span> </span><br><span>diff --git a/src/tapctl/tap.c b/src/ta=
pctl/tap.c</span><br><span>index b633e77..9731602 100644</span><br><span>--=
- a/src/tapctl/tap.c</span><br><span>+++ b/src/tapctl/tap.c</span><br><span=
>@@ -40,11 +40,11 @@</span><br><span> #endif</span><br><span> </span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const static GUI=
D GUID_DEVCLASS_NET =3D {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static const GUID GUID_DEVCLASS_NET =3D {</span><br><span>     0x4d36=
e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 }</=
span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-const static WCHAR szAdapterRegKeyPathTemplate[] =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static const WCHAR szAdapte=
rRegKeyPathTemplate[] =3D</span><br><span>     L&quot;SYSTEM\\CurrentContro=
lSet\\Control\\Network\\%ls\\%ls\\Connection&quot;;</span><br><span> #defin=
e ADAPTER_REGKEY_PATH_MAX                                                  =
              \</span><br><span>     (_countof(L&quot;SYSTEM\\CurrentContro=
lSet\\Control\\Network\\&quot;) - 1 + 38 + _countof(L&quot;\\&quot;) - 1 \<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/un=
it_tests/openvpn/test_pkt.c</span><br><span>index b5211cd..1423d46 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -164,7 +164,7 @@=
</span><br><span> init_tas_auth(int key_direction)</span><br><span> {</span=
><br><span>     struct tls_auth_standalone tas =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct frame frame =3D { { .headroo=
m =3D 200, .payload_size =3D 1400 }, 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct frame frame =3D { .buf =3D { .headroom =3D=
 200, .payload_size =3D 1400 }, 0 };</span><br><span>     tas.frame =3D fra=
me;</span><br><span> </span><br><span>     tas.tls_wrap.mode =3D TLS_WRAP_A=
UTH;</span><br><span>@@ -591,7 +591,7 @@</span><br><span>     enum first_pa=
cket_verdict verdict;</span><br><span> </span><br><span>     tas.tls_wrap.m=
ode =3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct frame frame =3D { { .headroom =3D 200, .payload_size =3D 1400 }=
, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct fr=
ame frame =3D { .buf =3D { .headroom =3D 200, .payload_size =3D 1400 }, 0 }=
;</span><br><span>     tas.frame =3D frame;</span><br><span>     tas.workbu=
f =3D alloc_buf(1600);</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1202?usp=
=3Demail">change 1202</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1202?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9ce664d073a4e6a6d433e9e6f98=
6a5086dae8aa1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1202 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+9P+8ypMPKw=--


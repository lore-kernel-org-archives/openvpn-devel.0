From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 18:45:40 +0000
In-Reply-To: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
References: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <48900261ce1e9d23388f744d6c19fb647ce3d5fe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fCUGyA7PPPE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Enable -Wtype-limits
 by default (via -Wextra)
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

--fCUGyA7PPPE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Enable -Wtype-limits by default (via -Wextra)
......................................................................

Enable -Wtype-limits by default (via -Wextra)

Removes a few smaller instances:
 - Fix return type check for socket() on Windows/Unixy
 - Ignore a few instances related to WSAWaitForMultipleEvents.
   The compiler says the check is currently useless, but
   we follow the API documentation.

Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1207
Message-Id: <20251111154846.31360-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
317.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M configure.ac
M src/openvpn/event.c
M src/openvpn/socket.c
4 files changed, 16 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1207/7

diff --git a/CMakeLists.txt b/CMakeLists.txt
index c9301e6..e812145 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -114,7 +114,7 @@
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     add_compile_options(-Wconversion -Wno-sign-conversion)
-    add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-un=
used-parameter)
+    add_compile_options(-Wextra -Wno-sign-compare -Wno-unused-parameter)
     # clang doesn't have the different levels but also doesn't include it =
in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFall=
through)
     if (WIN32)
diff --git a/configure.ac b/configure.ac
index 3117e13..f6e4b6d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1410,7 +1410,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -W=
no-unused-parameter])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-unused-paramet=
er])
 # clang doesn't have the different levels but also doesn't include it in -=
Wextra
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=3D2])
 if test "${WIN32}" =3D "yes"; then
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index ca84d19..ca2d0c1 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -410,6 +410,13 @@
     }
 #endif

+    /* WSA_WAIT_EVENT_0 =3D=3D 0 but the API documentation is written in a=
 way
+       that doesn't guarantee that. So we make useless checks. */
+#if defined(__GNUC__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wtype-limits"
+#endif
+
     /*
      * First poll our event list with 0 timeout
      */
@@ -474,6 +481,9 @@
             return -1;
         }
     }
+#if defined(__GNUC__)
+#pragma GCC diagnostic pop
+#endif
 }

 static struct event_set *
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8eac96d..f7317d1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -577,7 +577,8 @@
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype =3D=3D SOCK_STREAM);

-    if ((sd =3D socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinf=
o->ai_protocol)) < 0)
+    if ((sd =3D socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinf=
o->ai_protocol))
+        =3D=3D SOCKET_UNDEFINED)
     {
         msg(M_ERR, "Cannot create TCP socket");
     }
@@ -608,7 +609,8 @@
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype =3D=3D SOCK_DGRAM);

-    if ((sd =3D socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinf=
o->ai_protocol)) < 0)
+    if ((sd =3D socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinf=
o->ai_protocol))
+        =3D=3D SOCKET_UNDEFINED)
     {
         msg(M_ERR, "UDP: Cannot create UDP/UDP6 socket");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Gerrit-Change-Number: 1207
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fCUGyA7PPPE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Enable -Wtype-limits by default=
 (via -Wextra)<br><br>Removes a few smaller instances:<br> - Fix return typ=
e check for socket() on Windows/Unixy<br> - Ignore a few instances related =
to WSAWaitForMultipleEvents.<br>   The compiler says the check is currently=
 useless, but<br>   we follow the API documentation.<br><br>Change-Id: Iaab=
ddb6f81cd94863291b193aae9d384a8f9d871<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2639...=
..&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1207<br>Messag=
e-Id: &lt;20251111154846.31360-1-gert@...1296...&gt;<br>URL: https://www.ma=
il-archive.com/openvpn-devel@lists.sourceforge.net/msg34317.html<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>=
M configure.ac<br>M src/openvpn/event.c<br>M src/openvpn/socket.c<br>4 file=
s changed, 16 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1207/7</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index c9301e6.=
.e812145 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/=
CMakeLists.txt</span><br><span>@@ -114,7 +114,7 @@</span><br><span>     che=
ck_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)</span><br><s=
pan>     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinit=
ion)</span><br><span>     add_compile_options(-Wconversion -Wno-sign-conver=
sion)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    add_compile_=
options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_compile_optio=
ns(-Wextra -Wno-sign-compare -Wno-unused-parameter)</span><br><span>     # =
clang doesn&#39;t have the different levels but also doesn&#39;t include it=
 in -Wextra</span><br><span>     check_and_add_compiler_flag(-Wimplicit-fal=
lthrough=3D2 GCCImplicitFallthrough)</span><br><span>     if (WIN32)</span>=
<br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 31=
17e13..f6e4b6d 100644</span><br><span>--- a/configure.ac</span><br><span>++=
+ b/configure.ac</span><br><span>@@ -1410,7 +1410,7 @@</span><br><span> ACL=
_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])</span><br><span> ACL_CHE=
CK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])</span><br><span> =
ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-=
type-limits -Wno-unused-parameter])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno=
-unused-parameter])</span><br><span> # clang doesn&#39;t have the different=
 levels but also doesn&#39;t include it in -Wextra</span><br><span> ACL_CHE=
CK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=3D2])</span><br><span> if test=
 &quot;${WIN32}&quot; =3D &quot;yes&quot;; then</span><br><span>diff --git =
a/src/openvpn/event.c b/src/openvpn/event.c</span><br><span>index ca84d19..=
ca2d0c1 100644</span><br><span>--- a/src/openvpn/event.c</span><br><span>++=
+ b/src/openvpn/event.c</span><br><span>@@ -410,6 +410,13 @@</span><br><spa=
n>     }</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* WSA_WAIT_EVENT_0 =3D=3D 0 but the API=
 documentation is written in a way</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+       that doesn&#39;t guarantee that. So we make useless c=
hecks. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wtype-limits&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * Fi=
rst poll our event list with 0 timeout</span><br><span>      */</span><br><=
span>@@ -474,6 +481,9 @@</span><br><span>             return -1;</span><br>=
<span>         }</span><br><span>     }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </s=
pan><br><span> static struct event_set *</span><br><span>diff --git a/src/o=
penvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 8eac96d..f7317=
d1 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/=
src/openvpn/socket.c</span><br><span>@@ -577,7 +577,8 @@</span><br><span>  =
   ASSERT(addrinfo);</span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =
=3D=3D SOCK_STREAM);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&g=
t;ai_socktype, addrinfo-&gt;ai_protocol)) &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if ((sd =3D socket(addrinfo-&gt;ai_family=
, addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        =3D=3D SOCKET_UNDEFINED)</span><=
br><span>     {</span><br><span>         msg(M_ERR, &quot;Cannot create TCP=
 socket&quot;);</span><br><span>     }</span><br><span>@@ -608,7 +609,8 @@<=
/span><br><span>     ASSERT(addrinfo);</span><br><span>     ASSERT(addrinfo=
-&gt;ai_socktype =3D=3D SOCK_DGRAM);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if ((sd =3D socket(addrinfo-&gt;ai_fam=
ily, addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol)) &lt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if ((sd =3D socket(addrin=
fo-&gt;ai_family, addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =3D=3D SOCKET_UN=
DEFINED)</span><br><span>     {</span><br><span>         msg(M_ERR, &quot;U=
DP: Cannot create UDP/UDP6 socket&quot;);</span><br><span>     }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1207?usp=3Demail">change 1207</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1207?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae=
9d384a8f9d871 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1207 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--fCUGyA7PPPE=--


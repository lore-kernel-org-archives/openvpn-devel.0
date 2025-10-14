From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 11:33:57 +0000
In-Reply-To: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
References: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <68ef46d81d13168da75ad05ca7ed03ce3a5851ab-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YXvLEltEr2c="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YXvLEltEr2c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


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
---
M CMakeLists.txt
M configure.ac
M src/openvpn/event.c
M src/openvpn/socket.c
4 files changed, 16 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1207/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b773dcb..4b42413 100644
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
index 8f3c01d..44c7b65 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1399,7 +1399,7 @@
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
index f71d891..23b6439 100644
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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Gerrit-Change-Number: 1207
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--YXvLEltEr2c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Enable -Wtype-limits by default=
 (via -Wextra)<br><br>Removes a few smaller instances:<br> - Fix return typ=
e check for socket() on Windows/Unixy<br> - Ignore a few instances related =
to WSAWaitForMultipleEvents.<br>   The compiler says the check is currently=
 useless, but<br>   we follow the API documentation.<br><br>Change-Id: Iaab=
ddb6f81cd94863291b193aae9d384a8f9d871<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M configure.ac<br>M s=
rc/openvpn/event.c<br>M src/openvpn/socket.c<br>4 files changed, 16 inserti=
ons(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/07/1207/4</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLis=
ts.txt b/CMakeLists.txt</span><br><span>index b773dcb..4b42413 100644</span=
><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span>=
<br><span>@@ -114,7 +114,7 @@</span><br><span>     check_and_add_compiler_f=
lag(-Wstrict-prototypes StrictPrototypes)</span><br><span>     check_and_ad=
d_compiler_flag(-Wold-style-definition OldStyleDefinition)</span><br><span>=
     add_compile_options(-Wconversion -Wno-sign-conversion)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    add_compile_options(-Wextra -Wno-=
sign-compare -Wno-type-limits -Wno-unused-parameter)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    add_compile_options(-Wextra -Wno-sign=
-compare -Wno-unused-parameter)</span><br><span>     # clang doesn&#39;t ha=
ve the different levels but also doesn&#39;t include it in -Wextra</span><b=
r><span>     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImpl=
icitFallthrough)</span><br><span>     if (WIN32)</span><br><span>diff --git=
 a/configure.ac b/configure.ac</span><br><span>index 8f3c01d..44c7b65 10064=
4</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</sp=
an><br><span>@@ -1399,7 +1399,7 @@</span><br><span> ACL_CHECK_ADD_COMPILE_F=
LAGS([-Wold-style-definition])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS=
([-Wconversion -Wno-sign-conversion])</span><br><span> ACL_CHECK_ADD_COMPIL=
E_FLAGS([-Wall])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ACL_C=
HECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unu=
sed-parameter])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_=
CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-unused-parameter])<=
/span><br><span> # clang doesn&#39;t have the different levels but also doe=
sn&#39;t include it in -Wextra</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS=
([-Wimplicit-fallthrough=3D2])</span><br><span> if test &quot;${WIN32}&quot=
; =3D &quot;yes&quot;; then</span><br><span>diff --git a/src/openvpn/event.=
c b/src/openvpn/event.c</span><br><span>index ca84d19..ca2d0c1 100644</span=
><br><span>--- a/src/openvpn/event.c</span><br><span>+++ b/src/openvpn/even=
t.c</span><br><span>@@ -410,6 +410,13 @@</span><br><span>     }</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* WSA_WAIT_EVENT_0 =3D=3D 0 but the API documentation is wr=
itten in a way</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
  that doesn&#39;t guarantee that. So we make useless checks. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wtype-limits&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     /*</span><br><span>      * First poll our event l=
ist with 0 timeout</span><br><span>      */</span><br><span>@@ -474,6 +481,=
9 @@</span><br><span>             return -1;</span><br><span>         }</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span> }</span><br><span> </span><br><span> stati=
c struct event_set *</span><br><span>diff --git a/src/openvpn/socket.c b/sr=
c/openvpn/socket.c</span><br><span>index f71d891..23b6439 100644</span><br>=
<span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c=
</span><br><span>@@ -577,7 +577,8 @@</span><br><span>     ASSERT(addrinfo);=
</span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =3D=3D SOCK_STREAM);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&gt;ai_socktype, addrin=
fo-&gt;ai_protocol)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&gt;ai_soc=
ktype, addrinfo-&gt;ai_protocol))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        =3D=3D SOCKET_UNDEFINED)</span><br><span>     {</span=
><br><span>         msg(M_ERR, &quot;Cannot create TCP socket&quot;);</span=
><br><span>     }</span><br><span>@@ -608,7 +609,8 @@</span><br><span>     =
ASSERT(addrinfo);</span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =3D=
=3D SOCK_DGRAM);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&gt;ai=
_socktype, addrinfo-&gt;ai_protocol)) &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if ((sd =3D socket(addrinfo-&gt;ai_family, ad=
drinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        =3D=3D SOCKET_UNDEFINED)</span><br><=
span>     {</span><br><span>         msg(M_ERR, &quot;UDP: Cannot create UD=
P/UDP6 socket&quot;);</span><br><span>     }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1207?=
usp=3Demail">change 1207</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1207?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae=
9d384a8f9d871 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1207 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--YXvLEltEr2c=--


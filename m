From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 13:11:19 +0000
In-Reply-To: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
References: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ad00b376ed6945b1cb30981a91fac5c237cc84cc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SAjWLrykI/I="; charset=UTF-8
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

--SAjWLrykI/I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail

to look at the new patch set (#2).


Change subject: Enable -Wtype-limits by default (via -Wextra)
......................................................................

Enable -Wtype-limits by default (via -Wextra)

Removes a few smaller instances:
 - Fix return type check for socket() on Windows/Unixy
 - Ignore a few instances related to WSAWaitForMultipleEvents.
   The compiler says the check is currently useless, but
   we follow the API documentation.
 - Fix one check that assumed peer_id was signed.

Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M configure.ac
M src/openvpn/event.c
M src/openvpn/init.c
M src/openvpn/socket.c
5 files changed, 17 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1207/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fdc0162..e4e0b51 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -115,7 +115,7 @@
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     # We are not ready for this
     #add_compile_options(-Wconversion -Wno-sign-conversion)
-    add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-un=
used-parameter)
+    add_compile_options(-Wextra -Wno-sign-compare -Wno-unused-parameter)
     # clang doesn't have the different levels but also doesn't include it =
in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFall=
through)
     if (WIN32)
diff --git a/configure.ac b/configure.ac
index c2feeea..8fc27c3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1398,7 +1398,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
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
index 581bdbb..77f859f 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -400,6 +400,13 @@
     }
 #endif
=20
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
@@ -464,6 +471,9 @@
             return -1;
         }
     }
+#if defined(__GNUC__)
+#pragma GCC diagnostic pop
+#endif
 }

 static struct event_set *
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0d7a2ec..62b8138 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2724,7 +2724,7 @@
     /* Ensure that for epoch data format is only enabled if also data v2
      * is enabled */
     bool epoch_data =3D (c->options.imported_protocol_flags & CO_EPOCH_DAT=
A_KEY_FORMAT);
-    bool datav2_enabled =3D (c->options.peer_id >=3D 0 && c->options.peer_=
id < MAX_PEER_ID);
+    bool datav2_enabled =3D c->options.peer_id < MAX_PEER_ID;

     if (epoch_data && !datav2_enabled)
     {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 94f16c7..584fc6b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -572,7 +572,8 @@
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
@@ -603,7 +604,8 @@
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
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Gerrit-Change-Number: 1207
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--SAjWLrykI/I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Enable -Wtype-limits by default (via -Wextra)<br><br>Removes a fe=
w smaller instances:<br> - Fix return type check for socket() on Windows/Un=
ixy<br> - Ignore a few instances related to WSAWaitForMultipleEvents.<br>  =
 The compiler says the check is currently useless, but<br>   we follow the =
API documentation.<br> - Fix one check that assumed peer_id was signed.<br>=
<br>Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M =
configure.ac<br>M src/openvpn/event.c<br>M src/openvpn/init.c<br>M src/open=
vpn/socket.c<br>5 files changed, 17 insertions(+), 5 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1207/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index fdc=
0162..e4e0b51 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+=
++ b/CMakeLists.txt</span><br><span>@@ -115,7 +115,7 @@</span><br><span>   =
  check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)</s=
pan><br><span>     # We are not ready for this</span><br><span>     #add_co=
mpile_options(-Wconversion -Wno-sign-conversion)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    add_compile_options(-Wextra -Wno-sign-compar=
e -Wno-type-limits -Wno-unused-parameter)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    add_compile_options(-Wextra -Wno-sign-compare -Wn=
o-unused-parameter)</span><br><span>     # clang doesn&#39;t have the diffe=
rent levels but also doesn&#39;t include it in -Wextra</span><br><span>    =
 check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFallthro=
ugh)</span><br><span>     if (WIN32)</span><br><span>diff --git a/configure=
.ac b/configure.ac</span><br><span>index c2feeea..8fc27c3 100644</span><br>=
<span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span=
>@@ -1398,7 +1398,7 @@</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wstri=
ct-prototypes])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-d=
efinition])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-ACL_CHECK_ADD_COMPILE_FLAGS([-W=
extra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-=
Wextra -Wno-sign-compare -Wno-unused-parameter])</span><br><span> # clang d=
oesn&#39;t have the different levels but also doesn&#39;t include it in -We=
xtra</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=
=3D2])</span><br><span> if test &quot;${WIN32}&quot; =3D &quot;yes&quot;; t=
hen</span><br><span>diff --git a/src/openvpn/event.c b/src/openvpn/event.c<=
/span><br><span>index 581bdbb..77f859f 100644</span><br><span>--- a/src/ope=
nvpn/event.c</span><br><span>+++ b/src/openvpn/event.c</span><br><span>@@ -=
400,6 +400,13 @@</span><br><span>     }</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* WSA_WA=
IT_EVENT_0 =3D=3D 0 but the API documentation is written in a way</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+       that doesn&#39;t guara=
ntee that. So we make useless checks. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wtype-=
limits&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  /*</span><br><span>      * First poll our event list with 0 timeout</span=
><br><span>      */</span><br><span>@@ -464,6 +471,9 @@</span><br><span>   =
          return -1;</span><br><span>         }</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> }</span><br><span> </span><br><span> static struct event_set *</sp=
an><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br=
><span>index 0d7a2ec..62b8138 100644</span><br><span>--- a/src/openvpn/init=
.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2724,7 +272=
4,7 @@</span><br><span>     /* Ensure that for epoch data format is only en=
abled if also data v2</span><br><span>      * is enabled */</span><br><span=
>     bool epoch_data =3D (c-&gt;options.imported_protocol_flags &amp; CO_E=
POCH_DATA_KEY_FORMAT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    bool datav2_enabled =3D (c-&gt;options.peer_id &gt;=3D 0 &amp;&amp; c-=
&gt;options.peer_id &lt; MAX_PEER_ID);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool datav2_enabled =3D c-&gt;options.peer_id &lt; M=
AX_PEER_ID;</span><br><span> </span><br><span>     if (epoch_data &amp;&amp=
; !datav2_enabled)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 94f16c7..584f=
c6b 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b=
/src/openvpn/socket.c</span><br><span>@@ -572,7 +572,8 @@</span><br><span> =
    ASSERT(addrinfo);</span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =
=3D=3D SOCK_STREAM);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&g=
t;ai_socktype, addrinfo-&gt;ai_protocol)) &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if ((sd =3D socket(addrinfo-&gt;ai_family=
, addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        =3D=3D SOCKET_UNDEFINED)</span><=
br><span>     {</span><br><span>         msg(M_ERR, &quot;Cannot create TCP=
 socket&quot;);</span><br><span>     }</span><br><span>@@ -603,7 +604,8 @@<=
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
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1207?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae=
9d384a8f9d871 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1207 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SAjWLrykI/I=--


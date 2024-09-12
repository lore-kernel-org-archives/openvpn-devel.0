From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Sep 2024 15:02:26 +0000
In-Reply-To: <gerrit.1715766485000.I1ef5f6f21f0135a628a63553c39515fa4549ce87@...2715...>
References: <gerrit.1715766485000.I1ef5f6f21f0135a628a63553c39515fa4549ce87@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a522316f7d5a1751b2a9c63c63219e16be65ad71-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NT14pi1pA6E="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove check for
 anonymous unions from configure and cmake config
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

--NT14pi1pA6E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/588?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Remove check for anonymous unions from configure and cmake =
config
......................................................................

Remove check for anonymous unions from configure and cmake config

Anonymous unions/structs are technically a custom GNU C99 feature but
was already widely supported by other compilers. With C11 this feature
has become a standard feature so all compilers nowadays support it.

Change-Id: I1ef5f6f21f0135a628a63553c39515fa4549ce87
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240710160238.190189-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
914.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/mroute.h
3 files changed, 1 insertion(+), 36 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/588/4

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 720d679..18af5e9 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -65,9 +65,6 @@
 /* Enable --x509-username-field feature */
 #cmakedefine ENABLE_X509ALTUSERNAME

-/* Compiler supports anonymous unions */
-#define HAVE_ANONYMOUS_UNION_SUPPORT
-
 /* Define to 1 if you have the <arpa/inet.h> header file. */
 #cmakedefine HAVE_ARPA_INET_H 1

diff --git a/configure.ac b/configure.ac
index 9e569bf..9bc15c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -564,28 +564,6 @@
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_MSG_CHECKING([anonymous union support])
-AC_COMPILE_IFELSE(
-	[AC_LANG_PROGRAM(
-		[[
-			struct mystruct {
-			  union {
-			    int m1;
-			    char m2;
-			  };
-			};
-		]],
-		[[
-			struct mystruct s;
-			s.m1 =3D 1; s.m2 =3D 2;
-		]]
-	)],
-	[
-		AC_MSG_RESULT([yes])
-		AC_DEFINE([HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler supports anonymo=
us unions])
-	],
-	[AC_MSG_RESULT([no])]
-)

 saved_LDFLAGS=3D"$LDFLAGS"
 LDFLAGS=3D"$LDFLAGS -Wl,--wrap=3Dexit"
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index bc58493..8b457d4 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -96,17 +96,7 @@
             uint8_t prefix[12];
             in_addr_t addr;     /* _network order_ IPv4 address */
         } v4mappedv6;
-    }
-#ifndef HAVE_ANONYMOUS_UNION_SUPPORT
-/* Wrappers to support compilers that do not grok anonymous unions */
-        mroute_union
-#define raw_addr mroute_union.raw_addr
-#define ether mroute_union.ether
-#define v4 mroute_union.v4
-#define v6 mroute_union.v6
-#define v4mappedv6 mroute_union.v4mappedv6
-#endif
-    ;
+    };
 };

 /* Double-check that struct packing works as expected */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/588?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ef5f6f21f0135a628a63553c39515fa4549ce87
Gerrit-Change-Number: 588
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--NT14pi1pA6E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
588?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Remove check for anonymous unions from config=
ure and cmake config<br><br>Anonymous unions/structs are technically a cust=
om GNU C99 feature but<br>was already widely supported by other compilers. =
With C11 this feature<br>has become a standard feature so all compilers now=
adays support it.<br><br>Change-Id: I1ef5f6f21f0135a628a63553c39515fa4549ce=
87<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240710160238.19=
0189-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg28914.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M config.h.cmake.in<br>M configure.ac<br>M sr=
c/openvpn/mroute.h<br>3 files changed, 1 insertion(+), 36 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/588/4=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span=
>index 720d679..18af5e9 100644</span><br><span>--- a/config.h.cmake.in</spa=
n><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -65,9 +65,6 @@</span=
><br><span> /* Enable --x509-username-field feature */</span><br><span> #cm=
akedefine ENABLE_X509ALTUSERNAME</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/* Compiler supports anonymous unions */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_ANONYMOUS_UNIO=
N_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> /* Define to 1 if you have the &lt;arpa/inet.h&gt; header file. */</s=
pan><br><span> #cmakedefine HAVE_ARPA_INET_H 1</span><br><span> </span><br>=
<span>diff --git a/configure.ac b/configure.ac</span><br><span>index 9e569b=
f..9bc15c8 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/=
configure.ac</span><br><span>@@ -564,28 +564,6 @@</span><br><span> 	,</span=
><br><span> 	[[${SOCKET_INCLUDES}]]</span><br><span> )</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-AC_MSG_CHECKING([anonymous union support])=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_COMPILE_IFELSE(</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_LANG_PROGRAM(</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		[[</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			struct mystruct {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			  union {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-			    int m1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-			    char m2;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-			  };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			}=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		]],</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-		[[</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-			struct mystruct s;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-			s.m1 =3D 1; s.m2 =3D 2;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-		]]</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	)],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_MSG_RESULT([yes])</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([HAVE_ANONYMO=
US_UNION_SUPPORT], [], [Compiler supports anonymous unions])</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	],</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	[AC_MSG_RESULT([no])]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-)</span><br><span> </span><br><span> saved_LDFLAGS=3D=
&quot;$LDFLAGS&quot;</span><br><span> LDFLAGS=3D&quot;$LDFLAGS -Wl,--wrap=
=3Dexit&quot;</span><br><span>diff --git a/src/openvpn/mroute.h b/src/openv=
pn/mroute.h</span><br><span>index bc58493..8b457d4 100644</span><br><span>-=
-- a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span>=
<br><span>@@ -96,17 +96,7 @@</span><br><span>             uint8_t prefix[12=
];</span><br><span>             in_addr_t addr;     /* _network order_ IPv4=
 address */</span><br><span>         } v4mappedv6;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifndef HAVE_ANONYMOUS_UNION_SUPPORT</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/* Wrappers to support compilers that do not gr=
ok anonymous unions */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        mroute_union</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define raw_addr mroute_union.raw_addr</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define ether mroute_union.ether</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define v4 mroute_union.v4</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define v6 mroute_union.v6</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define v4mappedv6 mroute_union.v4map=
pedv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span> };</span><br><span> <=
/span><br><span> /* Double-check that struct packing works as expected */</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/588?usp=3Demail">change 588</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/588?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ef5f6f21f0135a628a63553c39=
515fa4549ce87 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 588 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--NT14pi1pA6E=--


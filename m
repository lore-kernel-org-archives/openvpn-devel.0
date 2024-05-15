From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 15 May 2024 09:48:07 +0000
References: <gerrit.1715766485000.I1ef5f6f21f0135a628a63553c39515fa4549ce87@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <957a8e1829b1d1e7827be18b0a46d10fa8d65958-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N82Osg64Zn4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--N82Osg64Zn4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/588?usp=3Demail

to review the following change.


Change subject: Remove check for anonymous unions from configure and cmake =
config
......................................................................

Remove check for anonymous unions from configure and cmake config

Anonymous unions/structs are technically a custom GNU C99 feature but
was already widely supported by other compilers. With C11 this feature
has become a standard feature so all compilers nowadays support it.

Change-Id: I1ef5f6f21f0135a628a63553c39515fa4549ce87
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/mroute.h
3 files changed, 1 insertion(+), 36 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/588/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 2cdfdcc..a4f0893 100644
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
index 965ed1a..5f72029 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--N82Osg64Zn4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/588?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove check for anonymous unions from configure and cmake co=
nfig<br><br>Anonymous unions/structs are technically a custom GNU C99 featu=
re but<br>was already widely supported by other compilers. With C11 this fe=
ature<br>has become a standard feature so all compilers nowadays support it=
.<br><br>Change-Id: I1ef5f6f21f0135a628a63553c39515fa4549ce87<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M config.h.cmake.in<br>=
M configure.ac<br>M src/openvpn/mroute.h<br>3 files changed, 1 insertion(+)=
, 36 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/88/588/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cm=
ake.in</span><br><span>index 2cdfdcc..a4f0893 100644</span><br><span>--- a/=
config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@=
@ -65,9 +65,6 @@</span><br><span> /* Enable --x509-username-field feature *=
/</span><br><span> #cmakedefine ENABLE_X509ALTUSERNAME</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Compiler supports ano=
nymous unions */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne HAVE_ANONYMOUS_UNION_SUPPORT</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;arpa/inet.h&=
gt; header file. */</span><br><span> #cmakedefine HAVE_ARPA_INET_H 1</span>=
<br><span> </span><br><span>diff --git a/configure.ac b/configure.ac</span>=
<br><span>index 965ed1a..5f72029 100644</span><br><span>--- a/configure.ac<=
/span><br><span>+++ b/configure.ac</span><br><span>@@ -564,28 +564,6 @@</sp=
an><br><span> 	,</span><br><span> 	[[${SOCKET_INCLUDES}]]</span><br><span> =
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_MSG_CHECKING([ano=
nymous union support])</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-AC_COMPILE_IFELSE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[=
AC_LANG_PROGRAM(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[[<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-			struct mystruct {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-			  union {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-			    int m1;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-			    char m2;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			  };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-			};</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-		]],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[[</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-			struct mystruct s;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-			s.m1 =3D 1; s.m2 =3D 2;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-		]]</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	)],</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC=
_MSG_RESULT([yes])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		A=
C_DEFINE([HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler supports anonymous u=
nions])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	],</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	[AC_MSG_RESULT([no])]</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span> </span><br><=
span> saved_LDFLAGS=3D&quot;$LDFLAGS&quot;</span><br><span> LDFLAGS=3D&quot=
;$LDFLAGS -Wl,--wrap=3Dexit&quot;</span><br><span>diff --git a/src/openvpn/=
mroute.h b/src/openvpn/mroute.h</span><br><span>index bc58493..8b457d4 1006=
44</span><br><span>--- a/src/openvpn/mroute.h</span><br><span>+++ b/src/ope=
nvpn/mroute.h</span><br><span>@@ -96,17 +96,7 @@</span><br><span>          =
   uint8_t prefix[12];</span><br><span>             in_addr_t addr;     /* =
_network order_ IPv4 address */</span><br><span>         } v4mappedv6;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifndef HAVE_ANONYMOUS_UNION_SUPPORT</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Wrappers to support comp=
ilers that do not grok anonymous unions */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        mroute_union</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define raw_addr mroute_union.raw_addr</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define ether mroute_union.ether</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define v4 mroute_union.v4<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define v6 mroute_unio=
n.v6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define v4mappedv=
6 mroute_union.v4mappedv6</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span> }=
;</span><br><span> </span><br><span> /* Double-check that struct packing wo=
rks as expected */</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/588?usp=3Demail">change 588</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/588?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ef5f6f21f0135a628a63553c39=
515fa4549ce87 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 588 </div>
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


--N82Osg64Zn4=--


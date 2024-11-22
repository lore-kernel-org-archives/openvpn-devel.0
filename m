From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 15:36:03 +0000
In-Reply-To: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
References: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <434cce41f971bf617f6f3e3c545dcd5d8edc2cd5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M9gn0Fhqfqg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-win: enable mode
 server on supported configuration
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

--M9gn0Fhqfqg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: dco-win: enable mode server on supported configuration
......................................................................

dco-win: enable mode server on supported configuration

Enable dco-win with mode server if driver supports it.

Disable for proto TCP or older drivers.

Change-Id: Iea4538cee075d50de836d1ef7652985186b2527c
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
3 files changed, 20 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/812/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcc80d3..4195cf8 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -43,6 +43,10 @@
 #include "tun.h"
 #include "tun_afunix.h"

+#if defined(_WIN32)
+#include "dco_win.h"
+#endif
+
 #ifdef HAVE_LIBCAPNG
 #include <cap-ng.h>
 #endif
@@ -255,18 +259,18 @@
         return false;
     }

-#if defined(TARGET_FREEBSD)
+#if defined(TARGET_FREEBSD) || defined(TARGET_WIN32)
     if (!proto_is_udp(ce->proto))
     {
-        msg(msglevel, "NOTE: TCP transport disables data channel offload o=
n FreeBSD.");
+        msg(msglevel, "NOTE: TCP transport disables data channel offload o=
n FreeBSD and Windows.");
         return false;
     }
 #endif

 #if defined(_WIN32)
-    if (!ce->remote)
+    if (!ce->remote && !dco_win_supports_multipeer())
     {
-        msg(msglevel, "NOTE: --remote is not defined, disabling data chann=
el offload.");
+        msg(msglevel, "NOTE: --remote is not defined. This DCO version doe=
sn't support multipeer. Disabling Data Channel Offload");
         return false;
     }
 #endif
@@ -331,9 +335,9 @@
     }

 #if defined(_WIN32)
-    if (o->mode =3D=3D MODE_SERVER)
+    if ((o->mode =3D=3D MODE_SERVER) && !dco_win_supports_multipeer())
     {
-        msg(msglevel, "--mode server is set. Disabling Data Channel Offloa=
d");
+        msg(msglevel, "--mode server is set. This DCO version doesn't supp=
ort multipeer. Disabling Data Channel Offload");
         return false;
     }

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 27182b5..3bc123b 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -523,4 +523,11 @@
     }
 }

+bool
+dco_win_supports_multipeer()
+{
+    OVPN_VERSION ver =3D { 0 };
+    return dco_get_version(&ver) && ver.Major >=3D 2;
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..a28436c 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -48,6 +48,9 @@
 void
 dco_start_tun(struct tuntap *tt);

+bool
+dco_win_supports_multipeer();
+
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */

 static inline void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea4538cee075d50de836d1ef7652985186b2527c
Gerrit-Change-Number: 812
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--M9gn0Fhqfqg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco-win: enable mode server on supported conf=
iguration<br><br>Enable dco-win with mode server if driver supports it.<br>=
<br>Disable for proto TCP or older drivers.<br><br>Change-Id: Iea4538cee075=
d50de836d1ef7652985186b2527c<br>Signed-off-by: Lev Stipakov &lt;lev@...2092...=
..&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/dco_win.c<br>M src/op=
envpn/dco_win.h<br>3 files changed, 20 insertions(+), 6 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/812/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>i=
ndex dcc80d3..4195cf8 100644</span><br><span>--- a/src/openvpn/dco.c</span>=
<br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -43,6 +43,10 @@</span>=
<br><span> #include &quot;tun.h&quot;</span><br><span> #include &quot;tun_a=
funix.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;dco_win.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef HAVE_LIBCAPNG</span><br><span> #include =
&lt;cap-ng.h&gt;</span><br><span> #endif</span><br><span>@@ -255,18 +259,18=
 @@</span><br><span>         return false;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(T=
ARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(TARGET_FREEBSD) || defined(TARGET_WIN32)</span><br><span>     if (!p=
roto_is_udp(ce-&gt;proto))</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;NOTE: TCP transport=
 disables data channel offload on FreeBSD.&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;NOTE: TCP transp=
ort disables data channel offload on FreeBSD and Windows.&quot;);</span><br=
><span>         return false;</span><br><span>     }</span><br><span> #endi=
f</span><br><span> </span><br><span> #if defined(_WIN32)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!ce-&gt;remote)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt;remote &amp;&amp; !d=
co_win_supports_multipeer())</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;NOTE: --remote =
is not defined, disabling data channel offload.&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;NOTE: --rem=
ote is not defined. This DCO version doesn&#39;t support multipeer. Disabli=
ng Data Channel Offload&quot;);</span><br><span>         return false;</spa=
n><br><span>     }</span><br><span> #endif</span><br><span>@@ -331,9 +335,9=
 @@</span><br><span>     }</span><br><span> </span><br><span> #if defined(_=
WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;m=
ode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if ((o-&gt;mode =3D=3D MODE_SERVER) &amp;&amp; !dco_win_supports_mu=
ltipeer())</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(msglevel, &quot;--mode server is set. Disabling Dat=
a Channel Offload&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(msglevel, &quot;--mode server is set. This DCO version do=
esn&#39;t support multipeer. Disabling Data Channel Offload&quot;);</span><=
br><span>         return false;</span><br><span>     }</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</s=
pan><br><span>index 27182b5..3bc123b 100644</span><br><span>--- a/src/openv=
pn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@=
 -523,4 +523,11 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_win_supports_multipeer()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    OVPN_VERSION ver =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return dco_get_version(&=
amp;ver) &amp;&amp; ver.Major &gt;=3D 2;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #endif /* defined(_WIN32) */</span><br><span>diff --gi=
t a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 488=
3629..a28436c 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br>=
<span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -48,6 +48,9 @@</span><=
br><span> void</span><br><span> dco_start_tun(struct tuntap *tt);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dco_win_supports_multipeer=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #else /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><br><=
span> </span><br><span> static inline void</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/812?usp=
=3Demail">change 812</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/812?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea4538cee075d50de836d1ef765=
2985186b2527c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 812 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--M9gn0Fhqfqg=--


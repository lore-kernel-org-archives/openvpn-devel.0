From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 14:34:50 +0000
In-Reply-To: <gerrit.1757601342000.Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f@...2715...>
References: <gerrit.1757601342000.Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <730af8a5411d6f005c05e0fd2e39f46e364b2829-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N7n+8jbn/PU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: event: Silence
 conversion warning in tv_to_ms_timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--N7n+8jbn/PU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello MaxF, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1178?usp=3Demail

to look at the new patch set (#8).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: event: Silence conversion warning in tv_to_ms_timeout
......................................................................

event: Silence conversion warning in tv_to_ms_timeout

The APIs want int (at least on unixy systems), so we
use int. max_int() protects us against negative values.

Change-Id: Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/event.c
1 file changed, 10 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1178/8

diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 2f60b78..ca84d19 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -65,11 +65,15 @@
 #define SELECT_MAX_FDS 256
 #endif

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
+/** Convert \c timeval value (which is in seconds and microseconds)
+    to a value of milliseconds which is required by multiple polling
+    APIs.

+    @param tv \c timeval to convert
+
+    @return Milliseconds to wait. Zero if \p tv is zero.
+     Otherwise the return value is always greater than zero.
+*/
 static inline int
 tv_to_ms_timeout(const struct timeval *tv)
 {
@@ -79,14 +83,11 @@
     }
     else
     {
-        return max_int(tv->tv_sec * 1000 + (tv->tv_usec + 500) / 1000, 1);
+        /* might overflow but not for practically useful numbers */
+        return max_int((int)(tv->tv_sec * 1000 + (tv->tv_usec + 500) / 100=
0), 1);
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef _WIN32

 struct we_set

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1178?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8a242838b6f8b42f36327c33fc62bb5f94ec43f
Gerrit-Change-Number: 1178
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--N7n+8jbn/PU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #8</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1178?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">event: Silence conversion warning in tv_to_ms_timeout=
<br><br>The APIs want int (at least on unixy systems), so we<br>use int. ma=
x_int() protects us against negative values.<br><br>Change-Id: Ie8a242838b6=
f8b42f36327c33fc62bb5f94ec43f<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>---<br>M src/openvpn/event.c<br>1 file changed, 10 inser=
tions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/78/1178/8</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/event.c b/s=
rc/openvpn/event.c</span><br><span>index 2f60b78..ca84d19 100644</span><br>=
<span>--- a/src/openvpn/event.c</span><br><span>+++ b/src/openvpn/event.c</=
span><br><span>@@ -65,11 +65,15 @@</span><br><span> #define SELECT_MAX_FDS =
256</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic =
ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* Convert \c timeval value (which is in seconds and microseconds)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    to a value of millisecond=
s which is required by multiple polling</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    APIs.</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    @param tv \c timeval to convert</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    @return Milliseconds to wait. Zero if \p tv is=
 zero.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     Otherwis=
e the return value is always greater than zero.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+*/</span><br><span> static inline int</span><br=
><span> tv_to_ms_timeout(const struct timeval *tv)</span><br><span> {</span=
><br><span>@@ -79,14 +83,11 @@</span><br><span>     }</span><br><span>     =
else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return max_int(tv-&gt;tv_sec * 1000 + (tv-&gt;tv_usec + 500) =
/ 1000, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* might overflow but not for practically useful numbers */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return max_int((int)(tv-&gt=
;tv_sec * 1000 + (tv-&gt;tv_usec + 500) / 1000), 1);</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span=
> </span><br><span> struct we_set</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1178?usp=3Demail=
">change 1178</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1178?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8a242838b6f8b42f36327c33fc=
62bb5f94ec43f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1178 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--N7n+8jbn/PU=--


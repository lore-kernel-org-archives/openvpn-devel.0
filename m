From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 15:42:25 +0000
References: <gerrit.1768318939000.I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <93b518754f4ffedff631dd76dc382abb70a99d20-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OHqitZoUrN0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: error: Remove our
 implementation of static_assert
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

--OHqitZoUrN0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail

to review the following change.


Change subject: error: Remove our implementation of static_assert
......................................................................

error: Remove our implementation of static_assert

It is C11, so it should be present in all our
compilers.

Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/error.h
1 file changed, 0 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1471/1

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 44572b4..1198994 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -245,14 +245,6 @@
 #endif
     ;

-/* Poor-man's static_assert() for when not supplied by assert.h, taken from
- * Linux's sys/cdefs.h under GPLv2 */
-#ifndef static_assert
-#define static_assert(expr, diagnostic)            \
-    extern int (*__OpenVPN_static_assert_function( \
-        void))[!!sizeof(struct { int __error_if_negative : (expr) ? 2 : -1=
; })]
-#endif
-
 /* Inline functions */

 static inline bool

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b
Gerrit-Change-Number: 1471
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--OHqitZoUrN0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">error: Remove our implementation of static_=
assert<br><br>It is C11, so it should be present in all our<br>compilers.<b=
r><br>Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/error.=
h<br>1 file changed, 0 insertions(+), 8 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1471/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/error.h b/src/openvpn/error.h</span><br><=
span>index 44572b4..1198994 100644</span><br><span>--- a/src/openvpn/error.=
h</span><br><span>+++ b/src/openvpn/error.h</span><br><span>@@ -245,14 +245=
,6 @@</span><br><span> #endif</span><br><span>     ;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Poor-man&#39;s static_a=
ssert() for when not supplied by assert.h, taken from</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Linux&#39;s sys/cdefs.h under GPLv2 */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef static_assert</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define static_assert(e=
xpr, diagnostic)            \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    extern int (*__OpenVPN_static_assert_function( \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        void))[!!sizeof(struct { int=
 __error_if_negative : (expr) ? 2 : -1; })]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /* Inline functions */</span><br><span> </span><br=
><span> static inline bool</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail">chang=
e 1471</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9cb14b9f44409ec5c78044ddb21=
6a2b4dced0f9b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1471 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--OHqitZoUrN0=--


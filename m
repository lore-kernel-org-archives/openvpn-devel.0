From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 10:06:40 +0000
In-Reply-To: <gerrit.1768318939000.I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b@...2715...>
References: <gerrit.1768318939000.I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <98c277df4dba8702b14bf4faefdc7a463ccff19b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MjtALR2HoGs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MjtALR2HoGs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: error: Remove our implementation of static_assert
......................................................................

error: Remove our implementation of static_assert

It is C11, so it should be present in all our
compilers.

Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1471
Message-Id: <20260115092552.25011-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59283672/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/error.h
1 file changed, 0 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1471/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b
Gerrit-Change-Number: 1471
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MjtALR2HoGs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">error: Remove our implementation of=
 static_assert<br><br>It is C11, so it should be present in all our<br>comp=
ilers.<br><br>Change-Id: I9cb14b9f44409ec5c78044ddb216a2b4dced0f9b<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1471<br>Message-Id: &lt;20260115092552.25011-1-gert@...1296...&gt;<b=
r>URL: https://sourceforge.net/p/openvpn/mailman/message/59283672/<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/erro=
r.h<br>1 file changed, 0 insertions(+), 8 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1471=
/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/error.h b/src/openvpn/error.h</span><br=
><span>index 44572b4..1198994 100644</span><br><span>--- a/src/openvpn/erro=
r.h</span><br><span>+++ b/src/openvpn/error.h</span><br><span>@@ -245,14 +2=
45,6 @@</span><br><span> #endif</span><br><span>     ;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Poor-man&#39;s static=
_assert() for when not supplied by assert.h, taken from</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Linux&#39;s sys/cdefs.h under GPLv2 */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef static_assert=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define static_assert=
(expr, diagnostic)            \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    extern int (*__OpenVPN_static_assert_function( \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        void))[!!sizeof(struct { i=
nt __error_if_negative : (expr) ? 2 : -1; })]</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /* Inline functions */</span><br><span> </span><=
br><span> static inline bool</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail">cha=
nge 1471</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1471?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9cb14b9f44409ec5c78044ddb21=
6a2b4dced0f9b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1471 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--MjtALR2HoGs=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 16:00:20 +0000
In-Reply-To: <gerrit.1753360288000.I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30@...2715...>
References: <gerrit.1753360288000.I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2edfa6a5b94f3e2bd18e0cbe90af7916f72ac972-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o8LNI0Nppxs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Make sure
 option types are treated as unsigned
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

--o8LNI0Nppxs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail

to look at the new patch set (#4).


Change subject: options: Make sure option types are treated as unsigned
......................................................................

options: Make sure option types are treated as unsigned

verify_permissions already expects them to be unsigned,
make sure they are to avoid spurious conversion warnings.

Change-Id: I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.h
1 file changed, 32 insertions(+), 32 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1106/4

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5ee6e93..7dc2912 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -729,38 +729,38 @@
 /*
  * Option classes.
  */
-#define OPT_P_GENERAL         (1 << 0)
-#define OPT_P_UP              (1 << 1)
-#define OPT_P_ROUTE           (1 << 2)
-#define OPT_P_DHCPDNS         (1 << 3) /* includes ip windows options like=
 */
-#define OPT_P_SCRIPT          (1 << 4)
-#define OPT_P_SETENV          (1 << 5)
-#define OPT_P_SHAPER          (1 << 6)
-#define OPT_P_TIMER           (1 << 7)
-#define OPT_P_PERSIST         (1 << 8)
-#define OPT_P_PERSIST_IP      (1 << 9)
-#define OPT_P_COMP            (1 << 10) /* TODO */
-#define OPT_P_MESSAGES        (1 << 11)
-#define OPT_P_NCP             (1 << 12) /**< Negotiable crypto parameters =
*/
-#define OPT_P_TLS_PARMS       (1 << 13) /* TODO */
-#define OPT_P_MTU             (1 << 14) /* TODO */
-#define OPT_P_NICE            (1 << 15)
-#define OPT_P_PUSH            (1 << 16)
-#define OPT_P_INSTANCE        (1 << 17) /**< allowed in ccd, client-connec=
t etc*/
-#define OPT_P_CONFIG          (1 << 18)
-#define OPT_P_EXPLICIT_NOTIFY (1 << 19)
-#define OPT_P_ECHO            (1 << 20)
-#define OPT_P_INHERIT         (1 << 21)
-#define OPT_P_ROUTE_EXTRAS    (1 << 22)
-#define OPT_P_PULL_MODE       (1 << 23)
-#define OPT_P_PLUGIN          (1 << 24)
-#define OPT_P_SOCKBUF         (1 << 25)
-#define OPT_P_SOCKFLAGS       (1 << 26)
-#define OPT_P_CONNECTION      (1 << 27)
-#define OPT_P_PEER_ID         (1 << 28)
-#define OPT_P_INLINE          (1 << 29)
-#define OPT_P_PUSH_MTU        (1 << 30)
-#define OPT_P_ROUTE_TABLE     (1 << 31)
+#define OPT_P_GENERAL         (1u << 0)
+#define OPT_P_UP              (1u << 1)
+#define OPT_P_ROUTE           (1u << 2)
+#define OPT_P_DHCPDNS         (1u << 3) /* includes ip windows options lik=
e */
+#define OPT_P_SCRIPT          (1u << 4)
+#define OPT_P_SETENV          (1u << 5)
+#define OPT_P_SHAPER          (1u << 6)
+#define OPT_P_TIMER           (1u << 7)
+#define OPT_P_PERSIST         (1u << 8)
+#define OPT_P_PERSIST_IP      (1u << 9)
+#define OPT_P_COMP            (1u << 10) /* TODO */
+#define OPT_P_MESSAGES        (1u << 11)
+#define OPT_P_NCP             (1u << 12) /**< Negotiable crypto parameters=
 */
+#define OPT_P_TLS_PARMS       (1u << 13) /* TODO */
+#define OPT_P_MTU             (1u << 14) /* TODO */
+#define OPT_P_NICE            (1u << 15)
+#define OPT_P_PUSH            (1u << 16)
+#define OPT_P_INSTANCE        (1u << 17) /**< allowed in ccd, client-conne=
ct etc*/
+#define OPT_P_CONFIG          (1u << 18)
+#define OPT_P_EXPLICIT_NOTIFY (1u << 19)
+#define OPT_P_ECHO            (1u << 20)
+#define OPT_P_INHERIT         (1u << 21)
+#define OPT_P_ROUTE_EXTRAS    (1u << 22)
+#define OPT_P_PULL_MODE       (1u << 23)
+#define OPT_P_PLUGIN          (1u << 24)
+#define OPT_P_SOCKBUF         (1u << 25)
+#define OPT_P_SOCKFLAGS       (1u << 26)
+#define OPT_P_CONNECTION      (1u << 27)
+#define OPT_P_PEER_ID         (1u << 28)
+#define OPT_P_INLINE          (1u << 29)
+#define OPT_P_PUSH_MTU        (1u << 30)
+#define OPT_P_ROUTE_TABLE     (1u << 31)

 #define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30
Gerrit-Change-Number: 1106
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--o8LNI0Nppxs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">options: Make sure option types are treated as unsigned<br><br>ve=
rify_permissions already expects them to be unsigned,<br>make sure they are=
 to avoid spurious conversion warnings.<br><br>Change-Id: I1d27cb81d32058e4=
0147e1d6dcd12df7f6cb2b30<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>---<br>M src/openvpn/options.h<br>1 file changed, 32 insertio=
ns(+), 32 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/06/1106/4</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.h b/s=
rc/openvpn/options.h</span><br><span>index 5ee6e93..7dc2912 100644</span><b=
r><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/optio=
ns.h</span><br><span>@@ -729,38 +729,38 @@</span><br><span> /*</span><br><s=
pan>  * Option classes.</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define OPT_P_GENERAL         (1 &lt;&lt; 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_UP             =
 (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e OPT_P_ROUTE           (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define OPT_P_DHCPDNS         (1 &lt;&lt; 3) /* includes i=
p windows options like */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define OPT_P_SCRIPT          (1 &lt;&lt; 4)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define OPT_P_SETENV          (1 &lt;&lt; 5)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_SHAPER     =
     (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine OPT_P_TIMER           (1 &lt;&lt; 7)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define OPT_P_PERSIST         (1 &lt;&lt; 8)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PERSIST_IP      (=
1 &lt;&lt; 9)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
OPT_P_COMP            (1 &lt;&lt; 10) /* TODO */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define OPT_P_MESSAGES        (1 &lt;&lt; 11)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_NCP       =
      (1 &lt;&lt; 12) /**&lt; Negotiable crypto parameters */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_TLS_PARMS       (1 &l=
t;&lt; 13) /* TODO */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define OPT_P_MTU             (1 &lt;&lt; 14) /* TODO */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_NICE            (1 &lt;&lt=
; 15)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PU=
SH            (1 &lt;&lt; 16)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define OPT_P_INSTANCE        (1 &lt;&lt; 17) /**&lt; allowed in cc=
d, client-connect etc*/</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define OPT_P_CONFIG          (1 &lt;&lt; 18)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define OPT_P_EXPLICIT_NOTIFY (1 &lt;&lt; 19)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_ECHO       =
     (1 &lt;&lt; 20)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define OPT_P_INHERIT         (1 &lt;&lt; 21)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define OPT_P_ROUTE_EXTRAS    (1 &lt;&lt; 22)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PULL_MODE     =
  (1 &lt;&lt; 23)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine OPT_P_PLUGIN          (1 &lt;&lt; 24)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define OPT_P_SOCKBUF         (1 &lt;&lt; 25)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_SOCKFLAGS       (=
1 &lt;&lt; 26)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 OPT_P_CONNECTION      (1 &lt;&lt; 27)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define OPT_P_PEER_ID         (1 &lt;&lt; 28)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_INLINE          (1 &=
lt;&lt; 29)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OP=
T_P_PUSH_MTU        (1 &lt;&lt; 30)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define OPT_P_ROUTE_TABLE     (1 &lt;&lt; 31)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_GENERAL         (1u &=
lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
PT_P_UP              (1u &lt;&lt; 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define OPT_P_ROUTE           (1u &lt;&lt; 2)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DHCPDNS         (1=
u &lt;&lt; 3) /* includes ip windows options like */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_SCRIPT          (1u &lt;&lt=
; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_S=
ETENV          (1u &lt;&lt; 5)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OPT_P_SHAPER          (1u &lt;&lt; 6)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_TIMER           (1u &lt;=
&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_=
P_PERSIST         (1u &lt;&lt; 8)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define OPT_P_PERSIST_IP      (1u &lt;&lt; 9)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_COMP            (1u &=
lt;&lt; 10) /* TODO */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define OPT_P_MESSAGES        (1u &lt;&lt; 11)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OPT_P_NCP             (1u &lt;&lt; 12=
) /**&lt; Negotiable crypto parameters */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OPT_P_TLS_PARMS       (1u &lt;&lt; 13) /* TOD=
O */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_M=
TU             (1u &lt;&lt; 14) /* TODO */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define OPT_P_NICE            (1u &lt;&lt; 15)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_PUSH       =
     (1u &lt;&lt; 16)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define OPT_P_INSTANCE        (1u &lt;&lt; 17) /**&lt; allowed in ccd, cl=
ient-connect etc*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPT_P_CONFIG          (1u &lt;&lt; 18)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OPT_P_EXPLICIT_NOTIFY (1u &lt;&lt; 19)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ECHO    =
        (1u &lt;&lt; 20)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define OPT_P_INHERIT         (1u &lt;&lt; 21)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ROUTE_EXTRAS    (1u &lt;&lt=
; 22)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
PULL_MODE       (1u &lt;&lt; 23)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define OPT_P_PLUGIN          (1u &lt;&lt; 24)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_SOCKBUF         (1u &=
lt;&lt; 25)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OPT_P_SOCKFLAGS       (1u &lt;&lt; 26)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OPT_P_CONNECTION      (1u &lt;&lt; 27)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_PEER_ID        =
 (1u &lt;&lt; 28)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ROUTE_TAB=
LE     (1u &lt;&lt; 31)</span><br><span> </span><br><span> #define OPT_P_DE=
FAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><br><span> </span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1106?usp=3Demail">change 1106</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/110=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d27cb81d32058e40147e1d6dcd=
12df7f6cb2b30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1106 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--o8LNI0Nppxs=--


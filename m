From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:43 +0000
References: <gerrit.1753360288000.I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2854996f9dfd1590e1375d52e20724a9b2cad35c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D4bHme9u6dg="; charset=UTF-8
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

--D4bHme9u6dg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1106/1

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 137e012..4ba8e3d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -728,38 +728,38 @@
 /*
  * Option classes.
  */
-#define OPT_P_GENERAL         (1<<0)
-#define OPT_P_UP              (1<<1)
-#define OPT_P_ROUTE           (1<<2)
-#define OPT_P_DHCPDNS         (1<<3)    /* includes ip windows options lik=
e */
-#define OPT_P_SCRIPT          (1<<4)
-#define OPT_P_SETENV          (1<<5)
-#define OPT_P_SHAPER          (1<<6)
-#define OPT_P_TIMER           (1<<7)
-#define OPT_P_PERSIST         (1<<8)
-#define OPT_P_PERSIST_IP      (1<<9)
-#define OPT_P_COMP            (1<<10) /* TODO */
-#define OPT_P_MESSAGES        (1<<11)
-#define OPT_P_NCP             (1<<12) /**< Negotiable crypto parameters */
-#define OPT_P_TLS_PARMS       (1<<13) /* TODO */
-#define OPT_P_MTU             (1<<14) /* TODO */
-#define OPT_P_NICE            (1<<15)
-#define OPT_P_PUSH            (1<<16)
-#define OPT_P_INSTANCE        (1<<17) /**< allowed in ccd, client-connect =
etc*/
-#define OPT_P_CONFIG          (1<<18)
-#define OPT_P_EXPLICIT_NOTIFY (1<<19)
-#define OPT_P_ECHO            (1<<20)
-#define OPT_P_INHERIT         (1<<21)
-#define OPT_P_ROUTE_EXTRAS    (1<<22)
-#define OPT_P_PULL_MODE       (1<<23)
-#define OPT_P_PLUGIN          (1<<24)
-#define OPT_P_SOCKBUF         (1<<25)
-#define OPT_P_SOCKFLAGS       (1<<26)
-#define OPT_P_CONNECTION      (1<<27)
-#define OPT_P_PEER_ID         (1<<28)
-#define OPT_P_INLINE          (1<<29)
-#define OPT_P_PUSH_MTU        (1<<30)
-#define OPT_P_ROUTE_TABLE     (1<<31)
+#define OPT_P_GENERAL         (1u<<0)
+#define OPT_P_UP              (1u<<1)
+#define OPT_P_ROUTE           (1u<<2)
+#define OPT_P_DHCPDNS         (1u<<3)    /* includes ip windows options li=
ke */
+#define OPT_P_SCRIPT          (1u<<4)
+#define OPT_P_SETENV          (1u<<5)
+#define OPT_P_SHAPER          (1u<<6)
+#define OPT_P_TIMER           (1u<<7)
+#define OPT_P_PERSIST         (1u<<8)
+#define OPT_P_PERSIST_IP      (1u<<9)
+#define OPT_P_COMP            (1u<<10) /* TODO */
+#define OPT_P_MESSAGES        (1u<<11)
+#define OPT_P_NCP             (1u<<12) /**< Negotiable crypto parameters */
+#define OPT_P_TLS_PARMS       (1u<<13) /* TODO */
+#define OPT_P_MTU             (1u<<14) /* TODO */
+#define OPT_P_NICE            (1u<<15)
+#define OPT_P_PUSH            (1u<<16)
+#define OPT_P_INSTANCE        (1u<<17) /**< allowed in ccd, client-connect=
 etc*/
+#define OPT_P_CONFIG          (1u<<18)
+#define OPT_P_EXPLICIT_NOTIFY (1u<<19)
+#define OPT_P_ECHO            (1u<<20)
+#define OPT_P_INHERIT         (1u<<21)
+#define OPT_P_ROUTE_EXTRAS    (1u<<22)
+#define OPT_P_PULL_MODE       (1u<<23)
+#define OPT_P_PLUGIN          (1u<<24)
+#define OPT_P_SOCKBUF         (1u<<25)
+#define OPT_P_SOCKFLAGS       (1u<<26)
+#define OPT_P_CONNECTION      (1u<<27)
+#define OPT_P_PEER_ID         (1u<<28)
+#define OPT_P_INLINE          (1u<<29)
+#define OPT_P_PUSH_MTU        (1u<<30)
+#define OPT_P_ROUTE_TABLE     (1u<<31)

 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))


--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30
Gerrit-Change-Number: 1106
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--D4bHme9u6dg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Make sure option types are treated as unsigned<br><=
br>verify_permissions already expects them to be unsigned,<br>make sure the=
y are to avoid spurious conversion warnings.<br><br>Change-Id: I1d27cb81d32=
058e40147e1d6dcd12df7f6cb2b30<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>---<br>M src/openvpn/options.h<br>1 file changed, 32 ins=
ertions(+), 32 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/06/1106/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.=
h b/src/openvpn/options.h</span><br><span>index 137e012..4ba8e3d 100644</sp=
an><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/=
options.h</span><br><span>@@ -728,38 +728,38 @@</span><br><span> /*</span><=
br><span>  * Option classes.</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define OPT_P_GENERAL         (1&lt;&lt;0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_UP          =
    (1&lt;&lt;1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne OPT_P_ROUTE           (1&lt;&lt;2)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define OPT_P_DHCPDNS         (1&lt;&lt;3)    /* includes i=
p windows options like */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define OPT_P_SCRIPT          (1&lt;&lt;4)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define OPT_P_SETENV          (1&lt;&lt;5)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_SHAPER         =
 (1&lt;&lt;6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
OPT_P_TIMER           (1&lt;&lt;7)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define OPT_P_PERSIST         (1&lt;&lt;8)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PERSIST_IP      (1&lt;&lt;9=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_COMP  =
          (1&lt;&lt;10) /* TODO */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define OPT_P_MESSAGES        (1&lt;&lt;11)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_NCP             (1&lt;&lt;=
12) /**&lt; Negotiable crypto parameters */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define OPT_P_TLS_PARMS       (1&lt;&lt;13) /* TODO *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_MTU   =
          (1&lt;&lt;14) /* TODO */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define OPT_P_NICE            (1&lt;&lt;15)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PUSH            (1&lt;&lt;=
16)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_INST=
ANCE        (1&lt;&lt;17) /**&lt; allowed in ccd, client-connect etc*/</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_CONFIG      =
    (1&lt;&lt;18)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine OPT_P_EXPLICIT_NOTIFY (1&lt;&lt;19)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define OPT_P_ECHO            (1&lt;&lt;20)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_INHERIT         (1&lt=
;&lt;21)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P=
_ROUTE_EXTRAS    (1&lt;&lt;22)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define OPT_P_PULL_MODE       (1&lt;&lt;23)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PLUGIN          (1&lt;&lt;24)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_SOCKBUF=
         (1&lt;&lt;25)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define OPT_P_SOCKFLAGS       (1&lt;&lt;26)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define OPT_P_CONNECTION      (1&lt;&lt;27)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_PEER_ID         =
(1&lt;&lt;28)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
OPT_P_INLINE          (1&lt;&lt;29)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define OPT_P_PUSH_MTU        (1&lt;&lt;30)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_ROUTE_TABLE     (1&lt;&lt=
;31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_G=
ENERAL         (1u&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define OPT_P_UP              (1u&lt;&lt;1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ROUTE           (1u&lt;&lt;=
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DHC=
PDNS         (1u&lt;&lt;3)    /* includes ip windows options like */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_SCRIPT      =
    (1u&lt;&lt;4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine OPT_P_SETENV          (1u&lt;&lt;5)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OPT_P_SHAPER          (1u&lt;&lt;6)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_TIMER          =
 (1u&lt;&lt;7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne OPT_P_PERSIST         (1u&lt;&lt;8)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OPT_P_PERSIST_IP      (1u&lt;&lt;9)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_COMP            (1=
u&lt;&lt;10) /* TODO */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPT_P_MESSAGES        (1u&lt;&lt;11)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define OPT_P_NCP             (1u&lt;&lt;12) /=
**&lt; Negotiable crypto parameters */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OPT_P_TLS_PARMS       (1u&lt;&lt;13) /* TODO */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_MTU   =
          (1u&lt;&lt;14) /* TODO */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define OPT_P_NICE            (1u&lt;&lt;15)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_PUSH            (1u&=
lt;&lt;16)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
PT_P_INSTANCE        (1u&lt;&lt;17) /**&lt; allowed in ccd, client-connect =
etc*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
CONFIG          (1u&lt;&lt;18)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OPT_P_EXPLICIT_NOTIFY (1u&lt;&lt;19)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ECHO            (1u&lt;&l=
t;20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
INHERIT         (1u&lt;&lt;21)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OPT_P_ROUTE_EXTRAS    (1u&lt;&lt;22)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_PULL_MODE       (1u&lt;&l=
t;23)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
PLUGIN          (1u&lt;&lt;24)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OPT_P_SOCKBUF         (1u&lt;&lt;25)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_SOCKFLAGS       (1u&lt;&l=
t;26)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
CONNECTION      (1u&lt;&lt;27)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OPT_P_PEER_ID         (1u&lt;&lt;28)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_INLINE          (1u&lt;&l=
t;29)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
PUSH_MTU        (1u&lt;&lt;30)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OPT_P_ROUTE_TABLE     (1u&lt;&lt;31)</span><br><span> </=
span><br><span> #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1106?usp=3Demail">change 1106</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1106?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d27cb81d32058e40147e1d6dcd=
12df7f6cb2b30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1106 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--D4bHme9u6dg=--


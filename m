From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 5 Feb 2025 11:12:09 +0000
In-Reply-To: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
References: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <e5cb5d6cd4977f60bba387e0b4028338dfd92673-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9ow5rjB6g8w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-win: disable dco
 in server mode if multiple --local options defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9ow5rjB6g8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: dco-win: disable dco in server mode if multiple --local opt=
ions defined
......................................................................

dco-win: disable dco in server mode if multiple --local options defined

dco-win doesn't yet support multisocket, so for the time
being we have to fallback to tap-windows6.

Change-Id: I8724eda269b816dd2cfd0833d467e6d24054e96f
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
1 file changed, 12 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/885/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b5a2136..c65aece 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -279,6 +279,12 @@
         msg(msglevel, "NOTE: --remote is not defined. This DCO version doe=
sn't support multipeer. Disabling Data Channel Offload");
         return false;
     }
+
+    if ((mode =3D=3D MODE_SERVER) && (ce->local_list->len > 1))
+    {
+        msg(msglevel, "NOTE: multiple --local options defined, disabling d=
ata channel offload");
+        return false;
+    }
 #endif

     return true;
@@ -355,6 +361,12 @@
         return false;
     }
=20
+    if ((o->mode =3D=3D MODE_SERVER) && o->ce.local_list->len > 1)
+    {
+        msg(msglevel, "multiple --local options defined, disabling data ch=
annel offload");
+        return false;
+    }
+
 #elif defined(TARGET_LINUX)
     /* if the device name is fixed, we need to check if an interface with =
this
      * name already exists. IF it does, it must be a DCO interface, otherw=
ise

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8724eda269b816dd2cfd0833d467e6d24054e96f
Gerrit-Change-Number: 885
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--9ow5rjB6g8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">dco-win: disable dco in=
 server mode if multiple --local options defined<br><br>dco-win doesn&#39;t=
 yet support multisocket, so for the time<br>being we have to fallback to t=
ap-windows6.<br><br>Change-Id: I8724eda269b816dd2cfd0833d467e6d24054e96f<br=
>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/=
dco.c<br>1 file changed, 12 insertions(+), 0 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/885/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index b5a213=
6..c65aece 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+=
++ b/src/openvpn/dco.c</span><br><span>@@ -279,6 +279,12 @@</span><br><span=
>         msg(msglevel, &quot;NOTE: --remote is not defined. This DCO versi=
on doesn&#39;t support multipeer. Disabling Data Channel Offload&quot;);</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if ((mode =3D=3D MODE_SERVER) &amp;&amp; (ce-&gt;l=
ocal_list-&gt;len &gt; 1))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(msglevel, &quot;NOTE: multiple --local options defined, disabling data=
 channel offload&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> #endif</span><br><span> </span><br><span>    =
 return true;</span><br><span>@@ -355,6 +361,12 @@</span><br><span>        =
 return false;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if ((o-&gt;mode =3D=3D MODE_SERVER)=
 &amp;&amp; o-&gt;ce.local_list-&gt;len &gt; 1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(msglevel, &quot;multiple --local options defined,=
 disabling data channel offload&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #elif defined(TARGET_LINUX)</span><br><span>     =
/* if the device name is fixed, we need to check if an interface with this<=
/span><br><span>      * name already exists. IF it does, it must be a DCO i=
nterface, otherwise</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail">change 885</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/885?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8724eda269b816dd2cfd0833d46=
7e6d24054e96f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 885 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9ow5rjB6g8w=--


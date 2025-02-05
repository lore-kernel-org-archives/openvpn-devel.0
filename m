From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 5 Feb 2025 12:40:07 +0000
In-Reply-To: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
References: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <9eda70cd2216fa1f7b9e77dbacd57953f9595103-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="inaYJW47ARU="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--inaYJW47ARU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/88=
5?usp=3Demail )

Change subject: dco-win: disable dco in server mode if multiple --local opt=
ions defined
......................................................................

dco-win: disable dco in server mode if multiple --local options defined

dco-win doesn't yet support multisocket, so for the time
being we have to fallback to tap-windows6.

Change-Id: I8724eda269b816dd2cfd0833d467e6d24054e96f
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250205122341.4944-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
805.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
1 file changed, 12 insertions(+), 0 deletions(-)




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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--inaYJW47ARU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/885?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco-win: disable dco in server mode if multipl=
e --local options defined<br><br>dco-win doesn&#39;t yet support multisocke=
t, so for the time<br>being we have to fallback to tap-windows6.<br><br>Cha=
nge-Id: I8724eda269b816dd2cfd0833d467e6d24054e96f<br>Signed-off-by: Lev Sti=
pakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&g=
t;<br>Message-Id: &lt;20250205122341.4944-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30805.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/dco.c<br>1 file changed, 12 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 b5a2136..c65aece 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -279,6 +279,12 @@</span><b=
r><span>         msg(msglevel, &quot;NOTE: --remote is not defined. This DC=
O version doesn&#39;t support multipeer. Disabling Data Channel Offload&quo=
t;);</span><br><span>         return false;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if ((mode =3D=3D MODE_SERVER) &amp;&amp; (c=
e-&gt;local_list-&gt;len &gt; 1))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(msglevel, &quot;NOTE: multiple --local options defined, disabli=
ng data channel offload&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span> #endif</span><br><span> </span><br><sp=
an>     return true;</span><br><span>@@ -355,6 +361,12 @@</span><br><span> =
        return false;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if ((o-&gt;mode =3D=3D MODE_=
SERVER) &amp;&amp; o-&gt;ce.local_list-&gt;len &gt; 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(msglevel, &quot;multiple --local options d=
efined, disabling data channel offload&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> #elif defined(TARGET_LINUX)</span><br><spa=
n>     /* if the device name is fixed, we need to check if an interface wit=
h this</span><br><span>      * name already exists. IF it does, it must be =
a DCO interface, otherwise</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail">change=
 885</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8724eda269b816dd2cfd0833d46=
7e6d24054e96f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 885 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--inaYJW47ARU=--


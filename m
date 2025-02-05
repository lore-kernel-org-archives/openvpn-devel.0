From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 5 Feb 2025 10:22:20 +0000
References: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <81c32319238aa478129db7cd3d88f7293e6ff81f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kMmc7gtdW2Y="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kMmc7gtdW2Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/885/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b5a2136..3f0b1cd 100644
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
+        msg(msglevel, "multiple --local options defined, disabling data ch=
annel offload");
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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kMmc7gtdW2Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: disable dco in server mode if multiple --local optio=
ns defined<br><br>dco-win doesn&#39;t yet support multisocket, so for the t=
ime<br>being we have to fallback to tap-windows6.<br><br>Change-Id: I8724ed=
a269b816dd2cfd0833d467e6d24054e96f<br>Signed-off-by: Lev Stipakov &lt;lev@...220...=
..515...&gt;<br>---<br>M src/openvpn/dco.c<br>1 file changed, 12 insertions=
(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/85/885/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openv=
pn/dco.c</span><br><span>index b5a2136..3f0b1cd 100644</span><br><span>--- =
a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span=
>@@ -279,6 +279,12 @@</span><br><span>         msg(msglevel, &quot;NOTE: --=
remote is not defined. This DCO version doesn&#39;t support multipeer. Disa=
bling Data Channel Offload&quot;);</span><br><span>         return false;</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((mode =3D=
=3D MODE_SERVER) &amp;&amp; (ce-&gt;local_list-&gt;len &gt; 1))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;multiple --local =
options defined, disabling data channel offload&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif</span><=
br><span> </span><br><span>     return true;</span><br><span>@@ -355,6 +361=
,12 @@</span><br><span>         return false;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
(o-&gt;mode =3D=3D MODE_SERVER) &amp;&amp; o-&gt;ce.local_list-&gt;len &gt;=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;mu=
ltiple --local options defined, disabling data channel offload&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(TARG=
ET_LINUX)</span><br><span>     /* if the device name is fixed, we need to c=
heck if an interface with this</span><br><span>      * name already exists.=
 IF it does, it must be a DCO interface, otherwise</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/885?usp=3Demail">change 885</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/885?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8724eda269b816dd2cfd0833d46=
7e6d24054e96f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 885 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--kMmc7gtdW2Y=--


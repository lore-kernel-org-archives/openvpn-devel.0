From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 18 May 2025 17:05:14 +0000
In-Reply-To: <gerrit.1742977449000.Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc@...2715...>
References: <gerrit.1742977449000.Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2c291b39076ef5376681010c4e318f61f7194b42-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="awuok72pyuU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 Explicit-exit-notify and multisocket interaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--awuok72pyuU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has uploaded a new patch set (#2) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/917?usp=3Demail )


Change subject: Explicit-exit-notify and multisocket interaction
......................................................................

Explicit-exit-notify and multisocket interaction

Check signals after timeout handling to avoid
unusual delay when using explicit-exit-notify.

Github: fixes OpenVPN/openvpn#702

Change-Id: Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/multi.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/917/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a673ec1..8e2c4d4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4265,13 +4265,13 @@
         {
             /* process the I/O which triggered select */
             multi_io_process_io(multi);
-            MULTI_CHECK_SIG(multi);
         }
         else if (status =3D=3D 0)
         {
             multi_io_action(multi, NULL, TA_TIMEOUT, false);
         }

+        MULTI_CHECK_SIG(multi);
         perf_pop();
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/917?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc
Gerrit-Change-Number: 917
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--awuok72pyuU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
917?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Explicit-exit-notify and multisocket inter=
action<br><br>Check signals after timeout handling to avoid<br>unusual dela=
y when using explicit-exit-notify.<br><br>Github: fixes OpenVPN/openvpn#702=
<br><br>Change-Id: Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc<br>Signed-off-=
by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openv=
pn/multi.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/917/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index =
a673ec1..8e2c4d4 100644</span><br><span>--- a/src/openvpn/multi.c</span><br=
><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -4265,13 +4265,13 @@</s=
pan><br><span>         {</span><br><span>             /* process the I/O wh=
ich triggered select */</span><br><span>             multi_io_process_io(mu=
lti);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MULT=
I_CHECK_SIG(multi);</span><br><span>         }</span><br><span>         els=
e if (status =3D=3D 0)</span><br><span>         {</span><br><span>         =
    multi_io_action(multi, NULL, TA_TIMEOUT, false);</span><br><span>      =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MULTI_CHECK_SIG(multi);</span><br><span>         perf_pop();</sp=
an><br><span>     }</span><br><span> }</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/917?usp=3De=
mail">change 917</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/917?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id9dbb4d3c550bd4c13f6ee97e67=
749686457d9fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 917 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--awuok72pyuU=--


From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 08:24:13 +0000
References: <gerrit.1742977449000.Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f4598c685c3aa7748b04ff4a56e6662bda4f37d4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1uwaJ7+f9pY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1uwaJ7+f9pY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/917?usp=3Demail

to review the following change.


Change subject: Explicit-exit-notify and multisocket interaction
......................................................................

Explicit-exit-notify and multisocket interaction

Check signals after timeout handling to avoid
unusual delay when using explicit-exit-notify.

Github: #702

Change-Id: Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/multi.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/917/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--1uwaJ7+f9pY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/917?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Explicit-exit-notify and multisocket interaction<br><br>Check=
 signals after timeout handling to avoid<br>unusual delay when using explic=
it-exit-notify.<br><br>Github: #702<br><br>Change-Id: Id9dbb4d3c550bd4c13f6=
ee97e67749686457d9fc<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...220...=
..2726...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/17/917/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/ope=
nvpn/multi.c</span><br><span>index a673ec1..8e2c4d4 100644</span><br><span>=
--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><=
br><span>@@ -4265,13 +4265,13 @@</span><br><span>         {</span><br><span=
>             /* process the I/O which triggered select */</span><br><span>=
             multi_io_process_io(multi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            MULTI_CHECK_SIG(multi);</span><br><span>    =
     }</span><br><span>         else if (status =3D=3D 0)</span><br><span> =
        {</span><br><span>             multi_io_action(multi, NULL, TA_TIME=
OUT, false);</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        MULTI_CHECK_SIG(multi);</span=
><br><span>         perf_pop();</span><br><span>     }</span><br><span> }</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/917?usp=3Demail">change 917</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/917?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id9dbb4d3c550bd4c13f6ee97e67=
749686457d9fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 917 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--1uwaJ7+f9pY=--


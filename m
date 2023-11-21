From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 11:01:09 +0000
In-Reply-To: <gerrit.1700480231000.I1141eb7740d8900ed4af0ff5ff52aa3659df99aa@...2715...>
References: <gerrit.1700480231000.I1141eb7740d8900ed4af0ff5ff52aa3659df99aa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <629755ed2a9544e46a39a6cfa0c01689346a8125-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S//FGMzVv2U="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove unused
 function prototype crypto_adjust_frame_parameters
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

--S//FGMzVv2U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/451?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Remove unused function prototype crypto_adjust_frame_parame=
ters
......................................................................

Remove unused function prototype crypto_adjust_frame_parameters

Change-Id: I1141eb7740d8900ed4af0ff5ff52aa3659df99aa
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231121104037.15307-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
524.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.h
1 file changed, 0 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/451/2

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index c5fd253..9255d38 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -429,12 +429,6 @@
                          struct gc_arena *gc);


-/** Calculate crypto overhead and adjust frame to account for that */
-void crypto_adjust_frame_parameters(struct frame *frame,
-                                    const struct key_type *kt,
-                                    bool packet_id,
-                                    bool packet_id_long_form);
-
 /** Calculate the maximum overhead that our encryption has
  * on a packet. This does not include needed additional buffer size
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/451?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1141eb7740d8900ed4af0ff5ff52aa3659df99aa
Gerrit-Change-Number: 451
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--S//FGMzVv2U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
451?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Remove unused function prototype crypto_adjus=
t_frame_parameters<br><br>Change-Id: I1141eb7740d8900ed4af0ff5ff52aa3659df9=
9aa<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: =
&lt;20231121104037.15307-1-frank@...2641...&gt;<br>URL: https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg27524.html<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/crypto.h<br=
>1 file changed, 0 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/51/451/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index c5fd253..=
9255d38 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+=
++ b/src/openvpn/crypto.h</span><br><span>@@ -429,12 +429,6 @@</span><br><s=
pan>                          struct gc_arena *gc);</span><br><span> </span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Calcu=
late crypto overhead and adjust frame to account for that */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void crypto_adjust_frame_parameters(=
struct frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                   const struct key_type *kt,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
 bool packet_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                               bool packet_id_long_form);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /** Calculate the max=
imum overhead that our encryption has</span><br><span>  * on a packet. This=
 does not include needed additional buffer size</span><br><span>  *</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/451?usp=3Demail">change 451</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/451?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1141eb7740d8900ed4af0ff5ff5=
2aa3659df99aa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 451 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--S//FGMzVv2U=--


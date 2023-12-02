From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 15:56:34 +0000
In-Reply-To: <gerrit.1700694723000.Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d@...2715...>
References: <gerrit.1700694723000.Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c4374f5d050bbf4d04ad9129323d93f15b9c648b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EL1zEhdVe9Q="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix
 check_session_buf_not_used using wrong index
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

--EL1zEhdVe9Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/459?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Fix check_session_buf_not_used using wrong index
......................................................................

Fix check_session_buf_not_used using wrong index

The inner loop used i instead of j when iterating through the buffers.

Since i is always between 0 and 2 and ks->send_reliable->size is
(when it is defined) always 6 (TLS_RELIABLE_N_SEND_BUFFERS) this does not
cause an index of out bounds.  So while the check was not doing anything
really useful with i instead of j, at least it was not crashing or
anything similar.

Noticed-By: Jon Williams (braindead-bf) on Github issue #449
Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231128104359.62967-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
576.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/459/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 400230c..b5d24b5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3207,7 +3207,7 @@

         for (int j =3D 0; j < ks->send_reliable->size; j++)
         {
-            if (ks->send_reliable->array[i].buf.data =3D=3D dataptr)
+            if (ks->send_reliable->array[j].buf.data =3D=3D dataptr)
             {
                 msg(M_INFO, "Warning buffer of freed TLS session is still =
in"
                     " use (session->key[%d].send_reliable->array[%d])",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/459?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d
Gerrit-Change-Number: 459
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--EL1zEhdVe9Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
459?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix check_session_buf_not_used using wrong in=
dex<br><br>The inner loop used i instead of j when iterating through the bu=
ffers.<br><br>Since i is always between 0 and 2 and ks-&gt;send_reliable-&g=
t;size is<br>(when it is defined) always 6 (TLS_RELIABLE_N_SEND_BUFFERS) th=
is does not<br>cause an index of out bounds.  So while the check was not do=
ing anything<br>really useful with i instead of j, at least it was not cras=
hing or<br>anything similar.<br><br>Noticed-By: Jon Williams (braindead-bf)=
 on Github issue #449<br>Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc=
5d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20231128104359.62=
967-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-dev=
el@lists.sourceforge.net/msg27576.html<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 1 inser=
tion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/59/459/2</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/op=
envpn/ssl.c</span><br><span>index 400230c..b5d24b5 100644</span><br><span>-=
-- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><s=
pan>@@ -3207,7 +3207,7 @@</span><br><span> </span><br><span>         for (i=
nt j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(ks-&gt;send_reliable-&gt;array[i].buf.data =3D=3D dataptr)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (ks-&gt;send_reliabl=
e-&gt;array[j].buf.data =3D=3D dataptr)</span><br><span>             {</spa=
n><br><span>                 msg(M_INFO, &quot;Warning buffer of freed TLS =
session is still in&quot;</span><br><span>                     &quot; use (=
session-&gt;key[%d].send_reliable-&gt;array[%d])&quot;,</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/459?usp=3Demail">change 459</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/459?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3d5b4946138df322ebcd9e9e77=
d04328dacbc5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 459 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--EL1zEhdVe9Q=--


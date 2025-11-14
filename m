From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 21:01:15 +0000
In-Reply-To: <gerrit.1762823521000.Ia74a931c703d594bdf8ccada9b783b94608de278@...2715...>
References: <gerrit.1762823521000.Ia74a931c703d594bdf8ccada9b783b94608de278@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <28bef360666cde2f4ba93d83fefe3850cb198af6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dNhwyVXsv1M="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: use saved
 iface index to restore metric
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dNhwyVXsv1M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
63?usp=3Demail )

Change subject: iservice: use saved iface index to restore metric
......................................................................

iservice: use saved iface index to restore metric

When adding block rules, the interface metric of the VPN adapter is
temporarily modified so that an old version of Windows 10 would pick
it up first when looking up stuff via DNS. These metrics are reverted to
the old value when the block is removed.

When reverting them, instead of using the stored interface index where
the original values were read from, we were using the interface index
passed to the service with the wfp block message. That index could
theoretically be different from the one stored, which would result in
the metric being set to the wrong interface.

Reported-by: stephan@...2953...
Change-Id: Ia74a931c703d594bdf8ccada9b783b94608de278
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1363
Message-Id: <20251112215106.14182-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
400.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 5 insertions(+), 5 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0712986..33282c63 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -752,7 +752,7 @@
 }

 static DWORD
-DeleteWfpBlock(const wfp_block_message_t *msg, undo_lists_t *lists)
+DeleteWfpBlock(undo_lists_t *lists)
 {
     DWORD err =3D 0;
     wfp_block_data_t *block_data =3D RemoveListItem(&(*lists)[wfp_block], =
CmpAny, NULL);
@@ -762,11 +762,11 @@
         err =3D delete_wfp_block_filters(block_data->engine);
         if (block_data->metric_v4 >=3D 0)
         {
-            set_interface_metric(msg->iface.index, AF_INET, block_data->me=
tric_v4);
+            set_interface_metric(block_data->index, AF_INET, block_data->m=
etric_v4);
         }
         if (block_data->metric_v6 >=3D 0)
         {
-            set_interface_metric(msg->iface.index, AF_INET6, block_data->m=
etric_v6);
+            set_interface_metric(block_data->index, AF_INET6, block_data->=
metric_v6);
         }
         free(block_data);
     }
@@ -829,7 +829,7 @@
             if (err)
             {
                 /* delete the filters, remove undo item and free interface=
 data */
-                DeleteWfpBlock(msg, lists);
+                DeleteWfpBlock(lists);
                 engine =3D NULL;
             }
         }
@@ -854,7 +854,7 @@
     }
     else
     {
-        return DeleteWfpBlock(msg, lists);
+        return DeleteWfpBlock(lists);
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia74a931c703d594bdf8ccada9b783b94608de278
Gerrit-Change-Number: 1363
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dNhwyVXsv1M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1363?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: use saved iface index to restore metri=
c<br><br>When adding block rules, the interface metric of the VPN adapter i=
s<br>temporarily modified so that an old version of Windows 10 would pick<b=
r>it up first when looking up stuff via DNS. These metrics are reverted to<=
br>the old value when the block is removed.<br><br>When reverting them, ins=
tead of using the stored interface index where<br>the original values were =
read from, we were using the interface index<br>passed to the service with =
the wfp block message. That index could<br>theoretically be different from =
the one stored, which would result in<br>the metric being set to the wrong =
interface.<br><br>Reported-by: stephan@...2953...<br>Change-Id: Ia74a931c70=
3d594bdf8ccada9b783b94608de278<br>Signed-off-by: Heiko Hund &lt;heiko@...2375...=
62...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1363<br>Message-Id: &lt;20251112=
215106.14182-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg34400.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 f=
ile changed, 5 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 0712986..33282c63 100644</span><br><span>--- a/src=
/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactiv=
e.c</span><br><span>@@ -752,7 +752,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-DeleteWfpBlock(const wfp_block_message_t *msg, undo_lists_t *list=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DeleteWfpBlock(un=
do_lists_t *lists)</span><br><span> {</span><br><span>     DWORD err =3D 0;=
</span><br><span>     wfp_block_data_t *block_data =3D RemoveListItem(&amp;=
(*lists)[wfp_block], CmpAny, NULL);</span><br><span>@@ -762,11 +762,11 @@</=
span><br><span>         err =3D delete_wfp_block_filters(block_data-&gt;eng=
ine);</span><br><span>         if (block_data-&gt;metric_v4 &gt;=3D 0)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            set_interface_metric(msg-&gt;iface.index, AF_INET, block_data-=
&gt;metric_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        set_interface_metric(block_data-&gt;index, AF_INET, block_data-&gt;=
metric_v4);</span><br><span>         }</span><br><span>         if (block_d=
ata-&gt;metric_v6 &gt;=3D 0)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            set_interface_metric(msg-&gt;=
iface.index, AF_INET6, block_data-&gt;metric_v6);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            set_interface_metric(block_data-&=
gt;index, AF_INET6, block_data-&gt;metric_v6);</span><br><span>         }</=
span><br><span>         free(block_data);</span><br><span>     }</span><br>=
<span>@@ -829,7 +829,7 @@</span><br><span>             if (err)</span><br><=
span>             {</span><br><span>                 /* delete the filters,=
 remove undo item and free interface data */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                DeleteWfpBlock(msg, lists);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                DeleteWfpBlo=
ck(lists);</span><br><span>                 engine =3D NULL;</span><br><spa=
n>             }</span><br><span>         }</span><br><span>@@ -854,7 +854,=
7 @@</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return Delet=
eWfpBlock(msg, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return DeleteWfpBlock(lists);</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail">change=
 1363</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia74a931c703d594bdf8ccada9b7=
83b94608de278 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1363 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dNhwyVXsv1M=--


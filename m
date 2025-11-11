From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 01:12:04 +0000
References: <gerrit.1762823521000.Ia74a931c703d594bdf8ccada9b783b94608de278@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e16360f969e5d7114f986318b233196f7144a6d3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u5AAdcQb/tg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: use saved
 iface index to restore metric
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

--u5AAdcQb/tg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail

to review the following change.


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
---
M src/openvpnserv/interactive.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1363/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0712986..46274ce 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia74a931c703d594bdf8ccada9b783b94608de278
Gerrit-Change-Number: 1363
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--u5AAdcQb/tg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: use saved iface index to restore =
metric<br><br>When adding block rules, the interface metric of the VPN adap=
ter is<br>temporarily modified so that an old version of Windows 10 would p=
ick<br>it up first when looking up stuff via DNS. These metrics are reverte=
d to<br>the old value when the block is removed.<br><br>When reverting them=
, instead of using the stored interface index where<br>the original values =
were read from, we were using the interface index<br>passed to the service =
with the wfp block message. That index could<br>theoretically be different =
from the one stored, which would result in<br>the metric being set to the w=
rong interface.<br><br>Reported-by: stephan@...2953...<br>Change-Id: Ia74a9=
31c703d594bdf8ccada9b783b94608de278<br>Signed-off-by: Heiko Hund &lt;heiko@=
...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed,=
 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/63/1363/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 0712986..46274ce 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -762,11 +762,11 @@</span><br><span>         err =3D delete_wfp_=
block_filters(block_data-&gt;engine);</span><br><span>         if (block_da=
ta-&gt;metric_v4 &gt;=3D 0)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            set_interface_metric(msg-&gt;i=
face.index, AF_INET, block_data-&gt;metric_v4);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            set_interface_metric(block_data-&gt=
;index, AF_INET, block_data-&gt;metric_v4);</span><br><span>         }</spa=
n><br><span>         if (block_data-&gt;metric_v6 &gt;=3D 0)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   set_interface_metric(msg-&gt;iface.index, AF_INET6, block_data-&gt;metri=
c_v6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
et_interface_metric(block_data-&gt;index, AF_INET6, block_data-&gt;metric_v=
6);</span><br><span>         }</span><br><span>         free(block_data);</=
span><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail">change 136=
3</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1363?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia74a931c703d594bdf8ccada9b7=
83b94608de278 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1363 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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

</body></html>=

--u5AAdcQb/tg=--


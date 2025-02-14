From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 10:30:15 +0000
In-Reply-To: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
References: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <4ff8c3e54ebb6bb8f3d7324dbdce0725da441dc7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2nmjaGUtUqQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 get_default_gateway(): Make sure the get_default_gateway() function n...
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

--2nmjaGUtUqQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: get_default_gateway(): Make sure the get_default_gateway() =
function never receives IPV4_INVALID_ADDR as a destination.
......................................................................

get_default_gateway(): Make sure the get_default_gateway() function never r=
eceives IPV4_INVALID_ADDR as a destination.

Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/898/2

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d895e1c..bc41492 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -655,7 +655,7 @@
         rl->spec.flags |=3D RTSA_DEFAULT_METRIC;
     }

-    get_default_gateway(&rl->rgi, remote_host, ctx);
+    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Gerrit-Change-Number: 898
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--2nmjaGUtUqQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, mrbff, plais=
thos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">get_default_gateway(): Make sure the get_default_gat=
eway() function never receives IPV4_INVALID_ADDR as a destination.<br><br>C=
hange-Id: I02afe6817433ca21aae76671c35151ec6a066933<br>Signed-off-by: Marco=
 Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/route.c<br>1 file c=
hanged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/98/898/2</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/route.c b/src/openvpn/route.c</span><br><span>index d895e1c..bc41492 10064=
4</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openv=
pn/route.c</span><br><span>@@ -655,7 +655,7 @@</span><br><span>         rl-=
&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_default=
_gateway(&amp;rl-&gt;rgi, remote_host, ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    get_default_gateway(&amp;rl-&gt;rgi, remote_ho=
st !=3D IPV4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);</span><br><span=
>     if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</=
span><br><span>         setenv_route_addr(es, &quot;net_gateway&quot;, rl-&=
gt;rgi.gateway.addr, -1);</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail">change =
898</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02afe6817433ca21aae76671c35=
151ec6a066933 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 898 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2nmjaGUtUqQ=--


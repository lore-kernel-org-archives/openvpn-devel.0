From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 08:44:15 +0000
In-Reply-To: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
References: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <6e4e5d63243b0de7dc4bb32b8e7ae5b7381fcbb4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XUnAkv5TVpc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: PUSH_UPDATE server:
 update reporting_addr after ifconfig update
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

--XUnAkv5TVpc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: PUSH_UPDATE server: update reporting_addr after ifconfig up=
date
......................................................................

PUSH_UPDATE server: update reporting_addr after ifconfig update

Update mi->reporting_addr(_ipv6) for status reporting purposes
after sending a PUSH_UPDATE containing an ifconfig(-ipv6) option.

Github: fixes OpenVPN/openvpn#889

Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/multi.c
1 file changed, 6 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1340/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 261209d..2b944667 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4346,6 +4346,7 @@
     multi_unlearn_in_addr_t(m, mi, old_addr);
     mi->context.c2.push_ifconfig_defined =3D false;
     mi->context.c2.push_ifconfig_local =3D 0;
+    mi->reporting_addr =3D 0;
 }

 /* Function to unlearn previous ifconfig-ipv6 of a client in the server mu=
lti_context after a PUSH_UPDATE */
@@ -4358,6 +4359,7 @@
     multi_unlearn_in6_addr(m, mi, old_addr6);
     mi->context.c2.push_ifconfig_ipv6_defined =3D false;
     CLEAR(mi->context.c2.push_ifconfig_ipv6_local);
+    CLEAR(mi->reporting_addr_ipv6);
 }

 /**
@@ -4389,6 +4391,8 @@
         {
             mi->context.c2.push_ifconfig_defined =3D true;
             mi->context.c2.push_ifconfig_local =3D ntohl(new_addr.s_addr);
+            /* set our client's VPN endpoint for status reporting purposes=
 */
+            mi->reporting_addr =3D mi->context.c2.push_ifconfig_local;
         }
     }

@@ -4408,6 +4412,8 @@
         {
             mi->context.c2.push_ifconfig_ipv6_defined =3D true;
             mi->context.c2.push_ifconfig_ipv6_local =3D new_addr6;
+            /* set our client's VPN endpoint for status reporting purposes=
 */
+            mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconfig_ipv6_=
local;
         }
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Gerrit-Change-Number: 1340
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

--XUnAkv5TVpc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">PUSH_U=
PDATE server: update reporting_addr after ifconfig update<br><br>Update mi-=
&gt;reporting_addr(_ipv6) for status reporting purposes<br>after sending a =
PUSH_UPDATE containing an ifconfig(-ipv6) option.<br><br>Github: fixes Open=
VPN/openvpn#889<br><br>Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a=
<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/ope=
nvpn/multi.c<br>1 file changed, 6 insertions(+), 0 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/40/1340/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<=
/span><br><span>index 261209d..2b944667 100644</span><br><span>--- a/src/op=
envpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ =
-4346,6 +4346,7 @@</span><br><span>     multi_unlearn_in_addr_t(m, mi, old_=
addr);</span><br><span>     mi-&gt;context.c2.push_ifconfig_defined =3D fal=
se;</span><br><span>     mi-&gt;context.c2.push_ifconfig_local =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;reporting_addr=
 =3D 0;</span><br><span> }</span><br><span> </span><br><span> /* Function t=
o unlearn previous ifconfig-ipv6 of a client in the server multi_context af=
ter a PUSH_UPDATE */</span><br><span>@@ -4358,6 +4359,7 @@</span><br><span>=
     multi_unlearn_in6_addr(m, mi, old_addr6);</span><br><span>     mi-&gt;=
context.c2.push_ifconfig_ipv6_defined =3D false;</span><br><span>     CLEAR=
(mi-&gt;context.c2.push_ifconfig_ipv6_local);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    CLEAR(mi-&gt;reporting_addr_ipv6);</span><br>=
<span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -4389,6 =
+4391,8 @@</span><br><span>         {</span><br><span>             mi-&gt;c=
ontext.c2.push_ifconfig_defined =3D true;</span><br><span>             mi-&=
gt;context.c2.push_ifconfig_local =3D ntohl(new_addr.s_addr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* set our client&#39=
;s VPN endpoint for status reporting purposes */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            mi-&gt;reporting_addr =3D mi-&gt;c=
ontext.c2.push_ifconfig_local;</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>@@ -4408,6 +4412,8 @@</span><br><sp=
an>         {</span><br><span>             mi-&gt;context.c2.push_ifconfig_=
ipv6_defined =3D true;</span><br><span>             mi-&gt;context.c2.push_=
ifconfig_ipv6_local =3D new_addr6;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* set our client&#39;s VPN endpoint for status =
reporting purposes */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfi=
g_ipv6_local;</span><br><span>         }</span><br><span>     }</span><br><=
span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail">change 1340</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie15977b44091445b9d1edebe885=
d92ec5cb5770a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1340 </div>
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

</body></html>=

--XUnAkv5TVpc=--


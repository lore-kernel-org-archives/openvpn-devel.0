From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 09:11:25 +0000
In-Reply-To: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
References: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8b2433e01105018c2d1d4c81ffb8eca1ef3b8154-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fBPZHDAC7i4="; charset=UTF-8
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
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fBPZHDAC7i4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
40?usp=3Demail )

Change subject: PUSH_UPDATE server: update reporting_addr after ifconfig up=
date
......................................................................

PUSH_UPDATE server: update reporting_addr after ifconfig update

Update mi->reporting_addr(_ipv6) for status reporting purposes
after sending a PUSH_UPDATE containing an ifconfig(-ipv6) option.

Github: fixes OpenVPN/openvpn#889

Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Signed-off-by: Marco Baffo <marco@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1340
Message-Id: <20251104085553.8218-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
186.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 6 insertions(+), 0 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Gerrit-Change-Number: 1340
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fBPZHDAC7i4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1340?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">PUSH_UPDATE server: update reporting_addr after =
ifconfig update<br><br>Update mi-&gt;reporting_addr(_ipv6) for status repor=
ting purposes<br>after sending a PUSH_UPDATE containing an ifconfig(-ipv6) =
option.<br><br>Github: fixes OpenVPN/openvpn#889<br><br>Change-Id: Ie15977b=
44091445b9d1edebe885d92ec5cb5770a<br>Signed-off-by: Marco Baffo &lt;marco@...220...=
..2726...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1340<br=
>Message-Id: &lt;20251104085553.8218-1-gert@...1296...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34186.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/=
multi.c<br>1 file changed, 6 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex 261209d..2b944667 100644</span><br><span>--- a/src/openvpn/multi.c</sp=
an><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -4346,6 +4346,7 @=
@</span><br><span>     multi_unlearn_in_addr_t(m, mi, old_addr);</span><br>=
<span>     mi-&gt;context.c2.push_ifconfig_defined =3D false;</span><br><sp=
an>     mi-&gt;context.c2.push_ifconfig_local =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;reporting_addr =3D 0;</span><b=
r><span> }</span><br><span> </span><br><span> /* Function to unlearn previo=
us ifconfig-ipv6 of a client in the server multi_context after a PUSH_UPDAT=
E */</span><br><span>@@ -4358,6 +4359,7 @@</span><br><span>     multi_unlea=
rn_in6_addr(m, mi, old_addr6);</span><br><span>     mi-&gt;context.c2.push_=
ifconfig_ipv6_defined =3D false;</span><br><span>     CLEAR(mi-&gt;context.=
c2.push_ifconfig_ipv6_local);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    CLEAR(mi-&gt;reporting_addr_ipv6);</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span>@@ -4389,6 +4391,8 @@</span=
><br><span>         {</span><br><span>             mi-&gt;context.c2.push_i=
fconfig_defined =3D true;</span><br><span>             mi-&gt;context.c2.pu=
sh_ifconfig_local =3D ntohl(new_addr.s_addr);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* set our client&#39;s VPN endpoint =
for status reporting purposes */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mi-&gt;reporting_addr =3D mi-&gt;context.c2.push_i=
fconfig_local;</span><br><span>         }</span><br><span>     }</span><br>=
<span> </span><br><span>@@ -4408,6 +4412,8 @@</span><br><span>         {</s=
pan><br><span>             mi-&gt;context.c2.push_ifconfig_ipv6_defined =3D=
 true;</span><br><span>             mi-&gt;context.c2.push_ifconfig_ipv6_lo=
cal =3D new_addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* set our client&#39;s VPN endpoint for status reporting purpos=
es */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi=
-&gt;reporting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfig_ipv6_local;</s=
pan><br><span>         }</span><br><span>     }</span><br><span> }</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1340?usp=3Demail">change 1340</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1340?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie15977b44091445b9d1edebe885=
d92ec5cb5770a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1340 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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

</body></html>=

--fBPZHDAC7i4=--


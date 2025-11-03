From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 10:34:01 +0000
References: <gerrit.1762166039000.Ie15977b44091445b9d1edebe885d92ec5cb5770a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <17ae18062d74cfdce04ffb5840d86db2bb1735ac-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GYS65X6cXRc="; charset=UTF-8
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

--GYS65X6cXRc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail

to review the following change.


Change subject: PUSH_UPDATE server: update reporting_addr after ifconfig up=
date
......................................................................

PUSH_UPDATE server: update reporting_addr after ifconfig update

Update mi->reporting_addr(_ipv6) for staus reporting purposes
after sending a PUSH_UPDATE containing an ifconfig(-ipv6) option.

Github: fixes OpenVPN/openvpn#889

Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/multi.c
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1340/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie15977b44091445b9d1edebe885d92ec5cb5770a
Gerrit-Change-Number: 1340
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--GYS65X6cXRc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1340?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">PUSH_UPDATE server: update reporting_addr a=
fter ifconfig update<br><br>Update mi-&gt;reporting_addr(_ipv6) for staus r=
eporting purposes<br>after sending a PUSH_UPDATE containing an ifconfig(-ip=
v6) option.<br><br>Github: fixes OpenVPN/openvpn#889<br><br>Change-Id: Ie15=
977b44091445b9d1edebe885d92ec5cb5770a<br>Signed-off-by: Marco Baffo &lt;mar=
co@...2726...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 6 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/40/1340/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 261209d..2b94466=
7 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/sr=
c/openvpn/multi.c</span><br><span>@@ -4346,6 +4346,7 @@</span><br><span>   =
  multi_unlearn_in_addr_t(m, mi, old_addr);</span><br><span>     mi-&gt;con=
text.c2.push_ifconfig_defined =3D false;</span><br><span>     mi-&gt;contex=
t.c2.push_ifconfig_local =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mi-&gt;reporting_addr =3D 0;</span><br><span> }</span><br><=
span> </span><br><span> /* Function to unlearn previous ifconfig-ipv6 of a =
client in the server multi_context after a PUSH_UPDATE */</span><br><span>@=
@ -4358,6 +4359,7 @@</span><br><span>     multi_unlearn_in6_addr(m, mi, old=
_addr6);</span><br><span>     mi-&gt;context.c2.push_ifconfig_ipv6_defined =
=3D false;</span><br><span>     CLEAR(mi-&gt;context.c2.push_ifconfig_ipv6_=
local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mi=
-&gt;reporting_addr_ipv6);</span><br><span> }</span><br><span> </span><br><=
span> /**</span><br><span>@@ -4389,6 +4391,8 @@</span><br><span>         {<=
/span><br><span>             mi-&gt;context.c2.push_ifconfig_defined =3D tr=
ue;</span><br><span>             mi-&gt;context.c2.push_ifconfig_local =3D =
ntohl(new_addr.s_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* set our client&#39;s VPN endpoint for status reporting p=
urposes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;reporting_addr =3D mi-&gt;context.c2.push_ifconfig_local;</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n>@@ -4408,6 +4412,8 @@</span><br><span>         {</span><br><span>        =
     mi-&gt;context.c2.push_ifconfig_ipv6_defined =3D true;</span><br><span=
>             mi-&gt;context.c2.push_ifconfig_ipv6_local =3D new_addr6;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* set our =
client&#39;s VPN endpoint for status reporting purposes */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;reporting_addr_ip=
v6 =3D mi-&gt;context.c2.push_ifconfig_ipv6_local;</span><br><span>        =
 }</span><br><span>     }</span><br><span> }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1340?=
usp=3Demail">change 1340</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1340?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie15977b44091445b9d1edebe885=
d92ec5cb5770a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1340 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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

--GYS65X6cXRc=--


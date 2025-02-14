From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 10:08:42 +0000
References: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0dba758edd244d445ee3d428b13cb034333ba62b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="keNDuZrOi4Q="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 get_dafault_gateway(): Make sure the get_default_gateway() function n...
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

--keNDuZrOi4Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail

to review the following change.


Change subject: get_dafault_gateway(): Make sure the get_default_gateway() =
function never receives IPV4_INVALID_ADDR as a destination.
......................................................................

get_dafault_gateway(): Make sure the get_default_gateway() function never r=
eceives IPV4_INVALID_ADDR as a destination.

Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/options.c
M src/openvpn/route.c
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/898/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 218d8a6..8b7fee4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5872,7 +5872,7 @@
             get_ipv6_addr(p[1], &remote_ipv6, NULL, M_WARN);
         }
         net_ctx_init(NULL, &net_ctx);
-        get_default_gateway(&rgi, remote_ipv4, &net_ctx);
+        get_default_gateway(&rgi, remote_ipv4 !=3D IPV4_INVALID_ADDR ? rem=
ote_ipv4 : INADDR_ANY, &net_ctx);
         get_default_gateway_ipv6(&rgi6, &remote_ipv6, &net_ctx);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
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
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--keNDuZrOi4Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">get_dafault_gateway(): Make sure the get_default_gateway() fu=
nction never receives IPV4_INVALID_ADDR as a destination.<br><br>Change-Id:=
 I02afe6817433ca21aae76671c35151ec6a066933<br>Signed-off-by: Marco Baffo &l=
t;marco@...2726...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/r=
oute.c<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/898/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>ind=
ex 218d8a6..8b7fee4 100644</span><br><span>--- a/src/openvpn/options.c</spa=
n><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5872,7 +5872,7 =
@@</span><br><span>             get_ipv6_addr(p[1], &amp;remote_ipv6, NULL,=
 M_WARN);</span><br><span>         }</span><br><span>         net_ctx_init(=
NULL, &amp;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       get_default_gateway(&amp;rgi, remote_ipv4, &amp;net_ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        get_default_gateway(&a=
mp;rgi, remote_ipv4 !=3D IPV4_INVALID_ADDR ? remote_ipv4 : INADDR_ANY, &amp=
;net_ctx);</span><br><span>         get_default_gateway_ipv6(&amp;rgi6, &am=
p;remote_ipv6, &amp;net_ctx);</span><br><span>         print_default_gatewa=
y(M_INFO, &amp;rgi, &amp;rgi6);</span><br><span>         openvpn_exit(OPENV=
PN_EXIT_STATUS_GOOD); /* exit point */</span><br><span>diff --git a/src/ope=
nvpn/route.c b/src/openvpn/route.c</span><br><span>index d895e1c..bc41492 1=
00644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/o=
penvpn/route.c</span><br><span>@@ -655,7 +655,7 @@</span><br><span>        =
 rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_def=
ault_gateway(&amp;rl-&gt;rgi, remote_host, ctx);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    get_default_gateway(&amp;rl-&gt;rgi, remot=
e_host !=3D IPV4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);</span><br><=
span>     if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>    =
 {</span><br><span>         setenv_route_addr(es, &quot;net_gateway&quot;, =
rl-&gt;rgi.gateway.addr, -1);</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail">cha=
nge 898</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02afe6817433ca21aae76671c35=
151ec6a066933 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 898 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--keNDuZrOi4Q=--


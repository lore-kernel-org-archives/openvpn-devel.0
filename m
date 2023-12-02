From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 15:31:17 +0000
In-Reply-To: <gerrit.1701361470000.Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c@...2715...>
References: <gerrit.1701361470000.Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e99f6600eb2cdfd70375f9d35f524c9ef4b8fafb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="29Udg5b8S7w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove
 TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--29Udg5b8S7w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/46=
3?usp=3Demail )

Change subject: Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gat=
eway
......................................................................

Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gateway

This debug code is not very useful as it is outdated and the same
functionality is provided by --show-gateway

Change-Id: Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231201111717.14940-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
624.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 0 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ca42c92..9972ed7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -880,17 +880,6 @@
     return false;
 #endif

-#ifdef TEST_GET_DEFAULT_GATEWAY
-    {
-        struct route_gateway_info rgi;
-        struct route_ipv6_gateway_info rgi6;
-        get_default_gateway(&rgi);
-        get_default_gateway_ipv6(&rgi6, NULL);
-        print_default_gateway(M_INFO, &rgi, &rgi6);
-        return false;
-    }
-#endif
-
 #ifdef GEN_PATH_TEST
     {
         struct gc_arena gc =3D gc_new();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/463?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c
Gerrit-Change-Number: 463
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--29Udg5b8S7w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/463?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove TEST_GET_DEFAULT_GATEWAY as it duplicat=
es --show-gateway<br><br>This debug code is not very useful as it is outdat=
ed and the same<br>functionality is provided by --show-gateway<br><br>Chang=
e-Id: Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Message-Id: &lt;20231201111717.14940-1-frank@...2641...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
624.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/init.c<br>1 file changed, 0 insertions(+), 11 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex ca42c92..9972ed7 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -880,17 +880,6 @@</spa=
n><br><span>     return false;</span><br><span> #endif</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef TEST_GET_DEFAULT_=
GATEWAY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct route_gateway_i=
nfo rgi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t route_ipv6_gateway_info rgi6;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        get_default_gateway(&amp;rgi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        get_default_gateway_ipv6(&amp;rgi6, NULL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_defau=
lt_gateway(M_INFO, &amp;rgi, &amp;rgi6);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #ifdef GEN_PATH_TEST</span><br><span>     {</span><br><span>         =
struct gc_arena gc =3D gc_new();</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/463?usp=3Demail">=
change 463</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/463?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7fd59cc84e2eb024086c28c2ec=
2a5606a2b2e7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 463 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--29Udg5b8S7w=--


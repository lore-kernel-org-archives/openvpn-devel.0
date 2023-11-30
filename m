From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 30 Nov 2023 16:24:38 +0000
References: <gerrit.1701361470000.Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0768d158f9982da5613e353a86618e05d8cf656c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Detvh9z1i/I="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Detvh9z1i/I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/463?usp=3Demail

to review the following change.


Change subject: Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gat=
eway
......................................................................

Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gateway

This debug code is not very useful as it is outdated and the same
functionality is provided by --show-gateway

Change-Id: Ie7fd59cc84e2eb024086c28c2ec2a5606a2b2e7c
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
1 file changed, 0 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/463/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index abba748..fdab26b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -885,17 +885,6 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Detvh9z1i/I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/463?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gatew=
ay<br><br>This debug code is not very useful as it is outdated and the same=
<br>functionality is provided by --show-gateway<br><br>Change-Id: Ie7fd59cc=
84e2eb024086c28c2ec2a5606a2b2e7c<br>Signed-off-by: Arne Schwabe &lt;arne@...1186...=
.1227...&gt;<br>---<br>M src/openvpn/init.c<br>1 file changed, 0 insertions=
(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/63/463/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/ope=
nvpn/init.c</span><br><span>index abba748..fdab26b 100644</span><br><span>-=
-- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br>=
<span>@@ -885,17 +885,6 @@</span><br><span>     return false;</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef TEST_GET_DEFAULT_GATEWAY</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        struct route_gateway_info rgi;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct route_ipv6_gateway_info rgi6;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        get_default_gateway(&amp;r=
gi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        get_defau=
lt_gateway_ipv6(&amp;rgi6, NULL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        print_default_gateway(M_INFO, &amp;rgi, &amp;rgi6);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> #ifdef GEN_PATH_TEST</span><br><span> =
    {</span><br><span>         struct gc_arena gc =3D gc_new();</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/463?usp=3Demail">change 463</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/463=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7fd59cc84e2eb024086c28c2ec=
2a5606a2b2e7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 463 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Detvh9z1i/I=--


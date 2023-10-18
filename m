From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 10:38:04 +0000
In-Reply-To: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
References: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d3162b1373bda5d6c1ec83e291df856746b727d5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cIFs5evV4oc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add warning if a p2p
 NCP client connects to a p2mp server
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

--cIFs5evV4oc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add warning if a p2p NCP client connects to a p2mp server
......................................................................

Add warning if a p2p NCP client connects to a p2mp server

Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231009105336.34267-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
191.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
3 files changed, 13 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/323/4

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0d4e6f9..8b490ed 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1811,6 +1811,15 @@
         return false;
     }

+    /* Print a warning if we detect the client being in P2P mode and will
+     * not accept our pushed ciphers */
+    if (proto & IV_PROTO_NCP_P2P)
+    {
+        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--c=
lient"
+            "option). It will not negotiate ciphers with this server. "
+            "Expect this connection to fail.");
+    }
+
     if (proto & IV_PROTO_REQUEST_PUSH)
     {
         c->c2.push_request_received =3D true;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index dafaef1..0ca6d42 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -24,7 +24,7 @@
  */

 /**
- * @file Control Channel SSL/Data dynamic negotion Module
+ * @file Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.c to be able to unit test it.
  */

@@ -258,8 +258,8 @@

     const char *peer_ncp_list =3D tls_peer_ncp_list(peer_info, &gc_tmp);

-    /* non-NCP client without OCC?  "assume nothing" */
-    /* For client doing the newer version of NCP (that send IV_CIPHER)
+    /* non-NCP clients without OCC?  "assume nothing" */
+    /* For client doing the newer version of NCP (that send IV_CIPHERS)
      * we cannot assume that they will accept remote_cipher */
     if (remote_cipher =3D=3D NULL
         || (peer_info && strstr(peer_info, "IV_CIPHERS=3D")))
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index d27ed24..de7a0e4 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -23,7 +23,7 @@
  */

 /**
- * @file Control Channel SSL/Data dynamic negotion Module
+ * @file Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.h to be able to unit test it.
  */


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7
Gerrit-Change-Number: 323
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--cIFs5evV4oc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
323?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add warning if a p2p NCP client connects to a=
 p2mp server<br><br>Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7<br=
>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20=
231009105336.34267-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg27191.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>M src/=
openvpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.h<br>3 files changed, 13 inserti=
ons(+), 4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/23/323/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/=
openvpn/multi.c</span><br><span>index 0d4e6f9..8b490ed 100644</span><br><sp=
an>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</spa=
n><br><span>@@ -1811,6 +1811,15 @@</span><br><span>         return false;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Print a warning if we detect the client being in=
 P2P mode and will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * not accept our pushed ciphers */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (proto &amp; IV_PROTO_NCP_P2P)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Note: peer reports running=
 in P2P mode (no --pull/--client&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;option). It will not negotiate ciphers=
 with this server. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;Expect this connection to fail.&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     if (proto &amp; IV_PROT=
O_REQUEST_PUSH)</span><br><span>     {</span><br><span>         c-&gt;c2.pu=
sh_request_received =3D true;</span><br><span>diff --git a/src/openvpn/ssl_=
ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>index dafaef1..0ca6d42 100644=
</span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/open=
vpn/ssl_ncp.c</span><br><span>@@ -24,7 +24,7 @@</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @file Control Channel SSL/Data dynamic negotion Module</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file Control Channel S=
SL/Data dynamic negotiation Module</span><br><span>  * This file is split f=
rom ssl.c to be able to unit test it.</span><br><span>  */</span><br><span>=
 </span><br><span>@@ -258,8 +258,8 @@</span><br><span> </span><br><span>   =
  const char *peer_ncp_list =3D tls_peer_ncp_list(peer_info, &amp;gc_tmp);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* non-NCP client without OCC?  &quot;assume nothing&quot; */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* For client doing the newer v=
ersion of NCP (that send IV_CIPHER)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* non-NCP clients without OCC?  &quot;assume nothing&q=
uot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* For c=
lient doing the newer version of NCP (that send IV_CIPHERS)</span><br><span=
>      * we cannot assume that they will accept remote_cipher */</span><br>=
<span>     if (remote_cipher =3D=3D NULL</span><br><span>         || (peer_=
info &amp;&amp; strstr(peer_info, &quot;IV_CIPHERS=3D&quot;)))</span><br><s=
pan>diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h</span><br><s=
pan>index d27ed24..de7a0e4 100644</span><br><span>--- a/src/openvpn/ssl_ncp=
.h</span><br><span>+++ b/src/openvpn/ssl_ncp.h</span><br><span>@@ -23,7 +23=
,7 @@</span><br><span>  */</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @file Control Channel SSL/Da=
ta dynamic negotion Module</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @file Control Channel SSL/Data dynamic negotiation Module</span><=
br><span>  * This file is split from ssl.h to be able to unit test it.</spa=
n><br><span>  */</span><br><span> </span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail=
">change 323</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf=
6c38befcaa8a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 323 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--cIFs5evV4oc=--


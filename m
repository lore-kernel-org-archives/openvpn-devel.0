From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 10 Aug 2023 13:51:28 +0000
References: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5b489d868a80cf1c3bb6325df28aa79891c824d5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kP5ANq9ZLWw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kP5ANq9ZLWw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail

to review the following change.


Change subject: Add warning if a p2p NCP client connects to a p2mp server
......................................................................

Add warning if a p2p NCP client connects to a p2mp server

Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7
---
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
2 files changed, 9 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/323/1

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index dafaef1..aae04e2 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -24,7 +24,7 @@
  */

 /**
- * @file Control Channel SSL/Data dynamic negotion Module
+ * @file Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.c to be able to unit test it.
  */

@@ -267,6 +267,13 @@
         remote_cipher =3D "";
     }

+    if (extract_iv_proto(peer_info) & IV_PROTO_NCP_P2P)
+    {
+        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--c=
lient"
+            "option). It will not negotiate ciphers with this server. "
+            "Expect this connection to fail.");
+    }
+
     char *tmp_ciphers =3D string_alloc(server_list, &gc_tmp);

     const char *token;
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kP5ANq9ZLWw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add warning if a p2p NCP client connects to a p2mp server<br>=
<br>Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7<br>---<br>M src/op=
envpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.h<br>2 files changed, 9 insertions=
(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/23/323/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ncp.c b/src/o=
penvpn/ssl_ncp.c</span><br><span>index dafaef1..aae04e2 100644</span><br><s=
pan>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c=
</span><br><span>@@ -24,7 +24,7 @@</span><br><span>  */</span><br><span> </=
span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @file Control Channel SSL/Data dynamic negotion Module</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @file Control Channel SSL/Data dynam=
ic negotiation Module</span><br><span>  * This file is split from ssl.c to =
be able to unit test it.</span><br><span>  */</span><br><span> </span><br><=
span>@@ -267,6 +267,13 @@</span><br><span>         remote_cipher =3D &quot;=
&quot;;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (extract_iv_proto(peer_info) &amp; IV_P=
ROTO_NCP_P2P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;Note: peer reports running in P2P mode (no --pull/--client&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;option=
). It will not negotiate ciphers with this server. &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;Expect this connect=
ion to fail.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     char *tmp_ciphers =3D string_alloc(server_list, &amp;gc_tmp);</spa=
n><br><span> </span><br><span>     const char *token;</span><br><span>diff =
--git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h</span><br><span>index=
 d27ed24..de7a0e4 100644</span><br><span>--- a/src/openvpn/ssl_ncp.h</span>=
<br><span>+++ b/src/openvpn/ssl_ncp.h</span><br><span>@@ -23,7 +23,7 @@</sp=
an><br><span>  */</span><br><span> </span><br><span> /**</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @file Control Channel SSL/Data dynami=
c negotion Module</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @file Control Channel SSL/Data dynamic negotiation Module</span><br><span>=
  * This file is split from ssl.h to be able to unit test it.</span><br><sp=
an>  */</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail">change =
323</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf=
6c38befcaa8a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 323 </div>
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


--kP5ANq9ZLWw=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 12:55:18 +0000
In-Reply-To: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
References: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <580f0d34bd2c961a40e7a92c2f59e78df4fbbaf3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZSWRmrT6D8Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: wfp_block: Avoid
 sign-compare warning with Fwpm* return types
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZSWRmrT6D8Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
06?usp=3Demail )

Change subject: wfp_block: Avoid sign-compare warning with Fwpm* return typ=
es
......................................................................

wfp_block: Avoid sign-compare warning with Fwpm* return types

FWP_E_ALREADY_EXISTS is explictly casted to HRESULT which
is LONG. But Fwpm* return DWORD. So if you compare an expected
result with the actual result you get an sign-compare warning...

Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1506
Message-Id: <20260330113826.20057-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
337.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/wfp_block.c
1 file changed, 1 insertion(+), 10 deletions(-)




diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 74d19ce..4d38fdb 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -131,11 +131,6 @@
     return err;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Block outgoing local traffic, possibly DNS only, except for
  * (i) adapter with the specified index (and loopback, if all is blocked)
@@ -198,7 +193,7 @@
        * do not treat "already exists" as an error */
         err =3D add_sublayer(OPENVPN_WFP_BLOCK_SUBLAYER);

-        if (err =3D=3D FWP_E_ALREADY_EXISTS || err =3D=3D ERROR_SUCCESS)
+        if (err =3D=3D (DWORD)FWP_E_ALREADY_EXISTS || err =3D=3D ERROR_SUC=
CESS)
         {
             msg_handler(0, "WFP Block: Added a persistent sublayer with pr=
e-defined UUID");
         }
@@ -345,10 +340,6 @@
     return err;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 DWORD
 delete_wfp_block_filters(HANDLE engine_handle)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711
Gerrit-Change-Number: 1506
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZSWRmrT6D8Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1506?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">wfp_block: Avoid sign-compare warning with Fwpm*=
 return types<br><br>FWP_E_ALREADY_EXISTS is explictly casted to HRESULT wh=
ich<br>is LONG. But Fwpm* return DWORD. So if you compare an expected<br>re=
sult with the actual result you get an sign-compare warning...<br><br>Chang=
e-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1506<br>Mess=
age-Id: &lt;20260330113826.20057-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36337.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/wfp_=
block.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c</span><br=
><span>index 74d19ce..4d38fdb 100644</span><br><span>--- a/src/openvpn/wfp_=
block.c</span><br><span>+++ b/src/openvpn/wfp_block.c</span><br><span>@@ -1=
31,11 +131,6 @@</span><br><span>     return err;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>=
  * Block outgoing local traffic, possibly DNS only, except for</span><br><=
span>  * (i) adapter with the specified index (and loopback, if all is bloc=
ked)</span><br><span>@@ -198,7 +193,7 @@</span><br><span>        * do not t=
reat &quot;already exists&quot; as an error */</span><br><span>         err=
 =3D add_sublayer(OPENVPN_WFP_BLOCK_SUBLAYER);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (err =3D=3D FWP_E_ALR=
EADY_EXISTS || err =3D=3D ERROR_SUCCESS)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (err =3D=3D (DWORD)FWP_E_ALREADY_EXISTS || =
err =3D=3D ERROR_SUCCESS)</span><br><span>         {</span><br><span>      =
       msg_handler(0, &quot;WFP Block: Added a persistent sublayer with pre=
-defined UUID&quot;);</span><br><span>         }</span><br><span>@@ -345,10=
 +340,6 @@</span><br><span>     return err;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> DWORD</span><br><span> delete_wfp_block_filters(HANDLE engine=
_handle)</span><br><span> {</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail">chan=
ge 1506</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f6502da1832edcb273a0dfa9b3=
ef940bec2d711 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ZSWRmrT6D8Y=--


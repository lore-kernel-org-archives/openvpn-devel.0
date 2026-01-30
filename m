From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:11:15 +0000
References: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <51339f3c253d5ec336468c8db101eec1228b6d13-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WsMugBdgRSg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WsMugBdgRSg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail

to review the following change.


Change subject: wfp_block: Avoid sign-compare warning with Fwpm* return typ=
es
......................................................................

wfp_block: Avoid sign-compare warning with Fwpm* return types

FWP_E_ALREADY_EXISTS is explictly casted to HRESULT which
is LONG. But Fwpm* return DWORD. So if you compare an expected
result with the actual result you get an sign-compare warning...

Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/wfp_block.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1506/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711
Gerrit-Change-Number: 1506
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--WsMugBdgRSg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">wfp_block: Avoid sign-compare warning with =
Fwpm* return types<br><br>FWP_E_ALREADY_EXISTS is explictly casted to HRESU=
LT which<br>is LONG. But Fwpm* return DWORD. So if you compare an expected<=
br>result with the actual result you get an sign-compare warning...<br><br>=
Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/wfp_block.c<=
br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1506/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c</spa=
n><br><span>index 74d19ce..4d38fdb 100644</span><br><span>--- a/src/openvpn=
/wfp_block.c</span><br><span>+++ b/src/openvpn/wfp_block.c</span><br><span>=
@@ -131,11 +131,6 @@</span><br><span>     return err;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><=
span>  * Block outgoing local traffic, possibly DNS only, except for</span>=
<br><span>  * (i) adapter with the specified index (and loopback, if all is=
 blocked)</span><br><span>@@ -198,7 +193,7 @@</span><br><span>        * do =
not treat &quot;already exists&quot; as an error */</span><br><span>       =
  err =3D add_sublayer(OPENVPN_WFP_BLOCK_SUBLAYER);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (err =3D=3D FWP_=
E_ALREADY_EXISTS || err =3D=3D ERROR_SUCCESS)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (err =3D=3D (DWORD)FWP_E_ALREADY_EXIST=
S || err =3D=3D ERROR_SUCCESS)</span><br><span>         {</span><br><span> =
            msg_handler(0, &quot;WFP Block: Added a persistent sublayer wit=
h pre-defined UUID&quot;);</span><br><span>         }</span><br><span>@@ -3=
45,10 +340,6 @@</span><br><span>     return err;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> DWORD</span><br><span> delete_wfp_block_filters(HANDLE e=
ngine_handle)</span><br><span> {</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail"=
>change 1506</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f6502da1832edcb273a0dfa9b3=
ef940bec2d711 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--WsMugBdgRSg=--


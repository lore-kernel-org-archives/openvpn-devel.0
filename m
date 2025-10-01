From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 1 Oct 2025 22:09:53 +0000
In-Reply-To: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
References: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26fccecf222930c3a7b31969a44107ad6456ecf4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N/3cSaUr7e4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: PUSH_UPDATE:
 disabling PUSH_UPDATE server if DCO is enabled
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

--N/3cSaUr7e4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: PUSH_UPDATE: disabling PUSH_UPDATE server if DCO is enabled
......................................................................

PUSH_UPDATE: disabling PUSH_UPDATE server if DCO is enabled

Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push_util.c
1 file changed, 16 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1245/2

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..bbca00f 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -294,10 +294,17 @@
         }                                                             \
     } while (0)

-
 bool
 management_callback_send_push_update_broadcast(void *arg, const char *opti=
ons)
 {
+    struct multi_context *m =3D arg;
+    if (dco_enabled(&m->top.options))
+    {
+        msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent w=
hile DCO is enabled."
+                    " To send a PUSH_UPDATE message, be sure to use the --=
disable-dco option.");
+        return false;
+    }
+
     int n_sent =3D send_push_update(arg, NULL, options, UPT_BROADCAST, PUS=
H_BUNDLE_SIZE);

     RETURN_UPDATE_STATUS(n_sent);
@@ -306,6 +313,14 @@
 bool
 management_callback_send_push_update_by_cid(void *arg, unsigned long cid, =
const char *options)
 {
+    struct multi_context *m =3D arg;
+    if (dco_enabled(&m->top.options))
+    {
+        msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent w=
hile DCO is enabled."
+                    " To send a PUSH_UPDATE message, be sure to use the --=
disable-dco option.");
+        return false;
+    }
+
     int n_sent =3D send_push_update(arg, &cid, options, UPT_BY_CID, PUSH_B=
UNDLE_SIZE);

     RETURN_UPDATE_STATUS(n_sent);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Gerrit-Change-Number: 1245
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--N/3cSaUr7e4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">PUSH_UPDATE: disabling PUSH_=
UPDATE server if DCO is enabled<br><br>Change-Id: Ibe78949435bb2f26ad68301e=
2710321bf37c9486<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>=
---<br>M src/openvpn/push_util.c<br>1 file changed, 16 insertions(+), 1 del=
etion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/45/1245/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push_util.=
c b/src/openvpn/push_util.c</span><br><span>index 9138bdb..bbca00f 100644</=
span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/open=
vpn/push_util.c</span><br><span>@@ -294,10 +294,17 @@</span><br><span>     =
    }                                                             \</span><=
br><span>     } while (0)</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> management_ca=
llback_send_push_update_broadcast(void *arg, const char *options)</span><br=
><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 multi_context *m =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (dco_enabled(&amp;m-&gt;top.options))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;WARN: PUSH_UPDATE messages ca=
nnot currently be sent while DCO is enabled.&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    &quot; To send a PUSH_UP=
DATE message, be sure to use the --disable-dco option.&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     int n_sent =3D send_pu=
sh_update(arg, NULL, options, UPT_BROADCAST, PUSH_BUNDLE_SIZE);</span><br><=
span> </span><br><span>     RETURN_UPDATE_STATUS(n_sent);</span><br><span>@=
@ -306,6 +313,14 @@</span><br><span> bool</span><br><span> management_callb=
ack_send_push_update_by_cid(void *arg, unsigned long cid, const char *optio=
ns)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct multi_context *m =3D arg;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (dco_enabled(&amp;m-&gt;top.options))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARN: PUSH_UPDATE =
messages cannot currently be sent while DCO is enabled.&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    &quot; To sen=
d a PUSH_UPDATE message, be sure to use the --disable-dco option.&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     int n_sent =
=3D send_push_update(arg, &amp;cid, options, UPT_BY_CID, PUSH_BUNDLE_SIZE);=
</span><br><span> </span><br><span>     RETURN_UPDATE_STATUS(n_sent);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1245?usp=3Demail">change 1245</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1245?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe78949435bb2f26ad68301e271=
0321bf37c9486 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1245 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

--N/3cSaUr7e4=--


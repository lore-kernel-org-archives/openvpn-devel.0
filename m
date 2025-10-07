From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 20:03:00 +0000
In-Reply-To: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
References: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <932e6c6a476c6a3b8a16036e8e57bbb574f42b12-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mPUcX6HFqxw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: PUSH_UPDATE:
 disabling PUSH_UPDATE server and client if DCO is enabled
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

--mPUcX6HFqxw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail

to look at the new patch set (#5).


Change subject: PUSH_UPDATE: disabling PUSH_UPDATE server and client if DCO=
 is enabled
......................................................................

PUSH_UPDATE: disabling PUSH_UPDATE server and client if DCO is enabled

The PUSH_UPDATE currently doesn't work with DCO.
For example, in server, if a new ifconfig is sent, the DCO
doesn't receive the new peer address and the connection drops.
Similarly in the client when a PUSH_UPDATE is received, the tun is
closed and reopened but the DCO doesn't receive the peer info.

Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push.c
M src/openvpn/push_util.c
M src/openvpn/ssl.c
3 files changed, 28 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1245/5

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7fc50c..e5f090f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1112,6 +1112,12 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
+        if (dco_enabled(&c->options))
+        {
+            msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be re=
ceived while DCO is enabled, ignoring."
+                        " To receive PUSH_UPDATE messages, be sure to use =
the --disable-dco option.");
+            return PUSH_MSG_ERROR;
+        }
         return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
     }
     else
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..bbca00f 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -294,10 +294,17 @@
         }                                                             \
     } while (0)
=20
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
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 34036f2..567560f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1926,8 +1926,12 @@
         /* support for exit notify via control channel */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;

-        /* support push-updates */
-        iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+        /* currently push-update is not supported when DCO is enabled */
+        if (!session->opt->dco_enabled)
+        {
+            /* support push-updates */
+            iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+        }

         if (session->opt->pull)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Gerrit-Change-Number: 1245
Gerrit-PatchSet: 5
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--mPUcX6HFqxw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">PUSH_UPDATE: disabling PUSH_UPDATE server and client if=
 DCO is enabled<br><br>The PUSH_UPDATE currently doesn&#39;t work with DCO.=
<br>For example, in server, if a new ifconfig is sent, the DCO<br>doesn&#39=
;t receive the new peer address and the connection drops.<br>Similarly in t=
he client when a PUSH_UPDATE is received, the tun is<br>closed and reopened=
 but the DCO doesn&#39;t receive the peer info.<br><br>Change-Id: Ibe789494=
35bb2f26ad68301e2710321bf37c9486<br>Signed-off-by: Marco Baffo &lt;marco@...1186...=
.2726...&gt;<br>---<br>M src/openvpn/push.c<br>M src/openvpn/push_util.c<br=
>M src/openvpn/ssl.c<br>3 files changed, 28 insertions(+), 3 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/45/1245/5</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn=
/push.c</span><br><span>index e7fc50c..e5f090f 100644</span><br><span>--- a=
/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><spa=
n>@@ -1112,6 +1112,12 @@</span><br><span>     }</span><br><span>     else i=
f (honor_received_options &amp;&amp; buf_string_compare_advance(&amp;buf, p=
ush_update_cmd))</span><br><span>     {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (dco_enabled(&amp;c-&gt;options))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARN: PUSH=
_UPDATE messages cannot currently be received while DCO is enabled, ignorin=
g.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             &quot; To receive PUSH_UPDATE messages, be sure to use the --d=
isable-dco option.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return PUSH_MSG_ERROR;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span>         return process_inc=
oming_push_update(c, permission_mask, option_types_found, &amp;buf, false);=
</span><br><span>     }</span><br><span>     else</span><br><span>diff --gi=
t a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>index=
 9138bdb..bbca00f 100644</span><br><span>--- a/src/openvpn/push_util.c</spa=
n><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -294,10 +294,1=
7 @@</span><br><span>         }                                            =
                 \</span><br><span>     } while (0)</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</spa=
n><br><span> management_callback_send_push_update_broadcast(void *arg, cons=
t char *options)</span><br><span> {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct multi_context *m =3D arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;m-&gt;top.option=
s))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARN=
: PUSH_UPDATE messages cannot currently be sent while DCO is enabled.&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot; To send a PUSH_UPDATE message, be sure to use the --disable-dco opt=
ion.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   int n_sent =3D send_push_update(arg, NULL, options, UPT_BROADCAST, PUSH_=
BUNDLE_SIZE);</span><br><span> </span><br><span>     RETURN_UPDATE_STATUS(n=
_sent);</span><br><span>@@ -306,6 +313,14 @@</span><br><span> bool</span><b=
r><span> management_callback_send_push_update_by_cid(void *arg, unsigned lo=
ng cid, const char *options)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct multi_context *m =3D arg;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;m-&gt=
;top.options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,=
 &quot;WARN: PUSH_UPDATE messages cannot currently be sent while DCO is ena=
bled.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            &quot; To send a PUSH_UPDATE message, be sure to use the --disa=
ble-dco option.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     int n_sent =3D send_push_update(arg, &amp;cid, options, UPT_B=
Y_CID, PUSH_BUNDLE_SIZE);</span><br><span> </span><br><span>     RETURN_UPD=
ATE_STATUS(n_sent);</span><br><span>diff --git a/src/openvpn/ssl.c b/src/op=
envpn/ssl.c</span><br><span>index 34036f2..567560f 100644</span><br><span>-=
-- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><s=
pan>@@ -1926,8 +1926,12 @@</span><br><span>         /* support for exit not=
ify via control channel */</span><br><span>         iv_proto |=3D IV_PROTO_=
CC_EXIT_NOTIFY;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* support push-updates */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* currently push-=
update is not supported when DCO is enabled */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!session-&gt;opt-&gt;dco_enabled)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* support push-upda=
tes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
v_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span> </span><br><span>         if (ses=
sion-&gt;opt-&gt;pull)</span><br><span>         {</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1245?usp=3Demail">change 1245</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/124=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe78949435bb2f26ad68301e271=
0321bf37c9486 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1245 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--mPUcX6HFqxw=--


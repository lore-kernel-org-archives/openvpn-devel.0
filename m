From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 08:19:09 +0000
In-Reply-To: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
References: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <f93b7f88b14c197c696aa782b7ac8dda0790d0e9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4rY19HOQ8bM="; charset=UTF-8
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

--4rY19HOQ8bM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail

to look at the new patch set (#6).


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
M tests/unit_tests/openvpn/test_push_update_msg.c
4 files changed, 20 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1245/6

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7fc50c..0c8eb84 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1112,6 +1112,12 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, pu=
sh_update_cmd))
     {
+        if (dco_enabled(&c->options))
+        {
+            msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be pr=
ocessed in client mode while DCO is enabled, ignoring."
+                        " To be able to process PUSH_UPDATE messages, be s=
ure to use the --disable-dco option.");
+            return PUSH_MSG_ERROR;
+        }
         return process_incoming_push_update(c, permission_mask, option_typ=
es_found, &buf, false);
     }
     else
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..f306104 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -191,6 +191,13 @@
 int
 send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size)
 {
+    if (dco_enabled(&m->top.options))
+    {
+        msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent w=
hile DCO is enabled."
+                    " To send a PUSH_UPDATE message, be sure to use the --=
disable-dco option.");
+        return 0;
+    }
+
     if (!msg || !*msg || !m
         || (!target && type !=3D UPT_BROADCAST))
     {
@@ -294,7 +301,6 @@
         }                                                             \
     } while (0)

-
 bool
 management_callback_send_push_update_broadcast(void *arg, const char *opti=
ons)
 {
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
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 8a5beeb..6e49f14 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -465,6 +465,7 @@
     m->instances =3D calloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi =3D calloc(1, sizeof(struct multi_instance));
     *(m->instances) =3D mi;
+    m->top.options.disable_dco =3D true;
     *state =3D m;
     return 0;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Gerrit-Change-Number: 1245
Gerrit-PatchSet: 6
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--4rY19HOQ8bM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #6</strong> to this change.</p><p><a hr=
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
>M src/openvpn/ssl.c<br>M tests/unit_tests/openvpn/test_push_update_msg.c<b=
r>4 files changed, 20 insertions(+), 3 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1245/6<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><spa=
n>index e7fc50c..0c8eb84 100644</span><br><span>--- a/src/openvpn/push.c</s=
pan><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -1112,6 +1112,12 =
@@</span><br><span>     }</span><br><span>     else if (honor_received_opti=
ons &amp;&amp; buf_string_compare_advance(&amp;buf, push_update_cmd))</span=
><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_WARN, &quot;WARN: PUSH_UPDATE messages canno=
t currently be processed in client mode while DCO is enabled, ignoring.&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       &quot; To be able to process PUSH_UPDATE messages, be sure to use th=
e --disable-dco option.&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return PUSH_MSG_ERROR;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span>         return proces=
s_incoming_push_update(c, permission_mask, option_types_found, &amp;buf, fa=
lse);</span><br><span>     }</span><br><span>     else</span><br><span>diff=
 --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>=
index 9138bdb..f306104 100644</span><br><span>--- a/src/openvpn/push_util.c=
</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -191,6 +1=
91,13 @@</span><br><span> int</span><br><span> send_push_update(struct mult=
i_context *m, const void *target, const char *msg, const push_update_type t=
ype, const int push_bundle_size)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;m-&gt;top.option=
s))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARN=
: PUSH_UPDATE messages cannot currently be sent while DCO is enabled.&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot; To send a PUSH_UPDATE message, be sure to use the --disable-dco opt=
ion.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     i=
f (!msg || !*msg || !m</span><br><span>         || (!target &amp;&amp; type=
 !=3D UPT_BROADCAST))</span><br><span>     {</span><br><span>@@ -294,7 +301=
,6 @@</span><br><span>         }                                           =
                  \</span><br><span>     } while (0)</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</sp=
an><br><span> management_callback_send_push_update_broadcast(void *arg, con=
st char *options)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 34036f2..567560f 100644<=
/span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/s=
sl.c</span><br><span>@@ -1926,8 +1926,12 @@</span><br><span>         /* sup=
port for exit notify via control channel */</span><br><span>         iv_pro=
to |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* support push-updates */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        iv_proto |=3D IV_PROTO_PU=
SH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* currently push-update is not supported when DCO is enabled */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!session-&gt;opt-&g=
t;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
support push-updates */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><sp=
an>         if (session-&gt;opt-&gt;pull)</span><br><span>         {</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/te=
sts/unit_tests/openvpn/test_push_update_msg.c</span><br><span>index 8a5beeb=
..6e49f14 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_push_u=
pdate_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update=
_msg.c</span><br><span>@@ -465,6 +465,7 @@</span><br><span>     m-&gt;insta=
nces =3D calloc(1, sizeof(struct multi_instance *));</span><br><span>     s=
truct multi_instance *mi =3D calloc(1, sizeof(struct multi_instance));</spa=
n><br><span>     *(m-&gt;instances) =3D mi;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    m-&gt;top.options.disable_dco =3D true;</span><=
br><span>     *state =3D m;</span><br><span>     return 0;</span><br><span>=
 }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1245?usp=3Demail">change 1245</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1245?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe78949435bb2f26ad68301e271=
0321bf37c9486 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1245 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--4rY19HOQ8bM=--


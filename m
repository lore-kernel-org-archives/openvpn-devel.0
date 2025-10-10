From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 14:43:08 +0000
In-Reply-To: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
References: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <62864071530e460571a86c104f436b1ef436cf78-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nOqOpjfcSGA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: PUSH_UPDATE server:
 check IV_PROTO before sending the message to the ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nOqOpjfcSGA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by ordex, Code-Review+2 by cron2


Change subject: PUSH_UPDATE server: check IV_PROTO before sending the messa=
ge to the client
......................................................................

PUSH_UPDATE server: check IV_PROTO before sending the message to the client

Before sending the PUSH_UPDATE message to the client, we must verify that
the client has actually sent IV_PROTO_PUSH_UPDATE to the server, declaring =
that
it supports push-updates.

Also fixed a gc_arena memory leak in one of the error paths and asserted
mi->context.c2.tls_multi .

Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1255
Message-Id: <20251009182855.18712-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244566/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
2 files changed, 36 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1255/3

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index b475d2e..25c6ebe 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -7,6 +7,7 @@

 #ifdef ENABLE_MANAGEMENT
 #include "multi.h"
+#include "ssl_util.h"
 #endif

 #if defined(__GNUC__) || defined(__clang__)
@@ -177,20 +178,32 @@
         buf_string_compare_advance(&tmp_msg, push_update_cmd);
         if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->peer_id);
             continue;
         }
         c->options.push_option_types_found |=3D *option_types_found;
         if (!options_postprocess_pull(&c->options, c->c2.es))
         {
-            msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u", c->c2.tls_multi->peer_id);
         }
     }
     return true;
 }

+/* Return true if the client supports push-update */
+static bool
+support_push_update(struct multi_instance *mi)
+{
+    ASSERT(mi->context.c2.tls_multi);
+    const unsigned int iv_proto_peer =3D extract_iv_proto(mi->context.c2.t=
ls_multi->peer_info);
+    if (!(iv_proto_peer & IV_PROTO_PUSH_UPDATE))
+    {
+        return false;
+    }
+
+    return true;
+}
+
 int
 send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size)
 {
@@ -231,9 +244,17 @@

         if (!mi)
         {
+            gc_free(&gc);
             return -ENOENT;
         }

+        if (!support_push_update(mi))
+        {
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported=
 peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            gc_free(&gc);
+            return 0;
+        }
+
         const char *old_ip =3D mi->context.options.ifconfig_local;
         const char *old_ipv6 =3D mi->context.options.ifconfig_ipv6_local;
         if (!mi->halt
@@ -262,7 +283,7 @@
     {
         struct multi_instance *curr_mi =3D he->value;

-        if (curr_mi->halt)
+        if (curr_mi->halt || !support_push_update(curr_mi))
         {
             continue;
         }
@@ -273,8 +294,7 @@
         const char *old_ipv6 =3D curr_mi->context.options.ifconfig_ipv6_lo=
cal;
         if (!send_single_push_update(&curr_mi->context, msgs, &option_type=
s_found))
         {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
-                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_=
mi->context.c2.tls_multi->peer_id);
             continue;
         }
         if (option_types_found & OPT_P_UP)
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 6e49f14..60596ed 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -144,7 +144,13 @@
 {
     return true;
 }
-#endif /* ifndef ENABLE_MANAGEMENT */
+
+unsigned int
+extract_iv_proto(const char *peer_info)
+{
+    return IV_PROTO_PUSH_UPDATE;
+}
+#endif /* ifdef ENABLE_MANAGEMENT */

 /* tests */

@@ -464,6 +470,7 @@
     struct multi_context *m =3D calloc(1, sizeof(struct multi_context));
     m->instances =3D calloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi =3D calloc(1, sizeof(struct multi_instance));
+    mi->context.c2.tls_multi =3D calloc(1, sizeof(struct tls_multi));
     *(m->instances) =3D mi;
     m->top.options.disable_dco =3D true;
     *state =3D m;
@@ -474,6 +481,7 @@
 teardown2(void **state)
 {
     struct multi_context *m =3D *state;
+    free((*(m->instances))->context.c2.tls_multi);
     free(*(m->instances));
     free(m->instances);
     free(m);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Gerrit-Change-Number: 1255
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nOqOpjfcSGA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by mrbff.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by ordex, Code-Review+2 by cron2</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">PUSH_UPDATE=
 server: check IV_PROTO before sending the message to the client<br><br>Bef=
ore sending the PUSH_UPDATE message to the client, we must verify that<br>t=
he client has actually sent IV_PROTO_PUSH_UPDATE to the server, declaring t=
hat<br>it supports push-updates.<br><br>Also fixed a gc_arena memory leak i=
n one of the error paths and asserted<br>mi-&gt;context.c2.tls_multi .<br><=
br>Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec<br>Signed-off-by: M=
arco Baffo &lt;marco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1255<br>Me=
ssage-Id: &lt;20251009182855.18712-1-gert@...1296...&gt;<br>URL: https://so=
urceforge.net/p/openvpn/mailman/message/59244566/<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/push_util.c<br>M test=
s/unit_tests/openvpn/test_push_update_msg.c<br>2 files changed, 36 insertio=
ns(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/55/1255/3</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/push_util.c b/src/openvpn/push_util.c</span><br><span>index b475d2e..25c=
6ebe 100644</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+=
++ b/src/openvpn/push_util.c</span><br><span>@@ -7,6 +7,7 @@</span><br><spa=
n> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> #include &qu=
ot;multi.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;ssl_util.h&quot;</span><br><span> #endif</span><br><span> </spa=
n><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span>@@=
 -177,20 +178,32 @@</span><br><span>         buf_string_compare_advance(&am=
p;tmp_msg, push_update_cmd);</span><br><span>         if (process_incoming_=
push_update(c, pull_permission_mask(c), option_types_found, &amp;tmp_msg, t=
rue) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to pr=
ocess push update message sent to client ID: %u&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2.tls_multi ? c-&gt=
;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_WARN, &quot;Failed to process push u=
pdate message sent to client ID: %u&quot;, c-&gt;c2.tls_multi-&gt;peer_id);=
</span><br><span>             continue;</span><br><span>         }</span><b=
r><span>         c-&gt;options.push_option_types_found |=3D *option_types_f=
ound;</span><br><span>         if (!options_postprocess_pull(&amp;c-&gt;opt=
ions, c-&gt;c2.es))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to post-proce=
ss push update message sent to client ID: %u&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2.tls_multi ? c-&gt;=
c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;Failed to post-process pu=
sh update message sent to client ID: %u&quot;, c-&gt;c2.tls_multi-&gt;peer_=
id);</span><br><span>         }</span><br><span>     }</span><br><span>    =
 return true;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Return true if the client supports push-u=
pdate */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+support_push_update=
(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(mi-&gt;context.c2.tls_multi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const unsigned int iv_proto_peer =3D extract_iv_proto(mi-&gt=
;context.c2.tls_multi-&gt;peer_info);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!(iv_proto_peer &amp; IV_PROTO_PUSH_UPDATE))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> int</span><br><span> send_push_update(struct multi_context *m, const voi=
d *target, const char *msg, const push_update_type type, const int push_bun=
dle_size)</span><br><span> {</span><br><span>@@ -231,9 +244,17 @@</span><br=
><span> </span><br><span>         if (!mi)</span><br><span>         {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;=
gc);</span><br><span>             return -ENOENT;</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!support_push_update(mi))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to=
 unsupported peer with ID: %u&quot;, mi-&gt;context.c2.tls_multi-&gt;peer_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>         const char *old_ip =3D mi-&gt;context.options.ifconfig_local;</=
span><br><span>         const char *old_ipv6 =3D mi-&gt;context.options.ifc=
onfig_ipv6_local;</span><br><span>         if (!mi-&gt;halt</span><br><span=
>@@ -262,7 +283,7 @@</span><br><span>     {</span><br><span>         struct=
 multi_instance *curr_mi =3D he-&gt;value;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (curr_mi-&gt;halt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (curr_mi-&gt;ha=
lt || !support_push_update(curr_mi))</span><br><span>         {</span><br><=
span>             continue;</span><br><span>         }</span><br><span>@@ -=
273,8 +294,7 @@</span><br><span>         const char *old_ipv6 =3D curr_mi-&=
gt;context.options.ifconfig_ipv6_local;</span><br><span>         if (!send_=
single_push_update(&amp;curr_mi-&gt;context, msgs, &amp;option_types_found)=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not been upda=
ted&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     curr_mi-&gt;context.c2.tls_multi ? curr_mi-&gt;context.c2.tls_multi-&g=
t;peer_id : UINT32_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not been update=
d&quot;, curr_mi-&gt;context.c2.tls_multi-&gt;peer_id);</span><br><span>   =
          continue;</span><br><span>         }</span><br><span>         if =
(option_types_found &amp; OPT_P_UP)</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_=
update_msg.c</span><br><span>index 6e49f14..60596ed 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -144,7 =
+144,13 @@</span><br><span> {</span><br><span>     return true;</span><br><=
span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifnd=
ef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_iv_proto(const=
 char *peer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return IV_PROTO_=
PUSH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MA=
NAGEMENT */</span><br><span> </span><br><span> /* tests */</span><br><span>=
 </span><br><span>@@ -464,6 +470,7 @@</span><br><span>     struct multi_con=
text *m =3D calloc(1, sizeof(struct multi_context));</span><br><span>     m=
-&gt;instances =3D calloc(1, sizeof(struct multi_instance *));</span><br><s=
pan>     struct multi_instance *mi =3D calloc(1, sizeof(struct multi_instan=
ce));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;con=
text.c2.tls_multi =3D calloc(1, sizeof(struct tls_multi));</span><br><span>=
     *(m-&gt;instances) =3D mi;</span><br><span>     m-&gt;top.options.disa=
ble_dco =3D true;</span><br><span>     *state =3D m;</span><br><span>@@ -47=
4,6 +481,7 @@</span><br><span> teardown2(void **state)</span><br><span> {</=
span><br><span>     struct multi_context *m =3D *state;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free((*(m-&gt;instances))-&gt;conte=
xt.c2.tls_multi);</span><br><span>     free(*(m-&gt;instances));</span><br>=
<span>     free(m-&gt;instances);</span><br><span>     free(m);</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1255?usp=3Demail">change 1255</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1255?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc=
65f2959227bec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1255 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--nOqOpjfcSGA=--


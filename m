From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 13:32:01 +0000
In-Reply-To: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
References: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <2b45845d2c6c3cec02286fdc6dbd4eb13bc10316-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EktlNi+cZvc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EktlNi+cZvc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, ordex, plaisthos.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail

to look at the new patch set (#2).


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
---
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
2 files changed, 36 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1255/2

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f306104..3fa099c 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -7,6 +7,7 @@

 #ifdef ENABLE_MANAGEMENT
 #include "multi.h"
+#include "ssl_util.h"
 #endif

 #if defined(__GNUC__) || defined(__clang__)
@@ -174,20 +175,32 @@
         buf_string_compare_advance(&msgs[i], push_update_cmd);
         if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
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
@@ -228,9 +241,17 @@

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
@@ -259,7 +280,7 @@
     {
         struct multi_instance *curr_mi =3D he->value;
=20
-        if (curr_mi->halt)
+        if (curr_mi->halt || !support_push_update(curr_mi))
         {
             continue;
         }
@@ -270,8 +291,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: mrbff <marco@...2726...>

--EktlNi+cZvc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, ordex, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">PUSH_UPDATE server: check IV_PROTO before sending the m=
essage to the client<br><br>Before sending the PUSH_UPDATE message to the c=
lient, we must verify that<br>the client has actually sent IV_PROTO_PUSH_UP=
DATE to the server, declaring that<br>it supports push-updates.<br><br>Also=
 fixed a gc_arena memory leak in one of the error paths and asserted<br>mi-=
&gt;context.c2.tls_multi .<br><br>Change-Id: I7c28da72be11c7efbed3068fbfc65=
f2959227bec<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<b=
r>M src/openvpn/push_util.c<br>M tests/unit_tests/openvpn/test_push_update_=
msg.c<br>2 files changed, 36 insertions(+), 8 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/=
1255/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util=
.c</span><br><span>index f306104..3fa099c 100644</span><br><span>--- a/src/=
openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br=
><span>@@ -7,6 +7,7 @@</span><br><span> </span><br><span> #ifdef ENABLE_MAN=
AGEMENT</span><br><span> #include &quot;multi.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util.h&quot;</span><br=
><span> #endif</span><br><span> </span><br><span> #if defined(__GNUC__) || =
defined(__clang__)</span><br><span>@@ -174,20 +175,32 @@</span><br><span>  =
       buf_string_compare_advance(&amp;msgs[i], push_update_cmd);</span><br=
><span>         if (process_incoming_push_update(c, pull_permission_mask(c)=
, option_types_found, &amp;msgs[i], true) =3D=3D PUSH_MSG_ERROR)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(M_WARN, &quot;Failed to process push update message sent to clie=
nt ID: %u&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           c-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M=
_WARN, &quot;Failed to process push update message sent to client ID: %u&qu=
ot;, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span>             continue=
;</span><br><span>         }</span><br><span>         c-&gt;options.push_op=
tion_types_found |=3D *option_types_found;</span><br><span>         if (!op=
tions_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.es))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(M_WARN, &quot;Failed to post-process push update message sent to client =
ID: %u&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        c-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WA=
RN, &quot;Failed to post-process push update message sent to client ID: %u&=
quot;, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span>         }</span><b=
r><span>     }</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Return=
 true if the client supports push-update */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+support_push_update(struct multi_instance *mi)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.tls_multi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int iv_pro=
to_peer =3D extract_iv_proto(mi-&gt;context.c2.tls_multi-&gt;peer_info);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(iv_proto_pee=
r &amp; IV_PROTO_PUSH_UPDATE))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> int</span><br><span> send_push_update=
(struct multi_context *m, const void *target, const char *msg, const push_u=
pdate_type type, const int push_bundle_size)</span><br><span> {</span><br><=
span>@@ -228,9 +241,17 @@</span><br><span> </span><br><span>         if (!m=
i)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            gc_free(&amp;gc);</span><br><span>             return=
 -ENOENT;</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!support_push_update(mi))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;=
PUSH_UPDATE: not sending message to unsupported peer with ID: %u&quot;, mi-=
&gt;context.c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         const char *old_ip =3D mi-&g=
t;context.options.ifconfig_local;</span><br><span>         const char *old_=
ipv6 =3D mi-&gt;context.options.ifconfig_ipv6_local;</span><br><span>      =
   if (!mi-&gt;halt</span><br><span>@@ -259,7 +280,7 @@</span><br><span>   =
  {</span><br><span>         struct multi_instance *curr_mi =3D he-&gt;valu=
e;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (curr_mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (curr_mi-&gt;halt || !support_push_update(curr_mi))</sp=
an><br><span>         {</span><br><span>             continue;</span><br><s=
pan>         }</span><br><span>@@ -270,8 +291,7 @@</span><br><span>        =
 const char *old_ipv6 =3D curr_mi-&gt;context.options.ifconfig_ipv6_local;<=
/span><br><span>         if (!send_single_push_update(&amp;curr_mi-&gt;cont=
ext, msgs, &amp;option_types_found))</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;E=
RROR: Peer ID: %u has not been updated&quot;,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                curr_mi-&gt;context.c2.tls_multi ? =
curr_mi-&gt;context.c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERR=
OR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;context.c2.tls_mult=
i-&gt;peer_id);</span><br><span>             continue;</span><br><span>    =
     }</span><br><span>         if (option_types_found &amp; OPT_P_UP)</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/=
tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>index 6e49f=
14..60596ed 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_push=
_update_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_upda=
te_msg.c</span><br><span>@@ -144,7 +144,13 @@</span><br><span> {</span><br>=
<span>     return true;</span><br><span> }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif /* ifndef ENABLE_MANAGEMENT */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+extract_iv_proto(const char *peer_info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br=
><span> /* tests */</span><br><span> </span><br><span>@@ -464,6 +470,7 @@</=
span><br><span>     struct multi_context *m =3D calloc(1, sizeof(struct mul=
ti_context));</span><br><span>     m-&gt;instances =3D calloc(1, sizeof(str=
uct multi_instance *));</span><br><span>     struct multi_instance *mi =3D =
calloc(1, sizeof(struct multi_instance));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mi-&gt;context.c2.tls_multi =3D calloc(1, sizeof(=
struct tls_multi));</span><br><span>     *(m-&gt;instances) =3D mi;</span><=
br><span>     m-&gt;top.options.disable_dco =3D true;</span><br><span>     =
*state =3D m;</span><br><span>@@ -474,6 +481,7 @@</span><br><span> teardown=
2(void **state)</span><br><span> {</span><br><span>     struct multi_contex=
t *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free((*(m-&gt;instances))-&gt;context.c2.tls_multi);</span><br><span>     =
free(*(m-&gt;instances));</span><br><span>     free(m-&gt;instances);</span=
><br><span>     free(m);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">change =
1255</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc=
65f2959227bec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1255 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--EktlNi+cZvc=--


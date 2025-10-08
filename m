From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 11:31:05 +0000
References: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4254e808dbc963f9e299b4fcf55676b42b70cc7f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ylcHf6i2ogs="; charset=UTF-8
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

--ylcHf6i2ogs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail

to review the following change.


Change subject: PUSH_UPDATE server: check IV_PROTO before sending the messa=
ge to the client
......................................................................

PUSH_UPDATE server: check IV_PROTO before sending the message to the client

Before sending the PUSH_UPDATE message to the client, we must verify that
the client has actually sent IV_PROTO_PUSH_UPDATE to the server, declaring =
that
it supports push-updates.

Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
2 files changed, 38 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1255/1

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f306104..5c8a9da 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -7,6 +7,7 @@

 #ifdef ENABLE_MANAGEMENT
 #include "multi.h"
+#include "ssl_util.h"
 #endif

 #if defined(__GNUC__) || defined(__clang__)
@@ -188,6 +189,26 @@
     return true;
 }

+/* Return true if the client supports push-update */
+static bool
+support_push_update(struct multi_instance *mi)
+{
+    if (!mi)
+    {
+        return false;
+    }
+
+    const unsigned int iv_proto_peer =3D extract_iv_proto(mi->context.c2.t=
ls_multi->peer_info);
+    if (!(iv_proto_peer & IV_PROTO_PUSH_UPDATE))
+    {
+        msg(M_CLIENT, "ERROR: Peer ID: %u does not support push-update",
+            mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id :=
 UINT32_MAX);
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
@@ -228,9 +249,16 @@

         if (!mi)
         {
+            gc_free(&gc);
             return -ENOENT;
         }

+        if (!support_push_update(mi))
+        {
+            gc_free(&gc);
+            return 0;
+        }
+
         const char *old_ip =3D mi->context.options.ifconfig_local;
         const char *old_ipv6 =3D mi->context.options.ifconfig_ipv6_local;
         if (!mi->halt
@@ -259,7 +287,7 @@
     {
         struct multi_instance *curr_mi =3D he->value;

-        if (curr_mi->halt)
+        if (curr_mi->halt || !support_push_update(curr_mi))
         {
             continue;
         }
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Gerrit-Change-Number: 1255
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ylcHf6i2ogs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">PUSH_UPDATE server: check IV_PROTO before s=
ending the message to the client<br><br>Before sending the PUSH_UPDATE mess=
age to the client, we must verify that<br>the client has actually sent IV_P=
ROTO_PUSH_UPDATE to the server, declaring that<br>it supports push-updates.=
<br><br>Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec<br>Signed-off-=
by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/push_util.=
c<br>M tests/unit_tests/openvpn/test_push_update_msg.c<br>2 files changed, =
38 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/55/1255/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>ind=
ex f306104..5c8a9da 100644</span><br><span>--- a/src/openvpn/push_util.c</s=
pan><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -7,6 +7,7 @@=
</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><spa=
n> #include &quot;multi.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;ssl_util.h&quot;</span><br><span> #endif</span><=
br><span> </span><br><span> #if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span>@@ -188,6 +189,26 @@</span><br><span>     return true;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Return true if the client supports push-update */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+support_push_update(struct multi_instanc=
e *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t unsigned int iv_proto_peer =3D extract_iv_proto(mi-&gt;context.c2.tls_mul=
ti-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!(iv_proto_peer &amp; IV_PROTO_PUSH_UPDATE))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: Peer ID: %u does not=
 support push-update&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_mul=
ti-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> se=
nd_push_update(struct multi_context *m, const void *target, const char *msg=
, const push_update_type type, const int push_bundle_size)</span><br><span>=
 {</span><br><span>@@ -228,9 +249,16 @@</span><br><span> </span><br><span> =
        if (!mi)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>     =
        return -ENOENT;</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!support_push_=
update(mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>         const char *old_ip =3D mi-&gt;context.options.ifconfig_local;</sp=
an><br><span>         const char *old_ipv6 =3D mi-&gt;context.options.ifcon=
fig_ipv6_local;</span><br><span>         if (!mi-&gt;halt</span><br><span>@=
@ -259,7 +287,7 @@</span><br><span>     {</span><br><span>         struct m=
ulti_instance *curr_mi =3D he-&gt;value;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (curr_mi-&gt;halt)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (curr_mi-&gt;halt=
 || !support_push_update(curr_mi))</span><br><span>         {</span><br><sp=
an>             continue;</span><br><span>         }</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/o=
penvpn/test_push_update_msg.c</span><br><span>index 6e49f14..60596ed 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br=
><span>@@ -144,7 +144,13 @@</span><br><span> {</span><br><span>     return =
true;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* ifndef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extra=
ct_iv_proto(const char *peer_info)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> /* tests */=
</span><br><span> </span><br><span>@@ -464,6 +470,7 @@</span><br><span>    =
 struct multi_context *m =3D calloc(1, sizeof(struct multi_context));</span=
><br><span>     m-&gt;instances =3D calloc(1, sizeof(struct multi_instance =
*));</span><br><span>     struct multi_instance *mi =3D calloc(1, sizeof(st=
ruct multi_instance));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    mi-&gt;context.c2.tls_multi =3D calloc(1, sizeof(struct tls_multi));=
</span><br><span>     *(m-&gt;instances) =3D mi;</span><br><span>     m-&gt=
;top.options.disable_dco =3D true;</span><br><span>     *state =3D m;</span=
><br><span>@@ -474,6 +481,7 @@</span><br><span> teardown2(void **state)</sp=
an><br><span> {</span><br><span>     struct multi_context *m =3D *state;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free((*(m-&gt;inst=
ances))-&gt;context.c2.tls_multi);</span><br><span>     free(*(m-&gt;instan=
ces));</span><br><span>     free(m-&gt;instances);</span><br><span>     fre=
e(m);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">change 1255</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1255?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc=
65f2959227bec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1255 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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

--ylcHf6i2ogs=--


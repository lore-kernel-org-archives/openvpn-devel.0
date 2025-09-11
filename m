From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 11 Sep 2025 13:41:38 +0000
References: <gerrit.1757598096000.Icc20f3adccb5689f11df8888c526d0402b32d806@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e16b1e6c88e6223982d1e374598896d0f8499094-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="podxcOuZeG0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: push-update-server:
 comment about `buf_string_compare_advance()` usag...
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

--podxcOuZeG0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1176?usp=3Demail

to review the following change.


Change subject: push-update-server: comment about `buf_string_compare_advan=
ce()` usage in `send_single_push_updaate()`
......................................................................

push-update-server: comment about `buf_string_compare_advance()` usage in `=
send_single_push_updaate()`

Change-Id: Icc20f3adccb5689f11df8888c526d0402b32d806
Signed-off-by: Marco Baffo <marco@...2726...>
---
A src/openvpn/push_util.c
1 file changed, 303 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1176/1

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
new file mode 100644
index 0000000..e641755
--- /dev/null
+++ b/src/openvpn/push_util.c
@@ -0,0 +1,303 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "push.h"
+#include "buffer.h"
+
+#ifdef ENABLE_MANAGEMENT
+#include "multi.h"
+#endif
+
+int
+process_incoming_push_update(struct context *c, unsigned int permission_ma=
sk,
+                             unsigned int *option_types_found, struct buff=
er *buf,
+                             bool msg_sender)
+{
+    int ret =3D PUSH_MSG_ERROR;
+    const uint8_t ch =3D buf_read_u8(buf);
+    if (ch =3D=3D ',')
+    {
+        if (apply_push_options(c, &c->options, buf, permission_mask, optio=
n_types_found, c->c2.es,
+                               true))
+        {
+            switch (c->options.push_continuation)
+            {
+                case 0:
+                case 1:
+                    ret =3D PUSH_MSG_UPDATE;
+                    break;
+
+                case 2:
+                    ret =3D PUSH_MSG_CONTINUATION;
+                    break;
+            }
+        }
+        else if (!msg_sender)
+        {
+            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
+        }
+    }
+    else if (ch =3D=3D '\0')
+    {
+        ret =3D PUSH_MSG_UPDATE;
+    }
+
+    return ret;
+}
+
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Return index of last `,` or `0` if it didn't find any.
+ * If there is a comma at index `0` it's an error anyway
+ */
+static int
+find_first_comma_of_next_bundle(const char *str, int ix)
+{
+    while (ix > 0)
+    {
+        if (str[ix] =3D=3D ',')
+        {
+            return ix;
+        }
+        ix--;
+    }
+    return 0;
+}
+
+/* Allocate memory and assemble the final message */
+static struct buffer
+forge_msg(const char *src, const char *continuation, struct gc_arena *gc)
+{
+    int src_len =3D strlen(src);
+    int con_len =3D continuation ? strlen(continuation) : 0;
+    struct buffer buf =3D alloc_buf_gc(src_len + sizeof(push_update_cmd) +=
 con_len + 2, gc);
+
+    buf_printf(&buf, "%s,%s%s", push_update_cmd, src, continuation ? conti=
nuation : "");
+
+    return buf;
+}
+
+static char *
+gc_strdup(const char *src, struct gc_arena *gc)
+{
+    char *ret =3D gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);
+
+    strcpy(ret, src);
+    return ret;
+}
+
+/* It split the messagge (if necessay) and fill msgs with the message chun=
ks.
+ * Return `false` on failure an `true` on success.
+ */
+static bool
+message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, =
const int safe_cap)
+{
+    if (!s || !*s)
+    {
+        return false;
+    }
+
+    char *str =3D gc_strdup(s, gc);
+    int i =3D 0;
+    int im =3D 0;
+
+    while (*str)
+    {
+        /* + ',' - '/0' */
+        if (strlen(str) > safe_cap)
+        {
+            int ci =3D find_first_comma_of_next_bundle(str, safe_cap);
+            if (!ci)
+            {
+                /* if no commas were found go to fail, do not send any mes=
sage */
+                return false;
+            }
+            str[ci] =3D '\0';
+            /* copy from i to (ci -1) */
+            msgs[im] =3D forge_msg(str, ",push-continuation 2", gc);
+            i =3D ci + 1;
+        }
+        else
+        {
+            if (im)
+            {
+                msgs[im] =3D forge_msg(str, ",push-continuation 1", gc);
+            }
+            else
+            {
+                msgs[im] =3D forge_msg(str, NULL, gc);
+            }
+            i =3D strlen(str);
+        }
+        str =3D &str[i];
+        im++;
+    }
+    return true;
+}
+
+/* send the message(s) prepared to one single client */
+static bool
+send_single_push_update(struct context *c, struct buffer *msgs, unsigned i=
nt *option_types_found)
+{
+    if (!msgs[0].data || !*(msgs[0].data))
+    {
+        return false;
+    }
+    int i =3D -1;
+
+    while (msgs[++i].data && *(msgs[i].data))
+    {
+        if (!send_control_channel_string(c, BSTR(&msgs[i]), D_PUSH))
+        {
+            return false;
+        }
+
+        /* After sending the control message, we update the options server=
-side in the client's context
+         * so pushed options like ifconfig/ifconfig-ipv6 can actually work.
+         * If we don't do that, the packets arriving from the client with =
the new address will be
+         * rejected because the value in the option is an old one.
+         * For the same reason we later update the vhash too in `send_push=
_update()` function.
+         * Using `buf_string_compare_advance()` we mimic the behavior insi=
de `process_incoming_push_msg()`.
+         * However, we don't need to check the return value here because w=
e just want to `advance`,
+         * meaning we skip the `push_update_cmd' we added earlier. */
+        buf_string_compare_advance(&msgs[i], push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
+        {
+            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
+                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            continue;
+        }
+        c->options.push_option_types_found |=3D *option_types_found;
+        if (!options_postprocess_pull(&c->options, c->c2.es))
+        {
+            msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u",
+                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+        }
+    }
+    return true;
+}
+
+int
+send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size)
+{
+    if (!msg || !*msg || !m
+        || (!target && type !=3D UPT_BROADCAST))
+    {
+        return -EINVAL;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* extra space for possible trailing ifconfig and push-continuation */
+    const int extra =3D 84 + sizeof(push_update_cmd);
+    /* push_bundle_size is the maximum size of a message, so if the message
+     * we want to send exceeds that size we have to split it into smaller =
messages */
+    const int safe_cap =3D push_bundle_size - extra;
+    int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) =
!=3D 0);
+    struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);
+
+    unsigned int option_types_found =3D 0;
+
+    msgs[msgs_num].data =3D NULL;
+    if (!message_splitter(msg, msgs, &gc, safe_cap))
+    {
+        gc_free(&gc);
+        return -EINVAL;
+    }
+
+    if (type =3D=3D UPT_BY_CID)
+    {
+        struct multi_instance *mi =3D lookup_by_cid(m, *((unsigned long *)=
target));
+
+        if (!mi)
+        {
+            return -ENOENT;
+        }
+
+        const char *old_ip =3D mi->context.options.ifconfig_local;
+        const char *old_ipv6 =3D mi->context.options.ifconfig_ipv6_local;
+        if (!mi->halt
+            && send_single_push_update(&mi->context, msgs, &option_types_f=
ound))
+        {
+            if (option_types_found & OPT_P_UP)
+            {
+                update_vhash(m, mi, old_ip, old_ipv6);
+            }
+            gc_free(&gc);
+            return 1;
+        }
+        else
+        {
+            gc_free(&gc);
+            return 0;
+        }
+    }
+
+    int count =3D 0;
+    struct hash_iterator hi;
+    const struct hash_element *he;
+
+    hash_iterator_init(m->iter, &hi);
+    while ((he =3D hash_iterator_next(&hi)))
+    {
+        struct multi_instance *curr_mi =3D he->value;
+
+        if (curr_mi->halt)
+        {
+            continue;
+        }
+
+        /* Type is UPT_BROADCAST so we update every client */
+        option_types_found =3D 0;
+        const char *old_ip =3D curr_mi->context.options.ifconfig_local;
+        const char *old_ipv6 =3D curr_mi->context.options.ifconfig_ipv6_lo=
cal;
+        if (!send_single_push_update(&curr_mi->context, msgs, &option_type=
s_found))
+        {
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
+                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
+            continue;
+        }
+        if (option_types_found & OPT_P_UP)
+        {
+            update_vhash(m, curr_mi, old_ip, old_ipv6);
+        }
+        count++;
+    }
+
+    hash_iterator_free(&hi);
+    gc_free(&gc);
+    return count;
+}
+
+#define RETURN_UPDATE_STATUS(n_sent)                                  \
+    do                                                                \
+    {                                                                 \
+        if ((n_sent) > 0)                                             \
+        {                                                             \
+            msg(M_CLIENT, "SUCCESS: %d client(s) updated", (n_sent)); \
+            return true;                                              \
+        }                                                             \
+        else                                                          \
+        {                                                             \
+            msg(M_CLIENT, "ERROR: no client updated");                \
+            return false;                                             \
+        }                                                             \
+    } while (0)
+
+
+bool
+management_callback_send_push_update_broadcast(void *arg, const char *opti=
ons)
+{
+    int n_sent =3D send_push_update(arg, NULL, options, UPT_BROADCAST, PUS=
H_BUNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+
+bool
+management_callback_send_push_update_by_cid(void *arg, unsigned long cid, =
const char *options)
+{
+    int n_sent =3D send_push_update(arg, &cid, options, UPT_BY_CID, PUSH_B=
UNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+#endif /* ifdef ENABLE_MANAGEMENT */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1176?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc20f3adccb5689f11df8888c526d0402b32d806
Gerrit-Change-Number: 1176
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--podxcOuZeG0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1176?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">push-update-server: comment about `buf_string_compare_advanc=
e()` usage in `send_single_push_updaate()`<br><br>Change-Id: Icc20f3adccb56=
89f11df8888c526d0402b32d806<br>Signed-off-by: Marco Baffo &lt;marco@...2787...=
...&gt;<br>---<br>A src/openvpn/push_util.c<br>1 file changed, 303 insertio=
ns(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/76/1176/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push_util.c b/=
src/openvpn/push_util.c</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000..e641755</span><br><span>--- /dev/null</span><br><span>+++ =
b/src/openvpn/push_util.c</span><br><span>@@ -0,0 +1,303 @@</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;push.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_incomi=
ng_push_update(struct context *c, unsigned int permission_mask,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                             un=
signed int *option_types_found, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                             bool msg_sen=
der)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D PUSH_MSG_ERROR;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t ch =
=3D buf_read_u8(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (ch =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (apply_push_options(c, &amp;c-&gt;options, buf, permission_mask, =
option_types_found, c-&gt;c2.es,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                               true))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            switch (c-&gt;options.push_continuation)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                case 0:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                case 1:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 ret =3D PUSH_MSG_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          case 2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  ret =3D PUSH_MSG_CONTINUATION;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else if (!msg_sender)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            throw_signal_soft(SIGUSR1, &quot;Offending =
option received from server&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (ch =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ret =3D PUSH_MSG_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Return index of last `,` or `0` if it didn&#39;t find any.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * If there is a comma at index `0`=
 it&#39;s an error anyway</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_first_comma_of=
_next_bundle(const char *str, int ix)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    while (ix &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
str[ix] =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return ix;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
x--;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Allocate memory and assemble the final message */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static struct buffer</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+forge_msg(const char *src, const char =
*continuation, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int src_len =3D strlen(src);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int con_len =3D continuation ? strlen(continuation) : 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(src_len + sizeof(push_update_cmd) + con_len + 2, gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;%s,%s%s&qu=
ot;, push_update_cmd, src, continuation ? continuation : &quot;&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_strdup(con=
st char *src, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *ret =3D gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    strcpy(ret, src);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* It s=
plit the messagge (if necessay) and fill msgs with the message chunks.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return `false` on fai=
lure an `true` on success.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+message_splitter(=
const char *s, struct buffer *msgs, struct gc_arena *gc, const int safe_cap=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!s || !*s)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *str =3D gc_strdup(s, gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int im =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (*str=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* + &#39;,&#39; - &#39;=
/0&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (strlen(str) &gt; safe_cap)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            int ci =3D find_first_comma_of_next_bundle(str, safe_cap);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!ci)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* if no comm=
as were found go to fail, do not send any message */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            str[ci] =3D &#39;\0&#39;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* copy=
 from i to (ci -1) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msgs[im] =3D forge_msg(str, &quot;,push-continuation 2&quot;,=
 gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i =
=3D ci + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (im)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msgs[im] =3D forge_msg(st=
r, &quot;,push-continuation 1&quot;, gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msgs[im] =3D forge_msg(str, NULL, gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            i =3D strlen(str);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        str =3D &amp;str[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        im++;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* send the me=
ssage(s) prepared to one single client */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+send_single_push_update(struct context *c, struct buffer *msg=
s, unsigned int *option_types_found)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!msgs[0].data || !*(msgs[0].data))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int i =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (msgs[++i].data=
 &amp;&amp; *(msgs[i].data))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!send_control_channel_string(c, BSTR(&amp;msgs[i]), D_PUSH))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* After sending the control message, we update the =
options server-side in the client&#39;s context</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * so pushed options like ifconfig/ifco=
nfig-ipv6 can actually work.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * If we don&#39;t do that, the packets arriving from the =
client with the new address will be</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * rejected because the value in the option is an o=
ld one.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * F=
or the same reason we later update the vhash too in `send_push_update()` fu=
nction. </span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
Using `buf_string_compare_advance()` we mimic the behavior inside `process_=
incoming_push_msg()`.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * However, we don&#39;t need to check the return value here beca=
use we just want to `advance`,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * meaning we skip the `push_update_cmd&#39; we added ea=
rlier. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bu=
f_string_compare_advance(&amp;msgs[i], push_update_cmd);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (process_incoming_push_upda=
te(c, pull_permission_mask(c), option_types_found, &amp;msgs[i], true) =3D=
=3D PUSH_MSG_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_WARN, &quot;Failed to process push update message sent to client ID=
: %u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        c-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;options.push_o=
ption_types_found |=3D *option_types_found;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!options_postprocess_pull(&amp;c-&gt;op=
tions, c-&gt;c2.es))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN, &quot;Failed to post-process push update message sent to cli=
ent ID: %u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              c-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_=
MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_push_update(st=
ruct multi_context *m, const void *target, const char *msg, const push_upda=
te_type type, const int push_bundle_size)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!msg || !*msg || !m</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        || (!target &amp;&amp; type !=3D UPT_BROADCAST))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* extra space for possible trailing ifconfig an=
d push-continuation */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int extra =3D 84 + sizeof(push_update_cmd);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* push_bundle_size is the maximum=
 size of a message, so if the message</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * we want to send exceeds that size we have to split=
 it into smaller messages */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const int safe_cap =3D push_bundle_size - extra;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int msgs_num =3D (strlen(msg)=
 / safe_cap) + ((strlen(msg) % safe_cap) !=3D 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer *msgs =3D gc_malloc((msgs_n=
um + 1) * sizeof(struct buffer), true, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    unsigned int option_types_found =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msgs[msgs_num].data =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!message_splitter(msg, msgs, &amp;gc, =
safe_cap))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -E=
INVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (type =3D=3D UPT_BY_CID)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D lookup_by_=
cid(m, *((unsigned long *)target));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const char *old_ip =3D mi-&gt=
;context.options.ifconfig_local;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const char *old_ipv6 =3D mi-&gt;context.options.ifconf=
ig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!mi-&gt;halt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &amp;&amp; send_single_push_update(&amp;mi-&gt;context, msgs, &=
amp;option_types_found))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (option_types_found &amp; OPT_P_UP)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                update_vhash(m, mi, old_ip, old_ipv6);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int count =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct hash_iterator hi;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const struct hash_element *he;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while ((he =3D hash_iterator_next(&am=
p;hi)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi_insta=
nce *curr_mi =3D he-&gt;value;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (curr_mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Type is UPT_BROADCAST so=
 we update every client */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        option_types_found =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const char *old_ip =3D curr_mi-&gt;context.opt=
ions.ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const char *old_ipv6 =3D curr_mi-&gt;context.options.ifconfig_ipv6=
_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!send_single_push_update(&amp;curr_mi-&gt;context, msgs, &amp;option_types_=
found))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIE=
NT, &quot;ERROR: Peer ID: %u has not been updated&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                curr_mi-&gt;context.c2=
.tls_multi ? curr_mi-&gt;context.c2.tls_multi-&gt;peer_id : UINT32_MAX);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (option_types_found=
 &amp; OPT_P_UP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            u=
pdate_vhash(m, curr_mi, old_ip, old_ipv6);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        count++;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_iterator_free(=
&amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn count;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define RETURN_UPDATE_STATUS(n_sent)           =
                       \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    do                                                                =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {             =
                                                    \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ((n_sent) &gt; 0)             =
                                \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {                                                    =
         \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_CLIENT, &quot;SUCCESS: %d client(s) updated&quot;, (n_sent)); \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return tru=
e;                                              \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }                                    =
                         \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else                                                        =
  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {       =
                                                      \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: =
no client updated&quot;);                \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return false;                           =
                  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }                                                             \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    } while (0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manag=
ement_callback_send_push_update_broadcast(void *arg, const char *options)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int n_sent =3D send_push_update(arg=
, NULL, options, UPT_BROADCAST, PUSH_BUNDLE_SIZE);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    RETURN_UPDATE_STATUS(n_sent);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+management_callback_send_p=
ush_update_by_cid(void *arg, unsigned long cid, const char *options)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int n_sent =3D send_push_update(arg, &am=
p;cid, options, UPT_BY_CID, PUSH_BUNDLE_SIZE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    RETURN_UPDATE_STATUS(n_sent);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1176?usp=
=3Demail">change 1176</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1176?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc20f3adccb5689f11df8888c52=
6d0402b32d806 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1176 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--podxcOuZeG0=--


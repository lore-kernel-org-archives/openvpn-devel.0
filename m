From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 13:26:26 +0000
In-Reply-To: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
References: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2902b7e9b5a3853ad276b0e1cdd276fb783085ca-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ag15snAre/0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Rename state_change
 to continue_tls_process
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

--ag15snAre/0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Rename state_change to continue_tls_process
......................................................................

Rename state_change to continue_tls_process

The name state_change is more confusing than helpful as it not really
indicates if there was a state change but rather if processing should
be continued. There even some states that are definitively state changes
(setting to_link buffer) that require continue_tls_process to be set
to false.

Change-Id: Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585
---
M src/openvpn/ssl.c
1 file changed, 27 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/452/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b4cd8f5..f8e0c51 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2694,7 +2694,7 @@
  */
 static bool
 read_incoming_tls_ciphertext(struct buffer *buf, struct key_state *ks,
-                             bool *state_change)
+                             bool *continue_tls_process)
 {
     int status =3D 0;
     if (buf->len)
@@ -2714,7 +2714,7 @@
     if (status =3D=3D 1)
     {
         reliable_mark_deleted(ks->rec_reliable, buf);
-        *state_change =3D true;
+        *continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
     }
     return true;
@@ -2730,7 +2730,7 @@

 static bool
 read_incoming_tls_plaintext(struct key_state *ks, struct buffer *buf,
-                            interval_t *wakeup, bool *state_change)
+                            interval_t *wakeup, bool *continue_tls_process)
 {
     ASSERT(buf_init(buf, 0));

@@ -2744,7 +2744,7 @@
     }
     if (status =3D=3D 1)
     {
-        *state_change =3D true;
+        *continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");

         /* More data may be available, wake up again asap to check. */
@@ -2754,7 +2754,7 @@
 }

 static bool
-write_outgoing_tls_ciphertext(struct tls_session *session, bool *state_cha=
nge)
+write_outgoing_tls_ciphertext(struct tls_session *session, bool *continue_=
tls_process)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];

@@ -2830,7 +2830,7 @@

             reliable_mark_active_outgoing(ks->send_reliable, buf, opcode);
             INCR_GENERATED;
-            *state_change =3D true;
+            *continue_tls_process =3D true;
         }
         dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
     }
@@ -2839,7 +2839,6 @@
     return true;
 }

-
 static bool
 tls_process_state(struct tls_multi *multi,
                   struct tls_session *session,
@@ -2848,13 +2847,19 @@
                   struct link_socket_info *to_link_socket_info,
                   interval_t *wakeup)
 {
-    bool state_change =3D false;
+    /* This variable indicates if we should call this method
+     * again to process more incoming/outgoing TLS state/data
+     * We want to repeat this until we either determined that there
+     * is nothing more to process or that further processing
+     * should only be done after the outer loop (sending packets etc.)
+     * has run once more */
+    bool continue_tls_process =3D false;
     struct key_state *ks =3D &session->key[KS_PRIMARY];      /* primary ke=
y */

     /* Initial handshake */
     if (ks->state =3D=3D S_INITIAL)
     {
-        state_change =3D session_move_pre_start(session, ks, false);
+        continue_tls_process =3D session_move_pre_start(session, ks, false=
);
     }
=20
     /* Are we timed out on receive? */
@@ -2872,7 +2877,7 @@
     if (ks->state =3D=3D S_PRE_START && reliable_empty(ks->send_reliable))
     {
         ks->state =3D S_START;
-        state_change =3D true;
+        continue_tls_process =3D true;

         /* New connection, remove any old X509 env variables */
         tls_x509_clear_env(session->opt->es);
@@ -2885,7 +2890,7 @@
         && reliable_empty(ks->send_reliable))
     {
         session_move_active(multi, session, to_link_socket_info, ks);
-        state_change =3D true;
+        continue_tls_process =3D true;
     }

     /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MA=
X ACKs
@@ -2927,7 +2932,7 @@
         }
         else
         {
-            if (!read_incoming_tls_ciphertext(&entry->buf, ks, &state_chan=
ge))
+            if (!read_incoming_tls_ciphertext(&entry->buf, ks, &continue_t=
ls_process))
             {
                 goto error;
             }
@@ -2938,7 +2943,7 @@
     struct buffer *buf =3D &ks->plaintext_read_buf;
     if (!buf->len)
     {
-        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &state_change))
+        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &continue_tls_pr=
ocess))
         {
             goto error;
         }
@@ -2954,7 +2959,7 @@
             goto error;
         }

-        state_change =3D true;
+        continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
         ks->state =3D S_SENT_KEY;
     }
@@ -2970,7 +2975,7 @@
             goto error;
         }

-        state_change =3D true;
+        continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
         ks->state =3D S_GOT_KEY;
     }
@@ -2988,7 +2993,7 @@
         }
         if (status =3D=3D 1)
         {
-            state_change =3D true;
+            continue_tls_process =3D true;
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
@@ -3006,7 +3011,7 @@
         }
     }

-    return state_change;
+    return continue_tls_process;
 error:
     tls_clear_error();
     ks->state =3D S_ERROR;
@@ -3065,19 +3070,19 @@
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }

-    bool state_change =3D true;
-    while (state_change)
+    bool continue_tls_process =3D true;
+    while (continue_tls_process)
     {
         update_time();

         dmsg(D_TLS_DEBUG, "TLS: tls_process: chg=3D%d ks=3D%s lame=3D%s to=
_link->len=3D%d wakeup=3D%d",
-             state_change,
+             continue_tls_process,
              state_name(ks->state),
              state_name(ks_lame->state),
              to_link->len,
              *wakeup);
-        state_change =3D tls_process_state(multi, session, to_link, to_lin=
k_addr,
-                                         to_link_socket_info, wakeup);
+        continue_tls_process =3D tls_process_state(multi, session, to_link=
, to_link_addr,
+                                                 to_link_socket_info, wake=
up);

         if (ks->state =3D=3D S_ERROR)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585
Gerrit-Change-Number: 452
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ag15snAre/0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Rename state_change to continue_tls_process<b=
r><br>The name state_change is more confusing than helpful as it not really=
<br>indicates if there was a state change but rather if processing should<b=
r>be continued. There even some states that are definitively state changes<=
br>(setting to_link buffer) that require continue_tls_process to be set<br>=
to false.<br><br>Change-Id: Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585<br>--=
-<br>M src/openvpn/ssl.c<br>1 file changed, 27 insertions(+), 22 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/5=
2/452/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><b=
r><span>index b4cd8f5..f8e0c51 100644</span><br><span>--- a/src/openvpn/ssl=
.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2694,7 +2694=
,7 @@</span><br><span>  */</span><br><span> static bool</span><br><span> re=
ad_incoming_tls_ciphertext(struct buffer *buf, struct key_state *ks,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
 bool *state_change)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                             bool *continue_tls_process)</span><br><span> =
{</span><br><span>     int status =3D 0;</span><br><span>     if (buf-&gt;l=
en)</span><br><span>@@ -2714,7 +2714,7 @@</span><br><span>     if (status =
=3D=3D 1)</span><br><span>     {</span><br><span>         reliable_mark_del=
eted(ks-&gt;rec_reliable, buf);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        *state_change =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        *continue_tls_process =3D true;</span><br><sp=
an>         dmsg(D_TLS_DEBUG, &quot;Incoming Ciphertext -&gt; TLS&quot;);</=
span><br><span>     }</span><br><span>     return true;</span><br><span>@@ =
-2730,7 +2730,7 @@</span><br><span> </span><br><span> static bool</span><br=
><span> read_incoming_tls_plaintext(struct key_state *ks, struct buffer *bu=
f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         interval_t *wakeup, bool *state_change)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            interval_t *wakeup=
, bool *continue_tls_process)</span><br><span> {</span><br><span>     ASSER=
T(buf_init(buf, 0));</span><br><span> </span><br><span>@@ -2744,7 +2744,7 @=
@</span><br><span>     }</span><br><span>     if (status =3D=3D 1)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 *state_change =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *continue_tls_process =3D true;</span><br><span>         dmsg(=
D_TLS_DEBUG, &quot;TLS -&gt; Incoming Plaintext&quot;);</span><br><span> </=
span><br><span>         /* More data may be available, wake up again asap t=
o check. */</span><br><span>@@ -2754,7 +2754,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-write_outgoing_tls_ciphertext(struct tls_session *sessio=
n, bool *state_change)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+write_outgoing_tls_ciphertext(struct tls_session *session, bool *continu=
e_tls_process)</span><br><span> {</span><br><span>     struct key_state *ks=
 =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span> </span><br><span>@@=
 -2830,7 +2830,7 @@</span><br><span> </span><br><span>             reliable=
_mark_active_outgoing(ks-&gt;send_reliable, buf, opcode);</span><br><span> =
            INCR_GENERATED;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            *state_change =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            *continue_tls_process =3D true;</span><br=
><span>         }</span><br><span>         dmsg(D_TLS_DEBUG, &quot;Outgoing=
 Ciphertext -&gt; Reliable&quot;);</span><br><span>     }</span><br><span>@=
@ -2839,7 +2839,6 @@</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static bool</span><br><span> tls_process_state(struct tls_mult=
i *multi,</span><br><span>                   struct tls_session *session,</=
span><br><span>@@ -2848,13 +2847,19 @@</span><br><span>                   s=
truct link_socket_info *to_link_socket_info,</span><br><span>              =
     interval_t *wakeup)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool state_change =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* This variable indicates if we sho=
uld call this method</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * again to process more incoming/outgoing TLS state/data</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * We want to repeat this un=
til we either determined that there</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * is nothing more to process or that further processin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * should only=
 be done after the outer loop (sending packets etc.)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * has run once more */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool continue_tls_process =3D=
 false;</span><br><span>     struct key_state *ks =3D &amp;session-&gt;key[=
KS_PRIMARY];      /* primary key */</span><br><span> </span><br><span>     =
/* Initial handshake */</span><br><span>     if (ks-&gt;state =3D=3D S_INIT=
IAL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        state_change =3D session_move_pre_start(session, ks, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        continue_tls=
_process =3D session_move_pre_start(session, ks, false);</span><br><span>  =
   }</span><br><span> </span><br><span>     /* Are we timed out on receive?=
 */</span><br><span>@@ -2872,7 +2877,7 @@</span><br><span>     if (ks-&gt;s=
tate =3D=3D S_PRE_START &amp;&amp; reliable_empty(ks-&gt;send_reliable))</s=
pan><br><span>     {</span><br><span>         ks-&gt;state =3D S_START;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        state_change =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        contin=
ue_tls_process =3D true;</span><br><span> </span><br><span>         /* New =
connection, remove any old X509 env variables */</span><br><span>         t=
ls_x509_clear_env(session-&gt;opt-&gt;es);</span><br><span>@@ -2885,7 +2890=
,7 @@</span><br><span>         &amp;&amp; reliable_empty(ks-&gt;send_reliab=
le))</span><br><span>     {</span><br><span>         session_move_active(mu=
lti, session, to_link_socket_info, ks);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        state_change =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        continue_tls_process =3D true;</span><=
br><span>     }</span><br><span> </span><br><span>     /* Reliable buffer t=
o outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs</span><br><span>@@=
 -2927,7 +2932,7 @@</span><br><span>         }</span><br><span>         els=
e</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (!read_incoming_tls_ciphertext(&amp;entry-&gt;buf, ks=
, &amp;state_change))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!read_incoming_tls_ciphertext(&amp;entry-&gt;buf, ks, &am=
p;continue_tls_process))</span><br><span>             {</span><br><span>   =
              goto error;</span><br><span>             }</span><br><span>@@=
 -2938,7 +2943,7 @@</span><br><span>     struct buffer *buf =3D &amp;ks-&gt=
;plaintext_read_buf;</span><br><span>     if (!buf-&gt;len)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!r=
ead_incoming_tls_plaintext(ks, buf, wakeup, &amp;state_change))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!read_incoming_tls_=
plaintext(ks, buf, wakeup, &amp;continue_tls_process))</span><br><span>    =
     {</span><br><span>             goto error;</span><br><span>         }<=
/span><br><span>@@ -2954,7 +2959,7 @@</span><br><span>             goto err=
or;</span><br><span>         }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        state_change =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        continue_tls_process =3D true=
;</span><br><span>         dmsg(D_TLS_DEBUG_MED, &quot;STATE S_SENT_KEY&quo=
t;);</span><br><span>         ks-&gt;state =3D S_SENT_KEY;</span><br><span>=
     }</span><br><span>@@ -2970,7 +2975,7 @@</span><br><span>             g=
oto error;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        state_change =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        continue_tls_process =
=3D true;</span><br><span>         dmsg(D_TLS_DEBUG_MED, &quot;STATE S_GOT_=
KEY&quot;);</span><br><span>         ks-&gt;state =3D S_GOT_KEY;</span><br>=
<span>     }</span><br><span>@@ -2988,7 +2993,7 @@</span><br><span>        =
 }</span><br><span>         if (status =3D=3D 1)</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            state_cha=
nge =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      continue_tls_process =3D true;</span><br><span>             dmsg(D_TL=
S_DEBUG, &quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span>       =
  }</span><br><span>     }</span><br><span>@@ -3006,7 +3011,7 @@</span><br>=
<span>         }</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return state_change;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return continue_tls_process;</=
span><br><span> error:</span><br><span>     tls_clear_error();</span><br><s=
pan>     ks-&gt;state =3D S_ERROR;</span><br><span>@@ -3065,19 +3070,19 @@<=
/span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_process: kille=
d expiring key&quot;);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool state_change =3D true;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (state_change=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool continue_=
tls_process =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    while (continue_tls_process)</span><br><span>     {</span><br><span> =
        update_time();</span><br><span> </span><br><span>         dmsg(D_TL=
S_DEBUG, &quot;TLS: tls_process: chg=3D%d ks=3D%s lame=3D%s to_link-&gt;len=
=3D%d wakeup=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-             state_change,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             continue_tls_process,</span><br><span>              =
state_name(ks-&gt;state),</span><br><span>              state_name(ks_lame-=
&gt;state),</span><br><span>              to_link-&gt;len,</span><br><span>=
              *wakeup);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        state_change =3D tls_process_state(multi, session, to_link, to_li=
nk_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                            to_link_socket_info, wakeup);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        continue_tls_process =3D tls_=
process_state(multi, session, to_link, to_link_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
        to_link_socket_info, wakeup);</span><br><span> </span><br><span>   =
      if (ks-&gt;state =3D=3D S_ERROR)</span><br><span>         {</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/452?usp=3Demail">change 452</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
52?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6d713f2eb08a4c39d97de3e1a4=
a832cedc09585 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 452 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ag15snAre/0=--


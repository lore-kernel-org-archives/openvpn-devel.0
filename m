From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 13:02:36 +0000
References: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b227a393d51dd3a30b8fe1acb79e6e5fbfaedd4a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uVYcNCwvIH0="; charset=UTF-8
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

--uVYcNCwvIH0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail

to review the following change.


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
1 file changed, 21 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/452/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b4cd8f5..f46b661 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2848,13 +2848,19 @@
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

     /* Are we timed out on receive? */
@@ -2872,7 +2878,7 @@
     if (ks->state =3D=3D S_PRE_START && reliable_empty(ks->send_reliable))
     {
         ks->state =3D S_START;
-        state_change =3D true;
+        continue_tls_process =3D true;

         /* New connection, remove any old X509 env variables */
         tls_x509_clear_env(session->opt->es);
@@ -2885,7 +2891,7 @@
         && reliable_empty(ks->send_reliable))
     {
         session_move_active(multi, session, to_link_socket_info, ks);
-        state_change =3D true;
+        continue_tls_process =3D true;
     }

     /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MA=
X ACKs
@@ -2927,7 +2933,7 @@
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
@@ -2938,7 +2944,7 @@
     struct buffer *buf =3D &ks->plaintext_read_buf;
     if (!buf->len)
     {
-        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &state_change))
+        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &continue_tls_pr=
ocess))
         {
             goto error;
         }
@@ -2954,7 +2960,7 @@
             goto error;
         }

-        state_change =3D true;
+        continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
         ks->state =3D S_SENT_KEY;
     }
@@ -2970,7 +2976,7 @@
             goto error;
         }

-        state_change =3D true;
+        continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
         ks->state =3D S_GOT_KEY;
     }
@@ -2988,7 +2994,7 @@
         }
         if (status =3D=3D 1)
         {
-            state_change =3D true;
+            continue_tls_process =3D true;
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
@@ -3006,7 +3012,7 @@
         }
     }

-    return state_change;
+    return continue_tls_process;
 error:
     tls_clear_error();
     ks->state =3D S_ERROR;
@@ -3065,19 +3071,19 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--uVYcNCwvIH0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Rename state_change to continue_tls_process<br><br>The name s=
tate_change is more confusing than helpful as it not really<br>indicates if=
 there was a state change but rather if processing should<br>be continued. =
There even some states that are definitively state changes<br>(setting to_l=
ink buffer) that require continue_tls_process to be set<br>to false.<br><br=
>Change-Id: Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585<br>---<br>M src/openv=
pn/ssl.c<br>1 file changed, 21 insertions(+), 15 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/452/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index b4=
cd8f5..f46b661 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><sp=
an>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2848,13 +2848,19 @@</span><b=
r><span>                   struct link_socket_info *to_link_socket_info,</s=
pan><br><span>                   interval_t *wakeup)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool state_change =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This =
variable indicates if we should call this method</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * again to process more incoming/outgoing=
 TLS state/data</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * We want to repeat this until we either determined that there</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * is nothing more to proce=
ss or that further processing</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * should only be done after the outer loop (sending packets =
etc.)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * has run=
 once more */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol continue_tls_process =3D false;</span><br><span>     struct key_state *k=
s =3D &amp;session-&gt;key[KS_PRIMARY];      /* primary key */</span><br><s=
pan> </span><br><span>     /* Initial handshake */</span><br><span>     if =
(ks-&gt;state =3D=3D S_INITIAL)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        state_change =3D session_move_pre_=
start(session, ks, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        continue_tls_process =3D session_move_pre_start(session, ks,=
 false);</span><br><span>     }</span><br><span> </span><br><span>     /* A=
re we timed out on receive? */</span><br><span>@@ -2872,7 +2878,7 @@</span>=
<br><span>     if (ks-&gt;state =3D=3D S_PRE_START &amp;&amp; reliable_empt=
y(ks-&gt;send_reliable))</span><br><span>     {</span><br><span>         ks=
-&gt;state =3D S_START;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        state_change =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        continue_tls_process =3D true;</span><br><span> </span=
><br><span>         /* New connection, remove any old X509 env variables */=
</span><br><span>         tls_x509_clear_env(session-&gt;opt-&gt;es);</span=
><br><span>@@ -2885,7 +2891,7 @@</span><br><span>         &amp;&amp; reliab=
le_empty(ks-&gt;send_reliable))</span><br><span>     {</span><br><span>    =
     session_move_active(multi, session, to_link_socket_info, ks);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        state_change =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        continue_tl=
s_process =3D true;</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_=
MAX ACKs</span><br><span>@@ -2927,7 +2933,7 @@</span><br><span>         }</=
span><br><span>         else</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (!read_incoming_tls_cipher=
text(&amp;entry-&gt;buf, ks, &amp;state_change))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!read_incoming_tls_ciphertext(=
&amp;entry-&gt;buf, ks, &amp;continue_tls_process))</span><br><span>       =
      {</span><br><span>                 goto error;</span><br><span>      =
       }</span><br><span>@@ -2938,7 +2944,7 @@</span><br><span>     struct =
buffer *buf =3D &amp;ks-&gt;plaintext_read_buf;</span><br><span>     if (!b=
uf-&gt;len)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &amp=
;state_change))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!read_incoming_tls_plaintext(ks, buf, wakeup, &amp;continue_tls_pro=
cess))</span><br><span>         {</span><br><span>             goto error;<=
/span><br><span>         }</span><br><span>@@ -2954,7 +2960,7 @@</span><br>=
<span>             goto error;</span><br><span>         }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        state_change =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
ntinue_tls_process =3D true;</span><br><span>         dmsg(D_TLS_DEBUG_MED,=
 &quot;STATE S_SENT_KEY&quot;);</span><br><span>         ks-&gt;state =3D S=
_SENT_KEY;</span><br><span>     }</span><br><span>@@ -2970,7 +2976,7 @@</sp=
an><br><span>             goto error;</span><br><span>         }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        state_=
change =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     continue_tls_process =3D true;</span><br><span>         dmsg(D_TLS_DEB=
UG_MED, &quot;STATE S_GOT_KEY&quot;);</span><br><span>         ks-&gt;state=
 =3D S_GOT_KEY;</span><br><span>     }</span><br><span>@@ -2988,7 +2994,7 @=
@</span><br><span>         }</span><br><span>         if (status =3D=3D 1)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            state_change =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            continue_tls_process =3D true;</span><br><s=
pan>             dmsg(D_TLS_DEBUG, &quot;Outgoing Plaintext -&gt; TLS&quot;=
);</span><br><span>         }</span><br><span>     }</span><br><span>@@ -30=
06,7 +3012,7 @@</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return st=
ate_change;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn continue_tls_process;</span><br><span> error:</span><br><span>     tls_c=
lear_error();</span><br><span>     ks-&gt;state =3D S_ERROR;</span><br><spa=
n>@@ -3065,19 +3071,19 @@</span><br><span>         msg(D_TLS_DEBUG_LOW, &qu=
ot;TLS: tls_process: killed expiring key&quot;);</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    boo=
l state_change =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    while (state_change)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool continue_tls_process =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while (continue_tls_process)</span><br><spa=
n>     {</span><br><span>         update_time();</span><br><span> </span><b=
r><span>         dmsg(D_TLS_DEBUG, &quot;TLS: tls_process: chg=3D%d ks=3D%s=
 lame=3D%s to_link-&gt;len=3D%d wakeup=3D%d&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-             state_change,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             continue_tls_process,</spa=
n><br><span>              state_name(ks-&gt;state),</span><br><span>       =
       state_name(ks_lame-&gt;state),</span><br><span>              to_link=
-&gt;len,</span><br><span>              *wakeup);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        state_change =3D tls_process_state(mult=
i, session, to_link, to_link_addr,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                         to_link_socket_info, =
wakeup);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
tinue_tls_process =3D tls_process_state(multi, session, to_link, to_link_ad=
dr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                 to_link_socket_info, wakeup);</span><br><s=
pan> </span><br><span>         if (ks-&gt;state =3D=3D S_ERROR)</span><br><=
span>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail">change 452</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/452?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6d713f2eb08a4c39d97de3e1a4=
a832cedc09585 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 452 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--uVYcNCwvIH0=--


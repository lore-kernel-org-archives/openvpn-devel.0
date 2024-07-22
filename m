From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jul 2024 14:35:29 +0000
In-Reply-To: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
References: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <795eaf7cd69964aedbbec6f1b04544a9ea335745-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6SwwT1d3PXY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Ensures all params
 are ready before invoking dco_set_peer()
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

--6SwwT1d3PXY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Ensures all params are ready before invoking dco_set_peer()
......................................................................

Ensures all params are ready before invoking dco_set_peer()

In UDP case the dco_set_peer() is currently perfomed at the wrong time
since the mssfix param is calculated later on in
tls_session_update_crypto_params_do_work().
By moving the dco_set_peer() inside the
tls_session_update_crypto_params_do_work() we will ensure that all
crypto and frame params are properly initialized and if an update occurs
dco will be notified.

Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e079
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
4 files changed, 35 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/587/3

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..0999f4d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2359,7 +2359,8 @@
     if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
                                           &c->options, &c->c2.frame,
                                           frame_fragment,
-                                          get_link_socket_info(c)))
+                                          get_link_socket_info(c),
+                                          &c->c1.tuntap->dco))
     {
         msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options"=
);
         return false;
@@ -2578,7 +2579,8 @@

     if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->op=
tions,
                                           &c->c2.frame, frame_fragment,
-                                          get_link_socket_info(c)))
+                                          get_link_socket_info(c),
+                                          &c->c1.tuntap->dco))
     {
         msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
         return false;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 03177bb..0509911 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2364,21 +2364,6 @@
         return false;
     }

-    if (mi->context.options.ping_send_timeout || mi->context.c2.frame.mss_=
fix)
-    {
-        ret =3D dco_set_peer(&mi->context.c1.tuntap->dco,
-                           mi->context.c2.tls_multi->dco_peer_id,
-                           mi->context.options.ping_send_timeout,
-                           mi->context.options.ping_rec_timeout,
-                           mi->context.c2.frame.mss_fix);
-        if (ret < 0)
-        {
-            msg(D_DCO, "Cannot set DCO peer parameters for %s (id=3D%u): %=
s",
-                multi_instance_string(mi, false, gc),
-                mi->context.c2.tls_multi->dco_peer_id, strerror(-ret));
-            return false;
-        }
-    }
     return true;
 }

@@ -2398,7 +2383,8 @@
     struct tls_session *session =3D &c->c2.tls_multi->session[TM_ACTIVE];
     if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->op=
tions,
                                           &c->c2.frame, frame_fragment,
-                                          get_link_socket_info(c)))
+                                          get_link_socket_info(c),
+                                          &c->c1.tuntap->dco))
     {
         msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
         register_signal(c->sig, SIGUSR1, "process-push-msg-failed");
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0e9591..50689e9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1584,7 +1584,8 @@
                                          struct options *options,
                                          struct frame *frame,
                                          struct frame *frame_fragment,
-                                         struct link_socket_info *lsi)
+                                         struct link_socket_info *lsi,
+                                         dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1631,6 +1632,26 @@
             return false;
         }
     }
+
+    if (dco_enabled(options))
+    {
+        /* dco_set_peer() must be called only when both
+        * keepalive and mss_fix are properly setted. */
+        if (options->ping_send_timeout || frame->mss_fix)
+        {
+            int ret =3D dco_set_peer(dco,
+                                   multi->dco_peer_id,
+                                   options->ping_send_timeout,
+                                   options->ping_rec_timeout,
+                                   frame->mss_fix);
+            if (ret < 0)
+            {
+                msg(D_DCO, "Cannot set DCO peer parameters for peer (id=3D=
%u): %s",
+                    multi->dco_peer_id, strerror(-ret));
+                return false;
+            }
+        }
+    }
     return tls_session_generate_data_channel_keys(multi, session);
 }

@@ -1639,7 +1660,8 @@
                                  struct tls_session *session,
                                  struct options *options, struct frame *fr=
ame,
                                  struct frame *frame_fragment,
-                                 struct link_socket_info *lsi)
+                                 struct link_socket_info *lsi,
+                                 dco_context_t *dco)
 {
     if (!check_session_cipher(session, options))
     {
@@ -1650,7 +1672,7 @@
     session->opt->crypto_flags |=3D options->imported_protocol_flags;

     return tls_session_update_crypto_params_do_work(multi, session, option=
s,
-                                                    frame, frame_fragment,=
 lsi);
+                                                    frame, frame_fragment,=
 lsi, dco);
 }


diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 1a45048..0e43961 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -457,6 +457,8 @@
  * @param frame_fragment  The fragment frame options.
  * @param lsi             link socket info to adjust MTU related options
  *                        depending on the current protocol
+ * @param dco             The dco context to perform dco_set_peer()
+ *                        whenever a crypto param update occurs.
  *
  * @return true if updating succeeded or keys are already generated, false=
 otherwise.
  */
@@ -465,7 +467,8 @@
                                       struct options *options,
                                       struct frame *frame,
                                       struct frame *frame_fragment,
-                                      struct link_socket_info *lsi);
+                                      struct link_socket_info *lsi,
+                                      dco_context_t *dco);

 /*
  * inline functions

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e079
Gerrit-Change-Number: 587
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--6SwwT1d3PXY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Ensures all params are ready before invoking =
dco_set_peer()<br><br>In UDP case the dco_set_peer() is currently perfomed =
at the wrong time<br>since the mssfix param is calculated later on in<br>tl=
s_session_update_crypto_params_do_work().<br>By moving the dco_set_peer() i=
nside the<br>tls_session_update_crypto_params_do_work() we will ensure that=
 all<br>crypto and frame params are properly initialized and if an update o=
ccurs<br>dco will be notified.<br><br>Change-Id: Ic8538e734dba53cd43fead396=
1e4401c8037e079<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2788...=
6...&gt;<br>---<br>M src/openvpn/init.c<br>M src/openvpn/multi.c<br>M src/o=
penvpn/ssl.c<br>M src/openvpn/ssl.h<br>4 files changed, 35 insertions(+), 2=
2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/87/587/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/i=
nit.c</span><br><span>index a49e563..0999f4d 100644</span><br><span>--- a/s=
rc/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>=
@@ -2359,7 +2359,8 @@</span><br><span>     if (!tls_session_update_crypto_p=
arams(c-&gt;c2.tls_multi, session,</span><br><span>                        =
                   &amp;c-&gt;options, &amp;c-&gt;c2.frame,</span><br><span=
>                                           frame_fragment,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
     get_link_socket_info(c)))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                          get_link_socket_info(c=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                         &amp;c-&gt;c1.tuntap-&gt;dco))</span><br><span>   =
  {</span><br><span>         msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: failed =
to import crypto options&quot;);</span><br><span>         return false;</sp=
an><br><span>@@ -2578,7 +2579,8 @@</span><br><span> </span><br><span>     i=
f (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, session, &amp;c-&g=
t;options,</span><br><span>                                           &amp;=
c-&gt;c2.frame, frame_fragment,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                          get_link_socket_info(c)=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                         get_link_socket_info(c),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                          &am=
p;c-&gt;c1.tuntap-&gt;dco))</span><br><span>     {</span><br><span>        =
 msg(D_TLS_ERRORS, &quot;ERROR: failed to set crypto cipher&quot;);</span><=
br><span>         return false;</span><br><span>diff --git a/src/openvpn/mu=
lti.c b/src/openvpn/multi.c</span><br><span>index 03177bb..0509911 100644</=
span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/=
multi.c</span><br><span>@@ -2364,21 +2364,6 @@</span><br><span>         ret=
urn false;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context.options.ping_send_ti=
meout || mi-&gt;context.c2.frame.mss_fix)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        ret =3D dco_set_peer(&amp;mi-&gt;context.c1.tuntap-&gt;dco,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
  mi-&gt;context.c2.tls_multi-&gt;dco_peer_id,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                           mi-&gt;context.options.=
ping_send_timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                        mi-&gt;context.options.ping_rec_timeout,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                           mi-&g=
t;context.c2.frame.mss_fix);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (ret &lt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(D_DCO, &quot;Cannot set DCO peer parameters for %s (id=3D%u): =
%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    multi_instance_string(mi, false, gc),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                mi-&gt;context.c2.tls_multi-&gt;dco_pee=
r_id, strerror(-ret));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            return false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span>@@ -2398,7 +2383,8 @@</span><br><span>     struct tls_session *s=
ession =3D &amp;c-&gt;c2.tls_multi-&gt;session[TM_ACTIVE];</span><br><span>=
     if (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, session, &am=
p;c-&gt;options,</span><br><span>                                          =
 &amp;c-&gt;c2.frame, frame_fragment,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                          get_link_socket_i=
nfo(c)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                               get_link_socket_info(c),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
   &amp;c-&gt;c1.tuntap-&gt;dco))</span><br><span>     {</span><br><span>  =
       msg(D_TLS_ERRORS, &quot;TLS Error: initializing data channel failed&=
quot;);</span><br><span>         register_signal(c-&gt;sig, SIGUSR1, &quot;=
process-push-msg-failed&quot;);</span><br><span>diff --git a/src/openvpn/ss=
l.c b/src/openvpn/ssl.c</span><br><span>index e0e9591..50689e9 100644</span=
><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c<=
/span><br><span>@@ -1584,7 +1584,8 @@</span><br><span>                     =
                     struct options *options,</span><br><span>             =
                             struct frame *frame,</span><br><span>         =
                                 struct frame *frame_fragment,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
       struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                         struct link_socke=
t_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                  dco_context_t *dco)</span><br><span> {</s=
pan><br><span>     if (session-&gt;key[KS_PRIMARY].crypto_options.key_ctx_b=
i.initialized)</span><br><span>     {</span><br><span>@@ -1631,6 +1632,26 @=
@</span><br><span>             return false;</span><br><span>         }</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled=
(options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dco_set_peer=
() must be called only when both</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        * keepalive and mss_fix are properly setted. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;pi=
ng_send_timeout || frame-&gt;mss_fix)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            int ret =3D dco_set_peer(dco,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                   multi-&gt;=
dco_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                            options-&gt;ping_send_timeout,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                   o=
ptions-&gt;ping_rec_timeout,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                   frame-&gt;mss_fix);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (ret &lt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO, &q=
uot;Cannot set DCO peer parameters for peer (id=3D%u): %s&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;=
dco_peer_id, strerror(-ret));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span>     return tls_session_generate_data_channel_key=
s(multi, session);</span><br><span> }</span><br><span> </span><br><span>@@ =
-1639,7 +1660,8 @@</span><br><span>                                  struct=
 tls_session *session,</span><br><span>                                  st=
ruct options *options, struct frame *frame,</span><br><span>               =
                   struct frame *frame_fragment,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                 struct link_soc=
ket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                            struct link_socket_info *lsi,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                 dco_=
context_t *dco)</span><br><span> {</span><br><span>     if (!check_session_=
cipher(session, options))</span><br><span>     {</span><br><span>@@ -1650,7=
 +1672,7 @@</span><br><span>     session-&gt;opt-&gt;crypto_flags |=3D opti=
ons-&gt;imported_protocol_flags;</span><br><span> </span><br><span>     ret=
urn tls_session_update_crypto_params_do_work(multi, session, options,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
                         frame, frame_fragment, lsi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
           frame, frame_fragment, lsi, dco);</span><br><span> }</span><br><=
span> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl.h b/s=
rc/openvpn/ssl.h</span><br><span>index 1a45048..0e43961 100644</span><br><s=
pan>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><=
br><span>@@ -457,6 +457,8 @@</span><br><span>  * @param frame_fragment  The=
 fragment frame options.</span><br><span>  * @param lsi             link so=
cket info to adjust MTU related options</span><br><span>  *                =
        depending on the current protocol</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param dco             The dco context to perform =
dco_set_peer()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
                     whenever a crypto param update occurs.</span><br><span=
>  *</span><br><span>  * @return true if updating succeeded or keys are alr=
eady generated, false otherwise.</span><br><span>  */</span><br><span>@@ -4=
65,7 +467,8 @@</span><br><span>                                       struc=
t options *options,</span><br><span>                                       =
struct frame *frame,</span><br><span>                                      =
 struct frame *frame_fragment,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                      struct link_socket_info *lsi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                     struct link_socket_info *lsi,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                      dco_co=
ntext_t *dco);</span><br><span> </span><br><span> /*</span><br><span>  * in=
line functions</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail">change 587</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/587?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8538e734dba53cd43fead3961e=
4401c8037e079 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--6SwwT1d3PXY=--


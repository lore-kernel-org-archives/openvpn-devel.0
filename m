From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 11:39:38 +0000
In-Reply-To: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
References: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <225e30a7c78450a3ed86dc2656eef42439e06436-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C/LZ5mDMMGs="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--C/LZ5mDMMGs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa, Code-Review-1 by cron2


Change subject: Ensures all params are ready before invoking dco_set_peer()
......................................................................

Ensures all params are ready before invoking dco_set_peer()

In UDP case, on a p2mp server, dco_set_peer() is currently called
at the wrong time since the mssfix param is calculated later on in
tls_session_update_crypto_params_do_work().

Move the dco_set_peer() inside tls_session_update_crypto_params_do_work(),
and remove p2p_set_dco_keepalive() to avoid calling dco_set_peer()
twice on the client side.

This way, we'll ensure that all crypto and frame params are properly
initialized and if an update occurs DCO will be notified.

Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e079
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20240906145745.67596-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
086.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
4 files changed, 34 insertions(+), 49 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/587/6

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4f63346..dd56961 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2178,27 +2178,6 @@
            || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }

-static bool
-p2p_set_dco_keepalive(struct context *c)
-{
-    if (dco_enabled(&c->options)
-        && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
-    {
-        int ret =3D dco_set_peer(&c->c1.tuntap->dco,
-                               c->c2.tls_multi->dco_peer_id,
-                               c->options.ping_send_timeout,
-                               c->options.ping_rec_timeout,
-                               c->c2.frame.mss_fix);
-        if (ret < 0)
-        {
-            msg(D_DCO, "Cannot set parameters for DCO peer (id=3D%u): %s",
-                c->c2.tls_multi->dco_peer_id, strerror(-ret));
-            return false;
-        }
-    }
-    return true;
-}
-
 /**
  * Helper function for tls_print_deferred_options_results
  * Adds the ", " delimitor if there already some data in the
@@ -2363,7 +2342,8 @@
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
@@ -2472,12 +2452,6 @@
             }
         }

-        if (c->mode =3D=3D MODE_POINT_TO_POINT && !p2p_set_dco_keepalive(c=
))
-        {
-            msg(D_TLS_ERRORS, "ERROR: Failed to apply DCO keepalive or MSS=
 fix parameters");
-            return false;
-        }
-
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save =3D c->c2.pulled_options_dige=
st;
@@ -2582,7 +2556,8 @@

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
index 8c72d0b..e2be614 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1591,7 +1591,8 @@
                                          struct options *options,
                                          struct frame *frame,
                                          struct frame *frame_fragment,
-                                         struct link_socket_info *lsi)
+                                         struct link_socket_info *lsi,
+                                         dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1638,6 +1639,25 @@
             return false;
         }
     }
+
+    if (dco_enabled(options))
+    {
+        /* dco_set_peer() must be called if either keepalive or
+         * mssfix are set to update in-kernel config */
+        if (options->ping_send_timeout || frame->mss_fix)
+        {
+            int ret =3D dco_set_peer(dco, multi->dco_peer_id,
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

@@ -1646,7 +1666,8 @@
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
@@ -1657,7 +1678,7 @@
     session->opt->crypto_flags |=3D options->imported_protocol_flags;

     return tls_session_update_crypto_params_do_work(multi, session, option=
s,
-                                                    frame, frame_fragment,=
 lsi);
+                                                    frame, frame_fragment,=
 lsi, dco);
 }


diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 6c2bfc3..eea1323 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -460,6 +460,8 @@
  * @param frame_fragment  The fragment frame options.
  * @param lsi             link socket info to adjust MTU related options
  *                        depending on the current protocol
+ * @param dco             The dco context to perform dco_set_peer()
+ *                        whenever a crypto param update occurs.
  *
  * @return true if updating succeeded or keys are already generated, false=
 otherwise.
  */
@@ -468,7 +470,8 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--C/LZ5mDMMGs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
587?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by stipa, Code-Review-1 by cron2</p><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Ensures all params are ready=
 before invoking dco_set_peer()<br><br>In UDP case, on a p2mp server, dco_s=
et_peer() is currently called<br>at the wrong time since the mssfix param i=
s calculated later on in<br>tls_session_update_crypto_params_do_work().<br>=
<br>Move the dco_set_peer() inside tls_session_update_crypto_params_do_work=
(),<br>and remove p2p_set_dco_keepalive() to avoid calling dco_set_peer()<b=
r>twice on the client side.<br><br>This way, we&#39;ll ensure that all cryp=
to and frame params are properly<br>initialized and if an update occurs DCO=
 will be notified.<br><br>Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e=
079<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>=
Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20240=
906145745.67596-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg29086.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/init.c<br>M src/open=
vpn/multi.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>4 files change=
d, 34 insertions(+), 49 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/87/587/6</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
init.c b/src/openvpn/init.c</span><br><span>index 4f63346..dd56961 100644</=
span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/i=
nit.c</span><br><span>@@ -2178,27 +2178,6 @@</span><br><span>            ||=
 !memcmp(a, &amp;zero, sizeof(struct sha256_digest));</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2p_set_dco_keep=
alive(struct context *c)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabl=
ed(&amp;c-&gt;options)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        &amp;&amp; (c-&gt;options.ping_send_timeout || c-&gt;c2.frame.mss_=
fix))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        int ret =3D dco_set_peer=
(&amp;c-&gt;c1.tuntap-&gt;dco,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                               c-&gt;c2.tls_multi-&gt;dco_peer_id,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
          c-&gt;options.ping_send_timeout,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                               c-&gt;options.ping_rec_=
timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                  c-&gt;c2.frame.mss_fix);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (ret &lt; 0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            msg(D_DCO, &quot;Cannot set parameters for DCO peer =
(id=3D%u): %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               c-&gt;c2.tls_multi-&gt;dco_peer_id, strerror(-ret));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /**</span><br><span>  * Helper function for tls_print_deferr=
ed_options_results</span><br><span>  * Adds the &quot;, &quot; delimitor if=
 there already some data in the</span><br><span>@@ -2363,7 +2342,8 @@</span=
><br><span>     if (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, s=
ession,</span><br><span>                                           &amp;c-&=
gt;options, &amp;c-&gt;c2.frame,</span><br><span>                          =
                 frame_fragment,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                          get_link_socket_info(c=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                          get_link_socket_info(c),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                          &a=
mp;c-&gt;c1.tuntap-&gt;dco))</span><br><span>     {</span><br><span>       =
  msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: failed to import crypto options&qu=
ot;);</span><br><span>         return false;</span><br><span>@@ -2472,12 +2=
452,6 @@</span><br><span>             }</span><br><span>         }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
c-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !p2p_set_dco_keepalive(c))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &qu=
ot;ERROR: Failed to apply DCO keepalive or MSS fix parameters&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         if (c-&gt=
;c2.did_open_tun)</span><br><span>         {</span><br><span>             c=
-&gt;c1.pulled_options_digest_save =3D c-&gt;c2.pulled_options_digest;</spa=
n><br><span>@@ -2582,7 +2556,8 @@</span><br><span> </span><br><span>     if=
 (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, session, &amp;c-&gt=
;options,</span><br><span>                                           &amp;c=
-&gt;c2.frame, frame_fragment,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                          get_link_socket_info(c))=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                        get_link_socket_info(c),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                          &amp=
;c-&gt;c1.tuntap-&gt;dco))</span><br><span>     {</span><br><span>         =
msg(D_TLS_ERRORS, &quot;ERROR: failed to set crypto cipher&quot;);</span><b=
r><span>         return false;</span><br><span>diff --git a/src/openvpn/mul=
ti.c b/src/openvpn/multi.c</span><br><span>index 03177bb..0509911 100644</s=
pan><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/m=
ulti.c</span><br><span>@@ -2364,21 +2364,6 @@</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context.options.ping_send_timeo=
ut || mi-&gt;context.c2.frame.mss_fix)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ret =3D dco_set_peer(&amp;mi-&gt;context.c1.tuntap-&gt;dco,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                           m=
i-&gt;context.c2.tls_multi-&gt;dco_peer_id,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                           mi-&gt;context.options.pin=
g_send_timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                     mi-&gt;context.options.ping_rec_timeout,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                           mi-&gt;c=
ontext.c2.frame.mss_fix);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (ret &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(D_DCO, &quot;Cannot set DCO peer parameters for %s (id=3D%u): %s&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 multi_instance_string(mi, false, gc),</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                mi-&gt;context.c2.tls_multi-&gt;dco_peer_i=
d, strerror(-ret));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span>     return true;</span><br><span> }</span><br><span> </span><b=
r><span>@@ -2398,7 +2383,8 @@</span><br><span>     struct tls_session *sess=
ion =3D &amp;c-&gt;c2.tls_multi-&gt;session[TM_ACTIVE];</span><br><span>   =
  if (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, session, &amp;c=
-&gt;options,</span><br><span>                                           &a=
mp;c-&gt;c2.frame, frame_fragment,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                          get_link_socket_info=
(c)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                            get_link_socket_info(c),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
 &amp;c-&gt;c1.tuntap-&gt;dco))</span><br><span>     {</span><br><span>    =
     msg(D_TLS_ERRORS, &quot;TLS Error: initializing data channel failed&qu=
ot;);</span><br><span>         register_signal(c-&gt;sig, SIGUSR1, &quot;pr=
ocess-push-msg-failed&quot;);</span><br><span>diff --git a/src/openvpn/ssl.=
c b/src/openvpn/ssl.c</span><br><span>index 8c72d0b..e2be614 100644</span><=
br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</s=
pan><br><span>@@ -1591,7 +1591,8 @@</span><br><span>                       =
                   struct options *options,</span><br><span>               =
                           struct frame *frame,</span><br><span>           =
                               struct frame *frame_fragment,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
     struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                         struct link_socket_=
info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                dco_context_t *dco)</span><br><span> {</spa=
n><br><span>     if (session-&gt;key[KS_PRIMARY].crypto_options.key_ctx_bi.=
initialized)</span><br><span>     {</span><br><span>@@ -1638,6 +1639,25 @@<=
/span><br><span>             return false;</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(o=
ptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dco_set_peer()=
 must be called if either keepalive or</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * mssfix are set to update in-kernel config */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-=
&gt;ping_send_timeout || frame-&gt;mss_fix)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            int ret =3D dco_set_peer(dco, multi-&gt;dco_peer_=
id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                   options-&gt;ping_send_timeout,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                   options-&g=
t;ping_rec_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                   frame-&gt;mss_fix);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (ret &lt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;Canno=
t set DCO peer parameters for peer (id=3D%u): %s&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;dco_peer_=
id, strerror(-ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     return tls_session_generate_data_channel_keys(multi, =
session);</span><br><span> }</span><br><span> </span><br><span>@@ -1646,7 +=
1666,8 @@</span><br><span>                                  struct tls_sess=
ion *session,</span><br><span>                                  struct opti=
ons *options, struct frame *frame,</span><br><span>                        =
          struct frame *frame_fragment,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                 struct link_socket_info =
*lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   struct link_socket_info *lsi,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                 dco_context_t=
 *dco)</span><br><span> {</span><br><span>     if (!check_session_cipher(se=
ssion, options))</span><br><span>     {</span><br><span>@@ -1657,7 +1678,7 =
@@</span><br><span>     session-&gt;opt-&gt;crypto_flags |=3D options-&gt;i=
mported_protocol_flags;</span><br><span> </span><br><span>     return tls_s=
ession_update_crypto_params_do_work(multi, session, options,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
                frame, frame_fragment, lsi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                                  =
  frame, frame_fragment, lsi, dco);</span><br><span> }</span><br><span> </s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvp=
n/ssl.h</span><br><span>index 6c2bfc3..eea1323 100644</span><br><span>--- a=
/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>=
@@ -460,6 +460,8 @@</span><br><span>  * @param frame_fragment  The fragment=
 frame options.</span><br><span>  * @param lsi             link socket info=
 to adjust MTU related options</span><br><span>  *                        d=
epending on the current protocol</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param dco             The dco context to perform dco_set_p=
eer()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
            whenever a crypto param update occurs.</span><br><span>  *</spa=
n><br><span>  * @return true if updating succeeded or keys are already gene=
rated, false otherwise.</span><br><span>  */</span><br><span>@@ -468,7 +470=
,8 @@</span><br><span>                                       struct options=
 *options,</span><br><span>                                       struct fr=
ame *frame,</span><br><span>                                       struct f=
rame *frame_fragment,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                      struct link_socket_info *lsi);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
            struct link_socket_info *lsi,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                      dco_context_t *=
dco);</span><br><span> </span><br><span> /*</span><br><span>  * inline func=
tions</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail">change 587</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/587?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8538e734dba53cd43fead3961e=
4401c8037e079 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--C/LZ5mDMMGs=--


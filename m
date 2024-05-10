From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 10 May 2024 11:07:32 +0000
References: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <115c9e4a18efea0807aafbc9aeabff9911c2ef81-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6Wkr53MA2zs="; charset=UTF-8
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

--6Wkr53MA2zs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail

to review the following change.


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
4 files changed, 34 insertions(+), 22 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/587/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ec0c309..b8420ad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2343,7 +2343,8 @@
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
@@ -2562,7 +2563,8 @@

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
index 162b23e..0425057 100644
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
index 7c49451..fa226f9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1572,7 +1572,8 @@
                                          struct options *options,
                                          struct frame *frame,
                                          struct frame *frame_fragment,
-                                         struct link_socket_info *lsi)
+                                         struct link_socket_info *lsi,
+                                         dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1619,6 +1620,25 @@
             return false;
         }
     }
+
+    if (dco_enabled(options))
+    {
+        int ret;
+        if (options->ping_send_timeout || frame->mss_fix)
+        {
+            ret =3D dco_set_peer(dco,
+                               multi->dco_peer_id,
+                               options->ping_send_timeout,
+                               options->ping_rec_timeout,
+                               frame->mss_fix);
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

@@ -1627,7 +1647,8 @@
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
@@ -1638,7 +1659,7 @@
     session->opt->crypto_flags |=3D options->imported_protocol_flags;

     return tls_session_update_crypto_params_do_work(multi, session, option=
s,
-                                                    frame, frame_fragment,=
 lsi);
+                                                    frame, frame_fragment,=
 lsi, dco);
 }


diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 98e59e8..c0d855a 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -452,6 +452,8 @@
  * @param frame_fragment  The fragment frame options.
  * @param lsi             link socket info to adjust MTU related options
  *                        depending on the current protocol
+ * @param dco             The dco context to perform dco_set_peer()
+ *                        whenever a crypto param update occur.
  *
  * @return true if updating succeeded or keys are already generated, false=
 otherwise.
  */
@@ -460,7 +462,8 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--6Wkr53MA2zs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Ensures all params are ready before invoking dco_set_peer()<b=
r><br>In UDP case the dco_set_peer() is currently perfomed at the wrong tim=
e<br>since the mssfix param is calculated later on in<br>tls_session_update=
_crypto_params_do_work().<br>By moving the dco_set_peer() inside the<br>tls=
_session_update_crypto_params_do_work() we will ensure that all<br>crypto a=
nd frame params are properly initialized and if an update occurs<br>dco wil=
l be notified.<br><br>Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e079<=
br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<=
br>M src/openvpn/init.c<br>M src/openvpn/multi.c<br>M src/openvpn/ssl.c<br>=
M src/openvpn/ssl.h<br>4 files changed, 34 insertions(+), 22 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/58=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br>=
<span>index ec0c309..b8420ad 100644</span><br><span>--- a/src/openvpn/init.=
c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2343,7 +2343=
,8 @@</span><br><span>     if (!tls_session_update_crypto_params(c-&gt;c2.t=
ls_multi, session,</span><br><span>                                        =
   &amp;c-&gt;options, &amp;c-&gt;c2.frame,</span><br><span>               =
                            frame_fragment,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                          get_link_so=
cket_info(c)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                     get_link_socket_info(c),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
         &amp;c-&gt;c1.tuntap-&gt;dco))</span><br><span>     {</span><br><s=
pan>         msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: failed to import crypto=
 options&quot;);</span><br><span>         return false;</span><br><span>@@ =
-2562,7 +2563,8 @@</span><br><span> </span><br><span>     if (!tls_session_=
update_crypto_params(c-&gt;c2.tls_multi, session, &amp;c-&gt;options,</span=
><br><span>                                           &amp;c-&gt;c2.frame, =
frame_fragment,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                    get_link_socket_info(c)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
         get_link_socket_info(c),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                          &amp;c-&gt;c1.tunta=
p-&gt;dco))</span><br><span>     {</span><br><span>         msg(D_TLS_ERROR=
S, &quot;ERROR: failed to set crypto cipher&quot;);</span><br><span>       =
  return false;</span><br><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index 162b23e..0425057 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -2364,21 +2364,6 @@</span><br><span>         return false;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (mi-&gt;context.options.ping_send_timeout || mi-&gt;co=
ntext.c2.frame.mss_fix)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =
=3D dco_set_peer(&amp;mi-&gt;context.c1.tuntap-&gt;dco,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                           mi-&gt;context=
.c2.tls_multi-&gt;dco_peer_id,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                           mi-&gt;context.options.ping_send_timeou=
t,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
        mi-&gt;context.options.ping_rec_timeout,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                           mi-&gt;context.c2.fra=
me.mss_fix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (ret &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_D=
CO, &quot;Cannot set DCO peer parameters for %s (id=3D%u): %s&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                multi_instan=
ce_string(mi, false, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                mi-&gt;context.c2.tls_multi-&gt;dco_peer_id, strerror(-=
ret));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> =
    return true;</span><br><span> }</span><br><span> </span><br><span>@@ -2=
398,7 +2383,8 @@</span><br><span>     struct tls_session *session =3D &amp;=
c-&gt;c2.tls_multi-&gt;session[TM_ACTIVE];</span><br><span>     if (!tls_se=
ssion_update_crypto_params(c-&gt;c2.tls_multi, session, &amp;c-&gt;options,=
</span><br><span>                                           &amp;c-&gt;c2.f=
rame, frame_fragment,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                          get_link_socket_info(c)))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
               get_link_socket_info(c),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                          &amp;c-&gt;c1=
.tuntap-&gt;dco))</span><br><span>     {</span><br><span>         msg(D_TLS=
_ERRORS, &quot;TLS Error: initializing data channel failed&quot;);</span><b=
r><span>         register_signal(c-&gt;sig, SIGUSR1, &quot;process-push-msg=
-failed&quot;);</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvp=
n/ssl.c</span><br><span>index 7c49451..fa226f9 100644</span><br><span>--- a=
/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>=
@@ -1572,7 +1572,8 @@</span><br><span>                                     =
     struct options *options,</span><br><span>                             =
             struct frame *frame,</span><br><span>                         =
                 struct frame *frame_fragment,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                         struct li=
nk_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                         struct link_socket_info *lsi,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                  dco_context_t *dco)</span><br><span> {</span><br><span>  =
   if (session-&gt;key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)</=
span><br><span>     {</span><br><span>@@ -1619,6 +1620,25 @@</span><br><spa=
n>             return false;</span><br><span>         }</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(options))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        int ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;ping_send_timeout=
 || frame-&gt;mss_fix)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     ret =3D dco_set_peer(dco,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                               multi-&gt;dco_peer_id,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
 options-&gt;ping_send_timeout,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                               options-&gt;ping_rec_timeout,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
         frame-&gt;mss_fix);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (ret &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                msg(D_DCO, &quot;Cannot set DCO peer parameters =
for peer (id=3D%u): %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    multi-&gt;dco_peer_id, strerror(-ret));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     retu=
rn tls_session_generate_data_channel_keys(multi, session);</span><br><span>=
 }</span><br><span> </span><br><span>@@ -1627,7 +1647,8 @@</span><br><span>=
                                  struct tls_session *session,</span><br><s=
pan>                                  struct options *options, struct frame=
 *frame,</span><br><span>                                  struct frame *fr=
ame_fragment,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                         struct link_socket_info *lsi)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 struct =
link_socket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                 dco_context_t *dco)</span><br><span> {<=
/span><br><span>     if (!check_session_cipher(session, options))</span><br=
><span>     {</span><br><span>@@ -1638,7 +1659,7 @@</span><br><span>     se=
ssion-&gt;opt-&gt;crypto_flags |=3D options-&gt;imported_protocol_flags;</s=
pan><br><span> </span><br><span>     return tls_session_update_crypto_param=
s_do_work(multi, session, options,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                                    frame, fra=
me_fragment, lsi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                                   frame, frame_fragment, l=
si, dco);</span><br><span> }</span><br><span> </span><br><span> </span><br>=
<span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>in=
dex 98e59e8..c0d855a 100644</span><br><span>--- a/src/openvpn/ssl.h</span><=
br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -452,6 +452,8 @@</span>=
<br><span>  * @param frame_fragment  The fragment frame options.</span><br>=
<span>  * @param lsi             link socket info to adjust MTU related opt=
ions</span><br><span>  *                        depending on the current pr=
otocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dco=
             The dco context to perform dco_set_peer()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *                        whenever a cry=
pto param update occur.</span><br><span>  *</span><br><span>  * @return tru=
e if updating succeeded or keys are already generated, false otherwise.</sp=
an><br><span>  */</span><br><span>@@ -460,7 +462,8 @@</span><br><span>     =
                                  struct options *options,</span><br><span>=
                                       struct frame *frame,</span><br><span=
>                                       struct frame *frame_fragment,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
           struct link_socket_info *lsi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                      struct link_soc=
ket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                 dco_context_t *dco);</span><br><span> </sp=
an><br><span> /*</span><br><span>  * inline functions</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/587?usp=3Demail">change 587</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8538e734dba53cd43fead3961e=
4401c8037e079 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--6Wkr53MA2zs=--


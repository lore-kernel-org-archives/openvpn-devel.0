From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 1 Jun 2024 20:27:39 +0000
In-Reply-To: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
References: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <67364f1d787f9b9f34fa2925d748076545c6220d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="44uDSYbAhKw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow the TLS
 session to send out TLS alerts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--44uDSYbAhKw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/44=
9?usp=3Demail )

Change subject: Allow the TLS session to send out TLS alerts
......................................................................

Allow the TLS session to send out TLS alerts

Previous OpenVPN versions shut down the TLS control channel immediately
when encountering an error. This also meant that we would not send out
TLS alerts to notify a client about potential problems like mismatching
TLS versions or having no common cipher.

This commit adds a new key_state S_ERROR_PRE which still allows to
send out the remaining TLS packets of the control session which are
typically the alert message and then going to S_ERROR. We do not
wait for retries. So this is more a one-shot notify but that is
acceptable in this situation.

Sending out alerts is a slight compromise in security as alerts give
out a bit of information that otherwise is not given
out. But since all other consumers TLS implementations are already doing th=
is
and TLS implementations (nowadays) are very careful not to leak (sensitive)
information by alerts and since the user experience is much better with
alerts, this compromise is worth it.

Change-Id: I0ad48915004ddee587e97c8ed190ba8ee989e48d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240408124933.243991-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
540.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M src/openvpn/ssl.c
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
6 files changed, 87 insertions(+), 19 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index 4bc3bb3..439352a 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,5 +1,14 @@
 Overview of changes in 2.7
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+New features
+------------
+TLS alerts
+    OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS
+    session shuts down or when the TLS implementation informs the peer abo=
ut
+    an error in the TLS session (e.g. mismatching TLS versions). This impr=
oves
+    the user experience as the client shows an error instead of running in=
to
+    a timeout when the server just stops responding completely.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7c49451..2054eb4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -690,6 +690,9 @@
         case S_ERROR:
             return "S_ERROR";

+        case S_ERROR_PRE:
+            return "S_ERROR_PRE";
+
         case S_GENERATED_KEYS:
             return "S_GENERATED_KEYS";

@@ -2683,6 +2686,25 @@
 }

 static bool
+check_outgoing_ciphertext(struct key_state *ks, struct tls_session *sessio=
n,
+                          bool *continue_tls_process)
+{
+    /* Outgoing Ciphertext to reliable buffer */
+    if (ks->state >=3D S_START)
+    {
+        struct buffer *buf =3D reliable_get_buf_output_sequenced(ks->send_=
reliable);
+        if (buf)
+        {
+            if (!write_outgoing_tls_ciphertext(session, continue_tls_proce=
ss))
+            {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
+static bool
 tls_process_state(struct tls_multi *multi,
                   struct tls_session *session,
                   struct buffer *to_link,
@@ -2706,7 +2728,7 @@
     }

     /* Are we timed out on receive? */
-    if (now >=3D ks->must_negotiate && ks->state < S_ACTIVE)
+    if (now >=3D ks->must_negotiate && ks->state >=3D S_UNDEF && ks->state=
 < S_ACTIVE)
     {
         msg(D_TLS_ERRORS,
             "TLS Error: TLS key negotiation failed to occur within %d seco=
nds (check your network connectivity)",
@@ -2760,6 +2782,16 @@
         return false;
     }

+    if (ks->state =3D=3D S_ERROR_PRE)
+    {
+        /* When we end up here, we had one last chance to send an outstand=
ing
+         * packet that contained an alert. We do not ensure that this pack=
et
+         * has been successfully delivered  (ie wait for the ACK etc)
+         * but rather stop processing now */
+        ks->state =3D S_ERROR;
+        return false;
+    }
+
     /* Write incoming ciphertext to TLS object */
     struct reliable_entry *entry =3D reliable_get_entry_sequenced(ks->rec_=
reliable);
     if (entry)
@@ -2840,29 +2872,31 @@
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
-
-    /* Outgoing Ciphertext to reliable buffer */
-    if (ks->state >=3D S_START)
+    if (!check_outgoing_ciphertext(ks, session, &continue_tls_process))
     {
-        buf =3D reliable_get_buf_output_sequenced(ks->send_reliable);
-        if (buf)
-        {
-            if (!write_outgoing_tls_ciphertext(session, &continue_tls_proc=
ess))
-            {
-                goto error;
-            }
-        }
+        goto error;
     }

     return continue_tls_process;
 error:
     tls_clear_error();
-    ks->state =3D S_ERROR;
+
+    /* Shut down the TLS session but do a last read from the TLS
+     * object to be able to read potential TLS alerts */
+    key_state_ssl_shutdown(&ks->ks_ssl);
+    check_outgoing_ciphertext(ks, session, &continue_tls_process);
+
+    /* Put ourselves in the pre error state that will only send out the
+     * control channel packets but nothing else */
+    ks->state =3D S_ERROR_PRE;
+
     msg(D_TLS_ERRORS, "TLS Error: TLS handshake failed");
     INCR_ERROR;
-    return false;
-
+    return true;
 }
+
+
+
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2970,7 +3004,7 @@
     }
=20
     /* When should we wake up again? */
-    if (ks->state >=3D S_INITIAL)
+    if (ks->state >=3D S_INITIAL || ks->state =3D=3D S_ERROR_PRE)
     {
         compute_earliest_wakeup(wakeup,
                                 reliable_send_timeout(ks->send_reliable));
@@ -3123,7 +3157,7 @@
              session_id_print(&ks->session_id_remote, &gc),
              print_link_socket_actual(&ks->remote_addr, &gc));

-        if (ks->state >=3D S_INITIAL && link_socket_actual_defined(&ks->re=
mote_addr))
+        if ((ks->state >=3D S_INITIAL || ks->state =3D=3D S_ERROR_PRE) && =
 link_socket_actual_defined(&ks->remote_addr))
         {
             struct link_socket_actual *tla =3D NULL;

@@ -3201,7 +3235,8 @@
             {
                 msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion faile=
d");
                 ks->authenticated =3D KS_AUTH_FALSE;
-                ks->state =3D S_ERROR;
+                key_state_ssl_shutdown(&ks->ks_ssl);
+                ks->state =3D S_ERROR_PRE;
             }

             /* Update auth token on the client if needed on renegotiation
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 8c3403c..285705f 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -363,6 +363,13 @@
                         const struct tls_root_ctx *ssl_ctx, bool is_server=
, struct tls_session *session);

 /**
+ * Sets a TLS session to be shutdown state, so the TLS library will genera=
te
+ * a shutdown alert.
+ */
+void
+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl);
+
+/**
  * Free the SSL channel part of the given key state.
  *
  * @param ks_ssl        The SSL channel's state info to free
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5a7dd60..5bc2f2a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -74,7 +74,10 @@
  *
  * @{
  */
-#define S_ERROR          -1     /**< Error state.  */
+#define S_ERROR         (-2)     /**< Error state.  */
+#define S_ERROR_PRE     (-1)     /**< Error state but try to send out aler=
ts
+                                  *  before killing the keystore and moving
+                                  *  it to S_ERROR */
 #define S_UNDEF           0     /**< Undefined state, used after a \c
                                  *   key_state is cleaned up. */
 #define S_INITIAL         1     /**< Initial \c key_state state after
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b0303b6..a68588e 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1276,6 +1276,14 @@
                         ssl_bio_read, NULL);
 }

+
+void
+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl)
+{
+    mbedtls_ssl_send_alert_message(ks_ssl->ctx, MBEDTLS_SSL_ALERT_LEVEL_FA=
TAL,
+                                   MBEDTLS_SSL_ALERT_MSG_CLOSE_NOTIFY);
+}
+
 void
 key_state_ssl_free(struct key_state_ssl *ks_ssl)
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 7e74f2f..e8a30a3 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1941,6 +1941,12 @@
 }

 void
+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl)
+{
+    SSL_set_shutdown(ks_ssl->ssl, SSL_SENT_SHUTDOWN | SSL_RECEIVED_SHUTDOW=
N);
+}
+
+void
 key_state_ssl_free(struct key_state_ssl *ks_ssl)
 {
     if (ks_ssl->ssl)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ad48915004ddee587e97c8ed190ba8ee989e48d
Gerrit-Change-Number: 449
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--44uDSYbAhKw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/449?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Allow the TLS session to send out TLS alerts<b=
r><br>Previous OpenVPN versions shut down the TLS control channel immediate=
ly<br>when encountering an error. This also meant that we would not send ou=
t<br>TLS alerts to notify a client about potential problems like mismatchin=
g<br>TLS versions or having no common cipher.<br><br>This commit adds a new=
 key_state S_ERROR_PRE which still allows to<br>send out the remaining TLS =
packets of the control session which are<br>typically the alert message and=
 then going to S_ERROR. We do not<br>wait for retries. So this is more a on=
e-shot notify but that is<br>acceptable in this situation.<br><br>Sending o=
ut alerts is a slight compromise in security as alerts give<br>out a bit of=
 information that otherwise is not given<br>out. But since all other consum=
ers TLS implementations are already doing this<br>and TLS implementations (=
nowadays) are very careful not to leak (sensitive)<br>information by alerts=
 and since the user experience is much better with<br>alerts, this compromi=
se is worth it.<br><br>Change-Id: I0ad48915004ddee587e97c8ed190ba8ee989e48d=
<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240408124933.2439=
91-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg28540.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M Changes.rst<br>M src/openvpn/ssl.c<br>M src/o=
penvpn/ssl_backend.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_mbe=
dtls.c<br>M src/openvpn/ssl_openssl.c<br>6 files changed, 87 insertions(+),=
 19 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 4bc3bb3..43=
9352a 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -1,5 +1,14 @@</span><br><span> Overview of changes=
 in 2.7</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+New features</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TLS=
 alerts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN =
2.7 will send out TLS alerts to peers informing them if the TLS</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    session shuts down or when =
the TLS implementation informs the peer about</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    an error in the TLS session (e.g. mismatching=
 TLS versions). This improves</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    the user experience as the client shows an error instead of r=
unning into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a ti=
meout when the server just stops responding completely.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecated features</=
span><br><span> -------------------</span><br><span> ``secret`` support has=
 been removed by default.</span><br><span>diff --git a/src/openvpn/ssl.c b/=
src/openvpn/ssl.c</span><br><span>index 7c49451..2054eb4 100644</span><br><=
span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span>=
<br><span>@@ -690,6 +690,9 @@</span><br><span>         case S_ERROR:</span>=
<br><span>             return &quot;S_ERROR&quot;;</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case S_ERROR_PRE:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return &=
quot;S_ERROR_PRE&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>         case S_GENERATED_KEYS:</span><br><span>      =
       return &quot;S_GENERATED_KEYS&quot;;</span><br><span> </span><br><sp=
an>@@ -2683,6 +2686,25 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+che=
ck_outgoing_ciphertext(struct key_state *ks, struct tls_session *session,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
     bool *continue_tls_process)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Outgoing Ciphertext to reliable buffer */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (ks-&gt;state &gt;=3D S_START)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer *buf =3D reliable_get_buf=
_output_sequenced(ks-&gt;send_reliable);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (buf)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!write_outgoing_tls_ciphertext(session, continue_tl=
s_process))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static bool</span><br><span> tls_process_state(struct tls_multi *multi,</s=
pan><br><span>                   struct tls_session *session,</span><br><sp=
an>                   struct buffer *to_link,</span><br><span>@@ -2706,7 +2=
728,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* A=
re we timed out on receive? */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (now &gt;=3D ks-&gt;must_negotiate &amp;&amp; ks-&gt;state =
&lt; S_ACTIVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (now &gt;=3D ks-&gt;must_negotiate &amp;&amp; ks-&gt;state &gt;=3D S_UNDE=
F &amp;&amp; ks-&gt;state &lt; S_ACTIVE)</span><br><span>     {</span><br><=
span>         msg(D_TLS_ERRORS,</span><br><span>             &quot;TLS Erro=
r: TLS key negotiation failed to occur within %d seconds (check your networ=
k connectivity)&quot;,</span><br><span>@@ -2760,6 +2782,16 @@</span><br><sp=
an>         return false;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;state =3D=3D =
S_ERROR_PRE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* When we en=
d up here, we had one last chance to send an outstanding</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * packet that contained an al=
ert. We do not ensure that this packet</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * has been successfully delivered  (ie wait for=
 the ACK etc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * but rather stop processing now */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ks-&gt;state =3D S_ERROR;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     /* Write incoming ciphertext to=
 TLS object */</span><br><span>     struct reliable_entry *entry =3D reliab=
le_get_entry_sequenced(ks-&gt;rec_reliable);</span><br><span>     if (entry=
)</span><br><span>@@ -2840,29 +2872,31 @@</span><br><span>             dmsg=
(D_TLS_DEBUG, &quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Outg=
oing Ciphertext to reliable buffer */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (ks-&gt;state &gt;=3D S_START)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!check_outgoing_ciphertext(ks, se=
ssion, &amp;continue_tls_process))</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        buf =3D reliable_get_buf_output=
_sequenced(ks-&gt;send_reliable);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (buf)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (!write_outgoing_tls_ciphertext(session, &amp;continue_tls_proces=
s))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto error=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span>  =
   }</span><br><span> </span><br><span>     return continue_tls_process;</s=
pan><br><span> error:</span><br><span>     tls_clear_error();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ks-&gt;state =3D S_ERROR;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Shut down the TLS session but do a la=
st read from the TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * object to be able to read potential TLS alerts */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    key_state_ssl_shutdown(&amp;ks-&g=
t;ks_ssl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check=
_outgoing_ciphertext(ks, session, &amp;continue_tls_process);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Put ourselves in the pre error state that wil=
l only send out the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * control channel packets but nothing else */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ks-&gt;state =3D S_ERROR_PRE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(D_TL=
S_ERRORS, &quot;TLS Error: TLS handshake failed&quot;);</span><br><span>   =
  INCR_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * This is the =
primary routine for processing TLS stuff inside the</span><br><span>  * the=
 main event loop.  When this routine exits</span><br><span>@@ -2970,7 +3004=
,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* When=
 should we wake up again? */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (ks-&gt;state &gt;=3D S_INITIAL)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (ks-&gt;state &gt;=3D S_INITIAL || ks-&gt=
;state =3D=3D S_ERROR_PRE)</span><br><span>     {</span><br><span>         =
compute_earliest_wakeup(wakeup,</span><br><span>                           =
      reliable_send_timeout(ks-&gt;send_reliable));</span><br><span>@@ -312=
3,7 +3157,7 @@</span><br><span>              session_id_print(&amp;ks-&gt;s=
ession_id_remote, &amp;gc),</span><br><span>              print_link_socket=
_actual(&amp;ks-&gt;remote_addr, &amp;gc));</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;state &gt;=3D S_=
INITIAL &amp;&amp; link_socket_actual_defined(&amp;ks-&gt;remote_addr))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((ks-&gt;sta=
te &gt;=3D S_INITIAL || ks-&gt;state =3D=3D S_ERROR_PRE) &amp;&amp;  link_s=
ocket_actual_defined(&amp;ks-&gt;remote_addr))</span><br><span>         {</=
span><br><span>             struct link_socket_actual *tla =3D NULL;</span>=
<br><span> </span><br><span>@@ -3201,7 +3235,8 @@</span><br><span>         =
    {</span><br><span>                 msg(D_TLS_ERRORS, &quot;TLS Error: g=
enerate_key_expansion failed&quot;);</span><br><span>                 ks-&g=
t;authenticated =3D KS_AUTH_FALSE;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                ks-&gt;state =3D S_ERROR;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                key_state_ssl_shutdown(&=
amp;ks-&gt;ks_ssl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ks-&gt;state =3D S_ERROR_PRE;</span><br><span>             =
}</span><br><span> </span><br><span>             /* Update auth token on th=
e client if needed on renegotiation</span><br><span>diff --git a/src/openvp=
n/ssl_backend.h b/src/openvpn/ssl_backend.h</span><br><span>index 8c3403c..=
285705f 100644</span><br><span>--- a/src/openvpn/ssl_backend.h</span><br><s=
pan>+++ b/src/openvpn/ssl_backend.h</span><br><span>@@ -363,6 +363,13 @@</s=
pan><br><span>                         const struct tls_root_ctx *ssl_ctx, =
bool is_server, struct tls_session *session);</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets a =
TLS session to be shutdown state, so the TLS library will generate</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * a shutdown alert.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Free the SSL chan=
nel part of the given key state.</span><br><span>  *</span><br><span>  * @p=
aram ks_ssl        The SSL channel&#39;s state info to free</span><br><span=
>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br=
><span>index 5a7dd60..5bc2f2a 100644</span><br><span>--- a/src/openvpn/ssl_=
common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ =
-74,7 +74,10 @@</span><br><span>  *</span><br><span>  * @{</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_ERROR  =
        -1     /**&lt; Error state.  */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define S_ERROR         (-2)     /**&lt; Error state.  =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S_ERROR_P=
RE     (-1)     /**&lt; Error state but try to send out alerts</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
  *  before killing the keystore and moving</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                  *  it to S_ERROR =
*/</span><br><span> #define S_UNDEF           0     /**&lt; Undefined state=
, used after a \c</span><br><span>                                  *   key=
_state is cleaned up. */</span><br><span> #define S_INITIAL         1     /=
**&lt; Initial \c key_state state after</span><br><span>diff --git a/src/op=
envpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index b0303=
b6..a68588e 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><b=
r><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1276,6 +1276,14=
 @@</span><br><span>                         ssl_bio_read, NULL);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+key_state_ssl_shutdown(str=
uct key_state_ssl *ks_ssl)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls=
_ssl_send_alert_message(ks_ssl-&gt;ctx, MBEDTLS_SSL_ALERT_LEVEL_FATAL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
           MBEDTLS_SSL_ALERT_MSG_CLOSE_NOTIFY);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> void</span><br><span> key_state_ssl_free(struct=
 key_state_ssl *ks_ssl)</span><br><span> {</span><br><span>diff --git a/src=
/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 7e=
74f2f..e8a30a3 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span=
><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -1941,6 +1941=
,12 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+key_state_ssl_shutdown(struct=
 key_state_ssl *ks_ssl)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SSL_set_sh=
utdown(ks_ssl-&gt;ssl, SSL_SENT_SHUTDOWN | SSL_RECEIVED_SHUTDOWN);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span> key_state_ssl_free(struct key_state_ssl *ks=
_ssl)</span><br><span> {</span><br><span>     if (ks_ssl-&gt;ssl)</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/449?usp=3Demail">change 449</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
49?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ad48915004ddee587e97c8ed19=
0ba8ee989e48d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 449 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--44uDSYbAhKw=--


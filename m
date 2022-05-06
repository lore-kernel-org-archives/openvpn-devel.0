From: Kristof Provost <kprovost@...2661...>
Date: Fri, 06 May 2022 14:09:18 +0200
Message-ID: <91AFBF0B-D93C-49DE-9D5D-D4EAD608A473@...2661...>
In-Reply-To: <20220429170236.48239-3-kprovost@...2661...>
References: <20220429170236.48239-1-kprovost@...2661...>
 <20220429170236.48239-3-kprovost@...2661...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_56225D2C-620F-4BD2-8D88-4F0217CC886C_="
Content-Transfer-Encoding: 8bit
Subject: Re: [Openvpn-devel] [PATCH 2/4] rework do_up() for correct order of
 DCO operations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=_MailMate_56225D2C-620F-4BD2-8D88-4F0217CC886C_=
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 29 Apr 2022, at 19:02, Kristof Provost wrote:
> From: Kristof Provost <kp@...1376...>
>
> We must create the peer before we can dco_set_peer or dco_new_key.
> On the other hand, we must first process options, because those may
> change our peer id and we should create the peer with the correct id.
>
> Split up do_deferred_options() in do_deferred_options() and
> finish_options(). Call any DCO configuration operations (i.e.
> dco_set_peer()/dco_new_key()) after we've created the peer (i.e.
> dco_new_peer()).
>
> Signed-off-by: Kristof Provost <kprovost@...2661...>
> ---
>  src/openvpn/init.c  | 112 
> +++++++++++++++++++++++++-------------------
>  src/openvpn/init.h  |   2 +
>  src/openvpn/multi.c |   2 +
>  3 files changed, 68 insertions(+), 48 deletions(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 8496e21f..5d53cf7e 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2100,26 +2100,26 @@ do_up(struct context *c, bool pulled_options, 
> unsigned int option_types_found)
>              }
>          }
>
> -        if ((c->mode == MODE_POINT_TO_POINT) && c->c2.did_open_tun)
> +        if (pulled_options)
>          {
> -            /* If we are in DCO mode we need to set the new peer 
> options now */
> -            int ret = dco_p2p_add_new_peer(c);
> -            if (ret < 0)
> +            if (!do_deferred_options(c, option_types_found))
>              {
> -                msg(D_DCO, "Cannot add peer to DCO: %s", 
> strerror(-ret));
> +                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push 
> options");
>                  return false;
>              }
>          }
> -
> -        if (pulled_options)
> +        if (c->mode == MODE_POINT_TO_POINT)
>          {
> -            if (!do_deferred_options(c, option_types_found))
> +            /* If we are in DCO mode we need to set the new peer 
> options now */
> +            int ret = dco_p2p_add_new_peer(c);
> +            if (ret < 0)
>              {
> -                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push 
> options");
> +                msg(D_DCO, "Cannot add peer to DCO: %s", 
> strerror(-ret));
>                  return false;
>              }
>          }
> -        else if (c->mode == MODE_POINT_TO_POINT)
> +
> +        if (!pulled_options && c->mode == MODE_POINT_TO_POINT)
>          {
>              if (!do_deferred_p2p_ncp(c))
>              {
> @@ -2128,6 +2128,13 @@ do_up(struct context *c, bool pulled_options, 
> unsigned int option_types_found)
>              }
>          }
>
> +
> +        if (!finish_options(c))
> +        {
> +            msg(D_TLS_ERRORS, "ERROR: Failed to finish option 
> processing");
> +            return false;
> +        }
> +
>          if (c->c2.did_open_tun)
>          {
>              c->c1.pulled_options_digest_save = 
> c->c2.pulled_options_digest;
> @@ -2344,49 +2351,58 @@ do_deferred_options(struct context *c, const 
> unsigned int found)
>          {
>              return false;
>          }
> -        struct frame *frame_fragment = NULL;
> +    }
> +
> +    return true;
> +}
> +
> +bool
> +finish_options(struct context *c)
> +{
> +    if (!c->options.pull || !dco_enabled(&c->options))
> +    {
> +        return true;
> +    }
> +
> +    struct frame *frame_fragment = NULL;
>  #ifdef ENABLE_FRAGMENT
> -        if (c->options.ce.fragment)
> -        {
> -            frame_fragment = &c->c2.frame_fragment;
> -        }
> +    if (c->options.ce.fragment)
> +    {
> +        frame_fragment = &c->c2.frame_fragment;
> +    }
>  #endif
>
> -        struct tls_session *session = 
> &c->c2.tls_multi->session[TM_ACTIVE];
> -        if (!tls_session_update_crypto_params(c->c2.tls_multi, 
> session,
> -                                              &c->options, 
> &c->c2.frame,
> -                                              frame_fragment,
> -                                              
> get_link_socket_info(c)))
> -        {
> -            msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto 
> options");
> -            return false;
> -        }
> +    struct tls_session *session = 
> &c->c2.tls_multi->session[TM_ACTIVE];
> +    if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
> +                                          &c->options, &c->c2.frame,
> +                                          frame_fragment,
> +                                          get_link_socket_info(c)))
> +    {
> +        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto 
> options");
> +        return false;
> +    }
>
> -        if (dco_enabled(&c->options))
> -        {
> -            /* Check if the pushed options are compatible with DCO if 
> we have
> -             * DCO enabled */
> -            if (!check_dco_pull_options(&c->options))
> -            {
> -                msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are 
> incompatible with "
> -                    "data channel offload. Use --disable-dco to 
> connect"
> -                    "to this server");
> -                return false;
> -            }
> +    /* Check if the pushed options are compatible with DCO if we have
> +     * DCO enabled */
> +    if (!check_dco_pull_options(&c->options))
> +    {
> +        msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are 
> incompatible with "
> +            "data channel offload. Use --disable-dco to connect"
> +            "to this server");
> +        return false;
> +    }
>
> -            if (c->options.ping_send_timeout || c->c2.frame.mss_fix)
> -            {
> -                int ret = dco_set_peer(&c->c1.tuntap->dco,
> -                                       c->c2.tls_multi->peer_id,
> -                                       c->options.ping_send_timeout,
> -                                       c->options.ping_rec_timeout,
> -                                       c->c2.frame.mss_fix);
> -                if (ret < 0)
> -                {
> -                    msg(D_DCO, "Cannot set DCO peer: %s", 
> strerror(-ret));
> -                    return false;
> -                }
> -            }
> +    if (c->options.ping_send_timeout || c->c2.frame.mss_fix)
> +    {
> +        int ret = dco_set_peer(&c->c1.tuntap->dco,
> +                               c->c2.tls_multi->peer_id,
> +                               c->options.ping_send_timeout,
> +                               c->options.ping_rec_timeout,
> +                               c->c2.frame.mss_fix);
> +        if (ret < 0)
> +        {
> +            msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
> +            return false;
>          }
>      }
>      return true;
> diff --git a/src/openvpn/init.h b/src/openvpn/init.h
> index 1c341da3..5cc2a990 100644
> --- a/src/openvpn/init.h
> +++ b/src/openvpn/init.h
> @@ -97,6 +97,8 @@ void reset_coarse_timers(struct context *c);
>
>  bool do_deferred_options(struct context *c, const unsigned int 
> found);
>
> +bool finish_options(struct context *c);
> +
>  void inherit_context_child(struct context *dest,
>                             const struct context *src);
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 958712f1..47e1c6cc 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2452,6 +2452,8 @@ multi_client_connect_late_setup(struct 
> multi_context *m,
>          mi->context.c2.tls_multi->multi_state = CAS_FAILED;
>      }
>
> +    finish_options(&mi->context);
> +
>      /* send push reply if ready */
>      if (mi->context.c2.push_request_received)
>      {
> -- 
This patch isn’t quite right. It works well for DCO, but breaks 
non-DCO. It fails to call tls_session_update_crypto_params() if DCO is 
disabled. It needs this on top of it:

	commit ee846144a46b20b889ab1966246f789f3266c2f9 (HEAD -> tmp_v10)
	Author: Kristof Provost <kp@...1376...>
	Date:   Thu May 5 19:36:13 2022 +0200

	    Fix finish_options() to perform the required work for non-DCO modes

	    We still need to run tls_session_update_crypto_params(), even when 
DCO
	    is not enabled.

	diff --git a/src/openvpn/init.c b/src/openvpn/init.c
	index 7083b803..ab59cbd7 100644
	--- a/src/openvpn/init.c
	+++ b/src/openvpn/init.c
	@@ -2374,7 +2374,7 @@ do_deferred_options(struct context *c, const 
unsigned int found)
	 bool
	 finish_options(struct context *c)
	 {
	-    if (!c->options.pull || !dco_enabled(&c->options))
	+    if (!c->options.pull)
	     {
	         return true;
	     }
	@@ -2399,7 +2399,7 @@ finish_options(struct context *c)

	     /* Check if the pushed options are compatible with DCO if we have
	      * DCO enabled */
	-    if (!check_dco_pull_options(&c->options))
	+    if (dco_enabled(&c->options) && 
!check_dco_pull_options(&c->options))
	     {
	         msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are 
incompatible with "
	             "data channel offload. Use --disable-dco to connect"
	@@ -2407,7 +2407,7 @@ finish_options(struct context *c)
	         return false;
	     }

	-    if (c->options.ping_send_timeout || c->c2.frame.mss_fix)
	+    if (dco_enabled(&c->options) && (c->options.ping_send_timeout || 
c->c2.frame.mss_fix))
	     {
	         int ret = dco_set_peer(&c->c1.tuntap->dco,
	                                c->c2.tls_multi->peer_id,

I’ll post an updated series in due course, but wanted to point this 
issue out already.

Kristof
--=_MailMate_56225D2C-620F-4BD2-8D88-4F0217CC886C_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" style=
=3D"white-space: normal;">
<p dir=3D"auto">On 29 Apr 2022, at 19:02, Kristof Provost wrote:</p>
</div><div class=3D"plaintext" style=3D"white-space: normal;"><blockquote s=
tyle=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE;=
 color: #136BCE;"><p dir=3D"auto">From: Kristof Provost &lt;kp@...1376...&g=
t;</p>
<p dir=3D"auto">We must create the peer before we can dco_set_peer or dco_n=
ew_key.
<br>
On the other hand, we must first process options, because those may
<br>
change our peer id and we should create the peer with the correct id.</p>
<p dir=3D"auto">Split up do_deferred_options() in do_deferred_options() and
<br>
finish_options(). Call any DCO configuration operations (i.e.
<br>
dco_set_peer()/dco_new_key()) after we've created the peer (i.e.
<br>
dco_new_peer()).</p>
<p dir=3D"auto">Signed-off-by: Kristof Provost &lt;kprovost@...2661...&gt;
<br>
---
<br>
 src/openvpn/init.c  | 112 +++++++++++++++++++++++++-------------------
<br>
 src/openvpn/init.h  |   2 +
<br>
 src/openvpn/multi.c |   2 +
<br>
 3 files changed, 68 insertions(+), 48 deletions(-)</p>
<p dir=3D"auto">diff --git a/src/openvpn/init.c b/src/openvpn/init.c
<br>
index 8496e21f..5d53cf7e 100644
<br>
--- a/src/openvpn/init.c
<br>
+++ b/src/openvpn/init.c
<br>
@@ -2100,26 +2100,26 @@ do_up(struct context *c, bool pulled_options, unsig=
ned int option_types_found)
<br>
             }
<br>
         }</p>
<p dir=3D"auto">-        if ((c-&gt;mode =3D=3D MODE_POINT_TO_POINT) &amp;&=
amp; c-&gt;c2.did_open_tun)
<br>
+        if (pulled_options)
<br>
         {
<br>
-            /* If we are in DCO mode we need to set the new peer options n=
ow */
<br>
-            int ret =3D dco_p2p_add_new_peer(c);
<br>
-            if (ret &lt; 0)
<br>
+            if (!do_deferred_options(c, option_types_found))
<br>
             {
<br>
-                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
<br>
+                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
<br>
                 return false;
<br>
             }
<br>
         }
<br>
-
<br>
-        if (pulled_options)
<br>
+        if (c-&gt;mode =3D=3D MODE_POINT_TO_POINT)
<br>
         {
<br>
-            if (!do_deferred_options(c, option_types_found))
<br>
+            /* If we are in DCO mode we need to set the new peer options n=
ow */
<br>
+            int ret =3D dco_p2p_add_new_peer(c);
<br>
+            if (ret &lt; 0)
<br>
             {
<br>
-                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
<br>
+                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
<br>
                 return false;
<br>
             }
<br>
         }
<br>
-        else if (c-&gt;mode =3D=3D MODE_POINT_TO_POINT)
<br>
+
<br>
+        if (!pulled_options &amp;&amp; c-&gt;mode =3D=3D MODE_POINT_TO_POI=
NT)
<br>
         {
<br>
             if (!do_deferred_p2p_ncp(c))
<br>
             {
<br>
@@ -2128,6 +2128,13 @@ do_up(struct context *c, bool pulled_options, unsign=
ed int option_types_found)
<br>
             }
<br>
         }</p>
<p dir=3D"auto">+
<br>
+        if (!finish_options(c))
<br>
+        {
<br>
+            msg(D_TLS_ERRORS, "ERROR: Failed to finish option processing");
<br>
+            return false;
<br>
+        }
<br>
+
<br>
         if (c-&gt;c2.did_open_tun)
<br>
         {
<br>
             c-&gt;c1.pulled_options_digest_save =3D c-&gt;c2.pulled_option=
s_digest;
<br>
@@ -2344,49 +2351,58 @@ do_deferred_options(struct context *c, const unsign=
ed int found)
<br>
         {
<br>
             return false;
<br>
         }
<br>
-        struct frame *frame_fragment =3D NULL;
<br>
+    }
<br>
+
<br>
+    return true;
<br>
+}
<br>
+
<br>
+bool
<br>
+finish_options(struct context *c)
<br>
+{
<br>
+    if (!c-&gt;options.pull || !dco_enabled(&amp;c-&gt;options))
<br>
+    {
<br>
+        return true;
<br>
+    }
<br>
+
<br>
+    struct frame *frame_fragment =3D NULL;
<br>
 #ifdef ENABLE_FRAGMENT
<br>
-        if (c-&gt;options.ce.fragment)
<br>
-        {
<br>
-            frame_fragment =3D &amp;c-&gt;c2.frame_fragment;
<br>
-        }
<br>
+    if (c-&gt;options.ce.fragment)
<br>
+    {
<br>
+        frame_fragment =3D &amp;c-&gt;c2.frame_fragment;
<br>
+    }
<br>
 #endif</p>
<p dir=3D"auto">-        struct tls_session *session =3D &amp;c-&gt;c2.tls_=
multi-&gt;session[TM_ACTIVE];
<br>
-        if (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, session,
<br>
-                                              &amp;c-&gt;options, &amp;c-&=
gt;c2.frame,
<br>
-                                              frame_fragment,
<br>
-                                              get_link_socket_info(c)))
<br>
-        {
<br>
-            msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto opti=
ons");
<br>
-            return false;
<br>
-        }
<br>
+    struct tls_session *session =3D &amp;c-&gt;c2.tls_multi-&gt;session[TM=
_ACTIVE];
<br>
+    if (!tls_session_update_crypto_params(c-&gt;c2.tls_multi, session,
<br>
+                                          &amp;c-&gt;options, &amp;c-&gt;c=
2.frame,
<br>
+                                          frame_fragment,
<br>
+                                          get_link_socket_info(c)))
<br>
+    {
<br>
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options"=
);
<br>
+        return false;
<br>
+    }</p>
<p dir=3D"auto">-        if (dco_enabled(&amp;c-&gt;options))
<br>
-        {
<br>
-            /* Check if the pushed options are compatible with DCO if we h=
ave
<br>
-             * DCO enabled */
<br>
-            if (!check_dco_pull_options(&amp;c-&gt;options))
<br>
-            {
<br>
-                msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incom=
patible with "
<br>
-                    "data channel offload. Use --disable-dco to connect"
<br>
-                    "to this server");
<br>
-                return false;
<br>
-            }
<br>
+    /* Check if the pushed options are compatible with DCO if we have
<br>
+     * DCO enabled */
<br>
+    if (!check_dco_pull_options(&amp;c-&gt;options))
<br>
+    {
<br>
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible =
with "
<br>
+            "data channel offload. Use --disable-dco to connect"
<br>
+            "to this server");
<br>
+        return false;
<br>
+    }</p>
<p dir=3D"auto">-            if (c-&gt;options.ping_send_timeout || c-&gt;c=
2.frame.mss_fix)
<br>
-            {
<br>
-                int ret =3D dco_set_peer(&amp;c-&gt;c1.tuntap-&gt;dco,
<br>
-                                       c-&gt;c2.tls_multi-&gt;peer_id,
<br>
-                                       c-&gt;options.ping_send_timeout,
<br>
-                                       c-&gt;options.ping_rec_timeout,
<br>
-                                       c-&gt;c2.frame.mss_fix);
<br>
-                if (ret &lt; 0)
<br>
-                {
<br>
-                    msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
<br>
-                    return false;
<br>
-                }
<br>
-            }
<br>
+    if (c-&gt;options.ping_send_timeout || c-&gt;c2.frame.mss_fix)
<br>
+    {
<br>
+        int ret =3D dco_set_peer(&amp;c-&gt;c1.tuntap-&gt;dco,
<br>
+                               c-&gt;c2.tls_multi-&gt;peer_id,
<br>
+                               c-&gt;options.ping_send_timeout,
<br>
+                               c-&gt;options.ping_rec_timeout,
<br>
+                               c-&gt;c2.frame.mss_fix);
<br>
+        if (ret &lt; 0)
<br>
+        {
<br>
+            msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
<br>
+            return false;
<br>
         }
<br>
     }
<br>
     return true;
<br>
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
<br>
index 1c341da3..5cc2a990 100644
<br>
--- a/src/openvpn/init.h
<br>
+++ b/src/openvpn/init.h
<br>
@@ -97,6 +97,8 @@ void reset_coarse_timers(struct context *c);</p>
<p dir=3D"auto"> bool do_deferred_options(struct context *c, const unsigned=
 int found);</p>
<p dir=3D"auto">+bool finish_options(struct context *c);
<br>
+
<br>
 void inherit_context_child(struct context *dest,
<br>
                            const struct context *src);</p>
<p dir=3D"auto">diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
<br>
index 958712f1..47e1c6cc 100644
<br>
--- a/src/openvpn/multi.c
<br>
+++ b/src/openvpn/multi.c
<br>
@@ -2452,6 +2452,8 @@ multi_client_connect_late_setup(struct multi_context =
*m,
<br>
         mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;
<br>
     }</p>
<p dir=3D"auto">+    finish_options(&amp;mi-&gt;context);
<br>
+
<br>
     /* send push reply if ready */
<br>
     if (mi-&gt;context.c2.push_request_received)
<br>
     {
<br>
-- </p>
</blockquote></div>
<div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">This patch isn=E2=80=99t quite right. It works well for DCO=
, but breaks non-DCO. It fails to call tls_session_update_crypto_params() i=
f DCO is disabled. It needs this on top of it:</p>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; border: =
thin solid gray; overflow-x: auto; max-width: 90vw; background-color: #E4E4=
E4;"><code>commit ee846144a46b20b889ab1966246f789f3266c2f9 (HEAD -&gt; tmp_=
v10)
Author: Kristof Provost &lt;kp@...1376...&gt;
Date:   Thu May 5 19:36:13 2022 +0200

    Fix finish_options() to perform the required work for non-DCO modes

    We still need to run tls_session_update_crypto_params(), even when DCO
    is not enabled.

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7083b803..ab59cbd7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2374,7 +2374,7 @@ do_deferred_options(struct context *c, const unsigned=
 int found)
 bool
 finish_options(struct context *c)
 {
-    if (!c-&gt;options.pull || !dco_enabled(&amp;c-&gt;options))
+    if (!c-&gt;options.pull)
     {
         return true;
     }
@@ -2399,7 +2399,7 @@ finish_options(struct context *c)

     /* Check if the pushed options are compatible with DCO if we have
      * DCO enabled */
-    if (!check_dco_pull_options(&amp;c-&gt;options))
+    if (dco_enabled(&amp;c-&gt;options) &amp;&amp; !check_dco_pull_options=
(&amp;c-&gt;options))
     {
         msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: pushed options are incompat=
ible with &quot;
             &quot;data channel offload. Use --disable-dco to connect&quot;
@@ -2407,7 +2407,7 @@ finish_options(struct context *c)
         return false;
     }

-    if (c-&gt;options.ping_send_timeout || c-&gt;c2.frame.mss_fix)
+    if (dco_enabled(&amp;c-&gt;options) &amp;&amp; (c-&gt;options.ping_sen=
d_timeout || c-&gt;c2.frame.mss_fix))
     {
         int ret =3D dco_set_peer(&amp;c-&gt;c1.tuntap-&gt;dco,
                                c-&gt;c2.tls_multi-&gt;peer_id,
</code></pre>
<p dir=3D"auto">I=E2=80=99ll post an updated series in due course, but want=
ed to point this issue out already.</p>
<p dir=3D"auto">Kristof</p>

</div></div></body>

</html>

--=_MailMate_56225D2C-620F-4BD2-8D88-4F0217CC886C_=--


MIME-Version: 1.0
From: Micah Morton <mortonm@...1913...>
Date: Fri, 13 Apr 2018 10:23:03 -0700
Message-ID: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
Content-Type: multipart/alternative; boundary="94eb2c058d68f911770569be1f78"
Subject: [Openvpn-devel] [PATCH] Specify platform and version on command
 line.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c058d68f911770569be1f78
Content-Type: text/plain; charset="UTF-8"

From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17 00:00:00 2001
From: Micah Morton <mortonm@...1913...>
Date: Fri, 13 Apr 2018 09:55:22 -0700
Subject: [PATCH] Specify platform and version on command line.

Add --iv-plat and --iv-plat-rel command line args, and use the values
passed to these args to set IV_PLAT and IV_PLAT_REL info that is pushed
to the server.

IV_PLAT (platform type) is normally inferred from the build target, but
it would be useful to be able to override this from the command line
(e.g. for client to set platform as ChromeOS instead of Linux).

IV_PLAT_REL (platform release version) would allow for pushing the
platform (e.g. ChromeOS) release version to the server.

This patch is written against openvpn-2.4.4.

Signed-off-by: Micah Morton <mortonm@...1913...>
---
 src/openvpn/init.c       |  8 ++++++++
 src/openvpn/options.c    | 18 ++++++++++++++++++
 src/openvpn/options.h    |  2 ++
 src/openvpn/ssl.c        |  9 +++++++++
 src/openvpn/ssl_common.h |  2 ++
 5 files changed, 39 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 133a9f5..1cb76ad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2723,6 +2723,14 @@ do_init_crypto_tls(struct context *c, const unsigned
int flags)
     {
         to.push_peer_info_detail = 0;
     }
+    if (options->iv_plat)
+    {
+        to.iv_plat = options->iv_plat;
+    }
+    if (options->iv_plat_rel)
+    {
+        to.iv_plat_rel = options->iv_plat_rel;
+    }
 #endif

     /* should we not xmit any packets until we get an initial
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8dee5d1..d9559a0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -229,6 +229,8 @@ static const char usage_message[] =
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1
NAT rule.\n"
 #ifdef ENABLE_PUSH_PEER_INFO
     "--push-peer-info : (client only) push client info to server.\n"
+    "--iv-plat: (client only) platform type.\n"
+    "--iv-plat-rel: (client only) platform release version.\n"
 #endif
     "--setenv name value : Set a custom environmental variable to pass to
script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to
allow\n"
@@ -1781,6 +1783,8 @@ show_settings(const struct options *o)
     SHOW_BOOL(single_session);
 #ifdef ENABLE_PUSH_PEER_INFO
     SHOW_BOOL(push_peer_info);
+    SHOW_STR(iv_plat);
+    SHOW_STR(iv_plat_rel);
 #endif
     SHOW_BOOL(tls_exit);

@@ -7837,6 +7841,20 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->push_peer_info = true;
     }
+
+    else if (streq(p[0], "iv-plat") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->iv_plat = p[1];
+    }
+
+    else if (streq(p[0], "iv-plat-rel") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->iv_plat_rel = p[1];
+    }
+
+
 #endif
     else if (streq(p[0], "tls-exit") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 01a7b26..9da4058 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -575,6 +575,8 @@ struct options

 #ifdef ENABLE_PUSH_PEER_INFO
     bool push_peer_info;
+    const char *iv_plat;
+    const char *iv_plat_rel;
 #endif

     bool tls_exit;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 0739cf7..1265177 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2245,6 +2245,7 @@ push_peer_info(struct buffer *buf, struct tls_session
*session)
         buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);

         /* push platform */
+        if (session->opt->iv_plat == NULL) {
 #if defined(TARGET_LINUX)
         buf_printf(&out, "IV_PLAT=linux\n");
 #elif defined(TARGET_SOLARIS)
@@ -2262,6 +2263,14 @@ push_peer_info(struct buffer *buf, struct
tls_session *session)
 #elif defined(_WIN32)
         buf_printf(&out, "IV_PLAT=win\n");
 #endif
+        } else {
+            buf_printf(&out, "IV_PLAT=%s\n", session->opt->iv_plat);
+        }
+
+        if (session->opt->iv_plat_rel != NULL)
+        {
+            buf_printf(&out, "IV_PLAT_REL=%s\n",
session->opt->iv_plat_rel);
+        }

         /* support for P_DATA_V2 */
         buf_printf(&out, "IV_PROTO=2\n");
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 25bffd5..d95c2ef 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -251,6 +251,8 @@ struct tls_options
     bool pull;
 #ifdef ENABLE_PUSH_PEER_INFO
     int push_peer_info_detail;
+    const char *iv_plat;
+    const char *iv_plat_rel;
 #endif
     int transition_window;
     int handshake_window;
-- 
2.13.5

--94eb2c058d68f911770569be1f78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep=
 17 00:00:00 2001</div><div>From: Micah Morton &lt;<a href=3D"mailto:morton=
m@...1913...">mortonm@...1913...</a>&gt;</div><div>Date: Fri, 13 Apr 2018 0=
9:55:22 -0700</div><div>Subject: [PATCH] Specify platform and version on co=
mmand line.</div><div><br></div><div>Add --iv-plat and --iv-plat-rel comman=
d line args, and use the values</div><div>passed to these args to set IV_PL=
AT and IV_PLAT_REL info that is pushed</div><div>to the server.</div><div><=
br></div><div>IV_PLAT (platform type) is normally inferred from the build t=
arget, but</div><div>it would be useful to be able to override this from th=
e command line</div><div>(e.g. for client to set platform as ChromeOS inste=
ad of Linux).</div><div><br></div><div>IV_PLAT_REL (platform release versio=
n) would allow for pushing the</div><div>platform (e.g. ChromeOS) release v=
ersion to the server.</div><div><br></div><div>This patch is written agains=
t openvpn-2.4.4.</div><div><br></div><div>Signed-off-by: Micah Morton &lt;<=
a href=3D"mailto:mortonm@...1913...">mortonm@...1913...</a>&gt;</div><div>-=
--</div><div>=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +=
+++++++</div><div>=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 | 18 +++++++++++=
+++++++</div><div>=C2=A0src/openvpn/options.h=C2=A0 =C2=A0 |=C2=A0 2 ++</di=
v><div>=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++++++=
++</div><div>=C2=A0src/openvpn/ssl_common.h |=C2=A0 2 ++</div><div>=C2=A05 =
files changed, 39 insertions(+)</div><div><br></div><div>diff --git a/src/o=
penvpn/init.c b/src/openvpn/init.c</div><div>index 133a9f5..1cb76ad 100644<=
/div><div>--- a/src/openvpn/init.c</div><div>+++ b/src/openvpn/init.c</div>=
<div>@@ -2723,6 +2723,14 @@ do_init_crypto_tls(struct context *c, const uns=
igned int flags)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0to.push_peer_info_detail =3D 0;</div><div>=C2=A0 =C2=A0=
 =C2=A0}</div><div>+=C2=A0 =C2=A0 if (options-&gt;iv_plat)</div><div>+=C2=
=A0 =C2=A0 {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 to.iv_plat =3D options-=
&gt;iv_plat;</div><div>+=C2=A0 =C2=A0 }</div><div>+=C2=A0 =C2=A0 if (option=
s-&gt;iv_plat_rel)</div><div>+=C2=A0 =C2=A0 {</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 to.iv_plat_rel =3D options-&gt;iv_plat_rel;</div><div>+=C2=A0 =
=C2=A0 }</div><div>=C2=A0#endif</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =
=C2=A0/* should we not xmit any packets until we get an initial</div><div>d=
iff --git a/src/openvpn/options.c b/src/openvpn/options.c</div><div>index 8=
dee5d1..d9559a0 100644</div><div>--- a/src/openvpn/options.c</div><div>+++ =
b/src/openvpn/options.c</div><div>@@ -229,6 +229,8 @@ static const char usa=
ge_message[] =3D</div><div>=C2=A0 =C2=A0 =C2=A0&quot;--client-nat snat|dnat=
 network netmask alias : on client add 1-to-1 NAT rule.\n&quot;</div><div>=
=C2=A0#ifdef ENABLE_PUSH_PEER_INFO</div><div>=C2=A0 =C2=A0 =C2=A0&quot;--pu=
sh-peer-info : (client only) push client info to server.\n&quot;</div><div>=
+=C2=A0 =C2=A0 &quot;--iv-plat: (client only) platform type.\n&quot;</div><=
div>+=C2=A0 =C2=A0 &quot;--iv-plat-rel: (client only) platform release vers=
ion.\n&quot;</div><div>=C2=A0#endif</div><div>=C2=A0 =C2=A0 =C2=A0&quot;--s=
etenv name value : Set a custom environmental variable to pass to script.\n=
&quot;</div><div>=C2=A0 =C2=A0 =C2=A0&quot;--setenv FORWARD_COMPATIBLE 1 : =
Relax config file syntax checking to allow\n&quot;</div><div>@@ -1781,6 +17=
83,8 @@ show_settings(const struct options *o)</div><div>=C2=A0 =C2=A0 =C2=
=A0SHOW_BOOL(single_session);</div><div>=C2=A0#ifdef ENABLE_PUSH_PEER_INFO<=
/div><div>=C2=A0 =C2=A0 =C2=A0SHOW_BOOL(push_peer_info);</div><div>+=C2=A0 =
=C2=A0 SHOW_STR(iv_plat);</div><div>+=C2=A0 =C2=A0 SHOW_STR(iv_plat_rel);</=
div><div>=C2=A0#endif</div><div>=C2=A0 =C2=A0 =C2=A0SHOW_BOOL(tls_exit);</d=
iv><div>=C2=A0</div><div>@@ -7837,6 +7841,20 @@ add_option(struct options *=
options,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_=
P_GENERAL);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;push_pe=
er_info =3D true;</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+=
=C2=A0 =C2=A0 else if (streq(p[0], &quot;iv-plat&quot;) &amp;&amp; p[1] &am=
p;&amp; !p[2])</div><div>+=C2=A0 =C2=A0 {</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 VERIFY_PERMISSION(OPT_P_GENERAL);</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 options-&gt;iv_plat =3D p[1];</div><div>+=C2=A0 =C2=A0 }</div><div>+=
</div><div>+=C2=A0 =C2=A0 else if (streq(p[0], &quot;iv-plat-rel&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</div><div>+=C2=A0 =C2=A0 {</div><div>+=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION(OPT_P_GENERAL);</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 options-&gt;iv_plat_rel =3D p[1];</div><div>+=C2=A0 =
=C2=A0 }</div><div>+</div><div>+</div><div>=C2=A0#endif</div><div>=C2=A0 =
=C2=A0 =C2=A0else if (streq(p[0], &quot;tls-exit&quot;) &amp;&amp; !p[1])</=
div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>diff --git a/src/openvpn/options.h=
 b/src/openvpn/options.h</div><div>index 01a7b26..9da4058 100644</div><div>=
--- a/src/openvpn/options.h</div><div>+++ b/src/openvpn/options.h</div><div=
>@@ -575,6 +575,8 @@ struct options</div><div>=C2=A0</div><div>=C2=A0#ifdef=
 ENABLE_PUSH_PEER_INFO</div><div>=C2=A0 =C2=A0 =C2=A0bool push_peer_info;</=
div><div>+=C2=A0 =C2=A0 const char *iv_plat;</div><div>+=C2=A0 =C2=A0 const=
 char *iv_plat_rel;</div><div>=C2=A0#endif</div><div>=C2=A0</div><div>=C2=
=A0 =C2=A0 =C2=A0bool tls_exit;</div><div>diff --git a/src/openvpn/ssl.c b/=
src/openvpn/ssl.c</div><div>index 0739cf7..1265177 100644</div><div>--- a/s=
rc/openvpn/ssl.c</div><div>+++ b/src/openvpn/ssl.c</div><div>@@ -2245,6 +22=
45,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;out, &quot;IV_VER=
=3D%s\n&quot;, PACKAGE_VERSION);</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* push platform */</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (session-&gt;opt-&gt;iv_plat =3D=3D NULL) {</div><div>=C2=A0#if defi=
ned(TARGET_LINUX)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&a=
mp;out, &quot;IV_PLAT=3Dlinux\n&quot;);</div><div>=C2=A0#elif defined(TARGE=
T_SOLARIS)</div><div>@@ -2262,6 +2263,14 @@ push_peer_info(struct buffer *b=
uf, struct tls_session *session)</div><div>=C2=A0#elif defined(_WIN32)</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;out, &quot;IV_PLAT=
=3Dwin\n&quot;);</div><div>=C2=A0#endif</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_print=
f(&amp;out, &quot;IV_PLAT=3D%s\n&quot;, session-&gt;opt-&gt;iv_plat);</div>=
<div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>+</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (session-&gt;opt-&gt;iv_plat_rel !=3D NULL)</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 buf_printf(&amp;out, &quot;IV_PLAT_REL=3D%s\n&quot;, session-&gt;opt=
-&gt;iv_plat_rel);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>=C2=
=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* support for P_DATA_V2 */=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf(&amp;out, &quot;IV_=
PROTO=3D2\n&quot;);</div><div>diff --git a/src/openvpn/ssl_common.h b/src/o=
penvpn/ssl_common.h</div><div>index 25bffd5..d95c2ef 100644</div><div>--- a=
/src/openvpn/ssl_common.h</div><div>+++ b/src/openvpn/ssl_common.h</div><di=
v>@@ -251,6 +251,8 @@ struct tls_options</div><div>=C2=A0 =C2=A0 =C2=A0bool=
 pull;</div><div>=C2=A0#ifdef ENABLE_PUSH_PEER_INFO</div><div>=C2=A0 =C2=A0=
 =C2=A0int push_peer_info_detail;</div><div>+=C2=A0 =C2=A0 const char *iv_p=
lat;</div><div>+=C2=A0 =C2=A0 const char *iv_plat_rel;</div><div>=C2=A0#end=
if</div><div>=C2=A0 =C2=A0 =C2=A0int transition_window;</div><div>=C2=A0 =
=C2=A0 =C2=A0int handshake_window;</div><div>--=C2=A0</div><div>2.13.5</div=
></div>

--94eb2c058d68f911770569be1f78--


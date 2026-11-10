Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0D606A325
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DTqvN6C/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QFnhvOp+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fegtU2VB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LV87L/kF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=kNwLUutQ7FzOgT637FT3dttpFp9tGURSFMwWv1EIFmQ=; b=DTqvN6C/Srg8zERP+8ZrGXDjY/
	3UuPO7OHOCQhc+8ceaJCn/XRTWDgLzlLazFwtLxDX7x7g8UBQGEZwK+5JrVpKGHaCEazg4MI52J7R
	SIsZmQAsl80Un85YvZK8ECv294ZRRNBrZ3a8UU/Q0hllx1diCBJcr4RgwzeFtBEfGth4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQk5f-0000000006k-23m8;
	Tue, 10 Nov 2026 11:32:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQk5d-0000000006e-1BrK
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GutaJ6X7L6rjUqYnKL53+I1ze1HUagpaC/Xo1skvAm4=; b=QFnhvOp+8AqJfAjCGY3Oh4e6E2
 7sPmfX1yvdL+NoCzQ4oJSSY0ke435PRaDj4mFn3xpIT2YhQIdre3W4SAZ+SU3IvURV1CaFqsJ5idM
 jwKgVa7Vn64YMJfPlNj0K5zAuFfX6nVS5nmWaXcdkUVWKlgRRrUPXppceIxcdFhB3hYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GutaJ6X7L6rjUqYnKL53+I1ze1HUagpaC/Xo1skvAm4=; b=fegtU2VBkOsSJKhGhxq/CaL2uU
 IB2k/xP73n//AXgu7Z07bNMT7kC8qFMQd/dEhmzvGMWV6hZXDbLy3fnZ/xUwJxd92DZ3YUqYudxxN
 KBh5bDRNqbSIUHFpei+Gby9yE2M8xStADxI0eoiQZXu2PmQLu/ICrXuMJrPmMDLjIXGc=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQk5b-000000004Mu-1Z35 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:32:37 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so16088525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794310349; x=1794915149; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GutaJ6X7L6rjUqYnKL53+I1ze1HUagpaC/Xo1skvAm4=;
 b=LV87L/kFbz+2q3U58/koTdRAUCFyDBkPEQe2l8L4s3CpQujf6XvtpYyFwsNQqHIa6J
 R4/RbU7YiJXo+lJGinxKyQgkoPluBTSyhAztqvxNHmlTBo87tptijwie0uy/O0UJj1Kf
 Rvdk/uO+HYdp6v6yBf5H80zBIKqbUI8oCBSZsEerquvxW7JZR5gk5zyEAuPpJUAwO1ba
 E9j+US6Dtd70U99ylfkusxE/ozy+4s5Fee9H/PYSKLrz10hVGuxhj0PqIlHpH1E39ULc
 MsN9MqH3JMgjDHTUkonm0jB5tMIK6AYd8esR914QDPhIZhBdw8IxuGuRFXAiS1J+UWD3
 vNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794310349; x=1794915149;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GutaJ6X7L6rjUqYnKL53+I1ze1HUagpaC/Xo1skvAm4=;
 b=iP7xjR6TRwTcuVjCoQjIraAJq4vZIZlU8NNfI0ANpxA7QKfdIRw3t1T8EC5GJ5+IvL
 yLD6RUdyoOJXjmdMoHVyxAjc4ZKKfoB7F4GptGYTP1uXQym/ZoYE0T6m2q10tPOXgqsf
 3OjXTJkwGG2qcokHuYc395JPjygHANyTcwMEmgVkpkm7VIQ6NqDVR/+m3/uc1+vweFmL
 v1/L/kQKHr6kGUo3CuKnslUxr967qqtZz+4qFGiAqwBUBERuvpsMhG10uh91OT7XtDQk
 q/5otKOf+WRhnEjWIJZmIHlqyCfcwtqC3SQpCGL7di0Uv09yu4SlygjLEH2k3a3YGHTA
 sbzQ==
X-Gm-Message-State: APuU4Z/Js1DyMA4Op92uZIfgFLxcn1UTrLMNiOzVT9zgg5WVkYcl4liG
 Ru64ddfrUVbBqOf4hq3fo/TtA8t1anDr5RLXg+aNzKi6dgaVvAR93v5+vhqILiCSoCNrUQ9gefp
 ZqdpR3tufPsRv0EMZ1LULSKAJEoeu3DYUeAA2yy+hZG/oi/cY7+Oz/YCzCmX5hnjbM8fok8JyQx
 7eCaBE/g==
X-Gm-Gg: AYBFou0a1sWHrY3CL6qgkekSxtfBAKOA+tK+N9UDFDqzgg4YIXbkzqNBTZtFum0KmbK
 vBci+AuCLquxc0VITzURI9oopbSkZGEl08m+o76rjf74tSVjc2X+jmhft+i61SwupwikrfxpDOC
 58sMw83S3S7HVU2D0YUG92bffmVEikGbIypWyf495F7gdMHl+5xQGUk1rm7ytx9sEdLUjTTGTgu
 FMUcsId4pFTFjsfqEt6d3Bn3NpUUVLmDHxI/XJ7HQDzmWC0OIPTAV60zX4pNNm+kMOQyWFKnnRq
 7pf4bPSgAjnQjYWXBTBNRd6H9jQPX40n+0fmiPACDrt3RDbaiMYazJIKY5YgrHiTY9/nqfMQdCi
 aFqA8lqo/eG2FOaI7gZ3Kz/JftGTMdhtsnACLsmuV3fRPtF7zismr9lc4yh8vxFsETkF+WjPa9t
 b241IrNht60ReLqUxZJV1Q6woJDNDJ++76h3kpuT/EXHTiWQzb+fhleurjbKSuxHQXVzyWzBjAP
 a+/Qk/cv0hPlwY0Ussc/+NsFNgmRqim1rPnSP6mPfIz26kxl0F9o9hAhz+rWb4GwCE//mxTCNJE
 iWz+f+jfpHJy0jRy7+VV2lrDZp6FOZ7brVSwMbp2lQ42s0Pi+YrMtIgY8eaeCnmpqntIrJaV8fi
 oHf6XzO4FdbkRes7W/v9rPhYGL7v4rGKllS7bKg9Z7t5FdcEsMpkklb0yIn1tdt4pNi07/6izqI
 h6/mtVnEOUWv7uZ/A=
X-Received: by 2002:a05:600c:8109:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4ba02349484mr35518275e9.19.1794310348562; 
 Tue, 10 Nov 2026 03:32:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm53099395e9.15.2026.11.10.03.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:32:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:32:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
X-Gerrit-Change-Number: 2164
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2164?usp=email>
X-Gerrit-Commit: f1c4e2fd753c16929b5e055b5d6d45d70fb6b2b9
References: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEwMzQ1MDAwLklmNjc4MmNhOGNiNjAzMDE3MDAxNmM3OWFjNmYwMjU5OGFmNmE0YmYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <82aab2ce3eaaecb41e4be878f886b21f04d2dee4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQk5b-000000004Mu-1Z35
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: share the
 reset code of remove_option() and update_option()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1982834490600538850=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1982834490600538850==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CA5kzPkfwc8="; charset=UTF-8

--CA5kzPkfwc8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2164?usp=3Demail

to review the following change=2E
=


Change subject: options: share the reset code of remove_option() and upda=
te_option()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: share the reset code of remove_option() and update_option()

remove=
_option() and update_option() reset routes, redirect-gateway,
--dns and --d=
hcp-option state with identical code=2E Move each reset into
a helper, and =
the --ignore-unknown-option level lookup, also used by
add_option(), into a=
nother=2E

remove_option() loses a second dhcp-option branch that only Andr=
oid
compiled and could never reach=2E delete_all_dhcp_fo() is no longer bui=
lt
on Android, where that branch was its only user=2E

Change-Id: If6782ca8=
cb6030170016c79ac6f02598af6a4bf3
Signed-off-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
---
M src/openvpn/options=2Ec
1 file changed, 114 insertions(+=
), 147 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/64/2164/1

diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec
index 4dfc719=2E=2E6beacf3 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1012,6 +1012,7 @@
     gc_free(&gc);=

 }
 
+#if !defined(TARGET_ANDROID)
 static void
 delete_all_dhcp_fo(struct=
 options *o, struct env_item **list)
 {
@@ -1043,6 +1044,7 @@
         prev=
 =3D current;
     }
 }
+#endif /* if !defined(TARGET_ANDROID) */
 
 #endif=
 /* ifndef _WIN32 */
 
@@ -3647,12 +3649,107 @@
     return options->forwar=
d_compatible ? M_WARN : msglevel;
 }
 
-#define RESET_OPTION_ROUTES(option_=
ptr, field) \
-    if (option_ptr)                            \
-    {     =
                                     \
-        option_ptr->field =3D NULL;=
              \
-        option_ptr->flags =3D 0;                 \
+/* Ret=
urn M_WARN for an unknown option listed in --ignore-unknown-option */
+stat=
ic msglvl_t
+msglevel_unknown_option(const struct options *options, const c=
har *name, const msglvl_t msglevel)
+{
+    for (int i =3D 0; options->igno=
re_unknown_option && options->ignore_unknown_option[i]; i++)
+    {
+      =
  if (streq(name, options->ignore_unknown_option[i]))
+        {
+         =
   return M_WARN;
+        }
     }
+    return msglevel;
+}
+
+/* If IPv4 =
routes were installed, delete them and forget the configured ones */
+stati=
c void
+reset_routes_v4(struct context *c, struct options *options, const s=
truct env_set *es)
+{
+    if (c->c1=2Eroute_list)
+    {
+        delete_r=
outes_v4(c->c1=2Eroute_list, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options=
), es,
+                         &c->net_ctx);
+        if (options->routes=
)
+        {
+            options->routes->routes =3D NULL;
+            op=
tions->routes->flags =3D 0;
+        }
+    }
+}
+
+/* If IPv6 routes were =
installed, delete them and forget the configured ones */
+static void
+rese=
t_routes_v6(struct context *c, struct options *options, const struct env_se=
t *es)
+{
+    if (c->c1=2Eroute_ipv6_list)
+    {
+        delete_routes_v=
6(c->c1=2Eroute_ipv6_list, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options),=

+                         es, &c->net_ctx);
+        if (options->routes_i=
pv6)
+        {
+            options->routes_ipv6->routes_ipv6 =3D NULL;
+ =
           options->routes_ipv6->flags =3D 0;
+        }
+    }
+}
+
+stati=
c void
+reset_redirect_gateway(struct options *options, struct env_set *es)=

+{
+    if (options->routes)
+    {
+        options->routes->flags =3D 0;=

+    }
+    if (options->routes_ipv6)
+    {
+        options->routes_ipv6=
->flags =3D 0;
+    }
+    env_set_del(es, "route_redirect_gateway_ipv4");
=
+    env_set_del(es, "route_redirect_gateway_ipv6");
+}
+
+static void
+res=
et_dns_options(struct options *options)
+{
+    gc_free(&options->dns_optio=
ns=2Egc);
+    CLEAR(options->dns_options);
+}
+
+static void
+reset_dhcp_o=
ptions(struct options *options, struct env_set *es)
+{
+#if defined(_WIN32)=
 || defined(TARGET_ANDROID)
+    struct tuntap_options *o =3D &options->tun=
tap_options;
+
+    o->domain =3D NULL;
+    o->netbios_scope =3D NULL;
+  =
  o->netbios_node_type =3D 0;
+    o->dns6_len =3D 0;
+    CLEAR(o->dns6);
=
+    o->dns_len =3D 0;
+    CLEAR(o->dns);
+    o->wins_len =3D 0;
+    CLE=
AR(o->wins);
+    o->ntp_len =3D 0;
+    CLEAR(o->ntp);
+    o->nbdd_len =
=3D 0;
+    CLEAR(o->nbdd);
+    o->domain_search_list_len =3D 0;
+    CLEA=
R(o->domain_search_list);
+    o->disable_nbt =3D 0;
+    o->dhcp_options =
=3D 0;
+    CLEAR(options->dns_options=2Efrom_dhcp);
+
+#if defined(TARGET_=
ANDROID)
+    o->http_proxy_port =3D 0;
+    o->http_proxy =3D NULL;
+#endi=
f
+#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+    delete_a=
ll_dhcp_fo(options, &es->list);
+#endif /* if defined(_WIN32) || defined(TA=
RGET_ANDROID) */
+}
 
 void
 remove_option(struct context *c, struct option=
s *options, char *p[], bool is_inline,
@@ -3678,22 +3775,12 @@
     else if=
 (streq(p[0], "route") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_RO=
UTE);
-        if (c->c1=2Eroute_list)
-        {
-            delete_route=
s_v4(c->c1=2Eroute_list, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options), e=
s,
-                             &c->net_ctx);
-            RESET_OPTION_RO=
UTES(options->routes, routes);
-        }
+        reset_routes_v4(c, optio=
ns, es);
     }
     else if (streq(p[0], "route-ipv6") && !p[1])
     {
  =
       VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (c->c1=2Eroute_ipv6_list=
)
-        {
-            delete_routes_v6(c->c1=2Eroute_ipv6_list, c->c1=
=2Etuntap, ROUTE_OPTION_FLAGS(&c->options),
-                             e=
s, &c->net_ctx);
-            RESET_OPTION_ROUTES(options->routes_ipv6, rou=
tes_ipv6);
-        }
+        reset_routes_v6(c, options, es);
     }
    =
 else if (streq(p[0], "route-gateway") && !p[1])
     {
@@ -3714,22 +3801,1=
2 @@
     else if ((streq(p[0], "redirect-gateway") || streq(p[0], "redirec=
t-private")) && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-   =
     if (options->routes)
-        {
-            options->routes->flags =
=3D 0;
-        }
-        if (options->routes_ipv6)
-        {
-          =
  options->routes_ipv6->flags =3D 0;
-        }
-        env_set_del(es, "r=
oute_redirect_gateway_ipv4");
-        env_set_del(es, "route_redirect_gate=
way_ipv6");
+        reset_redirect_gateway(options, es);
     }
     else =
if (streq(p[0], "dns") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_DH=
CPDNS);
-        gc_free(&options->dns_options=2Egc);
-        CLEAR(option=
s->dns_options);
+        reset_dns_options(options);
     }
     else if (=
streq(p[0], "topology") && !p[1])
     {
@@ -3749,64 +3826,21 @@
         V=
ERIFY_PERMISSION(OPT_P_ROUTE);
         options->block_ipv6 =3D false;
    =
 }
-#if defined(_WIN32) || defined(TARGET_ANDROID)
     else if (streq(p[0]=
, "dhcp-option") && !p[1])
     {
-        struct tuntap_options *o =3D &op=
tions->tuntap_options;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-      =
  o->domain =3D NULL;
-        o->netbios_scope =3D NULL;
-        o->netbi=
os_node_type =3D 0;
-        o->dns6_len =3D 0;
-        memset(o->dns6, 0,=
 sizeof(o->dns6));
-        o->dns_len =3D 0;
-        memset(o->dns, 0, si=
zeof(o->dns));
-        o->wins_len =3D 0;
-        memset(o->wins, 0, size=
of(o->wins));
-        o->ntp_len =3D 0;
-        memset(o->ntp, 0, sizeof(=
o->ntp));
-        o->nbdd_len =3D 0;
-        memset(o->nbdd, 0, sizeof(o-=
>nbdd));
-        o->domain_search_list_len =3D 0;
-        CLEAR(o->domain=
_search_list);
-        o->disable_nbt =3D 0;
-        o->dhcp_options =3D =
0;
-        CLEAR(options->dns_options=2Efrom_dhcp);
-
-#if defined(TARGET_=
ANDROID)
-        o->http_proxy_port =3D 0;
-        o->http_proxy =3D NULL=
;
-#endif
+        reset_dhcp_options(options, es);
     }
-#endif /* if de=
fined(_WIN32) || defined(TARGET_ANDROID) */
 #ifdef _WIN32
     else if (st=
req(p[0], "block-outside-dns") && !p[1])
     {
         VERIFY_PERMISSION(=
OPT_P_DHCPDNS);
         options->block_outside_dns =3D false;
     }
-#els=
e /* ifdef _WIN32 */
-    else if (streq(p[0], "dhcp-option") && !p[1])
-  =
  {
-        VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        delete_all_dhcp_fo(=
options, &es->list);
-    }
 #endif
     else
     {
-        msglvl_t msgl=
evel_unknown =3D msglevel_fc;
-        /* Check if an option is in --ignore=
-unknown-option and
-         * set warning level to non fatal */
-        =
for (int i =3D 0; options->ignore_unknown_option && options->ignore_unknown=
_option[i]; i++)
-        {
-            if (streq(p[0], options->ignore_un=
known_option[i]))
-            {
-                msglevel_unknown =3D M_WA=
RN;
-                break;
-            }
-        }
-        msg(msglevel=
_unknown,
+        msg(msglevel_unknown_option(options, p[0], msglevel_fc),=

             "Unrecognized option or missing or extra parameter(s) in %s:%=
d: -%s (%s)", file, line,
             p[0], PACKAGE_VERSION);
     }
@@ -3=
992,12 +4026,7 @@
             {
                 goto err;
             }
=
-            if (c->c1=2Eroute_list)
-            {
-                delete=
_routes_v4(c->c1=2Eroute_list, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->optio=
ns),
-                                 es, &c->net_ctx);
-                R=
ESET_OPTION_ROUTES(options->routes, routes);
-            }
+            re=
set_routes_v4(c, options, es);
             options->push_update_options_fo=
und |=3D OPT_P_U_ROUTE;
         }
     }
@@ -4010,12 +4039,7 @@
          =
   {
                 goto err;
             }
-            if (c->c1=2Erou=
te_ipv6_list)
-            {
-                delete_routes_v6(c->c1=2Erout=
e_ipv6_list, c->c1=2Etuntap,
-                                 ROUTE_OPTION=
_FLAGS(&c->options), es, &c->net_ctx);
-                RESET_OPTION_ROUTES=
(options->routes_ipv6, routes_ipv6);
-            }
+            reset_rout=
es_v6(c, options, es);
             options->push_update_options_found |=3D=
 OPT_P_U_ROUTE6;
         }
     }
@@ -4024,16 +4048,7 @@
         if (!(op=
tions->push_update_options_found & OPT_P_U_REDIR_GATEWAY))
         {
     =
        VERIFY_PERMISSION(OPT_P_ROUTE);
-            if (options->routes)
-=
            {
-                options->routes->flags =3D 0;
-            }=

-            if (options->routes_ipv6)
-            {
-                opt=
ions->routes_ipv6->flags =3D 0;
-            }
-            env_set_del(es,=
 "route_redirect_gateway_ipv4");
-            env_set_del(es, "route_redire=
ct_gateway_ipv6");
+            reset_redirect_gateway(options, es);
      =
       options->push_update_options_found |=3D OPT_P_U_REDIR_GATEWAY;
     =
    }
     }
@@ -4046,56 +4061,19 @@
             {
                 goto e=
rr;
             }
-            gc_free(&options->dns_options=2Egc);
-     =
       CLEAR(options->dns_options);
+            reset_dns_options(options)=
;
             options->push_update_options_found |=3D OPT_P_U_DNS;
       =
  }
     }
-#if defined(_WIN32) || defined(TARGET_ANDROID)
-    else if (st=
req(p[0], "dhcp-option") && p[1] && !p[3])
-    {
-        if (!(options->p=
ush_update_options_found & OPT_P_U_DHCP))
-        {
-            struct tu=
ntap_options *o =3D &options->tuntap_options;
-            VERIFY_PERMISSIO=
N(OPT_P_DHCPDNS);
-
-            o->domain =3D NULL;
-            o->netbio=
s_scope =3D NULL;
-            o->netbios_node_type =3D 0;
-            o->=
dns6_len =3D 0;
-            CLEAR(o->dns6);
-            o->dns_len =3D 0;=

-            CLEAR(o->dns);
-            o->wins_len =3D 0;
-            C=
LEAR(o->wins);
-            o->ntp_len =3D 0;
-            CLEAR(o->ntp);
-=
            o->nbdd_len =3D 0;
-            CLEAR(o->nbdd);
-            o-=
>domain_search_list_len =3D 0;
-            CLEAR(o->domain_search_list);
-=
            o->disable_nbt =3D 0;
-            o->dhcp_options =3D 0;
-
-  =
          CLEAR(options->dns_options=2Efrom_dhcp);
-#if defined(TARGET_ANDR=
OID)
-            o->http_proxy_port =3D 0;
-            o->http_proxy =3D =
NULL;
-#endif
-            options->push_update_options_found |=3D OPT_P_U_=
DHCP;
-        }
-    }
-#else  /* if defined(_WIN32) || defined(TARGET_AND=
ROID) */
     else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
     {
=
         if (!(options->push_update_options_found & OPT_P_U_DHCP))
        =
 {
             VERIFY_PERMISSION(OPT_P_DHCPDNS);
-            delete_all_d=
hcp_fo(options, &es->list);
+            reset_dhcp_options(options, es);
 =
            options->push_update_options_found |=3D OPT_P_U_DHCP;
         =
}
     }
-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
     a=
dd_option(options, p, is_inline, file, line, level, msglevel, permission_ma=
sk,
                option_types_found, es);
     return;
@@ -7943,18 +7921=
,7 @@
     }
     else
     {
-        int i;
-        msglvl_t msglevel_un=
known =3D msglevel_fc;
-        /* Check if an option is in --ignore-unknow=
n-option and
-         * set warning level to non fatal */
-        for (i =
=3D 0; options->ignore_unknown_option && options->ignore_unknown_option[i];=
 i++)
-        {
-            if (streq(p[0], options->ignore_unknown_optio=
n[i]))
-            {
-                msglevel_unknown =3D M_WARN;
-      =
          break;
-            }
-        }
+        const msglvl_t msglevel=
_unknown =3D msglevel_unknown_option(options, p[0], msglevel_fc);
         =
if (file)
         {
             msg(msglevel_unknown,

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6=
a4bf3
Gerrit-Change-Number: 2164
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--CA5kzPkfwc8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: share the reset code of remove_option() and up=
date_option()<br><br>remove_option() and update_option() reset routes, redi=
rect-gateway,<br>--dns and --dhcp-option state with identical code=2E Move =
each reset into<br>a helper, and the --ignore-unknown-option level lookup, =
also used by<br>add_option(), into another=2E<br><br>remove_option() loses =
a second dhcp-option branch that only Android<br>compiled and could never r=
each=2E delete_all_dhcp_fo() is no longer built<br>on Android, where that b=
ranch was its only user=2E<br><br>Change-Id: If6782ca8cb6030170016c79ac6f02=
598af6a4bf3<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 114 insertions(+), =
147 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/64/2164/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 4dfc719=2E=2E=
6beacf3 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1012,6 +1012,7 @@</span=
><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_ANDR=
OID)</span><br><span> static void</span><br><span> delete_all_dhcp_fo(struc=
t options *o, struct env_item **list)</span><br><span> {</span><br><span>@@=
 -1043,6 +1044,7 @@</span><br><span>         prev =3D current;</span><br><s=
pan>     }</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* if !defined(TARGET_ANDROID) */</span><br><span> </span>=
<br><span> #endif /* ifndef _WIN32 */</span><br><span> </span><br><span>@@ =
-3647,12 +3649,107 @@</span><br><span>     return options-&gt;forward_compa=
tible ? M_WARN : msglevel;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define RESET_OPTION_ROUTES(optio=
n_ptr, field) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (option_ptr)                            \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {                                          \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        option_ptr-&gt;fiel=
d =3D NULL;              \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        option_ptr-&gt;flags =3D 0;                 \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Return M_WARN for an unknown opti=
on listed in --ignore-unknown-option */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static msglvl_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+msglevel_unknown_option(const struct options *options, cons=
t char *name, const msglvl_t msglevel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; options-&gt;ignore_unknown_option &amp;&amp; options=
-&gt;ignore_unknown_option[i]; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (streq(name, options-&gt;ignore_unknown_option[i]))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return M_WARN;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return msglevel;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* If IPv4 routes were installed, delete them and forget=
 the configured ones */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rese=
t_routes_v4(struct context *c, struct options *options, const struct env_se=
t *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c1=2Eroute_list)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        delete_routes_v4(c-&gt;c1=
=2Eroute_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options), e=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
        &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (options-&gt;routes)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            options-&gt;routes-&gt;routes =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;routes-&=
gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* If IPv6 routes were installed, delete them and forget the conf=
igured ones */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_routes_=
v6(struct context *c, struct options *options, const struct env_set *es)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c1=2Eroute_ipv6_list)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        delete_routes_v6(c-&gt;c1=2Ero=
ute_ipv6_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (options-&gt;routes_ipv6)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            options-&gt;routes_ipv6-&gt;routes_ipv6 =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            optio=
ns-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+reset_redirect_gateway(struct options *options, struc=
t env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;rou=
tes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;routes-&g=
t;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt=
;routes_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;=
routes_ipv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
nv_set_del(es, &quot;route_redirect_gateway_ipv4&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    env_set_del(es, &quot;route_redire=
ct_gateway_ipv6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+reset_dns_options(struct options *options=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;options-&gt;dns_opt=
ions=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(options-&gt;dns_options);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+reset_dhcp_options(struct options *op=
tions, struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(_WIN32) || defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct tuntap_options *o =3D &amp;options-&gt;tuntap_op=
tions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;domain =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;netbios_scope =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;=
netbios_node_type =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    o-&gt;dns6_len =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(o-&gt;dns6);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(o-&gt;dns);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    o-&gt;wins_len =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;wins);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    o-&gt;ntp_len =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;ntp);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    o-&gt;nbdd_len =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;nbdd);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;domain_search_list_=
len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(o-&gt;domain_search_list);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    o-&gt;disable_nbt =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    o-&gt;dhcp_options =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(options-&gt;dns_options=2Efrom_dhcp);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_ANDROID)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;http_proxy_port =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;http_pro=
xy =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined=
(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    delete_all_dhcp_fo(options, &amp;es-&gt;list);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN=
32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span> </span><br><span> void</span><br><span> re=
move_option(struct context *c, struct options *options, char *p[], bool is_=
inline,</span><br><span>@@ -3678,22 +3775,12 @@</span><br><span>     else i=
f (streq(p[0], &quot;route&quot;) &amp;&amp; !p[1])</span><br><span>     {<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;c1=2Eroute_list)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            delete_routes_v4(c-&gt;c1=
=2Eroute_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options), e=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
          &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            RESET_OPTION_ROUTES(options-&gt;routes, routes);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        reset_routes_v4(c, options, e=
s);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;=
route-ipv6&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (c-&gt;c1=2Eroute_ipv6_list)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            delete_routes_v6(c-&gt;c1=2Eroute_ipv6=
_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                             es=
, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            RESET_OPTION_ROUTES(options-&gt;routes_ipv6, routes_ipv6);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        reset_routes_v6(c, options,=
 es);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quo=
t;route-gateway&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><=
span>@@ -3714,22 +3801,12 @@</span><br><span>     else if ((streq(p[0], &qu=
ot;redirect-gateway&quot;) || streq(p[0], &quot;redirect-private&quot;)) &a=
mp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (options-&gt;routes)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         options-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (options-&gt;routes_ipv6)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            options-&gt;routes_ipv6-&gt;flags =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        env_set_del(es, &quot;route_redire=
ct_gateway_ipv4&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        env_set_del(es, &quot;route_redirect_gateway_ipv6&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        reset_redirect_gate=
way(options, es);</span><br><span>     }</span><br><span>     else if (stre=
q(p[0], &quot;dns&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br=
><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        gc_free(&amp;options-&gt;dns_options=2E=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(opt=
ions-&gt;dns_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        reset_dns_options(options);</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;topology&quot;) &amp;&amp; !p[1])</span>=
<br><span>     {</span><br><span>@@ -3749,64 +3826,21 @@</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span>         options-&gt=
;block_ipv6 =3D false;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(_WIN32) || defined(TARGET_ANDROID)</spa=
n><br><span>     else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; !=
p[1])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct tuntap_options *o =3D &amp;options-&gt;tuntap_options=
;</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        o-&gt;domain =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        o-&gt;netbios_scope =3D NULL;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;netbios_node_type =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;d=
ns6_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 memset(o-&gt;dns6, 0, sizeof(o-&gt;dns6));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        o-&gt;dns_len =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        memset(o-&gt;dns, 0, sizeof(o-&gt;dns)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;wins_=
len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mem=
set(o-&gt;wins, 0, sizeof(o-&gt;wins));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        o-&gt;ntp_len =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        memset(o-&gt;ntp, 0, sizeof(o-&gt;ntp));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;nbdd_len =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(=
o-&gt;nbdd, 0, sizeof(o-&gt;nbdd));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        o-&gt;domain_search_list_len =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        CLEAR(o-&gt;domain_search_list)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;disabl=
e_nbt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
-&gt;dhcp_options =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        o-&gt;http_proxy_port =3D 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        o-&gt;http_proxy =3D NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        reset_dhcp_options(options, es);<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span=
> #ifdef _WIN32</span><br><span>     else if (streq(p[0], &quot;block-outsi=
de-dns&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span>         options-&gt=
;block_outside_dns =3D false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef _WIN32 */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;dhcp-opti=
on&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VE=
RIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        delete_all_dhcp_fo(options, &amp;es-&gt;list);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> #endif</s=
pan><br><span>     else</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msglvl_t msglevel_unknown =3D msglevel_fc;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Check if a=
n option is in --ignore-unknown-option and</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * set warning level to non fatal */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; optio=
ns-&gt;ignore_unknown_option &amp;&amp; options-&gt;ignore_unknown_option[i=
]; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (streq(p[0]=
, options-&gt;ignore_unknown_option[i]))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                msglevel_unknown =3D M_WARN;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                break;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(msglevel_unknown,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(msglevel_unknown_option(options, p[0],=
 msglevel_fc),</span><br><span>             &quot;Unrecognized option or mi=
ssing or extra parameter(s) in %s:%d: -%s (%s)&quot;, file, line,</span><br=
><span>             p[0], PACKAGE_VERSION);</span><br><span>     }</span><b=
r><span>@@ -3992,12 +4026,7 @@</span><br><span>             {</span><br><sp=
an>                 goto err;</span><br><span>             }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;c1=2Eroute_lis=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                delete_rout=
es_v4(c-&gt;c1=2Eroute_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&=
gt;options),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                        es, &amp;c-&gt;net_ctx);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                RESET_OPTION_ROUTES(options-&gt;=
routes, routes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 reset_routes_v4(c, options, es);</span><br><span>             options-&gt;=
push_update_options_found |=3D OPT_P_U_ROUTE;</span><br><span>         }</s=
pan><br><span>     }</span><br><span>@@ -4010,12 +4039,7 @@</span><br><span=
>             {</span><br><span>                 goto err;</span><br><span>=
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (c-&gt;c1=2Eroute_ipv6_list)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                delete_routes_v6(c-&gt;c1=2Eroute_ipv6_list, c-&gt;c=
1=2Etuntap,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                       ROUTE_OPTION_FLAGS(&amp;c-&gt;options), es, &amp;c-&=
gt;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       RESET_OPTION_ROUTES(options-&gt;routes_ipv6, routes_ipv6);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            reset_routes_v6(c, option=
s, es);</span><br><span>             options-&gt;push_update_options_found =
|=3D OPT_P_U_ROUTE6;</span><br><span>         }</span><br><span>     }</spa=
n><br><span>@@ -4024,16 +4048,7 @@</span><br><span>         if (!(options-&=
gt;push_update_options_found &amp; OPT_P_U_REDIR_GATEWAY))</span><br><span>=
         {</span><br><span>             VERIFY_PERMISSION(OPT_P_ROUTE);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (options-&=
gt;routes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                opt=
ions-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (options-&gt;routes_ipv6)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                options-&gt;routes_ipv6-&gt;flags =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            env_set_del(es, &quot;=
route_redirect_gateway_ipv4&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            env_set_del(es, &quot;route_redirect_gateway_ipv6=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 reset_redirect_gateway(options, es);</span><br><span>             options-=
&gt;push_update_options_found |=3D OPT_P_U_REDIR_GATEWAY;</span><br><span> =
        }</span><br><span>     }</span><br><span>@@ -4046,56 +4061,19 @@</s=
pan><br><span>             {</span><br><span>                 goto err;</sp=
an><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            gc_free(&amp;options-&gt;dns_options=2Egc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(options-&gt;dns_o=
ptions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 reset_dns_options(options);</span><br><span>             options-&gt;push_=
update_options_found |=3D OPT_P_U_DNS;</span><br><span>         }</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(_WIN32) || defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!(options-&gt;push_update_options_found &amp; OPT_P_U_DHCP))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            struct tuntap_options *o =3D &amp;op=
tions-&gt;tuntap_options;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            o-&gt;domain =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            o-&gt;netbios_scope =3D NULL;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;netbios_node_type=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-=
&gt;dns6_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          CLEAR(o-&gt;dns6);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            CLEAR(o-&gt;dns);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            o-&gt;wins_len =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;wins);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;ntp_len =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            CLE=
AR(o-&gt;ntp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     o-&gt;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            o-&gt;domain_search_list_len =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;domain_sear=
ch_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
o-&gt;disable_nbt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            o-&gt;dhcp_options =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_ANDROID)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;http_proxy_port =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;=
http_proxy =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            opti=
ons-&gt;push_update_options_found |=3D OPT_P_U_DHCP;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><s=
pan>     else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[3])</span><br><span>     {</span><br><span>         if (!(options=
-&gt;push_update_options_found &amp; OPT_P_U_DHCP))</span><br><span>       =
  {</span><br><span>             VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            delete_all_dhcp_fo=
(options, &amp;es-&gt;list);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            reset_dhcp_options(options, es);</span><br><span>     =
        options-&gt;push_update_options_found |=3D OPT_P_U_DHCP;</span><br>=
<span>         }</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) *=
/</span><br><span>     add_option(options, p, is_inline, file, line, level,=
 msglevel, permission_mask,</span><br><span>                option_types_fo=
und, es);</span><br><span>     return;</span><br><span>@@ -7943,18 +7921,7 =
@@</span><br><span>     }</span><br><span>     else</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t msglevel_unk=
nown =3D msglevel_fc;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* Check if an option is in --ignore-unknown-option and</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * set warning level to n=
on fatal */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fo=
r (i =3D 0; options-&gt;ignore_unknown_option &amp;&amp; options-&gt;ignore=
_unknown_option[i]; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (streq(p[0], options-&gt;ignore_unknown_option[i]))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msglevel_unknown =3D M_WARN;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const msglvl_t msglevel_unknown =
=3D msglevel_unknown_option(options, p[0], msglevel_fc);</span><br><span>  =
       if (file)</span><br><span>         {</span><br><span>             ms=
g(msglevel_unknown,</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail">change 2164</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If6782ca8cb603=
0170016c79ac6f02598af6a4bf3 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2164 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--CA5kzPkfwc8=--


--===============1982834490600538850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1982834490600538850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1982834490600538850==--


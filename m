Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E001606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OgqFX8Dk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zf7HPTBm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EmH1EPln;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Yqv2MFqK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b0xN64LBsVsJnqxdMgaA24uQr3hIGBkHvDWqXNBUVqQ=; b=OgqFX8DkOrWsR6jQ51BPii/XD2
	TWNDLu2jPd0PhItjaJQYC+twqAIJliHyOZMJCazRfQ6UT3x6MSKUoF3dNDWHSg1LjKhW82GidmYnd
	IlXwEGh+EBu0p0HGerixP6bRqMLMzdSarM5R/PGf9/FfpcDkd/wQ5VlMC7KG7swXoSNU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTN0v-000000006IF-3HeD;
	Tue, 17 Nov 2026 17:30:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTN0u-000000006Hm-3QeC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7CQQHPcduoTfpmRcjbS5/Bkvbk0rZNwt9GoHctO+nhg=; b=Zf7HPTBmRbZasQjzZiMznXzXi0
 vkkCrg4pPbQAdaAm7LDOIZ/W3hzt5WdTQsnTf0gbLKRai5qrEhn7GTt58YXUBbwyzkKBjxxFQ4SfL
 8JbwBIvX0Xme2NFEpeweWz0TGIvMBTiiDBq3tr3AlfTY/ybWl/0kjH7VTwXLvKEgAFug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7CQQHPcduoTfpmRcjbS5/Bkvbk0rZNwt9GoHctO+nhg=; b=EmH1EPlnCmmgD/JeA/rQE6R+5f
 cyvDf9QKiRLSel8OolqtKefBNU4KF3PQLYy0aywg4kLOiYT/MI0Yoohx4+EEfy4DoiNmvrR7QdP4d
 X2cEOjZNhNpsVm1Zl7D123wJ0Ypr7PKXvIkFMXig0HymXQCcZvrIei94oME/g4DkneuQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTN0R-000000008L5-3k55 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:30:10 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so2911220f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794936601; x=1795541401; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7CQQHPcduoTfpmRcjbS5/Bkvbk0rZNwt9GoHctO+nhg=;
 b=Yqv2MFqKNiFUkWO5HZ9fsqN5kUEzSBFht0f4xrK161B6JNA7MMBCKC70dzdknwwIhC
 rgPSHFpb7z27FaY0/+IDqyU9XT3eA0oHjDEjhq4R2v8FNcth8dmxR/cHvcaJ+XWaPNlE
 AXP6j/69tz17/DjVLABSDLbhbLczeEm1w3z41/Ipk/Aifv5cc41sGTGXkXB8sow55Keh
 NHPTdEnadhypDaKvxJLnX9NTEhXGqJ2NpDifG/Pd+Xm7OWwUOTtRzO71TvbUMTUL4vPW
 /dXRqn2h+HdK1nrivISZJB7U24nJxtG8gc+M/NMeRik9kTtuqewJqs9JIdd8qhGhGN+Z
 4tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936601; x=1795541401;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7CQQHPcduoTfpmRcjbS5/Bkvbk0rZNwt9GoHctO+nhg=;
 b=sOmjnAg1cTwbZm+LjXbBZVhtb5XXcXUjqbkzzYHxUO6GFr2MTeTCZkuZKItaDVF7Fn
 Obp+omE9dRyap3kGZ5DRexG9qNbGBtRQNf4pn+p2/wyj3rIlTmZGhYsY3uwqpp1RQBV+
 XFi1ofxvX6AS+4DX3zH7KItbptrDB7Ol7c0e4/IIRf2tlavy9MaCh54hvQP0ksaV5uDS
 6Jcped/ybrEzuKd/m6WcmAz5rpt4IpUt8+/qaJKJvKghmjLfK1EfoyYkENGgVWPcGg78
 i4AuuzxRZk6sQOYTVT33irkXj8OrOHCQHjExf3w8H6CK0xU+VYu5gRNQjb9AICTY9voJ
 x3Qg==
X-Forwarded-Encrypted: i=1;
 AL+hErHW+Hq95neJEBBdyoa8nTZKuEQPMfw/i7SiWoyoPgZ6rXts28ALRGOrIs6Zme7z7cno0HMuf9O0kehXQZH5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/KPtAQTy8oFWvYtTyXK18TS/755XWfMavMIt2wvwXw3FvIPjrW
 5gr1zlCkoAYgoCd0Dte9Baoi2oqa9soPsZ1MDH9FoJVjAdLR79owyzV4WFtApA/2EwElEGTNVqq
 3LQwKEUClOm6H5xHlutVNw96Dc+KEU50XD2/C5tXSuEMsCdjJBIUgRpheiuna5Np+BbhM
X-Gm-Gg: AZFdTZfQ9zjxqhbKfM914HP1naK8Au2GwnQ/7REw16tyGw+hkxeWIN2j0sf4b6VryJz
 Q4ol1b/t4EmbMb1YoJFDJD/+M0miimRVbsTcMDAEON8s5eFqKbO9H1iLYlFliE1hm0eZsUZFBmM
 nqWFWA2FOswDmD7hFuAUgR5KIvwV1azwK4Uy24kmQoV1n3Hdv6DLzPywnw2ZVoAONiCVRSDLVwc
 bvaWymjLvE+yvS9SM4LtOIecxyyPR9op+RTo3Olui/JijO/rAaNBsQCLqts6b9oyBI6k3e3JGtm
 burkJzOCxikAqulwstW0cD3wIMsSm4vXZueXepWNqKxRp6aW9Cs3EnYlK2M/fZFkdkD+cumiT53
 tdSjI5WEFWmRzzg18Cgy6loBQDOYgSj9igHiVwE3lBsbX0qB2fSEQn+yEJcbQBrXJSR73FHC//A
 3+XbRMKPq9cgcX3ZTxfO1fIuRSySITV23Ty4ZixdcPtzCrMaldExYmwda+BmHHZLaugR9OvBIpk
 kO+FvrBmWDtnYo8dJCmRdZhDO7UbXTiq0Z5nVNPLSN+4S80nkZbaQBKQVR95MRhBdv2HCUiTFDT
 rR9/8TXsBs4yw7u4q811JAd6LlLtJR7ndJEmT5Kg6tdgD6cu2WOTLXe0w2f09bsSauZg2hJMXr3
 IsWkg/WXNDouJ+gvoLYWrXCjNSlYDwtEHsl+jf10rf0D0oPAOHdiJv1QtwWXzQ71OQxXk83CugW
 WXkc5Ti9WTC/jDN7M=
X-Received: by 2002:a5d:64e4:0:b0:49c:192f:cf0f with SMTP id
 ffacd0b85a97d-4a6365824f4mr330083f8f.8.1794936600976; 
 Tue, 17 Nov 2026 09:30:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f78214dsm29523002f8f.25.2026.11.17.09.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:30:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:30:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
X-Gerrit-Change-Number: 2164
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2164?usp=email>
X-Gerrit-Commit: 7c1328aae934b27305168fe9a7e259f84c21690e
In-Reply-To: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
References: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEwMzQ1MDAwLklmNjc4MmNhOGNiNjAzMDE3MDAxNmM3OWFjNmYwMjU5OGFmNmE0YmYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d4b6c2d511643f3b3e77258107d714d49bd29214-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTN0R-000000008L5-3k55
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0960130100963772526=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0960130100963772526==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pb9IKbt3KUE="; charset=UTF-8

--Pb9IKbt3KUE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2164?usp=3Demail )

Change subject: options: share the reset co=
de of remove_option() and update_option()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: share the reset code of remove_option=
() and update_option()

remove_option() and update_option() reset routes, r=
edirect-gateway,
--dns and --dhcp-option state with identical code=2E Move =
each reset into
a helper, and the --ignore-unknown-option level lookup, als=
o used by
add_option(), into another=2E

remove_option() loses a second dhc=
p-option branch that only Android
compiled and could never reach=2E delete_=
all_dhcp_fo() is no longer built
on Android, where that branch was its only=
 user=2E

Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
Signed-off-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Marco Baffo <marco@man=
delbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164
M=
essage-Id: <20261110150210=2E17991-1-gert@greenie=2Emuc=2Ede>
URL: https://=
lore=2Ekernel=2Eorg/openvpn-devel/20261110150210=2E17991-1-gert@greenie=2Em=
uc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/options=2Ec
1 file changed, 114 insertions(+), 147 deletions(-)




di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 1d8bb2a=
=2E=2E2181076 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -1012,6 +1012,7 @@
     gc_free(&gc);
 }
 
+#if !defined(TARGET_AN=
DROID)
 static void
 delete_all_dhcp_fo(struct options *o, struct env_item =
**list)
 {
@@ -1043,6 +1044,7 @@
         prev =3D current;
     }
 }
+#end=
if /* if !defined(TARGET_ANDROID) */
 
 #endif /* ifndef _WIN32 */
 
@@ -35=
77,12 +3579,107 @@
     return options->forward_compatible ? M_WARN : msgle=
vel;
 }
 
-#define RESET_OPTION_ROUTES(option_ptr, field) \
-    if (option=
_ptr)                            \
-    {                                  =
        \
-        option_ptr->field =3D NULL;              \
-        opti=
on_ptr->flags =3D 0;                 \
+/* Return M_WARN for an unknown opt=
ion listed in --ignore-unknown-option */
+static msglvl_t
+msglevel_unknown=
_option(const struct options *options, const char *name, const msglvl_t msg=
level)
+{
+    for (int i =3D 0; options->ignore_unknown_option && options-=
>ignore_unknown_option[i]; i++)
+    {
+        if (streq(name, options->ig=
nore_unknown_option[i]))
+        {
+            return M_WARN;
+        }
=
     }
+    return msglevel;
+}
+
+/* If IPv4 routes were installed, delete=
 them and forget the configured ones */
+static void
+reset_routes_v4(struc=
t context *c, struct options *options, const struct env_set *es)
+{
+    if=
 (c->c1=2Eroute_list)
+    {
+        delete_routes_v4(c->c1=2Eroute_list, =
c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options), es,
+                     =
    &c->net_ctx);
+        if (options->routes)
+        {
+            opt=
ions->routes->routes =3D NULL;
+            options->routes->flags =3D 0;
+=
        }
+    }
+}
+
+/* If IPv6 routes were installed, delete them and fo=
rget the configured ones */
+static void
+reset_routes_v6(struct context *c=
, struct options *options, const struct env_set *es)
+{
+    if (c->c1=2Ero=
ute_ipv6_list)
+    {
+        delete_routes_v6(c->c1=2Eroute_ipv6_list, c-=
>c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options),
+                         es=
, &c->net_ctx);
+        if (options->routes_ipv6)
+        {
+            =
options->routes_ipv6->routes_ipv6 =3D NULL;
+            options->routes_ip=
v6->flags =3D 0;
+        }
+    }
+}
+
+static void
+reset_redirect_gatewa=
y(struct options *options, struct env_set *es)
+{
+    if (options->routes)=

+    {
+        options->routes->flags =3D 0;
+    }
+    if (options->rou=
tes_ipv6)
+    {
+        options->routes_ipv6->flags =3D 0;
+    }
+    en=
v_set_del(es, "route_redirect_gateway_ipv4");
+    env_set_del(es, "route_r=
edirect_gateway_ipv6");
+}
+
+static void
+reset_dns_options(struct options=
 *options)
+{
+    gc_free(&options->dns_options=2Egc);
+    CLEAR(options-=
>dns_options);
+}
+
+static void
+reset_dhcp_options(struct options *option=
s, struct env_set *es)
+{
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+=
    struct tuntap_options *o =3D &options->tuntap_options;
+
+    o->domain=
 =3D NULL;
+    o->netbios_scope =3D NULL;
+    o->netbios_node_type =3D 0;=

+    o->dns6_len =3D 0;
+    CLEAR(o->dns6);
+    o->dns_len =3D 0;
+    C=
LEAR(o->dns);
+    o->wins_len =3D 0;
+    CLEAR(o->wins);
+    o->ntp_len =
=3D 0;
+    CLEAR(o->ntp);
+    o->nbdd_len =3D 0;
+    CLEAR(o->nbdd);
+  =
  o->domain_search_list_len =3D 0;
+    CLEAR(o->domain_search_list);
+    =
o->disable_nbt =3D 0;
+    o->dhcp_options =3D 0;
+    CLEAR(options->dns_o=
ptions=2Efrom_dhcp);
+
+#if defined(TARGET_ANDROID)
+    o->http_proxy_port=
 =3D 0;
+    o->http_proxy =3D NULL;
+#endif
+#else  /* if defined(_WIN32) =
|| defined(TARGET_ANDROID) */
+    delete_all_dhcp_fo(options, &es->list);
=
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+}
 
 void
 rem=
ove_option(struct context *c, struct options *options, char *p[], bool is_i=
nline,
@@ -3608,22 +3705,12 @@
     else if (streq(p[0], "route") && !p[1])=

     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (c->c1=2Eroute=
_list)
-        {
-            delete_routes_v4(c->c1=2Eroute_list, c->c1=
=2Etuntap, ROUTE_OPTION_FLAGS(&c->options), es,
-                          =
   &c->net_ctx);
-            RESET_OPTION_ROUTES(options->routes, routes);=

-        }
+        reset_routes_v4(c, options, es);
     }
     else if (=
streq(p[0], "route-ipv6") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P=
_ROUTE);
-        if (c->c1=2Eroute_ipv6_list)
-        {
-            dele=
te_routes_v6(c->c1=2Eroute_ipv6_list, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c=
->options),
-                             es, &c->net_ctx);
-            RE=
SET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
-        }
+        r=
eset_routes_v6(c, options, es);
     }
     else if (streq(p[0], "route-gat=
eway") && !p[1])
     {
@@ -3644,22 +3731,12 @@
     else if ((streq(p[0], =
"redirect-gateway") || streq(p[0], "redirect-private")) && !p[1])
     {
  =
       VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (options->routes)
-     =
   {
-            options->routes->flags =3D 0;
-        }
-        if (opt=
ions->routes_ipv6)
-        {
-            options->routes_ipv6->flags =3D =
0;
-        }
-        env_set_del(es, "route_redirect_gateway_ipv4");
-   =
     env_set_del(es, "route_redirect_gateway_ipv6");
+        reset_redirec=
t_gateway(options, es);
     }
     else if (streq(p[0], "dns") && !p[1])
 =
    {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        gc_free(&options-=
>dns_options=2Egc);
-        CLEAR(options->dns_options);
+        reset_dn=
s_options(options);
     }
     else if (streq(p[0], "topology") && !p[1])
=
     {
@@ -3679,64 +3756,21 @@
         VERIFY_PERMISSION(OPT_P_ROUTE);
   =
      options->block_ipv6 =3D false;
     }
-#if defined(_WIN32) || defined=
(TARGET_ANDROID)
     else if (streq(p[0], "dhcp-option") && !p[1])
     {
=
-        struct tuntap_options *o =3D &options->tuntap_options;
         VE=
RIFY_PERMISSION(OPT_P_DHCPDNS);
-
-        o->domain =3D NULL;
-        o->=
netbios_scope =3D NULL;
-        o->netbios_node_type =3D 0;
-        o->dn=
s6_len =3D 0;
-        memset(o->dns6, 0, sizeof(o->dns6));
-        o->dns=
_len =3D 0;
-        memset(o->dns, 0, sizeof(o->dns));
-        o->wins_le=
n =3D 0;
-        memset(o->wins, 0, sizeof(o->wins));
-        o->ntp_len =
=3D 0;
-        memset(o->ntp, 0, sizeof(o->ntp));
-        o->nbdd_len =3D=
 0;
-        memset(o->nbdd, 0, sizeof(o->nbdd));
-        o->domain_search=
_list_len =3D 0;
-        CLEAR(o->domain_search_list);
-        o->disable=
_nbt =3D 0;
-        o->dhcp_options =3D 0;
-        CLEAR(options->dns_opt=
ions=2Efrom_dhcp);
-
-#if defined(TARGET_ANDROID)
-        o->http_proxy_po=
rt =3D 0;
-        o->http_proxy =3D NULL;
-#endif
+        reset_dhcp_opti=
ons(options, es);
     }
-#endif /* if defined(_WIN32) || defined(TARGET_AN=
DROID) */
 #ifdef _WIN32
     else if (streq(p[0], "block-outside-dns") && =
!p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->=
block_outside_dns =3D false;
     }
-#else /* ifdef _WIN32 */
-    else if =
(streq(p[0], "dhcp-option") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT=
_P_DHCPDNS);
-        delete_all_dhcp_fo(options, &es->list);
-    }
 #endi=
f
     else
     {
-        msglvl_t msglevel_unknown =3D msglevel_fc;
-   =
     /* Check if an option is in --ignore-unknown-option and
-         * se=
t warning level to non fatal */
-        for (int i =3D 0; options->ignore_=
unknown_option && options->ignore_unknown_option[i]; i++)
-        {
-     =
       if (streq(p[0], options->ignore_unknown_option[i]))
-            {
-=
                msglevel_unknown =3D M_WARN;
-                break;
-     =
       }
-        }
-        msg(msglevel_unknown,
+        msg(msglevel_un=
known_option(options, p[0], msglevel_fc),
             "Unrecognized option=
 or missing or extra parameter(s) in %s:%d: -%s (%s)", file, line,
        =
     p[0], PACKAGE_VERSION);
     }
@@ -3922,12 +3956,7 @@
             {
 =
                goto err;
             }
-            if (c->c1=2Eroute_lis=
t)
-            {
-                delete_routes_v4(c->c1=2Eroute_list, c->=
c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options),
-                            =
     es, &c->net_ctx);
-                RESET_OPTION_ROUTES(options->routes=
, routes);
-            }
+            reset_routes_v4(c, options, es);
   =
          options->push_update_options_found |=3D OPT_P_U_ROUTE;
         }=

     }
@@ -3940,12 +3969,7 @@
             {
                 goto err;
  =
           }
-            if (c->c1=2Eroute_ipv6_list)
-            {
-    =
            delete_routes_v6(c->c1=2Eroute_ipv6_list, c->c1=2Etuntap,
-    =
                             ROUTE_OPTION_FLAGS(&c->options), es, &c->net_c=
tx);
-                RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6=
);
-            }
+            reset_routes_v6(c, options, es);
           =
  options->push_update_options_found |=3D OPT_P_U_ROUTE6;
         }
     }=

@@ -3954,16 +3978,7 @@
         if (!(options->push_update_options_found &=
 OPT_P_U_REDIR_GATEWAY))
         {
             VERIFY_PERMISSION(OPT_P_RO=
UTE);
-            if (options->routes)
-            {
-                opt=
ions->routes->flags =3D 0;
-            }
-            if (options->routes_=
ipv6)
-            {
-                options->routes_ipv6->flags =3D 0;
- =
           }
-            env_set_del(es, "route_redirect_gateway_ipv4");
-=
            env_set_del(es, "route_redirect_gateway_ipv6");
+            re=
set_redirect_gateway(options, es);
             options->push_update_option=
s_found |=3D OPT_P_U_REDIR_GATEWAY;
         }
     }
@@ -3976,56 +3991,19 =
@@
             {
                 goto err;
             }
-            gc=
_free(&options->dns_options=2Egc);
-            CLEAR(options->dns_options)=
;
+            reset_dns_options(options);
             options->push_updat=
e_options_found |=3D OPT_P_U_DNS;
         }
     }
-#if defined(_WIN32) ||=
 defined(TARGET_ANDROID)
-    else if (streq(p[0], "dhcp-option") && p[1] &=
& !p[3])
-    {
-        if (!(options->push_update_options_found & OPT_P_U=
_DHCP))
-        {
-            struct tuntap_options *o =3D &options->tunt=
ap_options;
-            VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-            o=
->domain =3D NULL;
-            o->netbios_scope =3D NULL;
-            o->=
netbios_node_type =3D 0;
-            o->dns6_len =3D 0;
-            CLEAR=
(o->dns6);
-            o->dns_len =3D 0;
-            CLEAR(o->dns);
-    =
        o->wins_len =3D 0;
-            CLEAR(o->wins);
-            o->ntp=
_len =3D 0;
-            CLEAR(o->ntp);
-            o->nbdd_len =3D 0;
-  =
          CLEAR(o->nbdd);
-            o->domain_search_list_len =3D 0;
-  =
          CLEAR(o->domain_search_list);
-            o->disable_nbt =3D 0;
=
-            o->dhcp_options =3D 0;
-
-            CLEAR(options->dns_optio=
ns=2Efrom_dhcp);
-#if defined(TARGET_ANDROID)
-            o->http_proxy_po=
rt =3D 0;
-            o->http_proxy =3D NULL;
-#endif
-            options=
->push_update_options_found |=3D OPT_P_U_DHCP;
-        }
-    }
-#else  /*=
 if defined(_WIN32) || defined(TARGET_ANDROID) */
     else if (streq(p[0],=
 "dhcp-option") && p[1] && !p[3])
     {
         if (!(options->push_updat=
e_options_found & OPT_P_U_DHCP))
         {
             VERIFY_PERMISSION(=
OPT_P_DHCPDNS);
-            delete_all_dhcp_fo(options, &es->list);
+     =
       reset_dhcp_options(options, es);
             options->push_update_o=
ptions_found |=3D OPT_P_U_DHCP;
         }
     }
-#endif /* if defined(_WI=
N32) || defined(TARGET_ANDROID) */
     add_option(options, p, is_inline, f=
ile, line, level, msglevel, permission_mask,
                option_types_f=
ound, es);
     return;
@@ -7847,18 +7825,7 @@
     }
     else
     {
-   =
     int i;
-        msglvl_t msglevel_unknown =3D msglevel_fc;
-        /*=
 Check if an option is in --ignore-unknown-option and
-         * set warni=
ng level to non fatal */
-        for (i =3D 0; options->ignore_unknown_opt=
ion && options->ignore_unknown_option[i]; i++)
-        {
-            if (=
streq(p[0], options->ignore_unknown_option[i]))
-            {
-           =
     msglevel_unknown =3D M_WARN;
-                break;
-            }
- =
       }
+        const msglvl_t msglevel_unknown =3D msglevel_unknown_opti=
on(options, p[0], msglevel_fc);
         if (file)
         {
             =
msg(msglevel_unknown,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2164?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: If6782ca8cb6030170016c79ac6f02598af6a4bf3
Gerrit-Change-Number: 2164
Gerr=
it-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--Pb9IKbt3KUE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2164?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: share the reset code of r=
emove_option() and update_option()<br><br>remove_option() and update_option=
() reset routes, redirect-gateway,<br>--dns and --dhcp-option state with id=
entical code=2E Move each reset into<br>a helper, and the --ignore-unknown-=
option level lookup, also used by<br>add_option(), into another=2E<br><br>r=
emove_option() loses a second dhcp-option branch that only Android<br>compi=
led and could never reach=2E delete_all_dhcp_fo() is no longer built<br>on =
Android, where that branch was its only user=2E<br><br>Change-Id: If6782ca8=
cb6030170016c79ac6f02598af6a4bf3<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Acked-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164<br>Message=
-Id: &lt;20261110150210=2E17991-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://lore=2Ekernel=2Eorg/openvpn-devel/20261110150210=2E17991-1-gert@greenie=
=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 114 insertions(+), 1=
47 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec</span><br><span>index 1d8bb2a=2E=2E2181076 100644</spa=
n><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn=
/options=2Ec</span><br><span>@@ -1012,6 +1012,7 @@</span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_ANDROID)</span><br><s=
pan> static void</span><br><span> delete_all_dhcp_fo(struct options *o, str=
uct env_item **list)</span><br><span> {</span><br><span>@@ -1043,6 +1044,7 =
@@</span><br><span>         prev =3D current;</span><br><span>     }</span>=
<br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif =
/* if !defined(TARGET_ANDROID) */</span><br><span> </span><br><span> #endif=
 /* ifndef _WIN32 */</span><br><span> </span><br><span>@@ -3577,12 +3579,10=
7 @@</span><br><span>     return options-&gt;forward_compatible ? M_WARN : =
msglevel;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define RESET_OPTION_ROUTES(option_ptr, field) \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (option_ptr)    =
                        \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {                                          \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        option_ptr-&gt;field =3D NULL;     =
         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opt=
ion_ptr-&gt;flags =3D 0;                 \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Return M_WARN for an unknown option listed in --i=
gnore-unknown-option */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static msglvl_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
msglevel_unknown_option(const struct options *options, const char *name, co=
nst msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; options-&gt;ignore_unknown_option &amp;&amp; options-&gt;ignore_unkn=
own_option[i]; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (st=
req(name, options-&gt;ignore_unknown_option[i]))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return M_WARN;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return msglevel;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* If IPv4 routes were installed, delete them and forget the configured =
ones */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_routes_v4(stru=
ct context *c, struct options *options, const struct env_set *es)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (c-&gt;c1=2Eroute_list)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        delete_routes_v4(c-&gt;c1=2Eroute_list, c-=
&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options), es,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                         &amp;c-&g=
t;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (options-&gt;routes)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      options-&gt;routes-&gt;routes =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            options-&gt;routes-&gt;flags =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* If I=
Pv6 routes were installed, delete them and forget the configured ones */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+reset_routes_v6(struct context=
 *c, struct options *options, const struct env_set *es)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (c-&gt;c1=2Eroute_ipv6_list)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        delete_routes_v6(c-&gt;c1=2Eroute_ipv6_list, c-=
&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                         es, &amp;c-&g=
t;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (options-&gt;routes_ipv6)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           options-&gt;routes_ipv6-&gt;routes_ipv6 =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;routes_ipv=
6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+reset_redirect_gateway(struct options *options, struct env_set *es)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;routes)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;routes-&gt;flags =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;routes_ipv6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;routes_ipv6-&gt=
;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env_set_del(es, =
&quot;route_redirect_gateway_ipv4&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    env_set_del(es, &quot;route_redirect_gateway_ipv6=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+reset_dns_options(struct options *options)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;options-&gt;dns_options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(options-&gt;d=
ns_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+reset_dhcp_options(struct options *options, struct e=
nv_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || def=
ined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tuntap_options *o =3D &amp;options-&gt;tuntap_options;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    o-&gt;domain =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    o-&gt;netbios_scope =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;netbios_node_typ=
e =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;d=
ns6_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    C=
LEAR(o-&gt;dns6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    CLEAR(o-&gt;dns);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    o-&gt;wins_len =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(o-&gt;wins);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    o-&gt;ntp_len =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(o-&gt;ntp);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    o-&gt;nbdd_len =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;nbdd);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    o-&gt;domain_search_list_len =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;domain_se=
arch_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&g=
t;disable_nbt =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    o-&gt;dhcp_options =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(TARGET_ANDROID)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    o-&gt;http_proxy_port =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;http_proxy =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(_WIN32) || defi=
ned(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    delete_all_dhcp_fo(options, &amp;es-&gt;list);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) || defined(T=
ARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span> </span><br><span> void</span><br><span> remove_option(stru=
ct context *c, struct options *options, char *p[], bool is_inline,</span><b=
r><span>@@ -3608,22 +3705,12 @@</span><br><span>     else if (streq(p[0], &=
quot;route&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (c-&gt;c1=2Eroute_list)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            delete_routes_v4(c-&gt;c1=2Eroute_list, c-&=
gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options), es,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                             &amp;c-&=
gt;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   RESET_OPTION_ROUTES(options-&gt;routes, routes);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        reset_routes_v4(c, options, es);</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;route-ipv6&quot;=
) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_=
PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (c-&gt;c1=2Eroute_ipv6_list)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            delete_routes_v6(c-&gt;c1=2Eroute_ipv6_list, c-&gt;c1=
=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                             es, &amp;c-&gt;ne=
t_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            RE=
SET_OPTION_ROUTES(options-&gt;routes_ipv6, routes_ipv6);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        reset_routes_v6(c, options, es);</span><br=
><span>     }</span><br><span>     else if (streq(p[0], &quot;route-gateway=
&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -3644,2=
2 +3731,12 @@</span><br><span>     else if ((streq(p[0], &quot;redirect-gat=
eway&quot;) || streq(p[0], &quot;redirect-private&quot;)) &amp;&amp; !p[1])=
</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_RO=
UTE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (opti=
ons-&gt;routes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            option=
s-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (options-&gt;routes_ipv6)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           options-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        env_set_del(es, &quot;route_redirect_gateway_ip=
v4&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        env=
_set_del(es, &quot;route_redirect_gateway_ipv6&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        reset_redirect_gateway(options, =
es);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot=
;dns&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        gc_free(&amp;options-&gt;dns_options=2Egc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(options-&gt;dns_=
options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
set_dns_options(options);</span><br><span>     }</span><br><span>     else =
if (streq(p[0], &quot;topology&quot;) &amp;&amp; !p[1])</span><br><span>   =
  {</span><br><span>@@ -3679,64 +3756,21 @@</span><br><span>         VERIFY=
_PERMISSION(OPT_P_ROUTE);</span><br><span>         options-&gt;block_ipv6 =
=3D false;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><span>=
     else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; !p[1])</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct tuntap_options *o =3D &amp;options-&gt;tuntap_options;</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        o-&gt;domain =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        o-&gt;netbios_scope =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        o-&gt;netbios_node_type =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;dns6_len =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(o-&=
gt;dns6, 0, sizeof(o-&gt;dns6));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        memset(o-&gt;dns, 0, sizeof(o-&gt;dns));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;wins_len =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(o-&gt;w=
ins, 0, sizeof(o-&gt;wins));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        o-&gt;ntp_len =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        memset(o-&gt;ntp, 0, sizeof(o-&gt;ntp));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;nbdd_len =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(o-&gt;nbdd,=
 0, sizeof(o-&gt;nbdd));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        o-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        CLEAR(o-&gt;domain_search_list);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;disable_nbt =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;dhcp_o=
ptions =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        o-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        o-&gt;http_proxy =3D NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        reset_dhcp_options(options, es);</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* i=
f defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span> #ifdef _WI=
N32</span><br><span>     else if (streq(p[0], &quot;block-outside-dns&quot;=
) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_=
PERMISSION(OPT_P_DHCPDNS);</span><br><span>         options-&gt;block_outsi=
de_dns =3D false;</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#else /* ifdef _WIN32 */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;dhcp-option&quot;) &am=
p;&amp; !p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSI=
ON(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     delete_all_dhcp_fo(options, &amp;es-&gt;list);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> #endif</span><br><sp=
an>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        msglvl_t msglevel_unknown =3D msglevel_fc;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* Check if an option is=
 in --ignore-unknown-option and</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         * set warning level to non fatal */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; options-&gt;igno=
re_unknown_option &amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (streq(p[0], options-&=
gt;ignore_unknown_option[i]))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                msglevel_unknown =3D M_WARN;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                break;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(msglevel_unknown,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(msglevel_unknown_option(options, p[0], msglevel_f=
c),</span><br><span>             &quot;Unrecognized option or missing or ex=
tra parameter(s) in %s:%d: -%s (%s)&quot;, file, line,</span><br><span>    =
         p[0], PACKAGE_VERSION);</span><br><span>     }</span><br><span>@@ =
-3922,12 +3956,7 @@</span><br><span>             {</span><br><span>        =
         goto err;</span><br><span>             }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (c-&gt;c1=2Eroute_list)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                delete_routes_v4(c-&gt=
;c1=2Eroute_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
             es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                RESET_OPTION_ROUTES(options-&gt;routes, rou=
tes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            reset_rout=
es_v4(c, options, es);</span><br><span>             options-&gt;push_update=
_options_found |=3D OPT_P_U_ROUTE;</span><br><span>         }</span><br><sp=
an>     }</span><br><span>@@ -3940,12 +3969,7 @@</span><br><span>          =
   {</span><br><span>                 goto err;</span><br><span>           =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (c-=
&gt;c1=2Eroute_ipv6_list)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            delete_routes_v6(c-&gt;c1=2Eroute_ipv6_list, c-&gt;c1=2Etuntap,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
            ROUTE_OPTION_FLAGS(&amp;c-&gt;options), es, &amp;c-&gt;net_ctx)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                RESE=
T_OPTION_ROUTES(options-&gt;routes_ipv6, routes_ipv6);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            reset_routes_v6(c, options, es);</sp=
an><br><span>             options-&gt;push_update_options_found |=3D OPT_P_=
U_ROUTE6;</span><br><span>         }</span><br><span>     }</span><br><span=
>@@ -3954,16 +3978,7 @@</span><br><span>         if (!(options-&gt;push_upd=
ate_options_found &amp; OPT_P_U_REDIR_GATEWAY))</span><br><span>         {<=
/span><br><span>             VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;routes)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;ro=
utes-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (options-&gt;routes_ipv6)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                options-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            env_set_del(es, &quot;route_red=
irect_gateway_ipv4&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            env_set_del(es, &quot;route_redirect_gateway_ipv6&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            reset_re=
direct_gateway(options, es);</span><br><span>             options-&gt;push_=
update_options_found |=3D OPT_P_U_REDIR_GATEWAY;</span><br><span>         }=
</span><br><span>     }</span><br><span>@@ -3976,56 +3991,19 @@</span><br><=
span>             {</span><br><span>                 goto err;</span><br><s=
pan>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         gc_free(&amp;options-&gt;dns_options=2Egc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            CLEAR(options-&gt;dns_options);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            reset_d=
ns_options(options);</span><br><span>             options-&gt;push_update_o=
ptions_found |=3D OPT_P_U_DNS;</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN=
32) || defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] =
&amp;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(option=
s-&gt;push_update_options_found &amp; OPT_P_U_DHCP))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            struct tuntap_options *o =3D &amp;options-&=
gt;tuntap_options;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            o-&gt;domain =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            o-&gt;netbios_scope =3D NULL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            o-&gt;netbios_node_type =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;dns=
6_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   CLEAR(o-&gt;dns6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            CLEAR(o-&gt;dns);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            o-&gt;wins_len =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;wins);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;ntp_len =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt=
;ntp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&=
gt;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            o-&gt;domain_search_list_len =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;domain_search_list)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;di=
sable_nbt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       o-&gt;dhcp_options =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(TARGET_ANDROID)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o-&gt;http_proxy_port =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;http_p=
roxy =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&g=
t;push_update_options_found |=3D OPT_P_U_DHCP;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
se  /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span>   =
  else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[3])</span><br><span>     {</span><br><span>         if (!(options-&gt;pu=
sh_update_options_found &amp; OPT_P_U_DHCP))</span><br><span>         {</sp=
an><br><span>             VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            delete_all_dhcp_fo(option=
s, &amp;es-&gt;list);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            reset_dhcp_options(options, es);</span><br><span>            =
 options-&gt;push_update_options_found |=3D OPT_P_U_DHCP;</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span=
><br><span>     add_option(options, p, is_inline, file, line, level, msglev=
el, permission_mask,</span><br><span>                option_types_found, es=
);</span><br><span>     return;</span><br><span>@@ -7847,18 +7825,7 @@</spa=
n><br><span>     }</span><br><span>     else</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t msglevel_unknown =
=3D msglevel_fc;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* Check if an option is in --ignore-unknown-option and</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         * set warning level to non fa=
tal */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =
=3D 0; options-&gt;ignore_unknown_option &amp;&amp; options-&gt;ignore_unkn=
own_option[i]; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (streq(p[0], options-&gt;ignore_unknown_option[i]))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msglevel_unknown =3D M_WARN;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                break;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const msglvl_t msglevel_unknown =3D m=
sglevel_unknown_option(options, p[0], msglevel_fc);</span><br><span>       =
  if (file)</span><br><span>         {</span><br><span>             msg(msg=
level_unknown,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail">change 2164</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: If6782ca8cb6030170016=
c79ac6f02598af6a4bf3 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2164 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--Pb9IKbt3KUE=--


--===============0960130100963772526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0960130100963772526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0960130100963772526==--


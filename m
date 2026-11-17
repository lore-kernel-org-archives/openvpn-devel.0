Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E84606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BZacSJSm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N2Q0jbKI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=etQJK9Zy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YQuWb2z2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dJgENbjOeet+XfilkHWCxKTHTlTSEIGgxTUK3WAPH00=; b=BZacSJSmiGgp4bFCYtEAlpiF80
	/fb2DTEJ01ZGSlBpAwn6vZUDPRBtHHGo2/Ha5XCuMqtCx8OmETo48Al2Aewuh0c7McW286wxvo1DV
	t3tS3MwscU+7cEwhRS5JU8dOH9duSkoSti4ssIqNsYDeYBpMfQO6GijJdFmF265Hgakg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTN0y-000000002sT-03dv;
	Tue, 17 Nov 2026 17:30:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTN0u-000000002s6-3QbD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=We5299+9S5bL4ZAQBIpJD6goUGLtmaX0/H4CQ2EgytY=; b=N2Q0jbKIxJbiz2sJAAIzpSCBkk
 Tevpmy4NOv0nNqsA40/TobTn4j8v5cmRYPjShb3WlDmnRX/DujQhFPmzKAlZDJcOwNNK7mSxVMtgP
 Rkeow9/TTBClfKeap4xMQXygXUfqthGuTRf8FUylamZ04uEa6N2m4cjbwBmDD0WPWly4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=We5299+9S5bL4ZAQBIpJD6goUGLtmaX0/H4CQ2EgytY=; b=etQJK9ZyFuLPaFHnpia7XH5bIV
 FTgeCAOxn6SxBi2cNsEKW1XhfqSzrfiK8JncsUctxBVj1rV9Rv/y83v+zAfDzFJ62R2yYQXZQph2D
 GC6uFLCi4Apvv6tBVUSjUFCM3kxZOrSsPd8n0mX852CO1Ywuz6IFTqujIgJdHrYfMqdQ=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTN0R-000000008Kr-09h3 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:30:10 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so27902f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794936600; x=1795541400; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=We5299+9S5bL4ZAQBIpJD6goUGLtmaX0/H4CQ2EgytY=;
 b=YQuWb2z2JW507vqnZagCYovua/T6iaLJihFNCZmXiWLNa/FBwFuS0fcDPbRKF2733t
 WnlTRiu1YcGF2bfypkjgflEZu1d+W+LHKFA6fMuuS6om5V6s/OakkmVgsrEurFSplXX1
 8utJxSdV7oCq6Qww+GsbvMtTxngqx81BbEsb7/JQpLJsz9LcJRSj6WEZXDj5tQEoOG4P
 5RGKAlNpLi4irB0hXcgYVVnvdv7aonVSPlNeYFOkaLXt5D70qWSnqd2YezN5z8acvb2l
 O7WKzUN+8I2HBoBjLZaQowFgMKAYQi7Xlbm6aQr260/RDtBgGedUlAKdb3HFBhc+1JBU
 lorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936600; x=1795541400;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=We5299+9S5bL4ZAQBIpJD6goUGLtmaX0/H4CQ2EgytY=;
 b=i0nCQE/dVAXETYZEMzH+/5Tx4czL+ldrI8C1UZ3jp85bNcoXYfZ1p1OsInXnHhZZdq
 JngL4BNcIBatr0/XHvLShdkeBe2TA7mJII8W1IHnXqo31JEX2PmSsev9NUp/WkOlk47h
 W2Z0s/5WWYtwTXTLqsKwtZ+BqZ4NQi+a/YDRSDlwD24Mjwy843vNjPB5Xu52I8TZ7AS7
 uubuScWUEtBIzu1nsdYGBvRVR8mlsiQVybMdu2McFc7xw99fbASDCwzsAy/ysCAAy+d4
 ovOCllKeLpCkmoVg0BYguYecNz4ba0WnSka99wqdmdrLC1f/oiThZ/Co4OvRpFBQPwlk
 uHGg==
X-Gm-Message-State: APuU4Z/P5RmqOen8t+PrAMQJ4y8pDP8a0to9Hzf0mutbwXf5zhKIp8oo
 rbRFdK7Q90R61mC2frIDbzV3C1Ntv6YcbKJkx0UR/GdrHR0QcThdvHzod9d9nU0zxTZe3rh2COX
 9MaCltaE5+/nUN8oQoQJLFbODPrkqt9+h7uWmdc5oyggTcEyIx+x75RSQSmV24NujlvI7/cfkBT
 SCcT2m7g==
X-Gm-Gg: AZFdTZfS4jR1w/hNmjttbSlRFDiF3MirPFBfPFOInUatXFGLR9IlCl9LkqO3MpGt495
 B6JqvxAg8p3em77BWXo/gR3eWmN1mxjDsyxpTbmFdgQLkkJiApD8QXwd9zDmbP6r9jbkIf6QjNu
 MJwgUTSR3YARYQfLMoBSH+DsJnbVuLvZc2xYpK8UDuninskfWyl5/Mu1jBIFYb37AUwFwtiDSFW
 AacniV8PmEVcQtBzBBwjqBCy2FY9KzVLSCRVMpincrGOJJpPAq2AlioalHzz2xH50bGFEsdAp95
 iMjdXavrq5zNGRz8zGphtGHWlbEy1kobeodCgGcMFHvJOCP+orSmxLYzJJoT6UxCwXeTWQxdvCl
 q/bCDLr/n50rPlaHBAZT/d4mnluF5tfNfOncdT5K5RunDHtzjhOI8ZoItkFrolvQHm+dOywtRcf
 /otYReAhM7Llny/pCxcovu0vo8Xo37zmWy5bmpKvMDgY+bqX0fgQ4qlAARwMj4kWJnVW30rDeyL
 XAeESQFf0xT07kLEv+XduvoXdd2fxaYF7g/8A6lXQsvdltpBsZw5nEqDU4VW5EQK48R9Y/pxQAi
 ymURQCCLcl4Ag+7AQzFSq2srN5KKa5eZvNMACOeC83D18saDf7qeckX1DIrsKDjr0OibnyXOFIO
 eYlYeFnDkXTFQbD7Omo7BDKuEab6ZFFqtrqwiQHtJhlx+7Y16CwmAcyDKsvrMtg74orxf4Jdfyy
 1F2S/Znyf6/Yi9IV2T
X-Received: by 2002:a5d:456d:0:b0:491:895b:4c02 with SMTP id
 ffacd0b85a97d-4a63ac6bd02mr211489f8f.23.1794936600109; 
 Tue, 17 Nov 2026 09:30:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c604ee47dsm29810956f8f.38.2026.11.17.09.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:29:59 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:29:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Marco Baffo <marco@mandelbit.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
X-Gerrit-Change-Number: 2164
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2164?usp=email>
X-Gerrit-Commit: 7c1328aae934b27305168fe9a7e259f84c21690e
In-Reply-To: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
References: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEwMzQ1MDAwLklmNjc4MmNhOGNiNjAzMDE3MDAxNmM3OWFjNmYwMjU5OGFmNmE0YmYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d4b6c2d511643f3b3e77258107d714d49bd29214-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTN0R-000000008Kr-09h3
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5163805341041672963=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5163805341041672963==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/irtTul+Gik="; charset=UTF-8

--/irtTul+Gik=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2164?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Marco Baffo


Change subject: options: share the reset c=
ode of remove_option() and update_option()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: share the reset code of remove_opt=
ion() and update_option()

remove_option() and update_option() reset routes=
, redirect-gateway,
--dns and --dhcp-option state with identical code=2E Mo=
ve each reset into
a helper, and the --ignore-unknown-option level lookup, =
also used by
add_option(), into another=2E

remove_option() loses a second =
dhcp-option branch that only Android
compiled and could never reach=2E dele=
te_all_dhcp_fo() is no longer built
on Android, where that branch was its o=
nly user=2E

Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
Signed-of=
f-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Marco Baffo <marco@=
mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/216=
4
Message-Id: <20261110150210=2E17991-1-gert@greenie=2Emuc=2Ede>
URL: https=
://lore=2Ekernel=2Eorg/openvpn-devel/20261110150210=2E17991-1-gert@greenie=
=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/options=2Ec
1 file changed, 114 insertions(+), 147 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2164/=
2

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 1d8=
bb2a=2E=2E2181076 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/op=
tions=2Ec
@@ -1012,6 +1012,7 @@
     gc_free(&gc);
 }
 
+#if !defined(TARGE=
T_ANDROID)
 static void
 delete_all_dhcp_fo(struct options *o, struct env_i=
tem **list)
 {
@@ -1043,6 +1044,7 @@
         prev =3D current;
     }
 }
+=
#endif /* if !defined(TARGET_ANDROID) */
 
 #endif /* ifndef _WIN32 */
 
@@=
 -3577,12 +3579,107 @@
     return options->forward_compatible ? M_WARN : m=
sglevel;
 }
 
-#define RESET_OPTION_ROUTES(option_ptr, field) \
-    if (op=
tion_ptr)                            \
-    {                              =
            \
-        option_ptr->field =3D NULL;              \
-        =
option_ptr->flags =3D 0;                 \
+/* Return M_WARN for an unknown=
 option listed in --ignore-unknown-option */
+static msglvl_t
+msglevel_unk=
nown_option(const struct options *options, const char *name, const msglvl_t=
 msglevel)
+{
+    for (int i =3D 0; options->ignore_unknown_option && opti=
ons->ignore_unknown_option[i]; i++)
+    {
+        if (streq(name, options=
->ignore_unknown_option[i]))
+        {
+            return M_WARN;
+      =
  }
     }
+    return msglevel;
+}
+
+/* If IPv4 routes were installed, de=
lete them and forget the configured ones */
+static void
+reset_routes_v4(s=
truct context *c, struct options *options, const struct env_set *es)
+{
+  =
  if (c->c1=2Eroute_list)
+    {
+        delete_routes_v4(c->c1=2Eroute_li=
st, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options), es,
+                 =
        &c->net_ctx);
+        if (options->routes)
+        {
+           =
 options->routes->routes =3D NULL;
+            options->routes->flags =3D =
0;
+        }
+    }
+}
+
+/* If IPv6 routes were installed, delete them an=
d forget the configured ones */
+static void
+reset_routes_v6(struct contex=
t *c, struct options *options, const struct env_set *es)
+{
+    if (c->c1=
=2Eroute_ipv6_list)
+    {
+        delete_routes_v6(c->c1=2Eroute_ipv6_lis=
t, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options),
+                      =
   es, &c->net_ctx);
+        if (options->routes_ipv6)
+        {
+       =
     options->routes_ipv6->routes_ipv6 =3D NULL;
+            options->rout=
es_ipv6->flags =3D 0;
+        }
+    }
+}
+
+static void
+reset_redirect_g=
ateway(struct options *options, struct env_set *es)
+{
+    if (options->ro=
utes)
+    {
+        options->routes->flags =3D 0;
+    }
+    if (options=
->routes_ipv6)
+    {
+        options->routes_ipv6->flags =3D 0;
+    }
+ =
   env_set_del(es, "route_redirect_gateway_ipv4");
+    env_set_del(es, "ro=
ute_redirect_gateway_ipv6");
+}
+
+static void
+reset_dns_options(struct op=
tions *options)
+{
+    gc_free(&options->dns_options=2Egc);
+    CLEAR(opt=
ions->dns_options);
+}
+
+static void
+reset_dhcp_options(struct options *o=
ptions, struct env_set *es)
+{
+#if defined(_WIN32) || defined(TARGET_ANDRO=
ID)
+    struct tuntap_options *o =3D &options->tuntap_options;
+
+    o->d=
omain =3D NULL;
+    o->netbios_scope =3D NULL;
+    o->netbios_node_type =
=3D 0;
+    o->dns6_len =3D 0;
+    CLEAR(o->dns6);
+    o->dns_len =3D 0;
=
+    CLEAR(o->dns);
+    o->wins_len =3D 0;
+    CLEAR(o->wins);
+    o->nt=
p_len =3D 0;
+    CLEAR(o->ntp);
+    o->nbdd_len =3D 0;
+    CLEAR(o->nbdd=
);
+    o->domain_search_list_len =3D 0;
+    CLEAR(o->domain_search_list);=

+    o->disable_nbt =3D 0;
+    o->dhcp_options =3D 0;
+    CLEAR(options-=
>dns_options=2Efrom_dhcp);
+
+#if defined(TARGET_ANDROID)
+    o->http_prox=
y_port =3D 0;
+    o->http_proxy =3D NULL;
+#endif
+#else  /* if defined(_W=
IN32) || defined(TARGET_ANDROID) */
+    delete_all_dhcp_fo(options, &es->l=
ist);
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+}
 
 voi=
d
 remove_option(struct context *c, struct options *options, char *p[], boo=
l is_inline,
@@ -3608,22 +3705,12 @@
     else if (streq(p[0], "route") && =
!p[1])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (c->c1=
=2Eroute_list)
-        {
-            delete_routes_v4(c->c1=2Eroute_list,=
 c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options), es,
-                    =
         &c->net_ctx);
-            RESET_OPTION_ROUTES(options->routes, ro=
utes);
-        }
+        reset_routes_v4(c, options, es);
     }
     els=
e if (streq(p[0], "route-ipv6") && !p[1])
     {
         VERIFY_PERMISSION=
(OPT_P_ROUTE);
-        if (c->c1=2Eroute_ipv6_list)
-        {
-          =
  delete_routes_v6(c->c1=2Eroute_ipv6_list, c->c1=2Etuntap, ROUTE_OPTION_FL=
AGS(&c->options),
-                             es, &c->net_ctx);
-        =
    RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
-        }
+   =
     reset_routes_v6(c, options, es);
     }
     else if (streq(p[0], "rou=
te-gateway") && !p[1])
     {
@@ -3644,22 +3731,12 @@
     else if ((streq(=
p[0], "redirect-gateway") || streq(p[0], "redirect-private")) && !p[1])
   =
  {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (options->routes)
=
-        {
-            options->routes->flags =3D 0;
-        }
-        i=
f (options->routes_ipv6)
-        {
-            options->routes_ipv6->flag=
s =3D 0;
-        }
-        env_set_del(es, "route_redirect_gateway_ipv4")=
;
-        env_set_del(es, "route_redirect_gateway_ipv6");
+        reset_r=
edirect_gateway(options, es);
     }
     else if (streq(p[0], "dns") && !p=
[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        gc_free(&op=
tions->dns_options=2Egc);
-        CLEAR(options->dns_options);
+        re=
set_dns_options(options);
     }
     else if (streq(p[0], "topology") && !=
p[1])
     {
@@ -3679,64 +3756,21 @@
         VERIFY_PERMISSION(OPT_P_ROUTE=
);
         options->block_ipv6 =3D false;
     }
-#if defined(_WIN32) || d=
efined(TARGET_ANDROID)
     else if (streq(p[0], "dhcp-option") && !p[1])
 =
    {
-        struct tuntap_options *o =3D &options->tuntap_options;
     =
    VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-        o->domain =3D NULL;
-     =
   o->netbios_scope =3D NULL;
-        o->netbios_node_type =3D 0;
-       =
 o->dns6_len =3D 0;
-        memset(o->dns6, 0, sizeof(o->dns6));
-        =
o->dns_len =3D 0;
-        memset(o->dns, 0, sizeof(o->dns));
-        o->w=
ins_len =3D 0;
-        memset(o->wins, 0, sizeof(o->wins));
-        o->nt=
p_len =3D 0;
-        memset(o->ntp, 0, sizeof(o->ntp));
-        o->nbdd_l=
en =3D 0;
-        memset(o->nbdd, 0, sizeof(o->nbdd));
-        o->domain_=
search_list_len =3D 0;
-        CLEAR(o->domain_search_list);
-        o->d=
isable_nbt =3D 0;
-        o->dhcp_options =3D 0;
-        CLEAR(options->d=
ns_options=2Efrom_dhcp);
-
-#if defined(TARGET_ANDROID)
-        o->http_pr=
oxy_port =3D 0;
-        o->http_proxy =3D NULL;
-#endif
+        reset_dhc=
p_options(options, es);
     }
-#endif /* if defined(_WIN32) || defined(TAR=
GET_ANDROID) */
 #ifdef _WIN32
     else if (streq(p[0], "block-outside-dns=
") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         opt=
ions->block_outside_dns =3D false;
     }
-#else /* ifdef _WIN32 */
-    el=
se if (streq(p[0], "dhcp-option") && !p[1])
-    {
-        VERIFY_PERMISSI=
ON(OPT_P_DHCPDNS);
-        delete_all_dhcp_fo(options, &es->list);
-    }
=
 #endif
     else
     {
-        msglvl_t msglevel_unknown =3D msglevel_fc=
;
-        /* Check if an option is in --ignore-unknown-option and
-       =
  * set warning level to non fatal */
-        for (int i =3D 0; options->i=
gnore_unknown_option && options->ignore_unknown_option[i]; i++)
-        {
=
-            if (streq(p[0], options->ignore_unknown_option[i]))
-         =
   {
-                msglevel_unknown =3D M_WARN;
-                break;
=
-            }
-        }
-        msg(msglevel_unknown,
+        msg(msgle=
vel_unknown_option(options, p[0], msglevel_fc),
             "Unrecognized =
option or missing or extra parameter(s) in %s:%d: -%s (%s)", file, line,
  =
           p[0], PACKAGE_VERSION);
     }
@@ -3922,12 +3956,7 @@
          =
   {
                 goto err;
             }
-            if (c->c1=2Erou=
te_list)
-            {
-                delete_routes_v4(c->c1=2Eroute_lis=
t, c->c1=2Etuntap, ROUTE_OPTION_FLAGS(&c->options),
-                      =
           es, &c->net_ctx);
-                RESET_OPTION_ROUTES(options->=
routes, routes);
-            }
+            reset_routes_v4(c, options, es=
);
             options->push_update_options_found |=3D OPT_P_U_ROUTE;
    =
     }
     }
@@ -3940,12 +3969,7 @@
             {
                 goto e=
rr;
             }
-            if (c->c1=2Eroute_ipv6_list)
-            {=

-                delete_routes_v6(c->c1=2Eroute_ipv6_list, c->c1=2Etuntap,=

-                                 ROUTE_OPTION_FLAGS(&c->options), es, &c-=
>net_ctx);
-                RESET_OPTION_ROUTES(options->routes_ipv6, route=
s_ipv6);
-            }
+            reset_routes_v6(c, options, es);
     =
        options->push_update_options_found |=3D OPT_P_U_ROUTE6;
         }
=
     }
@@ -3954,16 +3978,7 @@
         if (!(options->push_update_options_f=
ound & OPT_P_U_REDIR_GATEWAY))
         {
             VERIFY_PERMISSION(OP=
T_P_ROUTE);
-            if (options->routes)
-            {
-             =
   options->routes->flags =3D 0;
-            }
-            if (options->r=
outes_ipv6)
-            {
-                options->routes_ipv6->flags =3D=
 0;
-            }
-            env_set_del(es, "route_redirect_gateway_ipv=
4");
-            env_set_del(es, "route_redirect_gateway_ipv6");
+        =
    reset_redirect_gateway(options, es);
             options->push_update_=
options_found |=3D OPT_P_U_REDIR_GATEWAY;
         }
     }
@@ -3976,56 +39=
91,19 @@
             {
                 goto err;
             }
-        =
    gc_free(&options->dns_options=2Egc);
-            CLEAR(options->dns_op=
tions);
+            reset_dns_options(options);
             options->push=
_update_options_found |=3D OPT_P_U_DNS;
         }
     }
-#if defined(_WIN=
32) || defined(TARGET_ANDROID)
-    else if (streq(p[0], "dhcp-option") && =
p[1] && !p[3])
-    {
-        if (!(options->push_update_options_found & O=
PT_P_U_DHCP))
-        {
-            struct tuntap_options *o =3D &options=
->tuntap_options;
-            VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-       =
     o->domain =3D NULL;
-            o->netbios_scope =3D NULL;
-         =
   o->netbios_node_type =3D 0;
-            o->dns6_len =3D 0;
-           =
 CLEAR(o->dns6);
-            o->dns_len =3D 0;
-            CLEAR(o->dns);=

-            o->wins_len =3D 0;
-            CLEAR(o->wins);
-            =
o->ntp_len =3D 0;
-            CLEAR(o->ntp);
-            o->nbdd_len =3D =
0;
-            CLEAR(o->nbdd);
-            o->domain_search_list_len =3D =
0;
-            CLEAR(o->domain_search_list);
-            o->disable_nbt =
=3D 0;
-            o->dhcp_options =3D 0;
-
-            CLEAR(options->dn=
s_options=2Efrom_dhcp);
-#if defined(TARGET_ANDROID)
-            o->http_p=
roxy_port =3D 0;
-            o->http_proxy =3D NULL;
-#endif
-            =
options->push_update_options_found |=3D OPT_P_U_DHCP;
-        }
-    }
-#e=
lse  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
     else if (stre=
q(p[0], "dhcp-option") && p[1] && !p[3])
     {
         if (!(options->pus=
h_update_options_found & OPT_P_U_DHCP))
         {
             VERIFY_PERM=
ISSION(OPT_P_DHCPDNS);
-            delete_all_dhcp_fo(options, &es->list);=

+            reset_dhcp_options(options, es);
             options->push_u=
pdate_options_found |=3D OPT_P_U_DHCP;
         }
     }
-#endif /* if defi=
ned(_WIN32) || defined(TARGET_ANDROID) */
     add_option(options, p, is_in=
line, file, line, level, msglevel, permission_mask,
                option_=
types_found, es);
     return;
@@ -7847,18 +7825,7 @@
     }
     else
    =
 {
-        int i;
-        msglvl_t msglevel_unknown =3D msglevel_fc;
-   =
     /* Check if an option is in --ignore-unknown-option and
-         * se=
t warning level to non fatal */
-        for (i =3D 0; options->ignore_unkn=
own_option && options->ignore_unknown_option[i]; i++)
-        {
-         =
   if (streq(p[0], options->ignore_unknown_option[i]))
-            {
-    =
            msglevel_unknown =3D M_WARN;
-                break;
-         =
   }
-        }
+        const msglvl_t msglevel_unknown =3D msglevel_unkno=
wn_option(options, p[0], msglevel_fc);
         if (file)
         {
      =
       msg(msglevel_unknown,

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2164?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
Gerrit-Change-Num=
ber: 2164
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--/irtTul+Gik=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2164?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Marco Baffo</p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">opti=
ons: share the reset code of remove_option() and update_option()<br><br>rem=
ove_option() and update_option() reset routes, redirect-gateway,<br>--dns a=
nd --dhcp-option state with identical code=2E Move each reset into<br>a hel=
per, and the --ignore-unknown-option level lookup, also used by<br>add_opti=
on(), into another=2E<br><br>remove_option() loses a second dhcp-option bra=
nch that only Android<br>compiled and could never reach=2E delete_all_dhcp_=
fo() is no longer built<br>on Android, where that branch was its only user=
=2E<br><br>Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Marco Baf=
fo &lt;marco@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2164<br>Message-Id: &lt;20261110150210=2E17991-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/2026111=
0150210=2E17991-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file=
 changed, 114 insertions(+), 147 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2164/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span>=
<br><span>index 1d8bb2a=2E=2E2181076 100644</span><br><span>--- a/src/openv=
pn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><spa=
n>@@ -1012,6 +1012,7 @@</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if !defined(TARGET_ANDROID)</span><br><span> static void</span><br><s=
pan> delete_all_dhcp_fo(struct options *o, struct env_item **list)</span><b=
r><span> {</span><br><span>@@ -1043,6 +1044,7 @@</span><br><span>         p=
rev =3D current;</span><br><span>     }</span><br><span> }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif /* if !defined(TARGET_ANDROID=
) */</span><br><span> </span><br><span> #endif /* ifndef _WIN32 */</span><b=
r><span> </span><br><span>@@ -3577,12 +3579,107 @@</span><br><span>     ret=
urn options-&gt;forward_compatible ? M_WARN : msglevel;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine RESET_OPTION_ROUTES(option_ptr, field) \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (option_ptr)                            \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {                    =
                      \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        option_ptr-&gt;field =3D NULL;              \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        option_ptr-&gt;flags =3D 0;      =
           \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Retu=
rn M_WARN for an unknown option listed in --ignore-unknown-option */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static msglvl_t</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+msglevel_unknown_option(const =
struct options *options, const char *name, const msglvl_t msglevel)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; options-&gt;ignore_unkn=
own_option &amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (streq(name, options-&gt;ignore_u=
nknown_option[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return M_WARN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return msglevel;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* If IPv4 routes were inst=
alled, delete them and forget the configured ones */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+reset_routes_v4(struct context *c, struct options=
 *options, const struct env_set *es)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (c-&gt;c1=2Eroute_list)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    delete_routes_v4(c-&gt;c1=2Eroute_list, c-&gt;c1=2Etuntap, ROUTE_OPTION=
_FLAGS(&amp;c-&gt;options), es,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         &amp;c-&gt;net_ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;routes)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;routes-&gt;=
routes =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         options-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* If IPv6 routes were installed, de=
lete them and forget the configured ones */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+reset_routes_v6(struct context *c, struct options *options,=
 const struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&=
gt;c1=2Eroute_ipv6_list)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
elete_routes_v6(c-&gt;c1=2Eroute_ipv6_list, c-&gt;c1=2Etuntap, ROUTE_OPTION=
_FLAGS(&amp;c-&gt;options),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         es, &amp;c-&gt;net_ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;routes_ipv6)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;routes=
_ipv6-&gt;routes_ipv6 =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            options-&gt;routes_ipv6-&gt;flags =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_redirect_gateway(s=
truct options *options, struct env_set *es)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (options-&gt;routes)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        options-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (options-&gt;routes_ipv6)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    env_set_del(es, &quot;route_redirect_gateway_ip=
v4&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env_s=
et_del(es, &quot;route_redirect_gateway_ipv6&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_dns_o=
ptions(struct options *options)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;options-&gt;dns_options=2Egc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(options-&gt;dns_options);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_d=
hcp_options(struct options *options, struct env_set *es)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct tuntap_options *o =
=3D &amp;options-&gt;tuntap_options;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  o-&gt;domain =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    o-&gt;netbios_scope =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o-&gt;netbios_node_type =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dns6_len =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;dns6);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dns_len =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;dns);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;wins_len =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o-&gt;win=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;ntp_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o=
-&gt;ntp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt=
;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    CLEAR(o-&gt;domain_search_list);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    o-&gt;disable_nbt =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dhcp_options =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(options-&=
gt;dns_options=2Efrom_dhcp);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  o-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    o-&gt;http_proxy =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    delete_all_dhcp_fo(opti=
ons, &amp;es-&gt;list);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><s=
pan> void</span><br><span> remove_option(struct context *c, struct options =
*options, char *p[], bool is_inline,</span><br><span>@@ -3608,22 +3705,12 @=
@</span><br><span>     else if (streq(p[0], &quot;route&quot;) &amp;&amp; !=
p[1])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_ROUTE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(c-&gt;c1=2Eroute_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  delete_routes_v4(c-&gt;c1=2Eroute_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_F=
LAGS(&amp;c-&gt;options), es,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                             &amp;c-&gt;net_ctx);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            RESET_OPTION_ROUTES(options=
-&gt;routes, routes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
set_routes_v4(c, options, es);</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; !p[1])</span><br><s=
pan>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;c1=2Eroute_=
ipv6_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            delete_rout=
es_v6(c-&gt;c1=2Eroute_ipv6_list, c-&gt;c1=2Etuntap, ROUTE_OPTION_FLAGS(&am=
p;c-&gt;options),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                         es, &amp;c-&gt;net_ctx);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            RESET_OPTION_ROUTES(options-&gt;rou=
tes_ipv6, routes_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
reset_routes_v6(c, options, es);</span><br><span>     }</span><br><span>   =
  else if (streq(p[0], &quot;route-gateway&quot;) &amp;&amp; !p[1])</span><=
br><span>     {</span><br><span>@@ -3644,22 +3731,12 @@</span><br><span>   =
  else if ((streq(p[0], &quot;redirect-gateway&quot;) || streq(p[0], &quot;=
redirect-private&quot;)) &amp;&amp; !p[1])</span><br><span>     {</span><br=
><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (options-&gt;routes)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            options-&gt;routes-&gt;flags =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;routes_ipv6)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;routes_ipv=
6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        env_set=
_del(es, &quot;route_redirect_gateway_ipv4&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        env_set_del(es, &quot;route_redirect_g=
ateway_ipv6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        reset_redirect_gateway(options, es);</span><br><span>     }</span><=
br><span>     else if (streq(p[0], &quot;dns&quot;) &amp;&amp; !p[1])</span=
><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp=
;options-&gt;dns_options=2Egc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        CLEAR(options-&gt;dns_options);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        reset_dns_options(options);</span><br=
><span>     }</span><br><span>     else if (streq(p[0], &quot;topology&quot=
;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -3679,64 +37=
56,21 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br=
><span>         options-&gt;block_ipv6 =3D false;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) || d=
efined(TARGET_ANDROID)</span><br><span>     else if (streq(p[0], &quot;dhcp=
-option&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct tuntap_options *o =3D &amp=
;options-&gt;tuntap_options;</span><br><span>         VERIFY_PERMISSION(OPT=
_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;domain =3D NULL;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;netbios=
_scope =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   o-&gt;netbios_node_type =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        o-&gt;dns6_len =3D 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        memset(o-&gt;dns6, 0, sizeof(o-&gt;dns6));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;dns_len =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(o-&g=
t;dns, 0, sizeof(o-&gt;dns));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        o-&gt;wins_len =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        memset(o-&gt;wins, 0, sizeof(o-&gt;wins));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;ntp_len =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(o-&gt;nt=
p, 0, sizeof(o-&gt;ntp));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        o-&gt;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        memset(o-&gt;nbdd, 0, sizeof(o-&gt;nbdd));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;domain_search_list_l=
en =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEA=
R(o-&gt;domain_search_list);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        o-&gt;disable_nbt =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        o-&gt;dhcp_options =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        CLEAR(options-&gt;dns_options=2Efro=
m_dhcp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_ANDROID)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;http_proxy_por=
t =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt=
;http_proxy =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reset=
_dhcp_options(options, es);</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif /* if defined(_WIN32) || defined(TARGET=
_ANDROID) */</span><br><span> #ifdef _WIN32</span><br><span>     else if (s=
treq(p[0], &quot;block-outside-dns&quot;) &amp;&amp; !p[1])</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><b=
r><span>         options-&gt;block_outside_dns =3D false;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef _=
WIN32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (=
streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; !p[1])</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        delete_all_dhcp_fo(options, &a=
mp;es-&gt;list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span> #endif</span><br><span>     else</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t msglev=
el_unknown =3D msglevel_fc;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        /* Check if an option is in --ignore-unknown-option and</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         * set warning leve=
l to non fatal */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (int i =3D 0; options-&gt;ignore_unknown_option &amp;&amp; options-=
&gt;ignore_unknown_option[i]; i++)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (streq(p[0], options-&gt;ignore_unknown_option[i]))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                msglevel_unknown =3D =
M_WARN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel_unknown,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel_un=
known_option(options, p[0], msglevel_fc),</span><br><span>             &quo=
t;Unrecognized option or missing or extra parameter(s) in %s:%d: -%s (%s)&q=
uot;, file, line,</span><br><span>             p[0], PACKAGE_VERSION);</spa=
n><br><span>     }</span><br><span>@@ -3922,12 +3956,7 @@</span><br><span> =
            {</span><br><span>                 goto err;</span><br><span>  =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (c-&gt;c1=2Eroute_list)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                delete_routes_v4(c-&gt;c1=2Eroute_list, c-&gt;c1=2Etuntap, =
ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                 es, &amp;c-&gt;net_ctx);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                RESET=
_OPTION_ROUTES(options-&gt;routes, routes);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            reset_routes_v4(c, options, es);</span><br><spa=
n>             options-&gt;push_update_options_found |=3D OPT_P_U_ROUTE;</s=
pan><br><span>         }</span><br><span>     }</span><br><span>@@ -3940,12=
 +3969,7 @@</span><br><span>             {</span><br><span>                =
 goto err;</span><br><span>             }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (c-&gt;c1=2Eroute_ipv6_list)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                delete_routes_v6(c-&gt;c1=
=2Eroute_ipv6_list, c-&gt;c1=2Etuntap,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                 ROUTE_OPTION_FLAGS(&amp;c=
-&gt;options), es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                RESET_OPTION_ROUTES(options-&gt;routes_ip=
v6, routes_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  reset_routes_v6(c, options, es);</span><br><span>             options-&gt=
;push_update_options_found |=3D OPT_P_U_ROUTE6;</span><br><span>         }<=
/span><br><span>     }</span><br><span>@@ -3954,16 +3978,7 @@</span><br><sp=
an>         if (!(options-&gt;push_update_options_found &amp; OPT_P_U_REDIR=
_GATEWAY))</span><br><span>         {</span><br><span>             VERIFY_P=
ERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (options-&gt;routes)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                options-&gt;routes-&gt;flags =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;routes_ipv6)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;rout=
es_ipv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       env_set_del(es, &quot;route_redirect_gateway_ipv4&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            env_set_del(es, &quo=
t;route_redirect_gateway_ipv6&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            reset_redirect_gateway(options, es);</span><b=
r><span>             options-&gt;push_update_options_found |=3D OPT_P_U_RED=
IR_GATEWAY;</span><br><span>         }</span><br><span>     }</span><br><sp=
an>@@ -3976,56 +3991,19 @@</span><br><span>             {</span><br><span> =
                goto err;</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            gc_free(&amp;options-&gt;dns=
_options=2Egc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      CLEAR(options-&gt;dns_options);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            reset_dns_options(options);</span><br><span> =
            options-&gt;push_update_options_found |=3D OPT_P_U_DNS;</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(_WIN32) || defined(TARGET_ANDROID)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quo=
t;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!(options-&gt;push_update_options_found &amp; =
OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct =
tuntap_options *o =3D &amp;options-&gt;tuntap_options;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            VERIFY_PERMISSION(OPT_P_DHCPDN=
S);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            o-&gt;domain =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;netbios_=
scope =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      o-&gt;netbios_node_type =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            o-&gt;dns6_len =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;dns6);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            o-&gt;dns_len =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;dns)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;wi=
ns_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    CLEAR(o-&gt;wins);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            o-&gt;ntp_len =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            CLEAR(o-&gt;ntp);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            o-&gt;nbdd_len =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            CLEAR(o-&gt;nbdd);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;domain_search_li=
st_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    CLEAR(o-&gt;domain_search_list);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            o-&gt;disable_nbt =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o-&gt;dhcp_options =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            CLEAR(options-&gt;dns_options=2Efrom=
_dhcp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TA=
RGET_ANDROID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    o-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            o-&gt;http_proxy =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            options-&gt;push_update_options_found |=3D OPT_P_U=
_DHCP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(_WIN32) || defined(TAR=
GET_ANDROID) */</span><br><span>     else if (streq(p[0], &quot;dhcp-option=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br>=
<span>         if (!(options-&gt;push_update_options_found &amp; OPT_P_U_DH=
CP))</span><br><span>         {</span><br><span>             VERIFY_PERMISS=
ION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          delete_all_dhcp_fo(options, &amp;es-&gt;list);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            reset_dhcp_options(options=
, es);</span><br><span>             options-&gt;push_update_options_found |=
=3D OPT_P_U_DHCP;</span><br><span>         }</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(_WIN32) =
|| defined(TARGET_ANDROID) */</span><br><span>     add_option(options, p, i=
s_inline, file, line, level, msglevel, permission_mask,</span><br><span>   =
             option_types_found, es);</span><br><span>     return;</span><b=
r><span>@@ -7847,18 +7825,7 @@</span><br><span>     }</span><br><span>     =
else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msglvl_t msglevel_unknown =3D msglevel_fc;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* Check if an option is in --ignore-un=
known-option and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    * set warning level to non fatal */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        for (i =3D 0; options-&gt;ignore_unknown_option &=
amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (streq(p[0], options-&gt;ignore_unknown_=
option[i]))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ms=
glevel_unknown =3D M_WARN;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t msglvl_t msglevel_unknown =3D msglevel_unknown_option(options, p[0], msgl=
evel_fc);</span><br><span>         if (file)</span><br><span>         {</sp=
an><br><span>             msg(msglevel_unknown,</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Dema=
il">change 2164</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2164?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2164 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Marco Baffo &lt;mar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--/irtTul+Gik=--


--===============5163805341041672963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5163805341041672963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5163805341041672963==--


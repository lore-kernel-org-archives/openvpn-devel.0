Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B84606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=icVjMEZM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OvMEEFrf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JUbJErI0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fqa4A1jJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fWrXEWYnMdBS9Seaml2ssW4w5FpWbsF2e/iI4nq6R1c=; b=icVjMEZMq8eB2+M307GWzPhuIg
	CaGHej75Yi4hbFeh1HK37ixkPQL2OTs1Rs/WqbO3RjvDb6ldNQzahenkydSZXEnSFtaoJIDgd1kCB
	R0Nb7IiUrI/+Tkzmpw2/hp8NvO5pm9N5cTmSwFMU53yXqMvfet1YsJ7zfplk8UIhcAdo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNwp-000000004Zv-2psh;
	Tue, 17 Nov 2026 18:30:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNwo-000000004Zo-2bOT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:30:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yk/lZPPIwZGB8fRoHCussD2YXviJAwLctIOsI3YXKvg=; b=OvMEEFrf4oGUUHjXlSMdMRVfKD
 5fGzCePi90a+Yn3/z9QDBEIvGmI8J14f+fLCSVth8UpyNirFbfJvnSTqbXPgl8c6PV6B6Xrkl9GQj
 Tl4M/4TrNZviZwZhJcW97Fsh2pJjgQYL13w9ZIrfqA8Q/o70gNUpxeY/4dE3pRP/2BBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yk/lZPPIwZGB8fRoHCussD2YXviJAwLctIOsI3YXKvg=; b=JUbJErI0neX7pMUFLfNfYEYJ/6
 urH31+NXqvc8qbkEm17wgMvtI0mSdaVfsZvsB9hPhwGl+oEkmnjGWr5jt3VO6OAXmmXW8fBi7ZwR7
 s9qQxyAso9qNAQCSx4kFlABr77YRrNu09Y50CKSH7HlA3cKUYYifXRbCNK9ZWuhQaHFo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNwl-000000001Qp-1ahX for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:30:26 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so1238905e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794940217; x=1795545017; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yk/lZPPIwZGB8fRoHCussD2YXviJAwLctIOsI3YXKvg=;
 b=fqa4A1jJTjzlTtZ2bP4ju7ZMbAh5xJBIj/uubQBrqptA9pM1dHnvholNNoqGT5ooZ2
 EHdphmIDwJX4/cO3e9djsPuhJI2B36lUzbtVU3XUvXZq2o6FTs4DdcVXaOZN0kXBCeeN
 co6m4HXP1E7gdeslK+6hmAf+U8Y07pba0R5jCrluDOt+QTgZHSNhrVzYgUcjlGsfadIy
 kb13AEuxEzzSA8ZPUI7DJ03uPgw6ujVVaDHgy0mw1cPeZHjxeL9+Ay6xpDt0ZO+T2bOB
 aRVbuG5PenKU0aykL/YYFwXNvFgcq45MTujtv2VEfZV+pwkPptJ5RfhuzEeJY4THT10m
 Zk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940217; x=1795545017;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yk/lZPPIwZGB8fRoHCussD2YXviJAwLctIOsI3YXKvg=;
 b=FfRKup8MenIN/soH4Ac7YO++ooe1eGNO1IgXOJnw1/8lebduPKpcGNPiSUD1xjGOJK
 X6YXufq4nWb7iDj8pcoikbS0XuMUraNTCJpzOBAJR2ueSd7Xktrs3RX5k/qvKzpy2mGg
 Op5huv3Z0gYfwLrNKNeilu6VyPKnYmB9FwO3YhtaZK2wfxr1IRQGYB3KgrWvj3ZqvJWo
 JT9+YPqmhCSlhr0FT4WqnZYYyUKZKs7Dcp4pKfxxetBlvl29bmRs52bWCCtx4U+LTbBr
 mbXU9b2+K4X01tZNPAzAN0WxRHc0XOn/sECwI6Sk16BoPDYQTlkHq+3kS0RutSsWAGxD
 mi3A==
X-Gm-Message-State: APuU4Z+PAGXewx6IOSmaUhl+p2TNIru06s/vfRgSnK48o0OaE1l5ZzCE
 gbpVd8kOSenES9BErmmDQVWpPOBaR/7ZBC/qNmg8O99nVAS/r2GkvcJxB0lisqh+z2CLCNW3WMm
 0pm+YxEQSCpWMUkRee9BBYbFp9W+J1dHq35RSc8kZSagyrZzmq/wzUm/jFqPf3VdkdFZY
X-Gm-Gg: AYBFou33kzmsiq5uCH+L3WWFB7+y9wIVlXdnZDQJSESpOsgUZI1OYv2UPv7C7ZuTKbK
 R2/ssdWJZQWlsRo8jD01a5A3MkwDxEgnF72rYZBM61zrfCkAqlr9741v6QmVhVH/fFz1irEE4lW
 SwJdpO/q9VLV65C+xN3IRMmyH04qvG3soLhvgcb0S+8bflxhQSnZbHRoyBZS7s5cNqH8Xi6Lt3l
 iArMB/QCpspB61OMRCmNpmIcX4uh74wg7nsZVzC7bFzlI2FxKY8SX+qCGGwCOQIpUBHmh+geqV+
 3Zr0ZeMmDt6y9uAAYDUE0cNSyWboXdGjB5ecxXtzp+yq0xft4oLJkrtGHCoRVsPkibfjVhMjbEY
 xSVlz/RB5YumW04sqlMiL5myKHBjm8uMhXrJlFUiGekBFRNf93zsHsXX3xtL4qb+BsSKYQL56hQ
 C13VNsq2Cd9TMkXdP4HDcMmbv2RMbqMmZvPHdYODiBUVykowBfSMPwgslNRRsPdNu1Xxn7oawg5
 rJzoqurKtcrnEfiDAEWKcG5hcH0J5/7DKjC9YJN+u4apd32KLNMBaYPOGxEj6Fgwwl3Vfiz6XFq
 0yQxlmFoveST0KtGK2hhBWj6746GfG2KgaHDeOZ0RVDn/Zyx1wHRLAIUI4Hjl3A3sr8SghmEecn
 bOqqx8c7TNWxt9GyqxvqJg6sNKR85/hCGfNw+g8Gd67ELNox7w2h1zEXqNtfv1RFV7mOfto/gFE
 5O6lKKe7RFBoOldFM=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:7033:c92f with SMTP id
 5b1f17b1804b1-4bb7da0f671mr354775e9.11.1794940215323; 
 Tue, 17 Nov 2026 10:30:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a64b60940csm235533f8f.0.2026.11.17.10.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:30:14 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 18:30:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
X-Gerrit-Change-Number: 2154
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2154?usp=email>
X-Gerrit-Commit: e37875c254cadf43008ef5acf3cf2ea0f9bd77ec
In-Reply-To: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
References: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkk2MDE0NTRhNTExYzlhYWM0ZjM3ZDg2MjliMTY5MjI2NmNkYmQ2ODg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eff567fdcfbb02bd5aea5d1117ec2c249a947d78-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNwl-000000001Qp-1ahX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: use the net_
 API for routes on FreeBSD and DragonFly
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
Content-Type: multipart/mixed; boundary="===============4124357876340974017=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4124357876340974017==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ky+MtP4XrM0="; charset=UTF-8

--ky+MtP4XrM0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2154?usp=3Demail

to look at the new patch set (#=
3)=2E


Change subject: route: use the net_ API for routes on FreeBSD and D=
ragonFly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

rout=
e: use the net_ API for routes on FreeBSD and DragonFly

Add and delete IPv=
4 and IPv6 routes through net_route_v4/v6_add/del()
on FreeBSD and DragonFl=
y, as on Linux, instead of running route(8)
from route=2Ec=2E Build network=
ing_freebsd=2Ec for DragonFly as well; -fib
is only passed on FreeBSD=2E

-=
-route-table stays Linux only=2E A non-contiguous IPv4 netmask now gets
an =
error instead of an invalid prefix length=2E networking_freebsd=2Ec
logs ro=
ute commands at D_ROUTE, as route=2Ec did=2E The shared error
messages lose=
 their "Linux" prefix=2E

Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6=
885
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvp=
n/networking=2Eh
M src/openvpn/networking_freebsd=2Ec
M src/openvpn/route=
=2Ec
3 files changed, 74 insertions(+), 128 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/2154/3

diff --git a/=
src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 7ad6e2e=2E=2E=
4b30092 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networkin=
g=2Eh
@@ -30,7 +30,7 @@
 #include "networking_sitnl=2Eh"
 #elif ENABLE_IPRO=
UTE
 #include "networking_iproute2=2Eh"
-#elif defined(TARGET_FREEBSD)
+#el=
if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 typedef void *open=
vpn_net_ctx_t;
 typedef char openvpn_net_iface_t;
 #else  /* ifdef ENABLE_S=
ITNL */
@@ -236,7 +236,8 @@
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
=
 
-#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_F=
REEBSD)
+#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TA=
RGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY)
 /**
  * Add a route for =
an IPv4 address/network
  *
@@ -309,7 +310,7 @@
                      const=
 struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
   =
                   int metric);
 
-#endif /* ENABLE_SITNL || ENABLE_IPROUTE=
 || TARGET_FREEBSD */
+#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_F=
REEBSD || TARGET_DRAGONFLY */
 
 #if defined(ENABLE_SITNL) || defined(ENABL=
E_IPROUTE)
 
diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/=
networking_freebsd=2Ec
index e3697d4=2E=2E0b2b225 100644
--- a/src/openvpn/=
networking_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -6,7 +6,=
7 @@
 #include "run_command=2Eh"
 #include "networking=2Eh"
 
-#if defined(=
TARGET_FREEBSD)
+#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 =

 static int
 net_route_v4(const char *op, const in_addr_t *dst, int prefix=
len, const in_addr_t *gw,
@@ -26,6 +26,7 @@
      */
     argv_printf(&argv=
, "%s %s -net %s/%d", ROUTE_PATH, op,
                 inet_ntop(AF_INET, &=
_dst, buf1, sizeof(buf1)), prefixlen);
+    /* FIXME -- add on-link support=
: iface is ignored when gw is set */
     if (gw)
     {
         _gw =3D n=
tohl(*gw);
@@ -35,14 +36,22 @@
     {
         argv_printf_cat(&argv, "-ifa=
ce %s", iface);
     }
+#if 0
+    if (metric >=3D 0)
+    {
+        argv_=
printf_cat(&argv, "-rtt %d", metric);
+    }
+#endif
+#if defined(TARGET_FR=
EEBSD)
     /* without -fib, route(8) uses the FIB of the process */
     i=
f (table)
     {
         argv_printf_cat(&argv, "-fib %u", table);
     }
=
+#endif
 
-    argv_msg(M_INFO, &argv);
-    bool status =3D openvpn_execve=
_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
+    argv_ms=
g(D_ROUTE, &argv);
+    bool status =3D openvpn_execve_check(&argv, NULL, 0=
, "ERROR: route command failed");
 
     argv_free(&argv);
 
@@ -77,13 +86,=
15 @@
     {
         argv_printf_cat(&argv, "-iface %s", iface);
     }
+#=
if defined(TARGET_FREEBSD)
     if (table)
     {
         argv_printf_cat(=
&argv, "-fib %u", table);
     }
+#endif
 
-    argv_msg(M_INFO, &argv);
- =
   bool status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD rou=
te command failed");
+    argv_msg(D_ROUTE, &argv);
+    bool status =3D op=
envpn_execve_check(&argv, NULL, 0, "ERROR: route command failed");
 
     a=
rgv_free(&argv);
 
@@ -118,4 +129,4 @@
     return net_route_v6("delete", d=
st, prefixlen, gw, iface, table, metric);
 }
 
-#endif /* if defined(TARGET=
_FREEBSD) */
+#endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGON=
FLY) */
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 90=
86529=2E=2E18c3292 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -103,6 +103,18 @@
 #define RTA_SUCCESS 1 /* route addition succee=
ded */
 #define RTA_EEXIST  2 /* route not added as it already exists */
 
=
+/* Platforms that add and delete routes through the net_ API (networking=
=2Eh) */
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(T=
ARGET_DRAGONFLY)
+#define ROUTE_NET_API
+#endif
+
+/* --route-table is supp=
orted only on Linux */
+#if defined(TARGET_LINUX)
+#define ROUTE_TABLE_ID(i=
d) (id)
+#else
+#define ROUTE_TABLE_ID(id) 0
+#endif
+
 #ifndef TARGET_ANDR=
OID
 static bool
 add_bypass_address(struct route_bypass *rb, const in_addr=
_t a)
@@ -1429,7 +1441,7 @@
 
 /* Return true if the "on-link" form of the =
route should be used=2E  This is when the gateway for
  * a route is specif=
ied as an interface rather than an address=2E */
-#if defined(TARGET_LINUX)=
 || defined(_WIN32) || defined(TARGET_DARWIN)
+#if defined(ROUTE_NET_API) |=
| defined(_WIN32) || defined(TARGET_DARWIN)
 static inline bool
 is_on_link=
(const struct route_ipv4 *r, const unsigned int flags,
            const st=
ruct route_gateway_info *rgi)
@@ -1455,7 +1467,7 @@
     struct argv argv =
=3D argv_new();
     struct gc_arena gc =3D gc_new();
 
-#if !defined(TARGE=
T_LINUX)
+#if !defined(ROUTE_NET_API)
     const char *network =3D print_in=
_addr_t(r->network, 0, &gc);
 #if !defined(TARGET_AIX)
     const char *net=
mask =3D print_in_addr_t(r->netmask, 0, &gc);
@@ -1464,7 +1476,7 @@
 #endif=

 
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     const char=
 *iface =3D NULL;
     int metric =3D -1;
 
@@ -1478,18 +1490,26 @@
       =
  metric =3D r->metric;
     }
 
+    const int netbits =3D netmask_to_netb=
its2(r->netmask);
+    if (netbits < 0)
+    {
+        msg(M_WARN, "ERROR:=
 cannot add route with non-contiguous netmask %s",
+            print_in_ad=
dr_t(r->netmask, 0, &gc));
+        status =3D RTA_ERROR;
+        goto don=
e;
+    }
 
     status =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_add(=
ctx, &r->network, netmask_to_netbits2(r->netmask), &r->gateway,
-          =
                     iface, r->table_id, metric);
+    int ret =3D net_rout=
e_v4_add(ctx, &r->network, netbits, &r->gateway, iface,
+                  =
             ROUTE_TABLE_ID(r->table_id), metric);
     if (ret =3D=3D -EEX=
IST)
     {
-        msg(D_ROUTE, "NOTE: Linux route add command failed bec=
ause route exists");
+        msg(D_ROUTE, "NOTE: route add command failed =
because route exists");
         status =3D RTA_EEXIST;
     }
     else if=
 (ret < 0)
     {
-        msg(M_WARN, "ERROR: Linux route add command fail=
ed");
+        msg(M_WARN, "ERROR: route add command failed");
         sta=
tus =3D RTA_ERROR;
     }
 
@@ -1593,44 +1613,6 @@
     bool ret =3D openvp=
n_execve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
  =
   status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBS=
D)
-
-    argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->fl=
ags & RT_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", =
r->metric);
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", n=
etwork, gateway, netmask);
-
-    /* FIXME -- add on-link support for FreeB=
SD */
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_che=
ck(&argv, es, 0, "ERROR: FreeBSD route add command failed");
-    status =
=3D ret ? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_DRAGONFLY)
-
-  =
  argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT=
_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r->metri=
c);
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network, =
gateway, netmask);
-
-    /* FIXME -- add on-link support for Dragonfly */
=
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&ar=
gv, es, 0, "ERROR: DragonFly route add command failed");
-    status =3D re=
t ? RTA_SUCCESS : RTA_ERROR;
-
 #elif defined(TARGET_DARWIN)
 
     argv_pr=
intf(&argv, "%s add", ROUTE_PATH);
@@ -1696,11 +1678,12 @@
     bool ret =
=3D openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route add command=
 failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#else  /* if d=
efined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(M_=
FATAL,
         "Sorry, but I don't know how to do 'route' commands on this=
 operating system=2E  Try putting your routes in a --route-up script");
-#e=
ndif /* if defined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */=

 
+done:
     if (status =3D=3D RTA_SUCCESS)
     {
         r->flags |=3D=
 RT_ADDED;
@@ -1773,8 +1756,7 @@
     const char *network =3D print_in6_add=
r(r6->network, 0, &gc);
     const char *gateway =3D print_in6_addr(r6->gat=
eway, 0, &gc);
 
-#if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || =
defined(TARGET_DRAGONFLY) \
-    || defined(TARGET_OPENBSD) || defined(TARG=
ET_NETBSD)
+#if defined(TARGET_DARWIN) || defined(TARGET_OPENBSD) || define=
d(TARGET_NETBSD)
 
     /* the BSD platforms cannot specify gateway and int=
erface independently,
      * but for link-local destinations, we MUST spec=
ify the interface, so
@@ -1826,7 +1808,7 @@
         goto done;
     }
 
-#=
if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     int metric =3D -1=
;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
@@ -=
1835,15 +1817,15 @@
 
     status =3D RTA_SUCCESS;
     int ret =3D net_rou=
te_v6_add(ctx, &r6->network, r6->netbits, gateway_needed ? &r6->gateway : N=
ULL,
-                               device, r6->table_id, metric);
+      =
                         device, ROUTE_TABLE_ID(r6->table_id), metric);
   =
  if (ret =3D=3D -EEXIST)
     {
-        msg(D_ROUTE, "NOTE: Linux route a=
dd command failed because route exists");
+        msg(D_ROUTE, "NOTE: rout=
e add command failed because route exists");
         status =3D RTA_EEXIST=
;
     }
     else if (ret < 0)
     {
-        msg(M_WARN, "ERROR: Linux r=
oute add command failed");
+        msg(M_WARN, "ERROR: route add command f=
ailed");
         status =3D RTA_ERROR;
     }
 
@@ -1889,23 +1871,6 @@
   =
  bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add=
 -inet6 command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
=
-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
-
-    argv_pri=
ntf(&argv, "%s add -inet6 %s/%d", ROUTE_PATH, network, r6->netbits);
-
-   =
 if (gateway_needed)
-    {
-        argv_printf_cat(&argv, "%s", gateway);=

-    }
-    else
-    {
-        argv_printf_cat(&argv, "-iface %s", devic=
e);
-    }
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execv=
e_check(&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
-    =
status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-
 #elif defined(TARGET_DARWIN)
 =

     argv_printf(&argv, "%s add -inet6 %s -prefixlen %d", ROUTE_PATH, netw=
ork, r6->netbits);
@@ -1956,10 +1921,10 @@
     bool ret =3D openvpn_execve=
_check(&argv, es, 0, "ERROR: Haiku inet6 route add command failed");
     s=
tatus =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#else  /* if defined(TARGET_LIN=
UX) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,
         "=
Sorry, but I don't know how to do 'route ipv6' commands on this operating s=
ystem=2E  Try putting your routes in a --route-up script");
-#endif /* if d=
efined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
 done:
  =
   if (status =3D=3D RTA_SUCCESS)
@@ -1982,13 +1947,13 @@
 delete_route(str=
uct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
           =
   const struct route_gateway_info *rgi, const struct env_set *es, openvpn_=
net_ctx_t *ctx)
 {
-#if !defined(TARGET_LINUX)
+#if !defined(ROUTE_NET_API)=

     const char *network;
 #if !defined(TARGET_AIX)
     const char *netma=
sk;
 #endif
     const char *gateway;
-#else /* if !defined(TARGET_LINUX) *=
/
+#else /* if !defined(ROUTE_NET_API) */
     int metric;
 #endif
 
@@ -20=
00,7 +1965,7 @@
     struct gc_arena gc =3D gc_new();
     struct argv argv=
 =3D argv_new();
 
-#if !defined(TARGET_LINUX)
+#if !defined(ROUTE_NET_API)=

     network =3D print_in_addr_t(r->network, 0, &gc);
 #if !defined(TARGET=
_AIX)
     netmask =3D print_in_addr_t(r->netmask, 0, &gc);
@@ -2009,7 +197=
4,7 @@
 #endif
 
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
 =
    metric =3D -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
@@ -2017,1=
0 +1982,10 @@
     }
 
     if (net_route_v4_del(ctx, &r->network, netmask_=
to_netbits2(r->netmask), &r->gateway, NULL,
-                         r->ta=
ble_id, metric)
+                         ROUTE_TABLE_ID(r->table_id), metr=
ic)
         < 0)
     {
-        msg(M_WARN, "ERROR: Linux route delete co=
mmand failed");
+        msg(M_WARN, "ERROR: route delete command failed");=

     }
 #elif defined(_WIN32)
 
@@ -2070,20 +2035,6 @@
     argv_msg(D_ROU=
TE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route d=
elete command failed");
 
-#elif defined(TARGET_FREEBSD)
-
-    argv_printf=
(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
=
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "E=
RROR: FreeBSD route delete command failed");
-
-#elif defined(TARGET_DRAGON=
FLY)
-
-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, netwo=
rk, gateway, netmask);
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve=
_check(&argv, es, 0, "ERROR: DragonFly route delete command failed");
-
 #e=
lif defined(TARGET_DARWIN)
 
     if (is_on_link(r, flags, rgi))
@@ -2131,1=
0 +2082,10 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&arg=
v, es, 0, "ERROR: Haiku inet route delete command failed");
 
-#else  /* if=
 defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(=
M_FATAL,
         "Sorry, but I don't know how to do 'route' commands on th=
is operating system=2E  Try putting your routes in a --route-up script");
-=
#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) =
*/
 
     r->flags &=3D ~RT_ADDED;
     argv_free(&argv);
@@ -2155,7 +2106,=
7 @@
     }
 
 #if !defined(_WIN32)
-#if !defined(TARGET_LINUX)
+#if !defin=
ed(ROUTE_NET_API)
     const char *gateway;
 #endif
 #if !defined(TARGET_SO=
LARIS)
@@ -2182,12 +2133,11 @@
     struct argv argv =3D argv_new();
 
    =
 network =3D print_in6_addr(r6->network, 0, &gc);
-#if !defined(TARGET_LINU=
X) && !defined(_WIN32)
+#if !defined(ROUTE_NET_API) && !defined(_WIN32)
   =
  gateway =3D print_in6_addr(r6->gateway, 0, &gc);
 #endif
 
-#if defined(T=
ARGET_DARWIN) || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \
-  =
  || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_=
DARWIN) || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the =
BSD platforms cannot specify gateway and interface independently,
      * b=
ut for link-local destinations, we MUST specify the interface, so
@@ -2205,=
7 +2155,7 @@
 
     msg(D_ROUTE, "delete_route_ipv6(%s/%u)", network, r6->n=
etbits);
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     int =
metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0)=
)
     {
@@ -2213,10 +2163,10 @@
     }
 
     if (net_route_v6_del(ctx, &r=
6->network, r6->netbits, gateway_needed ? &r6->gateway : NULL,
-           =
              device, r6->table_id, metric)
+                         devic=
e, ROUTE_TABLE_ID(r6->table_id), metric)
         < 0)
     {
-        msg(=
M_WARN, "ERROR: Linux route v6 delete command failed");
+        msg(M_WARN=
, "ERROR: route v6 delete command failed");
     }
 
 #elif defined(_WIN32)=

@@ -2238,22 +2188,6 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_=
check(&argv, es, 0, "ERROR: Solaris route delete -inet6 command failed");
 =

-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
-
-    argv_pr=
intf(&argv, "%s delete -inet6 %s/%d", ROUTE_PATH, network, r6->netbits);
-
=
-    if (gateway_needed)
-    {
-        argv_printf_cat(&argv, "%s", gatew=
ay);
-    }
-    else
-    {
-        argv_printf_cat(&argv, "-iface %s", d=
evice);
-    }
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&=
argv, es, 0, "ERROR: *BSD route delete -inet6 command failed");
-
 #elif de=
fined(TARGET_DARWIN)
 
     argv_printf(&argv, "%s delete -inet6 %s -prefix=
len %d", ROUTE_PATH, network, r6->netbits);
@@ -2306,10 +2240,10 @@
     ar=
gv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Hai=
ku inet6 route delete command failed");
 
-#else  /* if defined(TARGET_LINU=
X) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,
         "S=
orry, but I don't know how to do 'route ipv6' commands on this operating sy=
stem=2E  Try putting your routes in a --route-down script");
-#endif /* if =
defined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
     arg=
v_free(&argv);
     gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2154?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
Gerrit-Change-=
Number: 2154
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ky+MtP4XrM0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">route: use the net_ API for routes on FreeBSD and DragonFly<br><b=
r>Add and delete IPv4 and IPv6 routes through net_route_v4/v6_add/del()<br>=
on FreeBSD and DragonFly, as on Linux, instead of running route(8)<br>from =
route=2Ec=2E Build networking_freebsd=2Ec for DragonFly as well; -fib<br>is=
 only passed on FreeBSD=2E<br><br>--route-table stays Linux only=2E A non-c=
ontiguous IPv4 netmask now gets<br>an error instead of an invalid prefix le=
ngth=2E networking_freebsd=2Ec<br>logs route commands at D_ROUTE, as route=
=2Ec did=2E The shared error<br>messages lose their &quot;Linux&quot; prefi=
x=2E<br><br>Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openv=
pn/networking=2Eh<br>M src/openvpn/networking_freebsd=2Ec<br>M src/openvpn/=
route=2Ec<br>3 files changed, 74 insertions(+), 128 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/54/2154/3</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/networking=2Eh b/src/open=
vpn/networking=2Eh</span><br><span>index 7ad6e2e=2E=2E4b30092 100644</span>=
<br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvp=
n/networking=2Eh</span><br><span>@@ -30,7 +30,7 @@</span><br><span> #includ=
e &quot;networking_sitnl=2Eh&quot;</span><br><span> #elif ENABLE_IPROUTE</s=
pan><br><span> #include &quot;networking_iproute2=2Eh&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBS=
D) || defined(TARGET_DRAGONFLY)</span><br><span> typedef void *openvpn_net_=
ctx_t;</span><br><span> typedef char openvpn_net_iface_t;</span><br><span> =
#else  /* ifdef ENABLE_SITNL */</span><br><span>@@ -236,7 +236,8 @@</span><=
br><span> </span><br><span> #endif /* ENABLE_SITNL || ENABLE_IPROUTE */</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_SIT=
NL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD) \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    || defined(TARGET_DRAGONFLY)</s=
pan><br><span> /**</span><br><span>  * Add a route for an IPv4 address/netw=
ork</span><br><span>  *</span><br><span>@@ -309,7 +310,7 @@</span><br><span=
>                      const struct in6_addr *gw, const openvpn_net_iface_t=
 *iface, uint32_t table,</span><br><span>                      int metric);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_SITNL || ENABLE_IPR=
OUTE || TARGET_FREEBSD || TARGET_DRAGONFLY */</span><br><span> </span><br><=
span> #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/ope=
nvpn/networking_freebsd=2Ec</span><br><span>index e3697d4=2E=2E0b2b225 1006=
44</span><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span=
>+++ b/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -6,7 +6,7 @@</=
span><br><span> #include &quot;run_command=2Eh&quot;</span><br><span> #incl=
ude &quot;networking=2Eh&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(TARGET_FREEBSD)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD) || defined(T=
ARGET_DRAGONFLY)</span><br><span> </span><br><span> static int</span><br><s=
pan> net_route_v4(const char *op, const in_addr_t *dst, int prefixlen, cons=
t in_addr_t *gw,</span><br><span>@@ -26,6 +26,7 @@</span><br><span>      */=
</span><br><span>     argv_printf(&amp;argv, &quot;%s %s -net %s/%d&quot;, =
ROUTE_PATH, op,</span><br><span>                 inet_ntop(AF_INET, &amp;_d=
st, buf1, sizeof(buf1)), prefixlen);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* FIXME -- add on-link support: iface is ignored when=
 gw is set */</span><br><span>     if (gw)</span><br><span>     {</span><br=
><span>         _gw =3D ntohl(*gw);</span><br><span>@@ -35,14 +36,22 @@</sp=
an><br><span>     {</span><br><span>         argv_printf_cat(&amp;argv, &qu=
ot;-iface %s&quot;, iface);</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if 0</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (metric &gt;=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;, metric);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD)</span><br><span>    =
 /* without -fib, route(8) uses the FIB of the process */</span><br><span> =
    if (table)</span><br><span>     {</span><br><span>         argv_printf_=
cat(&amp;argv, &quot;-fib %u&quot;, table);</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp=
;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool statu=
s =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route c=
ommand failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool status =3D openvpn_execve_check(&amp;argv, NULL, 0=
, &quot;ERROR: route command failed&quot;);</span><br><span> </span><br><sp=
an>     argv_free(&amp;argv);</span><br><span> </span><br><span>@@ -77,13 +=
86,15 @@</span><br><span>     {</span><br><span>         argv_printf_cat(&a=
mp;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD)</spa=
n><br><span>     if (table)</span><br><span>     {</span><br><span>        =
 argv_printf_cat(&amp;argv, &quot;-fib %u&quot;, table);</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg=
(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bool status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: Fr=
eeBSD route command failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool status =3D openvpn_execve_check(&amp;=
argv, NULL, 0, &quot;ERROR: route command failed&quot;);</span><br><span> <=
/span><br><span>     argv_free(&amp;argv);</span><br><span> </span><br><spa=
n>@@ -118,4 +129,4 @@</span><br><span>     return net_route_v6(&quot;delete=
&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /*=
 if defined(TARGET_FREEBSD) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY=
) */</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 9086529=2E=2E18c3292 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -103,6 +103,18 @@</span><br><span> #define RTA_SUCCESS 1 /* rou=
te addition succeeded */</span><br><span> #define RTA_EEXIST  2 /* route no=
t added as it already exists */</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Platforms that add and delete routes throu=
gh the net_ API (networking=2Eh) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || def=
ined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define ROUTE_NET_API</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* --route-table is support=
ed only on Linux */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define ROUTE_TABLE_ID(id) (id)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define ROUTE_TABLE_ID(id) 0</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> #ifndef TARGET_ANDROID</span><br><span> static bool</span=
><br><span> add_bypass_address(struct route_bypass *rb, const in_addr_t a)<=
/span><br><span>@@ -1429,7 +1441,7 @@</span><br><span> </span><br><span> /*=
 Return true if the &quot;on-link&quot; form of the route should be used=2E=
  This is when the gateway for</span><br><span>  * a route is specified as =
an interface rather than an address=2E */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(_WIN32) || defined=
(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(ROUTE_NET_API) || defined(_WIN32) || defined(TARGET_DARWIN)</span><=
br><span> static inline bool</span><br><span> is_on_link(const struct route=
_ipv4 *r, const unsigned int flags,</span><br><span>            const struc=
t route_gateway_info *rgi)</span><br><span>@@ -1455,7 +1467,7 @@</span><br>=
<span>     struct argv argv =3D argv_new();</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)</span><br><span>     =
const char *network =3D print_in_addr_t(r-&gt;network, 0, &amp;gc);</span><=
br><span> #if !defined(TARGET_AIX)</span><br><span>     const char *netmask=
 =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span>@@ -1464,7=
 +1476,7 @@</span><br><span> #endif</span><br><span> </span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_N=
ET_API)</span><br><span>     const char *iface =3D NULL;</span><br><span>  =
   int metric =3D -1;</span><br><span> </span><br><span>@@ -1478,18 +1490,2=
6 @@</span><br><span>         metric =3D r-&gt;metric;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const int netbits =3D netmask_to_netbits2(r-&gt;netmask);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (netbits &lt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: cannot a=
dd route with non-contiguous netmask %s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            print_in_addr_t(r-&gt;netmask, 0, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sta=
tus =3D RTA_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> </span><br><span>     status =3D RTA_SUCCESS;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D net_route_v4_a=
dd(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;=
gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                  iface, r-&gt;table_id, metric);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int ret =3D net_route_v4_add(ctx, &amp;r-=
&gt;network, netbits, &amp;r-&gt;gateway, iface,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                               ROUTE_TABLE_ID(=
r-&gt;table_id), metric);</span><br><span>     if (ret =3D=3D -EEXIST)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(D_ROUTE, &quot;NOTE: Linux route add command failed because route =
exists&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(D_ROUTE, &quot;NOTE: route add command failed because route exists&q=
uot;);</span><br><span>         status =3D RTA_EEXIST;</span><br><span>    =
 }</span><br><span>     else if (ret &lt; 0)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERR=
OR: Linux route add command failed&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route add command f=
ailed&quot;);</span><br><span>         status =3D RTA_ERROR;</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -1593,44 +1613,6 @@</span><br=
><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR=
: Solaris route add command failed&quot;);</span><br><span>     status =3D =
ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-rtt %d&quo=
t;, r-&gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot=
;, network, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME=
 -- add on-link support for FreeBSD */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR=
: FreeBSD route add command failed&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-rtt %d&quo=
t;, r-&gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot=
;, network, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME=
 -- add on-link support for Dragonfly */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERR=
OR: DragonFly route add command failed&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif de=
fined(TARGET_DARWIN)</span><br><span> </span><br><span>     argv_printf(&am=
p;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br><span>@@ -1696,11 +1678,=
12 @@</span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es,=
 0, &quot;ERROR: Haiku inet route add command failed&quot;);</span><br><spa=
n>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LI=
NUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if=
 defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span><br><spa=
n>         &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; comm=
ands on this operating system=2E  Try putting your routes in a --route-up s=
cript&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span>     i=
f (status =3D=3D RTA_SUCCESS)</span><br><span>     {</span><br><span>      =
   r-&gt;flags |=3D RT_ADDED;</span><br><span>@@ -1773,8 +1756,7 @@</span><=
br><span>     const char *network =3D print_in6_addr(r6-&gt;network, 0, &am=
p;gc);</span><br><span>     const char *gateway =3D print_in6_addr(r6-&gt;g=
ateway, 0, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || d=
efined(TARGET_DRAGONFLY) \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_DARWIN) || def=
ined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br>=
<span>     /* the BSD platforms cannot specify gateway and interface indepe=
ndently,</span><br><span>      * but for link-local destinations, we MUST s=
pecify the interface, so</span><br><span>@@ -1826,7 +1808,7 @@</span><br><s=
pan>         goto done;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)=
</span><br><span>     int metric =3D -1;</span><br><span>     if ((r6-&gt;f=
lags &amp; RT_METRIC_DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br>=
<span>     {</span><br><span>@@ -1835,15 +1817,15 @@</span><br><span> </spa=
n><br><span>     status =3D RTA_SUCCESS;</span><br><span>     int ret =3D n=
et_route_v6_add(ctx, &amp;r6-&gt;network, r6-&gt;netbits, gateway_needed ? =
&amp;r6-&gt;gateway : NULL,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                               device, r6-&gt;table_id, metric);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
       device, ROUTE_TABLE_ID(r6-&gt;table_id), metric);</span><br><span>  =
   if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(D_ROUTE, &quot;NOTE: Linux route ad=
d command failed because route exists&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;NOTE: route add comman=
d failed because route exists&quot;);</span><br><span>         status =3D R=
TA_EEXIST;</span><br><span>     }</span><br><span>     else if (ret &lt; 0)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_WARN, &quot;ERROR: Linux route add command failed&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &=
quot;ERROR: route add command failed&quot;);</span><br><span>         statu=
s =3D RTA_ERROR;</span><br><span>     }</span><br><span> </span><br><span>@=
@ -1889,23 +1871,6 @@</span><br><span>     bool ret =3D openvpn_execve_chec=
k(&amp;argv, es, 0, &quot;ERROR: Solaris route add -inet6 command failed&qu=
ot;);</span><br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defi=
ned(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    argv_printf(&amp;argv, &quot;%s add -inet6 %s/%d&quot;, ROUTE_PAT=
H, network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (gatewa=
y_needed)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp=
;argv, &quot;%s&quot;, gateway);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv,=
 &quot;-iface %s&quot;, device);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp=
;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =
=3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: *BSD route add -ine=
t6 command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_DARWIN)<=
/span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s add =
-inet6 %s -prefixlen %d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span>=
<br><span>@@ -1956,10 +1921,10 @@</span><br><span>     bool ret =3D openvpn=
_execve_check(&amp;argv, es, 0, &quot;ERROR: Haiku inet6 route add command =
failed&quot;);</span><br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERRO=
R;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
else  /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else  /* if defined(ROUTE_NET_API) */</span><br><span>   =
  msg(M_FATAL,</span><br><span>         &quot;Sorry, but I don&#39;t know h=
ow to do &#39;route ipv6&#39; commands on this operating system=2E  Try put=
ting your routes in a --route-up script&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(ROUTE_NET_=
API) */</span><br><span> </span><br><span> done:</span><br><span>     if (s=
tatus =3D=3D RTA_SUCCESS)</span><br><span>@@ -1982,13 +1947,13 @@</span><br=
><span> delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigne=
d int flags,</span><br><span>              const struct route_gateway_info =
*rgi, const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LI=
NUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(RO=
UTE_NET_API)</span><br><span>     const char *network;</span><br><span> #if=
 !defined(TARGET_AIX)</span><br><span>     const char *netmask;</span><br><=
span> #endif</span><br><span>     const char *gateway;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else /* if !defined(TARGET_LINUX) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* if !defined(ROU=
TE_NET_API) */</span><br><span>     int metric;</span><br><span> #endif</sp=
an><br><span> </span><br><span>@@ -2000,7 +1965,7 @@</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span>     struct argv argv =3D a=
rgv_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if !defined(ROUTE_NET_API)</span><br><span>     network =3D =
print_in_addr_t(r-&gt;network, 0, &amp;gc);</span><br><span> #if !defined(T=
ARGET_AIX)</span><br><span>     netmask =3D print_in_addr_t(r-&gt;netmask, =
0, &amp;gc);</span><br><span>@@ -2009,7 +1974,7 @@</span><br><span> #endif<=
/span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</span><br><span>     metric =
=3D -1;</span><br><span>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span=
><br><span>     {</span><br><span>@@ -2017,10 +1982,10 @@</span><br><span> =
    }</span><br><span> </span><br><span>     if (net_route_v4_del(ctx, &amp=
;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway, NUL=
L,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
      r-&gt;table_id, metric)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                         ROUTE_TABLE_ID(r-&gt;table_id), metric)<=
/span><br><span>         &lt; 0)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: Linux ro=
ute delete command failed&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;ERROR: route delete command failed&=
quot;);</span><br><span>     }</span><br><span> #elif defined(_WIN32)</span=
><br><span> </span><br><span>@@ -2070,20 +2035,6 @@</span><br><span>     ar=
gv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;=
argv, es, 0, &quot;ERROR: Solaris route delete command failed&quot;);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif def=
ined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;a=
rgv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, net=
mask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check=
(&amp;argv, es, 0, &quot;ERROR: FreeBSD route delete command failed&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -net %s %s=
 %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR:=
 DragonFly route delete command failed&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_DARWIN)</sp=
an><br><span> </span><br><span>     if (is_on_link(r, flags, rgi))</span><b=
r><span>@@ -2131,10 +2082,10 @@</span><br><span>     argv_msg(D_ROUTE, &amp=
;argv);</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;E=
RROR: Haiku inet route delete command failed&quot;);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGE=
T_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /=
* if defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span><br>=
<span>         &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; =
commands on this operating system=2E  Try putting your routes in a --route-=
up script&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </spa=
n><br><span>     r-&gt;flags &amp;=3D ~RT_ADDED;</span><br><span>     argv_=
free(&amp;argv);</span><br><span>@@ -2155,7 +2106,7 @@</span><br><span>    =
 }</span><br><span> </span><br><span> #if !defined(_WIN32)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)</sp=
an><br><span>     const char *gateway;</span><br><span> #endif</span><br><s=
pan> #if !defined(TARGET_SOLARIS)</span><br><span>@@ -2182,12 +2133,11 @@</=
span><br><span>     struct argv argv =3D argv_new();</span><br><span> </spa=
n><br><span>     network =3D print_in6_addr(r6-&gt;network, 0, &amp;gc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINU=
X) &amp;&amp; !defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if !defined(ROUTE_NET_API) &amp;&amp; !defined(_WIN32)</span><b=
r><span>     gateway =3D print_in6_addr(r6-&gt;gateway, 0, &amp;gc);</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || defi=
ned(TARGET_DRAGONFLY) \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_DARWIN) || define=
d(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><sp=
an>     /* the BSD platforms cannot specify gateway and interface independe=
ntly,</span><br><span>      * but for link-local destinations, we MUST spec=
ify the interface, so</span><br><span>@@ -2205,7 +2155,7 @@</span><br><span=
> </span><br><span>     msg(D_ROUTE, &quot;delete_route_ipv6(%s/%u)&quot;, =
network, r6-&gt;netbits);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</span><br><span>    =
 int metric =3D -1;</span><br><span>     if ((r6-&gt;flags &amp; RT_METRIC_=
DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br><span>     {</span><b=
r><span>@@ -2213,10 +2163,10 @@</span><br><span>     }</span><br><span> </s=
pan><br><span>     if (net_route_v6_del(ctx, &amp;r6-&gt;network, r6-&gt;ne=
tbits, gateway_needed ? &amp;r6-&gt;gateway : NULL,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         device, r6-&gt;tab=
le_id, metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                    device, ROUTE_TABLE_ID(r6-&gt;table_id), metric)</span>=
<br><span>         &lt; 0)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: Linux route v6=
 delete command failed&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(M_WARN, &quot;ERROR: route v6 delete command failed&=
quot;);</span><br><span>     }</span><br><span> </span><br><span> #elif def=
ined(_WIN32)</span><br><span>@@ -2238,22 +2188,6 @@</span><br><span>     ar=
gv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;=
argv, es, 0, &quot;ERROR: Solaris route delete -inet6 command failed&quot;)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -inet6 %s/%d&quot;=
, ROUTE_PATH, network, r6-&gt;netbits);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (gateway_needed)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_prin=
tf_cat(&amp;argv, &quot;%s&quot;, gateway);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat=
(&amp;argv, &quot;-iface %s&quot;, device);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_=
ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: *BSD route delete -ine=
t6 command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> #elif defined(TARGET_DARWIN)</span><br><span> </span>=
<br><span>     argv_printf(&amp;argv, &quot;%s delete -inet6 %s -prefixlen =
%d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span><br><span>@@ -2306,10=
 +2240,10 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><=
span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Haiku inet6 r=
oute delete command failed&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LINUX) */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(ROUT=
E_NET_API) */</span><br><span>     msg(M_FATAL,</span><br><span>         &q=
uot;Sorry, but I don&#39;t know how to do &#39;route ipv6&#39; commands on =
this operating system=2E  Try putting your routes in a --route-down script&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if d=
efined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </span><br><spa=
n>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2154?usp=3Demail">change 2154</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2154?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6=
885 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2154 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--ky+MtP4XrM0=--


--===============4124357876340974017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4124357876340974017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4124357876340974017==--


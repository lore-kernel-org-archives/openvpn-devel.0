Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C25606A32D
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lMXmuX+c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IwFAz5N0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i+lbCTZV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PrsyvFa2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=W2CJIjsEYfFvzQtRamW+ZV/9Ki1qVgc4KQeDJfqG+UM=; b=lMXmuX+caS8AouorFN0juDXkcn
	r7CQHjHa/t/n/G4jj3r9zRDCmCXB93TNF8ySNb9F7YjQ54chNX05zyYUu61+p/vLhq1qT4i9FL14o
	qj3HYxxDnhx4KaqFw+kUpYiBeVT6ySoRVKn997tO2L+ZYELMvFjYXzWVilAH/ZeDrQJA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPkju-000000002e9-1bjD;
	Sat, 07 Nov 2026 18:02:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPkjt-000000002e3-0MCF
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zAaxfAMAAcR5Om1or4P0vSwNg2jpFLVkzQ+FGDJmmu8=; b=IwFAz5N0wwKDwYfNVRN989RFgY
 qQsP9NQVsoGBeVpt8jNUx0hbwEziTMgEyCw60B/AZtOmByM8uKqeJ8L8otmmDGSTvbbO8t3adzK38
 cbwRQMiM6vae7y+9nZXnoIvf0ysmRK4oTXHj6BCGXpB11T+8L6XkleLAvZMQf+RBn87Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zAaxfAMAAcR5Om1or4P0vSwNg2jpFLVkzQ+FGDJmmu8=; b=i+lbCTZVTe+Mf5dgXea4O+PpLH
 M1v9jSeI8UtER26Iw+YkBf317TCXI5T5U+tSd09kuc1U9cwwgu/BlSImFtDrjy/MSNdOTrSNYGEwE
 RsP0Qm5GvZ2FhV+fnNZOg/wtmZFv6DBq+Qftx72vBcTMQTkceA/T6C7rkrIU/EiO2Hlo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPkjq-000000007k4-0Mc2 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:02:05 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso15748595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 10:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794074515; x=1794679315; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zAaxfAMAAcR5Om1or4P0vSwNg2jpFLVkzQ+FGDJmmu8=;
 b=PrsyvFa2jcoNQPbPd1eGLclgo5OkfDs403LQ3WJj0tbvUFzL5NWfUNU5aLK9CO2SGh
 VAZiI0CoXVx1h+d/x4fZqnETH5yJDYiONF39wAJx24A4bvkjEvZl+ESgO18x4taA26OJ
 A3QFDZW/F7ACRrdKPGBkXY3XDoauUNYXS2xe7B3u8QKNiGQgtBcUDPYtwL1N6c8mcie/
 WdggFTkgKYkI4ulDtf90yMuMCvusRpGglL4beKaMxUZ5vzNO2js9G0lJjlx2CfILbthz
 pIlH7u7YmAiqocjB9mlrPhu+Pt5CHMfRlvBeuKg7C33DknpjYmlsqijW9NCro9QL75GY
 x8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794074515; x=1794679315;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAaxfAMAAcR5Om1or4P0vSwNg2jpFLVkzQ+FGDJmmu8=;
 b=KTB1c3XwofE8cI5dGuLht0UYuCDAunWJTdCLORnjtFFweH/5ewQec9+qpYOksje8wR
 lYEPDRjAhx3QRy7KSY4m4FQP5ZThmg9CF/gWNi6X/Ly1WGVL6C4TCI+7g94sLq4W9R5l
 rj7Xr9y7/qi3I28DUVvP2sKuPK5xYqpRE36yJ2SA/fnEFBgkM6o2pG3gf3z0kH1GBn0o
 BWAtVHlb1hUM5H3WOB78TsvgSvotDkBBn8Eh5JEa28Z3HVLJUE7lK0mg8372feHdJIm1
 cuLPDXupB2FoW4GBsgozzbJVIcrEBY101fs+rVzuyaz4K3IzNBE/UL6DxtjpnEEBsMAG
 N5eg==
X-Gm-Message-State: APuU4Z8OXMCj/5Zp1PRkpibCIGMNsmlk9TZz/GwOrhSrABQK/0uFzwlx
 Rx67xErT1hQ1/vG7FUOHgIRTWbx3PVFamtnkLiFYOX1x0V6FdRilmNnGVw7+vBNFV4plnRgiWA7
 olBClVDIQlKqS+cIiMTZBagh5ima2nVDk5QDG6divoGU34mRbi5nljkW76XSXoO7ePpBtMhmlqV
 qWsUWEhg==
X-Gm-Gg: AYBFou1f3SO8IR5qW8WY9GnqF3q3F/vK7XBgSUj1SSzACDaV1IEiu+VaPece/A2RckS
 +J9ELJ0GKEmY/4i6D+cfLnfGDsSXc/1OKhmFxPCukLW6coxXCSCbw1+jnsRbTetSS7sjsq7f1PY
 DveqPcLmDvWWc/+dJ4RUAH7Z2PwO8a0upSGDPaGNDrF2nqW7xE3ROzCS+ZFvqdiAv4l5RUTVHSa
 6JYKMJHuMS5f6pTiCK9nXXFc0cOOQ4cqdxiW2/oUYP7r87D//3B8zVusqBMzasz9rGAwDunXqP4
 Onohw8zyt42XwGHxrlUBv/cTGaT+b4O9j88kjRR2WPJkFUN6eZnfQTDbvsoIcGQBBFbpQD+Nofe
 mjmPCpRXy99RgCkGtDCjyqSRPOCuEGAxcl5Em6xxvs5ts4jHUflVw4vvjBLAP58qA63nBnD2lJu
 xbaobGWqMQFZMgaUa7g9CwlXJKeIZ1xhLvsMdEJjKD0nkfAo1Jf5Kv5LNbKWwAZebr6Q3spVXOc
 5SBZY4YheqPbOpD2GQ2A4B2PkFJH2bCg4lvbz1CfPN3hRbFtFLuLSwkWx+w1aJu6r7myGX0HGb9
 vQXee/YNK/2n6fgX8DtavRJycni/4rCmjhX/SIzbxGE+dKrztoUQCqiLr0KBRQOGxpUyGdAMYZ2
 5o4SO+lU6DWIErVVhlwTaLxYKgk2PNQyX8K2Kwi9s/Ns0PXBZiPwAn5Yzj5RAim0y3Ynmu4e/Gf
 GJ16IUb7JlOYQVuw==
X-Received: by 2002:a05:600c:310f:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4b6de788952mr98720125e9.10.1794074515018; 
 Sat, 07 Nov 2026 10:01:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e327a6d8sm90948765e9.9.2026.11.07.10.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:01:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 18:01:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
X-Gerrit-Change-Number: 2154
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2154?usp=email>
X-Gerrit-Commit: 144258afad651dc473c9b5299378a3d16af079db
References: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkk2MDE0NTRhNTExYzlhYWM0ZjM3ZDg2MjliMTY5MjI2NmNkYmQ2ODg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <988cf9000dfeb7d0454bdc2995abb37db6653d39-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPkjq-000000007k4-0Mc2
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
Content-Type: multipart/mixed; boundary="===============2706686561541612450=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2706686561541612450==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D9cIULWV8vY="; charset=UTF-8

--D9cIULWV8vY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2154?usp=3Demail

to review the following change=2E
=


Change subject: route: use the net_ API for routes on FreeBSD and DragonF=
ly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: use=
 the net_ API for routes on FreeBSD and DragonFly

Add and delete IPv4 and =
IPv6 routes through net_route_v4/v6_add/del()
on FreeBSD and DragonFly, as =
on Linux, instead of running route(8)
from route=2Ec=2E Build networking_fr=
eebsd=2Ec for DragonFly as well; -fib
is only passed on FreeBSD=2E

--route=
-table stays Linux only=2E A non-contiguous IPv4 netmask now gets
an error =
instead of an invalid prefix length=2E networking_freebsd=2Ec
logs route co=
mmands at D_ROUTE, as route=2Ec did=2E The shared error
messages lose their=
 "Linux" prefix=2E

Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
Si=
gned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/netw=
orking=2Eh
M src/openvpn/networking_freebsd=2Ec
M src/openvpn/route=2Ec
3 f=
iles changed, 73 insertions(+), 128 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/2154/1

diff --git a/src/ope=
nvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 7ad6e2e=2E=2E4b30092=
 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@=
@ -30,7 +30,7 @@
 #include "networking_sitnl=2Eh"
 #elif ENABLE_IPROUTE
 #i=
nclude "networking_iproute2=2Eh"
-#elif defined(TARGET_FREEBSD)
+#elif defi=
ned(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 typedef void *openvpn_net=
_ctx_t;
 typedef char openvpn_net_iface_t;
 #else  /* ifdef ENABLE_SITNL */=

@@ -236,7 +236,8 @@
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
 
-#if =
defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD)=

+#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FR=
EEBSD) \
+    || defined(TARGET_DRAGONFLY)
 /**
  * Add a route for an IPv4=
 address/network
  *
@@ -309,7 +310,7 @@
                      const struct=
 in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
          =
            int metric);
 
-#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TAR=
GET_FREEBSD */
+#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD =
|| TARGET_DRAGONFLY */
 
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROU=
TE)
 
diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/network=
ing_freebsd=2Ec
index e3697d4=2E=2E0b2b225 100644
--- a/src/openvpn/network=
ing_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -6,7 +6,7 @@
 #=
include "run_command=2Eh"
 #include "networking=2Eh"
 
-#if defined(TARGET_=
FREEBSD)
+#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
 stati=
c int
 net_route_v4(const char *op, const in_addr_t *dst, int prefixlen, co=
nst in_addr_t *gw,
@@ -26,6 +26,7 @@
      */
     argv_printf(&argv, "%s %=
s -net %s/%d", ROUTE_PATH, op,
                 inet_ntop(AF_INET, &_dst, b=
uf1, sizeof(buf1)), prefixlen);
+    /* FIXME -- add on-link support: iface=
 is ignored when gw is set */
     if (gw)
     {
         _gw =3D ntohl(*g=
w);
@@ -35,14 +36,22 @@
     {
         argv_printf_cat(&argv, "-iface %s",=
 iface);
     }
+#if 0
+    if (metric >=3D 0)
+    {
+        argv_printf_=
cat(&argv, "-rtt %d", metric);
+    }
+#endif
+#if defined(TARGET_FREEBSD)
=
     /* without -fib, route(8) uses the FIB of the process */
     if (tabl=
e)
     {
         argv_printf_cat(&argv, "-fib %u", table);
     }
+#endif=

 
-    argv_msg(M_INFO, &argv);
-    bool status =3D openvpn_execve_check(=
&argv, NULL, 0, "ERROR: FreeBSD route command failed");
+    argv_msg(D_ROU=
TE, &argv);
+    bool status =3D openvpn_execve_check(&argv, NULL, 0, "ERRO=
R: route command failed");
 
     argv_free(&argv);
 
@@ -77,13 +86,15 @@
 =
    {
         argv_printf_cat(&argv, "-iface %s", iface);
     }
+#if defi=
ned(TARGET_FREEBSD)
     if (table)
     {
         argv_printf_cat(&argv, =
"-fib %u", table);
     }
+#endif
 
-    argv_msg(M_INFO, &argv);
-    bool=
 status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route comm=
and failed");
+    argv_msg(D_ROUTE, &argv);
+    bool status =3D openvpn_e=
xecve_check(&argv, NULL, 0, "ERROR: route command failed");
 
     argv_fre=
e(&argv);
 
@@ -118,4 +129,4 @@
     return net_route_v6("delete", dst, pre=
fixlen, gw, iface, table, metric);
 }
 
-#endif /* if defined(TARGET_FREEBS=
D) */
+#endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) */=

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 53550c4=
=2E=2Eabf6152 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -103,6 +103,18 @@
 #define RTA_SUCCESS 1 /* route addition succeeded *=
/
 #define RTA_EEXIST  2 /* route not added as it already exists */
 
+/* P=
latforms that add and delete routes through the net_ API (networking=2Eh) *=
/
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_D=
RAGONFLY)
+#define ROUTE_NET_API
+#endif
+
+/* --route-table is supported o=
nly on Linux */
+#if defined(TARGET_LINUX)
+#define ROUTE_TABLE_ID(id) (id)=

+#else
+#define ROUTE_TABLE_ID(id) 0
+#endif
+
 #ifndef TARGET_ANDROID
 st=
atic bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)
@=
@ -1436,7 +1448,7 @@
 
 /* Return true if the "on-link" form of the route s=
hould be used=2E  This is when the gateway for
  * a route is specified as =
an interface rather than an address=2E */
-#if defined(TARGET_LINUX) || def=
ined(_WIN32) || defined(TARGET_DARWIN)
+#if defined(ROUTE_NET_API) || defin=
ed(_WIN32) || defined(TARGET_DARWIN)
 static inline bool
 is_on_link(const =
int is_local_route, const unsigned int flags, const struct route_gateway_in=
fo *rgi)
 {
@@ -1462,7 +1474,7 @@
     struct argv argv =3D argv_new();
   =
  struct gc_arena gc =3D gc_new();
 
-#if !defined(TARGET_LINUX)
+#if !defi=
ned(ROUTE_NET_API)
     const char *network =3D print_in_addr_t(r->network,=
 0, &gc);
 #if !defined(TARGET_AIX)
     const char *netmask =3D print_in_a=
ddr_t(r->netmask, 0, &gc);
@@ -1476,7 +1488,7 @@
         goto done;
     }=

 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     const char *=
iface =3D NULL;
     int metric =3D -1;
 
@@ -1490,18 +1502,26 @@
         =
metric =3D r->metric;
     }
 
+    const int netbits =3D netmask_to_netbit=
s2(r->netmask);
+    if (netbits < 0)
+    {
+        msg(M_WARN, "ERROR: c=
annot add route with non-contiguous netmask %s",
+            print_in_addr=
_t(r->netmask, 0, &gc));
+        status =3D RTA_ERROR;
+        goto done;=

+    }
 
     status =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_add(ct=
x, &r->network, netmask_to_netbits2(r->netmask), &r->gateway,
-            =
                   iface, r->table_id, metric);
+    int ret =3D net_route_=
v4_add(ctx, &r->network, netbits, &r->gateway, iface,
+                    =
           ROUTE_TABLE_ID(r->table_id), metric);
     if (ret =3D=3D -EEXIS=
T)
     {
-        msg(D_ROUTE, "NOTE: Linux route add command failed becau=
se route exists");
+        msg(D_ROUTE, "NOTE: route add command failed be=
cause route exists");
         status =3D RTA_EEXIST;
     }
     else if (=
ret < 0)
     {
-        msg(M_WARN, "ERROR: Linux route add command failed=
");
+        msg(M_WARN, "ERROR: route add command failed");
         statu=
s =3D RTA_ERROR;
     }
 
@@ -1605,44 +1625,6 @@
     bool ret =3D openvpn_=
execve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
    =
 status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBSD)=

-
-    argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flag=
s & RT_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r-=
>metric);
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", net=
work, gateway, netmask);
-
-    /* FIXME -- add on-link support for FreeBSD=
 */
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check=
(&argv, es, 0, "ERROR: FreeBSD route add command failed");
-    status =3D =
ret ? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_DRAGONFLY)
-
-    ar=
gv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT_MET=
RIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r->metric);
=
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network, gate=
way, netmask);
-
-    /* FIXME -- add on-link support for Dragonfly */
-
- =
   argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, =
es, 0, "ERROR: DragonFly route add command failed");
-    status =3D ret ? =
RTA_SUCCESS : RTA_ERROR;
-
 #elif defined(TARGET_DARWIN)
 
     argv_printf=
(&argv, "%s add", ROUTE_PATH);
@@ -1708,10 +1690,10 @@
     bool ret =3D op=
envpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route add command faile=
d");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#else  /* if defined=
(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,=

         "Sorry, but I don't know how to do 'route' commands on this opera=
ting system=2E  Try putting your routes in a --route-up script");
-#endif /=
* if defined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
 do=
ne:
     if (status =3D=3D RTA_SUCCESS)
@@ -1786,8 +1768,7 @@
     const ch=
ar *network =3D print_in6_addr(r6->network, 0, &gc);
     const char *gatew=
ay =3D print_in6_addr(r6->gateway, 0, &gc);
 
-#if defined(TARGET_DARWIN) |=
| defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \
-    || defined(TA=
RGET_OPENBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_DARWIN) || defi=
ned(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the BSD platforms c=
annot specify gateway and interface independently,
      * but for link-loc=
al destinations, we MUST specify the interface, so
@@ -1839,7 +1820,7 @@
  =
       goto done;
     }
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NE=
T_API)
     int metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && =
(r6->metric > 0))
     {
@@ -1848,15 +1829,15 @@
 
     status =3D RTA_SUCC=
ESS;
     int ret =3D net_route_v6_add(ctx, &r6->network, r6->netbits, gate=
way_needed ? &r6->gateway : NULL,
-                               device, r=
6->table_id, metric);
+                               device, ROUTE_TABLE_I=
D(r6->table_id), metric);
     if (ret =3D=3D -EEXIST)
     {
-        msg(=
D_ROUTE, "NOTE: Linux route add command failed because route exists");
+   =
     msg(D_ROUTE, "NOTE: route add command failed because route exists");
 =
        status =3D RTA_EEXIST;
     }
     else if (ret < 0)
     {
-      =
  msg(M_WARN, "ERROR: Linux route add command failed");
+        msg(M_WARN=
, "ERROR: route add command failed");
         status =3D RTA_ERROR;
     }=

 
@@ -1902,23 +1883,6 @@
     bool ret =3D openvpn_execve_check(&argv, es,=
 0, "ERROR: Solaris route add -inet6 command failed");
     status =3D ret =
? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBSD) || defined(TARG=
ET_DRAGONFLY)
-
-    argv_printf(&argv, "%s add -inet6 %s/%d", ROUTE_PATH, =
network, r6->netbits);
-
-    if (gateway_needed)
-    {
-        argv_prin=
tf_cat(&argv, "%s", gateway);
-    }
-    else
-    {
-        argv_printf_=
cat(&argv, "-iface %s", device);
-    }
-
-    argv_msg(D_ROUTE, &argv);
- =
   bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route add -=
inet6 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-
 #=
elif defined(TARGET_DARWIN)
 
     argv_printf(&argv, "%s add -inet6 %s -pr=
efixlen %d", ROUTE_PATH, network, r6->netbits);
@@ -1969,10 +1933,10 @@
   =
  bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 route=
 add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#e=
lse  /* if defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) */=

     msg(M_FATAL,
         "Sorry, but I don't know how to do 'route ipv6'=
 commands on this operating system=2E  Try putting your routes in a --route=
-up script");
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(=
ROUTE_NET_API) */
 
 done:
     if (status =3D=3D RTA_SUCCESS)
@@ -1995,13 =
+1959,13 @@
 delete_route(struct route_ipv4 *r, const struct tuntap *tt, un=
signed int flags,
              const struct route_gateway_info *rgi, const=
 struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-#if !defined(TARGET_LINUX)=

+#if !defined(ROUTE_NET_API)
     const char *network;
 #if !defined(TARGE=
T_AIX)
     const char *netmask;
 #endif
     const char *gateway;
-#else /=
* if !defined(TARGET_LINUX) */
+#else /* if !defined(ROUTE_NET_API) */
    =
 int metric;
 #endif
     int is_local_route;
@@ -2014,7 +1978,7 @@
     st=
ruct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();
 
-#if=
 !defined(TARGET_LINUX)
+#if !defined(ROUTE_NET_API)
     network =3D print=
_in_addr_t(r->network, 0, &gc);
 #if !defined(TARGET_AIX)
     netmask =3D =
print_in_addr_t(r->netmask, 0, &gc);
@@ -2028,7 +1992,7 @@
         goto do=
ne;
     }
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     me=
tric =3D -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
@@ -2036,10 +200=
0,10 @@
     }
 
     if (net_route_v4_del(ctx, &r->network, netmask_to_net=
bits2(r->netmask), &r->gateway, NULL,
-                         r->table_id=
, metric)
+                         ROUTE_TABLE_ID(r->table_id), metric)
  =
       < 0)
     {
-        msg(M_WARN, "ERROR: Linux route delete command =
failed");
+        msg(M_WARN, "ERROR: route delete command failed");
     =
}
 #elif defined(_WIN32)
 
@@ -2089,20 +2053,6 @@
     argv_msg(D_ROUTE, &a=
rgv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete =
command failed");
 
-#elif defined(TARGET_FREEBSD)
-
-    argv_printf(&argv=
, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
-
-   =
 argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: =
FreeBSD route delete command failed");
-
-#elif defined(TARGET_DRAGONFLY)
-=

-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, ga=
teway, netmask);
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check=
(&argv, es, 0, "ERROR: DragonFly route delete command failed");
-
 #elif de=
fined(TARGET_DARWIN)
 
     if (is_on_link(is_local_route, flags, rgi))
@@ =
-2150,10 +2100,10 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_che=
ck(&argv, es, 0, "ERROR: Haiku inet route delete command failed");
 
-#else=
  /* if defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) */
  =
   msg(M_FATAL,
         "Sorry, but I don't know how to do 'route' command=
s on this operating system=2E  Try putting your routes in a --route-up scri=
pt");
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NE=
T_API) */
 
 done:
     r->flags &=3D ~RT_ADDED;
@@ -2175,7 +2125,7 @@
    =
 }
 
 #if !defined(_WIN32)
-#if !defined(TARGET_LINUX)
+#if !defined(ROUTE_=
NET_API)
     const char *gateway;
 #endif
 #if !defined(TARGET_SOLARIS)
@@=
 -2202,12 +2152,11 @@
     struct argv argv =3D argv_new();
 
     network =
=3D print_in6_addr(r6->network, 0, &gc);
-#if !defined(TARGET_LINUX) && !de=
fined(_WIN32)
+#if !defined(ROUTE_NET_API) && !defined(_WIN32)
     gateway=
 =3D print_in6_addr(r6->gateway, 0, &gc);
 #endif
 
-#if defined(TARGET_DAR=
WIN) || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \
-    || defi=
ned(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_DARWIN) |=
| defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the BSD platf=
orms cannot specify gateway and interface independently,
      * but for li=
nk-local destinations, we MUST specify the interface, so
@@ -2225,7 +2174,7=
 @@
 
     msg(D_ROUTE, "delete_route_ipv6(%s/%u)", network, r6->netbits);
=
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     int metric =
=3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     =
{
@@ -2233,10 +2182,10 @@
     }
 
     if (net_route_v6_del(ctx, &r6->netw=
ork, r6->netbits, gateway_needed ? &r6->gateway : NULL,
-                  =
       device, r6->table_id, metric)
+                         device, ROUT=
E_TABLE_ID(r6->table_id), metric)
         < 0)
     {
-        msg(M_WARN,=
 "ERROR: Linux route v6 delete command failed");
+        msg(M_WARN, "ERRO=
R: route v6 delete command failed");
     }
 
 #elif defined(_WIN32)
@@ -22=
58,22 +2207,6 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&=
argv, es, 0, "ERROR: Solaris route delete -inet6 command failed");
 
-#elif=
 defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
-
-    argv_printf(&a=
rgv, "%s delete -inet6 %s/%d", ROUTE_PATH, network, r6->netbits);
-
-    if=
 (gateway_needed)
-    {
-        argv_printf_cat(&argv, "%s", gateway);
- =
   }
-    else
-    {
-        argv_printf_cat(&argv, "-iface %s", device);=

-    }
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, e=
s, 0, "ERROR: *BSD route delete -inet6 command failed");
-
 #elif defined(T=
ARGET_DARWIN)
 
     argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d"=
, ROUTE_PATH, network, r6->netbits);
@@ -2326,10 +2259,10 @@
     argv_msg(=
D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet=
6 route delete command failed");
 
-#else  /* if defined(TARGET_LINUX) */
+=
#else  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,
         "Sorry, b=
ut I don't know how to do 'route ipv6' commands on this operating system=2E=
  Try putting your routes in a --route-down script");
-#endif /* if defined=
(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
     argv_free(=
&argv);
     gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2154?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
Gerrit-Change-Number: 2=
154
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--D9cIULWV8vY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: use the net_ API for routes on FreeBSD and Drago=
nFly<br><br>Add and delete IPv4 and IPv6 routes through net_route_v4/v6_add=
/del()<br>on FreeBSD and DragonFly, as on Linux, instead of running route(8=
)<br>from route=2Ec=2E Build networking_freebsd=2Ec for DragonFly as well; =
-fib<br>is only passed on FreeBSD=2E<br><br>--route-table stays Linux only=
=2E A non-contiguous IPv4 netmask now gets<br>an error instead of an invali=
d prefix length=2E networking_freebsd=2Ec<br>logs route commands at D_ROUTE=
, as route=2Ec did=2E The shared error<br>messages lose their &quot;Linux&q=
uot; prefix=2E<br><br>Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885<=
br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M=
 src/openvpn/networking=2Eh<br>M src/openvpn/networking_freebsd=2Ec<br>M sr=
c/openvpn/route=2Ec<br>3 files changed, 73 insertions(+), 128 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/54/2154/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/networking=2Eh =
b/src/openvpn/networking=2Eh</span><br><span>index 7ad6e2e=2E=2E4b30092 100=
644</span><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/=
src/openvpn/networking=2Eh</span><br><span>@@ -30,7 +30,7 @@</span><br><spa=
n> #include &quot;networking_sitnl=2Eh&quot;</span><br><span> #elif ENABLE_=
IPROUTE</span><br><span> #include &quot;networking_iproute2=2Eh&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBS=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TAR=
GET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span> typedef void *op=
envpn_net_ctx_t;</span><br><span> typedef char openvpn_net_iface_t;</span><=
br><span> #else  /* ifdef ENABLE_SITNL */</span><br><span>@@ -236,7 +236,8 =
@@</span><br><span> </span><br><span> #endif /* ENABLE_SITNL || ENABLE_IPRO=
UTE */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_F=
REEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD) \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    || defined(TARGET_DRA=
GONFLY)</span><br><span> /**</span><br><span>  * Add a route for an IPv4 ad=
dress/network</span><br><span>  *</span><br><span>@@ -309,7 +310,7 @@</span=
><br><span>                      const struct in6_addr *gw, const openvpn_n=
et_iface_t *iface, uint32_t table,</span><br><span>                      in=
t metric);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_SITNL || =
ENABLE_IPROUTE || TARGET_FREEBSD || TARGET_DRAGONFLY */</span><br><span> </=
span><br><span> #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/networking_freebsd=2Ec=
 b/src/openvpn/networking_freebsd=2Ec</span><br><span>index e3697d4=2E=2E0b=
2b225 100644</span><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span=
><br><span>+++ b/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -6,7=
 +6,7 @@</span><br><span> #include &quot;run_command=2Eh&quot;</span><br><s=
pan> #include &quot;networking=2Eh&quot;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_FREEBSD)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD) ||=
 defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span> static int</s=
pan><br><span> net_route_v4(const char *op, const in_addr_t *dst, int prefi=
xlen, const in_addr_t *gw,</span><br><span>@@ -26,6 +26,7 @@</span><br><spa=
n>      */</span><br><span>     argv_printf(&amp;argv, &quot;%s %s -net %s/=
%d&quot;, ROUTE_PATH, op,</span><br><span>                 inet_ntop(AF_INE=
T, &amp;_dst, buf1, sizeof(buf1)), prefixlen);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* FIXME -- add on-link support: iface is ig=
nored when gw is set */</span><br><span>     if (gw)</span><br><span>     {=
</span><br><span>         _gw =3D ntohl(*gw);</span><br><span>@@ -35,14 +36=
,22 @@</span><br><span>     {</span><br><span>         argv_printf_cat(&amp=
;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if 0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (metric &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;,=
 metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD)</span><br=
><span>     /* without -fib, route(8) uses the FIB of the process */</span>=
<br><span>     if (table)</span><br><span>     {</span><br><span>         a=
rgv_printf_cat(&amp;argv, &quot;-fib %u&quot;, table);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M=
_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 bool status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: Free=
BSD route command failed&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool status =3D openvpn_execve_check(&amp;ar=
gv, NULL, 0, &quot;ERROR: route command failed&quot;);</span><br><span> </s=
pan><br><span>     argv_free(&amp;argv);</span><br><span> </span><br><span>=
@@ -77,13 +86,15 @@</span><br><span>     {</span><br><span>         argv_pr=
intf_cat(&amp;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FR=
EEBSD)</span><br><span>     if (table)</span><br><span>     {</span><br><sp=
an>         argv_printf_cat(&amp;argv, &quot;-fib %u&quot;, table);</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bool status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quo=
t;ERROR: FreeBSD route command failed&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool status =3D openvpn_execve_=
check(&amp;argv, NULL, 0, &quot;ERROR: route command failed&quot;);</span><=
br><span> </span><br><span>     argv_free(&amp;argv);</span><br><span> </sp=
an><br><span>@@ -118,4 +129,4 @@</span><br><span>     return net_route_v6(&=
quot;delete&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* if defined(TARGET_FREEBSD) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* if defined(TARGET_FREEBSD) || defined(TARGE=
T_DRAGONFLY) */</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/op=
envpn/route=2Ec</span><br><span>index 53550c4=2E=2Eabf6152 100644</span><br=
><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -103,6 +103,18 @@</span><br><span> #define RTA_SUCC=
ESS 1 /* route addition succeeded */</span><br><span> #define RTA_EEXIST  2=
 /* route not added as it already exists */</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Platforms that add and delete =
routes through the net_ API (networking=2Eh) */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FRE=
EBSD) || defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define ROUTE_NET_API</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* --route-tabl=
e is supported only on Linux */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define ROUTE_TABLE_ID(id) (id)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define ROUTE_TABLE_ID(id) 0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #ifndef TARGET_ANDROID</span><br><span> stati=
c bool</span><br><span> add_bypass_address(struct route_bypass *rb, const i=
n_addr_t a)</span><br><span>@@ -1436,7 +1448,7 @@</span><br><span> </span><=
br><span> /* Return true if the &quot;on-link&quot; form of the route shoul=
d be used=2E  This is when the gateway for</span><br><span>  * a route is s=
pecified as an interface rather than an address=2E */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(_WIN32=
) || defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(ROUTE_NET_API) || defined(_WIN32) || defined(TARGET_DAR=
WIN)</span><br><span> static inline bool</span><br><span> is_on_link(const =
int is_local_route, const unsigned int flags, const struct route_gateway_in=
fo *rgi)</span><br><span> {</span><br><span>@@ -1462,7 +1474,7 @@</span><br=
><span>     struct argv argv =3D argv_new();</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)</span><br><span>    =
 const char *network =3D print_in_addr_t(r-&gt;network, 0, &amp;gc);</span>=
<br><span> #if !defined(TARGET_AIX)</span><br><span>     const char *netmas=
k =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span>@@ -1476,=
7 +1488,7 @@</span><br><span>         goto done;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(ROUTE_NET_API)</span><br><span>     const char *iface =3D NULL;<=
/span><br><span>     int metric =3D -1;</span><br><span> </span><br><span>@=
@ -1490,18 +1502,26 @@</span><br><span>         metric =3D r-&gt;metric;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const int netbits =3D netmask_to_netbits2(r-&gt;netm=
ask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netbit=
s &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quo=
t;ERROR: cannot add route with non-contiguous netmask %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            print_in_addr_t(r-&=
gt;netmask, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        status =3D RTA_ERROR;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span> </span><br><span>     status =3D RTA_=
SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =
=3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;net=
mask), &amp;r-&gt;gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                               iface, r-&gt;table_id, metric);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D net_route_v=
4_add(ctx, &amp;r-&gt;network, netbits, &amp;r-&gt;gateway, iface,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
   ROUTE_TABLE_ID(r-&gt;table_id), metric);</span><br><span>     if (ret =
=3D=3D -EEXIST)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_ROUTE, &quot;NOTE: Linux route add command f=
ailed because route exists&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_ROUTE, &quot;NOTE: route add command failed be=
cause route exists&quot;);</span><br><span>         status =3D RTA_EEXIST;<=
/span><br><span>     }</span><br><span>     else if (ret &lt; 0)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_WARN, &quot;ERROR: Linux route add command failed&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR:=
 route add command failed&quot;);</span><br><span>         status =3D RTA_E=
RROR;</span><br><span>     }</span><br><span> </span><br><span>@@ -1605,44 =
+1625,6 @@</span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv=
, es, 0, &quot;ERROR: Solaris route add command failed&quot;);</span><br><s=
pan>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&q=
uot;, ROUTE_PATH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFI=
NED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv=
, &quot;-rtt %d&quot;, r-&gt;metric);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot=
;-net %s %s %s&quot;, network, gateway, netmask);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* FIXME -- add on-link support for FreeBSD */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv,=
 es, 0, &quot;ERROR: FreeBSD route add command failed&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : =
RTA_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quo=
t;, ROUTE_PATH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINE=
D)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, =
&quot;-rtt %d&quot;, r-&gt;metric);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-=
net %s %s %s&quot;, network, gateway, netmask);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* FIXME -- add on-link support for Dragonfly */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv,=
 es, 0, &quot;ERROR: DragonFly route add command failed&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS =
: RTA_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><span>   =
  argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br><span>@=
@ -1708,10 +1690,10 @@</span><br><span>     bool ret =3D openvpn_execve_che=
ck(&amp;argv, es, 0, &quot;ERROR: Haiku inet route add command failed&quot;=
);</span><br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if =
defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else  /* if defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATA=
L,</span><br><span>         &quot;Sorry, but I don&#39;t know how to do &#3=
9;route&#39; commands on this operating system=2E  Try putting your routes =
in a --route-up script&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif /* if defined(TARGET_LINUX) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br=
><span> </span><br><span> done:</span><br><span>     if (status =3D=3D RTA_=
SUCCESS)</span><br><span>@@ -1786,8 +1768,7 @@</span><br><span>     const c=
har *network =3D print_in6_addr(r6-&gt;network, 0, &amp;gc);</span><br><spa=
n>     const char *gateway =3D print_in6_addr(r6-&gt;gateway, 0, &amp;gc);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONF=
LY) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    || defined(T=
ARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(TARGET_DARWIN) || defined(TARGET_OPENBSD) =
|| defined(TARGET_NETBSD)</span><br><span> </span><br><span>     /* the BSD=
 platforms cannot specify gateway and interface independently,</span><br><s=
pan>      * but for link-local destinations, we MUST specify the interface,=
 so</span><br><span>@@ -1839,7 +1820,7 @@</span><br><span>         goto don=
e;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</span><br><span>    =
 int metric =3D -1;</span><br><span>     if ((r6-&gt;flags &amp; RT_METRIC_=
DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br><span>     {</span><b=
r><span>@@ -1848,15 +1829,15 @@</span><br><span> </span><br><span>     stat=
us =3D RTA_SUCCESS;</span><br><span>     int ret =3D net_route_v6_add(ctx, =
&amp;r6-&gt;network, r6-&gt;netbits, gateway_needed ? &amp;r6-&gt;gateway :=
 NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                device, r6-&gt;table_id, metric);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                               device, ROUTE_=
TABLE_ID(r6-&gt;table_id), metric);</span><br><span>     if (ret =3D=3D -EE=
XIST)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(D_ROUTE, &quot;NOTE: Linux route add command failed beca=
use route exists&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(D_ROUTE, &quot;NOTE: route add command failed because rout=
e exists&quot;);</span><br><span>         status =3D RTA_EEXIST;</span><br>=
<span>     }</span><br><span>     else if (ret &lt; 0)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN,=
 &quot;ERROR: Linux route add command failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route ad=
d command failed&quot;);</span><br><span>         status =3D RTA_ERROR;</sp=
an><br><span>     }</span><br><span> </span><br><span>@@ -1902,23 +1883,6 @=
@</span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, =
&quot;ERROR: Solaris route add -inet6 command failed&quot;);</span><br><spa=
n>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD) =
|| defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_print=
f(&amp;argv, &quot;%s add -inet6 %s/%d&quot;, ROUTE_PATH, network, r6-&gt;n=
etbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (gateway_needed)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;%s&quot=
;, gateway);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-iface %s&quo=
t;, device);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_ch=
eck(&amp;argv, es, 0, &quot;ERROR: *BSD route add -inet6 command failed&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D re=
t ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> #elif defined(TARGET_DARWIN)</span><br><span> </sp=
an><br><span>     argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen =
%d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span><br><span>@@ -1969,10=
 +1933,10 @@</span><br><span>     bool ret =3D openvpn_execve_check(&amp;ar=
gv, es, 0, &quot;ERROR: Haiku inet6 route add command failed&quot;);</span>=
<br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(T=
ARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#els=
e  /* if defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span>=
<br><span>         &quot;Sorry, but I don&#39;t know how to do &#39;route i=
pv6&#39; commands on this operating system=2E  Try putting your routes in a=
 --route-up script&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br><sp=
an> </span><br><span> done:</span><br><span>     if (status =3D=3D RTA_SUCC=
ESS)</span><br><span>@@ -1995,13 +1959,13 @@</span><br><span> delete_route(=
struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</span><b=
r><span>              const struct route_gateway_info *rgi, const struct en=
v_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)</span><b=
r><span>     const char *network;</span><br><span> #if !defined(TARGET_AIX)=
</span><br><span>     const char *netmask;</span><br><span> #endif</span><b=
r><span>     const char *gateway;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#else /* if !defined(TARGET_LINUX) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else /* if !defined(ROUTE_NET_API) */</span>=
<br><span>     int metric;</span><br><span> #endif</span><br><span>     int=
 is_local_route;</span><br><span>@@ -2014,7 +1978,7 @@</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>     struct argv argv =3D=
 argv_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if !defined(ROUTE_NET_API)</span><br><span>     network =
=3D print_in_addr_t(r-&gt;network, 0, &amp;gc);</span><br><span> #if !defin=
ed(TARGET_AIX)</span><br><span>     netmask =3D print_in_addr_t(r-&gt;netma=
sk, 0, &amp;gc);</span><br><span>@@ -2028,7 +1992,7 @@</span><br><span>    =
     goto done;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</span><=
br><span>     metric =3D -1;</span><br><span>     if (r-&gt;flags &amp; RT_=
METRIC_DEFINED)</span><br><span>     {</span><br><span>@@ -2036,10 +2000,10=
 @@</span><br><span>     }</span><br><span> </span><br><span>     if (net_r=
oute_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &a=
mp;r-&gt;gateway, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                         r-&gt;table_id, metric)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                         ROUTE_TABLE_ID(r-&g=
t;table_id), metric)</span><br><span>         &lt; 0)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, =
&quot;ERROR: Linux route delete command failed&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route d=
elete command failed&quot;);</span><br><span>     }</span><br><span> #elif =
defined(_WIN32)</span><br><span> </span><br><span>@@ -2089,20 +2053,6 @@</s=
pan><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openv=
pn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solaris route delete command=
 failed&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   argv_printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, =
network, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_=
ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route delete c=
ommand failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_=
DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot=
;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv=
, es, 0, &quot;ERROR: DragonFly route delete command failed&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defin=
ed(TARGET_DARWIN)</span><br><span> </span><br><span>     if (is_on_link(is_=
local_route, flags, rgi))</span><br><span>@@ -2150,10 +2100,10 @@</span><br=
><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_exec=
ve_check(&amp;argv, es, 0, &quot;ERROR: Haiku inet route delete command fai=
led&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#else  /* if defined(TARGET_LINUX) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#else  /* if defined(ROUTE_NET_API) */</span><br>=
<span>     msg(M_FATAL,</span><br><span>         &quot;Sorry, but I don&#39=
;t know how to do &#39;route&#39; commands on this operating system=2E  Try=
 putting your routes in a --route-up script&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(ROUT=
E_NET_API) */</span><br><span> </span><br><span> done:</span><br><span>    =
 r-&gt;flags &amp;=3D ~RT_ADDED;</span><br><span>@@ -2175,7 +2125,7 @@</spa=
n><br><span>     }</span><br><span> </span><br><span> #if !defined(_WIN32)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LI=
NUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(RO=
UTE_NET_API)</span><br><span>     const char *gateway;</span><br><span> #en=
dif</span><br><span> #if !defined(TARGET_SOLARIS)</span><br><span>@@ -2202,=
12 +2152,11 @@</span><br><span>     struct argv argv =3D argv_new();</span>=
<br><span> </span><br><span>     network =3D print_in6_addr(r6-&gt;network,=
 0, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !def=
ined(TARGET_LINUX) &amp;&amp; !defined(_WIN32)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API) &amp;&amp; !defined(=
_WIN32)</span><br><span>     gateway =3D print_in6_addr(r6-&gt;gateway, 0, =
&amp;gc);</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_DARWIN) || defined(TARGE=
T_FREEBSD) || defined(TARGET_DRAGONFLY) \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET=
_DARWIN) || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><sp=
an> </span><br><span>     /* the BSD platforms cannot specify gateway and i=
nterface independently,</span><br><span>      * but for link-local destinat=
ions, we MUST specify the interface, so</span><br><span>@@ -2225,7 +2174,7 =
@@</span><br><span> </span><br><span>     msg(D_ROUTE, &quot;delete_route_i=
pv6(%s/%u)&quot;, network, r6-&gt;netbits);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</s=
pan><br><span>     int metric =3D -1;</span><br><span>     if ((r6-&gt;flag=
s &amp; RT_METRIC_DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br><sp=
an>     {</span><br><span>@@ -2233,10 +2182,10 @@</span><br><span>     }</s=
pan><br><span> </span><br><span>     if (net_route_v6_del(ctx, &amp;r6-&gt;=
network, r6-&gt;netbits, gateway_needed ? &amp;r6-&gt;gateway : NULL,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         de=
vice, r6-&gt;table_id, metric)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         device, ROUTE_TABLE_ID(r6-&gt;table_id)=
, metric)</span><br><span>         &lt; 0)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR=
: Linux route v6 delete command failed&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route v6 delete=
 command failed&quot;);</span><br><span>     }</span><br><span> </span><br>=
<span> #elif defined(_WIN32)</span><br><span>@@ -2258,22 +2207,6 @@</span><=
br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_ex=
ecve_check(&amp;argv, es, 0, &quot;ERROR: Solaris route delete -inet6 comma=
nd failed&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete =
-inet6 %s/%d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (gateway_needed)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        argv_printf_cat(&amp;argv, &quot;%s&quot;, gateway);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   argv_printf_cat(&amp;argv, &quot;-iface %s&quot;, device);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: *BSD=
 route delete -inet6 command failed&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_DARWIN)</span>=
<br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s delete -in=
et6 %s -prefixlen %d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span><br=
><span>@@ -2326,10 +2259,10 @@</span><br><span>     argv_msg(D_ROUTE, &amp;=
argv);</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ER=
ROR: Haiku inet6 route delete command failed&quot;);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGE=
T_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /=
* if defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span><br>=
<span>         &quot;Sorry, but I don&#39;t know how to do &#39;route ipv6&=
#39; commands on this operating system=2E  Try putting your routes in a --r=
oute-down script&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br><span=
> </span><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(=
&amp;gc);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2154?usp=3Demail">change 2154</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I601454a511c9aac4f37d862=
9b1692266cdbd6885 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 2154 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--D9cIULWV8vY=--


--===============2706686561541612450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2706686561541612450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2706686561541612450==--


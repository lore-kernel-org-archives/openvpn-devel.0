Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA5606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z2LJsG3S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H5Kxax8H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V/TXEYsg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=a/VyMokm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=5tivFrxnv7FUj69dUGE+twGqd0OMV0/FI+FCOnN2sVs=; b=Z2LJsG3SmsndhOC3XaFN9zLqED
	z6X3ZS/JXhkZCXfLl6qEy47zKmBozgq+UuiCqWfMBASSxGlaO1fSj8TZ6JaFbMleisodj92dugr8p
	GgGkTfoGwlYVcNTHahhaTxF5CNPuiTnaS0K+K90HNCiz0+XB5z3FC3TAarSopP/UVvxY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUIAC-00000000409-1O66;
	Fri, 20 Nov 2026 06:32:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUIAA-00000000403-1nM1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRe98lbmgRatibXiMT+f7ubuTjIN8gc01HfQqQEIU/I=; b=H5Kxax8HzSqk7UGVaC/h1M2MBg
 e7FPBZVtc+M49OaWywHzspWHK3ZAZiyWzVbosKluKCDAYiGY83T0CHqQYxz5nP7YY3G3KWNdvyfp/
 6rayEsfMZoVo6vfkC+P7fraStTqm6142kF0vLXoRTnSiARwcd/d6jUGvaOAJ2jURe38o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRe98lbmgRatibXiMT+f7ubuTjIN8gc01HfQqQEIU/I=; b=V/TXEYsgYFdfwEnt3PQXgaSahs
 p2+KVp98OKI3ivfxuzwtMDwjQXgDRidcMoPeGM19fZ2QKa/vIz1+JheCAOe3NQD9EPigd4V3Ypa3F
 Di90WafJHSrFQOA3lL41eiu5YwMsts4MaWUjOOV5fQCWfxLKLK2nibDr5KllNAuGZ4Xs=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUIA7-0000000047q-1RZU for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:31:58 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-491971ac844so413347f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795156309; x=1795761109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wRe98lbmgRatibXiMT+f7ubuTjIN8gc01HfQqQEIU/I=;
 b=a/VyMokmOYdhzQrY74kUTUu4Oqb8q83/c5DNEsfefYrK9TicsTxZgOK3Rp9U2Jt5UY
 85n2Y0EjV+6Mir55AbEqk5rQGCdNqVgnMrhNAGMMmNUlTs8HUEbGn+2p6e0BbFr4EV/n
 VCOM1LJiMzNGlolPAj/hNPetI9TmMbK+6tqEiYMMbe8LSFVT2dkSuq0tcl0mHS0S+Cg1
 lJbZiKYZVc2mQBZtM/W3+BgLLJNde+fe5ao43zSG3SNoNGmiRjLgSru5yzdqS9elG8n/
 w2itnpJVqLCQb7yUyh0Fsr2TJbe+0cjR7TYHtXwA8x9RPteC0tfCEA+Rf/dmQCz+CM47
 wczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156309; x=1795761109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wRe98lbmgRatibXiMT+f7ubuTjIN8gc01HfQqQEIU/I=;
 b=oWVvEZpz+whMmeVsKJEa2nymj7Qd/+BeHTd4H/cWHTLaYlk5mPjSTkszqNChqVndn7
 i5n+0TfuW85mD0tOLZDusjKZf2mHz+RRN0rSlp6bYg47Z/lkwsV0JJxJMqcIybVmalO0
 7er6NdSX5l9cb1qRE4fKOkuJTOfjbFnDu+Bn0qea8gPZl9ofZ5wrMnVboXakAAN4ZvTp
 QLhIR2ZGfABOqqDQGDf0NACiEE6dtOa7a326/6uzoIXI5MD974zkKW4oYH/5DvNs3XUR
 Fysb7LHpFtBDPvyCOKmZO4XdhjB70SKTq37EP28ujwjjtuPxnHRVdqtFyZWLDmIsH3mg
 GeHQ==
X-Gm-Message-State: APuU4Z9TMQulXiMpwF1LFLyEwsxcwTfztGRKyTkTKRpwjj1WQAYEArUV
 pyfuhNGcBW07/50oMfke95F8ATzw7DRg6UoTa2nB9pBitZ2540KZPlF9GbaYopF56WD2cY5jl62
 2VNhknZZpilo0eYuv4Sjn7e9VzVPzDJooweOeTy1FLa3xgQ0JLFdXCOlN97RVTpqU2Yc4so7TYt
 hWofUiIA==
X-Gm-Gg: AZFdTZex0puhLIJUZKHbbxiuRJ687gwx1WzLJlAPVC+I8MEBtsFv4H/h+F+blNQTz6D
 LgtNadWCgEMcBZWL0VL6EqfzpMOtB4pjHJYftim0OYSZ1JVs+9zy16AVGdyUtW0TWNyVtj4E75L
 hbev2F5ZPN0TGu+mFuIZlHvN4WXiE8VMT6Pf4QW6+3x41zPh5aJWhUYwgGeRI/2twMl5hxuTVLQ
 sSE0u/WRdOo2DMPBPGTAhsv1bMYyGSPPpvDuJ7Zo4m0WTDfgyU2CvtNmOxWufV/ZnDmIVe49YN0
 rsFUPzRlqNLwELoY5AukwIJedAx7hezWS8WdbbY10YvTImilcOmEwX/xeNZKMqKLmKpaPo45yIv
 w3CyBgBQM+QFkKocT3kGNGIRBdvOMzBixCwebu2Qdbz8moHkhMT3a/yqg44OkxGNjshOKJStn/Y
 WMntY1Qg93/6FzX4BEYjZVvwciqGjg2iTBfWl+KDJa1P1gmtAHLdlfamrYmaiknMEOf5+TvxFoO
 LihgS8MBEWKNZVjIxjna4W8r8tl83HamylmdM0uFO00ArlpxoiiEOT+hOix+6t8sYCdtM/J2Cp6
 udSvjBorRM+oQ/IZrvyOYspbIGPrr5huhil3g15HDGB1BPIrwisNWoRRVTWU9CVmpAfVKf4MrKJ
 w8PJZFHajTTIoUhtYWZnokaECxarnEuFuSXvBpWqY+7qcL0HvgHtYmKt1MZu+O83GxezvE5B6oZ
 BdeWOHDr96ufxnylU=
X-Received: by 2002:a05:6000:470c:b0:4a7:557:fc0 with SMTP id
 ffacd0b85a97d-4abb225fb4bmr3494101f8f.32.1795156308049; 
 Thu, 19 Nov 2026 22:31:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb42absm4027559f8f.1.2026.11.19.22.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:31:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:31:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: 506026679d9fb07044994d6876cd2e6a35559d2d
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77ad2fc4b5026522af9a75ed3c438a72964bad8a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUIA7-0000000047q-1RZU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use -1
 for "no route table"
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
Content-Type: multipart/mixed; boundary="===============7396865875372094424=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7396865875372094424==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QmWR7W84fG0="; charset=UTF-8

--QmWR7W84fG0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2224?usp=3Demail

to review the following change=2E
=


Change subject: networking: use -1 for "no route table"
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking: use -1 for "no r=
oute table"

Table 0 meant "default table" in the net_route_*() API=2E That=
 is fine on
Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 i=
s a real
FIB, which could then not be selected from a process running in an=
other
FIB=2E

Make the table argument an int, with -1 for the default table=
, and
default --route-table to -1=2E sitnl maps -1 and 0 to the main table,=
 as
before=2E On FreeBSD, -fib is now passed only for a set table; DCO
irou=
tes no longer force FIB 0 but use the FIB of the process=2E

Routes that ro=
ute=2Ec creates internally get -1 too; block-local routes
passed an uniniti=
alized table before=2E

Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b=
9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/=
dco=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networking_freebsd=2Ec
M=
 src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M s=
rc/openvpn/options=2Ec
M src/openvpn/route=2Ec
M tests/unit_tests/openvpn/t=
est_networking=2Ec
8 files changed, 66 insertions(+), 62 deletions(-)



  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/2224/1
=

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 236be93=2E=2E=
8d376fb 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -721,=
7 +721,7 @@
         }
 
         net_route_v6_add(&m->top=2Enet_ctx, &addr=
->v6=2Eaddr, addr->netbits,
-                         gateway, c->c1=2Etunt=
ap->actual_name, 0,
+                         gateway, c->c1=2Etuntap->actu=
al_name, -1,
                          DCO_IROUTE_METRIC);
 #endif
     }
@=
@ -739,7 +739,7 @@
         }
 
         net_route_v4_add(&m->top=2Enet_ctx=
, &dest, addr->netbits, gateway,
-                         c->c1=2Etuntap->=
actual_name, 0, DCO_IROUTE_METRIC);
+                         c->c1=2Etunta=
p->actual_name, -1, DCO_IROUTE_METRIC);
 #endif
     }
 #endif /* if define=
d(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
@@ -765,7 =
+765,7 @@
             dco_win_del_iroute_ipv4(&c->c1=2Etuntap->dco, htonl(=
ir->network), ir->netbits);
 #else
             net_route_v4_del(net_ctx, &=
ir->network, ir->netbits,
-                             &c->c2=2Epush_ifcon=
fig_local, c->c1=2Etuntap->actual_name, 0,
+                             &c=
->c2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_name, -1,
              =
                DCO_IROUTE_METRIC);
 #endif
         }
@@ -779,7 +779,7 @@
=
         {
             /* On windows we do not install these routes, so we=
 also do not need to delete them */
             net_route_v4_del(net_ctx, =
&ifconfig_local, 32, NULL,
-                             c->c1=2Etuntap->ac=
tual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1=2Etun=
tap->actual_name, -1, DCO_IROUTE_METRIC);
         }
 #endif
     }
@@ -792=
,7 +792,7 @@
             dco_win_del_iroute_ipv6(&c->c1=2Etuntap->dco, ir6=
->network, ir6->netbits);
 #else
             net_route_v6_del(net_ctx, &ir=
6->network, ir6->netbits,
-                             &c->c2=2Epush_ifcon=
fig_ipv6_local, c->c1=2Etuntap->actual_name, 0,
+                          =
   &c->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->actual_name, -1,
    =
                          DCO_IROUTE_METRIC);
 #endif
         }
@@ -805,7 =
+805,7 @@
         {
             /* On windows we do not install these rou=
tes, so we also do not need to delete them */
             net_route_v6_del=
(net_ctx, dest, 128, NULL,
-                             c->c1=2Etuntap->ac=
tual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1=2Etun=
tap->actual_name, -1, DCO_IROUTE_METRIC);
         }
 #endif
     }
diff --=
git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index 7ad6e2e=
=2E=2E1763e64 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/net=
working=2Eh
@@ -245,14 +245,13 @@
  * @param prefixlen the length of the pr=
efix of the destination
  * @param gw        the gateway for this route
  *=
 @param iface     the interface for this route (can be NULL)
- * @param tab=
le     the table to add this route to (if 0, will be added to the
- *      =
            main table)
+ * @param table     the table to add this route to=
, or -1 for the default one
  * @param metric    the metric associated with=
 the route
  *
  * @return          0 on success, a negative error code oth=
erwise
  */
 int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_ad=
dr_t *dst, int prefixlen,
-                     const in_addr_t *gw, const =
openvpn_net_iface_t *iface, uint32_t table,
+                     const in_=
addr_t *gw, const openvpn_net_iface_t *iface, int table,
                  =
    int metric);
 
 /**
@@ -263,14 +262,13 @@
  * @param prefixlen the leng=
th of the prefix of the destination
  * @param gw        the gateway for th=
is route
  * @param iface     the interface for this route (can be NULL)
- =
* @param table     the table to add this route to (if 0, will be added to t=
he
- *                  main table)
+ * @param table     the table to add t=
his route to, or -1 for the default one
  * @param metric    the metric ass=
ociated with the route
  *
  * @return          0 on success, a negative er=
ror code otherwise
  */
 int net_route_v6_add(const openvpn_net_ctx_t *ctx,=
 const struct in6_addr *dst, int prefixlen,
-                     const str=
uct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+      =
               const struct in6_addr *gw, const openvpn_net_iface_t *iface,=
 int table,
                      int metric);
 
 /**
@@ -281,14 +279,13 @@=

  * @param prefixlen the length of the prefix of the destination
  * @para=
m gw        the gateway for this route
  * @param iface     the interface f=
or this route (can be NULL)
- * @param table     the table to add this rout=
e to (if 0, will be added to the
- *                  main table)
+ * @para=
m table     the table to add this route to, or -1 for the default one
  * @=
param metric    the metric associated with the route
  *
  * @return       =
   0 on success, a negative error code otherwise
  */
 int net_route_v4_del=
(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
-      =
               const in_addr_t *gw, const openvpn_net_iface_t *iface, uint3=
2_t table,
+                     const in_addr_t *gw, const openvpn_net_ifa=
ce_t *iface, int table,
                      int metric);
 
 /**
@@ -299,1=
4 +296,13 @@
  * @param prefixlen the length of the prefix of the destinati=
on
  * @param gw        the gateway for this route
  * @param iface     the=
 interface for this route (can be NULL)
- * @param table     the table to a=
dd this route to (if 0, will be added to the
- *                  main tabl=
e)
+ * @param table     the table to add this route to, or -1 for the defau=
lt one
  * @param metric    the metric associated with the route
  *
  * @r=
eturn          0 on success, a negative error code otherwise
  */
 int net_=
route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int =
prefixlen,
-                     const struct in6_addr *gw, const openvpn_n=
et_iface_t *iface, uint32_t table,
+                     const struct in6_a=
ddr *gw, const openvpn_net_iface_t *iface, int table,
                     =
 int metric);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD=
 */
diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networkin=
g_freebsd=2Ec
index 88fd5c0=2E=2E8ba6326 100644
--- a/src/openvpn/networkin=
g_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -10,7 +10,7 @@
 
=
 static int
 net_route_v4(const char *op, const in_addr_t *dst, int prefixl=
en, const in_addr_t *gw,
-             const char *iface, uint32_t table, i=
nt metric)
+             const char *iface, int table, int metric)
 {
     =
char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst, _gw=
;
@@ -27,15 +27,20 @@
     if (gw)
     {
         _gw =3D ntohl(*gw);
-   =
     argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+   =
     argv_printf(&argv, "%s %s -net %s/%d %s", ROUTE_PATH, op,
            =
         inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-       =
             inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+       =
             inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)));
     }
     els=
e
     {
-        argv_printf(&argv, "%s %s -net %s/%d -iface %s -fib %d", =
ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s -net %s/%d -iface %s", R=
OUTE_PATH, op,
                     inet_ntop(AF_INET, &_dst, buf1, sizeof(=
buf1)), prefixlen,
-                    iface, table);
+                   =
 iface);
+    }
+    /* without -fib, route(8) uses the FIB of the process =
*/
+    if (table >=3D 0)
+    {
+        argv_printf_cat(&argv, "-fib %d",=
 table);
     }
 
     argv_msg(M_INFO, &argv);
@@ -48,7 +53,7 @@
 
 static=
 int
 net_route_v6(const char *op, const struct in6_addr *dst, int prefixle=
n, const struct in6_addr *gw,
-             const char *iface, uint32_t tab=
le, int metric)
+             const char *iface, int table, int metric)
 {
=
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct argv =
argv =3D argv_new();
@@ -61,15 +66,19 @@
      */
     if (gw)
     {
-    =
    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+ =
       argv_printf(&argv, "%s -6 %s -net %s/%d %s", ROUTE_PATH, op,
       =
              inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-   =
                 inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+    =
                inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));
     }
     e=
lse
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s -fib =
%d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s -6 %s -net %s/%d -ifac=
e %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET6, dst, buf1, =
sizeof(buf1)), prefixlen,
-                    iface, table);
+            =
        iface);
+    }
+    if (table >=3D 0)
+    {
+        argv_printf_c=
at(&argv, "-fib %d", table);
     }
 
 
@@ -83,28 +92,28 @@
 
 int
 net_rou=
te_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen=
, const in_addr_t *gw,
-                 const char *iface, uint32_t table,=
 int metric)
+                 const char *iface, int table, int metric)
 {=

     return net_route_v4("add", dst, prefixlen, gw, iface, table, metric);=

 }
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6=
_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, con=
st char *iface, uint32_t table, int metric)
+                 const struct =
in6_addr *gw, const char *iface, int table, int metric)
 {
     return net_=
route_v6("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_r=
oute_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixl=
en, const in_addr_t *gw,
-                 const char *iface, uint32_t tabl=
e, int metric)
+                 const char *iface, int table, int metric)
=
 {
     return net_route_v4("del", dst, prefixlen, gw, iface, table, metric=
);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct i=
n6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, c=
onst char *iface, uint32_t table, int metric)
+                 const struc=
t in6_addr *gw, const char *iface, int table, int metric)
 {
     return ne=
t_route_v6("del", dst, prefixlen, gw, iface, table, metric);
 }
diff --git =
a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec=

index d987478=2E=2E6c4c8f4 100644
--- a/src/openvpn/networking_iproute2=2E=
c
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -243,7 +243,7 @@
 
 int
 net=
_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefi=
xlen, const in_addr_t *gw,
-                 const char *iface, uint32_t ta=
ble, int metric)
+                 const char *iface, int table, int metric=
)
 {
     struct argv argv =3D argv_new();
     const char *dst_str =3D pri=
nt_in_addr_t(*dst, 0, &argv=2Egc);
@@ -281,7 +281,7 @@
 
 int
 net_route_v6=
_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixle=
n,
-                 const struct in6_addr *gw, const char *iface, uint32_t=
 table, int metric)
+                 const struct in6_addr *gw, const char=
 *iface, int table, int metric)
 {
     struct argv argv =3D argv_new();
  =
   char *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
@@ -314,7=
 +314,7 @@
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_=
addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const ch=
ar *iface, uint32_t table, int metric)
+                 const char *iface,=
 int table, int metric)
 {
     struct argv argv =3D argv_new();
     const=
 char *dst_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
@@ -340,7 +340,7 @=
@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_a=
ddr *dst, int prefixlen,
-                 const struct in6_addr *gw, const=
 char *iface, uint32_t table, int metric)
+                 const struct in=
6_addr *gw, const char *iface, int table, int metric)
 {
     struct argv a=
rgv =3D argv_new();
     char *dst_str =3D (char *)print_in6_addr(*dst, 0, =
&argv=2Egc);
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/ne=
tworking_sitnl=2Ec
index b7c0f58=2E=2E17df0d9 100644
--- a/src/openvpn/netw=
orking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1115,14 +1115,1=
1 @@
 
 static int
 sitnl_route_add(const char *iface, sa_family_t af_famil=
y, const void *dst, int prefixlen,
-                const void *gw, uint32_=
t table, int metric)
+                const void *gw, int table, int metric=
)
 {
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
-
-    if (table =3D=
=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-    }
+    /* table 0 is R=
T_TABLE_UNSPEC */
+    uint32_t rt_table =3D table > 0 ? (uint32_t)table : =
RT_TABLE_MAIN;
 
     if (!gw && iface)
     {
@@ -1130,12 +1127,12 @@
    =
 }
 
     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_fami=
ly, dst, prefixlen, gw,
-                           table, metric, scope, R=
TPROT_BOOT, RTN_UNICAST);
+                           rt_table, metric, sco=
pe, RTPROT_BOOT, RTN_UNICAST);
 }
 
 int
 net_route_v4_add(const openvpn_ne=
t_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-  =
               const char *iface, uint32_t table, int metric)
+            =
     const char *iface, int table, int metric)
 {
     const in_addr_t *dst=
_ptr =3D NULL, *gw_ptr =3D NULL;
     in_addr_t dst_be =3D 0, gw_be =3D 0;
=
@@ -1154,7 +1151,7 @@
         gw_ptr =3D &gw_be;
     }
 
-    msg(D_ROUTE=
, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE,=
 "%s: %s/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop=
(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop=
(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ =
-1163,7 +1160,7 @@
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, c=
onst struct in6_addr *dst, int prefixlen,
-                 const struct in=
6_addr *gw, const char *iface, uint32_t table, int metric)
+               =
  const struct in6_addr *gw, const char *iface, int table, int metric)
 {
 =
    inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1183,7 +1180,7 @@=

         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %=
s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s=
 dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6=
=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6,=
 &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1=
192,20 +1189,18 @@
 
 static int
 sitnl_route_del(const char *iface, sa_fam=
ily_t af_family, const inet_address_t *dst, int prefixlen,
-               =
 const inet_address_t *gw, uint32_t table, int metric)
+                con=
st inet_address_t *gw, int table, int metric)
 {
-    if (table =3D=3D 0)
-=
    {
-        table =3D RT_TABLE_MAIN;
-    }
+    /* table 0 is RT_TABLE_=
UNSPEC */
+    uint32_t rt_table =3D table > 0 ? (uint32_t)table : RT_TABLE=
_MAIN;
 
-    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst=
, prefixlen, gw, table, metric,
+    return sitnl_route_set(RTM_DELROUTE, 0=
, iface, af_family, dst, prefixlen, gw, rt_table, metric,
                 =
           RT_SCOPE_NOWHERE, 0, 0);
 }
 
 int
 net_route_v4_del(const openv=
pn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw=
,
-                 const char *iface, uint32_t table, int metric)
+       =
          const char *iface, int table, int metric)
 {
     inet_address_t =
dst_v4;
     inet_address_t gw_v4;
@@ -1225,7 +1220,7 @@
         gw_v4=2Ei=
pv4 =3D htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s tab=
le %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s tabl=
e %d metric %d", __func__,
         inet_ntop(AF_INET, &dst_v4=2Eipv4, dst_=
str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4=2Eipv4=
, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1234,7 +1229,7 =
@@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_=
addr *dst, int prefixlen,
-                 const struct in6_addr *gw, cons=
t char *iface, uint32_t table, int metric)
+                 const struct i=
n6_addr *gw, const char *iface, int table, int metric)
 {
     inet_address=
_t dst_v6;
     inet_address_t gw_v6;
@@ -1254,7 +1249,7 @@
         gw_v6=
=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table =
%u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %=
d metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_st=
r, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6,=
 gw_str, sizeof(gw_str)), np(iface), table, metric);
 
diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index 947439d=2E=2E01d5edb 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -831,7 +83=
1,7 @@
     o->ce=2Emssfix =3D 0;
     o->ce=2Emssfix_default =3D true;
   =
  o->ce=2Emssfix_encap =3D true;
-    o->route_default_table_id =3D 0;
+   =
 o->route_default_table_id =3D -1;
     o->route_delay_window =3D 30;
     =
o->resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;
     o->resolve_in_adva=
nce =3D false;
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
i=
ndex 9086529=2E=2E8c493ee 100644
--- a/src/openvpn/route=2Ec
+++ b/src/open=
vpn/route=2Ec
@@ -545,6 +545,7 @@
         /* split a route into two smalle=
r blocking routes, and direct them to target */
         l2 =3D ((~gateway-=
>netmask) + 1) >> 1;
         r1->flags =3D RT_DEFINED;
+        r1->table_=
id =3D -1;
         r1->gateway =3D target;
         r1->network =3D gatewa=
y->addr & gateway->netmask;
         r1->netmask =3D ~(l2 - 1);
@@ -854,6 +=
855,7 @@
                 r6->gateway =3D rl6->rgi6=2Egateway=2Eaddr_ipv6;
=
             }
             r6->metric =3D 1;
+            r6->table_id =3D=
 -1;
 #ifdef _WIN32
             r6->adapter_index =3D rl6->rgi6=2Eadapter_=
index;
 #else
@@ -883,6 +885,7 @@
     struct route_ipv4 r;
     CLEAR(r);
=
     r=2Eflags =3D RT_DEFINED;
+    r=2Etable_id =3D -1;
     r=2Enetwork =
=3D network;
     r=2Enetmask =3D netmask;
     r=2Egateway =3D gateway;
@@=
 -897,6 +900,7 @@
     struct route_ipv4 r;
     CLEAR(r);
     r=2Eflags =
=3D RT_DEFINED | RT_ADDED;
+    r=2Etable_id =3D -1;
     r=2Enetwork =3D n=
etwork;
     r=2Enetmask =3D netmask;
     r=2Egateway =3D gateway;
diff --=
git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openv=
pn/test_networking=2Ec
index b580d32=2E=2E95019e5 100644
--- a/tests/unit_t=
ests/openvpn/test_networking=2Ec
+++ b/tests/unit_tests/openvpn/test_networ=
king=2Ec
@@ -112,7 +112,7 @@
     }
     printf("\n");
 
-    return net_ro=
ute_v4_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_=
route_v4_add(NULL, &dst, prefixlen, NULL, iface, -1, metric);
 }
 
 static =
int
@@ -148,7 +148,7 @@
     }
     printf("\n");
 
-    return net_route_v=
4_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_=
v4_add(NULL, &dst, prefixlen, &gw, iface, -1, metric);
 }
 
 static int
@@ =
-175,7 +175,7 @@
     }
     printf("\n");
 
-    return net_route_v6_add(N=
ULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_v6_add=
(NULL, &dst, prefixlen, NULL, iface, -1, metric);
 }
 
 static int
@@ -208,=
7 +208,7 @@
     }
     printf("\n");
 
-    return net_route_v6_add(NULL, =
&dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_v6_add(NULL,=
 &dst, prefixlen, &gw, iface, -1, metric);
 }
 
 static void

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08=
ad862597b9
Gerrit-Change-Number: 2224
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--QmWR7W84fG0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">networking: use -1 for &quot;no route table&quot;<br><b=
r>Table 0 meant &quot;default table&quot; in the net_route_*() API=2E That =
is fine on<br>Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0=
 is a real<br>FIB, which could then not be selected from a process running =
in another<br>FIB=2E<br><br>Make the table argument an int, with -1 for the=
 default table, and<br>default --route-table to -1=2E sitnl maps -1 and 0 t=
o the main table, as<br>before=2E On FreeBSD, -fib is now passed only for a=
 set table; DCO<br>iroutes no longer force FIB 0 but use the FIB of the pro=
cess=2E<br><br>Routes that route=2Ec creates internally get -1 too; block-l=
ocal routes<br>passed an uninitialized table before=2E<br><br>Change-Id: Ic=
bfc6b64beea5e70f32449c5a63a08ad862597b9<br>Signed-off-by: Razvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openv=
pn/networking=2Eh<br>M src/openvpn/networking_freebsd=2Ec<br>M src/openvpn/=
networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/open=
vpn/options=2Ec<br>M src/openvpn/route=2Ec<br>M tests/unit_tests/openvpn/te=
st_networking=2Ec<br>8 files changed, 66 insertions(+), 62 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/24/2224/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/open=
vpn/dco=2Ec</span><br><span>index 236be93=2E=2E8d376fb 100644</span><br><sp=
an>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</spa=
n><br><span>@@ -721,7 +721,7 @@</span><br><span>         }</span><br><span>=
 </span><br><span>         net_route_v6_add(&amp;m-&gt;top=2Enet_ctx, &amp;=
addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                         gateway, c-&gt;c1=2Etuntap-&gt;act=
ual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  gateway, c-&gt;c1=2Etuntap-&gt;actual_name, -1,</span><br=
><span>                          DCO_IROUTE_METRIC);</span><br><span> #endi=
f</span><br><span>     }</span><br><span>@@ -739,7 +739,7 @@</span><br><spa=
n>         }</span><br><span> </span><br><span>         net_route_v4_add(&a=
mp;m-&gt;top=2Enet_ctx, &amp;dest, addr-&gt;netbits, gateway,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                         c-&gt;c1=
=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         c-&gt;c1=2Etuntap-&g=
t;actual_name, -1, DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><s=
pan>     }</span><br><span> #endif /* if defined(TARGET_LINUX) || defined(T=
ARGET_FREEBSD) || defined(_WIN32) */</span><br><span>@@ -765,7 +765,7 @@</s=
pan><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&=
gt;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else</spa=
n><br><span>             net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-=
&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-=
&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                             &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=
=2Etuntap-&gt;actual_name, -1,</span><br><span>                            =
  DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>         }</s=
pan><br><span>@@ -779,7 +779,7 @@</span><br><span>         {</span><br><spa=
n>             /* On windows we do not install these routes, so we also do =
not need to delete them */</span><br><span>             net_route_v4_del(ne=
t_ctx, &amp;ifconfig_local, 32, NULL,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                             c-&gt;c1=2Etuntap-&gt;actual_n=
ame, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                             c-&gt;c1=2Etuntap-&gt;actual_name, -1,=
 DCO_IROUTE_METRIC);</span><br><span>         }</span><br><span> #endif</sp=
an><br><span>     }</span><br><span>@@ -792,7 +792,7 @@</span><br><span>   =
          dco_win_del_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;n=
etwork, ir6-&gt;netbits);</span><br><span> #else</span><br><span>          =
   net_route_v6_del(net_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
&amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name=
, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
              &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&=
gt;actual_name, -1,</span><br><span>                              DCO_IROUT=
E_METRIC);</span><br><span> #endif</span><br><span>         }</span><br><sp=
an>@@ -805,7 +805,7 @@</span><br><span>         {</span><br><span>         =
    /* On windows we do not install these routes, so we also do not need to=
 delete them */</span><br><span>             net_route_v6_del(net_ctx, dest=
, 128, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
            c-&gt;c1=2Etuntap-&gt;actual_name, -1, DCO_IROUTE_METRIC);</spa=
n><br><span>         }</span><br><span> #endif</span><br><span>     }</span=
><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=
=2Eh</span><br><span>index 7ad6e2e=2E=2E1763e64 100644</span><br><span>--- =
a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=
=2Eh</span><br><span>@@ -245,14 +245,13 @@</span><br><span>  * @param prefi=
xlen the length of the prefix of the destination</span><br><span>  * @param=
 gw        the gateway for this route</span><br><span>  * @param iface     =
the interface for this route (can be NULL)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param table     the table to add this route to (if=
 0, will be added to the</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *                  main table)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param table     the table to add this route to, or -1 fo=
r the default one</span><br><span>  * @param metric    the metric associate=
d with the route</span><br><span>  *</span><br><span>  * @return          0=
 on success, a negative error code otherwise</span><br><span>  */</span><br=
><span> int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t =
*dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                    const in_addr_t *gw, const openvpn_net_iface_t *iface, =
uint32_t table,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 const in_addr_t *gw, const openvpn_net_iface_t *iface, int=
 table,</span><br><span>                      int metric);</span><br><span>=
 </span><br><span> /**</span><br><span>@@ -263,14 +262,13 @@</span><br><spa=
n>  * @param prefixlen the length of the prefix of the destination</span><b=
r><span>  * @param gw        the gateway for this route</span><br><span>  *=
 @param iface     the interface for this route (can be NULL)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param table     the table to add=
 this route to (if 0, will be added to the</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *                  main table)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param table     the table to add this=
 route to, or -1 for the default one</span><br><span>  * @param metric    t=
he metric associated with the route</span><br><span>  *</span><br><span>  *=
 @return          0 on success, a negative error code otherwise</span><br><=
span>  */</span><br><span> int net_route_v6_add(const openvpn_net_ctx_t *ct=
x, const struct in6_addr *dst, int prefixlen,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                     const struct in6_addr *gw, con=
st openvpn_net_iface_t *iface, uint32_t table,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                     const struct in6_addr *gw, =
const openvpn_net_iface_t *iface, int table,</span><br><span>              =
        int metric);</span><br><span> </span><br><span> /**</span><br><span=
>@@ -281,14 +279,13 @@</span><br><span>  * @param prefixlen the length of t=
he prefix of the destination</span><br><span>  * @param gw        the gatew=
ay for this route</span><br><span>  * @param iface     the interface for th=
is route (can be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @param table     the table to add this route to (if 0, will be added to=
 the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *               =
   main table)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram table     the table to add this route to, or -1 for the default one</s=
pan><br><span>  * @param metric    the metric associated with the route</sp=
an><br><span>  *</span><br><span>  * @return          0 on success, a negat=
ive error code otherwise</span><br><span>  */</span><br><span> int net_rout=
e_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                     con=
st in_addr_t *gw, const openvpn_net_iface_t *iface, int table,</span><br><s=
pan>                      int metric);</span><br><span> </span><br><span> /=
**</span><br><span>@@ -299,14 +296,13 @@</span><br><span>  * @param prefixl=
en the length of the prefix of the destination</span><br><span>  * @param g=
w        the gateway for this route</span><br><span>  * @param iface     th=
e interface for this route (can be NULL)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param table     the table to add this route to (if 0=
, will be added to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *                  main table)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param table     the table to add this route to, or -1 for =
the default one</span><br><span>  * @param metric    the metric associated =
with the route</span><br><span>  *</span><br><span>  * @return          0 o=
n success, a negative error code otherwise</span><br><span>  */</span><br><=
span> int net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_a=
ddr *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                     const struct in6_addr *gw, const openvpn_net_iface_=
t *iface, uint32_t table,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     const struct in6_addr *gw, const openvpn_net_ifa=
ce_t *iface, int table,</span><br><span>                      int metric);<=
/span><br><span> </span><br><span> #endif /* ENABLE_SITNL || ENABLE_IPROUTE=
 || TARGET_FREEBSD */</span><br><span>diff --git a/src/openvpn/networking_f=
reebsd=2Ec b/src/openvpn/networking_freebsd=2Ec</span><br><span>index 88fd5=
c0=2E=2E8ba6326 100644</span><br><span>--- a/src/openvpn/networking_freebsd=
=2Ec</span><br><span>+++ b/src/openvpn/networking_freebsd=2Ec</span><br><sp=
an>@@ -10,7 +10,7 @@</span><br><span> </span><br><span> static int</span><b=
r><span> net_route_v4(const char *op, const in_addr_t *dst, int prefixlen, =
const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
            const char *iface, uint32_t table, int metric)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+             const char *iface, int =
table, int metric)</span><br><span> {</span><br><span>     char buf1[INET_A=
DDRSTRLEN], buf2[INET_ADDRSTRLEN];</span><br><span>     in_addr_t _dst, _gw=
;</span><br><span>@@ -27,15 +27,20 @@</span><br><span>     if (gw)</span><b=
r><span>     {</span><br><span>         _gw =3D ntohl(*gw);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;=
%s %s -net %s/%d %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s %s -=
net %s/%d %s&quot;, ROUTE_PATH, op,</span><br><span>                     in=
et_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    inet_ntop(AF_INET=
, &amp;_gw, buf2, sizeof(buf2)), table);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    inet_ntop(AF_INET, &amp;_gw, buf2,=
 sizeof(buf2)));</span><br><span>     }</span><br><span>     else</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
argv_printf(&amp;argv, &quot;%s %s -net %s/%d -iface %s -fib %d&quot;, ROUT=
E_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
argv_printf(&amp;argv, &quot;%s %s -net %s/%d -iface %s&quot;, ROUTE_PATH, =
op,</span><br><span>                     inet_ntop(AF_INET, &amp;_dst, buf1=
, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    iface, table);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    iface);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* without -fib, route(8) uses the FIB of the process */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (table &gt;=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&am=
p;argv, &quot;-fib %d&quot;, table);</span><br><span>     }</span><br><span=
> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>@@ -48=
,7 +53,7 @@</span><br><span> </span><br><span> static int</span><br><span> =
net_route_v6(const char *op, const struct in6_addr *dst, int prefixlen, con=
st struct in6_addr *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             const char *iface, uint32_t table, int metric)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             const char *iface, i=
nt table, int metric)</span><br><span> {</span><br><span>     char buf1[INE=
T6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];</span><br><span>     struct argv ar=
gv =3D argv_new();</span><br><span>@@ -61,15 +66,19 @@</span><br><span>    =
  */</span><br><span>     if (gw)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s =
-6 %s -net %s/%d %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %=
s -net %s/%d %s&quot;, ROUTE_PATH, op,</span><br><span>                    =
 inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    inet_ntop(AF_INET6,=
 gw, buf2, sizeof(buf2)), table);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2=
)));</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(=
&amp;argv, &quot;%s -6 %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, o=
p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_prin=
tf(&amp;argv, &quot;%s -6 %s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</s=
pan><br><span>                     inet_ntop(AF_INET6, dst, buf1, sizeof(bu=
f1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               iface, table);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    iface);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (table &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   argv_printf_cat(&amp;argv, &quot;-fib %d&quot;, table);</span><br><span>=
     }</span><br><span> </span><br><span> </span><br><span>@@ -83,28 +92,28=
 @@</span><br><span> </span><br><span> int</span><br><span> net_route_v4_ad=
d(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const =
in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
          const char *iface, uint32_t table, int metric)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                 const char *iface, in=
t table, int metric)</span><br><span> {</span><br><span>     return net_rou=
te_v4(&quot;add&quot;, dst, prefixlen, gw, iface, table, metric);</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span> net_route=
_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefi=
xlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 con=
st struct in6_addr *gw, const char *iface, int table, int metric)</span><br=
><span> {</span><br><span>     return net_route_v6(&quot;add&quot;, dst, pr=
efixlen, gw, iface, table, metric);</span><br><span> }</span><br><span> </s=
pan><br><span> int</span><br><span> net_route_v4_del(const openvpn_net_ctx_=
t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                 const char *if=
ace, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 const char *iface, int table, int metric)</sp=
an><br><span> {</span><br><span>     return net_route_v4(&quot;del&quot;, d=
st, prefixlen, gw, iface, table, metric);</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span> net_route_v6_del(const openvpn_ne=
t_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                 const struct in6_addr *=
gw, const char *iface, uint32_t table, int metric)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 const struct in6_addr *gw, =
const char *iface, int table, int metric)</span><br><span> {</span><br><spa=
n>     return net_route_v6(&quot;del&quot;, dst, prefixlen, gw, iface, tabl=
e, metric);</span><br><span> }</span><br><span>diff --git a/src/openvpn/net=
working_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>=
index d987478=2E=2E6c4c8f4 100644</span><br><span>--- a/src/openvpn/network=
ing_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec<=
/span><br><span>@@ -243,7 +243,7 @@</span><br><span> </span><br><span> int<=
/span><br><span> net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_ad=
dr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                 const char *iface, uint32_t table=
, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           const char *iface, int table, int metric)</span><br><span> {</sp=
an><br><span>     struct argv argv =3D argv_new();</span><br><span>     con=
st char *dst_str =3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><s=
pan>@@ -281,7 +281,7 @@</span><br><span> </span><br><span> int</span><br><s=
pan> net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *=
dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               const struct in6_addr *gw, const char *iface, uint32_t table=
, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           const struct in6_addr *gw, const char *iface, int table, int met=
ric)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new(=
);</span><br><span>     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &=
amp;argv=2Egc);</span><br><span>@@ -314,7 +314,7 @@</span><br><span> </span=
><br><span> int</span><br><span> net_route_v4_del(const openvpn_net_ctx_t *=
ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                 const char *iface=
, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const char *iface, int table, int metric)</span>=
<br><span> {</span><br><span>     struct argv argv =3D argv_new();</span><b=
r><span>     const char *dst_str =3D print_in_addr_t(*dst, 0, &amp;argv=2Eg=
c);</span><br><span>@@ -340,7 +340,7 @@</span><br><span> </span><br><span> =
int</span><br><span> net_route_v6_del(const openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                 const struct in6_addr *gw, const char *iface=
, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const struct in6_addr *gw, const char *iface, in=
t table, int metric)</span><br><span> {</span><br><span>     struct argv ar=
gv =3D argv_new();</span><br><span>     char *dst_str =3D (char *)print_in6=
_addr(*dst, 0, &amp;argv=2Egc);</span><br><span>diff --git a/src/openvpn/ne=
tworking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index=
 b7c0f58=2E=2E17df0d9 100644</span><br><span>--- a/src/openvpn/networking_s=
itnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><=
span>@@ -1115,14 +1115,11 @@</span><br><span> </span><br><span> static int<=
/span><br><span> sitnl_route_add(const char *iface, sa_family_t af_family, =
const void *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                const void *gw, uint32_t table, int metric)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                const voi=
d *gw, int table, int metric)</span><br><span> {</span><br><span>     enum =
rt_scope_t scope =3D RT_SCOPE_UNIVERSE;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (table =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        table =3D=
 RT_TABLE_MAIN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* table 0 is RT=
_TABLE_UNSPEC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint32_t rt_table =3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</spa=
n><br><span> </span><br><span>     if (!gw &amp;&amp; iface)</span><br><spa=
n>     {</span><br><span>@@ -1130,12 +1127,12 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     return sitnl_route_set(RTM_NEWROUTE, NL=
M_F_CREATE, iface, af_family, dst, prefixlen, gw,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                           table, metric, scope=
, RTPROT_BOOT, RTN_UNICAST);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                           rt_table, metric, scope, RTPROT_BOOT, R=
TN_UNICAST);</span><br><span> }</span><br><span> </span><br><span> int</spa=
n><br><span> net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t=
 *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                 const char *iface, uint32_t table, in=
t metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       const char *iface, int table, int metric)</span><br><span> {</span><=
br><span>     const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><b=
r><span>     in_addr_t dst_be =3D 0, gw_be =3D 0;</span><br><span>@@ -1154,=
7 +1151,7 @@</span><br><span>         gw_ptr =3D &amp;gw_be;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot=
;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __func__,=
</span><br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(d=
st_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_be=
, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </sp=
an><br><span>@@ -1163,7 +1160,7 @@</span><br><span> </span><br><span> int</=
span><br><span> net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct=
 in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                 const struct in6_addr *gw, const char *iface, uin=
t32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                 const struct in6_addr *gw, const char *iface, int tab=
le, int metric)</span><br><span> {</span><br><span>     inet_address_t dst_=
v6;</span><br><span>     inet_address_t gw_v6;</span><br><span>@@ -1183,7 +=
1180,7 @@</span><br><span>         gw_v6=2Eipv6 =3D *gw;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, _=
_func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_R=
OUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __func__,</sp=
an><br><span>         inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, size=
of(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET6, &amp;=
gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br=
><span> </span><br><span>@@ -1192,20 +1189,18 @@</span><br><span> </span><b=
r><span> static int</span><br><span> sitnl_route_del(const char *iface, sa_=
family_t af_family, const inet_address_t *dst, int prefixlen,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                const inet_address_=
t *gw, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                const inet_address_t *gw, int table, int met=
ric)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (table =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tabl=
e =3D RT_TABLE_MAIN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* table 0 =
is RT_TABLE_UNSPEC */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint32_t rt_table =3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, =
gw, table, metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen=
, gw, rt_table, metric,</span><br><span>                            RT_SCOP=
E_NOWHERE, 0, 0);</span><br><span> }</span><br><span> </span><br><span> int=
</span><br><span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_a=
ddr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                 const char *iface, uint32_t tabl=
e, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            const char *iface, int table, int metric)</span><br><span> {</s=
pan><br><span>     inet_address_t dst_v4;</span><br><span>     inet_address=
_t gw_v4;</span><br><span>@@ -1225,7 +1220,7 @@</span><br><span>         gw=
_v4=2Eipv4 =3D htonl(*gw);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s=
/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s d=
ev %s table %d metric %d&quot;, __func__,</span><br><span>         inet_nto=
p(AF_INET, &amp;dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,</span>=
<br><span>         inet_ntop(AF_INET, &amp;gw_v4=2Eipv4, gw_str, sizeof(gw_=
str)), np(iface), table, metric);</span><br><span> </span><br><span>@@ -123=
4,7 +1229,7 @@</span><br><span> </span><br><span> int</span><br><span> net_=
route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int =
prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      const struct in6_addr *gw, const char *iface, uint32_t table, int met=
ric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const struct in6_addr *gw, const char *iface, int table, int metric)</spa=
n><br><span> {</span><br><span>     inet_address_t dst_v6;</span><br><span>=
     inet_address_t gw_v6;</span><br><span>@@ -1254,7 +1249,7 @@</span><br>=
<span>         gw_v6=2Eipv6 =3D *gw;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &q=
uot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%=
d via %s dev %s table %d metric %d&quot;, __func__,</span><br><span>       =
  inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefix=
len,</span><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str=
, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </span><br><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 947439d=2E=2E01d5edb 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -831,7 +831,7 @@</span><br><span>     o-&gt;ce=2Emssfix =3D 0;</span><b=
r><span>     o-&gt;ce=2Emssfix_default =3D true;</span><br><span>     o-&gt=
;ce=2Emssfix_encap =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    o-&gt;route_default_table_id =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    o-&gt;route_default_table_id =3D -1;</span><=
br><span>     o-&gt;route_delay_window =3D 30;</span><br><span>     o-&gt;r=
esolve_retry_seconds =3D RESOLV_RETRY_INFINITE;</span><br><span>     o-&gt;=
resolve_in_advance =3D false;</span><br><span>diff --git a/src/openvpn/rout=
e=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9086529=2E=2E8c493ee 10=
0644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/=
openvpn/route=2Ec</span><br><span>@@ -545,6 +545,7 @@</span><br><span>     =
    /* split a route into two smaller blocking routes, and direct them to t=
arget */</span><br><span>         l2 =3D ((~gateway-&gt;netmask) + 1) &gt;&=
gt; 1;</span><br><span>         r1-&gt;flags =3D RT_DEFINED;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        r1-&gt;table_id =3D -1;</s=
pan><br><span>         r1-&gt;gateway =3D target;</span><br><span>         =
r1-&gt;network =3D gateway-&gt;addr &amp; gateway-&gt;netmask;</span><br><s=
pan>         r1-&gt;netmask =3D ~(l2 - 1);</span><br><span>@@ -854,6 +855,7=
 @@</span><br><span>                 r6-&gt;gateway =3D rl6-&gt;rgi6=2Egate=
way=2Eaddr_ipv6;</span><br><span>             }</span><br><span>           =
  r6-&gt;metric =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            r6-&gt;table_id =3D -1;</span><br><span> #ifdef _WIN32</span=
><br><span>             r6-&gt;adapter_index =3D rl6-&gt;rgi6=2Eadapter_ind=
ex;</span><br><span> #else</span><br><span>@@ -883,6 +885,7 @@</span><br><s=
pan>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><spa=
n>     r=2Eflags =3D RT_DEFINED;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    r=2Etable_id =3D -1;</span><br><span>     r=2Enetwork =3D =
network;</span><br><span>     r=2Enetmask =3D netmask;</span><br><span>    =
 r=2Egateway =3D gateway;</span><br><span>@@ -897,6 +900,7 @@</span><br><sp=
an>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span=
>     r=2Eflags =3D RT_DEFINED | RT_ADDED;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    r=2Etable_id =3D -1;</span><br><span>     r=2Ene=
twork =3D network;</span><br><span>     r=2Enetmask =3D netmask;</span><br>=
<span>     r=2Egateway =3D gateway;</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networki=
ng=2Ec</span><br><span>index b580d32=2E=2E95019e5 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_networking=2Ec</span><br><span>@@ -112,7 +112,7 @=
@</span><br><span>     }</span><br><span>     printf(&quot;\n&quot;);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, metric);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_route_v4_=
add(NULL, &amp;dst, prefixlen, NULL, iface, -1, metric);</span><br><span> }=
</span><br><span> </span><br><span> static int</span><br><span>@@ -148,7 +1=
48,7 @@</span><br><span>     }</span><br><span>     printf(&quot;\n&quot;);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return net_route_v4_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, 0, metr=
ic);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_=
route_v4_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, -1, metric);</span>=
<br><span> }</span><br><span> </span><br><span> static int</span><br><span>=
@@ -175,7 +175,7 @@</span><br><span>     }</span><br><span>     printf(&quo=
t;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen, NULL, iface=
, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn net_route_v6_add(NULL, &amp;dst, prefixlen, NULL, iface, -1, metric);<=
/span><br><span> }</span><br><span> </span><br><span> static int</span><br>=
<span>@@ -208,7 +208,7 @@</span><br><span>     }</span><br><span>     print=
f(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;=
gw, iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, -=
1, metric);</span><br><span> }</span><br><span> </span><br><span> static vo=
id</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2224?usp=3Demail">change 2224</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08=
ad862597b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2224 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"=
display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--QmWR7W84fG0=--


--===============7396865875372094424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7396865875372094424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7396865875372094424==--


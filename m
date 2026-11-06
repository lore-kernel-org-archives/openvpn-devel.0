Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AD606A329
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RsE0Fl/W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gBmjJEb/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G7sXJYNL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LR8zQw51
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JWcer8KvvuNYyhQ5P4Zoj/KM7NHz8ESfzg0cKf5dkhk=; b=RsE0Fl/WsFrBLa5lyl/gi0fNl/
	9cLSLi0fP0WiirLPsPxgywDZ7RQodhZCdkAWu6JYyoqFp9mzFDvOhQDVyvB3rjumqtBWiDL9OjFuY
	EU8wUsgA5q+TQ6MwQkf/D2/moWlLO7vty+H0vWBvvygZUKd6Oj9FfU3g8oILv+i71RGo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPNpF-00000000248-0wmf;
	Fri, 06 Nov 2026 17:34:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPNpE-00000000242-39kn
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 17:34:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RUCLohpfl6pIfcBe6u7NswmejAMj3R+/ZgNFUJtNZWI=; b=gBmjJEb/XV/PVznEWOwZB7RDQ3
 ftd0ls/moBoMLXbx/UqB/jhFXnZ0gThkJH/VbXvE+1496Gk2uuMg122TIWStRx+4RiM2ddUFJ1fjc
 9lA3lX4kLKIwNLOnA/7CabV9d6NBC2RHIA5vNfdryz2Cgt9TpJuXnFT7Yq8MMOEDzcTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RUCLohpfl6pIfcBe6u7NswmejAMj3R+/ZgNFUJtNZWI=; b=G7sXJYNL3kiX4uU64w+Nt2ixfb
 vRdCdSDkr7+B30r6PMlzu1z6n5OjQRcIo9ko1og/M/hAPHUJTlAp1EjPJthnoYHzdSpS8s19YWUMj
 4Xv7WRjzZdl5F4uEKfhGDoYIb+mKvs5xB1Q3t/K/cN2kk7CzBFfxIC4zaHUGfJac32h8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPNpC-000000000YS-2Y9L for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 17:34:04 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so7644535e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793986436; x=1794591236; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RUCLohpfl6pIfcBe6u7NswmejAMj3R+/ZgNFUJtNZWI=;
 b=LR8zQw51HOaptBdvll9VRARNKpUZAdts+2L4FFF6ALt8foCRFCslVF1iz/bWHLNbOt
 KZZHlioJwdbPTXw8JNQx+RzirVcpQwrEWlGlnQtFMFpy5Pp6tPAPVixDxyGVuku+b7+M
 bLL2uDQazyQxEhOr1/7FDfe0vqbr5EcCcd3PHq85+XfLmFMd4HGcjLqnsplBY685MN8U
 hgR9mIL+bnNgCbSJ7PV8nH6BngtR+POf2JU7qkrHWy6xGFOt01O9d/RUXeAH4eo9hOrc
 HbxX1wl+T/VbClXL9EDWNBhQBwV5bpPzT/McesSHEFadP/IG1T6iSlCVytEcWugT8X3I
 edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986436; x=1794591236;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RUCLohpfl6pIfcBe6u7NswmejAMj3R+/ZgNFUJtNZWI=;
 b=QynmyOPzf00GjQBJq4K0YlWC8ArTfu9m7fEq994HByWmINtsO6c9FHppz4xEybTjh8
 cvZyY2gHGVRAUOkZM2N0VN1WO2dECr+Wb2YmXDZBtuKu0Q/EoEFBZeiy4XmUjaOCuCGl
 leUloJbszFEQjvJvHcTwacczV/SzieNo/+HvmIhZnD45+dslGMW2VRclyiqi2k9JqGVw
 vsBjZr3KPJeQ235SR3TUhv87sKxURqdOBWlMmJsj0Pg35vJmgiCgvXgUms1gFjE9F1IJ
 gYztHaqhbEcLCfTy2sbAB4aRuQso4M04YTU3B2qXcxOU6upErFnOXTgV/B8ycsKC3fFK
 +sbg==
X-Gm-Message-State: APuU4Z/sScSh/J2hmzNGMioH33d0f2Fis8Rr/4DantlgA4Jiif2a8/If
 FT/XRHbDrDUKXkgWiD/oPdP6MgKbbgaFQNMmiRfYLOYAq7TbHxVp2x1IxS4/YlSacxIAjrPfImx
 iZNwm8ZeuyKaM3eqHyFqUIaXdbfvVo8ZCGU2FX4Dd/A6DS9aT6Lze2uAl0mhI5G0mFHLX2mTv2i
 zOJV3U0A==
X-Gm-Gg: AYBFou11hr3AwpKeaP9UD6e9md2XA0gYUIVsNH3WWJz7yxpaJdtRgwm7KfC81DTWUaS
 018JQHIPuThDhCqIK6+9jHGi4ao2IXQkuPLw9+3A3JwC//SVWQX5XJA+raiX1KIi8NQjEV1xlo3
 j2CjaLk641S226lNGdGW8HC4Wvcmy4x5b506pYfPARWOHacAzB4t7ap2ktAEsF+sBJf9hCkWOZV
 j7L/Y3B31hWo4URelzJvTODL48qnWN27fCcm0qL0T9EJD1NSylguOi0o4mlP9H2QBSvqLEmsHUi
 2/xzGUHjjCwkz2CLua+jRLgaLs1WYjNxf+LZT6hkpccsRSdqVZflA9K3sjK1WViXmdbtxPY6xeh
 vYrmK7z2jh1wp+kdMXkdKH/3SiljZFUUIMrkarKSYsk7HRsfRl1Qg5tc3/O46De3+HHwj4Hce43
 pNAqZwdkUR1ETOgZfZwP9dkbEC8BGKtduAs+FsLwMYSgC386In69OJAOelcqjGavVlajwblKp8C
 HIFrxjEVjC+2yYx4KBLXE3hrNXe/NpGW8FVUSO0tlO36hccHMdmVptnfXOPJXKNI1TNz/lRW3lY
 iWhAq3EtYlrFweQ1F16zio0aR4QDNRUOSnjoUcY+KNXUy6FJ+5Bu9/9m1k+ydP2zrR9nBpC1eyV
 Wbb0UZ+wLvmFuMRyvXBIkn0JEqk2BD2zdR4Nft4lxERVT1hXRnag3ZswuePTWPWTO7Kh4kPVgIp
 WAU++qU93E8XWIUQ==
X-Received: by 2002:a05:600d:82e2:b0:4a2:18d4:f9e0 with SMTP id
 5b1f17b1804b1-4b6df6deffbmr57704015e9.25.1793986435756; 
 Fri, 06 Nov 2026 09:33:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm1724835e9.4.2026.11.06.09.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:33:55 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 17:33:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 612c2203b19d58de952b65d0a1860487dc7e00c6
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a111b7d89d8836240ce2545bd0650f9ba249544a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPNpC-000000000YS-2Y9L
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3792573058565631401=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3792573058565631401==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BKhgW71JfQQ="; charset=UTF-8

--BKhgW71JfQQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Gert Doering


Change subject: Move gc from openvpn_net_ctx_t to=
 local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Move gc from openvpn_net_ctx_t to local variables

All the iproute2 fu=
nctions use the gc only to create local variables
and strings to ultimately=
 pass to openvpn_execve_check=2E These do not
need to live longer than the =
function that calls openvpn_execve_check=2E

Since argv already has a gc an=
d the variables are used for the
command construction with that argv, just =
use the gc of that local
argv=2E

Change-Id: I494a427924ea501382275ea96ef85=
a6abcd780e5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2105
Message-Id: <20261106131044=2E16659-1-gert@greenie=2Emu=
c=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261106131044=2E166=
59-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emu=
c=2Ede>
---
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_=
iproute2=2Eh
2 files changed, 17 insertions(+), 20 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2105/3

diff -=
-git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute=
2=2Ec
index f091fb3=2E=2E7a0f4f7 100644
--- a/src/openvpn/networking_iprout=
e2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -43,21 +43,19 @@
     {=

         ctx->es =3D c->es;
     }
-    ctx->gc =3D gc_new();
-
     retur=
n 0;
 }
 
 void
 net_ctx_reset(openvpn_net_ctx_t *ctx)
 {
-    gc_reset(&ct=
x->gc);
+    (void)ctx;
 }
 
 void
 net_ctx_free(openvpn_net_ctx_t *ctx)
 {=

-    gc_free(&ctx->gc);
+    (void)ctx;
 }
 
 int
@@ -148,7 +146,7 @@
 {
 =
    struct argv argv =3D argv_new();
 
-    const char *addr_str =3D print_=
in_addr_t(*addr, 0, &ctx->gc);
+    const char *addr_str =3D print_in_addr_=
t(*addr, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s addr add dev %s %s/%=
d broadcast +", iproute_path, iface, addr_str, prefixlen);
     argv_msg(M_=
INFO, &argv);
@@ -164,7 +162,7 @@
                 int prefixlen)
 {
     s=
truct argv argv =3D argv_new();
-    char *addr_str =3D (char *)print_in6_a=
ddr(*addr, 0, &ctx->gc);
+    char *addr_str =3D (char *)print_in6_addr(*ad=
dr, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s -6 addr add %s/%d dev %s"=
, iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
=
@@ -179,7 +177,7 @@
 net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *if=
ace, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv =3D arg=
v_new();
-    const char *addr_str =3D print_in_addr_t(*addr, 0, &ctx->gc);=

+    const char *addr_str =3D print_in_addr_t(*addr, 0, &argv=2Egc);
 
   =
  argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface, addr_=
str, prefixlen);
 
@@ -196,7 +194,7 @@
                 int prefixlen)
 {
 =
    struct argv argv =3D argv_new();
-    char *addr_str =3D (char *)print_=
in6_addr(*addr, 0, &ctx->gc);
+    char *addr_str =3D (char *)print_in6_add=
r(*addr, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s -6 addr del %s/%d de=
v %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &ar=
gv);
@@ -212,8 +210,8 @@
                     const in_addr_t *remote)
 {
 =
    struct argv argv =3D argv_new();
-    const char *local_str =3D print_i=
n_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str =3D print_in_add=
r_t(*remote, 0, &ctx->gc);
+    const char *local_str =3D print_in_addr_t(*=
local, 0, &argv=2Egc);
+    const char *remote_str =3D print_in_addr_t(*rem=
ote, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s addr add dev %s local %s=
 peer %s", iproute_path, iface, local_str,
                 remote_str);
@@=
 -230,8 +228,8 @@
                     const in_addr_t *remote)
 {
     str=
uct argv argv =3D argv_new();
-    const char *local_str =3D print_in_addr_=
t(*local, 0, &ctx->gc);
-    const char *remote_str =3D print_in_addr_t(*re=
mote, 0, &ctx->gc);
+    const char *local_str =3D print_in_addr_t(*local, =
0, &argv=2Egc);
+    const char *remote_str =3D print_in_addr_t(*remote, 0,=
 &argv=2Egc);
 
     argv_printf(&argv, "%s addr del dev %s local %s peer %=
s", iproute_path, iface, local_str,
                 remote_str);
@@ -248,7=
 +246,7 @@
                  const char *iface, uint32_t table, int metric)=

 {
     struct argv argv =3D argv_new();
-    const char *dst_str =3D prin=
t_in_addr_t(*dst, 0, &ctx->gc);
+    const char *dst_str =3D print_in_addr_=
t(*dst, 0, &argv=2Egc);
     int ret =3D 0;
 
     argv_printf(&argv, "%s r=
oute add %s/%d", iproute_path, dst_str, prefixlen);
@@ -265,7 +263,7 @@
 
 =
    if (gw)
     {
-        const char *gw_str =3D print_in_addr_t(*gw, 0, =
&ctx->gc);
+        const char *gw_str =3D print_in_addr_t(*gw, 0, &argv=2E=
gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -286,14=
 +284,14 @@
                  const struct in6_addr *gw, const char *iface,=
 uint32_t table, int metric)
 {
     struct argv argv =3D argv_new();
-    =
char *dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    char *dst=
_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
     int ret =3D 0;
 =

     argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_=
str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str =3D (ch=
ar *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str =3D (char *)pr=
int_in6_addr(*gw, 0, &argv=2Egc);
 
         argv_printf_cat(&argv, "via %s=
", gw_str);
     }
@@ -319,7 +317,7 @@
                  const char *iface,=
 uint32_t table, int metric)
 {
     struct argv argv =3D argv_new();
-    =
const char *dst_str =3D print_in_addr_t(*dst, 0, &ctx->gc);
+    const char=
 *dst_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
     int ret =3D 0;
 
 =
    argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixl=
en);
@@ -345,14 +343,14 @@
                  const struct in6_addr *gw, con=
st char *iface, uint32_t table, int metric)
 {
     struct argv argv =3D ar=
gv_new();
-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);=

+    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
     i=
nt ret =3D 0;
 
     argv_printf(&argv, "%s -6 route del %s/%d dev %s", ipr=
oute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char =
*gw_str =3D (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str=
 =3D (char *)print_in6_addr(*gw, 0, &argv=2Egc);
 
         argv_printf_cat=
(&argv, "via %s", gw_str);
     }
diff --git a/src/openvpn/networking_iprou=
te2=2Eh b/src/openvpn/networking_iproute2=2Eh
index dd7d8b3=2E=2Edac5f0d 10=
0644
--- a/src/openvpn/networking_iproute2=2Eh
+++ b/src/openvpn/networking=
_iproute2=2Eh
@@ -28,7 +28,6 @@
 struct openvpn_net_ctx
 {
     struct env_=
set *es;
-    struct gc_arena gc;
 };
 
 typedef struct openvpn_net_ctx ope=
nvpn_net_ctx_t;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2105?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I494a427924ea501382275ea96ef85a6abcd780e5
Gerrit-Change-Number: 2105
Gerri=
t-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>

--BKhgW71JfQQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
5?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">Move gc fro=
m openvpn_net_ctx_t to local variables<br><br>All the iproute2 functions us=
e the gc only to create local variables<br>and strings to ultimately pass t=
o openvpn_execve_check=2E These do not<br>need to live longer than the func=
tion that calls openvpn_execve_check=2E<br><br>Since argv already has a gc =
and the variables are used for the<br>command construction with that argv, =
just use the gc of that local<br>argv=2E<br><br>Change-Id: I494a427924ea501=
382275ea96ef85a6abcd780e5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105<br>Message-Id: &lt=
;20261106131044=2E16659-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20261106131044=2E16659-1-gert@greenie=2Emuc=
=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---=
<br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networking_iprou=
te2=2Eh<br>2 files changed, 17 insertions(+), 20 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/05/2105/3</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/sr=
c/openvpn/networking_iproute2=2Ec</span><br><span>index f091fb3=2E=2E7a0f4f=
7 100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><b=
r><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -43,21=
 +43,19 @@</span><br><span>     {</span><br><span>         ctx-&gt;es =3D c=
-&gt;es;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ctx-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     return 0;</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span> net_ctx_reset(openvpn_net=
_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    gc_reset(&amp;ctx-&gt;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    (void)ctx;</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span> net_ctx_free(openvpn_net_ctx_t *ctx)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    (void)ctx;</span><br><span> }</span><br><span> </span><br><span> =
int</span><br><span>@@ -148,7 +146,7 @@</span><br><span> {</span><br><span>=
     struct argv argv =3D argv_new();</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const char *addr_str =3D print_in_add=
r_t(*addr, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *addr_str =3D print_in_addr_t(*addr, 0, &amp;arg=
v=2Egc);</span><br><span> </span><br><span>     argv_printf(&amp;argv, &quo=
t;%s addr add dev %s %s/%d broadcast +&quot;, iproute_path, iface, addr_str=
, prefixlen);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><=
span>@@ -164,7 +162,7 @@</span><br><span>                 int prefixlen)</s=
pan><br><span> {</span><br><span>     struct argv argv =3D argv_new();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *addr_str =3D (ch=
ar *)print_in6_addr(*addr, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    char *addr_str =3D (char *)print_in6_addr(*=
addr, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>     argv_print=
f(&amp;argv, &quot;%s -6 addr add %s/%d dev %s&quot;, iproute_path, addr_st=
r, prefixlen, iface);</span><br><span>     argv_msg(M_INFO, &amp;argv);</sp=
an><br><span>@@ -179,7 +177,7 @@</span><br><span> net_addr_v4_del(openvpn_n=
et_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)</sp=
an><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *addr_str =
=3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *addr_str =3D print_in_addr_t(*a=
ddr, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>     argv_printf=
(&amp;argv, &quot;%s addr del dev %s %s/%d&quot;, iproute_path, iface, addr=
_str, prefixlen);</span><br><span> </span><br><span>@@ -196,7 +194,7 @@</sp=
an><br><span>                 int prefixlen)</span><br><span> {</span><br><=
span>     struct argv argv =3D argv_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    char *addr_str =3D (char *)print_in6_addr(*addr, 0=
, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    char *addr_str =3D (char *)print_in6_addr(*addr, 0, &amp;argv=2Egc);</s=
pan><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s -6 add=
r del %s/%d dev %s&quot;, iproute_path, addr_str, prefixlen, iface);</span>=
<br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>@@ -212,8 +210,=
8 @@</span><br><span>                     const in_addr_t *remote)</span><b=
r><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const char *local_str =3D pr=
int_in_addr_t(*local, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const char *remote_str =3D print_in_addr_t(*remote=
, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *local_str =3D print_in_addr_t(*local, 0, &amp;argv=2Egc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *re=
mote_str =3D print_in_addr_t(*remote, 0, &amp;argv=2Egc);</span><br><span> =
</span><br><span>     argv_printf(&amp;argv, &quot;%s addr add dev %s local=
 %s peer %s&quot;, iproute_path, iface, local_str,</span><br><span>        =
         remote_str);</span><br><span>@@ -230,8 +228,8 @@</span><br><span> =
                    const in_addr_t *remote)</span><br><span> {</span><br><=
span>     struct argv argv =3D argv_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const char *local_str =3D print_in_addr_t(*local, =
0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const char *remote_str =3D print_in_addr_t(*remote, 0, &amp;ctx-&gt;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *loc=
al_str =3D print_in_addr_t(*local, 0, &amp;argv=2Egc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *remote_str =3D print_in_=
addr_t(*remote, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>     =
argv_printf(&amp;argv, &quot;%s addr del dev %s local %s peer %s&quot;, ipr=
oute_path, iface, local_str,</span><br><span>                 remote_str);<=
/span><br><span>@@ -248,7 +246,7 @@</span><br><span>                  const=
 char *iface, uint32_t table, int metric)</span><br><span> {</span><br><spa=
n>     struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const char *dst_str =3D print_in_addr_t(*dst, 0, &amp=
;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *dst_str =3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><=
span>     int ret =3D 0;</span><br><span> </span><br><span>     argv_printf=
(&amp;argv, &quot;%s route add %s/%d&quot;, iproute_path, dst_str, prefixle=
n);</span><br><span>@@ -265,7 +263,7 @@</span><br><span> </span><br><span> =
    if (gw)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const char *gw_str =3D print_in_addr_t(*gw, 0, &amp;ct=
x-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst char *gw_str =3D print_in_addr_t(*gw, 0, &amp;argv=2Egc);</span><br><s=
pan> </span><br><span>         argv_printf_cat(&amp;argv, &quot;via %s&quot=
;, gw_str);</span><br><span>     }</span><br><span>@@ -286,14 +284,14 @@</s=
pan><br><span>                  const struct in6_addr *gw, const char *ifac=
e, uint32_t table, int metric)</span><br><span> {</span><br><span>     stru=
ct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;ctx-&gt;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *dst_st=
r =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><br><span>    =
 int ret =3D 0;</span><br><span> </span><br><span>     argv_printf(&amp;arg=
v, &quot;%s -6 route add %s/%d dev %s&quot;, iproute_path, dst_str, prefixl=
en, iface);</span><br><span> </span><br><span>     if (gw)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *g=
w_str =3D (char *)print_in6_addr(*gw, 0, &amp;ctx-&gt;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        char *gw_str =3D (char *)pri=
nt_in6_addr(*gw, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>    =
     argv_printf_cat(&amp;argv, &quot;via %s&quot;, gw_str);</span><br><spa=
n>     }</span><br><span>@@ -319,7 +317,7 @@</span><br><span>              =
    const char *iface, uint32_t table, int metric)</span><br><span> {</span=
><br><span>     struct argv argv =3D argv_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *dst_str =3D print_in_addr_t(*dst=
, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *dst_str =3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</s=
pan><br><span>     int ret =3D 0;</span><br><span> </span><br><span>     ar=
gv_printf(&amp;argv, &quot;%s route del %s/%d&quot;, iproute_path, dst_str,=
 prefixlen);</span><br><span>@@ -345,14 +343,14 @@</span><br><span>        =
          const struct in6_addr *gw, const char *iface, uint32_t table, int=
 metric)</span><br><span> {</span><br><span>     struct argv argv =3D argv_=
new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *dst_s=
tr =3D (char *)print_in6_addr(*dst, 0, &amp;ctx-&gt;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *dst_str =3D (char *)print_in=
6_addr(*dst, 0, &amp;argv=2Egc);</span><br><span>     int ret =3D 0;</span>=
<br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s -6 route d=
el %s/%d dev %s&quot;, iproute_path, dst_str, prefixlen, iface);</span><br>=
<span> </span><br><span>     if (gw)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        char *gw_str =3D (char *)prin=
t_in6_addr(*gw, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *gw_str =3D (char *)print_in6_addr(*gw, 0, &a=
mp;argv=2Egc);</span><br><span> </span><br><span>         argv_printf_cat(&=
amp;argv, &quot;via %s&quot;, gw_str);</span><br><span>     }</span><br><sp=
an>diff --git a/src/openvpn/networking_iproute2=2Eh b/src/openvpn/networkin=
g_iproute2=2Eh</span><br><span>index dd7d8b3=2E=2Edac5f0d 100644</span><br>=
<span>--- a/src/openvpn/networking_iproute2=2Eh</span><br><span>+++ b/src/o=
penvpn/networking_iproute2=2Eh</span><br><span>@@ -28,7 +28,6 @@</span><br>=
<span> struct openvpn_net_ctx</span><br><span> {</span><br><span>     struc=
t env_set *es;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct gc_arena gc;</span><br><span> };</span><br><span> </span><br><span> typ=
edef struct openvpn_net_ctx openvpn_net_ctx_t;</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demai=
l">change 2105</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2105?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2105 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--BKhgW71JfQQ=--


--===============3792573058565631401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3792573058565631401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3792573058565631401==--


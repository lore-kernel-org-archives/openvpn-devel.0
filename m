Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7999606A32F
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mi0+LjVU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ijaH3JCC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l5X02P7F;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IKzQUkZu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pj5kKzfweYrLsoZJkRtBw7GE1cG2wN4mHxeGLBMDgMM=; b=Mi0+LjVUci5laudICjb0iEXXjt
	q9WqCTYa+14/JTqXZWGwbtvm2p4chr5qdVkLspWDKoriE69A3w9SGdIhMHHLK9E658kP7IgkQUFTa
	SJ/YQ61tkCf6Svtq2gtSjoWZDB2oQHWK4D2409mbDPgMOUA5hzzMmR7vY5bYDhwcUrP8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPNpI-000000008Sb-2QW1;
	Fri, 06 Nov 2026 17:34:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPNpG-000000008SI-2glw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 17:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C7mJzSX60nJU/wOmPkZChS2PCpAGRbA3pNDwORF/xbE=; b=ijaH3JCC5jqr/mbbjCiLJVk+3D
 qs8x3b2Prl0TPXG2gIm5TTFs+6KCX4KTOu7fSKAHe+1Hr5DPmypIVI9LcEJSZSscHligQzVOgSQTc
 yxOoBbGFo0Gdt5K0VZ1Q7Ir6kLKEFvaAMqx80TLpg1MbuEo0iPXVN5mdMkwlHRwEz2X0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C7mJzSX60nJU/wOmPkZChS2PCpAGRbA3pNDwORF/xbE=; b=l5X02P7FNtKvt0Tez2o/9jXx+8
 7E19xMzIyy4Ejn/EfU4Y/D48bB5fCUodSG4xlmcpCSjuZYYh6tglBhDHh6y3Dug8suf+jPYgkipsV
 //h7s7F/MtOvTxNSyNTIt2PEXMCRy2BGcd0hM/JfP0ByTZClAXKh9QtlEyn0a/zkBO/M=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPNpE-000000000YV-3kqN for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 17:34:06 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso6233905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793986438; x=1794591238; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C7mJzSX60nJU/wOmPkZChS2PCpAGRbA3pNDwORF/xbE=;
 b=IKzQUkZumOeOKgba+ySLcqsHjalReWlBjefoVUJ2hxVl8HnFoej/yk/GpJcimJrn3f
 n+8S4BEJ/gn/xZhuCm2Wigu1Jpmlzqohro0zfzh6DLVRICv3zBh3HD98dqKjOD7UUc6O
 HSY6thc2xeA4IPjNkT/emuNCM4OetGLGWQnhWY6r6tiHZHuxXah6jdbhBpo1q472ZvXM
 HYewzl0pQPNlOiEoFtxpn0vgQ4KpMVCcjxlcwwbDIqfNxjTKUE6qfHwq1uz6ZgUcRCgl
 mlpNvrhyl2Ig2sYOpe0okRL3rQ9Oqk1Ye4T4qiNkBpFYHUzE0TlzJu5qsj1QRDLeMAhm
 ZzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986438; x=1794591238;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=C7mJzSX60nJU/wOmPkZChS2PCpAGRbA3pNDwORF/xbE=;
 b=dr4RcSkIWGKF3a7IsBRZDKZRw+qBFAqSwhaFkkI3WMYi9c1a5csVVGbqBGJQRysFaZ
 Y/KBdM4DsPwyW0flBFXd49BiofHMK6My1RYwDvnErHtPkTHty3EBt+BhotPK8DZ6JadK
 51JWOLa0e6QpNBsxDfz5gw86/MJ495dFVFE6vb7gV+juZmafk+gTwiyWNmxVYZe7dSI1
 BbUKiw6+wcJLdm1ucjTUGaFDOdJMAju7nfOWC/iWwd4dvF5Pb8m4OfKxqT3wcHPViG62
 PTh/Y1DKgJJGUaV+nGfdUFXNFZflq82sSbbop8YH1I1LJYMXmAxw/ZL0hGsPbWQpGFIw
 7TiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7QsW0QKut6jpW4c7OzRoB8eucvGu/bW6H3MtA8dINUiFILizUWg89sZMX9CMH9N4fWcGBipg/tHHEDVb9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z82Ddt+arMGcakZn+UQD18zhijkWuRtzlU0AWoJD6ST+meV3ULH
 HGMObK/qzQDIqJp0INcDlzIQQhNFak1dqv+9BPlxQN7iuy8W6BPTwo5Gt3ekshPT/teL/3yrCxX
 gWtJ7188Ia8wDJtWeiqT/MWHObVwxvVuR8EjwKWBTkRoUo0A3lW1mB50luUrEV+yJj+7P
X-Gm-Gg: AYBFou08tb+8+C5OTf3TL+1q3UZ2Nc6C5HQ3zBk4BH2fx6bb6qkBtEGTM4m3k6LA9Dz
 Gowgunzg2TA6UDs2dNEuhdF/HWKJZ5y6EJ1qXGMorUTT9iZKpHHki34fDHPcpPhb0+7GMWGo43u
 rLLU8R8t04LSMhcpy8W7kfML5xV85tRiEzjrqcS2FuGtBwbNtbbFdPLjR5BK434/D+b/QKhnicv
 pEtMR5i9z+zl/8gk+Hk6fzeAylNtnJ4dThfhyTacYIIYC/Dvt06fLGcM83JqhucCz8kB8qNooXr
 ukXRwaPUrB/u9rjcOGRY7dLUIxlPbmogQiTKp4cYYF18qBuX3KoLzijUSgpwOoG1PGtxxoRrV29
 huz4p9BxCl0tkj/AJIBBCTWQrXbVSE/vPl2jCKLBPUPRudKAZCkwcyBLXVgZtVyETs9k59P5Ane
 tBB/5hrpTAWPEDqktkXa4d4SLEOyqXdoDRXcuormpHplhedapzE8ubxaAyOM2VXa2UxHbZkUers
 DGWIOlgwNdQeto83kqKIG6w0kA8dM+ynur6LCcvXaMaZNSzxHAdA9c7pxGyCg9wyUruJqSsxdXh
 rG3W73PE5/VJ2KNuylxkOXI8bj1y766wIAtuk8QfXJKR/MYACgdiGqWYLSvwSwMIcSrpAaLS9vW
 4My8PrRQgm0nHp4QuNsLmPSW+rVNPvvolLKopJEoqGnqnTRDYTOj0O3v4iaVt1CsBcfxTyLBG6o
 Vdqt6kNO3nYJLBvw==
X-Received: by 2002:a05:600c:6388:b0:4af:79ee:f660 with SMTP id
 5b1f17b1804b1-4b6e091ed9fmr57619515e9.31.1793986438143; 
 Fri, 06 Nov 2026 09:33:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795012503sm1387705e9.2.2026.11.06.09.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:33:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 17:33:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 612c2203b19d58de952b65d0a1860487dc7e00c6
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a111b7d89d8836240ce2545bd0650f9ba249544a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPNpE-000000000YV-3kqN
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
Content-Type: multipart/mixed; boundary="===============1197595625299591659=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1197595625299591659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RgqL+cfVSp4="; charset=UTF-8

--RgqL+cfVSp4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2105?usp=3Demail )

Change subject: Move gc from openvpn_net_ct=
x_t to local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Move gc from openvpn_net_ctx_t to local variables

All the iprou=
te2 functions use the gc only to create local variables
and strings to ulti=
mately pass to openvpn_execve_check=2E These do not
need to live longer tha=
n the function that calls openvpn_execve_check=2E

Since argv already has a=
 gc and the variables are used for the
command construction with that argv,=
 just use the gc of that local
argv=2E

Change-Id: I494a427924ea501382275ea=
96ef85a6abcd780e5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2105
Message-Id: <20261106131044=2E16659-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261106131044=
=2E16659-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
---
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/netwo=
rking_iproute2=2Eh
2 files changed, 17 insertions(+), 20 deletions(-)




d=
iff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_ip=
route2=2Ec
index f091fb3=2E=2E7a0f4f7 100644
--- a/src/openvpn/networking_i=
proute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -43,21 +43,19 @@
 =
    {
         ctx->es =3D c->es;
     }
-    ctx->gc =3D gc_new();
-
     =
return 0;
 }
 
 void
 net_ctx_reset(openvpn_net_ctx_t *ctx)
 {
-    gc_rese=
t(&ctx->gc);
+    (void)ctx;
 }
 
 void
 net_ctx_free(openvpn_net_ctx_t *ct=
x)
 {
-    gc_free(&ctx->gc);
+    (void)ctx;
 }
 
 int
@@ -148,7 +146,7 @@=

 {
     struct argv argv =3D argv_new();
 
-    const char *addr_str =3D p=
rint_in_addr_t(*addr, 0, &ctx->gc);
+    const char *addr_str =3D print_in_=
addr_t(*addr, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s addr add dev %s=
 %s/%d broadcast +", iproute_path, iface, addr_str, prefixlen);
     argv_m=
sg(M_INFO, &argv);
@@ -164,7 +162,7 @@
                 int prefixlen)
 {
 =
    struct argv argv =3D argv_new();
-    char *addr_str =3D (char *)print_=
in6_addr(*addr, 0, &ctx->gc);
+    char *addr_str =3D (char *)print_in6_add=
r(*addr, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s -6 addr add %s/%d de=
v %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &ar=
gv);
@@ -179,7 +177,7 @@
 net_addr_v4_del(openvpn_net_ctx_t *ctx, const cha=
r *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv =
=3D argv_new();
-    const char *addr_str =3D print_in_addr_t(*addr, 0, &ct=
x->gc);
+    const char *addr_str =3D print_in_addr_t(*addr, 0, &argv=2Egc)=
;
 
     argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface=
, addr_str, prefixlen);
 
@@ -196,7 +194,7 @@
                 int prefixle=
n)
 {
     struct argv argv =3D argv_new();
-    char *addr_str =3D (char *=
)print_in6_addr(*addr, 0, &ctx->gc);
+    char *addr_str =3D (char *)print_=
in6_addr(*addr, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s -6 addr del %=
s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_IN=
FO, &argv);
@@ -212,8 +210,8 @@
                     const in_addr_t *remot=
e)
 {
     struct argv argv =3D argv_new();
-    const char *local_str =3D =
print_in_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str =3D print=
_in_addr_t(*remote, 0, &ctx->gc);
+    const char *local_str =3D print_in_a=
ddr_t(*local, 0, &argv=2Egc);
+    const char *remote_str =3D print_in_addr=
_t(*remote, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s addr add dev %s l=
ocal %s peer %s", iproute_path, iface, local_str,
                 remote_s=
tr);
@@ -230,8 +228,8 @@
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
 
     argv_printf(&argv, "%s addr del dev %s local %s=
 peer %s", iproute_path, iface, local_str,
                 remote_str);
@@=
 -248,7 +246,7 @@
                  const char *iface, uint32_t table, int =
metric)
 {
     struct argv argv =3D argv_new();
-    const char *dst_str =
=3D print_in_addr_t(*dst, 0, &ctx->gc);
+    const char *dst_str =3D print_=
in_addr_t(*dst, 0, &argv=2Egc);
     int ret =3D 0;
 
     argv_printf(&arg=
v, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
@@ -265,7 +263,=
7 @@
 
     if (gw)
     {
-        const char *gw_str =3D print_in_addr_t(=
*gw, 0, &ctx->gc);
+        const char *gw_str =3D print_in_addr_t(*gw, 0, =
&argv=2Egc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@=
 -286,14 +284,14 @@
                  const struct in6_addr *gw, const char=
 *iface, uint32_t table, int metric)
 {
     struct argv argv =3D argv_new(=
);
-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    c=
har *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
     int ret =
=3D 0;
 
     argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_pa=
th, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str=
 =3D (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str =3D (c=
har *)print_in6_addr(*gw, 0, &argv=2Egc);
 
         argv_printf_cat(&argv,=
 "via %s", gw_str);
     }
@@ -319,7 +317,7 @@
                  const char=
 *iface, uint32_t table, int metric)
 {
     struct argv argv =3D argv_new(=
);
-    const char *dst_str =3D print_in_addr_t(*dst, 0, &ctx->gc);
+    co=
nst char *dst_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
     int ret =
=3D 0;
 
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_st=
r, prefixlen);
@@ -345,14 +343,14 @@
                  const struct in6_add=
r *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv a=
rgv =3D argv_new();
-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, =
&ctx->gc);
+    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Eg=
c);
     int ret =3D 0;
 
     argv_printf(&argv, "%s -6 route del %s/%d de=
v %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-   =
     char *gw_str =3D (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        ch=
ar *gw_str =3D (char *)print_in6_addr(*gw, 0, &argv=2Egc);
 
         argv_=
printf_cat(&argv, "via %s", gw_str);
     }
diff --git a/src/openvpn/networ=
king_iproute2=2Eh b/src/openvpn/networking_iproute2=2Eh
index dd7d8b3=2E=2E=
dac5f0d 100644
--- a/src/openvpn/networking_iproute2=2Eh
+++ b/src/openvpn/=
networking_iproute2=2Eh
@@ -28,7 +28,6 @@
 struct openvpn_net_ctx
 {
     s=
truct env_set *es;
-    struct gc_arena gc;
 };
 
 typedef struct openvpn_n=
et_ctx openvpn_net_ctx_t;

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2105?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I494a427924ea501382275ea96ef85a6abcd780e5
Gerrit-Change-Number: 2105
=
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--RgqL+cfVSp4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2105?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Move gc from openvpn_net_ctx_t to =
local variables<br><br>All the iproute2 functions use the gc only to create=
 local variables<br>and strings to ultimately pass to openvpn_execve_check=
=2E These do not<br>need to live longer than the function that calls openvp=
n_execve_check=2E<br><br>Since argv already has a gc and the variables are =
used for the<br>command construction with that argv, just use the gc of tha=
t local<br>argv=2E<br><br>Change-Id: I494a427924ea501382275ea96ef85a6abcd78=
0e5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2105<br>Message-Id: &lt;20261106131044=2E16659=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-=
devel/20261106131044=2E16659-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/networki=
ng_iproute2=2Ec<br>M src/openvpn/networking_iproute2=2Eh<br>2 files changed=
, 17 insertions(+), 20 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br>=
<span>index f091fb3=2E=2E7a0f4f7 100644</span><br><span>--- a/src/openvpn/n=
etworking_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute=
2=2Ec</span><br><span>@@ -43,21 +43,19 @@</span><br><span>     {</span><br>=
<span>         ctx-&gt;es =3D c-&gt;es;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     retur=
n 0;</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span> net_ctx_reset(openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    gc_reset(&amp;ctx-&gt;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)ctx;</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span> net_ctx=
_free(openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    gc_free(&amp;ctx-&gt;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    (void)ctx;</span><br><span> }</spa=
n><br><span> </span><br><span> int</span><br><span>@@ -148,7 +146,7 @@</spa=
n><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *addr_str =3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *addr_str =3D pri=
nt_in_addr_t(*addr, 0, &amp;argv=2Egc);</span><br><span> </span><br><span> =
    argv_printf(&amp;argv, &quot;%s addr add dev %s %s/%d broadcast +&quot;=
, iproute_path, iface, addr_str, prefixlen);</span><br><span>     argv_msg(=
M_INFO, &amp;argv);</span><br><span>@@ -164,7 +162,7 @@</span><br><span>   =
              int prefixlen)</span><br><span> {</span><br><span>     struct=
 argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    char *addr_str =3D (char *)print_in6_addr(*addr, 0, &amp;ctx-&gt;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *addr_s=
tr =3D (char *)print_in6_addr(*addr, 0, &amp;argv=2Egc);</span><br><span> <=
/span><br><span>     argv_printf(&amp;argv, &quot;%s -6 addr add %s/%d dev =
%s&quot;, iproute_path, addr_str, prefixlen, iface);</span><br><span>     a=
rgv_msg(M_INFO, &amp;argv);</span><br><span>@@ -179,7 +177,7 @@</span><br><=
span> net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_a=
ddr_t *addr, int prefixlen)</span><br><span> {</span><br><span>     struct =
argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const char *addr_str =3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ad=
dr_str =3D print_in_addr_t(*addr, 0, &amp;argv=2Egc);</span><br><span> </sp=
an><br><span>     argv_printf(&amp;argv, &quot;%s addr del dev %s %s/%d&quo=
t;, iproute_path, iface, addr_str, prefixlen);</span><br><span> </span><br>=
<span>@@ -196,7 +194,7 @@</span><br><span>                 int prefixlen)</=
span><br><span> {</span><br><span>     struct argv argv =3D argv_new();</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *addr_str =3D (c=
har *)print_in6_addr(*addr, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *addr_str =3D (char *)print_in6_addr(=
*addr, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>     argv_prin=
tf(&amp;argv, &quot;%s -6 addr del %s/%d dev %s&quot;, iproute_path, addr_s=
tr, prefixlen, iface);</span><br><span>     argv_msg(M_INFO, &amp;argv);</s=
pan><br><span>@@ -212,8 +210,8 @@</span><br><span>                     cons=
t in_addr_t *remote)</span><br><span> {</span><br><span>     struct argv ar=
gv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *local_str =3D print_in_addr_t(*local, 0, &amp;ctx-&gt;gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *remote_st=
r =3D print_in_addr_t(*remote, 0, &amp;ctx-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *local_str =3D print_in_ad=
dr_t(*local, 0, &amp;argv=2Egc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *remote_str =3D print_in_addr_t(*remote, 0, &am=
p;argv=2Egc);</span><br><span> </span><br><span>     argv_printf(&amp;argv,=
 &quot;%s addr add dev %s local %s peer %s&quot;, iproute_path, iface, loca=
l_str,</span><br><span>                 remote_str);</span><br><span>@@ -23=
0,8 +228,8 @@</span><br><span>                     const in_addr_t *remote)=
</span><br><span> {</span><br><span>     struct argv argv =3D argv_new();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *local_s=
tr =3D print_in_addr_t(*local, 0, &amp;ctx-&gt;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *remote_str =3D print_in_add=
r_t(*remote, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *local_str =3D print_in_addr_t(*local, 0, &amp=
;argv=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *remote_str =3D print_in_addr_t(*remote, 0, &amp;argv=2Egc);</span>=
<br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s addr del d=
ev %s local %s peer %s&quot;, iproute_path, iface, local_str,</span><br><sp=
an>                 remote_str);</span><br><span>@@ -248,7 +246,7 @@</span>=
<br><span>                  const char *iface, uint32_t table, int metric)<=
/span><br><span> {</span><br><span>     struct argv argv =3D argv_new();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *dst_str =
=3D print_in_addr_t(*dst, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *dst_str =3D print_in_addr_t(*dst=
, 0, &amp;argv=2Egc);</span><br><span>     int ret =3D 0;</span><br><span> =
</span><br><span>     argv_printf(&amp;argv, &quot;%s route add %s/%d&quot;=
, iproute_path, dst_str, prefixlen);</span><br><span>@@ -265,7 +263,7 @@</s=
pan><br><span> </span><br><span>     if (gw)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *gw_str =
=3D print_in_addr_t(*gw, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const char *gw_str =3D print_in_addr_t(*g=
w, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>         argv_prin=
tf_cat(&amp;argv, &quot;via %s&quot;, gw_str);</span><br><span>     }</span=
><br><span>@@ -286,14 +284,14 @@</span><br><span>                  const st=
ruct in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br=
><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    char *dst_str =3D (char *)pri=
nt_in6_addr(*dst, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &a=
mp;argv=2Egc);</span><br><span>     int ret =3D 0;</span><br><span> </span>=
<br><span>     argv_printf(&amp;argv, &quot;%s -6 route add %s/%d dev %s&qu=
ot;, iproute_path, dst_str, prefixlen, iface);</span><br><span> </span><br>=
<span>     if (gw)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        char *gw_str =3D (char *)print_in6_addr(*gw, 0,=
 &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       char *gw_str =3D (char *)print_in6_addr(*gw, 0, &amp;argv=2Egc);</sp=
an><br><span> </span><br><span>         argv_printf_cat(&amp;argv, &quot;vi=
a %s&quot;, gw_str);</span><br><span>     }</span><br><span>@@ -319,7 +317,=
7 @@</span><br><span>                  const char *iface, uint32_t table, i=
nt metric)</span><br><span> {</span><br><span>     struct argv argv =3D arg=
v_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *dst_str =3D print_in_addr_t(*dst, 0, &amp;ctx-&gt;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *dst_str =3D print_in_=
addr_t(*dst, 0, &amp;argv=2Egc);</span><br><span>     int ret =3D 0;</span>=
<br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s route del =
%s/%d&quot;, iproute_path, dst_str, prefixlen);</span><br><span>@@ -345,14 =
+343,14 @@</span><br><span>                  const struct in6_addr *gw, con=
st char *iface, uint32_t table, int metric)</span><br><span> {</span><br><s=
pan>     struct argv argv =3D argv_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &=
amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><=
br><span>     int ret =3D 0;</span><br><span> </span><br><span>     argv_pr=
intf(&amp;argv, &quot;%s -6 route del %s/%d dev %s&quot;, iproute_path, dst=
_str, prefixlen, iface);</span><br><span> </span><br><span>     if (gw)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      char *gw_str =3D (char *)print_in6_addr(*gw, 0, &amp;ctx-&gt;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *gw_str =
=3D (char *)print_in6_addr(*gw, 0, &amp;argv=2Egc);</span><br><span> </span=
><br><span>         argv_printf_cat(&amp;argv, &quot;via %s&quot;, gw_str);=
</span><br><span>     }</span><br><span>diff --git a/src/openvpn/networking=
_iproute2=2Eh b/src/openvpn/networking_iproute2=2Eh</span><br><span>index d=
d7d8b3=2E=2Edac5f0d 100644</span><br><span>--- a/src/openvpn/networking_ipr=
oute2=2Eh</span><br><span>+++ b/src/openvpn/networking_iproute2=2Eh</span><=
br><span>@@ -28,7 +28,6 @@</span><br><span> struct openvpn_net_ctx</span><b=
r><span> {</span><br><span>     struct env_set *es;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc;</span><br><span> };=
</span><br><span> </span><br><span> typedef struct openvpn_net_ctx openvpn_=
net_ctx_t;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2105?usp=3Demail">change 2105</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I494a427924ea501382275e=
a96ef85a6abcd780e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2105 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RgqL+cfVSp4=--


--===============1197595625299591659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1197595625299591659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1197595625299591659==--


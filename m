Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA80606D825
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Aicl+5eb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ga4oskdO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PlK90pNM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=N8P5nw4f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=6IEDihnENWdEmBte+l1fCQMomFTRqIvgnseEaPNkYzk=; b=Aicl+5ebuRsCG1/E2LYbmYTWcP
	xXYWUR1hbvcg009JiML22yb/31ZvVCCkGo2kvKQ5/fqpdgwpwBcvdyCrkMc8DewEu50yWOeh8CCJm
	7t6v3BVJaKHw0474dh6KsN5t6qLEz46WF4C2kWj+2kUG7Hv2NGEHv9/xnY7R4JL9gqGM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODsh-000000002QG-0am7;
	Tue, 03 Nov 2026 12:44:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODsT-000000002Ot-3xRU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oaQB94DM9DVlAgpyv5KaMWKMEUy+RMobrpWW3FuE0Ks=; b=Ga4oskdO8UwppWIH/UHoNI4/90
 Fa5yEike4+AKrQxJ6dHdSR/4u3pBSnnetkkY9ZorApnsSxHUG5jUoTQ6iPvR0U8DopkbTp+785BxV
 kuSvEII7nBn+DcDRRTMhbiIrqasi3gHgc/aYj7XYLi1epU9PJt9//wjbi2Hn0gia7hE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oaQB94DM9DVlAgpyv5KaMWKMEUy+RMobrpWW3FuE0Ks=; b=PlK90pNMqkgKlXMik4Imq2Can1
 Df837KsWjRLTV77q8uLKgZb/2ytpckMIaR8dNLCes3vlitDCmqVJq7n3U+z+HnuM5/JsG5vQUwW3q
 6T7pkjrXmhRw9eE3QjkK+nqiSicU2rtCSPA+H33M9328tiVYusms8uw6+OYyLWVFMVM4=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODsF-000000003ra-3Amh for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:26 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3243946f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793709857; x=1794314657; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oaQB94DM9DVlAgpyv5KaMWKMEUy+RMobrpWW3FuE0Ks=;
 b=N8P5nw4fn3R+CO4gzfX0VHBpEH21YDSmmPdoh1lt8gfgZdSkhLLKVPFkXMQxDSgvWy
 NNHgTssXxrp2JhvnBEJc5b2U+1F8WUDD2zt7D9jbS8UdgOWPHR/ZzU32ggp51cfNcss9
 blUZ/97vXMpwWAoiCBDlJdug8TmnsboZME89PD2x/WVb4ZmV3Pb6zejHucWDNdBYNCye
 +1yMG9HlzHFbeUAEfLmenbJEmMfEzaTrwr2OVRruHj/TcHXjO5v210eiVc0u7JmqipG5
 Y1p//XBI/rbHsfWgAgJ7sfZTLrT1yy0HEomsHwoFcBogprlNmqeRruwbciXY48lSoaZQ
 oclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709857; x=1794314657;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oaQB94DM9DVlAgpyv5KaMWKMEUy+RMobrpWW3FuE0Ks=;
 b=B8BR2CjQRGoAIe5u+Cf/sYsFM1Ztx7XlZ2HdeSWSVZdK2AdP//21tJZmDS0qlnpIFf
 NQzzZKvukNY1ljmY+2IkYNoyYz+Qfb31vHDD1EY/43iHiVWiO5QBk4Zy8N3EHXbfoQHQ
 Hq4pRu2JcqGZl17iEgNvKbFHUz3cwVHKpRjcADye12+9t6S5jB1vufsyApMZMCl+KJgR
 fmMulMnmlV6rBkg3dIF3/i/OFGZ8v9tJkGbNb+E3xOSduY6QlTgKGMjE2iBfzLvHuoyx
 ANXDbZi8ENLTmnR6kfmY9/l7a8EeqDJ+gRvhln9JQtzNcwwUHBRfqUs804Areni29Vz+
 mKWg==
X-Gm-Message-State: APuU4Z+JyAca7lKFoYc6yV0B7q9mC6hfzB2n7cNvsllMk0mKyYXxHN2q
 yYTnsRfhDGucJr6qPeK8mCGvzGwHdgIlkWc8ZsUb4f0oHoidwIw4eMMEZkKFQtUU2QyCsKYB3jJ
 aqDPsDcrPB0FvO4wIqkwpBEB7Xeu37lqnIiU77X7+fLTpM6/3iuWtdNcogQhsWOkgW/lCtB8CYW
 F0HskZiQ==
X-Gm-Gg: AYBFou2MZNQ3DEuh4WgoOoVeM+0exnc0livCjaMUNxbPqybOUJa4pOmCdan+gs9j6wL
 A39EVoGstvHvPje0w+QspC4V5AF/d7z6nqD7sBDHgKxaOhhbnYLPfBTNu+N4wXnCIEQI5DF6ikO
 J/SfKzt4i/HlrwdxVrAOxnOcxWJKAMbsuE4m94Iclb5vzkIrNo+1kvqbeuws0dIWKhx8ekYwV0J
 vLGExhptzWMWUuB6cEvb6Qf32LwcPO/El9Vgna/YEqhyk/hMfhoEqaw3CTmXfnjpIfLuoPblGo5
 lfXUnBGg3S7TaA58Y++eTBIpXY6HWXns+FeKk2nLVZgbKRN2pAsIauNVUZwR3O0YLd2YK/xSaAc
 5jUz25CWqu1ky/nQojrKoKs/hiawH8xuIc2o6iA4D9Vp+dlL+EYv0ObIvsJ9NRksKF3PaVeFKLb
 tyuXts3SJJziO0alJ+m6Ru9MQiwP7L0+DVVY6x/GEdgmdXZG94yzk8atPNSu1U68ocCnUQiBdIR
 9n8A3SoT1CK98FRVptpCGwdru1kINabedLRzTNWKo3EXhfHOMd9ZOY+bzrTHW5KZ3eYaMxFHbQY
 Tjw70MAuStPWAHp8eRB1p8a/hIfdSR+AdqvqwjfCQQWDwniNSQ3E5Wr7BTZn0xApGT+PCBxIjra
 /wbBueSJQzKnSmbJQWg+FSVaYgE4iwJkb718mq2WmEJRX/jQfW6ZobPNODphv76Acsg/L+ogWYT
 1d6Z5qNKm0Va8ACg==
X-Received: by 2002:a05:6000:40c7:b0:48d:f1b3:c02e with SMTP id
 ffacd0b85a97d-48e6e5016f1mr29897844f8f.25.1793709856849; 
 Tue, 03 Nov 2026 04:44:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a7d1sm24816428f8f.38.2026.11.03.04.44.16
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:44:16 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:44:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 8eb4af5adaff4a6f1f9a8801a45c00eac2a2df24
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4711367404b0269cc6c5c4c8ea7cdafc96dfb740-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xODsF-000000003ra-3Amh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move gc from
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6725776468241420803=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6725776468241420803==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bqzm2JrSoX0="; charset=UTF-8

--Bqzm2JrSoX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2105?usp=3Demail )


Change subject: Move gc from ope=
nvpn_net_ctx_t to local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Move gc from openvpn_net_ctx_t to local variables

A=
ll the iproute2 functions use the gc only to create local variables
and str=
ings to ultimately pass to openvpn_execve_check=2E These do not
need to liv=
e longer than the function that calls openvpn_execve_check

Change-Id: I494=
a427924ea501382275ea96ef85a6abcd780e5
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
---
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/network=
ing_iproute2=2Eh
2 files changed, 40 insertions(+), 20 deletions(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2105/1

d=
iff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_ip=
route2=2Ec
index f091fb3=2E=2E4685465 100644
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
@@ -147,13 +145,15 =
@@
 net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_add=
r_t *addr, int prefixlen)
 {
     struct argv argv =3D argv_new();
+    str=
uct gc_arena gc =3D gc_new();
 
-    const char *addr_str =3D print_in_addr=
_t(*addr, 0, &ctx->gc);
+    const char *addr_str =3D print_in_addr_t(*addr=
, 0, &gc);
 
     argv_printf(&argv, "%s addr add dev %s %s/%d broadcast +"=
, iproute_path, iface, addr_str, prefixlen);
     argv_msg(M_INFO, &argv);
=
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add faile=
d");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -164,1=
2 +164,15 @@
                 int prefixlen)
 {
     struct argv argv =3D a=
rgv_new();
-    char *addr_str =3D (char *)print_in6_addr(*addr, 0, &ctx->g=
c);
+    struct gc_arena gc =3D gc_new();
+
+    char *addr_str =3D (char *=
)print_in6_addr(*addr, 0, &gc);
 
     argv_printf(&argv, "%s -6 addr add %=
s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_IN=
FO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip -6=
 addr add failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     retu=
rn 0;
@@ -179,13 +182,16 @@
 net_addr_v4_del(openvpn_net_ctx_t *ctx, const =
char *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv=
 =3D argv_new();
-    const char *addr_str =3D print_in_addr_t(*addr, 0, &c=
tx->gc);
+    struct gc_arena gc =3D gc_new();
+
+    const char *addr_str =
=3D print_in_addr_t(*addr, 0, &gc);
 
     argv_printf(&argv, "%s addr del =
dev %s %s/%d", iproute_path, iface, addr_str, prefixlen);
 
     argv_msg(M=
_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr =
del failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
=
@@ -196,12 +202,15 @@
                 int prefixlen)
 {
     struct argv a=
rgv =3D argv_new();
-    char *addr_str =3D (char *)print_in6_addr(*addr, 0=
, &ctx->gc);
+    struct gc_arena gc =3D gc_new();
+
+    char *addr_str =
=3D (char *)print_in6_addr(*addr, 0, &gc);
 
     argv_printf(&argv, "%s -6=
 addr del %s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     ar=
gv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux =
ip -6 addr del failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
    =
 return 0;
@@ -212,14 +221,16 @@
                     const in_addr_t *remo=
te)
 {
     struct argv argv =3D argv_new();
-    const char *local_str =3D=
 print_in_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str =3D prin=
t_in_addr_t(*remote, 0, &ctx->gc);
+    struct gc_arena gc =3D gc_new();
+ =
   const char *local_str =3D print_in_addr_t(*local, 0, &gc);
+    const ch=
ar *remote_str =3D print_in_addr_t(*remote, 0, &gc);
 
     argv_printf(&ar=
gv, "%s addr add dev %s local %s peer %s", iproute_path, iface, local_str,
=
                 remote_str);
     argv_msg(M_INFO, &argv);
     openvpn_ex=
ecve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
+    gc_=
free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -230,14 +241,16 @@
  =
                   const in_addr_t *remote)
 {
     struct argv argv =3D ar=
gv_new();
-    const char *local_str =3D print_in_addr_t(*local, 0, &ctx->g=
c);
-    const char *remote_str =3D print_in_addr_t(*remote, 0, &ctx->gc);
=
+    struct gc_arena gc =3D gc_new();
+    const char *local_str =3D print_=
in_addr_t(*local, 0, &gc);
+    const char *remote_str =3D print_in_addr_t(=
*remote, 0, &gc);
 
     argv_printf(&argv, "%s addr del dev %s local %s pe=
er %s", iproute_path, iface, local_str,
                 remote_str);
     =
argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linu=
x ip addr del failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     =
return 0;
@@ -248,7 +261,8 @@
                  const char *iface, uint32_t=
 table, int metric)
 {
     struct argv argv =3D argv_new();
-    const cha=
r *dst_str =3D print_in_addr_t(*dst, 0, &ctx->gc);
+    struct gc_arena gc =
=3D gc_new();
+    const char *dst_str =3D print_in_addr_t(*dst, 0, &gc);
 =
    int ret =3D 0;
 
     argv_printf(&argv, "%s route add %s/%d", iproute_=
path, dst_str, prefixlen);
@@ -265,7 +279,7 @@
 
     if (gw)
     {
-     =
   const char *gw_str =3D print_in_addr_t(*gw, 0, &ctx->gc);
+        const=
 char *gw_str =3D print_in_addr_t(*gw, 0, &gc);
 
         argv_printf_cat(=
&argv, "via %s", gw_str);
     }
@@ -276,6 +290,7 @@
         ret =3D -1;
 =
    }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return ret;
@@ -28=
6,14 +301,15 @@
                  const struct in6_addr *gw, const char *if=
ace, uint32_t table, int metric)
 {
     struct argv argv =3D argv_new();
-=
    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    struc=
t gc_arena gc =3D gc_new();
+    char *dst_str =3D (char *)print_in6_addr(*=
dst, 0, &gc);
     int ret =3D 0;
 
     argv_printf(&argv, "%s -6 route ad=
d %s/%d dev %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
 =
    {
-        char *gw_str =3D (char *)print_in6_addr(*gw, 0, &ctx->gc);
+=
        char *gw_str =3D (char *)print_in6_addr(*gw, 0, &gc);
 
         ar=
gv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -309,6 +325,7 @@
        =
 ret =3D -1;
     }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     retu=
rn ret;
@@ -319,7 +336,8 @@
                  const char *iface, uint32_t t=
able, int metric)
 {
     struct argv argv =3D argv_new();
-    const char =
*dst_str =3D print_in_addr_t(*dst, 0, &ctx->gc);
+    struct gc_arena gc =
=3D gc_new();
+    const char *dst_str =3D print_in_addr_t(*dst, 0, &gc);
 =
    int ret =3D 0;
 
     argv_printf(&argv, "%s route del %s/%d", iproute_=
path, dst_str, prefixlen);
@@ -335,6 +353,7 @@
         ret =3D -1;
     }
=
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return ret;
@@ -345,14 +=
364,15 @@
                  const struct in6_addr *gw, const char *iface, u=
int32_t table, int metric)
 {
     struct argv argv =3D argv_new();
-    ch=
ar *dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    struct gc_a=
rena gc =3D gc_new();
+    char *dst_str =3D (char *)print_in6_addr(*dst, 0=
, &gc);
     int ret =3D 0;
 
     argv_printf(&argv, "%s -6 route del %s/%=
d dev %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
=
-        char *gw_str =3D (char *)print_in6_addr(*gw, 0, &ctx->gc);
+      =
  char *gw_str =3D (char *)print_in6_addr(*gw, 0, &gc);
 
         argv_pri=
ntf_cat(&argv, "via %s", gw_str);
     }
@@ -368,6 +388,7 @@
         ret =
=3D -1;
     }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return re=
t;
diff --git a/src/openvpn/networking_iproute2=2Eh b/src/openvpn/networkin=
g_iproute2=2Eh
index dd7d8b3=2E=2Edac5f0d 100644
--- a/src/openvpn/networki=
ng_iproute2=2Eh
+++ b/src/openvpn/networking_iproute2=2Eh
@@ -28,7 +28,6 @@=

 struct openvpn_net_ctx
 {
     struct env_set *es;
-    struct gc_arena g=
c;
 };
 
 typedef struct openvpn_net_ctx openvpn_net_ctx_t;

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6=
abcd780e5
Gerrit-Change-Number: 2105
Gerrit-PatchSet: 1
Gerrit-Owner: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--Bqzm2JrSoX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Move gc from openvpn_net_ctx_t to local variables<br><br>All t=
he iproute2 functions use the gc only to create local variables<br>and stri=
ngs to ultimately pass to openvpn_execve_check=2E These do not<br>need to l=
ive longer than the function that calls openvpn_execve_check<br><br>Change-=
Id: I494a427924ea501382275ea96ef85a6abcd780e5<br>Signed-off-by: Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/networking_iproute2=2E=
c<br>M src/openvpn/networking_iproute2=2Eh<br>2 files changed, 40 insertion=
s(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/05/2105/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span>=
<br><span>index f091fb3=2E=2E4685465 100644</span><br><span>--- a/src/openv=
pn/networking_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_ipr=
oute2=2Ec</span><br><span>@@ -43,21 +43,19 @@</span><br><span>     {</span>=
<br><span>         ctx-&gt;es =3D c-&gt;es;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;gc =3D gc_new();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     r=
eturn 0;</span><br><span> }</span><br><span> </span><br><span> void</span><=
br><span> net_ctx_reset(openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    gc_reset(&amp;ctx-&gt;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)ctx;</spa=
n><br><span> }</span><br><span> </span><br><span> void</span><br><span> net=
_ctx_free(openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;ctx-&gt;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    (void)ctx;</span><br><span> }=
</span><br><span> </span><br><span> int</span><br><span>@@ -147,13 +145,15 =
@@</span><br><span> net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *ifa=
ce, const in_addr_t *addr, int prefixlen)</span><br><span> {</span><br><spa=
n>     struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *addr_s=
tr =3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *addr_str =3D print_in_addr_t=
(*addr, 0, &amp;gc);</span><br><span> </span><br><span>     argv_printf(&am=
p;argv, &quot;%s addr add dev %s %s/%d broadcast +&quot;, iproute_path, ifa=
ce, addr_str, prefixlen);</span><br><span>     argv_msg(M_INFO, &amp;argv);=
</span><br><span>     openvpn_execve_check(&amp;argv, ctx-&gt;es, S_FATAL, =
&quot;Linux ip addr add failed&quot;);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span>=
     argv_free(&amp;argv);</span><br><span> </span><br><span>     return 0;=
</span><br><span>@@ -164,12 +164,15 @@</span><br><span>                 int=
 prefixlen)</span><br><span> {</span><br><span>     struct argv argv =3D ar=
gv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ad=
dr_str =3D (char *)print_in6_addr(*addr, 0, &amp;ctx-&gt;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *addr_str =3D (char *)prin=
t_in6_addr(*addr, 0, &amp;gc);</span><br><span> </span><br><span>     argv_=
printf(&amp;argv, &quot;%s -6 addr add %s/%d dev %s&quot;, iproute_path, ad=
dr_str, prefixlen, iface);</span><br><span>     argv_msg(M_INFO, &amp;argv)=
;</span><br><span>     openvpn_execve_check(&amp;argv, ctx-&gt;es, S_FATAL,=
 &quot;Linux ip -6 addr add failed&quot;);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan>     argv_free(&amp;argv);</span><br><span> </span><br><span>     retur=
n 0;</span><br><span>@@ -179,13 +182,16 @@</span><br><span> net_addr_v4_del=
(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int pref=
ixlen)</span><br><span> {</span><br><span>     struct argv argv =3D argv_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *a=
ddr_str =3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *addr_str =3D print_in_add=
r_t(*addr, 0, &amp;gc);</span><br><span> </span><br><span>     argv_printf(=
&amp;argv, &quot;%s addr del dev %s %s/%d&quot;, iproute_path, iface, addr_=
str, prefixlen);</span><br><span> </span><br><span>     argv_msg(M_INFO, &a=
mp;argv);</span><br><span>     openvpn_execve_check(&amp;argv, ctx-&gt;es, =
0, &quot;Linux ip addr del failed&quot;);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an>     argv_free(&amp;argv);</span><br><span> </span><br><span>     return=
 0;</span><br><span>@@ -196,12 +202,15 @@</span><br><span>                 =
int prefixlen)</span><br><span> {</span><br><span>     struct argv argv =3D=
 argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char =
*addr_str =3D (char *)print_in6_addr(*addr, 0, &amp;ctx-&gt;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char *addr_str =3D (char *)p=
rint_in6_addr(*addr, 0, &amp;gc);</span><br><span> </span><br><span>     ar=
gv_printf(&amp;argv, &quot;%s -6 addr del %s/%d dev %s&quot;, iproute_path,=
 addr_str, prefixlen, iface);</span><br><span>     argv_msg(M_INFO, &amp;ar=
gv);</span><br><span>     openvpn_execve_check(&amp;argv, ctx-&gt;es, 0, &q=
uot;Linux ip -6 addr del failed&quot;);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
>     argv_free(&amp;argv);</span><br><span> </span><br><span>     return 0=
;</span><br><span>@@ -212,14 +221,16 @@</span><br><span>                   =
  const in_addr_t *remote)</span><br><span> {</span><br><span>     struct a=
rgv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const char *local_str =3D print_in_addr_t(*local, 0, &amp;ctx-&gt;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *rem=
ote_str =3D print_in_addr_t(*remote, 0, &amp;ctx-&gt;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *loca=
l_str =3D print_in_addr_t(*local, 0, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *remote_str =3D print_in_addr_t(*=
remote, 0, &amp;gc);</span><br><span> </span><br><span>     argv_printf(&am=
p;argv, &quot;%s addr add dev %s local %s peer %s&quot;, iproute_path, ifac=
e, local_str,</span><br><span>                 remote_str);</span><br><span=
>     argv_msg(M_INFO, &amp;argv);</span><br><span>     openvpn_execve_chec=
k(&amp;argv, ctx-&gt;es, S_FATAL, &quot;Linux ip addr add failed&quot;);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span>     argv_free(&amp;argv);</span><br><spa=
n> </span><br><span>     return 0;</span><br><span>@@ -230,14 +241,16 @@</s=
pan><br><span>                     const in_addr_t *remote)</span><br><span=
> {</span><br><span>     struct argv argv =3D argv_new();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *local_str =3D print_in_=
addr_t(*local, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const char *remote_str =3D print_in_addr_t(*remote, 0, &a=
mp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *local_str =3D print_in_addr_t(*local, 0, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*remote_str =3D print_in_addr_t(*remote, 0, &amp;gc);</span><br><span> </sp=
an><br><span>     argv_printf(&amp;argv, &quot;%s addr del dev %s local %s =
peer %s&quot;, iproute_path, iface, local_str,</span><br><span>            =
     remote_str);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><=
br><span>     openvpn_execve_check(&amp;argv, ctx-&gt;es, 0, &quot;Linux ip=
 addr del failed&quot;);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span>     argv_free=
(&amp;argv);</span><br><span> </span><br><span>     return 0;</span><br><sp=
an>@@ -248,7 +261,8 @@</span><br><span>                  const char *iface,=
 uint32_t table, int metric)</span><br><span> {</span><br><span>     struct=
 argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const char *dst_str =3D print_in_addr_t(*dst, 0, &amp;ctx-&gt;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *dst_str =3D print_in_addr_t(*dst, 0, &amp;gc);</span><br><spa=
n>     int ret =3D 0;</span><br><span> </span><br><span>     argv_printf(&a=
mp;argv, &quot;%s route add %s/%d&quot;, iproute_path, dst_str, prefixlen);=
</span><br><span>@@ -265,7 +279,7 @@</span><br><span> </span><br><span>    =
 if (gw)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        const char *gw_str =3D print_in_addr_t(*gw, 0, &amp;ctx-&=
gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t char *gw_str =3D print_in_addr_t(*gw, 0, &amp;gc);</span><br><span> </spa=
n><br><span>         argv_printf_cat(&amp;argv, &quot;via %s&quot;, gw_str)=
;</span><br><span>     }</span><br><span>@@ -276,6 +290,7 @@</span><br><spa=
n>         ret =3D -1;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span>     argv_free(&amp;argv);</span><br><span> </span><br><span>     re=
turn ret;</span><br><span>@@ -286,14 +301,15 @@</span><br><span>           =
       const struct in6_addr *gw, const char *iface, uint32_t table, int me=
tric)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *dst_str =
=3D (char *)print_in6_addr(*dst, 0, &amp;ctx-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *dst_str =3D (c=
har *)print_in6_addr(*dst, 0, &amp;gc);</span><br><span>     int ret =3D 0;=
</span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s -6 =
route add %s/%d dev %s&quot;, iproute_path, dst_str, prefixlen, iface);</sp=
an><br><span> </span><br><span>     if (gw)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        char *gw_str =3D (char=
 *)print_in6_addr(*gw, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        char *gw_str =3D (char *)print_in6_addr(*gw=
, 0, &amp;gc);</span><br><span> </span><br><span>         argv_printf_cat(&=
amp;argv, &quot;via %s&quot;, gw_str);</span><br><span>     }</span><br><sp=
an>@@ -309,6 +325,7 @@</span><br><span>         ret =3D -1;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span>     argv_free(&amp;argv);</spa=
n><br><span> </span><br><span>     return ret;</span><br><span>@@ -319,7 +3=
36,8 @@</span><br><span>                  const char *iface, uint32_t table=
, int metric)</span><br><span> {</span><br><span>     struct argv argv =3D =
argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *dst_str =3D print_in_addr_t(*dst, 0, &amp;ctx-&gt;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *d=
st_str =3D print_in_addr_t(*dst, 0, &amp;gc);</span><br><span>     int ret =
=3D 0;</span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;=
%s route del %s/%d&quot;, iproute_path, dst_str, prefixlen);</span><br><spa=
n>@@ -335,6 +353,7 @@</span><br><span>         ret =3D -1;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span>     argv_free(&amp;argv);</span=
><br><span> </span><br><span>     return ret;</span><br><span>@@ -345,14 +3=
64,15 @@</span><br><span>                  const struct in6_addr *gw, const=
 char *iface, uint32_t table, int metric)</span><br><span> {</span><br><spa=
n>     struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &am=
p;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;gc);=
</span><br><span>     int ret =3D 0;</span><br><span> </span><br><span>    =
 argv_printf(&amp;argv, &quot;%s -6 route del %s/%d dev %s&quot;, iproute_p=
ath, dst_str, prefixlen, iface);</span><br><span> </span><br><span>     if =
(gw)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        char *gw_str =3D (char *)print_in6_addr(*gw, 0, &amp;ctx-&gt;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *g=
w_str =3D (char *)print_in6_addr(*gw, 0, &amp;gc);</span><br><span> </span>=
<br><span>         argv_printf_cat(&amp;argv, &quot;via %s&quot;, gw_str);<=
/span><br><span>     }</span><br><span>@@ -368,6 +388,7 @@</span><br><span>=
         ret =3D -1;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span>     argv_free(&amp;argv);</span><br><span> </span><br><span>     retu=
rn ret;</span><br><span>diff --git a/src/openvpn/networking_iproute2=2Eh b/=
src/openvpn/networking_iproute2=2Eh</span><br><span>index dd7d8b3=2E=2Edac5=
f0d 100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Eh</span>=
<br><span>+++ b/src/openvpn/networking_iproute2=2Eh</span><br><span>@@ -28,=
7 +28,6 @@</span><br><span> struct openvpn_net_ctx</span><br><span> {</span=
><br><span>     struct env_set *es;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc;</span><br><span> };</span><br><span> =
</span><br><span> typedef struct openvpn_net_ctx openvpn_net_ctx_t;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2105?usp=3Demail">change 2105</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2105?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2105 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--Bqzm2JrSoX0=--


--===============6725776468241420803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6725776468241420803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6725776468241420803==--


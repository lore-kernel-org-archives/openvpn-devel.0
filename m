Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40924C982F1
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WfpJpZJZHGobd6m/GKCYRkHbm58BcAv+boSWba/m8kY=; b=f5L+54jAbzp9PB
	Rk1GJOeNbe57r0TBc+xXLcUzL83HLlQChh2s06U+zmnh3kaNe+S3+ld3IEjAA9aD1k4dvuBn8YJyu
	NdK9K0RbSDsOIyOF41tOnTfe+LsWPjUvJRWCNgc1bYvFSr7NUiwv4jUbV+u6qaVXGlqZRNnpTRxtf
	SfE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8zYF-0008Oa-O2;
	Tue, 22 Sep 2026 12:24:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8zYD-0008OT-7p
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:24:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzvbG2GhHvRAfd/RmOw5qjv+htefTe7/AcaaDdaIilo=; b=XAn+7+Ws80lKfd1p+1IORhrj27
 bKy1Y0KjYaviGskaqPblbTC6nQxv5lEkvbnnmk9WRBW2WlCU0nyZNJ8qwVpyNuTXHYUVQj8iOpd+6
 KytytoMf7NqMEerEitHTKm6yIbKm+B2WoEZkyLaPj4OHGwd+ywMvLHzNmyMt3t1MtgSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kzvbG2GhHvRAfd/RmOw5qjv+htefTe7/AcaaDdaIilo=; b=c
 vgRcG3U9sl4p1u8KxhmsjufI40gzwoS/Z4KVJ+ISfBNj4aNKKxYt63VItWDJQ0dzY+RlUKYqCX8Ex
 fAp2IF4IeBGvmCN4XxRW//2FYbDnkm+EL/ei3NSkTezgW8YWM1raiGF+YitxDhKpUZJs14YLzxDEG
 eX5LBqfPAwKxmG04=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8zYB-0007wc-DX for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:24:45 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-482f635552aso3360113f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790079877; x=1790684677; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kzvbG2GhHvRAfd/RmOw5qjv+htefTe7/AcaaDdaIilo=;
 b=CnLrrN2PCPGp1+0cDbS+No59DEg5kuhH2aT/8/aVYjseQAYjz0k+OzNgaGq9vjnR79
 m+Uw2yfE1Uiq2hRYqQUU6pAwnC/ReuIfTOrmutOG5wYNcUOVaQqaCRbe5QD0fqCe6Gbt
 PBvYcJCtqs8Nn9dctFt8H5zmHTwBemAFuswqCb1VMxTeEr4nJLWERWftjKGOT/t8NiBg
 gM1q2U7vCIL61PrRIjWhSA/MWLmgzJ++MlKkmAO6Mmsw8oWU8son5yG5J+EJzdUhRzKa
 ZjJjZyHL8mIDTobqCflszfrP+8H1adRlWRzVqZ3G5CrZi4B/HWBlENNTDH6Te7Zjq1vM
 Fh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790079877; x=1790684677;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kzvbG2GhHvRAfd/RmOw5qjv+htefTe7/AcaaDdaIilo=;
 b=pyue+dMIquH+ZosDNcSREZoefQMlUKH9+IMCtN5gQXtZe2nGzvOVWFXWvTaikV+vWn
 1MZXAKKgvq+zPWbm33jg2AfVQHlIt0rifbnA4jf+3gmmtJSrpu3J2eR089YBWzhV4llz
 pGHeCxYItSFpzkiF1kbfJBkFcOExM2HiGZPy+3lu0tczgshTYh6sPxMrcRhrPiqA2s0x
 i3Q1ZxeONL9b1d23xSWxpLRqPmoZFTwL5DueUbMLgKVyAkFDT6mjMoD6tk3lP5ln4LwO
 uOsqzljs5HA568aqbegnmVy30+qNaMUnycLRr3vtlGuQaYprSzjxajHElhAz99/jA7D8
 v9Kw==
X-Gm-Message-State: AFuF++nDamJFxVsqSN43AiuG0tlINIRcHZFHY0gXoFQV6pwCnyTbuiXe
 tIVTlKXprkVv2zICawZoxGw6sBJk4ctkUVSbnePJrKVJbpaOoVTqO5HcnkHcV42RrrQYAjJMbIb
 xwIaYAuLmNxjHdZpVprc+vh7cX8V/VCO9JsBP0yAk3zUK9t0vu9ED10ip2S2yOmt3U5HQUNHsHO
 kXr1rt+Q==
X-Gm-Gg: AYBFou2RXKYrx04E02hTWQ7Uji98NqQfvtee+bw2slhZmAHUD1etSElJwyh4PkD4UiB
 Xw4g3LqgXV9KR+f+9aeaeyF28Q2kA2gbrYRCMIhyos1g/PlQEAdWlTlauTFeIA5hJh99v8xRqKp
 Wzf52dim6X/oRfY4IQiGMrxYOg6LBQZslZ1m6Txs51d6yTq2ClWmZiOB65ayLFuNqpgMwnUJJQC
 ZnNKhfm8E0GXl7OMaQc2meHyhQofJwoi+Ztlcyr9+kGXVHPoAEpZJktfR5cbkJwrzWCYyHq8QbY
 bBHQCZIvEUH2Te+BCP0UbODOUKalJATCELpRUnazYj2YHC0u6lB7cr9fXTAfdroaajDmNnA/cTP
 9ZT7VHGlrzaeb6y4ufPLOR/SUYDreG4rTcIQjrXDx/Z+fHZ3O8iOyv6cJLdaLH7BoqqzfJfP/Vt
 w5AD3GN1IiJWCZIXpFyu+j8E60hV1AzlWpcCkavonH4w7VOdKPPUy08+la/kZMWBadmPUZQ2BHJ
 6JZr0LRDYF3rP2T/nJXdGWAnnFExkChVU/KXuGliu6SFGIZI/MUZvX744GUq3SLjjt+aWxpb4mD
 5hjJUuZxzykT7rSob4/vS4oHjnNnqJexVLHbjO3kxpbVygxaFyarAf9xsGE7iA==
X-Received: by 2002:a5d:6f17:0:b0:488:54ff:67c9 with SMTP id
 ffacd0b85a97d-48854ff685amr11689125f8f.46.1790079876489; 
 Tue, 22 Sep 2026 05:24:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862731bf9sm4840907f8f.1.2026.09.22.05.24.35
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:24:36 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 12:24:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: f2f3c8f0f1f7612b34b4499ae43b77677faeda8a
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9700a01fe55ec78bba6f1cd22eb7490e7e5146e4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8zYB-0007wc-DX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4474229203599971260=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4474229203599971260==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wMBaJXCuEPw="; charset=UTF-8

--wMBaJXCuEPw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1942?usp=3Demail )


Change subject: Change most ENABLE_=
DEBUG ifdefs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMA=
LL

Most of these are verbose logging or even enable logging at high
verbos=
ity level or just useful tools like --show-gateway=2E

We had --enabled-deb=
ug on by default forever, so these "debug"
logs are on by default=2E This p=
atch instead moves them to
enable-small=2E

Change-Id: I3f96cd1c3488b558b8a=
597594d99edcba1214d27
---
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/cr=
ypto_mbedtls_legacy=2Ec
M src/openvpn/error=2Eh
M src/openvpn/event=2Ec
M s=
rc/openvpn/forward=2Ec
M src/openvpn/mroute=2Ec
M src/openvpn/mtcp=2Ec
M sr=
c/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src=
/openvpn/options=2Ec
M src/openvpn/packet_id=2Ec
M src/openvpn/plugin=2Ec
M=
 src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec
M src/openvpn/route=2Ec
=
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
18 files changed, 35 inse=
rtions(+), 34 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/42/1942/1

diff --git a/src/openvpn/crypto_mbedtls=2E=
c b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E9d19902 100644
--- a/=
src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -842=
,7 +842,7 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC=
_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     /* used by =
the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
      * va=
riables warnings if compiled with --enable-small */
     const size_t olen_=
orig =3D olen;
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/ope=
nvpn/crypto_mbedtls_legacy=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src=
/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=
=2Ec
@@ -989,8 +989,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t=
 A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW=
_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMAL=
L
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid=
 unused
      * variables warnings if compiled with --enable-small */
     =
const size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff=
 --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E5=
811bef 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -1=
58,7 +158,7 @@
         }                                \
         EXIT_FA=
TAL(flags);               \
     } while (false)
-#ifdef ENABLE_DEBUG
+#ifn=
def ENABLE_SMALL
 #define dmsg(flags, =2E=2E=2E)                 \
     do =
                                  \
     {                                 =
   \
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 8b771=
6a=2E=2E2cb4e04 100644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=
=2Ec
@@ -398,7 +398,7 @@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter n=3D%d to=
=3D%d", wes->n_events, timeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMA=
LL
     if (check_debug_level(D_EVENT_WAIT))
     {
         int i;
diff --=
git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 6fe5849=2E=2E=
7811245 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
=
@@ -50,7 +50,7 @@
 
 /* show event wait debugging info */
 
-#ifdef ENABLE_=
DEBUG
+#ifndef ENABLE_SMALL
 
 static const char *
 wait_status_string(stru=
ct context *c, struct gc_arena *gc)
@@ -2190,7 +2190,7 @@
         {
      =
       int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
           =
  if (check_debug_level(D_EVENT_WAIT))
             {
                 show=
_wait_status(c);
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=
=2Ec
index 39fa482=2E=2E261d25a 100644
--- a/src/openvpn/mroute=2Ec
+++ b/s=
rc/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
     }
     mh->n_net_len =3D j;
=
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_M=
ULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
diff --git a/=
src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2Eb0125f1 1006=
44
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -74,7 +74,7 @@
=
         mi->did_real_hash =3D true;
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef=
 ENABLE_SMALL
     if (mi)
     {
         dmsg(D_MULTI_DEBUG, "MULTI TCP: =
instance added: %s", mroute_addr_print(&mi->real, &gc));
diff --git a/src/o=
penvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 88b0091=2E=2E4794b7e 100644
--=
- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -431,7 +431,7 @@
   =
      }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_=
debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new()=
;
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=
=2E=2E67204c3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -1145,7 +1145,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef E=
NABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         stru=
ct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/multi_io=2Ec b/src/op=
envpn/multi_io=2Ec
index 3604684=2E=2E4b96c57 100644
--- a/src/openvpn/mult=
i_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -46,7 +46,7 @@
 #define MULTI_IO=
_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO              ((void *)6=
)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static const char *
 pract(=
int action)
 {
@@ -89,7 +89,7 @@
             return "?";
     }
 }
-#endif=
 /* ENABLE_DEBUG */
+#endif
 
 static inline struct context *
 multi_get_co=
ntext(struct multi_context *m, struct multi_instance *mi)
diff --git a/src/=
openvpn/options=2Ec b/src/openvpn/options=2Ec
index 133c035=2E=2E01de12b 10=
0644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -785,7 =
+785,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
     "General Standalone Op=
tions:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     "--show-gateway [=
address]: Show info about gateway [to v4/v6 address]=2E\n"
 #endif
     ;
@=
@ -4229,7 +4229,7 @@
         read_config_file(options, p[1], level, file, =
line, msglevel, permission_mask,
                          option_types_fou=
nd, es);
     }
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#if !=
defined(ENABLE_SMALL)
     else if (streq(p[0], "show-gateway") && !p[2])
 =
    {
         struct route_gateway_info rgi;
@@ -4938,12 +4938,13 @@
     =
         * mbed TLS always generating debug level logging */
             o=
ptions->ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !defined(ENA=
BLE_DEBUG) && !defined(ENABLE_SMALL)
+#if defined(ENABLE_SMALL)
         /*=
 Warn when a debug verbosity is supplied when built without debug support *=
/
         if (options->verbosity >=3D 7)
         {
             msg(M_WAR=
N,
-                "NOTE: debug verbosity (--verb %d) is enabled but this =
build lacks debug support=2E",
+                "NOTE: debug verbosity (--v=
erb %d) is enabled but this build is "
+                "built with --enabl=
e-small that lacks support for high --verb settings",
                 opti=
ons->verbosity);
         }
 #endif
diff --git a/src/openvpn/packet_id=2Ec =
b/src/openvpn/packet_id=2Ec
index a4b627c=2E=2E22c53c7 100644
--- a/src/ope=
nvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -52,18 +52,18 @@
 #de=
fine SEQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED ((time_t)1)
 
-#ifdef ENA=
BLE_DEBUG
+#ifndef ENABLE_SMALL
 static void packet_id_debug_print(msglvl_t=
 msglevel, const struct packet_id_rec *p,
                                 =
  const struct packet_id_net *pin, const char *message,
                   =
                packet_id_print_type value);
 
-#endif /* ENABLE_DEBUG */
+=
#endif
 
 static inline void
 packet_id_debug(msglvl_t msglevel, const stru=
ct packet_id_rec *p,
                 const struct packet_id_net *pin, cons=
t char *message, uint64_t value)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SM=
ALL
     if (unlikely(check_debug_level(msglevel)))
     {
         packet_=
id_debug_print(msglevel, p, pin, message, value);
@@ -576,7 +576,7 @@
     =
return (char *)out=2Edata;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
=
 
 static void
 packet_id_debug_print(msglvl_t msglevel, const struct packe=
t_id_rec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef E=
NABLE_DEBUG */
+#endif
 
 uint16_t
 packet_id_read_epoch(struct packet_id_n=
et *pin, struct buffer *buf)
diff --git a/src/openvpn/plugin=2Ec b/src/open=
vpn/plugin=2Ec
index f8adde5=2E=2Ed10f9fa 100644
--- a/src/openvpn/plugin=
=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,7 +993,7 @@
     pr->n =3D 0;
 }
=
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
 plugin_return_print(con=
st msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)
 =
{
diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf=
3=2E=2E684632c 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=
=2Eh
@@ -135,7 +135,7 @@
 
 void plugin_return_free(struct plugin_return *p=
r);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_return_print(=
const msglvl_t msglevel, const char *prefix, const struct plugin_return *pr=
);
 
 #endif
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec
index ced438e=2E=2Eb5315ff 100644
--- a/src/openvpn/reliable=2Ec
+++ b=
/src/openvpn/reliable=2Ec
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DE=
BUG
+#ifndef ENABLE_SMALL
 /* print the current sequence of active packet I=
Ds */
 static const char *
 reliable_print_ids(const struct reliable *rel, =
struct gc_arena *gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(&out);
 }
=
-#endif /* ENABLE_DEBUG */
+#endif
 
 /* true if at least one free buffer a=
vailable */
 bool
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2E=
c
index 03a2526=2E=2Ea9a6dcc 100644
--- a/src/openvpn/route=2Ec
+++ b/src/o=
penvpn/route=2Ec
@@ -81,7 +81,7 @@
 
 static void get_bypass_addresses(stru=
ct route_bypass *rb, const unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#if=
ndef ENABLE_SMALL
 
 static void
 print_bypass_addresses(const struct route=
_bypass *rb)
@@ -617,7 +617,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_DEFINE=
D)
     {
         setenv_route_addr(es, "net_gateway", rl->ngi=2Egateway=
=2Eaddr, -1);
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#if !de=
fined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, &rl->rgi, NULL)=
;
 #endif
     }
@@ -660,7 +660,7 @@
             add_block_local_routes(rl=
);
         }
         get_bypass_addresses(&rl->spec=2Ebypass, rl->flags);=

-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
         print_bypass_addresses=
(&rl->spec=2Ebypass);
 #endif
     }
@@ -768,7 +768,7 @@
     if (rl6->ngi6=
=2Eflags & RGI_ADDR_DEFINED)
     {
         setenv_str(es, "net_gateway_ip=
v6", print_in6_addr(rl6->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
-#if defined=
(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#if !defined(ENABLE_SMALL)
      =
   print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
     }
diff --=
git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6772ad6=2E=
=2E6c60dc2 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=
=2Ec
@@ -33,7 +33,7 @@
 
 #include "memdbg=2Eh"
 
-#ifdef ENABLE_DEBUG
+#if=
ndef ENABLE_SMALL
 static void
 schedule_entry_debug_info(const char *calle=
r, const struct schedule_entry *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_a=
dd_modify(struct schedule *s, struct schedule_entry *e)
 {
-#ifdef ENABLE_D=
EBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
=
         schedule_entry_debug_info("schedule_add_modify", e);
@@ -355,7 +35=
5,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     =
if (check_debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_in=
fo("schedule_find_least", e);
diff --git a/src/tapctl/error=2Eh b/src/tapct=
l/error=2Eh
index f9586dc=2E=2E34aa894 100644
--- a/src/tapctl/error=2Eh
++=
+ b/src/tapctl/error=2Eh
@@ -83,7 +83,7 @@
         }                      =
          \
         EXIT_FATAL(flags);               \
     } while (false=
)
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 #define dmsg(flags, =2E=2E=2E=
)                 \
     do                                   \
     {     =
                               \

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Numbe=
r: 1942
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wMBaJXCuEPw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL<br><br>Most=
 of these are verbose logging or even enable logging at high<br>verbosity l=
evel or just useful tools like --show-gateway=2E<br><br>We had --enabled-de=
bug on by default forever, so these &quot;debug&quot;<br>logs are on by def=
ault=2E This patch instead moves them to<br>enable-small=2E<br><br>Change-I=
d: I3f96cd1c3488b558b8a597594d99edcba1214d27<br>---<br>M src/openvpn/crypto=
_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/er=
ror=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/op=
envpn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M s=
rc/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/op=
envpn/plugin=2Eh<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/route=2Ec<b=
r>M src/openvpn/schedule=2Ec<br>M src/tapctl/error=2Eh<br>18 files changed,=
 35 insertions(+), 34 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</sp=
an><br><span>index 0c5beb4=2E=2E9d19902 100644</span><br><span>--- a/src/op=
envpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=
=2Ec</span><br><span>@@ -842,7 +842,7 @@</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef ENABLE_SMALL</span><br><span>     /* used by the D_SHOW_KEY_SOURCE, guar=
ded with ENABLE_DEBUG to avoid unused</span><br><span>      * variables war=
nings if compiled with --enable-small */</span><br><span>     const size_t =
olen_orig =3D olen;</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=
_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>index b=
bd012f6=2E=2Ef46d8bf 100644</span><br><span>--- a/src/openvpn/crypto_mbedtl=
s_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</s=
pan><br><span>@@ -989,8 +989,8 @@</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* used b=
y the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used by the D_SHOW_K=
EY_SOURCE, guarded with ENABLE_SMALL to avoid unused</span><br><span>      =
* variables warnings if compiled with --enable-small */</span><br><span>   =
  const size_t olen_orig =3D olen;</span><br><span>     const uint8_t *out_=
orig =3D out;</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/open=
vpn/error=2Eh</span><br><span>index a887fc7=2E=2E5811bef 100644</span><br><=
span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2E=
h</span><br><span>@@ -158,7 +158,7 @@</span><br><span>         }           =
                     \</span><br><span>         EXIT_FATAL(flags);         =
      \</span><br><span>     } while (false)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> #define dmsg(f=
lags, =2E=2E=2E)                 \</span><br><span>     do                 =
                  \</span><br><span>     {                                 =
   \</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=
=2Ec</span><br><span>index 8b7716a=2E=2E2cb4e04 100644</span><br><span>--- =
a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><=
br><span>@@ -398,7 +398,7 @@</span><br><span> </span><br><span>     dmsg(D_=
EVENT_WAIT, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, wes-&gt;n_events, tim=
eout);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_EVENT_=
WAIT))</span><br><span>     {</span><br><span>         int i;</span><br><sp=
an>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br=
><span>index 6fe5849=2E=2E7811245 100644</span><br><span>--- a/src/openvpn/=
forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@=
@ -50,7 +50,7 @@</span><br><span> </span><br><span> /* show event wait debu=
gging info */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static co=
nst char *</span><br><span> wait_status_string(struct context *c, struct gc=
_arena *gc)</span><br><span>@@ -2190,7 +2190,7 @@</span><br><span>         =
{</span><br><span>             int status;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span=
>             if (check_debug_level(D_EVENT_WAIT))</span><br><span>        =
     {</span><br><span>                 show_wait_status(c);</span><br><spa=
n>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><s=
pan>index 39fa482=2E=2E261d25a 100644</span><br><span>--- a/src/openvpn/mro=
ute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -50=
1,7 +501,7 @@</span><br><span>     }</span><br><span>     mh-&gt;n_net_len =
=3D j;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_MULTI_=
DEBUG))</span><br><span>     {</span><br><span>         struct gc_arena gc =
=3D gc_new();</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openv=
pn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2Eb0125f1 100644</span><br><sp=
an>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</s=
pan><br><span>@@ -74,7 +74,7 @@</span><br><span>         mi-&gt;did_real_ha=
sh =3D true;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>    =
 if (mi)</span><br><span>     {</span><br><span>         dmsg(D_MULTI_DEBUG=
, &quot;MULTI TCP: instance added: %s&quot;, mroute_addr_print(&amp;mi-&gt;=
real, &amp;gc));</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/op=
envpn/mudp=2Ec</span><br><span>index 88b0091=2E=2E4794b7e 100644</span><br>=
<span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec=
</span><br><span>@@ -431,7 +431,7 @@</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_M=
ULTI_DEBUG))</span><br><span>     {</span><br><span>         struct gc_aren=
a gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec</span><br><span>index 3e72b92=2E=2E67204c3 100644</span>=
<br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mul=
ti=2Ec</span><br><span>@@ -1145,7 +1145,7 @@</span><br><span>         }</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_l=
evel(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>         struct=
 gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/multi_i=
o=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 3604684=2E=2E4b96c57=
 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ =
b/src/openvpn/multi_io=2Ec</span><br><span>@@ -46,7 +46,7 @@</span><br><spa=
n> #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span><br><span> #define M=
ULTI_IO_DCO              ((void *)6)</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> sta=
tic const char *</span><br><span> pract(int action)</span><br><span> {</spa=
n><br><span>@@ -89,7 +89,7 @@</span><br><span>             return &quot;?&q=
uot;;</span><br><span>     }</span><br><span> }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 static inline struct context *</span><br><span> multi_get_context(struct m=
ulti_context *m, struct multi_instance *mi)</span><br><span>diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 133c0=
35=2E=2E01de12b 100644</span><br><span>--- a/src/openvpn/options=2Ec</span>=
<br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -785,7 +785,7 @@=
</span><br><span> #endif /* ENABLE_PKCS11 */</span><br><span>     &quot;\n&=
quot;</span><br><span>     &quot;General Standalone Options:\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span>     &quot;--show-gateway [address]: Show info about gateway [to v=
4/v6 address]=2E\n&quot;</span><br><span> #endif</span><br><span>     ;</sp=
an><br><span>@@ -4229,7 +4229,7 @@</span><br><span>         read_config_fil=
e(options, p[1], level, file, line, msglevel, permission_mask,</span><br><s=
pan>                          option_types_found, es);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_=
DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if !defined(ENABLE_SMALL)</span><br><span>     else i=
f (streq(p[0], &quot;show-gateway&quot;) &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         struct route_gateway_info rgi;</span><br><s=
pan>@@ -4938,12 +4938,13 @@</span><br><span>              * mbed TLS always=
 generating debug level logging */</span><br><span>             options-&gt=
;ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(ENABLE_DEBUG) &am=
p;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(ENABLE_SMALL)</span><br><span>         /* Warn when =
a debug verbosity is supplied when built without debug support */</span><br=
><span>         if (options-&gt;verbosity &gt;=3D 7)</span><br><span>      =
   {</span><br><span>             msg(M_WARN,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                &quot;NOTE: debug verbosity (--verb=
 %d) is enabled but this build lacks debug support=2E&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                &quot;NOTE: debug =
verbosity (--verb %d) is enabled but this build is &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;built with --en=
able-small that lacks support for high --verb settings&quot;,</span><br><sp=
an>                 options-&gt;verbosity);</span><br><span>         }</spa=
n><br><span> #endif</span><br><span>diff --git a/src/openvpn/packet_id=2Ec =
b/src/openvpn/packet_id=2Ec</span><br><span>index a4b627c=2E=2E22c53c7 1006=
44</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/sr=
c/openvpn/packet_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</span><br><span=
> #define SEQ_UNSEEN  ((time_t)0)</span><br><span> #define SEQ_EXPIRED ((ti=
me_t)1)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ENABLE_SMALL</span><br><span> static void packet_id_debug_print=
(msglvl_t msglevel, const struct packet_id_rec *p,</span><br><span>        =
                           const struct packet_id_net *pin, const char *mes=
sage,</span><br><span>                                   packet_id_print_ty=
pe value);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span> </span><br><span> static inline void</=
span><br><span> packet_id_debug(msglvl_t msglevel, const struct packet_id_r=
ec *p,</span><br><span>                 const struct packet_id_net *pin, co=
nst char *message, uint64_t value)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>    =
 if (unlikely(check_debug_level(msglevel)))</span><br><span>     {</span><b=
r><span>         packet_id_debug_print(msglevel, p, pin, message, value);</=
span><br><span>@@ -576,7 +576,7 @@</span><br><span>     return (char *)out=
=2Edata;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><s=
pan> static void</span><br><span> packet_id_debug_print(msglvl_t msglevel, =
const struct packet_id_rec *p,</span><br><span>@@ -648,7 +648,7 @@</span><b=
r><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span> uint16_t</span><br><span> packet_id_read_epoch(str=
uct packet_id_net *pin, struct buffer *buf)</span><br><span>diff --git a/sr=
c/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index f8adde5=
=2E=2Ed10f9fa 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br=
><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +993,7 @@</sp=
an><br><span>     pr-&gt;n =3D 0;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span=
><br><span> void</span><br><span> plugin_return_print(const msglvl_t msglev=
el, const char *prefix, const struct plugin_return *pr)</span><br><span> {<=
/span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2E=
h</span><br><span>index 7e9faf3=2E=2E684632c 100644</span><br><span>--- a/s=
rc/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plugin=2Eh</span><b=
r><span>@@ -135,7 +135,7 @@</span><br><span> </span><br><span> void plugin_=
return_free(struct plugin_return *pr);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> vo=
id plugin_return_print(const msglvl_t msglevel, const char *prefix, const s=
truct plugin_return *pr);</span><br><span> </span><br><span> #endif</span><=
br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</=
span><br><span>index ced438e=2E=2Eb5315ff 100644</span><br><span>--- a/src/=
openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><=
br><span>@@ -462,7 +462,7 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef E=
NABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
ENABLE_SMALL</span><br><span> /* print the current sequence of active packe=
t IDs */</span><br><span> static const char *</span><br><span> reliable_pri=
nt_ids(const struct reliable *rel, struct gc_arena *gc)</span><br><span>@@ =
-480,7 +480,7 @@</span><br><span>     }</span><br><span>     return BSTR(&a=
mp;out);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span> </span><br><span> /* true if at least o=
ne free buffer available */</span><br><span> bool</span><br><span>diff --gi=
t a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 03a=
2526=2E=2Ea9a6dcc 100644</span><br><span>--- a/src/openvpn/route=2Ec</span>=
<br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -81,7 +81,7 @@</sp=
an><br><span> </span><br><span> static void get_bypass_addresses(struct rou=
te_bypass *rb, const unsigned int flags);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>=
 </span><br><span> static void</span><br><span> print_bypass_addresses(cons=
t struct route_bypass *rb)</span><br><span>@@ -617,7 +617,7 @@</span><br><s=
pan>     if (rl-&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>   =
  {</span><br><span>         setenv_route_addr(es, &quot;net_gateway&quot;,=
 rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ENABLE_SM=
ALL)</span><br><span>         print_default_gateway(D_ROUTE, &amp;rl-&gt;rg=
i, NULL);</span><br><span> #endif</span><br><span>     }</span><br><span>@@=
 -660,7 +660,7 @@</span><br><span>             add_block_local_routes(rl);<=
/span><br><span>         }</span><br><span>         get_bypass_addresses(&a=
mp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print_bypas=
s_addresses(&amp;rl-&gt;spec=2Ebypass);</span><br><span> #endif</span><br><=
span>     }</span><br><span>@@ -768,7 +768,7 @@</span><br><span>     if (rl=
6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br=
><span>         setenv_str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr=
(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(=
ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !d=
efined(ENABLE_SMALL)</span><br><span>         print_default_gateway(D_ROUTE=
, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><br><span>     }<=
/span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedul=
e=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 100644</span><br><span>---=
 a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec<=
/span><br><span>@@ -33,7 +33,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void</sp=
an><br><span> schedule_entry_debug_info(const char *caller, const struct sc=
hedule_entry *e)</span><br><span> {</span><br><span>@@ -308,7 +308,7 @@</sp=
an><br><span> void</span><br><span> schedule_add_modify(struct schedule *s,=
 struct schedule_entry *e)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check=
_debug_level(D_SCHEDULER))</span><br><span>     {</span><br><span>         =
schedule_entry_debug_info(&quot;schedule_add_modify&quot;, e);</span><br><s=
pan>@@ -355,7 +355,7 @@</span><br><span>         }</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</s=
pan><br><span>     {</span><br><span>         schedule_entry_debug_info(&qu=
ot;schedule_find_least&quot;, e);</span><br><span>diff --git a/src/tapctl/e=
rror=2Eh b/src/tapctl/error=2Eh</span><br><span>index f9586dc=2E=2E34aa894 =
100644</span><br><span>--- a/src/tapctl/error=2Eh</span><br><span>+++ b/src=
/tapctl/error=2Eh</span><br><span>@@ -83,7 +83,7 @@</span><br><span>       =
  }                                \</span><br><span>         EXIT_FATAL(fl=
ags);               \</span><br><span>     } while (false)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> =
#define dmsg(flags, =2E=2E=2E)                 \</span><br><span>     do   =
                                \</span><br><span>     {                   =
                 \</span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b55=
8b8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--wMBaJXCuEPw=--


--===============4474229203599971260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4474229203599971260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4474229203599971260==--


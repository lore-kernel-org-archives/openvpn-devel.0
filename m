Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7C60A262F
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eg8IsLMy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cNnPFPLV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hpuGOiJ9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XxiwRiqG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rz2o10zRLcGQXFpxW1mxbszzOAxyjBeRItpTbTv4kiw=; b=eg8IsLMyHD63N6R2L0XmWnScxp
	vJXEjNXZPMYKri92tYuK0aG5yHtlZsNY1IikI10w09ZI9kUBfBKnwWZ7kP33xTGZPKo44oQqA6hsk
	qMjn/4amE3fiqTiidC8v/EfoFD+0JgmJdsyEtFcnFLVjZ2TN4CZiPRfudlbP4b50ppZg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzXQ-000000000Cy-0FpF;
	Fri, 13 Nov 2026 22:14:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzWy-000000000CC-3AJG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zncm3rWqRIurpW/Y7RAiq4moMUOSWNro51vKpy6l9Yc=; b=cNnPFPLVOr6n/+Y9H8wBzk/yWp
 lLPOvPnkr3Eu+EZxep0JBiWSTvSc1Ctpq6mrQHRpEL5Y+AbcLv4/9RWn3uuSJgi/BNy/C0LlFlwWs
 pDN5lKzPjjPyNiCNY6Wq15eHewo8YPMaGC+4ZterKHx5DIHdcLIPA3pQ6r0IJis/s2dE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zncm3rWqRIurpW/Y7RAiq4moMUOSWNro51vKpy6l9Yc=; b=hpuGOiJ93QTUX3Xr8xmhEVwLjR
 mJdRpF+uN4IXQ+w8DRqKwTAJ5dbUpIQ2rk29SDXjPOZaOPgQYdWp7dJOEiNp/PMJr2Z4g/Mo1B0LQ
 M/+So09cqG9Ymm8fwN6QbX5H8x2ozwbs1p9wN3yDttvrSYXupLIRhlNY+dNcdBr16cTE=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzWn-000000008PJ-2yvU for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:13:52 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so704044f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794608023; x=1795212823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zncm3rWqRIurpW/Y7RAiq4moMUOSWNro51vKpy6l9Yc=;
 b=XxiwRiqGqxBVR0R3fi3ry3SEoWWMgp1p9Le/WZh6jgcL42I4RFtUB8WkElhTvXIlNo
 oKFWyIXSFC2e/4Yh6E3SgA6a/OEOIQn13aKcawpKFqu7wHgzqKcqy1S2vZBL1daoZu8K
 5HzUjAHRTW/KTV7Qz6D/2PZRPfYRTVEIeoE4STFvKNTROn1gpJKJNiOSCNgr84NBy21F
 p55Vlh9TyTdhnWo8EeJ5kTsftb+AhOs4zNzEFVI1ziU2QR8THgUdhqHN4aEFk4CjeJLJ
 sZbBb40uOtOCmRbzLZtawJ3cWJJWEkN4bcIPWbyxz6J3W3R+0YS1O1sgziEZmq8l6yVt
 iOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794608023; x=1795212823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Zncm3rWqRIurpW/Y7RAiq4moMUOSWNro51vKpy6l9Yc=;
 b=b2m4Dg7DS8FU54FUDwosO+wW443ED/HylLkrNHoyZeCSdaJlT5kbeyOukk16AUJyOP
 uOrSeoIllzR2B7xO/ooAq7EUY6sH/bEsu3EM6epC5TXcZCTjyDPZ4S+Adw2X56mQS0HA
 Ghwb+c9oTZ1/M8mjVPCG7df+JZKK6c87Wlrjzp11fdU/mDEzP5sLxyLRfSeIy3Aw5JNM
 6jHXg46nnepV5srWC6AOh8HOj+XzXqK54GW3aJIbHN2DGQ01XZCdOXYu66flInXhat7m
 2ksRQD01VE7mDHqy09gJSO3C++8K40gepj095sM5qI0SqhSUe4e7dSeBEXZ0ZORPC5n4
 CG3Q==
X-Gm-Message-State: APuU4Z8YZhRWt6YUwr4f0Tl3fcHBUSWbHi0J76EfgeVrff53s6q+DSti
 BDBG9lNjJy7Tdsj2xpLsfZg9uCLl5KL+JKJz9fTy66uGGdAgvxZqiHdRom1wTZSaVYsAuMCIDSS
 jU5qKfyi+XPBkaNZhW/CNVQTUHO2cwZpnc7wAM957POHjiD7jRZK0S47NhsQVGxXTFBdG
X-Gm-Gg: AYBFou1ncCaawOWmgiUeeMs2u9dm7DeflEJlt0c1IwG/EzXYbmI0dq3gfvQbjt+jnJg
 E4Wl66mB1RcNYV7KkhR9pGh7/RjuaB7bPOr5mVo54PSBhReH3hOt5diu9K6HzOiXAdBO7o3WMZY
 XH0NpbCUSfppu7ZXZJwryCJpPVzA+IW8CTL0jxm4Sao0XaHgF3qPBsxD+kuq/jdTQ02NOdqLrZ4
 G61gRzWC6XoAop4tzlfpJH1DZTQCOT/WqwbZCwf2xg/d5iEChdRLeMZnVEgDPpN/YmVmmKQBbIf
 4ORQYOXl/njS5uD7Q8vhvQg8DVwp2NCDTaqz/Qr/vmCRDPmmRMjCznrT0hlOX2eHMwsoe1aFH6k
 K1ihaIzqwK5cgrRAn8yNIO30fUhpWLU14XZA/VTRaK2cwwrZ2Xfv2r7LeK9vqkowKbzH3plEkoK
 oO/rbcubBavy89o8BS+DPUayrBg19LkiT5GxhQfuhuzqV4YkH5g1L5sD6PN2kRoS4StGJrPFutX
 cMtaFhgCkQ12L/uuIXkj97uO87yrQKuvxRimaWuVbATcqrUYUpT9m3pYJogUIvqSaQpufChCeD4
 WYyM9oq+0TPxftrQbeQGGWGmHKWI8/XVSj+nOpaiOdWciV3R9bfQMzAYbGcE6SHA/l3B4RwmCx1
 jrKR3mYMXA9R+MY0Y0IQsU/PL/ywrQordeW8gWDaarYAotmbn8mluXCIQ3j0mzRXVW6clioG4kp
 UyO57uG9vEB98gYVY=
X-Received: by 2002:a05:6000:25f9:b0:48e:c0:9441 with SMTP id
 ffacd0b85a97d-49c71a66e00mr8417490f8f.29.1794608022613; 
 Fri, 13 Nov 2026 14:13:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm8240913f8f.45.2026.11.13.14.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:13:41 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:13:41 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: 30a8bf5eb8eb298b18c32807d39eeaae777c3066
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eb887e1f9b7a42cbf20a12b5f244e7a03fc8400-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzWn-000000008PJ-2yvU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3161070273338442763=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3161070273338442763==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="40fgYZ+vfu4="; charset=UTF-8

--40fgYZ+vfu4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#6) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
157?usp=3Demail )


Change subject: Various trivial -Wsign-conversion fixes=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Various tr=
ivial -Wsign-conversion fixes

* Continue BLEN -> BLENZ replacement
* Remov=
e some unneeded casts
* Some trivial type fixes

Change-Id: I02f8df01f8f33c=
b9cd04cd844d1f1893688f51e8
Signed-off-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157
Message-Id: <20261110143722=
=2E15193-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41094=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/acc=2Ec
M src/openvpn/a=
uth_token=2Ec
M src/openvpn/base64=2Eh
M src/openvpn/console_builtin=2Ec
M =
src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/crypto_epoch=
=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M tests/unit_te=
sts/openvpn/test_crypto=2Ec
M tests/unit_tests/openvpn/test_networking=2Ec
=
M tests/unit_tests/openvpn/test_pkt=2Ec
M tests/unit_tests/openvpn/test_tls=
_crypt=2Ec
13 files changed, 49 insertions(+), 95 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/2157/6

diff --=
git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
index ceb7100=2E=2Edae614a =
100644
--- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -148,11 +148,=
6 @@
     return parse_acc_message_flags(flags, err_reason, gc);
 }
 
-#if =
defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#prag=
ma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 receive_acc_=
message(struct context *c, const struct buffer *buffer)
 {
@@ -236,15 +231,=
10 @@
     msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app contr=
ol channel "
                        "message (%s): %s",
         err_reaso=
n,
-        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+        for=
mat_hex(CBPTR(buffer), BLENZ(buffer), 80, &gc));
     gc_free(&gc);
 }
 
-
=
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#=
endif
-
 bool
 send_acc_message(struct context *c,
                  struct=
 tls_multi *multi,
diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/au=
th_token=2Ec
index 211af90=2E=2Eb69092c 100644
--- a/src/openvpn/auth_token=
=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -36,11 +36,6 @@
  * padding */
 st=
atic_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple =
of 3");
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnos=
tic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 boo=
l
 is_auth_token(const char *password)
 {
@@ -67,7 +62,7 @@
         return=
;
     }
 
-    int auth_token_state_flags =3D session->key[KS_PRIMARY]=2Ea=
uth_token_state_flags;
+    unsigned int auth_token_state_flags =3D session=
->key[KS_PRIMARY]=2Eauth_token_state_flags;
 
     const char *state;
 
@@ =
-188,7 +183,7 @@
 {
     struct gc_arena gc =3D gc_new();
 
-    int64_t ti=
mestamp =3D htonll((uint64_t)now);
+    int64_t timestamp =3D (int64_t)hton=
ll((uint64_t)now);
     int64_t initial_timestamp =3D timestamp;
 
     hma=
c_ctx_t *ctx =3D multi->opt=2Eauth_token_key=2Ehmac;
@@ -273,7 +268,7 @@
  =
       alloc_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &gc)=
;
 
     ASSERT(buf_write(&session_token, SESSION_ID_PREFIX, strlen(SESSION=
_ID_PREFIX)));
-    ASSERT(buf_write(&session_token, b64output, (int)strlen=
(b64output)));
+    ASSERT(buf_write(&session_token, b64output, strlen(b64o=
utput)));
     ASSERT(buf_write_u8(&session_token, 0));
 
     free(b64outp=
ut);
@@ -296,10 +291,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) ||=
 defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 che=
ck_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *usern=
ame)
 {
diff --git a/src/openvpn/base64=2Eh b/src/openvpn/base64=2Eh
index =
be7aa64=2E=2E800e569 100644
--- a/src/openvpn/base64=2Eh
+++ b/src/openvpn/=
base64=2Eh
@@ -35,7 +35,7 @@
 #define _BASE64_H_
 
 /** Compute resulting b=
ase64 length=2E  6 bits per byte, padded to 4 bytes=2E */
-#define OPENVPN_=
BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) + 3) & ~3)
+#defin=
e OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) + 3) & ~=
3u)
 
 /** Compute the maximal number of bytes encoded in a base64 string=
=2E */
 #define OPENVPN_BASE64_DECODED_LENGTH(base64_length) ((base64_lengt=
h / 4) * 3)
diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/cons=
ole_builtin=2Ec
index dc71d12=2E=2E0353ade 100644
--- a/src/openvpn/console=
_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -234,7 +234,7 @@
    =
 if (!echo && (tcgetattr(fileno(fp), &tty_tmp) =3D=3D 0))
     {
         t=
ty_save =3D tty_tmp;
-        tty_tmp=2Ec_lflag &=3D ~(ECHO | ECHOE | ECHOK=
 | ECHONL | ISIG);
+        tty_tmp=2Ec_lflag &=3D ~(unsigned int)(ECHO | E=
CHOE | ECHOK | ECHONL | ISIG);
         restore_tty =3D (tcsetattr(fileno(f=
p), TCSAFLUSH, &tty_tmp) =3D=3D 0);
     }
 
diff --git a/src/openvpn/crypt=
o=2Ec b/src/openvpn/crypto=2Ec
index 9d53006=2E=2E5ad4b5f 100644
--- a/src/=
openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -139,7 +139,7 @@
       =
  ASSERT(cipher_ctx_reset(ctx->cipher, iv));
     }
 
-    dmsg(D_PACKET_CO=
NTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+   =
 dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf=
), 80, &gc));
 
     /* Buffer overflow check */
     if (!buf_safe(&work, =
buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
@@ -151,7 +151,7 =
@@
 
     /* For AEAD ciphers, authenticate Additional Data, including opco=
de */
     ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work=
)));
-    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(BPTR(&work), =
BLEN(&work), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format=
_hex(BPTR(&work), BLENZ(&work), 0, &gc));
 
     if (!use_epoch_data_format=
)
     {
@@ -170,8 +170,8 @@
 
     /* update number of plaintext blocks en=
crypted=2E Use the (x + (n-1))/n trick
      * to round up the result to th=
e number of blocks used */
-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZ=
E;
-    opt->key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLEN(&work) + (b=
locksize - 1)) / blocksize;
+    const unsigned int blocksize =3D AEAD_LIMI=
T_BLOCKSIZE;
+    opt->key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLENZ(=
&work) + (blocksize - 1)) / blocksize;
 
     /* if the tag is at end the e=
nd, allocate it now */
     if (use_epoch_data_format)
@@ -186,7 +186,7 @@
=
 
     *buf =3D work;
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", forma=
t_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT=
 TO: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     gc_free(&gc);=

     return;
@@ -257,13 +257,13 @@
             ASSERT(buf_write(&work, iv=
_buf, iv_size));
             dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", form=
at_hex(iv_buf, iv_size, 0, &gc));
 
-            dmsg(D_PACKET_CONTENT, "EN=
CRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+            d=
msg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf),=
 80, &gc));
 
             /* cipher_ctx was already initialized with key &=
 keylen */
             ASSERT(cipher_ctx_reset(ctx->cipher, iv_buf));
 
  =
           /* Buffer overflow check */
-            if (!buf_safe(&work, bu=
f->len + cipher_ctx_block_size(ctx->cipher)))
+            if (!buf_safe(&w=
ork, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
             {
     =
            msg(D_CRYPT_ERRORS,
                     "ENCRYPT: buffer size =
error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u",
@@ -317,7=
 +317,7 @@
 
         *buf =3D work;
 
-        dmsg(D_PACKET_CONTENT, "ENC=
RYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+        dmsg=
(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), =
80, &gc));
     }
 
     gc_free(&gc);
@@ -456,7 +456,7 @@
     ASSERT(buf-=
>len > 0);
     ASSERT(ctx->cipher);
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT=
 FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_=
CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 =

     ASSERT(ad_start >=3D buf->data && ad_start <=3D BPTR(buf));
 
@@ -554=
,10 +554,10 @@
     }
 
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", form=
at_hex(tag_ptr, tag_size, 0, &gc));
-    dmsg(D_PACKET_CONTENT, "DECRYPT FR=
OM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &gc));
+    dmsg(D_PACKET_CONT=
ENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
    =
 /* Buffer overflow check (should never fail) */
-    if (!buf_safe(&work, =
buf->len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&work, B=
LENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
     {
         CRYPT_ERRO=
R("potential buffer overflow");
     }
@@ -581,7 +581,7 @@
     }
     ASSE=
RT(buf_inc_len(&work, outlen));
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT TO: =
%s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+    dmsg(D_PACKET_CON=
TENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
 
=
     if (!crypto_check_replay(opt, &pin, epoch, error_prefix, &gc))
     {
=
@@ -590,8 +590,8 @@
 
     /* update number of plaintext blocks decrypted=
=2E Use the (x + (n-1))/n trick
      * to round up the result to the numbe=
r of blocks used=2E */
-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-=
    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLEN(&work) + (block=
size - 1)) / blocksize;
+    const unsigned int blocksize =3D AEAD_LIMIT_BL=
OCKSIZE;
+    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLENZ(&wor=
k) + (blocksize - 1)) / blocksize;
 
     *buf =3D work;
 
@@ -627,7 +627,7=
 @@
         struct packet_id_net pin;
         bool have_pin =3D false;
 
=
-        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), B=
LEN(buf), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", fo=
rmat_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
         /* Verify the HMAC */=

         if (ctx->hmac)
@@ -690,7 +690,7 @@
             }
 
             =
/* Buffer overflow check (should never happen) */
-            if (!buf_saf=
e(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+            if (!=
buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
         =
    {
                 CRYPT_ERROR("packet too big to decrypt");
          =
   }
@@ -709,7 +709,7 @@
             }
             ASSERT(buf_inc_len(&wo=
rk, outlen));
 
-            dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", forma=
t_hex(BPTR(&work), BLEN(&work), 80, &gc));
+            dmsg(D_PACKET_CONTE=
NT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
 
  =
           /* Get packet ID from plaintext buffer or IV, depending on ciphe=
r mode */
             {
@@ -851,7 +851,7 @@
 crypto_max_overhead(void)
 {
=
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_CIPH=
ER_BLOCK_SIZE
-           + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG=
_LENGTH);
+           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LE=
NGTH);
 }
 
 static void
@@ -1362,7 +1362,7 @@
         size_t buf_size =3D=
 strlen(file) + 1;
         ASSERT(buf_size <=3D INT_MAX);
         size =
=3D (int)buf_size;
-        buf_set_read(&in, (const uint8_t *)file, size);=

+        buf_set_read(&in, (const uint8_t *)file, buf_size);
     }
     e=
lse /* 'file' is a filename which refers to a file containing the ascii key=
 */
     {
@@ -1531,7 +1531,7 @@
     struct buffer out =3D alloc_buf_gc(20=
48, &gc);
 
     /* how to format the ascii file representation of key */
-=
    const int bytes_per_line =3D 16;
+    const unsigned int bytes_per_line=
 =3D 16;
 
     /* write header */
     buf_printf(&out, "#\n# %d bit OpenV=
PN static key\n#\n", nbits);
diff --git a/src/openvpn/crypto=2Eh b/src/open=
vpn/crypto=2Eh
index 7e240d2=2E=2Ef0cacde 100644
--- a/src/openvpn/crypto=
=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -746,12 +746,12 @@
  * to read=2E
  */=

 static inline bool
-aead_usage_limit_reached(const uint64_t limit, const =
struct key_ctx *key_ctx, int64_t higest_pid)
+aead_usage_limit_reached(cons=
t uint64_t limit, const struct key_ctx *key_ctx, uint64_t higest_pid)
 {
  =
   /* This is the  q + s <=3D  p^(1/2) * 2^(129/2) - 1 calculation where
  =
    * q is the number of protected messages (highest_pid)
      * s Total p=
laintext length in all messages (in blocks) */
-    return (limit > 0 && ke=
y_ctx->plaintext_blocks + (uint64_t)higest_pid > limit);
+    return (limit=
 > 0 && key_ctx->plaintext_blocks + higest_pid > limit);
 }
 
 #endif /* CR=
YPTO_H */
diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_ep=
och=2Ec
index 312cf6f=2E=2E243b5a2 100644
--- a/src/openvpn/crypto_epoch=2E=
c
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -98,7 +98,7 @@
     const uint8_t *=
label_prefix =3D (const uint8_t *)("ovpn ");
     uint8_t prefix_len =3D 5;=

 
-    size_t hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + cont=
ext_len;
+    size_t hkdf_label_len =3D 2u + prefix_len + 1u + label_len + =
1u + context_len;
     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label=
_len, &gc);
 
     buf_write_u16(&hkdf_label, (uint16_t)out_len);
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 4809532=2E=2E1760=
c90 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -27=
58,7 +2758,7 @@
             else
             {
                 int statu=
s;
-                int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON=
_SIGNAL | GETADDR_FATAL;
+                unsigned int resolve_flags =3D GE=
TADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
 
                 =
if (!(flags & MF_CONNECT_AS_CLIENT))
                 {
@@ -4001,11 +4001,1=
1 @@
         desc =3D "rsa-sign";
     }
 
-    buf_write(&buf_data, b64_d=
ata, (int)strlen(b64_data));
+    buf_write(&buf_data, b64_data, strlen(b64=
_data));
     if (man->connection=2Eclient_version >=3D MCV_PKSIGN_ALG)
   =
  {
-        buf_write(&buf_data, ",", (int)strlen(","));
-        buf_writ=
e(&buf_data, algorithm, (int)strlen(algorithm));
+        buf_write(&buf_da=
ta, ",", strlen(","));
+        buf_write(&buf_data, algorithm, strlen(algo=
rithm));
     }
     char *ret =3D management_query_multiline_flatten(man, =
(char *)buf_bptr(&buf_data), prompt, desc,
                                =
                    &man->connection=2Eext_key_state,
diff --git a/src/open=
vpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index cbc3118=2E=2Ef4e142=
b 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2E=
c
@@ -1119,7 +1119,7 @@
         return 0;
     }
 
-    retval =3D endless=
_buf_write(&ks->bio_ctx->in, BPTR(buf), buf->len);
+    retval =3D endless_=
buf_write(&ks->bio_ctx->in, BPTR(buf), BLENZ(buf));
 
     if (retval < 0)
=
     {
diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_t=
ests/openvpn/test_crypto=2Ec
index e68a0b2=2E=2E6ccca33 100644
--- a/tests/=
unit_tests/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_cryp=
to=2Ec
@@ -52,11 +52,6 @@
 
 static const char testtext[] =3D "Dummy text t=
o test PEM encoding";
 
-#if defined(__GNUC__) || defined(__clang__)
-#prag=
ma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
=
-#endif
-
 static void
 crypto_pem_encode_decode_loopback(void **state)
 {
=
@@ -438,14 +433,14 @@
      * current mode (FIPS), this will still return -=
1 */
     assert_int_equal(cipher_get_aead_limits("CHACHA20-POLY1305"), 0);=

 
-    int64_t aeslimit =3D cipher_get_aead_limits("AES-128-GCM");
+    ui=
nt64_t aeslimit =3D cipher_get_aead_limits("AES-128-GCM");
 
     assert_in=
t_equal(aeslimit, (1ull << 36) - 1);
 
     /* Check if this matches our ex=
ception for 1600 size packets assuming
      * AEAD_LIMIT_BLOCKSIZE (128 bi=
ts/ 16 bytes)=2E Gives us 100 blocks
      * + 1 for the packet */
-    int=
64_t L =3D 101;
+    uint64_t L =3D 101;
     /* 2 ^ 29=2E34, using the res=
ult here to avoid linking to libm */
     assert_int_equal(aeslimit / L, 68=
0390858);
 
@@ -491,7 +486,7 @@
                          0xec, 0xed, 0xee,=
 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
                    =
      0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };
 
-    const int L =
=3D 82;
+    const size_t L =3D 82;
     uint8_t okm[82] =3D { 0xb1, 0x1e, =
0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1, 0xc8, 0xe7, 0xf7, 0x8c,
               =
          0x59, 0x6a, 0x49, 0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa,=
 0xd8,
                         0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0=
x7c, 0x59, 0x04, 0x5a, 0x99,
@@ -516,7 +511,7 @@
 
     const uint8_t info[=
] =3D { 0 };
 
-    int L =3D 42;
+    const size_t L =3D 42;
     uint8_t =
okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0=
x80,
                         0x2a, 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1=
f, 0x5c, 0x5e, 0xe1,
                         0x87, 0x9e, 0xc3, 0x45, 0x4e,=
 0x5f, 0x3c, 0x73, 0x8d, 0x2d, 0x9d,
@@ -541,7 +536,7 @@
     uint8_t info[=
18] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,
           =
               0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };
 
- =
   int L =3D 27;
+    const size_t L =3D 27;
     uint8_t okm[27] =3D { 0x8=
7, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80, 0xb8,
                        =
 0xd9, 0x33, 0xed, 0x32, 0x3c, 0x2d, 0xf8, 0xe8, 0xec,
                    =
     0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0, 0x6a, 0x83, 0xac };
@@ -753,7 +748=
,7 @@
 
     /* lookup some wacky things that should fail */
     assert_nu=
ll(epoch_lookup_decrypt_key(co, 2000));
-    assert_null(epoch_lookup_decry=
pt_key(co, -1));
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX))=
;
     assert_null(epoch_lookup_decrypt_key(co, 0xefff));
 
     /* Lookup =
the edges of the current window */
@@ -804,10 +799,6 @@
     assert_null(ep=
och_lookup_decrypt_key(co, 23));
 }
 
-#if defined(__GNUC__) || defined(__c=
lang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 crypto_test_epoch_key_=
overflow(void **state)
 {
diff --git a/tests/unit_tests/openvpn/test_networ=
king=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec
index ae75386=2E=2E=
3699a2a1 100644
--- a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/te=
sts/unit_tests/openvpn/test_networking=2Ec
@@ -40,23 +40,14 @@
     return =
net_iface_del(NULL, name);
 }
 
-#if defined(__GNUC__) || defined(__clang__=
)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conv=
ersion"
-#endif
-
 static int
-net__iface_mtu_set(int mtu)
+net__iface_mtu_=
set(uint32_t mtu)
 {
-    printf("CMD: ip link set %s mtu %d\n", iface, mtu=
);
+    printf("CMD: ip link set %s mtu %u\n", iface, mtu);
 
     return n=
et_iface_mtu_set(NULL, iface, mtu);
 }
 
-#if defined(__GNUC__) || defined(=
__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 net__addr_v4_=
add(const char *addr_str, int prefixlen)
 {
diff --git a/tests/unit_tests/o=
penvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 889e6d7=
=2E=2E49ba833 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/test=
s/unit_tests/openvpn/test_pkt=2Ec
@@ -618,11 +618,6 @@
     assert_memory_e=
qual(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);
 }
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC dia=
gnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 test_generate_r=
eset_packet_plain(void **ut_state)
 {
@@ -701,10 +696,6 @@
     free_tas(&t=
as_server);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC =
diagnostic pop
-#endif
-
 /* A peer can ask us to append the wrapped client=
 key (WKc) to our next
  * control packet=2E Only a tls-crypt-v2 client has=
 one, so check that we
  * refuse to build such a packet when we have no ke=
y instead of walking
diff --git a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index ab90ea5=2E=2E2d31c=
00 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/uni=
t_tests/openvpn/test_tls_crypt=2Ec
@@ -352,7 +352,7 @@
     skip_if_tls_cry=
pt_not_supported(ctx);
 
     buf_clear(&ctx->source);
-    assert_non_null=
(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLEN(&ctx->ciphertext)
+    a=
ssert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLENZ(&ctx->cip=
hertext)
                                                       - tls_crypt=
_buf_overhead()));
 
     assert_true(tls_crypt_wrap(&ctx->source, &ctx->ci=
phertext, &ctx->co));
@@ -373,7 +373,7 @@
     skip_if_tls_crypt_not_suppor=
ted(ctx);
 
     buf_clear(&ctx->source);
-    assert_non_null(buf_write_al=
loc(&ctx->source, TESTBUF_SIZE - BLEN(&ctx->ciphertext)
+    assert_non_nul=
l(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLENZ(&ctx->ciphertext)
    =
                                                   - tls_crypt_buf_overhead=
() + 1));
     assert_false(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, =
&ctx->co));
 }
@@ -553,7 +553,7 @@
     assert_false(tls_crypt_v2_extract_c=
lient_key(&ctx->wkc, &wrap_ctx, NULL));
 
     /* add a opcode in front of =
the key to make it valid to extract */
-    struct buffer wkcop =3D alloc_b=
uf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc);
+    struct buffer wkcop =3D alloc=
_buf_gc(BLENZ(&ctx->wkc) + 1, &ctx->gc);
     buf_write_u8(&wkcop, 0x50);
 =
    buf_copy(&wkcop, &ctx->wkc);
     assert_true(tls_crypt_v2_extract_clie=
nt_key(&wkcop, &wrap_ctx, NULL));
@@ -638,7 +638,7 @@
     int64_t create_t=
ime =3D now - (days_ago * 24 * 60 * 60);
     assert_true(create_time > 0);=

 
-    int64_t timestamp =3D htonll((uint64_t)create_time);
+    uint64_t =
timestamp =3D htonll((uint64_t)create_time);
     ASSERT(buf_write(&metadat=
a, &TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));
     ASSERT(buf_write(&metadata=
, &timestamp, sizeof(timestamp)));
 
@@ -660,7 +660,7 @@
                  =
                            &ctx->server_keys=2Eencrypt, &ctx->gc));
 
    =
 /* add a opcode in front of the key to make it valid to extract */
-    st=
ruct buffer pseudo_packet =3D alloc_buf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc=
);
+    struct buffer pseudo_packet =3D alloc_buf_gc(BLENZ(&ctx->wkc) + 1, =
&ctx->gc);
 
     buf_write_u8(&pseudo_packet, 0x50);
     buf_copy(&pseudo=
_packet, &ctx->wkc);
@@ -745,7 +745,7 @@
     struct buffer expected_metada=
ta =3D create_metadata_days_ago(&ctx->gc, 29);
     buf_advance(&expected_m=
etadata, 1);
 
-    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&=
expected_metadata), buf_len(&expected_metadata));
+    expect_memory(__wrap=
_buffer_write_file, pem, buf_bptr(&expected_metadata), BLENZ(&expected_meta=
data));
     will_return(__wrap_buffer_write_file, true);
 
     tmp =3D cr=
eate_client_key_input(ctx, 29);
@@ -760,7 +760,7 @@
     }
 
     expect_st=
ring(__wrap_buffer_write_file, filename, tmpfile_path);
-    expect_memory(=
__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), buf_len(&expec=
ted_metadata));
+    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(=
&expected_metadata), BLENZ(&expected_metadata));
     will_return(__wrap_bu=
ffer_write_file, true);
 
     tmp =3D create_client_key_input(ctx, 29);

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02f8df01f8f33c=
b9cd04cd844d1f1893688f51e8
Gerrit-Change-Number: 2157
Gerrit-PatchSet: 6
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--40fgYZ+vfu4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #6</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2157?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Various trivial -Wsign=
-conversion fixes<br><br>* Continue BLEN -&gt; BLENZ replacement<br>* Remov=
e some unneeded casts<br>* Some trivial type fixes<br><br>Change-Id: I02f8d=
f01f8f33cb9cd04cd844d1f1893688f51e8<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157=
<br>Message-Id: &lt;20261110143722=2E15193-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg41094=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/acc=2Ec<br>M src/openvpn/auth_token=2Ec<b=
r>M src/openvpn/base64=2Eh<br>M src/openvpn/console_builtin=2Ec<br>M src/op=
envpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/crypto_epoch=
=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M test=
s/unit_tests/openvpn/test_crypto=2Ec<br>M tests/unit_tests/openvpn/test_net=
working=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>M tests/unit_test=
s/openvpn/test_tls_crypt=2Ec<br>13 files changed, 49 insertions(+), 95 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/57/2157/6</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/acc=2E=
c b/src/openvpn/acc=2Ec</span><br><span>index ceb7100=2E=2Edae614a 100644</=
span><br><span>--- a/src/openvpn/acc=2Ec</span><br><span>+++ b/src/openvpn/=
acc=2Ec</span><br><span>@@ -148,11 +148,6 @@</span><br><span>     return pa=
rse_acc_message_flags(flags, err_reason, gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><spa=
n> receive_acc_message(struct context *c, const struct buffer *buffer)</spa=
n><br><span> {</span><br><span>@@ -236,15 +231,10 @@</span><br><span>     m=
sg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app control chan=
nel &quot;</span><br><span>                        &quot;message (%s): %s&q=
uot;,</span><br><span>         err_reason,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        format_hex(CBPTR(buffer), BLEN(buffer), 80, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
mat_hex(CBPTR(buffer), BLENZ(buffer), 80, &amp;gc));</span><br><span>     g=
c_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> send_acc_mes=
sage(struct context *c,</span><br><span>                  struct tls_multi =
*multi,</span><br><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openv=
pn/auth_token=2Ec</span><br><span>index 211af90=2E=2Eb69092c 100644</span><=
br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn=
/auth_token=2Ec</span><br><span>@@ -36,11 +36,6 @@</span><br><span>  * padd=
ing */</span><br><span> static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TO=
KEN_DATA_LEN is not a multiple of 3&quot;);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> bool</span><br><span> is_auth_token(cons=
t char *password)</span><br><span> {</span><br><span>@@ -67,7 +62,7 @@</spa=
n><br><span>         return;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int auth_token_state_fl=
ags =3D session-&gt;key[KS_PRIMARY]=2Eauth_token_state_flags;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    unsigned int auth_token_state=
_flags =3D session-&gt;key[KS_PRIMARY]=2Eauth_token_state_flags;</span><br>=
<span> </span><br><span>     const char *state;</span><br><span> </span><br=
><span>@@ -188,7 +183,7 @@</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int64_t timestamp =3D htonll((uint64_t)now);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t timestamp =3D=
 (int64_t)htonll((uint64_t)now);</span><br><span>     int64_t initial_times=
tamp =3D timestamp;</span><br><span> </span><br><span>     hmac_ctx_t *ctx =
=3D multi-&gt;opt=2Eauth_token_key=2Ehmac;</span><br><span>@@ -273,7 +268,7=
 @@</span><br><span>         alloc_buf_gc(strlen(SESSION_ID_PREFIX) + strle=
n(b64output) + 1, &amp;gc);</span><br><span> </span><br><span>     ASSERT(b=
uf_write(&amp;session_token, SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_write=
(&amp;session_token, b64output, (int)strlen(b64output)));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_write(&amp;session_tok=
en, b64output, strlen(b64output)));</span><br><span>     ASSERT(buf_write_u=
8(&amp;session_token, 0));</span><br><span> </span><br><span>     free(b64o=
utput);</span><br><span>@@ -296,10 +291,6 @@</span><br><span>     gc_free(&=
amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br=
><span> check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const =
char *username)</span><br><span> {</span><br><span>diff --git a/src/openvpn=
/base64=2Eh b/src/openvpn/base64=2Eh</span><br><span>index be7aa64=2E=2E800=
e569 100644</span><br><span>--- a/src/openvpn/base64=2Eh</span><br><span>++=
+ b/src/openvpn/base64=2Eh</span><br><span>@@ -35,7 +35,7 @@</span><br><spa=
n> #define _BASE64_H_</span><br><span> </span><br><span> /** Compute result=
ing base64 length=2E  6 bits per byte, padded to 4 bytes=2E */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_BASE64_LENGTH(bina=
ry_length) ((((8 * binary_length) / 6) + 3) &amp; ~3)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_BASE64_LENGTH(binary_leng=
th) ((((8 * binary_length) / 6) + 3) &amp; ~3u)</span><br><span> </span><br=
><span> /** Compute the maximal number of bytes encoded in a base64 string=
=2E */</span><br><span> #define OPENVPN_BASE64_DECODED_LENGTH(base64_length=
) ((base64_length / 4) * 3)</span><br><span>diff --git a/src/openvpn/consol=
e_builtin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><span>index dc71d=
12=2E=2E0353ade 100644</span><br><span>--- a/src/openvpn/console_builtin=2E=
c</span><br><span>+++ b/src/openvpn/console_builtin=2Ec</span><br><span>@@ =
-234,7 +234,7 @@</span><br><span>     if (!echo &amp;&amp; (tcgetattr(filen=
o(fp), &amp;tty_tmp) =3D=3D 0))</span><br><span>     {</span><br><span>    =
     tty_save =3D tty_tmp;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        tty_tmp=2Ec_lflag &amp;=3D ~(ECHO | ECHOE | ECHOK | ECHONL | I=
SIG);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tty_tm=
p=2Ec_lflag &amp;=3D ~(unsigned int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);=
</span><br><span>         restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH,=
 &amp;tty_tmp) =3D=3D 0);</span><br><span>     }</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span>=
<br><span>index 9d53006=2E=2E5ad4b5f 100644</span><br><span>--- a/src/openv=
pn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>=
@@ -139,7 +139,7 @@</span><br><span>         ASSERT(cipher_ctx_reset(ctx-&g=
t;cipher, iv));</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT=
 FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &qu=
ot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));=
</span><br><span> </span><br><span>     /* Buffer overflow check */</span><=
br><span>     if (!buf_safe(&amp;work, buf-&gt;len + mac_len + cipher_ctx_b=
lock_size(ctx-&gt;cipher)))</span><br><span>@@ -151,7 +151,7 @@</span><br><=
span> </span><br><span>     /* For AEAD ciphers, authenticate Additional Da=
ta, including opcode */</span><br><span>     ASSERT(cipher_ctx_update_ad(ct=
x-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work)));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s=
&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &=
quot;ENCRYPT AD: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 0,=
 &amp;gc));</span><br><span> </span><br><span>     if (!use_epoch_data_form=
at)</span><br><span>     {</span><br><span>@@ -170,8 +170,8 @@</span><br><s=
pan> </span><br><span>     /* update number of plaintext blocks encrypted=
=2E Use the (x + (n-1))/n trick</span><br><span>      * to round up the res=
ult to the number of blocks used */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;key_ctx_bi=2Eencrypt=
=2Eplaintext_blocks +=3D (BLEN(&amp;work) + (blocksize - 1)) / blocksize;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned in=
t blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    opt-&gt;key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D =
(BLENZ(&amp;work) + (blocksize - 1)) / blocksize;</span><br><span> </span><=
br><span>     /* if the tag is at end the end, allocate it now */</span><br=
><span>     if (use_epoch_data_format)</span><br><span>@@ -186,7 +186,7 @@<=
/span><br><span> </span><br><span>     *buf =3D work;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT=
, &quot;ENCRYPT TO: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET=
_CONTENT, &quot;ENCRYPT TO: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80,=
 &amp;gc));</span><br><span> </span><br><span>     gc_free(&amp;gc);</span>=
<br><span>     return;</span><br><span>@@ -257,13 +257,13 @@</span><br><spa=
n>             ASSERT(buf_write(&amp;work, iv_buf, iv_size));</span><br><sp=
an>             dmsg(D_PACKET_CONTENT, &quot;ENCRYPT IV: %s&quot;, format_h=
ex(iv_buf, iv_size, 0, &amp;gc));</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTENT, &quot;EN=
CRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_PACKET=
_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 8=
0, &amp;gc));</span><br><span> </span><br><span>             /* cipher_ctx =
was already initialized with key &amp; keylen */</span><br><span>          =
   ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv_buf));</span><br><span> </spa=
n><br><span>             /* Buffer overflow check */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!buf_safe(&amp;work, buf-&g=
t;len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!buf_safe(&amp;work, BLENZ(buf)=
 + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>             {</=
span><br><span>                 msg(D_CRYPT_ERRORS,</span><br><span>       =
              &quot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=
=3D%d wo=3D%d wl=3D%d cbs=3D%u&quot;,</span><br><span>@@ -317,7 +317,7 @@</=
span><br><span> </span><br><span>         *buf =3D work;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_=
CONTENT, &quot;ENCRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;=
work), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, format_hex(BPT=
R(&amp;work), BLENZ(&amp;work), 80, &amp;gc));</span><br><span>     }</span=
><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>@@ -456=
,7 +456,7 @@</span><br><span>     ASSERT(buf-&gt;len &gt; 0);</span><br><sp=
an>     ASSERT(ctx-&gt;cipher);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: =
%s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECR=
YPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span>=
<br><span> </span><br><span>     ASSERT(ad_start &gt;=3D buf-&gt;data &amp;=
&amp; ad_start &lt;=3D BPTR(buf));</span><br><span> </span><br><span>@@ -55=
4,10 +554,10 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, =
tag_size, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(=
buf), BLEN(buf), 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_=
hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));</span><br><span> </span><br><span>=
     /* Buffer overflow check (should never fail) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt;len + =
cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!buf_safe(&amp;work, BLENZ(buf) + cipher_ctx_bl=
ock_size(ctx-&gt;cipher)))</span><br><span>     {</span><br><span>         =
CRYPT_ERROR(&quot;potential buffer overflow&quot;);</span><br><span>     }<=
/span><br><span>@@ -581,7 +581,7 @@</span><br><span>     }</span><br><span>=
     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;D=
ECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &amp;=
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PAC=
KET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(=
&amp;work), 80, &amp;gc));</span><br><span> </span><br><span>     if (!cryp=
to_check_replay(opt, &amp;pin, epoch, error_prefix, &amp;gc))</span><br><sp=
an>     {</span><br><span>@@ -590,8 +590,8 @@</span><br><span> </span><br><=
span>     /* update number of plaintext blocks decrypted=2E Use the (x + (n=
-1))/n trick</span><br><span>      * to round up the result to the number o=
f blocks used=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    opt-&gt;key_ctx_bi=2Edecrypt=2Eplaintext_bloc=
ks +=3D (BLEN(&amp;work) + (blocksize - 1)) / blocksize;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const unsigned int blocksize =3D A=
EAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    opt-&gt;key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLENZ(&amp;work)=
 + (blocksize - 1)) / blocksize;</span><br><span> </span><br><span>     *bu=
f =3D work;</span><br><span> </span><br><span>@@ -627,7 +627,7 @@</span><br=
><span>         struct packet_id_net pin;</span><br><span>         bool hav=
e_pin =3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, f=
ormat_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        dmsg(D_PACKET_CONTENT, &quot;DECRYPT FRO=
M: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><sp=
an> </span><br><span>         /* Verify the HMAC */</span><br><span>       =
  if (ctx-&gt;hmac)</span><br><span>@@ -690,7 +690,7 @@</span><br><span>   =
          }</span><br><span> </span><br><span>             /* Buffer overfl=
ow check (should never happen) */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_b=
lock_size(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!buf_safe(&amp;work, BLENZ(buf) + cipher_ctx_block_=
size(ctx-&gt;cipher)))</span><br><span>             {</span><br><span>     =
            CRYPT_ERROR(&quot;packet too big to decrypt&quot;);</span><br><=
span>             }</span><br><span>@@ -709,7 +709,7 @@</span><br><span>   =
          }</span><br><span>             ASSERT(buf_inc_len(&amp;work, outl=
en));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex=
(BPTR(&amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            dmsg(D_PACKET_CONTENT, &quot;DECR=
YPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &amp;gc=
));</span><br><span> </span><br><span>             /* Get packet ID from pl=
aintext buffer or IV, depending on cipher mode */</span><br><span>         =
    {</span><br><span>@@ -851,7 +851,7 @@</span><br><span> crypto_max_overh=
ead(void)</span><br><span> {</span><br><span>     return packet_id_size(tru=
e) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_CIPHER_BLOCK_SIZE</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           + max_int(OPENVPN_MAX_HMAC_=
SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_L=
ENGTH);</span><br><span> }</span><br><span> </span><br><span> static void</=
span><br><span>@@ -1362,7 +1362,7 @@</span><br><span>         size_t buf_si=
ze =3D strlen(file) + 1;</span><br><span>         ASSERT(buf_size &lt;=3D I=
NT_MAX);</span><br><span>         size =3D (int)buf_size;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        buf_set_read(&amp;in, (const ui=
nt8_t *)file, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        buf_set_read(&amp;in, (const uint8_t *)file, buf_size);</span><br>=
<span>     }</span><br><span>     else /* &#39;file&#39; is a filename whic=
h refers to a file containing the ascii key */</span><br><span>     {</span=
><br><span>@@ -1531,7 +1531,7 @@</span><br><span>     struct buffer out =3D=
 alloc_buf_gc(2048, &amp;gc);</span><br><span> </span><br><span>     /* how=
 to format the ascii file representation of key */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const int bytes_per_line =3D 16;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int bytes_=
per_line =3D 16;</span><br><span> </span><br><span>     /* write header */<=
/span><br><span>     buf_printf(&amp;out, &quot;#\n# %d bit OpenVPN static =
key\n#\n&quot;, nbits);</span><br><span>diff --git a/src/openvpn/crypto=2Eh=
 b/src/openvpn/crypto=2Eh</span><br><span>index 7e240d2=2E=2Ef0cacde 100644=
</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/ope=
nvpn/crypto=2Eh</span><br><span>@@ -746,12 +746,12 @@</span><br><span>  * t=
o read=2E</span><br><span>  */</span><br><span> static inline bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-aead_usage_limit_reached(const=
 uint64_t limit, const struct key_ctx *key_ctx, int64_t higest_pid)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+aead_usage_limit_reached(co=
nst uint64_t limit, const struct key_ctx *key_ctx, uint64_t higest_pid)</sp=
an><br><span> {</span><br><span>     /* This is the  q + s &lt;=3D  p^(1/2)=
 * 2^(129/2) - 1 calculation where</span><br><span>      * q is the number =
of protected messages (highest_pid)</span><br><span>      * s Total plainte=
xt length in all messages (in blocks) */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return (limit &gt; 0 &amp;&amp; key_ctx-&gt;plaintex=
t_blocks + (uint64_t)higest_pid &gt; limit);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return (limit &gt; 0 &amp;&amp; key_ctx-&gt;pl=
aintext_blocks + higest_pid &gt; limit);</span><br><span> }</span><br><span=
> </span><br><span> #endif /* CRYPTO_H */</span><br><span>diff --git a/src/=
openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><span>ind=
ex 312cf6f=2E=2E243b5a2 100644</span><br><span>--- a/src/openvpn/crypto_epo=
ch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br><span>@=
@ -98,7 +98,7 @@</span><br><span>     const uint8_t *label_prefix =3D (cons=
t uint8_t *)(&quot;ovpn &quot;);</span><br><span>     uint8_t prefix_len =
=3D 5;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    size_t hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + conte=
xt_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t h=
kdf_label_len =3D 2u + prefix_len + 1u + label_len + 1u + context_len;</spa=
n><br><span>     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, =
&amp;gc);</span><br><span> </span><br><span>     buf_write_u16(&amp;hkdf_la=
bel, (uint16_t)out_len);</span><br><span>diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec</span><br><span>index 4809532=2E=2E1760c90 10064=
4</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/op=
envpn/manage=2Ec</span><br><span>@@ -2758,7 +2758,7 @@</span><br><span>    =
         else</span><br><span>             {</span><br><span>              =
   int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | G=
ETADDR_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          unsigned int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_=
SIGNAL | GETADDR_FATAL;</span><br><span> </span><br><span>                 =
if (!(flags &amp; MF_CONNECT_AS_CLIENT))</span><br><span>                 {=
</span><br><span>@@ -4001,11 +4001,11 @@</span><br><span>         desc =3D =
&quot;rsa-sign&quot;;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf_data, b64_d=
ata, (int)strlen(b64_data));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_write(&amp;buf_data, b64_data, strlen(b64_data));</span><b=
r><span>     if (man-&gt;connection=2Eclient_version &gt;=3D MCV_PKSIGN_ALG=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        buf_write(&amp;buf_data, &quot;,&quot;, (int)strlen(&quot;,&quot=
;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write=
(&amp;buf_data, algorithm, (int)strlen(algorithm));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;buf_data, &quot;,&=
quot;, strlen(&quot;,&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_write(&amp;buf_data, algorithm, strlen(algorithm));<=
/span><br><span>     }</span><br><span>     char *ret =3D management_query_=
multiline_flatten(man, (char *)buf_bptr(&amp;buf_data), prompt, desc,</span=
><br><span>                                                    &amp;man-&gt=
;connection=2Eext_key_state,</span><br><span>diff --git a/src/openvpn/ssl_m=
bedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index cbc3118=2E=
=2Ef4e142b 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><=
br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1119,7 +1119=
,7 @@</span><br><span>         return 0;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D =
endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(buf), buf-&gt;len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    retval =3D endless_b=
uf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(buf), BLENZ(buf));</span><br><spa=
n> </span><br><span>     if (retval &lt; 0)</span><br><span>     {</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_=
tests/openvpn/test_crypto=2Ec</span><br><span>index e68a0b2=2E=2E6ccca33 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2Ec</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>@@ =
-52,11 +52,6 @@</span><br><span> </span><br><span> static const char testte=
xt[] =3D &quot;Dummy text to test PEM encoding&quot;;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> c=
rypto_pem_encode_decode_loopback(void **state)</span><br><span> {</span><br=
><span>@@ -438,14 +433,14 @@</span><br><span>      * current mode (FIPS), t=
his will still return -1 */</span><br><span>     assert_int_equal(cipher_ge=
t_aead_limits(&quot;CHACHA20-POLY1305&quot;), 0);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t aeslimit =3D ciph=
er_get_aead_limits(&quot;AES-128-GCM&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint64_t aeslimit =3D cipher_get_aead_limits(&=
quot;AES-128-GCM&quot;);</span><br><span> </span><br><span>     assert_int_=
equal(aeslimit, (1ull &lt;&lt; 36) - 1);</span><br><span> </span><br><span>=
     /* Check if this matches our exception for 1600 size packets assuming<=
/span><br><span>      * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes)=2E Gives =
us 100 blocks</span><br><span>      * + 1 for the packet */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int64_t L =3D 101;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint64_t L =3D 101;</span><br>=
<span>     /* 2 ^ 29=2E34, using the result here to avoid linking to libm *=
/</span><br><span>     assert_int_equal(aeslimit / L, 680390858);</span><br=
><span> </span><br><span>@@ -491,7 +486,7 @@</span><br><span>              =
            0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf=
6, 0xf7,</span><br><span>                          0xf8, 0xf9, 0xfa, 0xfb, =
0xfc, 0xfd, 0xfe, 0xff };</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const int L =3D 82;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const size_t L =3D 82;</span><br><span>     u=
int8_t okm[82] =3D { 0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1, 0xc8, =
0xe7, 0xf7, 0x8c,</span><br><span>                         0x59, 0x6a, 0x49=
, 0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,</span><br><span>   =
                      0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c, 0x59,=
 0x04, 0x5a, 0x99,</span><br><span>@@ -516,7 +511,7 @@</span><br><span> </s=
pan><br><span>     const uint8_t info[] =3D { 0 };</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int L =3D 42;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const size_t L =3D 42;</sp=
an><br><span>     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63,=
 0xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><span>                         0x2=
a, 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1,</span><br><s=
pan>                         0x87, 0x9e, 0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73=
, 0x8d, 0x2d, 0x9d,</span><br><span>@@ -541,7 +536,7 @@</span><br><span>   =
  uint8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x=
75,</span><br><span>                          0x6e, 0x69, 0x74, 0x20, 0x74,=
 0x65, 0x73, 0x74, 0x00 };</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int L =3D 27;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const size_t L =3D 27;</span><br><span>     uint8_=
t okm[27] =3D { 0x87, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80, 0xb8,</span=
><br><span>                         0xd9, 0x33, 0xed, 0x32, 0x3c, 0x2d, 0xf=
8, 0xe8, 0xec,</span><br><span>                         0xcf, 0x49, 0x72, 0=
xe6, 0x83, 0xf0, 0x6a, 0x83, 0xac };</span><br><span>@@ -753,7 +748,7 @@</s=
pan><br><span> </span><br><span>     /* lookup some wacky things that shoul=
d fail */</span><br><span>     assert_null(epoch_lookup_decrypt_key(co, 200=
0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_null(e=
poch_lookup_decrypt_key(co, -1));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));</s=
pan><br><span>     assert_null(epoch_lookup_decrypt_key(co, 0xefff));</span=
><br><span> </span><br><span>     /* Lookup the edges of the current window=
 */</span><br><span>@@ -804,10 +799,6 @@</span><br><span>     assert_null(e=
poch_lookup_decrypt_key(co, 23));</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> void</span><br><span> crypto_test_epoch_key_overflow(void **state)</spa=
n><br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_n=
etworking=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><spa=
n>index ae75386=2E=2E3699a2a1 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_networking=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_networking=2Ec</span><br><span>@@ -40,23 +40,14 @@</span><br><span>  =
   return net_iface_del(NULL, name);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-net__iface_mtu_set(int mtu)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+net__iface_mtu_set(uint32_t mtu=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   printf(&quot;CMD: ip link set %s mtu %d\n&quot;, iface, mtu);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;CMD: ip link =
set %s mtu %u\n&quot;, iface, mtu);</span><br><span> </span><br><span>     =
return net_iface_mtu_set(NULL, iface, mtu);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> static int</span><br><span> net__addr_v4_add(const char *addr=
_str, int prefixlen)</span><br><span> {</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</sp=
an><br><span>index 889e6d7=2E=2E49ba833 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_pkt=2Ec</span><br><span>@@ -618,11 +618,6 @@</span><br><span>     =
assert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> static void</span><br><span> test_generate_reset_packet_plain(void **u=
t_state)</span><br><span> {</span><br><span>@@ -701,10 +696,6 @@</span><br>=
<span>     free_tas(&amp;tas_server);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> /* A peer can ask us to append the wrapped client key (WKc) to our =
next</span><br><span>  * control packet=2E Only a tls-crypt-v2 client has o=
ne, so check that we</span><br><span>  * refuse to build such a packet when=
 we have no key instead of walking</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>index ab90ea5=2E=2E2d31c00 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -352,7 +352,7 @@</s=
pan><br><span>     skip_if_tls_crypt_not_supported(ctx);</span><br><span> <=
/span><br><span>     buf_clear(&amp;ctx-&gt;source);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_non_null(buf_write_alloc(&amp;ct=
x-&gt;source, TESTBUF_SIZE - BLEN(&amp;ctx-&gt;ciphertext)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(buf_write_alloc(=
&amp;ctx-&gt;source, TESTBUF_SIZE - BLENZ(&amp;ctx-&gt;ciphertext)</span><b=
r><span>                                                       - tls_crypt_=
buf_overhead()));</span><br><span> </span><br><span>     assert_true(tls_cr=
ypt_wrap(&amp;ctx-&gt;source, &amp;ctx-&gt;ciphertext, &amp;ctx-&gt;co));</=
span><br><span>@@ -373,7 +373,7 @@</span><br><span>     skip_if_tls_crypt_n=
ot_supported(ctx);</span><br><span> </span><br><span>     buf_clear(&amp;ct=
x-&gt;source);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_non_null(buf_write_alloc(&amp;ctx-&gt;source, TESTBUF_SIZE - BLEN(&amp;=
ctx-&gt;ciphertext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_non_null(buf_write_alloc(&amp;ctx-&gt;source, TESTBUF_SIZE - BLE=
NZ(&amp;ctx-&gt;ciphertext)</span><br><span>                               =
                        - tls_crypt_buf_overhead() + 1));</span><br><span> =
    assert_false(tls_crypt_wrap(&amp;ctx-&gt;source, &amp;ctx-&gt;ciphertex=
t, &amp;ctx-&gt;co));</span><br><span> }</span><br><span>@@ -553,7 +553,7 @=
@</span><br><span>     assert_false(tls_crypt_v2_extract_client_key(&amp;ct=
x-&gt;wkc, &amp;wrap_ctx, NULL));</span><br><span> </span><br><span>     /*=
 add a opcode in front of the key to make it valid to extract */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer wkcop =3D allo=
c_buf_gc(buf_len(&amp;ctx-&gt;wkc) + 1, &amp;ctx-&gt;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer wkcop =3D alloc_buf=
_gc(BLENZ(&amp;ctx-&gt;wkc) + 1, &amp;ctx-&gt;gc);</span><br><span>     buf=
_write_u8(&amp;wkcop, 0x50);</span><br><span>     buf_copy(&amp;wkcop, &amp=
;ctx-&gt;wkc);</span><br><span>     assert_true(tls_crypt_v2_extract_client=
_key(&amp;wkcop, &amp;wrap_ctx, NULL));</span><br><span>@@ -638,7 +638,7 @@=
</span><br><span>     int64_t create_time =3D now - (days_ago * 24 * 60 * 6=
0);</span><br><span>     assert_true(create_time &gt; 0);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t timestamp=
 =3D htonll((uint64_t)create_time);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint64_t timestamp =3D htonll((uint64_t)create_time);</=
span><br><span>     ASSERT(buf_write(&amp;metadata, &amp;TLS_CRYPT_METADATA=
_TYPE_TIMESTAMP, 1));</span><br><span>     ASSERT(buf_write(&amp;metadata, =
&amp;timestamp, sizeof(timestamp)));</span><br><span> </span><br><span>@@ -=
660,7 +660,7 @@</span><br><span>                                           =
   &amp;ctx-&gt;server_keys=2Eencrypt, &amp;ctx-&gt;gc));</span><br><span> =
</span><br><span>     /* add a opcode in front of the key to make it valid =
to extract */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct buffer pseudo_packet =3D alloc_buf_gc(buf_len(&amp;ctx-&gt;wkc) + 1, &am=
p;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer pseudo_packet =3D alloc_buf_gc(BLENZ(&amp;ctx-&gt;wkc) + 1, &a=
mp;ctx-&gt;gc);</span><br><span> </span><br><span>     buf_write_u8(&amp;ps=
eudo_packet, 0x50);</span><br><span>     buf_copy(&amp;pseudo_packet, &amp;=
ctx-&gt;wkc);</span><br><span>@@ -745,7 +745,7 @@</span><br><span>     stru=
ct buffer expected_metadata =3D create_metadata_days_ago(&amp;ctx-&gt;gc, 2=
9);</span><br><span>     buf_advance(&amp;expected_metadata, 1);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_mem=
ory(__wrap_buffer_write_file, pem, buf_bptr(&amp;expected_metadata), buf_le=
n(&amp;expected_metadata));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&amp;expe=
cted_metadata), BLENZ(&amp;expected_metadata));</span><br><span>     will_r=
eturn(__wrap_buffer_write_file, true);</span><br><span> </span><br><span>  =
   tmp =3D create_client_key_input(ctx, 29);</span><br><span>@@ -760,7 +760=
,7 @@</span><br><span>     }</span><br><span> </span><br><span>     expect_=
string(__wrap_buffer_write_file, filename, tmpfile_path);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    expect_memory(__wrap_buffer_write_f=
ile, pem, buf_bptr(&amp;expected_metadata), buf_len(&amp;expected_metadata)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_memory=
(__wrap_buffer_write_file, pem, buf_bptr(&amp;expected_metadata), BLENZ(&am=
p;expected_metadata));</span><br><span>     will_return(__wrap_buffer_write=
_file, true);</span><br><span> </span><br><span>     tmp =3D create_client_=
key_input(ctx, 29);</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail">change 2157</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02f8df01f8f=
33cb9cd04cd844d1f1893688f51e8 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2157 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--40fgYZ+vfu4=--


--===============3161070273338442763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3161070273338442763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3161070273338442763==--


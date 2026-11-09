Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1F606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kdLxYw7G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cII7jAZJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bhq5shxR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OeivqkWO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=OjMZcjHtAJZYGxZ05R/2pvbaiCh44IFUclKlvFKDndQ=; b=kdLxYw7GN3mpY8v/zkOph1l4c2
	AU81IVdkCmrGee43YQFtI0Nu4fRGikA33mcIvtRxE6apo8vy4t0t6ep2QAYdKJNJIKVrZm9eFI1lp
	sEoudiobQyiGgKVPqAD7aP9cl9Js09pDnGkjq18hHAYqMxKlGYcLhPjsqhJ5LqrG1cCo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQXRp-000000007WA-3hJd;
	Mon, 09 Nov 2026 22:02:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQXRo-000000007W2-1MfY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 22:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4xRn00bheyMSQ/Hv1ZhtPHUDfw5nweDRWFTcAxdgVHE=; b=cII7jAZJSOGa8RuuE1CYAVW/P2
 swB2BAYyWDtKzWZdEXTGFHQHxSVLQeB65zGdtHbXuHccqyxk1RnNSSEPENRx/0XDHKrdUf/T2ZG/A
 k+5kWlNbP5SFTv6t/F0wb29zN7rkIn2YxNGgfVlkw8vZG3dRjQ8OFA6rP5sJnKq3NG5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4xRn00bheyMSQ/Hv1ZhtPHUDfw5nweDRWFTcAxdgVHE=; b=bhq5shxRa0Ux79YXk/9bkF3+ww
 iN2Dqluj1pReyaSi7XyERuwKRrGD5e/DKIaKjUn20tGcdRXsWPcR1R/j4q0rUtWFdxGP8pmOmlkFw
 mdxPptO10HTLue0GFKCXVX2jRYYVqyPMky20aSjmjjDZLxmWWL4/rpliBS8hyOsEjnI4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQXRl-000000001l8-2wpl for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 22:02:40 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4919a880834so882230f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 14:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794261751; x=1794866551; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4xRn00bheyMSQ/Hv1ZhtPHUDfw5nweDRWFTcAxdgVHE=;
 b=OeivqkWOY3f978FmdwUq76+B9uNLTanCV44LAw4pLRVbOd5DAb5MTqe5gqAKei4xJN
 A8cAPsx+297e/FVKJzLCd166K7IMx1170vBDo8j/7+yz1/7MmcSwF4FZfSu4MYAI0gLZ
 EUn2mf2MMV5G8GoJ01HDGguuFaezMw4WnYGzh4KDMfNoW3WbuwiBNvgQI2Qb/N3wY1Wn
 GdqMYoLglRTWpVsluHSjM+0rcO4RCp/ptYDWU64sxgWSq6sSxR1nnBPo7dNGajCi2tYp
 js7dP3rNretcY9OvaphQkUHAuA+eGix5CpcGKFePH5VSTZdqTv/bIsauEnavh3z2CEd0
 f7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261751; x=1794866551;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4xRn00bheyMSQ/Hv1ZhtPHUDfw5nweDRWFTcAxdgVHE=;
 b=O4iuE/dBumykjdsOAh+AXlhn5VWN2q17Du4ss4uxe4alFCraGBdVQhhNL8j2ZeUi0X
 lQ1WZLFDkHE9H6nHWzP27/CIr+p9vKjL2ChxM4NymDlsaovLBe+OwQ7j6gdw36sGTB4W
 yIJ4DI7yvfoymKK9yPx7ANw1MIDomvXIvmtWncNFlXabyKHgPMxUXMLju0ORBSHAfino
 4XjY2p5YYGXkcpn1HXzwljcsJT4053DSodfVcpl8QU5iadFN2dTJHhoC7+0OyIKvWpAV
 6c30asNRo327GH1irbnILaqO1kdoSomnFaqPD69lRJYQ1V0oHmtlV/0AN8ACkHHYNCT2
 8CEw==
X-Gm-Message-State: APuU4Z8271haDckF/wfJarOnKEIuStlCfzaIYHZFrMXWL0mhZmCtr0OQ
 +VtniZikxkmkGDY6Kn0Q5q29a0mRBj/JyKmAXuhnR4LBKgWeMKRQQ2MvjE0toCHaY3XYPtjLKcm
 qGcScASovTSoUf/zdmwmmEyiuXO3IAO+UWIjuDiC6nxJwSH533cKjJMYFc+4+93YmTEzL1VuIT9
 jlrfxjfA==
X-Gm-Gg: AYBFou0n1+xyBjxKC9SxiIkEAo6GwLI+j/U//6rk6Dg0V7QmxihP+Xm/NJNbsyk2v4+
 e3jOJr2KK+Xfrg7AqqDcsidsQwu2n9hnZd9WsTpF2hKo/Rlk9rEDGUOnyy+NYJ0wdg9inMs6bFA
 kHetARLelHk6vCVU7JcqxWz6bKznZA9/jk8zCllhf2qPXvF9E7GFPU4Whu4Lpimss07F7ROiw4B
 nxSAWx5UMSYW12yNZCSKcvkih1TUZnLYgzG/wlp0Cu6bX2COd3x1S5sP2uIadKx/nm+UHC38ABe
 SGuvpRgp9uYQdi9WipYgv2CDfpYD8zV01/6rWxlEfaF7eHw+YQo4I8ClOd7PxBpnVXm0b6jdBkI
 DHlYsmitPQ4JEdYMPS5sWHPNrCWRsouHWx2dx00Saq9wc2m82MlnPYAcKisVT4AC/+kihkbxYV2
 ajjEKL2lT6xEKlMifOFBwGQrTyISxzcLzuZVNyl/SJRApg2UGRudqOZwozJxSH5s2r1CoDMvF/8
 4KKZAsyukopXoeM8lFv3axkTKlxc/b4hFmEHi6kleivm4594ICxU7zLu1bUHZpV/n64ycxszRvO
 R1Yt2/iLWKRS57nBprwq8K814x2nAtSN5cvOCQaS3m8wXTyt6ug+IKEZCWRXB1KgeOVrvTLLcTQ
 ngpcu0pLRfQ/Zz61PcO1joDqWtFMU00xM7/8JGF5ATsuuo9o+9LrNoRKVi8Y5m56P6iSg5+G711
 Ax28+S4Jhb/4bJxA==
X-Received: by 2002:a05:600c:3e14:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4ba0233fa1dmr7631325e9.9.1794261750837; 
 Mon, 09 Nov 2026 14:02:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01ff3428sm19670305e9.15.2026.11.09.14.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:02:30 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 22:02:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: 29bfe04c375fa07c0ce3ac3284b7ae4695b47b50
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67e7844197d0db341f195350f1f323f7abdb151d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQXRl-000000001l8-2wpl
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0192627008313446418=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0192627008313446418==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dFGWpH9kO+8="; charset=UTF-8

--dFGWpH9kO+8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2157?usp=3Demail

to review the following change=2E
=


Change subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Various trivial -Wsign-conve=
rsion fixes

* Continue BLEN -> BLENZ replacement
* Remove some unneeded ca=
sts
* Some trivial type fixes

Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893=
688f51e8
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M s=
rc/openvpn/acc=2Ec
M src/openvpn/auth_token=2Ec
M src/openvpn/base64=2Eh
M =
src/openvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/cryp=
to=2Eh
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/manage=2Ec
M src/openvp=
n/ssl_mbedtls=2Ec
9 files changed, 33 insertions(+), 52 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/2157/1

=
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
index e21891d=2E=2Eb=
8d7c3d 100644
--- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -148,1=
1 +148,6 @@
     return parse_acc_message_flags(flags, err_reason, gc);
 }
=
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push=

-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 recei=
ve_acc_message(struct context *c, const struct buffer *buffer)
 {
@@ -236,1=
5 +231,10 @@
     msg(D_PUSH_ERRORS, "WARNING: Received malformed custom ap=
p control channel "
                        "message (%s): %s",
         er=
r_reason,
-        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+    =
    format_hex(CBPTR(buffer), BLENZ(buffer), 80, &gc));
     gc_free(&gc);
=
 }
 
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic=
 pop
-#endif
-
 bool
 send_acc_message(struct context *c,
                 =
 struct tls_multi *multi,
diff --git a/src/openvpn/auth_token=2Ec b/src/ope=
nvpn/auth_token=2Ec
index 211af90=2E=2E736ad67 100644
--- a/src/openvpn/aut=
h_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -36,11 +36,6 @@
  * padding=
 */
 static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a mu=
ltiple of 3");
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC =
diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif=

-
 bool
 is_auth_token(const char *password)
 {
@@ -67,7 +62,7 @@
        =
 return;
     }
 
-    int auth_token_state_flags =3D session->key[KS_PRIMA=
RY]=2Eauth_token_state_flags;
+    unsigned int auth_token_state_flags =3D =
session->key[KS_PRIMARY]=2Eauth_token_state_flags;
 
     const char *state=
;
 
@@ -273,7 +268,7 @@
         alloc_buf_gc(strlen(SESSION_ID_PREFIX) + s=
trlen(b64output) + 1, &gc);
 
     ASSERT(buf_write(&session_token, SESSION=
_ID_PREFIX, strlen(SESSION_ID_PREFIX)));
-    ASSERT(buf_write(&session_tok=
en, b64output, (int)strlen(b64output)));
+    ASSERT(buf_write(&session_tok=
en, b64output, strlen(b64output)));
     ASSERT(buf_write_u8(&session_token=
, 0));
 
     free(b64output);
@@ -296,10 +291,6 @@
     gc_free(&gc);
 }
 =

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-=
#endif
-
 static bool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64=
decoded, const char *username)
 {
diff --git a/src/openvpn/base64=2Eh b/src=
/openvpn/base64=2Eh
index be7aa64=2E=2E800e569 100644
--- a/src/openvpn/bas=
e64=2Eh
+++ b/src/openvpn/base64=2Eh
@@ -35,7 +35,7 @@
 #define _BASE64_H_
=
 
 /** Compute resulting base64 length=2E  6 bits per byte, padded to 4 byt=
es=2E */
-#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_lengt=
h) / 6) + 3) & ~3)
+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * bi=
nary_length) / 6) + 3) & ~3u)
 
 /** Compute the maximal number of bytes en=
coded in a base64 string=2E */
 #define OPENVPN_BASE64_DECODED_LENGTH(base6=
4_length) ((base64_length / 4) * 3)
diff --git a/src/openvpn/console_builti=
n=2Ec b/src/openvpn/console_builtin=2Ec
index dc71d12=2E=2E0353ade 100644
-=
-- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
=
@@ -234,7 +234,7 @@
     if (!echo && (tcgetattr(fileno(fp), &tty_tmp) =3D=
=3D 0))
     {
         tty_save =3D tty_tmp;
-        tty_tmp=2Ec_lflag &=
=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
+        tty_tmp=2Ec_lflag &=
=3D ~(unsigned int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
         restore=
_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp) =3D=3D 0);
     }
 
di=
ff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 88c2c52=2E=
=2Effdf8c4 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec=

@@ -139,7 +139,7 @@
         ASSERT(cipher_ctx_reset(ctx->cipher, iv));
  =
   }
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf)=
, BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", for=
mat_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Buffer overflow check *=
/
     if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx-=
>cipher)))
@@ -151,7 +151,7 @@
 
     /* For AEAD ciphers, authenticate Add=
itional Data, including opcode */
     ASSERT(cipher_ctx_update_ad(ctx->cip=
her, BPTR(&work), BLEN(&work)));
-    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %=
s", format_hex(BPTR(&work), BLEN(&work), 0, &gc));
+    dmsg(D_PACKET_CONTE=
NT, "ENCRYPT AD: %s", format_hex(BPTR(&work), BLENZ(&work), 0, &gc));
 
   =
  if (!use_epoch_data_format)
     {
@@ -170,8 +170,8 @@
 
     /* update n=
umber of plaintext blocks encrypted=2E Use the (x + (n-1))/n trick
      * =
to round up the result to the number of blocks used */
-    const int block=
size =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi=2Eencrypt=2Eplaintext_b=
locks +=3D (BLEN(&work) + (blocksize - 1)) / blocksize;
+    const unsigned=
 int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi=2Eencrypt=2Ep=
laintext_blocks +=3D (BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     /=
* if the tag is at end the end, allocate it now */
     if (use_epoch_data_=
format)
@@ -186,7 +186,7 @@
 
     *buf =3D work;
 
-    dmsg(D_PACKET_CONT=
ENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dms=
g(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLENZ(buf), 80,=
 &gc));
 
     gc_free(&gc);
     return;
@@ -257,13 +257,13 @@
           =
  ASSERT(buf_write(&work, iv_buf, iv_size));
             dmsg(D_PACKET_CON=
TENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
 
-          =
  dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf=
), 80, &gc));
+            dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", forma=
t_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
             /* cipher_ctx was al=
ready initialized with key & keylen */
             ASSERT(cipher_ctx_reset=
(ctx->cipher, iv_buf));
 
             /* Buffer overflow check */
-       =
     if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+=
            if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->ci=
pher)))
             {
                 msg(D_CRYPT_ERRORS,
               =
      "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d =
wl=3D%d cbs=3D%u",
@@ -317,7 +317,7 @@
 
         *buf =3D work;
 
-       =
 dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLEN(&wor=
k), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex=
(BPTR(&work), BLENZ(&work), 80, &gc));
     }
 
     gc_free(&gc);
@@ -460,=
7 +460,7 @@
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
 
-    dms=
g(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80=
, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(bu=
f), BLENZ(buf), 80, &gc));
 
     ASSERT(ad_start >=3D buf->data && ad_star=
t <=3D BPTR(buf));
 
@@ -558,10 +558,10 @@
     }
 
     dmsg(D_PACKET_CONT=
ENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-    dmsg(D=
_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &g=
c));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), =
BLENZ(buf), 0, &gc));
 
     /* Buffer overflow check (should never fail) *=
/
-    if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))=

+    if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher))=
)
     {
         CRYPT_ERROR("potential buffer overflow");
     }
@@ -585,=
7 +585,7 @@
     }
     ASSERT(buf_inc_len(&work, outlen));
 
-    dmsg(D_P=
ACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &=
gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work),=
 BLENZ(&work), 80, &gc));
 
     if (!crypto_check_replay(opt, &pin, epoch,=
 error_prefix, &gc))
     {
@@ -594,8 +594,8 @@
 
     /* update number of =
plaintext blocks decrypted=2E Use the (x + (n-1))/n trick
      * to round =
up the result to the number of blocks used=2E */
-    const int blocksize =
=3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks=
 +=3D (BLEN(&work) + (blocksize - 1)) / blocksize;
+    const unsigned int =
blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi=2Edecrypt=2Eplaint=
ext_blocks +=3D (BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     *buf =
=3D work;
 
@@ -631,7 +631,7 @@
         struct packet_id_net pin;
        =
 bool have_pin =3D false;
 
-        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: =
%s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+        dmsg(D_PACKET_CON=
TENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
  =
       /* Verify the HMAC */
         if (ctx->hmac)
@@ -694,7 +694,7 @@
  =
           }
 
             /* Buffer overflow check (should never happen) =
*/
-            if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->=
cipher)))
+            if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_s=
ize(ctx->cipher)))
             {
                 CRYPT_ERROR("packet too =
big to decrypt");
             }
@@ -713,7 +713,7 @@
             }
       =
      ASSERT(buf_inc_len(&work, outlen));
 
-            dmsg(D_PACKET_CONT=
ENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+   =
         dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), B=
LENZ(&work), 80, &gc));
 
             /* Get packet ID from plaintext buff=
er or IV, depending on cipher mode */
             {
@@ -855,7 +855,7 @@
 c=
rypto_max_overhead(void)
 {
     return packet_id_size(true) + OPENVPN_MAX_=
IV_LENGTH + OPENVPN_MAX_CIPHER_BLOCK_SIZE
-           + max_int(OPENVPN_MAX=
_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+           + max_uint(OPENVPN_MAX_HM=
AC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
 static void
@@ -1366,7 +1366,7 @@
=
         size_t buf_size =3D strlen(file) + 1;
         ASSERT(buf_size <=
=3D INT_MAX);
         size =3D (int)buf_size;
-        buf_set_read(&in, (=
const uint8_t *)file, size);
+        buf_set_read(&in, (const uint8_t *)fi=
le, buf_size);
     }
     else /* 'file' is a filename which refers to a f=
ile containing the ascii key */
     {
@@ -1535,7 +1535,7 @@
     struct bu=
ffer out =3D alloc_buf_gc(2048, &gc);
 
     /* how to format the ascii fil=
e representation of key */
-    const int bytes_per_line =3D 16;
+    const=
 size_t bytes_per_line =3D 16;
 
     /* write header */
     buf_printf(&o=
ut, "#\n# %d bit OpenVPN static key\n#\n", nbits);
diff --git a/src/openvpn=
/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe0802=2E=2Efd632be 100644
--- =
a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -760,12 +760,12 @@=

  * to read=2E
  */
 static inline bool
-aead_usage_limit_reached(const ui=
nt64_t limit, const struct key_ctx *key_ctx, int64_t higest_pid)
+aead_usag=
e_limit_reached(const uint64_t limit, const struct key_ctx *key_ctx, uint64=
_t higest_pid)
 {
     /* This is the  q + s <=3D  p^(1/2) * 2^(129/2) - 1 =
calculation where
      * q is the number of protected messages (highest_pi=
d)
      * s Total plaintext length in all messages (in blocks) */
-    ret=
urn (limit > 0 && key_ctx->plaintext_blocks + (uint64_t)higest_pid > limit)=
;
+    return (limit > 0 && key_ctx->plaintext_blocks + higest_pid > limit)=
;
 }
 
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/crypto_epoch=2Ec b/s=
rc/openvpn/crypto_epoch=2Ec
index 312cf6f=2E=2E243b5a2 100644
--- a/src/ope=
nvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -98,7 +98,7 @@
=
     const uint8_t *label_prefix =3D (const uint8_t *)("ovpn ");
     uint8=
_t prefix_len =3D 5;
 
-    size_t hkdf_label_len =3D 2 + prefix_len + 1 + =
label_len + 1 + context_len;
+    size_t hkdf_label_len =3D 2u + prefix_len=
 + 1u + label_len + 1u + context_len;
     struct buffer hkdf_label =3D all=
oc_buf_gc(hkdf_label_len, &gc);
 
     buf_write_u16(&hkdf_label, (uint16_t=
)out_len);
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
ind=
ex 4809532=2E=2E1760c90 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openv=
pn/manage=2Ec
@@ -2758,7 +2758,7 @@
             else
             {
      =
           int status;
-                int resolve_flags =3D GETADDR_RESOL=
VE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
+                unsigned int =
resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;=

 
                 if (!(flags & MF_CONNECT_AS_CLIENT))
                 {=

@@ -4001,11 +4001,11 @@
         desc =3D "rsa-sign";
     }
 
-    buf_wr=
ite(&buf_data, b64_data, (int)strlen(b64_data));
+    buf_write(&buf_data, =
b64_data, strlen(b64_data));
     if (man->connection=2Eclient_version >=3D=
 MCV_PKSIGN_ALG)
     {
-        buf_write(&buf_data, ",", (int)strlen(",")=
);
-        buf_write(&buf_data, algorithm, (int)strlen(algorithm));
+     =
   buf_write(&buf_data, ",", strlen(","));
+        buf_write(&buf_data, al=
gorithm, strlen(algorithm));
     }
     char *ret =3D management_query_mul=
tiline_flatten(man, (char *)buf_bptr(&buf_data), prompt, desc,
            =
                                        &man->connection=2Eext_key_state,
d=
iff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index=
 cbc3118=2E=2Ef4e142b 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/op=
envpn/ssl_mbedtls=2Ec
@@ -1119,7 +1119,7 @@
         return 0;
     }
 
-  =
  retval =3D endless_buf_write(&ks->bio_ctx->in, BPTR(buf), buf->len);
+   =
 retval =3D endless_buf_write(&ks->bio_ctx->in, BPTR(buf), BLENZ(buf));
 
 =
    if (retval < 0)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2157?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Gerrit-Change-Number: 2=
157
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--dFGWpH9kO+8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Various trivial -Wsign-conversion fixes<br><br>* Continue =
BLEN -&gt; BLENZ replacement<br>* Remove some unneeded casts<br>* Some triv=
ial type fixes<br><br>Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<=
br>M src/openvpn/acc=2Ec<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/b=
ase64=2Eh<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/crypto=2Ec<=
br>M src/openvpn/crypto=2Eh<br>M src/openvpn/crypto_epoch=2Ec<br>M src/open=
vpn/manage=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>9 files changed, 33 inse=
rtions(+), 52 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/2157/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index e21891d=2E=
=2Eb8d7c3d 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><span=
>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -148,11 +148,6 @@</span><br><=
span>     return parse_acc_message_flags(flags, err_reason, gc);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsig=
n-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
void</span><br><span> receive_acc_message(struct context *c, const struct b=
uffer *buffer)</span><br><span> {</span><br><span>@@ -236,15 +231,10 @@</sp=
an><br><span>     msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed cust=
om app control channel &quot;</span><br><span>                        &quot=
;message (%s): %s&quot;,</span><br><span>         err_reason,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        format_hex(CBPTR(buffer), B=
LEN(buffer), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        format_hex(CBPTR(buffer), BLENZ(buffer), 80, &amp;gc));</sp=
an><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><b=
r><span> send_acc_message(struct context *c,</span><br><span>              =
    struct tls_multi *multi,</span><br><span>diff --git a/src/openvpn/auth_=
token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 211af90=2E=2E7=
36ad67 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><s=
pan>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -36,11 +36,6 @@</sp=
an><br><span>  * padding */</span><br><span> static_assert(TOKEN_DATA_LEN %=
 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multiple of 3&quot;);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><spa=
n> is_auth_token(const char *password)</span><br><span> {</span><br><span>@=
@ -67,7 +62,7 @@</span><br><span>         return;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t auth_token_state_flags =3D session-&gt;key[KS_PRIMARY]=2Eauth_token_state=
_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned=
 int auth_token_state_flags =3D session-&gt;key[KS_PRIMARY]=2Eauth_token_st=
ate_flags;</span><br><span> </span><br><span>     const char *state;</span>=
<br><span> </span><br><span>@@ -273,7 +268,7 @@</span><br><span>         al=
loc_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &amp;gc);</sp=
an><br><span> </span><br><span>     ASSERT(buf_write(&amp;session_token, SE=
SSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(buf_write(&amp;session_token, b64output,=
 (int)strlen(b64output)));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(buf_write(&amp;session_token, b64output, strlen(b64output=
)));</span><br><span>     ASSERT(buf_write_u8(&amp;session_token, 0));</spa=
n><br><span> </span><br><span>     free(b64output);</span><br><span>@@ -296=
,10 +291,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> static bool</span><br><span> check_hmac_token(hmac_c=
tx_t *ctx, const uint8_t *b64decoded, const char *username)</span><br><span=
> {</span><br><span>diff --git a/src/openvpn/base64=2Eh b/src/openvpn/base6=
4=2Eh</span><br><span>index be7aa64=2E=2E800e569 100644</span><br><span>---=
 a/src/openvpn/base64=2Eh</span><br><span>+++ b/src/openvpn/base64=2Eh</spa=
n><br><span>@@ -35,7 +35,7 @@</span><br><span> #define _BASE64_H_</span><br=
><span> </span><br><span> /** Compute resulting base64 length=2E  6 bits pe=
r byte, padded to 4 bytes=2E */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_lengt=
h) / 6) + 3) &amp; ~3)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6)=
 + 3) &amp; ~3u)</span><br><span> </span><br><span> /** Compute the maximal=
 number of bytes encoded in a base64 string=2E */</span><br><span> #define =
OPENVPN_BASE64_DECODED_LENGTH(base64_length) ((base64_length / 4) * 3)</spa=
n><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/cons=
ole_builtin=2Ec</span><br><span>index dc71d12=2E=2E0353ade 100644</span><br=
><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/open=
vpn/console_builtin=2Ec</span><br><span>@@ -234,7 +234,7 @@</span><br><span=
>     if (!echo &amp;&amp; (tcgetattr(fileno(fp), &amp;tty_tmp) =3D=3D 0))<=
/span><br><span>     {</span><br><span>         tty_save =3D tty_tmp;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        tty_tmp=2Ec_lflag &=
amp;=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tty_tmp=2Ec_lflag &amp;=3D ~(unsigned =
int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);</span><br><span>         restor=
e_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &amp;tty_tmp) =3D=3D 0);</span>=
<br><span>     }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 88c2c52=2E=2Effd=
f8c4 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>++=
+ b/src/openvpn/crypto=2Ec</span><br><span>@@ -139,7 +139,7 @@</span><br><s=
pan>         ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv));</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR=
(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, forma=
t_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><sp=
an>     /* Buffer overflow check */</span><br><span>     if (!buf_safe(&amp=
;work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cipher)))</spa=
n><br><span>@@ -151,7 +151,7 @@</span><br><span> </span><br><span>     /* F=
or AEAD ciphers, authenticate Additional Data, including opcode */</span><b=
r><span>     ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, BPTR(&amp;work), B=
LEN(&amp;work)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;, format_hex(BPTR(&amp;wor=
k), BLEN(&amp;work), 0, &amp;gc));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;, forma=
t_hex(BPTR(&amp;work), BLENZ(&amp;work), 0, &amp;gc));</span><br><span> </s=
pan><br><span>     if (!use_epoch_data_format)</span><br><span>     {</span=
><br><span>@@ -170,8 +170,8 @@</span><br><span> </span><br><span>     /* up=
date number of plaintext blocks encrypted=2E Use the (x + (n-1))/n trick</s=
pan><br><span>      * to round up the result to the number of blocks used *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int blocks=
ize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    opt-&gt;key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLEN(&amp=
;work) + (blocksize - 1)) / blocksize;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZ=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_c=
tx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLENZ(&amp;work) + (blocksize - 1)=
) / blocksize;</span><br><span> </span><br><span>     /* if the tag is at e=
nd the end, allocate it now */</span><br><span>     if (use_epoch_data_form=
at)</span><br><span>@@ -186,7 +186,7 @@</span><br><span> </span><br><span> =
    *buf =3D work;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, forma=
t_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot=
;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span=
><br><span>     gc_free(&amp;gc);</span><br><span>     return;</span><br><s=
pan>@@ -257,13 +257,13 @@</span><br><span>             ASSERT(buf_write(&am=
p;work, iv_buf, iv_size));</span><br><span>             dmsg(D_PACKET_CONTE=
NT, &quot;ENCRYPT IV: %s&quot;, format_hex(iv_buf, iv_size, 0, &amp;gc));</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR=
(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot=
;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span=
><br><span>             /* cipher_ctx was already initialized with key &amp=
; keylen */</span><br><span>             ASSERT(cipher_ctx_reset(ctx-&gt;ci=
pher, iv_buf));</span><br><span> </span><br><span>             /* Buffer ov=
erflow check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;=
cipher)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!buf_safe(&amp;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;ciphe=
r)))</span><br><span>             {</span><br><span>                 msg(D_=
CRYPT_ERRORS,</span><br><span>                     &quot;ENCRYPT: buffer si=
ze error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u&quot;,</=
span><br><span>@@ -317,7 +317,7 @@</span><br><span> </span><br><span>      =
   *buf =3D work;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, fo=
rmat_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_PACKET_CONTENT, &quot;=
ENCRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &am=
p;gc));</span><br><span>     }</span><br><span> </span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span>@@ -460,7 +460,7 @@</span><br><span>     ASSER=
T(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_=
PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(bu=
f), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf=
), BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><span>     ASSERT=
(ad_start &gt;=3D buf-&gt;data &amp;&amp; ad_start &lt;=3D BPTR(buf));</spa=
n><br><span> </span><br><span>@@ -558,10 +558,10 @@</span><br><span>     }<=
/span><br><span> </span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT=
 MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECR=
YPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 0, &amp;gc));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &=
quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc))=
;</span><br><span> </span><br><span>     /* Buffer overflow check (should n=
ever fail) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(&a=
mp;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><sp=
an>     {</span><br><span>         CRYPT_ERROR(&quot;potential buffer overf=
low&quot;);</span><br><span>     }</span><br><span>@@ -585,7 +585,7 @@</spa=
n><br><span>     }</span><br><span>     ASSERT(buf_inc_len(&amp;work, outle=
n));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&am=
p;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;,=
 format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &amp;gc));</span><br><sp=
an> </span><br><span>     if (!crypto_check_replay(opt, &amp;pin, epoch, er=
ror_prefix, &amp;gc))</span><br><span>     {</span><br><span>@@ -594,8 +594=
,8 @@</span><br><span> </span><br><span>     /* update number of plaintext =
blocks decrypted=2E Use the (x + (n-1))/n trick</span><br><span>      * to =
round up the result to the number of blocks used=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const int blocksize =3D AEAD_LIMIT_BLO=
CKSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;ke=
y_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLEN(&amp;work) + (blocksize - =
1)) / blocksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi=2Edecrypt=2Eplai=
ntext_blocks +=3D (BLENZ(&amp;work) + (blocksize - 1)) / blocksize;</span><=
br><span> </span><br><span>     *buf =3D work;</span><br><span> </span><br>=
<span>@@ -631,7 +631,7 @@</span><br><span>         struct packet_id_net pin=
;</span><br><span>         bool have_pin =3D false;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_CONTE=
NT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp=
;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(=
D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ=
(buf), 80, &amp;gc));</span><br><span> </span><br><span>         /* Verify =
the HMAC */</span><br><span>         if (ctx-&gt;hmac)</span><br><span>@@ -=
694,7 +694,7 @@</span><br><span>             }</span><br><span> </span><br>=
<span>             /* Buffer overflow check (should never happen) */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!buf_safe(&a=
mp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!buf_safe(&amp;w=
ork, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span> =
            {</span><br><span>                 CRYPT_ERROR(&quot;packet too=
 big to decrypt&quot;);</span><br><span>             }</span><br><span>@@ -=
713,7 +713,7 @@</span><br><span>             }</span><br><span>            =
 ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTENT, &qu=
ot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;w=
ork), BLENZ(&amp;work), 80, &amp;gc));</span><br><span> </span><br><span>  =
           /* Get packet ID from plaintext buffer or IV, depending on ciphe=
r mode */</span><br><span>             {</span><br><span>@@ -855,7 +855,7 @=
@</span><br><span> crypto_max_overhead(void)</span><br><span> {</span><br><=
span>     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX=
_CIPHER_BLOCK_SIZE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
        + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           + max_uint(OPENVP=
N_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span>@@ -1366,7 +1366,7 @@</sp=
an><br><span>         size_t buf_size =3D strlen(file) + 1;</span><br><span=
>         ASSERT(buf_size &lt;=3D INT_MAX);</span><br><span>         size =
=3D (int)buf_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     buf_set_read(&amp;in, (const uint8_t *)file, size);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        buf_set_read(&amp;in, (const u=
int8_t *)file, buf_size);</span><br><span>     }</span><br><span>     else =
/* &#39;file&#39; is a filename which refers to a file containing the ascii=
 key */</span><br><span>     {</span><br><span>@@ -1535,7 +1535,7 @@</span>=
<br><span>     struct buffer out =3D alloc_buf_gc(2048, &amp;gc);</span><br=
><span> </span><br><span>     /* how to format the ascii file representatio=
n of key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
int bytes_per_line =3D 16;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const size_t bytes_per_line =3D 16;</span><br><span> </span><br>=
<span>     /* write header */</span><br><span>     buf_printf(&amp;out, &qu=
ot;#\n# %d bit OpenVPN static key\n#\n&quot;, nbits);</span><br><span>diff =
--git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>ind=
ex dbe0802=2E=2Efd632be 100644</span><br><span>--- a/src/openvpn/crypto=2Eh=
</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -760,12 +7=
60,12 @@</span><br><span>  * to read=2E</span><br><span>  */</span><br><spa=
n> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *key_ct=
x, int64_t higest_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *key=
_ctx, uint64_t higest_pid)</span><br><span> {</span><br><span>     /* This =
is the  q + s &lt;=3D  p^(1/2) * 2^(129/2) - 1 calculation where</span><br>=
<span>      * q is the number of protected messages (highest_pid)</span><br=
><span>      * s Total plaintext length in all messages (in blocks) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (limit &gt; 0 &=
amp;&amp; key_ctx-&gt;plaintext_blocks + (uint64_t)higest_pid &gt; limit);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (limit &g=
t; 0 &amp;&amp; key_ctx-&gt;plaintext_blocks + higest_pid &gt; limit);</spa=
n><br><span> }</span><br><span> </span><br><span> #endif /* CRYPTO_H */</sp=
an><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto=
_epoch=2Ec</span><br><span>index 312cf6f=2E=2E243b5a2 100644</span><br><spa=
n>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/cryp=
to_epoch=2Ec</span><br><span>@@ -98,7 +98,7 @@</span><br><span>     const u=
int8_t *label_prefix =3D (const uint8_t *)(&quot;ovpn &quot;);</span><br><s=
pan>     uint8_t prefix_len =3D 5;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t hkdf_label_len =3D 2 + prefix_le=
n + 1 + label_len + 1 + context_len;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    size_t hkdf_label_len =3D 2u + prefix_len + 1u + label=
_len + 1u + context_len;</span><br><span>     struct buffer hkdf_label =3D =
alloc_buf_gc(hkdf_label_len, &amp;gc);</span><br><span> </span><br><span>  =
   buf_write_u16(&amp;hkdf_label, (uint16_t)out_len);</span><br><span>diff =
--git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>ind=
ex 4809532=2E=2E1760c90 100644</span><br><span>--- a/src/openvpn/manage=2Ec=
</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2758,7 +2=
758,7 @@</span><br><span>             else</span><br><span>             {</=
span><br><span>                 int status;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                int resolve_flags =3D GETADDR_RESOLVE=
 | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                unsigned int resolve_flags =3D GETAD=
DR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;</span><br><span> </spa=
n><br><span>                 if (!(flags &amp; MF_CONNECT_AS_CLIENT))</span=
><br><span>                 {</span><br><span>@@ -4001,11 +4001,11 @@</span=
><br><span>         desc =3D &quot;rsa-sign&quot;;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf_write(&amp;buf_data, b64_data, (int)strlen(b64_data));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf_data, b64_data=
, strlen(b64_data));</span><br><span>     if (man-&gt;connection=2Eclient_v=
ersion &gt;=3D MCV_PKSIGN_ALG)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write(&amp;buf_data, &quot;,&qu=
ot;, (int)strlen(&quot;,&quot;));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        buf_write(&amp;buf_data, algorithm, (int)strlen(algorit=
hm));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_wr=
ite(&amp;buf_data, &quot;,&quot;, strlen(&quot;,&quot;));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;buf_data, algo=
rithm, strlen(algorithm));</span><br><span>     }</span><br><span>     char=
 *ret =3D management_query_multiline_flatten(man, (char *)buf_bptr(&amp;buf=
_data), prompt, desc,</span><br><span>                                     =
               &amp;man-&gt;connection=2Eext_key_state,</span><br><span>dif=
f --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><=
br><span>index cbc3118=2E=2Ef4e142b 100644</span><br><span>--- a/src/openvp=
n/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><=
br><span>@@ -1119,7 +1119,7 @@</span><br><span>         return 0;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    retval =3D endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR=
(buf), buf-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    retval =3D endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(buf), BL=
ENZ(buf));</span><br><span> </span><br><span>     if (retval &lt; 0)</span>=
<br><span>     {</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail">change 2157</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02f8df01f8f33c=
b9cd04cd844d1f1893688f51e8 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2157 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dFGWpH9kO+8=--


--===============0192627008313446418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0192627008313446418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0192627008313446418==--


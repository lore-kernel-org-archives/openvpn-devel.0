Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE03606A8AA
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U040H5Pa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jyXcXAN4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EU9hNLaF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ops8gx29
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vE8+3QOQ/ka2FFQNAMsU485kGkEecFb9SzGNIsi0vT4=; b=U040H5Pa/dyXV4oJr4SYGQfKIR
	6IFo2kHOtJd6f8Ipb1pZgLrma659+6qmOiKwg7W457LiDMcajlByKZmq1NvZMqbHhHn3iVMNxUo0o
	H8lwTWbBRULKapm6RGUrdA8CDHwNjTRaXhwm2gjaMG1D3xbJtpBSIa2fwpPuy+3EnHeA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzXP-000000007hi-3s7z;
	Fri, 13 Nov 2026 22:14:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzWy-000000007fE-3MFn
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/zzVItlxHi921R/Sr09r/khgKg0hMKz9OoVyZQabcho=; b=jyXcXAN4G5jrhOXbh+F7u1m5HF
 lbA3YCPBiq6cM87mrHmuXNGJlyXCpXeVfuuTxRrTiOw2kVjV2SzXs7DK6OjVt41/6+rgG8IQipyDm
 f8wjrpCjnVuw5l/Hm+shcSBfvlVmSWSeB5mYZ0Rd8rpNRjTQH9UPL+t26aPor5fNLFQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/zzVItlxHi921R/Sr09r/khgKg0hMKz9OoVyZQabcho=; b=EU9hNLaFDkHZTd8a3IWJrvzBUb
 ZeYFVY1prqnK0AUtFghkV4gzjr7Ce//052IzSqDpsTV/jzjktGRwaCmGe5VcS3zJRfTgsu10mUoRp
 U0Q58q6K5AViWKqa/blFU+zQHPI5Lr8KXpKv9G2bChVwLmeZGMxZu3xJNDdxLKtmS0Io=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzWo-000000006GB-1fDd for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:13:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so708623f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794608024; x=1795212824; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/zzVItlxHi921R/Sr09r/khgKg0hMKz9OoVyZQabcho=;
 b=Ops8gx293VeXu0cP4PqJWQnq+Bw8jdGKYlk58lcr3ZXdI1Mq5ikAkddic6Pw0WUi72
 SSO4c/nQ+MLEbP4wm/kztpquimbV/PGj6j/gvuYRLQO4YrsLu31Slin5b4fHyF1PJ88X
 tIRcrye3e7VrfKfpJHMDf+aSNQSwUHWtDmxB2YQulhxUBT3JLSdAmiRUmi087rYU1ziY
 hQFajLHsxhsNsVSzYD7/v1WHhtgXKvM62MxgOy8TWQAPKMuORV+U0lxZ9bWNT5Yl1Y0B
 +rF5fjKfCW9KX3LiBZxtSdb3O30e6VKyyAB2m74cvxxF9oOW5tBLMh6xlfBFK1TY1jHH
 LVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794608024; x=1795212824;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/zzVItlxHi921R/Sr09r/khgKg0hMKz9OoVyZQabcho=;
 b=O1XORtRw4O9EDnOzJjsLQfEe30tR2ikvS9eOajigYJ/FY8zgxvWrnD8khw84bmMCEg
 HR3v01rSmBEly5WK1YkUPXlrRbMHZMzzt6l6xZSB5aJ0Ksw200Bx+dsP+BqTQfq+4zKw
 8yt022xh9CZG6F6p8V1h4lwIN38bFb3L+UGFsW7a6tWITD2jTCThVbejEZwDYXIg9jbE
 e6Xx76wUdlQ+JUfQTM0966QFs1C/pDOTQ+Sq4kn7TbAzpJ/iSM47aOoexk5HH/X+tBM5
 piG1xAEhtT5A3noJwbZdVzkYQrZuRcKfyCY6VO2BKub/sSgKnkbybtkZw2J9M/O4sj1j
 kV4w==
X-Forwarded-Encrypted: i=1;
 AL+hErG1IBx+eUpVL4lVa5JtbQxsOZ1TsOFsgtakE0bN0Efsnm2poltavyBfSYHiLTgGRF+ADAUPsBdDw1dRnz67@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+e7rm+amcLWw5Qajr053mjSI+tv423s/PHQAc6NM2WiwP4lD5O
 CXZyFMxilg0v5U+sxeduIOUeSvLYv6+8RC/PmHzcavt/OBf225Mz18W5ESl0b/33IiYRDkRKmLH
 T0kPjDQdR22mzQsfsAHBGH2d8DuTSeHp6SfZ/xfPsaaQGCsrjJvrIyso/17nHvi+WV02XNNTLDL
 LLodHVzQ==
X-Gm-Gg: AYBFou3sxguwKoJMwEBmuUmLZkkUCeIIM2KXSGpeYPpUchiQRlVFpnKhdgJboXDqKM0
 pjgwbF5ub84a/w8Vcfh2EP0Q4Y3mXNtQxLMNYEH8n3T1AUec9C5/Y4Avcq0+VZMYJdZk7LFT6+H
 JNbkOD2jNHCNrYXMt3QHDarFcqQbN+WrYGXufERXqXvcO0LAapZG3rdB7RloCE737v1/f5VVCFb
 zwXnNDEOL0d6W6BLAzXtIFzREckFenJ/qwpdPgvXR3CLI4k23ZxnI8m9hRs6RgzMzIBc84hSeb4
 I5MvCNa7MoCqCNc+zsvmbSO8OdAsdEBjlvVMxtgJRJYuE5MsTr1HDxoUmGwnxa08CX3We+QN3h3
 kjmuZLdh80NcqZIMSi1lGbaF1vxNLWUR1lypZMzU170MHA6E1OEjnJe6rnWGWl7a1HE8qS3Os1g
 yb9i4DFa/jbVKvpyhiV2z93GG8a1H394aiQdRKEfpKliDd3ZDzq4NlL8WujfRaBlpBP4NpWOKqy
 sEM649NbP5vWZcoX46Q7lz/0weqTSPUSeQtQeBpZ0ZfG4xaMx70769Q7H8fZal1LmRJLfe05/aF
 x+l8BFlAJJl5bMOhpVNkk+Shmejoa9tb8GuX08NAuS9SuWe68WB/MLDWjlBSvgJf9SCUJlZjzrw
 +lBDajDjpbpBlkinyqT5N5V+0M/Attrvn/GkCZ0TTvLo75lT2SD/6KwmXQDt9bogHKZ9q15QNZH
 jnF9+Z2bKQFdSfV2Y=
X-Received: by 2002:a05:6000:2602:b0:491:66b9:625b with SMTP id
 ffacd0b85a97d-49c73bf0527mr8611905f8f.31.1794608023543; 
 Fri, 13 Nov 2026 14:13:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8e794sm7907855f8f.59.2026.11.13.14.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:13:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:13:42 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: 30a8bf5eb8eb298b18c32807d39eeaae777c3066
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eb887e1f9b7a42cbf20a12b5f244e7a03fc8400-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzWo-000000006GB-1fDd
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9179312499101132862=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9179312499101132862==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/3r9Fp8r1DY="; charset=UTF-8

--/3r9Fp8r1DY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2157?usp=3Demail )

Change subject: Various trivial -Wsign-conv=
ersion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Various trivial -Wsign-conversion fixes

* Continue BLEN -> BLENZ replace=
ment
* Remove some unneeded casts
* Some trivial type fixes

Change-Id: I02=
f8df01f8f33cb9cd04cd844d1f1893688f51e8
Signed-off-by: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157
Message-Id: <2026=
1110143722=2E15193-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41094=2Ehtml
Signed-off=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/acc=2Ec
M src=
/openvpn/auth_token=2Ec
M src/openvpn/base64=2Eh
M src/openvpn/console_buil=
tin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/cry=
pto_epoch=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M test=
s/unit_tests/openvpn/test_crypto=2Ec
M tests/unit_tests/openvpn/test_networ=
king=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
M tests/unit_tests/openvpn=
/test_tls_crypt=2Ec
13 files changed, 49 insertions(+), 95 deletions(-)



=

diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
index ceb7100=2E=2E=
dae614a 100644
--- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -148,=
11 +148,6 @@
     return parse_acc_message_flags(flags, err_reason, gc);
 }=

 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pus=
h
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 rece=
ive_acc_message(struct context *c, const struct buffer *buffer)
 {
@@ -236,=
15 +231,10 @@
     msg(D_PUSH_ERRORS, "WARNING: Received malformed custom a=
pp control channel "
                        "message (%s): %s",
         e=
rr_reason,
-        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+   =
     format_hex(CBPTR(buffer), BLENZ(buffer), 80, &gc));
     gc_free(&gc);=

 }
 
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnosti=
c pop
-#endif
-
 bool
 send_acc_message(struct context *c,
                =
  struct tls_multi *multi,
diff --git a/src/openvpn/auth_token=2Ec b/src/op=
envpn/auth_token=2Ec
index 211af90=2E=2Eb69092c 100644
--- a/src/openvpn/au=
th_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -36,11 +36,6 @@
  * paddin=
g */
 static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a m=
ultiple of 3");
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC=
 diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endi=
f
-
 bool
 is_auth_token(const char *password)
 {
@@ -67,7 +62,7 @@
       =
  return;
     }
 
-    int auth_token_state_flags =3D session->key[KS_PRIM=
ARY]=2Eauth_token_state_flags;
+    unsigned int auth_token_state_flags =3D=
 session->key[KS_PRIMARY]=2Eauth_token_state_flags;
 
     const char *stat=
e;
 
@@ -188,7 +183,7 @@
 {
     struct gc_arena gc =3D gc_new();
 
-    in=
t64_t timestamp =3D htonll((uint64_t)now);
+    int64_t timestamp =3D (int6=
4_t)htonll((uint64_t)now);
     int64_t initial_timestamp =3D timestamp;
 
=
     hmac_ctx_t *ctx =3D multi->opt=2Eauth_token_key=2Ehmac;
@@ -273,7 +268=
,7 @@
         alloc_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64output) +=
 1, &gc);
 
     ASSERT(buf_write(&session_token, SESSION_ID_PREFIX, strlen=
(SESSION_ID_PREFIX)));
-    ASSERT(buf_write(&session_token, b64output, (in=
t)strlen(b64output)));
+    ASSERT(buf_write(&session_token, b64output, str=
len(b64output)));
     ASSERT(buf_write_u8(&session_token, 0));
 
     free=
(b64output);
@@ -296,10 +291,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static b=
ool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const cha=
r *username)
 {
diff --git a/src/openvpn/base64=2Eh b/src/openvpn/base64=2E=
h
index be7aa64=2E=2E800e569 100644
--- a/src/openvpn/base64=2Eh
+++ b/src/=
openvpn/base64=2Eh
@@ -35,7 +35,7 @@
 #define _BASE64_H_
 
 /** Compute res=
ulting base64 length=2E  6 bits per byte, padded to 4 bytes=2E */
-#define =
OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) + 3) & ~3)=

+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) =
+ 3) & ~3u)
 
 /** Compute the maximal number of bytes encoded in a base64 =
string=2E */
 #define OPENVPN_BASE64_DECODED_LENGTH(base64_length) ((base64=
_length / 4) * 3)
diff --git a/src/openvpn/console_builtin=2Ec b/src/openvp=
n/console_builtin=2Ec
index dc71d12=2E=2E0353ade 100644
--- a/src/openvpn/c=
onsole_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -234,7 +234,7 @=
@
     if (!echo && (tcgetattr(fileno(fp), &tty_tmp) =3D=3D 0))
     {
    =
     tty_save =3D tty_tmp;
-        tty_tmp=2Ec_lflag &=3D ~(ECHO | ECHOE |=
 ECHOK | ECHONL | ISIG);
+        tty_tmp=2Ec_lflag &=3D ~(unsigned int)(EC=
HO | ECHOE | ECHOK | ECHONL | ISIG);
         restore_tty =3D (tcsetattr(fi=
leno(fp), TCSAFLUSH, &tty_tmp) =3D=3D 0);
     }
 
diff --git a/src/openvpn=
/crypto=2Ec b/src/openvpn/crypto=2Ec
index 9d53006=2E=2E5ad4b5f 100644
--- =
a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -139,7 +139,7 @@
 =
        ASSERT(cipher_ctx_reset(ctx->cipher, iv));
     }
 
-    dmsg(D_PAC=
KET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc))=
;
+    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLE=
NZ(buf), 80, &gc));
 
     /* Buffer overflow check */
     if (!buf_safe(&=
work, buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
@@ -151,7 +=
151,7 @@
 
     /* For AEAD ciphers, authenticate Additional Data, includin=
g opcode */
     ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN=
(&work)));
-    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(BPTR(&w=
ork), BLEN(&work), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", =
format_hex(BPTR(&work), BLENZ(&work), 0, &gc));
 
     if (!use_epoch_data_=
format)
     {
@@ -170,8 +170,8 @@
 
     /* update number of plaintext blo=
cks encrypted=2E Use the (x + (n-1))/n trick
      * to round up the result=
 to the number of blocks used */
-    const int blocksize =3D AEAD_LIMIT_BL=
OCKSIZE;
-    opt->key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLEN(&work=
) + (blocksize - 1)) / blocksize;
+    const unsigned int blocksize =3D AEA=
D_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (=
BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     /* if the tag is at end=
 the end, allocate it now */
     if (use_epoch_data_format)
@@ -186,7 +186=
,7 @@
 
     *buf =3D work;
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s",=
 format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "E=
NCRYPT TO: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     gc_free=
(&gc);
     return;
@@ -257,13 +257,13 @@
             ASSERT(buf_write(&wo=
rk, iv_buf, iv_size));
             dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s"=
, format_hex(iv_buf, iv_size, 0, &gc));
 
-            dmsg(D_PACKET_CONTEN=
T, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+       =
     dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ=
(buf), 80, &gc));
 
             /* cipher_ctx was already initialized with=
 key & keylen */
             ASSERT(cipher_ctx_reset(ctx->cipher, iv_buf))=
;
 
             /* Buffer overflow check */
-            if (!buf_safe(&wo=
rk, buf->len + cipher_ctx_block_size(ctx->cipher)))
+            if (!buf_s=
afe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
             {=

                 msg(D_CRYPT_ERRORS,
                     "ENCRYPT: buffer=
 size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u",
@@ =
-317,7 +317,7 @@
 
         *buf =3D work;
 
-        dmsg(D_PACKET_CONTENT=
, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+      =
  dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&w=
ork), 80, &gc));
     }
 
     gc_free(&gc);
@@ -456,7 +456,7 @@
     ASSER=
T(buf->len > 0);
     ASSERT(ctx->cipher);
 
-    dmsg(D_PACKET_CONTENT, "D=
ECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_P=
ACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &g=
c));
 
     ASSERT(ad_start >=3D buf->data && ad_start <=3D BPTR(buf));
 
@=
@ -554,10 +554,10 @@
     }
 
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s"=
, format_hex(tag_ptr, tag_size, 0, &gc));
-    dmsg(D_PACKET_CONTENT, "DECR=
YPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &gc));
+    dmsg(D_PACKE=
T_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
=
 
     /* Buffer overflow check (should never fail) */
-    if (!buf_safe(&=
work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&w=
ork, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
     {
         CRYP=
T_ERROR("potential buffer overflow");
     }
@@ -581,7 +581,7 @@
     }
   =
  ASSERT(buf_inc_len(&work, outlen));
 
-    dmsg(D_PACKET_CONTENT, "DECRYP=
T TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+    dmsg(D_PACK=
ET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc=
));
 
     if (!crypto_check_replay(opt, &pin, epoch, error_prefix, &gc))
 =
    {
@@ -590,8 +590,8 @@
 
     /* update number of plaintext blocks decry=
pted=2E Use the (x + (n-1))/n trick
      * to round up the result to the n=
umber of blocks used=2E */
-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZ=
E;
-    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLEN(&work) + (b=
locksize - 1)) / blocksize;
+    const unsigned int blocksize =3D AEAD_LIMI=
T_BLOCKSIZE;
+    opt->key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLENZ(=
&work) + (blocksize - 1)) / blocksize;
 
     *buf =3D work;
 
@@ -627,7 +6=
27,7 @@
         struct packet_id_net pin;
         bool have_pin =3D false=
;
 
-        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf=
), BLEN(buf), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s"=
, format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
         /* Verify the HMA=
C */
         if (ctx->hmac)
@@ -690,7 +690,7 @@
             }
 
         =
    /* Buffer overflow check (should never happen) */
-            if (!buf=
_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+            i=
f (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
     =
        {
                 CRYPT_ERROR("packet too big to decrypt");
      =
       }
@@ -709,7 +709,7 @@
             }
             ASSERT(buf_inc_len=
(&work, outlen));
 
-            dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", f=
ormat_hex(BPTR(&work), BLEN(&work), 80, &gc));
+            dmsg(D_PACKET_C=
ONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
=
 
             /* Get packet ID from plaintext buffer or IV, depending on c=
ipher mode */
             {
@@ -851,7 +851,7 @@
 crypto_max_overhead(void)=

 {
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_=
CIPHER_BLOCK_SIZE
-           + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD=
_TAG_LENGTH);
+           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TA=
G_LENGTH);
 }
 
 static void
@@ -1362,7 +1362,7 @@
         size_t buf_size=
 =3D strlen(file) + 1;
         ASSERT(buf_size <=3D INT_MAX);
         siz=
e =3D (int)buf_size;
-        buf_set_read(&in, (const uint8_t *)file, size=
);
+        buf_set_read(&in, (const uint8_t *)file, buf_size);
     }
    =
 else /* 'file' is a filename which refers to a file containing the ascii k=
ey */
     {
@@ -1531,7 +1531,7 @@
     struct buffer out =3D alloc_buf_gc(=
2048, &gc);
 
     /* how to format the ascii file representation of key */=

-    const int bytes_per_line =3D 16;
+    const unsigned int bytes_per_li=
ne =3D 16;
 
     /* write header */
     buf_printf(&out, "#\n# %d bit Ope=
nVPN static key\n#\n", nbits);
diff --git a/src/openvpn/crypto=2Eh b/src/op=
envpn/crypto=2Eh
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

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02f8df01f8f33cb9cd0=
4cd844d1f1893688f51e8
Gerrit-Change-Number: 2157
Gerrit-PatchSet: 6
Gerrit-=
Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--/3r9Fp8r1DY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2157?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Various trivial -Wsign-conversion =
fixes<br><br>* Continue BLEN -&gt; BLENZ replacement<br>* Remove some unnee=
ded casts<br>* Some trivial type fixes<br><br>Change-Id: I02f8df01f8f33cb9c=
d04cd844d1f1893688f51e8<br>Signed-off-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157<br>Message-=
Id: &lt;20261110143722=2E15193-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41094=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/acc=2Ec<br>M src/openvpn/auth_token=2Ec<br>M src/openvp=
n/base64=2Eh<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/crypto=
=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/crypto_epoch=2Ec<br>M src=
/openvpn/manage=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M tests/unit_tests/=
openvpn/test_crypto=2Ec<br>M tests/unit_tests/openvpn/test_networking=2Ec<b=
r>M tests/unit_tests/openvpn/test_pkt=2Ec<br>M tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec<br>13 files changed, 49 insertions(+), 95 deletions(-)<br><=
br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><=
br><span>index ceb7100=2E=2Edae614a 100644</span><br><span>--- a/src/openvp=
n/acc=2Ec</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -148=
,11 +148,6 @@</span><br><span>     return parse_acc_message_flags(flags, er=
r_reason, gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void</span><br><span> receive_acc_message(struct=
 context *c, const struct buffer *buffer)</span><br><span> {</span><br><spa=
n>@@ -236,15 +231,10 @@</span><br><span>     msg(D_PUSH_ERRORS, &quot;WARNI=
NG: Received malformed custom app control channel &quot;</span><br><span>  =
                      &quot;message (%s): %s&quot;,</span><br><span>       =
  err_reason,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
format_hex(CBPTR(buffer), BLEN(buffer), 80, &amp;gc));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        format_hex(CBPTR(buffer), BLENZ(=
buffer), 80, &amp;gc));</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> bool</span><br><span> send_acc_message(struct context *c,</span=
><br><span>                  struct tls_multi *multi,</span><br><span>diff =
--git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><=
span>index 211af90=2E=2Eb69092c 100644</span><br><span>--- a/src/openvpn/au=
th_token=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><sp=
an>@@ -36,11 +36,6 @@</span><br><span>  * padding */</span><br><span> stati=
c_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multipl=
e of 3&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> bool</span><br><span> is_auth_token(const char *password)</span><br><=
span> {</span><br><span>@@ -67,7 +62,7 @@</span><br><span>         return;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int auth_token_state_flags =3D session-&gt;key[KS_PR=
IMARY]=2Eauth_token_state_flags;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unsigned int auth_token_state_flags =3D session-&gt;key[KS=
_PRIMARY]=2Eauth_token_state_flags;</span><br><span> </span><br><span>     =
const char *state;</span><br><span> </span><br><span>@@ -188,7 +183,7 @@</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int6=
4_t timestamp =3D htonll((uint64_t)now);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int64_t timestamp =3D (int64_t)htonll((uint64_t)no=
w);</span><br><span>     int64_t initial_timestamp =3D timestamp;</span><br=
><span> </span><br><span>     hmac_ctx_t *ctx =3D multi-&gt;opt=2Eauth_toke=
n_key=2Ehmac;</span><br><span>@@ -273,7 +268,7 @@</span><br><span>         =
alloc_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &amp;gc);</=
span><br><span> </span><br><span>     ASSERT(buf_write(&amp;session_token, =
SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(buf_write(&amp;session_token, b64outpu=
t, (int)strlen(b64output)));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(buf_write(&amp;session_token, b64output, strlen(b64outp=
ut)));</span><br><span>     ASSERT(buf_write_u8(&amp;session_token, 0));</s=
pan><br><span> </span><br><span>     free(b64output);</span><br><span>@@ -2=
96,10 +291,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> static bool</span><br><span> check_hmac_token(hmac=
_ctx_t *ctx, const uint8_t *b64decoded, const char *username)</span><br><sp=
an> {</span><br><span>diff --git a/src/openvpn/base64=2Eh b/src/openvpn/bas=
e64=2Eh</span><br><span>index be7aa64=2E=2E800e569 100644</span><br><span>-=
-- a/src/openvpn/base64=2Eh</span><br><span>+++ b/src/openvpn/base64=2Eh</s=
pan><br><span>@@ -35,7 +35,7 @@</span><br><span> #define _BASE64_H_</span><=
br><span> </span><br><span> /** Compute resulting base64 length=2E  6 bits =
per byte, padded to 4 bytes=2E */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_len=
gth) / 6) + 3) &amp; ~3)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / =
6) + 3) &amp; ~3u)</span><br><span> </span><br><span> /** Compute the maxim=
al number of bytes encoded in a base64 string=2E */</span><br><span> #defin=
e OPENVPN_BASE64_DECODED_LENGTH(base64_length) ((base64_length / 4) * 3)</s=
pan><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/co=
nsole_builtin=2Ec</span><br><span>index dc71d12=2E=2E0353ade 100644</span><=
br><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/op=
envpn/console_builtin=2Ec</span><br><span>@@ -234,7 +234,7 @@</span><br><sp=
an>     if (!echo &amp;&amp; (tcgetattr(fileno(fp), &amp;tty_tmp) =3D=3D 0)=
)</span><br><span>     {</span><br><span>         tty_save =3D tty_tmp;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        tty_tmp=2Ec_lflag=
 &amp;=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        tty_tmp=2Ec_lflag &amp;=3D ~(unsigne=
d int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);</span><br><span>         rest=
ore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &amp;tty_tmp) =3D=3D 0);</spa=
n><br><span>     }</span><br><span> </span><br><span>diff --git a/src/openv=
pn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 9d53006=2E=2E5=
ad4b5f 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>=
+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -139,7 +139,7 @@</span><br>=
<span>         ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv));</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BP=
TR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, for=
mat_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><=
span>     /* Buffer overflow check */</span><br><span>     if (!buf_safe(&a=
mp;work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cipher)))</s=
pan><br><span>@@ -151,7 +151,7 @@</span><br><span> </span><br><span>     /*=
 For AEAD ciphers, authenticate Additional Data, including opcode */</span>=
<br><span>     ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, BPTR(&amp;work),=
 BLEN(&amp;work)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;, format_hex(BPTR(&amp;w=
ork), BLEN(&amp;work), 0, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;, for=
mat_hex(BPTR(&amp;work), BLENZ(&amp;work), 0, &amp;gc));</span><br><span> <=
/span><br><span>     if (!use_epoch_data_format)</span><br><span>     {</sp=
an><br><span>@@ -170,8 +170,8 @@</span><br><span> </span><br><span>     /* =
update number of plaintext blocks encrypted=2E Use the (x + (n-1))/n trick<=
/span><br><span>      * to round up the result to the number of blocks used=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int bloc=
ksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    opt-&gt;key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLEN(&a=
mp;work) + (blocksize - 1)) / blocksize;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const unsigned int blocksize =3D AEAD_LIMIT_BLOCKS=
IZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key=
_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLENZ(&amp;work) + (blocksize - =
1)) / blocksize;</span><br><span> </span><br><span>     /* if the tag is at=
 end the end, allocate it now */</span><br><span>     if (use_epoch_data_fo=
rmat)</span><br><span>@@ -186,7 +186,7 @@</span><br><span> </span><br><span=
>     *buf =3D work;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, for=
mat_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&qu=
ot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </sp=
an><br><span>     gc_free(&amp;gc);</span><br><span>     return;</span><br>=
<span>@@ -257,13 +257,13 @@</span><br><span>             ASSERT(buf_write(&=
amp;work, iv_buf, iv_size));</span><br><span>             dmsg(D_PACKET_CON=
TENT, &quot;ENCRYPT IV: %s&quot;, format_hex(iv_buf, iv_size, 0, &amp;gc));=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BP=
TR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&qu=
ot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </sp=
an><br><span>             /* cipher_ctx was already initialized with key &a=
mp; keylen */</span><br><span>             ASSERT(cipher_ctx_reset(ctx-&gt;=
cipher, iv_buf));</span><br><span> </span><br><span>             /* Buffer =
overflow check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&g=
t;cipher)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (!buf_safe(&amp;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cip=
her)))</span><br><span>             {</span><br><span>                 msg(=
D_CRYPT_ERRORS,</span><br><span>                     &quot;ENCRYPT: buffer =
size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u&quot;,=
</span><br><span>@@ -317,7 +317,7 @@</span><br><span> </span><br><span>    =
     *buf =3D work;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, =
format_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_PACKET_CONTENT, &quo=
t;ENCRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &=
amp;gc));</span><br><span>     }</span><br><span> </span><br><span>     gc_=
free(&amp;gc);</span><br><span>@@ -456,7 +456,7 @@</span><br><span>     ASS=
ERT(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(=
D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(=
buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(b=
uf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><span>     ASSE=
RT(ad_start &gt;=3D buf-&gt;data &amp;&amp; ad_start &lt;=3D BPTR(buf));</s=
pan><br><span> </span><br><span>@@ -554,10 +554,10 @@</span><br><span>     =
}</span><br><span> </span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRY=
PT MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DE=
CRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 0, &amp;gc));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT,=
 &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc=
));</span><br><span> </span><br><span>     /* Buffer overflow check (should=
 never fail) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher))=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(=
&amp;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><=
span>     {</span><br><span>         CRYPT_ERROR(&quot;potential buffer ove=
rflow&quot;);</span><br><span>     }</span><br><span>@@ -581,7 +581,7 @@</s=
pan><br><span>     }</span><br><span>     ASSERT(buf_inc_len(&amp;work, out=
len));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&=
amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot=
;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &amp;gc));</span><br><=
span> </span><br><span>     if (!crypto_check_replay(opt, &amp;pin, epoch, =
error_prefix, &amp;gc))</span><br><span>     {</span><br><span>@@ -590,8 +5=
90,8 @@</span><br><span> </span><br><span>     /* update number of plaintex=
t blocks decrypted=2E Use the (x + (n-1))/n trick</span><br><span>      * t=
o round up the result to the number of blocks used=2E */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const int blocksize =3D AEAD_LIMIT_B=
LOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;=
key_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLEN(&amp;work) + (blocksize =
- 1)) / blocksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi=2Edecrypt=2Epl=
aintext_blocks +=3D (BLENZ(&amp;work) + (blocksize - 1)) / blocksize;</span=
><br><span> </span><br><span>     *buf =3D work;</span><br><span> </span><b=
r><span>@@ -627,7 +627,7 @@</span><br><span>         struct packet_id_net p=
in;</span><br><span>         bool have_pin =3D false;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_CON=
TENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dms=
g(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLE=
NZ(buf), 80, &amp;gc));</span><br><span> </span><br><span>         /* Verif=
y the HMAC */</span><br><span>         if (ctx-&gt;hmac)</span><br><span>@@=
 -690,7 +690,7 @@</span><br><span>             }</span><br><span> </span><b=
r><span>             /* Buffer overflow check (should never happen) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!buf_safe(=
&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (!buf_safe(&amp=
;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span=
>             {</span><br><span>                 CRYPT_ERROR(&quot;packet t=
oo big to decrypt&quot;);</span><br><span>             }</span><br><span>@@=
 -709,7 +709,7 @@</span><br><span>             }</span><br><span>          =
   ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTENT, &=
quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 80,=
 &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp=
;work), BLENZ(&amp;work), 80, &amp;gc));</span><br><span> </span><br><span>=
             /* Get packet ID from plaintext buffer or IV, depending on cip=
her mode */</span><br><span>             {</span><br><span>@@ -851,7 +851,7=
 @@</span><br><span> crypto_max_overhead(void)</span><br><span> {</span><br=
><span>     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_M=
AX_CIPHER_BLOCK_SIZE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
          + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           + max_uint(OPEN=
VPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span>@@ -1362,7 +1362,7 @@</=
span><br><span>         size_t buf_size =3D strlen(file) + 1;</span><br><sp=
an>         ASSERT(buf_size &lt;=3D INT_MAX);</span><br><span>         size=
 =3D (int)buf_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      buf_set_read(&amp;in, (const uint8_t *)file, size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf_set_read(&amp;in, (const =
uint8_t *)file, buf_size);</span><br><span>     }</span><br><span>     else=
 /* &#39;file&#39; is a filename which refers to a file containing the asci=
i key */</span><br><span>     {</span><br><span>@@ -1531,7 +1531,7 @@</span=
><br><span>     struct buffer out =3D alloc_buf_gc(2048, &amp;gc);</span><b=
r><span> </span><br><span>     /* how to format the ascii file representati=
on of key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 int bytes_per_line =3D 16;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const unsigned int bytes_per_line =3D 16;</span><br><span> </sp=
an><br><span>     /* write header */</span><br><span>     buf_printf(&amp;o=
ut, &quot;#\n# %d bit OpenVPN static key\n#\n&quot;, nbits);</span><br><spa=
n>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><s=
pan>index 7e240d2=2E=2Ef0cacde 100644</span><br><span>--- a/src/openvpn/cry=
pto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -74=
6,12 +746,12 @@</span><br><span>  * to read=2E</span><br><span>  */</span><=
br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-aead_usage_limit_reached(const uint64_t limit, const struct key_ctx =
*key_ctx, int64_t higest_pid)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+aead_usage_limit_reached(const uint64_t limit, const struct key_c=
tx *key_ctx, uint64_t higest_pid)</span><br><span> {</span><br><span>     /=
* This is the  q + s &lt;=3D  p^(1/2) * 2^(129/2) - 1 calculation where</sp=
an><br><span>      * q is the number of protected messages (highest_pid)</s=
pan><br><span>      * s Total plaintext length in all messages (in blocks) =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (limit &=
gt; 0 &amp;&amp; key_ctx-&gt;plaintext_blocks + (uint64_t)higest_pid &gt; l=
imit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (l=
imit &gt; 0 &amp;&amp; key_ctx-&gt;plaintext_blocks + higest_pid &gt; limit=
);</span><br><span> }</span><br><span> </span><br><span> #endif /* CRYPTO_H=
 */</span><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn=
/crypto_epoch=2Ec</span><br><span>index 312cf6f=2E=2E243b5a2 100644</span><=
br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openv=
pn/crypto_epoch=2Ec</span><br><span>@@ -98,7 +98,7 @@</span><br><span>     =
const uint8_t *label_prefix =3D (const uint8_t *)(&quot;ovpn &quot;);</span=
><br><span>     uint8_t prefix_len =3D 5;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    size_t hkdf_label_len =3D 2 + pre=
fix_len + 1 + label_len + 1 + context_len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    size_t hkdf_label_len =3D 2u + prefix_len + 1u +=
 label_len + 1u + context_len;</span><br><span>     struct buffer hkdf_labe=
l =3D alloc_buf_gc(hkdf_label_len, &amp;gc);</span><br><span> </span><br><s=
pan>     buf_write_u16(&amp;hkdf_label, (uint16_t)out_len);</span><br><span=
>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><sp=
an>index 4809532=2E=2E1760c90 100644</span><br><span>--- a/src/openvpn/mana=
ge=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -275=
8,7 +2758,7 @@</span><br><span>             else</span><br><span>          =
   {</span><br><span>                 int status;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                int resolve_flags =3D GETADDR_R=
ESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                unsigned int resolve_flags =3D=
 GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;</span><br><span>=
 </span><br><span>                 if (!(flags &amp; MF_CONNECT_AS_CLIENT))=
</span><br><span>                 {</span><br><span>@@ -4001,11 +4001,11 @@=
</span><br><span>         desc =3D &quot;rsa-sign&quot;;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    buf_write(&amp;buf_data, b64_data, (int)strlen(b64_data));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf_data, b6=
4_data, strlen(b64_data));</span><br><span>     if (man-&gt;connection=2Ecl=
ient_version &gt;=3D MCV_PKSIGN_ALG)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        buf_write(&amp;buf_data, &quo=
t;,&quot;, (int)strlen(&quot;,&quot;));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        buf_write(&amp;buf_data, algorithm, (int)strlen(a=
lgorithm));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buf_write(&amp;buf_data, &quot;,&quot;, strlen(&quot;,&quot;));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;buf_data=
, algorithm, strlen(algorithm));</span><br><span>     }</span><br><span>   =
  char *ret =3D management_query_multiline_flatten(man, (char *)buf_bptr(&a=
mp;buf_data), prompt, desc,</span><br><span>                               =
                     &amp;man-&gt;connection=2Eext_key_state,</span><br><sp=
an>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</=
span><br><span>index cbc3118=2E=2Ef4e142b 100644</span><br><span>--- a/src/=
openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</=
span><br><span>@@ -1119,7 +1119,7 @@</span><br><span>         return 0;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    retval =3D endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in=
, BPTR(buf), buf-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    retval =3D endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(bu=
f), BLENZ(buf));</span><br><span> </span><br><span>     if (retval &lt; 0)<=
/span><br><span>     {</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><spa=
n>index e68a0b2=2E=2E6ccca33 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_crypto=2Ec</span><br><span>@@ -52,11 +52,6 @@</span><br><span> </span><br>=
<span> static const char testtext[] =3D &quot;Dummy text to test PEM encodi=
ng&quot;;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 static void</span><br><span> crypto_pem_encode_decode_loopback(void **stat=
e)</span><br><span> {</span><br><span>@@ -438,14 +433,14 @@</span><br><span=
>      * current mode (FIPS), this will still return -1 */</span><br><span>=
     assert_int_equal(cipher_get_aead_limits(&quot;CHACHA20-POLY1305&quot;)=
, 0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int64_t aeslimit =3D cipher_get_aead_limits(&quot;AES-128-GCM&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t aeslim=
it =3D cipher_get_aead_limits(&quot;AES-128-GCM&quot;);</span><br><span> </=
span><br><span>     assert_int_equal(aeslimit, (1ull &lt;&lt; 36) - 1);</sp=
an><br><span> </span><br><span>     /* Check if this matches our exception =
for 1600 size packets assuming</span><br><span>      * AEAD_LIMIT_BLOCKSIZE=
 (128 bits/ 16 bytes)=2E Gives us 100 blocks</span><br><span>      * + 1 fo=
r the packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t64_t L =3D 101;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint64_t L =3D 101;</span><br><span>     /* 2 ^ 29=2E34, using the result =
here to avoid linking to libm */</span><br><span>     assert_int_equal(aesl=
imit / L, 680390858);</span><br><span> </span><br><span>@@ -491,7 +486,7 @@=
</span><br><span>                          0xec, 0xed, 0xee, 0xef, 0xf0, 0x=
f1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,</span><br><span>                   =
       0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int L =3D 82=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t L=
 =3D 82;</span><br><span>     uint8_t okm[82] =3D { 0xb1, 0x1e, 0x39, 0x8d,=
 0xc8, 0x03, 0x27, 0xa1, 0xc8, 0xe7, 0xf7, 0x8c,</span><br><span>          =
               0x59, 0x6a, 0x49, 0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, =
0xfa, 0xd8,</span><br><span>                         0xa0, 0x50, 0xcc, 0x4c=
, 0x19, 0xaf, 0xa9, 0x7c, 0x59, 0x04, 0x5a, 0x99,</span><br><span>@@ -516,7=
 +511,7 @@</span><br><span> </span><br><span>     const uint8_t info[] =3D =
{ 0 };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int L =3D 42;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const size_t L =3D 42;</span><br><span>     uint8_t okm[42] =3D { 0x8d=
, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><sp=
an>                         0x2a, 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1f,=
 0x5c, 0x5e, 0xe1,</span><br><span>                         0x87, 0x9e, 0xc=
3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d, 0x9d,</span><br><span>@@ -541,=
7 +536,7 @@</span><br><span>     uint8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0=
x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,</span><br><span>                        =
  0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int L =3D 27;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t L =3D =
27;</span><br><span>     uint8_t okm[27] =3D { 0x87, 0x5a, 0x8e, 0xec, 0x18=
, 0x55, 0x63, 0x80, 0xb8,</span><br><span>                         0xd9, 0x=
33, 0xed, 0x32, 0x3c, 0x2d, 0xf8, 0xe8, 0xec,</span><br><span>             =
            0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0, 0x6a, 0x83, 0xac };</span><=
br><span>@@ -753,7 +748,7 @@</span><br><span> </span><br><span>     /* look=
up some wacky things that should fail */</span><br><span>     assert_null(e=
poch_lookup_decrypt_key(co, 2000));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    assert_null(epoch_lookup_decrypt_key(co, -1));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_d=
ecrypt_key(co, UINT16_MAX));</span><br><span>     assert_null(epoch_lookup_=
decrypt_key(co, 0xefff));</span><br><span> </span><br><span>     /* Lookup =
the edges of the current window */</span><br><span>@@ -804,10 +799,6 @@</sp=
an><br><span>     assert_null(epoch_lookup_decrypt_key(co, 23));</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> crypto_test_epoch_=
key_overflow(void **state)</span><br><span> {</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/tes=
t_networking=2Ec</span><br><span>index ae75386=2E=2E3699a2a1 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>@@ -40,=
23 +40,14 @@</span><br><span>     return net_iface_del(NULL, name);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net__i=
face_mtu_set(int mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+net__iface_mtu_set(uint32_t mtu)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;CMD: ip link set %s mtu %d=
\n&quot;, iface, mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    printf(&quot;CMD: ip link set %s mtu %u\n&quot;, iface, mtu);</span>=
<br><span> </span><br><span>     return net_iface_mtu_set(NULL, iface, mtu)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><span> =
net__addr_v4_add(const char *addr_str, int prefixlen)</span><br><span> {</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span>index 889e6d7=2E=2E49ba833 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -618,1=
1 +618,6 @@</span><br><span>     assert_memory_equal(server_id2_p1=2Eid, se=
rver_id_p2=2Eid, SID_SIZE);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> test_gen=
erate_reset_packet_plain(void **ut_state)</span><br><span> {</span><br><spa=
n>@@ -701,10 +696,6 @@</span><br><span>     free_tas(&amp;tas_server);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> /* A peer can ask us to append the=
 wrapped client key (WKc) to our next</span><br><span>  * control packet=2E=
 Only a tls-crypt-v2 client has one, so check that we</span><br><span>  * r=
efuse to build such a packet when we have no key instead of walking</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index ab90ea5=2E=2E2d3=
1c00 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</spa=
n><br><span>@@ -352,7 +352,7 @@</span><br><span>     skip_if_tls_crypt_not_=
supported(ctx);</span><br><span> </span><br><span>     buf_clear(&amp;ctx-&=
gt;source);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_non_null(buf_write_alloc(&amp;ctx-&gt;source, TESTBUF_SIZE - BLEN(&amp;ctx=
-&gt;ciphertext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_non_null(buf_write_alloc(&amp;ctx-&gt;source, TESTBUF_SIZE - BLENZ(=
&amp;ctx-&gt;ciphertext)</span><br><span>                                  =
                     - tls_crypt_buf_overhead()));</span><br><span> </span>=
<br><span>     assert_true(tls_crypt_wrap(&amp;ctx-&gt;source, &amp;ctx-&gt=
;ciphertext, &amp;ctx-&gt;co));</span><br><span>@@ -373,7 +373,7 @@</span><=
br><span>     skip_if_tls_crypt_not_supported(ctx);</span><br><span> </span=
><br><span>     buf_clear(&amp;ctx-&gt;source);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    assert_non_null(buf_write_alloc(&amp;ctx-&gt;=
source, TESTBUF_SIZE - BLEN(&amp;ctx-&gt;ciphertext)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(buf_write_alloc(&amp;=
ctx-&gt;source, TESTBUF_SIZE - BLENZ(&amp;ctx-&gt;ciphertext)</span><br><sp=
an>                                                       - tls_crypt_buf_o=
verhead() + 1));</span><br><span>     assert_false(tls_crypt_wrap(&amp;ctx-=
&gt;source, &amp;ctx-&gt;ciphertext, &amp;ctx-&gt;co));</span><br><span> }<=
/span><br><span>@@ -553,7 +553,7 @@</span><br><span>     assert_false(tls_c=
rypt_v2_extract_client_key(&amp;ctx-&gt;wkc, &amp;wrap_ctx, NULL));</span><=
br><span> </span><br><span>     /* add a opcode in front of the key to make=
 it valid to extract */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct buffer wkcop =3D alloc_buf_gc(buf_len(&amp;ctx-&gt;wkc) + 1, &=
amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer wkcop =3D alloc_buf_gc(BLENZ(&amp;ctx-&gt;wkc) + 1, &amp;ctx=
-&gt;gc);</span><br><span>     buf_write_u8(&amp;wkcop, 0x50);</span><br><s=
pan>     buf_copy(&amp;wkcop, &amp;ctx-&gt;wkc);</span><br><span>     asser=
t_true(tls_crypt_v2_extract_client_key(&amp;wkcop, &amp;wrap_ctx, NULL));</=
span><br><span>@@ -638,7 +638,7 @@</span><br><span>     int64_t create_time=
 =3D now - (days_ago * 24 * 60 * 60);</span><br><span>     assert_true(crea=
te_time &gt; 0);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int64_t timestamp =3D htonll((uint64_t)create_time);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t timestamp =
=3D htonll((uint64_t)create_time);</span><br><span>     ASSERT(buf_write(&a=
mp;metadata, &amp;TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));</span><br><span> =
    ASSERT(buf_write(&amp;metadata, &amp;timestamp, sizeof(timestamp)));</s=
pan><br><span> </span><br><span>@@ -660,7 +660,7 @@</span><br><span>       =
                                       &amp;ctx-&gt;server_keys=2Eencrypt, =
&amp;ctx-&gt;gc));</span><br><span> </span><br><span>     /* add a opcode i=
n front of the key to make it valid to extract */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct buffer pseudo_packet =3D alloc_buf_g=
c(buf_len(&amp;ctx-&gt;wkc) + 1, &amp;ctx-&gt;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct buffer pseudo_packet =3D alloc_bu=
f_gc(BLENZ(&amp;ctx-&gt;wkc) + 1, &amp;ctx-&gt;gc);</span><br><span> </span=
><br><span>     buf_write_u8(&amp;pseudo_packet, 0x50);</span><br><span>   =
  buf_copy(&amp;pseudo_packet, &amp;ctx-&gt;wkc);</span><br><span>@@ -745,7=
 +745,7 @@</span><br><span>     struct buffer expected_metadata =3D create_=
metadata_days_ago(&amp;ctx-&gt;gc, 29);</span><br><span>     buf_advance(&a=
mp;expected_metadata, 1);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    expect_memory(__wrap_buffer_write_file, pem, buf_=
bptr(&amp;expected_metadata), buf_len(&amp;expected_metadata));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    expect_memory(__wrap_buffer=
_write_file, pem, buf_bptr(&amp;expected_metadata), BLENZ(&amp;expected_met=
adata));</span><br><span>     will_return(__wrap_buffer_write_file, true);<=
/span><br><span> </span><br><span>     tmp =3D create_client_key_input(ctx,=
 29);</span><br><span>@@ -760,7 +760,7 @@</span><br><span>     }</span><br>=
<span> </span><br><span>     expect_string(__wrap_buffer_write_file, filena=
me, tmpfile_path);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&amp;expected_metada=
ta), buf_len(&amp;expected_metadata));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    expect_memory(__wrap_buffer_write_file, pem, buf_bpt=
r(&amp;expected_metadata), BLENZ(&amp;expected_metadata));</span><br><span>=
     will_return(__wrap_buffer_write_file, true);</span><br><span> </span><=
br><span>     tmp =3D create_client_key_input(ctx, 29);</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?u=
sp=3Demail">change 2157</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2157?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2157 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--/3r9Fp8r1DY=--


--===============9179312499101132862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9179312499101132862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9179312499101132862==--


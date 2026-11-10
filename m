Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C7606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JpnUraat;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h4YoqE+3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BYnmI8DF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QKj0eL+c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VnfRWgc+KSxaNRUNOhJk5SChkFTwSHj2oHnExyLCHxM=; b=JpnUraatmMXp8F3oU6Ke7mBtqx
	ZhDPD1iNv9usKZzmKXOrN7Zr/dYzbBf6dCAQRvkSZeVOoI1bytkXacl9jF9cU4qeg1A+qyGDEx5ZX
	lIh/ltuOqtx33bxMdcBjvpTfXK3IiEe0XqNQH0fGMOyrGHi2nwug62wyTUFh6r3r2OXg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmbS-000000003sw-0t0p;
	Tue, 10 Nov 2026 14:13:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmbQ-000000003so-2yg3
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dl3oOXY/XkJHkecJgLdNSk1mF8aoPN6rNMIuAau2r0M=; b=h4YoqE+3S6Tq9Bj/FjIGL9Rak7
 CLat0qRCIYXVat24xTvQRPuvGCrOrrajLlNLbfBjC6072f7TM3SemV2657fquQBHTgwyqZcYyV606
 pSMWENikebXRPKUQkNQYPqVnI9QEaZPv04aIbEMZqtAsjktHYRLDsGZwCMnTnpSUxUgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dl3oOXY/XkJHkecJgLdNSk1mF8aoPN6rNMIuAau2r0M=; b=BYnmI8DFJ03qJoLWNq1+9Uo5J7
 hGpgBdAMbC4LBdUb1kyZiF1q7w5ghhQ/ym4OkDZNC38UKY8IfX5iRhXxNRXQHNLuxhdh6ZT4kBmKP
 uFUf2h+FFT+spqyrtVdTwNeS2wRl1580Ukof6JHEvNHhuCVBt0Z+Jpi/fLcPjbNdDUno=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmbM-000000007z6-2uZj for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:13:36 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso17106135e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794320006; x=1794924806; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dl3oOXY/XkJHkecJgLdNSk1mF8aoPN6rNMIuAau2r0M=;
 b=QKj0eL+cCab0/eR78JVA+FWDYHYEkeoFJ27GD57MvgWq5ryMtdDPGiMvSqiEY5FcuY
 +3sKMnZacx6ekpdztYRej79iCcXvGMKoBVWsUZxJX84oMvTdbn98+nLTiAA5CihQpiPV
 VzGhOzM68yT3Ya3/UtbnL30aRyJ9QjiHCDyh2dowBYosM3AoEurelm8fsr/ibLI247Jg
 BnhNBBWbuFUmDqUpmUptH6jlV89MGZ7epE5grVISWgkB1kqov6pv4iAauq0ZleCILcGz
 dro9fPwT1sN9rhSkHEI1ZLyhOt0ULOMg3JpuWwtvrUTtUB9LzqIkAl2xbaGOMn0XXQga
 R6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794320006; x=1794924806;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dl3oOXY/XkJHkecJgLdNSk1mF8aoPN6rNMIuAau2r0M=;
 b=k3zIt6GpIWbzLx2dq/rE4xyHkPbiyEFDR59KUr6l8C6qKBjTa6bEzb6Gm2lC6wKVO0
 kLO08VB3w4+YoLxX5JULMTY6LBnYo9QUoPbkWHcR78OZUHizg0FYjsk5NVt7iLJJ0Her
 txM3uTOZYkuCXWLQJ/hPRkR4T2pnBblgO/6b0WwTbQoYmipbcyepI3WNALf4jyu038E1
 St0LPNd5/FpLyX15hBEhLWKBH1nHmPrzFaY4r0ZvGfAydnjALyxFaawUlW+FFRj7RUXr
 8l57s2f1B27fZeDF0teLmJr3ZT7xgPzsDjlhC7e7TqTEZ6Ge0TUQ1ouR6zKYBZQyabgq
 Ad1g==
X-Gm-Message-State: APuU4Z/z+FUQ0IpMbKkvTqtdio/J11tIwaAvlYzM/xQlds8xrpCYzj/O
 N4F5blGNKZwaTtFSlRAraj80Xnhmn7LgoxTI9Sr4h1KbXSXMtxnocbDfTX9bGIfGM9jlUdV69mM
 Xslb//yQJTWCcyLfONFmxqCpsXRmXipAcEpi8n1f5EQ6YvyDwuKf9tEms1W2DUyGuZUGV
X-Gm-Gg: AYBFou1jJqK3eJ8IK7Pz1Jy91Y1cD7cogjJnQ9kWMSdm5uJ4qGvzGopTyndd26s3aCD
 Aanr0vEJ+HzW6IVhxFvAowpGx4CnNkuQrR0GKaE8KM/tG+cgE6DLfk7TuM4ywydo4e6r5IhDE3D
 piogrw/tQd05kVLkRI5j8yoGapNi+ID+zMvLd+RlDVI+9dBeGHAXOImtGTZ7G0QWSSiSaoSVJHT
 DFRl1k2fdoWekMKANtmcgMBd2ddVcMKF9kck2sN0nWO2Qa2d57myl6w9b6mr+SUKcYQ1J1aik7M
 bNkZHeRO0dEuEe8HvmowYxeAdeN+GPktuxaqivINcEMLM/17VtgszbIB57zHJAmj6OXfZ9FcA1j
 6bGRv94OKG6+RdYdpEqr+axcS9VkzJ2XbzsOgc+Tg+Pbrwk61FouhbF7+HvtQ44q00B6lDM233c
 nZpF/DigIpEATO/bTXJ2zJVWE93zJyUbt23EqdOVN8AVQH6S9EsMPB2U1mTts+tB4JUTGwvZq8H
 tJ3r2cR9cTGy6SQAuJhr8j+y2kXMwhTb9AAag4ok4Zm1kXNOk9tFUU1kdCK+Cp/QVC7Gv1UpxoY
 Sixz8FgKa6ZmLZVTda3oupi4kLZagScrLjYDafvoqgdQt5/PbjV5TIOWU9AD3OPpDpJ/a310Ih/
 52qN49rVtUrPaokLePOhJUnHG1TI5bSn/OgyF4NHeHZwjbfca2JBx0mszTZtaweQI46Pmq3nTvj
 XT/+4i89hQjAETv94VTEipHfHolpxYM4Lc4X/8
X-Received: by 2002:a05:600c:6290:b0:4a6:7d6:821f with SMTP id
 5b1f17b1804b1-4ba02350573mr51874475e9.29.1794320005493; 
 Tue, 10 Nov 2026 06:13:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm61619045e9.15.2026.11.10.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:13:25 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:13:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: b4ea722bae1c48a481b79713c37a670264e4c61c
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <63bc53c31e51e66109beb1c30cdc13a3996766c5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmbM-000000007z6-2uZj
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0207615525419312989=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0207615525419312989==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ll9DZDcRJwY="; charset=UTF-8

--Ll9DZDcRJwY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2157?usp=3Demail

to look at the new patch set (#4)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: Various trivial -Wsign-conversion fixes
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Various trivial =
-Wsign-conversion fixes

* Continue BLEN -> BLENZ replacement
* Remove some=
 unneeded casts
* Some trivial type fixes

Change-Id: I02f8df01f8f33cb9cd04=
cd844d1f1893688f51e8
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
---
M src/openvpn/acc=2Ec
M src/openvpn/auth_token=2Ec
M src/openvpn/b=
ase64=2Eh
M src/openvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/=
openvpn/crypto=2Eh
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/manage=2Ec
=
M src/openvpn/ssl_mbedtls=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M =
tests/unit_tests/openvpn/test_networking=2Ec
M tests/unit_tests/openvpn/tes=
t_pkt=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
13 files changed, 4=
9 insertions(+), 95 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/57/2157/4

diff --git a/src/openvpn/acc=2Ec b/sr=
c/openvpn/acc=2Ec
index e21891d=2E=2Eb8d7c3d 100644
--- a/src/openvpn/acc=
=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -148,11 +148,6 @@
     return parse_acc_m=
essage_flags(flags, err_reason, gc);
 }
 
-#if defined(__GNUC__) || defined=
(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-=
Wsign-conversion"
-#endif
-
 void
 receive_acc_message(struct context *c, c=
onst struct buffer *buffer)
 {
@@ -236,15 +231,10 @@
     msg(D_PUSH_ERRORS=
, "WARNING: Received malformed custom app control channel "
               =
         "message (%s): %s",
         err_reason,
-        format_hex(CBPTR=
(buffer), BLEN(buffer), 80, &gc));
+        format_hex(CBPTR(buffer), BLENZ=
(buffer), 80, &gc));
     gc_free(&gc);
 }
 
-
-#if defined(__GNUC__) || de=
fined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 send_acc_mess=
age(struct context *c,
                  struct tls_multi *multi,
diff --gi=
t a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index 211af90=
=2E=2Eb69092c 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/aut=
h_token=2Ec
@@ -36,11 +36,6 @@
  * padding */
 static_assert(TOKEN_DATA_LEN=
 % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple of 3");
 
-#if defined(__G=
NUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diag=
nostic ignored "-Wsign-conversion"
-#endif
-
 bool
 is_auth_token(const cha=
r *password)
 {
@@ -67,7 +62,7 @@
         return;
     }
 
-    int auth_t=
oken_state_flags =3D session->key[KS_PRIMARY]=2Eauth_token_state_flags;
+  =
  unsigned int auth_token_state_flags =3D session->key[KS_PRIMARY]=2Eauth_t=
oken_state_flags;
 
     const char *state;
 
@@ -188,7 +183,7 @@
 {
     s=
truct gc_arena gc =3D gc_new();
 
-    int64_t timestamp =3D htonll((uint64=
_t)now);
+    int64_t timestamp =3D (int64_t)htonll((uint64_t)now);
     in=
t64_t initial_timestamp =3D timestamp;
 
     hmac_ctx_t *ctx =3D multi->op=
t=2Eauth_token_key=2Ehmac;
@@ -273,7 +268,7 @@
         alloc_buf_gc(strlen=
(SESSION_ID_PREFIX) + strlen(b64output) + 1, &gc);
 
     ASSERT(buf_write(=
&session_token, SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));
-    ASSERT=
(buf_write(&session_token, b64output, (int)strlen(b64output)));
+    ASSERT=
(buf_write(&session_token, b64output, strlen(b64output)));
     ASSERT(buf_=
write_u8(&session_token, 0));
 
     free(b64output);
@@ -296,10 +291,6 @@
=
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#prag=
ma GCC diagnostic pop
-#endif
-
 static bool
 check_hmac_token(hmac_ctx_t *=
ctx, const uint8_t *b64decoded, const char *username)
 {
diff --git a/src/o=
penvpn/base64=2Eh b/src/openvpn/base64=2Eh
index be7aa64=2E=2E800e569 10064=
4
--- a/src/openvpn/base64=2Eh
+++ b/src/openvpn/base64=2Eh
@@ -35,7 +35,7 =
@@
 #define _BASE64_H_
 
 /** Compute resulting base64 length=2E  6 bits pe=
r byte, padded to 4 bytes=2E */
-#define OPENVPN_BASE64_LENGTH(binary_lengt=
h) ((((8 * binary_length) / 6) + 3) & ~3)
+#define OPENVPN_BASE64_LENGTH(bi=
nary_length) ((((8 * binary_length) / 6) + 3) & ~3u)
 
 /** Compute the max=
imal number of bytes encoded in a base64 string=2E */
 #define OPENVPN_BASE=
64_DECODED_LENGTH(base64_length) ((base64_length / 4) * 3)
diff --git a/src=
/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index dc71d1=
2=2E=2E0353ade 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openv=
pn/console_builtin=2Ec
@@ -234,7 +234,7 @@
     if (!echo && (tcgetattr(fil=
eno(fp), &tty_tmp) =3D=3D 0))
     {
         tty_save =3D tty_tmp;
-      =
  tty_tmp=2Ec_lflag &=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
+        =
tty_tmp=2Ec_lflag &=3D ~(unsigned int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG=
);
         restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp) =3D=
=3D 0);
     }
 
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec
index 88c2c52=2E=2Ea4c2683 100644
--- a/src/openvpn/crypto=2Ec
+++ b/s=
rc/openvpn/crypto=2Ec
@@ -139,7 +139,7 @@
         ASSERT(cipher_ctx_reset(=
ctx->cipher, iv));
     }
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s",=
 format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "E=
NCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Bu=
ffer overflow check */
     if (!buf_safe(&work, buf->len + mac_len + ciphe=
r_ctx_block_size(ctx->cipher)))
@@ -151,7 +151,7 @@
 
     /* For AEAD ciph=
ers, authenticate Additional Data, including opcode */
     ASSERT(cipher_c=
tx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work)));
-    dmsg(D_PACKET_CO=
NTENT, "ENCRYPT AD: %s", format_hex(BPTR(&work), BLEN(&work), 0, &gc));
+  =
  dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(BPTR(&work), BLENZ(&w=
ork), 0, &gc));
 
     if (!use_epoch_data_format)
     {
@@ -170,8 +170,8 =
@@
 
     /* update number of plaintext blocks encrypted=2E Use the (x + (n=
-1))/n trick
      * to round up the result to the number of blocks used */=

-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi=2E=
encrypt=2Eplaintext_blocks +=3D (BLEN(&work) + (blocksize - 1)) / blocksize=
;
+    const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key=
_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLENZ(&work) + (blocksize - 1)) =
/ blocksize;
 
     /* if the tag is at end the end, allocate it now */
   =
  if (use_epoch_data_format)
@@ -186,7 +186,7 @@
 
     *buf =3D work;
 
- =
   dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLEN(buf)=
, 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(=
buf), BLENZ(buf), 80, &gc));
 
     gc_free(&gc);
     return;
@@ -257,13 +=
257,13 @@
             ASSERT(buf_write(&work, iv_buf, iv_size));
         =
    dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0,=
 &gc));
 
-            dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_he=
x(BPTR(buf), BLEN(buf), 80, &gc));
+            dmsg(D_PACKET_CONTENT, "ENC=
RYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
            =
 /* cipher_ctx was already initialized with key & keylen */
             AS=
SERT(cipher_ctx_reset(ctx->cipher, iv_buf));
 
             /* Buffer overf=
low check */
-            if (!buf_safe(&work, buf->len + cipher_ctx_block_=
size(ctx->cipher)))
+            if (!buf_safe(&work, BLENZ(buf) + cipher_c=
tx_block_size(ctx->cipher)))
             {
                 msg(D_CRYPT_ER=
RORS,
                     "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=
=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u",
@@ -317,7 +317,7 @@
 
         *bu=
f =3D work;
 
-        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(=
BPTR(&work), BLEN(&work), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "ENCRY=
PT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
     }
 
     =
gc_free(&gc);
@@ -460,7 +460,7 @@
     ASSERT(buf->len > 0);
     ASSERT(ct=
x->cipher);
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BP=
TR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %=
s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     ASSERT(ad_start >=
=3D buf->data && ad_start <=3D BPTR(buf));
 
@@ -558,10 +558,10 @@
     }
 =

     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_siz=
e, 0, &gc));
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPT=
R(buf), BLEN(buf), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s"=
, format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer overflow che=
ck (should never fail) */
-    if (!buf_safe(&work, buf->len + cipher_ctx_b=
lock_size(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_=
block_size(ctx->cipher)))
     {
         CRYPT_ERROR("potential buffer ove=
rflow");
     }
@@ -585,7 +585,7 @@
     }
     ASSERT(buf_inc_len(&work, o=
utlen));
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&w=
ork), BLEN(&work), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s",=
 format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
 
     if (!crypto_check_=
replay(opt, &pin, epoch, error_prefix, &gc))
     {
@@ -594,8 +594,8 @@
 
 =
    /* update number of plaintext blocks decrypted=2E Use the (x + (n-1))/n=
 trick
      * to round up the result to the number of blocks used=2E */
- =
   const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi=2Edec=
rypt=2Eplaintext_blocks +=3D (BLEN(&work) + (blocksize - 1)) / blocksize;
+=
    const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ct=
x_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLENZ(&work) + (blocksize - 1)) / b=
locksize;
 
     *buf =3D work;
 
@@ -631,7 +631,7 @@
         struct packe=
t_id_net pin;
         bool have_pin =3D false;
 
-        dmsg(D_PACKET_CO=
NTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+   =
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ=
(buf), 80, &gc));
 
         /* Verify the HMAC */
         if (ctx->hmac)
=
@@ -694,7 +694,7 @@
             }
 
             /* Buffer overflow check =
(should never happen) */
-            if (!buf_safe(&work, buf->len + ciphe=
r_ctx_block_size(ctx->cipher)))
+            if (!buf_safe(&work, BLENZ(buf=
) + cipher_ctx_block_size(ctx->cipher)))
             {
                 CR=
YPT_ERROR("packet too big to decrypt");
             }
@@ -713,7 +713,7 @@
=
             }
             ASSERT(buf_inc_len(&work, outlen));
 
-        =
    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&=
work), 80, &gc));
+            dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", for=
mat_hex(BPTR(&work), BLENZ(&work), 80, &gc));
 
             /* Get packet =
ID from plaintext buffer or IV, depending on cipher mode */
             {
=
@@ -855,7 +855,7 @@
 crypto_max_overhead(void)
 {
     return packet_id_siz=
e(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_CIPHER_BLOCK_SIZE
-          =
 + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+           + m=
ax_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
 static void
=
@@ -1366,7 +1366,7 @@
         size_t buf_size =3D strlen(file) + 1;
      =
   ASSERT(buf_size <=3D INT_MAX);
         size =3D (int)buf_size;
-       =
 buf_set_read(&in, (const uint8_t *)file, size);
+        buf_set_read(&in,=
 (const uint8_t *)file, buf_size);
     }
     else /* 'file' is a filename=
 which refers to a file containing the ascii key */
     {
@@ -1535,7 +1535=
,7 @@
     struct buffer out =3D alloc_buf_gc(2048, &gc);
 
     /* how to =
format the ascii file representation of key */
-    const int bytes_per_lin=
e =3D 16;
+    const unsigned int bytes_per_line =3D 16;
 
     /* write he=
ader */
     buf_printf(&out, "#\n# %d bit OpenVPN static key\n#\n", nbits)=
;
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe080=
2=2E=2Efd632be 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=
=2Eh
@@ -760,12 +760,12 @@
  * to read=2E
  */
 static inline bool
-aead_us=
age_limit_reached(const uint64_t limit, const struct key_ctx *key_ctx, int6=
4_t higest_pid)
+aead_usage_limit_reached(const uint64_t limit, const struc=
t key_ctx *key_ctx, uint64_t higest_pid)
 {
     /* This is the  q + s <=3D=
  p^(1/2) * 2^(129/2) - 1 calculation where
      * q is the number of prot=
ected messages (highest_pid)
      * s Total plaintext length in all messag=
es (in blocks) */
-    return (limit > 0 && key_ctx->plaintext_blocks + (ui=
nt64_t)higest_pid > limit);
+    return (limit > 0 && key_ctx->plaintext_bl=
ocks + higest_pid > limit);
 }
 
 #endif /* CRYPTO_H */
diff --git a/src/op=
envpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 312cf6f=2E=2E24=
3b5a2 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_ep=
och=2Ec
@@ -98,7 +98,7 @@
     const uint8_t *label_prefix =3D (const uint8=
_t *)("ovpn ");
     uint8_t prefix_len =3D 5;
 
-    size_t hkdf_label_len=
 =3D 2 + prefix_len + 1 + label_len + 1 + context_len;
+    size_t hkdf_lab=
el_len =3D 2u + prefix_len + 1u + label_len + 1u + context_len;
     struct=
 buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, &gc);
 
     buf_write_=
u16(&hkdf_label, (uint16_t)out_len);
diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec
index 4809532=2E=2E1760c90 100644
--- a/src/openvpn/=
manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2758,7 +2758,7 @@
             =
else
             {
                 int status;
-                int resol=
ve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
+   =
             unsigned int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_=
ON_SIGNAL | GETADDR_FATAL;
 
                 if (!(flags & MF_CONNECT_AS_C=
LIENT))
                 {
@@ -4001,11 +4001,11 @@
         desc =3D "rsa-s=
ign";
     }
 
-    buf_write(&buf_data, b64_data, (int)strlen(b64_data));
=
+    buf_write(&buf_data, b64_data, strlen(b64_data));
     if (man->connec=
tion=2Eclient_version >=3D MCV_PKSIGN_ALG)
     {
-        buf_write(&buf_d=
ata, ",", (int)strlen(","));
-        buf_write(&buf_data, algorithm, (int)=
strlen(algorithm));
+        buf_write(&buf_data, ",", strlen(","));
+     =
   buf_write(&buf_data, algorithm, strlen(algorithm));
     }
     char *re=
t =3D management_query_multiline_flatten(man, (char *)buf_bptr(&buf_data), =
prompt, desc,
                                                    &man->con=
nection=2Eext_key_state,
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/ope=
nvpn/ssl_mbedtls=2Ec
index cbc3118=2E=2Ef4e142b 100644
--- a/src/openvpn/ss=
l_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1119,7 +1119,7 @@
     =
    return 0;
     }
 
-    retval =3D endless_buf_write(&ks->bio_ctx->in, =
BPTR(buf), buf->len);
+    retval =3D endless_buf_write(&ks->bio_ctx->in, B=
PTR(buf), BLENZ(buf));
 
     if (retval < 0)
     {
diff --git a/tests/uni=
t_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
=
index bea51b5=2E=2E37f6218 100644
--- a/tests/unit_tests/openvpn/test_crypt=
o=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -52,11 +52,6 @@
 
 =
static const char testtext[] =3D "Dummy text to test PEM encoding";
 
-#if =
defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#prag=
ma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 crypt=
o_pem_encode_decode_loopback(void **state)
 {
@@ -467,14 +462,14 @@
      *=
 current mode (FIPS), this will still return -1 */
     assert_int_equal(ci=
pher_get_aead_limits("CHACHA20-POLY1305"), 0);
 
-    int64_t aeslimit =3D =
cipher_get_aead_limits("AES-128-GCM");
+    uint64_t aeslimit =3D cipher_ge=
t_aead_limits("AES-128-GCM");
 
     assert_int_equal(aeslimit, (1ull << 36=
) - 1);
 
     /* Check if this matches our exception for 1600 size packets=
 assuming
      * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes)=2E Gives us 100=
 blocks
      * + 1 for the packet */
-    int64_t L =3D 101;
+    uint64_t=
 L =3D 101;
     /* 2 ^ 29=2E34, using the result here to avoid linking to =
libm */
     assert_int_equal(aeslimit / L, 680390858);
 
@@ -520,7 +515,7 =
@@
                          0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3=
, 0xf4, 0xf5, 0xf6, 0xf7,
                          0xf8, 0xf9, 0xfa, 0xfb,=
 0xfc, 0xfd, 0xfe, 0xff };
 
-    const int L =3D 82;
+    const size_t L =
=3D 82;
     uint8_t okm[82] =3D { 0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27=
, 0xa1, 0xc8, 0xe7, 0xf7, 0x8c,
                         0x59, 0x6a, 0x49, =
0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
                     =
    0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c, 0x59, 0x04, 0x5a, 0x99,=

@@ -545,7 +540,7 @@
 
     const uint8_t info[] =3D { 0 };
 
-    int L =
=3D 42;
+    const size_t L =3D 42;
     uint8_t okm[42] =3D { 0x8d, 0xa4, =
0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,
                     =
    0x2a, 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1,
     =
                    0x87, 0x9e, 0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0=
x2d, 0x9d,
@@ -570,7 +565,7 @@
     uint8_t info[18] =3D { 0x00, 0x1b, 0x0e=
, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,
                          0x6e, 0x69,=
 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };
 
-    int L =3D 27;
+    cons=
t size_t L =3D 27;
     uint8_t okm[27] =3D { 0x87, 0x5a, 0x8e, 0xec, 0x18,=
 0x55, 0x63, 0x80, 0xb8,
                         0xd9, 0x33, 0xed, 0x32, 0=
x3c, 0x2d, 0xf8, 0xe8, 0xec,
                         0xcf, 0x49, 0x72, 0xe=
6, 0x83, 0xf0, 0x6a, 0x83, 0xac };
@@ -782,7 +777,7 @@
 
     /* lookup som=
e wacky things that should fail */
     assert_null(epoch_lookup_decrypt_ke=
y(co, 2000));
-    assert_null(epoch_lookup_decrypt_key(co, -1));
+    asse=
rt_null(epoch_lookup_decrypt_key(co, UINT16_MAX));
     assert_null(epoch_l=
ookup_decrypt_key(co, 0xefff));
 
     /* Lookup the edges of the current w=
indow */
@@ -833,10 +828,6 @@
     assert_null(epoch_lookup_decrypt_key(co,=
 23));
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic pop
-#endif
-
 void
 crypto_test_epoch_key_overflow(void **state)
 {
=
diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/unit_test=
s/openvpn/test_networking=2Ec
index ae75386=2E=2E3699a2a1 100644
--- a/test=
s/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/unit_tests/openvpn/tes=
t_networking=2Ec
@@ -40,23 +40,14 @@
     return net_iface_del(NULL, name);=

 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic =
push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static =
int
-net__iface_mtu_set(int mtu)
+net__iface_mtu_set(uint32_t mtu)
 {
-    =
printf("CMD: ip link set %s mtu %d\n", iface, mtu);
+    printf("CMD: ip li=
nk set %s mtu %u\n", iface, mtu);
 
     return net_iface_mtu_set(NULL, ifa=
ce, mtu);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic pop
-#endif
-
 static int
 net__addr_v4_add(const char *addr_str, =
int prefixlen)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/test=
s/unit_tests/openvpn/test_pkt=2Ec
index 5ace810=2E=2Efbbb40f 100644
--- a/t=
ests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pk=
t=2Ec
@@ -618,11 +618,6 @@
     assert_memory_equal(server_id2_p1=2Eid, ser=
ver_id_p2=2Eid, SID_SIZE);
 }
 
-#if defined(__GNUC__) || defined(__clang__=
)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conv=
ersion"
-#endif
-
 static void
 test_generate_reset_packet_plain(void **ut_=
state)
 {
@@ -701,10 +696,6 @@
     free_tas(&tas_server);
 }
 
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*=
 A peer can ask us to append the wrapped client key (WKc) to our next
  * c=
ontrol packet=2E Only a tls-crypt-v2 client has one, so check that we
  * r=
efuse to build such a packet when we have no key instead of walking
diff --=
git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvp=
n/test_tls_crypt=2Ec
index ab90ea5=2E=2E2d31c00 100644
--- a/tests/unit_tes=
ts/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
@@ -352,7 +352,7 @@
     skip_if_tls_crypt_not_supported(ctx);
 
     =
buf_clear(&ctx->source);
-    assert_non_null(buf_write_alloc(&ctx->source,=
 TESTBUF_SIZE - BLEN(&ctx->ciphertext)
+    assert_non_null(buf_write_alloc=
(&ctx->source, TESTBUF_SIZE - BLENZ(&ctx->ciphertext)
                     =
                                  - tls_crypt_buf_overhead()));
 
     asse=
rt_true(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
@@ -373,=
7 +373,7 @@
     skip_if_tls_crypt_not_supported(ctx);
 
     buf_clear(&ct=
x->source);
-    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE=
 - BLEN(&ctx->ciphertext)
+    assert_non_null(buf_write_alloc(&ctx->source=
, TESTBUF_SIZE - BLENZ(&ctx->ciphertext)
                                  =
                     - tls_crypt_buf_overhead() + 1));
     assert_false(tl=
s_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
 }
@@ -553,7 +553,=
7 @@
     assert_false(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx=
, NULL));
 
     /* add a opcode in front of the key to make it valid to ex=
tract */
-    struct buffer wkcop =3D alloc_buf_gc(buf_len(&ctx->wkc) + 1, =
&ctx->gc);
+    struct buffer wkcop =3D alloc_buf_gc(BLENZ(&ctx->wkc) + 1, =
&ctx->gc);
     buf_write_u8(&wkcop, 0x50);
     buf_copy(&wkcop, &ctx->wkc=
);
     assert_true(tls_crypt_v2_extract_client_key(&wkcop, &wrap_ctx, NULL=
));
@@ -638,7 +638,7 @@
     int64_t create_time =3D now - (days_ago * 24 *=
 60 * 60);
     assert_true(create_time > 0);
 
-    int64_t timestamp =3D =
htonll((uint64_t)create_time);
+    uint64_t timestamp =3D htonll((uint64_t=
)create_time);
     ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_TI=
MESTAMP, 1));
     ASSERT(buf_write(&metadata, &timestamp, sizeof(timestamp=
)));
 
@@ -660,7 +660,7 @@
                                              &c=
tx->server_keys=2Eencrypt, &ctx->gc));
 
     /* add a opcode in front of t=
he key to make it valid to extract */
-    struct buffer pseudo_packet =3D =
alloc_buf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc);
+    struct buffer pseudo_p=
acket =3D alloc_buf_gc(BLENZ(&ctx->wkc) + 1, &ctx->gc);
 
     buf_write_u8=
(&pseudo_packet, 0x50);
     buf_copy(&pseudo_packet, &ctx->wkc);
@@ -745,7=
 +745,7 @@
     struct buffer expected_metadata =3D create_metadata_days_ag=
o(&ctx->gc, 29);
     buf_advance(&expected_metadata, 1);
 
-    expect_mem=
ory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), buf_len(&e=
xpected_metadata));
+    expect_memory(__wrap_buffer_write_file, pem, buf_b=
ptr(&expected_metadata), BLENZ(&expected_metadata));
     will_return(__wra=
p_buffer_write_file, true);
 
     tmp =3D create_client_key_input(ctx, 29)=
;
@@ -760,7 +760,7 @@
     }
 
     expect_string(__wrap_buffer_write_file,=
 filename, tmpfile_path);
-    expect_memory(__wrap_buffer_write_file, pem,=
 buf_bptr(&expected_metadata), buf_len(&expected_metadata));
+    expect_me=
mory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), BLENZ(&ex=
pected_metadata));
     will_return(__wrap_buffer_write_file, true);
 
    =
 tmp =3D create_client_key_input(ctx, 29);

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Gerri=
t-Change-Number: 2157
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>

--Ll9DZDcRJwY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #4</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Var=
ious trivial -Wsign-conversion fixes<br><br>* Continue BLEN -&gt; BLENZ rep=
lacement<br>* Remove some unneeded casts<br>* Some trivial type fixes<br><b=
r>Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/acc=
=2Ec<br>M src/openvpn/auth_token=2Ec<br>M src/openvpn/base64=2Eh<br>M src/o=
penvpn/console_builtin=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/cry=
pto=2Eh<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/manage=2Ec<br>M =
src/openvpn/ssl_mbedtls=2Ec<br>M tests/unit_tests/openvpn/test_crypto=2Ec<b=
r>M tests/unit_tests/openvpn/test_networking=2Ec<br>M tests/unit_tests/open=
vpn/test_pkt=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>13 fil=
es changed, 49 insertions(+), 95 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/2157/4</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><spa=
n>index e21891d=2E=2Eb8d7c3d 100644</span><br><span>--- a/src/openvpn/acc=
=2Ec</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -148,11 +=
148,6 @@</span><br><span>     return parse_acc_message_flags(flags, err_rea=
son, gc);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic=
 ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> void</span><br><span> receive_acc_message(struct contex=
t *c, const struct buffer *buffer)</span><br><span> {</span><br><span>@@ -2=
36,15 +231,10 @@</span><br><span>     msg(D_PUSH_ERRORS, &quot;WARNING: Rec=
eived malformed custom app control channel &quot;</span><br><span>         =
               &quot;message (%s): %s&quot;,</span><br><span>         err_r=
eason,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        format_=
hex(CBPTR(buffer), BLEN(buffer), 80, &amp;gc));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        format_hex(CBPTR(buffer), BLENZ(buffer)=
, 80, &amp;gc));</span><br><span>     gc_free(&amp;gc);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> bool</span><br><span> send_acc_message(struct context *c,</span><br><s=
pan>                  struct tls_multi *multi,</span><br><span>diff --git a=
/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>in=
dex 211af90=2E=2Eb69092c 100644</span><br><span>--- a/src/openvpn/auth_toke=
n=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -=
36,11 +36,6 @@</span><br><span>  * padding */</span><br><span> static_asser=
t(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multiple of 3&=
quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> b=
ool</span><br><span> is_auth_token(const char *password)</span><br><span> {=
</span><br><span>@@ -67,7 +62,7 @@</span><br><span>         return;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int auth_token_state_flags =3D session-&gt;key[KS_PRIMARY]=
=2Eauth_token_state_flags;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int auth_token_state_flags =3D session-&gt;key[KS_PRIMA=
RY]=2Eauth_token_state_flags;</span><br><span> </span><br><span>     const =
char *state;</span><br><span> </span><br><span>@@ -188,7 +183,7 @@</span><b=
r><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t ti=
mestamp =3D htonll((uint64_t)now);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int64_t timestamp =3D (int64_t)htonll((uint64_t)now);</s=
pan><br><span>     int64_t initial_timestamp =3D timestamp;</span><br><span=
> </span><br><span>     hmac_ctx_t *ctx =3D multi-&gt;opt=2Eauth_token_key=
=2Ehmac;</span><br><span>@@ -273,7 +268,7 @@</span><br><span>         alloc=
_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &amp;gc);</span>=
<br><span> </span><br><span>     ASSERT(buf_write(&amp;session_token, SESSI=
ON_ID_PREFIX, strlen(SESSION_ID_PREFIX)));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ASSERT(buf_write(&amp;session_token, b64output, (i=
nt)strlen(b64output)));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(buf_write(&amp;session_token, b64output, strlen(b64output)))=
;</span><br><span>     ASSERT(buf_write_u8(&amp;session_token, 0));</span><=
br><span> </span><br><span>     free(b64output);</span><br><span>@@ -296,10=
 +291,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static bool</span><br><span> check_hmac_token(hmac_ctx_=
t *ctx, const uint8_t *b64decoded, const char *username)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/base64=2Eh b/src/openvpn/base64=
=2Eh</span><br><span>index be7aa64=2E=2E800e569 100644</span><br><span>--- =
a/src/openvpn/base64=2Eh</span><br><span>+++ b/src/openvpn/base64=2Eh</span=
><br><span>@@ -35,7 +35,7 @@</span><br><span> #define _BASE64_H_</span><br>=
<span> </span><br><span> /** Compute resulting base64 length=2E  6 bits per=
 byte, padded to 4 bytes=2E */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length=
) / 6) + 3) &amp; ~3)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) =
+ 3) &amp; ~3u)</span><br><span> </span><br><span> /** Compute the maximal =
number of bytes encoded in a base64 string=2E */</span><br><span> #define O=
PENVPN_BASE64_DECODED_LENGTH(base64_length) ((base64_length / 4) * 3)</span=
><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/conso=
le_builtin=2Ec</span><br><span>index dc71d12=2E=2E0353ade 100644</span><br>=
<span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openv=
pn/console_builtin=2Ec</span><br><span>@@ -234,7 +234,7 @@</span><br><span>=
     if (!echo &amp;&amp; (tcgetattr(fileno(fp), &amp;tty_tmp) =3D=3D 0))</=
span><br><span>     {</span><br><span>         tty_save =3D tty_tmp;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        tty_tmp=2Ec_lflag &a=
mp;=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tty_tmp=2Ec_lflag &amp;=3D ~(unsigned i=
nt)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);</span><br><span>         restore=
_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &amp;tty_tmp) =3D=3D 0);</span><=
br><span>     }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 88c2c52=2E=2Ea4c2=
683 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++=
 b/src/openvpn/crypto=2Ec</span><br><span>@@ -139,7 +139,7 @@</span><br><sp=
an>         ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv));</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(=
buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format=
_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><spa=
n>     /* Buffer overflow check */</span><br><span>     if (!buf_safe(&amp;=
work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cipher)))</span=
><br><span>@@ -151,7 +151,7 @@</span><br><span> </span><br><span>     /* Fo=
r AEAD ciphers, authenticate Additional Data, including opcode */</span><br=
><span>     ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, BPTR(&amp;work), BL=
EN(&amp;work)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
msg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;, format_hex(BPTR(&amp;work=
), BLEN(&amp;work), 0, &amp;gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;, format=
_hex(BPTR(&amp;work), BLENZ(&amp;work), 0, &amp;gc));</span><br><span> </sp=
an><br><span>     if (!use_epoch_data_format)</span><br><span>     {</span>=
<br><span>@@ -170,8 +170,8 @@</span><br><span> </span><br><span>     /* upd=
ate number of plaintext blocks encrypted=2E Use the (x + (n-1))/n trick</sp=
an><br><span>      * to round up the result to the number of blocks used */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int blocksi=
ze =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    opt-&gt;key_ctx_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLEN(&amp;=
work) + (blocksize - 1)) / blocksize;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ct=
x_bi=2Eencrypt=2Eplaintext_blocks +=3D (BLENZ(&amp;work) + (blocksize - 1))=
 / blocksize;</span><br><span> </span><br><span>     /* if the tag is at en=
d the end, allocate it now */</span><br><span>     if (use_epoch_data_forma=
t)</span><br><span>@@ -186,7 +186,7 @@</span><br><span> </span><br><span>  =
   *buf =3D work;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, format=
_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;=
, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span>=
<br><span>     gc_free(&amp;gc);</span><br><span>     return;</span><br><sp=
an>@@ -257,13 +257,13 @@</span><br><span>             ASSERT(buf_write(&amp=
;work, iv_buf, iv_size));</span><br><span>             dmsg(D_PACKET_CONTEN=
T, &quot;ENCRYPT IV: %s&quot;, format_hex(iv_buf, iv_size, 0, &amp;gc));</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(=
buf), BLEN(buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;=
, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span>=
<br><span>             /* cipher_ctx was already initialized with key &amp;=
 keylen */</span><br><span>             ASSERT(cipher_ctx_reset(ctx-&gt;cip=
her, iv_buf));</span><br><span> </span><br><span>             /* Buffer ove=
rflow check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;c=
ipher)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (!buf_safe(&amp;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher=
)))</span><br><span>             {</span><br><span>                 msg(D_C=
RYPT_ERRORS,</span><br><span>                     &quot;ENCRYPT: buffer siz=
e error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u&quot;,</s=
pan><br><span>@@ -317,7 +317,7 @@</span><br><span> </span><br><span>       =
  *buf =3D work;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;ENCRYPT TO: %s&quot;, for=
mat_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_PACKET_CONTENT, &quot;E=
NCRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &amp=
;gc));</span><br><span>     }</span><br><span> </span><br><span>     gc_fre=
e(&amp;gc);</span><br><span>@@ -460,7 +460,7 @@</span><br><span>     ASSERT=
(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_P=
ACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf=
), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf)=
, BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><span>     ASSERT(=
ad_start &gt;=3D buf-&gt;data &amp;&amp; ad_start &lt;=3D BPTR(buf));</span=
><br><span> </span><br><span>@@ -558,10 +558,10 @@</span><br><span>     }</=
span><br><span> </span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT =
MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRY=
PT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 0, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &q=
uot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));=
</span><br><span> </span><br><span>     /* Buffer overflow check (should ne=
ver fail) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(&am=
p;work, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><spa=
n>     {</span><br><span>         CRYPT_ERROR(&quot;potential buffer overfl=
ow&quot;);</span><br><span>     }</span><br><span>@@ -585,7 +585,7 @@</span=
><br><span>     }</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen=
));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp=
;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, =
format_hex(BPTR(&amp;work), BLENZ(&amp;work), 80, &amp;gc));</span><br><spa=
n> </span><br><span>     if (!crypto_check_replay(opt, &amp;pin, epoch, err=
or_prefix, &amp;gc))</span><br><span>     {</span><br><span>@@ -594,8 +594,=
8 @@</span><br><span> </span><br><span>     /* update number of plaintext b=
locks decrypted=2E Use the (x + (n-1))/n trick</span><br><span>      * to r=
ound up the result to the number of blocks used=2E */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const int blocksize =3D AEAD_LIMIT_BLOC=
KSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;key=
_ctx_bi=2Edecrypt=2Eplaintext_blocks +=3D (BLEN(&amp;work) + (blocksize - 1=
)) / blocksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi=2Edecrypt=2Eplain=
text_blocks +=3D (BLENZ(&amp;work) + (blocksize - 1)) / blocksize;</span><b=
r><span> </span><br><span>     *buf =3D work;</span><br><span> </span><br><=
span>@@ -631,7 +631,7 @@</span><br><span>         struct packet_id_net pin;=
</span><br><span>         bool have_pin =3D false;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_CONTEN=
T, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;=
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D=
_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(=
buf), 80, &amp;gc));</span><br><span> </span><br><span>         /* Verify t=
he HMAC */</span><br><span>         if (ctx-&gt;hmac)</span><br><span>@@ -6=
94,7 +694,7 @@</span><br><span>             }</span><br><span> </span><br><=
span>             /* Buffer overflow check (should never happen) */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!buf_safe(&am=
p;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!buf_safe(&amp;wo=
rk, BLENZ(buf) + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>  =
           {</span><br><span>                 CRYPT_ERROR(&quot;packet too =
big to decrypt&quot;);</span><br><span>             }</span><br><span>@@ -7=
13,7 +713,7 @@</span><br><span>             }</span><br><span>             =
ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_PACKET_CONTENT, &quo=
t;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;work), BLEN(&amp;work), 80, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO: %s&quot;, format_hex(BPTR(&amp;wo=
rk), BLENZ(&amp;work), 80, &amp;gc));</span><br><span> </span><br><span>   =
          /* Get packet ID from plaintext buffer or IV, depending on cipher=
 mode */</span><br><span>             {</span><br><span>@@ -855,7 +855,7 @@=
</span><br><span> crypto_max_overhead(void)</span><br><span> {</span><br><s=
pan>     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_=
CIPHER_BLOCK_SIZE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
       + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+           + max_uint(OPENVPN=
_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span>@@ -1366,7 +1366,7 @@</spa=
n><br><span>         size_t buf_size =3D strlen(file) + 1;</span><br><span>=
         ASSERT(buf_size &lt;=3D INT_MAX);</span><br><span>         size =
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
0%);">+    const unsigned int bytes_per_line =3D 16;</span><br><span> </spa=
n><br><span>     /* write header */</span><br><span>     buf_printf(&amp;ou=
t, &quot;#\n# %d bit OpenVPN static key\n#\n&quot;, nbits);</span><br><span=
>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><sp=
an>index dbe0802=2E=2Efd632be 100644</span><br><span>--- a/src/openvpn/cryp=
to=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -760=
,12 +760,12 @@</span><br><span>  * to read=2E</span><br><span>  */</span><b=
r><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *=
key_ctx, int64_t higest_pid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+aead_usage_limit_reached(const uint64_t limit, const struct key_ct=
x *key_ctx, uint64_t higest_pid)</span><br><span> {</span><br><span>     /*=
 This is the  q + s &lt;=3D  p^(1/2) * 2^(129/2) - 1 calculation where</spa=
n><br><span>      * q is the number of protected messages (highest_pid)</sp=
an><br><span>      * s Total plaintext length in all messages (in blocks) *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (limit &g=
t; 0 &amp;&amp; key_ctx-&gt;plaintext_blocks + (uint64_t)higest_pid &gt; li=
mit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (li=
mit &gt; 0 &amp;&amp; key_ctx-&gt;plaintext_blocks + higest_pid &gt; limit)=
;</span><br><span> }</span><br><span> </span><br><span> #endif /* CRYPTO_H =
*/</span><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/=
crypto_epoch=2Ec</span><br><span>index 312cf6f=2E=2E243b5a2 100644</span><b=
r><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvp=
n/crypto_epoch=2Ec</span><br><span>@@ -98,7 +98,7 @@</span><br><span>     c=
onst uint8_t *label_prefix =3D (const uint8_t *)(&quot;ovpn &quot;);</span>=
<br><span>     uint8_t prefix_len =3D 5;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    size_t hkdf_label_len =3D 2 + pref=
ix_len + 1 + label_len + 1 + context_len;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size_t hkdf_label_len =3D 2u + prefix_len + 1u + =
label_len + 1u + context_len;</span><br><span>     struct buffer hkdf_label=
 =3D alloc_buf_gc(hkdf_label_len, &amp;gc);</span><br><span> </span><br><sp=
an>     buf_write_u16(&amp;hkdf_label, (uint16_t)out_len);</span><br><span>=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><spa=
n>index 4809532=2E=2E1760c90 100644</span><br><span>--- a/src/openvpn/manag=
e=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2758=
,7 +2758,7 @@</span><br><span>             else</span><br><span>           =
  {</span><br><span>                 int status;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                int resolve_flags =3D GETADDR_RE=
SOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                unsigned int resolve_flags =3D =
GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;</span><br><span> =
</span><br><span>                 if (!(flags &amp; MF_CONNECT_AS_CLIENT))<=
/span><br><span>                 {</span><br><span>@@ -4001,11 +4001,11 @@<=
/span><br><span>         desc =3D &quot;rsa-sign&quot;;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    buf_write(&amp;buf_data, b64_data, (int)strlen(b64_data));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf_data, b64=
_data, strlen(b64_data));</span><br><span>     if (man-&gt;connection=2Ecli=
ent_version &gt;=3D MCV_PKSIGN_ALG)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        buf_write(&amp;buf_data, &quot=
;,&quot;, (int)strlen(&quot;,&quot;));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        buf_write(&amp;buf_data, algorithm, (int)strlen(al=
gorithm));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        b=
uf_write(&amp;buf_data, &quot;,&quot;, strlen(&quot;,&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;buf_data,=
 algorithm, strlen(algorithm));</span><br><span>     }</span><br><span>    =
 char *ret =3D management_query_multiline_flatten(man, (char *)buf_bptr(&am=
p;buf_data), prompt, desc,</span><br><span>                                =
                    &amp;man-&gt;connection=2Eext_key_state,</span><br><spa=
n>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</s=
pan><br><span>index cbc3118=2E=2Ef4e142b 100644</span><br><span>--- a/src/o=
penvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</s=
pan><br><span>@@ -1119,7 +1119,7 @@</span><br><span>         return 0;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    retval =3D endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in,=
 BPTR(buf), buf-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    retval =3D endless_buf_write(&amp;ks-&gt;bio_ctx-&gt;in, BPTR(buf=
), BLENZ(buf));</span><br><span> </span><br><span>     if (retval &lt; 0)</=
span><br><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span=
>index bea51b5=2E=2E37f6218 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
crypto=2Ec</span><br><span>@@ -52,11 +52,6 @@</span><br><span> </span><br><=
span> static const char testtext[] =3D &quot;Dummy text to test PEM encodin=
g&quot;;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsig=
n-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
static void</span><br><span> crypto_pem_encode_decode_loopback(void **state=
)</span><br><span> {</span><br><span>@@ -467,14 +462,14 @@</span><br><span>=
      * current mode (FIPS), this will still return -1 */</span><br><span> =
    assert_int_equal(cipher_get_aead_limits(&quot;CHACHA20-POLY1305&quot;),=
 0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int64_t aeslimit =3D cipher_get_aead_limits(&quot;AES-128-GCM&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t aeslimi=
t =3D cipher_get_aead_limits(&quot;AES-128-GCM&quot;);</span><br><span> </s=
pan><br><span>     assert_int_equal(aeslimit, (1ull &lt;&lt; 36) - 1);</spa=
n><br><span> </span><br><span>     /* Check if this matches our exception f=
or 1600 size packets assuming</span><br><span>      * AEAD_LIMIT_BLOCKSIZE =
(128 bits/ 16 bytes)=2E Gives us 100 blocks</span><br><span>      * + 1 for=
 the packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
64_t L =3D 101;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint64_t L =3D 101;</span><br><span>     /* 2 ^ 29=2E34, using the result h=
ere to avoid linking to libm */</span><br><span>     assert_int_equal(aesli=
mit / L, 680390858);</span><br><span> </span><br><span>@@ -520,7 +515,7 @@<=
/span><br><span>                          0xec, 0xed, 0xee, 0xef, 0xf0, 0xf=
1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,</span><br><span>                    =
      0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int L =3D 82;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t L =
=3D 82;</span><br><span>     uint8_t okm[82] =3D { 0xb1, 0x1e, 0x39, 0x8d, =
0xc8, 0x03, 0x27, 0xa1, 0xc8, 0xe7, 0xf7, 0x8c,</span><br><span>           =
              0x59, 0x6a, 0x49, 0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0=
xfa, 0xd8,</span><br><span>                         0xa0, 0x50, 0xcc, 0x4c,=
 0x19, 0xaf, 0xa9, 0x7c, 0x59, 0x04, 0x5a, 0x99,</span><br><span>@@ -545,7 =
+540,7 @@</span><br><span> </span><br><span>     const uint8_t info[] =3D {=
 0 };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int L =3D 42;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const size_t L =3D 42;</span><br><span>     uint8_t okm[42] =3D { 0x8d,=
 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><spa=
n>                         0x2a, 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1f, =
0x5c, 0x5e, 0xe1,</span><br><span>                         0x87, 0x9e, 0xc3=
, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d, 0x9d,</span><br><span>@@ -570,7=
 +565,7 @@</span><br><span>     uint8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0x=
6f, 0x76, 0x70, 0x6e, 0x20, 0x75,</span><br><span>                         =
 0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int L =3D 27;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t L =3D 2=
7;</span><br><span>     uint8_t okm[27] =3D { 0x87, 0x5a, 0x8e, 0xec, 0x18,=
 0x55, 0x63, 0x80, 0xb8,</span><br><span>                         0xd9, 0x3=
3, 0xed, 0x32, 0x3c, 0x2d, 0xf8, 0xe8, 0xec,</span><br><span>              =
           0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0, 0x6a, 0x83, 0xac };</span><b=
r><span>@@ -782,7 +777,7 @@</span><br><span> </span><br><span>     /* looku=
p some wacky things that should fail */</span><br><span>     assert_null(ep=
och_lookup_decrypt_key(co, 2000));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_null(epoch_lookup_decrypt_key(co, -1));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_de=
crypt_key(co, UINT16_MAX));</span><br><span>     assert_null(epoch_lookup_d=
ecrypt_key(co, 0xefff));</span><br><span> </span><br><span>     /* Lookup t=
he edges of the current window */</span><br><span>@@ -833,10 +828,6 @@</spa=
n><br><span>     assert_null(epoch_lookup_decrypt_key(co, 23));</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
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
it_tests/openvpn/test_pkt=2Ec</span><br><span>index 5ace810=2E=2Efbbb40f 10=
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2157 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--Ll9DZDcRJwY=--


--===============0207615525419312989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0207615525419312989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0207615525419312989==--


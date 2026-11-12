Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BE606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=horzZ9gP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G7Yn7Qx0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OKuYIYKP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CWDWqqpt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QdSnfOHDO34nkL0fJ8kDKuhzOU+SKEHV8uAE5nsXFJw=; b=horzZ9gPxr2s3ZlUEN7+tnInvP
	lmBDeMtsyugX7nSoZyk2QYqTiqdYFtxxqVBMFEpeVEJwvrYiZnRs6WwnqiAm5COkShoQvrgR58Ldc
	1MhYgW8wvFwkYogLZ11W5ms8zxc7hrMqywWBpSS/za+KdX8fIJ4pA11RI0OuzGDWo1u4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLC-000000003E1-2mo1;
	Thu, 12 Nov 2026 17:12:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYL6-000000003Cx-1jBd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rD1Dmxu4CKuO/Oy2e5ZGaaaFv3eQrt7zC+R47JzHXms=; b=G7Yn7Qx0FJsBpAbc1cqap1HpZ9
 WAmp4VsWQIhzKoEmHTlRqvWRDb3AtyB5Fs+Y6yaFlyD6Ai7z7272hM3fKcraUZNRGfLv0yjIEnbgE
 H8IYFwT+q7N7LFe+qMAOm0VpnR3kXgEaSQmJQskovth3Ltv8q034Cpd/MDBrViq0kkOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rD1Dmxu4CKuO/Oy2e5ZGaaaFv3eQrt7zC+R47JzHXms=; b=OKuYIYKPQ0r0kImAsFaY+2mjUb
 k/i88BZ5ilcVZsQiaIndo61eemNh9MeDcE79NRru7fEk5LBf0je0xGYdS76P69Rt00OOL9qJLOLKY
 ijPhznYaO0t+fmLPOrXWFvKbRe0uwox9b5hKmwoxJd0m3fDtTG8Uzrmwrv46fut8Kt7Q=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYKv-0000000075B-15ET for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:54 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so3007751f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503499; x=1795108299; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rD1Dmxu4CKuO/Oy2e5ZGaaaFv3eQrt7zC+R47JzHXms=;
 b=CWDWqqptdOUcnBO399b1wgFqX3AidpCrcbv7f0WB8+ykVt72A5LVIxJRTUS3cQQK9l
 K2nZQ3FbF+ui/VlNbF1jjWWbRMXUqDiait09I94n5jX5M8Z83xioS1pgLQL8oSBsitn3
 cdzDdikUPxi5SAEmXuEI/HEpzi2Wzf3iDL6BCojwzykvrIPmRd9HImrR2bUf5YZCF8Zs
 oICDGm+u+YrWHIYumsXsoPreyVx5UKFms9zBwZO/lTFwR62vPCo7Z8S/focOiSJ81spV
 YdFBJybF+qchpJd1Rm58sDqJyYvQpXBylKlvqhqxsFxr+Vi8ppgsx9kWYPfolftCcbAT
 ZhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503499; x=1795108299;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rD1Dmxu4CKuO/Oy2e5ZGaaaFv3eQrt7zC+R47JzHXms=;
 b=hrharyye32gRpHYc677RwR4TJyS27kmMAp1V3ZP+o+7fVIxk9inO0PelrDgklCfx4a
 qGuUnvF5Nx1Muf6E3je7zIpthxRhrCRBk8Xws2+qsiDdyPrCSX6/iQivLEcdIZDrHw7B
 g0wYNX3BmxCe0NqXmdvd+UQ9x0JrQb0BpJ2I3K4u0HkY6Lx62+tM+ZKLj0MAyxVq/4Wc
 R0DEHC5EKOjuUz41laZ6hO6aQsV7hqrTu/4OPF0D4gUFRAb5PbPL1a2Nhp9pmQLJhnc4
 C2ZK/pNSkXYLqlf2HQIgtY5/Qej8eQMGlrB+/ubh7XcXVJ73LKlicy1pZuHybsbTVKuX
 TNYg==
X-Gm-Message-State: APuU4Z/hsCO0uTdeaOZtMuOd4sVDGxIdwavFmbUDW2Ii0B3wcurIdBjP
 wVHaX6RRKH3VitLl6nCuJnnmEc1DIVuEW5Xcv4yQVPkhQIol85x59AZUcb793imNfOlz4qYa9jc
 p/KVU6Khyg+Cb7Q1HLotMytSjUhIUQlkKbMJTWKm9yV58qc+hByjboMwmLQSYL3A++zl2
X-Gm-Gg: AYBFou3HmyaBQRMV32hrGn3nTIhz1BCn02EOohCmDJ1PZ1HZ0bqaI3GaWEY3B0IT3Bf
 UXczCYgRBi+Sl1kNVpMbgLBWeY0uT6zunWJ1M+0UN8e5EsmJJtfDTXoK5vGf+JXU44CNMWo78xh
 AK21hjUKIktRM+BF6lJJNboERRYvvLRR0wMTEFI9p1qz1NVy5uTxG3a0SOmLzqclaVM0862dUPi
 j4nnq0f8vZNR/ef76VRbmVRc/9L9al+ORATHpNXKhPiPmdGSmxz3hXjOuuJwxgeG7HJtJh3BsNt
 GfNeEjBAAu7CtZNlprbN87aqCs2f3qEX0yXjfh3utpU2tXRMh3Jm6eWa472Uhntce3m+G5GO+wK
 Q3IDhg8KEbPP7C2iLW1J3r9DeKqZgfyxdQZj/kkQ8qwwDHlpEPM+eVYHSel7t/WkV7GEXcl3JCQ
 6s1aqOvO8677pYv6IOr/p0ZsJcTdgq3fK4H0t3nfW4QpPSTwths2kXP0XoO/kedLsO8Oav8Efzc
 zZmJIoOpvZGechM38CVyzb2T5MFSCQXfcMzlEMZeXWj8n5ZxJ5lxYWCcA4402dnjSAxwe2FyFbx
 E6DBbLkVULegsYHA+njj/oPiUAZJNmjslQp00EYkC9/faJ6wj5jTwXNfSU9TRth04TMu2N1YoKH
 byyl6OUHBxMrfrwDrEvvxD4xK9T2VYietM4xO4NGydXzsW8zuIn98NsahTTfnEUEdgpCmMGyYpR
 s/AinCsc8G/yzdH6GSDsnxUUfvo0ZIZ/tjFm0d
X-Received: by 2002:a05:6000:25ec:b0:498:1d72:106c with SMTP id
 ffacd0b85a97d-499c764c9eemr10681349f8f.55.1794503498119; 
 Thu, 12 Nov 2026 09:11:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d223a29sm386390f8f.8.2026.11.12.09.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:11:37 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:11:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: ee2457d7ba689b5be0ecbf1dbc67e72047e21628
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6e75966d400fd3882fed87135f70ea3e4091442d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYKv-0000000075B-15ET
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
Content-Type: multipart/mixed; boundary="===============8393052737879205083=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8393052737879205083==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GEhoJeB675k="; charset=UTF-8

--GEhoJeB675k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2157?usp=3Demail

to look at the new patch set (#5)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by R=C4=83z=
van Cojocaru

The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E


Change subject: Various trivial -W=
sign-conversion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Various trivial -Wsign-conversion fixes

* Continue BLEN -> BLEN=
Z replacement
* Remove some unneeded casts
* Some trivial type fixes

Chang=
e-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Signed-off-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/acc=2Ec
M src/openvpn/aut=
h_token=2Ec
M src/openvpn/base64=2Eh
M src/openvpn/console_builtin=2Ec
M sr=
c/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/crypto_epoch=2E=
c
M src/openvpn/manage=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M tests/unit_tests=
/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M tests=
/unit_tests/openvpn/test_networking=2Ec
M tests/unit_tests/openvpn/test_pkt=
=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
14 files changed, 51 ins=
ertions(+), 106 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/57/2157/5

diff --git a/src/openvpn/acc=2Ec b/src/op=
envpn/acc=2Ec
index e21891d=2E=2Eb8d7c3d 100644
--- a/src/openvpn/acc=2Ec
+=
++ b/src/openvpn/acc=2Ec
@@ -148,11 +148,6 @@
     return parse_acc_message=
_flags(flags, err_reason, gc);
 }
 
-#if defined(__GNUC__) || defined(__cla=
ng__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-=
conversion"
-#endif
-
 void
 receive_acc_message(struct context *c, const s=
truct buffer *buffer)
 {
@@ -236,15 +231,10 @@
     msg(D_PUSH_ERRORS, "WAR=
NING: Received malformed custom app control channel "
                     =
   "message (%s): %s",
         err_reason,
-        format_hex(CBPTR(buffe=
r), BLEN(buffer), 80, &gc));
+        format_hex(CBPTR(buffer), BLENZ(buffe=
r), 80, &gc));
     gc_free(&gc);
 }
 
-
-#if defined(__GNUC__) || defined(=
__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 send_acc_message(st=
ruct context *c,
                  struct tls_multi *multi,
diff --git a/sr=
c/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index 211af90=2E=2Eb6=
9092c 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=
=2Ec
@@ -36,11 +36,6 @@
  * padding */
 static_assert(TOKEN_DATA_LEN % 3 =
=3D=3D 0, "TOKEN_DATA_LEN is not a multiple of 3");
 
-#if defined(__GNUC__=
) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
-#endif
-
 bool
 is_auth_token(const char *pa=
ssword)
 {
@@ -67,7 +62,7 @@
         return;
     }
 
-    int auth_token_=
state_flags =3D session->key[KS_PRIMARY]=2Eauth_token_state_flags;
+    uns=
igned int auth_token_state_flags =3D session->key[KS_PRIMARY]=2Eauth_token_=
state_flags;
 
     const char *state;
 
@@ -188,7 +183,7 @@
 {
     struct=
 gc_arena gc =3D gc_new();
 
-    int64_t timestamp =3D htonll((uint64_t)no=
w);
+    int64_t timestamp =3D (int64_t)htonll((uint64_t)now);
     int64_t=
 initial_timestamp =3D timestamp;
 
     hmac_ctx_t *ctx =3D multi->opt=2Ea=
uth_token_key=2Ehmac;
@@ -273,7 +268,7 @@
         alloc_buf_gc(strlen(SESS=
ION_ID_PREFIX) + strlen(b64output) + 1, &gc);
 
     ASSERT(buf_write(&sess=
ion_token, SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));
-    ASSERT(buf_=
write(&session_token, b64output, (int)strlen(b64output)));
+    ASSERT(buf_=
write(&session_token, b64output, strlen(b64output)));
     ASSERT(buf_write=
_u8(&session_token, 0));
 
     free(b64output);
@@ -296,10 +291,6 @@
     =
gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GC=
C diagnostic pop
-#endif
-
 static bool
 check_hmac_token(hmac_ctx_t *ctx, =
const uint8_t *b64decoded, const char *username)
 {
diff --git a/src/openvp=
n/base64=2Eh b/src/openvpn/base64=2Eh
index be7aa64=2E=2E800e569 100644
---=
 a/src/openvpn/base64=2Eh
+++ b/src/openvpn/base64=2Eh
@@ -35,7 +35,7 @@
 #=
define _BASE64_H_
 
 /** Compute resulting base64 length=2E  6 bits per byt=
e, padded to 4 bytes=2E */
-#define OPENVPN_BASE64_LENGTH(binary_length) ((=
((8 * binary_length) / 6) + 3) & ~3)
+#define OPENVPN_BASE64_LENGTH(binary_=
length) ((((8 * binary_length) / 6) + 3) & ~3u)
 
 /** Compute the maximal =
number of bytes encoded in a base64 string=2E */
 #define OPENVPN_BASE64_DE=
CODED_LENGTH(base64_length) ((base64_length / 4) * 3)
diff --git a/src/open=
vpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index dc71d12=2E=
=2E0353ade 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/c=
onsole_builtin=2Ec
@@ -234,7 +234,7 @@
     if (!echo && (tcgetattr(fileno(=
fp), &tty_tmp) =3D=3D 0))
     {
         tty_save =3D tty_tmp;
-        tt=
y_tmp=2Ec_lflag &=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
+        tty_=
tmp=2Ec_lflag &=3D ~(unsigned int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
 =
        restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp) =3D=3D =
0);
     }
 
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
i=
ndex 33e0376=2E=2E826f39e 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/ope=
nvpn/crypto=2Ec
@@ -139,7 +139,7 @@
         ASSERT(cipher_ctx_reset(ctx->c=
ipher, iv));
     }
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", forma=
t_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT=
 FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Buffer o=
verflow check */
     if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_=
block_size(ctx->cipher)))
@@ -151,7 +151,7 @@
 
     /* For AEAD ciphers, a=
uthenticate Additional Data, including opcode */
     ASSERT(cipher_ctx_upd=
ate_ad(ctx->cipher, BPTR(&work), BLEN(&work)));
-    dmsg(D_PACKET_CONTENT,=
 "ENCRYPT AD: %s", format_hex(BPTR(&work), BLEN(&work), 0, &gc));
+    dmsg=
(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(BPTR(&work), BLENZ(&work), =
0, &gc));
 
     if (!use_epoch_data_format)
     {
@@ -170,8 +170,8 @@
 
 =
    /* update number of plaintext blocks encrypted=2E Use the (x + (n-1))/n=
 trick
      * to round up the result to the number of blocks used */
-    =
const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi=2Eencryp=
t=2Eplaintext_blocks +=3D (BLEN(&work) + (blocksize - 1)) / blocksize;
+   =
 const unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_b=
i=2Eencrypt=2Eplaintext_blocks +=3D (BLENZ(&work) + (blocksize - 1)) / bloc=
ksize;
 
     /* if the tag is at end the end, allocate it now */
     if (=
use_epoch_data_format)
@@ -186,7 +186,7 @@
 
     *buf =3D work;
 
-    dms=
g(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLEN(buf), 80, =
&gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), =
BLENZ(buf), 80, &gc));
 
     gc_free(&gc);
     return;
@@ -257,13 +257,13=
 @@
             ASSERT(buf_write(&work, iv_buf, iv_size));
             dm=
sg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc))=
;
 
-            dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR=
(buf), BLEN(buf), 80, &gc));
+            dmsg(D_PACKET_CONTENT, "ENCRYPT F=
ROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
             /* ci=
pher_ctx was already initialized with key & keylen */
             ASSERT(c=
ipher_ctx_reset(ctx->cipher, iv_buf));
 
             /* Buffer overflow ch=
eck */
-            if (!buf_safe(&work, buf->len + cipher_ctx_block_size(c=
tx->cipher)))
+            if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_blo=
ck_size(ctx->cipher)))
             {
                 msg(D_CRYPT_ERRORS,
=
                     "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d w=
c=3D%d wo=3D%d wl=3D%d cbs=3D%u",
@@ -317,7 +317,7 @@
 
         *buf =3D w=
ork;
 
-        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&w=
ork), BLEN(&work), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: =
%s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
     }
 
     gc_free=
(&gc);
@@ -460,7 +460,7 @@
     ASSERT(buf->len > 0);
     ASSERT(ctx->ciph=
er);
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf)=
, BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", for=
mat_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     ASSERT(ad_start >=3D buf->=
data && ad_start <=3D BPTR(buf));
 
@@ -558,10 +558,10 @@
     }
 
     dms=
g(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc=
));
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), B=
LEN(buf), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_=
hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer overflow check (shoul=
d never fail) */
-    if (!buf_safe(&work, buf->len + cipher_ctx_block_size=
(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_siz=
e(ctx->cipher)))
     {
         CRYPT_ERROR("potential buffer overflow");
=
     }
@@ -585,7 +585,7 @@
     }
     ASSERT(buf_inc_len(&work, outlen));
=
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLE=
N(&work), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_h=
ex(BPTR(&work), BLENZ(&work), 80, &gc));
 
     if (!crypto_check_replay(op=
t, &pin, epoch, error_prefix, &gc))
     {
@@ -594,8 +594,8 @@
 
     /* up=
date number of plaintext blocks decrypted=2E Use the (x + (n-1))/n trick
  =
    * to round up the result to the number of blocks used=2E */
-    const =
int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi=2Edecrypt=2Epl=
aintext_blocks +=3D (BLEN(&work) + (blocksize - 1)) / blocksize;
+    const=
 unsigned int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi=2Ede=
crypt=2Eplaintext_blocks +=3D (BLENZ(&work) + (blocksize - 1)) / blocksize;=

 
     *buf =3D work;
 
@@ -631,7 +631,7 @@
         struct packet_id_net =
pin;
         bool have_pin =3D false;
 
-        dmsg(D_PACKET_CONTENT, "D=
ECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+        dmsg=
(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80=
, &gc));
 
         /* Verify the HMAC */
         if (ctx->hmac)
@@ -694,7=
 +694,7 @@
             }
 
             /* Buffer overflow check (should n=
ever happen) */
-            if (!buf_safe(&work, buf->len + cipher_ctx_blo=
ck_size(ctx->cipher)))
+            if (!buf_safe(&work, BLENZ(buf) + ciphe=
r_ctx_block_size(ctx->cipher)))
             {
                 CRYPT_ERROR=
("packet too big to decrypt");
             }
@@ -713,7 +713,7 @@
         =
    }
             ASSERT(buf_inc_len(&work, outlen));
 
-            dmsg(=
D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80=
, &gc));
+            dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(B=
PTR(&work), BLENZ(&work), 80, &gc));
 
             /* Get packet ID from p=
laintext buffer or IV, depending on cipher mode */
             {
@@ -855,7=
 +855,7 @@
 crypto_max_overhead(void)
 {
     return packet_id_size(true) +=
 OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_CIPHER_BLOCK_SIZE
-           + max_in=
t(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+           + max_uint(O=
PENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
 static void
@@ -1366,=
7 +1366,7 @@
         size_t buf_size =3D strlen(file) + 1;
         ASSERT=
(buf_size <=3D INT_MAX);
         size =3D (int)buf_size;
-        buf_set_=
read(&in, (const uint8_t *)file, size);
+        buf_set_read(&in, (const u=
int8_t *)file, buf_size);
     }
     else /* 'file' is a filename which re=
fers to a file containing the ascii key */
     {
@@ -1535,7 +1535,7 @@
   =
  struct buffer out =3D alloc_buf_gc(2048, &gc);
 
     /* how to format th=
e ascii file representation of key */
-    const int bytes_per_line =3D 16;=

+    const unsigned int bytes_per_line =3D 16;
 
     /* write header */
 =
    buf_printf(&out, "#\n# %d bit OpenVPN static key\n#\n", nbits);
diff --=
git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index a03c5ce=2E=2E2a=
596c9 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -=
751,12 +751,12 @@
  * to read=2E
  */
 static inline bool
-aead_usage_limit=
_reached(const uint64_t limit, const struct key_ctx *key_ctx, int64_t higes=
t_pid)
+aead_usage_limit_reached(const uint64_t limit, const struct key_ctx=
 *key_ctx, uint64_t higest_pid)
 {
     /* This is the  q + s <=3D  p^(1/2)=
 * 2^(129/2) - 1 calculation where
      * q is the number of protected mes=
sages (highest_pid)
      * s Total plaintext length in all messages (in bl=
ocks) */
-    return (limit > 0 && key_ctx->plaintext_blocks + (uint64_t)hi=
gest_pid > limit);
+    return (limit > 0 && key_ctx->plaintext_blocks + hi=
gest_pid > limit);
 }
 
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/cry=
pto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 312cf6f=2E=2E243b5a2 100=
644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@=
@ -98,7 +98,7 @@
     const uint8_t *label_prefix =3D (const uint8_t *)("ov=
pn ");
     uint8_t prefix_len =3D 5;
 
-    size_t hkdf_label_len =3D 2 + =
prefix_len + 1 + label_len + 1 + context_len;
+    size_t hkdf_label_len =
=3D 2u + prefix_len + 1u + label_len + 1u + context_len;
     struct buffer=
 hkdf_label =3D alloc_buf_gc(hkdf_label_len, &gc);
 
     buf_write_u16(&hk=
df_label, (uint16_t)out_len);
diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec
index 4809532=2E=2E1760c90 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2758,7 +2758,7 @@
             else
 =
            {
                 int status;
-                int resolve_fla=
gs =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
+         =
       unsigned int resolve_flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIG=
NAL | GETADDR_FATAL;
 
                 if (!(flags & MF_CONNECT_AS_CLIENT)=
)
                 {
@@ -4001,11 +4001,11 @@
         desc =3D "rsa-sign";
=
     }
 
-    buf_write(&buf_data, b64_data, (int)strlen(b64_data));
+    b=
uf_write(&buf_data, b64_data, strlen(b64_data));
     if (man->connection=
=2Eclient_version >=3D MCV_PKSIGN_ALG)
     {
-        buf_write(&buf_data,=
 ",", (int)strlen(","));
-        buf_write(&buf_data, algorithm, (int)strl=
en(algorithm));
+        buf_write(&buf_data, ",", strlen(","));
+        b=
uf_write(&buf_data, algorithm, strlen(algorithm));
     }
     char *ret =
=3D management_query_multiline_flatten(man, (char *)buf_bptr(&buf_data), pr=
ompt, desc,
                                                    &man->conne=
ction=2Eext_key_state,
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openv=
pn/ssl_mbedtls=2Ec
index cbc3118=2E=2Ef4e142b 100644
--- a/src/openvpn/ssl_=
mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1119,7 +1119,7 @@
       =
  return 0;
     }
 
-    retval =3D endless_buf_write(&ks->bio_ctx->in, BP=
TR(buf), buf->len);
+    retval =3D endless_buf_write(&ks->bio_ctx->in, BPT=
R(buf), BLENZ(buf));
 
     if (retval < 0)
     {
diff --git a/tests/unit_=
tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
in=
dex b480985=2E=2E14f5d1d 100644
--- a/tests/unit_tests/openvpn/test_buffer=
=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -106,20 +106,15 @@
 =
    gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-=
#endif
-
 static void
 test_buffer_format_hex_ex(void **state)
 {
-    cons=
t int input_size =3D 10;
+    const size_t input_size =3D 10;
     const ui=
nt8_t input[] =3D { 0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0=
x0a };
     char *output;
     struct gc_arena gc =3D gc_new();
 
-    int =
maxoutput =3D 0;
+    size_t maxoutput =3D 0;
     unsigned int blocksize =
=3D 5;
     const char *separator =3D " ";
     output =3D format_hex_ex(in=
put, input_size, maxoutput, blocksize, separator, &gc);
@@ -144,10 +139,6 @=
@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pr=
agma GCC diagnostic pop
-#endif
-
 struct test_buffer_list_aggregate_ctx
 {=

     struct buffer_list *empty;
diff --git a/tests/unit_tests/openvpn/test=
_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
index e68a0b2=2E=2E6=
ccca33 100644
--- a/tests/unit_tests/openvpn/test_crypto=2Ec
+++ b/tests/un=
it_tests/openvpn/test_crypto=2Ec
@@ -52,11 +52,6 @@
 
 static const char te=
sttext[] =3D "Dummy text to test PEM encoding";
 
-#if defined(__GNUC__) ||=
 defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ig=
nored "-Wsign-conversion"
-#endif
-
 static void
 crypto_pem_encode_decode_=
loopback(void **state)
 {
@@ -438,14 +433,14 @@
      * current mode (FIPS)=
, this will still return -1 */
     assert_int_equal(cipher_get_aead_limits=
("CHACHA20-POLY1305"), 0);
 
-    int64_t aeslimit =3D cipher_get_aead_limi=
ts("AES-128-GCM");
+    uint64_t aeslimit =3D cipher_get_aead_limits("AES-1=
28-GCM");
 
     assert_int_equal(aeslimit, (1ull << 36) - 1);
 
     /* Ch=
eck if this matches our exception for 1600 size packets assuming
      * AE=
AD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes)=2E Gives us 100 blocks
      * + 1 =
for the packet */
-    int64_t L =3D 101;
+    uint64_t L =3D 101;
     /* =
2 ^ 29=2E34, using the result here to avoid linking to libm */
     assert_=
int_equal(aeslimit / L, 680390858);
 
@@ -491,7 +486,7 @@
                 =
         0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, =
0xf7,
                          0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0=
xff };
 
-    const int L =3D 82;
+    const size_t L =3D 82;
     uint8_t =
okm[82] =3D { 0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1, 0xc8, 0xe7, 0=
xf7, 0x8c,
                         0x59, 0x6a, 0x49, 0x34, 0x4f, 0x01, 0x2=
e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
                         0xa0, 0x50, 0xcc,=
 0x4c, 0x19, 0xaf, 0xa9, 0x7c, 0x59, 0x04, 0x5a, 0x99,
@@ -516,7 +511,7 @@
=
 
     const uint8_t info[] =3D { 0 };
 
-    int L =3D 42;
+    const size=
_t L =3D 42;
     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63,=
 0xc1, 0x8f, 0x71, 0x5f, 0x80,
                         0x2a, 0x06, 0x3c, 0=
x5a, 0x31, 0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1,
                         0x8=
7, 0x9e, 0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d, 0x9d,
@@ -541,7 +5=
36,7 @@
     uint8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6=
e, 0x20, 0x75,
                          0x6e, 0x69, 0x74, 0x20, 0x74, 0x65=
, 0x73, 0x74, 0x00 };
 
-    int L =3D 27;
+    const size_t L =3D 27;
    =
 uint8_t okm[27] =3D { 0x87, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80, 0xb8=
,
                         0xd9, 0x33, 0xed, 0x32, 0x3c, 0x2d, 0xf8, 0xe8, =
0xec,
                         0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0, 0x6a, 0x=
83, 0xac };
@@ -753,7 +748,7 @@
 
     /* lookup some wacky things that sho=
uld fail */
     assert_null(epoch_lookup_decrypt_key(co, 2000));
-    asse=
rt_null(epoch_lookup_decrypt_key(co, -1));
+    assert_null(epoch_lookup_de=
crypt_key(co, UINT16_MAX));
     assert_null(epoch_lookup_decrypt_key(co, 0=
xefff));
 
     /* Lookup the edges of the current window */
@@ -804,10 +79=
9,6 @@
     assert_null(epoch_lookup_decrypt_key(co, 23));
 }
 
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 vo=
id
 crypto_test_epoch_key_overflow(void **state)
 {
diff --git a/tests/unit=
_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networki=
ng=2Ec
index ae75386=2E=2E3699a2a1 100644
--- a/tests/unit_tests/openvpn/te=
st_networking=2Ec
+++ b/tests/unit_tests/openvpn/test_networking=2Ec
@@ -40=
,23 +40,14 @@
     return net_iface_del(NULL, name);
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
-#endif
-
 static int
-net__iface_mtu_set=
(int mtu)
+net__iface_mtu_set(uint32_t mtu)
 {
-    printf("CMD: ip link se=
t %s mtu %d\n", iface, mtu);
+    printf("CMD: ip link set %s mtu %u\n", if=
ace, mtu);
 
     return net_iface_mtu_set(NULL, iface, mtu);
 }
 
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
=
 static int
 net__addr_v4_add(const char *addr_str, int prefixlen)
 {
diff =
--git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/te=
st_pkt=2Ec
index 889e6d7=2E=2E49ba833 100644
--- a/tests/unit_tests/openvpn=
/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -618,11 +618,6=
 @@
     assert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZ=
E);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 stat=
ic void
 test_generate_reset_packet_plain(void **ut_state)
 {
@@ -701,10 +6=
96,6 @@
     free_tas(&tas_server);
 }
 
-#if defined(__GNUC__) || defined(=
__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* A peer can ask us to a=
ppend the wrapped client key (WKc) to our next
  * control packet=2E Only a=
 tls-crypt-v2 client has one, so check that we
  * refuse to build such a p=
acket when we have no key instead of walking
diff --git a/tests/unit_tests/=
openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
in=
dex ab90ea5=2E=2E2d31c00 100644
--- a/tests/unit_tests/openvpn/test_tls_cry=
pt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -352,7 +352,7 @=
@
     skip_if_tls_crypt_not_supported(ctx);
 
     buf_clear(&ctx->source)=
;
-    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLEN(&c=
tx->ciphertext)
+    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_=
SIZE - BLENZ(&ctx->ciphertext)
                                            =
           - tls_crypt_buf_overhead()));
 
     assert_true(tls_crypt_wrap(=
&ctx->source, &ctx->ciphertext, &ctx->co));
@@ -373,7 +373,7 @@
     skip_i=
f_tls_crypt_not_supported(ctx);
 
     buf_clear(&ctx->source);
-    assert=
_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLEN(&ctx->ciphertex=
t)
+    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLENZ(=
&ctx->ciphertext)
                                                       - =
tls_crypt_buf_overhead() + 1));
     assert_false(tls_crypt_wrap(&ctx->sour=
ce, &ctx->ciphertext, &ctx->co));
 }
@@ -553,7 +553,7 @@
     assert_false(=
tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL));
 
     /* add=
 a opcode in front of the key to make it valid to extract */
-    struct bu=
ffer wkcop =3D alloc_buf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc);
+    struct =
buffer wkcop =3D alloc_buf_gc(BLENZ(&ctx->wkc) + 1, &ctx->gc);
     buf_wri=
te_u8(&wkcop, 0x50);
     buf_copy(&wkcop, &ctx->wkc);
     assert_true(tls=
_crypt_v2_extract_client_key(&wkcop, &wrap_ctx, NULL));
@@ -638,7 +638,7 @@=

     int64_t create_time =3D now - (days_ago * 24 * 60 * 60);
     assert_=
true(create_time > 0);
 
-    int64_t timestamp =3D htonll((uint64_t)create=
_time);
+    uint64_t timestamp =3D htonll((uint64_t)create_time);
     ASS=
ERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));
     ASSE=
RT(buf_write(&metadata, &timestamp, sizeof(timestamp)));
 
@@ -660,7 +660,7=
 @@
                                              &ctx->server_keys=2Eencry=
pt, &ctx->gc));
 
     /* add a opcode in front of the key to make it valid=
 to extract */
-    struct buffer pseudo_packet =3D alloc_buf_gc(buf_len(&c=
tx->wkc) + 1, &ctx->gc);
+    struct buffer pseudo_packet =3D alloc_buf_gc(=
BLENZ(&ctx->wkc) + 1, &ctx->gc);
 
     buf_write_u8(&pseudo_packet, 0x50);=

     buf_copy(&pseudo_packet, &ctx->wkc);
@@ -745,7 +745,7 @@
     struct =
buffer expected_metadata =3D create_metadata_days_ago(&ctx->gc, 29);
     b=
uf_advance(&expected_metadata, 1);
 
-    expect_memory(__wrap_buffer_write=
_file, pem, buf_bptr(&expected_metadata), buf_len(&expected_metadata));
+  =
  expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata)=
, BLENZ(&expected_metadata));
     will_return(__wrap_buffer_write_file, tr=
ue);
 
     tmp =3D create_client_key_input(ctx, 29);
@@ -760,7 +760,7 @@
 =
    }
 
     expect_string(__wrap_buffer_write_file, filename, tmpfile_path=
);
-    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_met=
adata), buf_len(&expected_metadata));
+    expect_memory(__wrap_buffer_writ=
e_file, pem, buf_bptr(&expected_metadata), BLENZ(&expected_metadata));
    =
 will_return(__wrap_buffer_write_file, true);
 
     tmp =3D create_client_=
key_input(ctx, 29);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2157?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Gerrit-Change-Number: 2157
G=
errit-PatchSet: 5
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--GEhoJeB675k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #5</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">Various trivial -Wsign-conversion fixes<br><br>=
* Continue BLEN -&gt; BLENZ replacement<br>* Remove some unneeded casts<br>=
* Some trivial type fixes<br><br>Change-Id: I02f8df01f8f33cb9cd04cd844d1f18=
93688f51e8<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt;<br>---<br>M src/openvpn/acc=2Ec<br>M src/openvpn/auth_token=2Ec<br>M sr=
c/openvpn/base64=2Eh<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/=
crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/crypto_epoch=2Ec<br=
>M src/openvpn/manage=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M tests/unit_=
tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/test_crypto=2Ec=
<br>M tests/unit_tests/openvpn/test_networking=2Ec<br>M tests/unit_tests/op=
envpn/test_pkt=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>14 f=
iles changed, 51 insertions(+), 106 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/2157/5=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><=
span>index e21891d=2E=2Eb8d7c3d 100644</span><br><span>--- a/src/openvpn/ac=
c=2Ec</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -148,11 =
+148,6 @@</span><br><span>     return parse_acc_message_flags(flags, err_re=
ason, gc);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> void</span><br><span> receive_acc_message(struct conte=
xt *c, const struct buffer *buffer)</span><br><span> {</span><br><span>@@ -=
236,15 +231,10 @@</span><br><span>     msg(D_PUSH_ERRORS, &quot;WARNING: Re=
ceived malformed custom app control channel &quot;</span><br><span>        =
                &quot;message (%s): %s&quot;,</span><br><span>         err_=
reason,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        format=
_hex(CBPTR(buffer), BLEN(buffer), 80, &amp;gc));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        format_hex(CBPTR(buffer), BLENZ(buffer=
), 80, &amp;gc));</span><br><span>     gc_free(&amp;gc);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> bool</span><br><span> send_acc_message(struct context *c,</span><br><=
span>                  struct tls_multi *multi,</span><br><span>diff --git =
a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>i=
ndex 211af90=2E=2Eb69092c 100644</span><br><span>--- a/src/openvpn/auth_tok=
en=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ =
-36,11 +36,6 @@</span><br><span>  * padding */</span><br><span> static_asse=
rt(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not a multiple of 3=
&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsig=
n-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
bool</span><br><span> is_auth_token(const char *password)</span><br><span> =
{</span><br><span>@@ -67,7 +62,7 @@</span><br><span>         return;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int auth_token_state_flags =3D session-&gt;key[KS_PRIMARY]=
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
crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 33e0376=2E=2E826f=
39e 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++=
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
an>index a03c5ce=2E=2E2a596c9 100644</span><br><span>--- a/src/openvpn/cryp=
to=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -751=
,12 +751,12 @@</span><br><span>  * to read=2E</span><br><span>  */</span><b=
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
/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span=
>index b480985=2E=2E14f5d1d 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_buffer=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
buffer=2Ec</span><br><span>@@ -106,20 +106,15 @@</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> static void</span><br><span> test_buffer_format_hex_=
ex(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const int input_size =3D 10;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const size_t input_size =3D 10;</span><br><s=
pan>     const uint8_t input[] =3D { 0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0x=
f0, 0x0f, 0x09, 0x0a };</span><br><span>     char *output;</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int maxoutput =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t maxoutput =3D 0;</span><b=
r><span>     unsigned int blocksize =3D 5;</span><br><span>     const char =
*separator =3D &quot; &quot;;</span><br><span>     output =3D format_hex_ex=
(input, input_size, maxoutput, blocksize, separator, &amp;gc);</span><br><s=
pan>@@ -144,10 +139,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> struct test_buffer_list_aggregate_ctx</s=
pan><br><span> {</span><br><span>     struct buffer_list *empty;</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_te=
sts/openvpn/test_crypto=2Ec</span><br><span>index e68a0b2=2E=2E6ccca33 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>@@ -5=
2,11 +52,6 @@</span><br><span> </span><br><span> static const char testtext=
[] =3D &quot;Dummy text to test PEM encoding&quot;;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> cry=
pto_pem_encode_decode_loopback(void **state)</span><br><span> {</span><br><=
span>@@ -438,14 +433,14 @@</span><br><span>      * current mode (FIPS), thi=
s will still return -1 */</span><br><span>     assert_int_equal(cipher_get_=
aead_limits(&quot;CHACHA20-POLY1305&quot;), 0);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t aeslimit =3D cipher=
_get_aead_limits(&quot;AES-128-GCM&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint64_t aeslimit =3D cipher_get_aead_limits(&qu=
ot;AES-128-GCM&quot;);</span><br><span> </span><br><span>     assert_int_eq=
ual(aeslimit, (1ull &lt;&lt; 36) - 1);</span><br><span> </span><br><span>  =
   /* Check if this matches our exception for 1600 size packets assuming</s=
pan><br><span>      * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes)=2E Gives us=
 100 blocks</span><br><span>      * + 1 for the packet */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int64_t L =3D 101;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint64_t L =3D 101;</span><br><s=
pan>     /* 2 ^ 29=2E34, using the result here to avoid linking to libm */<=
/span><br><span>     assert_int_equal(aeslimit / L, 680390858);</span><br><=
span> </span><br><span>@@ -491,7 +486,7 @@</span><br><span>                =
          0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6,=
 0xf7,</span><br><span>                          0xf8, 0xf9, 0xfa, 0xfb, 0x=
fc, 0xfd, 0xfe, 0xff };</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const int L =3D 82;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const size_t L =3D 82;</span><br><span>     uin=
t8_t okm[82] =3D { 0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1, 0xc8, 0x=
e7, 0xf7, 0x8c,</span><br><span>                         0x59, 0x6a, 0x49, =
0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,</span><br><span>     =
                    0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c, 0x59, 0=
x04, 0x5a, 0x99,</span><br><span>@@ -516,7 +511,7 @@</span><br><span> </spa=
n><br><span>     const uint8_t info[] =3D { 0 };</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int L =3D 42;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const size_t L =3D 42;</span=
><br><span>     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0=
xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><span>                         0x2a,=
 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1,</span><br><spa=
n>                         0x87, 0x9e, 0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, =
0x8d, 0x2d, 0x9d,</span><br><span>@@ -541,7 +536,7 @@</span><br><span>     =
uint8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75=
,</span><br><span>                          0x6e, 0x69, 0x74, 0x20, 0x74, 0=
x65, 0x73, 0x74, 0x00 };</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int L =3D 27;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const size_t L =3D 27;</span><br><span>     uint8_t =
okm[27] =3D { 0x87, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80, 0xb8,</span><=
br><span>                         0xd9, 0x33, 0xed, 0x32, 0x3c, 0x2d, 0xf8,=
 0xe8, 0xec,</span><br><span>                         0xcf, 0x49, 0x72, 0xe=
6, 0x83, 0xf0, 0x6a, 0x83, 0xac };</span><br><span>@@ -753,7 +748,7 @@</spa=
n><br><span> </span><br><span>     /* lookup some wacky things that should =
fail */</span><br><span>     assert_null(epoch_lookup_decrypt_key(co, 2000)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_null(epo=
ch_lookup_decrypt_key(co, -1));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));</spa=
n><br><span>     assert_null(epoch_lookup_decrypt_key(co, 0xefff));</span><=
br><span> </span><br><span>     /* Lookup the edges of the current window *=
/</span><br><span>@@ -804,10 +799,6 @@</span><br><span>     assert_null(epo=
ch_lookup_decrypt_key(co, 23));</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void</span><br><span> crypto_test_epoch_key_overflow(void **state)</span>=
<br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_net=
working=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>=
index ae75386=2E=2E3699a2a1 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_networking=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_networking=2Ec</span><br><span>@@ -40,23 +40,14 @@</span><br><span>    =
 return net_iface_del(NULL, name);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-net__iface_mtu_set(int mtu)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+net__iface_mtu_set(uint32_t mtu)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 printf(&quot;CMD: ip link set %s mtu %d\n&quot;, iface, mtu);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;CMD: ip link se=
t %s mtu %u\n&quot;, iface, mtu);</span><br><span> </span><br><span>     re=
turn net_iface_mtu_set(NULL, iface, mtu);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static int</span><br><span> net__addr_v4_add(const char *addr_s=
tr, int prefixlen)</span><br><span> {</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span>index 889e6d7=2E=2E49ba833 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>@@ -618,11 +618,6 @@</span><br><span>     as=
sert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 5 </=
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
<div style=3D"display:none"> Ge=
rrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--GEhoJeB675k=--


--===============8393052737879205083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8393052737879205083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8393052737879205083==--


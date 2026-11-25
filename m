Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9E606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dFRKr3u3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UQgCE2Ug;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JL50b1IC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WTmpifIp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=woBahJLBah6PqOFI5XovELVrz/ghi/51LglZ3YYJ6Mg=; b=dFRKr3u37oXSCJVzeGydgKcvOD
	v3M3hjycCRfdU8VkvbgvYMZ5F8GBJ6D74fatGhXS9Htz6lw9+dPvE/ovB5CItrwzDWQpkLDzriPKI
	DHsoJ36Xu2P2+Q7lolNgPYcimLkcLi5LSSaBLSGWeZTFto9eZl44JRXuWtUawqiszrZg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWINj-000000006a9-2O8t;
	Wed, 25 Nov 2026 19:10:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWINh-000000006a1-48Yp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cmzrqXxP8HMBfCYIcJig9r11NEzks2q/OnxxKYXttDc=; b=UQgCE2UgeecWh91lISZM6+DHxM
 ykRQw0JlBhanrkZO+HQr0H0HSYHMjv4GKESMp+9mSVEyXl9S2qmDXq8g8VlTdKFiM9CvSbThoA39G
 EWpB+EkJbvMezK/pELtrhC9pm9a/jJysVsXtTBSoBNBLE4l1K1zmDtz4Gkqia4GEMRO8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cmzrqXxP8HMBfCYIcJig9r11NEzks2q/OnxxKYXttDc=; b=JL50b1ICWBb1G1F2tEFjnOIhiS
 q2bbhhzOY+2hhCwSEGS/ZDSvXJ+3RTmEb79vBidfkZ99cUPuqJxLl1AgFe68uMRb5FLwcGdFdE8/D
 /JFXokPcmfw1tZ3liGdEOXOYTw/56dl8KjuiKxc/bioYdBkepl4a0/z7THRiKMKiUGk8=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWINf-000000007ws-0QeI for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:10:13 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so48223095e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 11:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795633804; x=1796238604; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cmzrqXxP8HMBfCYIcJig9r11NEzks2q/OnxxKYXttDc=;
 b=WTmpifIpd/5slGFsIha3d5gPURjQoqvOCNdOh8KIR6p1iDkkMdNt4FY/L7GVbgDWMR
 YJ4DBwL4gJhz8XDfv0JQnfqhdtz9VmXs1whjKd3Ha9ToI0yLWnzJXoRAc79IjTL03iyU
 n2VzXuW6xkPZcjfJ21MdxJxOD9JcnVeHpVgt2G1ZR37xH/hfWQKPFlXcGE8I4MlaVqyK
 R1ZTJdMFxP/3rnuPzI5aujBTkrXTYdi7W8AXVn9qa9rwQDDKLLYZIPcJdiUQignjQtH6
 /r5q7K1XpE7zJy5NGTiSOXTjjLfBYW4/m55y/5DWEFTsBXcSCaIU+PiSDtmJmfzd2h7e
 SdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795633804; x=1796238604;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cmzrqXxP8HMBfCYIcJig9r11NEzks2q/OnxxKYXttDc=;
 b=VbNNnhimqtGsNqD3mtURCvcAnrQ07BwL5LcNQ3fVAv3nGOk0Yt5nMmMaz58olYlatn
 5L2aF0Xofw5OMeGRMdTug3dPFBsATcJr1gLG0dfDFcVhSP2YUQI8HjlRa2vW3pWihNkL
 EYwS8MOfR9AsIBCgNtSmw09LMPLVAVNvRcADJuo0/71kFGacoNlZNN3N8/O08wKw5AKU
 nbyrFMTvfAjtl32fAJsowCDT1WhpP1kN+QIKmXpv48YicATyAQg9B4xtGONIAmbRbFLx
 RbB6kU2gku4+1vyqKhLjKJkJSHoBBHcUBI3O2qQtvuYFFVJ2bNocUNW9FDq4fJ1qHwnV
 48hQ==
X-Gm-Message-State: APuU4Z+jktC0vIYS4NT+WopsPkiSM1sehdCEFNXxSBOdr9HPyO9qWv2Y
 2GXzKjnimGR8XFsGLivM1SyoacSxy3e/9Tlc/oa6iQW6Rr5Ylv1srASjaiMczqv7t+Zpn19odp8
 2Md/arDvMa2S8/gWErvO/V08tlLp9VLFhRgAr9YZGgICklJW8Od/JH3NaRgcMnmEQE0NR
X-Gm-Gg: AZFdTZexgP86v9pC/bAYj0yoS3OSvvPIkfpu5AJ+qr/Uyc75H5GFPak5VoBZVbgj3QU
 n1G/7PPzlkD/XjgzdoFufyh3tJ8ktrWWqcJrHSX/z3VMxwLTlA1rj8MgrEmzzjQK4/whn68xG85
 uO9G3uM+RTAIrPGrFkDFO4+lDpgvm5yiPdcM7ieJQkxk139RaeKFhiXZvzhdnpRDh6Ko4MqfPjB
 wgDtYzPiI8RZVxmcwpLKZtEi3oJbpYy4HE84wbYLpUXLVP+VKIaJioIRbEj3WaDImDwxbxPjDAy
 SzAe2RkK66ZqfPU8MnOUmFX2GqG3dPvccy42j50AsdQEbxr/TJ+dvWDt3KYu9Mfm8CH1EI46nu8
 BhXjwJg0RetKvNjTEu3drrnK5cCow973Xpax6QTlKiY/NAX3Oj94R19uN42LzHy04cJgSWUmTt4
 pg1sRO370TyVv+ijf0u9c6VbxYLkv9zKYt0SNezaIPChc2NJnLJBFHrvgEToxmVtSXRVEW1n4Yi
 LqN+y/op+xyr7p9+368d5BTeHjf2KbLcVLCdzQePv04J9cWbsHJUPLSBPlC+bi2ncZvGn4WFvx6
 NsQJBbhQPYj9mKtZeRdR0jpoW5KqI50V9yEdBywMzyWB56xzAvdxmXUykp8EG/qHbcZZZE3DFSN
 FhLvjPs1E/JUl25K+4rARVgJY1lFZgDsxEpIOlPV8RoMiER17r5m4O71wd1ez7DE0exGmdZzv5Q
 ZOzhDpqaoEgHryYM8=
X-Received: by 2002:a05:600c:4f0f:b0:4bb:87f4:3674 with SMTP id
 5b1f17b1804b1-4bb8880ef40mr479269195e9.15.1795633804142; 
 Wed, 25 Nov 2026 11:10:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm528164465e9.10.2026.11.25.11.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:10:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 19:10:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
X-Gerrit-Change-Number: 2346
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2346?usp=email>
X-Gerrit-Commit: 2a2310f4bca9c51a67500fb575b57ae04e8a12a8
In-Reply-To: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
References: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkkxZTg0NTI1MGI2ZTYwNmZmYjQ5ZmE1ZmUxYmZkMDM0YmU3ZWFhZjJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4934f1780766602cdd5e41a771d486713d4df598-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWINf-000000007ws-0QeI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: push: check INFO_PRE
 length before sending AUTH_PENDING
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0006865043155935499=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0006865043155935499==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aLuiZlzAVjw="; charset=UTF-8

--aLuiZlzAVjw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: push: chec=
k INFO_PRE length before sending AUTH_PENDING
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: check INFO_PRE length before sendi=
ng AUTH_PENDING

send_auth_pending_messages() sent AUTH_PENDING, then rejec=
ted an
oversized INFO_PRE and returned false=2E The client was left pending=

with no INFO_PRE, auth_deferred_expire was not set, and the management
cli=
ent got an error for a message that had already gone out=2E

Do the length =
check before sending anything=2E The check also counted
the terminating NUL=
 twice; count it once=2E Log both early returns, as
callers fail the auth o=
n them=2E

Add a push unit test driver covering both the longest accepted a=
nd a
too-long INFO_PRE=2E

Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7ea=
af2b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M CMakeList=
s=2Etxt
M src/openvpn/push=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
M t=
ests/unit_tests/openvpn/mock_management=2Ec
A tests/unit_tests/openvpn/test=
_push=2Ec
5 files changed, 398 insertions(+), 8 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/2346/3

diff --gi=
t a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 50b2d68=2E=2E554e117 100644
-=
-- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -695,6 +695,7 @@
         "=
test_packet_id"
         "test_pkt"
         "test_provider"
+        "test=
_push"
         "test_socket"
         "test_ssl"
         "test_user_pass"=

@@ -943,6 +944,16 @@
         src/openvpn/run_command=2Ec
         )
 
+  =
  target_sources(test_push PRIVATE
+        tests/unit_tests/openvpn/mock_g=
et_random=2Ec
+        tests/unit_tests/openvpn/mock_management=2Ec
+      =
  tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+        src/openvpn/=
base64=2Ec
+        src/openvpn/options_util=2Ec
+        src/openvpn/otime=
=2Ec
+        src/openvpn/ssl_util=2Ec
+    )
+
     target_sources(test_pu=
sh_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg=2Ec
      =
   tests/unit_tests/openvpn/mock_get_random=2Ec
diff --git a/src/openvpn/pu=
sh=2Ec b/src/openvpn/push=2Ec
index eb11107=2E=2Ebbc4f71 100644
--- a/src/o=
penvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -508,11 +508,21 @@
     time_=
t time_elapsed =3D now - ks->initial;
     if (time_elapsed < 0 || time_ela=
psed >=3D (time_t)max_timeout)
     {
+        msg(M_WARN, "Handshake time =
elapsed (%ds, max %us), not sending AUTH_PENDING",
+            (int)time_e=
lapsed, max_timeout);
         return false;
     }
     max_timeout -=3D (=
unsigned int)time_elapsed;
     timeout =3D min_uint(max_timeout, timeout);=

 
+    const size_t info_len =3D strlen(extra) + sizeof(info_pre);
+    if=
 (info_len > PUSH_BUNDLE_SIZE)
+    {
+        msg(M_WARN, "INFO_PRE messag=
e too long (%zu > %d), not sending AUTH_PENDING",
+            info_len, PU=
SH_BUNDLE_SIZE);
+        return false;
+    }
+
     struct gc_arena gc =
=3D gc_new();
     if ((proto & IV_PROTO_AUTH_PENDING_KW) =3D=3D 0)
     {
=
@@ -530,14 +540,7 @@
         send_control_channel_string_dowork(session, B=
STR(&buf), D_PUSH);
     }
 
-    size_t len =3D strlen(extra) + 1 + sizeof=
(info_pre);
-    if (len > PUSH_BUNDLE_SIZE)
-    {
-        gc_free(&gc);
=
-        return false;
-    }
-
-    struct buffer buf =3D alloc_buf_gc(len=
, &gc);
+    struct buffer buf =3D alloc_buf_gc(info_len, &gc);
     buf_pr=
intf(&buf, info_pre);
     buf_printf(&buf, "%s", extra);
     send_control=
_channel_string_dowork(session, BSTR(&buf), D_PUSH);
diff --git a/tests/uni=
t_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
inde=
x e3404754=2E=2Eb068028 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam=

+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -18,6 +18,7 @@
 	packet_id=
_testdriver \
 	pkt_testdriver \
 	provider_testdriver \
+	push_testdriver =
\
 	push_update_msg_testdriver \
 	socket_testdriver \
 	ssl_testdriver \
@=
@ -413,6 +414,25 @@
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
 	$=
(top_srcdir)/src/openvpn/session_id=2Ec
 
+push_testdriver_CFLAGS  =3D \
+	=
-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/open=
vpn \
+	@TEST_CFLAGS@
+push_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+push_t=
estdriver_SOURCES =3D test_push=2Ec \
+	mock_get_random=2Ec \
+	mock_manage=
ment=2Ec \
+	mock_msg=2Ec test_common=2Eh \
+	mock_push_dependencies=2Ec \
=
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn=
/base64=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/=
openvpn/options_util=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_=
srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec=
 \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
 push_update_msg_testdriver=
_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	=
-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/op=
envpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
in=
dex aea43da=2E=2E18f13569 100644
--- a/tests/unit_tests/openvpn/mock_manage=
ment=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -42,6 +42,22=
 @@
     ASSERT(false);
 }
 
+void
+management_notify(const char *severity,=
 const char *type, const char *text)
+{
+}
+
+void
+management_notify_clien=
t_cr_response(unsigned mda_key_id, const struct man_def_auth_context *mdac,=

+                                     const struct env_set *es, const char=
 *response)
+{
+}
+
+void
+management_notify_generic(const char *str)
+{
+}=

+
 char *
 management_query_pk_sig(struct management *man, const char *b64=
_data, const char *algorithm)
 {
diff --git a/tests/unit_tests/openvpn/test=
_push=2Ec b/tests/unit_tests/openvpn/test_push=2Ec
new file mode 100644
ind=
ex 0000000=2E=2E4615e91
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_p=
ush=2Ec
@@ -0,0 +1,340 @@
+/*
+ *  OpenVPN -- An application to securely tu=
nnel IP networks
+ *             over a single UDP port, with support for S=
SL/TLS-based
+ *             session authentication and key exchange,
+ *  =
           packet encryption, packet authentication, and
+ *             pa=
cket compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <=
stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=
=2Eh>
+#include <cmocka=2Eh>
+
+#include "push=2Ec"
+#include "mock_msg=2Eh=
"
+#include "test_common=2Eh"
+
+/* Control channel messages sent by the co=
de under test */
+static int sent_count;
+/* larger than PUSH_BUNDLE_SIZE s=
o an oversized message is not truncated */
+static char sent_msgs[2][2 * PU=
SH_BUNDLE_SIZE];
+
+bool
+send_control_channel_string_dowork(struct tls_ses=
sion *session, const char *str,
+                                   msglvl_=
t msglevel)
+{
+    if (sent_count < (int)SIZE(sent_msgs))
+    {
+        =
strlcpy(sent_msgs[sent_count], str, sizeof(sent_msgs[0]));
+    }
+    sent=
_count++;
+    return true;
+}
+
+/* Remaining dependencies of push=2Ec, no=
t reached by these tests */
+#ifdef ENABLE_MANAGEMENT
+void
+ssl_put_auth_c=
hallenge(const char *cr_str)
+{
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
+
=
+#ifdef ENABLE_PLUGIN
+void
+verify_crresponse_plugin(struct tls_multi *mul=
ti, const char *cr_response)
+{
+}
+#endif
+
+void
+verify_crresponse_scrip=
t(struct tls_multi *multi, const char *cr_response)
+{
+}
+
+bool
+apply_pu=
sh_options(struct context *c, struct options *options, struct buffer *buf,
=
+                   uint64_t permission_mask, uint64_t *option_types_found,=
 struct env_set *es,
+                   bool is_update)
+{
+    return tru=
e;
+}
+
+static int global_auth_retry;
+
+int
+auth_retry_get(void)
+{
+   =
 return global_auth_retry;
+}
+
+bool
+do_up(struct context *c, bool pulled=
_options, uint64_t option_types_found)
+{
+    return true;
+}
+
+bool
+do_=
update(struct context *c, uint64_t option_types_found)
+{
+    return true;=

+}
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int res=
olve_retry_seconds, bool *succeeded,
+        struct signal_info *sig_info)=

+{
+    return 0;
+}
+
+bool
+get_ipv6_addr(const char *hostname, struct i=
n6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel)
=
+{
+    return false;
+}
+
+struct buffer
+get_list_intersection(struct gc_=
arena *gc, const char *list1, const char *list2)
+{
+    return alloc_buf_g=
c(0, gc);
+}
+
+const char **
+make_extended_arg_array(char **p, bool is_in=
line, struct gc_arena *gc)
+{
+    const char **argv;
+    ALLOC_ARRAY_CLEA=
R_GC(argv, const char *, 1, gc);
+    return argv;
+}
+
+void
+md_ctx_clean=
up(md_ctx_t *ctx)
+{
+}
+
+void
+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)
=
+{
+}
+
+void
+md_ctx_free(md_ctx_t *ctx)
+{
+}
+
+void
+md_ctx_init(md_ctx=
_t *ctx, const char *mdname)
+{
+}
+
+md_ctx_t *
+md_ctx_new(void)
+{
+    =
return NULL;
+}
+
+void
+md_ctx_update(md_ctx_t *ctx, const uint8_t *src, s=
ize_t src_len)
+{
+}
+
+void
+notify_client_acc_protocols(struct tls_multi =
*multi)
+{
+}
+
+char *
+parse_acc_parameters(const char *capabilities, con=
st char *delim, int *max_acc_len, bool server,
+                     struct=
 gc_arena *gc)
+{
+    return NULL;
+}
+
+int
+parse_line(const char *line,=
 char *p[], const int n, const char *file, const int line_num,
+           =
msglvl_t msglevel, struct gc_arena *gc)
+{
+    return 0;
+}
+
+const char =
*
+print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc_aren=
a *gc)
+{
+    return "";
+}
+
+const char *
+print_in_addr_t(in_addr_t add=
r, unsigned int flags, struct gc_arena *gc)
+{
+    return "";
+}
+
+int
+p=
rocess_push_update(struct context *c, struct options *o, uint64_t permissio=
n_mask,
+                    uint64_t *option_types_found, struct buffer *b=
uf, bool msg_sender)
+{
+    return PUSH_MSG_ERROR;
+}
+
+void
+register_si=
gnal(struct signal_info *si, int sig, const char *text)
+{
+}
+
+void
+resc=
hedule_multi_process(struct context *c)
+{
+}
+
+const char *
+sanitize_con=
trol_message(const char *str, struct gc_arena *gc)
+{
+    return str;
+}
+=

+bool
+schedule_exit(struct context *c)
+{
+    return true;
+}
+
+bool
+s=
end_control_channel_string(struct context *c, const char *str, msglvl_t msg=
level)
+{
+    return true;
+}
+
+bool
+ssl_clean_auth_token(void)
+{
+    =
return false;
+}
+
+void
+ssl_purge_auth(const bool auth_user_pass_only)
+{=

+}
+
+enum tls_auth_status
+tls_authentication_status(struct tls_multi *mu=
lti)
+{
+    return TLS_AUTHENTICATION_FAILED;
+}
+
+bool
+tls_peer_support=
s_ncp(const char *peer_info)
+{
+    return false;
+}
+
+/* "INFO_PRE," + e=
xtra + NUL must fit in PUSH_BUNDLE_SIZE */
+#define INFO_EXTRA_MAX (PUSH_BU=
NDLE_SIZE - sizeof("INFO_PRE,"))
+
+struct auth_pending_ctx
+{
+    struct =
tls_multi multi;
+    struct tls_session session;
+    char extra[PUSH_BUND=
LE_SIZE + 1];
+};
+
+static int
+auth_pending_setup(void **state)
+{
+    s=
truct auth_pending_ctx *ctx =3D calloc(1, sizeof(*ctx));
+    ctx->multi=2E=
peer_info =3D "IV_PROTO=3D16\n"; /* IV_PROTO_AUTH_PENDING_KW */
+    ctx->m=
ulti=2Eopt=2Ehandshake_window =3D 60;
+    ctx->multi=2Eopt=2Erenegotiate_s=
econds =3D 3600;
+
+    now =3D 1000;
+    ctx->session=2Ekey[KS_PRIMARY]=
=2Einitial =3D now;
+    ctx->session=2Ekey[KS_PRIMARY]=2Eauth_deferred_exp=
ire =3D 42;
+
+    sent_count =3D 0;
+    CLEAR(sent_msgs);
+    CLEAR(mock=
_msg_buf);
+
+    *state =3D ctx;
+    return 0;
+}
+
+static int
+auth_pen=
ding_teardown(void **state)
+{
+    free(*state);
+    return 0;
+}
+
+stat=
ic void
+set_extra(struct auth_pending_ctx *ctx, size_t len)
+{
+    memset=
(ctx->extra, 'x', len);
+    ctx->extra[len] =3D '\0';
+}
+
+static void
+t=
est_auth_pending_sent(void **state)
+{
+    struct auth_pending_ctx *ctx =
=3D *state;
+    set_extra(ctx, INFO_EXTRA_MAX);
+
+    assert_true(send_au=
th_pending_messages(&ctx->multi, &ctx->session, ctx->extra, 120));
+
+    a=
ssert_int_equal(sent_count, 2);
+    assert_string_equal(sent_msgs[0], "AUT=
H_PENDING,timeout 120");
+    assert_int_equal(strlen(sent_msgs[1]), sizeof=
("INFO_PRE,") - 1 + INFO_EXTRA_MAX);
+    assert_true(strprefix(sent_msgs[1=
], "INFO_PRE,xxx"));
+    assert_int_equal(ctx->session=2Ekey[KS_PRIMARY]=
=2Eauth_deferred_expire, now + 120);
+}
+
+static void
+test_auth_pending_i=
nfo_too_long(void **state)
+{
+    struct auth_pending_ctx *ctx =3D *state;=

+    set_extra(ctx, INFO_EXTRA_MAX + 1);
+
+    assert_false(send_auth_pen=
ding_messages(&ctx->multi, &ctx->session, ctx->extra, 120));
+
+    /* noth=
ing may reach the client, not even AUTH_PENDING */
+    assert_int_equal(se=
nt_count, 0);
+    assert_int_equal(ctx->session=2Ekey[KS_PRIMARY]=2Eauth_d=
eferred_expire, 42);
+    assert_string_equal(mock_msg_buf,
+              =
          "INFO_PRE message too long (1025 > 1024), not sending AUTH_PENDIN=
G");
+}
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+
+    const =
struct CMUnitTest tests[] =3D {
+        cmocka_unit_test_setup_teardown(te=
st_auth_pending_sent, auth_pending_setup,
+                                =
        auth_pending_teardown),
+        cmocka_unit_test_setup_teardown(te=
st_auth_pending_info_too_long, auth_pending_setup,
+                       =
                 auth_pending_teardown),
+    };
+
+    return cmocka_run_g=
roup_tests_name("push tests", tests, NULL, NULL);
+}

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7ea=
af2b
Gerrit-Change-Number: 2346
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--aLuiZlzAVjw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83=
zvan Cojocaru <strong>uploaded patch set #3</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">push: check INFO_PRE length before sending =
AUTH_PENDING<br><br>send_auth_pending_messages() sent AUTH_PENDING, then re=
jected an<br>oversized INFO_PRE and returned false=2E The client was left p=
ending<br>with no INFO_PRE, auth_deferred_expire was not set, and the manag=
ement<br>client got an error for a message that had already gone out=2E<br>=
<br>Do the length check before sending anything=2E The check also counted<b=
r>the terminating NUL twice; count it once=2E Log both early returns, as<br=
>callers fail the auth on them=2E<br><br>Add a push unit test driver coveri=
ng both the longest accepted and a<br>too-long INFO_PRE=2E<br><br>Change-Id=
: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b<br>Signed-off-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/open=
vpn/push=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_te=
sts/openvpn/mock_management=2Ec<br>A tests/unit_tests/openvpn/test_push=2Ec=
<br>5 files changed, 398 insertions(+), 8 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/=
2346/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><=
span>index 50b2d68=2E=2E554e117 100644</span><br><span>--- a/CMakeLists=2Et=
xt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -695,6 +695,7 =
@@</span><br><span>         &quot;test_packet_id&quot;</span><br><span>    =
     &quot;test_pkt&quot;</span><br><span>         &quot;test_provider&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;test=
_push&quot;</span><br><span>         &quot;test_socket&quot;</span><br><spa=
n>         &quot;test_ssl&quot;</span><br><span>         &quot;test_user_pa=
ss&quot;</span><br><span>@@ -943,6 +944,16 @@</span><br><span>         src/=
openvpn/run_command=2Ec</span><br><span>         )</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_pu=
sh PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
ests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_management=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/base64=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/options_util=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/otim=
e=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/ssl_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     target_sources(test_push_update_msg PRIVATE</span><br><span>        =
 tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span>         tests/unit_=
tests/openvpn/mock_get_random=2Ec</span><br><span>diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec</span><br><span>index eb11107=2E=2Ebbc4f71 =
100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src=
/openvpn/push=2Ec</span><br><span>@@ -508,11 +508,21 @@</span><br><span>   =
  time_t time_elapsed =3D now - ks-&gt;initial;</span><br><span>     if (ti=
me_elapsed &lt; 0 || time_elapsed &gt;=3D (time_t)max_timeout)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_WARN, &quot;Handshake time elapsed (%ds, max %us), not sending AUTH_PE=
NDING&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     (int)time_elapsed, max_timeout);</span><br><span>         return false=
;</span><br><span>     }</span><br><span>     max_timeout -=3D (unsigned in=
t)time_elapsed;</span><br><span>     timeout =3D min_uint(max_timeout, time=
out);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const size_t info_len =3D strlen(extra) + sizeof(info_pre);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (info_len &gt; PUSH_=
BUNDLE_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &=
quot;INFO_PRE message too long (%zu &gt; %d), not sending AUTH_PENDING&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            info_=
len, PUSH_BUNDLE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     if ((pr=
oto &amp; IV_PROTO_AUTH_PENDING_KW) =3D=3D 0)</span><br><span>     {</span>=
<br><span>@@ -530,14 +540,7 @@</span><br><span>         send_control_channe=
l_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    si=
ze_t len =3D strlen(extra) + 1 + sizeof(info_pre);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (len &gt; PUSH_BUNDLE_SIZE)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct buffer buf =3D alloc_buf_gc(len, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(info_le=
n, &amp;gc);</span><br><span>     buf_printf(&amp;buf, info_pre);</span><br=
><span>     buf_printf(&amp;buf, &quot;%s&quot;, extra);</span><br><span>  =
   send_control_channel_string_dowork(session, BSTR(&amp;buf), D_PUSH);</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>index e3404754=2E=2Eb068028 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><=
br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -1=
8,6 +18,7 @@</span><br><span> 	packet_id_testdriver \</span><br><span> 	pkt=
_testdriver \</span><br><span> 	provider_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	push_testdriver \</span><br><span> 	push=
_update_msg_testdriver \</span><br><span> 	socket_testdriver \</span><br><s=
pan> 	ssl_testdriver \</span><br><span>@@ -413,6 +414,25 @@</span><br><span=
> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+push_testdriver_CFLAGS  =3D \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(t=
op_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+push_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+push_testdriver_SOURCES =3D test_push=2Ec=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_managem=
ent=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=
=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	mock_push_dependencies=2Ec \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/ope=
nvpn/platform=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> push_update_m=
sg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I=
$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tes=
ts/openvpn \</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_man=
agement=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>=
index aea43da=2E=2E18f13569 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/m=
ock_management=2Ec</span><br><span>@@ -42,6 +42,22 @@</span><br><span>     =
ASSERT(false);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_notify(const char *severity, const char *type=
, const char *text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+management_notify_client_cr_response(unsigned mda_key_id, const struct=
 man_def_auth_context *mdac,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                     const struct env_set *es, con=
st char *response)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+management_notify_generic(const char *str)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> char *</span><br><span> management_query_pk_sig(struct management =
*man, const char *b64_data, const char *algorithm)</span><br><span> {</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_push=2Ec b/tests/unit=
_tests/openvpn/test_push=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E4615e91</span><br><span>--- /dev/null</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_push=2Ec</span><br><span>@@ -0,0 +=
1,340 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicatio=
n to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             over a single UDP port, with support for SSL/TL=
S-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   session authentication and key exchange,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet encryption, packet authentica=
tion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;push=2Ec&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Control channel messages sent by the code under =
test */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int s=
ent_count;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* larger=
 than PUSH_BUNDLE_SIZE so an oversized message is not truncated */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static char sent_msgs[2][2 *=
 PUSH_BUNDLE_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string_dowork=
(struct tls_session *session, const char *str,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                   msglvl_t msgl=
evel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (sent_count &lt; (int)SIZ=
E(sent_msgs))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(sent=
_msgs[sent_count], str, sizeof(sent_msgs[0]));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    sent_count++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Remaining dependencies of =
push=2Ec, not reached by these tests */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssl_put_auth_challenge(const char *cr_str)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+verify_crresponse_=
plugin(struct tls_multi *multi, const char *cr_response)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+verify_crresponse_script(struct tls_multi *mul=
ti, const char *cr_response)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+apply_push_options(struct context *c, struct options *options=
, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   uint64_t permission_mask, uint64_t *option_types_found=
, struct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   bool is_update)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int global_auth_retry;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+auth_retry_get(void)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn global_auth_retry;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+do_up(struct context *c, bool pulled_options, uint=
64_t option_types_found)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+do_update(struct context *c, uint64_t option_types_found)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+getaddr(unsigned int fl=
ags, const char *hostname, int resolve_retry_seconds, bool *succeeded,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct signal_in=
fo *sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv=
6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbit=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              msg=
lvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+get_list_intersection(struct gc_arena *gc, const char *list1, cons=
t char *list2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return alloc_buf_gc=
(0, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const char **</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+make_extended_arg_array(char **p, bool is_inline, stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char **argv=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_CL=
EAR_GC(argv, const char *, 1, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return argv;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+md_ctx_cleanup(md_ctx_t *ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_final(md_ctx_t *ct=
x, uint8_t *dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+md_ctx_free(md_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+md_ctx_init(md_ctx_t *ctx, const char *mdname)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_t *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_new(void)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_update(md_ctx_t *=
ctx, const uint8_t *src, size_t src_len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct tls_multi *mul=
ti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc=
_parameters(const char *capabilities, const char *delim, int *max_acc_len, =
bool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              struct gc_arena *gc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_line(const char *line, char *p[], const int n, cons=
t char *file, const int line_num,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+           msglvl_t msglevel, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in6_addr(struct i=
n6_addr addr6, unsigned int flags, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in_addr_t(in_ad=
dr_t addr, unsigned int flags, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+process_push_update(struct conte=
xt *c, struct options *o, uint64_t permission_mask,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    uint64_t *option_type=
s_found, struct buffer *buf, bool msg_sender)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return PUSH_MSG_ERROR;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+register_signal(struct signal_info *s=
i, int sig, const char *text)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+reschedule_multi_process(struct context *c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+sanitize_control_messag=
e(const char *str, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return str;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+schedule_exit(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct cont=
ext *c, const char *str, msglvl_t msglevel)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ssl_clean_auth_token(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ssl_purge_auth(const bool auth_user_pa=
ss_only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+enum tls_auth_status</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tls_authentication_status(struct tls_multi *multi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return TLS_AUTHENTICATION_FAILED;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_peer_su=
pports_ncp(const char *peer_info)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* &quot;INFO_PRE,&quot; + extra + NUL mu=
st fit in PUSH_BUNDLE_SIZE */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define INFO_EXTRA_MAX (PUSH_BUNDLE_SIZE - sizeof(&quot;INFO_PRE,=
&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct auth_pending_ctx</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct tls_multi multi;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct tls_session session;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char extra[PUSH_BUND=
LE_SIZE + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+auth_pending_setup(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct auth_pending_ctx *ctx =3D calloc(1, sizeof(*=
ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;m=
ulti=2Epeer_info =3D &quot;IV_PROTO=3D16\n&quot;; /* IV_PROTO_AUTH_PENDING_=
KW */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;mu=
lti=2Eopt=2Ehandshake_window =3D 60;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ctx-&gt;multi=2Eopt=2Erenegotiate_seconds =3D 3600;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;session=2Ekey[KS_PRIMARY]=2Ei=
nitial =3D now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ctx-&gt;session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire =3D 42;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    sent_count =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CLEAR(sent_msgs);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *state =3D ctx;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+auth_pending_teardown(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    free(*state);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_extra(struct=
 auth_pending_ctx *ctx, size_t len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  memset(ctx-&gt;extra, &#39;x&#39;, len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ctx-&gt;extra[len] =3D &#39;\0&#39;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_auth_pending_sent(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct auth_pending_ctx *ctx =3D *state;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    set_extra(ctx, INFO_EXTRA_MAX);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(send_auth_pending_messages(&amp;ctx-&gt=
;multi, &amp;ctx-&gt;session, ctx-&gt;extra, 120));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(sent_count, 2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(sent_msgs[0], &qu=
ot;AUTH_PENDING,timeout 120&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(strlen(sent_msgs[1]), sizeof(&quot;INF=
O_PRE,&quot;) - 1 + INFO_EXTRA_MAX);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(strprefix(sent_msgs[1], &quot;INFO_PRE,xxx=
&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(ctx-&gt;session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire, now + =
120);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_auth_pending_info_too_long(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct auth_pending_ctx *ctx =3D *state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    set_extra(ctx, INFO_EX=
TRA_MAX + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(send_aut=
h_pending_messages(&amp;ctx-&gt;multi, &amp;ctx-&gt;session, ctx-&gt;extra,=
 120));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing may reach the cl=
ient, not even AUTH_PENDING */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(sent_count, 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(ctx-&gt;session=2Ekey[KS_P=
RIMARY]=2Eauth_deferred_expire, 42);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(mock_msg_buf,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        &quot;INFO_PRE m=
essage too long (1025 &gt; 1024), not sending AUTH_PENDING&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(v=
oid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test_setup_teardown(test_auth_pending_sent, auth_pending_setup,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
          auth_pending_teardown),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test_setup_teardown(test_auth_pending_inf=
o_too_long, auth_pending_setup,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                        auth_pending_teardown),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;push t=
ests&quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">change 2346</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e845250b6e606f=
fb49fa5fe1bfd034be7eaaf2b </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2346 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--aLuiZlzAVjw=--


--===============0006865043155935499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0006865043155935499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0006865043155935499==--


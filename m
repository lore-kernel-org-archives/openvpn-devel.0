Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8F606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IeKuaep5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LZf3sXY0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cD3RSG4h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Sqvsoj1C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vzA5bOP4E4RnfoWn2nEny9yrBiTeidluSBmIcmLL170=; b=IeKuaep5EmPnH94OYutGkqnoOS
	2Dxi33OOQcV+YUv7jS4QH2asrsqohNy8RgqJ2/O1+OPRDsXjmlJDSLk4hnKirLLePmx18ZpmTIVAF
	g2PnmCJJj2u+WfNjmIUbQl/Dtsy4vpHkP95+ZQ8wPQG4BdTAzp2dBy4lkiH2SXQUKyg0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWFrp-000000007bE-2qfJ;
	Wed, 25 Nov 2026 16:29:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWFrm-000000007b6-17JZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:29:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UIx6gybWVTyJnM7uOCpUli11JQcp4vlPrlyrdX9LhSw=; b=LZf3sXY0MNaRLx733/ciDmpV+/
 deAm8YioHnqaQM1Tqk6kEGYgHrybMgHrGZiW3Asg7XrxmnbALN9TB5VKXwoQqt3dwEMYXIEqpUmeF
 6/29r0sdwgIZaT/pL5yvuXna/5qfNfFkhZ2XGbDMb4nj4rw6ixCoampHx7Sw3nv3tSC8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UIx6gybWVTyJnM7uOCpUli11JQcp4vlPrlyrdX9LhSw=; b=cD3RSG4hOXIQka1Vrl7Hj2UMho
 JhTuQY0tPfZ1bO2bdq7WQNLYQTJZNhgqIpGkukOGRf3Taa937iIhnfGMF7e3ftLlqwiZH6wcOAHIX
 HcenTO1y5YlXOhTeu0o2zwNNIB8SqqkJrS7AuICwwdXRCn1tFusLMybatjVromThSMeg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWFri-000000006zS-3c7i for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:29:06 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so46731955e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795624136; x=1796228936; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UIx6gybWVTyJnM7uOCpUli11JQcp4vlPrlyrdX9LhSw=;
 b=Sqvsoj1CEvXd7tXcUSXe4oqCTPcdgiLkH41xYrYKneS3c7Dh7/uOxOY0w8+tjDEzU3
 CTGlhuW5KiLMpoklvlpIKQ/mEg/FrdUNDcR3F5gMsn6EtX8x3gqEmJEvhDrgKY2EUkq8
 XWwLM6ShEO3HvoLJdUlP2jP4UUDCX+ApBi+Akz4pvIIkutjVaiCXClO+hCznJmQzDM1k
 Ku9ULD/uIN6sTwM25357i0NMPJtKTS2xnrPvKRMCxPVQvkgUiyieyS2tcTr4FHJ24FKZ
 clewZ1QsBMfGWHMpVf+D+WZplyEVPDMmx1i6V0+F8b8TcfcvjIUZQLsiqgs1IZZHDyG3
 H3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624136; x=1796228936;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UIx6gybWVTyJnM7uOCpUli11JQcp4vlPrlyrdX9LhSw=;
 b=CiZ9wmuy4YBFDJHDPgJ+/HiFrONwT7W33K8SkdTSKLehU3jiN5cLucJGtqtKLqltcw
 uwfd/kJP7RyNLC9yCK+F55VTBKb3Kxhc9vrKiZLL+hfEALfDofEYuEBhv4QFdM4W4dlB
 teznnPGFSdtu4s+3VdIKCPkfd1M2BSABwYOs+Srjh9lSYj3cBjn9o5Ti99k9xontmmBE
 39nEKLBfR+OlGnhkzk5G73Wdiv4GrJFCNJqtB5K6dYxLJQB/QWDUOrTZCgb+Dqo+KWN1
 FnrVcsYfcvpsRGn4tibhThQpTKvmdX1wjQnncmasC4DMBEXDbDYiVoQUc49PoqwfBcq/
 Fb6Q==
X-Gm-Message-State: APuU4Z+dL32T+Vhy6khPw9mRg7dRStDD71+eqDvFXycc7TbIkS8SIQnm
 2UOtcvVWqhQWljWM8tYsw0Ex5Yi2vEsKWXTsvHpNwWz1HRg1WEcplScIxvDVe81dK005z7H00+X
 7d6o5wlp8QRjo85nIXqMErwYmfFzHo0JsU8CBuyxS2NNGU9/iPXxkWz6Z4vyPHL6clHT0gvqCgJ
 ZhkSGvIA==
X-Gm-Gg: AZFdTZezZ5SXmg6QI3c0ZOM5lsdWpAfE7JWzlYfXNPNEO0VkD9naVjtxLvj2KXSxbck
 lcLTO+s1ZW7IyzqFWsg+UdG3DNy/rWg26iId81YKnDqawZWmF/spwpYlISXXX5nCgVPvlzwxpm6
 fZxZAt8GzPI+eSPp6sNYZdUBSUPm1E3zywWR+FwXzERMWh3h9VAcQPLfRY2nn0UU+tO3PAvOT9J
 9lldqWiCStt/cEbzeZYk0Xo+xMy0Qn4YlYFTAyiaVQpJ4AugWvk6pDjAyfAKq4DMwJRTU5CGEsm
 24xb9z3Cs8qijfuoI1WiPflwiv7T32ejeyKV8U2jjzmCjbaasfVxb5xVNjU73zoRqUTZ70cI8Sd
 6cfzKdIumRKLz7FYo0vll4Y69UAG1/oQ6ICdiYu7HDC8u1LQDf6nESosIJwDZ9iiiVKmC8noB/Z
 dvhGr02wEPP8oto02p8sDcKPkLKJN2u6eeCg5PtxtFyKDv112/qzdJcXsS0I+lubF9q5lQqYr4C
 C1BpJZkwN/ALPv03ska7kt0y5yCL/ZlqFE32bAjw6L8gx/DCS2EmRudlJVny1csuaWKbHUWU6o0
 GYGpSGUbqAeaEwamsICRZUdxX71v8+yNQvhXqLE1K6DggSmzpR8c1rBMlFcznPg/vEDUMZJXZBr
 Cs7v4MZyB3Trisdd+fTda1Yp7oP8MBlDJ6bA+PCzbWKMufmfl06noQHXOUwFcjnJrQ8xp32sZrG
 02r8Zzi1N+zKiSXjk=
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4bb8881d4damr385142095e9.28.1795624135907; 
 Wed, 25 Nov 2026 08:28:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm726301305e9.13.2026.11.25.08.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:28:55 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:28:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
X-Gerrit-Change-Number: 2346
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2346?usp=email>
X-Gerrit-Commit: 347dc16f2c3b30ed94bf0c75562ea6276bf694fa
References: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkkxZTg0NTI1MGI2ZTYwNmZmYjQ5ZmE1ZmUxYmZkMDM0YmU3ZWFhZjJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72476e8d3115f7c1319d76b601df0d3ed79f2ea9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWFri-000000006zS-3c7i
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0875953957830887912=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0875953957830887912==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fPJgP7SmhT0="; charset=UTF-8

--fPJgP7SmhT0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2346?usp=3Demail

to review the following change=2E
=


Change subject: push: check INFO_PRE length before sending AUTH_PENDING
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: check I=
NFO_PRE length before sending AUTH_PENDING

send_auth_pending_messages() se=
nt AUTH_PENDING, then rejected an
oversized INFO_PRE and returned false=2E =
The client was left pending
with no INFO_PRE, auth_deferred_expire was not =
set, and the management
client got an error for a message that had already =
gone out=2E

Do the length check before sending anything=2E The check also =
counted
the terminating NUL twice; count it once=2E Log both early returns,=
 as
callers fail the auth on them=2E

Add a push unit test driver covering =
both the longest accepted and a
too-long INFO_PRE=2E

Change-Id: I1e845250b=
6e606ffb49fa5fe1bfd034be7eaaf2b
Signed-off-by: Razvan Cojocaru <razvanc@mai=
lbox=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/push=2Ec
M tests/unit_test=
s/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_push=2Ec
4 files ch=
anged, 407 insertions(+), 8 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/46/2346/1

diff --git a/CMakeLists=2Etx=
t b/CMakeLists=2Etxt
index 50b2d68=2E=2Ed2abdb8 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -695,6 +695,7 @@
         "test_packet_id"
   =
      "test_pkt"
         "test_provider"
+        "test_push"
         "te=
st_socket"
         "test_ssl"
         "test_user_pass"
@@ -943,6 +944,15 =
@@
         src/openvpn/run_command=2Ec
         )
 
+    target_sources(te=
st_push PRIVATE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+    =
    tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+        src/openvp=
n/base64=2Ec
+        src/openvpn/options_util=2Ec
+        src/openvpn/oti=
me=2Ec
+        src/openvpn/ssl_util=2Ec
+    )
+
     target_sources(test_=
push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg=2Ec
    =
     tests/unit_tests/openvpn/mock_get_random=2Ec
diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec
index eb11107=2E=2Ebbc4f71 100644
--- a/src=
/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -508,11 +508,21 @@
     tim=
e_t time_elapsed =3D now - ks->initial;
     if (time_elapsed < 0 || time_e=
lapsed >=3D (time_t)max_timeout)
     {
+        msg(M_WARN, "Handshake tim=
e elapsed (%ds, max %us), not sending AUTH_PENDING",
+            (int)time=
_elapsed, max_timeout);
         return false;
     }
     max_timeout -=3D=
 (unsigned int)time_elapsed;
     timeout =3D min_uint(max_timeout, timeout=
);
 
+    const size_t info_len =3D strlen(extra) + sizeof(info_pre);
+    =
if (info_len > PUSH_BUNDLE_SIZE)
+    {
+        msg(M_WARN, "INFO_PRE mess=
age too long (%zu > %d), not sending AUTH_PENDING",
+            info_len, =
PUSH_BUNDLE_SIZE);
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
x e3404754=2E=2E70439d4 100644
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
@ -413,6 +414,24 @@
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
+	mock_msg=2E=
c test_common=2Eh \
+	mock_push_dependencies=2Ec \
+	$(top_srcdir)/src/comp=
at/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
+	$(top_sr=
cdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/options_util=2Ec=
 \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openvpn/plat=
form=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
+	$(top_srcdir)/src/o=
penvpn/win32-util=2Ec
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcd=
ir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/un=
it_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/test_push=2Ec b/te=
sts/unit_tests/openvpn/test_push=2Ec
new file mode 100644
index 0000000=2E=
=2E8c4c98b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_push=2Ec
@@ -0=
,0 +1,367 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks
+ *             over a single UDP port, with support for SSL/TLS-based
=
+ *             session authentication and key exchange,
+ *             pa=
cket encryption, packet authentication, and
+ *             packet compress=
ion=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ =
*  This program is free software; you can redistribute it and/or modify
+ *=
  it under the terms of the GNU General Public License version 2
+ *  as pu=
blished by the Free Software Foundation=2E
+ *
+ *  This program is distrib=
uted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; wit=
hout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PAR=
TICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more detail=
s=2E
+ *
+ *  You should have received a copy of the GNU General Public Lic=
ense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lic=
enses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#=
include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#incl=
ude <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <c=
mocka=2Eh>
+
+#include "push=2Ec"
+#include "mock_msg=2Eh"
+#include "test_=
common=2Eh"
+
+/* Control channel messages sent by the code under test */
+=
static int sent_count;
+/* larger than PUSH_BUNDLE_SIZE so an oversized mes=
sage is not truncated */
+static char sent_msgs[2][2 * PUSH_BUNDLE_SIZE];
+=

+bool
+send_control_channel_string_dowork(struct tls_session *session, con=
st char *str,
+                                   msglvl_t msglevel)
+{
+  =
  if (sent_count < (int)SIZE(sent_msgs))
+    {
+        strlcpy(sent_msgs[=
sent_count], str, sizeof(sent_msgs[0]));
+    }
+    sent_count++;
+    ret=
urn true;
+}
+
+/* Remaining dependencies of push=2Ec, not reached by these=
 tests */
+#ifdef ENABLE_MANAGEMENT
+struct management *management =3D NULL=
;
+
+void
+management_auth_failure(const struct management *man, const char=
 *type, const char *reason)
+{
+}
+
+void
+management_notify(const char *se=
verity, const char *type, const char *text)
+{
+}
+
+void
+management_notif=
y_generic(const char *str)
+{
+}
+
+void
+management_notify_client_cr_respo=
nse(unsigned mda_key_id, const struct man_def_auth_context *mdac,
+        =
                             const struct env_set *es, const char *response=
)
+{
+}
+
+void
+management_set_state(struct management *man, const int sta=
te, const char *detail,
+                     const in_addr_t *tun_local_ip=
, const struct in6_addr *tun_local_ip6,
+                     const struct =
openvpn_sockaddr *local_addr,
+                     const struct openvpn_so=
ckaddr *remote_addr)
+{
+}
+
+void
+ssl_put_auth_challenge(const char *cr_s=
tr)
+{
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
+
+#ifdef ENABLE_PLUGIN
+vo=
id
+verify_crresponse_plugin(struct tls_multi *multi, const char *cr_respon=
se)
+{
+}
+#endif
+
+void
+verify_crresponse_script(struct tls_multi *multi=
, const char *cr_response)
+{
+}
+
+bool
+apply_push_options(struct context=
 *c, struct options *options, struct buffer *buf,
+                   uint6=
4_t permission_mask, uint64_t *option_types_found, struct env_set *es,
+   =
                bool is_update)
+{
+    return true;
+}
+
+int
+auth_retry_=
get(void)
+{
+    return 0;
+}
+
+bool
+do_up(struct context *c, bool pulle=
d_options, uint64_t option_types_found)
+{
+    return true;
+}
+
+bool
+do=
_update(struct context *c, uint64_t option_types_found)
+{
+    return true=
;
+}
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int re=
solve_retry_seconds, bool *succeeded,
+        struct signal_info *sig_info=
)
+{
+    return 0;
+}
+
+bool
+get_ipv6_addr(const char *hostname, struct =
in6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel)=

+{
+    return false;
+}
+
+struct buffer
+get_list_intersection(struct gc=
_arena *gc, const char *list1, const char *list2)
+{
+    return alloc_buf_=
gc(0, gc);
+}
+
+const char **
+make_extended_arg_array(char **p, bool is_i=
nline, struct gc_arena *gc)
+{
+    return NULL;
+}
+
+void
+md_ctx_cleanup=
(md_ctx_t *ctx)
+{
+}
+
+void
+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)
+{=

+}
+
+void
+md_ctx_free(md_ctx_t *ctx)
+{
+}
+
+void
+md_ctx_init(md_ctx_t=
 *ctx, const char *mdname)
+{
+}
+
+md_ctx_t *
+md_ctx_new(void)
+{
+    re=
turn NULL;
+}
+
+void
+md_ctx_update(md_ctx_t *ctx, const uint8_t *src, siz=
e_t src_len)
+{
+}
+
+void
+notify_client_acc_protocols(struct tls_multi *m=
ulti)
+{
+}
+
+char *
+parse_acc_parameters(const char *capabilities, const=
 char *delim, int *max_acc_len, bool server,
+                     struct g=
c_arena *gc)
+{
+    return NULL;
+}
+
+int
+parse_line(const char *line, c=
har *p[], const int n, const char *file, const int line_num,
+           ms=
glvl_t msglevel, struct gc_arena *gc)
+{
+    return 0;
+}
+
+const char *
=
+print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc_arena =
*gc)
+{
+    return "";
+}
+
+const char *
+print_in_addr_t(in_addr_t addr,=
 unsigned int flags, struct gc_arena *gc)
+{
+    return "";
+}
+
+int
+pro=
cess_push_update(struct context *c, struct options *o, uint64_t permission_=
mask,
+                    uint64_t *option_types_found, struct buffer *buf=
, bool msg_sender)
+{
+    return PUSH_MSG_ERROR;
+}
+
+void
+register_sign=
al(struct signal_info *si, int sig, const char *text)
+{
+}
+
+void
+resche=
dule_multi_process(struct context *c)
+{
+}
+
+const char *
+sanitize_contr=
ol_message(const char *str, struct gc_arena *gc)
+{
+    return str;
+}
+
+=
bool
+schedule_exit(struct context *c)
+{
+    return true;
+}
+
+bool
+sen=
d_control_channel_string(struct context *c, const char *str, msglvl_t msgle=
vel)
+{
+    return true;
+}
+
+bool
+ssl_clean_auth_token(void)
+{
+    re=
turn false;
+}
+
+void
+ssl_purge_auth(const bool auth_user_pass_only)
+{
+=
}
+
+enum tls_auth_status
+tls_authentication_status(struct tls_multi *mult=
i)
+{
+    return TLS_AUTHENTICATION_FAILED;
+}
+
+bool
+tls_peer_supports_=
ncp(const char *peer_info)
+{
+    return false;
+}
+
+/* "INFO_PRE," + ext=
ra + NUL must fit in PUSH_BUNDLE_SIZE */
+#define INFO_EXTRA_MAX (PUSH_BUND=
LE_SIZE - sizeof("INFO_PRE,"))
+
+struct auth_pending_ctx
+{
+    struct tl=
s_multi multi;
+    struct tls_session session;
+    char extra[PUSH_BUNDLE=
_SIZE + 1];
+};
+
+static int
+auth_pending_setup(void **state)
+{
+    str=
uct auth_pending_ctx *ctx =3D calloc(1, sizeof(*ctx));
+    ctx->multi=2Epe=
er_info =3D "IV_PROTO=3D16\n"; /* IV_PROTO_AUTH_PENDING_KW */
+    ctx->mul=
ti=2Eopt=2Ehandshake_window =3D 60;
+    ctx->multi=2Eopt=2Erenegotiate_sec=
onds =3D 3600;
+
+    now =3D 1000;
+    ctx->session=2Ekey[KS_PRIMARY]=2Ei=
nitial =3D now;
+    ctx->session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire =
=3D 42;
+
+    sent_count =3D 0;
+    CLEAR(sent_msgs);
+    CLEAR(mock_msg=
_buf);
+
+    *state =3D ctx;
+    return 0;
+}
+
+static int
+auth_pending=
_teardown(void **state)
+{
+    free(*state);
+    return 0;
+}
+
+static v=
oid
+set_extra(struct auth_pending_ctx *ctx, size_t len)
+{
+    memset(ctx=
->extra, 'x', len);
+    ctx->extra[len] =3D '\0';
+}
+
+static void
+test_=
auth_pending_sent(void **state)
+{
+    struct auth_pending_ctx *ctx =3D *s=
tate;
+    set_extra(ctx, INFO_EXTRA_MAX);
+
+    assert_true(send_auth_pen=
ding_messages(&ctx->multi, &ctx->session, ctx->extra, 120));
+
+    assert_=
int_equal(sent_count, 2);
+    assert_string_equal(sent_msgs[0], "AUTH_PEND=
ING,timeout 120");
+    assert_int_equal(strlen(sent_msgs[1]), sizeof("INFO=
_PRE,") - 1 + INFO_EXTRA_MAX);
+    assert_true(strprefix(sent_msgs[1], "IN=
FO_PRE,xxx"));
+    assert_int_equal(ctx->session=2Ekey[KS_PRIMARY]=2Eauth_=
deferred_expire, now + 120);
+}
+
+static void
+test_auth_pending_info_too_=
long(void **state)
+{
+    struct auth_pending_ctx *ctx =3D *state;
+    se=
t_extra(ctx, INFO_EXTRA_MAX + 1);
+
+    assert_false(send_auth_pending_mes=
sages(&ctx->multi, &ctx->session, ctx->extra, 120));
+
+    /* nothing may =
reach the client, not even AUTH_PENDING */
+    assert_int_equal(sent_count=
, 0);
+    assert_int_equal(ctx->session=2Ekey[KS_PRIMARY]=2Eauth_deferred_=
expire, 42);
+    assert_string_equal(mock_msg_buf,
+                      =
  "INFO_PRE message too long (1025 > 1024), not sending AUTH_PENDING");
+}
=
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+
+    const struct C=
MUnitTest tests[] =3D {
+        cmocka_unit_test_setup_teardown(test_auth_=
pending_sent, auth_pending_setup,
+                                        =
auth_pending_teardown),
+        cmocka_unit_test_setup_teardown(test_auth_=
pending_info_too_long, auth_pending_setup,
+                               =
         auth_pending_teardown),
+    };
+
+    return cmocka_run_group_tes=
ts_name("push tests", tests, NULL, NULL);
+}

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
Gerr=
it-Change-Number: 2346
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--fPJgP7SmhT0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">push: check INFO_PRE length before sending AUTH_PENDING=
<br><br>send_auth_pending_messages() sent AUTH_PENDING, then rejected an<br=
>oversized INFO_PRE and returned false=2E The client was left pending<br>wi=
th no INFO_PRE, auth_deferred_expire was not set, and the management<br>cli=
ent got an error for a message that had already gone out=2E<br><br>Do the l=
ength check before sending anything=2E The check also counted<br>the termin=
ating NUL twice; count it once=2E Log both early returns, as<br>callers fai=
l the auth on them=2E<br><br>Add a push unit test driver covering both the =
longest accepted and a<br>too-long INFO_PRE=2E<br><br>Change-Id: I1e845250b=
6e606ffb49fa5fe1bfd034be7eaaf2b<br>Signed-off-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/push=2Ec=
<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/=
test_push=2Ec<br>4 files changed, 407 insertions(+), 8 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/46/2346/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etx=
t</span><br><span>index 50b2d68=2E=2Ed2abdb8 100644</span><br><span>--- a/C=
MakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -=
695,6 +695,7 @@</span><br><span>         &quot;test_packet_id&quot;</span><=
br><span>         &quot;test_pkt&quot;</span><br><span>         &quot;test_=
provider&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &quot;test_push&quot;</span><br><span>         &quot;test_socket&quot;</=
span><br><span>         &quot;test_ssl&quot;</span><br><span>         &quot=
;test_user_pass&quot;</span><br><span>@@ -943,6 +944,15 @@</span><br><span>=
         src/openvpn/run_command=2Ec</span><br><span>         )</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_so=
urces(test_push PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_=
push_dependencies=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/base64=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        src/openvpn/options_util=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_util=2Ec</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     target_sources=
(test_push_update_msg PRIVATE</span><br><span>         tests/unit_tests/ope=
nvpn/mock_msg=2Ec</span><br><span>         tests/unit_tests/openvpn/mock_ge=
t_random=2Ec</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvp=
n/push=2Ec</span><br><span>index eb11107=2E=2Ebbc4f71 100644</span><br><spa=
n>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</sp=
an><br><span>@@ -508,11 +508,21 @@</span><br><span>     time_t time_elapsed=
 =3D now - ks-&gt;initial;</span><br><span>     if (time_elapsed &lt; 0 || =
time_elapsed &gt;=3D (time_t)max_timeout)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Hand=
shake time elapsed (%ds, max %us), not sending AUTH_PENDING&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            (int)time_elapse=
d, max_timeout);</span><br><span>         return false;</span><br><span>   =
  }</span><br><span>     max_timeout -=3D (unsigned int)time_elapsed;</span=
><br><span>     timeout =3D min_uint(max_timeout, timeout);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t =
info_len =3D strlen(extra) + sizeof(info_pre);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (info_len &gt; PUSH_BUNDLE_SIZE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;INFO_PRE messag=
e too long (%zu &gt; %d), not sending AUTH_PENDING&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            info_len, PUSH_BUNDLE_SIZ=
E);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span>     if ((proto &amp; IV_PROTO_A=
UTH_PENDING_KW) =3D=3D 0)</span><br><span>     {</span><br><span>@@ -530,14=
 +540,7 @@</span><br><span>         send_control_channel_string_dowork(sess=
ion, BSTR(&amp;buf), D_PUSH);</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strlen(=
extra) + 1 + sizeof(info_pre);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D a=
lloc_buf_gc(len, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(info_len, &amp;gc);</span><br=
><span>     buf_printf(&amp;buf, info_pre);</span><br><span>     buf_printf=
(&amp;buf, &quot;%s&quot;, extra);</span><br><span>     send_control_channe=
l_string_dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam</span><br><span>index e3404754=2E=2E70439d4 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/u=
nit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -18,6 +18,7 @@</span><br=
><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver \</span><b=
r><span> 	provider_testdriver \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	push_testdriver \</span><br><span> 	push_update_msg_testdriver=
 \</span><br><span> 	socket_testdriver \</span><br><span> 	ssl_testdriver \=
</span><br><span>@@ -413,6 +414,24 @@</span><br><span> 	$(top_srcdir)/src/o=
penvpn/siphash_reference=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
session_id=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+push_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat =
-I$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+push_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+push_testdriver_SOURCES =3D test_push=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec test_common=2Eh \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_push_dependencies=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/compat/compat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/options_util=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_u=
til=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_src=
dir)/src/openvpn/win32-util=2Ec</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top=
_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span=
><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_push=2Ec b/tests/unit_tests/openvpn=
/test_push=2Ec</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E8c4c98b</span><br><span>--- /dev/null</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_push=2Ec</span><br><span>@@ -0,0 +1,367 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 =
OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is free software; you can redistribute it and/or modify=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the te=
rms of the GNU General Public License version 2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundatio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed =
in the hope that it will be useful,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more=
 details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;con=
fig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;push=2Ec&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Control channel messages sent by the code under test */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static int sent_count;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* larger than PUSH_BUNDL=
E_SIZE so an oversized message is not truncated */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static char sent_msgs[2][2 * PUSH_BUNDLE_SIZ=
E];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+send_control_channel_string_dowork(struct tls_sess=
ion *session, const char *str,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                   msglvl_t msglevel)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (sent_count &lt; (int)SIZE(sent_msgs))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        strlcpy(sent_msgs[sent_count=
], str, sizeof(sent_msgs[0]));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 sent_count++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Remaining dependencies of push=2Ec, not re=
ached by these tests */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct management *management =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manag=
ement_auth_failure(const struct management *man, const char *type, const ch=
ar *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man=
agement_notify(const char *severity, const char *type, const char *text)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_notify=
_generic(const char *str)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+management_notify_client_cr_response(unsigned mda_key_id, const =
struct man_def_auth_context *mdac,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                     const struct env_set *e=
s, const char *response)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+management_set_state(struct management *man, const int state, con=
st char *detail,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  const in_addr_t *tun_local_ip, const struct in6_addr *tun=
_local_ip6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             const struct openvpn_sockaddr *local_addr,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     const struct openv=
pn_sockaddr *remote_addr)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ssl_put_auth_challenge(const char *cr_str)</span><br><span style=
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
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+auth_retry_get(void)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+do_up(struct context *c, bool pulled_options, uint64_t o=
ption_types_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+do_update(struct context *c, uint64_t option_types_found)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+getaddr(unsigned int flags, c=
onst char *hostname, int resolve_retry_seconds, bool *succeeded,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct signal_info *si=
g_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr=
(const char *hostname, struct in6_addr *network, unsigned int *netbits,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+              msglvl_t =
msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+get_list_intersection(struct gc_arena *gc, const char *list1, const char =
*list2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return alloc_buf_gc(0, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+const char **</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+make_extended_arg_array(char **p, bool is_inline, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_c=
leanup(md_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+md_ctx_free(md_ctx_t *ctx)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_init(md_ctx_t *ctx, co=
nst char *mdname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+md_ctx_t *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+md_ctx_new(void)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc=
_protocols(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities, const=
 char *delim, int *max_acc_len, bool server,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     struct gc_arena *gc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+parse_line(const char *line=
, char *p[], const int n, const char *file, const int line_num,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           msglvl_t msglevel, s=
truct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc=
_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_are=
na *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p=
rocess_push_update(struct context *c, struct options *o, uint64_t permissio=
n_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        uint64_t *option_types_found, struct buffer *buf, bool msg_sender)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return PUSH_MSG_ERROR;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+register=
_signal(struct signal_info *si, int sig, const char *text)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(struct=
 context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+sanitize_control_message(const char *str, struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return str;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_exit(struct c=
ontext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_co=
ntrol_channel_string(struct context *c, const char *str, msglvl_t msglevel)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_clean_auth_to=
ken(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_pur=
ge_auth(const bool auth_user_pass_only)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+enum tls_auth_status</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+tls_authentication_status(struct t=
ls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TLS_AUTHEN=
TICATION_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+tls_peer_supports_ncp(const char *peer_info)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* &quot;INF=
O_PRE,&quot; + extra + NUL must fit in PUSH_BUNDLE_SIZE */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define INFO_EXTRA_MAX (PUSH_BUNDLE_=
SIZE - sizeof(&quot;INFO_PRE,&quot;))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
truct auth_pending_ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_=
multi multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct tls_session session;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char extra[PUSH_BUNDLE_SIZE + 1];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_pending_setup(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct auth_pending_ctx=
 *ctx =3D calloc(1, sizeof(*ctx));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ctx-&gt;multi=2Epeer_info =3D &quot;IV_PROTO=3D16\n&quot=
;; /* IV_PROTO_AUTH_PENDING_KW */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ctx-&gt;multi=2Eopt=2Ehandshake_window =3D 60;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;multi=2Eopt=2Erene=
gotiate_seconds =3D 3600;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1=
000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;ses=
sion=2Ekey[KS_PRIMARY]=2Einitial =3D now;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ctx-&gt;session=2Ekey[KS_PRIMARY]=2Eauth_deferred=
_expire =3D 42;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    sent_count =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(sent_msgs);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    *state =3D ctx;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_pendi=
ng_teardown(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(*st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+set_extra(struct auth_pending_ctx *ctx, size_t len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    memset(ctx-&gt;extra, &#39;x&#39;, len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;extra[len] =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_auth_pending_sent(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct auth_pending_ctx *ctx =3D *state;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_extra(ctx, INFO_E=
XTRA_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(send_auth_pe=
nding_messages(&amp;ctx-&gt;multi, &amp;ctx-&gt;session, ctx-&gt;extra, 120=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(sent_count, 2)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(sent_msgs[0], &quot;AUTH_PENDING,timeout 120&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(strlen(sent_msg=
s[1]), sizeof(&quot;INFO_PRE,&quot;) - 1 + INFO_EXTRA_MAX);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(strprefix(sent_msgs=
[1], &quot;INFO_PRE,xxx&quot;));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(ctx-&gt;session=2Ekey[KS_PRIMARY]=2Eauth_=
deferred_expire, now + 120);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_auth_pending_info_too_long(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct auth_pending_ctx =
*ctx =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 set_extra(ctx, INFO_EXTRA_MAX + 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(send_auth_pending_messages(&amp;ctx-&gt;multi, &amp;ctx-&gt;=
session, ctx-&gt;extra, 120));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* n=
othing may reach the client, not even AUTH_PENDING */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(sent_count, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ctx=
-&gt;session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire, 42);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_bu=
f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       &quot;INFO_PRE message too long (1025 &gt; 1024), not sending AUTH_P=
ENDING&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openv=
pn_unit_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test_setup_teardown(test_auth_pending_sent, auth_p=
ending_setup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                  auth_pending_teardown),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardo=
wn(test_auth_pending_info_too_long, auth_pending_setup,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
 auth_pending_teardown),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group=
_tests_name(&quot;push tests&quot;, tests, NULL, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">change=
 2346</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2346 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--fPJgP7SmhT0=--


--===============0875953957830887912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0875953957830887912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0875953957830887912==--


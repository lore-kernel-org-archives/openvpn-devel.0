Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEE606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lvk8o3I3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q0QFqAcj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X5ojQpEv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=frGX/k3Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=YiFf+LxtpvowcnjBnr72RmIsi2e2tKzihMVLdSnNl0A=; b=Lvk8o3I3oAEyuw9dTZlb1gkIt3
	96dsO6fDEu2fvSxsNyeHlPCTvD+RosVAGbNcRP2AKN8ZMluen2JeXLy89L9/AdLWtE2Zu8X1yxzi3
	Oq/AGjc+IOBSHn2woexdOe2sfBybmXz+0wVd6tZi0ZHyWBdalbdLzqeuP5GExJsPVnSU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSu2J-000000003Vu-1A2s;
	Mon, 16 Nov 2026 10:34:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSu2E-000000003VO-24UF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eh8EpWzuQVYiq+mYSh7eZi3VQuupJUUaVQmFFy2bHJI=; b=Q0QFqAcjaLuhzj/Gc/pMjkn0FN
 gZE3tViBQ5sb+ZR7aIPsiSsNi9YuvWXmc9lawYRoKYrQ3KI+8/FN7YjfhCYXOuDMnYEpEAkHqdI13
 P2TH2t59k2Ku4zUJrvrGnNbu9L5yTCn2A6rXuV16Da56dl22v1Pst3ZSjmOwMqzpWNC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eh8EpWzuQVYiq+mYSh7eZi3VQuupJUUaVQmFFy2bHJI=; b=X5ojQpEv6BAfLPCnZv7Bs2eYxL
 ULvoPVyi//c7EktKdq0nFVU3J6PWVKJjxKy3SLdvM8xyHjXw6KhfGKHuQSSe5TD+O6cuwuNsSgxSo
 iw52Eem4x8a5VLit/Z+ql82yw1T9bwVHy9FPVUvK8HEXQ2DqvZqlREaEYBKndUPid4SA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSu2D-000000003JA-1gks for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:34:02 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so1492955f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 02:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794825235; x=1795430035; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eh8EpWzuQVYiq+mYSh7eZi3VQuupJUUaVQmFFy2bHJI=;
 b=frGX/k3Z/OsNP8oIPI2uRTZQl/fpPyGGGnXt1/TLNA85wU38HJAKoBZ5/685P9h9/B
 SfWxREi/1byvsHug+87sQf0RwRrb6eJoEPaJpK9P4tWCZUihEaW6YPyqzy1KK6sYQq/l
 eE0zEaLdAXRyaU5nHE1rQzNjRpxRIoXgsTrNgmOV1SjyuqhPDm+TjQisg+FjvFn2i6VK
 3AyYVkaq3c+NMpNv6LVYY12/g/G3nXN1McOsRh1Alp2GguLD/6kymwbkoW6sya7ZF8Uf
 vD6wbIIA+41K1IhQYfsIIcfLKYgezyFfjAWNbE48te/nFyS0Tl2J2ERIKZCMqYPCGSqO
 qrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794825235; x=1795430035;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eh8EpWzuQVYiq+mYSh7eZi3VQuupJUUaVQmFFy2bHJI=;
 b=m5GmrOUY1ZjZIoq/xb5Roi38L+FbYQJ4xIxRB4R9bqUqTAlCQKnWVYPQvtqGBp4pf8
 7IRVijTEYKKW68UW17bO/C6swx9+EObxFqLQQbyMdWLNdp9Kc+OWyJ0ziAbtdseFGqTl
 JOg04tdX4IwIbB2MuMpBx8jQlpDBBlaifgiIyAn4LAZnF6KblnwWOmTtbCRTdQRmR7ch
 aSE7ZAAQ4LUv++HvEVDeIgvzbj6ZQuVAmJudbwQ/jZTgpwXQWtYRuaaiMFEO0IiR1Lyo
 p/bcJt0Vw8Q0temwp63emTIfmstAZXAPZ998Lu15OtS3MQTDZoGPOOcbUEcmK2lAIv14
 F59w==
X-Gm-Message-State: APuU4Z8kN6E0WHbhIxMsQpEe4r41gjzvt00yxUF4Vu4ro5t449ksPt8Z
 6uaYiGNHV19iJs0UoyR5M1mi8x9iFwu1Iqvm6+bqtv9O89OddWh4rSlyatDSgITMp8bnUipe3d+
 3N6OITURaE5pMym6sVCeRo2fgsp+E5R8wae4TWesnoQOHCdAd5mi8FN6BKVAqB3QdWVwDgFLEQn
 UGjwYG/Q==
X-Gm-Gg: AZFdTZdm2i4TbQBYIKVinHQ2awcJ8pulb2OFBTIZxBVICxLWKiMZAsrA49j9anc/18F
 w2sgTpQ4xcg9mlkvZxqIId/LNGqs1RWpJcVxHZqBLDh52yECU1j7lfsHj+LAyzv3Xj2mCW4Mp7B
 +x8FsVjG3odfuK/F2WHbF5PlWoDsMob4LdG8AaHghjbq2OSYEJUpRi5u1cIhwL35HSSPI9Rxki7
 Y647azGExID2R/0rMEmVFeomFGqZrUJwJwhHOHet01sMaAFZhzyRuCyZ/0rRDMmRFQoRfN83sxE
 SCUJ7JMmxbWz+jhMSsNCQBmnN216AKIC3yyuUVgZr95eXqnTpM4Zp3Y4HCBcLE4IdVTSVZsdxUZ
 hfanPYx8d6YknPVtgukllvO1s3NQO4XOdpKpRJb2bXs2Pkr8tpGrC2RaKvTDnSNji2H5neiSpMK
 QQbvLaWbFE7i6US+UVcI05xhUDnKzO7hZCk6CufteCcSNJqJFPJ9jyO0IZuKaztSEERQ9/7tRZ/
 W02mvG1S9asvcCfggLpD0JBUqhXK3GZb9EBT9hAwFptbT9yR8sX52DGzjY+3uUmn186xUjk/4s/
 k6PbF310nCaNzTuP7BamgjITajBVo+gjrdkKcffPzBgx3WsV6DlUFiALl4sK8Biff+uSi+KM25Q
 00JC0JSscQIWMiFxpDhiyLwCgr8DeXnplC7WpqhKr7fjmAc48MIhHueT5TOOi/oWoHxNDMCoa/3
 0+cJ9vYgOoNCat198=
X-Received: by 2002:a05:6000:490a:b0:487:1662:cf4c with SMTP id
 ffacd0b85a97d-49c6dc01394mr21120161f8f.7.1794825234504; 
 Mon, 16 Nov 2026 02:33:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f77fc47sm21578458f8f.22.2026.11.16.02.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:33:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 10:33:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
X-Gerrit-Change-Number: 2188
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2188?usp=email>
X-Gerrit-Commit: 6b7b1d11b70f4cc74e7d99f234b086ab1e08535b
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI1MjMyMDAwLkkxNGFkNGU0NTExYmQ5OTMzYjg5ZjQ4YWU1YTNhYzZkMmE1ZTBmMmQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c05fd5b7c5cea0d864e6c0aa44789ec71e7184f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSu2D-000000003JA-1gks
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: check
 for a leading non-option in the startup data
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
Content-Type: multipart/mixed; boundary="===============3749735089843952817=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3749735089843952817==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3OIavErc81M="; charset=UTF-8

--3OIavErc81M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2188?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: check for a leading non-option in the startu=
p data
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: check for a leading non-option in the startup data

Check sud=2Eop=
tions directly before doing any other work, instead of
building the openvpn=
=2Eexe command line and parsing it back=2E This also
rejects empty options=
=2E

Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec=

M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 10 in=
sertions(+), 46 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/88/2188/1

diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index f9a2c970=2E=2E342e4d7 100644
-=
-- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
=
@@ -354,29 +354,6 @@
     ReturnError(pipe, GetLastError(), func, 1, &exit_=
event);
 }
 
-/**
- * Check whether the user options start with a non-optio=
n
- *
- * openvpn=2Eexe takes a lone argument as the config file only when =
there are
- * no other arguments, and takes non-options after the --msg-cha=
nnel handle
- * as its extra parameters=2E
- *
- * @param  cmdline  openvpn=
=2Eexe command line built by the service
- *
- * @return BOOL to indicate i=
f the first user argument is not an option
- */
-static BOOL
-StartsWithNon=
Option(const WCHAR *cmdline)
-{
-    int argc;
-    WCHAR **argv =3D Comman=
dLineToArgvW(cmdline, &argc);
-    /* "openvpn --msg-channel <handle> <arg>=
=2E=2E=2E" */
-    BOOL ret =3D argv && argc > 3 && !IsOption(argv[3]);
-
-=
    LocalFree(argv);
-    return ret;
-}
-
 /*
  * Validate options against=
 a white list=2E Also check the config_file is
  * inside the config_dir=2E=
 The white list is defined in validate=2Ec
@@ -3614,6 +3591,16 @@
         =
goto out;
     }
 
+    /* openvpn=2Eexe takes non-options after the --msg-=
channel handle the
+     * service prepends as its extra parameters, not as=
 the config file */
+    if (!IsOption(sud=2Eoptions + wcsspn(sud=2Eoptions=
, L" \t")))
+    {
+        ReturnError(pipe, ERROR_STARTUP_DATA,
+        =
            L"Options must start with an option, pass the config file with =
--config", 1,
+                    &exit_event);
+        goto out;
+    }
=
+
     if (!InitializeSecurityDescriptor(&ovpn_sd, SECURITY_DESCRIPTOR_REVI=
SION))
     {
         ReturnLastError(pipe, L"InitializeSecurityDescriptor=
");
@@ -3858,14 +3845,6 @@
     swprintf(cmdline, cmdline_size, L"openvpn -=
-msg-channel %" PRIuPTR L" %ls",
              (uintptr_t)svc_pipe, sud=2Eo=
ptions);
 
-    if (StartsWithNonOption(cmdline))
-    {
-        ReturnErr=
or(pipe, ERROR_STARTUP_DATA,
-                    L"Options must start with=
 an option, pass the config file with --config", 1,
-                    &e=
xit_event);
-        goto out;
-    }
-
     /*
      * Only authorized use=
rs are allowed to use any command line options or
      * have the config f=
ile in locations other than the global config directory=2E
diff --git a/tes=
ts/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnse=
rv/test_openvpnserv=2Ec
index 7db61f7=2E=2E6ad285f 100644
--- a/tests/unit_=
tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit_tests/openvpnserv/t=
est_openvpnserv=2Ec
@@ -302,20 +302,6 @@
 }
 
 static void
-test_starts_wit=
h_non_option(void **state)
-{
-    assert_true(StartsWithNonOption(L"openvp=
n --msg-channel 1 foo=2Eovpn"));
-    assert_true(StartsWithNonOption(L"ope=
nvpn --msg-channel 1 \"my vpn=2Eovpn\""));
-    assert_true(StartsWithNonOp=
tion(L"openvpn --msg-channel 1 foo=2Eovpn --verb 3"));
-    assert_true(Sta=
rtsWithNonOption(L"openvpn --msg-channel 1 foo=2Eovpn bar"));
-    assert_t=
rue(StartsWithNonOption(L"openvpn --msg-channel 1 \"\""));
-
-    assert_fa=
lse(StartsWithNonOption(L"openvpn --msg-channel 1 "));
-    assert_false(St=
artsWithNonOption(L"openvpn --msg-channel 1 --persist-tun"));
-    assert_f=
alse(StartsWithNonOption(L"openvpn --msg-channel 1 --config foo=2Eovpn"));
=
-}
-
-static void
 test_validate_lone_option(void **state)
 {
     WCHAR er=
rmsg[512];
@@ -338,7 +324,6 @@
         cmocka_unit_test(test_append_search=
_list),
         cmocka_unit_test(test_remove_search_list_tokens),
        =
 cmocka_unit_test(test_merge_openvpn_environment),
-        cmocka_unit_tes=
t(test_starts_with_non_option),
         cmocka_unit_test(test_validate_lon=
e_option),
     };
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2188?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Gerrit-Change-Number: 2188
Ge=
rrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>

--3OIavErc81M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: check for a leading non-option in the star=
tup data<br><br>Check sud=2Eoptions directly before doing any other work, i=
nstead of<br>building the openvpn=2Eexe command line and parsing it back=2E=
 This also<br>rejects empty options=2E<br><br>Change-Id: I14ad4e4511bd9933b=
89f48ae5a3ac6d2a5e0f2d8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_te=
sts/openvpnserv/test_openvpnserv=2Ec<br>2 files changed, 10 insertions(+), =
46 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/88/2188/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>ind=
ex f9a2c970=2E=2E342e4d7 100644</span><br><span>--- a/src/openvpnserv/inter=
active=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br>=
<span>@@ -354,29 +354,6 @@</span><br><span>     ReturnError(pipe, GetLastEr=
ror(), func, 1, &amp;exit_event);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Check whether the user options start wit=
h a non-option</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * openvpn=2Eexe takes a l=
one argument as the config file only when there are</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * no other arguments, and takes non-option=
s after the --msg-channel handle</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * as its extra parameters=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param  cmdline  openvpn=2Eexe command line built by the service</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @return BOOL to indicate if the first user ar=
gument is not an option</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static BOOL</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-StartsWithNonOption(const =
WCHAR *cmdline)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int argc;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    WCHAR **argv =3D CommandLineTo=
ArgvW(cmdline, &amp;argc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* &quot;openvpn --msg-channel &lt;handle&gt; &lt;arg&gt;=2E=2E=2E=
&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BOOL ret=
 =3D argv &amp;&amp; argc &gt; 3 &amp;&amp; !IsOption(argv[3]);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    LocalFree(argv);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /*</span><br><span>  * Validate options against a white list=2E=
 Also check the config_file is</span><br><span>  * inside the config_dir=2E=
 The white list is defined in validate=2Ec</span><br><span>@@ -3614,6 +3591=
,16 @@</span><br><span>         goto out;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* openv=
pn=2Eexe takes non-options after the --msg-channel handle the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * service prepends as its ex=
tra parameters, not as the config file */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!IsOption(sud=2Eoptions + wcsspn(sud=2Eoption=
s, L&quot; \t&quot;)))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Ret=
urnError(pipe, ERROR_STARTUP_DATA,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    L&quot;Options must start with an option=
, pass the config file with --config&quot;, 1,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    &amp;exit_event);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     if (!InitializeSecurityD=
escriptor(&amp;ovpn_sd, SECURITY_DESCRIPTOR_REVISION))</span><br><span>    =
 {</span><br><span>         ReturnLastError(pipe, L&quot;InitializeSecurity=
Descriptor&quot;);</span><br><span>@@ -3858,14 +3845,6 @@</span><br><span> =
    swprintf(cmdline, cmdline_size, L&quot;openvpn --msg-channel %&quot; PR=
IuPTR L&quot; %ls&quot;,</span><br><span>              (uintptr_t)svc_pipe,=
 sud=2Eoptions);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (StartsWithNonOption(cmdline))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ReturnError(pipe, ERROR_STARTUP_DATA,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    L&quot;Options mus=
t start with an option, pass the config file with --config&quot;, 1,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    &amp;exi=
t_event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto=
 out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><=
br><span>      * Only authorized users are allowed to use any command line =
options or</span><br><span>      * have the config file in locations other =
than the global config directory=2E</span><br><span>diff --git a/tests/unit=
_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test=
_openvpnserv=2Ec</span><br><span>index 7db61f7=2E=2E6ad285f 100644</span><b=
r><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><spa=
n>@@ -302,20 +302,6 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_sta=
rts_with_non_option(void **state)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt_true(StartsWithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn&quot;=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(St=
artsWithNonOption(L&quot;openvpn --msg-channel 1 \&quot;my vpn=2Eovpn\&quot=
;&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
true(StartsWithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn --verb 3=
&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_t=
rue(StartsWithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn bar&quot;=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(St=
artsWithNonOption(L&quot;openvpn --msg-channel 1 \&quot;\&quot;&quot;));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_false(StartsWithNonOption(L&quot=
;openvpn --msg-channel 1 &quot;));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_false(StartsWithNonOption(L&quot;openvpn --msg-chan=
nel 1 --persist-tun&quot;));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    assert_false(StartsWithNonOption(L&quot;openvpn --msg-channel 1 =
--config foo=2Eovpn&quot;));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span> test_=
validate_lone_option(void **state)</span><br><span> {</span><br><span>     =
WCHAR errmsg[512];</span><br><span>@@ -338,7 +324,6 @@</span><br><span>    =
     cmocka_unit_test(test_append_search_list),</span><br><span>         cm=
ocka_unit_test(test_remove_search_list_tokens),</span><br><span>         cm=
ocka_unit_test(test_merge_openvpn_environment),</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_starts_with_non_opt=
ion),</span><br><span>         cmocka_unit_test(test_validate_lone_option),=
</span><br><span>     };</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">change 2188</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I14ad4e=
4511bd9933b89f48ae5a3ac6d2a5e0f2d8 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2188 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--3OIavErc81M=--


--===============3749735089843952817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3749735089843952817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3749735089843952817==--


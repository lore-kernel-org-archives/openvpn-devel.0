Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E17606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RLX9CSwI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ke0Dywq5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fAe5YJ9C;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JoQLqiGg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Uc5Tnx+eK41g5o6DPniPDWv4MCR3AHh/6PdX2sCvNBI=; b=RLX9CSwIPCYI/DkuvMYDoyPkhL
	K53gVMsSBL4J16hqyl1uRdj5bKGhnzx4NNYQrZUicKEEK9hhkPvtjmJNFSw/EkLGPmqhodoM9ZU/s
	yzpTM1bvkoIzGLIHo2XSEB/eeCQQrcdJE5bZgCGBr/M/5/+bD4DNfknr5vJV9dV/h4Q4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGJM-00000000677-1df1;
	Wed, 25 Nov 2026 16:57:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGIz-0000000065R-41N9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=COYYaPcA8nTSnQLRNwcQunsWi8CMurPB/Gfu38hY6uc=; b=ke0Dywq5A7w9AnueWNbiks+jof
 AuQj/1usJWwKp6aSKdz/f4jGThXQHYFORlvYnkj/XnaRp4xY7QCJw10aOEzYWLAHTdh/yoqKGi2Fw
 rrNioZrLXHAJ7oCZIbkdrCdoiXFPGvdMlGGlaQsWboY/N1Vikw/iDv7s6aePPLIGdFhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=COYYaPcA8nTSnQLRNwcQunsWi8CMurPB/Gfu38hY6uc=; b=fAe5YJ9CGp6rTOth3RjLrqwh4g
 LWjFl5yf5K+vKvRuA2L5WgwUoBeyNSgGbOsk/Nj/NJMVVAduGcjbZCiQXhT2rNzCC2WFQkpyX9mk/
 iqJsjc/t4lPE/USSh8lw1Mo+ftOoqnxwqm6Q+XiyrktdTC74Ze8Ax+Be95zdNnZM13Wk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGIm-0000000053J-19w7 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:57:03 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso5314401f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795625814; x=1796230614; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=COYYaPcA8nTSnQLRNwcQunsWi8CMurPB/Gfu38hY6uc=;
 b=JoQLqiGgDtgKek8XtlpjRpvIuM0ctuhJX2BUMnBcvCtOCRYohj4AQwPdKsqMqR6Kup
 UJNSe/Ubkn1tTdeCOiYAYv0UQaWRwUNHitwYmjWEw8hgUHyLVDprfGh6ws9B4btY5R5/
 Nh3pP8vRAsfXMFgj5pTc3nDQojk/SiTVBapawzq8TkNkldGYwZww5AC3qlYagkXg9Add
 QKXkD59g345FZpVyf+Wv4IUQvdMlx4RQNEPwERxvnlrgnPcWPw2qgjYEozVQyX03mxH/
 1dLySuQ921dcH+4NGTGTc6O3zgCOECRvdOhc/AoekDDA0506eZyYnkd9z9SZM886TyTr
 D18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795625814; x=1796230614;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=COYYaPcA8nTSnQLRNwcQunsWi8CMurPB/Gfu38hY6uc=;
 b=lVprj5VT5cb4QUrM+8NQaQenDz9zPLNA85fuQwEIUZBPGy9tLpKNAAOWYtWJDyiSiu
 IOZeVivNedn2iD1AyoGPSCUQqrlfjVo3XH8IjjrCAAalgpoCNpv7NZV2Bsa4vc1UgzgM
 WbZcIdxjdbyEamIy2MRN4b2gZn86D0NJsJKFd5nced2jOlS2ggLa6dEmszPyiP98X6Fs
 77RLwcRYbOdLvfef8b1kA3GvQoIiiqcw3y4cCut+1jhHgxSy/AC16KrWkiDMORT+8wLu
 XjuV57d9GRszEFFVhBlRuJ/Mr0JsCv3Qj5k40f9olNLeLex2nxsJv/OxPsqPNM0SYDDS
 gHRg==
X-Gm-Message-State: APuU4Z+Qsc/59ummhIsSKv6QQsLAh/KPEXjw81bQ1ODBtG4dpxKDSDDz
 9Ppfn3pnkL0HYX8/+7uepor+zJrZocwxRsQdnqR9NC0CqLBW1y8vU0NhcAi220RS2YDmKncnf5C
 7pcQSGMwnV1NW4TDiz4LFf1yl2/otRgB+Kk9CWI/a/15k/3ujdlddFZaKPQcMopTwk583
X-Gm-Gg: AZFdTZco8BSdr4Kx1WHWgUZ2b56xciw8bSy1P1LpjTeBuFObez7DwNkrXoU7salxZca
 wprtmMIr891U5gRIMxoX288ZZJN7H0ph5CgagO1PsEhNvnId6+81Wi1wC0ZRWmYidWItuEPGYXq
 GktAE7RMf553a8ef3xonmTmao8fvSRZaR1beoCd5ntO5IvU7BRI0rwza+vjDV/usfZ9BLbfWkaN
 84Jil17cbES4Zv7oBh8uLuWFuXfNQ2j6bxShda4MUrnj/JQjs8F3grp1/yjVYMUha7tWw+TucFg
 vNFWWZDfFBKscjyZxj+uB0JDgW+eSS2Wc6ZaXIrMtE0qXMGQ+Pboos3nVwS0qwSNfrefV0OcD2C
 jY5uG9iimr/l2skuIF4Ln6QNFDadj+GrCLwnm2bPsd/YVWt4V2uhv0XVb9JyQBpnFFP5FGXw7Mr
 LnLNAdaI1VSc26XieIt2wMb3Oh8vRzmMbm7kst6CsKoeL0MwE3Xt9JzRRzxfmrocQ4/SSafFA0N
 FK2MHHhXnEDrAoa+syOlXQyI1t7dbg4GIfdWiP98CwJOzHbXIYzov3FV2lFx/BaEYhDbJOw+83L
 gfkQ9pgNKb0WSMR8tiHAAMHgWGXcQC2z/m2Iom6DQfKCMo0AbWt8Xhre5P+sD5rd2qTT0vgk7cS
 Mfzu5xn8TR1BPoPinnD24YhuccNdLvkMixSMybg0Mw74TsHjUBdRLG3zBOfoGPEO69nWSOcdZnB
 YSMjJEDHtXkCegLj41aQekbZCQnFPc7yekua2g
X-Received: by 2002:a05:6000:2997:20b0:4aa:d196:f325 with SMTP id
 ffacd0b85a97d-4abb7f2ee9dmr25442324f8f.40.1795625813336; 
 Wed, 25 Nov 2026 08:56:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm36908685f8f.8.2026.11.25.08.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:56:52 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:56:52 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
X-Gerrit-Change-Number: 2346
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2346?usp=email>
X-Gerrit-Commit: be39ee88f0b5b257659577c5d1b5a2da9e8712be
In-Reply-To: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
References: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkkxZTg0NTI1MGI2ZTYwNmZmYjQ5ZmE1ZmUxYmZkMDM0YmU3ZWFhZjJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9b725a368f4ff7273ae401d1c5ab456abba632b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWGIm-0000000053J-19w7
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
Content-Type: multipart/mixed; boundary="===============1591504869701625157=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1591504869701625157==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="quq9MmDmreM="; charset=UTF-8

--quq9MmDmreM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=
=3Demail

to look at the new patch set (#2)=2E

The following approvals got=
 outdated and were removed:
Code-Review-1 by Frank Lichtenheld


Change sub=
ject: push: check INFO_PRE length before sending AUTH_PENDING
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: check INFO_PRE leng=
th before sending AUTH_PENDING

send_auth_pending_messages() sent AUTH_PEND=
ING, then rejected an
oversized INFO_PRE and returned false=2E The client w=
as left pending
with no INFO_PRE, auth_deferred_expire was not set, and the=
 management
client got an error for a message that had already gone out=2E
=

Do the length check before sending anything=2E The check also counted
the =
terminating NUL twice; count it once=2E Log both early returns, as
callers =
fail the auth on them=2E

Add a push unit test driver covering both the lon=
gest accepted and a
too-long INFO_PRE=2E

Change-Id: I1e845250b6e606ffb49fa=
5fe1bfd034be7eaaf2b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
=
---
M CMakeLists=2Etxt
M src/openvpn/push=2Ec
M tests/unit_tests/openvpn/Ma=
kefile=2Eam
A tests/unit_tests/openvpn/test_push=2Ec
4 files changed, 394 i=
nsertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/46/2346/2

diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt
index 50b2d68=2E=2E554e117 100644
--- a/CMakeLists=2Etxt
+++ b/CMak=
eLists=2Etxt
@@ -695,6 +695,7 @@
         "test_packet_id"
         "test_p=
kt"
         "test_provider"
+        "test_push"
         "test_socket"
  =
       "test_ssl"
         "test_user_pass"
@@ -943,6 +944,16 @@
         s=
rc/openvpn/run_command=2Ec
         )
 
+    target_sources(test_push PRIVA=
TE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+        tests/uni=
t_tests/openvpn/mock_management=2Ec
+        tests/unit_tests/openvpn/mock_=
push_dependencies=2Ec
+        src/openvpn/base64=2Ec
+        src/openvpn/=
options_util=2Ec
+        src/openvpn/otime=2Ec
+        src/openvpn/ssl_ut=
il=2Ec
+    )
+
     target_sources(test_push_update_msg PRIVATE
         t=
ests/unit_tests/openvpn/mock_msg=2Ec
         tests/unit_tests/openvpn/mock=
_get_random=2Ec
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
in=
dex eb11107=2E=2Ebbc4f71 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvp=
n/push=2Ec
@@ -508,11 +508,21 @@
     time_t time_elapsed =3D now - ks->ini=
tial;
     if (time_elapsed < 0 || time_elapsed >=3D (time_t)max_timeout)
 =
    {
+        msg(M_WARN, "Handshake time elapsed (%ds, max %us), not send=
ing AUTH_PENDING",
+            (int)time_elapsed, max_timeout);
         r=
eturn false;
     }
     max_timeout -=3D (unsigned int)time_elapsed;
     =
timeout =3D min_uint(max_timeout, timeout);
 
+    const size_t info_len =
=3D strlen(extra) + sizeof(info_pre);
+    if (info_len > PUSH_BUNDLE_SIZE)=

+    {
+        msg(M_WARN, "INFO_PRE message too long (%zu > %d), not sen=
ding AUTH_PENDING",
+            info_len, PUSH_BUNDLE_SIZE);
+        retu=
rn false;
+    }
+
     struct gc_arena gc =3D gc_new();
     if ((proto & =
IV_PROTO_AUTH_PENDING_KW) =3D=3D 0)
     {
@@ -530,14 +540,7 @@
         se=
nd_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
     }
 
-  =
  size_t len =3D strlen(extra) + 1 + sizeof(info_pre);
-    if (len > PUSH_=
BUNDLE_SIZE)
-    {
-        gc_free(&gc);
-        return false;
-    }
-
=
-    struct buffer buf =3D alloc_buf_gc(len, &gc);
+    struct buffer buf =
=3D alloc_buf_gc(info_len, &gc);
     buf_printf(&buf, info_pre);
     buf_=
printf(&buf, "%s", extra);
     send_control_channel_string_dowork(session,=
 BSTR(&buf), D_PUSH);
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam
index e3404754=2E=2Eb068028 100644
=
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn=
/Makefile=2Eam
@@ -18,6 +18,7 @@
 	packet_id_testdriver \
 	pkt_testdriver =
\
 	provider_testdriver \
+	push_testdriver \
 	push_update_msg_testdriver =
\
 	socket_testdriver \
 	ssl_testdriver \
@@ -413,6 +414,25 @@
 	$(top_src=
dir)/src/openvpn/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/sessio=
n_id=2Ec
 
+push_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top=
_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+push_tes=
tdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+push_testdriver_SOURCES =3D test_push=
=2Ec \
+	mock_get_random=2Ec \
+	mock_management=2Ec \
+	mock_msg=2Ec test_=
common=2Eh \
+	mock_push_dependencies=2Ec \
+	$(top_srcdir)/src/compat/comp=
at-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
+	$(top_srcdir)/s=
rc/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/options_util=2Ec \
+	$(=
top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2E=
c \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
+	$(top_srcdir)/src/openvpn/=
win32-util=2Ec
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src=
/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_test=
s/openvpn \
diff --git a/tests/unit_tests/openvpn/test_push=2Ec b/tests/uni=
t_tests/openvpn/test_push=2Ec
new file mode 100644
index 0000000=2E=2E728be=
bd
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_push=2Ec
@@ -0,0 +1,35=
2 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ * =
            over a single UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This =
program is free software; you can redistribute it and/or modify
+ *  it und=
er the terms of the GNU General Public License version 2
+ *  as published =
by the Free Software Foundation=2E
+ *
+ *  This program is distributed in =
the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *=

+ *  You should have received a copy of the GNU General Public License alo=
ng
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <st=
darg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=
=2Eh>
+
+#include "push=2Ec"
+#include "mock_msg=2Eh"
+#include "test_commo=
n=2Eh"
+
+/* Control channel messages sent by the code under test */
+stati=
c int sent_count;
+/* larger than PUSH_BUNDLE_SIZE so an oversized message =
is not truncated */
+static char sent_msgs[2][2 * PUSH_BUNDLE_SIZE];
+
+boo=
l
+send_control_channel_string_dowork(struct tls_session *session, const ch=
ar *str,
+                                   msglvl_t msglevel)
+{
+    if =
(sent_count < (int)SIZE(sent_msgs))
+    {
+        strlcpy(sent_msgs[sent_=
count], str, sizeof(sent_msgs[0]));
+    }
+    sent_count++;
+    return t=
rue;
+}
+
+/* Remaining dependencies of push=2Ec, not reached by these test=
s */
+#ifdef ENABLE_MANAGEMENT
+void
+management_notify(const char *severit=
y, const char *type, const char *text)
+{
+}
+
+void
+management_notify_gen=
eric(const char *str)
+{
+}
+
+void
+management_notify_client_cr_response(u=
nsigned mda_key_id, const struct man_def_auth_context *mdac,
+             =
                        const struct env_set *es, const char *response)
+{
=
+}
+
+void
+ssl_put_auth_challenge(const char *cr_str)
+{
+}
+#endif /* ifd=
ef ENABLE_MANAGEMENT */
+
+#ifdef ENABLE_PLUGIN
+void
+verify_crresponse_pl=
ugin(struct tls_multi *multi, const char *cr_response)
+{
+}
+#endif
+
+voi=
d
+verify_crresponse_script(struct tls_multi *multi, const char *cr_respons=
e)
+{
+}
+
+bool
+apply_push_options(struct context *c, struct options *opt=
ions, struct buffer *buf,
+                   uint64_t permission_mask, uin=
t64_t *option_types_found, struct env_set *es,
+                   bool is_=
update)
+{
+    return true;
+}
+
+int
+auth_retry_get(void)
+{
+    return=
 0;
+}
+
+bool
+do_up(struct context *c, bool pulled_options, uint64_t opti=
on_types_found)
+{
+    return true;
+}
+
+bool
+do_update(struct context *=
c, uint64_t option_types_found)
+{
+    return true;
+}
+
+in_addr_t
+getad=
dr(unsigned int flags, const char *hostname, int resolve_retry_seconds, boo=
l *succeeded,
+        struct signal_info *sig_info)
+{
+    return 0;
+}
+=

+bool
+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsig=
ned int *netbits,
+              msglvl_t msglevel)
+{
+    return false;
+=
}
+
+struct buffer
+get_list_intersection(struct gc_arena *gc, const char *=
list1, const char *list2)
+{
+    return alloc_buf_gc(0, gc);
+}
+
+const c=
har **
+make_extended_arg_array(char **p, bool is_inline, struct gc_arena *=
gc)
+{
+    return NULL;
+}
+
+void
+md_ctx_cleanup(md_ctx_t *ctx)
+{
+}
+
=
+void
+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)
+{
+}
+
+void
+md_ctx_free=
(md_ctx_t *ctx)
+{
+}
+
+void
+md_ctx_init(md_ctx_t *ctx, const char *mdnam=
e)
+{
+}
+
+md_ctx_t *
+md_ctx_new(void)
+{
+    return NULL;
+}
+
+void
+m=
d_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len)
+{
+}
+
+vo=
id
+notify_client_acc_protocols(struct tls_multi *multi)
+{
+}
+
+char *
+p=
arse_acc_parameters(const char *capabilities, const char *delim, int *max_a=
cc_len, bool server,
+                     struct gc_arena *gc)
+{
+    ret=
urn NULL;
+}
+
+int
+parse_line(const char *line, char *p[], const int n, c=
onst char *file, const int line_num,
+           msglvl_t msglevel, struct =
gc_arena *gc)
+{
+    return 0;
+}
+
+const char *
+print_in6_addr(struct i=
n6_addr addr6, unsigned int flags, struct gc_arena *gc)
+{
+    return "";
=
+}
+
+const char *
+print_in_addr_t(in_addr_t addr, unsigned int flags, str=
uct gc_arena *gc)
+{
+    return "";
+}
+
+int
+process_push_update(struct =
context *c, struct options *o, uint64_t permission_mask,
+                 =
   uint64_t *option_types_found, struct buffer *buf, bool msg_sender)
+{
+ =
   return PUSH_MSG_ERROR;
+}
+
+void
+register_signal(struct signal_info *s=
i, int sig, const char *text)
+{
+}
+
+void
+reschedule_multi_process(struc=
t context *c)
+{
+}
+
+const char *
+sanitize_control_message(const char *s=
tr, struct gc_arena *gc)
+{
+    return str;
+}
+
+bool
+schedule_exit(stru=
ct context *c)
+{
+    return true;
+}
+
+bool
+send_control_channel_string=
(struct context *c, const char *str, msglvl_t msglevel)
+{
+    return true=
;
+}
+
+bool
+ssl_clean_auth_token(void)
+{
+    return false;
+}
+
+void
+=
ssl_purge_auth(const bool auth_user_pass_only)
+{
+}
+
+enum tls_auth_statu=
s
+tls_authentication_status(struct tls_multi *multi)
+{
+    return TLS_AU=
THENTICATION_FAILED;
+}
+
+bool
+tls_peer_supports_ncp(const char *peer_inf=
o)
+{
+    return false;
+}
+
+/* "INFO_PRE," + extra + NUL must fit in PUS=
H_BUNDLE_SIZE */
+#define INFO_EXTRA_MAX (PUSH_BUNDLE_SIZE - sizeof("INFO_P=
RE,"))
+
+struct auth_pending_ctx
+{
+    struct tls_multi multi;
+    stru=
ct tls_session session;
+    char extra[PUSH_BUNDLE_SIZE + 1];
+};
+
+stati=
c int
+auth_pending_setup(void **state)
+{
+    struct auth_pending_ctx *ct=
x =3D calloc(1, sizeof(*ctx));
+    ctx->multi=2Epeer_info =3D "IV_PROTO=3D=
16\n"; /* IV_PROTO_AUTH_PENDING_KW */
+    ctx->multi=2Eopt=2Ehandshake_win=
dow =3D 60;
+    ctx->multi=2Eopt=2Erenegotiate_seconds =3D 3600;
+
+    no=
w =3D 1000;
+    ctx->session=2Ekey[KS_PRIMARY]=2Einitial =3D now;
+    ctx=
->session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire =3D 42;
+
+    sent_coun=
t =3D 0;
+    CLEAR(sent_msgs);
+    CLEAR(mock_msg_buf);
+
+    *state =3D=
 ctx;
+    return 0;
+}
+
+static int
+auth_pending_teardown(void **state)
=
+{
+    free(*state);
+    return 0;
+}
+
+static void
+set_extra(struct au=
th_pending_ctx *ctx, size_t len)
+{
+    memset(ctx->extra, 'x', len);
+   =
 ctx->extra[len] =3D '\0';
+}
+
+static void
+test_auth_pending_sent(void *=
*state)
+{
+    struct auth_pending_ctx *ctx =3D *state;
+    set_extra(ctx=
, INFO_EXTRA_MAX);
+
+    assert_true(send_auth_pending_messages(&ctx->mult=
i, &ctx->session, ctx->extra, 120));
+
+    assert_int_equal(sent_count, 2)=
;
+    assert_string_equal(sent_msgs[0], "AUTH_PENDING,timeout 120");
+    =
assert_int_equal(strlen(sent_msgs[1]), sizeof("INFO_PRE,") - 1 + INFO_EXTRA=
_MAX);
+    assert_true(strprefix(sent_msgs[1], "INFO_PRE,xxx"));
+    asse=
rt_int_equal(ctx->session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire, now + 1=
20);
+}
+
+static void
+test_auth_pending_info_too_long(void **state)
+{
+ =
   struct auth_pending_ctx *ctx =3D *state;
+    set_extra(ctx, INFO_EXTRA_=
MAX + 1);
+
+    assert_false(send_auth_pending_messages(&ctx->multi, &ctx-=
>session, ctx->extra, 120));
+
+    /* nothing may reach the client, not ev=
en AUTH_PENDING */
+    assert_int_equal(sent_count, 0);
+    assert_int_eq=
ual(ctx->session=2Ekey[KS_PRIMARY]=2Eauth_deferred_expire, 42);
+    assert=
_string_equal(mock_msg_buf,
+                        "INFO_PRE message too =
long (1025 > 1024), not sending AUTH_PENDING");
+}
+
+int
+main(void)
+{
+ =
   openvpn_unit_test_setup();
+
+    const struct CMUnitTest tests[] =3D {
=
+        cmocka_unit_test_setup_teardown(test_auth_pending_sent, auth_pendi=
ng_setup,
+                                        auth_pending_teardown),
=
+        cmocka_unit_test_setup_teardown(test_auth_pending_info_too_long, a=
uth_pending_setup,
+                                        auth_pending_te=
ardown),
+    };
+
+    return cmocka_run_group_tests_name("push tests", te=
sts, NULL, NULL);
+}

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2346?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
Gerrit-Change-Number: 2346
=
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>

--quq9MmDmreM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru <strong>uploaded patch set #2</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">View=
 Change</a></p><p>The following approvals got outdated and were removed:
Co=
de-Review-1 by Frank Lichtenheld</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">push: check INFO_PRE leng=
th before sending AUTH_PENDING<br><br>send_auth_pending_messages() sent AUT=
H_PENDING, then rejected an<br>oversized INFO_PRE and returned false=2E The=
 client was left pending<br>with no INFO_PRE, auth_deferred_expire was not =
set, and the management<br>client got an error for a message that had alrea=
dy gone out=2E<br><br>Do the length check before sending anything=2E The ch=
eck also counted<br>the terminating NUL twice; count it once=2E Log both ea=
rly returns, as<br>callers fail the auth on them=2E<br><br>Add a push unit =
test driver covering both the longest accepted and a<br>too-long INFO_PRE=
=2E<br><br>Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M src/openvpn/push=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Ea=
m<br>A tests/unit_tests/openvpn/test_push=2Ec<br>4 files changed, 394 inser=
tions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/2346/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 50b2d68=2E=2E554e=
117 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMa=
keLists=2Etxt</span><br><span>@@ -695,6 +695,7 @@</span><br><span>         =
&quot;test_packet_id&quot;</span><br><span>         &quot;test_pkt&quot;</s=
pan><br><span>         &quot;test_provider&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        &quot;test_push&quot;</span><br><span>=
         &quot;test_socket&quot;</span><br><span>         &quot;test_ssl&qu=
ot;</span><br><span>         &quot;test_user_pass&quot;</span><br><span>@@ =
-943,6 +944,16 @@</span><br><span>         src/openvpn/run_command=2Ec</spa=
n><br><span>         )</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    target_sources(test_push PRIVATE</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock=
_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tests/unit_tests/openvpn/mock_management=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_push_dep=
endencies=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/base64=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/options_util=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_util=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     target_sources(test=
_push_update_msg PRIVATE</span><br><span>         tests/unit_tests/openvpn/=
mock_msg=2Ec</span><br><span>         tests/unit_tests/openvpn/mock_get_ran=
dom=2Ec</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/pus=
h=2Ec</span><br><span>index eb11107=2E=2Ebbc4f71 100644</span><br><span>---=
 a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><b=
r><span>@@ -508,11 +508,21 @@</span><br><span>     time_t time_elapsed =3D =
now - ks-&gt;initial;</span><br><span>     if (time_elapsed &lt; 0 || time_=
elapsed &gt;=3D (time_t)max_timeout)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Handshake=
 time elapsed (%ds, max %us), not sending AUTH_PENDING&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            (int)time_elapsed, ma=
x_timeout);</span><br><span>         return false;</span><br><span>     }</=
span><br><span>     max_timeout -=3D (unsigned int)time_elapsed;</span><br>=
<span>     timeout =3D min_uint(max_timeout, timeout);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t info_=
len =3D strlen(extra) + sizeof(info_pre);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (info_len &gt; PUSH_BUNDLE_SIZE)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;INFO_PRE message too =
long (%zu &gt; %d), not sending AUTH_PENDING&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            info_len, PUSH_BUNDLE_SIZE);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     if ((proto &amp; IV_PROTO_AUTH_=
PENDING_KW) =3D=3D 0)</span><br><span>     {</span><br><span>@@ -530,14 +54=
0,7 @@</span><br><span>         send_control_channel_string_dowork(session,=
 BSTR(&amp;buf), D_PUSH);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strlen(extr=
a) + 1 + sizeof(info_pre);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D alloc=
_buf_gc(len, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(info_len, &amp;gc);</span><br><sp=
an>     buf_printf(&amp;buf, info_pre);</span><br><span>     buf_printf(&am=
p;buf, &quot;%s&quot;, extra);</span><br><span>     send_control_channel_st=
ring_dowork(session, BSTR(&amp;buf), D_PUSH);</span><br><span>diff --git a/=
tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index e3404754=2E=2Eb068028 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit=
_tests/openvpn/Makefile=2Eam</span><br><span>@@ -18,6 +18,7 @@</span><br><s=
pan> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver \</span><br><=
span> 	provider_testdriver \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	push_testdriver \</span><br><span> 	push_update_msg_testdriver \<=
/span><br><span> 	socket_testdriver \</span><br><span> 	ssl_testdriver \</s=
pan><br><span>@@ -413,6 +414,25 @@</span><br><span> 	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ses=
sion_id=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+push_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$=
(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+push_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+push_testdriver_SOURCES =3D test_push=2Ec \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_management=2Ec \</span><br><span st=
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
000000=2E=2E728bebd</span><br><span>--- /dev/null</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_push=2Ec</span><br><span>@@ -0,0 +1,352 @@</span=
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
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manage=
ment_notify(const char *severity, const char *type, const char *text)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_notify_=
generic(const char *str)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+management_notify_client_cr_response(unsigned mda_key_id, const s=
truct man_def_auth_context *mdac,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                     const struct env_set *es=
, const char *response)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ssl_put_auth_challenge(const char *cr_str)</span><br><span style=
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
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2346 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--quq9MmDmreM=--


--===============1591504869701625157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1591504869701625157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1591504869701625157==--


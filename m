Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EC3C44508
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=RJ3ai+fQ9GwWdQkYAr8Qau6FR+p8+HMgQu6yP9EFAZ8=; b=NYqR/zxCrbXmEK
	dlUdZ/CHrb/MuO5xjdC+T+mUhtJ6mUQsFSpxr0UUY0KJjwH7Aejl3R/t0Kr0ZXizi/V/ACjivqH7n
	r9WTUyn4pw/wuwF2CaKucAHuzO4HzyEPonpj3Z+d3UNAwZxCCb0+iOkgoDqOnRHiyvzCRSkJMG+vt
	6Ro=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjJt9-0006il-R3;
	Mon, 13 Jul 2026 16:52:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjJt6-0006ic-GI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 16:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=syP19+3o4vOD27Gvjs53PM8NevK5wwzrqctEaBxpalw=; b=CkzUZF2PMjXbg0ybQUefRZZUZd
 glC/GEFy7Y61GVnK72uspBPbnok+r3e7F5VAt9VBoypt600xoVKKC+7JdsFShzT5amYp80tVMKOEZ
 alQka+XB3H/x6zhA54/hhr7Y3eP8RuMuK//EwZhvxhEOT38f/PCEnhXR7wIVCJKCy7o8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=syP19+3o4vOD27Gvjs53PM8NevK5wwzrqctEaBxpalw=; b=C
 TzecLsg2KPYxlNp2fS8KfIMSEHgNcfHr6J+rCA4pLmzgEWNsRJHN1RNEeyHIIfXeCAUUns5rz7dsf
 tvFRHRHBYSZP4/8IqlmsM70vvzyAsKMmuDFeHyYTnRKF6bFOQPMYCI0ZfHKMXhJrsLfWix9rByVfl
 RON3VhyJ9xXkl8TY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjJt4-0007NH-O4 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 16:52:12 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso3478071f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783961519; x=1784566319; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=syP19+3o4vOD27Gvjs53PM8NevK5wwzrqctEaBxpalw=;
 b=Oi+/6Uenbk8oxO++Vr0vwAjzUaRuN0J3pk2LugFMULMC5LfdcA7L4Z1zakn9q9kTOL
 aOvzKDjnw2zbGUfJCSLWg61OIkE7sSN4nXhJFCP1r0wugxosiZUgc3W/6bm+6pxoc5en
 C6Wk0z1DwgF7/eqCW7amcuInN4CyiiyN7AHLgGrcIVBDmv0QlSJPOOIvtmT0YXnoosow
 Ytv6Lxovu1EM7SrKKnlWolkKd4RZGWtZ6KVMneOULWVre/ByRm07XMnxxgFmRHymK0aY
 bA876RxB3M7fKsbneMp2TVYsVcoK3lapQ4JpXu7cIFoWu6VTn1/Y61FqdAE4s8IyyQ1x
 gfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961519; x=1784566319;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=syP19+3o4vOD27Gvjs53PM8NevK5wwzrqctEaBxpalw=;
 b=LUnYww/pzfujJwu36hqYbBh4ia3lVdzJF0rsXpEI5iUcqb27/Vwn0gw7ZFUZK/td2z
 CC/7PvxGN4dSbhsBeOx8wS8fW3Kr3Jt1yRmAJTghqM20KJlqsY3LxZk3fclhLuH0A7gV
 d5Jb9mTbYHpITSK1ZAVeaAx74sc9K2dBxAeDyHJkXyyLwVtUhnkpnJpwZCAvvIXPBha3
 hZRlXGHDeii6BuTKpN+bfhpq3F0c6TD8ZdTocXXKYDbsHIdPWSAOOXUluUa7I8u/DXpF
 3tO69gV79KUzUREam2F5YSFZ+Rm8TSjSncVUlq/nHULzi8VZePgHZ6MVYvTzTYM7bRXZ
 n+cg==
X-Gm-Message-State: AOJu0YzWSEkb10wX+j1YW7ULXixmPi3QUsNeJeARqpKGKDTXl5APNdja
 gH7iALw8J1CLqv0O/axq+pcVcFfMg3VRVVOxKeAnbm/a/fN/n7D9jTx0gayRHVcVxBbHjjQFCuJ
 mDlC3kObkU6wViXvRGaShZCVxcx0xwjs98h6fn0vi3GPIDKXVHiiWcpgCbY4WzcIGrc836fWpIb
 5kY8zg1w==
X-Gm-Gg: AfdE7ckfdf/MpIp/iqncs5TU18XmWZx/emBsaVYw83bFMi24SrmYER1G0lrMAvRf2yf
 KQ2Jbut3M7sZQSqiFzbT+OV+vgJkqT0dgXUUVkfj3kIj6I26ghcRNfNf8SPcS40UdC36lPlP29k
 WOQ3L9TcGnH2YOvD/VfmWXwYh5455x3MPm+penLEzLRkq95FVYg2aXuJjFO+nkIdEnI9/zgaejC
 /Wqc0xo9Y3aD/aVgEXCRqmIKqZzducpwYD56wvm0vEIJy/Jl4Xu0kapUK+Kbag3C4m832YTUFka
 EOgV2IZGOR7LX7d7g2QK6wyNewh95AwGG1wAJhXYDkvFcrU9m4CXA2nQlSdZlcDsBWmvwKlUzS/
 vT9ZKO7McNSNEs6jbRO1TsZtnpUjo2LA2y48DhsijMQpLY1Zn0ssrlt3kZP60privw405+TGN+f
 gPzbh46N11oRLvJy96MSFUax5ePTYf2DR5DzzVuMbxUjkMuY7FT0Z2JIrFUX/WheHnBYmleK/bg
 wXCDvIPvTlKhVKg4Nu8jT8+rzLzvyufTope+8QvaKSBhv4kkCWPTrENyoWhge7FbsKmUcI50A/m
 KbY=
X-Received: by 2002:a05:6000:41c6:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-47f2dcae7ffmr11244994f8f.25.1783961518976; 
 Mon, 13 Jul 2026 09:51:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0e4sm833604f8f.4.2026.07.13.09.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:51:58 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 16:51:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
X-Gerrit-Change-Number: 1781
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1781?usp=email>
X-Gerrit-Commit: 1b50deceac18a405b48770f21b1976ac982fb84b
References: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0NWRkYzhlMzUwZDM5NDhiMzE5N2FlNzI1ZGYxMDJkOGNlNzNmYTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <307715bad85e976f47e74930406381ad10371c66-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjJt4-0007NH-O4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_tls_crypt: Fix
 test failure on Windows
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3361950597941808436=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3361950597941808436==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IE454Xpz4VY="; charset=UTF-8

--IE454Xpz4VY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1781?usp=3Demail

to review the following change=2E


Chang=
e subject: test_tls_crypt: Fix test failure on Windows
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test_tls_crypt: Fix test failur=
e on Windows

- Exclude tests that use verify_script on Windows=2E
  We cur=
rently do not have openvpn_execve available
  for Windows tests=2E It would=
 also need more work
  to replace the hardcoded paths=2E
- Use platform_gen=
_path instead of hard-coding /
  Do to the previous change that is not stri=
ctly
  necessary, but it also doesn't hurt and it fixes
  at least one issu=
e if anyone ever decides to port
  this to Windows)=2E

Change-Id: I45ddc8e=
350d3948b3197ae725df102d8ce73fa77
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec
2 files changed, 8 insertions(+), 8 deletions(-)



  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1781/1

diff --g=
it a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 4779d69=2E=2Eb2da69b 100644
=
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -811,7 +811,6 @@
 
     ta=
rget_sources(test_mbuf PRIVATE
         tests/unit_tests/openvpn/mock_get_r=
andom=2Ec
-        src/openvpn/buffer=2Ec
         src/openvpn/mbuf=2Ec
   =
      )
 
diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/=
unit_tests/openvpn/test_tls_crypt=2Ec
index a2987c6=2E=2Edb03437 100644
---=
 a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openv=
pn/test_tls_crypt=2Ec
@@ -710,7 +710,7 @@
     assert_true(tls_crypt_v2_ext=
ract_client_key(&tmp, &wrap_ctx, &tls_options));
     tls_wrap_free(&wrap_c=
tx);
 
-
+#ifndef _WIN32
     /* Use /bin/true as verify script */
     scr=
ipt_security_set(2);
     tls_options=2Etls_crypt_v2_verify_script =3D "/us=
r/bin/true";
@@ -727,11 +727,12 @@
      * platform_create_temp_file() */
 =
    char non_random_tmpfile[128];
     snprintf(non_random_tmpfile, sizeof(=
non_random_tmpfile),
-             "%s/" PACKAGE "_tls_crypt_v2_metadata__%=
08" PRIx64 "%08" PRIx64 "=2Etmp",
-             tls_options=2Etmp_dir, get_=
random(), get_random());
-    unlink(non_random_tmpfile);
+             PAC=
KAGE "_tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 "=2Etmp",
+         =
    get_random(), get_random());
+    const char *tmpfile_path =3D platform=
_gen_path(tls_options=2Etmp_dir, non_random_tmpfile, &ctx->gc);
+    unlink=
(tmpfile_path);
 
-    expect_string(__wrap_buffer_write_file, filename, no=
n_random_tmpfile);
+    expect_string(__wrap_buffer_write_file, filename, t=
mpfile_path);
 
     /* We do not write the first byte (type) to the file b=
ut rather to a
      * metadata_type environment variable */
@@ -752,7 +753=
,7 @@
         tls_options=2Etls_crypt_v2_verify_script =3D "/bin/false";
 =
    }
 
-    expect_string(__wrap_buffer_write_file, filename, non_random_t=
mpfile);
+    expect_string(__wrap_buffer_write_file, filename, tmpfile_pat=
h);
     expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_me=
tadata), buf_len(&expected_metadata));
     will_return(__wrap_buffer_write=
_file, true);
 
@@ -760,8 +761,8 @@
     assert_false(tls_crypt_v2_extract_=
client_key(&tmp, &wrap_ctx, &tls_options));
     tls_wrap_free(&wrap_ctx);
=
 
-
     tls_options=2Etls_crypt_v2_verify_script =3D NULL;
+#endif
 
     =
/* An outdated time should fail */
     tmp =3D create_client_key_input(ctx=
, 31);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I45ddc8e350d=
3948b3197ae725df102d8ce73fa77
Gerrit-Change-Number: 1781
Gerrit-PatchSet: 1=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>

--IE454Xpz4VY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">test_tls_crypt: Fix test failure on Windows<br><br>- Exclude tests tha=
t use verify_script on Windows=2E<br>  We currently do not have openvpn_exe=
cve available<br>  for Windows tests=2E It would also need more work<br>  t=
o replace the hardcoded paths=2E<br>- Use platform_gen_path instead of hard=
-coding /<br>  Do to the previous change that is not strictly<br>  necessar=
y, but it also doesn&#39;t hurt and it fixes<br>  at least one issue if any=
one ever decides to port<br>  this to Windows)=2E<br><br>Change-Id: I45ddc8=
e350d3948b3197ae725df102d8ce73fa77<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/unit_te=
sts/openvpn/test_tls_crypt=2Ec<br>2 files changed, 8 insertions(+), 8 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/81/1781/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/=
CMakeLists=2Etxt</span><br><span>index 4779d69=2E=2Eb2da69b 100644</span><b=
r><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span=
><br><span>@@ -811,7 +811,6 @@</span><br><span> </span><br><span>     targe=
t_sources(test_mbuf PRIVATE</span><br><span>         tests/unit_tests/openv=
pn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        src/openvpn/buffer=2Ec</span><br><span>         src/openvpn/mbuf=
=2Ec</span><br><span>         )</span><br><span> </span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/=
test_tls_crypt=2Ec</span><br><span>index a2987c6=2E=2Edb03437 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -710,=
7 +710,7 @@</span><br><span>     assert_true(tls_crypt_v2_extract_client_ke=
y(&amp;tmp, &amp;wrap_ctx, &amp;tls_options));</span><br><span>     tls_wra=
p_free(&amp;wrap_ctx);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef _WIN32</span><br><span>     /* Use /bin/true as verify script */</s=
pan><br><span>     script_security_set(2);</span><br><span>     tls_options=
=2Etls_crypt_v2_verify_script =3D &quot;/usr/bin/true&quot;;</span><br><spa=
n>@@ -727,11 +727,12 @@</span><br><span>      * platform_create_temp_file()=
 */</span><br><span>     char non_random_tmpfile[128];</span><br><span>    =
 snprintf(non_random_tmpfile, sizeof(non_random_tmpfile),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             &quot;%s/&quot; PACKAGE &q=
uot;_tls_crypt_v2_metadata__%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=
=2Etmp&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     tls_options=2Etmp_dir, get_random(), get_random());</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    unlink(non_random_tmpfile);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             PACKAGE &quot;_=
tls_crypt_v2_metadata__%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 get_random(), get_random());</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *tmpfile_path =3D platform_gen_path(tls_options=2E=
tmp_dir, non_random_tmpfile, &amp;ctx-&gt;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unlink(tmpfile_path);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_string(__wrap_b=
uffer_write_file, filename, non_random_tmpfile);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    expect_string(__wrap_buffer_write_file, fi=
lename, tmpfile_path);</span><br><span> </span><br><span>     /* We do not =
write the first byte (type) to the file but rather to a</span><br><span>   =
   * metadata_type environment variable */</span><br><span>@@ -752,7 +753,7=
 @@</span><br><span>         tls_options=2Etls_crypt_v2_verify_script =3D &=
quot;/bin/false&quot;;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    expect_string(__wrap_buffer_w=
rite_file, filename, non_random_tmpfile);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expect_string(__wrap_buffer_write_file, filename,=
 tmpfile_path);</span><br><span>     expect_memory(__wrap_buffer_write_file=
, pem, buf_bptr(&amp;expected_metadata), buf_len(&amp;expected_metadata));<=
/span><br><span>     will_return(__wrap_buffer_write_file, true);</span><br=
><span> </span><br><span>@@ -760,8 +761,8 @@</span><br><span>     assert_fa=
lse(tls_crypt_v2_extract_client_key(&amp;tmp, &amp;wrap_ctx, &amp;tls_optio=
ns));</span><br><span>     tls_wrap_free(&amp;wrap_ctx);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
tls_options=2Etls_crypt_v2_verify_script =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>   =
  /* An outdated time should fail */</span><br><span>     tmp =3D create_cl=
ient_key_input(ctx, 31);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail">cha=
nge 1781</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1781 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--IE454Xpz4VY=--


--===============3361950597941808436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3361950597941808436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3361950597941808436==--


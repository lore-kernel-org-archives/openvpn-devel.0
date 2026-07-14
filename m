Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498BFC44508
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FZsSWMA8qZncmWmI85f/pGByX07aUwZz7JH3+Qe4lV0=; b=NmVJvvxjweJfDtrE8OqXKXFOTo
	puC/SIdZ49oj3Erk0NOC1WsjvqcZPcBgEd53Wb+mdkbBSUKk6qOCT4b22HPcwxjDdWEWPzbZE6FYY
	xJYfPPz4mXQw3HWNQqkaQny/dSz0AfAkBHB4oiku+x6BT9KU0jT7kgDZm8z2wajk2cwM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjeB6-0005rh-3t;
	Tue, 14 Jul 2026 14:32:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjeB4-0005rZ-Mz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 14:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vFYfSrxhDkJZW5SpvpEU2XQVWORJko8QjgTN61bR1Ks=; b=VplNb/rB5Qby1VhX4DyOVRodbR
 6ePI490ODCUFHk0gPHU2ot6dlYVREZJd/SsBeg7MIE1EaJkbpGZgFZBNw0kuPEmt8Xq+plR/JkpPZ
 gjEbrq8LxYDcAcB3X8D2EaZY6CjhiHxAiD1KlIkhuOdGgwlJ0vvSXK8Lp0OUwaXLg45Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vFYfSrxhDkJZW5SpvpEU2XQVWORJko8QjgTN61bR1Ks=; b=C
 enIVvYIYngirKfYIaTi/dvyasNa8tz+BBxKTfRf6feAW8tr2IQ5yiWdzD3yFyyycODmIHK6TWCeRm
 sC+gCutXpAKhY53gsKOQThH9PBbg/yUwlyZn+TgD8oLmKC0j3SXrJsaGUB6WxYciJ67+XSh/wy6Jv
 lBKsY1oISLrdHHYc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjeB3-0006zk-MM for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 14:32:07 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47db714766aso618002f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784039514; x=1784644314; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vFYfSrxhDkJZW5SpvpEU2XQVWORJko8QjgTN61bR1Ks=;
 b=Y3lW/1dMA0KfAtmg95V/XPcVTDA85n3buB+LX92tfMQvbl9+ReKYWDk+wPUzIy1Bt7
 jVQ1alfrEHnBq6GA8y2zfTUHivAYSi4uw54DELhUM8Ietks+w94ygOs6v6jUGCKKI9h/
 14i5xFAAPttKLREXFuahLl7piZF9LL6oCeOMkDIaOla9gQVTVCSAzeJGdkeT1NA0l3EO
 hJYoaL4aCEVfgKe4qSTihnyx/JXhX1BNGaW+LRsL6YzimdAQn1iXkj2qpkNZrpO5JCWQ
 Iiq79me4R2EVpe8PzA0hcIaUAMquKY8EzdQfYWKBxRNUR9aWsDmg6w2zLhLzgybc0tr9
 ot7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784039514; x=1784644314;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vFYfSrxhDkJZW5SpvpEU2XQVWORJko8QjgTN61bR1Ks=;
 b=Aq0vezZgEEX8kqSnY9E6xxNYt3ObS78MjOYHcFI3u5Z7qjBTGm/R2S2OxEYPrRZ+5f
 eu4a+IYiqbAuzluRYD+bZgBbN8ux1cWa6Y+Gu7QEj+g8AsVlgDyENUh2qe7/kUR8fAiC
 80GvOuV1bjL3KHU+Dyr/+8G8d5lqYtpjpPHFJkwvbo/EEdBYt2N20liqNKpKEsKvCpvR
 /gQYpcVW01PVRSCbWsmPfBAN9R+5/E+gCd+VMcrlaz99dgGKIJ17qnsmQgEMiUwBVQ5Y
 MxTDtg4Y59PySQNCFdPvF2F6GUmr5efsu+2wnddm/e8d88HRQ5hB0n5y8B9t7htCz34J
 uKFw==
X-Gm-Message-State: AOJu0Yx4WuCCKkkoTqa4XA+T4nsFxdCvDBaq5dhWGRIqQRlAv27V/4kO
 J705UOnAb14PSAZ97kbBCXRiJqHxqL4VILscI3BCnRce6fcat2iCcH8RYUZt2CqdFtZzaDSXfMX
 r1tXHnvXx5RSCtt3HDiZ6GZm7ySxb+O2IgRFCWty3sH2zz+TfxvBY8Iezraosu/wBagbr
X-Gm-Gg: AfdE7cl3rqGK3ru7NWoH+GW9RgKBBtnuCr0XIFkIZh93hroyorQ97oaW02ZUNQJEx4M
 MDxraXjvkNMOWwKepHYltKi0xyt7ESqAKHAUgCm1rIxaR09CLqk0TAgNS9k7Cq3mH1RrBV5x+mW
 QcnYxT97uv8hCX8J7FiMEBYMMfNSqfxbxnhkbO2ukT6J2pM6n+mRQki9zd/uNhgBm9TC8fVNIbC
 wvIF+MmdX5dLfC08Uxj1FSICbfN0l0LnhUc2jPbkTj2NwQelMUoEbbXBaEYOU49T2rSt1edbbYI
 qKpit5dOc4ZxjHJi9OtXSN7dbSpjKGHpl0Pb/RdHrmrUZt/phEegjpJUqK06L9hNqkyPl1Be4aG
 wbqqBvlJeyY3fvqeTbzURVJ1VD7tjL2YZb2sVUQTzJmfvv46EMIsIMN9s6sXKEtb7BUT7YWYKVT
 FzLaH+2fyaBovy02jiRWMVwjoCLUXvXJnRDhrS+HfciYy9LArYWKeqKovZ8QE9iMXQ50chqIPb0
 wceY4WW5x2xcurL9CkL5yZ8IvF36Iz/DdIkpCL5jm2rU0fr0zGxsboE1frmq592yhqhMcdUbovs
 YbM=
X-Received: by 2002:a05:6000:2dc5:b0:475:c578:b62f with SMTP id
 ffacd0b85a97d-47eee0f3b13mr20928006f8f.5.1784039513882; 
 Tue, 14 Jul 2026 07:31:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a973fsm9334498f8f.17.2026.07.14.07.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:31:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 14:31:48 +0000
To: flichtenheld <frank@lichtenheld.com>,
 plaisthos <arne-openvpn@rfc2549.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
X-Gerrit-Change-Number: 1781
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1781?usp=email>
X-Gerrit-Commit: a3942a62ff3c8e8f0a5dc577e24552a4d4fa5fb0
In-Reply-To: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
References: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0NWRkYzhlMzUwZDM5NDhiMzE5N2FlNzI1ZGYxMDJkOGNlNzNmYTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7b904d3fba38d0cddd94ad5b871e978877d3b709-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjeB3-0006zk-MM
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6003823540665984620=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6003823540665984620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4azhMOkBZ/k="; charset=UTF-8

--4azhMOkBZ/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by stipa


Change subject: test_tls_crypt: Fix test failure on Windows
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test_tls_crypt: =
Fix test failure on Windows

- Exclude tests that use verify_script on Wind=
ows=2E
  We currently do not have openvpn_execve available
  for Windows te=
sts=2E It would also need more work
  to replace the hardcoded paths=2E
- U=
se platform_gen_path instead of hard-coding /
  Do to the previous change t=
hat is not strictly
  necessary, but it also doesn't hurt and it fixes
  at=
 least one issue if anyone ever decides to port
  this to Windows)=2E

Chan=
ge-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Acked-by: Lev Stipakov <lstipakov@gmail=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781
Message-Id=
: <20260714121238=2E13936-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37593=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M=
 tests/unit_tests/openvpn/test_tls_crypt=2Ec
2 files changed, 8 insertions(=
+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/81/1781/2

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
in=
dex 8de836a=2E=2E23541a5d 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2E=
txt
@@ -819,7 +819,6 @@
 
     target_sources(test_mbuf PRIVATE
         te=
sts/unit_tests/openvpn/mock_get_random=2Ec
-        src/openvpn/buffer=2Ec
=
         src/openvpn/mbuf=2Ec
         )
 
diff --git a/tests/unit_tests/op=
envpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
inde=
x 1d8ac25=2E=2Efa313d0 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -710,7 +710,7 @@
=
     assert_true(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, &tls_opti=
ons));
     tls_wrap_free(&wrap_ctx);
 
-
+#ifndef _WIN32
     /* Use /bin/=
true as verify script */
     script_security_set(2);
     tls_options=2Etl=
s_crypt_v2_verify_script =3D "/usr/bin/true";
@@ -727,11 +727,12 @@
      *=
 platform_create_temp_file() */
     char non_random_tmpfile[128];
     snp=
rintf(non_random_tmpfile, sizeof(non_random_tmpfile),
-             "%s/" P=
ACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 "=2Etmp",
-       =
      tls_options=2Etmp_dir, get_random(), get_random());
-    unlink(non_r=
andom_tmpfile);
+             PACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 =
"%08" PRIx64 "=2Etmp",
+             get_random(), get_random());
+    cons=
t char *tmpfile_path =3D platform_gen_path(tls_options=2Etmp_dir, non_rando=
m_tmpfile, &ctx->gc);
+    unlink(tmpfile_path);
 
-    expect_string(__wra=
p_buffer_write_file, filename, non_random_tmpfile);
+    expect_string(__wr=
ap_buffer_write_file, filename, tmpfile_path);
 
     /* We do not write th=
e first byte (type) to the file but rather to a
      * metadata_type envir=
onment variable */
@@ -752,7 +753,7 @@
         tls_options=2Etls_crypt_v2_=
verify_script =3D "/bin/false";
     }
 
-    expect_string(__wrap_buffer_w=
rite_file, filename, non_random_tmpfile);
+    expect_string(__wrap_buffer_=
write_file, filename, tmpfile_path);
     expect_memory(__wrap_buffer_write=
_file, pem, buf_bptr(&expected_metadata), buf_len(&expected_metadata));
   =
  will_return(__wrap_buffer_write_file, true);
 
@@ -760,8 +761,8 @@
     a=
ssert_false(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, &tls_options))=
;
     tls_wrap_free(&wrap_ctx);
 
-
     tls_options=2Etls_crypt_v2_verify=
_script =3D NULL;
+#endif
 
     /* An outdated time should fail */
     tm=
p =3D create_client_key_input(ctx, 31);

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
Gerrit-C=
hange-Number: 1781
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--4azhMOkBZ/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">test_tls_crypt: Fix test f=
ailure on Windows<br><br>- Exclude tests that use verify_script on Windows=
=2E<br>  We currently do not have openvpn_execve available<br>  for Windows=
 tests=2E It would also need more work<br>  to replace the hardcoded paths=
=2E<br>- Use platform_gen_path instead of hard-coding /<br>  Do to the prev=
ious change that is not strictly<br>  necessary, but it also doesn&#39;t hu=
rt and it fixes<br>  at least one issue if anyone ever decides to port<br> =
 this to Windows)=2E<br><br>Change-Id: I45ddc8e350d3948b3197ae725df102d8ce7=
3fa77<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781<br>Message-Id: &lt;2026071412123=
8=2E13936-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37593=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>2 files changed,=
 8 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1781/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 8de836a=
=2E=2E23541a5d 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><spa=
n>+++ b/CMakeLists=2Etxt</span><br><span>@@ -819,7 +819,6 @@</span><br><spa=
n> </span><br><span>     target_sources(test_mbuf PRIVATE</span><br><span> =
        tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        src/openvpn/buffer=2Ec</span><br><s=
pan>         src/openvpn/mbuf=2Ec</span><br><span>         )</span><br><spa=
n> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2E=
c b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index 1d8ac=
25=2E=2Efa313d0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>@@ -710,7 +710,7 @@</span><br><span>     assert_true(t=
ls_crypt_v2_extract_client_key(&amp;tmp, &amp;wrap_ctx, &amp;tls_options));=
</span><br><span>     tls_wrap_free(&amp;wrap_ctx);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span>     /* Use /bi=
n/true as verify script */</span><br><span>     script_security_set(2);</sp=
an><br><span>     tls_options=2Etls_crypt_v2_verify_script =3D &quot;/usr/b=
in/true&quot;;</span><br><span>@@ -727,11 +727,12 @@</span><br><span>      =
* platform_create_temp_file() */</span><br><span>     char non_random_tmpfi=
le[128];</span><br><span>     snprintf(non_random_tmpfile, sizeof(non_rando=
m_tmpfile),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
   &quot;%s/&quot; PACKAGE &quot;_tls_crypt_v2_metadata__%08&quot; PRIx64 &=
quot;%08&quot; PRIx64 &quot;=2Etmp&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-             tls_options=2Etmp_dir, get_random(), get_r=
andom());</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unlink(n=
on_random_tmpfile);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             PACKAGE &quot;_tls_crypt_v2_metadata__%08&quot; PRIx64 &quot;%=
08&quot; PRIx64 &quot;=2Etmp&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             get_random(), get_random());</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *tmpfile_path =3D plat=
form_gen_path(tls_options=2Etmp_dir, non_random_tmpfile, &amp;ctx-&gt;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unlink(tmpfile_p=
ath);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    expect_string(__wrap_buffer_write_file, filename, non_random_tmpfile)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(=
__wrap_buffer_write_file, filename, tmpfile_path);</span><br><span> </span>=
<br><span>     /* We do not write the first byte (type) to the file but rat=
her to a</span><br><span>      * metadata_type environment variable */</spa=
n><br><span>@@ -752,7 +753,7 @@</span><br><span>         tls_options=2Etls_=
crypt_v2_verify_script =3D &quot;/bin/false&quot;;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
xpect_string(__wrap_buffer_write_file, filename, non_random_tmpfile);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(__wrap_=
buffer_write_file, filename, tmpfile_path);</span><br><span>     expect_mem=
ory(__wrap_buffer_write_file, pem, buf_bptr(&amp;expected_metadata), buf_le=
n(&amp;expected_metadata));</span><br><span>     will_return(__wrap_buffer_=
write_file, true);</span><br><span> </span><br><span>@@ -760,8 +761,8 @@</s=
pan><br><span>     assert_false(tls_crypt_v2_extract_client_key(&amp;tmp, &=
amp;wrap_ctx, &amp;tls_options));</span><br><span>     tls_wrap_free(&amp;w=
rap_ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     tls_options=2Etls_crypt_v2_verify_script =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span> </span><br><span>     /* An outdated time should fail */</span><br>=
<span>     tmp =3D create_client_key_input(ctx, 31);</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1781?usp=3Demail">change 1781</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1781?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73f=
a77 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1781 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--4azhMOkBZ/k=--


--===============6003823540665984620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6003823540665984620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6003823540665984620==--


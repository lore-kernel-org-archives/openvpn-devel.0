Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FBDC44508
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4HBiW22zagtVIa96Su4LE4i0snFR5aZ2HKyfHD+PVnY=; b=Wq0VGnqux3L9NoDLzgPSd8eg38
	Xj+m2got9yWOKgLHF/99yMbNHRgaxQZsdNliY/Rmwke4W5/GmvjbtgdFCE45/UKmsS/uXxvnMCoq4
	7dVSACnmghczb8aPQbkUokKmVYOhf/VczqBgSMB+lSEWadpoK2eoZcXNBhdh2uxyrQo0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjeB2-00026c-Fv;
	Tue, 14 Jul 2026 14:32:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjeB1-00026S-RB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 14:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1fFxZVzX49vf1whzPb7XhWbvJr66ZIrsg4wnAEJ+MQw=; b=Z3QUXfqEvsf86jZXZ7/tTQiiSL
 8OlE8ickfEbqBFqsaefgRgs+6cTC9qdyo8zdIr0yCMVN6Gksh3kb+s0wVwFUUFNdlEzUEkcg+weIh
 kgqqhKDwa6qX3a9rsvEABrF9Tz7zYVSiQZkmUGNS7tCnPoQCLyAUHkllJrm2Yre2VAqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1fFxZVzX49vf1whzPb7XhWbvJr66ZIrsg4wnAEJ+MQw=; b=B
 2FJdO34ISErt7IBM6N1N29WRPW2l7DxXUwUTzilcy8yQ+9fgqSzwCe4VQt0AzURfNqhwPRxMMTWin
 G8GDz4qBQ4kv6s86gNoKdv7FBs5qwT5VTgQeIFzVaQWRdktdVmvX42+X5Co6HrUwPCq63bFvCDI9R
 KMOp7KqbjymUwUG0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjeB1-0006zg-Ec for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 14:32:04 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so7302635e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784039517; x=1784644317; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1fFxZVzX49vf1whzPb7XhWbvJr66ZIrsg4wnAEJ+MQw=;
 b=Ge7L+8kQtBAqLoeB+ElhYadpr5mqveYaaJRRwLpElhVfd7joEydVzqwPsAgmAmoqTX
 39lD2e/wIIWaCzlOcpxphcu6Rr+ZlU7zOosm6b1myh63BUR59sl8H3tE0yn5SsYG6Aht
 bqaqsEfixXuNYuhxU6g3FFWrF6y6ao+GQjuCYrafIQ11XzDMrBzUoZBpdbVunl2o/k7b
 of15ACoffFxhr8tn7pQbcEyGr3EGg1j++/OWeNiXw5Fm1aqbR2PNipf8ag9CROtsP939
 SXAcIdmF26cIjvjKba1UI1U4yBDGtbiBREoWvRkc+p5rNlEcMw33iUI5KYW7iGtQlabZ
 Rcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784039517; x=1784644317;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1fFxZVzX49vf1whzPb7XhWbvJr66ZIrsg4wnAEJ+MQw=;
 b=oxI7uZkxR+4eXxrj1uV9oICZeloNeUELg66Ayh8LL/bkk/yNdbmwxNOfO4QNma27vC
 OmuFKhuVkxTCUzmLXYzb8yBHFnZeyRZoC1oZcpAF4gJkQww8vk1IaEhyUrQ8ROClnPQ/
 RB2mFfss/FluNqLVcU6VuZlH1GBO6mYmEZuaXAmjBkbMpIFAH0Y7R8lAdF36QKmqiOW3
 EpUn1nHcqFzA9R99baX1LL5LkbkuP7MUaG96VuZegI5PrJK3Yd4blrvnj0urrr7pVx49
 HihonWRsJI2OpgSaznTzFArFjMpfB9x6iUejlSk4HCYjv462APYAyTCl1f5j/jj4G0kr
 7QrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkJH0yEvkDnhND6glu0KkI3m5+oBbWe4i/IMS+j03D7CszMtAkHE9Ho0e9P6FYh1zZYDeE1nDX5SF5Gbf4@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwnSyMhtc84GMmCn0mf5UK7zU1Z8Z/WRL95oC1jj7+9uZaUWI5H
 fW7qk5CoFlpgWisP5C5SQU/42WZwIWXjnCVfrSOFQW4fFSZQLkfX2t6sxJyUkSxqS52oioUGsxO
 +ATbuT2k9BnHtgIcP3spPdmniHgoAfdEb+92cM+9bXzbL4lhHW/1JgbxCQ0zRxpwk6rDg
X-Gm-Gg: AfdE7clt1imrqmVH68Pt7gEr0+NhR0VSQguFjFMuL8baJ7sESXBLMEvHjFjycPMmnS9
 64S/yFAorpSQlq3hzNQgucVXmrr+0cKy1rt6QhrQUc63HA6M2pegKSHMI/0W4qSid1czlFK0jC1
 Ao3w09NM9rWnw3D7LJ08xwWmjywehh66t+ZINpZsFTkWnxq64n9nY6bedOmI4dEHCk86IlHpDAc
 owQ+wrrmwp12HBZlISPaFZ/DwQwCFN4LG36/dyurfsp1rm94Si7wi0awNyFvb65N9COuPH57sXV
 gJBsnZOmD0bQ7rmDYdFXyJAn/8rpbz2bScEC7yUhyCnV2Nn1iZoabtUgMpZaEdQYSxWcPXNGs8m
 pq7YcCB2FduCHIEeBVRVejImZ60CyW56mWJIzadbHlnPJ47RJAMyesKQOy4Tcbl3/SqDwTop1N5
 r8Pdoi7lR7PdZEmSyx0qq50qEWxwaqYctzF2fm49pRe42IuT4VbD0fxuDbCy85Krz14idH3aCLD
 S1K+wxh1sQLzWQykxtEY2LyxHF5bQEi9irEBDwtoJeW8RCxfrFKu/CeXrN/INMbMUJ5+zkDau4Z
 0ia6wCXRQf8FJg==
X-Received: by 2002:a7b:ca4c:0:b0:493:b240:6a8b with SMTP id
 5b1f17b1804b1-493f2ac0688mr140134585e9.14.1784039516574; 
 Tue, 14 Jul 2026 07:31:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a935sm8201596f8f.11.2026.07.14.07.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:31:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 14:31:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
X-Gerrit-Change-Number: 1781
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1781?usp=email>
X-Gerrit-Commit: a3942a62ff3c8e8f0a5dc577e24552a4d4fa5fb0
In-Reply-To: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
References: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0NWRkYzhlMzUwZDM5NDhiMzE5N2FlNzI1ZGYxMDJkOGNlNzNmYTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7b904d3fba38d0cddd94ad5b871e978877d3b709-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjeB1-0006zg-Ec
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3636845177652455509=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3636845177652455509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T2umb2vQDYw="; charset=UTF-8

--T2umb2vQDYw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1781?usp=3Demail )

Change subject: test_tls_crypt: Fix test failure on=
 Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test=
_tls_crypt: Fix test failure on Windows

- Exclude tests that use verify_sc=
ript on Windows=2E
  We currently do not have openvpn_execve available
  fo=
r Windows tests=2E It would also need more work
  to replace the hardcoded =
paths=2E
- Use platform_gen_path instead of hard-coding /
  Do to the previ=
ous change that is not strictly
  necessary, but it also doesn't hurt and i=
t fixes
  at least one issue if anyone ever decides to port
  this to Windo=
ws)=2E

Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Lev Stipakov <lstipa=
kov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/178=
1
Message-Id: <20260714121238=2E13936-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3759=
3=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeL=
ists=2Etxt
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
2 files changed, 8=
 insertions(+), 8 deletions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLis=
ts=2Etxt
index 8de836a=2E=2E23541a5d 100644
--- a/CMakeLists=2Etxt
+++ b/CM=
akeLists=2Etxt
@@ -819,7 +819,6 @@
 
     target_sources(test_mbuf PRIVATE
=
         tests/unit_tests/openvpn/mock_get_random=2Ec
-        src/openvpn/=
buffer=2Ec
         src/openvpn/mbuf=2Ec
         )
 
diff --git a/tests/un=
it_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_cry=
pt=2Ec
index 1d8ac25=2E=2Efa313d0 100644
--- a/tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -710,7=
 +710,7 @@
     assert_true(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx=
, &tls_options));
     tls_wrap_free(&wrap_ctx);
 
-
+#ifndef _WIN32
     /=
* Use /bin/true as verify script */
     script_security_set(2);
     tls_o=
ptions=2Etls_crypt_v2_verify_script =3D "/usr/bin/true";
@@ -727,11 +727,12=
 @@
      * platform_create_temp_file() */
     char non_random_tmpfile[128=
];
     snprintf(non_random_tmpfile, sizeof(non_random_tmpfile),
-         =
    "%s/" PACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 "=2Etmp=
",
-             tls_options=2Etmp_dir, get_random(), get_random());
-    u=
nlink(non_random_tmpfile);
+             PACKAGE "_tls_crypt_v2_metadata__%=
08" PRIx64 "%08" PRIx64 "=2Etmp",
+             get_random(), get_random())=
;
+    const char *tmpfile_path =3D platform_gen_path(tls_options=2Etmp_dir=
, non_random_tmpfile, &ctx->gc);
+    unlink(tmpfile_path);
 
-    expect_s=
tring(__wrap_buffer_write_file, filename, non_random_tmpfile);
+    expect_=
string(__wrap_buffer_write_file, filename, tmpfile_path);
 
     /* We do n=
ot write the first byte (type) to the file but rather to a
      * metadata=
_type environment variable */
@@ -752,7 +753,7 @@
         tls_options=2Etl=
s_crypt_v2_verify_script =3D "/bin/false";
     }
 
-    expect_string(__wr=
ap_buffer_write_file, filename, non_random_tmpfile);
+    expect_string(__w=
rap_buffer_write_file, filename, tmpfile_path);
     expect_memory(__wrap_b=
uffer_write_file, pem, buf_bptr(&expected_metadata), buf_len(&expected_meta=
data));
     will_return(__wrap_buffer_write_file, true);
 
@@ -760,8 +761,=
8 @@
     assert_false(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, &tl=
s_options));
     tls_wrap_free(&wrap_ctx);
 
-
     tls_options=2Etls_cryp=
t_v2_verify_script =3D NULL;
+#endif
 
     /* An outdated time should fail=
 */
     tmp =3D create_client_key_input(ctx, 31);

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
Gerr=
it-Change-Number: 1781
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--T2umb2vQDYw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1781?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">test_tls_crypt: Fix test failure on Window=
s<br><br>- Exclude tests that use verify_script on Windows=2E<br>  We curre=
ntly do not have openvpn_execve available<br>  for Windows tests=2E It woul=
d also need more work<br>  to replace the hardcoded paths=2E<br>- Use platf=
orm_gen_path instead of hard-coding /<br>  Do to the previous change that i=
s not strictly<br>  necessary, but it also doesn&#39;t hurt and it fixes<br=
>  at least one issue if anyone ever decides to port<br>  this to Windows)=
=2E<br><br>Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Lev S=
tipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1781<br>Message-Id: &lt;20260714121238=2E13936-1-gert@=
greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg37593=2Ehtml<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/un=
it_tests/openvpn/test_tls_crypt=2Ec<br>2 files changed, 8 insertions(+), 8 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt</span><br><span>index 8de836a=2E=2E23541a5d 100644</span><br><span>--- =
a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@=
@ -819,7 +819,6 @@</span><br><span> </span><br><span>     target_sources(te=
st_mbuf PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_get_=
random=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        src=
/openvpn/buffer=2Ec</span><br><span>         src/openvpn/mbuf=2Ec</span><br=
><span>         )</span><br><span> </span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>index 1d8ac25=2E=2Efa313d0 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -710,7 +710,7 @@</s=
pan><br><span>     assert_true(tls_crypt_v2_extract_client_key(&amp;tmp, &a=
mp;wrap_ctx, &amp;tls_options));</span><br><span>     tls_wrap_free(&amp;wr=
ap_ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32=
</span><br><span>     /* Use /bin/true as verify script */</span><br><span>=
     script_security_set(2);</span><br><span>     tls_options=2Etls_crypt_v=
2_verify_script =3D &quot;/usr/bin/true&quot;;</span><br><span>@@ -727,11 +=
727,12 @@</span><br><span>      * platform_create_temp_file() */</span><br>=
<span>     char non_random_tmpfile[128];</span><br><span>     snprintf(non_=
random_tmpfile, sizeof(non_random_tmpfile),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             &quot;%s/&quot; PACKAGE &quot;_tls_crypt=
_v2_metadata__%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-             tls_option=
s=2Etmp_dir, get_random(), get_random());</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    unlink(non_random_tmpfile);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             PACKAGE &quot;_tls_crypt_v2_=
metadata__%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+             get_random()=
, get_random());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *tmpfile_path =3D platform_gen_path(tls_options=2Etmp_dir, non_=
random_tmpfile, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    unlink(tmpfile_path);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    expect_string(__wrap_buffer_write_f=
ile, filename, non_random_tmpfile);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    expect_string(__wrap_buffer_write_file, filename, tmpfi=
le_path);</span><br><span> </span><br><span>     /* We do not write the fir=
st byte (type) to the file but rather to a</span><br><span>      * metadata=
_type environment variable */</span><br><span>@@ -752,7 +753,7 @@</span><br=
><span>         tls_options=2Etls_crypt_v2_verify_script =3D &quot;/bin/fal=
se&quot;;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    expect_string(__wrap_buffer_write_file, fi=
lename, non_random_tmpfile);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    expect_string(__wrap_buffer_write_file, filename, tmpfile_path=
);</span><br><span>     expect_memory(__wrap_buffer_write_file, pem, buf_bp=
tr(&amp;expected_metadata), buf_len(&amp;expected_metadata));</span><br><sp=
an>     will_return(__wrap_buffer_write_file, true);</span><br><span> </spa=
n><br><span>@@ -760,8 +761,8 @@</span><br><span>     assert_false(tls_crypt=
_v2_extract_client_key(&amp;tmp, &amp;wrap_ctx, &amp;tls_options));</span><=
br><span>     tls_wrap_free(&amp;wrap_ctx);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     tls_options=
=2Etls_crypt_v2_verify_script =3D NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>     /* An out=
dated time should fail */</span><br><span>     tmp =3D create_client_key_in=
put(ctx, 31);</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail">change 1781</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I45ddc8=
e350d3948b3197ae725df102d8ce73fa77 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1781 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--T2umb2vQDYw=--


--===============3636845177652455509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3636845177652455509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3636845177652455509==--


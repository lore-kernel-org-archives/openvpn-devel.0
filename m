Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2768606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N/HioH8J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fpJi8EbF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AUNbHXc4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EZBAWmD/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=nnZsAdvhDywKei7JYDPNLttS3p7HBl400b7ir2XWnH4=; b=N/HioH8JdvViltAzYPNr/0pUi2
	uB6SR5MuU8NpA6W/S3HuzVFmhnOjNXP3B3uz1f3ptnucXUyExXK0deoCBAeMT+9KY5/DKNPBuUsBc
	RiFUmc3w+x4LQXhZyYvf2LhxFJu9eBtL7fJBjHNruZyNgflYKzXoSPd4a7foaamdregY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNjpx-000000004tc-2ZLl;
	Mon, 02 Nov 2026 04:40:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNjpv-000000004t7-474L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 04:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eqrre8vs8NaePWR798Gw9uhS6okeT/Zdf6na23dtJXY=; b=fpJi8EbF1e08gOktWTMwff1WVC
 GCQFb/5xv0xx1VE8Q0GTSIgrH1ExaPz1fWiyjiSIGGSHey6H4QEV+PXfTgRH4O+rlLALh6LsMJim6
 DlywX8AMkcxC414B+CDbsC2YgY2wWfrcZDIHBxbAcO+7vibD8lobdnN/6raa9y3WbkIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eqrre8vs8NaePWR798Gw9uhS6okeT/Zdf6na23dtJXY=; b=AUNbHXc4mx29VoUvVXlRzP6t3j
 GX2UMFAMDFc+5dGhn6Jvqg49EEvZUDst6u6qbLNT72tKFIpBFICBQVGXS55UkvoYjZvqawtCiZqyc
 ftr8og9QB3/QdX+d4+1KXffQqwTiNickPZsPxpJjGg+hZznCP6HLOL0J07xYdfNh8PqQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNjpu-000000001nQ-1Qcq for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 04:39:59 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so15166235e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 20:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793594392; x=1794199192; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eqrre8vs8NaePWR798Gw9uhS6okeT/Zdf6na23dtJXY=;
 b=EZBAWmD/d7XPLc+xxhRM7rAFkSKAvV2hH+2h3pzPGqb4PgstI9EQ2JVshTBa/gq/dz
 QdLZlkBWKuvp2/aOaIpArzTd6pVr+UvLiYM9Z9jyfRI9R0c27q7LC/k1dXIuz/zS566R
 vqXoEcX7X7rhL+wQLwb16l/0Ax5DlmJhWeHF4/TSrYPX0gd/DHoqTO178VzXP8pYmbqu
 MYWTRa5xfWIthcXazL6QQJotHsYTlFES5Bl3vjhsetVZ1uBQC1DBDh80XXxLq02WuXN5
 1+R5Yl5pH1vNd+5Y2d7xDvQP4WAakP2JUwVMEnHzP6gycKYOCei8IIaW61sE5VxSOvEQ
 ANoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793594392; x=1794199192;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eqrre8vs8NaePWR798Gw9uhS6okeT/Zdf6na23dtJXY=;
 b=v4bYkFoNEarwHbOGe5Lf2awurB3OZtYkd+yln40Mtiw9xXVXTmdp65wIk4c+nWVDLJ
 qYVplGJotD+MyvbLB+aw+FAuI8ibzUjWxs5k6IxeVyqjt4lMSOAqH9KtCHw97Kx069cL
 vsAd6EVPeKJf4wZeaTWmfIy1lrz651hhkVz3YU8VkZVLOGLOSANGkmAcLljI84u6xV7T
 wGxEBA2pE6dSXVxrys6hUkIcXaTVsQKLeP6ZowkE31naKcD37a7/iHa/MpPBPoGYbz3N
 MwqNtACLixi2FGiVnFdovAneKMIpyBpjTnwwkTRXPadqkWL9YTCgGACUHAP+ujKL14ZN
 zqZg==
X-Gm-Message-State: AFq9FYLjIHikjO9ppLEb0GUXj4wo6W1XmW3S8eaU0LEkaME79mTw/Prl
 LC9K9lqFQxon+dqC6HMkR37JsxRM09IhD6XrNjgEZ5Jt/BiddglaA8avl4S9S8nkoNrrjWla1vn
 XAG9Hb+cYURrI31yUIHbLYVYkI3SN2nQHsNSWfcXr9fUMi+vrL7DBKqDpSsKCNEJvXFMn85GYOJ
 DU5m+Dmg==
X-Gm-Gg: AYBFou2JsxduGJ7H1CRt8Ah7+Vo1K+0k41Z0PO4wadUf5+PofA1X63A3YEKKRXHVWiO
 5K593MQ8cEp+XMIVVRIQ8nq7g08j6f0nNFSfYtaVDbE0tD6A5Vyj8uUdmFqczb3iMkxRIXOA9hv
 jJ/7+73HP+zzZbTZ+lstHKNMBgLc74lw7ajXrF8DvC3m7/yiOp2UdRDYjnjnVKhPhJuIfty0L8S
 QJeeuIe/0e0ED14ycjio7YGSY5myepyrk65q6nKe21XCExTXW2RLSdNWn0xp0pfbs+KIrtD+BJe
 7F+hC9usZHpwDKiYfBv/ZfwL2qmXC5nFWhM0GVwP+1+Y6cNDI3reAUwCHCrEkYMNNEmA85SbzZM
 DumGtywg7Ajzix/FjZsocXPLLf9cA1gQ236wk4DwEpAWdmC39AQTuyseli4tRm6+TxwGe+UqrwV
 8blP+OfDy+38eV1FBJDiv1oWhlsXwc/YFGcDimZuVRKoDQiErMHDlLN9ATDKyoStMvoJXWo5L0l
 YeQn625jVZkwRojsgOBfJ0HudQHGBFHLo/gPNsmhz2OvL46pduppYYE9Hd6y0ucx8Hq3n6nvIu4
 1bL0Bfj48ZM86d6/FhakEEkT5nZbGLAHDM84q4LHeZcWNZPCOYSBt0eunI2jetYa5kOruBVikwa
 X6iwes8S8VZnbB2cQ3hPLSX1bs+Gh7qSzt4eN7i/gINBqkHq+IlQ+urWf3ort/y+YoH07M5b6Ip
 n7+HZyk7LLeIPOJC4RkeyEeqswvTM6zB9Nwhk=
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4ac180f2fd3mr215731225e9.30.1793594391660; 
 Sun, 01 Nov 2026 20:39:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm18061701f8f.35.2026.11.01.20.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:39:51 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 04:39:50 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
X-Gerrit-Change-Number: 2079
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2079?usp=email>
X-Gerrit-Commit: 7f3b66366055c7e45c4256969f2497496df91a88
References: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTk0Mzg4MDAwLkk4ZTAyYjRjZjM5Y2M0MzFmMWYyYzA1OGRiOTU5OTdjODkwNzU1N2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c8d74f66aa98c2dc2c0853dc16d167935faaf10-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNjpu-000000001nQ-1Qcq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: Wipe the
 tls-crypt-v2 client key copies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6196507248595884748=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6196507248595884748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A1Qmyymn/xw="; charset=UTF-8

--A1Qmyymn/xw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2079?usp=3Demail

to review the following change=2E
=


Change subject: tls_crypt: Wipe the tls-crypt-v2 client key copies
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tls_crypt: Wipe the=
 tls-crypt-v2 client key copies

tls_crypt_v2_init_client_key() reads the c=
lient key into a struct key2
on the stack, copies it to *original_key and r=
eturns without clearing
it, so every client start leaves the tls-crypt-v2 c=
lient key on the
stack=2E crypto_read_openvpn_key() does the same copy for =
tls-auth and
tls-crypt keys and clears its struct key2 afterwards; do the s=
ame here=2E

The --genkey tls-crypt-v2-client sanity check in
tls_crypt_v2_=
write_client_key_file() has two more copies:
- keydata, the struct key2 tha=
t tls_crypt_v2_init_client_key() fills;
  clear it after use=2E
- check_wra=
pped_client_key, the decoded key file buffer: the client key
  is still in =
front of the wrapped key when it is freed=2E Clear it with
  buf_clear() be=
fore free_buf(), as do_close_free_key_schedule() does
  for the client's tl=
s_crypt_v2_wkc=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I8e0=
2b4cf39cc431f1f2c058db95997c8907557c0
Signed-off-by: Hansaem Wi <hansaemw@g=
mail=2Ecom>
---
M src/openvpn/tls_crypt=2Ec
1 file changed, 3 insertions(+)=
, 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/79/2079/1

diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn=
/tls_crypt=2Ec
index 23c7975=2E=2Eee4acdf 100644
--- a/src/openvpn/tls_cryp=
t=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -331,6 +331,7 @@
 
     tls_crypt_=
v2_load_client_key(key, &key2, false);
     *original_key =3D key2;
+    se=
cure_memzero(&key2, sizeof(key2));
 
     *wkc_buf =3D client_key;
 }
@@ -7=
83,6 +784,7 @@
     tls_crypt_v2_init_client_key(&check_client_key, &keydat=
a, &check_wrapped_client_key, client_file,
                                =
  client_inline);
     free_key_ctx_bi(&check_client_key);
+    secure_memz=
ero(&keydata, sizeof(keydata));
 
     /* Sanity check: unwrap and load cli=
ent key (as "server") */
     struct buffer check_metadata =3D alloc_buf_gc=
(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
@@ -793,6 +795,7 @@
     ASSERT(tls_c=
rypt_v2_unwrap_client_key(&check_client_key2, &check_metadata,
            =
                               check_wrapped_client_key, &server_key));
   =
  secure_memzero(&check_client_key2, sizeof(check_client_key2));
+    buf_c=
lear(&check_wrapped_client_key);
     free_buf(&check_wrapped_client_key);
=
 
 cleanup:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2079?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e02=
b4cf39cc431f1f2c058db95997c8907557c0
Gerrit-Change-Number: 2079
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--A1Qmyymn/xw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Hansaem Wi would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">tls_crypt: Wipe the tls-crypt-v2 client key copies<br><br>tls_cry=
pt_v2_init_client_key() reads the client key into a struct key2<br>on the s=
tack, copies it to *original_key and returns without clearing<br>it, so eve=
ry client start leaves the tls-crypt-v2 client key on the<br>stack=2E crypt=
o_read_openvpn_key() does the same copy for tls-auth and<br>tls-crypt keys =
and clears its struct key2 afterwards; do the same here=2E<br><br>The --gen=
key tls-crypt-v2-client sanity check in<br>tls_crypt_v2_write_client_key_fi=
le() has two more copies:<br>- keydata, the struct key2 that tls_crypt_v2_i=
nit_client_key() fills;<br>  clear it after use=2E<br>- check_wrapped_clien=
t_key, the decoded key file buffer: the client key<br>  is still in front o=
f the wrapped key when it is freed=2E Clear it with<br>  buf_clear() before=
 free_buf(), as do_close_free_key_schedule() does<br>  for the client&#39;s=
 tls_crypt_v2_wkc=2E<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Cha=
nge-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0<br>Signed-off-by: Hansaem=
 Wi &lt;hansaemw@gmail=2Ecom&gt;<br>---<br>M src/openvpn/tls_crypt=2Ec<br>1=
 file changed, 3 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/2079/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</=
span><br><span>index 23c7975=2E=2Eee4acdf 100644</span><br><span>--- a/src/=
openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span=
><br><span>@@ -331,6 +331,7 @@</span><br><span> </span><br><span>     tls_c=
rypt_v2_load_client_key(key, &amp;key2, false);</span><br><span>     *origi=
nal_key =3D key2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  secure_memzero(&amp;key2, sizeof(key2));</span><br><span> </span><br><spa=
n>     *wkc_buf =3D client_key;</span><br><span> }</span><br><span>@@ -783,=
6 +784,7 @@</span><br><span>     tls_crypt_v2_init_client_key(&amp;check_cl=
ient_key, &amp;keydata, &amp;check_wrapped_client_key, client_file,</span><=
br><span>                                  client_inline);</span><br><span>=
     free_key_ctx_bi(&amp;check_client_key);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    secure_memzero(&amp;keydata, sizeof(keydata));=
</span><br><span> </span><br><span>     /* Sanity check: unwrap and load cl=
ient key (as &quot;server&quot;) */</span><br><span>     struct buffer chec=
k_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</span>=
<br><span>@@ -793,6 +795,7 @@</span><br><span>     ASSERT(tls_crypt_v2_unwr=
ap_client_key(&amp;check_client_key2, &amp;check_metadata,</span><br><span>=
                                           check_wrapped_client_key, &amp;s=
erver_key));</span><br><span>     secure_memzero(&amp;check_client_key2, si=
zeof(check_client_key2));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_clear(&amp;check_wrapped_client_key);</span><br><span>     fr=
ee_buf(&amp;check_wrapped_client_key);</span><br><span> </span><br><span> c=
leanup:</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2079?usp=3Demail">change 2079</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058d=
b95997c8907557c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2079 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--A1Qmyymn/xw=--


--===============6196507248595884748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6196507248595884748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6196507248595884748==--


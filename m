Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F446606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kqMJnoZJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aPJtCcyt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aavX/gyA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ASe3ILmo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nvcVfnqaYdicPAlpDEPDtLJ2YOUyQBhUi3dDWAFxhJ4=; b=kqMJnoZJmxEV/YZK/UVXOABPkB
	uNtAodrfjWF5lv8C+pneZf248nq48wN4ksm+FFJxxAfP5tXF7BE+6T4mGjF7bEQYuCiRxvbxt/eRF
	DNcojizztDjgGIiQo8D7AexM0V9pWDdRdk80fthW33Na27HZf10KR0C5j0+O4HulUVbA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM76k-0000000083e-1T8L;
	Wed, 28 Oct 2026 17:06:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM76i-0000000083X-3s7v
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 17:06:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IuPRF6j3NCkcgkmdHIHX8g5kLoZn6CpXUD7pbEYxHIw=; b=aPJtCcyttwF9cbhzQZcRob0Rng
 pqb7MTHmedKpT7FI+ODyj8arIP63dyqSLOkyuZIfx/IvtmqHJl+RfWFtK5FCaz3omtVZIsY2ZJXZk
 Y2Rw2QOD289exatH4QcgY+yoR7GYtTGzl/Cj0JZ5BBzUaQB0yFbOyssOKvQUwuuKA8Ps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IuPRF6j3NCkcgkmdHIHX8g5kLoZn6CpXUD7pbEYxHIw=; b=aavX/gyAfvfjAUDc2QIKH9IJER
 yrNs54sQfcrRcy8BRF6EXSKj0XxVRHIFiqyBhUxqj8IJU94XCBfxMWCWS4/cd+LZpBQO7mbjuTAuL
 YFFkxaUoAIsWCApCMrR7pZHeOQQS0vYELIwuzSZygMk9bmnj4qmamgoXHvaTLNV1a/WM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM76g-000000006E2-1AIP for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 17:06:36 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so11195235e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793207188; x=1793811988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IuPRF6j3NCkcgkmdHIHX8g5kLoZn6CpXUD7pbEYxHIw=;
 b=ASe3ILmo7pDmFR3iSIfFYV65QlwJTwivgGULqw77f2c4FWh8E8kuF33jhwTPk+xyFs
 Nz9K3mwD139yt4N2IqyTePCvQhJ5j3Ua51T1s3aztF+39NJ2KCBdTzgUO6O/grThY+aI
 b8aGwvFA8fDhSjF5YN7W4XYmfSc7VRr3o8b+nDL1IyQjkQKlc4v601NWt0CVaLzodPt0
 mgsafAph5VH6BLlwr6VXlagJrx7P+gn8Worr+n7H8Mkt9M6X4tt241VRP8/qyYiv3nmk
 S2v8tbEGNz6NmhuMsQdasPN41iUorHTqze8xI6h8ib+Tp3jsKix3JgWnZtgNFz8HdOMo
 CSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207188; x=1793811988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IuPRF6j3NCkcgkmdHIHX8g5kLoZn6CpXUD7pbEYxHIw=;
 b=U7QTkmVaGj+E5vo0V0DRnKFoKoF/JsCCnPURzAURDIBy1v2lP0gQAZY7hzUyRn/+Os
 G7LTWQHMD6BrN0wshyV8Yec3thlnH1iZj+n618w5WB6LGhEB1bfqXakMavPHQL3/WrgX
 zKI9iImS8Dah9Fz7sHO5QaFHnwRC4PgxKsBNIvRFt0zqG2i8C+gDN8rueJmqXKAiJN40
 OewSLMnEsik3LRD3cwLISO5AwVu0jLvjbNpSf1fXyz3lEi2h+dRbWCCnlJC4FlH1i11k
 7nb1nvRhs5WnCMAGcv9jd8YM0M1LO4usCkZUb36+JVRDYx2EhF6wt6SqdvkjzrDyLGpr
 bliw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU1TyOYI33BmcuuiMeidGbbF/dHN6+TYifj6V7EMKzG42lIBMs2klLpIJJzmqxIaCZ/VUm0bjNwK5KnUFe@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL2My2ULfTdsIzX2LEBv2H76eqBZW+SYcrSv/4gfgy9ay0rkzwv
 kZE3LS0e50wYfXw/Nlf5lvdqSQw0DJFqTDmdF4pDZlGtWoTZeIwSwfTOix7HS398AhmNyAiXNv/
 V3oBkh/cD0djWVtA2ubV3cEAHlSsdwtboeQ804bDxQw6VcpRnVbMu34IoPlW2bjqeoM0v
X-Gm-Gg: AYBFou3dcTjgFY4V3DtZB1SRTQ+FD04yoOoR1Fq6WxygYBpB4b13pRJaWllM7kSfs+x
 eFMt0PYwa3JRR7DF0OPlomlu6bU4FClsBRScnNUa1TIskt3/pY/UH4MRz0N+7M9cDFZNJNDng1/
 Cms+mdFi4PF1S/vX1RPzkWf0uPiiKyUxtYRF9aVfjKdvSY/wtmgnzh1zcepTrsYv3fxZPlZIsoM
 pHpY1zQLgU8cvALV2XCCTx+30I7U4fpVItbSIO2wSwEc037xKGTTQrOTuywjCMY4f/QJFfwiuXp
 OtHdQ849IfOGbLhkBPIftvBSs9XCU1zhjgjrVYQQOddlLxaJ9I74+Ch3iStgBi92otTazFaNoR2
 wCbUHGkC6kZNwAE+YV0MsiQv64Gi7DxFFcyAEPbmqY7ZqxHyd03S/J5v7N45JOmr8LkD/9Kplbd
 gwXGuFbwBtqZZhspqY0u4V1su/kXDxSvG+KuWbGZfTF6sBw4NaDeZoUrulciA5TMsmgrl9X8CpL
 Hlzm0x1G2lwIDTvk0Fg4nooNBjUosnO1mEWKxO88AqKqaU6rWjm2yy6P3Ro74W/tRuKd+IArlt9
 uQMHkXsCNvsxUQkmjI5TF0r2cPJmh0CJwJGUnWpO0WKXtipWn/FXxPVEk0QPPoVyw9MkMH+xcuh
 aTIAb3Xr9YMYDmhpMYVpP/GnYzfTCajXuI2nOraFH7o5jfbchZUVs/TkR6dQKelgbAflt7RLmsG
 NBFtsTMo5DlwyVcG1xd3RsJP3NKHe/PnxYNm/o
X-Received: by 2002:a05:600d:4121:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4a96836988amr68378745e9.32.1793207187461; 
 Wed, 28 Oct 2026 10:06:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f418afbsm6141405e9.6.2026.10.28.10.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:06:26 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 17:06:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: abced4a51301c1228875f58c87e15c7ec4056937
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 17:06:24 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ccb08cacc2bed130f73989b567ef5491699e8251-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM76g-000000006E2-1AIP
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0336046304710401524=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0336046304710401524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jDi+pOsgtqM="; charset=UTF-8

--jDi+pOsgtqM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Max Fillinger has posted comments on this change by Ma=
x Fillinger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demai=
l )

Change subject: Remove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(4 comments)

Patch=
set:

PS2: 
> In addition to the inline comments, it would be nice if we wo=
uld also drop a line in Changes=2E [=E2=80=A6]
I added a line that it is re=
moved now, but you said deprecated instead of removed - should I add a depr=
ecation warning to the 2=2E7 branch?


File CMakeLists=2Etxt:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/2d4f0996_94d2b037?usp=3Demail :=

PS2, Line 320:     check_include_files(psa/crypto=2Eh HAVE_PSA_CRYPTO_H)
>=
 It seems that after this change there are no users left of `psa/crypto=2E =
[=E2=80=A6]
There are still users left of this header, but it exists in eve=
ry version of Mbed TLS 4=2E So you're still right that the checks should be=
 removed=2E


File src/openvpn/ssl_mbedtls=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2029/comment/a467f7fb_05bcfc69?usp=3Demail :
PS2, Line 1=
56:     return mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_siz=
e, label, label_size,
> `MBEDTLS_SSL_KEYING_MATERIAL_EXPORT` seems to gate =
availability of `mbedtls_ssl_export_keying_materi [=E2=80=A6]
I was thinkin=
g about that, but Mbed TLS is very modular and there are lots of configurat=
ions that would cause OpenVPN builds to fail=2E I don't think it would be e=
asy to print a nice error message for every possible unsupported configurat=
ion=2E

Do you think it's important to have a check for this one in particu=
lar?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/501ffb31_ef4=
fa1f8?usp=3Demail :
PS2, Line 514:         mbedtls_pk_context *mut_prv =3D =
(mbedtls_pk_context *)ctx->priv_key; /* remove const */
> `ctx` is not `con=
st` here, so the cast shouldn't be necessary=2E
Right, this was a copy-past=
e error=2E This code was originally from mbedtls_compat=2Eh=2E



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25=
d6696d95d719
Gerrit-Change-Number: 2029
Gerrit-PatchSet: 2
Gerrit-Owner: Ma=
x Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 28 Oct 2026 17:06:24 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>

--jDi+pOsgtqM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Max Fillinger has posted comments on this change by Max Filling=
er=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=
=3Demail">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2029?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a>=
 </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">In addition to the inline comments, it would be nice if we=
 would also drop a line in Changes=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I added=
 a line that it is removed now, but you said deprecated instead of removed =
- should I add a deprecation warning to the 2=2E7 branch?</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2029/comment/2d4f0996_94d2b037?usp=3Demail">Patch Set #2=
, Line 320:</a> <code style=3D"font-family:monospace,monospace">    check_i=
nclude_files(psa/crypto=2Eh HAVE_PSA_CRYPTO_H)</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">It see=
ms that after this change there are no users left of `psa/crypto=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">There are still users left of this header, but it exi=
sts in every version of Mbed TLS 4=2E So you&#39;re still right that the ch=
ecks should be removed=2E</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/ssl_mbedtls=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
29/comment/a467f7fb_05bcfc69?usp=3Demail">Patch Set #2, Line 156:</a> <code=
 style=3D"font-family:monospace,monospace">    return mbed_ok(mbedtls_ssl_e=
xport_keying_material(ctx, ekm, ekm_size, label, label_size,</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">`MBEDTLS_SSL_KEYING_MATERIAL_EXPORT` seems to gate availability of =
`mbedtls_ssl_export_keying_materi [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I was thinki=
ng about that, but Mbed TLS is very modular and there are lots of configura=
tions that would cause OpenVPN builds to fail=2E I don&#39;t think it would=
 be easy to print a nice error message for every possible unsupported confi=
guration=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Do you think it&#39;s important to have a check for this on=
e in particular?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2029/comment/501ffb31_ef4fa1f8?usp=3Demail">Patch Set #2, Line 514:=
</a> <code style=3D"font-family:monospace,monospace">        mbedtls_pk_con=
text *mut_prv =3D (mbedtls_pk_context *)ctx-&gt;priv_key; /* remove const *=
/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">`ctx` is not `const` here, so the cast shouldn&#39;=
t be necessary=2E</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Right, this was a copy-paste error=2E Th=
is code was originally from mbedtls_compat=2Eh=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?=
usp=3Demail">change 2029</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2029?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Wed, 28 Oct 2026 17:06:24 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--jDi+pOsgtqM=--


--===============0336046304710401524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0336046304710401524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0336046304710401524==--


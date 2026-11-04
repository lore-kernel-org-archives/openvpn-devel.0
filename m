Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2DC606D830
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RwsFspgm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gt75ZtiW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jjlX40MX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FuSHZSLz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s+P5/rmyCGbH0iqWyXpf69MM9xfSGvykU5cT6CGFuOo=; b=RwsFspgm8J4pNCIQCvAEin6LlT
	6P5xaMqL0HWJAVxutDz++nh5FsJuhp5Y9VuHdVJ/a7A1OhPb6de/p2ZlHTvuayA9tWHFqJD+igY/4
	xIah1c8fRGcbgmtnSPFqk02XIQLh/6+DQjNGdFydT4Pv/BsuDMokecEa8O14hgo5GbHE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcYp-000000003Gh-3R7Z;
	Wed, 04 Nov 2026 15:05:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcYn-000000003Ga-3LxL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e5D2LE2AWI4KQaNwCu0xdKlzCXBY0zXtZs8AB7jeZ/k=; b=Gt75ZtiWD/BDfrXp9ZHsNeYnud
 4dFWY5tN/llHjklbCZKc7BHkWVZLY5L9W6IUN4kyvDgfNZEfAEZgRDJcI+XvKehS8B+kw4VMefEYI
 e8bHjXttq3ll1v9sGT/L+WgPUou1Mu+1lYwoad7S/HX6x67LQMVUVtpquU/cinO2dEtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e5D2LE2AWI4KQaNwCu0xdKlzCXBY0zXtZs8AB7jeZ/k=; b=jjlX40MXRHvte9epA5m8nTNNV6
 KB5HwVmYhnz82LR1+abaS81IayrKwy1HB9Jvo8fHnLw3/kObTz7nG0l9vqYEFx85kA6t9EQh/jQeK
 gXIjhwtqDx55g3kiFQM4le8HsL6eVCOoDhwQYCfHYh1H5clUSiZy3Z2wSfxbySJ80ytE=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcYm-00000000411-3bCF for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:05:57 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so55709f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793804750; x=1794409550; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e5D2LE2AWI4KQaNwCu0xdKlzCXBY0zXtZs8AB7jeZ/k=;
 b=FuSHZSLzmujwXpWbSXJf7re1JpuQRX2fhcE+NzNpMqkvhj83vvte520sxu5oBALGyk
 ydDATGK9vrhzgTXI2B5wCySUDkITouSYchqUfi0fRoXX45/m/kBmOgtI6bm0j2atk2SE
 V9mAPJWwMsoAurq2/ysQGtzt5WKXeiyJ+rjxBZnep8vqfsd1mjuS/IodEs6upuX8c2iX
 BPc394XXGRpwba4zzXFcp8ctkFe9Ng6tEkJg/HrAiVQM2OlFxW/pHx7oOUb5Z9O3/rUi
 E4qWH9iDv5GBtNTXb2EB1TBcKMuIi185rmTs6ugIcW0vp7tHB+tPuzFQiMSnf0wFt5w0
 QjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804750; x=1794409550;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e5D2LE2AWI4KQaNwCu0xdKlzCXBY0zXtZs8AB7jeZ/k=;
 b=v8g+cmsxMXBmzTzOt2AND93tmUgJxFgQvOBNawauTInqmXtvgFUtX2NLyMtrGey+0s
 Mtxf1hKmbwH0Qe17yYz/pmUiWemZtpwhsHsjDgNdZGWJC3Sf5xwfBIo6npqfp0rtmTx+
 e762X7Y1CUSa/ZKDHLpEYXZ+lSfdUGavyX2YBKiWvELaFyAiAZ7AlJE7Rbh7mt9t00AN
 mlGznxm6Ikr0sXYlcFoNnRtNFIda+FSqUNwYlz7F0nr+hmVnmqAusOVsTKyDe6+wLHRJ
 CLuLTFJfYALpsnPLImdBOErrlMArAExoLygedesU5LCgSfPE1kUXMhs0BAW+3bec/sDN
 BxmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgQvi6QHdrrgHzT9HG5cf6vxqZAxXJN4gfR2BWY1HE6LI7Gd6L6GVmrdryJhC6EllKAMwtYP5g1ffOAqwH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+cq66qrlzvVdtdrfN3zOXanwmBIoc93ewB1zAFkA1OOF6peE2g
 QcFtYlCoI4eTP1rMNcufqal3/3WVfPBrNMgKIXe3jwiMERZlEKsZDBKRTeg3DEBPevaZP5Nq4IT
 aSLAMZZYumS+YgSpStEQCQkC1T61RvtGttDZz0L3I5ZlhXxdN75mD4fQ0ruRyOhjL/3BrkXBZn0
 +Uteyi4w==
X-Gm-Gg: AYBFou1n2o5BMtaN0U3kvFRtLAkLsi8pbPnZL12KZoSfVl2D93ouAE8SDv9ZzyPFD5r
 G9qyYnu7gArNwtoktEqSMk3iS0679eltd4l7TgvcMGrbuJxooBt3/8bTNeyUC3aV4yoMK3mhEoy
 bFq4s/nFrDZS7dn9fqWe1u2hsgkBacA51Gkk5IxmBP0gcW+pNQXCKuWfpbG+dc/UATRByNNT1ie
 zL9A2XCpH+zsWcOeEiO2+LKfOtbMt4+9AsQ8zoHtHXT651kgDIG9OkARWhkTgy1l7xN2enEm2XD
 IWQEtQTlVfB2jQmO8iLEuAaJq2B7lrTm/L+8ux1XvEyCbmKXMrvmwRBiCZrrvk+v97t88B4D4Kp
 X9DiPFqXmL/oRxZbf1v6zWxzINpo35SSBy/aWKRsNLCRUnCnuVhSfMuJhhGg2FT0rxAkoMuajsD
 ZdiD8N0NWnY9Qon63g1Vzoohnd9OQBKyJ6Y+Elb7z+PmkoNhmLG8fEGCJu4UPOiqg16kVQPmfUa
 mbvSE+5o/l6g+yPeVNREdjjqRvimuZB9+b79a32RVVoxJzvJRUfI7GIfrRTqVYgzNj/vehEUvnB
 sw8jgbERBHRAVb2YLQ5OJVZHWrrytByDb/5GvccwDleGpFwgQ6fq48JIZDTWV6tVWZnNt+9g6Mh
 bk0+ZnwkkPDx3dXYUucGJ3AKl7MK2REiFyFifuZkvXXp6c4IZ4/xEpoCqxKQ8ZeJZiPmsqNCWyv
 gxBsH0l7ZNIC65j+D95hJVE3PR7gk7lGVmzCw=
X-Received: by 2002:a05:6000:29d9:b0:48a:fe00:ad1 with SMTP id
 ffacd0b85a97d-48e6e2c1d3cmr23791940f8f.6.1793804750057; 
 Wed, 04 Nov 2026 07:05:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d2bbsm4679314f8f.33.2026.11.04.07.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:05:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:05:48 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: f131316b0e700585165a27cd24f894ec6c9bfb3a
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:05:48 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ae07cdbccc007861397ab585b6a88bfdb1a1f7c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcYm-00000000411-3bCF
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6206800251682682528=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6206800251682682528==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hR1G07FGgzs="; charset=UTF-8

--hR1G07FGgzs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3: Code-Review-1

(2 comments)

File src/openvpn/control_msg=
=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/34121669_0d8=
eb3ea?usp=3Demail :
PS3, Line 49: /* The header every TLV carries: the 15-b=
it type and optional flag packed into
Please make this `/**` so Doxygen pic=
ks it up=2E


File tests/unit_tests/openvpn/test_pkt=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/7d18d8c7_439ff91e?usp=3Demail :
P=
S3, Line 48: int run_control_msg_tests(void); /* test_control_msg=2Ec */
Th=
is looks a little weird, testing the new functions seems to go a different =
way than the existing convention (I expected a `control_msg_testdriver` or =
ctest target)=2E

Also if the prototype changes this will get stale=2E



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2=
c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 3
Gerrit=
-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 04 Nov 2026 15:05:48 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--hR1G07FGgzs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipakov=
=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?us=
p=3Demail">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/c=
ontrol_msg=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/34121669_0d8eb3=
ea?usp=3Demail">Patch Set #3, Line 49:</a> <code style=3D"font-family:monos=
pace,monospace">/* The header every TLV carries: the 15-bit type and option=
al flag packed into</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Please make this `/**` so Doxygen picks it u=
p=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/u=
nit_tests/openvpn/test_pkt=2Ec:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/=
7d18d8c7_439ff91e?usp=3Demail">Patch Set #3, Line 48:</a> <code style=3D"fo=
nt-family:monospace,monospace">int run_control_msg_tests(void); /* test_con=
trol_msg=2Ec */</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">This looks a little weird, testing the new funct=
ions seems to go a different way than the existing convention (I expected a=
 `control_msg_testdriver` or ctest target)=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Also if the prototype ch=
anges this will get stale=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1=
965</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipak=
ov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 202=
6 15:05:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--hR1G07FGgzs=--


--===============6206800251682682528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6206800251682682528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6206800251682682528==--


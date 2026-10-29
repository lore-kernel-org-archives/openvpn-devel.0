Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12718606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=as96kBmj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=daEf3S2P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jXvMj2OZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DrTJkGTW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=X3BoTyzNmcOCgskjntTJczb+Qvnb03bARQOwVMyWSss=; b=as96kBmjp48mAXafFDYOMl1xY3
	egqJ1SmAo+Ncfqg44d4eL/I5X1fZn/2XFbbZXz2sLEzAbd6deAIQwPQgPJjA4uV4tWOVtO9GDdKlG
	PYa1A459qz3ZdkSi+ysBkI8L4IunDH53aTc6m8IzkGbg7yyI1/lJt4vDycvEZ/kEOTDI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMQYW-00000000415-31IP;
	Thu, 29 Oct 2026 13:52:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMQYV-0000000040z-0XzB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 13:52:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WY6SNmgdZIU9IbVJeQKAm+KUVrYPwwazT70LUSrOelM=; b=daEf3S2P+yeSyrLE7I4fvmsyb7
 stAzeGygWzXewyoAPdvQNTN7Lxjlby7ut5F7ItAQv3GocpJ6LhygKMePoewFiKOAC1T3icxwt+NMT
 L2raIXCWWr2igYsQOaR6H88+P3nkibCv9T5Y7m5AH/lTfzrO8g/yeqV8lABrbw2KBGvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WY6SNmgdZIU9IbVJeQKAm+KUVrYPwwazT70LUSrOelM=; b=jXvMj2OZS5LTTDSgLbpkqKFULF
 PUGojpqMQtuHYSrEtbCGmV1kaY7/OCGzHRiYyz981JXi1jW2qGS3XXJaTfz8TA6SKkFUkLrBdnmfh
 UXRa4B/sGwKPP8yKtZfcIYk5aa7FRD6bei8Wksb4Mlk7tJsaWbhsb6ucAcG/xUkIGKaU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMQYT-000000003cM-1PKs for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 13:52:35 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so16832315e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793281947; x=1793886747; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WY6SNmgdZIU9IbVJeQKAm+KUVrYPwwazT70LUSrOelM=;
 b=DrTJkGTWX9I1flMLnS7asdpSfbsue6jEEv517JhqBNOJeKaKJugrSByPlzfUVj5l5r
 0Jagc8P7va4wrjaqjDJNUotWJTIgZcobXtbgM32jnl/AMd4YJ9jAakDzPoTFuSnQPzs3
 HKFspsGy3hleGHypgewkAYZCqtIw5ttW3tp0nT9ZJheSNfjvtWx0yHJGc6nXm6q0UC4s
 tYJQeTqoyj+vpG9xKVy0LNZ8UB0XdkGDNUEHnzyV4Ajhi+7j9aN2ZCzEu/oX1jc4oEW4
 QAuQnzO71Nj1RkUfznJRcthnKy06WdZRQQCQhYK1lQBsXHbzPnx5/0mPOkZwwzKacEf6
 O3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281947; x=1793886747;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WY6SNmgdZIU9IbVJeQKAm+KUVrYPwwazT70LUSrOelM=;
 b=wIWK3nF1DGSWb7bHAzXvvNzdAKcCodHW4vRSlZ2MB/tK9Jng8qDhoCv4Vd0O4BDwK6
 D4m/YFzbDpKD3HH6ZRbmzUGmSOWtiK3FA7IOCvYpZPZ908xLBR8e8q+R5tZCTSprlqrP
 Yg9UhH/6+o+y2CaLzKIO0mswDwXleWb1gFzBgWIer+gE4TZKeQItu9CE0zRI4bTdeZAI
 M5/RzRBQFq8gkSq8R+R7fDaP2RdqY6mSMKx+/PnamdS+aGGzAuFTlSzXQVhRGz7YMOUj
 tVEhTci/UMDfL2hKwoqCDmMeNczCxtc3Xj53bVW58YI7bMpTYm5oJDQkSqajKb4fJXPy
 r92g==
X-Gm-Message-State: AFq9FYLSK8wiQ/AqcBs1W7/n3lW5Y31HrxlX9JGJYog8uhRtDk/j5W4T
 BtQBYEtVxoeQrZtFuqwpanmI0RYheDXNMSznOquw/UmtavHX7BWWxSOtznp3BtyPqPXoaHODktA
 HQjJJDpqgDQ+KpIa4bwEwQRFoTibh37AtTBpdr5dv+Ux3ClauOXooYauEsOkJpk4mMhEYCovGx3
 Lx/tvAuQ==
X-Gm-Gg: AYBFou3k7QaJdU45ky7eW4v1TJOU5Zhjl0+c7+iCoB/P6xPB7g7YVlQspO+ejKiTYNa
 MoRNN+XerRAdclyDHCV2vUIxnmNkxRYdiVWOhWRbbX6LoZKhgXlzob2MHlaFbwR4n5k+tFY3w0x
 tWR+DBMEuSKVsY7l2eCS1YJfhWTPkTCTmCx1aKWQ2m2OnkIo1Vq/CdvCJgpyZ4WJfjjJVWtw4c6
 Mm+6Ogsrp6qrv0I/9vUnKsna6m+6/goR+tSAdaB7cn8xZ3OWpl678k+eXDsR5bN0ouw9M2zGl2O
 MDNJVH6ZCpSC61J5XDy1zbuNa4NpyH7nfap+NsZLWioFpGPXbx0GLZ77QyXFAaSeGMxNNzIpmI8
 k/AESRMzvGLgq7g+Z5aBkfpXec1f4Ly+uXCurJD9Y/TZMAHudXahd7KZbF+fOHwhm+lbsES5a08
 bSCjuTKJuUU/FwXFgQx733EsvQt5T45u2GdvTqnkJtEI2ppFCBqUTHJ45JQ5grXUkZMaggMl+Mt
 aPxTmdmwTQMwei2MA6RAMci+e1ThoMDGHJ65iZPVcQuR3uoGVr3a1A34u7ONl2xNF2RPaXeYptB
 VmkXFZ3jJvWp0DG4KNh0eLwIS5MK0BM26NmrsQo5tSRH61jNPvoUbjQjRg1Ja9BQ6ztUm4Po5nL
 Cy3KdZt2udP6TOqDQ2f5Twy5TzGpb9LtD4GDo1CPApAYm3IeWBA+W615pU4bH+f4HpPRqX5eGBB
 9oINCQ7qOXpuxt2oo=
X-Received: by 2002:a05:600c:e54a:20b0:4a2:18d4:f9e0 with SMTP id
 5b1f17b1804b1-4a966f20a84mr82471685e9.25.1793281946490; 
 Thu, 29 Oct 2026 06:52:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e4be4b2sm78761805e9.2.2026.10.29.06.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:52:26 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 13:52:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
X-Gerrit-Change-Number: 2070
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2070?usp=email>
X-Gerrit-Commit: cd427dd611e34c9ae67b671e0be9faf0244d1296
References: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjgxOTQxMDAwLklmMzM1OTZhYmVmNGU5N2FhOWI1OGYxMmNkODY2YTVjZGVkMTdmZDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a6bce3b5df3b92da5da488c35b9b01e286cb2080-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMQYT-000000003cM-1PKs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_provider: Fix
 compiler warning with clang 23
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2554784362440631303=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2554784362440631303==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EgyP1uFvkEY="; charset=UTF-8

--EgyP1uFvkEY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2070?usp=3Demail

to review the following change=2E
=


Change subject: test_provider: Fix compiler warning with clang 23
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test_provider: Fix =
compiler warning with clang 23

With --disable-management it complains
"var=
iable 'mgmt_callback_called' set but not used
[-Werror,-Wunused-but-set-glo=
bal]"=2E

Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/unit_tests/openv=
pn/test_provider=2Ec
1 file changed, 4 insertions(+), 1 deletion(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/2070/1

d=
iff --git a/tests/unit_tests/openvpn/test_provider=2Ec b/tests/unit_tests/o=
penvpn/test_provider=2Ec
index e5562ee=2E=2E5d31da3 100644
--- a/tests/unit=
_tests/openvpn/test_provider=2Ec
+++ b/tests/unit_tests/openvpn/test_provid=
er=2Ec
@@ -42,7 +42,9 @@
 #include "test_common=2Eh"
 
 struct management *=
management; /* global */
+#ifdef ENABLE_MANAGEMENT
 static int mgmt_callbac=
k_called;
+#endif
 
 #ifndef _countof
 #define _countof(x) sizeof((x)) / si=
zeof(*(x))
@@ -156,8 +158,9 @@
     char *out =3D NULL;
 
     /* indicate =
entry to the callback */
+#ifdef ENABLE_MANAGEMENT
     mgmt_callback_calle=
d =3D 1;
-
+#endif
     const char *expected_tbs =3D test_digest_b64;
     =
if (strstr(algorithm, "data=3Dmessage"))
     {

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
Ge=
rrit-Change-Number: 2070
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--EgyP1uFvkEY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">test_provider: Fix compiler warning with clang 23<br><br>W=
ith --disable-management it complains<br>&quot;variable &#39;mgmt_callback_=
called&#39; set but not used<br>[-Werror,-Wunused-but-set-global]&quot;=2E<=
br><br>Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/unit=
_tests/openvpn/test_provider=2Ec<br>1 file changed, 4 insertions(+), 1 dele=
tion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/70/2070/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/op=
envpn/test_provider=2Ec b/tests/unit_tests/openvpn/test_provider=2Ec</span>=
<br><span>index e5562ee=2E=2E5d31da3 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_provider=2Ec</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_provider=2Ec</span><br><span>@@ -42,7 +42,9 @@</span><br><span> =
#include &quot;test_common=2Eh&quot;</span><br><span> </span><br><span> str=
uct management *management; /* global */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span> static int m=
gmt_callback_called;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span> </span><br><span> #ifndef _countof</span><br><span=
> #define _countof(x) sizeof((x)) / sizeof(*(x))</span><br><span>@@ -156,8 =
+158,9 @@</span><br><span>     char *out =3D NULL;</span><br><span> </span>=
<br><span>     /* indicate entry to the callback */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span>=
     mgmt_callback_called =3D 1;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span>     const char *expected_tbs =3D test_digest_b64;</span><br=
><span>     if (strstr(algorithm, &quot;data=3Dmessage&quot;))</span><br><s=
pan>     {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2070?usp=3Demail">change 2070</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If33596abef4e97aa9b5=
8f12cd866a5cded17fd4f </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2070 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--EgyP1uFvkEY=--


--===============2554784362440631303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2554784362440631303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2554784362440631303==--


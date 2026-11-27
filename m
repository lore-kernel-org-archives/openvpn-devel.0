Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108D606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BwgOaCCj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ke28o6Ju;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IOucCeSF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LiDxlioL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tEyYHOaK93izCXHW79O8gVHF/YykCfE20b6+FFKmw4U=; b=BwgOaCCj0L7ObWuizV9yshNjHv
	UxMl8MltBKxHAB5fEAocYqq9nKXWUEFF4as2ExrAhwCnwtfa1+F83mrzmfJ9twhnVJ5dfRQUkWEll
	tOLG2VNnq6rNjJdaYs+f/nF3/4RY3uPPJ2pFUVEn7QS/PTFKck4GnxaQZlRPX+5XopPE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxTi-000000003Wf-3yrB;
	Fri, 27 Nov 2026 15:03:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxTi-000000003WY-1C9p
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:03:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X6DEBqh6rPLzt5asFZauphcDuhf6O3syIuunwTRrkgU=; b=Ke28o6JuZOn3tnRxH8vZL+niYt
 zz3Gfg/VC/H6yeuOUSbYq2/qMhxO9hfYE/FaEtH0tME1jECXbdi0RaOVbdW00M3+hDiBZDSS7bDPZ
 H3dyj/6ABcA5K01ayu9uerGacdpWM38U//eFX2RrJxMNUPah7a/L5ouGtNWq5bOlnkkk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X6DEBqh6rPLzt5asFZauphcDuhf6O3syIuunwTRrkgU=; b=IOucCeSFDQFc6DSd11VOlf6EH6
 +HaIIciv4O97vlFPkdcU1kjh2WYYwmdTs5YUdxBiSSHk34kq8gEz3Wv6ueMocUoSis4QaEyCQsW5D
 fp57TukhLvgwiFy0ID54d2rCshI/Fky3/F6RDeScd0JN39fnFDpLyAaW6KZcoB6Mw8VE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxTg-000000006nQ-2r1c for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:03:10 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so71638015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791782; x=1796396582; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X6DEBqh6rPLzt5asFZauphcDuhf6O3syIuunwTRrkgU=;
 b=LiDxlioL/Zq3Eqx0r8btGKSrsrLG90EmZJjEyqN3EWdDo8jI9BNIn2DW5vbW9mpt/j
 wFJlygdWhs+l0RkP9bYy6j0Hv9MMfv3T6Lp0Vcu2w6bh7xGcegoSPe9rEd+OzgxvEQ3J
 1cgEtotWFDfzCdq7IMiMBeJZ2MOa3COF7tcjK/aUJ1W+DYHrCPYF5/AUktxfTpwBV8rC
 2OXwZKm5GxaSmpZCepV9jBHMaoFnFJFXZe2J8xm+HooOrIZjOrtY0TZWyJ2HUx4i2cKg
 lVfKk3A+ZdL3ec5XELGdiowWN7zordMEEtVlq7r7EmsF3NnggdzFQ29IKhpIegCPR67z
 kZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791782; x=1796396582;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X6DEBqh6rPLzt5asFZauphcDuhf6O3syIuunwTRrkgU=;
 b=Wdt/eoEfdtycNIo9OAvJcggmefcUadUOBayjnaIVwT5GIIBYk31rKvDM5HgR1P9Kmf
 r1tn3Y0+X2/sfDFXmOyADbViUZy3gAwWhg+wDIzihZIWYiyiDrypbkc6ecyKNpYYeNGO
 idBFbC4JL6bva5Yuu16UZVfH0dyXAC4p2SjjBXz9t7vnG7g0QnylyYN8yA+ukt6q3cea
 fiTXsgo9GcCa1hpw2HBF11Nqo9XRIRWMbMyzHrM57pt8Bh3We5Eo4D5YzGUG2wLz4F0l
 FsOlO1oJitQ4UUcaTnuDWoWX3Z9wgqEE/wiDxLd/X/t+8fvaRHzxoMhMnTS2R+b6ttt6
 U2PQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEmrR7yZg/k73diAGZpuuvBm0QzTiNbq9IqPVSGJnfcUxwBqm/omG6orX9QEBPIVVYaGVh9s8rYtPb3vmc0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8COTyWCRFSXydfrTuozFXWhIvKN/K33p3XuEuHT8KbIsg+Zvm2
 r71SYbBHUkTrQ4hUqLn3aRn+6GAOvB6czdk6b49fprQM5xPiPdI6mHjNv07qDewnoLrmwcB6icG
 eFX3DGP8a7vbjpkUlC+zuLlfAh53eENuRHIJZvtm5UBzmK4Fz79sgYj4Upjr8rfQIfr9EuXCjjt
 OYbOIeYQ==
X-Gm-Gg: AZFdTZdOLVy/Zzws+sfGCdGhc4+Nmbh5PwYFF4uNTWXigichzlYDY8KbEpuFK4Utp6s
 OpVT8yGt7yIyq9Z8qsTSHtU+ljtaCN9gqGYw+KKjZrhntcasU+PHfbKEKMSa8SUlV+aozXwKp8a
 15iXX5RemxKuDQDu7JCqqv3ic/8UnEHdMvIvIbc8dFED5FrBRfhcoU3YYCxjzUUtBIL5bj5M78/
 gMIpXbv+ZNKzzE1VEuZZ1hEugwsBIgYz1cZng2L2cTi7pk7+9j7B2BRjZu2dIsaVlyeDp+sjOJz
 kF4zepoM8vkWtnQt7ivcMmUYxv2l5d+fMszk8wvQNS+BWt1y3OVNBtPiaFIgzOIrGDxl7Jw9Tje
 RpOhvFul9av3E4O2GgZHAtGC3qxr4zg0AqjVIVoZnZOPNaBKhavYzKKmVv+ZP0VUECp3nGQeWnV
 19G1qYbdtLrBAF7Lk8g+BcBMWZyABw5cvQajbdtvoP8eEIoApAybR41FlmwoOoWLJXnuakS5/44
 9Lpwxw4zEHG2IZsmSSjcgyEZSxyUeD4nxQHIXZEagw20d5/RcJZp/cVCpDQJoR4VdeMdiQoikHt
 YWBbyvYpynVXJO4dOaSLHVpOgslJtZJ+u0p8vNGsSwAxRO0mhg4DSpZRikGr1BUkyHaDaLa8MNV
 F1HLGWAvf/HifKxva3xRxVMsqC5kiGmPay2l7UpSQo7SbyDnalifJK1TJz5Jc/PrEqQfkEfAHb4
 HxuP+WnvE5f5/XhyD8OhBWEwFYpqD3jJF4xEbc
X-Received: by 2002:a05:600c:a05:b0:4bb:5e6b:49e with SMTP id
 5b1f17b1804b1-4bb88807c0fmr503358365e9.6.1795791781591; 
 Fri, 27 Nov 2026 07:03:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f1b2sm44188593f8f.25.2026.11.27.07.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 07:03:01 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 15:02:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ced
X-Gerrit-Change-Number: 2364
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2364?usp=email>
X-Gerrit-Commit: 16fdb69610255055eec11a639bc0d4161dd3d515
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 15:02:58 +0000
In-Reply-To: <gerrit.1795791606000.I7aa7e2f15d63e8e5dc2449c46db075e179627ced@gerrit.openvpn.net>
References: <gerrit.1795791606000.I7aa7e2f15d63e8e5dc2449c46db075e179627ced@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkxNjA2MDAwLkk3YWE3ZTJmMTVkNjNlOGU1ZGMyNDQ5YzQ2ZGIwNzVlMTc5NjI3Y2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ab4eb3228726cc562af428162766b97c439ade0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxTg-000000006nQ-2r1c
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pkcs11_openssl:
 free the BIO in pkcs11_certificate_serial()
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6032341231192386537=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6032341231192386537==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YOAFPdI8kx0="; charset=UTF-8

--YOAFPdI8kx0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2364?usp=3Demail )

Cha=
nge subject: pkcs11_openssl: free the BIO in pkcs11_certificate_serial()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2364?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7a=
a7e2f15d63e8e5dc2449c46db075e179627ced
Gerrit-Change-Number: 2364
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 15:02:58 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--YOAFPdI8kx0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2364?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2364?=
usp=3Demail">change 2364</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2364?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I7aa7e2f15d63e8e5dc2449c46db075e179627ced </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2364 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 15:02:58 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--YOAFPdI8kx0=--


--===============6032341231192386537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6032341231192386537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6032341231192386537==--


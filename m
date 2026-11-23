Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A48606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c3zfQku/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RN9WuOWv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fILwx675;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FRDNea95
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ksq06HMgE71UQ4DpiaeJ07hRoCdETkRp439TlHbt1fE=; b=c3zfQku/zyx9/nzOlP4AEyXUNZ
	8X/YXcSEccMxb/OJhb8u2bBgTKY8tzJp9R0JPH5gzibmyWIxXvT5TXVYWxWFZJh7suQIgwpRTcq0O
	+NepW/tk8yghYBgL6Mq24NgwbW+7rctxgP4eqa6JnpGSJidwjZXwn1CU/X2xVq/MA4CY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTce-000000006eD-0zv5;
	Mon, 23 Nov 2026 12:58:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTcd-000000006e6-01Ps
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:58:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8H4y2iA3UnUR8aEdeI7f4SJdQjEmlXg8b1h1GSISxBs=; b=RN9WuOWvm3SBzDCqlKg6BdzFvr
 kmNDWhVgiDpjoVWu8ZF7q6BZiofHflr9ufWWWZPhtaeVUUC7mQKtTDhTJuVt47oBqCyq7o+LOGCSB
 3YZkk9T1UYlajvg2+Ro0wD4vowycwYb2ot4gR/ixmqfIv3IGftK1fj6MiwbiV+OBAuQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8H4y2iA3UnUR8aEdeI7f4SJdQjEmlXg8b1h1GSISxBs=; b=fILwx6754PFpqu+NTSpFB+Ll1U
 ajhA00N/Gk4FWMKxYwLfbYWj3+D+L/tYLrETO65UY0mJwJ2RvT+4vNik4ylN+1bvoCzv6w4idbPNe
 mGnPQMagZArhlGdkacNJOK38h7BekPnfj8fmBMg6vTPoWx+lD9QI5NyS7EtkIDxm+OB8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTca-0000000020t-1l8N for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:58:14 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso1514215f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 04:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438686; x=1796043486; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8H4y2iA3UnUR8aEdeI7f4SJdQjEmlXg8b1h1GSISxBs=;
 b=FRDNea95APnZ2HbdESDR/NVv5msVyrY49yWR9tpgW968tCH/FHn9OwRxIImRJPHzYY
 /dmx9zASx903LOmSdVz8CxKEH9x4ejmEk19QqzOwwHylwHm6iu7ZqlvmnJz0iev9djzm
 KgyDmlsTRNZWNAF3DHFeK+eDZfBxef1uijSM0YYvakvfu7+kbxrTsMYq/52HHl29FCDk
 rNSHAEVWATd2PEQysGtpsvKhyKpWPODHzo3a93KSjh0gaKIavADnQxQcvBndYMu9sA+e
 wsCR7GgfP9Sp9t0/44WJwvYj5Zc9EAo/7qlJBiuEogAioLZNXRC+dd0aLy1NUjitDASb
 XY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438686; x=1796043486;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8H4y2iA3UnUR8aEdeI7f4SJdQjEmlXg8b1h1GSISxBs=;
 b=xKmbLMR2wSq939AW8JbNYSgSI4bxp6r2UmsWQ/4DvIn3cz9Q9MrlYtdfvc414hjmIc
 nZulCrp+AnVgbtOPDQCUVaeOZ/5zq6sm3ZhHwRXCdmTeXvNN1aV1eOS+HNUib/rVg1TR
 6f5K6JzRA6xN2/tSZEW7OT8J/R898n4EjtLW2Nr/FtyyTWEN5/Xaj4xndt7+guK0BYwe
 X76VSG0nig572zdnCGIi3BOOm4dP0j2uxdB+AxKqujsKBwIuufsq+Ngmnn2KT9mziaWG
 boHzjBdvxvZcpvOeYNbZwa0JAEnLxrxXqnvmXJr0mn/X08FXKhcEbQQKwYR0bz2JDFzr
 BI/g==
X-Forwarded-Encrypted: i=1;
 AL+hErHnzbugMCj+hWUx1ETr0uTRIUNatV+it6+awq9EgUkca1rNdaKAyTV0nl78z5hl9hO5OSF25x4kGvS7vkAz@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9duk9qNd4vrvZnxEqLOnFSee2FEOrHVVkf5DGmDmE7TDVrDNg7
 z9kSec8rr3vqyRGRQEm+z5X+3uuJYiWLkUKIE63Azdo+CqwMHAKtdXPZMkP8fJn5Bo4bmRNOyCM
 mGY7mmlQrsBBLr5LSJ0Gtcb95uO6mG1yB3VKh6NlEMaUIGWpy4Mrx58YC5TPlT+4OW7yu
X-Gm-Gg: AZFdTZfTadq42v01KBC8eazSdUz/THzPFBB0i2Eq7gxT3KVDXJF21g+LYVqwnGJ/qtp
 /um7Ou5IZrYgoX1IOwy6NTybyY4DDJDS+R2OXlMSD1OzwI6VGBe4GvePLqNwfkw0iLySCauoZaj
 BpDEDFbvWiOHBF1QJAGEjEbUGoJMeIzIvj5EXKySAsu3zYN7b0B0mWkuX933nOEqE2C07NQc2+N
 iI58P/kYLWRnCpskdB+f0VmtHlXkkMNJfks2DjbnTv8kopu3twdRUedIvecEGN9nHw18MW4Wbol
 j0W3hpd0mcBnV19wIzEHxG3fLnfRs+Jin80ozdT+wduO8JG7b3ex6gEK6N96+D4wefEw8Xk4EFu
 RyAz7z8/zJulua8mOOgPJXa5eHcVIsCQiGXsucDEQTsJkOar9lA8HpYfIy8S/9D09Fgdd6/IIB7
 JVnNbGGDY2H2d0LkgIwOkpxmRqMkKmPN0SK42UUYE2jZittrSOYK55oefWSYzBiR1X92rIAkhqY
 /THfX0OJE1rAooO0Jz31/ktIY1OtBNZYE5hnOafaVAlmVg2WtEa7UNnpneCAnxcTifgQarlQhDq
 TUHAUoF79aTm1jcezlNn5T35gW1ElBiF9gQuwSFysuRLYSe33RIalII6aioxtCPS3II48lKGuBY
 hvVwDwPRQWKL8VJ8hVOprRxuWtSGy5m6pl2ZLdoSA74fJr+kYSvgNN/tbsv3BwBjBoUWJVnFk7B
 9/CVMDJi7ncmZQNgs=
X-Received: by 2002:a5d:6691:0:b0:4a6:c3f:9d0e with SMTP id
 ffacd0b85a97d-4abb3d2c0bemr15151243f8f.44.1795438685629; 
 Mon, 23 Nov 2026 04:58:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm20617165f8f.18.2026.11.23.04.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:58:05 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 12:58:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
X-Gerrit-Change-Number: 2238
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2238?usp=email>
X-Gerrit-Commit: 28cf00257af563148e87c13274adad29a482fb3a
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 12:58:04 +0000
In-Reply-To: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
References: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MzUzMDYyMDAwLkk1OGI4OGNhMzkzNGU1MmNmYzUxNDBhNTY0YzllZDcyNjA4NTdjZTgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1af40cfdcf60522e4ce780a5dd95f0cbbdc69a69-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVTca-0000000020t-1l8N
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: drop
 redundant NULL checks
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
Content-Type: multipart/mixed; boundary="===============2016525489302431960=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2016525489302431960==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xQWETtDpZBk="; charset=UTF-8

--xQWETtDpZBk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail )

Cha=
nge subject: manage: drop redundant NULL checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9e=
d7260857ce80
Gerrit-Change-Number: 2238
Gerrit-PatchSet: 1
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Mon, 23 Nov 2026 12:58:04 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--xQWETtDpZBk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?=
usp=3Demail">change 2238</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2238?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2238 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 12:58:04 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xQWETtDpZBk=--


--===============2016525489302431960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2016525489302431960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2016525489302431960==--


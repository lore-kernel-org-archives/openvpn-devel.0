Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BC606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ez0LI1E4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FBcfO2Ns;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fJU9nX7I;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YeK+WkfK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/RmosY40UhhQNt1TUotGcWf01ZuFvPGsou5oVdhyp3o=; b=Ez0LI1E4txLb1gJ9A/coKeYOsN
	wsj2f3dI/6afYSRuSNrQP/FI2KdMm//ZwRcNem8vWXOm2MXUrGU13ka6O24jThPj78b8QDqlVrBk0
	WGSHM963LprHmmdr9D25abICeO/Cm7SVJ4MDY1bL6RBgAdRfUlljkbGI7d4HOxnlgkzk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRVVM-000000008W9-27kQ;
	Thu, 12 Nov 2026 14:10:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRVVL-000000008W3-2plX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ms3hkfuwIdFSNjXEjRX0F4KTLS/HwHLULuvX44Tq3wI=; b=FBcfO2Ns753Ars6Ezt62dtLXN1
 8mwR3bL0G65eL7SBvAnBhcqaF3kjjU80kLrx71zU5sYRO6KsuIqkb9hzMM+ili4JPn1V2d0syEqnN
 IiKVTY3dBNN04YIpQMdEv6Cklgg37kKxWsDTN+se7PRuRjpJYWLriCLMkJ05Yz3XOUaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ms3hkfuwIdFSNjXEjRX0F4KTLS/HwHLULuvX44Tq3wI=; b=fJU9nX7Ibccrpb9JIzpaERJ0ue
 VyvXJNmaNFkIgw/eedXGXfS0GzfbN2olLCUIOCJey8xUYG5MfZ2v3zrJQGXJyHgQBCW6pg5CAlrva
 0RIC/dAEpteC+rGOAoN/3iPriAsYdJV+XPPG5OQW/rQ6Mz2sNeTuQSfW3V/UqbcNRCgQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVVH-000000002k8-1Qgz for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:10:19 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso42285655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794492609; x=1795097409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ms3hkfuwIdFSNjXEjRX0F4KTLS/HwHLULuvX44Tq3wI=;
 b=YeK+WkfKBP7VPAciwrRXz6YZtN0BI0YJqJOIIurnhqltmp144jrHArw0Z0ZyRwnLgd
 zvwQVv1O8y5vrVn9s2Equ3/hcHuI8sQQz3l/t49kI3nobS6wPmgThWXNplNQOTZFd1Zi
 6mbMsBzP80S7Dm7vWs+QUuhK8wWbDwKTL4KAwmINg8dRbZGD404Nr6gKte9GK/e8Tg6W
 odIPWHh1yPo8UmYRKPndrtEEYxN9R1fuSVgEAsWzfacMKxAdSd8LLJellSixVMFCblrI
 gHNHkksh+B4qrEYT7PWKODDv9y4Ogt7nrfzzIhFce461Dp28hrd0u5sWAmHiMTCEBjvQ
 5V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492609; x=1795097409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ms3hkfuwIdFSNjXEjRX0F4KTLS/HwHLULuvX44Tq3wI=;
 b=EDxKSF4LtQDPcSiBARBHQF0fU+hLUzKaZ7b1hiQLzmY27jittNAWqUs4L/eFkONPJY
 mpu/bPDkVGV6CSg6PEFkCF1qmqtv2L8Hm2SEVFlifwEMqdl6Lab3b3GQ2FGFpxNAcvk4
 Jyh6vg0TUvzQo0jE0d7gBtLgObaTZCJE83qnAw2BbVu3GdQGRTkkZKDgoRUDQPweYBEQ
 TqYvyp2zm8p6hzZOQsu+ktmplofSoEdWKE6QFVS6ZA1BjiG/pzmHsJ2VzpGHCwvd+C4o
 44411rPeDKpxn/wWM/SXL7Lueq8SJ15C20C0WM2w3sEroLtJX86iD/0zhaXViBb6/rQH
 0pfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEd1aUpKNzyfbf6wACBFnQsxV6rZzQo+zJLHnDnPJH6FFTOKkwaZtea5NDtHb4qCdphTmlK8zRHN/j9FURb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Gq34HHWBj1Pb0RjEseQfiScj06QLWP2pF2N67zo3aBex3DV1E
 NfVviFSfpCcT0wo/VzFdZ/w2bRpv3AubqOaszA1Fm79rUYpmAqVRjOuOAvaVisIA3L24mXHXWnW
 1J+HynZXxLRK8S4ez210XBZ/kSb+K3lGd/Dj6VSDBxJ8bE2+snmJczDJqD0uj+2Rxr0ZyyGVUls
 eQxYrpew==
X-Gm-Gg: AYBFou0jlx3VaIP0qfJDJBwTUxnxghrSw7kK+zBslaCraYBzHf2S9PIPZ26X+zJ7Ho/
 nAEO1DMX9JQZieK1DJP3UrpQJrWwcEGSlQSJGUCARwIYEFOQB2zbOksUwUg21VEgxOJgToJNQeF
 JW292j6gWzLV7wi5/zg59QPrD+nRFVi6xIeMrXcEvpWLWqJyyF505csBKwW7S7ekyhGp+b5DOeE
 YuSMjeOT63dYbtEIc6QMlNhfEygi5/xYA/VJCI+YXoGkZdYWD24mLU3kU02FrGb+jAbp/L/5pEq
 m27nv+/38C6iWPXYK9dZlkS97ZBIXIE2pJWSQYXvNbX6GHRszYM6C0QD9KO0nWFA57whV6KiFe2
 bfbP8P0Rkay5s8lAV3bzLheDvdibd0BnjM1IxR+i8Fe7D71PvsdDjifMFONrVZUfQnBfVUsMQqz
 +C3dGw4sntQUusC/BqzQseHT2zpDu6uo0NWk/9iJbUkS6ifvKMjHLvQEkb/oYqqGWwz/fVjUVkd
 25+0+dvz0r94S3q+SbRuUVzaRlrb3Bp7fc1J2IyzfY26FVlzi5DPxspr/h+ajZoDg1rhe57Jb8f
 WCGTlXA4ztFn0uJ1fwFNGDVtDlMcCi5AkRQbi9MIMMNi41zY3x0xEC7jQWEImBTWYO7YOEhjMQc
 SUTTO8lTQhzsQwvHK1hXlQ7otzQL4Es32ZMH1EBj1QCkxJ9Cdso0+ZiGBcZRMrIANTZC/ry+C0y
 0X9wM825TrqFVUQhMMBSPHjWaz+pDrdyY6n995
X-Received: by 2002:a05:600c:1986:b0:4ba:eb:eb9b with SMTP id
 5b1f17b1804b1-4ba0935dad6mr105684755e9.8.1794492608512; 
 Thu, 12 Nov 2026 06:10:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm17262870f8f.44.2026.11.12.06.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 06:10:07 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 14:10:06 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
X-Gerrit-Change-Number: 2178
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2178?usp=email>
X-Gerrit-Commit: 7b3750941fae3ea385d73250bc8b599700c20a1c
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 14:10:06 +0000
In-Reply-To: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
References: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2MjE3MDAwLkllODc2MzJhZTM1MDNmNGM3NGIzMjcxODZlNjk1MmY2NmFkYTY2NjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2143047932a033bf2d381e874157c687a620ce2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRVVH-000000002k8-1Qgz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_digest: free
 the EVP_MD when EVP_Digest() fails
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
Content-Type: multipart/mixed; boundary="===============7703357156823332016=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7703357156823332016==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zWnSwnMVh18="; charset=UTF-8

--zWnSwnMVh18=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Demail )

Cha=
nge subject: xkey_digest: free the EVP_MD when EVP_Digest() fails
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie87632ae350=
3f4c74b327186e6952f66ada66640
Gerrit-Change-Number: 2178
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Thu, 12 Nov 2026 14:10:06 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--zWnSwnMVh18=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?=
usp=3Demail">change 2178</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2178?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2178 </div>
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
"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 14:10:06 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--zWnSwnMVh18=--


--===============7703357156823332016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7703357156823332016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7703357156823332016==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C4606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W+UyVW9D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dZ7cONeF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lCG8IRI3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dPHuOwdO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxmX+w1M8iaju1it0JeAO3iShRimib8L/2BVxxiVpM8=; b=W+UyVW9DUoRn62R/7YxPdAmeg0
	8KvqnzJb8/u2nwuSZSm/5ybKCEat5LVzipLXO1+n2VN2ESTArClmmL2gbV+hkWb74gQHevzBuCtmj
	7WStDBHBtbRtGVqWyTlVx2q4QEIStzqib8uCYefD5aCrLY8v3AgrkWlNvVKr+arogkdI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBI0-0002E8-W4;
	Tue, 20 Oct 2026 14:58:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJBI0-0002E2-5r
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:58:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ppRNE8ZhTrBpsasIkdgcmiNtp4WbocIHVRT5d9BN/Mg=; b=dZ7cONeF9MSoKfWcwzfQ2vT/R1
 x+wl5rInPIEF/obwhUQb7dP2k9YS4xPoTIctLiTqDlC3Ghtk1xNnmvQF51UKaHyYuH+YD8J+QGelX
 o3SyFmT3xwWe6QNFFaKGJDRWTiYI8YAX+NlfnzDgXT4M6uShtSxW5LpMBXARcek1zrsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ppRNE8ZhTrBpsasIkdgcmiNtp4WbocIHVRT5d9BN/Mg=; b=l
 CG8IRI3kSO4jpP0D9T9g/JRuYgQn7xvT7RXiNODUukwI4A76o5G5AXLbgFL513muwhGUMmdJnrJjv
 ckfbf79OFlHz0eFqfnB1M6v2gDAvXzoaoJA1dSTMZE5ctcCnIs+h3TUQw2vXxj2CDJkPjIkFQVUPj
 1ygzmdQbKUdej8RE=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJBHz-000452-AL for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:58:08 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so591299f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792508281; x=1793113081; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ppRNE8ZhTrBpsasIkdgcmiNtp4WbocIHVRT5d9BN/Mg=;
 b=dPHuOwdOjV1w7rwDU+nOOxtaNNQtJXzdlLnDk8WNhrGj6pakLphDKKqMRWhYCLMvOm
 uTUzfhaCyCZQTS3G88kkeAJCNrkIDa6dbwqQB6M2RPkIJrjmeMtZL3ThEeUQv6Y9zYe7
 8t/znfTGwoZT+HKzeYvlRzEjhOZlDH7Fx6J/ml7LAFHU/Bw0K9IeBi6EJM4zpmV4mtz3
 lq7q/KGMS0d04TFgToVdr1gsRUtt7xcWhNtqKYrejGRcPCJDi0pZRPTy27qP/kFOf9FD
 o481yCA2hgS0t07bqeWdBgz4pc8O6PfNNengxFM/dZP/J/8MgaqPd3KQPLh/+thK6Yex
 4MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508281; x=1793113081;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ppRNE8ZhTrBpsasIkdgcmiNtp4WbocIHVRT5d9BN/Mg=;
 b=qkM91M2NaOFGMJ+t/6/0a7REqnoHpOi4MBPjKU0I3gyQc7NwpxMqRsFQoTqg3KT2KW
 aLZsLmRxAG2CMWPYYq3d8JlvfTXzdA8Nn9nvFboUkKid7XVgElhFivRL/vG/WKvf5ezn
 CFl6j9YTQJ5d2Hbh09S+ByFdjb/EJpLxmGj9e26/Jenw+MTYerKCs+IuMR/vXMFZYsSq
 6R9kzmX/0lo1T66YCFxrVaWxJNzEzoCs9uR/UGo7odYlfwtOXL7+dkeUwHZucrpmE37N
 hh86uxO15vkLuYwknAi1Y8rJL8sfxDePPyo3mQlPVa/zuWAY3YstceTslS6HyoMM0SRL
 g68g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkxqzFp5MBC8630T+l4VDT+xiGzFogWsuvY0vUpi6gS4QcKnHoFjOJ6gxQrVvrPrAfV3EFHF07V7pkVaw0@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ9VdT2LAaSkfjK2ad3HI90xsTNdajJsUIXvMgOtq01PsQmEchD
 r0V+e+kcnxL84GYAMnNXdGCHQWAANLwoQLEayFFs/yzVQgJ2EuoDqvLTFf7aTrv2FBmOEQRMV5Z
 uqD2oIpn79x3ORjAo+0B+hRbiCoET3jsWEqB+Bk5ChNCoWpD48/rniVsofYetlVhT3bE5swRXTl
 PQtaCC3g==
X-Gm-Gg: AYBFou0ozNsazXr46H5jzSYyUMxCvLhJ86olFXQOtzpQ9WRY20v7FX5+wkMBSAAkUi8
 IB5ntFHxTIimwhAEfFLqYEMyck9+Ozzv+FTWkLYxgW0q1TNi9SdAJ7OPSYd0kYfGOv7heV31YIz
 LrahRW0UEDRuSKpYEQNeVAF6FC6nKcsu1n6CCmDEZIJ7ZzBQky/4YmPFQSRxv4CFeWAme9MoR6M
 7547tZr/Z9OuMR8AaUeO+RvWYVtyHc3c0LPUUScmkv4Y/upf1GDyZlpx7HOABRXTf072dslHJDp
 5P+nTjAwdwjPApM4ZGChgyflb+MplNwhZe5SYM3saDBe3D0TjsbZ1zgEEjvAHM+o5e2t7ttjkpe
 QjUxg8phmAjTCBV7WSZ4FOSryj+9HeJmQee/vdXWtUjf5l8UwgBhV3OZdmM6iigQz9O4KYtpMuQ
 slLD2evuYufOYn5aD+RxIcEsjtDWRx+2lq6gQzGm73EnRBpoKkIfYNqCJ73cr9J58G9o0hI9nqX
 4BOwKEnj8lqj0me7HpAJVw8AkMqZ2hH20BDt+KeWfPNMmUoKGmladxyDg2w9ajsFD4r4h+KNuej
 i0OuXlCY68KSXIaje8NR+Snew6NSskiI9j5uYRgW0P3ZkA25E1AOjQ6xxbhefRwJ4g/gmsA=
X-Received: by 2002:a05:6000:4b0d:b0:48d:f1ab:faf9 with SMTP id
 ffacd0b85a97d-48e1e76daa2mr5486662f8f.16.1792508280516; 
 Tue, 20 Oct 2026 07:58:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80fc6csm6451643f8f.14.2026.10.20.07.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:58:00 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 14:57:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
X-Gerrit-Change-Number: 2023
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2023?usp=email>
X-Gerrit-Commit: 2d5818e59110ab3f3a3d004a8f90023239daf4f8
X-Gerrit-Comment-Date: Tue, 20 Oct 2026 14:57:57 +0000
In-Reply-To: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
References: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDI2MjczMDAwLkk3ZjJkYjYwNTY0ZmExNzljZTVmNTY5Nzk5MTJjN2U0ODRkYWQxZTFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <019cbeaab2611e47b8079728cdf9946c25a26870-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xJBHz-000452-AL
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix broken
 unit tests after commit 5c6fbd0a11
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1910049408079948425=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1910049408079948425==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LuJJyWMyWC4="; charset=UTF-8

--LuJJyWMyWC4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Gert Doering=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail )

Change subject=
: Fix broken unit tests after commit 5c6fbd0a11
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I7f2db60564fa179ce5f56=
979912c7e484dad1e1d
Gerrit-Change-Number: 2023
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Tue,=
 20 Oct 2026 14:57:57 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--LuJJyWMyWC4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Gert Doering=2E</p><p>Patch set=
 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail">View Cha=
nge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail">=
change 2023</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/202=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2023 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Tue, 20 Oct 2026 14:57:57 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--LuJJyWMyWC4=--


--===============1910049408079948425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1910049408079948425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1910049408079948425==--


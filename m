Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A6606B117
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kaRzNj7C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S3XOkSZ+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HybMUEdp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bYAUjHGb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FEKvGqxjaqbErH0zeMDWTIGCaGFRf+tpAgJLZ0tVuxs=; b=kaRzNj7CD/Ms3KQnZZ2aeKvfug
	+wJBfEE6pEmotW05mM+Bo/yNsPk4GqnO7e80qqtG8dpl8tc154GBq3b9BeA8crEwvXkpkGs5kGgfF
	DH52cEknIt39khJKxjtPb9Ua6H/3By94VVyMOrEYF4jHFS00d91CbKgNV8+D0h56fyvw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBxA-0000000011Y-1OJx;
	Tue, 03 Nov 2026 10:41:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBx8-0000000011R-3PwP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FzKo4s8yT4GhWj2UhVBC8I6vbXh+d/N0JG1qNn8PPNU=; b=S3XOkSZ+qahzoGrovvBr85silC
 6YuoqP3Hiz6q2iq08mNi3KAjM7qLlqO+fs7SvgpRzXHHUeprBDBPw3xv4SBh/2akvdHAf7UEs3ohl
 HWF80Oxh/SSx/1TzqVWBDg3zSfRrdMKbyVfPncywKJU18Y80LsRE3sd6G8Jawpttuzlg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FzKo4s8yT4GhWj2UhVBC8I6vbXh+d/N0JG1qNn8PPNU=; b=HybMUEdpck2Y8H0dnWx5ELNT79
 roZd/9iqFd2cE7fsAg5Sv7I1Mtv7ZWzoyyf8GXA0W2e3zohDwA0Oq5/Gx197QLmFSjah+aXlvELIv
 keVwprDjhcy53ayH40ykvnHbfMX06ulbOEMBI0lGRx9XovoepmNQbrstMY7bGykJWsy0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBx7-0000000018s-0YJS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:41:18 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so33901885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793702470; x=1794307270; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FzKo4s8yT4GhWj2UhVBC8I6vbXh+d/N0JG1qNn8PPNU=;
 b=bYAUjHGbASwKldbf5W3wwzv33DysvWgMQFa9s9ohqvJH9qFGWmBoqe1mIzz7F5pr7l
 y8HvVWjOjFFYBATPQ8falGc7KCc03ERK3SnB3GZUOWmbcsGhcfyW+0AMO1JRFHHx0qPs
 UqSAzkTMVY7ZF85rImbRJu295+t7qTbHqMxH3AkbVHlIi9CuIE2oai0XdD+qFOJwvKm4
 uj6WhOyWd+3iNUoWRCQtubFPp7nbb7UM75FM+qSmmtmZU6Na0o1LcJoyaXSTHepw8rBu
 tdkXSSYAtjkE7vJN4H2mxD1DAzMKxiym6lU1ci9yv6B0dUu1n5lEsGcyrmQJFD0ftH68
 v9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793702470; x=1794307270;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FzKo4s8yT4GhWj2UhVBC8I6vbXh+d/N0JG1qNn8PPNU=;
 b=HtZ72wxz/CQ5QbbbiGtAUKpRdMu4Fvelo0flcganFkksj01IpxhYmh2Y3nXQShUoMP
 HpPPhfy+6Y+shUqlRzK6qD2PeGVFZFcaPPZ2FgTgUh+glHsbDNyCCK2K89nz2CPEASea
 HbmIxzGkyA2ptYN33iPlOsKZXUTHW3jQse5Zn9fpBjnlbNKJXCNHvoTYOFGkiyVyPjX5
 lW306s/SmwiImYISrkuqHfb6qxL1kfkNxp8MrZubEjaz2kVgUnZz//2viizf8o+/9uKa
 mIzCSSE8+Ki30gp6OY7k3RS+hAiEnubVWJ1eZeVKaio0IC9YGsu1ebcdBM/gInlRREiK
 vvEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfCyW+NR1UQevaovuHqzlm6H8P30IGVjJTB2aTsQim99v/vYHTdsr3E6FSN1avbvYMNYG19bDbkF24KlAE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8+lr5zrWxP8N6+IqxcDCSDidNyoFVGU7/Hgi6mhkLYkagJ+6Fq
 E2hPt10D1jsI3zkdSdt5ius0fW/Yf5CUwI//Uw+EHZ2IWIYDErzUyB7Flbl6TV6ilbVo2Jdk1W+
 hVWU3CjZZyakKONFYw6c0dQwtRjRv9y9jx8I0cFAwqu2d3mQSc7ndICM5RHr3/BWWjEDk
X-Gm-Gg: AYBFou0nrnPEXzFPPDn3H/uidESFLAPj+Uxlgwc6LqSgO0YqsM1RCmsO36KzT5A3m1w
 +yywENTYva4zwUCaKpC/U/F2rXPErzrWpW4BdWhkkiyOKz/aLahDLDjieNDpatvbjIFcBfiM9Kz
 0aam/8e8NlF30Ri0Q/msTGJULDcyzeGWJxQY0wcUQJhCl/WwO4cmxEoC4AdxukxBfgMTH+GqV49
 IkpE0EQZ+aeS6lIRzyKYu9lSy0MCVLI6/2rhc8ttmfRBKkljEUso8j+282oUjX0O6+dzLtJQSdq
 fmOHURdBK3113OhnCcEIYWe1OGduZo82cfSQNtWgaR9eLTbZXXi2WNLJJTvtpuIijLTrTS6EZ/I
 kBswJPRD+LIdOcAU0gljQaCD4LYL9VD1GlM6EexZR6f1ssqq3PtzrS2gohlEqMaSiomyBVIXCkt
 xIm7fDd6TbFjL0oFACHp+MRfp02sXoauoDTOxcYeNS/eh+M4wSwwdiyOJsZD/FjbkF+d3mE3J1+
 r7DnHPfWnJnr97X0nuVu/yYXt4s7HMin83aaZf/QOv81cHrGoMFVEqrtOZWhtqNwy5HN6glJddk
 kXB5Z+zqa1IwP8jaFbz3ORn5Qef6AVyRgsw0WcpCQd30BSY1xSYcrC4N8MaOpgnSenJu8vPs5Wk
 NkXXoLsQXvov8yv1AtolLV60H76qMaQso+xGd+yZgvi0SNUnT6tt3ccl0HLvM73b2EMb4FBlalU
 aypWIm3khjSbYRTQ==
X-Received: by 2002:a05:600c:19d3:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4ac14fbdd29mr287206815e9.3.1793702470428; 
 Tue, 03 Nov 2026 02:41:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm21987792f8f.59.2026.11.03.02.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:41:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:41:09 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
X-Gerrit-Change-Number: 2051
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2051?usp=email>
X-Gerrit-Commit: e30b37ae898619b96ac42577cb58b47af0d2a783
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:41:09 +0000
In-Reply-To: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllNzU1MTY5YmIzMmRhODU2ZTk0MWEyMTRmNDNmYmIyNDNiNzY4ZDc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb1b60f8cd6512a467daf7ba3c579bf66ae71afe-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBx7-0000000018s-0YJS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: drop
 MPP_CLOSE_ON_SIGNAL
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1957531336129482184=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1957531336129482184==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8On90cvqqX0="; charset=UTF-8

--8On90cvqqX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail )

=
Change subject: multi: drop MPP_CLOSE_ON_SIGNAL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie755169bb32da856e941a214f43f=
bb243b768d75
Gerrit-Change-Number: 2051
Gerrit-PatchSet: 2
Gerrit-Owner: Gi=
anmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Commen=
t-Date: Tue, 03 Nov 2026 10:41:09 +0000
Gerrit-HasComments: No
Gerrit-Has-L=
abels: Yes

--8On90cvqqX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2051?usp=3Demail">change 2051</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2051?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2051 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 10:4=
1:09 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--8On90cvqqX0=--


--===============1957531336129482184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1957531336129482184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1957531336129482184==--


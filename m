Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B095FCA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CDJSUioRjgJZ6f7QkbFjqd1vnQzFeUqz7zeF+3RBPs=; b=NGYH8/8HNI8kafTUQh2TnSi12E
	/bRgIuu/xraIJYUnuB5aF3soK2I6aZE5c5vr1+CczPbg2WOfB0QlCU7INfJ++knarjtrZ10Y9uhHh
	Bq/GkFJE2Opqld0cemEbsQR31a1BUhk2c6lf22uZQqLrFgNuRTs5ozlKSs2hGZi31L6I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDiF1-0000xq-9w;
	Mon, 05 Oct 2026 12:56:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDiEz-0000xi-B0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kqljpmPLC3VxNuwfUuMVqSBrhBx99a93DWcD8Z5wGdM=; b=WvUc3EhecobpSFluNYsgVJResx
 isW08yLH9is1R0Q7KgKd9OGcB2bhPywVN5vhQjSvLK4yUkBSWFvr20OrTnZaqbx9h1fCNuXFImAC7
 pe3msS9G6NjOQr5WntUK+9SAQ2LqEUeAUNRiGpXNUQUBzHoZdyhQDUKxwkxZPOLMNVEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kqljpmPLC3VxNuwfUuMVqSBrhBx99a93DWcD8Z5wGdM=; b=f
 yhhgfGQOoZPQN5+1UFuI1cAeTX5tAW8R6ApZD8MFHhoNWp97Ch3y0caivUMNSssV3Tv8TDxkENeYY
 cLGTXXTgmE+m4AkF4NTmkUiNwRDonYff8+WTjpvu4epPYH2CTdGBmVEQqojsODWqS+PNUUyQ+zulB
 lkQ9b6nt1XejZlF0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDiEv-0007TG-G3 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:56:22 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so14969095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791204975; x=1791809775; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kqljpmPLC3VxNuwfUuMVqSBrhBx99a93DWcD8Z5wGdM=;
 b=YqoPHRxW2EQhO4PYb+G/SxyGqCU+/Xz/VTJ3zcV1siULPS31PXUZ3FsIpc8qNKSSw0
 lJm8RMBv6S1jOnglMAaAXXajRu9pL6+3ZgPB2XeN2eXyNeDBN4I80MWKjskNZneZ6el6
 nr5Wnic+U8TE6jNh0uOnYxExZ4oMJ3DOHSlZh8HMjWg0H+eKyZ1s+IMcIpp2sxU8x+w0
 Sth5OoGsa5qAm0W4a30v9ZVEgZ+e9EK3c3jwoWezIQhiJ6j5eJz+OQ2A00t6elHroVYB
 Tzh1+Opzc5yx2qJT1o/8mzlfNU+LgBELLDm9EA+w6SH2fBQvwzCA0tLiL1BvJu2ZLsM5
 mnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791204975; x=1791809775;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kqljpmPLC3VxNuwfUuMVqSBrhBx99a93DWcD8Z5wGdM=;
 b=ue6tpfUi1PsG2HW32wPa8Q6QEySrSV3PTjrktq6QCce6jla48dPLOE9mBWuN3Gbkp4
 EISUvMVzD0AQRRw3wxXTxuNpNdEPfgotHOTeSlzz+waJikltknVyFJ+5qgv1O/hnypTe
 a0hmDksSw3Slc6DF8a8A/M+ZuygJyg7hNRrkoYaKIFiKdUOt181o+oqWBwlbmiAtX3KR
 ksmp/2QC/PoEyvYq5+ANvzAtoySTZuq8BJsz/PrZHv0k6ogIsDMCwZXZDtCeI1IVXy7G
 5KhXNBhCqxfxmEIzuUaqMQpMuk9tawqzcNlD6R5PXxa9DpHtdWFol5GNFjDrcHg3gTgG
 sJFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3tDwsbaWBPy6oMt1oLQaWp1qtLu8ZitsYIoqSpOXdzFUY2dt9ax7Hrtlxq7glG66n+o49bGnnUnw+CEwk@lists.sourceforge.net
X-Gm-Message-State: AFuF++n9g9/8K5HO7uT00UvXgpQaDXGvlLfd9TOXBCqSXwfADHkT6bGn
 6GqbQ0xXqcShwzNmUXxjI2mNjK8kFJC41gxPSzOd6OjvuLgacVSPHeNFHlgPHdJ8+fji5YkgUTu
 8Kg4RCw60pqjdJzUOYyPKNkPnwzjN67dTUk6uqogV2RdwOj2ZszouKeof8nGqud8oZl2D
X-Gm-Gg: AYBFou1FuJISm0E5ED7V0b/GXI6tlOqtqSvL5d/hVVW5/B/kb8jQyR87erszw7QUvKO
 KNyz+s06+/3U2pLqbHK+U4Ptr7674I/JfVKuk2Yc3MrqcwxieDG9tpaaOgYu9GPda7sRL1Ftp42
 GaL/XCeyGmUHWJsXi2J+903tAYq/sRY8mSfxQd2eFPhRue5twbvNMvERd7QH3INcAA4xd9b6IKM
 mm3nz8F4PKncKfYTCI1zuXOHpzrNPziyKjNzi1ZqUoeR1DHqlqI9slQLv27a9t7OcCUWdKYVwzI
 bxOxRR9s/RAxOjSZmBdmDaI4fWpAgPNi2s7VXw4gA8JryjUGIRnb5cqqsqDbE8D6az2hDAbH6SP
 doo4n4QHgfjQt/+RMQ6i3EwaNe1JO/50KWW2wPowDGUyoTClAfsR+IqwT2qpqXdtzC3zmNqCiow
 949cN1QzF2lPRynD5WGWi6lnN5MnuADDYTRuoj2NNGpJdcKZjGGuO7eyRbzjR6vEOfJVTyPFAur
 NOay8WJ9HoFm6p+3hw4CSXjKVUaVlsb8YttRAf+BpWBYXJK9bHJLu5JL8sa++2UDkf6VHN3BiNR
 qdkyHs4cVm3TGQyOnuzzAExrbnLEAbl7dSHW4aJmGfkq77T/Ocy4bHmYQFML
X-Received: by 2002:a05:600c:c088:b0:4a0:1c10:12ee with SMTP id
 5b1f17b1804b1-4a0275194e3mr143594965e9.3.1791204974779; 
 Mon, 05 Oct 2026 05:56:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm3742849f8f.37.2026.10.05.05.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:56:14 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 12:56:13 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: d9769b4275aee5ef4cb47fba767b0327c795dcc3
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 12:56:13 +0000
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de1b2c5250ef9ea6e70a10961df8576eac98f299-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDiEv-0007TG-G3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbuf: don't count
 dereferenced items in the queue length
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2925272333741433599=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2925272333741433599==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GMt99Ylr0i4="; charset=UTF-8

--GMt99Ylr0i4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori, plaisthos=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail )

Cha=
nge subject: mbuf: don't count dereferenced items in the queue length
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1961?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9579a=
b9a3f588a3841bb90c9a4b930b7690e0b71
Gerrit-Change-Number: 1961
Gerrit-Patch=
Set: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>
Gerrit-Comment-Date: Mon, 05 Oct 2026 12:56:13 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--GMt99Ylr0i4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori, plaisthos=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?=
usp=3Demail">change 1961</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1961?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1961 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 12:56:13 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--GMt99Ylr0i4=--


--===============2925272333741433599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2925272333741433599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2925272333741433599==--


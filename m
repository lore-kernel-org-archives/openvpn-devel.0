Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5765EC4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56jFvff2pq3ManUdG2hD/OE2kEJ+cLifp3UtMFJjxEg=; b=inHuygGyRWU5e/Cie0RpzMq6FZ
	ZmxtqbT2TNBR89qWQ+siQGG4vzz8pemgICcHcrfZwFUOGzmTFhF01q+SzTUgwr7JhD5oipyEL9ge7
	qJjUw7V6eFaMN9b046/hsPKrF/qm4Fhh5/eZpjUMi+J5++c5mQzbR6OrDQKXkYVDD20I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjbb-0007IQ-Hu;
	Fri, 17 Jul 2026 14:31:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjba-0007II-LK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uqH08H46KyfaeljOW/gqPH3EkZJnNS2iZqU2Hq+a+FQ=; b=Tc/rMsPW+2Sr4y3Vbyzp+frv9N
 9NiX7sPADtsSCAhhA3HCl53w8tPu7/rqfDZTUVY7EcwfiIzDzk/J6XGVJzcDG733iE87cSwJ46fcV
 hRMzg5Mfi+bJR0r7nr1VqogXgQDavjSG8z5DPW87jJ0oXJX/uFKbPvHGYgyO7yrtSZs8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uqH08H46KyfaeljOW/gqPH3EkZJnNS2iZqU2Hq+a+FQ=; b=R
 +YZfozSdFrQ5SRfCFm0ZHPtD/p07D/K1qh/rxEqXSyV+meV1jwwYMj0EnJC59+nj7B+dfQ/KRvO4E
 flBM4Nz4umbdjT5j2x+MGbad6d8YFR28MGBXON9WFNfYE58jW0+VDYTLWWCUBsUfb8p9wXAXdLvju
 1dY/I5RFC6z6D+Ms=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjbW-0005MJ-Kt for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:31:56 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso1935095e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784298708; x=1784903508; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uqH08H46KyfaeljOW/gqPH3EkZJnNS2iZqU2Hq+a+FQ=;
 b=Pr8utnKSF1DZV9KNobMZu4eQbE8T4bddoj2Lf+/4P9VXySAKQC7gMpVPFwnjwJkllL
 ddN47Qmka+bXyu3MsDcOLEr4r4fwNELyTC3HUc3Z91VzVnnKhLRmkBVkzgI2xOBlNWas
 snN1Ejj2VbVFJE/Jvdj8tfttrUOcDFMfEuvCCh/pQo2GwYhDz6k+dwsgN/dyVtaLjcMR
 Z2y2AWO7fjF1llad7ocNUkjbkTXv7opHa2z9EgiSxP4Zk9OFBsFXq1cvMknSku3zBhj6
 wlVDTAvfty03hdQhn29Ia5lBHhOMVojy2mmOi4sTbiHboRHo5hLNC7u8ftsT17Up5c0Z
 MqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784298708; x=1784903508;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uqH08H46KyfaeljOW/gqPH3EkZJnNS2iZqU2Hq+a+FQ=;
 b=okJY5/U/9Fkm9nJLu0Y9WGOl99srOFYlz4HVilJj4YwS9hvWlQukNJ6fv4gpJr8+al
 UNAXN1WoGnTMWxX5tfvEemQBKizh9ucGDtlkqIYDLt/r8Nn62jlfZxgxUDOqpvPM9+FB
 R+Q81Sbsz//5ajYyXR9lBJ3CR8OA0qZnQhqBupJ273+gi5ZGEakTrzNPNVzmHUpvGH7a
 s6Uff4axnDJwa3S1/8LhfB5W3febob1nKyvmGK4kUpherS3aBQVoUbO66dOmamMd6hA9
 8N1Acr6mKFvYqs/b15Je1uuR6s6rZPsFOsnRLEWG6BXEWbGDDvMu4fZpHxgpBFVqxcBq
 bkKA==
X-Gm-Message-State: AOJu0YyXH9Tb79nG4UXRBTWIlSK8tQSKWnalCfNDgwWfOIQ0q8ge2tci
 HCwDmGrnrdHdhAXMqwKnbVD8a3vRsDUSs6mJqTKmQ29VKo4m5ZeDxX6SR7x6+rkEgHpZneAvMLg
 SV/lQoNcntRQg5UIthZfuOmtDCsU3Oxzb1HjbwvsNinohYbqZE+ZYWFxNDhDMU2uklORu
X-Gm-Gg: AfdE7clyCTfsHnMuj4+1wS3l06aYwriqLJe1feJa8cGSnu3UZgJQ4Mfq2IGVYn+Yf0K
 Vww7sI2eO5zhKWBL2chJMLOq4ES9DgbruUcinATZX2hbku7/TmJVe3roo4VKnlxp0/V39mF1hpS
 mMoyav9I76d0UdY3TnhnRXcMjKa8YZOOWvJumAEyc9GOCPYLlQi81of9aHFb75hsmL5LmRz97wJ
 WtYj6qEvtwhtbwlG6I19w+C4X6XTv8zcJcXwcwp9rn+PXeJuijIfHocFJutWrzUIAwxbbrx7nRL
 6aLWoGi+6iiFM6V4bCOeNLF2KWNkwiZjoOIKHOx6f464Fc+Heo1MvzC+Rd3s1chCVuHncqR0yDm
 eXy/M+/Dh7zya43D5A6O6VY34meIVzSMQ90qFLmtMZgtVcdt/KLCzgchEVaz9u1a+oLe4F5cu9I
 pBFH0B2tFPlpkLbvl+K2JdYqsKLllPgXRdb72GfhYqViZMRNKCloPNCTyns28ExClHjgZDUFcge
 aRbK3WuRNxmE+oPZtT/1SibKt7D0h6bCmp/0IVVdcp88MB+tHp4R7SuUy2pnS7qX3Vu
X-Received: by 2002:a05:600c:524b:b0:495:4df3:5187 with SMTP id
 5b1f17b1804b1-4954df351c3mr8239545e9.4.1784298707742; 
 Fri, 17 Jul 2026 07:31:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954aa1a231sm24235765e9.1.2026.07.17.07.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:31:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:31:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 93d8efc4aa02009f633bfaa8ed0622d7eb8d0da2
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:31:45 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ec8ce489a8f47ddf7b89ebdd13c9942f7711713-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjbW-0005MJ-Kt
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8732356738252199080=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8732356738252199080==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CvmKqhfJvk0="; charset=UTF-8

--CvmKqhfJvk0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change by plaisthos=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail )

Change subject: Replac=
e custom hash_func with siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7: -Code-Review


-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit=
-Change-Number: 1573
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Co=
mment-Date: Fri, 17 Jul 2026 14:31:45 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--CvmKqhfJvk0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Patch set 7:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f3989=
03ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Jul 202=
6 14:31:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--CvmKqhfJvk0=--


--===============8732356738252199080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8732356738252199080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8732356738252199080==--


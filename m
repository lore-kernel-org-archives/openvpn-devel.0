Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DD606A31F
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c5Flfb22;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PgPimrwX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h9IfQ6Kf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KNK+hfGG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nrJHmYoa4GE4GSwDLdi3b7ZeBUcOkZsPGtAztdABjXc=; b=c5Flfb22c3v3AW21SAkYdZk5Ta
	qdhRo3tRssNUQGt+EwM1yVUG1Vgy1WRsyAMbqaoAQVStHva21/6SWzjSAivN2eUJSJ+vgrzQSIAGU
	Yv3AE5nZ3YuRYXQCW9OzMkBDdc+6fx0aC40I4qO8Hb2XenwsXo3kiRr2SBu2qSQbJxGw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXF8r-0000000073d-1vS2;
	Sat, 28 Nov 2026 09:54:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xXF8p-0000000073V-2fYJ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 09:54:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oNBbUo/SNLfwhpYpi3hCCUzDCPBrdNq4szD28HkJm5I=; b=PgPimrwXNtWaF9MeJ1BKyGIddH
 trOhaYYvYKZgSrKutxP1lfmxRau57d1l1oHbucGfc0l7ciqGPR2cdfDOrjHuXDZ591xUMw20VLmiA
 iKIVcfR2PmLGTDa1BUwA6ysW/CVfQA0ZUk/qLX+kEJ3CeGSvRWjprzyhY+PZHWwkF57g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oNBbUo/SNLfwhpYpi3hCCUzDCPBrdNq4szD28HkJm5I=; b=h9IfQ6KfkinNuk0ScMDTO+pbs/
 946A+UnezQDa45qbfJvMiENhdOhkYOqDix632KuKV6Sa6W5Pke7IQ35IA7c4TwFJ7ONK1CC4XxOSi
 l2EG9xCRN2GvY99Xy7YKJz1UhFOQtp7Jo27DT/nrq2gxnUQBmP7WNTdEqwzyeP4MVAXg=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXF8n-000000003vX-38gG for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 09:54:47 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4b52fcb410dso3644298f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2026 01:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795859679; x=1796464479; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oNBbUo/SNLfwhpYpi3hCCUzDCPBrdNq4szD28HkJm5I=;
 b=KNK+hfGGjWEkKAIqAwjMmEJlv0dZYiBF8fqwi80Apt7uTRWq+dXV53bj5JHeSrg2qC
 5XWwqeTShUnSchC55wi4IrFI0YIla1TuJ6C+blwCig/kXOLQHPRYOr6bWNPE4w/cVLyf
 gSscDrX9RV/jEV4EdtnUSHeZyG6b+iTEsFoCZLoZi9p2k701Y2QeTqgiPmo6hL5Cb0k4
 u7xTdehM6f/EU8Ns/ZYWjgnh3lzn2QKWx77Zhrab0jEhG0fuMWxPi8+iK4cnZwEuUE8H
 EcTalnPxy+LuDreia/74Sg35CNDx+x1rVm4EjW6syyyjBuKsQbrSvwSax6At21gYBe9E
 ZdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795859679; x=1796464479;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oNBbUo/SNLfwhpYpi3hCCUzDCPBrdNq4szD28HkJm5I=;
 b=XKEoa7xFjbv+R6Zotq2FsQGJxTYYHGgBK/LO+eqbEGAj/DUOsDqstCun7a4LxU+F2F
 W15DSZfqdfV6SfMbALfVxvSadW4rQcBTn1d/J3UhyrGJArIZ5x6oA7YSiUnK9troq0vd
 E8qfnMmcn1RMw7hOQsOW3OKj8anhISuanr+vw+xViz83lPY8aNv/EdJfSZ4gk/ux3i9C
 AW96V054ZyhYPERWrnM6nNjRok5l/dsl0MxG0mqdgDrgTNn/UcLM8bbEQA5ZDt3rCnQU
 /NR5MfCuOTMfmvf9nAu6oEnc28Y4CLiUXcl/f7rF2jsSLzBhnqUUgXV7oJlCEVPlDMUD
 vXkg==
X-Forwarded-Encrypted: i=1;
 AL+hErEKX6nOLvwFUfLIWSI9Pj4FV31R8t751C3pqFcTAhKpJPdZPOLNpy8plL1rRem4EfPRZPhtNhdEZJFxrkqm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//HC0TAEgxPKlXOA+AwLypMUZNjQJiXJ9oGpBliNY98vBvZB2w
 4wFXSVdrROXqA6nSt5pb/t6enxHNcV8GRmekIEunXBMXL78t/9Vd+mq65WMuVz+E3FknEU8dUZn
 vjXo7LAGLO9sn40LPrCbEhxAeDiVQxCgq1ZKZlC0s7MNTjF5vLqFjYrpMOBCgrLNlxGgq
X-Gm-Gg: AZFdTZf/F/lUZRAqeYdMiN/Tdg/Z7jUiKK9AlGJy0ccXxspPYfdQuQR/j6OXl0QYkH5
 pVa7FM9REy8lvo/DjXDOHGFvqbQi1VH8XCdfXi7dpDH+EZ2ndb7WpB3buFO0m61YTsIa8vJcVg3
 iEMxOK05mhwfoML8u7d+1AQ3uHGBD8Jk5RJT7aiPqx9QAOugeaFAcdZ6OZzQnaei6de1QROW9fQ
 VEy/1lbqoMHhIFmIvXjw26bQQXGtAfriWwv2QZpr3wacvtWNYyJpAEEaItRTw1k4e210eBcdCsq
 aqg2+Vw30rxwM8dnavr7x5fJEhKYUY3z6KZ/WkdGMGTAU+mnznlZ4/4t/Z5XK/E1tV8IJPThqW7
 gGI2QGmlAPzN9Z9VS7c6Qw2sKJePrl/8pHVEEJVVZANevFO7c4NuLPfJzy3WY8BOXXhk4zynioH
 Tf9xlRwyMPYJrcBVKPVcHA0y2IE4BL+jO59lFi5/FhKW7OjehK6kja/K0HTNF07nPSgi8978FyU
 QepZEun3n4Dil1Ul9lKr8wOcuFNe9MJQ3b+KjTHXBeIASw5sKkJzMUOsCUkdpytrDdTuWjtrBlu
 62gSLdUTPJ7DLD/VLt9XAcKHiGtL9ChJrU/zLmyQN84IykEbkxcLAAxMcpPBozb5eL7LuBS3XvZ
 lNu6hRj47re5NKGho5zsuyLRRsJvQbN2h5U7/2JVgv/F3zCI6k/gW2s/b0DHVAip99sv6rWeihP
 g8lQh6oovthpgBCCY=
X-Received: by 2002:a05:6000:26ca:b0:4a9:faef:7aae with SMTP id
 ffacd0b85a97d-4abafd02fdcmr58510229f8f.5.1795859678819; 
 Sat, 28 Nov 2026 01:54:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad644140b5sm49087866f8f.17.2026.11.28.01.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 01:54:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 09:54:36 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 09:54:36 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d6411b554d2f37fc2bb27f06aa2ee6eccf449c2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xXF8n-000000003vX-38gG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com,
 heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8498324913909948369=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8498324913909948369==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oHKZf66wZA8="; charset=UTF-8

--oHKZf66wZA8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Deri Haerudi=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: dns-scripts: p=
arse dns_vars_file as data instead of sourcing it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: -Code-Review


-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754=
adc82f42d4371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 3
Gerrit-Owner: D=
eri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, =
28 Nov 2026 09:54:36 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--oHKZf66wZA8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Deri Haerudi=2E</p><p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Change</a></p><ul styl=
e=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">change 2341</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id05f3e4e=
32aeb806d762858e754adc82f42d4371 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Deri Haerudi &lt;abcdery=
screenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;h=
eiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Sat, 28 Nov 2026 09:54:36 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--oHKZf66wZA8=--


--===============8498324913909948369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8498324913909948369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8498324913909948369==--


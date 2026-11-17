Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC26606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SfWPyDPP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E3UR5HA9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jocXG0r3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VBJvBRgA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EOMkOYyTO/50btUi3/UwpicARdfqeQ/qMwYkOu1uP9I=; b=SfWPyDPP490ncB+8QQT6m2Kr9Z
	HsuKO6k6UsEYbkmviAisGtk7OMcnEJphvCLwM+4vRppOml+DYw1pUXhS7DRg1qZDu0QZX5BkXVX0d
	/LVANRSPRZ98fxOXI2ko4jBvuwxM1neDk/nCQZ3u9Kg2cnxRELbXxV2avo4Tlr9VCaXE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKr4-000000002jT-3EiA;
	Tue, 17 Nov 2026 15:12:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKr4-000000002jN-0YIe
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:12:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VSNiweZZt/MMRVOUjHLoJXlMVLxaKjdA3r7/i5vyp2U=; b=E3UR5HA9v3P0gle8tCiy3fZ8I9
 34d+4QN1A+EsvfLYwpJJAo8hyICzEttpcNU3F0MLUpqBjHlRd/iF+Z2MBdGXy5qSnW+vJGoaI5Mt5
 Yw/qaPoFHct6gweKI1qDYEQlLYdnxZprLzIvhbah4qtMxWlU3C6P1Qp2CMQEJ4MzG6pE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VSNiweZZt/MMRVOUjHLoJXlMVLxaKjdA3r7/i5vyp2U=; b=jocXG0r3G2ldJuFfe1l+e7di8U
 8bBOxI6lBYbzBMg/0BwAE0estrGEeU4CDBdY/jeqiwdRAHrvKiNTnHpBNYViRnBwu4bD/O/mNoDq3
 jdZq94fS1x/JqBFqWTuWEB5NI0hHvX6WbeHeSqDrY3uckcX5UGjaUmfQ4164ydwIkVAI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKr2-0000000016m-2Ev6 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:12:18 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso4532751f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794928330; x=1795533130; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VSNiweZZt/MMRVOUjHLoJXlMVLxaKjdA3r7/i5vyp2U=;
 b=VBJvBRgA2t6583UT0lTbkkyscGDV5EAC3Xxrd9dBXY95nX1l8GK/p5n0+yKvKTXcqr
 R8v92kV8JU7II1WpNrPakk6Mpha6l+gqHCWDekjp7j3cLmMrpu8BYpP14H53kKia5Yiu
 7TVYwaprXWs1OjbfA2hv9kTRzSDhgK8al2j7AACYtimi5s3yKvpYGNgoTGAXzWNORa+Z
 KFLiuH0GBFiHgijYU35fxQx3XQPkiiu2kEtxm/H3L4/7qSCMFPG93c9Dl6yKcDdzRC7t
 O2ixgJAXgC8eeHG5+ph8v+20lGRKQS3y5vpgXcz4kILvBlyFk/ORO0Z/ATqPskO12YZ5
 ZfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928330; x=1795533130;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VSNiweZZt/MMRVOUjHLoJXlMVLxaKjdA3r7/i5vyp2U=;
 b=bmQPRj/Doq/MHYaisorxqKqbLToX0d5nFsEMRYtVmXCPksFhGZNbB/zAwpvN95SWC7
 qIb/BSEJgsMxQrLxCTa/XapL7ko/PJLPY9eb5YtRDX9IiC4EU5Vc6c4eEQ9y+A8GQslv
 jDL7SJXovixS+87+VTtF6KB2+213586rBwuMV7rWigxlJw3kaNS92U3Ijy3GsuHBVZjp
 MrvXASGWV28aqydkm7eOhDo6SgFFJ24sDx7U9dh/91PbybzF21M4f/148+HJGg4MjuKX
 VXElhCMLc0McBs2wjH3upzWkC8NPMGDcLrZmT2IjFG3EFmFvRiKTwoTqMhQX62jdp+Ny
 ebCA==
X-Forwarded-Encrypted: i=1;
 AL+hErEa/P1R807t7AaBj1NrpbgF6HdDSbagcWimk0hL7OzWauQiTT48itlFRLvzYGRhI193P24Bjh4qmxWVFbc5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z83pLvnGy4AhceaT/AfTtj/eyyzsyad1UZTEHWOIVBIScTrcIOj
 Bd1/J8cGFIeZ9AIiE7+zquNIjy70qLXVzYWcXwsmgj17phq2PmSiLiq8WQ00EFvFC2Vi4BDgM0Z
 9+biyJeiesbZAQFk4o+WS3BjYWvN9fkbVfBlWtXTvkz/UoebrfkNI46VX1APnxWsgqd5M
X-Gm-Gg: AZFdTZfDRa28Zq3Z0RPCMRPW+YOpV4gRszu15Jrtdbhnb2Qjkpk8P0gXO65PD+f/APS
 Q29LxQHPriQMwOt+PY0nznKsYlQUMLhJPhjyl7c80rsHkXcIDWQlcYbTM84nS+aI1w/nxSSZcF/
 vWzYyw2cgfo2kTBQQWa/DUM2yNcv+HoPVcTLbR1VtygNp1zJnJxtque6UDvnmhtQxk1/WcWhT4i
 igVSNqOhK1gRWtAzDJlx7CtQs97+72vWYuXimkCfAOCk0nPP/h+4QyZnJV8m2/c84mAFaGVyxKJ
 px+4jsaY8m7RCHyW2AkY4QUX85qbfKUIrZ6MwMuxXmMypTGi66dt+uIlrNZjgIb6OC9a5oF2KMc
 dhvzcQA0J/kTsJ8PX82dEasyBoQKcOplwoNCBfxSElEosH/v737ExxXbaRScG1KAHsKdWJHAfCJ
 mhf5kve9Y48bm2RuMRMZWpqAiwm6Y3I/H+C+GI2KaqbAbp5MQui/gYe2Qk/tDVLNQONMTovHu3O
 Vb26X3U0HNWYrFMNEM2BLJ5Fz6JZLND3gbFaAa7d7Wy99EMNXapfJF37Lc/m40c3N67/r7uoAUY
 IZ5gO59Yvx9/s+M6Aim8D9tVSRCOPfhrGPrhZLyV9Qo6sCykOaKgdWcRGjmKVBa+VMs3bmYd/IT
 Sg8bPwmipygcrL2zNY2BWK+7ec9H35hgMjVB93/RiL19CqQSOGxCa3qWUJCtw9VP6KAOJT0QwRY
 yLxw6pV/M1PZsYKmo=
X-Received: by 2002:a05:6000:2209:b0:4a3:39a2:4c2c with SMTP id
 ffacd0b85a97d-4a339a24d24mr6773849f8f.7.1794928329587; 
 Tue, 17 Nov 2026 07:12:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm28643220f8f.9.2026.11.17.07.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:12:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 15:12:07 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 6e544f6320d31ce0143df4a8253cb988a4e4c8b4
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 15:12:07 +0000
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec5f98a3a9c10d8a73fa1bbfbb3ce0ef7ab7a60f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKr2-0000000016m-2Ev6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
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
Content-Type: multipart/mixed; boundary="===============9087169999692973711=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9087169999692973711==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GWM7Cip1lgI="; charset=UTF-8

--GWM7Cip1lgI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail )

=
Change subject: socket: pause the listeners when accept() runs out of resou=
rces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2210?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-Number: 2210
Ger=
rit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov 2026 15:12:07 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--GWM7Cip1lgI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2210?usp=3Demail">change 2210</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2210?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2210 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 15:1=
2:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--GWM7Cip1lgI=--


--===============9087169999692973711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9087169999692973711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9087169999692973711==--


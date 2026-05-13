Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA881CD4851
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsKpe4uoHsY+OtCQTyvSibg3NBozdxIUfS1UrwjSrLc=; b=UtKLTyhXcz/tkVvS0sDCZwnsPW
	IA655IbvNKUVU813dl/KmKL3wwAIgYb9G7bEciU3wUVDMgpem4TozDCr0Dg+RggahouxZGuq4Rd2a
	agOaUuRdT+EZBL9210xnfDwKkNJtZZnnpTZdG7QVLMx4eUWTWj9tB8mhyyOq+ad0icBo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNAq8-00082o-3c;
	Wed, 13 May 2026 14:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNAq5-00082S-4e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OIu35rtW/2YJ54mhgJPG9SNo2Mt+im/40BFbPYJ7YEw=; b=Q7tBXj3e/27U91cCQ9xPvZ+wMl
 k4Ra4bGgUGYihoMZ4r5UskD9nF7irxXYXZJdEbNl8ettXALy6fVlW1vDbQbgyzIfY0T1N16+SrNvK
 rEJ3NyOVpAWCgQ3RsZqt1CRW7IeYymZeiZTmJ/L0WP/gO6X+iEdV+aHT0NzDWXWqgf1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OIu35rtW/2YJ54mhgJPG9SNo2Mt+im/40BFbPYJ7YEw=; b=F
 P30sVsapui2HLy8cw2/6nJ1rJWjnbXI929HAPBEagCdt3Q+/mKAbsFf19wpmPWXm/vyzu3GRk2dUT
 497DyLWfWdIoRzv3/w1RFI/Kt/cJ3ZVIarpRRqVHgalMBZ1uKf/Rp8IUgipIq5FFJcTBV/oElmdcf
 J5wrj+UsSmXQXMQ4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNAq3-0005Ho-R7 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:45:33 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso63682515e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778683521; x=1779288321; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OIu35rtW/2YJ54mhgJPG9SNo2Mt+im/40BFbPYJ7YEw=;
 b=X+N7Uy9zKpxGw5QCYjob3bVmj32VtovAWV3xwlrWqhGoutLGgvpUPcnTdJza8GC8U0
 O8eDQzC4yl7nsfPTvi0iPXN1zV0rYld9cTxNgafODWc0xIYCoWLB5vW2x+Dx3T4rJLT8
 dTl+xRO2eV8pOLIpCq4HWI9+S4f+CS88zCdRwvvFRUJWsXhhA99BzQ716yFoyTSB4nke
 LMiHf8jpJ5B2HuVIMw2b5HDVnI8FLpM/yB5eag/rrvYn5diOSJdt54b1GBirdsZDldn5
 8lh5+IY/GCszaBJWxmtO8Uz35x0MVgKupqMuQBp5A5IWYp2JnLVM4OXnQyJA4aRmMara
 9YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683521; x=1779288321;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIu35rtW/2YJ54mhgJPG9SNo2Mt+im/40BFbPYJ7YEw=;
 b=maEw96P8FloydiHgPP0ENT8j9UMUMmdAawhxOVME8Opdiyuaa15KpbNKgFCelGTfrD
 Ffi08tPRQQN2aDmO/I/RVwBJFlL+JLpzQGX5sNuZeHIOlxE/cxZqWIpjHmVOfoZou36h
 eL6RCHAtG3LOHm25f3SWPhoZsRMUe1ykRw1x7OD9NW49NZcXFbhj81zjYqkUAxIZZIKd
 9CnjGwkr5fEJAdYCRf3Jio5GAczLA5RRDEvM9r5CspZ7ksri9fUZeIamY3g/QhvcPjJh
 A1DDl+qjWuKLY4QVnosY/VNdr1zjjqi2WiK6hH8LID5K196kqjmXmi+vkixkv/w55xzx
 0w7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aPeRSQm1mAMbF5RTg0BFkGnFTMseFXV8hg6BJ5FWujJLzF0kbAoeWSyQDANo4DyT6ngozKWjRAxsPGx80@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyGHgw+QQ/NvgG5y9wIyDPw4BdBeSDx0wYbUFjqtx+JHKC4kaRJ
 +fhvXSAL1s/knUL1EiGrf4MUlfyD4WFTk3nibQIAkMvlpAE+ekkxlmq7+4I+iu8QN9qA38EaDGL
 ASYrO2hClZvSRB/kC5FYMJ4dDYgqp8QUGCfwWfLG4058FU1wuD9tNIF6btf9ECWQyEgY/
X-Gm-Gg: Acq92OFoHyjwbHr3PeWEvZxkklObFLHx2otLeB0tT74yZCg1ZeWoptjdTQRIKhMQbxx
 WGu14U21lwR2gMI40LGKAwCBugwkObmdlI+7PnEgGGEgoUt30wpmdjY9Uw77YrkNEmZUXgU4F1j
 cFpAnKqnhn90uGelW9GiFVK3tk5pJKs37YQc3R0DS7LHuIM+AQwTTo+M3zHFLAfu/J6OcNJtOT2
 q9OlvprhpLeROij33/2kOvnDTtoEmdEoDr06tv073oZV+OL53tE3nwFNqgCr8NRiC3+c1jjgw46
 HGVZfQsLTJe30c6yGvlqtEvex6UmTB2iEk11tkksKfzmxDX6UEoU65OMPkPSet4sirNA/S/09lC
 aWpr9JcEF9Fky4zcyeIVeizIsASdq/5K6JxsYn5wBAH5+eOMFfzi6Jxj9LkLni9+smJB/IYsLyx
 MWLolGmeTCqo1ooHj1OeS02td/l/Echp0xkRs8kvdH/ek+2hZXOW1hvCQiGbwK/qRaSJDqOxsDa
 XywvHaR1nC8wLQCb5GDLvqNjIglKbhCNnQnpLgUYMpAR6pj9/z6gcA76KW6GptRw0VskmFdk6C+
 zN7wGY04ipAIFQ==
X-Received: by 2002:a05:600c:4595:b0:48e:706b:53e8 with SMTP id
 5b1f17b1804b1-48fc9a1b9famr54179465e9.11.1778683520571; 
 Wed, 13 May 2026 07:45:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fcdf6408bsm59541715e9.3.2026.05.13.07.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:45:20 -0700 (PDT)
From: "d12fk (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 14:45:18 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
X-Gerrit-Change-Number: 1674
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1674?usp=email>
X-Gerrit-Commit: 8a89e496026fa03aac682c52065ab1c6aaf20ce1
X-Gerrit-Comment-Date: Wed, 13 May 2026 14:45:18 +0000
In-Reply-To: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLklkYTZkNGZhOGM1YzVmZmJkNzkwOWQ2YWZkNTFiMWI2ZjMyY2EyZDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a7e6327fbcc0d57aedc91884ba7779a981a11d7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNAq3-0005Ho-R7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Address
 some uninitVariable warnings from cppcheck
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
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4025045188850931270=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4025045188850931270==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b7/mbl6qc2s="; charset=UTF-8

--b7/mbl6qc2s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

d12fk has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1674?usp=3Demail )

Change subject: openvpnserv: Addres=
s some uninitVariable warnings from cppcheck
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32=
ca2d9f
Gerrit-Change-Number: 1674
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Wed, 13 May 2026 14:45:18 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--b7/mbl6qc2s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Demail">change 1674=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida6d=
4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1674 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 May 2026 14:45:18 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--b7/mbl6qc2s=--


--===============4025045188850931270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4025045188850931270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4025045188850931270==--


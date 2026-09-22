Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0247EC982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJdkmGpGTD/sOz13PXN48Wqxqxc8C4etjS8izpbuWnE=; b=U331C2YxN+Sn9uLVPGoTQE3kUD
	CCVtYmZhDoXUe7mPoM5aq6VA0n0q3E8EVhxM4sBE/os0GXHnaovmp40fyUUyAltwgD9iW5fs3CLal
	yd22I4ptdrpr2gUQ8++V2qaS47HvbNLzh2QPBSXnzSUeL52VJuwbNsUu7ZypE1gL7VW8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91x7-0003K9-GC;
	Tue, 22 Sep 2026 14:58:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x91x6-0003K2-54
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ObYlS3DrkWUv2IMsg9KISsRQNQjkSP+f58f72Q92rHE=; b=UonkBviMZcG3bidoM5msF2Ojf2
 Z4F7cwe6MSKjUtBTgXtZzdQdDulMleDU92t4fD3OHss8/EJwgWqm9vfqoszxY3UMKAEcUIdv6hWI4
 5rQiZE6LNrTyLMJeKA0J25p/EkU/mrkDn1ppWPyKqi4cMj8z+159eroOZ2mMIkPNBkCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ObYlS3DrkWUv2IMsg9KISsRQNQjkSP+f58f72Q92rHE=; b=R
 8PHYd4GUNhR5w+HLALQX7k31HKmzrmd2NrRzbY/SPiIVEYZmk3kni6Ci7p2VX35MYq0A62kH9ZXLI
 2G6Dm8uMJA613BijIrialfMeCHbw1MyY3tmpVIq5DMGvYgOwCd0U2MZJ2VjWzxNm92xlvDcbkf8UH
 vA6yF3WGAv7joW3I=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91x5-0006Mw-FQ for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:58:36 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so7593f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790089109; x=1790693909; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ObYlS3DrkWUv2IMsg9KISsRQNQjkSP+f58f72Q92rHE=;
 b=dwJpH0pLtAaYOrbkJZHtssC8bspdmwOr3xyeHr7Ydn17hP4N0f00VH8aNC3ZEKiIQD
 UlKCAmCdRufpwi+d0Tpb8V9F4WnYCPSi4gRwTM7hLlV5KAtT178cfV7Uxe/WDc6258B+
 eBcJToLf/whBh9ugPkdMJm60oNrc1opmu2Kt6Fb8S4Jc4J4eAqApWI9BNSthD7YNtyu2
 XO43xqccwjbdlA57rRtERjtM5n9yBl6ICHWIeLj7zXwgvaYvj+ouU76ora2V3yDh4I7u
 /MggK64SEgPU6epBOlHeX+0aeVDgHGnuMxmIe7nWqiu2diOdkkf0WAxUwhS4mmOrotbs
 wQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790089109; x=1790693909;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ObYlS3DrkWUv2IMsg9KISsRQNQjkSP+f58f72Q92rHE=;
 b=aZbEUaB3LZp86VLOOOqlhQoyJSalVQBIJD3+mdUjowpiHpRa1jXilxNNeLOkUoLJRL
 YG3SatfrZ2QS9OF6lYrjVuvZdaZBu25M6nAqnOVa4L7rKW4koJBnEFR0cNDRnQl+Nhs6
 6ZJ/iwenN/c14OHyyxNBhxYbdgUCBU5UZ1MYYupunCSXUeyxzm0mepGG7qqRCfK5vRAR
 HokW3S4YlFdFyZ13nqBhavI5Yq8UgPU4sh4Vbr1A5vDpkm9P8Ek+/5U6aXEk2tczZHwf
 FeznBwN3XwCGzlYgAeA2vKliFlNduHhIK/jSVuHCHi5F+DpWjpdl5YAqWqxRYGaJCWzq
 BHKw==
X-Gm-Message-State: AFuF++ksDJyS/Ln+L6byxmHKtln/kFccO0cMLapWcuBg10Z3A75excox
 NSEGNixLHINvh8MUUTC9lTxLyNejB/QAqqNGd00CrThN4RFJtmfbf0/7oviNsu2gwbEpeTk5tBJ
 D3AYjQ7X+HT0hhzqn9SExF6X63qLVxylxIy3P6B4/csE8KMLsOXoey3SN2rUbcw27Lgz7
X-Gm-Gg: AYBFou3p8rRp00QYzUtDkPSXuNm2Ami7ZuD6fwzG1iVgfXjiz2OjMTkzWz5u6Dg76CW
 5/9uN3ng3KN/J8hUfr0OO7N3db2R2HVHDaHinfAXfQvQrmL0BRzi8uypkMj4QNytrDJYP5xDwDM
 SfdBzjjzaxdm8VdpuBLCsTK6kqazgzxgjGO6ve31RsQORhwsDewzW8zt3dLmQU9QAhsJZEraaW9
 IK7VhjGcJdDeUD7vRdrLN+p/IIqS4ZvByqhkZYHtTi7B830udknm73EKGxth5Nn9wNOSAGvPxI1
 fmMwfksfTmocKWEImG19ikTYStxCWaKpOuwyx5txUwCwp87jQxnzEWOsBN2kTTIGBGm2reVOWiP
 LTxGwHDDTbVqW5MzOzniT+BqC5rboqL0M55UYsrnJdgDFi6AJbtkR/oq5T98zEqJRKd54OSdq8G
 nVjcKwAeV0sMVN+V4kMaS1kxrckazqCeAWDGAxilE5AVbMDBmhl+IRMwVvM/WHzjzpS1diHCPMl
 yQ0wxNiPbQ0UrvRr1VheHVTuHd96B/FRflI2usXa/Iz4tUaVy0F7ZEJjOvQuJrL2h2rLpkBblbc
 uWmFuM7Z4xxDucv1qdjFS5KIoy/YEguWSYeFu7JO/0N7VebmdnC4dfCAlUnUhMBdzTpTECw=
X-Received: by 2002:a5d:64e4:0:b0:487:172:6293 with SMTP id
 ffacd0b85a97d-4871e21319cmr23429431f8f.3.1790089108857; 
 Tue, 22 Sep 2026 07:58:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277e84dsm6083384f8f.20.2026.09.22.07.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:58:28 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 14:58:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: 12c2603caaec7f4b6d7f4aca60c1177714d2b300
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 14:58:27 +0000
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32ee45591dcd1e20789009c67c19b053a0100abf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x91x5-0006Mw-FQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9216308700967445437=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9216308700967445437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e8bn2LLEZjg="; charset=UTF-8

--e8bn2LLEZjg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919?usp=3Demail )

Change subject: Document notify as auth pending me=
thod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1919?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I6217c0541bff81eefa63a987db8904b2feda2546
Gerrit-Change-Number: 1919
Gerri=
t-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 22 Sep 2026 14:58:27 +0000
Gerrit-=
HasComments: No
Gerrit-Has-Labels: Yes

--e8bn2LLEZjg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc has posted comments on t=
his change by plaisthos=2E</p><p>Patch set 3:<span style=3D"border-radius: =
3px; display: inline-block; margin: 0 2px; padding: 4px;background-color: #=
d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1919?usp=3Demail">View Change</a></p><ul style=3D"list-style=
: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1919?usp=3Demail">change 1919</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I6217c0541bff81eefa63a987db8=
904b2feda2546 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 191=
9 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 22 Sep 2026=
 14:58:27 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--e8bn2LLEZjg=--


--===============9216308700967445437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9216308700967445437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9216308700967445437==--


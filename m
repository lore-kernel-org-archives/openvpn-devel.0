Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D4C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XPSQi6wMoXri0ap2HvS6eeg1rp24DYmFhx15O5Fkl78=; b=M6bFWEF+Uk4j7nrS6LGx01UkG4
	QlfGOGHlZmsrWO/dH+pzGqiIL9mMmcYUQ2PRLZuyyhRvP75fhqKQSvD3lj80IBCxgMg5g5xYwxCnS
	0YP7In+qWBtrv3cbyVePRzlaghg3icXFd3Yg6Gjx4HdSIeGxiQ2UMOVZaHIM8hb2z6Cc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnO4F-000501-SB;
	Fri, 24 Jul 2026 22:08:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnO4E-0004zu-Em
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 22:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=y63iwpvuOfVT2FpKBFSSGcsVxb0ycWpsPNlzR5ZgJow=; b=J8CAmhjLDPMjtpg/RfpXynJyNN
 JTvV7rFPVwvqq/WA00CBygoVeaO9w0HHAnlI/K3CEFzeWYfaBUf69hsSv7qyaHV0MOOIS//XY1GjB
 nziQTVvTGRdiXxNV2/X2asEZuE1XQ18PPb0Tfn23M7SwbXaHJFnWOcoMzZBR8I+gz+pM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y63iwpvuOfVT2FpKBFSSGcsVxb0ycWpsPNlzR5ZgJow=; b=A
 bY6FnYTqjQPw4ioHg7EeFEw7qsZYaDOQYoNedb1FEpajKMK/8dXD1j/Gq5jGAY3bUIZLtqiDhWVal
 PsaoLHUoobufz+ZDVuV4ng6aj3UQ6msl2TYrQBuKTNexkp0lw72os4afao1c4YzKUh1Rd5ZecBEwz
 Tv6LuX+HBPt8qFXQ=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnO49-0004K4-T1 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 22:08:27 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso513987f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784930899; x=1785535699; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y63iwpvuOfVT2FpKBFSSGcsVxb0ycWpsPNlzR5ZgJow=;
 b=HM3pHj+OZYx1DtQZb9Nx0c7zrm3AqJE9kA760RSp9xnSMas0RQjvyklLLXsNkqoeyQ
 jM6MrmLmxpFo2j/C1O1SdP0vh9DQS/++lLGje7+Z4FnnXyZ/hiM84PdDrLFyHd4+NXzp
 Nw4+LISsVuVAn94o+uiobcQ+kL5oZlObMkhxFOXjbRITykFTaaGoCmu8f88gF+WNbgTx
 znNWah5E3YrSLAcuvYqUs0+22HG2PjG7GxGGGMwg+PsDewtSeQ4ts0knnFGq+xaGEShH
 qBX46fIC7vs4E3pmZMRancSXxW6VjubIVe5IeS2oPWL1Y09OAwXt/+RLVHRMBYXs8h44
 TlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784930899; x=1785535699;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y63iwpvuOfVT2FpKBFSSGcsVxb0ycWpsPNlzR5ZgJow=;
 b=eOzmzbc0KtEGcuX7/ng+8njpr6yxeMJCrhZaoGuYAlWtSo7/mIyMuhyDDLgScvDb09
 mvw1aRKmGQHX2kL0iPAW7qbx8haczKC6rhbXacwEk1kApJwGydwcSBKS0Atu67XpfxwU
 jZ+ZyXInns5HNtOva/plRsRvfdt4nyPWAuFyMB5ssuFtrbJUk/gPvv2/8UqoO8MvKNMB
 0UbHt5QjsN4ytRgWs+LhxbwHJFELOYTWAKLJevdBn/RXhA1NZvZQX7jSXkaNinRGavd/
 /p+tU59hJTPuvTfY0woPaiJPrmnWE7sPKPL7gkMEqcRn3yVzXeupTJhjOrj6HG3p0Bzd
 wisg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/BTSYvgaRvXrFSdkTbGyWMA3+YhJ0WdionEj+OQ65/CJl94kTBONxUSWR80v+IMg7CMtX/9/QKmpB16Ui@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywv4BIRDh6utr5bXOtELPwRbrmgWZ18pHfj8AIR/s7D9j58f4jc
 IGLCrE7S3FP/+k3lJAGTuXKezBApAswOeYawCMiVkhbXPuiQyKTy+fnvwIebtjHCBsMbOhcVjCM
 k35D29EX7SMB89evXXkq1l03Gxt0M455Re6WlwJz32EfCQU5hE5x8hLwNjNWgRhBamq+BwgPnZs
 Sip9hDOA==
X-Gm-Gg: AR+sD10uzGiJ3v+vswxX8d3+ywUqwQzjwpdbLYkPDWCNEJZP07EsBkcxGNNhurULUl/
 RohPvY8nrJJ0C/4t80xme2fyWtJZ6EFgkUAEsehlrWemebN2TXSdInM/BE04eqizIV8+2VbHSh3
 jqeZ/ZcYPwjcd+yutTOXDQzXUSQXaK5fKOsIkiVjl5jPwVeYVF6PJWdz+2gk5C4pTw84690ewkr
 sDQ1OB96YbKc1AmJBTiHSeEyKxKnh6ipr/2wnLRUa7gVpcJwSQ42T8cxS5Yf19qZn46yQqruTzZ
 /yWCGMLbt9o1jgyXheaQaKnQBCZ9trlBj2M6JF8Y3oRC04z1Lp8mEVIcYm4PA7DjYDaNa0aDaIA
 yZ9fEw6FmRQ5TbAWhkSLNE34e4LPuJwmlRMG8iR0bXnHOyzqCWGRaMsKcfWH4YoFiDRvGvHcCFW
 sJkcvMu9VVKHMWlZwclZPxvK5iLhOHJ9ZU7Q67vDWm7tTVN0IgSQ6Sx/K9d4vjiZChzfXerMxBY
 39cfZDvadk8xbHg/gUJkXGqmxJI7fDwTGpFYMKwFEXEJIUSvG8lmhF38r2DepKe1xPd
X-Received: by 2002:a05:6000:2313:b0:47e:9f16:c0bf with SMTP id
 ffacd0b85a97d-47f9fe97a4amr45286f8f.30.1784930899161; 
 Fri, 24 Jul 2026 15:08:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm27193648f8f.30.2026.07.24.15.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 15:08:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 22:08:16 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: e9a0645e18dca96e910a41a4ca85352d3298f79e
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 22:08:16 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <648d722fcc44d36d95e3e40cf3f3a6705ec4a131-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnO49-0004K4-T1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up
 code and BSD support
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0554459922953416118=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0554459922953416118==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h+WiwK74ISY="; charset=UTF-8

--h+WiwK74ISY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail )

Change subject: lladdr: Clean up co=
de and BSD support
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Gerrit-Change-Num=
ber: 1675
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Fri, 24 Jul 2026 22:08:16 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--h+WiwK74ISY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">change 1675=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe7b=
3c17176c97a1cbb4d9cc87735b05e62c4f43 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1675 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 22:=
08:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--h+WiwK74ISY=--


--===============0554459922953416118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0554459922953416118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0554459922953416118==--


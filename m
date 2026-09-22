Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140E8C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pAy5LEg3zyWfeBPzeavYrNiaGySVkp1jgx/3lo50SYA=; b=Jlf2VUt+JbbI0aXc5mwjwSVsld
	vSp3tJAof6avuZPdFBBOyO+2lyYSpAk3ta+jGfTV+obvORzmj+CCJ1GYj2bDYEPG7pvzJGkB/gVmA
	scIieYT5kISLAYXdbgMynDsarIoH7Vx/43PAVjP6o9tHoM3OzxFx9mEq8J44GK41pk/U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8vfx-0003Nk-97;
	Tue, 22 Sep 2026 08:16:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8vfu-0003Nb-Rm
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KJG7hXXrr59EYP4P+Gv1brmNuifvvLrRrTRnQLnug8Q=; b=UqmxkWGgBZqYeUGUnga16xQMeW
 9DIeUB/G5GJ8vUtFJg5f8M26kKtn92bK3pckaQz/EgHQ8+UXgfWe91UBNcbZk3C7/khGb/+2aH+IY
 DcUA/RNRnXTkuErCVm7OooHZx154ylYXSsYOx/9FAroy9sBeV6qhGKzOtq3VNetZsJ5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KJG7hXXrr59EYP4P+Gv1brmNuifvvLrRrTRnQLnug8Q=; b=N
 uQpA42UNhRwOYHESc2un+cx4CZGYn9Qm9gsfdAxVoTr7lJ/HSXT8utvQfh2Fy11ZgsEs96lpQCXdr
 2Vge3kkBQG6HzL057wxG33Rrg+r6xoK5+EcRom0QtimH5P6mEO1BkTwvp9gX0h6v5mT4UsSE3cF2Z
 n45h1c5G8WSPJRPc=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8vft-00055F-Vq for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:16:27 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so2354127f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790064979; x=1790669779; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KJG7hXXrr59EYP4P+Gv1brmNuifvvLrRrTRnQLnug8Q=;
 b=PWM2amEC1Wl/K3j7nObZNi0BWuzmjmws+va3IoRAs0A/NscTbig0fqcQJksUC6Oc5R
 WKPN9SeKBRezUMV5WUeFe4xsPPFc288xtq+K8GESh0sNJyUSCRHPeL1oNACvA0iYRMP2
 V0cxNUTQveQrP23syhyWNP+wMXoDUmjE9w32u9iq4JB3PAa8GowjNqPabApUhAUTZmB3
 tl6B7QORUjoGGITtE0hFUcjR9R42YbWgZWW0g4y5HzPlDdtJhWEt8RaoP7tyVhgTg/Uh
 Bd1/d5xLTspmEDT+rCOaMIMLSiI+qh00uTKlqfmS1rIqkBcVYk9oGYz4fXQbzHrr0soT
 qkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064979; x=1790669779;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KJG7hXXrr59EYP4P+Gv1brmNuifvvLrRrTRnQLnug8Q=;
 b=VeHaAGXYwjU7YMMjh/Mr7CY2tV/CyAglAbfNRGYz8eBp8MAbxPkMR5ssBvdnBngYl/
 g0Sxhy1M3dwkbOEUITl27R3K9KOwimjprcDZ7yaodMfpIDX68rARzdePZS0RdHcAexxS
 J2fJCop6NTaINdifs5NYgrjbtmVhkRBmBYZSEtITzWHqcfbd2D6ZGktMo7cDwGJlrz+s
 k1fL5WC/v4+adFHoE8mi6yKgQ2j/2GHWNEB2EkeaXCVoMMzJUEbMm/b/gKyzKoKuRz7x
 PkierNOt3YkXqXSSQCBxOigAB9ycfEMWYq+L4Sgse7BtK/b4chezAKFAYaT1fTTUJ3/w
 9xdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuO2WwFADXZHXAYcd2gs+OUjoSxt2WsT8oRI98bOdKRmv8AoHdbQ5pgSyiksD8gUZLn5mLhfpBquJDyuiD@lists.sourceforge.net
X-Gm-Message-State: AFuF++nPGhaMzwddo8AYbrSnsMTdwUNOTNdGl4wR9Q7GZ7hQFqS3uEsS
 WqSnR2R81cJjGvgoDA4WqWuT9Uii+GyXuNRFLqLGOT5r/r/OiHByifcoom7QY8XtnCEZZ79mCoZ
 jWI76ynYCp2ApZ/otOFh6GiOJED6ZdnvFDBdq6+VtnSqTawoEDD/yhOS9zObsLSgZ6HrZUwwh0a
 PIQ6aoMg==
X-Gm-Gg: AYBFou2SwM401wTO2U/nmDPCzAMzquKaG7J+/VCYWV+OMxZWQ2S4PCCPdxZfdRWSRLH
 3Ya+5UI7hTXyggOOy/X7T7UPO2k1ioshJc91rXyY2DlQm+gfa9+KCHJeieKjgwkPsOh1XR/dcfs
 KMNGHKbEaMsBxsuROZ7zt7C0ekxJf018b1gHjtW79efjOVj1VtGK2yMfbLwiObTmM+ONODMWxfL
 H4f4xc7FlAeF++DMdc7zfwqeorCAYpNE4P5iXFkbskwIrcEdzITBzd1R97IDtMWWqT8SIUWPBsG
 0G85QfoicQQxaA1anIvLGuV/Dqskse8ysxKf3YQvC9PMzJHu8NdOdd9nfbun+p4VQwIOt/uiVBd
 1PDXrrtjSnWfI+KUJBc+YmLD2A7E0HA4Kn7cbgjKafEXyo1L6UFnqg0d+/KLQ5B7aaMRLFrBIkM
 pnDTuGMNMa33PaCLf/1au9dfn4xWb5EzgdxRJaXSx3Nr2kGjNwEq8ijnHfswABkIBr6HBsj7OF7
 kAX6nnXiV29LKmxpcMjHeWw8gdMMNLizKzw+cZz8BGLCIHDuloTomWCDcigxviW+yoMzZZkpqdc
 nryX+ShN+4zNJ0zopPqlt1aUwLbYqj8gNNmcNyTCL0XK7m8FC5bZuS5S8jOTgw==
X-Received: by 2002:a05:600c:83cf:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-49fce783698mr106265875e9.19.1790064979000; 
 Tue, 22 Sep 2026 01:16:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cd8dd6sm54403235e9.11.2026.09.22.01.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:16:18 -0700 (PDT)
X-Google-Original-From: "uddr (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 08:16:17 +0000
To: buildbot <yura.darnobyt@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I08d5574e5ed6098b5147357eee09fa796853efb8
X-Gerrit-Change-Number: 261
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/261?usp=email>
X-Gerrit-Commit: a26516a944ea5c85679dc0cae19eb858a64ae0eb
In-Reply-To: <gerrit.1680209488000.I08d5574e5ed6098b5147357eee09fa796853efb8@gerrit.openvpn.net>
References: <gerrit.1680209488000.I08d5574e5ed6098b5147357eee09fa796853efb8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjgwMjA5NDg4MDAwLkkwOGQ1NTc0ZTVlZDYwOThiNTE0NzM1N2VlZTA5ZmE3OTY4NTNlZmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65713775abc119e950c329a20fefd148d9c18a95-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8vft-00055F-Vq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Please ignore -
 Uncrustify code check
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
From: "uddr \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: yura.uddr@gmail.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, yura.darnobyt@openvpn.net
Cc: "uddr \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7208962872658351808=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7208962872658351808==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w9pyWXPfc8E="; charset=UTF-8

--w9pyWXPfc8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

uddr has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/261?usp=3Demail )

Change subject: Please ignore - Uncrustify code check=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Abandoned=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/261?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I08d5574e5ed6098b51473=
57eee09fa796853efb8
Gerrit-Change-Number: 261
Gerrit-PatchSet: 25
Gerrit-Ow=
ner: uddr <yura=2Euddr@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: uddr <yura=2Euddr@gmail=2Ecom>
Gerrit-CC:=
 buildbot <yura=2Edarnobyt@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--w9pyWXPfc8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>uddr <strong>aban=
doned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/261?usp=3Demail">View Change</a></p><div style=3D"white-space=
:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/261?usp=3Demail">change 261</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/261?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit=
-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I08d5574e5ed6098b5147357eee09fa=
796853efb8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 261 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"=
display:none"> Gerrit-Owner: uddr &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt=
;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 buildbot &lt;yura=2Edarnobyt@openvpn=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>

</body></html>
--w9pyWXPfc8E=--


--===============7208962872658351808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7208962872658351808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7208962872658351808==--


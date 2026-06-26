Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF53C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kau8EklaG7CaljvIOdtGJEdDF7kYKwfO86pbchfikso=; b=XDF/TnEV/UemYwk1VfqdVsovac
	93Eo/ZM3WCHUVQM4KhQaizrfYlb+ydOszGycaKsaTit/sL/kcqy5YJ8sKuD+3bmMk4dZajlQvWdQD
	a6OIOj8UlVIymaEPb3Da4E2JPQ92EPt+WLhUnmh8zgwamZC6Gnnvd4R6uH558oZgnVvE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd8Qw-0008EC-ET;
	Fri, 26 Jun 2026 15:25:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wd8Qd-0008Ds-I9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lriLsAeX+Jegbxy/uyGFv/F2v6mC18t5XP8mgZ0iRuY=; b=JADZ8KCEgu670E4Cz9dyziKfpl
 lPXpbh1ldsV6DNW5qc/SWJYX2shQWCwRL/ZOYR3YOA+1+EcBdOMDBjD7Hm8Q6OJNpj2LLeT4ghd8i
 biMR/eykNUuPcKTGBhpWnPJ2J6iVuXNJ+JXERkqHLnQLEUTnmXK1ZXZwfI8dxK4NZ7wE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lriLsAeX+Jegbxy/uyGFv/F2v6mC18t5XP8mgZ0iRuY=; b=N
 4vTc0m8UjV2M6FSbvrPPrthP8rOTRE8bwRshqXpGy7vYpoz8YOnTNbhZaCWnCtZMfeDuuWVSSusoc
 c2X8SIv+7YowOMw9qAECbNZEtrehh5HaNmDYF8Vw6oXfQqiQCj8FOMdTpNQMSbJWKENZ72vzW/GUU
 8g3cfio2+D9n4xpc=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wd8QX-0007oK-75 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:25:12 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso8746105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782487498; x=1783092298; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lriLsAeX+Jegbxy/uyGFv/F2v6mC18t5XP8mgZ0iRuY=;
 b=Zmkn6A/BmS0sC71KFmkouOZR9AyHbbwQ/jwFDYcHUUPyh0E3FM1jjLIG6gXRq2DwOs
 94oTHPd5tKbP0AIJpGDrRb38ILmL/0AdLGENAur78MeySv8xckx0TMwVefkTf6KDtwlJ
 ol2gR0nSRrGNl2Y7gNkgDGlCsPWrKRdQGuv2cLBoP1UbERqYVzjKZHLXsbd8M+ivH0Hz
 rrUq4Net9uMfJj9ypTHvpWmsBWbLj2CSuQ9xU0aCo5UreAMRRb++LQzIIZ5dSLXdjVgP
 EXv36gRSmrbCEvadDe5b4/YGV++I/ofaA7PnVhvTfFzx1NEdDZlWO9Mj8Lbi+y8XuZj1
 DrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487498; x=1783092298;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lriLsAeX+Jegbxy/uyGFv/F2v6mC18t5XP8mgZ0iRuY=;
 b=OS9PIF0rtHjlB7JY64G6xt+3QNepelR0uQMNqFd3oZ4wYEyLDO5Bn6tQT7SQJBFOhm
 jT4tLCpGbzx1kbOaZmp4jDxlORcvSeb0+cHrljrrkBF986H3a6ZQv++n6YozgdCB1nkU
 lWO3aApTSzQ4R9DFTYwUhHM0UKq6aWVBmflZECfTgW6LmeNugo318zUaz9mq53mD48Aq
 oxeVIZy3Szp24QGX5W+2OHZmos8VtTxb7jbZIcfYrjSzVK6vFl5MEcrgKGBSyWuoBdQ3
 LRAfkhUrT/yCD68nucZDIuRQZjRV+D1zBIW/emai/lbNde0O+uHjyJHWcvWa/+hUtDKV
 R9hQ==
X-Gm-Message-State: AOJu0YziPLGPHWLkB+fKYTylzLoq2LCeOKd2CuDs9/+yv+U0Y97vhpGe
 MEJIT5dhpo8bfGJCJEWgZ9Gbc0G4nczpC7mO5JpwtAxmahv6YdVrxz/qMc+ljdEv1T/qvnzJYRh
 fnDj2g+FhPkgjX0m8pgMNHPZskjPHxwWD9HVhKbpOzYVWlHPOXev/Yt0Ty+jMMsnqqr557V34sL
 //BdF4Tw==
X-Gm-Gg: AfdE7ck+B7RcTqJxGnIDhc3Y26W3rn5eRA5wjC3MmHEV6of+96fYOjntb1xTjf9b0Ed
 USOQ80SiXrX//vjPFaqo+puc3tRVIBEM5WTL9L8NSuH0yCmNqirvO1Yc+wa2ugztSSQXHq+ulgw
 lgmBO8e13x7l8Q5cgwB2fH3KYYft2GwDzlfSbdG066rYamQ/aVJEGjffqnsRelkTIC+8yeWEyY4
 5Rp4XQYkUAL8qX/AdaKFtEpHxwDXnULhSpEG5B0Q4O90a6f5iU2teZsSckqD+GNfYC3JAztLSvl
 8rIolbLLm2QO7DbLr9kkuVbx/YGsFDRn4hG9S8VUwgGJhME4UfRi915U2Omib3+wAo8PJN8u5VL
 60Q1NwuZsnge35TDOjpDnjmXB8xG7f2ZJ1cpyc2i7B9FmuATNv58E7Y445yxfz7eCHxdlp+PLPU
 +bKgQecvhoUlTviE5jIOJ2cRqcQSvegioWC/ufHgdqalqhjrWX9QQhHSArYZU9A8I92WEpBzZvy
 4FJOYINTHHLMD9f+fGwNVKlETooIlJnUj30XrgOLYeC4we89NwT8uraNo/o2FInVx0SONwMyJGr
 37g=
X-Received: by 2002:a05:600c:4f90:b0:492:3237:ddf with SMTP id
 5b1f17b1804b1-49266884b39mr99246515e9.28.1782487498041; 
 Fri, 26 Jun 2026 08:24:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c28c51asm34988885e9.2.2026.06.26.08.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:24:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 15:24:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
X-Gerrit-Change-Number: 1732
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1732?usp=email>
X-Gerrit-Commit: e1fc01b4866bf68f0c90d6e676bc78686b021345
X-Gerrit-Comment-Date: Fri, 26 Jun 2026 15:24:52 +0000
In-Reply-To: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
References: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNDg2Mjk1MDAwLklmZWZiM2FkMjA0YzBjMTZjYjQ5NTJkZDZlODY2MWZkYzkxMzZiMTI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d16b3048ce24f63b18f0efae692004fddfb7f934-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wd8QX-0007oK-75
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make get_random
 return int64 instead of long
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5426892192866085182=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5426892192866085182==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C1W+6THq0es="; charset=UTF-8

--C1W+6THq0es=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1732?usp=3Demail )

Change subject: Make get_random return int64 instead=
 of long
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1732?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
Gerrit-Change-Number: 1732
Ge=
rrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 26 Jun 2026 15:24:52 +0000
Gerr=
it-HasComments: No
Gerrit-Has-Labels: Yes

--C1W+6THq0es=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1732?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail">change 1732</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifefb3ad204c0c16cb=
4952dd6e8661fdc9136b125 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1732 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 26=
 Jun 2026 15:24:52 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--C1W+6THq0es=--


--===============5426892192866085182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5426892192866085182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5426892192866085182==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE06C531CB
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVzfNXawEKdd7XGOLB9FmuhfsIfvsDs9OV7DleCx0Ks=; b=Z9DhMINjAvSwF2Xl2NFGx8QLIv
	vFfvD/wKLnXdFcnLws576eQtH6ZeW34zNOm/bOWT6nE8kQtHlv+X8+pWE1C3T87ZJ6RtxXq+vQ0lB
	5OVLCe5yccRxsq+V6J5W1frtzTblq3X02B4VnbdqnBn89nSSgn6oaCE6kRST7lb1G1ww=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmseV-0002cH-RG;
	Thu, 23 Jul 2026 12:35:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmseD-0002bz-UV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wzGNzI6YHfe5BRQkCX3uE2uaqzn1CTnbzHtt/ABHZWU=; b=iGlSfdrIbhODWelDX/keoHrbW0
 ewfyeUQacVqPkTAuYGY97UR0Yj6EnTtHnd50s4jvqZjE5/Nf+Mk+3p5T4TKBCC2EJ6YQcKQX6cSMS
 p+3mUDDPK7KnAexA33CfmLrRre3DZkl3CkUN1/Lsax+3k7WpCJR1ZztUq9vMS4jmiDjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wzGNzI6YHfe5BRQkCX3uE2uaqzn1CTnbzHtt/ABHZWU=; b=A
 dtTIivcO8nRBTFaHWuzdzZglwIWUzZrCBmAxlH7A3h5pcfVa1wrwNQvuRvAKyJPB9g9UfHHdc2M50
 Ptiu38VwRlH3UnNLYfwOYW+/aLHZmox172453KbE0WAzL1D7I5cMoPYisppGqvgk067BNULPOIZea
 85IgLg3IyM7PiIZ4=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmseD-0002q2-Ey for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:35:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso2970405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784810123; x=1785414923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wzGNzI6YHfe5BRQkCX3uE2uaqzn1CTnbzHtt/ABHZWU=;
 b=YBTOqHAUkyVzkqdtd974wpMZOFeMsLLHYCsHbZaVweBjzYH0GBY0BWsRAPYyW9MPyv
 485WDELn3IH1keqyS+v9J8Z3W71yqe5MS/IkFud1pjjVpXBUX7zdy9+XAkQFa7mFvw4D
 EYlSvVZV5Bf6H6O+O8sL1VNQuxgKhaqAK7p7lifqjCBCFYN89FRlV6ZCxxh8Mz3OmLg/
 Jonin9wTZY7mt+t56k+mq+V3cXXf72lRTVJRsqWqlVcU3QYGHDhQ5BcPNu7BtixIhcHX
 5uRKMSufRfdSoo3ASk5dV84TGk0ToMPlhPSNtDzsYZkLreMZYqrF6WmIHGWyclJWrA9p
 0gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810123; x=1785414923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wzGNzI6YHfe5BRQkCX3uE2uaqzn1CTnbzHtt/ABHZWU=;
 b=hs51xpLx+jI11ZQ3X1c/HgWDwLvh978ulMZIlU/hHyhJ6vtbsPMmZzeGKCS2hKXvGi
 hLR2tK+jqagp46iuYDV/EXsjjVpHOuBnfgxTdU8PbPKFoaLUIwT8ZQbIIBzfckLujcEf
 AoUX3C2Cr3ysA5YZR/FNCBDuGBOfXtHK3qDLyWKfRSgdX6W5vZvqq7sv98EmHMurCBAS
 Ba5kJXuSCKGhyxY6C1lY7PwFxCQBbXZI9Np5yyj8mInADfHyMEzBxyoCeldN5U9lkVR/
 QOrqCPf+D3DOnKQoHG48fbitZD6JmbYnLfMKYja/hOz+avUJCHBiL6mpsZfYEhOKxl+v
 /0MQ==
X-Gm-Message-State: AOJu0YzUrSR0NGfULdS0JE1MCnQWJ022YhLv6+9n4SAkEETxKTZH9/5R
 Cikin3KDO2NVQln/mxYJRSvWVqVsiBucBLjudasxzIGbQ+mG8G4QzIlEwvC5KYwlL3e9/lTY4YE
 Hm9UsyQ+vt9cAJSamNUQyWJdV4mICOyC6sAmqSip9puHfz0iBVojJ/abt3471q/HSyAjL
X-Gm-Gg: AR+sD109aRrJCzMcOe7DXRs7ptWUhIhrKgy2EbJULjn+d0xq3gnrnAxyhy2VLLaYbo4
 bJGJ+Hu7N2J+oB/W6M3E4XIBbkdc6KHI5EE5vLeO9OHxCoSulRpqqlZ9enkeXnFYJ6MAKvUFdj1
 MbxY9/4rnNyJUwVpYZF5FpPCftaflNzHMMFveTuBozEpdt5mp/IpTvH5F2W+856pzeshs5377+M
 eNw5RTPnDlMTz+fH1KM8fvqtoMpV7Cr++OarOh+dV5Bs+z5Z7JZIqPOyDvZh2E8GffCJ2PWLNmk
 QJ3dgZVCNi05YVWXxiux3DoTqkqVa3pjxBpL2z2kisQQLaKalTLF2XYzn9Y4spKKTuuV2mqyOzO
 yXsbRX8HNhJQO1VzEfLQUZc/aooe7la65Rn7Z/f1BklzNDExuyt7fesVeGxd6byqctXkR3Uo23D
 Rd9Is7jAuSRUBS5Y7uNfwVP0WzpSS+TsChifU9MayRKMzrpp+c0kF3FmwUIln/a5mA7uznvpdHc
 9JZ7Ay9uFn3FdwN8Lyx9ny6CqwAH6eX9m4Hu2TTTXWq9w4FZBLKMalUS5CuQiMq4/iI
X-Received: by 2002:a05:600c:8b6f:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-49574581059mr27224695e9.1.1784810123138; 
 Thu, 23 Jul 2026 05:35:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f24bcsm170942455e9.1.2026.07.23.05.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:35:22 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 12:35:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517
X-Gerrit-Change-Number: 1731
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1731?usp=email>
X-Gerrit-Commit: 62e3dd04c20c2c5e0ddfee0599ad6bf0fef9d502
X-Gerrit-Comment-Date: Thu, 23 Jul 2026 12:35:21 +0000
In-Reply-To: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
References: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMzkwNDg0MDAwLkk5NmQzNjk4NjAxYmI1YWFjM2EwZDdhYzZhYzViNWRkMjNjOTc1NTE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cc50a34cad5fdee958aed87e98392936a8d5e054-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmseD-0002q2-Ey
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Silence warning
 with gcc 15 and O0/01
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
Content-Type: multipart/mixed; boundary="===============6825358455377300581=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6825358455377300581==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BipWXwaSOzE="; charset=UTF-8

--BipWXwaSOzE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1731?usp=3Demail )

Change subject: Silence warning with gcc 15 a=
nd O0/01
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1731?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517
Gerrit-Change-Number: 1731
Ge=
rrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 23 Jul 2026 12:35:21 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--BipWXwaSOzE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1731?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail">change 1731</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I96d3698601bb5aac3=
a0d7ac6ac5b5dd23c975517 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1731 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 23 Jul 2026 12:35:21 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--BipWXwaSOzE=--


--===============6825358455377300581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6825358455377300581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6825358455377300581==--


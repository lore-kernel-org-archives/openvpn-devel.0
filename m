Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D6C531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XX3FlA1q7dxIfQSZLjib5dH0sq8SIYmKDzdrUQDqBSY=; b=Tqv37gR4ThrcafnteobW/3GQgu
	dSfHFtXTzg7n8sDBW3/drY1E1X4tlLLFc+IqN4H5vpQBrl4mkqyiRiILbZOjCpd9tZ08K35VXARpl
	oVhx4RI5qCbdZF9w91zLcQlmFhrYgK5gMyaFsffecGd6igVYN3pqNdi2XIbOvIe1A/9I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnDNj-0003A1-0j;
	Fri, 24 Jul 2026 10:43:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnDNa-00039D-U4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FNv2je6KMqdXNt9/cknE3yxLyuXIG0w76w0B/4OWzBk=; b=OBQTYplnnhrSpilYzgtDo5q4pz
 G1wmV/pamKJ6jjt1HR5uCnfQm0Ls73Q1ZUzz8sAXX9MV+LdNijEdUcvqTlN5AePIB+qTmPxeCJSjI
 WTkwxPNCYAJoGhdGrMdHxTk0EWCs3md4NdsoLuMQPBRm6TVPvfKyHeBLat3Jkk82R0fw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FNv2je6KMqdXNt9/cknE3yxLyuXIG0w76w0B/4OWzBk=; b=A
 ox/kP7Mojc3FAs3PSCb+/7V/cQbDf1TBAO3CqHQzpDmfA1L+O8nj0YifwijmoHYgvlZg/C7swE9ZF
 wPlef1ZuFfarhiOEuYkDhVWjWXTBIMbXB6fYGalWhuSUnnJwBCjekA8DNewnGWIwYh9O8XmN+zDL8
 PQpE+SwpqW90/FiE=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnDNZ-0004k6-9a for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:43:47 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49557167508so2921545e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784889819; x=1785494619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FNv2je6KMqdXNt9/cknE3yxLyuXIG0w76w0B/4OWzBk=;
 b=Ww/tYBrHEg+KPRv4J6Ixj4hQcjU0iIqAv4pxSI3ySbCa7Cvu3cIQPVQArIKOGcH4/H
 nw1J2i863QdJEPCjQTDNNaH4R1GYx83HmzlUc7vsYRz0Ert6cf8Kt6koToAkX6aT58Ts
 3jxF3jSeWwg2hduj5ADUOQHvG2Le/EiwnLJPYIhYU0zlmPaj4rekQ07LUv0EjqdHkmPJ
 GiXvt13Ab4X4kyofuxufP0lqF0u5a063ueecOY+jENCWlfHAteAG2jDBgVgQ3C2O92Sa
 CFE2SKsrnGwaJG6lz+K990kD6TCip6Y3NcR1zq5a090hWVHHe0ALCysl7vN/YeTKf4PN
 LqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889819; x=1785494619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FNv2je6KMqdXNt9/cknE3yxLyuXIG0w76w0B/4OWzBk=;
 b=XqFIsRj7GXvDc5TrMsxwPBAMtvn7u+AlUPlOtO1XFVGRyYd0o1aPQKcW6OyyNE7DNi
 BYHMYe458RWKAw73bs6UYLehgjBu4mUJM6kdCqGDBAGf7fP3A1UTnCfz2oBWbV3i4/EF
 Lwdtjz3YGANStsj2WUy7BVN4q5c1oBiTeV8L61ZWT51jygSqhF0j/f+hpDCPkQ56CrOP
 sDeLP1MA4RvrLB0mBJLpFDRlo94Hbunl2P1KaNarT/oKyT4bZytiZt+my0iqV7k0i1xY
 CYrkPeLybjpApLUkH/V42yUsR/x0fZTmrI/cFgUHdEXtFv6LB0VkUIpBu27o5MwkFTFX
 S2DA==
X-Gm-Message-State: AOJu0YyXlAzug07Gctj7KW6MGZJBa8KuyPzTHSEEfyNLSh4WmNiGkgBr
 aIFY9ttCfMNXCeLc96k7NVoSwH+eLXk5b610Ec2D2IbhHqFvWYLejmT7gv40DKkveP0u3MnY0j6
 bQ9TLqfsi46PBmN3tqhsk3iqqXR3y/jif1UvU2YfaK103wXO2HmSOfPYauziJ88ZfoAWn
X-Gm-Gg: AR+sD10sGWV/XW88D+HvGmenBhH4biqKsttiAHOk8hIUa4RZ+YCrxHZZLe7GMQJZKKP
 Rtu5eQW8boVW3XTNeHZQpL9DYq81+iDA3/rPgMRPmyu/uxCvISEwqCgmeowHq/xAfckF5MSY87b
 2IVlYwCkzDLlN/0FAlxe6slYuTqizipnBy24utKSs1V5Nn9jv9HmktyQMzOMMVoFWZuTZzkeetl
 PGCuMG18ao449A7IERKjobDRXr1qJjP2XNF0D2PHS/rbXlPW5IyEfXMRIt6w0rPSU4pNZvmgCP2
 GWXyDxY1UHeUnAj34j5Cxm26aw7ronMYb4OsCYfiwdPJ+5l6dB6pL3daIVwh16RRnvTYZ/c7WMs
 ixnp4Q9JaDzSh4Vi6HKex5R2cMsBWiKS4UfDuPpL1PeZsC/rEIkdwBiEF8hJYn3G2NEbO++FPAb
 PPBESdwGE8rM3t8rXNl9QKrLcPNBk7/FxxpQzNH1rrcln42fv/UBqMCXYlmOD5VcMbw/ZIYGEkX
 ne59U0OVYcPuA8YoQF6OKMe6d7IpSKI/Ur0oDwYn3QNdF4bnkD2kaCzZFU0jLUNDSXg
X-Received: by 2002:a05:600c:630d:b0:495:64c6:84e9 with SMTP id
 5b1f17b1804b1-49573c6a190mr83073005e9.0.1784889818461; 
 Fri, 24 Jul 2026 03:43:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9928fdsm21524955e9.1.2026.07.24.03.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:43:38 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 10:43:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 67fdaea1257715386493e61e8d0fe9313ee70cce
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 10:43:36 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <729d5e9f586f6599ef436b01304acb5dbdbdd638-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnDNZ-0004k6-9a
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
Content-Type: multipart/mixed; boundary="===============7441867467069322350=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7441867467069322350==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GKnyTx8L2kc="; charset=UTF-8

--GKnyTx8L2kc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 13: Code-Review+2


-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Numbe=
r: 1571
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 24 Jul 2026=
 10:43:36 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--GKnyTx8L2kc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 13:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047=
b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Fri, 24 Jul 2026 10:43:36 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--GKnyTx8L2kc=--


--===============7441867467069322350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7441867467069322350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7441867467069322350==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0F6C88E72
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzGEuW/PzICf1ghOVG//8S11qcFSsLHp06WJ9Ge47Bc=; b=hZxKGurxF4YZ2yYTUskSQm1blZ
	HDRxTv+fEMEOPeLzjfau89tWJTDzUhoSWXE5QykpeS+GOf8cmmHTI686wqDUYkunCQWlJwFk/NMml
	pidZ2QVYJvk+VNl+Ji7JQ+J/zwTYAEtSgwzVPdn1e5SMmCT3ypX34GfhwTFp+KXL/GRE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67ZT-0006sT-Dr;
	Mon, 14 Sep 2026 14:22:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67ZS-0006sN-Co
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=asCumNO8VXz6rWRHOu50Bp1CDNnL+S89laTrOYqOJq4=; b=YEmOZy4+prhLHtHPO9mm9B60Lg
 dvXsh4nsR60RXxsT5o5cOb7bKAE5EOgz7eq22GdfAd6iZ9Dwxet6h7kJT5U1Tna1RqhdJwaBDsA0R
 +xUcRRNszFIqECVtLfspGZNe91or05zy+wvx2cLV8C1Pth+hpHhhKR+cY3JeAfovOIJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=asCumNO8VXz6rWRHOu50Bp1CDNnL+S89laTrOYqOJq4=; b=m
 XbD9RuV4FmNbpuXovkqZEqarm53SqxwovrifENvZMieiKB/Vk8HyGiH5ZtcVrdfNtmvI8tBdafbNo
 cxHoMFyn65jJZPtuuKUJfrUHxSQfMQnSM3wxUFlYX4XbjFueT7n4snvJpPadsjAoQl1uaLetuM56W
 kZgoEsjhQAbewp8E=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67ZR-0006ml-PC for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:22:10 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso655274f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395723; x=1790000523; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=asCumNO8VXz6rWRHOu50Bp1CDNnL+S89laTrOYqOJq4=;
 b=Qhkb3rIbUvVNbpWapktDxqomqpMTjLGXirhs0aECy10yIFG8rl+PKZuk5qZrDlj+wF
 G0CozNU2ljQfikJN0suQoSAHlECik66VGGRSvnmQC89DLdoy4RsEiUkXuFJ0EUg6uuY6
 zDgAC1PQOJtDgENEAUXnT2XEfwLMwhEq1YEoqmuy3cdGYxJsqJs5iOzaXcJiitBdKlzu
 QASnxJsbcIoIrQLtE2/tCMCtEnQ1LIo+L1Oi5jKPim9cYbWQWQ279WJla2uzn40zM1vo
 0s1kMzfWv+mQbDHTD2tcdRw7HKgaJr+r3GH85yaiytOKS6BpfnLGNBIYfxq3O2RUFC5L
 nunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395723; x=1790000523;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=asCumNO8VXz6rWRHOu50Bp1CDNnL+S89laTrOYqOJq4=;
 b=bkCEcxjm/FCMwYY0CcWAIs/aC1M6WtH2UslRPQv+AO+usfE2qe16U1svEQHsLtKETC
 Eu+5YypwXI0pmG8nWRAV7IC2jIPutGSjM1AitWs75MKodKQs+B4TwbyATxuYzNVoIi6G
 EWw0/uzxSyxgbWdbJDrPNT34M1y68bxTz3Eyy2YhIV20Gbb3BHyExvH6BYFEsN+agOoJ
 xg/SouzIxA51T7j1ZzcqUFGKyyrQwjuzUyHpd5iDErw00HBKaWMFhURIr2HwdpszsP4J
 lhrto/d5pYeA9iguXyF7gbgHfCFUiTlNA7TZnU4OkCxtQuPgJuLn6OGm8zHQmjyvKuFv
 3CGg==
X-Forwarded-Encrypted: i=1;
 AKwUvByLhXF8CTCYW8vBLYe9qB9pEkwpM/pYuOE7jbMA/dmqVr87Kga43lP89v40kzqw/1Q8HoIuckno5NUIJ/DP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kn9smZQS6Mf96q9A5yzh0Q7LEck7tuA12tChfHuz2aZSE5Qov7
 LMi96X+WinwD0vhUpCziQDri2GBtGFiK4zYPdnYv+ZhvPfAXYgU07pXzaotNog1Y93nDpDS98XQ
 4RJKLP3ZvOJCBlOVoQ3WcU45eo8d75ndRLgKqdOBxKfXVEOQBIC+nzQppG9IcD5QCK3IG
X-Gm-Gg: AYBFou05VNYTEYtyOzO3lj0d8M0mUWOPaVxE5mmQVKtP7bwyStAZnZyV02NdZdWTgc/
 hBNnD6B/EW8qAE/d+wuoHxmrTuenRsL67P02XdKH1oVdfPwXq3CA35HjqGI8wX2Pr5rK73PdvAP
 cy/8b+syBNUOgC4n2rmSObwBF+c9cAX4VjJXu45YleYDKBri1WWngpD+A5UjduxYHXer86QQNmR
 ZHaVoOXAxZv6yX0bY+uSdvuxyobvVcVB0Pl9g/+z3kC3cXbuhfQ9/vitRtq2j8kihE/Ev3Xwz+u
 Ibh7Wj+UrBAkuCNQMM5IwcxLkCPnixa7xpZnY8fZB8PLfnd3Zo2Q/8PXe1UG6rU9AbXwr3KBEG0
 6AA/gqYAoBY80wym9E8nq/KZmuV1M8nTlf9I7ARQCjahHLGOSbiQPrnsgrnhAqsS22wjtn23lqt
 REykT3LOWQKbh+YC2Z6HVb4yiOCCoWwEmSZh9hjZOAfq7Mev63fRNxwbrmFvNSGlXiQuYVts2QO
 hvSDkJ0oBYO3w7n5x22tfy2g+lv3IRwC4EmFKvQNSsWgEpRxIJmwNphGtjiYvEB9NwHyn3ejMpK
 xCW8g1VeuBxZRmjKBkmWjcek8DWyc32UiiE3T5afyUr/yAtOOsXfgncgrK3LIQ==
X-Received: by 2002:a05:6000:2613:b0:486:e6a2:2d8f with SMTP id
 ffacd0b85a97d-48702928b2emr3503394f8f.19.1789395723030; 
 Mon, 14 Sep 2026 07:22:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf23sm27797498f8f.5.2026.09.14.07.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:22:02 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:22:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c
X-Gerrit-Change-Number: 1913
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1913?usp=email>
X-Gerrit-Commit: dbc36f56a69d0ca4c77a76b126678ada4d74f259
In-Reply-To: <gerrit.1789140193000.I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c@gerrit.openvpn.net>
References: <gerrit.1789140193000.I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTQwMTkzMDAwLkk3ZDhkYjE1YzIyMjYxMjc3YzQ0YTJlZmQzZDJlN2NmNzFmMjNlYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8709e1cd8e25c041af87075745c508c913fe86d7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67ZR-0006ml-PC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0570987074940993027=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0570987074940993027==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0uXnvc9HFI8="; charset=UTF-8

--0uXnvc9HFI8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

stipa has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1913?usp=3Demail )

Change subject: oob: Wrap the client SERVER_PROBE w=
ith tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Abandoned
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1913?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I7d8db15c22261277c44a2efd3d2e7cf71f23ea0c
Gerrit-Change-Number: 1913
Gerrit=
-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--0uXnvc9HFI8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>stipa <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1913?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1913?usp=3Demail">change 1913</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1913?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I7d8db15c22261277c44a2efd3d=
2e7cf71f23ea0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 19=
13 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--0uXnvc9HFI8=--


--===============0570987074940993027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0570987074940993027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0570987074940993027==--


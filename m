Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF520C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Li9R9hezeSVwF6LPWC62FFMiNO6ALLiYFxSwGcE7Wlc=; b=Qnsq6qgqW6useqQ3wGEh75ZiLA
	uQiahPVz71TWwGk+BuYys6l13rB4pFbrVpHX3KzeVQkPHuW+HyMw7q0Is0cxzOhboVT234C6v6P/u
	Wvrnm61bFJWH5YL3GujFetJm8BNK1WeZk4i52XwL8XmJsdN96NUc5Cdqg/YtuVy8Fb+o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZHc-0007yo-2o;
	Thu, 13 Aug 2026 17:31:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuZHa-0007yf-GK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mzgmCgqtlQ5nRabuYc37N8vBLlMdwu10ssnlXGghRl4=; b=FkLLqHxI1kyVlvrB8wn/dz9j6X
 4+/ZsNsmgbm1lTa14C8yIqH15nW4YUd2hNIf25HgngSN02Sb1zVIjc2FfCualwYlUz8y4Q0B/cu6q
 0D+vUcVX57NxpuUJ7/jj6EAJPcIOrDDGB1FpEkyxjqQHJnuuqpTJ5ubhiyqbWrSpPncA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mzgmCgqtlQ5nRabuYc37N8vBLlMdwu10ssnlXGghRl4=; b=d
 +IPSN/mGAHAKYUw4V/7S2MlrLBy35wdu64VGSR9rd/aFRLdEviNoXl5i1B0h5n754f1x4pybLOZdD
 Vsldq/DV9x81v8c8kdJ0z1O3PzKfMGPTCZoV6VV7QInzFFET4/8XZbPmL/TtLaWW3vhRKFYuwWK4o
 uMoW7L6R9Pmn1dPQ=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuZHV-00069k-Ds for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:31:55 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so1560855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786642307; x=1787247107; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mzgmCgqtlQ5nRabuYc37N8vBLlMdwu10ssnlXGghRl4=;
 b=ff6dYNpLgXI4UCgy7OlM4lj7bl9f1j2LQFy6D9M+agrTOM4vQOzd3vbQX8VS24sMfx
 dt/IZ4eI66v4WWXxnOkYmxtCNG7r53DuTWAmOVpj590ptPvK6F80AVO56iED/pie5+ZO
 cOTF5qXlgI88ucZMTrDr6jSurWADRcJnTjqDDKmwCwmE3NdznehBR0Yuki6o0r6SiOCV
 Vw2OvVo5Mw3P6Wbr9lUcUkM4CIJNi4r+KwT3xvfvVSYG+JNdkoFFXQUVJGdi+99RXrmU
 LgGnaqyeCtSLnig7ZypLqqhuA8KuhCePDquVPbFcJciTKOA4lzZ7IE+0jx9rI6PC/BvL
 VjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642307; x=1787247107;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mzgmCgqtlQ5nRabuYc37N8vBLlMdwu10ssnlXGghRl4=;
 b=o8O4fudM/K9N3Hfei7KXIH5GVdNGhebCydXqCydms0EljRa6KzAJR1sYZj5iamRJ5z
 TreVtuUU00zxkh0kv6RleXwF8AIdYHW5RoOWaMhM/D1HZmP4zZLpmoesx/mjeile/Osl
 +bnaQqT94iOiPoIcJa/3k7HC61r3MBuuZ0UkMxfBt8ZGYZ+Cy2zfuAe8dwSeV2/LeyvP
 GjrQVTwji45Sy9JSX+cZ5BqMt3+eT+UWRgfPK5Qjvfci0uceD6UXt9e8JB3xh71L00g/
 EQ/ru/y9lkNR3zd2ctvLMYpEYDovDNBt7XstWnYXuqO/Nmcf97hw3Nh1vjVD2A3jpCfO
 49Bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoQ+M89DFxFO8ISfB+0TvEEoYSbZojib5Mb66o2NP03EdG1uDSP/dGzcJVdndQz1rFwmWInHHK2CwwUm0/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyxaR5WNmfmm/9TKiJZqiMqz8P1HntD/cSmFiHcaXth1WBNEEu6
 vA01CZL8KIquz11C1pfpJPQMC8V9ZoWGE51NTB7xkiOJN64/HxBpoIyNAutjvxsXVXZd3oF++sP
 wjXCprhrHJ+4p+Uw7Xdk6aQJHvXX5Yn5wSk8wsEnS5AeoylEKlsfw5KUBfwXdp+HaxSGk
X-Gm-Gg: AR+sD11Lwhi+B8vBX6nGwmhdYBI0nX4ob3eZ0RuS/1Ebz0TANLYZ0l3RpgW8Ej0xzO9
 DvCBrkhmFClKiUXNT+tTPlf5P5A/EkeoObAgBg5ZD6gD2hOJsVzk+aGbivIWq3f0FTzZyHOGXrn
 Djyr9ABL9He0VjnpSSkP92lzBwq/NPMOfrOevsCS0an3fjslYHTs2OsUKlNDuSsPNoTEjHmGFJP
 tR2jGGc/Z90cU6+x8Mg+Xp9Wcewq2JOAPlYECvDL+0w/Yt+R8s4BJAIpVviP1c25p1Q3glwiEy0
 smxyWqwITkLg7FzKrTf4Zrc6P4D97Nw6SSbu0t+0g7hgXYt/lHj3aIcMiVcmcjtT1g0P8SjDjRV
 NmXWQVMY23QQh+0HK13ZAjq22EWZFKf63FEz6wS0pKE6M4hPr9uzdm2OoBT6kGHaiZtkAc2zmnz
 GufN6R8fOmeYP+FlLMpx6QFWaWqsoOTLsS1Z8iCtRGA2uCpfdhMdcZt3eu+9Ry6eXqTvJxpB0JG
 IECw6FSXP9LTK00hf0dt3sqkBTWWolUOLvepeY6TkkrZ7KhS+EbmjPPZeGNnjoXcWIhUeQvMibN
 GbitOLeSJxHrBf8SXIf1GKHjGgf66Hq041QtJzZy4qK10Bh/dMjI
X-Received: by 2002:a05:600c:1992:b0:499:4d4a:4990 with SMTP id
 5b1f17b1804b1-499879441b2mr1010595e9.3.1786642306754; 
 Thu, 13 Aug 2026 10:31:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm898651f8f.21.2026.08.13.10.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:31:46 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 17:31:45 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
X-Gerrit-Change-Number: 1527
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1527?usp=email>
X-Gerrit-Commit: 1042fe173bd4ad663ef967554f0648eaab73805a
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 17:31:45 +0000
In-Reply-To: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
References: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMDA4ODk2MDAwLkkyY2E0MGQwZDg2NTk5ODk2YjM4ZWExNDY3MzEzYjZhNmNkYzgzMzljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8c8bfc2cdd5c172aebcbf32f3db8f2a11437d52-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuZHV-00069k-Ds
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: Avoid
 sign-compare warning in header_modify_read_write_return
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0239290271881544367=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0239290271881544367==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XMaTRVBqXD8="; charset=UTF-8

--XMaTRVBqXD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1527?usp=3Demail )

Change subject: tun: Avoid sign-c=
ompare warning in header_modify_read_write_return
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9: Code-Review+2


-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ca40d0d86599896b38ea1467313=
b6a6cdc8339c
Gerrit-Change-Number: 1527
Gerrit-PatchSet: 9
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 13 Aug 2026 17:31:45 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--XMaTRVBqXD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 9:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Demail">change 1527=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca4=
0d0d86599896b38ea1467313b6a6cdc8339c </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1527 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 17:=
31:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--XMaTRVBqXD8=--


--===============0239290271881544367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0239290271881544367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0239290271881544367==--


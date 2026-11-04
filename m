Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F86606D81C
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HrhT0BYf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OpeDc0E1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Zh9IquVD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DJxekrF9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZjWZpxR0inwNRDx60UGswU5QlXKcxBfmDqdv6IT4KMQ=; b=HrhT0BYfpK8R8oGGvw2fbLYumM
	Q+z2+MIbfe1BFCcdMA1VQyUtuLDnjE85ZztG4SoUShqVTVnYriejF1CzdkG8w8hiZaf1Nc/cxo60l
	90jxtXMIDO5Wwr1acPjLYWuaPLFFngs4NnXIYgyU7sznIMCuVwIygycXNuaPzvPYLbLA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOhC8-000000002SG-0kmA;
	Wed, 04 Nov 2026 20:02:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOhBp-000000002Rx-2luw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 20:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EurEEMlBCytmw2X4XVoul5nXGNvbg9G2WGWX4A7KYFc=; b=OpeDc0E1Ty3e2cxv/GIHhbqRKE
 BqrT8aQAVlJsniVTwkAa2rmiiZ5W1gxaYa0bKpDK9uCaFAblXFa2bl69ZqdD5vF6fUoeahbDzE1lX
 BeDIHkdZQ6OCJWhueynym6OMPxCGSvkBE4CZ0a/wbZZjBIgNnbmkmdT9HX4VuaYInBSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EurEEMlBCytmw2X4XVoul5nXGNvbg9G2WGWX4A7KYFc=; b=Zh9IquVDT2TnE+SSqSo4EuxRfF
 JI/kToM8FAYUUFz1PPCooMoy8rRiuSzNM9OjWMQBO9UDMy3ekQblfqShhgpwPomEu8Wd3XL4O2Pcm
 nA/a4cJfB+AtbPUSRVW4JLbLaSNjDz3nc6z5TurQkpewkn1Ept+nKtk4jUQwSQlGDM6o=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOhBh-000000004vm-369h for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 20:02:28 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so445992f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793822539; x=1794427339; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EurEEMlBCytmw2X4XVoul5nXGNvbg9G2WGWX4A7KYFc=;
 b=DJxekrF9Ci3rL6+eDDvjKIjukyMA31bPG3RKk9vsDbtCa2yxdbLyM3MzEzhtXtZPId
 BUkCqZWgolzYWnUQLRK6+ZsqDMoc2CIiusMBu65rchnXFWxSre0RG+xHX9DUOc+t0Urq
 5owdJaLUQrGASamOvtlV6pTDUxyQBiE+XhW2WxjUOjr3ow118qAnJdSo8ft21aKf0u0y
 bKqlH1Gjzz1l1eQ6yEWlW4o3vN09WWKsGR2eIT9hyhpPPC4bYziuAOJlaoCig6dUa5Kz
 Frpj/P0zUTVbnAs3oqvdEPxBXwT1W6PYwSTjKoi0JQJlYIyjtKQPCzKesHlDzMn2PA6v
 YHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793822539; x=1794427339;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EurEEMlBCytmw2X4XVoul5nXGNvbg9G2WGWX4A7KYFc=;
 b=mYvOu4ZuPH6vul/lZ3zqsBx8yapKqdFJaXVHHCpp4bNyM/yWQCFDdJ4elhU8zuIHOP
 jPNg8YtRfASNriUGlJfdA8XL6jdvxSrYT5SEiTi6xeLrHWYqysD1ChABzWG/hVB/9vrP
 iJiLqlUuG9UG0I/COzdQSZbCL+Pxa1zF5fMgHlunzcTjmSbSQ26zP3WSlaRvT+5Lq21K
 KbCIxX/A4nZTaBiz6eTOGXoZgHIISWcdheBURibI0OitjOudTojpjNiy8oZWdIoAXo2r
 qolPvnFW/k1Xr8iYgqaYrrak+XgAH9cbmPWiV7zrt3hJ248rwPbkpXJCdx15twrrU5Y6
 XAmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxctv3ASy/+afeZfRIvNuk0n5d6v19vL8JCEBKHFGyoX9nakWHvC94ZjY56fFa2Cfdjg4Wd7GRfQt6zFGgC@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+7FgUOfQ6o2hJPno5V4g8qqDE/sSvKqlTsr6eD+W1XixUh7pvy
 iIBc4pbGH1g4ntSlcBtS/Y5njqc3AbGavetbGrj/DL13B7FdWXbQXkXqpN7In9jqakvcEkxs+lS
 yrI1L+FT/7Zi/ItXeNW5efQ1MvAiUHfPEoyczn6CpwB7ZBR+WBcn/LmsZkzxOSh2kfCyv
X-Gm-Gg: AYBFou0d9FzsyHES0NVEj8soYFvblBuZvoS5IhcSJM8MjIP4LhL7bc8YhcHf3Qnd8mU
 AyUz8pd4FyaN3zHkw22y2+2PGsrpOZ3WTT90ipA/EgoUcDgZTqkZ7pcaN/TWJpGyi6NslgiCrYl
 HMxDr2LgH8H4cYArxVkqGhXgJEnu6FyD5MEkLHAjv0e2sqeW6qYj+pGbmKS338Ej/intAhUJG9y
 vzEF94xymjdy9Tw5WLpiEKqH7MANcHDR6d6ZHcn8EqmIkvsK8z8PGMyoJcyQo6Ksm44P8jnRPpt
 6rVbuuSf5gyk8ANltjUdgT86sFCsEPXYg/CdnzyEALrtPYZSodtfoBdaaNwGnjvYib0dfT09hs2
 97HuFqwvZYqdrSETOqWxWKAGINe2c41lDs0BDdEb7xAEWWsv5XlvoL3akUsczFf8bWluaebE2Lm
 aClxAaV7ZWrmSYkvjgq3J4bwGnnJuDq0RmJCRTWughv6Q0nG33eCOC2lYnJnF2V38LsUUgbHkPg
 cXCAgZoNG9pd9arEOcSWFHMjDBK22daqv7lSk1mB7X9obceYtzorpr5UlR54rD1IEWHNQtScLDr
 mhM5EVlGYmhcb9RJf8neItv7iUtJ17xCRTepZ36vqemZHO71D+3nuv9bfa38n3HuKjUgprCiqEA
 JtE1PPCmEkFuwcPrSh4BpQPfn8gH5OmOlKnhMZJZC3siyY2GnVTaaaG3rToWH6YnBp+AtyKFnQP
 jR25TnQv+RIY2ATA==
X-Received: by 2002:a05:600c:a41:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4ac150b2136mr364022545e9.4.1793822539037; 
 Wed, 04 Nov 2026 12:02:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecf8ef85sm6197618f8f.27.2026.11.04.12.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:02:18 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 20:02:16 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 81c4dde479fa60d5fec0736c65406622e3327206
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 20:02:16 +0000
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b555333135249b2bd4ce06226f6139b43e6560c3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOhBh-000000004vm-369h
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE: enable
 Linux DCO address and iroute updates
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7664662419364132814=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7664662419364132814==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCuo+PZL49U="; charset=UTF-8

--uCuo+PZL49U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail )

Change subject: PU=
SH_UPDATE: enable Linux DCO address and iroute updates
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1=
 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063=
/comment/7177331f_bfbe3311?usp=3Demail :
PS2, Line 13: scheduled-exit check=
 to report the push as failed=2E Skip clients already
The `scheduled-exit` =
comment is stale now=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2063?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I24589d5158f67febd3c25af029944d3f1da32763
Gerrit-Change-Number: 2063=

Gerrit-PatchSet: 2
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mande=
lbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Wed, 04 Nov 2026 20:02:16 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--uCuo+PZL49U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 2=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2063/comment/7177331f_bfbe3311?usp=3Demail">Patch Set #2, Line 13:</a=
> <code style=3D"font-family:monospace,monospace">scheduled-exit check to r=
eport the push as failed=2E Skip clients already</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The `scheduled-=
exit` comment is stale now=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">change =
2063</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I24589d5158f67febd3c25af029944d3f1da32763 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2063 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baff=
o &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Wed, 04 Nov 2026 20:02:16 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>

</body></html>
--uCuo+PZL49U=--


--===============7664662419364132814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7664662419364132814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7664662419364132814==--


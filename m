Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87614CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S2ql9+j/YyuW14uc6fAr0XLef3k4T9MfW6qPJslGeKg=; b=nNZ93wdswkUvY41VK4aYx/6C/V
	bL6B3nwFPVWGbxsBXw33V2PUdP13HC43gathd0hGGzzg+YGV4cn5wR6kN0i+SY3vKwUwFgRfaHE6O
	qkuxiLH6Hh6kHPHaXG+Bq+zIYqXRAL937zv9cXezw3mUKXsZ1BwrAibKUHZW6Gy3FcZc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI9w8-0002WD-5A;
	Sat, 17 Oct 2026 19:19:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI9w6-0002W4-AZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nqmAQjErJ/cJbNlaBv+R4TPhOaVMucDFBgbG1CyGgKk=; b=G8f+Srjr4l8OUKqq5HkSIHLH3j
 ytyuaBIm47qwhzj7u0AxuKKwLwwy6HsAnlYq6uTg5n7GmMpAEk9P0VDXn2BNsGqRGxxg1+i7QagVX
 4obUK2uZ2/M0UfzpcI5rQ33bDHX5f/E11aE/JQALJVh4OKS/PClYTCcBqMNsvAELd+zA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nqmAQjErJ/cJbNlaBv+R4TPhOaVMucDFBgbG1CyGgKk=; b=D
 cNGHlLjsUIOerbfEvAC/RExEXXprWyPgZtB0hgEUTzmr5isBLqP/8TTLyqbfuF5IYWsfpWY5VDcth
 Y6jy2Gi74oUN0UPHmzQLmKIDbEV9AQj+8hn8oZFIXsHnL+weOGAuXhqPy3bqZurbxmjJkyIRiQxVt
 HLDkyZ3F1J5VcJeU=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI9w6-0001vY-Dw for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:19:19 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso5867235e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792264752; x=1792869552; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nqmAQjErJ/cJbNlaBv+R4TPhOaVMucDFBgbG1CyGgKk=;
 b=dZnLZLR8lN2RWIWNfxTZQbGQHRK4pqXR6xYnsFXGvnIQTY5bpHtvhztKutLqc+hsF5
 44RB7FBDfFjAhcZHRmkMN8qJjgB5Bb000X6tpPrdbwcl12aJxweS/nJYnCLaPqt0OP/X
 qI52PEFfaJb3rGAq89J1dNSsN+WE2GZaqPTJZv6Qqb18Omlu+1vKIeZK+It0GZ7qGfpB
 HIXX8Y/uE6nLF4f6xrLWpk87WF75j16gDQ2sNa0wUYwKYT72BoT5sNMWhuapg5i7fBde
 Jqef040OopkSRMMhyJd6BWOfpNsbXqANlmpa4/iDyppSwxUYOSBmpt2xJHxJvsKc3q9F
 bwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792264752; x=1792869552;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nqmAQjErJ/cJbNlaBv+R4TPhOaVMucDFBgbG1CyGgKk=;
 b=BHx5HIDeuybi+jq2q6QYdhE78hxmSVNpjxIkwQ0jJpJ2VMxWbGz+awQnpurE2SWxWT
 QFEh+4vfHv5tbFqwjEM7zDsVk/0u2cvxF2lx/zX6dbSIx3IdwdiaqSwep4eFrspOZQsj
 ConQe6Zs6dByE/Pc/cXSi3BKgliivLwnkf0F5uNSAl0vYkko6YZwKDcc3otzujmi9KMS
 3yG5uwuZE4a0kdNT3DCCBiXfiyNcXD7EmzCoP812aw16HuACEteH3dlnZj6k9DsZ2GMO
 0TQ2pEzRdxpW8eUmXVx8TgtBeYVyOrrz883AFfLdt0qLl5jA3811wHWk7Aur3tqP5b/J
 Hl4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByEnQhgQb5HQKZ5yHG115bDyQ1WPhK3ZLz6xB64S4DtbSnjmagzgbeyPcMTy/FlLL1BdR05DYntAKX757QX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLyAt/AxEiT8OaQBjz1c2k9lh3wEP0d6T/r60Fk3R8K+o1XKP2p
 HX6F4fr5J/Icb8nyIlp/7xOmxksB44L/gjMQgzE8c+YgYO8p2EWcGMBNe6sIuYPayHvuwz/CdXi
 XF3R78xIj2wvDW/7AoOKWKIUro4JMSHd1A9ZD5gQgktc0QptaJEV6yeaCyjThEW+QE92V
X-Gm-Gg: AYBFou0BM4EnUJIkYehmfIaevhQMdMNO6muF9lYpW6/jtrZ3vEkJvRybzbI8hALfrwq
 uCvMGWq2EOd/ac4B1dDv+/+EklMsdzprnrrG+5vCDC73+2FgEIV67i/cAGAMgfBGDn0ljHNXNZj
 9cCEIqfQ1lS4DrpdTE9YtmNNR64mQp6a+b6+t7INBK4qPbLnUSxPwCn+E64a6qNFYWbarDtNXhb
 33WeLTMO2ukcOkIhH69dXIGmWbnWaFprMONvziGjL4ZWG5v2XqTWsURsc40+98ty9JrYa0bp83h
 bP+Z6jAJRT/8LwdJZYtJW9YwFtjEbIc3/SNvZdJH+kdmOy/RH7AIrv5bMngdf/jkluazBKuZW0J
 B+BNlDcUTego5fWzUz2TALEmjbAKxQkVqD56Xtrx5i9brvHRW6HpJs50zbMxzx7NhST2xEQ5Bwu
 heawOkwEYDc3tft/0h33V8fwlvQJV3tUcwqiR3pq3sjZER6diMJm55WYFRiXu6u1JWG7NMO3lfW
 AJRGKZm25O7zqVKgUStT/hKbAVB/Dp02GIhV5brLfn1RdPmm8KG+iw6RVz63uW+2mz3BVa3ImFX
 PblgutF0eCzG0UKzfo3zCa4ypnuryPr5X9W0l8ETVJ+7K4YfEHoQmQ1rHTRj
X-Received: by 2002:a05:600c:8219:b0:4a1:85d9:13be with SMTP id
 5b1f17b1804b1-4a1d76031bfmr74241955e9.20.1792264751823; 
 Sat, 17 Oct 2026 12:19:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd409989sm13455129f8f.0.2026.10.17.12.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:19:11 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:19:09 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
X-Gerrit-Change-Number: 2005
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2005?usp=email>
X-Gerrit-Commit: 95741acc59940c22f4234fbd677945bb9b5e8d7c
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:19:09 +0000
In-Reply-To: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
References: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk2YjAzYmE5MzkzODdjMmE4NzMxMDVmNmI2Y2Q1ZjE4ZWZiZjRkZDRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1dd84f42b37ba5ca610ab1f8950b7938a62f49cd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI9w6-0001vY-Dw
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Avoid
 conversion warnings in send_push_options
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8849250427949056545=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8849250427949056545==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eZDDwskBgtA="; charset=UTF-8

--eZDDwskBgtA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail )

Change=
 subject: push: Avoid conversion warnings in send_push_options
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b03ba939387c2=
a873105f6b6cd5f18efbf4dd4c
Gerrit-Change-Number: 2005
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Sat, 17 Oct 2026 19:19:09 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--eZDDwskBgtA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=
=3Demail">change 2005</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2005?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2005 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 19:19:09 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--eZDDwskBgtA=--


--===============8849250427949056545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8849250427949056545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8849250427949056545==--


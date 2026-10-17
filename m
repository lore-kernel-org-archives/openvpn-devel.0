Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E7CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcaY+gj7n75NQFbb67VTeopo5R0HeFE1+3SI+iujwf0=; b=RqJV9zFtrQfC6GVFWkQwtDEAYi
	8ju5Xzc6UYpquM01Tvaaq8Jl/6plWC7QCZyO+5+0N/yDZS0vFfA+eQr4NBdSDqzFgAOS3SYsZPkur
	WN7H25sInRPocFD1Ja4cu+NE4sg+rwDKIMtddVmIlNLRsTIU6Us4Z0jgZOqo1oETuVII=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI9ne-0003e8-QX;
	Sat, 17 Oct 2026 19:10:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI9nd-0003e2-1f
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EifRWc6pR7OlXs7E2LKf3NPvLM2/QTa45CFdSaUbPGs=; b=mrkARCB2HzaDwgoAv4dP4zyO1N
 vZcGc60SlpfG3ICXucgDzD9PodUoFIYQw1ZAhLJF6WsTeHvg0xpIpOP3rB9Rmlvi17eRcpwbEKnSi
 gJaVdpaQFBVMT5rQbVvLmfTvQk8E3l7Do62M9S0l6EJjqOTPfiaN4zBoST10mq0nwtbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EifRWc6pR7OlXs7E2LKf3NPvLM2/QTa45CFdSaUbPGs=; b=E
 V8QpSIDVkfjboY/7nt034SLo3kU8t2D//JLb8kJYxW2W55oaH7wnJh66HOqF/FIvlitJn60dSYXFI
 DX72DgD+cCgc25Uwfzb7JvN3U+0Yfxkou67a/DbuB4NH6NxBI0ZC/r+ojyrdEdWeh/VQD/FiXYQtd
 XzojCtp1mLxWKaTc=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI9nZ-0000rw-Bk for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:10:30 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso7628545e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792264223; x=1792869023; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EifRWc6pR7OlXs7E2LKf3NPvLM2/QTa45CFdSaUbPGs=;
 b=HErD7+Hai6XLk0QbcrbkuVcESmTaIYxePZCVnXfhiPyABfYS8+LY8yyk0OAjKuwkbT
 oCkV5ssDeLk1vv6zdkdLTck9943Zz+JvAy+QkQcd+RC4CrDPzQhMTeJSqZM8PTk1FmAo
 JqVM3OtPGd4MLXQ24nHmFG421C/QOgJXBeGO5FRxuN/fu+wIZmmtC7ZxsNZbEir0jwvv
 XPmXS2++Bpqmi6jxKIYiXlM4inLcqiphNAr/6/wzL3jP7cnSkjeAx6h9eRcvZskoa94a
 mSVEM6jw7r2m2Kvm0U4ABk96n/p3SVn/iwWAdnpUKMOs9NHSDpmUSd7RCDUaYro3bOqv
 67hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792264223; x=1792869023;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EifRWc6pR7OlXs7E2LKf3NPvLM2/QTa45CFdSaUbPGs=;
 b=zujsV2fjhON50HiqbN4CEqBnycNZk6E79jIdj/a06sD1hMqQ0a1wdHbMbbdztmJIUK
 gWMijQrLJF1MU06oFV4TDAZpQ6Aak6zT9WE39/uZRhLWnmuaoDS1gr2sQ9IUIl1NGhKU
 3P8Gv5jGTUiCG9A68vI0S6Df2qdA4iexhZhrvYgJhZ2m5+Sj0wohL8WMlnBu42YAwmr9
 UBznANlKOzg2NcLPh0CIM5nCaZAzpjQvoG05GAlYMW9IwXwII4FfYH1BHTsqLUclbhKl
 mq02yj2TS573elEKW9s8ZezpgDPfowzUehwB8nMNsVH+9+fJL5Lp3frX2K69hv3im/iC
 FsjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjOtgijMMg8nyAbtxWaWhBGMSSFBXHLjVgfV4vUodA+UoSkTokIMs1LHH1QDcOGz2vO1wxCszkl4xltZaR@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIjFvRqoqRmnHWM7B6KYQv9fe6YIdukpPQUcxrOu81qpkAiuYUB
 b0OWBrpfJIAJboVaJZf5aE3ygeiU2VBMvohgbnq89vKdnDNL/Ec1DYhMZ0pCV5yAuvMjarYOl1x
 mIFz29JWxcGTrgU7HvRN2dTDhLZjfK7bCkDcxVJ/nb2ULl5qbp03jkHs1QR1xn+qPsRs3
X-Gm-Gg: AYBFou29vWRNY8vMn0ivUQrSRZ7pYF8w3Bl6g5fpGmlmnL1X3lpbgLCoLXsB/wR3kCO
 YOjo4yKMMO5SMNEZxguMaClw/RGxJpMvZVstrb5Rz7i71xAeZgJZFN1zsAQC3rvGYwpTwbhRHQk
 1ts5tAG6rj9ueP09YBSflZ1tJ4toWWDCSPAZ63Ss9JLiU88h33IaGO9mGViT3nkyBU2QasZMh2v
 FS/ECSMT1Z1z4u79afvIKMHmNlfzKI7Aqgrxq68yl9uiJ/6mJYzpmZ5mz96RnWwGh9aIo/zyT/P
 jJrQXhI4qUhzCRlY0qtXbRy1dfOuLvB4fuk32eIb0snfzDL691JF4/ti3UjOZ6dn6pHY0t19Nh0
 8uNhmMyIwymUnJ9yXvEnfCpLC/t9Bifo9pSoRGZjmQ0v2/Mv5q8ZyteVF0ahTsrVb+gkgUV+neV
 4YUDMWwqdh3Q1rreqSU00mIQFg+UkvfTb+2YYga6H658JZahlWtxdXJVEBQRAq3RZF/ZdiP3aSW
 440K0AVlkarkJvHwBug3ok1TWuax2t4vBYdWbb701enc1PyYf5RKVfYGoFnhyJCl+moZOpjg7kg
 NCBysEsufrDH3mILN+VxX3SI1Faq4tMC2jJCkfjCzARaT4HEwsN5mOp372Br
X-Received: by 2002:a05:600c:a46:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a1d7603dd1mr74776235e9.21.1792264222679; 
 Sat, 17 Oct 2026 12:10:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf983b88sm141827405e9.7.2026.10.17.12.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:10:21 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:10:19 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
X-Gerrit-Change-Number: 2007
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2007?usp=email>
X-Gerrit-Commit: 553c977228962fae2adc092785bcbfef4d9e8438
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:10:19 +0000
In-Reply-To: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
References: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhZTcwYTAzYzJiY2M1MDJmNjIxMzNhYmNiZmQxYzkyNTI4ZTY1ZDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <229d57b67cb16a8a245f3daf421b51c41071f516-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI9nZ-0000rw-Bk
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_mbedtls:
 Avoid conversion warning in x509_get_fingerprint
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
Content-Type: multipart/mixed; boundary="===============6320888464395650597=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6320888464395650597==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7pfskeIDoxo="; charset=UTF-8

--7pfskeIDoxo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail )

Change=
 subject: ssl_verify_mbedtls: Avoid conversion warning in x509_get_fingerpr=
int
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2

(1 comment)

Commit Message:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2007/comment/d4b3df19_a459acca?usp=3Demail :
PS1, Line =
10: places, so just use that here was well=2E
Typo: "here as well"=2E



--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae70a03c2bcc502f62133=
abcbfd1c92528e65d69
Gerrit-Change-Number: 2007
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-D=
ate: Sat, 17 Oct 2026 19:10:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Lab=
els: Yes

--7pfskeIDoxo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2007/comment/d4b3df19_a459acca?usp=3Demail">Patch Set #1=
, Line 10:</a> <code style=3D"font-family:monospace,monospace">places, so j=
ust use that here was well=2E</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Typo: &quot;here as well&quot;=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2007?usp=3Demail">change 2007</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Iae70a03c2bcc502f62133abcbf=
d1c92528e65d69 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 20=
07 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 17 Oct 202=
6 19:10:19 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--7pfskeIDoxo=--


--===============6320888464395650597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6320888464395650597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6320888464395650597==--


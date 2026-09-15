Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2953C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQ8qBfTCUKQ8KuItEhYu2SLGLLAKy/4q4r2iPUJ+/iw=; b=mAa+48GJMQNamTMMw0QjemL03I
	r9rk42OyQBBYe7oeop6t6GlXOWZyrPYxPx6UkSxI8vK8F2AyGY+S93U18SzYy1BWyEjBNoKKq2AxR
	QslYqx8WZzoYM76KKtUdwcv8bZfG0fuh+KmnA5iJM2jYPebtSdE9iKcARkvqUMhyS0C4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6O33-0005ll-V2;
	Tue, 15 Sep 2026 07:57:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6O32-0005ld-Kp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:57:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G3aYVVDY8cyzbQEL18E8OG3ic9yAjBU4OgMwumUiSQM=; b=UajVVC5CNjLGIMaSy5uJCnNG4i
 LNzvuAMwPyhsCiC/ZPMCWPj35WCl4vi/CfACtD+66R2/6V+2cpqfS5nDZZbcuIpAqiyFJm3PBd+KK
 bcyO4UX6ULDRloNjnNMiLJG9jFj2HEJdVOLEQz8z/qcSOd/j3kx6j1/FAQZxBaA9eVFU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G3aYVVDY8cyzbQEL18E8OG3ic9yAjBU4OgMwumUiSQM=; b=l
 eUBH+7Nx3Hi7dE4kwDB3SP6FeTUprLuQgceJPcPkezVfR7aoJr463CFwHEKv4v8amTe/nKgdfuxgw
 BUPQ9/aptPNvMIehtA3+3Tulzya2i5wEDIbleu5KNfF/2hxGgc4G6zFG3e9x3b32T2ePedgLB7XIJ
 raOsfMHLotKDn5hw=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6O32-00065N-On for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:57:49 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so48185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789459062; x=1790063862; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G3aYVVDY8cyzbQEL18E8OG3ic9yAjBU4OgMwumUiSQM=;
 b=D0bk92dyOWJRiBVtpdYy5gUmFTgYqZ/20dMFr3orBnaHeRZTktYG/qocSWuRU8xTC1
 wxHcHayTxy9GUHIuSkIl1e7ab1mDT6/6H3rOdkf1t2P8SCpoas4L3VjoDgjiGe1rrDO/
 T/g5XlCwqiD9L9XMKMJS5pbiEZXqw8RfC2vfofMnPkDLy1s52fyM6sneKu/Yo4Odnh7d
 KaOOC2JJfEPZ/zFyshJLMqGAg2LTLU6fIyZZXHHrNTzIq1GVJf8Z7IP9QIK3i2gbSuwA
 ycwIsteGcdPtIzDPlHUPTXZxFfesVlTfflVrpN7q5sHqngtwO4xfLXS83MlBkEFQEfGV
 Nbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459062; x=1790063862;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G3aYVVDY8cyzbQEL18E8OG3ic9yAjBU4OgMwumUiSQM=;
 b=rKbp95Pn/mN7nc0LwiR3+znZYJ5j7YZrZi663uv+a3Dx8km15P78+nTDMV8+DZ7PvG
 8NihN8K6YpZjIz0k13i/a6EV1Qka/KIInfB4tKynkgNfyR353hRLDEAGW30TE37meJIt
 gijkCGEMatQrPtxZvEMcy8MM/8Jkkp+h6W0yvWmypFff95G5OT57W3CD+smEaPH4SF2X
 kT96dziJB7AgmMgg3pzCaxqH+XhMwJhfLI3Yp9FHh8XkMrMYs2ICKkeAY0AU+pVhsKaU
 2d//qD3kNivEuopXt1H8zLDjUcJua0Vdr29cKGKDgfCgHzJJN+vPQEbdQiH3PLfGlz5F
 u1TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh25YAMQYtObPrYH+neQbsqukda0yuL7SsnqxwTHA1a3CX2qiS6Bmq8l+U2Z2aIUCAx6OJRpFQAqT9VE68@lists.sourceforge.net
X-Gm-Message-State: AFuF++myuo6k6O0ZCQa2KruMH06aqiQYqTRdkMA3nB61eDob2iYF6wuR
 wrUIHabaOxfRIN5l6DlD7RaBsVW49QbXVIUucO8hY+0lH7JtJ6WRFFfkHy1UN+cgToqIp3LDwUV
 b0MUaEemfroqsSiavQ7V+YQdCV6lb2c5HdNJ1JWG2FZi0i7ak95I29fkHObeTKxqZAUML
X-Gm-Gg: AYBFou3fzEC9kcTFh+6m/GPVE1ixUcs3QVQXBc9lhC1oO+yki5c/Lod/NB/hD+0Cwzi
 X6BMIap3bLqnLtF2vgwmCAzs0dan34FoKnZJnNVewi7N93+Hv+myuyYOBox/1kmfIqwIPUoXG/H
 QVZPyhevz6i8rhu+zm9Ww25QIQKJZcVngBND7J6X2ATpGebzpSsJjDoRgqJtOhavsx3NxQ0VL46
 W2BoZup5I/jtUExnRalzciySsSe2UWQO2kKsEX+h3HK3X65U6JfLa7AgDVit3WySfr6WZo0xmBz
 3+3l8f+2FfQo6yvDXH1LPAG/fNxSs7E5OlUowhqb7FmairbjsYRQrCn33Jkcdy1V7JVlEetyQPT
 1yIvS97vZSZs8euASC7eeydNBJXZg9cTAF9xkpZmX43ufMzAmhMU2gmAHktVC6l59BY74XYxtja
 gcxZ3gYEuTiDU4E/zEDIJ/HdoTvf1bac3gsZSFmJ2KbTy4G3U4bJOcU4PtPWhRpXwEdFqJfXgKn
 V3mPAF2sHDucsSyXnjCnHGhkmtADccDM04lVh6UQ62qKD7UijF2i2XTmAWLyMucqEdDdQwY/Siq
 N6aDtWrWPBT473kIHtQkEV7+4Ia7lOP8sUe6NJalnd3g+mcqwWxQfRX5Tb/0iA==
X-Received: by 2002:a05:600c:4455:b0:49c:fc6e:a3d5 with SMTP id
 5b1f17b1804b1-49e8228f4aamr613825e9.20.1789459062124; 
 Tue, 15 Sep 2026 00:57:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef6bc50sm44848425e9.3.2026.09.15.00.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:57:41 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 07:57:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5e038f577838cd050300fc39be6d2c3f67a51f2c
X-Gerrit-Change-Number: 1917
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1917?usp=email>
X-Gerrit-Commit: 6d7c7fd7037d9ed1221b0efdb52acfd9167fa3e6
In-Reply-To: <gerrit.1789456688000.I5e038f577838cd050300fc39be6d2c3f67a51f2c@gerrit.openvpn.net>
References: <gerrit.1789456688000.I5e038f577838cd050300fc39be6d2c3f67a51f2c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLkk1ZTAzOGY1Nzc4MzhjZDA1MDMwMGZjMzliZTZkMmMzZjY3YTUxZjJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <050be740e6e6f07a06cece87c255ae454cbdb73a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6O32-00065N-On
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tests: check that we
 only append a WKc we actually have
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
Content-Type: multipart/mixed; boundary="===============4471340777171322568=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4471340777171322568==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kalBKwJXcA4="; charset=UTF-8

--kalBKwJXcA4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

stipa has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1917?usp=3Demail )

Change subject: tests: check that we only append a =
WKc we actually have
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Abandoned
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1917?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e=
038f577838cd050300fc39be6d2c3f67a51f2c
Gerrit-Change-Number: 1917
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--kalBKwJXcA4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>stipa <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1917?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1917?usp=3Demail">change 1917</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1917?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I5e038f577838cd050300fc39be=
6d2c3f67a51f2c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 19=
17 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--kalBKwJXcA4=--


--===============4471340777171322568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4471340777171322568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4471340777171322568==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4CDC44507
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=its5P5r+nsoWE8IdDSKwwY+9pupcdXbDCsMAJZ46quE=; b=IjFqmjWlIE/Tvjzd9NMRoZ5AbQ
	K5XHkkc241yKeYyEcdvUIrV6YkzC0Kk83w4DoIQyqd4hNdGv7zd87xNdDPdsHibt8P6k+QGMjpg1w
	GME+U/i6qZrWFp+NT1n59YzZB81Au0lPwlW84ZVXp3rvTSox8r0uC/wRmr2qta8khS2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkeuw-00030a-A6;
	Fri, 17 Jul 2026 09:31:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkeuv-00030S-M3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 09:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RysPR+/WAvH8W/Bvm/l5bFrKNNFvwZH9nFoCwkk+6Xw=; b=gJ8OZR9nE1p4CNV07ylzlIpwoR
 E6MkpQptul9uGBEGQWsdqyXSQA9mD6FITPTeUVq0KCcZUFRfuP1NLmYIxnliIa+nj4R1NZLy/BJl8
 44K4nSC4Mrgxa5QFkO6DE329z5n9g/kSDRK9CZbzxSInwYsiG2tBDXOdrm2y080VaqxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RysPR+/WAvH8W/Bvm/l5bFrKNNFvwZH9nFoCwkk+6Xw=; b=Y
 hRu0Ey5b2cnfWol/eep5M9JIYjlh7vVXHbo3Zilr3Qo/Q+peEMbD5pkzdxxPU48TLlSXMvbemVVG/
 BTIuVxmtgizRD7Y2TX9RyC3BkI8yktuphD6J4yhUxiAlg5cQSIwQMqFkuGL/oHZaw/V+uGnFl1i8r
 qHRBmyd3u92Thtw4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkeus-00008B-J0 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 09:31:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so56974345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784280688; x=1784885488; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RysPR+/WAvH8W/Bvm/l5bFrKNNFvwZH9nFoCwkk+6Xw=;
 b=QB132RU1P1rbcCbnMR714X2IPkD2WRI6GAJX0iCzaf3esUFo1Tx/vmPFPAXAn8Jttj
 5Q/+qLaBQ44bDYBTMK5QLtwuiKIOx3p+jeNH9KhiogyIxBAxjZspe+htKYgS6BR7Wxa2
 97o9KCkNEmtZ1eirFHaLTCur3av68g/zP4ulHAldia6QB7HDAgeLWHs+uJ1yRzYG8Cj7
 ZdsarIQCqT55JSl452KuitiTv8eMTHpgA0+Z3XUWvxERcBq57b7nbwfj7wvcv4NcSAQy
 fPZYdG39dH9GU6pC0BRBl5Rc7zh5BHl1Ck8iIZ53nDfhbObHdD/3ww3LDvBHV/UEGtoQ
 1JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784280688; x=1784885488;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RysPR+/WAvH8W/Bvm/l5bFrKNNFvwZH9nFoCwkk+6Xw=;
 b=cTHnNV26ZhzCtp4pkZMaPVyX6DWOth5T0JKY0aOd2bwwJXTxu1EV71C7Yo6xC6OnPb
 3qw+Cifn3Vo660zj6D+QtQFLHoA3MHdtiS95n5lqSH7dJM2xftaJLUKMZb440+JTk+iV
 KXVZlAXpWsTz2VqAdU19z91KQfilC7UgEIUtzMULzZ6TN29dJLUp9mR17UaurfHO64Ps
 d4MAut+TTPledXDX0UNenfHXc6x2rYdz9ntAMK6jPTKdfqUtpxk00FciADUltKoOcQFq
 KaVWBQRjN19qV/UhFQ+Jschh/gdyzvnJvMud/leotnAYZFFZJxQZJol1yLMiG0WM9O15
 8u3g==
X-Gm-Message-State: AOJu0Yw0w+tpY+66GkctXpvhhn6AedN4Sfvnq9v+LPuj+ZApXqTDIUNA
 eczbsGQbdn/ioZCtrARyWJBdK3cIF/kBfudPaRYD4TW35jQhrA81GF3nLcZy0NBxKF28ms/aeC6
 7/FPM7MT/dYiaqM2UQmTwZ5gFjpvopUalCLr3f/8lXAHQmtatnUDzcLZfasRfiD+x6gFu
X-Gm-Gg: AfdE7ckox7DCJvzCveT4VVDE+3MxNohEGe/3vGSSp+fexn4wPA74WPS5kd5t2t4tGfE
 UiQLHamvV1YoeeJV4/mX/LOhIGZ5+b+LY8Qp/71QN6IeJg5GB7MrKy1atfZxgG46716+yPmZrgZ
 ZRyfUXA7/JTngARoaALUetBTGbvy/gPsVmY6ZuPId3QL2jRiLcUymVWcaw8qHccESGT6dDb3oQW
 gBSfHWyvsRf7jWYjWqBLSFkm2Ut9FredxplK1/amS7TrXjJKjmLnlOwMYU4FDFuL9zoOLnm11lP
 Xc+rpWv0Vcr11O6ajtDB6raDY7686Jxrng9XA24/9Duh8NwCuYaxzGXvnwNJEZoKAWl3773NihP
 ToFXfIcophB2ukerTl4aK5khD/gpRfvjsEu/Frcfaoeb2BKevHsNK2O2rKhAAqSmruCTHlypEjs
 A+q4z9f0XYeYpy3R9Itdkh/YPdZP28Oo/nuydS5vzrDBVqCKkge7S+UlbOfqHBMzKj/Ary2CqCT
 fMWWkKtsj6jpySZj8JqfEdmxTRqFBf1QcrHDh0JuGo0tlDaPgaw2OHe04jH2gI6DHNfjkMbykKs
 ZzQ=
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4954a3ed4bamr20368015e9.13.1784280687707; 
 Fri, 17 Jul 2026 02:31:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b87c6sm52188865e9.7.2026.07.17.02.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:31:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 09:31:25 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: ccdcee277ad5c6d427ef187ab1ce1a7b2f19ed33
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 09:31:25 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cdf4733d1526b77b632e8cc9788ccbacba46d6c4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkeus-00008B-J0
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
Content-Type: multipart/mixed; boundary="===============4300744447577331451=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4300744447577331451==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xDbeRN/sxis="; charset=UTF-8

--xDbeRN/sxis=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Ge=
rrit-Change-Number: 1723
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fr=
i, 17 Jul 2026 09:31:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--xDbeRN/sxis=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c=
3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
Fri, 17 Jul 2026 09:31:25 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--xDbeRN/sxis=--


--===============4300744447577331451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4300744447577331451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4300744447577331451==--


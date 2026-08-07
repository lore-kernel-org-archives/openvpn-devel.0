Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D1C5AC7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8fWxK+ubG3DWQDw0ZmTEaSqBdj1ILaE5cI+IpWnmgk=; b=ZDlo8ppdrp03Xw21j4zqdyC8NG
	v8dB3r9b22qEDXZp9HxckP6Lz7c3pHGp8NWVZbLn/XKhSLLV0h1ErLXPwMITs6w5TFhy/I4bNLJsT
	8ZCY2ZCUTXh8kfxd7zmaW/ckf8NKiwS/xsC3oES5I5UeZMqHF1rIGjXNkiYozhMPDFVc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsHjA-0005Cn-RE;
	Fri, 07 Aug 2026 10:23:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsHj9-0005CY-Dg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 10:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=datpqB4nljf69++W9Va63QMECJyzjUOi5bMWXatFlxU=; b=fUkQ+BlE9UodAOwfbUsY1C9LHF
 v/YIY32YDhC2Dsxox1nqlgFAWDqsyxtSdxA82AF0mMsppQ8Mdhsmz/G2a4XammqMiwOxjFN/0sivI
 WRqcNfjA8et9Y67ByeG7tuRqvxCTQ1pczqZI1gSCZkdS2NyBAGXgHrsKbk633wtcCttc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=datpqB4nljf69++W9Va63QMECJyzjUOi5bMWXatFlxU=; b=Y
 sJg/Vtck7/ihSh+b5GhBtBMSVvSZDn4cntOIm0TFM24t0k/XC5GkZ6GzjfZUgdC3PCK4Gmrk52efq
 4mCQyamyPv97YMuMOsZP2PUIO8NJuaDDRLdWdpvPRQfJGT9GufJ3T13AFKg8Y67uc4R3Lt+brYrVV
 56ANhX9l1R0Gwl/E=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsHj8-0003ap-13 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 10:23:00 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4807df69172so147807f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786098171; x=1786702971; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=datpqB4nljf69++W9Va63QMECJyzjUOi5bMWXatFlxU=;
 b=BT+xniPtUJY/0LHZ0p4MwQn36HyF8a3ncIDChkVHOf+ZrCSlXd/nwlrt9J9C/3up/w
 /M5Sh0/i4sAUPxpM69vTBGvXB1y8aSvo3nnXgr/dg6KQfRagmd1gstJUdiVIFGHHZuew
 sSTsHKdWyK0FrgRadXKWWDx9VIC9pEhL7Y+dqBseczwnZfOnbsSWyeou7+2Ot82UxiTm
 ZkAhl7l5CwzXwTsLUnJUiMvEJGVb0ysaf9aEJfHkxU9SsAgH7LzKDIEXow+/ijcP1lWH
 DzFG0j1/Rrsipp3rMe/+L8ofr1YVkN2UyJbnrzBzwRbl+HBFshyOvrd2NLjSwMVBGjpE
 k4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786098171; x=1786702971;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=datpqB4nljf69++W9Va63QMECJyzjUOi5bMWXatFlxU=;
 b=HUlbKeT4ERx1z0hqzCSdNdx0TDIYuTmaIUz/fJQd1Qi0IuDQjl4Sn4ktCxrV8jHlR1
 JpMj85wPPAw8wElI+ngl4anzE1QwXrlUK1VbTCvOUihHUeygNaF+FtFDgDSS5+IJNL6T
 kfGeqT2DCwNkQxWsbkhxeETKHWN26NFCLg0ldiIdgYNvOoakgI8vRPxM6un0Zm1019Tg
 02n+VTUGkej3QQYo2W/2ACJRCDzVF32u4mHEuqteJDiU4vrAyG+q79zSuo60t9HIm9Ul
 k7f74X5hl+Uy2dji1DPGj87OWc88VWh/sxMHDSN0Dz3VeV/TgRqLSJzBKJDbIZnpHTLb
 +PIA==
X-Gm-Message-State: AOJu0YwllZ7LIcOueIe4EEaXyZsWEWuDwHoHj+wIybyawzEZjxRroRyZ
 KytKZVF0SzilwcCfivGUZ9Sr8xe8t/iC+0OP/7P1XTsqR1VP1giON3AyFkawCcFrkPv0DR459Uf
 dUGDWpZ2Sc4MRj09SZEJoDDHgpDPBC4c9pxfQo3PkEusitCuukPlcYp+ErJy93BHj6t8WYC4hzI
 TeWpf2bw==
X-Gm-Gg: AR+sD12KPT1g+MUOa71FJ+qcOTD2lnFddI91mTkYSRnu9WM3qbGTuSiUXnNgZf9OTXv
 PCiOGjAT5Lv5FdKrDLvz+nCPKgOv1GtWwKYPFJuYVtJGCJkwxygAZopDr/eBpt6PGSdSl4SHgp8
 +kLcKe24pYKCXI/EnWo7Cl9usuI14okKFWU8YAsU6lD8OujwTmoypaLxbRy/Jjdp9seQCwrWgRJ
 vbdZ6wiG63X7jwq2InmqFV3qgiQWKqjF/dXdheNPMWdnPSw1o80b0kvmgtawADfVesbe3vPOZEw
 IYaSGwFDRWRrBTfxR1OCbErSKEKN289gSLMxN/Uxdu6utPcqrUrMG4z7w/MEqNeIKe9PPLmvUnw
 QefP+MMLkGsLKatQWH9ajeiL/dyzdM4z0Y+i4WwSOpVW7vHyvaiwqwSjE3k9/E088wRCHjafb2w
 cAMt35rRw2mTgPsmN6Z2tycYzwMRpHER/ZE6qJMpB7MK6Bi7W3nU5hTU1ZN4i13t2wKqCEOdz4D
 WKFlS0Aux52NpGHqA5glAs6hdNlPzlM6ZRBuHuTpmtyF6yoF7eN1VC74DjdHW2ijA00HDa0piQY
 i1Fbf98ov/gZL8YuQkOe1NbOEVrLUlJYXQuep6vfReGpMDdxqc4=
X-Received: by 2002:a05:600c:42d4:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49959fddc5emr62077635e9.1.1786098171211; 
 Fri, 07 Aug 2026 03:22:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995d85b96csm17496385e9.2.2026.08.07.03.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:22:50 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 10:22:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: c8254e8bdff023b7b242b0ca3036807c6b3eace1
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 10:22:46 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d990ec37e9c3dc7e182de854282cc568a50d9025-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsHj8-0003ap-13
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
Content-Type: multipart/mixed; boundary="===============5913097203172215411=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5913097203172215411==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lEKorosS53Y="; charset=UTF-8

--lEKorosS53Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Gerrit-Chan=
ge-Number: 1827
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 07 Aug=
 2026 10:22:46 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--lEKorosS53Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">change 1827</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb499=
81bc23eabf04fe8e06d6fc3 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
Fri, 07 Aug 2026 10:22:46 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--lEKorosS53Y=--


--===============5913097203172215411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5913097203172215411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5913097203172215411==--


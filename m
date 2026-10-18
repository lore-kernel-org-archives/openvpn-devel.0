Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D9CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pfAQfOUFhVZwo/9I6fWy4sju1UF1TSThRpUN5IibWx8=; b=G6CgIQGBRPT9nz5y3gUYEX9+Pw
	cMtAKWGxZCtH5UvoTZHWBj7y0ejy4jWQl51MbfMRpizn+xbX+8C05+mRc7Qhe7pSp3cq7ShHP8dG7
	oaMqQDPgxeRQf/prtxihKpwLOxAWINvuNmkcy8LefBho5jr1Drjo3ikiYQ8qMegm3p40=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xINVI-0003xj-Hv;
	Sun, 18 Oct 2026 09:48:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xINVB-0003wh-LN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nTR/IpDBjFTD7wML5ulgUIgTjcPFJi04y709YSVlAOE=; b=URRmcO1VeTZHjjzpixYQQwVStC
 s2Rd2gwzRyasQNrJi6nrP2RWhkt5kVek4uhd3LXJ0rKBmmTY3DVkAsefDJ7VyYzGV5lmoRMcyZaBW
 qixq7yhQWL2Z5MmCjY6sDazDye7akH6Gw6OL3TuCfDlrazdN1f1Ar5UpTAuwx8B8qQe8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nTR/IpDBjFTD7wML5ulgUIgTjcPFJi04y709YSVlAOE=; b=R
 s4zcXd2aZKFsSXX1xs3AHz+0OZMu72UjAcw59MTeFeHeY6THGBzcn6kKjqS94D0fbnYLedKbyPcgk
 NXO1WpxJcM+ZwYw5l/3XrhavolydET5Iv5/5Vw1c8pNhBQadviG0auqAX9emTkIDFoXAtA9oNf+q6
 jLCovt96qq2Pne2M=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xINV8-0002gF-7K for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:48:23 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so7956865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792316896; x=1792921696; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nTR/IpDBjFTD7wML5ulgUIgTjcPFJi04y709YSVlAOE=;
 b=THogtO1FHXLxuh4vYequgfclzOT+QDJRpiTD1E8ACjBqnzk7iry+keihqJDC/NDOsx
 n1PVn3gLdF+JzxHE7ZSGgxSslHfCc7qv7NJjrQ+VoWr5fb0T352ZBvAcuBguqBBAYRb5
 HNRWRPJS5dvmj+5e+t0mRROMhpssCG61Ek/QtBhifYyaEePd+eHthtzVE8t3Q4xbFxOK
 UqvzS61dL0Zmi7/jL6rk1VmLya+pi2GUfGb3/2KrOImSEQtYtGnYId27dbxY4WKVojrt
 wuRulNCx05nHvOv4VygjEa3bFPwPk+g2BhHmaK2nEhqWrEcBuhIJiMmVUg4Qj/B546Ox
 dmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792316896; x=1792921696;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nTR/IpDBjFTD7wML5ulgUIgTjcPFJi04y709YSVlAOE=;
 b=mYXxPCmz8RFCvvVYSlVz5EPIfpgCCSzjRgCo4Fla0Hq2IYL0/vuFzBr1TgCxatc5RP
 4SEVHn4Xcn7Oa1NV7/wJHTOZGiNVC40knFpSY5V/c5tUpYmhCHgvszn74V/O9+dXmHZu
 PNBA5QtiGVSO0VQOz8mFQ6kwwZA+jS4NXVSSEGazh89TFQpys7LsNC2q+oidBr7dYsCN
 JcEyyIj++xXSfH6CzNq7Sffxvyn8mMxl3qiQIrrCOG667atV+yBXficc8TSU/WsF24Uw
 xP3hGJPSca696MmG2oKUXskf+nRduYxM62SlHBFI34Q3T89KUQGsl/n44X70DnV9v/gX
 ARJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi0gJWiOV3aLgb4fT8mbssbkfzavdS+QCXThQy12Bxr15aVwUHNPm408hK/yHysjvCEol9mjdlnlwh9X/l@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKZTV42/uL/a4pjPoNbp/h9NGyyUR63h07YFP7HQwWQdw31UbS9
 cUdJqEnMSGoEV/xZMmrzK9FZheLMZj/XNobIu5ixUdWR/8rwtiH7YL4O/z7oZhfWzSwPt+rtTQD
 ct7rYHXTDP+DliMopWo8A2eseUWk33eN3yR88zYlPCqT+l654mtI7Zj9VIjFKRD8PxsNnxUHrwu
 XMQxizcQ==
X-Gm-Gg: AYBFou0vxVxmby/xIX62R1wktcchtZVzhNGLfPkHdASdoHILPbGFKAEdLeghHOfjjFC
 BiK2f6ZmGFontAPYLedBtcoflCTNOwJXsJOhdKxwv5en3ij8pQkAr9FFk4FT+xAgTSpaAQVPORC
 0U+6Yiu2POIGuJIq3Mj6bbMRIY6BnmSxbqKlqtU0EcadQ9rHfFjunPVSIEqR8rwrtefCKfCkwh8
 +VQvoYL0YpZ3ywhJrzwWiBBTFXf5/9jy1NDAEyx0EfUcvPSyk508D4HXvrfX/eehBY2TQMFX7c5
 e7bXsjHRVQFpfjWw7MaPq62g6cn+z2n5Z2dEJL0XOCl9TJLxFs/D7KgkKNvRT2bCi3YDo0cCLQh
 97MhDzP04mvr9jB1Nh/hX2fxD7ZVB1EmoDTfbAYmy+j7nLLyKocWZsC0w4r2KLOOtgPF650Il96
 J0x8CYIjuklU4ZQRtNudUW5KZGuvHdTqP8WMmQkJSzsSmjFLUE6wRIewi5f1cTjkjnBA6AF+IBB
 kKBwUQ0cFeEXvXUYdXNv5sUO1ag8ofNHaykywLmtRrFMoljsPxaVT63HQjN/TpBnTCKMPvgRelF
 hJ9SPAgH0dod4evm0iCHf/eZMfHV/qRSx1OLTBeQZct6I3sHG5C+61tQjhIh
X-Received: by 2002:a05:600c:4692:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4a1d97ed786mr75522285e9.16.1792316895504; 
 Sun, 18 Oct 2026 02:48:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm16218993f8f.2.2026.10.18.02.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:48:15 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 09:48:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 4f52ddc639360c746103d4a704f0aeb81044f095
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 09:48:13 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <28686f0bbfe9b32e2e3aea36479a913f2951e9d1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xINV8-0002gF-7K
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7732183968604251251=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7732183968604251251==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sIM3cYaXfWM="; charset=UTF-8

--sIM3cYaXfWM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subj=
ect: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: Code-Revie=
w-1

(1 comment)

Patchset:

PS12: 
Doesn't build on Windows



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436aa782f7e24bfff6=
65a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 12
Gerrit-Owner: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Sun, 18 Oct 2026 09:48:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes

--sIM3cYaXfWM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 12:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1852?tab=3Dcomments&amp;usp=3Demail">Patch Set #12:</a> </p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Doesn&=
#39;t build on Windows</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I307=
e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Sun, 18 Oct 2026 09:48:13 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: Yes </div>

</body></html>
--sIM3cYaXfWM=--


--===============7732183968604251251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7732183968604251251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7732183968604251251==--


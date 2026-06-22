Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C4BCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pjyrY5Jyq47n2obb4HCVM9Pk+MhTaVp7dScQ2muDb0=; b=FPphoMpsvwv2OItpNB4Ko6+cV7
	mIrsErHy4mQBoMUPFdKUwjdJ0iAz/Gtn55P4bR7kQRp/hno7cLwQgaWQeS+oXhzGBobe7pA5dkgcS
	IBGZEJTQQuwitcFDEChC7VxeFJAt8lcvh7nWjgbyinfbmwZuV87AyJheEs6NlUWLPfz8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbeh7-0001kn-1I;
	Mon, 22 Jun 2026 13:28:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbeh5-0001ke-Rz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:28:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A7lHy30si080sQIDlV29Q4brZR0lhpfl/dzqwIW9og4=; b=fH2LLorDQfIp8WwA/hsFOjS2uU
 qEVFPx3MEU6Uf/W/w3v1h+9qoaHEotVD9/WKhgEOZJ4fiw5BFn1a/X1Prb902WEiQ8jmDEvqAQNX5
 h0u5HN3yD8jmxsHx7zOm2m9iYbniAfjL3TLWgRY4ymtYYDIDp29Wpw7KhfitQGe/VHrM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A7lHy30si080sQIDlV29Q4brZR0lhpfl/dzqwIW9og4=; b=H
 AaIEvdsus2g4vmwJNxENhbX2w6LjHqw+T2SXbLKeSd/qa5/NDU8iHSm8r0d1WYd5xpyDUiRZKTPk5
 YsePJ+SaTuXFTF9s/3zoMcD+hTw0Y868ZxKebl9IS4zbIBgKCVjWl6AbHYahxs7dmohg8gaNZbm2s
 NKDyPWeyzoTuP3jA=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbeh1-0000pf-0n for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:28:05 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so42162695e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134877; x=1782739677; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A7lHy30si080sQIDlV29Q4brZR0lhpfl/dzqwIW9og4=;
 b=VDMcmIfra5CbTTkBbFJ7+mhcMzxeT32WRc6Pew+1OfPOnQzSm9QHvgHjidQqZ3Vpp8
 QyauU17F3mu3y2xOT4f/A1jmDByn0u3jJJaRKmU0GUgYT9hQBuIctQ7tYOwIWsJVxsVb
 i53uQOS2KxvqHPiksHbH+UtBDt9DMrEDhLaRCFlEQSAx8v9s5Z05F8s2StgqGbQMN1gM
 ScXJzBJcyDXmAzk5Ss7GWoLRk+hMuBcQS00U200DEPvtIe0KvWaWC96aIjnkVYafGXFj
 WzPF2Zi/TdG4VqFb87w3yDfIZq5ZeL16na6cQ8gqsIoY59Cyg/zxEsorEi48sh80UQWn
 X4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134877; x=1782739677;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7lHy30si080sQIDlV29Q4brZR0lhpfl/dzqwIW9og4=;
 b=q3Zu+rFEsAkUzYLEZUl/huKupzHjSkQWYzn+j5hHpIySmtUwbBFCEn02caUn33xxES
 jDpSLECUvRSyiEV8e2RVaOjo8E/XMoegZQrvMXluahPqatE2CI6prq5cCLA5hsuTrOTe
 ZmWDDB2ctnCRcKN8F0WcfGCFFPoH1IkDL5AR2hdUM1pOn8zc+BBrQeRjFrTxTBYOGSFC
 twn8Ppy8wPieg+kLnGsiP41HaUTNQ1Mztn18ij8bwC3UMO0oDJSf93cFQ5IVgYNJydrU
 8irWrVN188W1V5RnKHYtpvXW1yWI8JaGz9s/8Ci4t6iJRX925SZyC8qjOyFWd9BM9uZ/
 lh+g==
X-Gm-Message-State: AOJu0YyoQH6wouDtO+yOx8GmaInATgn4gCLn7kkmJjlA8J+DsNp0xEeC
 ethaqE44crJPHTG0wyZCrhth8xysZsDRL2JBJk52N5hBlnknKvN8Qc31q+OOpST9DRnDSZhs5KY
 My6GQT4YRArS58V8e5uCBluz9DTAUc0760MWng7hwO8wHDtscv82gt9YCjmjbIHnksv585ULPRe
 4vSsgdUw==
X-Gm-Gg: AfdE7cluMkYH+OrEYlCDiWPhO6qrrlNxXicewz3Bed3g8gcqK0jTGVTTPyeXn085HRh
 vuk7rr21nfGXQ+BOsueZrnAKcSoHotlA5PIuazNfjhL1jAwY6eVAnDq/60qtIrXyl8Fexwj4RGj
 N9nuK95wE4wghLfqNiww24maa+BO1gaDsfPbodM7VNNeIr1sR7dpCgbzQhNLIPnUFyniCpEUtBf
 je3QoxPNvsVqm/FkQuphZa+su2Adoyvm4cUoFgjtWF47Mgm83RnsM/esbqVOKVUNdQlBSBH0Z1M
 85hvjh1cmUccdsMBxmZ7MXJVbSPyFKn1QBb3x2pTQSDgjzm12PiF+Fj9V1UZHOk9dpkUUD2jMhZ
 w2+a5dtAovrfhRj42J86FN5g7zGGodumKFg5UkI5FtOU6QdPI+tfu6pjcyzSiMfUaMdC926kGfB
 B+5PDN0YHNyVPEd76kwscoSl33zsAls2zHFXCsqTggjd7+urD5HiwXvulwjb3oE2UQ/urkSRzHn
 p6md3wGdXcmejsHbzSFYZmxaoLVxXBdjaeV72R+kXfdyy3aFDFy+rdzS9bWFLcXAwuTA2YJTbrv
 qoY=
X-Received: by 2002:a05:600c:5493:b0:492:1ea2:6258 with SMTP id
 5b1f17b1804b1-49240e7b049mr222973665e9.33.1782134875692; 
 Mon, 22 Jun 2026 06:27:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5413sm27339410f8f.11.2026.06.22.06.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:27:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:27:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: d6d0507d61a11c6ef19e0b96697cd8581e59a63f
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 13:27:54 +0000
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0b47a69e4f3a8c0fe09f9fb42a49ffb6cf133f8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbeh1-0000pf-0n
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
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
Content-Type: multipart/mixed; boundary="===============5786989546040561504=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5786989546040561504==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IR8k/bb/iy8="; charset=UTF-8

--IR8k/bb/iy8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1604?usp=3Demail )

Change subject: Fix building wolfSSL with CMa=
ke
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2: Code-Review-1


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1604?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3=
55760e43c3e2da0dda0cdec6e4253c028cefe38
Gerrit-Change-Number: 1604
Gerrit-P=
atchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 22 Jun 2026 13:27:54 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--IR8k/bb/iy8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1604?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail">change 1604</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I355760e43c3e2da0d=
da0cdec6e4253c028cefe38 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1604 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
Mon, 22 Jun 2026 13:27:54 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--IR8k/bb/iy8=--


--===============5786989546040561504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5786989546040561504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5786989546040561504==--


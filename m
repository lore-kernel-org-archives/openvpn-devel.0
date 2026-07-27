Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03422C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7T1JLJ6XjaZaDWmsQeQ7xv+w3W6Wq84HnmvPvG7A7Ok=; b=ONghSGHYHdw/vVGdpLkdFQJVbl
	ldYW67E+kBxcPrl43NsJIOgmtQB5SCzZcyXmOYFIDa2OEdDm1L+we4+fPXTEMtkBNzCCSMgzdCXAz
	LAuX4QI4i/uNH6HbzmpzFDfepzM/PJ7oMWZxEeY7d1N09XAW1+dvGIeU8NbGkdjr0Zv8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woNrc-0000tP-Ie;
	Mon, 27 Jul 2026 16:07:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woNrH-0000t0-HH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 16:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oAUsJ32o9tcNLRRYV/BdlxSJZSrkJ69awBDQdICRnGE=; b=UZFMoNQCVUmp+0JLG/adKfAgWM
 sUOAR2kRmNNToKyg7hIo6KXVoRc8HLfqjxWZjCaY7/h7QvuoXcm8PtVrI1TOjNWDFW8p7Wmr36Jjk
 p3LYLZ3Dd79mwjyUP32JEbAsVemrGSUifjM6vz4Gtq/6+7NLCVFd2XE3Tt8tl9rz7aNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oAUsJ32o9tcNLRRYV/BdlxSJZSrkJ69awBDQdICRnGE=; b=O
 VPbZjrebcCIkxqzWdEvfDG5Bb90RvNZHp0+ygfKCx8L8h7zYF6NWkB/kJKGEtlmNwCBKggo/Lcdfi
 POOV64Og0+Cl63z97608JtQSnKt84/EWSTeuJYLtn9Hasy2ccMruCVlJwWPy+N/wnUeu93qS+1l/0
 m3tpsLWirY0Lmocs=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woNr4-00030m-AX for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 16:07:05 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956242332dso25553785e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785168416; x=1785773216; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oAUsJ32o9tcNLRRYV/BdlxSJZSrkJ69awBDQdICRnGE=;
 b=SK2rbnOI4j4SBLKx6G0tmiXzI6XTs+xVyjBdURTXKGFFCllu97j/vLKUqiPTkqXaLs
 29kEkRadt4G8cB5A4B5cHpSRYSoVCnCa0TtoIU7Fp0z41SSYl0IO/wUUS0kP29fjJtMd
 95WLoRu3zB7TrwUJ2vF+79YlmmF6LbZQgTW6/IuAMTiaIjLM8OPTPLOazebHlc1b9d74
 8DUdsbTFAsgE+QOm/TpyapHLls262Q6/VjAjPiAtxCUxEZGU/ZvS+7JHxit+3j/ngjiO
 QqQCI+SsWMWjmvLU+VzqCoU1GF7N4KVvUKyTPDNrp3/sS8IL4jc3tVKJCcfUV7eCcm3x
 7HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785168416; x=1785773216;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oAUsJ32o9tcNLRRYV/BdlxSJZSrkJ69awBDQdICRnGE=;
 b=liG/Qsq4HxQYhJPlX/S0ow/otsA20wl0aQRmc45BPPbV3dwXDtqoAEjv+O/B/rTJ6D
 G6Q4IozT6MXztXF/0Sh+Xtr6xlQMpo1CKo64jFjiG9qTbbJAIUtoSUz/Qa+g8cGyxnE+
 ivrG8jTKBAGdp/Ad0wrZoAakLZIpRugyzNLCXdczu05TV/F+vz5iQ47EDbB5Q1G0o0Hb
 Fjg5HpTFAVxrApzKCKdZnIwxdWZtncOwYbAa8n7z9ERG/JuAJ4uD7y/g9jzKK3kjYYbI
 Ey2X0p9gzKIxM82H17kVg//uMvd6oUhxbjMirAWr3KEmQXWnoQlZQqy/4y5G0l1ySS/E
 jt+w==
X-Gm-Message-State: AOJu0Yzv3EPZMivm1zprjYrD9j+6m7sI/ldFp0F/jQoyFAKRfL++Eouc
 ci1DzKA/RxgfYp+PXOAdPbCxC8RLdrzumOAVYVoC/Mwr2nMvaADDqsTsZRDn99lhkrxVHQ99sNe
 bPJ/BHIxvkQntiIsMoE918XlAOQhho4LwZpvOCjNBqqqAtpID1OjUzWHwmsSxY97IZOSfqDlA9Z
 meY0m5jQ==
X-Gm-Gg: AR+sD10gU3Vo4deMU+hBj65JeycI8ZjJQ83bicudFP/usq3RBEOnH1aIC2MrxDSts4d
 z/1JbkVu1bQp1CkMc6ofbRqsW0aSXqe4XSoiPrFqXFy4ndygRsKq8gpicbU0p8aEq6aw/dFlbCu
 CaUHpJqNh7OyJkdX1tWRIX2VDKXk7v+uP3aLvcPYccqpPEtE1+AwugO3tJqItsWFxpY8wi+KtOQ
 wyWAnBigk9T8eyOOGvuRBUEf1o88BIc9eniD/WnUHInNwGM6ke35GW2czyyJC5krYtIp04WNtYs
 eYBDftb/9DD22k3PG+ZPX0/yBbExthvb/1eWv3355quSGb9wMHcilJLGbHs1jI6KkEn308uBg43
 ECStCPca009s/mC+z/6n1JJqMlL44D/vfNC33R94XAyfEyoKPXALhRi5LNdspdd5At28O43kuAb
 QcWX5psRJN14aOOFPVJd+aYPJNT3kg1WAjtHQRjueYYZMcM+4m7oukUSvShlNr+3sXqSByAIv7h
 B9pGCZBHmP76dXynlH+foNZDRrxdTwugGbj96WWNyWua3Jdmy93asKvTZJwDbJsMN1E
X-Received: by 2002:a05:600c:1387:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-496bd695ff4mr72392675e9.19.1785168415361; 
 Mon, 27 Jul 2026 09:06:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44b84edsm3957355e9.5.2026.07.27.09.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:06:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 16:06:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
X-Gerrit-Change-Number: 1821
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1821?usp=email>
X-Gerrit-Commit: 9d7e5ed1101d19f463ac9351d617f8a74b5346c4
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 16:06:53 +0000
In-Reply-To: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
References: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0ODI0OTkxMDAwLklhZTc2ZjEwZmE2ODMzNjljYTNmNzE4ZGMyNGZkNTQ1NjBiYjc0MTEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cdb601efa14c585fde613ef246ed740fe815be12-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woNr4-00030m-AX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Drop support for
 OpenSSL 1.1.0
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6877859907741318803=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6877859907741318803==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J+hgAfyeFnk="; charset=UTF-8

--J+hgAfyeFnk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1821?usp=3Demail )

Change subject: Drop support for OpenSSL 1=
=2E1=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1821?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
Gerrit-Change-Number: 1821
Ge=
rrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 27 Jul 2026 16:06:53 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--J+hgAfyeFnk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail">change 1821</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae76f10fa68336=
9ca3f718dc24fd54560bb74112 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1821 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 27 Jul 2026 16:06:53 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--J+hgAfyeFnk=--


--===============6877859907741318803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6877859907741318803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6877859907741318803==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E6C44507
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SRCCB4KYPX92rDpquA5cQeYFQmEZZ06hrQhBWh0lGgY=; b=HnWWNcM3Sa8wulAsp0Gwv9TjDW
	iTSUDV2suuHV9Mu/ahkO2hydZQiPNrwopAzD9jBDorwf+YbM6wMI6B4RobUesLAVTBAZiTLOD4DNp
	xxRyeZMSJaF18k5/XJqa7MJ0BixVnKxQvHT1DP3OFbHWmDNBzHt1a1V35J0bxHml/vZ8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk4mb-0001NZ-G6;
	Wed, 15 Jul 2026 18:56:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk4mZ-0001NS-C4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 18:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ggUslT/HgNXGCnvgljriZoLnoY50RW1jUi3LngeJzJs=; b=Cl+mUKAUr6QRXO2xqDn8g55fiF
 zeQa8gaFpBsxiJ8VcVDdbqLFqgWwDZorao/2DHEGSxPtrvGPPr5U9Zq9XKAnWLPt6PBQkz5yCsQL8
 7XGSQL05WUNVQNYrhU+K3if8/Lq+coPG45CVHBDeIV3nVijpz8OyhW0H73YcAc8PYAEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ggUslT/HgNXGCnvgljriZoLnoY50RW1jUi3LngeJzJs=; b=C
 C87Ng2p6hPEbXoobC4EKxEiSXpX/9bEi3jJigpPz8esbRLR4aT20SbJjHXG0bVrDZyxN2UPQlyGRU
 X4+/Djzy7JiR6BVjd+LSA3Maysaj30vyP012uvLqk05QX79ZoeZ4qUbdGJ46/s0/UcMmOukEW87VK
 +d1f799BfVchTXb0=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk4mY-0003Bt-1Q for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 18:56:35 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493f45e20cdso34477365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784141787; x=1784746587; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ggUslT/HgNXGCnvgljriZoLnoY50RW1jUi3LngeJzJs=;
 b=QprafLij6yI1rWUxfoYXL5HYy82axHT9rcfFxcZYObeYG2sWqjfwMYVpwR8+yzSgDc
 O3tdjDqHpDX4QXbUxSiIBQUFxFt/8gByny652kv9Ah8OAKrKJqE+aU23/XbhF0qkeul6
 pkHt0W/jgq7zwqbrWUIJbLKC8GBe9jM4W7OMAv6Bf8qOsHmbsxybSDIzu14vwIhy+r/g
 oyjTg8fsGarWKQ8dH4bBMCya+3b79OVNdmCjFza8CwjjXu4Sk6VGpTH2qkumKa314bPx
 zXq00JuOXgmRC2vg32hqB5ZDQeOn+k3cbGgDPvwWmIM+YtF01zLSr8WWtJikdAMlAOhv
 dy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784141787; x=1784746587;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ggUslT/HgNXGCnvgljriZoLnoY50RW1jUi3LngeJzJs=;
 b=UBg8Wf2RJOYwo82Nl2PwBOn71m/GsfuVxrJdGgfbZQjuNJJI1YNEFtBW2xjabM30ss
 7kpshULlsPNJ2zcguSzQNOApOys5H6R3BSUcGnjWMXalsKnhvrR/JIEOvZ+yf/5DP3hT
 UQuezgLZ+a+DR9tKUgvaLUAK/GFaoebnsgENQigyVUdAAYIfiWjgrrCHAG+H5SqnQ6uh
 lPXYRQNAN6g8MRpnnbiloJro9rYdp6kQUOCWQPtLCaM7qYnesGPhUq/LYhXpA1jY2BhO
 tqGiWmdMx7uZ21ZoBV0Cv7cA9Q73RRX/ZlQVAbrL8IPpS/KO6518e/Wbt/LYrFZl3AK3
 6s6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI4SFN0IH9IpmGH+aeRiaPpFiK3Qlg0bra7LPDSRvCDG9L3davH9RvqGIxsITFrQfcL0z2Rt94Goce+QPK@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxUGzmYwsIdUzm29YgVDKgPYEBx4HeUk9TmK6MpV6s4wRe9l9BX
 FJe5yfIXYyxX7Io0J0JwBexotAqQ8hgNPrn6b23F6HIsTj7+A3BzMKQjMg5WBzTguVNmsALuNKK
 LfivqV7eqOiKPX73IEqytEjgUXqp+Tj82WGN5ZBPf/DQ05tnyg0KCyYUbyv57N9noTgLU
X-Gm-Gg: AfdE7cnFz+4OFBjNqXSiIfWQhj0rZWrnJv7qaBfeTUtoKKE9HVtCVHORX+uPdgxlg5o
 sMNeT9hqp9o3Zp+K3dVivOx3NcYoYpzsyTuM0BM+nM9T0QJYO2iTnkw75IIhI5RrxqZbfcQQkaA
 5a4R0ZKshbVmyEYBVjHQ5gQNLfAjGFFMFypyItFduyOB5862WR4gi5TwQgyZAdrhRGk+UrgEozk
 qaKI1ef0/xITVPpUTJ9penhsSNk2DJLpfq5sPo5wcV/mzHZVKYVvi7KQth1mCJNTloIj+VLunV0
 PPIE+TextZLiwY4Uen8FYtTBzriJNBLUpE2f4JZaSbMxTQsqw2g2Yli9DVVu+rxolCDdj4Bpilf
 972X3RgHTpcApPo5BNwmZSV9VBLdZSjXPhcTP3l4jeaq3aps/UqSHrimOiramGBfuuvIgv3CIU5
 Qu6BVofQd5xkHb7E4iLXX5nteFUOB64JMS/oDn4hma7iyppSddjvW+S2fCkVMbRK+wW7zAKkoM5
 IITrN/33M8nlih90yjWlxjaWgoeSRmN7HcJGmE9VXhPCyfkcWf25v+Xb5neawTWdx1CG5zopejP
 5T/mB3mZ/mEAHQ==
X-Received: by 2002:a05:600d:6405:20b0:493:f807:1a79 with SMTP id
 5b1f17b1804b1-49538a0ef82mr68132835e9.27.1784141787424; 
 Wed, 15 Jul 2026 11:56:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e036sm21062284f8f.5.2026.07.15.11.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:56:27 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 18:56:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: 08e75f6ea182acd2c9b6d4ca06b5bb35b7b7addd
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 18:56:25 +0000
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b72832673f989d7c1a927b1ea946799be489e05a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk4mY-0003Bt-1Q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8597657569925890740=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8597657569925890740==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gU3JUALXGe8="; charset=UTF-8

--gU3JUALXGe8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

ordex has pos=
ted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1789?usp=3Demail )

Change subject: proto: correct 802=2E1Q length=
 check in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1789?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
Gerrit-Change-Num=
ber: 1789
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 15 Jul 2026 18:56:25=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--gU3JUALXGe8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>Patch set 2:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">change 1789</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8219c629=
5acf28ff10ddb2fcc285f813c42fa8fe </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1789 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex =
&lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 18:5=
6:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--gU3JUALXGe8=--


--===============8597657569925890740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8597657569925890740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8597657569925890740==--


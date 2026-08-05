Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59888C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCODXVxPI1JkA1cHZDscPTRv6tGE202U/UZ94rQC600=; b=Enj+cTSyJnS5MwLvmCM0+igRiF
	XWIkFacmTy0indT7JmG7Mo/Fuj75dvWy9djWZdXZ1tRdCqfYZ9yzmtA9AVL7BwZe6MZZjoiRlyt80
	Bshc4tfLOdIAcaZQny77v9syrC24rZQbBFYlgf0/jFfKsf/mreRZD/UJhwXGKiACBmaI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wre8x-0004eM-Mv;
	Wed, 05 Aug 2026 16:07:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wre8w-0004eC-SU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=URO3LYqnE2zxQYSpBZMSqerp5cA/JftoavB33ydJvxc=; b=UheQcAUEUYIFlLosKinufYze4r
 6925JYRGv8yLE3sLA0sU3DmIis4WLOnf0cPEiQfy7yEDDCja4ZVf4U5F56WwgmZwNbJpSh3uFTR+g
 i/8twY2e8Zfur4VDMY3jBMYdobN4k0S5DPEJlbqBERXtVhlNMlfmyvib9yrttMnlEvbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=URO3LYqnE2zxQYSpBZMSqerp5cA/JftoavB33ydJvxc=; b=e
 ZDPI5Mo71kkt4SWCDhu3k+go9YrrLOYNYF4/wz+aJBzMJsXMgcN1ywYrhw+73SX9VnaiHoD3QjiDL
 ZGnJVfT5htVOWa52jhN9w56Xzep8luTiTt3gqqc/qhj7WSxSsaRUlfJSUMmwGrY79IySzhqqLPH71
 SWr6Y45VPCTQdUWQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wre90-000427-Ey for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:06:59 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so769847f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785946012; x=1786550812; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=URO3LYqnE2zxQYSpBZMSqerp5cA/JftoavB33ydJvxc=;
 b=TSgncl0+vEgs5UAruI1dJiLDmdHkETUW14mNGkV5spbkUwrHxOrfFlzwLNORc6fwVB
 1+fKQL5wZ7Z6ARLno8EcuS2pyzP6XM7K7a6DBabZtmweB6Y9eIDt/PO3E1tCbR8lqHMK
 FYgEEFCq8KAR5TKIv4QjoaYJzOFlv+4iSbkCM1LrBVCHnaPqXaTAEtsIb3pZoX7Qpa0y
 +gPDLlcJeDDOf/0vLoJkWxhidmBjQ9PiLz08dWBfIpHxu4RGv7NovbjiOly+fOvsqid8
 StFsqK0EQn8zew0PavRDcOxzwA9qVr1lbeTEBnLryoxljc1VTSwVxXBZ96tVzC3TTyJE
 Ir8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785946012; x=1786550812;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=URO3LYqnE2zxQYSpBZMSqerp5cA/JftoavB33ydJvxc=;
 b=E6sYlhp9WhB30zjW63XDJvir2gRyTSRnit2S1rkYXvzw+svAMs4L6v2PLfo0Z8cDBT
 0FJ+Y+VtimrjeWlE3Ue8tP/2VQMO1NIPoC4P5Dm2lErb0aIqrtaAiqCLP92yhbXQRngA
 ht0YSORezWoTBcZyBFBXuWfhpbXRej93vqZ1h66wk4mWMAPcWlMSSMbF8+UP88d0HTvT
 kDdGUme2s/1r3uX5+eoHLvt/AAqQUVSuvCJcTGkM9Vgy1d8zc27PuKvCWla1Lo6OqtCD
 nysbdSp75KmmRx3RqYdEYusWewLg2EIaENWVKtBWHN/i3WYVHcoeW7NMhYC4x4ql3Scj
 o+uA==
X-Gm-Message-State: AOJu0YxlPlzNulNAmNYIvSboy/XDpwVAQOBkza70FQ0e3yMMwZqP/nK1
 KV6R5lB/j7aP8Tvm2JPm/WeVfQggb0KHuM/PS/Qp9ySWPRJPzu6LCRFr9VTsYJI5hby4bxXJUMp
 /2BwuH73ZpnwVFjwGVvqabn/OmAsDYRxwxhjVAZUzNq6wJ+3UaURBdxiHd0LF3fkxChRCuPM8Os
 bP+jv/fQ==
X-Gm-Gg: AR+sD1106hWMYsgdRgIQAsHwYmW1IPT80n6bRkBTa/vJygSLw5h581CapuuniJ2b6N0
 fSHKCAJovLFSVGNoQviGlqZluzVPmFhf/FWqS6RUiXroaGS+QRi4As/LyDGARxiHp0OXKM9Feye
 udeWzwdPsT/yCtjXuaPkrMJcWqLpOuU7gZ0zI8OSrMTLGPY3d2tFaPpO2MxPB1Ais+cvSzoqRAO
 tonpZ0Ce7tQNKcsMxR4Q3vKMs11J3SykSFM4RXSIriwA3HiIWel6EPhU+4shrf7MN5rpQpEmrah
 XfCaBNpB60g6bvZ0+SRRzAYdbD9MWzMSgIz4+83NTCTapgX1TOmOCgqfU0ISeOVumTzkmiTErbI
 sq40n9Km+0hSRMbC+R12JbdbicN/y4/snsjNnbVk05pr0fIj1c6rFh4Qb7fk6sygYVAoJUf3xHt
 aNInPUTvzxsXTYMfvsLixVh9XYm6XUUUKcKI2RomT31yOsdC0g872N/oGVwIfTVV22iR6LDTu6Y
 XVaclt0x2OdT0gt6OPZyGWAE80z2GFXErgnhIS45N8ZW1UH6hVUJAMzBCogfqEMSjOWc//pZoIh
 ysRPCLhYeaEOYAVvtX2L2SZJUBQq/p1XZYtItKZd7Y1kV+e5mGo=
X-Received: by 2002:a05:6000:2995:20b0:47f:959f:f69c with SMTP id
 ffacd0b85a97d-47fec512853mr11931434f8f.7.1785946012117; 
 Wed, 05 Aug 2026 09:06:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfe5d7csm10609585f8f.15.2026.08.05.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:06:51 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 16:06:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: e7ba43c8495f1a1d969e81514e690de485360e89
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 16:06:50 +0000
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <69ed0b5e1531c66a84bad7bf1e58da11750bd1d5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wre90-000427-Ey
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: reject a pushed
 epoch data format tag with a non-AEAD cipher
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
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5898197440891382915=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5898197440891382915==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MApjfLFZq2w="; charset=UTF-8

--MApjfLFZq2w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
836?usp=3Demail )

Change subject: ssl: reject a pushed epoch data format t=
ag with a non-AEAD cipher
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
Gerrit-Chan=
ge-Number: 1836
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: o=
rdex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 2026 16:06:=
50 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--MApjfLFZq2w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 2:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1836?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail">change 1836</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc0721fd4a910110507d0=
6b4e941e9e6dbb11e9f </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1836 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Aug 2026 1=
6:06:50 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--MApjfLFZq2w=--


--===============5898197440891382915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5898197440891382915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5898197440891382915==--


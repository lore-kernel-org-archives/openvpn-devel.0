Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC28C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPb48G3n6IG6c5jNpdcY4Y1O47RGHOc3T7ucPt4AICw=; b=RUasov+5RWpohPEhnEyHHAvVO2
	9FEoevALyBwY/f++j1+vna/wApRltHsCQRyan63yJnja/hcCNcf8t2S981Kdmsk6roQzQuDjOhd/u
	6ms3uc3dRgycZeHJpUvkiNzgI4mKhVGKLxmXSwPZ0BjAZdWLK7OS/ajmPhQoA5/buD4A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmYwo-00062c-G6;
	Wed, 22 Jul 2026 15:33:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmYwn-00062V-I6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VIUItCE7EUeWSRSdjhjcl2YnXeUnVInqQmxSUV3/3EI=; b=NlAE0hxmLF2gUCITlG2pAIeiiS
 3K8Awh8W41BE23lGwHF3ByZvbtOElQINKE61OMxBom4n/6rXLqRiqRFxPf8UGoSn/Fww9bXcinpJt
 rFsFQWhOq6nXtsrAIEVIY7YQfBl3EqK+jCmgQmyEncZaJ6juR51XqAm0ANW6ap/RwGnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VIUItCE7EUeWSRSdjhjcl2YnXeUnVInqQmxSUV3/3EI=; b=G
 oUV1PtCjz+2HOjToJzS9yZAiRXpcrEz9GE9pH4+JfGgeq/SIoo9E/d71tsf9yBetlwYbFc66JzCEL
 bg6JUR/sM6mh97y6f1cZLYXv7qf2rW30V5Mbv1//I4uIfx2q0Zr98aiiiCKjMI6sV4keM4QKOeo/v
 Hrl8weqRKZGrzFiw=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmYwm-0005Or-Ss for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:33:26 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so36808075e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784734393; x=1785339193; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VIUItCE7EUeWSRSdjhjcl2YnXeUnVInqQmxSUV3/3EI=;
 b=FPDJJl0F6T5PcQdmO0ADLM0jzaYowUAhemo0JVd3Be/kCqKFLIqvR8pUWyOv1tdk1j
 cQcEvElzuCSsLtmaTJUBHIKhqznieRPanYHKuz2/jFi9C+o+ZLgsJA9Pj16IB7tSFfAF
 3l3mdwpCbPw/awuVTAP6vSfHYW/eFe5I/eks3qXAMYFuOL4sr+6+7nyakfbtw3NAZuqI
 YhrlyI54BD/EEq5MAk6uOku0gbn3GBZgYIZtCFyrVOBATTCL4g7GA6cwIEXsgRs2VxvH
 iRxcWGvwoLVzKYIILJQrLLQzP6V/WXjZOFt0UeCKz0drnTUF+ZRfA1/bybcNuF0ADOdB
 z0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784734393; x=1785339193;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VIUItCE7EUeWSRSdjhjcl2YnXeUnVInqQmxSUV3/3EI=;
 b=eeDIb3uaLttiJvdz3I6cnJNF/4rRp23dPR0wfaCc0QlJS32OsgfqY4wX9BUNkiTg6/
 A3NDjgCbIlWT0j95GOCgUYKdeEOAKehs+vAOdr9+CjTbG56CJvbFIN5ELuAkt2MR0YbJ
 70XkU0AbPPiZVMvHhtd3hgobEK2n2Ca2vk6RcnW+eWRiYR/nhE6d4YbPla48labnqi9f
 NY7Z/bjdNtzc9SzfaK6LrEjJIu6PvGfcuM9MMeVW8/qQVrz1+pr1FRp2qKbhwFeeGpNQ
 wPSAkNSJoN8tN6oabR2i+KMM+Y8THQfSw4WBfSc+w4BxC1ew7s3mv+7+k1taVMcnXZFC
 jJHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqNSBXRcbmtoIVVFQlwnPtSvgS5/brtDh9/LujcFt8LY7pbTkcQB3r8tY4zkJj54pomDrbALzGp3llzEA0@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyc3eWuwfhxj2NQ29Di6IWT7+tqzfNvY2m+hbMednMYLmHdsjGC
 YO/KY9rn4ZOGyUcVZ/2nklrzh5aYIOOL6pPXjLzqBcJv37weUANmzxyke+PtSLOgiPIORligNyM
 9W/N++84fS7NfUH10XmGGSb4eARJQkLC5Qi1jQfxtpp89hoEBUzM06sAwfXuewcUa9R95nxcdCe
 pDUYHVsg==
X-Gm-Gg: AR+sD11YtvppaRhZWr2VEhGLY5yFFLQISt1RP3X0Xh9NIVUJPFoSenQZFJQk9wZ7UBR
 dm8vX5n6M8x9aMKanbyv9P1GIkUik7iUZo7f7Zu7EZH3Lmqj4Ihyshh+sFJdftWYjx0zCm5Xb2c
 5lf9SfX62sVI2l+f0G3uxiCw4wTq9yZh26MnYq3Ol7Rutyz5eT6jJ6H5zqsM7ExBvy7ziGikGOK
 l5D8E+IfgNT1SIk/k/8hhCzYZBR6O3UKqXQUY2s6vF2ZbVQ1zZv3ol6LFVhumhsqmNAobfAOLjU
 iqSpQnPjPam/uItOBAwFejgIkS2v3tdzTs8aeIpou1t95Fe6IkN5DcETSIBFh6h/415HSzaiJDK
 oObDjbX6+9GwW/xs0xZxETfGXdIjWAd4IvXnZVCmglGOKBaVUlnbL20geHSyrrwx5zI8z8lefAC
 icdoqwgLaYlgjbj6fzmEGzBd/SSKqxcFLNmZn+pg1QvITfwjuKMNINKk/GBD5zZuUTn/GG1JXu7
 Korcza/rlIsizCGcEq0Dl2Zq8Dsq2bJeSwnOLyZYGIoRtKxAJKTGKtnkVWmAch7JY8T
X-Received: by 2002:a05:600d:9:b0:495:5e07:649b with SMTP id
 5b1f17b1804b1-4955e16aca3mr160206625e9.24.1784734393089; 
 Wed, 22 Jul 2026 08:33:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm6596580f8f.0.2026.07.22.08.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:33:12 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 15:33:11 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 2e79a47e4bad09cf3952c4df0be13742908f2437
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 15:33:11 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7f56a7d85ff8fd45abf8025dcc6aa9738b8d31a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmYwm-0005Or-Ss
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5087384185133946182=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5087384185133946182==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cgh+V94e5PM="; charset=UTF-8

--Cgh+V94e5PM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER_PROBE pars=
ing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 8: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerri=
t-Change-Number: 1742
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Comment-Date: Wed, 22 Jul 2026 15:33:11 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--Cgh+V94e5PM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 8:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1=
c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1742 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 15:33:11 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Cgh+V94e5PM=--


--===============5087384185133946182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5087384185133946182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5087384185133946182==--


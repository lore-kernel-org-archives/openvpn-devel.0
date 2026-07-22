Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0E6C44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDwNlIQ6f5Q++2DXrMIRiSr+dR/mLlYzwwNCpl7CDfI=; b=hzM4KTtMZ/9rRUo5E+KM6CMVPb
	04cVgXaYRKxT9OPHU3qT0zT6J2SR/VovIsIwCPIrHdMOozTRAkc4CfqPV8Cip8r9XyaLhHsBCZKfj
	qjIYcrKgoLPj57jHMBG7HM9Uj1pTEwlTa7VEz7uAPuXpLo3gH+ixmsTDhtK1h2L7dWUE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUGE-0004dz-Al;
	Wed, 22 Jul 2026 10:33:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUFr-0004cx-NB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Pq90zsEBeClJPVKM9keGF2lLH3dn/zGQC1jXKOk/s74=; b=PAfyC8Z9uE+2zRBy9tUdUVkCbh
 YfvvUKHrNbBJFXSyuVw/SyXqHvzhJOCTX9DLnE4puKDNP+Nuc3SrbQG+Z4QOCNmpukDyiS5KSoIPn
 96HXyQFtnp4GsTsRskmFu9rny//DIjUSxN0++cEshtaAP8AA9w2MdCtrU5azvqKvADek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pq90zsEBeClJPVKM9keGF2lLH3dn/zGQC1jXKOk/s74=; b=E
 FzuV+sbnUZ4F8tSIbbOgIv8nOZ2c/F/TJr0p3FTxkZcFDdBytlBBx6ZpgkLERobz1x/q2lbBVXES2
 KojEkPiWfbDVQQcJPs0IiTV3GBk8P9o362IcYphRGBplyQOvlwspFKxiplEJliEz+mwBlA1eY/7Ik
 FXJoEX/ZoE2yO1Go=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUFl-0007wq-3j for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:32:42 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so4814972f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784716349; x=1785321149; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Pq90zsEBeClJPVKM9keGF2lLH3dn/zGQC1jXKOk/s74=;
 b=O9jAyi15TtLCowFID2Cyq9KaDPdNVyIDj43cRk60IFrEMGi9f3Rh2Hx+InsgSYHrPQ
 x2Yu1LJRl+L0w+vZMv2hsWP743xNXrbJNG28fFZEjnMr0ThDpARFzGey0fWDl2UV5LkG
 jTL4PVDcdkQLo6X/9fawHEqOsD1OJI+XyEI5AEMmIsao1TNVuXX0ucfydn70/f9FhMp0
 oiZFUAX5lwcQvqYxQyvo3SfsYtGnMtU/atorLsbMJyl6oj1A+e/amLdPNY+0+OeyugxX
 LgsBc291BlRCyytxRe6EQldIhC8X0+z2TWyaxnxsi5O9TxIGXnLNZG/nnnxBnaJO/v2v
 BXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784716349; x=1785321149;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pq90zsEBeClJPVKM9keGF2lLH3dn/zGQC1jXKOk/s74=;
 b=B/C85z0WZtsn2KqPZFCk15HVoL7vLEeMqhvBqE2h+hbzrrMneKPCnUrru/9PtDChfX
 nxPT9/BsbAUvBWzoBogfvLdMFTLDPbKNlYCVjoQsGoEWicQEDR73V6tehdaE5/gI21KY
 xMmgTepdLLkMmbMJrJtOs9ucc/4ffRSL03ygMxC7heGWMh4SKLiIWeeaNDogOGfQs82v
 mUy9c0jdPbwpj3gQUVBEJwUcwacWaRPYCrFB/T56gzJztwQdfPBvkz+CB9xo47i7d3SW
 /2yCyopweuAwX97allgUnKp4IaNigRKQx6fQ2JZM1YFJhkGhhVss1gmDMbyZUK9qCzCR
 y/6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8aCKidT5mfurClhKW4GFFVqQRSWcmRWxfmg2XSlVf0tuZ+JtHs09BgJa1R9gDFga79GLXF04Wkb004Rze@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz209Xx1bnoUeDyH+zBLhSaz03T180zFTczo7HLdItkEubXz1oL
 ObYbhJeF3k5uTa5T64btbSRHF34N0MriZ2xoXocEUTP4BnnPFkeB7ulPT/rHBjDAcHjsc2BJmPq
 BDQo4hTdklbd9TyaPfJ+TSBtS/yQb+wFTilNbHzm4yNsCjHdkM6sb6pNCR0TN56MNuDTMCvpJ/v
 gAfNdwHg==
X-Gm-Gg: AR+sD12E1pmEr30s6piyco5xgfV078Yj67zOAyp0cCFzBtmi5YU/FTNdG6ZLqD7ZSes
 gRh5D8clfnz/eB1/mYIWLKJuRoLBwL4yFRBhfoC/ZabY/PxnkfX/Rnr+LyVuoQJxJ3p9ZV9qzTi
 P4f14YwgxxMemfUeS5yzdUt0OQvie76xid3Wkv39zyNUOk7hcHuB3qkmHA8ay5hV9CDvCQGTWQn
 k919oOFfCA+PwdIHxVtLYg6JuAyNbM/6Caf8ux2AYioYp8dmG1fnjHjKw/w1b1OMy/1peFlulqA
 VoB00j3zlgTxdiiRArD0mfSHuVkaxZUtxXmlQXMBsjVBgsJWz9VuC8qWZ20PJSy3S7/IQzYvzl5
 byE0dkXm4MqLWJ74YTp0pAYSqzjxI9WiEH0WNoJYJP/xPscx4gcjuBwEkzNVlDYGs/JMO7wIEfp
 kVDSJLeFVIAS1uuvVWM2bdEVBMOmz4CBxrUDU0WoeBU55ZAds4fU9fv6nxOUPyXftMTgEa74iQP
 zjnk0K6FLD3KmWtLd7Q+fJ7PR10OvBOc4IkaRLhV91hYdlGddajrC4E30SU+vtj4amJ
X-Received: by 2002:a05:6000:2dc5:b0:47f:7346:89df with SMTP id
 ffacd0b85a97d-47f73468ae6mr16573353f8f.24.1784716349399; 
 Wed, 22 Jul 2026 03:32:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63678sm4531018f8f.29.2026.07.22.03.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:32:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:32:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 9d0ee07b20b50dc7d63643cd521f4ddb0a8005df
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 10:32:27 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ce5f17ca9723da7ad7dd80924039b8ec7436dda-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUFl-0007wq-3j
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
Content-Type: multipart/mixed; boundary="===============5166030051879110163=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5166030051879110163==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g6hxmj/nMF0="; charset=UTF-8

--g6hxmj/nMF0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572?usp=3Demail )

Change subject: Add aws-lc siphash implementa=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 10:

(1 comment)

Patchset:

PS10: 
Added headers since the cleanup of =
headers in previous now requires additional headers in aws-lc part=2E



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I05e20f8c82494e4abf96fe1=
e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 10
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Wed, 22 Jul 2026 10:32:27 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No

--g6hxmj/nMF0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #10:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Added headers since the cleanup of hea=
ders in previous now requires additional headers in aws-lc part=2E</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1572?usp=3Demail">change 1572</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101=
af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 10=
:32:27 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></ht=
ml>
--g6hxmj/nMF0=--


--===============5166030051879110163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5166030051879110163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5166030051879110163==--


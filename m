Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6375C5516D
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a8EwhZJJs3hL7MJRQmoI5rj2/sMKqVRVoh/fG3nJics=; b=OV9d0urLTTMVKWCTzepMplLIJ7
	fM84GSX6pg1B6i9Xg6rguAvN/qCQnO2bAgN0UnyDJOcg8X4AdWo2iKn+2ftXOe6CA8cGz6+TBs+dH
	grw/3+xPV0o9vgvg2WSzggPHTx+0qqDW1DfMxK/iorXfIvcbSJf6HJPn/zMKtxBRqrF4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wplfX-0002Yl-Gs;
	Fri, 31 Jul 2026 11:44:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wplfW-0002Yf-L9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 11:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l91BqRg83/MszTcE3GUSouDFAI578OMXF1JUElNSOt0=; b=adrEi4ExfO71BaxL5Mvn2ghW6S
 lfTJ6J81iuGs4wI/VMPyo67/SeaR5wUA4LgO+JgQ8VLEEYI5kBL2jcEfRG1so8cUxOX0EYEbpXaJC
 4NKCJdza4SNGaXb8GlBQzG5lhYE3v6POltVRfXP/bqxDTFG/AtpFbYx+F4pFyD7TMsM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l91BqRg83/MszTcE3GUSouDFAI578OMXF1JUElNSOt0=; b=i
 YFMs8gULbMyaVqNF5xn7NlOknNHEMkewDLYKX5/dp4vZqbKUMTml6osBXodb1x5itG/6iSPueuA8U
 xVczKYuep/OdnbHhXpkBv4nZtl9pnw/roI7VbzsCSNoXL1hdfpHHR/s8wv181y0Pp057KDpeJ9iIx
 GzOyWfR+7FTPnVZc=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wplfW-0006z8-4z for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 11:44:51 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47362928f65so885952f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 31 Jul 2026 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785498283; x=1786103083; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l91BqRg83/MszTcE3GUSouDFAI578OMXF1JUElNSOt0=;
 b=OQxvnZIxq9iccPcxQyN0mgLByT5vI1gQQw457jxMhaxj/EXXh34JlWW+5AoQdWzdtg
 r7//+ITC3qoMsIiEuCmhh2t3wtwwXfXfj7SRCZyGCmN6DLu3NyteF5Tn7gIJBRb2T8Y0
 n2YcgYqqxx7r2ZCKILmwv10CFb14KmkX6ckNR3iWQHmhonszRIqGbzUAvJ8Vh31ySBCS
 3Nuqmbtv+l+8I2MLxwdOcf5D1yr3PZzysNO/0sV5SyaK9uwug2OswXPR5Pu28qEI6yrs
 cDkbXC/GHKdmT6PQ0i93EU6Ozxq4ABglh1PSzIcoPQHLz9Ol70J7abyTOIgOA3rwsdBt
 gkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785498283; x=1786103083;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l91BqRg83/MszTcE3GUSouDFAI578OMXF1JUElNSOt0=;
 b=dz7fXhfHGP+j0ViBp3HKKQWieTOGm0NT2iKqxmZE61HBum0YWLGeReqHTCXF2Ykxmg
 rP7poELF3JW9EP9+IbMh4SL7naIAjeWymqe4mza/tOMyr9AHAdCPAC17hXYQja21U4Vy
 BLo4vPhJyS+eCvLF++U0fuX9DXOaMwmmxJIykh5dTayKVX8B9Oii47jjk+Jxbf0M2pHK
 I8Sk5VrCh/6vu3bC5WnT8korOgZ5U11U8IXAjWL3L9Y7l6r2jvQtLfKhfzaFo2GpEqWS
 PZq28tPEo8piv/r1rFeX8cXhogfgZqo56dtpmOGDGcja7h9T/rsOGU/iu8LXQL64TUM6
 3c6Q==
X-Gm-Message-State: AOJu0Ywrsuz+BisO02Hluw1QSPdTWKeuDqKu9CcYhYplZlBEs79/jkm9
 jtNtxauWSIIE40BJakAbw2Z0fIMFTem/M2i5yUCDFrCF96pTWg3QxD2QUi2gsywlQ8IFQnOB0Il
 XiqeQU+LTueJCkyhBS0f2bsIyZsmtiuz4iFNth+gCKub7fj9vnEW/KGqwhOnKGDz08NJRBWzHj+
 oGVkvEig==
X-Gm-Gg: AR+sD10sBog+3V7GSg40wxiKKuVt/pYusb4mqN5DRt4gs26tMS9GMeQltU+kwUyhdCt
 Kd++lw25Uz9H3MTFzoZi9Sm3BWpYPT29Ws2xf3Iqqk6Z4ss+sg29SGXMZ3PSHPSd7bXmT5cKEHP
 jiN8K61IYZD7UEbdIHK3FzVHmidDNgQMlp0qvRiohBSAPYfQ7EcPNxzmmdfBGCD3wtx75PUOpkB
 5h0b59tPNsONSIJUHyL2wvHTesJWMRH5nAvfCPiTio2irwszsMJdEGhkr/ssMwDmnkBB6LFDP1Z
 xcT67y313vKfHfGeRjiR39hRYAP29r4t8cbNgvAEAYehkvMLpEx+8e4A45S/5lYzhWd542asow4
 pBNeX3Nw2EnU2J6iRj7Sjkk7w2evGSyMkYoNBJPmsuATdt61UnK7+VDuNELgR4epou5cfxclyzK
 8uH9NfZ5tb1opEEdAjbC2pKBs9bOAO29KSOZfNBIhOSPoR47QCxdPyFUqtmRsK3r1Yfm9FENUwa
 Ew5DrmLgxPM+JccykxCnEkDbacQ3w1BIMHWz8d827KOtANHVGCFSvzR+s4t70jEJESaKU+UBeSs
 qOtJQeGC2UNTEFrsodzG9/+yNi65LEyUgm+EPBeB1O+UkBkO5PfVBAXgm939Lw==
X-Received: by 2002:a05:6000:460f:b0:47f:6fbc:dad5 with SMTP id
 ffacd0b85a97d-47fd2af1307mr4011354f8f.26.1785498283365; 
 Fri, 31 Jul 2026 04:44:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6cbsm3858825f8f.23.2026.07.31.04.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:44:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 31 Jul 2026 11:44:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
X-Gerrit-Change-Number: 1832
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1832?usp=email>
X-Gerrit-Commit: 2962c4e1c61699905dba0ce2d6efc6799f984b13
X-Gerrit-Comment-Date: Fri, 31 Jul 2026 11:44:41 +0000
In-Reply-To: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
References: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkkzYzdkMWY5ZTViMmE0YzZkOGUxZjNhNWI3YzlkMmU0ZjZhOGIxYzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a34bffc798c646c1385acde5abf78d267a41c89d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wplfW-0006z8-4z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Ignore hard
 reset packets with a non-zero packet id
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
Content-Type: multipart/mixed; boundary="===============0136513241298774550=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0136513241298774550==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HJlV5Dj7R8g="; charset=UTF-8

--HJlV5Dj7R8g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1832?usp=3Demail )

Change subject: ssl: Ignore hard reset pac=
kets with a non-zero packet id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS=
1: 
This is straightforward and works around a bug on the sender side=2E


=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e=
1f3a5b7c9d2e4f6a8b1c3d
Gerrit-Change-Number: 1832
Gerrit-PatchSet: 1
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Fri, 31 Jul 2026 11:44:41 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--HJlV5Dj7R8g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">This is straightforward and works =
around a bug on the sender side=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Demail">cha=
nge 1832</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1832 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Fri, 31 Jul 2026 11:44:41 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>

</body></html>
--HJlV5Dj7R8g=--


--===============0136513241298774550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0136513241298774550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0136513241298774550==--


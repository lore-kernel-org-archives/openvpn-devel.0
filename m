Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC5DC5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYizHaaAS27uipp+hwPFATneGgY1Kc288zWAqCTkoMk=; b=E7bJGOvF7hi5d8MEu7pF9N2JJo
	zh9BCg5bXi1EVJuMFvHZNOiYt5asqAs0IU55kQHRkpKXzH1MFuFT2L33NIeq96c9dTJ0nyR/9VpW5
	r/0gFh+CK+KmlxgucSvh6odbEC4J2LDeLOdAJy+wG755642iiAlETHE7Vc4E+SdWtvO8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiV1-0001Rq-VS;
	Wed, 19 Aug 2026 15:46:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiV0-0001Rj-Cy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:46:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bfWGlx2JHXyGBnpqegBaV1ms8IMwgyJE6HTnjNh7edw=; b=dZKJkgFYkTpEc10AiTOk6TIPa+
 Ei+mP2RYTa8bca+VcbSdy2EctUBn4oIDQ5CWEbKUOQfdEdKoF/sVORM9mJs3oDlvIZ2397CnHBv6+
 4SbjEqWsvS3L5XywiCvwJq79uQPVdjFLsJPrA8gSRNz1+LFHf8MGTgRBW4GZ1thiXVq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bfWGlx2JHXyGBnpqegBaV1ms8IMwgyJE6HTnjNh7edw=; b=S
 AVASYR9Q7Rf6rt6nOFymZcr1h8/3NpS3tXJDaEwVp8dGzYbz/DTMvqHbdgRdHI/iYLokuXYgCUb36
 OJ6gK/R2LQNQHhAVfjnBA2PWLX0nwEN9MhKBBljM+oi63Z/di4/rBh4X43BO8ad36nanAzrHVYg/1
 E56A2flfCA2KPEOw=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiUu-00088v-1C for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:46:38 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a386a34603so58460a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154385; x=1787759185; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bfWGlx2JHXyGBnpqegBaV1ms8IMwgyJE6HTnjNh7edw=;
 b=Cn+ps7ug4Ya4Qeukl56TEFpxxBMdSZ8BDnQzorE5KYWWAurUEwzYoncEkl+jbjfdKz
 V/9EK1Dque+6BdEHoo5ckyvI4T6CO2fa4NpzEfOvzD2ehkUDLuiirVtP/CX2hASXMGmn
 s8peVPFI1j49TWn8LcO9GOvymEyEMfV9M1W1V8wJl6kWOfFTbdJMa05sVrtDvJQA9Bjk
 cPxex5kSP304xLCy48qNC6wnBOUYByfH4aevx2iWE2QYaFi/VFlCo8vuwZnOakbBOV1t
 /qFgLkhR6tyYoON0AcWbxqgJW44XJ1aLJrFYYuUpX3b7t4V9dniTE3ByjPYJkDl2puJs
 ViRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154385; x=1787759185;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bfWGlx2JHXyGBnpqegBaV1ms8IMwgyJE6HTnjNh7edw=;
 b=SAYRUoBEumpXOrSRX4Om5E4eyXLDnP+T+lAO+jsSzv3sAdAGFVS0fsBD8wGo9mtNmN
 eS3L432p3emRQt3bdYgOwPXb/25hLY/0pq0WoU8FlRukvpicqtlItzJsrj+i4lcPlP25
 W7D30DDYYjMk5hzOp7X29dxYUasFYburh01RX4W+wg3oKqNSCYDC5DPh2H22P8anhjAs
 69SWZ9P/6Eb/gLUoPgpQVzBaimy5SIGp4MlHRMmWR+ivrjof7l6C32ecaK5QmISFo/Qu
 oDDHzBNIJoh60GKNGSO1ZXoCQNowC7i82tcNKevllcoshJsqQuwvrTfBLZfku2TLzR62
 wkig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou9WA+Qsa1vT9iuiBJUzV+crcFYilm1N1+SvQ7okZGprkOxQzhO1xcCPwxCVA6RbjaYeWktu9UTDjQtTud@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzqElE6FsI0quzOrWt2YJ2hQKe0aS66+3Y8Hu4pA9hhVMyv/sRy
 OdGOqSdPRlupt1f0hAe8w8aQi5o/tXJcCA3eKKKcF/ht9yF1mQcSOSR3st8S+PziRo+UN4IYGmA
 12wrkWbv5+vC7jSJBzrwiY9+ZwKSWUrwMH7cRebQT1RwHNuN9hggFfAWkQZubuZSMk2Er7t5QbB
 ZBJI05ww==
X-Gm-Gg: AR+sD10Df28Ia405nU7gnuFQx/TtlFSK2K0aQKfrFX9mIMuyTA72h/OqfTS4IcgLu4F
 F9AdQ6O5S+V8DdqEZYYI5yO2ctDWbwPxAwEqlbP8oUjVbxTPd/iDSz7pb40Hvkoyfjl94bVbXBe
 0lSAfRtBPkHlp2Mf/81OK8G/st/soMSxL1mmpego4IbzanQIZj8lNT0c3RZpR7XuWrYUIdPJaNu
 MOTY9EhGaX6ZsXWUESzObKcN7n+GZt8RbplPbhOA2I3abkGNzSucOMRV+S0S95KI/CPS9sY3dcD
 75BiBN0yn53T0ScpYMFwdAk1jTUL8H1RKIUC9TBZ3nU5s9C4sK/yVj/OK97zxgQJiXfGu1/b9FV
 Mqh81rjy54/llU2x6ty3Aeb0EKCpi7h8uiQiZK3qARJ9NF/B5Iu9k3FdoXJkjq4jGmHZanolfj9
 X8luPWXN9+QGstxXMcjBxot4es1n1TZnCIm1sg4Rx6rBgyN8DXByP8s7/tDYHvO98dNnsWmphKF
 eMMep03ZYjkZu7kAB5tyOnYDn/qOTuwVG7sV8h/hwD1UtRbPLfqNaLGiB2s/2jtG8VncqIMVU//
 JoA/M5MFTgZpWJARd0wGxfFlsTg8RGIwbR8391N6ubR/rcb1Us8=
X-Received: by 2002:a05:6000:4a1b:b0:47f:71a0:c060 with SMTP id
 ffacd0b85a97d-482b7807d35mr176209f8f.2.1787154044416; 
 Wed, 19 Aug 2026 08:40:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450acdsm6444361f8f.9.2026.08.19.08.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:40:43 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:40:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: 82c8562de76089838ee7b4ad609aa6ab92f3bddc
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:40:41 +0000
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <63c6c31e7f50d2157df359af3a85040c88b05fb3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiUu-00088v-1C
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2913871988846927397=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2913871988846927397==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/9qMyZT3eNw="; charset=UTF-8

--/9qMyZT3eNw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1846?usp=3Demail )

Change subject: Factor out addres=
s resolve code to a new file resolve=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b71=
01f
Gerrit-Change-Number: 1846
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15:40:41 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--/9qMyZT3eNw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">change 1846=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I12be=
f330e2c8a5e5b21c2fa807584319b2b7101f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1846 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:=
40:41 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--/9qMyZT3eNw=--


--===============2913871988846927397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2913871988846927397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2913871988846927397==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72296C79FB6
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAwNkSyi3MAvASuePMFNHl4ak34xWMfdVrrCTUS8N0k=; b=SiA47/5gfPxu9bPy+j6WKP9Agj
	SWwlJcjI6G94+AFwcJ/lQtarI6WiZVymfIDWYq5++yzA/Fpeka+zepFbpHNGMtJnoV6OHMupeZSlz
	Y2n/zU6oO/EmjF2RNKYkMsE/Gb0BvVLX3CJc4cPrYmgK6fwaTavEnezZV1iaWjI7bcgk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5K6N-0004hz-Kl;
	Sat, 12 Sep 2026 09:32:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5K6L-0004ht-QX
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 09:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5hvW4JtCt1N3bJ6rHuk+8bWjMiUxhCD5iwPpdTyrQvA=; b=fjQro5IyGob8yoRcsQmvWDbZ0B
 Ou0JpwlQveY88qDYu+NFHL1u/pvsY2GghEsTfdxDLbYw3B4qj1ksTxanTiN6yFuxdAvkPmqi8MKEz
 N0QPVRJFv4pnWnEfiUlS1oaxsDjKqxM3n2IKKToe6b+WC0dUoyOfZJfw2ZPaddBaM3/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5hvW4JtCt1N3bJ6rHuk+8bWjMiUxhCD5iwPpdTyrQvA=; b=l
 BFt6EVeMHyAfKqpspNhJyLmlvMh1I07ikwMbLNYBNBZ5FbDu6DQVobShX+3Kz4M/F7sfndv4QK1Ts
 OhLtEFOXfAo6M8RrefrDFUMtLa5gYecju1EqrziQ//fDvKqFuqHsReUkvWx6is8GOv6evLACdJljz
 KExfQXWGnCnxLfDk=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5K6K-0002KM-Kc for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 09:32:49 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so21601355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789205562; x=1789810362; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5hvW4JtCt1N3bJ6rHuk+8bWjMiUxhCD5iwPpdTyrQvA=;
 b=XiuPxS+RemnCQK95pamLYxe7OKQd2Bs8SWvipKP79COeCu3UbWfAEdYk2cxKftVgSX
 oT2SIsPP/voflNrhFCbddf1Ge0muzefcRUZd7dedEgC8hlMK0HpLd95R95owgavOsdLM
 ltPsATaBG/1WwsPfNASmfd7mXv3o73A0IDf8adCW8+d4IBG8t5cdhQH5WxY0qCf6gkn7
 YBoF0heL9tuLWHP3EBp2S2F7b9HNye8RKHCvI52tSfHeMfVnLe7cayrqz6i03eham4os
 ldKY+MUonl5vhWzKsy8O6nWdUIPsdEjEhuRp1QcLmEBFMV3H03BZvh17n9iR13S05bVE
 Bvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789205562; x=1789810362;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5hvW4JtCt1N3bJ6rHuk+8bWjMiUxhCD5iwPpdTyrQvA=;
 b=q3WLCnGZkUlbC8Gr5O71q2WkRdiGBAt9yYq5AK5MbSQ1FBRA0Ilp4RCTOYHNaa8cMi
 Qn3ZxZTvX/ITlRRwnMZwm2AcSv/93AFgwpCIzFI1M4YDbsfqVfssKXnMIDYKnAhlHxJv
 UPmWT6RZfNdCo5YY/gpefWVerAX8KwRgWpGIX3dhoJPtCL9Ol9wVFyMLNjwke2xaYQrm
 Lxu6IGar/KTQ+MV5bXVBdQrFMt5gvDS8W7bbReHkZ++svgySoBjdAJuSZ2rVIhoEKDKk
 6zX8XYcV7BjMvdts6n/Cg3BbnHM11p0mj9ad85caJc2VnumKg0lJxvKdFbky7HkZeoY2
 0/3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtNo1IY848XPWLwUlOqlWYE3lIjFU0ORS16CMBVACPu7PCgSkux0QwBBJ5Rg2zcDGW5MC6lgdmOsGxlkEh@lists.sourceforge.net
X-Gm-Message-State: AFuF++nyHndOFsnwnSVa/FQ08tOqhBwoWq6sprSBLSViKLz/l6NED7vX
 OvxljSi7ASc9BYrGMKeetExm3vyi5/sabx05v5SZCj2JiwAMm9tpTWPF/zw/gA/v+ILLt+dsCZ/
 r55IJLdU1SssYDt2NZD2jGVq7Znakxd5gj/VRHoH6QKFKl1KkproY02ml2WskYRIDJcp3
X-Gm-Gg: AYBFou0iGFyeN8j52c5360a9GnDaReVdmmzH50j1DIwbj+fUYdjN2YncEAWWd+1jFma
 AR6vab4/8+YrQN/n/+2vR7eitiZLV/tu5MK5/+wNV8AP290RhUPfWVErO0a+HyUGxOjazgieoyH
 Gd0oRAP23T/DO2JU6tiEaBtm+9ktKfC/JW3Y0hFmcrKq5E+lBt5mtFNk83R+71VLLiCRoxkkj/z
 jjY2HotXDi79tKP1rpLtEd05ZaC5MMe+rs/hQmKzeXqFigRrEwinN1CfRq4ZVjYdgV2NKXrGs0i
 qbOiR5tMTwBvhY4upZfEolNOGftPyRDsVmNpmzJb2O8oZa9k5G20FDdwCTuRuSHzhGNnGecLtIF
 kaFl8uYklEiGIOV75gOLiKWVVLR7jlz6WWUOUgfBfC7ybH3DhvrjIcLcmrcJ/7m6MiM2btMN56Z
 7SfuJctfglUgwJpAD4V4C/O3mwSfeHa1s8e30RIRBA38lOrPlkykD/Nqom9tr9wlsaaFKM/foP4
 +wAKGLUGacfatQBxyioXQdgwNtofdeW2ofnVF4e5Uri4ddoLiQEPGRLqdgd4wGYizce2eW09Bvb
 eufWnlfgdRhv8K9kr3xP29HGjW63XNvSDQp6keOiEzcPRBcafTCTHKC2Dr4hmHfcdDHQQuD5
X-Received: by 2002:a05:600c:4fd4:b0:49d:462:6eda with SMTP id
 5b1f17b1804b1-49e619d1ff0mr77549915e9.28.1789205561969; 
 Sat, 12 Sep 2026 02:32:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02e0bsm45053905e9.2.2026.09.12.02.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 02:32:41 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 09:32:40 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
X-Gerrit-Change-Number: 1911
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1911?usp=email>
X-Gerrit-Commit: d351ce40ac593ceeef48eda9b0bb676be8f157ed
X-Gerrit-Comment-Date: Sat, 12 Sep 2026 09:32:40 +0000
In-Reply-To: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
References: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkk2NWY4ODI2ZjM0MzgyMmM3NWU3ODlkOTE4ODFjOWRiYWM2NzY4ODBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab03e6abb6eee4a1171ba688bc818006c51ad30a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5K6K-0002KM-Kc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Update
 suppressions for current master
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
Content-Type: multipart/mixed; boundary="===============1735306434928945587=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1735306434928945587==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ycx0qWN6dDM="; charset=UTF-8

--Ycx0qWN6dDM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1911?usp=3Demail )

Change subject: cppcheck: Update =
suppressions for current master
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
Gerri=
t-Change-Number: 1911
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Sat, 12 Sep 2026 09:32:40 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--Ycx0qWN6dDM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail">change 1911=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65f8=
826f343822c75e789d91881c9dbac676880f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1911 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 12 Sep 2026 09:=
32:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--Ycx0qWN6dDM=--


--===============1735306434928945587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1735306434928945587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1735306434928945587==--


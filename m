Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE306C79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MvZdICG29/wwD41LbCrJfe8VaHR5pzpkL1fdrl2rRg=; b=A/8oSN4G6XValX+T41t0iX2x7y
	1/V7K7SAvrWCEy1lszVR8fbDgTcocNi4pi3+CJzWpV/8UpkySa/9tTC4NqRzRufDPseWdOrUSUIT6
	p7Uv/WvfPinuR3+Qlk1bCIzwJrPD2Bf+zNOeMmIFfdu6TGEjyg0m1eG7Z+FNqLRShkxI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4GjA-0002Ik-Ui;
	Wed, 09 Sep 2026 11:44:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Gj9-0002H7-Ci
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:44:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rkPh4nKGF1g1J2UyZxEZgsnjNYmMcsgUPpfqBZ6V2II=; b=DMYTw85QB+svptBUYlOLWMDUb4
 jFwZfpoucX5WjZ99uDPWt32wCdRT7eZatyCbadS4cZzj6NwVDEzd3NvLDXj3svaCqzMgACs/LcIsF
 +BSjI+Fjj4t4ucYrAB0FVHnpkFTQV3bcWEa31mm+83WHy1dQfO21jUcmcjfV+gQghNjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rkPh4nKGF1g1J2UyZxEZgsnjNYmMcsgUPpfqBZ6V2II=; b=i
 84NSQ0S80+0fyIOAD+9sTt+sF/YHLnk9UlDvnc3UE2A2p+7ioRNKBeOAB33XR6THYunF5tFDDWuHv
 K7a9NSpR1l9SeIK4M6eXm41At9vCuGOEjNJUyJ+4DHilDfwsc/avCJvJ0RIiJci+D2ihMlPurXTKJ
 KXxaf98SfdAeYq5w=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Gic-0000n3-Ee for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:59 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so45351185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788954232; x=1789559032; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rkPh4nKGF1g1J2UyZxEZgsnjNYmMcsgUPpfqBZ6V2II=;
 b=K320A+o3VygLVtvN3HYu7349oDwHfHwpiZ5gXp8T058b59n5JZCgOxKGsgtysyrWW5
 evxGEvH+/gpFE8X4mDwGegPuLfmN8fRIuBN4r/2vixv/mp6t532W6zNRe7xMeegKXK+N
 BF2HNF3lXZ1eg2Y5bMj84cAioHkV/wxe9oKzoaet0+anvS3u0sVj80uGXqm5MN5mxPuw
 AKO3N5iDRYZnlPTSRCmVtY1ZbIMG7HoIaK3MwwBUs5WRV1w3KNBFl7OyYG0rd3xQ17n1
 1pj6JwEDg/peL6Btvhpd47haFqjnw0fIPPWE6yN9evbJOpecprG17F93/r9zE1/oeIDe
 xu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954232; x=1789559032;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rkPh4nKGF1g1J2UyZxEZgsnjNYmMcsgUPpfqBZ6V2II=;
 b=GPJo8j7u+7iZ73Vz/dvHhax6gcCHOmim5U5KDoZ5TDib7qh9ToTEyWxYJW0OdfCuaT
 ZmHSn3y8a4yMSBIiW/7mL1K/7CMQDVMT91Mqsyu04UrvFeQv9b++LQ8u0bfOPTltg/VO
 1KjA6gtPVZmgV2PYaQFCjPWlRvElYC54WMWBJQi6UMoYepZV4So2ntRjHNR6HbwFelro
 f/6/V0uE4iAwvOfbxmp82m3QA5VyvfTfI3yaGrqpwnylGdHPp52ATDh8j1ZciEUV4tuH
 Jtapd9HTDvJq98TpZjqohWJtkssfurpyE+moRL0SB2TCybYiUtTl/HdTjmKCatLeBc/K
 od6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJNth5ymcLNsXHJB5h6vE03Z4MCWfkknLUTN00mjC/FfESt0XpWDyX9gzB/nuLZaq7C84DuVLVetl2MgyH@lists.sourceforge.net
X-Gm-Message-State: AFuF++mSrkNPuSlO2qIUlO0p8yget3mvwzfl0yyg7NkTFiDEJx7A9hhv
 GWZp7w8Ow9wXaPYkxsE0FppOOaRqJYAm8+cKV+CGUL3UNrvvPzcn92af8QEQb1ChsPNvPlE13Np
 P60hVk2eSlo8upfHhbzqIS90pFBk5N5EA87sEl3N1093xdXe/mKO/tSElYa2M7e/C0CQX
X-Gm-Gg: AYBFou3uNZeuR1tGzt27nBCspi7gqsyNrKG6X9C901ur2yRKgGo6q9vNbFLUoUkEFMK
 2fSHXf+cj/Aqy6mO1ujkQ4c7v+A/SHxZJbb/e8kuZztdNdrj+HQyZbiUQbc9IYqmBqEbfa4HI8t
 wo/zfevBs9TSNJkpQEVJFmmzPgD9GUlK+uw8XbQg5YJ7pLlSALiTzEYEfB3H+FQa20N7p1JUb8c
 RvAJQX2d7jEijOEYn0/pdoUqSpOrlQWx+sytuRX5qp+2qB51pN17zeZA6EK+gb8e6bbCUVkDFF1
 ae86Nw3ssI7FSXIkhfwr4ZzJywmKGi13IXjvAVwYMex+NdmzroMRXKDMohCAnrveVkkh7AXBGMO
 GRPFWBmdj2fXfb3s4jJdzYq3o8rn2v1u038hxZmkeA8aFIFKDB6jStKWb0bBI+PKejLRlcM9aAE
 61W1DhfGPNNG1wVkl2hm7S8mIg7+AhWdqmc3ML/UC4Bs0bo5uMpZbNDC2ThMUGp82wy40xjkMHv
 8u+AsXtDQc09ccyksoh1RdcQwm9K0ZbIr4H6szcDlDonTTP85gI7Zv5vPkFHJs3j008pCIuLom4
 5yy7eqjiMPNDyrcESE8/xCM/x5n9SPleDooxJNReGSfw9AExg5EB+SAptXyHD2Aa4ss8OeRNyg=
 =
X-Received: by 2002:a05:600c:3ba5:b0:49c:dada:f581 with SMTP id
 5b1f17b1804b1-49cf7f39c8bmr427851985e9.0.1788954227106; 
 Wed, 09 Sep 2026 04:43:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48591eb3d3bsm28905257f8f.0.2026.09.09.04.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:43:46 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 11:43:45 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 8cf9b7955aa320f7fb32dd205689c8c577bf4b43
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 11:43:45 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ab3550a873c18c79236fac25e4cfd3ca66c5f7d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Gic-0000n3-Ee
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2018444540999607380=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2018444540999607380==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VF/khhCeFvA="; charset=UTF-8

--VF/khhCeFvA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER=
_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: Code-Review+1


-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c=
2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 13
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-A=
ttention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 20=
26 11:43:45 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--VF/khhCeFvA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">cha=
nge 1742</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Comment-Date: Wed, 09 Sep 2026 11:43:45 +0000 </div>
<div style=3D"dis=
play:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: Yes </div>

</body></html>
--VF/khhCeFvA=--


--===============2018444540999607380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2018444540999607380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2018444540999607380==--


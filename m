Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6622C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SIG5s8L1wWQfn3xv5mCiQ+f5vZyCeBIaeNQPybbe9B8=; b=aFn7/ytKfsEpmS2iIdMJTjfQep
	a4rlwdQI0bMT6PKnbvveTyIEkBvoQQLeamSuqEv3/QvcQsOPCe3NnZsGhZ4ThWkPMfg0e/IkCkLaG
	p5dP67JsaKkSLJnBgb6tMu1YsOR9zCqpSry8aIgQz4XiM1wAo3amrap3fHbRnl4+hM1M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxKMN-0007s3-2x;
	Fri, 21 Aug 2026 08:12:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxKMD-0007qr-0u
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 08:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bw6Lo3sSighXSRXQRRYtFJwTBDxG37HqPenUPylaj2w=; b=Y86HhXqRtzMQTrVL4xgRYPybMR
 FbfSr9rwjSYgDVwbLgudsL+fgXn/lYwuix//W1EK5g7mC30P6kANwIQfJLmzPvmsjSubo8NYvIJnw
 viR9tJbwVK5nt8kVdmac2T24GZbDPfggv6fSJaKJDydVcDxEBAvFCjPhVI0IHXik0Z9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bw6Lo3sSighXSRXQRRYtFJwTBDxG37HqPenUPylaj2w=; b=m
 QhxN4cCAI7TapIpQ+OIdPeBjCSHS4seftASP2rXHmr8Ln8/r35tgHzpVlm0am0q5W7ILiUd8trLeB
 W3VohK/mnMfo2OmC2Pcfcm5GJ+rSbdTXTD4KINYhjJcKPdKF7VbEbqc9fjB3Q0RzLSkcaysenboPp
 WM8gCW5lHSIEyInQ=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxKM9-00029U-L3 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 08:12:09 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so1602446a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787299919; x=1787904719; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bw6Lo3sSighXSRXQRRYtFJwTBDxG37HqPenUPylaj2w=;
 b=Wp0dMssdGRbSasWD+DQ5CUZ9FZBgxO+R93Cwj3JXKzl6iDMiBFBlC842zjdt40mrAW
 cDU++HdSpfj4JDihA+3dKeVNPzWMEV4oOD5m9hZo78u5SoisLsO3Fr/XME6yO8gpgXLP
 7GhvwvHRrNyzljMMpD/zqEBS/aldc79iLZ1w89ZtTPk8Gb6gPLwZJXwqvy1TGcDTuoJT
 1AvVYMAS5QcuG9Ra2BrNpySbDg2oiP2y9GkwdPufawhFc+YqWQm++1od7UN8o0dWVbXZ
 UhHON3Bz4wZ1UO7HrgAEbJfot8gibkkmoiJOL3+mkWdiSzRRkfH/7e7ohGIc9CqlQD20
 zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787299919; x=1787904719;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bw6Lo3sSighXSRXQRRYtFJwTBDxG37HqPenUPylaj2w=;
 b=BfmekmdUAM0n0bcTMbhsf5rJQXqc/bYOKeKWT2ssHvol2U5hj/mTT++/hbb61NhyGn
 gDal+mZ5eTVXYEhwO/5sp1VQqFyoSv+hM8wLEpe41TV4huioYi1hhsDuhOmf7u3+yQ8S
 WT/4n+wQdIpgtY5R8OPvGJqg5u4kybmevLBQt6MARibqEtZpmBWNMi+p3Xjh3xSTdO74
 kG24xIZSD8dOCVSerkQF6GC76MwD52owuq8dpuY419ZlmFkWi6g1elG1I4037GSH4O3M
 1oCr0NfMM7DlcRr6JDQRGiY0TisibSJz+d5HqWZa84v4Y/riB3jH6a9iuIyQvqXpjMCi
 EIVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWTyzE4d6XS5JbW3yKGNr6eImQOcd/Asr7H+OlpAc4q0xAdVSdwzGBBduYrySnfQcAn9cUfD1JT6Yhpqb3@lists.sourceforge.net
X-Gm-Message-State: AFuF++mVy7PM2cDQL8h2kMoKAYZ6kRaC2sbRrPKCDFUbO95DUbqvq8Jc
 3vfA1MjYJTBEv2gmGJanTcAHCi9TEdk/NCzXDKu/XrSEPvFqvbFnm2qBT+hvQlZVXhjaqc9CIRl
 soJGG42xOdAx0ZMEhbS0YV8MWm5fWQ8WSo5/AkOZVKKQxIBvL0ygvp0SCys6bd6V5BJtU
X-Gm-Gg: AR+sD11blr3Hfk+nWtwtrBdx9bQeeLgKKhha/FQVyNjpJB1UenNHPugp+pwB6prKHww
 1zz0rRTIWz/dSvgP/kutrZu3zNaq31mLXx7oeEel/Y26jG4HWDZ4kRsc9myOjRkPflM0U/kZBya
 QOthemLCcBcJCQl2jsELkDKUaar8tUO0Dz25RNHaXbkWuMerEaBp91YCImA02q8NCSJglDLCa8n
 MjXG3XIaOP3O28MmNB9vyFkR82N5o3qEzIxIBUzoj4iQfBbB+00yyrJtAMcCtOIeObUHlF5Rv9H
 oY3KmHyj2ylm+21aGLL2JWasOYgMavLlLITZOSbQaaPRBTXEq0KCeWDdImQVSjod9JyAldI3a8U
 TTt2Am+sTtqjwf1gem4gzoiWnLrjo2LPNFEbXUxbkEEDLv9AFVVAsspphvqxUobd0oK/28NXq3h
 zLO0pUsdAh0GJ5TvyfdyCUbmLPUjK07IwszE17zPu3iJGj0h9dRV3fTVU40oV5gI1GebmpI0oIR
 huF/h81AtMdH2M1Qgz6P1a8lvwV64LEFgt1MgYK0N5A7o25xqOxBasCDmFVV7LpAVPZuom2BT2N
 qS9a7n2sNzZ9H1WxJy0rzTplxJqTRHRDrK68dizHl2yrYBEEtZE=
X-Received: by 2002:a17:906:5152:10b0:c21:757:1bb4 with SMTP id
 a640c23a62f3a-c246a6d03e2mr367644566b.16.1787299918900; 
 Fri, 21 Aug 2026 01:11:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459197cc9sm359349766b.31.2026.08.21.01.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:11:57 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 08:11:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
X-Gerrit-Change-Number: 1476
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1476?usp=email>
X-Gerrit-Commit: dd05183025e196bede588b71b71b82807484f202
X-Gerrit-Comment-Date: Fri, 21 Aug 2026 08:11:54 +0000
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4NTc4OTk0MDAwLkk3YmU3NDI3NDgwZDM1NDBkNDNkZDgxOGVkZGI2ZWI1ODYwOTU2NDU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <550bcb183eccf9370e1cb85764ee29e010226460-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxKM9-00029U-L3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Fix various
 conversion warnings
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
Content-Type: multipart/mixed; boundary="===============6832544633501430247=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6832544633501430247==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GR1veto/PB8="; charset=UTF-8

--GR1veto/PB8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1476?usp=3Demail )

Change subject: socket: Fix vario=
us conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 9:

(2 comments)

File src/openvpn/options=2Ec:

http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476/comment/fcd0ba0e_871fb010?usp=3D=
email :
PS9, Line 6540:         if (strlen(p[1]) <=3D IFNAMSIZ)
This is an =
off-by-one issue=2E

Linux uses `IFNAMSIZ` as the total length for these bu=
ffers (e=2Eg=2E `char ifr_name[IFNAMSIZ];  /* Interface name */`), which me=
ans that includes the `NUL` terminator=2E

I believe we want `<` here (inst=
ead of `<=3D`)=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476/comment/=
0e07805a_1b855ae7?usp=3Demail :
PS9, Line 6546:             msg(msglevel, "=
argument to --bind-dev is longer than allowed %u", IFNAMSIZ);
`IFNAMSIZ - 1=
`



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be7427480d3540=
d43dd818eddb6eb5860956459
Gerrit-Change-Number: 1476
Gerrit-PatchSet: 9
Ger=
rit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Fri, 21 Aug 2026 08:11:54 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No

--GR1veto/PB8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1476/comment/fcd0ba0e_871fb010?usp=3Demail">Patch Set #9, Line 6540=
:</a> <code style=3D"font-family:monospace,monospace">        if (strlen(p[=
1]) &lt;=3D IFNAMSIZ)</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This is an off-by-one issue=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Linux u=
ses `IFNAMSIZ` as the total length for these buffers (e=2Eg=2E `char ifr_na=
me[IFNAMSIZ];  /* Interface name */`), which means that includes the `NUL` =
terminator=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I believe we want `&lt;` here (instead of `&lt;=3D`)=2E</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476/commen=
t/0e07805a_1b855ae7?usp=3Demail">Patch Set #9, Line 6546:</a> <code style=
=3D"font-family:monospace,monospace">            msg(msglevel, &quot;argume=
nt to --bind-dev is longer than allowed %u&quot;, IFNAMSIZ);</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`IF=
NAMSIZ - 1`</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">change 1476</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be7427480d3540d4=
3dd818eddb6eb5860956459 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1476 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 21 Aug 2026 0=
8:11:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></h=
tml>
--GR1veto/PB8=--


--===============6832544633501430247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6832544633501430247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6832544633501430247==--


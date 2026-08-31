Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C5DC61DD3
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gveSKmx/GISjjDhmlWKsVlEu9V0/1HGQFkCz8Y1WFmE=; b=BAHt10ORhCJ6pvz5JGLhGDbiVE
	1vwTNILnasl2aL4HuHAAuDTIwNmgLzUdRBc189incj7kszq2XXn/MgCdaZVrmZe5C5AM3iGD5jObz
	MrO8gek012YV1UQ+VgV3CIStmTIaUbnPUHbfwdnnlgpmziEspordffQcbwtnLj2jAFv0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x15Yy-0007u3-Dx;
	Mon, 31 Aug 2026 17:12:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x15Yx-0007tx-1b
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qiXKRDsdYrtoH3mOsnUoKsv1vWDG1Gg3Al2v8trpIt4=; b=ByrF9teVcgtn2yOWVlvV7CBrOz
 dCGiku3VtTeF8VnB6La40unNDQNDwhjGZj8YGvfBD1/NmqHeBcq1u8x0lgbohYRHlxsXF3BqqoHPx
 QqlsGpne9Dor5+k8WNFxYWJFyC2nD+JdRfd8B5oqW2aDKFe6E2nxTdefhbckm7nFwUbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qiXKRDsdYrtoH3mOsnUoKsv1vWDG1Gg3Al2v8trpIt4=; b=m
 hUSwiLYTPa141SfdsCHJkAbTi0NR+H5vFWFbqD8wLnhlaKTP6MH0kf/sAm1fpDb4n7To70T7zSoWf
 hlFbHOrWQ24be9Jewf9/L+MyFvOG4wcCIW8ZLBxuuP8mLnEceVExYObvdCG4nKEIciKbKcYVanJoQ
 3dxq0Jsg6uoFxxKc=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Yv-0001ZO-WA for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:12:51 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482e5733a5aso2218405f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788196363; x=1788801163; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qiXKRDsdYrtoH3mOsnUoKsv1vWDG1Gg3Al2v8trpIt4=;
 b=SgCvQ3ikAiJYxcvrLMdf+La5QXiMpR2WpKFOHeqDp4TjtjFzS4H4ZFpmtVebuv4vN1
 zM0xNMaBnNiLNUesItNpp+4I8q0buLr6rduQ83rvjFkTtqMUiMkJt+T+SJ3D8emA/f8K
 Do/Key81IdpfJa1feVfSZ7UZldGTTtKQd1wSDlhmwQgHeawzgtl+NIZnSSuraLIeZ9oM
 hLVPW+K5qoDKm+9Y9JTR9z6vo9RM7dbJx8r2S5ujuZ4r4eb3y/45FWRYumq14bbRqosw
 iZQIu+cDrxRz3QpSoXjSicW0YUZCpSED/gWlRCqGK1ICcC5serM9ja+VOH+6TOWsQV2r
 8Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788196363; x=1788801163;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qiXKRDsdYrtoH3mOsnUoKsv1vWDG1Gg3Al2v8trpIt4=;
 b=FBNpdl2AVKFDFLMLFDSz3qgSf1d+hyhSy3DfvxqBB8R7cQBzDXHePpxtYYezh6Wrnd
 ud6yKyF2XY+zp61jDRpFg/DpMGvUXcUBBtLsnjjA6ObQI6ExLEeTccqvLbupVceWSXXT
 st/RR+O7NuD7feOG7RAk4zuwVcCOdyVunzK6F5K6nCLWeYdHJ89nbzKjfWlwzxrTnYYk
 j1g1m8eR7y5ljFKiFlGsHIsi0scEHdnfXQCFHVZOe2SzlS3T0WEKKTJP69nprYu3DjQh
 YFlkvPUU0sXGZdFdDsQk9LxpVxhYbssj+S82WbxSJj826+bWn4mU1KnyTuqanVQ7y6PQ
 xWuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwILpPvuv1ITu7Gd4nuvvaXoRd0wAMAmS/98CxM60wFYUMG0Ij1EKz4MkcX1qj4Fh+mx+JltayXZFcPpa26@lists.sourceforge.net
X-Gm-Message-State: AFuF++mxEOmFlgoo5kKLuMy/wt80mvNUC4dzL5q26Do7dfZomBLX6PxD
 H8Forcnsxe3DCJtRcd6M31dYqOFJCLYJ6+rXCAvDvE5I/cFNmX6NeBM0Q+/54PCvfmBvbCIfkdq
 mG9TGevhFOf0pdMrDKci5B0PGUhmkWG8jbBzu0VQi62G+BFYnX95ITn5dSnJaT+F4+htE
X-Gm-Gg: AYBFou3ESwTbbewolLTx0UlvTYKaTcdl1Er9iXUBKEaVebS/O7Jvk14uWJP5U1FlKp7
 nG2V8wpC08hleVwxYvT5/QWWwyL5bO4z3WpBKVCbBbNY+NcL7BPYUAuNJRTAEDMtGRu2LaGa2HF
 NNz0vdRQTdbnlLMeKrMBwjxRm+ZZi9PCPTR9vPObHhX6RatYA1yNa7az+aEqA9STtLUJ0J56D1f
 MVeWkBKEtSj4iSM8tVkMve0mPDA0s8l40reYBG8O2eK9gC4wKbBGQIb7CEN47i7ymi0HByPKlEg
 k2cKnTEDG8Tim0wBN0Ohjf/OsIcbxFSxP3vZ5wcWtyZKnWRMqhD8aqbQTS/PGCoWz45OQuhQdHp
 IvwXoeEb2F6EnnnQzA3qhYqzLdd5EgbF/4TPU1ryRciQeViKLQwT3KTVNL5txNgHLOCCjIlkF4h
 cUofGCrdUUO7VQ6ZfgcMA+fh4Vj6utMA4DJwhle8qm573NA6p97F4hjlUUGDiM0k5ExakpgDZQs
 +1JPvW1LPXSxmkEUj3s7X95Xhm0V1gaxgZrtPnupmwzCVu4/ZTmesmLPdqDYN7mZjc7wkR0fbYw
 NkTq9NRwpV3SmmMrZIf3SzkX+9l47QrgiqQ/O4aMDqUthIsL3/hpjpbin2n0GRQ=
X-Received: by 2002:a05:6000:46c8:b0:482:ea08:8c97 with SMTP id
 ffacd0b85a97d-48440fa3a79mr3428202f8f.2.1788196363326; 
 Mon, 31 Aug 2026 10:12:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48432022ab8sm16984252f8f.28.2026.08.31.10.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 10:12:42 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 17:12:40 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1886
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1886?usp=email>
X-Gerrit-Commit: d1e87a4b4ec6a953063ff9be501595571c17d921
X-Gerrit-Comment-Date: Mon, 31 Aug 2026 17:12:40 +0000
In-Reply-To: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d2c746515bb4d0666d9af705c0bb1103e51362f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x15Yv-0001ZO-WA
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: harden
 CheckConfigPath() a bit more
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3708274895741400394=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3708274895741400394==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7cUAOszRxLI="; charset=UTF-8

--7cUAOszRxLI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1886?usp=3Demail )

Change subject: openvpnserv: harden Chec=
kConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
Gerrit-Chan=
ge-Number: 1886
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Ene=
t>
Gerrit-Comment-Date: Mon, 31 Aug 2026 17:12:40 +0000
Gerrit-HasComments:=
 No
Gerrit-Has-Labels: Yes

--7cUAOszRxLI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail">change 1886=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic983=
a3bf1ee8d4ef98f3883d5e5ddf234696a182 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1886 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12f=
k &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Aug=
 2026 17:12:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--7cUAOszRxLI=--


--===============3708274895741400394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3708274895741400394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3708274895741400394==--


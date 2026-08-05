Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE232C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/QD5jIPryTK9i8wq0eqyd1/o8vevOF/M8Hy8OUNeBs=; b=EIe43PSsDnN3SKepQmh85a5gFw
	a1LlAWJGkXeX9QhI9W2s/8gNkpoBdGFXnzF4mqJ+ZM354iW2vOcx8lq73qzM7Zl08WqYmInJE8mqU
	CH9ExYpnUQanqDt+CwCejGJJlbmWixTGfqsea7v4phq7y8f5JAHzMRj+prtFSHKZ4brc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrgsp-0000N7-1m;
	Wed, 05 Aug 2026 19:02:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrgsm-0000N0-Sg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Fz7qUSNBFmSm8Sb/b0l8uGmxegMJcXybrWug4An5ht0=; b=NhjbdHwNHy0fTqEjVkY92p74aH
 X0k4G97NDusOo25lO0WRhWKSVAYMKZ/2TXuTekju9J2MvPlwyvNXzb0NFlnYHIr9R0pJzc1W2uj5X
 ZMNaj0FdfDROGiM5RL30YWB+rUA7bpb+vojFZNEruriwMqPLVmYImML2LubUjv1UYaRw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Fz7qUSNBFmSm8Sb/b0l8uGmxegMJcXybrWug4An5ht0=; b=B
 Ct+FVfSHK3fhUVaR2I1tjTM306RgxYVbb6PUzOmNOqt1bejzlC4L9643se3EWCTHQOKkbQDj4pwSO
 LlRcTVE5mOeIVE04PB9IGFt1PtKv5tvEGAm1nQeTvvHgoleGWUFi/I71q/+wb+konxQBczI5d9sDX
 oWa4HYo0Gh8z3/rw=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrgsk-0003th-R3 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:02:28 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so892057f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785956540; x=1786561340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fz7qUSNBFmSm8Sb/b0l8uGmxegMJcXybrWug4An5ht0=;
 b=aaVixt9XodhQMPHH0xjb51kc37bBiTLuRudtYpt4PfF2eArhvD3MfVH5n8szM6pPxU
 239KPucPxScCX4rvtaTwRZqEmEF5yRtoe2s7Q51MOBoZdeY2eFaGO/A4JnLnMjF8ayCg
 pJDfS2Grvyg7THPjMW3anAIneFavcsPNgHNErrcf2ixpoE+u5Ck/yxsmG7RNs4ciYme5
 kScQ2JhsfRTinO8Zy5bcRpKR198M/Ov6rBILt6s0NGZFbzo2mgpsrR4LEdThYrvPHSes
 2voC53FE4M4LbAQpmB41fKROg/MyHnvKhuTnc8Nn0gApC0hFes1tJwP9uzEjF+Ozw6j4
 BvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785956540; x=1786561340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fz7qUSNBFmSm8Sb/b0l8uGmxegMJcXybrWug4An5ht0=;
 b=Y76Odbdnyu6jsIzuVle6GlJFILnxjiEXPcOQUKz0shmdqSNcetEsxaCrqv/8Jfa/6l
 Fv3kMSrEsktbPRYpVCwMtRyI4lyCc9jkHhgI52rxycLZDtsnWvuUHnVHxLPS+fZKaFXw
 GWqCMNKKyudJevsJS1I31pyyEsQ84UIopCDLaBd3coGCra30fvYD5aGX/V9BnGrY0ytn
 X116VBOg94UqEiBkw4E3Tonp6wLtrhdUYpEQvXDFZdxiKxFrETj3lGq8eRBhe9aGRZNg
 rJjqynMVibVRaXW+lGTslZr5UC2s6a7XE86l7V6ZrVzPnr+/mY4Qhbm5u+/gVpDGpdeC
 aAZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvihJi72DfP1VXqVGOj+3s6FrXEIPtthSUGtwnDetIRg2a9qlMvTTupD7GGu4QJehweZHSR6jEx8vP+JDF@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy2n1vndGswwKiMhQDO/pmibHLHkfJMKEbxuLo53dvqo0QwRHjf
 N35YV1Nx8RoOP//+Ps2ZAogw6uyMFzQ2JqWHmtGy8kFXb/r2L5AaCYLhr2J2YclP+yTS2RHJBaH
 K1jkOusreCus9laE3/BDq/+piXi59Zei6FJ4qA3h8QBv8ByG/87dFGiFgliL5QQwoyDQ/MabyLB
 p1x/YJ+Q==
X-Gm-Gg: AR+sD13muDsp40k/T1MS900H1GKVCBevZ+BjpsOZtbT6RDKLKeopqvctrfG+CBfRcu8
 M2q5cU1R+zAFA9BMkDKfAUhYASjk2vN2E164muFNw4RCqY49NijRLL9BvUhU4+FOWu6thDpN2IQ
 zdbWvNi/G0hjpoMTshqqyw+7WsjrvF+u+/fM+n8Ww8V37+tCi6NWLzaHdD2WunZ0bjRmYwk578a
 Dkego6RhM20GXxm+LUKZMhm3KpnLL7ARI3SQVS50/yVfEAioEK59i8u8X+w7q/use6iQMm255og
 UTVkadWCGGboamou2z6KzTfgJqs/gy1ZMkzli6cwaIBH4er4+X+sfKitwoROA69WouZs21YChB+
 Zygth2hdBf/PUFLieK1wFK6YXCNH+CaZSX+84Qu3vRUW1j18YMis6sIaOnHf1CF2jDwutbaBnOG
 3NiUkWaqHjOqJkb0IxBDSbtAPftdamEcENPFeclU9XtIXyARNc9K1Fw/PlBfbJweBj2WBJEmeWK
 lobkTeypowc6kpD4DB8pKwaUe0DkYu141RSFIg0RBWJ1ekSJHwLSaUU3No9Z+5roKWnwpGU9nvg
 aNHXwY4r8r15tw/C2T2cG1Lrb+/CTP/wNVcCCqRyZzBVMBOI4LA=
X-Received: by 2002:a5d:5f45:0:b0:47f:97bf:d891 with SMTP id
 ffacd0b85a97d-47fec50970cmr14974459f8f.1.1785956539993; 
 Wed, 05 Aug 2026 12:02:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec232328sm11469777f8f.24.2026.08.05.12.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:02:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 19:02:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 0b8d09de0d5aafe99201f1ad7c26fe95d102f519
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 19:02:15 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d6e4a5c8a1155824768c254773068f0a683406b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrgsk-0003th-R3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
Content-Type: multipart/mixed; boundary="===============8711738597252615422=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8711738597252615422==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vdGel6vBxAo="; charset=UTF-8

--vdGel6vBxAo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 4:

(2 comments)

File tests/unit_tests/openvpn/te=
st_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/e61393e=
2_992f11b5?usp=3Demail :
PS4, Line 440:     rand_bytes(key, sizeof(key));
>=
 should also use siphash_key_init?
Done


http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1827/comment/d86fc94f_25937d66?usp=3Demail :
PS4, Line 522:     ra=
nd_bytes(key, sizeof(key));
> should also use siphash_key_init?
Done



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23e=
abf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 4
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Comment-Date: Wed, 05 Aug 2026 19:02:15 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2E=
com>

--vdGel6vBxAo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1827/comment/e61393e2_992f11b5?usp=3Demail">Patch Set #4, Line 4=
40:</a> <code style=3D"font-family:monospace,monospace">    rand_bytes(key,=
 sizeof(key));</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">should also use siphash_key_init?</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1827/comment/d86fc94f_25937d66?usp=3Demail">Patch Set #4, Line 522:=
</a> <code style=3D"font-family:monospace,monospace">    rand_bytes(key, si=
zeof(key));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">should also use siphash_key_init?</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">change 1827</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49=
981bc23eabf04fe8e06d6fc3 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Wed, 05 Aug 2026 19:02:15 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--vdGel6vBxAo=--


--===============8711738597252615422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8711738597252615422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8711738597252615422==--


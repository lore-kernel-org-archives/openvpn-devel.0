Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51F8C5DF88
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAJyM2jMpMvGX9Mh14KuSk8QN+OzvLLCs+9uPM81AeQ=; b=KraUsgR8DnuF3D7zfJQ3HP/V7C
	RaPB2BtgUr2+u3Q0v8F2wKHeC0zlwsEWBkR1/8La2Dz0qyS+A5Vfv+DdSbzwfvA8fEWQFnEDTEb3I
	JatqlLhFc4Iw0z7u5AhtDJOo4JYyjbkHGm+E+vEG34yyPkT+kioVRghnYF1+vtjX5SFs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiQL-0003sO-Vz;
	Wed, 19 Aug 2026 15:41:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiQK-0003sH-SU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EYSh6MsdTTgg/Y7O7OIkM+aORI5cD1DtvxPcDEXF0SY=; b=cR03dxiAGlbwMO/Lre03zohEnD
 NTmQ6fa7f/Gpq2mBw7t90m0Gk0UvVw36nXBPo0V0St/XD5OuIH62qB6YgBCUo99tbKSQHvIruU/bU
 aBNYueOjZsMX106bEGkG+NQfTmj5ndpEZRnQHA+jLGzxdyU90sec8WLgkpCqWUpV8kwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EYSh6MsdTTgg/Y7O7OIkM+aORI5cD1DtvxPcDEXF0SY=; b=J
 V2sHWehvbkRtMS7pn5L7ZEZwndWVz7Vb9fCM4OTlIQJw87r4VXj+sl93PkOmytlXq7an9FKVOZ2NI
 ytCFkIAnHa6d0VIpnuIYxbxhKJXNRD0/Qsz+IzUWinlqoquLirw5C+Pu31pv7E6etv0g1n4YMDHbX
 n+eMS2jhCM5plZhA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiQJ-0007tJ-F8 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:41:52 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1080639f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154105; x=1787758905; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EYSh6MsdTTgg/Y7O7OIkM+aORI5cD1DtvxPcDEXF0SY=;
 b=fnAoZCpZj+ugMPxB2Dd0wgZADPHxFUQxfqhafBEK37IHPxHMv+GnhP20WRUuqtjlV/
 yjahwKnnkfwBLF3XKX8nyaBuiqV44Z2xZFFMGGeYxxLdSl5DhaW0uAMFHmVMnmcZlkbu
 2BTYxjuHIpgtbcpnpSllvAwqSY6SQ0sev30dGXzz18DPmEJxI2lVwjE1I3LFdZKOGntA
 vshPyGVHcyxUpxhuSy8BeNjnMda9qJJi+9iZRAqpDgkERVALIKIB9xhGMQ/p0X/Jg1K4
 WYDDlgtWLlyYIaBy123mMCgAtB2ITZABx53TadAmkj3VRn0Hr4Zl7oYQOjuiMXenqtJB
 4vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154105; x=1787758905;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EYSh6MsdTTgg/Y7O7OIkM+aORI5cD1DtvxPcDEXF0SY=;
 b=alxynRnuihU1lKieGM9zT4A5MhWueC9idMZEdPaXwJD8+SDNcbP96hdOOVXPbm8uid
 3H7vnZSxn3MWlhqlJKBzI44ImqxYY8CC9kAJsW1m7blLlfnp5FfY+nIrR0R+v68CvlzE
 nuGnvtaHrXx9IttmyqNezd7ldMLNVFcKFoY8kg1bFU2yH8rr8v3g7f5mhR1U/8aHSGO0
 6rIjtNkjb68gevDC24mMKAQAM4lsCFf00+m+x6rv8LqH+4MbriiAVsTEpd76i4TGExcG
 EaIl9w7z1BJfmKiitt6PXdY9csajoW5BvOfAxM+dXBe+RfBzrIgC6VCCQflQ8PYas2LW
 ovYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZ9Z30fO08ivBomUNtzd4gaVbtjX9nMhn4P1l20buddb7zEQjZKeKOQnuaryP+021RqFEaIodpGcDLzYmi@lists.sourceforge.net
X-Gm-Message-State: AFuF++ksf7VOtL7ZetAJVy+fy0vwNzvVNFEP+iiBGHD/gosN45Y8f9MG
 Wn24gkpI4Yc9tmOrpHJfWz+b6nSArQ6fQ/FR7bQRj9DzPCFWx6dcgHDaG8nwTzzPQqiMwNDky6a
 QTQIA+blfWmv2fMPHxCG9RANEI3/LFjyQrn6v9C8w8OSYyKrkW8AQA1MValldVRHSGfSy6x4Dw1
 A/x+yazg==
X-Gm-Gg: AR+sD13pSn5e3mWubiufi7NAbiCfYKXwjzH0zCVxUt/NNxWEi3Y37n14ztzr/DcHZTJ
 vxN2rej/d/KeEb5ZNBj8ah7kVJfotqRDw2Uie+47QaryOIw23VKhuljdQq/TmeaSE62rXWjSy1m
 E70WTIDoEq92IaHyil3Vf9SRbP5+8nRkx+kL9A4bsuzs3MXLZ3iDb3jaKDx8ujWoFEvDA4LJhuC
 9WXcOBr/WIPuKx98aVVFCe8SW+cbE3Sbl4LAp/N1vvU2YzDbL9WVQ7H+gXpgkWTEQaZsNi55MZQ
 Ns4TCvwmNmThKx2ZgJftEeva7zW50AT1J3IbIFJf5fx/58af/EOE8nF1jv2CqStm5d0OrOPK5BD
 fjvmycW90oK3/hz2gGo1Iqsc6vhpsxA5/JxO4pW9gSDa+tnUYg8NXxjXoIt0t0X/ay5k2B7zr07
 Y2sy6GnmksPMeysm1CpsaZpst9P5SlJqsHVPrsLdpj8wQEYMQpgRCMyyo6frNeZzzS+fcDE+B1R
 J9hpAw/CYBeQJWtLClTPBe3NuZ/vXshi58wcna/gr5EM+TScf5hoqn6lVE5MhfLaIvcAjzoB65k
 n1QrtuZ05U83b1ujjfn4BVltRlW6Stw+wviGJQFanfSJXN8Oqr0Tbj6ZxDbdsg==
X-Received: by 2002:a05:600c:4e04:b0:499:8ed2:8234 with SMTP id
 5b1f17b1804b1-499aa0e221fmr135164045e9.0.1787153618606; 
 Wed, 19 Aug 2026 08:33:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9aa3204sm48647975e9.0.2026.08.19.08.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:33:38 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:33:35 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 46a9953a30d82673ae9841cb050117d2d41048fb
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:33:35 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f9ec9e251f4825ce73b38b80aefa1748624aacb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiQJ-0007tJ-F8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
Content-Type: multipart/mixed; boundary="===============7065140575134827627=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7065140575134827627==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dy8intXb+qY="; charset=UTF-8

--Dy8intXb+qY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables =
that shadow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: Code-Review+2


-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa=
2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15:33:35 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--Dy8intXb+qY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 15:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">change 161=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528=
f5fd200d877841e473e5e05b7ac7915fa2e33 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1618 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:=
33:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--Dy8intXb+qY=--


--===============7065140575134827627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7065140575134827627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7065140575134827627==--


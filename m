Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A392C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/YrIMu9a/24KvkWJm/OVwgmjLLSZ54MQlE492/EeVO0=; b=XkgD/XtkcKyFMAV/PEzz2k0l+Q
	vQi419Fr2SyZV6NRK/4T/4PoAI2SF36THHO6zc7w09HiFGa3sinJxNjHvrr1VkJAWprKqd7JtrmMj
	LQeZdYQrpjlDO1o/SA5c3ZmXsmQunT3QcK4LOOmSfsLgclW/KNn924tC/fHZ4biWZLqw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrhAh-00086n-Sk;
	Wed, 05 Aug 2026 19:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrhAg-00086f-Ea
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cd+VPOTXre9Wkfp+DQuY03HKVp5Cc2GqEmAuOAwStDY=; b=lOjjc1ATtMzrHgpg3bsMw7xrOB
 D3GKFsJfTdp0dy2nnS3jDBunnrMiaobCP1Qnqwczq0+pBecY0lwt1eikoJfkszEmaXvqN9HTSeQb2
 v/z8ED/zBt2246zwu15s4kLoRd0SucUYbt8vZItKiWTJXWdOwijYIIu0NZlHnGmnksaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cd+VPOTXre9Wkfp+DQuY03HKVp5Cc2GqEmAuOAwStDY=; b=k
 +9CfxWe/3y6qdFlHOv/7gMJE8mw7/iusYJsfw4XPKF5DC/7ZwtgEi0c9xGt+NTrBsBXTowiUFP8B1
 FXHswf1cJfl1fM6qdAbQe44ZMlxSkK1pTv6W3NOykEb1MD1c6Sp4DlQsxkN5SBizwe9P2un/G64R8
 a0ev7Rup7Eo83FA4=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrhAc-0004Fi-CK for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:20:55 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47fde295992so174914f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785957648; x=1786562448; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cd+VPOTXre9Wkfp+DQuY03HKVp5Cc2GqEmAuOAwStDY=;
 b=Y+NH73QdVCc7h1DD1TyFtAusOZLRn3CZ1m+zWAzO7vk1GxYHQF1Se+plHj6K0BScnZ
 KaSD4WISYchkVqrZX6bzQQYZMV8VD89vi6CxD7wm87b13M672fIGfL2TyWSElrDRsdyZ
 KSqlPizqxEvg1NI5Tn1oLGAi2GShJ+8oDynZ1ASj000AOWfSLnZW/cVTzfumNqCRj2db
 trqjn0xxNAPqw8lRiciyurc8GkYCAkNSk5fHP2HP43gmIQnYQm23zYhb5vC4VRjWnB1v
 DaU2TjIooXL9qxSPhzWJaCgHWfxp2FHG3dbVu+Nw/SFY4FMKdrfz4/FaPWDwvJWfv2XE
 h91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957648; x=1786562448;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cd+VPOTXre9Wkfp+DQuY03HKVp5Cc2GqEmAuOAwStDY=;
 b=BNBKSdDr9nXnqpQvOEHl1g3J4nTZKCm4lWodddhYKcXznMDp7VDkuS0yX7xhAbBYck
 gdXbE9oVHxO/UEi6F+TpSkrVeudsBgmN3qRgtI3vJhpY87U6pjXEMXXnSXRykVf0Cndq
 mBK6PoaeO1UxBn/O67M5gbB0k19AZkPPaOVY6PIN8TpR2VnvW183JWZS+EcGISOxTGgP
 tPaFUK/gRrdrWa7mslDar7waC1j0Npd4+nZrXvTDYlvlqf9Qz4uxLox5J3dDpVODTQ3v
 dkzrHl1rszSEFiYm7lTjFlZk9k00sxG9Y5aLsUvzIZlc2a7XXu9Uzn8xImaV0mU5kgJ8
 8MRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rra++acoU3l1PEc8O8JNCQDsQgQ/UmJTzQGIdlQoMUg+AatGIjtPY8rFELdoq7Zoqhr2nd5yRMmkYHMmyEK@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx6gQvao8n6WxNMo1Z3oyxes3T3Vr2Cegfie2h9/W/mbHsfh9w3
 qemL+7/TWp3krfbWIOObE6bdtkoN6f/P+IsLk6TP++lQQk+UErq/pWL7YmTptgKAmKMqrp5MkG3
 yw3oQoVcnpbrlMqG5U+sMmIrjr8u7/swEx2EsN3/pxWnQS1ihuhWZtTFsmaw/eTspbk4wxdnUIN
 pDSzO0pw==
X-Gm-Gg: AR+sD12S9zln+nsRdfnARbZmsZat+ssjB35G7QCrmJKox6ByWCZwTKmhQH57rhYN2pA
 gl6t1zH+p6i7W1nx5PtB/3YCclJlWkcxWC1y45NYzSDQ0uFaVw4MI3UKq3VF1w1I6cCN/TdFpUj
 BCXEls332RTPqbdZ6iJxBq1KLo18FihuVNo3Mp2PhyKr4p5Q8S49zmksn2qcpSrPQNuMujfZohE
 v5MLX+3jsPqzJ1Mmh+uD64na1p2uvFlHivdoO49pYX46iWuncyqbWXOwkMYnVpkAfbJ0hD+Uj7B
 NSow1cc1pyo9nx+eEvQkJdXxykXZ+kIzNzzU4mt2h8kVe2V99n+H17/cgbQWDvwN/yj1AtFA0Oy
 fv0kFhy/dxWnOnMtqsy7Acomb/bPxxGwOP0XXsTzs/VEeqytTMNiQzKc5xWIagODiJJpNyD8ouY
 /mZ66rO3B2VdbPt6WdLLLLlguwWWD0uFi2LP2eIX9XAzZZ/CXeBKPPicMHOIno5peaBv8e9EuZk
 /AKnNQBFSZ2e+hh9JfUCCQDBSbmI9IcOOPO/aSj5l5R6D+/bxM3yV0Y7Z160JyfShUAM5pAisBx
 Vr6jbJY6Dmpe1wp7TwKA+NxhOiisdhUXIpOWMyry12SSyXEqqqY=
X-Received: by 2002:a05:6000:25fb:b0:47f:70f2:ccf6 with SMTP id
 ffacd0b85a97d-47ff4cd9786mr2689548f8f.6.1785957647587; 
 Wed, 05 Aug 2026 12:20:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfe6b26sm11596874f8f.16.2026.08.05.12.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:20:47 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 19:20:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: e4c4e2fff1272a6a949b347d4bfe38d3d4278f6d
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 19:20:44 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f94600ac9925a1f64e2f4dfe8dd7ea303ecb3172-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrhAc-0004Fi-CK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
Content-Type: multipart/mixed; boundary="===============1582563170378862413=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1582563170378862413==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FDHucym3Vpo="; charset=UTF-8

--FDHucym3Vpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1826?usp=3Demail )

Change subject: Make required action returned=
 from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/m=
udp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/e7731825_d=
660ca9a?usp=3Demail :
PS4, Line 83: /* Returns true if this packet should c=
reate a new session */
> Obsolete comment=2E Please add some explanation he=
re about the different states=2E
I added the different states as doxygen co=
mments in the enum itself=2E Is that the right direction?



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106=
c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-=
Date: Wed, 05 Aug 2026 19:20:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--FDHucym3Vpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/co=
mment/e7731825_d660ca9a?usp=3Demail">Patch Set #4, Line 83:</a> <code style=
=3D"font-family:monospace,monospace">/* Returns true if this packet should =
create a new session */</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Obsolete comment=2E Please ad=
d some explanation here about the different states=2E</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I ad=
ded the different states as doxygen comments in the enum itself=2E Is that =
the right direction?</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfa=
d090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Wed, 05 Aug 2026 19:20:44 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--FDHucym3Vpo=--


--===============1582563170378862413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1582563170378862413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1582563170378862413==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9899FC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfXKMgl5gMuKz6gTfElsyoT+yP8UnlYc70rBJjHNWJw=; b=ipCxMf07a5ei32KHh0hxTnyU3d
	G4YOxe4+NC67tReBGUUN0tvgXgl8QPZVjRJpP6GUb48VvHAaLjtrIPxedBUJz7pAxxb5H4S67vlrT
	VVzNiVYTpnMzi67QDSA1zwEZZM37q13UMbm39ip18e0BYu8DsvqvACkmq8hgZh8hrDO8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjx82-0004tW-Ub;
	Wed, 15 Jul 2026 10:46:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjx81-0004tI-IZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6Q2lWtO94zmZyGB8W+m5HbeXgQvWWNTUi0RCS7N4XRM=; b=AbERwfTJgBUS2xWM0o83OEmckx
 av3Pz/pympEcVFYoQM9vgHDKTJhEtt49npDT2JvMRRYVcCItn5NQ5wLS7WjVtHzMVU0U+Jnmz11ek
 zzxRDegXpRucy5DsHbOv2EHDY66swc46ioaTjY2Ptl54PQcxAOX79heOnl7EtgSUiW2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6Q2lWtO94zmZyGB8W+m5HbeXgQvWWNTUi0RCS7N4XRM=; b=P
 EV6zVaD5odU9dtOrFuMeKRUsm4MLRoflZpYjgf+AeM4gNgS2cAKSZe0Btb4jYwrnQqpU0AERdXZRg
 61O+sUqyWEZd5gs9kjZqhoWUHO6/mYu0xiF3P5/hPMwncBoE1vlqWpt0AI0/ll6ezdG/0vUI+k65v
 rkf9DSxF/lHk6eQQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjx80-0001pV-8K for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:46:14 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so2874227f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784112361; x=1784717161; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6Q2lWtO94zmZyGB8W+m5HbeXgQvWWNTUi0RCS7N4XRM=;
 b=BbpNAsxAaHzVQYMK01jeLDlECnwrLXtnro8W+kUmee5gI4a40ov2kFDICpcrvr9oxU
 WVf380CRAvzloETRQL8uijPbx2CSKcRszc5u4jV1UWaRxIZi+qoTC6D1IYUC2mKVp00q
 LI2xdR5K4QOb9zpxeqnseU2JeNbr0Gycor/iNkwqy71oOKXHNSBy489nQk4tZ8bsATt0
 bVIU1ZkBVoK+fSUiXb6AH1tTGDdkHWkRgFey4S3Ptz6NYSq0MnGckMa+hrIk8ww27Pgg
 yW939jDIoAH2YgQElW9dKPg6SbUgHE2g2qE72rCwTgIEwuIfNW+j75Wq9UmpG/lGpoMJ
 eNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112361; x=1784717161;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6Q2lWtO94zmZyGB8W+m5HbeXgQvWWNTUi0RCS7N4XRM=;
 b=NAm5mQWIEmIp9DUEWC2St8rS9kg1kX3ehgnoJ9icANFQUuB2ODCZA+Gk9IYQ2u0RgG
 8Z9/ydRk9OoP6wNzKFqqWGTPrMUr3OpRgv79VLRIus5/3LDqsD1BLHJ1dwITv91lU51C
 ydMu2i0HNjXl+J+jSRtf92Cj2FX6sIO6owBJHRQCv3RCeXm48YmdxpKMJq0bFTSWET5t
 +wF6GNs7d16Xly4Dbfn3kKbZb2TFJ3LFP0ISnmxUMWXpStOr0pVgAnAL2KsNr7W4NqT6
 BvvH7/bTREvDcsTQ0xyjfVVMSoxNwHprObiR4NXLOcvkY0EEfB90MymUxlzjNCa9CVFb
 J4HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrXj55+vgjRy4lNZDAVpnPlTmUJpUufaH/noGISB1hXJyRpqeQH56j2luhxmbikO0hDgOBdqrVfZakcZoN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzqA3+SQmn8puXryvACJ/IDew7VCKxAt3HLcUz67Gkc1YQwbb/B
 CrDobwmEJ02L8Ex69HtL98KYbHmJa3BH99OZWPsfdolMlqYIzy/rkeroNsV7PegNQiwJW52snGV
 zdxmm+Rd08UdGPtCZQrbbnuC7HBXRQB0pXneci2BiEzsgM8ZkaBRD+34BxFN3XWmjSebU
X-Gm-Gg: AfdE7ckFPF7mgX+3/n9xObFtXNNYwDMpFSGtF/n4NU9FJOwZhe+hvtKwn4az+KzG8Wm
 KTlESCsVlFpcZtuAgkOq3Myj+mkz8Qp1VJKD5vZp/ywqQ1t2zmtaOoBfvMaxvZY7V6VnNFE2+XI
 Znqr3JEgxTzlGDinYG2LZwJV/rmmn+Gul1uyvaYLR7Sxc+aCg4hi6x+oR7RsZb/D1WX7FeTefUX
 1CnA/42Qb8gktCpb63b5xXHPny0r+eIE1148jCMU6xxW0q4RcP4JeFKDSKrwHNUqHqV4PycSaeF
 Cky2Pry4/C7K4pk7/x/XHxHqqI4ws1f25g1O/ywNP9JE9TbTx28KNZGTUQBIDzivR3T2LvBTJFk
 H2BhBRsduwVEpPeZRBgaTS6LA4UjNqHXkIHXh4kBfZElt01QinlpsiyoDeVwDtCjHR2TWC2h9w4
 LGRHdDMzflsrAC8WNs2ehZ4oGrp8jWL/oRVFsRaTQpau/mITnwgwdP9OA6EIPb0MqxnGDm4VfH5
 goJpfy2RwZZJh6NOqnReZ2YpHrkipi22fTexa9yM9N1GdNl1Z9RdPPi3jaPXZRUp/kZwvl2i0sZ
 I6M=
X-Received: by 2002:a05:6000:1a8d:b0:46b:7f57:7109 with SMTP id
 ffacd0b85a97d-47f4887e1famr7652220f8f.20.1784112360425; 
 Wed, 15 Jul 2026 03:46:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm17391050f8f.18.2026.07.15.03.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:45:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 10:45:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I37793543cd026aa4917129710c085c808e648c60
X-Gerrit-Change-Number: 1788
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1788?usp=email>
X-Gerrit-Commit: b3bccccb423e1bfdcdba57216e633444a41146eb
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 10:45:58 +0000
In-Reply-To: <gerrit.1784067448000.I37793543cd026aa4917129710c085c808e648c60@gerrit.openvpn.net>
References: <gerrit.1784067448000.I37793543cd026aa4917129710c085c808e648c60@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkkzNzc5MzU0M2NkMDI2YWE0OTE3MTI5NzEwYzA4NWM4MDhlNjQ4YzYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c52ebbe493df4756fcc7ac7087b64d591907fb96-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjx80-0001pV-8K
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tests: cover
 subnet_pool6_by_tag
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8220278348470640859=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8220278348470640859==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bOWqYfjoiZg="; charset=UTF-8

--bOWqYfjoiZg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1788?usp=3Demail )

Change subject: tests: cover subnet_pool6_by_tag
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review-2

(1 comment)

Patchset:

PS2: 
please squash into the unit t=
est patch for `subnet_pool_by_tag()`



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1788?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I37793543cd026aa4917129710c085c808e648c60
Gerrit-Change-N=
umber: 1788
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom=
>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Da=
te: Wed, 15 Jul 2026 10:45:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: Yes

--bOWqYfjoiZg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1788?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">please squash into the unit t=
est patch for `subnet_pool_by_tag()`</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?usp=3Demail">c=
hange 1788</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I37793543cd026aa4917129710c085c808e648c60 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1788 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 10:45:58=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--bOWqYfjoiZg=--


--===============8220278348470640859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8220278348470640859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8220278348470640859==--


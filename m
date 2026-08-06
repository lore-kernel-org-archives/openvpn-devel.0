Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2FCC561E6
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIVmn7OgilfdM9fKuNW3q2MzrvlGOJB04wEPgM6cViM=; b=T12tGrrmJujXpswMcWZXGXllJL
	XIaQGHzrf7MR7acNXwVzRUae83tR8sfeNFaDNZPrzQmPz48Rlt/8Y0EeO9g6a8S1mFgSg5uYjwdOE
	oCV2hxoUdxqlUNrsM7DDM9fjp1QXwk+sXBdcGc6zogEQXkCMIw8zIFZxIpBH5hxT47Ck=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrtzt-0007ib-Jg;
	Thu, 06 Aug 2026 09:02:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrtzr-0007iV-Ol
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xJqLsWjGYGGz56/ZPYjJSx0G40Ve1rFPqMNx6lfpoSA=; b=XVHnuirZbAzpsL6ZnzjZvyn+UU
 YvBRy9NzFcIS+VsTubL9lzUHn3s6DT4eJBnPZ6l75zNZXYqb/ez1SvjIeNivtL+p30ZjKJUNBLiiN
 +XNed7cZMDozfRL9XMtGQhPPcxwIYrrSKue+zdA+Z8zf6yQmwKmvwta8L77Z5Ylhu4VI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xJqLsWjGYGGz56/ZPYjJSx0G40Ve1rFPqMNx6lfpoSA=; b=L
 E5vL/ktOmFSXogycyVG6OprP5WeuFzNfcwdOlCuLZc0YQgyEHyxUwuYHCWnz5Rjr/Cin3rhLpRtgL
 xZO9BJExioOp5Nms2sm0/ezDxCBUSRFLp05VeOtWw7nSVeWcBYcCZJ88ACSgxzT1I+cQu82tIFmFX
 a6DAWiW7nwqeXQt8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrtzu-00063U-3U for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:02:40 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso4115885e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786006952; x=1786611752; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xJqLsWjGYGGz56/ZPYjJSx0G40Ve1rFPqMNx6lfpoSA=;
 b=GuoCkFWJBaWOgLR9erNbsjY2QOKq7OjwuDvUBsvcl3J+4i2RAGJn9nV8A35dvKZXdE
 5DO0ZltyGoRTFEo4GE7kSDWRCzGKgu0Yvk46stmFgvCAa0dKR6nrcXT0k1LZkRf8TO5g
 4VP7+Bj5f/yXjF2mbs7VTCxWgYeXNKWHwcfg6ZEgpN6WIYNr/uwLCU5QNBltIzqTNJs9
 HjEt4go0Iy1wTxnlJ+IRuNxwHdieHIeQsC9PxIHL1Snxd5wKXKZFuf20COGMV4PUDXw4
 dBX8MmLV5LNcAl4ZPVupBq6FqeHR+qHKiRNnS4UfZDii5yDpqQKNp6Si0oETBiNc4azq
 1/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786006952; x=1786611752;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xJqLsWjGYGGz56/ZPYjJSx0G40Ve1rFPqMNx6lfpoSA=;
 b=kyRcwSfbAbvUgWvQC1pNry7xIZTFRx+zjRTr1k0rG0BfIKqvZhaznP6xjOPwOnHluD
 2FzSZOdM7PeH/QH5WXx+Jo+MPQZFH5hS9r8f1d8CuZogMkfaRyAgSLYetatMGgB/mSlO
 dSqQjbeNDFaSgnt7OZ7Q1Aw+dxPzz4oAoGMvxiIV2EZ6V1076j4+2iq6L7lZv2Ha4QPc
 jrcVPpRl4Z/TXWqD5HjVnncqhc4zM1mfh7G1JMXflBgez1ncgWPKg0vfYbW1qmds7cJy
 bgA+szuYY2QzoMUY31JR0CaKc1Kqa6m1BCaAXTE7bXsJTQWkgTbCjw1amvFACh2OqbQe
 ghEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL3QeZX/571bNqn0T5BjxfncgXwm5DJP4mFKS6TEHsHfOR0C25qTS2JG0IYQfrjmvH8+nxq+U9tByL1RwV@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxve4WpUH8SxCNtlVu7/W7Q00pqqTQ8SuawukCEvs4yz/+/fCaq
 hp20lGCnmHgC7YPoPi1/cyy3VbZC3qLkP04zDC0FSE4mpH8pf8vyiK5dcH1u/VsrqJ9Ny965671
 Fv582vuicMZNM7MRgqf45r/F9CFzVa6cafOhwUuYRfYSsAHaGmohRPGKkfnsNclbje4r6
X-Gm-Gg: AR+sD128tLLkuVCjkjBYP34Hz584DGuJC/OCYU9m+pHIexpwvYuJ/+dV7uI9WIgTEHg
 dWo79hiq3BKtEcu6+cnxmF/3jPXW50GZto3s7++OinHzeCSYUTbftU6AHYDBjcFc85j7Xbk/yah
 y3hqL0g6JFaSO4IBC0OaTeKAcSF1VjI5bR6abgaTFyFaJn0b9SeqPTvR+Dl29+k/nzO+t29Dddz
 601iy0vRgY/8K8J30IsAhh7HXmaUXaNKpf2qE31Ggjz2rNt8HB+3YjWA7dRbMaurFdmYUa4czro
 anM08S6srECSDQ8imb0tfrKXBmX0+d/cM+CyqMEpY19E34xSyDgCQ4wKAWX4wk/L9LWjOxne7ZL
 Fa/KAWTlVeoGtQPJpsMTlDqiIQWyGhOuvOq46CWg1O4ctL6woKE8qTeIqFprH3GMCaognxra4jK
 GUDRX6Aq9WfCzv21EdyXdBcPJfZuBwjYy45SUNeZXHz0V9PAssHw5ZfHiOvveYUc06WrFeT9iZh
 5qL8TvIOK60k1zg5eGvH1QW98UXoXt5AypsAck4DVry+MdZcUK3PrluVD1+xopurqHXZyDa29u8
 9HsI4jjpGtvE+7UZ6Ma/gg1gBCvUKpebrQ0MswbvvKcnOM/Oxjs=
X-Received: by 2002:a05:600c:5694:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-4994e7bab0emr124439805e9.9.1786006951617; 
 Thu, 06 Aug 2026 02:02:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542183b2sm53044685e9.4.2026.08.06.02.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:02:31 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 09:02:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
X-Gerrit-Change-Number: 1834
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1834?usp=email>
X-Gerrit-Commit: a6be3fb9e95f4d155b1cc5750712e334f825ceac
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 09:02:27 +0000
In-Reply-To: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
References: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzY2MjYwMDAwLkkzZGI3MDAwMWJlN2YzOWNmODRkNTYyNTE3NjQ3ZjFhMzA1OTYyYjQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f64a929705943e792b86938def1eb201f5232e4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrtzu-00063U-3U
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove local
 get_random in test_misc.c
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4414413270962324045=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4414413270962324045==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1Xeqd0ZP+jg="; charset=UTF-8

--1Xeqd0ZP+jg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ordex has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1834?usp=3Demail )

Change subject: Remove local get_random in test_misc=
=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1834?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I3db70001be7f39cf84d562517647f1a305962b42
Gerrit-Change-Number: 1834
Gerri=
t-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: ordex <ant=
onio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Thu, 06 Aug 2026 09:02:27 +0000
Gerrit-HasComments: No
Ger=
rit-Has-Labels: Yes

--1Xeqd0ZP+jg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1834?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail">change 1834</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3db70001be7f39cf8=
4d562517647f1a305962b42 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1834 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 06 Aug 2026 09:02:27 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: Yes </div>

</body></html>
--1Xeqd0ZP+jg=--


--===============4414413270962324045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4414413270962324045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4414413270962324045==--


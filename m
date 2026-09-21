Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F89C982DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+Q8U52FKxiZfwkz6TSZxcl8cjRpa+tLanxZi9kZyGc=; b=Fd1Y0csRHdQgqv3IJt8KeqaLTC
	IC7JhYF9JmcmgdJAbqgKC40liIRjwvvxHvLSxxCUq2IyehIaES+uK2U5fUih+jee1sUHWKFhePtso
	YC0WG6KH6XSq9nd9YGeVfvEWam0lqo1vLAhh3dzPtaTrt6j0MWLHHDmY0IbfJ54OHBiE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8axs-00057U-12;
	Mon, 21 Sep 2026 10:09:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8axr-00057M-Ff
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:09:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EJiGQItSuDR1nRLjku/xzTi9jVT7dFe9yanz66oDpz0=; b=UHfpNEO7uKa9HI5C/zX/E3CPTR
 rfazDBW99/MajRDVLRUPLMQmt8kyrHhifVH6mMSp6yo27S3WiwhKmEVZaHz+5cFN+29zz3Z7qe8D6
 MqO407c7c6PmOVq1PzkquO/PQaq1i87H42Olxrz4oczT+jHd8VAeTNVH9zi8Y7GixOEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EJiGQItSuDR1nRLjku/xzTi9jVT7dFe9yanz66oDpz0=; b=W
 IllK0PJvvTsbg8sIeDTVImprEpfzWuQ8Zb9Feo3uc7Fl3762eyuBjuwhuvMj4Lzw4Zf1MTzlo/Xs/
 rz4PUQe0hCD3huO3CzN/+Qimocc8mkcj++DEs7MoUYspvHjGzeaKGWIllplORnBG3AvoRjW4Um8Tk
 8exctHyAR+7y1nPQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8axn-0003bk-Au for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:09:32 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so1340116f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789985365; x=1790590165; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EJiGQItSuDR1nRLjku/xzTi9jVT7dFe9yanz66oDpz0=;
 b=hGCsI8Nc4wmPOUtW6eN9/Sz1QLU86OiF5gT+dTeXRMqbb+x6T6D8EY8WZy4abM6P8u
 aY2kF9J2K3jxb57X9FNkfGAeqoLTsOfTfCdcCwhDyia/+dzn3ZwUfdQOtcjJ9tZIL7au
 mc8SwLB8+0Fbc5Kw/XvGRSrLG1jJVfqdh9GNd5VkT3vAbE+gpiuAnxUqkF644ugn3X1q
 400JitN2tIeDvfHhb8PtX0e8PoniDbSqqTU/d/eRXqH7FiKpq+e4l/JHTRVk1wAxXt7X
 oMyZjqAHNILto3irPHPCX1KzTqp2UaUMWvmq3T3byM6OSwgeAD/c9eg5d/ahfVl6S7hp
 G3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985365; x=1790590165;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EJiGQItSuDR1nRLjku/xzTi9jVT7dFe9yanz66oDpz0=;
 b=myKdGZk1irZ3aOhX8Sd1RnxnZ55kYbmJqZpoX4pdRKOKG7fksfpoVqM8jasckiZtaL
 X+V3X5cTPGTE+i4sOMZ7uzWp4SsRAZApKmWY0rLQMPUlyp6KCDBNGbZ2gE2yDyK3pL7W
 mSrH5OHoHW94L40NU4QD11RYQedp8U13LvyPbRP/BBSC9ChCE221pg+pkAoocmlhLXGF
 glSYJtGYNLmg9aiCP16Q97QmItS5WTh9vewOQT0kPeSrRKx782+fx12ALL32cKXdcfjc
 uWhB3wS1bT4+6TfjT62MmM65IY0fTjY6VCuMgtlE7xpcC5h2SPMr2g/IrbcaOzIa4PZs
 pA5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbWUGBwXFfM3q+LCpXP7MTHUeYg+/U6i/8f6LU3DbnxKUsTA6SR7DxNwdVjLvqLIkxxrvdpXMyASFquRhg@lists.sourceforge.net
X-Gm-Message-State: AFuF++lLynZ5Q4FV27Rlpwf2UsAMrABPZSW9e1CcOeusOaosaADhe6CD
 4rTwGKsX2X9e96XTJBvmV6pCqWKzKIAgcNMw6YR05hf/SoQUloi1ys3TEL6832y2lT3pCNUfWF9
 R1Owqobj6B87zPlPehL+xu4kmfjQWNMOLMGmnSUg5WYCTUG65ik/p2Ki1uGb2BzT5BONG
X-Gm-Gg: AYBFou1AYfYqL548Phx3wmlc20TziVqEKLGWf71nFBGfoOPvbQsuR/l0N5OitMkcz2u
 T7GGGhK2uFK5S/Vyk2Usev5XBl3nkJaoQ8j8RCfb/yi9kCi0sWPBkyhB05fLL5WZQ9u/stlt3q+
 +81gRcE3dFLexx56rVDJ2z5yAWVu57UonZrlOeDx2qwRfCNZiOYIuiZVAnFLa/8N+9dZYSZjH86
 MBDoue4T20SJ+PbRFzXpCHLad17kPEwDf9sbQKdrpvjthcHZbkDX08G9PMbE7Xgg3hl8S76PW+K
 xMrW4eOcBwkPeLv4G3Oud0vyTvZYJahOb1f2/79pYRDjUugWoBAjbDEfMJRkC2jXPdniXFLGNZq
 a5m8St0AcZqRmY8On+kJkPqSWANWOvAC3dslnaRCQc2ZjAiq8bVYkDMZoDWUNNeP/w6ikYxceGp
 SDv4FnsZ7Svc6Gx+7J/Fl7MuT/fpfVCIms+uTi7QxBiC0RR1uRYR+osvpvt0Z0N3/0KAFANETRo
 vy4RNp1CQ83aEdZ8p1JxWbQwhl3DstkQQVoyiXn9lh8IMI4RF3/iAHajMPLO7lceGNwvmd1Nnt3
 t33dHdZnkX3o5nEa9HtYbfMVkCMGSzRZwfYh+jyeTHlbBfgmh4U0yIfyoDUoiA==
X-Received: by 2002:a05:6000:2612:b0:485:8226:c696 with SMTP id
 ffacd0b85a97d-48713c59e2bmr22653411f8f.21.1789985364676; 
 Mon, 21 Sep 2026 03:09:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724595289sm23122759f8f.29.2026.09.21.03.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:09:24 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 10:09:22 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 1b0b7e8e90804b64fa6997b2c5c1cdc7d03a5941
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 10:09:22 +0000
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <64e09b2d6c1cd481ce0b77e58d973c5a168bf35c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8axn-0003bk-Au
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Probe every
 resolved address of a remote
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2751995304503024856=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2751995304503024856==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4VsNBBgu/X8="; charset=UTF-8

--4VsNBBgu/X8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1751?usp=3Demail )

Change subject: oob: Probe every resolved add=
ress of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 29: Code-Review+1


-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1751?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Numbe=
r: 1751
Gerrit-PatchSet: 29
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_=
lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mo=
n, 21 Sep 2026 10:09:22 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--4VsNBBgu/X8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 29:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610=
e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 10:09:22 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--4VsNBBgu/X8=--


--===============2751995304503024856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2751995304503024856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2751995304503024856==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC1EC982D7
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3i4X8roRqRPvjz0hzDkz4N8p70cujBsD+6H8V8NiAno=; b=PLcPEK9Pz/NPqIrCqD/C4bCSlL
	mG+WaZyHHWY4ks8WoKcroiDWz6uXwdcLE4cNfwfn6SQS+b639vgyzoQCT8vUqu2UVlkamynz3F96w
	TNNyh6ri5AdExy4nKL9QQid/rK3JZ4CCY4wvJVvJQxmrPqq1qkUNoVxCQu5mGCoNgXFM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7cxK-0003IR-LO;
	Fri, 18 Sep 2026 18:05:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7cxK-0003IJ-4E
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 18:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wrAY47XkmPqCVU5nTIdjjT3tL6ilUSbbNR0xbV8POco=; b=jmNMsIJVgBWo01vmrmOWedfgBu
 B9PXZmLLFqpXXertFdoyzqEeSChKde3fczPJAbWWG3lveCVCzNxfmTQmqrmXvuT48dN4bP23otUJQ
 4Xk2PZOq3DTRhWb56+eoD53EHUkEzHr+k8Br1udcaH9/eEgXks5GV3paB5xrdKArLJ+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wrAY47XkmPqCVU5nTIdjjT3tL6ilUSbbNR0xbV8POco=; b=V
 olQbuckF0BOcZz61L9FzeaU1a+yUlt/6ZidDGlqVW0l7SVE9W98jCV2lEVL87pTXkBAfebN4az2OQ
 HHy2OwWsA+MqYp8EPndApfo0HVZZ/NDwCkgQv9fZ2bzyRreKDxwmFJUBMdpPe3lDKrdxnORWsameE
 BFza3fX/HGNAojbI=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7cxH-0001GD-Rd for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 18:05:02 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso7340795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789754693; x=1790359493; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wrAY47XkmPqCVU5nTIdjjT3tL6ilUSbbNR0xbV8POco=;
 b=LPMFrZ5vEartklVRmd/2LImbHk7ZZY7XxyN+2Sh9uM9HCRzty0BH5It9xA+YZTRkjn
 lpkapy0el4HMArTFQct2zrnRedQc62lfBit5EIYXnMQZeXzIEVB+5nNSWe9T1qZMcPoo
 s0LXTPSPd+8FrtqPgwgRDAL/BSDKUy/eObxR7PnQ6QdJLLu1pLXJAuEYKA9fwjDdEa6O
 mPLJJWt73wLozPJurYH1lGQ4ZZM59XRupQC3NqjEzFSDudKhhbb1Of8gdL3xJQR2SaFl
 FIzA3fkHsKVe3HQ02p900h1iL1e7L/SzKdUI6Ji5JpLuy+NwTCqsnWuns3G+LVuniAil
 lNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754693; x=1790359493;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wrAY47XkmPqCVU5nTIdjjT3tL6ilUSbbNR0xbV8POco=;
 b=GbhMrmHnEjzGI6b3lfgSPtaBjOV3Rn2WlwWkOdz/c6niORa0O4ka2A4CIPahbDvlsR
 ke08tLws3Exo5AmM2wjw2eDMF+EddDQNKATdEmdMGOIsKSf97RjnAHOltfR9XCFfm8xD
 trAieD1UpHLVMpzwr68DpASDzFY2DdJpiyST5aLaGQr16wIt3oFWgCvHikM0teC6RgLH
 WK6VmhuqeotJNlXNc2dAulR+c1GSVJLGALRXScdAXJXIOvHtlTUNdXc3kfVvCobHdKUv
 07S5/lb36CqJUlCZ7f8GXGa5iQI3ToLxBf+K0I5LZgsQlbySuSSBinV4+5j8GQQM5KNv
 mzTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiRwj4aU8Md6SMdJGcZRcjV1DnBiarJS7wlyOyas2QJge98FwqMNCBGbpVjcAHE5KPHtCC0B7QLWVuHe6B@lists.sourceforge.net
X-Gm-Message-State: AFuF++luJZ7PB9wSzfe9WOfnI0mQ4C9SFCo5a4XnOI02bNNlfih1lFHF
 q1izDeLpq7AaWRkJQKcQiChGyKzcv6WsZtxMGc5eoU/OZ0qTpyshgK2S4x+VPYFuYJ5iADJY5w5
 XSMS42dlRCStUzAt6nwKWIhDmuXrtqX+BQGvHNBALU1wRMXyyHlKfEqmLwJ5AP0uncm+q
X-Gm-Gg: AYBFou2yDNu+g6s27g5uxaQVDekprPTo0QCWJwZLKJXIj4FnENeO2JO3F7UUExPvz7x
 08Ej94B89ZRMFcLqmUh9ES80oLiWCIsXrH7iGon4jl8xb0Tn2AJYEgr3e2SxzQbPvZh9GAOspwI
 ZINrN6QwZDtvSkeJAP+a6Mk7d1KIxzyvgUqlfYLOLDAPhAeeWsyHebVqaGl78/YuZBVaJXfp+eN
 iqZ/KJ3j/4Uy1npRl7WL0TPq7RHIJvJ8Flsk5cHB45viXxd3kq6DFzybJVOenjJ2kv5VuDOjxLh
 +CsRcDSmOSrKiwtDE1hXwmtairH1PMP9P2myvjPnVOi/VARC5MZvkO5sjiebH+3YpfroGzM3qK9
 qjUd2btz7fx8o0QqPvZ/rKggq669l3H1Bw5IX0oqrIQ+UDcPt+GGL7ByDG8w3RwiCC8FhdYQctA
 lhRSGCn5amHZA7sn3i9XT58r4TRZG6QDRI+y2//ZTQ3pcC1NgVOoQjq4LBNDkJFH7vai2DtzmaL
 HyumKZH+xoBj1W1I8dFy/jsPDy0ZWPa+DsI/uGQ8zIPSE8BUfThOSQCbwYYlyjN29wLxaLfxh+W
 +/u6jnyVJ/Cg80Gb31GzNP6fLNKnH6R02WPkJzdN3qC8VR9PmwXteSzP6I5Z0w==
X-Received: by 2002:a05:600c:138c:b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-49fc574af20mr42897995e9.30.1789754693028; 
 Fri, 18 Sep 2026 11:04:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd03ffc4sm12816475e9.1.2026.09.18.11.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:04:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 18:04:51 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
X-Gerrit-Change-Number: 1920
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1920?usp=email>
X-Gerrit-Commit: 0e031e39e423011f3b2912f2b5bba3833afb3974
X-Gerrit-Comment-Date: Fri, 18 Sep 2026 18:04:51 +0000
In-Reply-To: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
References: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NzE1NzQ0MDAwLkllNDY5MzRjMGE4ZjA0OTA4Y2MyNzcxMTRhZTQ5MWMxMDBkMzY4Y2IyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95b6ec4dadad8ae9c3b91a6f16d8db5b8cc444b4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7cxH-0001GD-Rd
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: report
 per-peer ioctl failures instead of exiting
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4475831422109922667=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4475831422109922667==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NmyJltmKALE="; charset=UTF-8

--NmyJltmKALE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

cron2 has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1920?usp=3Demail )

Change subject: dco_win: report per-peer ioctl fa=
ilures instead of exiting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
Gerrit-Chan=
ge-Number: 1920
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date=
: Fri, 18 Sep 2026 18:04:51 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--NmyJltmKALE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail">change 1920</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie46934c0=
a8f04908cc277114ae491c100d368cb2 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1920 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 18 Sep 2026 18:04:51 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--NmyJltmKALE=--


--===============4475831422109922667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4475831422109922667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4475831422109922667==--


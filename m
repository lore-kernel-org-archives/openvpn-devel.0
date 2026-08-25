Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD56C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KUdMJQRRPEsDMwoSoy4YKVF/Qe31dGOKrgVDcRbF2kg=; b=nOqKbKoZcVB4jchYgFy8BWWSjJ
	U2+qjX7c2SWPK2VKyp8DLsADKrHcZ8VDVYV3jkKBJSulGDa3Zqd58ip8jFLqiyF7UYGJC5ZA5l8zK
	0NDYZktuBX2bPM+RMYYVJBVCSme4PSmRLcjHMligZg2uwKI6U/idtM1I71hS00Jk5h6U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyta5-0006bk-HK;
	Tue, 25 Aug 2026 16:00:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytZm-0006bE-Q6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P2k+ZJ2bqVxIw3YMMMv+6H28nK80RbyoPtocp+MJoLQ=; b=lq72vLviR7SC0e5z0c8gUVhzkC
 vMMeifQf8zT+Zq8Ytp7AyZo1plvGN3v2d24CzWg9OchNzqs2Ax/uPciFV0ACt7YYxbpOCkVAvebAf
 CgUdp8hsTya4O8zkPwyoDkduGeMNX91iSwSftzp+2NoZehlmTZa7YuvPWTGZ3EoS1iQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P2k+ZJ2bqVxIw3YMMMv+6H28nK80RbyoPtocp+MJoLQ=; b=Q
 O2VdCz5qVA3TSUmrlt1MPI4Q3CnRNqvq/5/YImLpFwb33tYn17P/mU1X3pCTKfxjNEfMqoORWtgmV
 u0NQrclAEzkwnPCOVYJDjOe+w8RNMf8hy9cfxaC3YPsBV4QYqTHPsFT6/oABhQ5txnn2V34QZQw3d
 jawjP+hulbnG424Y=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytZb-0001iQ-9s for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:00:29 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so308137a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787673621; x=1788278421; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P2k+ZJ2bqVxIw3YMMMv+6H28nK80RbyoPtocp+MJoLQ=;
 b=KWti0vneX+mqjA3N856VMQG2t187Wf0bwtFOJYLZf7CGhupHOQTWZ+huqLwi/v3HQv
 VhA8USXk6avQVVMWzUaKhsXfEXH50mzXaI1o4cbf9U8ryW3ebipHMbl0m5Wr/T7pZA5M
 fNwpKm2NZtiSapuM97lWnB8hWC5r3XAnz3AP07MpoT9waUR/4DG56ThnXwfEoYIwEfZW
 wdqLihnKUtKCGYzM0f1SvHSfes3nHkYQBDDlBe8Eni/LvQzXgoG6AHST6sH5y91gS+h7
 JloDv8FnPGsVVta8orTbZ7ACGh5g4TqWvSOFItW6Ifb6S93db1FHxVw0fBhv0uWdvyU8
 VCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787673621; x=1788278421;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P2k+ZJ2bqVxIw3YMMMv+6H28nK80RbyoPtocp+MJoLQ=;
 b=g9Xfy0kvCOCVINSaQs4841qyvIhmcAKEXcETnyyiAWXw0pnx+eqcZNIBq5qxp4U2+5
 Xv+GZoQQwkJ8K5sViycby+16fENQvjQFXfgaM6AETYg0HHR7686yxSHzIMqvkVEbQbHM
 hdoX+90y9E3XLgNoimLrBoQ0PBYV8RCL5oBYgkEMY85k/Ln5DcrlNqL7dlKAx4fjt+Bi
 weKiDTB3g2Jfo/tWj6RMvMRIKkojSMr1L2Ff7PMYtOL4jTIB7xthTmbV3Yg5nR1HxShX
 0TlyINJFbDkEeiAjPh0zjV19F8vfwvhMbTdhsT5am4BoTbvWX26XvbddgVtyBCSNRmgz
 fzPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMOnwc/0YukvKDHHGiK309ZqzEanJ2vD3IGpuoF+3hCF6+n64cjdi2FO9K9mfpnNdFXVoqN2YQbEzIs6lx@lists.sourceforge.net
X-Gm-Message-State: AFuF++nFWCjv1NLBNfvK63AtLROUo/wlCk7yuXl0FLbMqVb8CdVOcqn6
 Tmt3a5uVfoyHiS2B6r0/IC1NKSxFWW/fvEeEWvpzm4nGg273Bk950Qcb8VrAqXI1uFlV+dY0BhZ
 62psGlsoJzj77Dxc8MqU/xVTKZoJRzCMtMFn9z6eU8sbZJNQuE3GcDWMavUv0oyFHKe9Q
X-Gm-Gg: AR+sD11r+zQabItjZJOOvW47vcEEG8iv5i0U55yI7UJTOHCobPzpscHGMi+NnV9+X0j
 FfEhWHNwONf/2cOJIpomAZpHqdbpttikbpHTQlO2t/mGnuXJG9Gx7E42LixF5Nn/HMCLWf2dk8e
 VeBSleS9pJdqNIUFQEYSp91Ilh252AXnox7DJfZIooFGhE33VAlzzHPkjfXFQOmNtkz7SsGLbCX
 VBetZR3CC/H3U1kLtaE2dKCExfgeOigmf5APB5tscD4AwMck7CoWxFePQRMM9DGjEDe/b9Tsmy9
 I5JkQiaoym/m7CrL1mayWN214U/qFV6bLvw12uMUZpVeVpLBTeefbCqsDEw19WxpWC0vI5JnjXx
 xjmtQHLqQkjjeMpzcNe/bMTyEIKywZ+99htdHCubZZxwQ3YneW25hQ/WaktnYkQPppP6HzjksOX
 M7IeUyxfW3KCBmFj0DCBIOlF0gv3CUJt07YiRlxBFtmkRb/birp/fR0rvKyCO9jHI4xIpG7WBSt
 PHX/xPnOTO/jxBBRl0QElm3QNvMbUBu0CdwfW+1FO969tHZ7JMEU3xNS/3USKpmlEmW/x1Kn850
 9WMGz4liVQ2dlNO6sbcQm5jyw3+ERKi7jCoeC+MPdpV0r8b8bztZh1n4do3gQA==
X-Received: by 2002:a05:6402:3807:b0:6a3:849b:aa48 with SMTP id
 4fb4d7f45d1cf-6a582b39dc9mr32072169a12.7.1787673620542; 
 Tue, 25 Aug 2026 09:00:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1afcsm541676a12.8.2026.08.25.09.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 09:00:19 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 16:00:16 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
X-Gerrit-Change-Number: 1870
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1870?usp=email>
X-Gerrit-Commit: 55f9a92178eabc83fd2787dd9c8a021a77d8f329
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 16:00:16 +0000
In-Reply-To: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
References: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2MTIzYzMzYjE0MzRkNzdhMGJjMzNkZDVlZjI4ZGE2NDNkMDg2YjRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1ac7b12e043892a06c691a93defbe2498f6c00c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytZb-0001iQ-9s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_schedule: Make
 all the counting variables unsigned
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
Content-Type: multipart/mixed; boundary="===============2277858179691281758=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2277858179691281758==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TQlpMjFHWew="; charset=UTF-8

--TQlpMjFHWew=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1870?usp=3Demail )

Change subject: test_schedule: Ma=
ke all the counting variables unsigned
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b=

Gerrit-Change-Number: 1870
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Tue, 25 Aug 2026 16:00:16 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--TQlpMjFHWew=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail">change 1870=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6123=
c33b1434d77a0bc33dd5ef28da643d086b4b </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1870 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 25 Aug 2026 16:=
00:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--TQlpMjFHWew=--


--===============2277858179691281758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2277858179691281758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2277858179691281758==--


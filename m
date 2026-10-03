Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61491CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuh7ubfBoA0o/c2uO/zXXZ9cD6VGLH9LvxhSEJB56x4=; b=Aaa4C6o9QnoE4ig836iA/0qGvD
	rbIkUnFxibN4X+hvm79vXtKxuIhUoEYMBYbs2vY3x8OvPLWXE7Y6g6ZEc/QWRJBYDnljA8S1u4m/M
	jw19jKoD80BQzyjY2mMEng637s+mgjrl32KctH2H7TQNx4Do0lGK7WJlU+vxeR47LnKE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD3xI-00069p-D3;
	Sat, 03 Oct 2026 17:55:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD3xH-00069j-8P
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sfc6FvFo59ZAPgFNFsqlUAMr90nrOScCFUg7xLbRg2Y=; b=a/fGBI0j5WVYnOt8x9fI83ExWE
 iyTX7e78TWRrqC1nJTLebV5sxHbkMl8SOf7buwb8ooiBKqYKLOLBLDXFSjRgVXRa8Q+M4xHrCNOBF
 8dgTetu7axgorrVLnckjgttAtvWFa3fZ/Q3ZyHZz9QBfToQBtQLmdiYN8vFYP5Zjhdo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sfc6FvFo59ZAPgFNFsqlUAMr90nrOScCFUg7xLbRg2Y=; b=F
 phY03VEEbRnouF3MAYCek0xJWZtV5YY6OPK2zGtteG3DNYVkw+u3q6UrrM3AFEOUVCGDTYDv7s2Ed
 06Rv4YqHmCME2+kPPlcFD6x8ro+gB3mnVT1Xxt+KB+vakLUPKTigGn25/N16HZ3GsHMHRN9DP0u2v
 XUBJ+2USCMRbdcNA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD3xE-0003Ug-8m for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:55:24 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff6f0f87so6608725e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791050118; x=1791654918; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sfc6FvFo59ZAPgFNFsqlUAMr90nrOScCFUg7xLbRg2Y=;
 b=Z1VpnFVK/7HYLLF7rmK4+SdRglw1XfUoT9t2ILsmVV/lxVgvKVE93srgE3u63l/+3h
 Z6hYjKG4Ed2V56UKNC3vvBTQoCR2b6aVJuaRGhl3i4QUZnsMT+N+980XHfKOftDWPQnP
 h8JaT3KS6zndJhT1PZPSwYLy7jsWkCGU45NfiSFqtKPPDQP7WacQ/tAHUf2RaRom87XL
 vBpQ6uah0c0nybDmU9xySE3duYQx67YPblS92u8MCtiAm8RUDsg650mEkrbRHWY+o3yC
 Xgsz/KPCsTc9bEHvdMXxSqe29ohLJCNdEwNelG5tGvK6OJgk4rzYt+spSmmt4Dlm56QQ
 mq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791050118; x=1791654918;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sfc6FvFo59ZAPgFNFsqlUAMr90nrOScCFUg7xLbRg2Y=;
 b=p4g5Euir0k5CxeyYr6nuQi4Z0SrhO0RVSDiaM+osX3SNRQVc0H4kd9hOSk7gjdvEA2
 BKUW4Kv6046hEpf7XAijmO9+0LpuZ0joCOYTOYWvrnQBmUVF5TcK7z3kMjIVBl22KfNU
 Bb0pyNKT9ivk7DwEyTAgRfrohc3W96XcYX5W8LD7x/9JRgF+UEH09Ed52ZZFB5ll4i+y
 joPB7NEnkvikBzPvrisJDmS2uMg0FyTmA4Eq7TmVro1rXSxQIFZI6CUxPIvFaAOoeTUK
 fzi6aEFCBkOQ/LWvjIJ9LO2AhfnrvQ188cvxvObyTLxe95xnQUiflPjQu4HlK9DUhcr4
 JF7A==
X-Forwarded-Encrypted: i=1;
 AKwUvByBoCDI17o9u7DpSb0RxCZ7ClqeEoDkuo4zJ965JGnMY4LMgz5ROThQTxct45mCir4vLyUyCgomePJul7mX@lists.sourceforge.net
X-Gm-Message-State: AFuF++mAGmqp71nEQgtBQyo3tX/ouc6k8g7xrXH2Ngd1snBqkOheNuJW
 kUUey8K1V0/0Mu+K2sovRb90cotStqJHdToke6ljxHk2pUrY0YVkLm7PNwoBR9E4ph1v05qpASw
 OPocmAbdhh6bN16JKDoh+741u3sdcvoDDG1b34is/vWgxR24aDjIkA0Kf1GL4AL7cUqBM
X-Gm-Gg: AYBFou1wgLg+6kzTJfKP/6MtNdEzK5VpL5Rft1txORXseL9VsNbPVPp8b/EBtZTOToB
 V/X7tFLfMyYFxctPW1sQ7FDguGN4iJpcNr1NDH3XsmNknKYeqJsTvUmsVyz750ViPwZzLURv+sn
 Bv6DgtfyhUALyWZ1OfvA8xBI+Ir1huXWz6QX9KlHiDB43IVUa5pOT3Yat8xxElhtW2OVwCFNhsY
 4EvZC6fzq7WJBJyVWSeoFVDILZ9YNnKFnRaqjNljgZFB9Z76rvGABppZUDzXU0Cn+DJfdjeToYa
 plCjoABo2AtZOcI9BzbSmt8P4F+DyOpWy6OYsatVPYFC6kiTWS5rk9rhp8cGRimJ8ozRFrU7Kuh
 zkLVwLW8KRiSMtoo0bzS2AxNcezzVsosRIDtz+V76qlfHNA+Ach0NPQOOAz4h10W/mvpmft8q2X
 QOPIEB0LhkMWat5S5npFU+IJm6u48eaWOQG2QmkCjGmEYDgGVcM7wuSXidzh9LL7cB2tBvygxkR
 0tkeeX5anrBtKUQiWQGGA2h5z8GXAvwLziBM115zQZpMCrxjiyLA2wBvmlNQHNC0i+UsuTGb1Ju
 iNL8Zw3orzubISU/4a7UA84vUjL3zcnpgGPOIGBG1mxY1DmnO/I50ZzJ0iHv
X-Received: by 2002:a05:600c:608c:b0:4a0:20fa:603f with SMTP id
 5b1f17b1804b1-4a02758e4e1mr102612665e9.17.1791050117596; 
 Sat, 03 Oct 2026 10:55:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027f2a4cfsm163722805e9.1.2026.10.03.10.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 10:55:17 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 17:55:15 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1
X-Gerrit-Change-Number: 1954
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1954?usp=email>
X-Gerrit-Commit: cc339dbf62f25ad08c277862348b8bf071fb3793
X-Gerrit-Comment-Date: Sat, 3 Oct 2026 17:55:15 +0000
In-Reply-To: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
References: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzU0NDIyMDAwLkk2NjkzYjVhYTI5ODgxMDJmNWU3ODg0YTY1MTE5ZWJmYzg3ZGQwN2UxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a22cbd0f1675a5a2724c20cde8a5fa498af16167-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD3xE-0003Ug-8m
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix various issues
 found by cppcheck 2.21.0
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2089391660692615904=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2089391660692615904==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TEQJju/rAbM="; charset=UTF-8

--TEQJju/rAbM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

Gert=
 Doering has posted comments on this change by Frank Lichtenheld=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail )

Change subject: F=
ix various issues found by cppcheck 2=2E21=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119=
ebfc87dd07e1
Gerrit-Change-Number: 1954
Gerrit-PatchSet: 3
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 03 Oct 20=
26 17:55:15 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--TEQJju/rAbM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>Gert Doering =
has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch set =
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail">c=
hange 1954</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1954 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Sat, 03 Oct 2026 17:55:15 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--TEQJju/rAbM=--


--===============2089391660692615904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2089391660692615904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2089391660692615904==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2171EC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSpyIqgUeNgEUcccClChVUon/D3huGAMdaGSwNQqCXo=; b=MiBeGSYqvq7nV7VDXJep/1l6w0
	MOiY7m41dnAWAEIYlldzba3u9HT2kXVo5f5KYWTg5zBgyElUx7k9XYTbDzlL+u9CuTjwp6c8LG9Bb
	t1v1OE0QBFOwbOjxYOeOGf4YTa7ageBZrWZJQjzBsWCxWSf8D7Jtp5crknOvWMBZuG1o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1JX-0005Oo-Bn;
	Wed, 15 Jul 2026 15:14:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1JW-0005Oe-GR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WNg68j7diYOYjzI7ZfwXO1x3lEGU5Dj8mRXUMaXTTBc=; b=jA+S8Lw9LHPqctZaX6fl24TCQb
 duwtvPSZ2oXaHnyd3Vau90Dejtc5MRUMzoAIE3N7z3I/+GZ/5JrjHPGVNBoymVHb5VUnrLlx9tbWl
 RYRR4TXZx2tD++pyyB7F3H7mRs5iJyfRCxvbVwRL3DFSR4BPg5UxojXfXgaxrvj1pbrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WNg68j7diYOYjzI7ZfwXO1x3lEGU5Dj8mRXUMaXTTBc=; b=A
 jYNdpym6XkYmEiNXUR8Pjb7z6YXX0T8D4iO/fn30W77ws4vcsgQVEqxbdQh40DRy7Altk6YBtYZiZ
 DmoTUTWoMGdQt9cNhoXtphqK9HcQrSyfLsKgUa9JX40xX+OlgE2Scmj0dXFk8jj1yH5Ge+7/u0N58
 SboznhkcfDaBxMg4=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1JW-0007Yz-M0 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:14:23 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso2007615f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128451; x=1784733251; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WNg68j7diYOYjzI7ZfwXO1x3lEGU5Dj8mRXUMaXTTBc=;
 b=WQ5F2hR1ssa81SC7wpd0510RlS+2vaAC5lYvlihtLKXapG2tzFXT8+O9PPq48lPb41
 FKB7OMdtI1sQjgSuvCgpYDNBf5+4uts+2clOxhL6u9Zx87YTav3vkclG/xJF2DIsO75I
 QXx4uhGMIkJ7xRFFEGvfKTxmDxFOzLuAzKnMjQGaHQbIRln4omPL2OPDFJlyaKCZX0AP
 e0BmiQ9JBiJO1zY+G3IaK+zppsaWT8UzKLkR2C8U3RLw9eoF6FFtYIxw2gA751dSsvOH
 u3BWkjnnjMZWowNUrvtELp+JalTsRV42Yv2Wjj1iqmKdqdOVCa3knd3nKt1ZYjkpTNlB
 +DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128451; x=1784733251;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WNg68j7diYOYjzI7ZfwXO1x3lEGU5Dj8mRXUMaXTTBc=;
 b=HUwb1oXdxE8ih330zUniAWSJsyBzM1Crf5heh5RbTMCzVjiYFeBYnj24ta77sMrkn4
 ydRZh1WJ7KmhoiEtjgnaG9kfNZoEfZubAhhyTOKTUzpS22Q3iaqoUMvCCMgc/OADw3NJ
 CCB0dD5y2nhT9IlDrekfwxF3JLIDfSZHUmAYluwmhlzu8b66LKCRZ5HXmyxC5J/Asl9U
 X3bxy3hoPg23bUsWhPKbccVA7UGVU+mDeKxRzJaIoP7rxHTrqORSWP0EQks+MogBSLTo
 DHE8nFSpF5YxRDbNxKvyCnIJFCF2SAi3Pmhxk3GClEz0zIDOOu8TEbe31cogU/g6VG3B
 yYyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr93lYONgatQy2IVPaEKUnk6BQZavRw4Wgx8sX1j/umtmHApWk+jMKYK5d+c8C2QHs2lu435BnGm2zlGT0O@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwkfKV1IAH/aPX+WNOYFrAfp7PJA/kA6O1cqND3TQrxT9EMNV47
 Bp5MvhiFaaqAtGIvJoEE2O8NQayIbNBeb7naWpU9CLAYfOEtEBJa3TQZ39TW8iCqIfHv9O9oOQE
 5i0OEWJr0HL0ycMpQvVuGGl6JJfuLpDv4SpV+nyhCr+r3+1GDqHonNWuGvmZ64saAOj01
X-Gm-Gg: AfdE7clOYW/WisZcGlA06Iv+ixnijLyNBLWjmViLujk81E0E6kxlBJvjVWgNX0X2p/F
 aZTgRC8hAMJhotHS0IwHyx+u36FAGnhWmp+j76L2wql94MM2I2hmn2/KuRIn74b+ONJxKqZ+pyo
 68FVzCUCkgqXnLICqMgfhaYK4xGxOAuBMhPTONxL/2XOIBxigJrENNFf2IxyGbJgEBK6U6niT4a
 Bwyd2FHwW3E400iOc1B3Dn1FQAcBUNigqLTZj2i+kkgZaXC/jUqejsCjYEez38uDXCDs+oLDpTw
 kyOdrVjDwlSiywOQm0SADCJd4APtJedcrJmGwCvQ/Sc3MVwXMyDvfL0U1H7Kuj/o0820s9CVkMd
 NLyODXaJSh6Pt+nuwF7O4GeqwQITQNyAgeb1xA1BxbSuQBQh52zvaHjh6POEakEYYFvoZ4cklsX
 Ce8lIZzAxODu6+q+cyvoED49NAVFE/0SIFuHhpM/8g5wawQFfJVSwzD9e/pJhcZM87EyRm8hdPs
 tb/i6tqFs6YZhLns3jaiKALBMIAFLxjFtf1EAsYU/M6N9oMmivoj+NbJQAPy9SZGz+vAMbNkmSE
 CSk=
X-Received: by 2002:a05:6000:2508:b0:475:f100:35ff with SMTP id
 ffacd0b85a97d-47f2dd4e492mr21297614f8f.60.1784128450897; 
 Wed, 15 Jul 2026 08:14:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f84sm16442290f8f.27.2026.07.15.08.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:14:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 15:14:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: a20d76761ca008d4f9485b46d59fbd2fde0a348d
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 15:14:09 +0000
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f7f2935b216b773d9ee2ceede873f12c302957a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1JW-0007Yz-M0
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5669076025070665022=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5669076025070665022==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LEvLsobEvIA="; charset=UTF-8

--LEvLsobEvIA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

flichtenheld has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1789?usp=3Demail )

Change subject: proto: correct 802=2E1Q le=
ngth check in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1:

(1 comment)

Commit Message:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1789/comment/2d76300f_e2a50df8?usp=3Demail :
PS1, Li=
ne 10: Signed-off-by: rootvector2 <dxbnaveed=2Ek@gmail=2Ecom>
I would move =
the Signed-off-by to its usual place at the end=2E I assume you did it beca=
use you wanted to have it before the "editorial comments"? Still it is conf=
using=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
89?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8219c6295=
acf28ff10ddb2fcc285f813c42fa8fe
Gerrit-Change-Number: 1789
Gerrit-PatchSet:=
 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 15 Jul 2026 15:14:09=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--LEvLsobEvIA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789/comment/=
2d76300f_e2a50df8?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"fo=
nt-family:monospace,monospace">Signed-off-by: rootvector2 &lt;dxbnaveed=2Ek=
@gmail=2Ecom&gt;</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">I would move the Signed-off-by to its usual pla=
ce at the end=2E I assume you did it because you wanted to have it before t=
he &quot;editorial comments&quot;? Still it is confusing=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1789?usp=3Demail">change 1789</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1789?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1789 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 15 Jul 2026 15:14:09 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>

</body></html>
--LEvLsobEvIA=--


--===============5669076025070665022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5669076025070665022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5669076025070665022==--


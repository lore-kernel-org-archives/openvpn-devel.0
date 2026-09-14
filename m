Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5DC88E75
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=THlAHpNxTUBP5Ky2TFXPMijrsqhegfH8BHYP/D+P53M=; b=GSP4XMjYUskmj4Qv3JaQuqeiUU
	IWnxhZiCCOIZGMTPR+ACEUfUlEDRm3K51ImctvGWCn7ChnuIiV71DtL4RUlxY7Aa/+f2spcbr4+60
	6u9FFvQTdwMZ1AmE05vlhRKMUou6Uhu345sAecrajxR8yMFF6bpnU5iWRJqTMsc/lqrI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Fv-0006KI-KR;
	Mon, 14 Sep 2026 14:01:59 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67Fu-0006KA-9u
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o5AVD8ckA3/gHfl3QRNk4959KxwikoG7ePcwMWpRfu8=; b=KKoHqTqTltuM4/aBoKHWRpkhqb
 t2ZheO8brV2n9o8CxF5yaKm/p98klW2bg7hCBr+wC2mFsfmgV/B/Q2zNCeiQk5Gu5hKNl4ic/vbIn
 INhVUigxM7qhVNlMBZaGqFQGQmmEQ9jHD0U+1J5Tk4JXmfCRIRn1Vd4Yu82J85iNUL5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o5AVD8ckA3/gHfl3QRNk4959KxwikoG7ePcwMWpRfu8=; b=W
 Hg60VIuavn1JuyglgtsF1zNOTvXhn3crCoGS4MQ6TcHrCSpqc6vDKylrapnInnNQKJLLcGqDmsk9F
 1+NGamoWPSd30+QIOy3c7SWPGMDVYLv+cHcMEOwM83Xxo8oYdPV1LmZg6gn1RNivKFzr9HOZCOUuC
 08It1iT2bzvE5xi0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67Fs-00067o-AD for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:01:58 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso17767465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789394508; x=1789999308; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o5AVD8ckA3/gHfl3QRNk4959KxwikoG7ePcwMWpRfu8=;
 b=g0fTkFktGdQS9Nmuzn2WEwISN+m10tT+hoLzRKQvuQ1mOf6wMMmQnrzjtOv4Sr37yt
 qUv6miqqFn2pEearQygRDOosAAl3LvIommA7r+mIp2VuWf2CCvoVpiW9Mnfd++RTv2Rb
 ee3NsSK91CNqnbbPOFy2wQvTkT2XyjTRc/rdtEFduB2VqWikKvsbaXrY7hepHw/KB+wK
 Q9fd5Kl/7dnVMFGWHP055lsWI6u4RwTEq2JPB+IPPqi9IAh9PGwwLp9RLgZs0YI9XYkR
 agDg58gMDiUMvGJwOUyU6kNNmeVg97AvH1DOLF22e5/k6GJGce/W26W/Z/5s/mgbpnYb
 88CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789394508; x=1789999308;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o5AVD8ckA3/gHfl3QRNk4959KxwikoG7ePcwMWpRfu8=;
 b=CgALdXAsFTjB0IUCzxnH3i4YiRFl+goe3CbI5cl3TvsN0zW0YovTmfPWt2YJospGqO
 H7u6phcr1MnKPTKIT1henp8MA8wJTGkIofLAfjaMR96htG2/GS0Od3qnKDCoMiNokB6N
 BoO9jilj5arSl69PA1t9DRyC8BZiKwSQgUx8w+TNPwejpsDLZAnHJQAwcPXf92fCDddu
 W7/TUxdphB4gwtVWYT+rbUICzS/bEJvhvV5ExmMv/Mtqut0BYEFIgT8hL6wfMmD2DyXO
 jPEUXVfHJstdEY+nDDNeanhrIMAcypwgYktDzEMyt1DvNVuBWtZUuR7uQwei6IOdpEAD
 gzVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKt077JWD6cdZIh4BwFp0sO9CMl12FkQH2zxXXqwnmMmR/N09EwROVG9UTNPetO9btSczGFrP5/Hg/hmvK@lists.sourceforge.net
X-Gm-Message-State: AFuF++lGU4vRoUM/CX7Or8T0dkeyCxjEiPOBaPFgaXQBLW8DTH6wBoVZ
 8+4EGlBb0yUgFydHuU/po2XjtC8a7Z9/nzBaXMmbW94zdDFpZpAyQLNUTssYvGCxYiIqJrD1vuR
 cGnUgpbimi/0w/dO+QhP/hamzRh8YjbZWuh1pNLmv/WNiw9Yuo36mIxNgm8XgDcSfV+Hy
X-Gm-Gg: AYBFou2Gp2CXVSdYcLuucXBAv0UXHCn+w57ZofdIhd74rUafEuNEIs1s62wsxHKtx8S
 iWc49AYUT7Ne9YjY2ToeBXa6J+Rv7TqC2Z0TpDkni84Df1WIcQ5DDWCdtZlJ3/ofv69/48LMqzf
 lWXYxcVeXnj3Om+NGGnRFz3TkP0I2pCP6S1sjpseVdJvjbIQ7z/Xso7Yr3bt95MBQUQm/MbYj0+
 NaCaxhwzEzXqbTIYLyWYAGvu9ez/vmotScScbLauvki+U7F0KK1lmocx7xMvUT2VNkbFTI3c+9T
 C03klS8TOy4KGWvRcnbUN46FPdnYlVeslS43lr/uJfypJbr/XLGKMS7+UoKcOcKWOM2wZmXZngN
 YOenr+PGGEfFfdD/jnkrUYfTTCTwegxQnVLDmXemFUEPwh6zsJ5+6fNeIaAMt1c13MLINCViDbp
 m/3AE62Tr7Hh4uu2Ky8u/eNBwyIj/CWxMqbOYuvOrja++kSSUc78ZJYxiZbNghoySqknakQWKkG
 QkcBlyFb3OkhSkpadfnJQ59UqA2B5FZjwS9V+qqytXNKuBPv0MvtSUF/pXh2nHXCugtigK1egVa
 wWguWcN7WCxrwE5kvPl29RUpPHLvZbM7bmDfvgsdhqDiY1Y2dDNulYQYBGtJsQ==
X-Received: by 2002:a05:600c:6b0c:b0:49e:795e:ba89 with SMTP id
 5b1f17b1804b1-49e795ebc0cmr36002145e9.6.1789394503099; 
 Mon, 14 Sep 2026 07:01:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d23f932sm4418345e9.1.2026.09.14.07.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:01:42 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:01:40 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 41de9be8c936523b1b7ac9316f611686469deba0
X-Gerrit-Comment-Date: Mon, 14 Sep 2026 14:01:40 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a90bc1799d7254e314a02de00ffcc33ef00b413-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67Fs-00067o-AD
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
Content-Type: multipart/mixed; boundary="===============3651859464738555232=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3651859464738555232==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kg2/mOG8w3U="; charset=UTF-8

--kg2/mOG8w3U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 21: Code-Review+1


-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit=
-Change-Number: 1747
Gerrit-PatchSet: 21
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comme=
nt-Date: Mon, 14 Sep 2026 14:01:40 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--kg2/mOG8w3U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 21:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13=
b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
1 </div>
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
play:none"> Gerrit-Comment-Date: Mon, 14 Sep 2026 14:01:40 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--kg2/mOG8w3U=--


--===============3651859464738555232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3651859464738555232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3651859464738555232==--


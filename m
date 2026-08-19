Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90E5C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=37HVxf+Tmxr6NoGmZIJk5kDYKM5x0n+3z+96Giz9epk=; b=bij+v7cTTDuWMzulRycH2DIzIb
	Oqn+dkAaAB1YebvzZrWcIW1Kb827oPM7bUUdGTOb1XiFuWrLO414yyqvsyyCzz5i6FAuHXRxtpfoY
	vvQwzaYmuLQdkZQ0av/Hxi9ljXeJQ2JD6ErYEtqIEYnoNuMOPL1H99f0JOt97iZnQxP8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwf5d-0001iB-Ec;
	Wed, 19 Aug 2026 12:08:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwf5P-0001hi-4L
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 12:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hCj277nan9QroQHBipVkPcyxE+EKVtVNWEaj6pBGe34=; b=loVPgLGgUxBoMvqzIVYCDX9S2D
 I10f40PFvC7NNSj8dTrhrsxmJHJXP+gidC8ES1LE8f9gp4VMv9wbDU9G1qBMG3OlSCPTku9RUAFVa
 OwHbWUe6nqmkHaDIVNk7cCJt3N+KZLXXxPW1OWuAI63n5ub0MpvSCGpATX/U+JWaUcJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hCj277nan9QroQHBipVkPcyxE+EKVtVNWEaj6pBGe34=; b=g
 Rw6Pr8+lHbfhRscNKT+LPfaI+XTHRDHdkZXFnYy1x8AwxB71cYiU+ty7R1shUkZSTgX0oMgQhM01+
 VadF+6Pa7UaMH02niZFSiTjfk7J4myTSIgxtrtvAbfPISHumd8j8IG8sHhiLBe1wJapJhDt7ubEC8
 p635bO2PZPYKMo9k=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwf5G-00057Y-K8 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 12:07:56 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so486474f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787141268; x=1787746068; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hCj277nan9QroQHBipVkPcyxE+EKVtVNWEaj6pBGe34=;
 b=QcUrI0PDS2wfQrsY/gfrks7gGyorqiPj1PpsRNV95wZVrWAdXAhErgHHd1oeixHKrF
 tSN2osLVkXtmlTVY9I3JeCXPYlXGSimaT+4YdnvrlXkZfnD2dq6y17YpAS8AkeQr/za3
 bl6EZq4b6ZvKStfC0WE3CC5YO3ZnBJUH0LK4Eo/SuQ67L1ExC3GghXFclC5xgJJjFgDG
 gYkCsUiRA46aBhtv+MX/EISt5d/pKNLKzhD45oAUvuBSaehk0AmmTPGPEDTrWpX7l+3/
 +qENzPlczhX7erwQ5kSwBFHJuVoFrp2/WtNmNEpUMRgfCF8fg0FexcKA6T2CbUZI5rQb
 7ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141268; x=1787746068;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hCj277nan9QroQHBipVkPcyxE+EKVtVNWEaj6pBGe34=;
 b=W7lURJgklB8N7q1Uh/FBZXq642NcuRs1pdRwQMHbBMuXMLGf+HeTeHI4l0XeTiprWE
 iuMxM06xN7QLppc7OADqsrRRzyDFEMtFDzs23WUeVp9dULraYfsy1E6Ee+srgQppd6Pa
 x2zAt1gq+Y9u9OmM4SS1dsYd3UsQNghKIgTSacs7xrvuBaHZ7eVE09Kd+LnaoQQYXPfI
 KNbp8N1UGkIaB0MsIUF4bYKs84k1BEK7Eyq///UvvNn8wpaOEDrp0q7PlVUkBqqfTaBr
 CKcSy5sc5H2QrRd32XogxLKH90q94yDhbCMR6DeegseBwoVMGJiMLIrUJorI3eCjtoEJ
 uu/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyJtv+jOqjL1ddw3jIUR8cg2jzwenStAwN/S7bpMLl7a7cMC3sHmGfP2+0Yj7fLFTRZ6awaQ/r+NI5gPMZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++lSw2s+hLHk8Ykv7uDDvciwWyVpFeUmq+KEwRbQp7cW+0k9wU63
 EiRA/ztbx+s0f6hkmuGZB8l7CvcErWfi6j/ip86HCeE0AQqMMKJxTNMfdBOfpIUmiBHNUgTZeur
 HP3Sn6WHSiCatee1FBI2Xz+WvYzbiExV7k5SWs4dzITqGw698nUI5DzvqAyEy68bRextB
X-Gm-Gg: AR+sD13PUpX+PSpDzT8ZIpQ30fDhBddvYpKm7xS2pkqjihBur9FDBTJKgeQg8a2v2RY
 n6ZNN23osLLM/h0TF5ZphBckEoG1QVA+d3t6nDIpjhVKBa3j32oqgEqrfQZvBbzZvvCFUh+dtDp
 u12XlufzK7YPsezaIFzmuTXIMSoY1ahh4ap8qnf2W3QzCClD4tWAahkuCYZqVIT0BBReKF1fKto
 F0QsWEKVc3AGuh+h+OYyiGi7jiHlEmgMRo5zzEJ2QPH4LEdd7iQSFUjX4xC75/Jbk0yZVx3oQb+
 tgb6WU6jg/1D2RyQNm7JMHcGXQapcV6Mb6rBHFOmD0JKRcnjfxNY/NbI5xU36NwaCJr6Zba8Dbw
 63p24yw6FA8ICgg4hfWhZWeb8p8gIEv1Ya7qHG+lySYnrmPgYrVPNP0JIXuEeynN1wo56NpEaac
 oRFimHFwB6pQdiorPVRCokXpGFdPCl/W/Ju48XBvf4fITZUWTiixz9Asr7w8/dKB5ojmb9cazCg
 Ls1izDwzqag441FdI+QX0sQQWGrGjTc8nPTbOk4++vKq7q7GAWGmwgZC+13/+kL8XeMcPqpwbzc
 J1kTjxgE/LML8OMBRBv08uOIJH0r7V9RTp9+IDn7/69sSc+UJojVYeR2+PaWtA==
X-Received: by 2002:a05:6000:2c13:b0:47f:f3d4:26da with SMTP id
 ffacd0b85a97d-482b1fd4978mr6636230f8f.11.1787141267908; 
 Wed, 19 Aug 2026 05:07:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8050sm5381971f8f.19.2026.08.19.05.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:07:47 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 12:07:46 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 532f87b9cc89ae14ead0d9cd9884792e704f9a49
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 12:07:46 +0000
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e53024abce5a712ded7333105f0229a3e4613176-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwf5G-00057Y-K8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 gen-release-tarballs.sh: Fix some shell issues
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
Content-Type: multipart/mixed; boundary="===============6497513917481833035=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6497513917481833035==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tf6Oe1jlskM="; charset=UTF-8

--Tf6Oe1jlskM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1847?usp=3Demail )

Change subject: gen-release-tarba=
lls=2Esh: Fix some shell issues
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File dev-tools/gen-release-=
tarballs=2Esh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847/comment/8e04=
cef1_c9d4c2f6?usp=3Demail :
PS1, Line 1: #!/bin/bash
On second thought, thi=
s will typically live in `/usr/local/bin/bash` on FreeBSD, so if we plan to=
 run this on FreeBSDs as well we probably want to use `env` here=2E

If not=
, the +2 still stands=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1847?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Change-Number: 1847
=
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Wed, 19 Aug 2026 12:07:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No

--Tf6Oe1jlskM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File dev-tools/gen-release-tarballs=2Esh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1847/comment/8e04cef1_c9d4c2f6?usp=3Demail">Patch Set #1=
, Line 1:</a> <code style=3D"font-family:monospace,monospace">#!/bin/bash</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">On second thought, this will typically live in `/usr/local/bin/ba=
sh` on FreeBSD, so if we plan to run this on FreeBSDs as well we probably w=
ant to use `env` here=2E</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">If not, the +2 still stands=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1847?usp=3Demail">change 1847</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1847?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1847 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Wed, 19 Aug 2026 12:07:46 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>

</body></html>
--Tf6Oe1jlskM=--


--===============6497513917481833035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6497513917481833035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6497513917481833035==--


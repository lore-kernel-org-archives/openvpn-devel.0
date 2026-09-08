Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77204C79FA0
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfVx6C2FxxQwWjq33EuBA8dWy9/xTXalS9VGyT+emqM=; b=bYo68bTSYJe6z8kbID20OQKCJW
	9mpazaX706T3Dgi8yO0HqDW5fkkPvOgN+ekc+DNWwZH1+lOVq5BMAgLYdfLkomABLiIVcg91yeRaT
	GI+bT4UXf3BixDz57BWFlpVaik2GsNLX7pQlaV6141kq+7vpGzAepC2HyP/Kes8OsDac=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3rbR-0004cy-5b;
	Tue, 08 Sep 2026 08:54:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3rb5-0004U1-JN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 08:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bTWabIGXtYtGKlIiUH80tiDZ0AqO9aGLIt1D8N0Gol0=; b=XMwSQr1a4ePilbBzXlz9UlcumQ
 3IJ6F3SxLUOPNzxidY0lMmh/6YPN8h+4kOy5ihJazmnOKQqGrwja5D191iBgGh5q+527S1SRQoHt1
 7zHvdn+YtEFGzREv/i2L2Xl4+moTueaWT83zCbExCqJzCLLYTxBb+HPk1QDVUqdtiRL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bTWabIGXtYtGKlIiUH80tiDZ0AqO9aGLIt1D8N0Gol0=; b=b
 HIQjiYpOBufx1B6Fc0beVf73Z6H899jgGpfi/KxMix19WmyJ4vU2G0oxMN4I64LaB4bHrZly6Y7B8
 Uh6Z3o32k8pKypVL72PAc58GH6Di4Wb0IK0PcaXION4KBajJmDK6v4Bws6dGAluww1J3Qx+A3J/nD
 PHTdyUPndhaG3rKw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3rb1-0007Lm-62 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 08:54:29 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356256so390841f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788857661; x=1789462461; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bTWabIGXtYtGKlIiUH80tiDZ0AqO9aGLIt1D8N0Gol0=;
 b=e/o/TG995ZFCqBFPO4ZDOrnRBc1Gjto12wEPooRLmP40U9C/OCfUz57PG2w/JstNwV
 0x393/ckaxczwiqFy1yDPTboEsCt3OZSL7ieISzXlBPoBG7WhX56zpqJkxmCQIy0+MVs
 4J1fWlQAr0sTEg4DrI3s5lR2GSMWNTGsaFBllyWEG6jSlPLFLs663zBTU5SjDmAgcaN5
 TdUfd5hVw9AhbxRQ6vMSYtjS6FxryjdTfrIwy2lKwChOBGTDtkVvkDjgAAPy9JGdzcA5
 0mnzYlDewmTWV+0nE+0eJLn4MPXAKexnsIeXziWFlgWfyR5mHSIQkEfR1yGDq8YyeSla
 JnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788857661; x=1789462461;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bTWabIGXtYtGKlIiUH80tiDZ0AqO9aGLIt1D8N0Gol0=;
 b=ghmrJP+pGBBcPSqECkwlUF9GDGdkM02sBmiaJccUQQfJymC9lcgLNlDGXOgawHKXZR
 L4r1+O6mk44Mh5LgS/USLHKTUS2gCdrvQVIvOxfAxXMmKn4rwU3xrIgzTGiL9D+Gnboq
 /6gXalfd289SWc+RowLazz65HGVQKK39v+pw7M+YsbfJHkEvkGDW4x7GWrBMS2sIuW5b
 zadGkozD0X4IZW+Bmza+1qTR4mQQBy6kSaaodFTdGRPM+/27RhxhgS35hB3cS2umc1/t
 k/4M/OaNpDN0P+bAcJKeexFIJycwTeWtHMOo/o7siGUGwtvW2pLsvatrsbMaERXeh/hq
 d4hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwegm44d59c3BZux02ZKBtAMPT/DV8SQmiQTZygACmJU76Sy1sj6S/aAUPeVf7szGxih6RsyrS7+pOeB3Hn@lists.sourceforge.net
X-Gm-Message-State: AFuF++nryp6zig2lGukn0ZbnkyJsm8fCx6TrnsxlqHLzb9nvsmzwAKQU
 c77BJdEiIzauEZh3wLcbL0Vs8LiZzrahZtYCN2k43dWvOPg11z1Cj85Ww2b0uZaBwAPEfHsR94a
 gkitA9zIy62dkvnyY88vHaiOVawFrNIzQ6gJk9spsrzAQO1snKgN4Y68Jge7N47CYs8+c
X-Gm-Gg: AYBFou224go1aMljkJHidC/LYy07V68LHgKwIAoCewAKsTo1F9FjG2rpYxOCqO0OU7P
 ZOsg9YOgLQ+sGwHLafxBMtA6AHpd+7KaTgJI8cNrMbTpvjwZQPhLaBOjFZeOjURbmPU9jb8Iifq
 WVR/5Vs1i9v7WAKXTK62Az4ZVQ1dhd32KKlP11tptpGYh4iC/U09FYCbq3B6sNQhvLjDXMQmbCQ
 wVfVBqK3dwffas061TDRGeSTfR/SIy4F827E3LFUUe8OANZl1OFWaBoHX6vNmucXbYf3Qg9DzA4
 D7fr5RhcOF466AloEarszSaio3nWG2h5ExQrE3KJQpHv7CO05TaFGAwSAmhPOfucx9VTHhtZJai
 OVXx/GFzKinU5/tZcM8xWA8rwLmXN+rX80IqOz6OUdECyVH4nrr6Ug7R4O0msZLZSHik0GI4Gzy
 h01no8xOqDzMVZiMUkqYvvFwJXLx41gP3fuea6mvFKAiA59VDWTNcFxZfnsa1sJSoMgnoyfdl/h
 bfEvLM5vZyxQRfMNCSdwfA+jjLb3nEkBlOc/S23K/ETinv1CMnrA9EYsZqOoK3EX4iMcRmuq2Dq
 vhHqPDgxavpf0gjqtVje+vV7Ic4BH4wPsMJTrCuUJJBu5ILb+fI=
X-Received: by 2002:a05:600c:4455:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49d1754fdf6mr57086475e9.6.1788857660456; 
 Tue, 08 Sep 2026 01:54:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d08144037sm285346895e9.7.2026.09.08.01.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:54:19 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 08:54:18 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: a5e4c6c7420d0a40fd560f4b51a5e3796d101fec
X-Gerrit-Comment-Date: Tue, 8 Sep 2026 08:54:18 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f87dcdbd7db457ba45927a834d04ada9a4197018-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3rb1-0007Lm-62
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3586019638057195715=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3586019638057195715==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nAvM1UsrDbM="; charset=UTF-8

--nAvM1UsrDbM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SER=
VER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: Code-Review-1

(2 comments)
=

Patchset:

PS12: 
This patch adds `tls_wrap_oob_standalone` and the corres=
ponding `tls_pre_decrypt_lite` path, but does not test them=2E What do you =
think about adding round-trip tests analogous to `test_generate_reset_packe=
t_plain` and `test_generate_reset_packet_tls_auth` that wrap an OOB payload=
, pass it through tls_pre_decrypt_lite, and verify the verdict, session ID,=
 and recovered payload? Ideally the tls-crypt mode should be covered as wel=
l=2E


File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1744/comment/21ca661c_cddb43dc?usp=3Demail :
PS12, Line 241:         stru=
ct oob_probe_reply reply;
This would potentially send stack garbage=2E Even=
 though it is fixed by a later patch, this commit should be correct indepen=
dently so I'd add ` =3D {0}` here=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-N=
umber: 1744
Gerrit-PatchSet: 12
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-Comment-Date: Tue, 08 Sep 2026 08:54:18 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--nAvM1UsrDbM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1744?tab=3Dcomments&amp;usp=3Demail">Patch Set #12:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This patch add=
s `tls_wrap_oob_standalone` and the corresponding `tls_pre_decrypt_lite` pa=
th, but does not test them=2E What do you think about adding round-trip tes=
ts analogous to `test_generate_reset_packet_plain` and `test_generate_reset=
_packet_tls_auth` that wrap an OOB payload, pass it through tls_pre_decrypt=
_lite, and verify the verdict, session ID, and recovered payload? Ideally t=
he tls-crypt mode should be covered as well=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1744/comment/21ca661c_cddb43dc?usp=3Demail">Patch Set #12, Line=
 241:</a> <code style=3D"font-family:monospace,monospace">        struct oo=
b_probe_reply reply;</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">This would potentially send stack garbage=
=2E Even though it is fixed by a later patch, this commit should be correct=
 independently so I&#39;d add ` =3D {0}` here=2E</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?us=
p=3Demail">change 1744</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owne=
r: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Tue, 08 Sep 2026 08:54:18 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nAvM1UsrDbM=--


--===============3586019638057195715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3586019638057195715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3586019638057195715==--


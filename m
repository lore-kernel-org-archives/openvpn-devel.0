Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78494C79F9F
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXhhtfHaWxPNcDGarTaFiy19Ir56+cH8KFCFlxyjBeE=; b=W1/axKztzMazanSUXmgkK/oHoe
	w5er56QhyI965hh5XIjwhHvGJRFIOn7VA3iw7PXT1Pswsa99J2C5ZaNtRWpcjYzdUeo2x10m2TwuA
	0zfyq6kF7xfmwVP0JjNAiPyOG/6wYjkquiaHfTeW1av5EsFSfe504P5EclF+vcAmAlk4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4cet-0008B7-Rb;
	Thu, 10 Sep 2026 11:09:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4ceX-0008Ao-Ix
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 11:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+wquXfUK+MRooUQ8Q1LghsIQbNyaPKsDDeI/B4zCQwo=; b=KAmtdwrrEqJLR/GO/jRI+vI/0r
 Zdk9Xeia0hkrPry4o37ypcTgsJ+EHk3Z3CSU9y2mpaaiZP2s6SxfiF4BYbdCRHwuYNzDi2GD5OzPg
 8fXN2AgexrE2MEu8igCCvW1XVwr4qqefw99HxvdZG3b3Nbyz2bijadhh/ehoKRSxpCgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+wquXfUK+MRooUQ8Q1LghsIQbNyaPKsDDeI/B4zCQwo=; b=L
 GETU5DkHJzAyBnI8P+0Xs4RiGZiEUqcrbXtKMUAzsJMpQm8iV9KCjM/E7nG8UV/KsF/gZxVl4UkQC
 RXhOqJ6qNwiX58ImJGxExs2ZH/1e8biL28jUYo42vIsW/XtlxAfGF49RtmPbagZG5UET/TJGmGKDf
 tW4JGy/BoIAgVpJY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4ceS-00060A-Ss for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 11:09:10 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso50914035e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789038542; x=1789643342; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+wquXfUK+MRooUQ8Q1LghsIQbNyaPKsDDeI/B4zCQwo=;
 b=f5thA6r5dbzhxt6kYKQgmS6v9WocccNwxqin5U78HypbRaQZlBlrVoPYWrDPOktWOx
 TCRk2F+xExcIFF4HR9512Gm/BVt8FHP/CHDjjgOshWZtw8R+s2GAtPMHmh9wvC+ssMgv
 I8jjyuLZ2DqNqkPY0+5tAR35HdQk9vK+X5yMSTKQ2rFgZxUV03Way98bsiz5tBQDepQg
 HFPD9Elf6F1YOdYd1PL7wEU5ZU8n3g7F1TqENAtBeEbG0ERwImQGEzNQsMfUyB4MQFbs
 RP2CDL3gwPpgyDiD5H5AwdeTbOVqXdZoK0TduuM2/kSCZN2Jm+cBTjEqg6+Dr1Jo0IEy
 DvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789038542; x=1789643342;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+wquXfUK+MRooUQ8Q1LghsIQbNyaPKsDDeI/B4zCQwo=;
 b=Ycdm9gjVgm0IoPgW6O65u+Ri3SxlYDmNG56wlPTGHs+D+JPtQj6XRWdoVZBy/lFtJY
 tI1vq8D4jJZ5vwBtdyM8pspjSB1dbNApkv4+my1KxY1u9SrZn2aRPVs1PI+pn1YGyNN9
 qQTUq7T76mXI9fe5PFVyiFP+C7JmMWCX7Z+bj3J2rMocxKA3jahQ09jkw4EqZi5k71a/
 v6FJ3T9jbP79499MpBuGlQy6O+WQ+E75JeG8dX/dtsTuYRVKXFkKvM7fuc9+GRjr0DSr
 R3Un5T/OzY752J2z5VnNVQa+IU/tOKTAyNY1qqKLvZfSjT7cV0uYBSIVO99/yrp/tyuL
 acJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ0dx4x5D/fv+SkLATe1Dyf35GaWQ3hxdxLhdXVQutt1MIcylOqVgV36icHsKz11qQ2855dzssNcz93b+L@lists.sourceforge.net
X-Gm-Message-State: AFuF++lQWWWhwkRRPzQd9YtyQX4UtdoQHakSI8h9qZQ/qGQBwTX1bmNh
 QXKAA7pTCB1p7cudRYOA4wKYztk2n6L1BuqIE8qF76m/i3C+uIN/DIqvAIEgXc7zMJInt/R42k4
 Qk9SY7l3cYXp95pJ3qFh86GWveQX7DdGa6Fab2yA0fMzNRaJXC7l5Nk5xAMvdDLMhQa7V
X-Gm-Gg: AYBFou0wD18EDujCW5PrShb820HA9FLnVrFLr+IvmirVXgor+5m/ghIDkUPqLk8iZ5S
 pAcSjexnSHjhoEH5SqE3qwu93HRdLlact/tRLpcqeToaNALqyIbyEuMuwY9ru4m/sgZKgvJbOSl
 cU2bseCafuTQ3JdCdQrJTd1O3yY8XCt13Pwxcg5qgy7yIY9+5BMM74sZ2Ba7G0T8Payz2tl9UEH
 EZiuOa+eLjmkrZ9TpFHteY+G53ii7ogOIm8jbM8zlaaFxp7hDKBskaV40G+ewtCfxLaCs1w8HWq
 ruBEjL+MOmf7t1WI6ndODgzQuXCSTNDfX9adCM1ftRoyZ8u4Hdh8TWDO9Kp7v7MpvU9Nss3CIgC
 hWi6tq22ckkWtijdys7fOnFNVPdjIn2KjrZuE+qbNMdzxy7fJuYsAPtsfMIzaHuqxEWkSYmP2Ij
 ukl1+iFLeFwNAAG95yoLA1N8sYl0VGR2uY5eT2U5T++MVnuNAqimt1oXjXUDeoewUsBEU6bSych
 Y+NxgKk7aV3m0jYq3rh/dgkULHl6D1/TrzbTadd6eM2eKotifx4g5Ra83/awfXGqJRKEW/OxZek
 QlwaeP1hu50Z7JpENlwN2lu9TXaNw+3sUcAIWNiYj7VOfKOwPyLGrRT99TuEZw==
X-Received: by 2002:a05:600d:650c:20b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49cfc6cc026mr300700745e9.31.1789038542018; 
 Thu, 10 Sep 2026 04:09:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm36447995e9.13.2026.09.10.04.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:09:01 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 11:08:59 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: e7dff97bf39b89b4abc37042a480e3e1655be4f1
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 11:08:59 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0736b1f417570cb939230af425997414e3b7514a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4ceS-00060A-Ss
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
Content-Type: multipart/mixed; boundary="===============5129058600424334745=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5129058600424334745==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Da+JiGBoDCU="; charset=UTF-8

--Da+JiGBoDCU=
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


Patch Set 17: Code-Review-1

(5 comments)

File doc/man-s=
ections/client-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
47/comment/92102c08_eb01e67f?usp=3Demail :
PS17, Line 619: TCP remotes keep=
 their configured
              :   position
nit: Responders are sorted bef=
ore all nonresponders=2E For [TCP-A, UDP-B], where UDP-B answers, the resul=
t is [UDP-B, TCP-A]=2E TCP entries only preserve their relative order among=
 the nonresponders=2E


File src/openvpn/oob_client=2Ec:

http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1747/comment/bb8cadea_66b250b6?usp=3Demail :
PS17,=
 Line 101: so a remote is always probed on a socket that can later serve as=
 its
              :  * connection socket
The raw probe sockets do not go t=
hrough the normal connection socket setup=2E `--local`, `--lport`, and `--b=
ind` select the local endpoint, while `--bind-dev` and `--mark` can influen=
ce routing=2E Consequently, the probe might not use the same path as the ev=
entual connection=2E

Applying `--bind-dev` and `--mark` only after adoptin=
g the socket is too late to affect the route used by the probe=2E More seri=
ously, a profile using `--socks-proxy` currently sends the probe directly t=
o the VPN server, bypassing the proxy=2E


http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747/comment/2623237f_47fdc6ed?usp=3Demail :
PS17, Line 178:     =
                           (const struct openvpn_sockaddr *)(const void *)&=
targets[i]=2Edest))
nit: What happens if 2 connection entries resolve to th=
e same addr:port? In this patch every matching reply is credited to the fir=
st target because the search always starts at index 0 and then breaks=2E Th=
e second entry therefore remains marked as unresponsive, even if two replie=
s arrive=2E

The later "probe every resolved address" patch skips targets a=
lready marked as responsive, so successive replies may populate successive =
entries=2E However, the association then depends on how many duplicate repl=
ies arrive and remains accidental=2E

Could resolved endpoints instead be d=
eduplicated, with one endpoint result applied to every corresponding connec=
tion entry?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/780a85=
3a_86111f76?usp=3Demail :
PS17, Line 343: client_probe_and_order_remotes(st=
ruct context *c)
Just a followup idea: could the probing phase expose its r=
esults through a one-shot/query API, rather than only reordering the connec=
tion list and immediately connecting?

Maybe a structured result containing=
 the remote, responding address, reachability, RTT, priority, weight, and r=
elated parameters could be consumed by the current automatic ordering logic=
, a management client, or a standalone information command=2E

This would a=
lso support the RFC's stated use case where the final server selection is l=
eft to a UI or another client-specific policy=2E Not a blocker for this pat=
ch=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/57683f06_f34=
08b0d?usp=3Demail :
PS17, Line 408: AF_UNSPEC
Resolving with AF_UNSPEC seem=
s wrong, we should probably use ce->af here=2E

If the remote is non-numeri=
c and it resolves to multiple ai results with different families, probing t=
he first one might probe through the wrong family=2E The later "probe every=
 resolved address" patch does not fix this: it still resolves with AF_UNSPE=
C, and the socket-availability check only verifies that a probe socket exis=
ts for the resolved family, not that ce->af permits that family=2E



-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae=
2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 17
Gerrit-Owner:=
 stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Comment-Date: Thu, 10 Sep 2026 11:08:59 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--Da+JiGBoDCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 17:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>5=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File doc/man-sections/client-options=2Erst:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1747/comment/92102c08_eb01e67f?usp=3Demail">Patch Set =
#17, Line 619:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">TCP remotes keep their con=
figured<br>  position<br></pre></blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">nit: Responders are sort=
ed before all nonresponders=2E For [TCP-A, UDP-B], where UDP-B answers, the=
 result is [UDP-B, TCP-A]=2E TCP entries only preserve their relative order=
 among the nonresponders=2E</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
47/comment/bb8cadea_66b250b6?usp=3Demail">Patch Set #17, Line 101:</a> </p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;"><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">so a remote is always probed on a socket that can=
 later serve as its<br> * connection socket<br></pre></blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The =
raw probe sockets do not go through the normal connection socket setup=2E `=
--local`, `--lport`, and `--bind` select the local endpoint, while `--bind-=
dev` and `--mark` can influence routing=2E Consequently, the probe might no=
t use the same path as the eventual connection=2E</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Applying `--bind-dev`=
 and `--mark` only after adopting the socket is too late to affect the rout=
e used by the probe=2E More seriously, a profile using `--socks-proxy` curr=
ently sends the probe directly to the VPN server, bypassing the proxy=2E</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment=
/2623237f_47fdc6ed?usp=3Demail">Patch Set #17, Line 178:</a> <code style=3D=
"font-family:monospace,monospace">                               (const str=
uct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Edest))</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">ni=
t: What happens if 2 connection entries resolve to the same addr:port? In t=
his patch every matching reply is credited to the first target because the =
search always starts at index 0 and then breaks=2E The second entry therefo=
re remains marked as unresponsive, even if two replies arrive=2E</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The la=
ter &quot;probe every resolved address&quot; patch skips targets already ma=
rked as responsive, so successive replies may populate successive entries=
=2E However, the association then depends on how many duplicate replies arr=
ive and remains accidental=2E</p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Could resolved endpoints instead be dedup=
licated, with one endpoint result applied to every corresponding connection=
 entry?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
47/comment/780a853a_86111f76?usp=3Demail">Patch Set #17, Line 343:</a> <cod=
e style=3D"font-family:monospace,monospace">client_probe_and_order_remotes(=
struct context *c)</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Just a followup idea: could the probing phase=
 expose its results through a one-shot/query API, rather than only reorderi=
ng the connection list and immediately connecting?</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe a structured r=
esult containing the remote, responding address, reachability, RTT, priorit=
y, weight, and related parameters could be consumed by the current automati=
c ordering logic, a management client, or a standalone information command=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">This would also support the RFC&#39;s stated use case where the fin=
al server selection is left to a UI or another client-specific policy=2E No=
t a blocker for this patch=2E</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1747/comment/57683f06_f3408b0d?usp=3Demail">Patch Set #=
17, Line 408:</a> <code style=3D"font-family:monospace,monospace">AF_UNSPEC=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Resolving with AF_UNSPEC seems wrong, we should probably use ce=
-&gt;af here=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">If the remote is non-numeric and it resolves to multipl=
e ai results with different families, probing the first one might probe thr=
ough the wrong family=2E The later &quot;probe every resolved address&quot;=
 patch does not fix this: it still resolves with AF_UNSPEC, and the socket-=
availability check only verifies that a probe socket exists for the resolve=
d family, not that ce-&gt;af permits that family=2E</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747=
?usp=3Demail">change 1747</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 10 Sep 2=
026 11:08:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</bo=
dy></html>
--Da+JiGBoDCU=--


--===============5129058600424334745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5129058600424334745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5129058600424334745==--


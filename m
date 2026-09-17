Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E75C982D1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHA477rA0EG8pqcujEqrCqJ7Ib+tqroT4xOmHSXxzhM=; b=VXYYTr1PmWWZLV9mOd6L6EI98W
	P6omrE1en+3UbsOzBUvnsG7ELS/IhNXRBr5yFEkWwf2qKsngMFmEzhGBCmgBQe+ipiDwV3QqwIEO+
	ilru+cJ4OJv3G55a17ex6KDwYIcnIFvOvoFirEvkds3sDqLVTCANNsCPwcU5Lo7QnlUw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7C6P-0006xJ-D2;
	Thu, 17 Sep 2026 13:24:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7C6O-0006xC-Bp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KAeAjr1pyqKT/nubjpTV8C1y4uDrnua+ghVacbBwuyY=; b=k0qXeYs5pQ2c5RJdImLurofw/T
 17ZnP0YR7ZnpRG+GINXP8np8KcKO9AxQ9znoxYaqrs7NpSZMtDI54ozPg53THu7NtLp2AoV3C8yd1
 5rgwePeML4lKc9Uk1wfFMUuPbWQorOnkQI7zFFOpwEnMMkag92ZBHKbbuEUZJnTtYjfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KAeAjr1pyqKT/nubjpTV8C1y4uDrnua+ghVacbBwuyY=; b=h
 JRHCHgTTUI2Fc3/uVP38euk35FoaJiLAVVmkFn8BUvFF5UtPSimvVw+m80UNZCBv00xEdzxpjmqkP
 34TbnhizBcGJCpfShLCgOgCcwbPtBv015eQVWBJJ7/7f8GnGbTd4OJ2SWp0M5qq5uohctGbQUpzna
 AiMH8T8fqSWFR29s=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7C6M-0007fp-Vy for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:24:36 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso10202105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789651468; x=1790256268; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KAeAjr1pyqKT/nubjpTV8C1y4uDrnua+ghVacbBwuyY=;
 b=NK1WrkD8lC0xMGTQS5tTpJfsO/Or6LEjMDOT7X7POLBhcRXix0QYKDotQYqrMxSAov
 BBKrZX4c+3YLa9rKzCuLOBKjHFmfUxwe/q5whJ1fbDACq3nePefS3uL231/4ojFrgp6a
 UpAfBlJpL1swXpwzrH7W70FKO1wPZcGyaYrxblKDXTGDX7VJRrglXD3u2NRXTpSXYop1
 1BTu8TJPVykghEvkku3A7tyjfgbmIeS/REQbGOxeM4LdbcJV6pfnZwTv29je4QbdmlYb
 cBmUK8Fh3f/Q4Ok1kZINXqUbcYKUQ5ONLAKJnBY8ZnE0CznqGqU/gtgmfjHTUcwabkHP
 UdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789651468; x=1790256268;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KAeAjr1pyqKT/nubjpTV8C1y4uDrnua+ghVacbBwuyY=;
 b=zC50vlW2PPl2A9SVeRdEnWHAP8yifYXUqzxO8NFP/htqurUJwTiFF5DbuuLECrj+WI
 RGyJp+dA/9l8HPm/tfGhpKxzRdO0G1+GWarh5i/id/+5Vz8zL5GnfoIK+ZnL/NnNWwSZ
 YudNbKAIFLCXIJawYdn9JQIrLRz63O3nfk2wbY0NiRQNSq8kCjDLvWjJpdJSQnXnJ9y8
 DzLX+JSfOVAL6U1PAAcD9GBneWhg/XDEdFXft78q99urT0QdJAq8Nhc4Sj3t53Lh6YmT
 qgBCyv7D/bOeV7R2d7++9EqwEyt07IFXKdJpBjAwHebLNYHx7uSkiubPruC6mBm+NDS8
 XChQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBymiv9xHCfESA93fQk4Fjuwi+dpQJnI6wi3eYu8i4gIhKTC+LoLEtPYZ3Nka7Rcm0n32H37uQAYfHuu2rnJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mLKG+a0lK7KQt4GV6T4xz8ZpWubDhjHzCIMeBfTRwr8qJhGfwu
 RmrEGF5kPn50SULukY2FJMhdDSTh3ElLAMWh4y0MMJoT0BKunVGfGKmJniFLWR0c8JEIC5+gqxP
 /MutMCB5crjeavZiATmjFe3mWLo+sY01GbJI3MWEIncbQB6MHDqsSUfhRx05GMmxRGO4Uj/zUig
 mM8+vrew==
X-Gm-Gg: AYBFou1Jxzd7VIViK3epcC+N4jzzFEGB4ueIqxzUMPTsMQeLIaeb5yi9gGyQ1LHIvgF
 ZOf9c4yzEb02wS2TuEHEAwpl6Xd9IWcNFRHTN6SxZUoZH6d9zm9Up0eEWoCHTWOW1MyyT4bobum
 RJe6JK9VDFMioZTPxWn1pmZzZh5dm4oSjYuhz7MeGrHRX1caRjCupXLh7wGevTzFyVXdnfOEB+U
 weFCqmdUTkXgSlfLzWXE4bx778688aWBeuojcPaB4RQETCd8SMvgOUARSWlhWHII1HCX9gcd2Zu
 4Se5TBPO9A0NUMI4JT6qToVk+1iakHU56s91Sxrr5zEmRvN25mK1k3WDHKkEZ+TW9VhoOBcZ0St
 r5AwMafC2F6NlTB91AoTMwn4gRuX7HrcLz3U0h+48uTviggvTswi/uwKHT7ns1RCDBZcJYtguUA
 Th2T8tD982zGxNoLWhMP9LQVN61eLfNN4yYvIh/scbgBjN7mT9u2uwQjPBhVuYryCUqg8h0a7Hk
 CVxLc4CfPB4YEhkUuaGRjjIpDQJ66LGfqMQtCJjBKFKn3GLjwedFku2LF3+9P+BlDWTSU4GJ8IE
 VRMPuwhnWH8d9yYMY9sHZ2Y8NQKSniim/Oue/vMq1bcQHY1NApXAeGkKXF2H4w==
X-Received: by 2002:a05:600c:c48f:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49eac4638e7mr111810055e9.3.1789651468221; 
 Thu, 17 Sep 2026 06:24:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27c65sm16283676f8f.21.2026.09.17.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:24:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:24:23 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 47af139f1160a47717d57d0d54f8ccfd84eaebbb
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:24:23 +0000
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <55770e0910baed011f40289d4b8ef3515b1e4391-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7C6M-0007fp-Vy
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0280908669828010166=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0280908669828010166==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Zm5TCwOlOU="; charset=UTF-8

--8Zm5TCwOlOU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici, stipa=2E

plaisthos has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail )

Change subject: oob: Add --server-probe-reply=
 to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 28: Code-Review-2

(5 comments)

File doc/ma=
n-sections/server-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1752/comment/dbc114bf_a9b13251?usp=3Demail :
PS24, Line 671:      server-p=
robe-reply off
Since the goal was to allow eventually the server probe to b=
e a better way of three way handshake allowing a user to turn it off works =
against this goal=2E Why do you want to allow it being turned off=2E Is the=
re a good reason? If yes we should discuss that reason and alternatives=2E
=


File doc/man-sections/server-options=2Erst:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1752/comment/1f9209be_ccb72e66?usp=3Demail :
PS28, Line 688: =
  servers of the same priority proportionally to their weights=2E
Should me=
ntion if low number or high number of priority means better priority=2E


h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/db85ad8a_3cd95c4f?usp=
=3Demail :
PS28, Line 701: 
gets little what?


File src/openvpn/mudp=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/2e8cbafc_d882789a?u=
sp=3Demail :
PS24, Line 259:             =2Epriority =3D (uint16_t)m->top=
=2Eoptions=2Eserver_probe_reply_priority,
If only uint16 is the valid range=
, then the type should be uint16 and not doing casting here=2E


File src/o=
penvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/d8=
eb059d_c812534d?usp=3Demail :
PS28, Line 249:             return false; /* =
--server-probe-reply off: exactly the probe reply, nothing else */
I don't =
understand what "exactly the probe reply, nothing else" means here=2E



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf6=
35ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 28
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 13:24:23 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--8Zm5TCwOlOU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici, stipa=2E </p>
<p>Patch set 28:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>5=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File doc/man-sections/server-options=2Erst:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1752/comment/dbc114bf_a9b13251?usp=3Demail">Patch Set =
#24, Line 671:</a> <code style=3D"font-family:monospace,monospace">     ser=
ver-probe-reply off</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Since the goal was to allow eventually the s=
erver probe to be a better way of three way handshake allowing a user to tu=
rn it off works against this goal=2E Why do you want to allow it being turn=
ed off=2E Is there a good reason? If yes we should discuss that reason and =
alternatives=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile doc/man-sections/server-options=2Erst:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/175=
2/comment/1f9209be_ccb72e66?usp=3Demail">Patch Set #28, Line 688:</a> <code=
 style=3D"font-family:monospace,monospace">  servers of the same priority p=
roportionally to their weights=2E</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Should mention if low number o=
r high number of priority means better priority=2E</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/db85ad8a_3cd95c4f?usp=
=3Demail">Patch Set #28, Line 701:</a> <code style=3D"font-family:monospace=
,monospace"></code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">gets little what?</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1752/comment/2e8cbafc_d882789a?usp=3Demail">Patch Set #24, Line 259:<=
/a> <code style=3D"font-family:monospace,monospace">            =2Epriority=
 =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">If only uint16 is the valid range, then the type should be uint16 and not=
 doing casting here=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/=
d8eb059d_c812534d?usp=3Demail">Patch Set #28, Line 249:</a> <code style=3D"=
font-family:monospace,monospace">            return false; /* --server-prob=
e-reply off: exactly the probe reply, nothing else */</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;=
t understand what &quot;exactly the probe reply, nothing else&quot; means h=
ere=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddb=
f635ee85a2a6cedc3d8 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1752 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Thu, 17 Sep 2026 13:24:23 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--8Zm5TCwOlOU=--


--===============0280908669828010166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0280908669828010166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0280908669828010166==--


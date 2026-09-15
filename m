Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F5FC982C3
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4EngrkXxbr1vObLl6plhYeCbKg511N7f8cBvpG96DeU=; b=W/zyzQkTlwaERsF7WJ3GWckdv9
	pkdwljTEKvp1JDVfCKfi2qfY4XVDNCnxk87JdrdeVq1WhylAvBnsqPrdeNlYytUEscXkcoqKh3IOe
	o0RB6eVuYC6ibgZcy1INy+tf0nx93unW6OHeYmtx3HXnASvzWcxuRgDSPqZ4jlpuc/bE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SlF-0005hn-Iz;
	Tue, 15 Sep 2026 12:59:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6SlD-0005hW-Os
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F4+vgMlQLtaxzTAGisq3EI/QPT0SXZlr1+RAs+wxV58=; b=RdOM8HqA0c1tjtuPZrWaG0PLzp
 R+HI4hVarMDeKIx6vak5R5dzu6E5pDhRG/e43jDjdCjEOqkva8Ddtx/epn3uA8L2ia2p+bbzFK4Tr
 qtgJo44ZoDNz+NDfiDkdJJ6sCyqdqMDdcwfdo9i/tZ6fSsU0RyPvHn1RJf+jPJ0kZ5fQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F4+vgMlQLtaxzTAGisq3EI/QPT0SXZlr1+RAs+wxV58=; b=H
 O5zEsEcU/5gilOx+LTSuADYb/NSKUiqvQkp/Lw8ORG+sCQh+dqH1hKUThc/mlXTt1fjcEAdilI+TP
 rKhbDX71vqKoXzW89ItZknqH+myQjjoMdCEu0zA1ZG89l3NnJwip9QolruA7+tyaIu7CKHt/zcPdw
 hTdkCUIGMNes32G0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6SlC-0002jj-9Y for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:44 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so1705655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789477176; x=1790081976; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F4+vgMlQLtaxzTAGisq3EI/QPT0SXZlr1+RAs+wxV58=;
 b=RgqMqs1VGl7/0dwGjoXHbPK4IBgCPGM9Uq+C10ApH0tv4rWtf5wu7kG3jnrF/YIba+
 4vSCeX4JrVFQVKl2ehv4TzKsbOazl+G4pNYIApbw9mLqaOLAgruokQj6M5sXpsgcCJLf
 hoRtIrYBlt+HXPbpT7gg/w5XHF2DCTs5O2WgBw47DNkZ7jXAygMs7U9Rq7y5NwnIGgDZ
 3fd3Ez/oVRW3C9KcOJy7+K/VtO6mCZdh0i7hlZZKcAyjxALb0qaaOnGL793icXheP4o0
 bQOeIoMp6fhBR6f2ftrbWzluFXDh27HBIJc5p4kKXQwhoCSiqUKOo6ZtEHLMYewOrp/G
 TNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477176; x=1790081976;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F4+vgMlQLtaxzTAGisq3EI/QPT0SXZlr1+RAs+wxV58=;
 b=l/Roytxuhy0zk9zmuAbQGZqhBJxk7/6o05qXeVWMDsBhBI7dQCoVPWBBe2RGPT3XRu
 /8V2cACZpgVgQXXpQXmcw5x4OdWDyIO7VBLND0xuk+IJreiDRVIo5EVmWYzbZivjD09m
 1M1qfxrdpx9sMQ/ub8NXca8hFy4yhOwoxZwIYEhnhy6I1i4OnYGuIrCRejBtVhyaiBPp
 bWTvixN8HfdQq52REdVzb2d9MkJH7aBSYSnwFfIYN1pvCyHnkIu9N+2WYikn5WkkWbNX
 C3ltPxiwpIEJKJL/9Dp4rOAfxhQXDF3Cl7siYJJtop0eSGnMUfsP+N5hT4DoKXnCs8EM
 hpAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBysKWrWbKvqbI4S7/DMyHbTYbxy0rCsHMbDUZ2A8/Opu90Xu3L8o9GWHR005Dd++hISUYlFghrUlHsjgGel@lists.sourceforge.net
X-Gm-Message-State: AFuF++k1x+3vnxKRiXqv9XyUWKdEerDrxRj0XS2ac9I8cWZ3iuKYNZhH
 m3bh/1m2lUPD4XPI+12RkPG7w/1luCeafu/JFzS1Fp7Qbdin/Jy/qQAAhUAxJDQ77eAevymTUFd
 QzB2gc6KJtXMVC2w1vbKkCSMTIzFkdcXuCuGWGS6wfTyEECD13ieEqaCzmPw7v0JN7BrX
X-Gm-Gg: AYBFou14UXGmIGx3xp5PwJrdCEIg+fMoYazUbJxLzUkDc1Fsu5FZNl85Hep8jJKTTPs
 y6UfGhgzVTsdeLvosMMuQtF4Pvwn9B6F02UOjiZGMtnnPdK+isP5IMvnqvtuOQye9cEugSKMo+3
 fYA2SJURQhinf4ohsFIr7boYHnhz5kTez5HQoFj//K90eciB2lHmsIGTrHqdGYHL1YNJ9k6LsOl
 hbaAfzQQssyhvKQ9ROuPzjDZRo4hJoVrz8C+ZaBNODhlfFbUXAgu3/RRtF98duVvJAiK0p5H+eG
 zJerBruE7moiGwSVaQS4E80r93NEMwcyzIWkQlhreTD9Qia3ih4ZQh9TH0JxRY1ArWf8otjDChn
 bopDLFBVZWSq6iLugPR+dUo7kPBPGPZj3YAw2ZIJK4MpnwJfTRGOSKrHfC292nF6lt6ME2N73bz
 c6wmT2ju6lS7ZEqzqJMJkrQ8Fbp1EJwvO4CvOyLTQPkS8eAWuY//bI8+RGrtGpicoMf+ZzZKSY0
 Zk1bxWyfrl+nUIz0lrQ9/8M/2I8dHywpIJYOnn4WXODEEjw8rfh5Vv0gxUd6wmD8I15fjWjW8Yr
 nsoj15ZGHgMlja3jalWyw0ADYfhrw3vjjHqsFBbDOxYVMGvl0nRGwV9WuGWi/g==
X-Received: by 2002:a05:600c:4743:b0:49c:fc6e:a3d7 with SMTP id
 5b1f17b1804b1-49e8228f446mr14719185e9.22.1789477175396; 
 Tue, 15 Sep 2026 05:59:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d695677sm70256625e9.5.2026.09.15.05.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:59:35 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:59:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0e4f26ec62f719eb61db55882e367f47586a8483
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 12:59:33 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47cbf55ce9baa8df36c1121d5741db61c5407387-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6SlC-0002jj-9Y
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2922516040484680348=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2922516040484680348==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XTsPX1eBTkg="; charset=UTF-8

--XTsPX1eBTkg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 22:

(10 comments)

Commit Message:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/b61c4899_dbba1cb9?usp=3Demail =
:
PS22, Line 11: PROBE_REPLYs within a short window, and reorders the conne=
ction list so
> Is that short window documented
Yes, the man page says "up =
to one second"=2E Will put this in the commit message too=2E


File doc/man=
-sections/client-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1747/comment/cd58fdee_1e41ce66?usp=3Demail :
PS22, Line 624:   skipped and =
the configured order is used=2E Remotes that answered are tried first, in t=
he
> so this implementation breaks with dual stack? That sounds like a pret=
ty big omission=2E
No, it doesn't break dual stack=2E There is one probe so=
cket per AF, IPv6 one is opened wit IPV6_V6ONLY, and each remote is probed =
on the socket of its own family=2E Reworded=2E


http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1747/comment/eddf9a15_2c628435?usp=3Demail :
PS22, Line 627=
:   attempt; a restart does not probe again=2E
> restart? What kind of rest=
art are you talking about yeah, restarting the openvpn definitively will r =
[=E2=80=A6]
Clarified=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/c=
omment/71d4d2fa_38b7a9e8?usp=3Demail :
PS22, Line 632:   client whose clock=
 is badly wrong receives no replies and keeps the
> The RFC draft has a dif=
ferent stance on this=2E [=E2=80=A6]
Implementation is the one which differ=
s=2E The server drops every probe whose timestamp is outside of the window =
and doesn't let a small amount of out-of-window probes through, as RFC sugg=
ests (SHOULD)=2E The window is --hand-window, 60s by default, so normal clo=
ck drift is covered=2E If client is further off it still connects, in the c=
onfiguration order=2E I would add this allowance as a follow-up rather than=
 grow this (already large) change=2E


http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1747/comment/bba2b6e0_e8d5072d?usp=3Demail :
PS22, Line 634:   ``--re=
mote-random`` produced=2E See ``--server-probe-reply`` for the
> Yet, I see=
 no warning for using both together=2E
I would not add it - the combination=
 is not a misconfiguration=2E --remote-random still applies to remotes whic=
h are not probed and to those which don't answer, probing only moves answer=
ing ones to the front=2E A warning would tell the user that something is wr=
ong, which is not=2E


File src/openvpn/oob_client=2Ec:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1747/comment/e9401dcb_bdaada77?usp=3Demail :
PS22, =
Line 523:      * get a probe socket=2E */
> This duplicates the do_preresol=
ve code=2E [=E2=80=A6]
do_preresolve() does three things the probe must not=
 do:

 - it is fatal when a remote does not resolve (GETADDR_FATAL)
 - it r=
etries for --resolv-retry
 - it stores the result in c->c1=2Edns_cache
 
Us=
ing it here would mean that a remote which fails to resolve aborts the clie=
nt instead of just being left out of the probe, and that every client, not =
only those with --preresolve, keeps the resolved addresses for all later re=
connects=2E

Taking those out would leave a single openvpn_getaddrinfo() ca=
ll, so there is nothing left to share=2E


File src/openvpn/options=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/a739730f_18017925?usp=
=3Demail :
PS22, Line 818:      * the built-in default) applies=2E */
> > o=
therwise each server's advertised margin [=E2=80=A6]
The RFC says:

The gro=
up of candidates remotes then includes all remotes have a RTT that is no mo=
re their max_latency_diff (in ms) larger than the lowest RTT=2E

"Their" is=
 each remote's own value, which is what code does=2E

Per-server also lets =
a server say how equivalent it wants to be treated - announcing 0 means "pi=
ck me only when I am the fastest" without constraining the others=2E If you=
 mean the best candidate's margin, the RFC text needs to change - I am fine=
 either way=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/66f=
00a15_f5da99fb?usp=3Demail :
PS22, Line 5102:                 msg(msglevel,=
 "--server-probe: max-latency-diff must be 0 to 65535 ms");
> This sounds l=
ike you could have values over 1000ms while the man page and documenntation=
 says that y [=E2=80=A6]
No, I don't plan to allow longer window=2E

Replie=
s arrive within the one second probe window, so RTT differences never excee=
d 1000ms, and a value of 1000 or more means "every answering server in a pr=
iority group is a candidate, pick by weight"=2E This is a legitimate settin=
g, so I would rather document it than warn=2E


File src/openvpn/socket=2Eh=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/5453c7ca_7d5c1378=
?usp=3Demail :
PS22, Line 413:  * Hand @p fd to the VPNService API as a pro=
tected socket, so its traffic is not
> I remember we typically use \p inste=
ad of @p in OpenVPN 2=2E [=E2=80=A6]
Replaced with \p=2E


File tests/unit_=
tests/openvpn/test_oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747=
/comment/32140867_a5cef67b?usp=3Demail :
PS22, Line 528:  * and a second re=
ply from that address credits nothing more=2E */
> > * and a second reply f=
rom that address credits nothing more=2E */ [=E2=80=A6]
Yeah, the the first=
 reply credited to both entries, a second one is ignored=2E Fixed the comme=
nt=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9=
548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 22=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_li=
ci <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 15 Sep 2026 12:59:33 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plai=
sthos <arne-openvpn@rfc2549=2Eorg>

--XTsPX1eBTkg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>10 =
comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/com=
ment/b61c4899_dbba1cb9?usp=3Demail">Patch Set #22, Line 11:</a> <code style=
=3D"font-family:monospace,monospace">PROBE_REPLYs within a short window, an=
d reorders the connection list so</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is that short windo=
w documented</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Yes, the man page says &quot;up to one second=
&quot;=2E Will put this in the commit message too=2E</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-options=2E=
rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/cd58fdee_1e41ce66?usp=3Demai=
l">Patch Set #22, Line 624:</a> <code style=3D"font-family:monospace,monosp=
ace">  skipped and the configured order is used=2E Remotes that answered ar=
e tried first, in the</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">so this implementation breaks w=
ith dual stack? That sounds like a pretty big omission=2E</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
No, it doesn&#39;t break dual stack=2E There is one probe socket per AF, IP=
v6 one is opened wit IPV6_V6ONLY, and each remote is probed on the socket o=
f its own family=2E Reworded=2E</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1747/comment/eddf9a15_2c628435?usp=3Demail">Patch Set=
 #22, Line 627:</a> <code style=3D"font-family:monospace,monospace">  attem=
pt; a restart does not probe again=2E</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">restart? What k=
ind of restart are you talking about yeah, restarting the openvpn definitiv=
ely will r [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Clarified=2E</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/71d4d2fa_38b7a9e8?u=
sp=3Demail">Patch Set #22, Line 632:</a> <code style=3D"font-family:monospa=
ce,monospace">  client whose clock is badly wrong receives no replies and k=
eeps the</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">The RFC draft has a different stance on this=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Implementation is the one which differs=2E=
 The server drops every probe whose timestamp is outside of the window and =
doesn&#39;t let a small amount of out-of-window probes through, as RFC sugg=
ests (SHOULD)=2E The window is --hand-window, 60s by default, so normal clo=
ck drift is covered=2E If client is further off it still connects, in the c=
onfiguration order=2E I would add this allowance as a follow-up rather than=
 grow this (already large) change=2E</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/bba2b6e0_e8d5072d?usp=3Demail">Pa=
tch Set #22, Line 634:</a> <code style=3D"font-family:monospace,monospace">=
  ``--remote-random`` produced=2E See ``--server-probe-reply`` for the</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Yet, I see no warning for using both together=2E</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">I would not add it - the combination is not a misconfiguration=2E =
--remote-random still applies to remotes which are not probed and to those =
which don&#39;t answer, probing only moves answering ones to the front=2E A=
 warning would tell the user that something is wrong, which is not=2E</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob_c=
lient=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/e9401dcb_bdaada77?usp=
=3Demail">Patch Set #22, Line 523:</a> <code style=3D"font-family:monospace=
,monospace">     * get a probe socket=2E */</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This dup=
licates the do_preresolve code=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">do_preresolv=
e() does three things the probe must not do:</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"> - it is fata=
l when a remote does not resolve (GETADDR_FATAL)<br> - it retries for --res=
olv-retry<br> - it stores the result in c-&gt;c1=2Edns_cache<br> <br>Using =
it here would mean that a remote which fails to resolve aborts the client i=
nstead of just being left out of the probe, and that every client, not only=
 those with --preresolve, keeps the resolved addresses for all later reconn=
ects=2E</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Taking those out would leave a single openvpn_getaddrinfo() c=
all, so there is nothing left to share=2E</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1747/comment/a739730f_18017925?usp=3Demail">Patch Set #22, Line 81=
8:</a> <code style=3D"font-family:monospace,monospace">     * the built-in =
default) applies=2E */</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">&gt; otherwise each server&#39=
;s advertised margin [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">The RFC says:</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The gr=
oup of candidates remotes then includes all remotes have a RTT that is no m=
ore their max_latency_diff (in ms) larger than the lowest RTT=2E</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;=
Their&quot; is each remote&#39;s own value, which is what code does=2E</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Per-server also lets a server say how equivalent it wants to be treated - a=
nnouncing 0 means &quot;pick me only when I am the fastest&quot; without co=
nstraining the others=2E If you mean the best candidate&#39;s margin, the R=
FC text needs to change - I am fine either way=2E</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/66f00a15_f5da99fb?usp=
=3Demail">Patch Set #22, Line 5102:</a> <code style=3D"font-family:monospac=
e,monospace">                msg(msglevel, &quot;--server-probe: max-latenc=
y-diff must be 0 to 65535 ms&quot;);</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This sounds like=
 you could have values over 1000ms while the man page and documenntation sa=
ys that y [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">No, I don&#39;t plan to allow longer=
 window=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Replies arrive within the one second probe window, so RTT di=
fferences never exceed 1000ms, and a value of 1000 or more means &quot;ever=
y answering server in a priority group is a candidate, pick by weight&quot;=
=2E This is a legitimate setting, so I would rather document it than warn=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/socket=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/5453c7ca_7d5c137=
8?usp=3Demail">Patch Set #22, Line 413:</a> <code style=3D"font-family:mono=
space,monospace"> * Hand @p fd to the VPNService API as a protected socket,=
 so its traffic is not</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">I remember we typically use \p=
 instead of @p in OpenVPN 2=2E [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Replaced with \=
p=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/u=
nit_tests/openvpn/test_oob=2Ec:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/3=
2140867_a5cef67b?usp=3Demail">Patch Set #22, Line 528:</a> <code style=3D"f=
ont-family:monospace,monospace"> * and a second reply from that address cre=
dits nothing more=2E */</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">&gt; * and a second reply fro=
m that address credits nothing more=2E */ [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah=
, the the first reply credited to both entries, a second one is ignored=2E =
Fixed the comment=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=
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
2 </div>
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
rit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Tue, 15 Sep 2026 12:59:33 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Com=
ment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bo=
dy></html>
--XTsPX1eBTkg=--


--===============2922516040484680348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2922516040484680348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2922516040484680348==--


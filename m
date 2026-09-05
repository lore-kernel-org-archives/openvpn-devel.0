Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222DEC624DB
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQXqC1GQiSinESBYB9IIW/Hs3FtqQFl2HNT059GdIPQ=; b=IAXuvMxxnbhkCTnJph4y9YpWeR
	uvMDMW8OL1MrZg0HwMxql+stK5UooQW80Pkx36fl0TYQgM+M0VCNsS8xWdHtEXXBlaWSB87o1rnO9
	14C7EeO7GOvoz7kqm3reLZCuJbVZzQX0ShPd44+ZZiW82AzOEbu9ryLPkffJ40Xxv8dw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2uxx-0007Dd-Ev;
	Sat, 05 Sep 2026 18:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2uxw-0007DP-Ex
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 18:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NdbWAlKlp89QMv/Vxq7cWxgcZ4ATRXztiRadEq3vyNA=; b=CJrINATkobSxkq/YyW1WczOVoA
 5HpHSIJY9y5WqdJit9tRcDPjbV0TCTv4Yl5NFQZykE4I39NRA6XiInh48rVK3yB54IPESLiRiOr0j
 FUl47iZRdDcONfNUQpEhI6F1JPNyoqA3K6wbvaHFuFqxg9JJ8ITZuEBMZ4c92LGdEe4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NdbWAlKlp89QMv/Vxq7cWxgcZ4ATRXztiRadEq3vyNA=; b=C
 SNreY8QQHSDwSyZh8QCLyc3A9UH3gTfys5OsSnDGI4CpcTA1pHdm8uRkQoAAZcZYgjkB4XdcJFrjo
 W27gDZfMd5auv57gjWf74nmDj4aIQTsZ3JI8/klut3hslWKSFDf4tXwarJxbcrqY4IDfmjbwaUkWb
 pOtMLehAfAUrV89s=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2uxw-0004fH-EK for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 18:18:13 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so19186935e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788632286; x=1789237086; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NdbWAlKlp89QMv/Vxq7cWxgcZ4ATRXztiRadEq3vyNA=;
 b=aouymM5S16v3DpWCVi7iLAPzIuHqe+tsv4FiOT9x5ohC7bnjhvymr4uPAhiIWgVykI
 soXW2l9YxP2Iq5x4Tx1lh7XIku+4x/ECsyn+bm2fDAQNyOOuXQ5tyAhkfV2vZtn9gasP
 mXDW8mdAMIX7rsMqDzQ2miMfxpU8yIuChE9t6MP/3YKdyXwlwM9ook6I/XdrB5GTA8TN
 50BBRCKjT3QIgffn59LcVEU6Y9xN7WHIo3LU09p+493kRsVOyrz8U4r9NyxvOGRUoXzp
 SN+accTD7OsZypCskqhsD6uFEgcsF+PmbECJZ0MiiP8H2TQSq195nmY7ilfqmd7zBEI6
 eyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788632286; x=1789237086;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NdbWAlKlp89QMv/Vxq7cWxgcZ4ATRXztiRadEq3vyNA=;
 b=g2t68jNWozqQbJUUwtURoYDzxuCGvY1C0K4InTQ21mj8pk7lnnqNO9NjPW8E/yMQZ/
 VfHGUOCIeP17725K3roXZSMSH28fFLH6NUV4VWHqySCVRaybOSfiZeReSJFg6RDFhIAH
 PHELe1n8cT/+QYQuPvxHbjYlaJHkTgIk0H+myIViQyhyE4ClcV1X5hITuF3H3bVrJonk
 SMucx1GFNW2+YJOJK8KN5ozu35ntVS93aDQvvqyJvPKFpU/X3xbmHFeVYbx+NZqT6Z++
 APY/3G7EHYx6MywZoe7P24IWSSLyM0s0aD5MOsBKSET7ZnCe3hxEos6ReZSuUmYe/iDB
 7cXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPmYgLzctNKOt+1XH1+TEkzI/MrDYYD0BfnF1lQxSzRjZFsQp9bylK309D/W/115fjdBkZO9/4Bl9j0CmQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mRPGf/sYEM4BwuvMuFbaIo2Yyyi4cwb25IGu1JdKKjnTiQWsq1
 aURwY8lJUPMMbzM74mPChL7sSkTSEBi+Y/bw5hhUzrXbzbUisfcfwaaec+oXvrBtW0/MM+31IoI
 j4umk1kZ6a4uTgk5STJEYcXbWKLZzsj2ynEdtpAtZ7jqXp8rzv4yoy60EsmDsF+X2hX0P
X-Gm-Gg: AYBFou0o/hDNAsA0tWC72yqNsqpUTUF6hvEbQ1wlCbcnTG0ycoY+FxrT69d0ZRykMfJ
 V1ln3MLomeamMJuwPRuB8xhuKldWRPWJ+3947s0410B18xK7jRxpU9e3004o2ldFpmpxxWoFNdm
 RiXuQDAJSwHcUCj2L/iN++8BIeOy/+Glmp3mquwgkzxdXuJ/s5qNyuKr33lbYeOuEV+ewHoPxDe
 J7l5UHb5ikWPlbObYXmzYwfGzYh+NgJsTrhIL0aVD08u65mYCUpKlr5E7K+PQGvqfIS26cPiPj4
 KpSwSAC0hqDxdGiUJMZpRgbMiSz/gumYhA+r3zzZl3nrm2H97a898ksTXSFC+6nHF6YRHlGtJzX
 T8/bx//v2Iit8y/nnVtGoCqeUWq4D1Pkalzu+uXwv0wBYXgh19XVY1pTkGWWhaQNXAipufZnAji
 8vWQahjFt4kPZUP1q6EGxLI39cqwqePjLf+aHHPq0iMzZmMDNbTUuNC0S1IC9vICosP5zKKvey4
 LUtOGsFWYs08E04YacBA+RilhpzWOVLcxLngI5B89wh85CfArkspjXj+kpSIjO9RJKBK1sF8vtO
 hBz632Jovfq2Hj5uR3K693xouOmXPu1kuU7W2e3n6muOOxk/4UQ=
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49cf7fe62admr249001125e9.2.1788632285800; 
 Sat, 05 Sep 2026 11:18:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm200915105e9.10.2026.09.05.11.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:18:05 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 5 Sep 2026 18:18:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 89a1011cb5d3a17d56b5fdad59531d8be8e20835
X-Gerrit-Comment-Date: Sat, 5 Sep 2026 18:18:04 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4540615862ab1243dfffaf06b481900cc28a619f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2uxw-0004fH-EK
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "srkyn \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3157301156601354826=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3157301156601354826==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NzvEimX8Ri0="; charset=UTF-8

--NzvEimX8Ri0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

srkyn has posted comments on this change by srkyn=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1881?usp=3Demail )

Change subject: compat: close all=
 unrelated fds in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4:

Patch set 4 renames the helper to compat=
-close-fds, applies the suggested close_range simplification, and makes the=
 descriptor tests adapt to RLIMIT_NOFILE=2E Verified current master with na=
tive and forced-fallback CMake builds, both low-limit test_misc runs, the A=
utotools main build, and all 17 OpenVPN unit tests=2E


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55=

Gerrit-Change-Number: 1881
Gerrit-PatchSet: 4
Gerrit-Owner: srkyn <david@s=
rkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Comment-Date: Sat, 05 Sep 2026 18:18:04 +0000
Gerrit-HasComments: =
No
Gerrit-Has-Labels: No

--NzvEimX8Ri0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Patch set 4 renames=
 the helper to compat-close-fds, applies the suggested close_range simplifi=
cation, and makes the descriptor tests adapt to RLIMIT_NOFILE=2E Verified c=
urrent master with native and forced-fallback CMake builds, both low-limit =
test_misc runs, the Autotools main build, and all 17 OpenVPN unit tests=2E<=
/p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=
=3Demail">change 1881</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Sat, 05 Sep 2026 18:18:04 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: No </div>

</body></html>
--NzvEimX8Ri0=--


--===============3157301156601354826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3157301156601354826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3157301156601354826==--


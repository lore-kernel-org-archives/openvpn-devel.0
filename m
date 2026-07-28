Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57535C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tKxdTvjt4XIehoIOhXB1EzSi5ACl6/DMD0FpY9VJkI=; b=hcygqJWQq/QFGCN3t9zBZePfX3
	CX8s5pewk7nk0SEfzDJtb9uQJJvAf5zBtP8rslddsjE8/j7GwtEEdfEY6kW0s0TrygPJ3ydn2wPon
	q8FEkGGxn9RCfP5OorR0bDunGxpI2fEA05U/iZ1kkVLu5g5H+sEjqRybv1osZM/KsTmk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woh8R-00047d-No;
	Tue, 28 Jul 2026 12:42:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woh8N-00047V-4v
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RY1CUthehvzzprQpaZWHrsSoKkBD8LiTwViA5VI/fWs=; b=Zh6hWq3Juu2Akgfs9TqNGaIvJo
 ZuGZ6NwqaXzN/BkP6EEHcdR+V1gyFoxyzc3WkthOISGVd+86nSMIWOY2DdS9S6zaoj0xkCOS//SYg
 AI9IHTjjCC3maIq+EM5lkSStqzadzb6TF0cnI+QME0JbLCrxITTF0dUuHE2ZjtVBNDsw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RY1CUthehvzzprQpaZWHrsSoKkBD8LiTwViA5VI/fWs=; b=l
 cOYd+RcOdOKGtl2ZjhGkJIWpBdwBMnqFg7g9IwpwxYUguGTwU0s1HR9kPTospZkiuE3ST2o4X9ZF6
 Db2NZ7a4RCs0wJsJFaF9i7GK88pYr7SEpVZvGphQ56BsN58B6w4wTGI0PvyRH7BZ0VwbqHYAiNlb2
 aQxHKA4KKXLnINLw=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woh8L-0004X6-HJ for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:42:11 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so786804f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785242523; x=1785847323; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RY1CUthehvzzprQpaZWHrsSoKkBD8LiTwViA5VI/fWs=;
 b=giHcXJy6WlGpXJzMiSiMT9bSU+2MRF+irMcyDT9MiY1OU/0qoHwxT/7I0dMSMbRLIZ
 +g/INX4BCQWR4W7KVkpcsE9BvYzJgg4rXrhiVt657DTC7IN2ZeEbOhdMnNJtMnTWM/t/
 wxVlrhcVmSXRms9mLrRjQY7BfUM9ERuqTNq5AT36gs95BoofzsAGOFBofOWmbTA7HLKH
 ZH13PV9EK3zn6UhkVeTfy7uT8/bXKUF2zd4pkGSYejgx3qbeNnfjeIYh3EJQW64kisgn
 dncWYhgVyvB42aFrC8cBYHrzQszabjud6JMTfUaVS7bH4ofkobYrISF2ZtfCkB3MhT/w
 iDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785242523; x=1785847323;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RY1CUthehvzzprQpaZWHrsSoKkBD8LiTwViA5VI/fWs=;
 b=PbdOH2mvdgBH3PU7iof4Kb7xWe7DCri+w2R1EGb3xfmShkqecYayTgjbjsHFtPN6XG
 SJk6L4LnEAzDd7XICi6+oAjEuMTahLwV5Wnq8NDYBFPH/3p4ajpsHJLSMFWN6g8JVKeN
 PwIFXl+dEopabQeo+o/w2POTGfLZ/zbkNrQ1zTOF0fpmNgVknR/XzlnQNPQLObVp2Czb
 opf4/wGsqhiViXLN9+8Y6BJWB6nkaZ5BnH5Q5gP4PEh5olMPfhlt8WNWJ2CDhjYqELoo
 vkeZfgtFUV9N4tOPRMsXTa6Qjq3Xv8ZXLZyiy5AOfeZz2AdfHamW32QeCks4X8kIaQu6
 B49w==
X-Gm-Message-State: AOJu0Yy8aDmpkvnhw9ia1BYaoX5ilwr2VlVEVc0Ko/prUWifr6+nrfaL
 uHkgEUbqbxwTBo9OFiz5epgzSdptYDNBh/9nUY8zdFdvh0b5Jwc4v8Le6V4gPLOpQLUdxse5tDI
 a55KpCCwTBzRKr5n70PqPyZc5ECj6XWKa1Ika90KF8LzQ+Lcv2QmN0XYMDI5XU0qZ5tY4IU7JF8
 SzrGeDsw==
X-Gm-Gg: AR+sD13cilUbeusYFl9kn8bVc92Atx12Bz5++cvBmuxS7RMaTvRRnEOOBWbIcyqI9og
 cmRAeN9LtrZenTUNNe07w4YVFKs/tB/Uzi6agGglQ9MApK/yn1U/uEAYTxy2fn8fAuqhfTgxSgo
 /BL6FKHBO6BSBF6cqCVbN8u2oyA0E4wDkppsA56QebEDQmrBzTaKPDzH0BPXt0QbLmy7CZRHv5k
 wa/JFK9L8fmsz96GgoS1w9CCzvOC4HqENvh7MTQ3ynWIEjF0hHHSo0Wk4hP9zzfHul0ozZp9AIi
 w8fy+UCfu0/cJwMgNCYnVeq0JRR8uK6Cxe9A5qmSg7F7THZ2b1fU9cA+jifZR8m+EQhU5JH0Kb2
 xrLQmPk5lCr/3somW+Gp3ae+9TvDix7qpf4Zgd7z5rIkP5WvVEMXK+QJ47Z7wkmIXIQnWg8684n
 93TtvyNUGCuIsldNrFb1oCHxydLlMBOCYyBSoxINywl7SkTa2J25j08tDmfrRy4tQ/XrdC0c5JY
 1RdzNDX1hS+cAfdWBqewn13wMVFzrMuo4/OrHi7PKu2mh/o3qW08wwfib3e1fYGRiG7
X-Received: by 2002:a05:6000:5c2:b0:47f:2de3:b351 with SMTP id
 ffacd0b85a97d-47fb1ee2a7cmr2741973f8f.26.1785242522734; 
 Tue, 28 Jul 2026 05:42:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fa9sm60161735f8f.20.2026.07.28.05.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:42:01 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:41:59 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 4b683b5f8c105a13de0285b9c71cf614ca6b251d
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 12:41:59 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f55fe3af8c3324d084fdbf44277727842e5fa87a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woh8L-0004X6-HJ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6426456832599349032=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6426456832599349032==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mZzXRKjTQC4="; charset=UTF-8

--mZzXRKjTQC4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables that shad=
ow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 11:

(1 comment)

File src/openvpn/push=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/d2598ba1_0e5a6217?=
usp=3Demail :
PS11, Line 1004:         openvpn_time(&local_now);
I think th=
is is also a leftover of the multithread stuff=2E We should probably just r=
emove openvpn_time and use update_now() here=2E



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerr=
it-Change-Number: 1618
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue=
, 28 Jul 2026 12:41:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--mZzXRKjTQC4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/co=
mment/d2598ba1_0e5a6217?usp=3Demail">Patch Set #11, Line 1004:</a> <code st=
yle=3D"font-family:monospace,monospace">        openvpn_time(&amp;local_now=
);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">I think this is also a leftover of the multithread stuff=2E W=
e should probably just remove openvpn_time and use update_now() here=2E</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1618?usp=3Demail">change 1618</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915=
fa2e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026=
 12:41:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body><=
/html>
--mZzXRKjTQC4=--


--===============6426456832599349032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6426456832599349032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6426456832599349032==--


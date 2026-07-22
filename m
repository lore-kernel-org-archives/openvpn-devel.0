Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB62C44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SDidlMM46Z4GZlwlN2s0fF6XKeiVBoISegzqwEfY25U=; b=R2IY0GULB4nOhfX9uxm69AsjAu
	kLW3skMd0p5pJSUtEfkz3q9YSXoe1uri2A0KTWtEvc5ZYrhcMXsNprsmNGxZwhfgyHrYwhxGxr9if
	uXOSZ/6FeDXiw17kleC1y8ZD1cxdYlSt6lR6U3eBnXTzcbAu2pBrEY+z0a7fqgV6V+Ew=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmaYh-0008GJ-EH;
	Wed, 22 Jul 2026 17:16:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmaYf-0008GB-Ek
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LL3hkWkwdT/RoYgxnkGQMk68MJCxAMQ/qVRaxBPHYwg=; b=Yz47xH5osBvmNocXdDDUkXxdiG
 nKlwmul9zbjX28DyjBUcwSRF51iDNriyJBVmr30qUSR9aoJaZJVu7rHV8JA05I1TwpI/pbzlXa5do
 2c3n5WQIDuCKTSQg3NonTLDpbgakFYYmIJ7awaasSt6LJaav3v2MQ+wd4vxAKdFPHvDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LL3hkWkwdT/RoYgxnkGQMk68MJCxAMQ/qVRaxBPHYwg=; b=k
 Z+VOtYjChdciHJlkIfJq6OqiuS5+MlApzUToFKNnVuVU9Ig777JdDFUdqAdIFSUDM0fo8GjMh2G9A
 hBa7OH3s1cHc+VLU9zFgbjIQ7+wyfqS9hcBQx1MSElFEErR028jLkgzqyT9WgoBvul8YtShOUIE5j
 10l4yo4AY/RPsCm0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmaYe-0004qO-Iq for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:16:38 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso22971225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784740590; x=1785345390; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LL3hkWkwdT/RoYgxnkGQMk68MJCxAMQ/qVRaxBPHYwg=;
 b=F2XHdbRhLxb1Snkgpv8kn5iSiA04CjOvmAmBLZMHHPCUWKnKdeEBn6i4A5Akh3kQ3P
 WBVphWFmBd60skTY2KEq1olN0bq/cOpPSasSSUV+UIPs3zI15xRs+EfmoQy4AUp1qgJa
 K8yOCw02SlcORViwmkn+bkGvlYBb5vVUTFLaRd4hZLH5jB+pv/aa1srBa9lrH4get38j
 E+64e5iauvfbKa2sa+YgxS0cjFjUKe1Vanxv7qTXMWgSIhMhp/Ft5rKtFnaV7Tih8ZPj
 3wJ7lz1JiFEiD/PZJV5Uz34sIBDI0UJMjjrSuL1NmJIe2EHVxmjgHYiG6F+Hfbb52cKV
 H6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784740590; x=1785345390;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LL3hkWkwdT/RoYgxnkGQMk68MJCxAMQ/qVRaxBPHYwg=;
 b=NeNKE/vdjvhs7nxwCEF0RKAp0SJ1PO5TshYhImkV3bDIQf2pOsz/znHu0GlJQvvtXv
 RqeiEz6u2ZGZSiAXBbJCkouXMXi/p+VUDP2Di0c6akWxZgRK0EA/yahLphPyl14AsEHq
 sZcllqyidPJcKKOBJtI5ShmgjXVjNcwHrkR4AL2MHHbHRVthIsMVdIlU0YGM1FcmerkB
 bAG7t2bvGqLZIh/oWPb6h4Clw7LItQrJtjghihFie4Xk8qU5wqo6c4iAJ8ZO9srAL03f
 QyeSCnek5aS/y5JA7GoxfyM9xixYtgvAstrh1j3r2HEe+gRiGSLcgfrdVahWQpXzbmgZ
 X3JA==
X-Gm-Message-State: AOJu0YyUFXw1vllwf7iIY+ghuoV8zrYqi158ArxotT+ccTyjCmIkCz+J
 ul/cPuKBhjZKnobHci5G+0ajjhoZDwfkrjPK9F37YfxvevkFv3sowxhX9i2HcQHw1Fp9C/QKfzI
 zQhj7WRvFyv6Ga3iap/D8TJRfKDT5ShJL4NSRgiM0+HQbI3RHNEVLbLUhibhEbpk6j5RPJ1yJiQ
 cFkXXYiQ==
X-Gm-Gg: AR+sD13NlLZlp0Gn/ktLq95kg/OvVufF0V1wmxYatHj7gfK/PZWYAPujHZ7d36Sx4qC
 Tvj7fX0OxSzNl4GgBZqrP6Xch/V9PJiWX4z1Muf+USGhB5qMCdSgpO6bnEyPzefWy1eM41ZRWt7
 z7B31xVM5hFxDzdIJzLPGu/OWUefQ7Ld9KavTGb3eqcoqWyaE8chvpzeG8HUxz07t+f4rkrr+EI
 x2p0uAobUDtuC64zDlcrWkPVszFIEUNKSBd8XA06UOqrokxLJc0c+JapT15l8Y2tIYUfL3sTcgJ
 8mBTyzHet9Hjxohwm973ktzl17+Q6nZakA7hQB/qAosGnlinRFxP6JG+9UdWtZkQkyn+JVuNObl
 ZF4JaUc/mROw8NIPShdKY9H7UlhOy6+cp8VsL8Byu2jJQLo1MRJEznGxuRcwubKceF99EM9Qn/W
 YfMp3dk9pV3qI8Ke7pl93WuQBALtqxqF/XOwI4/thsTfY6/8zSbCWfDIU7UfLXR6GqAzp6KSTGl
 3oxi+Xd+96tefk3I3VIXdFW5mcMuLoNlHjF1QbUjGziWILAA21E+qjoeWib8ptooF/h
X-Received: by 2002:a05:600c:1f94:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-4954a3dc491mr284380695e9.10.1784740589797; 
 Wed, 22 Jul 2026 10:16:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm147872965e9.14.2026.07.22.10.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:16:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 17:16:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: 1ecf48732b06b461ef608e4f3509d49b8bdc6317
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 17:16:28 +0000
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2e5565dbbdfe7640cac6e504011ac4f246cc88f6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmaYe-0004qO-Iq
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow extracing
 other integers from peer info and add a unit test for it
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
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7964569207178333356=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7964569207178333356==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="grbNPTMiNIo="; charset=UTF-8

--grbNPTMiNIo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1800?usp=3Demail )

Change subject: Allow extracing other integers from =
peer info and add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File CMakeLists=2Etxt=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/92d5ff1b_74c948c2=
?usp=3Demail :
PS3, Line 913:     )
> your 'add ssl_util=2E [=E2=80=A6]
Don=
e



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad94e7a9d0b3be8=
a8db09e9a20eaac6041470ab6
Gerrit-Change-Number: 1800
Gerrit-PatchSet: 4
Ger=
rit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Co=
mment-Date: Wed, 22 Jul 2026 17:16:28 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--grbNPTMiNIo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1800?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/92d=
5ff1b_74c948c2?usp=3Demail">Patch Set #3, Line 913:</a> <code style=3D"font=
-family:monospace,monospace">    )</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">your &#39;add ssl_=
util=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Dema=
il">change 1800</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
800?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1800 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Wed, 22 Jul 2026 17:16:28 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--grbNPTMiNIo=--


--===============7964569207178333356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7964569207178333356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7964569207178333356==--


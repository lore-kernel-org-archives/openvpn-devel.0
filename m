Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C60BCA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Y+yZhPEXD46PrQQ77m0RPReNvVdvrFLz6+td9IP+mI=; b=SX1qfV6Qy8vyAeLcJBB7UR4mxp
	vPiUukrh+JV6Sq3qkYbg9AkYipg1EKcfMD1M1dF3oVxKjaMVJFRjE+M53wV0gmk5M12xGuINbjNWZ
	AcacRTWCvYTl+A0rlAMcKwAOTCD79MdstCyHQYGjQhhaPsh+bYCdeS9bKTr7xKdegBRU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDdyL-0006v3-QZ;
	Mon, 05 Oct 2026 08:22:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDdyC-0006uE-P6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 08:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xrJg9e0edKKmSrvEjGJo19AT3m4rdyFc/3VzW5h3kJY=; b=CM7UT0YS8jjMbeVMJi704ZtIUa
 Y+d+WtHftozGc0U+Amqmgx8rLUW+LNuxl1mqmQy4qpN1obTveTBZHCvZCs4vsxqGbGUM4N4SzA7pz
 XllhBhrEQQEuI4gEjj5XnMQcd/3QO7dyQjOiSY9J5edOtoy/lNPJ47bXwmNqZDBbuh1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xrJg9e0edKKmSrvEjGJo19AT3m4rdyFc/3VzW5h3kJY=; b=f
 S4C2G8mga02OnnswzAZSpwH2OngMIBFG7ahBRHsV34ld6oxJJhRXFGBQz5nqZIe0BjF9BzRMpe+T0
 fzUh910Tv6hdKih7NMuCbxLBOAKUpIMc/Z6HifPodsWIqgnWyQVh1bP5F1DUf7SYzcC48x1XdnOvv
 oy40ZO50dn0wQ1u4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDdyB-00015a-KZ for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 08:22:49 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a166199820so4122035e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791188561; x=1791793361; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xrJg9e0edKKmSrvEjGJo19AT3m4rdyFc/3VzW5h3kJY=;
 b=Yrb4ctjdd+vO1WqS8rQ9D90iuXTqMq8iWOehEsuHQoEyjO4a6pHkY5nqBiDdkiMHAH
 0NU2BOsrEeRM2IDSbNESF/pHJxQLx69xVUEMtWv6Lah7r3AW/0NNtS9uC4Sp8ogLz5jU
 nlFOQHXBIOjyJpSszdEMBMji2PXYT9yOE4oJNATsoa6Ombznw4tLdPZdwMDaur3Jf/s8
 6f5GVkw9ts4/wAqCfkNMUqydELmNHRNohfiv47K8/9zJxLbup+aS+yPVE1GhTU7de7JN
 Xvynp745GwptxR/3aMRUpPGu0+rCzQ4mM2LmmuSbgp2xiqf9fSE9GYiHXI14knJCJoMA
 1EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791188561; x=1791793361;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xrJg9e0edKKmSrvEjGJo19AT3m4rdyFc/3VzW5h3kJY=;
 b=ztipxj7Zb48HEu/dJMYg7M84Qq0IwtAGp5bSSRVH7eWRZ9snNQxQ1CWQQVUD9gkOnZ
 N4oYwGdpshrkYP4ngEcyMYYhpwzlJEkmjSOH2q28BJqo8X/AgiMJJL1BXoUHQ0556BXs
 uzGgsHUuTmybcUL+No2q/khjsCchD9Pkh/2/KEIdgOqWv+mA9LJ0mttbHwp3p41TeE4J
 qrmZxJI0SCuCsjkKEIohEeGI/9+3iLmLLV6Dg2bMC2OjYTTxnm1PI5PRDMevNAf6z16x
 H/rCANGRSiMqoZmQYwmzNfM4G6WZA84Cxgjw21lIrHB/97Frf3LBJ3G2w8qG7WeMfUgx
 sKzw==
X-Forwarded-Encrypted: i=1;
 AKwUvByVW1c8HDpHkvHLXmEk3BxmC5jFtBVQN2rnBDrSJdlFDtF7ps3u5YJ1MefkGCx/AXZ3Om/SjZC1pinQTMTl@lists.sourceforge.net
X-Gm-Message-State: AFuF++kbcD2kJP5rWtvN5VlfBzSHNLnk0m3xyQOC9ZZi8btcO+lY3ZLw
 sAQSRclUlqR6WswaO1NkS/g2ZekyEMEucXXvWzeipZd8IgyH3MoiWvspViUaCzHMtQvZ/ViFe6r
 CgHDB8hRELiLFdZCSE+2JNaxaxXUMDy/CCqeP6O2PurRxVJFU5HdQVZdajpc0R9UvrtoB
X-Gm-Gg: AYBFou3oP+SJpMmYKN2tIzE4bJFSO8r7GCxX/vEe6OESPB1cjpgfb2CDn7BjMJvWfrt
 USkWuAoBpB7YU1Ia0Oq8wZfrnDtVPGxJwh3beJbSlixuUuWfU2qzB4VaE0rtdJT8gsBzHfBto+w
 60bsPIxRWQ8efgj1nwLU7moJB29PPMvVdZV99EkKoelMNxwlMG5W8jk+u9zHUQpCOoeONFVCDNt
 FEnEeZQzxqqKLF71tEzH/NJqeqXz5hSb51fJYoj6loaulVfXNS8R/4KY+EgcEdOYAebMcIDCB8Y
 mwvzNKEPND7NjgZkKj7t6tJTAbj8YIiJ7O5sv+p6vBMrRwxxM9XQslCjJ+vfrcPlodDGVg+ky46
 kDgqmrIqva4iBwKY0Q2dtsULKvfC3WgQ1ku2rhSri7IEfvL6oRIz7BfV4s8w+B8bIv12bHs7/gL
 GzM3Rfh7yu+KqcbQsUrrf0ufIpFNamcfY+LEIXpHIxpDTwJNYc/kPGoBiuD2lB/PBm/Zeu7FcjY
 T5HpH0xR2ivbYqT0VhYwRxVGV21tkFDVOLF2o/7ocGi3EhUuEcJ4ERDHHFEvo8iSaELtGkMb7w+
 fjTwkTYljIl8MEO3q1N7/pwM+0wGRkoJZPSQ+CYFEreiAAMunxpsbeU6ZIl1
X-Received: by 2002:a7b:c3cc:0:b0:4a0:ff8:2a0e with SMTP id
 5b1f17b1804b1-4a01eb1e93fmr183038105e9.3.1791188560719; 
 Mon, 05 Oct 2026 01:22:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622bb166sm2007206f8f.44.2026.10.05.01.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 01:22:40 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 08:22:38 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: ee54ec4336d8a6fd39ebe77b38efef8eb4a56bec
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 08:22:38 +0000
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c06347bbfe1a6773963fd86305d22f8fc144953a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDdyB-00015a-KZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbuf: don't count
 dereferenced items in the queue length
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1541207064690212616=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1541207064690212616==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wsJI6acZrd8="; charset=UTF-8

--wsJI6acZrd8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori, plaisthos=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail )

Cha=
nge subject: mbuf: don't count dereferenced items in the queue length
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(=
3 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
61/comment/656af8fe_f98cce0c?usp=3Demail :
PS1, Line 23: what can still be =
sent=2E
I think this not 100% true because unless I'm misreading the code t=
he `[live][hole][hole][hole]` corner case is not covered (which we can prob=
ably live with)=2E


File tests/unit_tests/openvpn/test_mbuf=2Ec:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961/comment/bcbb942d_dffda595?usp=3Dema=
il :
PS1, Line 150: 
Would testing also that after an extract, the reclaim =
skips a hole and stops at a live item, be useful?


https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1961/comment/ba92a09a_2c3abeba?usp=3Demail :
PS1, Line =
218: test_mbuf_add_on_stale_full_queue(void **state)
Is this test not guara=
nteed to pass if `test_mbuf_dereference_reclaims_queue()` passes? The end o=
f that test seems to test the same functionality as this=2E



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b=
7690e0b71
Gerrit-Change-Number: 1961
Gerrit-PatchSet: 1
Gerrit-Owner: Gianm=
arco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, =
05 Oct 2026 08:22:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--wsJI6acZrd8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori, plaisthos=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail"=
>View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1961/comment/656af8fe_f98cce0c?usp=3Demail">Patch Set #1=
, Line 23:</a> <code style=3D"font-family:monospace,monospace">what can sti=
ll be sent=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I think this not 100% true because unless I&#39;m =
misreading the code the `[live][hole][hole][hole]` corner case is not cover=
ed (which we can probably live with)=2E</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_mbuf=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1961/comment/bcbb942d_dffda595?usp=3Demail">Patch Se=
t #1, Line 150:</a> <code style=3D"font-family:monospace,monospace"></code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Would testing also that after an extract, the reclaim skips a hole and=
 stops at a live item, be useful?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1961/comment/ba92a09a_2c3abeba?usp=3Demail">Patch =
Set #1, Line 218:</a> <code style=3D"font-family:monospace,monospace">test_=
mbuf_add_on_stale_full_queue(void **state)</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Is this test not guar=
anteed to pass if `test_mbuf_dereference_reclaims_queue()` passes? The end =
of that test seems to test the same functionality as this=2E</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1961?usp=3Demail">change 1961</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1961?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1961 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 08:22:38 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--wsJI6acZrd8=--


--===============1541207064690212616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1541207064690212616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1541207064690212616==--


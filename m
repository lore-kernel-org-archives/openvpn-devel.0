Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EF9C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QX01ybb/xrx2JLfjeQXrXhZJ6064hFot/I6OJFAkMj8=; b=OVUHLPqfNyv3LRcAqkgG/m5fXJ
	2di+Yuy4NoSQmR2gaFn5ULQOuZbV8XvXKzqyloum+e8xcoV41JjGe6NpjmzE/mwhoZBlqtx4cK10c
	d7bUHrGlFbyt+tM4Bz25ZwKODxbDEsZDkXjnopIpzONevA3aEVQI2j+wOyHCcInRFjNQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1vP-0000o9-Ih;
	Wed, 15 Jul 2026 15:53:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1v9-0000nu-M7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=il6l9GQ7eRO552XiNLCsz5zGBTiPbSABSvd7asTcR30=; b=i+vfhQiklIM1qDpwxcRsnonTSB
 xI5ohKAxHpL6MmUrf2NS7XnuSq3emJsWeJKqffDAnh+NSeSWWqMKbJzh3IQKM7BOjvgey4GWWVvQE
 IMnrhmkNsq126gmIi6cHf//nhe7QQ5vLe+Fafo2jezb2hFfx+Zb3APNvS/JN9TVkWZ9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=il6l9GQ7eRO552XiNLCsz5zGBTiPbSABSvd7asTcR30=; b=F
 CBAUABNVlFgi0zYjG5gkCwwxiRaanIZDLeNtCwbI/SGP4JoHoPU3AUYd2/VokncWJeXN6hNDCqaxK
 l/1SPDMmwgjZgcT5HWRYGn195I32w27YeOezcRhlWtsRR9CR1BRroEriuwikSJF3A4GeFxwr6QH38
 x7YyBoOXXvmsrg4M=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1v9-0001R7-1E for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:53:16 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so1453174f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784130788; x=1784735588; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=il6l9GQ7eRO552XiNLCsz5zGBTiPbSABSvd7asTcR30=;
 b=V7JG/SA3LPT0tMVudPYWCtgVudYrZfT2jgPdvyAo2jhFnxFdXdG0cPFCMFHvm4RTqe
 brabA1uVfPWhzJlp+raXblS9OTzMg2dxr2FFDuaqUGw3bGJkk9MHz7Lx/HDRi0YO4RH+
 d7W7gEYYL7vTtMdn8gE1cIGxNf/CpNcm5+YMjtCzjk+6SxzzDGsgCEzTN11ZpS+tSaMc
 tERPWHY/yJQ0yaS2zo0KOZn13ih7E2+5FvGDQEtAM7JS+ujp2rJYxc2aTn0e8EGvLwsp
 xnqLRqYS3UUsSof26yCHSyJrDElKOB++c3QHug6JVNzX4gIVyURINP89M4fqD3wqHXFl
 91rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130788; x=1784735588;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=il6l9GQ7eRO552XiNLCsz5zGBTiPbSABSvd7asTcR30=;
 b=MXidJEixo0s+1rL+dA6du836L2rpRIq9lw1FD9yWgza5jMTUlvHdEqqDMoG1llib61
 bmB65jBFQuIXrFbrs4+F2st7sB9ZAEQdOvMlHBjBIiai1IKvGpOto7H3vtNU9ssYUyjG
 Qp1sXqEy3Ogrz++00u8C8j6bFwJ5UVRUJGFV+2WkejHjQESo5molu0Mr/Z4kCwwoevQf
 UL3pUFLbEuB5NbBNs2M251sRrMoi9vnt2bv+6A7tcx6rFcO/ltqGfiA7QeLjMLebiIMm
 EP1PYoHIccnOvvmqWzWClHqiifCWkPILdgbR++nHIKWvHCcKHDBQ+7lmvznTFoDxxDjY
 eISQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEDqj9wOp9VYByc0+riYLVIiBRLiUXS/ERNo1j6JzeOjH556kkP0RFLlPZwenWVqo/2sWlM3alIZH8p8C4@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyP3oothhrz6SUGvxWkvYdY1p02uENYR3w3n+z/UD/+5W43Glob
 Y961rgWfDAI6Jx9G2BEZ+WI5wIAyUDHWCkImaANNjXfrKQgp6uTxjHdWzJhIte9GsjDqXruVV5J
 zbHWsmv8gKJM8qTY5QmyPJkZDhBj5g6JV+9pVphv1P8AJfqqsAIwV8VpW2IPnGjg9z/zwF/hrdq
 fDoakkLw==
X-Gm-Gg: AfdE7cknbuScmaDvBjLbv0DErgvdFnNt21sde7kvK+naTeW67n+AVw01H51SmnBf4bm
 nnQy9bJyJkftAx35fTWRMVkyikKUPaVPrq1k/D9/ANw/VQhcYkkQyvYZTnR77bka1i1izYP9SGy
 TKE3yDt//PVkZtI0Z85S3dWgGyT3tkCqWen76FSqVb6DjnDHnfrYY8i8bkBMAS/zY+WYQ+hDYLS
 NSEMAigstr3/944NVJc2eOD1Uhwwjqqve8Zk/0skpf3XCMEnSjLzSZw6ozQGs7MBtP4DXooVvVu
 NsxI6RQ4NWeKs86PqVZ7nG7EUMPPSVKt0kadC4wz9PzSr/aENMUvYwzN5ZkxWb72J3wp8Dd3GJW
 wGnaJBTjh0uMJT98Vzu13V/a28XgAbbXIpDYpLlpvaSukXOeFzc9Q9vc3j7bw6R6XthTrB+/fqp
 AMTsh7ZIva3+Lm2+N/xAwbQIZ6mAjYtc2d5ypFEleRWMvawaTrvnTz/qCzzkcardA7qfE7l/ybt
 5o7JjGGWgCbJqTiCFdnmQS2UxHHO+DbQ6S/Fn+xnOM+NfjRSuEL47wOZKqneR2T1Cfm17el/KAG
 pvY=
X-Received: by 2002:a05:600c:c87:b0:493:fd5b:2d5c with SMTP id
 5b1f17b1804b1-49515904a8dmr93690465e9.22.1784130788282; 
 Wed, 15 Jul 2026 08:53:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950873270esm154661395e9.6.2026.07.15.08.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:53:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 15:53:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: 08e75f6ea182acd2c9b6d4ca06b5bb35b7b7addd
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 15:53:06 +0000
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d1e9d7e2ce9e751fa42feb1988e48f782d86bf3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1v9-0001R7-1E
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5142505752488073176=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5142505752488073176==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UAmi5KhPnss="; charset=UTF-8

--UAmi5KhPnss=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1789?usp=3Demail )

Change subject: proto: correct 802=2E1Q le=
ngth check in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
Gerrit-Chang=
e-Number: 1789
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comm=
ent-Date: Wed, 15 Jul 2026 15:53:06 +0000
Gerrit-HasComments: No
Gerrit-Has=
-Labels: Yes

--UAmi5KhPnss=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>Patch set 2:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">change 1789</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8219c629=
5acf28ff10ddb2fcc285f813c42fa8fe </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1789 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 15:53:06 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--UAmi5KhPnss=--


--===============5142505752488073176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5142505752488073176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5142505752488073176==--


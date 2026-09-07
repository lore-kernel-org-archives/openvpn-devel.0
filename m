Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0BFC79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2E6hcDQGXSrqvG/lpAtnPmn3K2XW9sKEcSwoJzo2aoU=; b=DcfqFAFeRyP74N2ndczM0uLLox
	13ImR5gTpxwFYnTHFysN11IS00ZVTrvG+abpQ4o+8TLUKTql29p0SxUxlJoRwagt4dplVJ9vsrVvo
	1tK/UOiiVnVemIocMdc2E+fq9QUJs+1amqANYQxjTIuaRs5IoU0LYtTJgCyOqRVu2aWA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3aYZ-0001c3-Vw;
	Mon, 07 Sep 2026 14:42:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3aYY-0001bw-Sy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SfSuu3ndGoyrawMxn859Whrx6yrkAtQXYBwkq+KEvnM=; b=nNONv9Se5wjViq1TtdhX9cYyg9
 3L5WSrHvF/No4yaTI6kfLSUfSdfBFBD1B580SR3MCSiqK3zVy88z4Pkx5yFrZ6YZAa1lC/lZ8KrEt
 IgH5Jrdp3TyxlwGU21p7InzRMFsuuawLdpWOL3Pe6TMLOVsBwyAz6hR1M4JI1kuJu34A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SfSuu3ndGoyrawMxn859Whrx6yrkAtQXYBwkq+KEvnM=; b=a
 bYS1hC+JCTHwMppq67X6f59R39+kqUgUnOwCNrTHizIr7MvEY6kC5A7rpO1DaAaHkhRP0/7NP2a6z
 +kshMDMO660DR+3All6vAA6adAB0c1+Bk2glunOjqx4Kq2zHdRnvjV1JvI1xtpVeT0n+KYIqtWa9w
 VmbSAF55zSRhT4xs=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3aYV-0003Z0-1S for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:42:44 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4859245e493so1640286f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788792156; x=1789396956; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SfSuu3ndGoyrawMxn859Whrx6yrkAtQXYBwkq+KEvnM=;
 b=MPftItNEL3KRZ41htwsWzuuWVUo/fhIVUEJ/Q8tsa21Uz4C+NZQjgZrBj0wkAxcP20
 E3zV5LL9/eaFQ+35TZX1564uO4jYzaX3vGRod4IF21NyYwPKZre4+MPjjh5J7IokNOK0
 dcQLVMAASkpvSYiQGadcAgwSyxX9krtzCKuargUXJ8q52ZbNNTuPHY9cdL5GS6DQKEbh
 KMHGaq5X3GXuk72XBC5Bqd+c4CfP+ghbMGdSa6coHyGL6Tkm/giP7E43uc5oU3UO9Fd/
 XITa8Da6ulp4V13NRPppVIfG5L2CanxVBv3LgxI/SWcFeekPZRdOzQ07/ycBLfm7vxqt
 Tw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792156; x=1789396956;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SfSuu3ndGoyrawMxn859Whrx6yrkAtQXYBwkq+KEvnM=;
 b=evvgbgXLyKtOjazehJzGHXRALuBZRBtUBFX4GSRmkjfg7LcAa1ox3IAHXoGzge4KW4
 TM1K2Li2sqkCFm2GEOO1QTRUqVvGlFYg4EEun0WJ/BXBJh/5awl+GOLOwMdXko2DqGQZ
 /lq1RBlu5xGHhd8VxbC8nelpo0wTcSyYT3jPw89W+WM12zuGfkqQaKNrUxTZ8c9zsmOj
 Y9SinaeijI4jWZ3Slq3Saeb/fVU6feYG4okaLKDCTBYn94eBOrmhDsVJH9QH6eHwz7mD
 TOVW+WM7AmGLnjfYlbFleT2NUsDpR8Ic7hUMAGJwDNzMJDIg4DnTTmj+kWErHNseQyFe
 j0/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyTx1LcFZfz9Jje60YWB0KLIPXj3w1DzXVSrToRF6kpQdEN1Y9Iy3Mb+XYZ/qnb1NhekpJir93INljHiCP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kH4JDrZYlyNfJFP8bZw9v2lL1NR6I+CQqZZ1Qr9ADa6Ilq7YRQ
 GuR4VynQfHvH0YrSKybF0n9XADFT4Wu+Uj2RXJcwqgXKLkWTaOCoVvJhcrohrNCpL3uuhx7Zg35
 NLo2WkhblHEIiy+fFPl2U11cunEspBDWVwTO7I5vjZaHjujlyA0WAA2a5hgbIBBumbAAh
X-Gm-Gg: AYBFou31w34H2IaJs59N9vRXrlLlar2+N2vtKY+oigDjjmNsDkF8VSPet9cPT9qa1Ty
 10ZEEQ0oANV4iGL5qYfH1cqRROTpDvbhEau101Fg931MkyJhvcCVv4ktaCPue8yHXOcm1Bpm/BA
 tkeTDGfXA78NoX07kiqjUfhDkJZe1TKDgRSBlxKrnzk4A5RdN+76fERNtKzZg7I49/5/oZljXCf
 C61uBSqcoTw9CHEWLbt7pIRMNX4elXEMD8PfePZNING+lEYnrCYgw8JHuuxak6Y4hdySdw5MQZo
 q6zUwk+Pz9f4Z1Zu7/V/kXw5DdChP0bg73dK6xrjvv3F9Y8460/KY/HL6NMqsfk6hrYvucATWmD
 WG493wtiHfcgtzYzPobxmenUXLRvffkVRGD0G3zAN/3LI0ZXJWlZPzg98HUTA82hQaq3aqGvYKv
 02G/6/yd5/zBgGDvK0BS0axWatVMdvYhk3lOnSiCbTZPSlv0KeEyXPQmXt4ZX3uFEf5HMSjvfoW
 fjoEx/zcDpfB0Kos3QzGMedzWDfiM7fEh1sqxt7fObRcbZgpc5p7wqA6gSjiMMdUnLB9dDCxvnl
 TS0VcK6KhFTwue6c9YbX10M0rYxkpgBBIGySqZxB3Ufgu0IjzlBaxEmaifhsAw==
X-Received: by 2002:a05:6000:220c:b0:485:8a47:5b80 with SMTP id
 ffacd0b85a97d-4858a475c9amr21197044f8f.29.1788792156369; 
 Mon, 07 Sep 2026 07:42:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859207c28fsm22787121f8f.5.2026.09.07.07.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:42:36 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 14:42:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 67bc78c7f97e197fe98ce901e36edb13709376c2
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 14:42:35 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2de1fef1bca1f216259e8590941ebf15ec8651f3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3aYV-0003Z0-1S
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
Content-Type: multipart/mixed; boundary="===============8246611299856688659=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8246611299856688659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u2WTauD0UUY="; charset=UTF-8

--u2WTauD0UUY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

srkyn has posted comments o=
n this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?=
usp=3Demail )

Change subject: compat: close all unrelated fds in forked he=
lpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 5:

Good catch=2E Patch set 5 now creates FD 101 when the limit permits=
=2E The test fails against the previous 3 through 100 loop and passes with =
the new helper=2E Native and fallback runs also pass with ulimit 64=2E


--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b=
364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 5
Gerrit-Owne=
r: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2=
 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Comment-Date: Mon, 07 Sep 2026 14:42:35 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: No

--u2WTauD0UUY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Good catch=2E Patch set 5 now creates =
FD 101 when the limit permits=2E The test fails against the previous 3 thro=
ugh 100 loop and passes with the new helper=2E Native and fallback runs als=
o pass with ulimit 64=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1881?usp=3Demail">View Change</a></p><ul style=3D"list-style: none=
; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1881?usp=3Demail">change 1881</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa2=
89dc55 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1881 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 =
Sep 2026 14:42:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComme=
nts: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

<=
/body></html>
--u2WTauD0UUY=--


--===============8246611299856688659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8246611299856688659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8246611299856688659==--


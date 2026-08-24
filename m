Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC55CC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2p+q7ddnAwj5hgoQ47mq70izynVq5ct3BqIHeyUaa4I=; b=fUIDMFG1oto/HfLJaLFXM2lOGZ
	nwTA79XmucBieYozNU3MbUaiC6kbSNszaafioGCcKIEQgClyeV84jU7jZf0x7uFZOAKSjMNY1UC5P
	SZKAXom5hpSVMC6Kc1e6PU/wi9z8OONu7s/hmLWSJZbABBxAmElnBzQjPaB+/qZ6HJAg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXLf-00036B-HH;
	Mon, 24 Aug 2026 16:16:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyXLf-000364-5q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Lgqc4avHOYtkN0PcTIWvaoW0GPZFbigJmHgP26eUwf8=; b=VFSnRz3i+lIlaNvciKYbcaQGjk
 sp0YOoQ9S4jQGCkfARWm0oXMI6tweu2haHqVY9EthJtNHuPK1IxQbLVl7IHRii1+W2M4yHQfjkKM8
 Z05ReldW+CGyEp5fxQRErvNRyXi0yQ/YzekmQWAaXm9rZ1Ex6HUyqDXPdJL3QYUVD3VI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lgqc4avHOYtkN0PcTIWvaoW0GPZFbigJmHgP26eUwf8=; b=i
 qFKIuwFswOd+ag+Q5na1edkuwvpLD0U2GbB0rjYNYOD2lht4WNbeMXlOY0bABFTdMlT7zCZsXlOpg
 u/R2P4EYGryRsUIY5QGDY/ZLRoACfecEHxyI29TXoL+cccSywzwNTlF5drh0lPUEj3cosM9CD5dq0
 S48HTu/X3WfnvbLI=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyXLd-0001cq-I9 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:16:34 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so7141814a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787588187; x=1788192987; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lgqc4avHOYtkN0PcTIWvaoW0GPZFbigJmHgP26eUwf8=;
 b=XLeSeEBKkpH36D42Gz1+2s+E43IlHYl6ZrAG/h/auSazTH7S82B5QTl4CN5MePBfok
 TIaj6YqsLSmfa9dzeenFagukIQ7g3av/v24zeSe7h5iBZlMAIG3ZZuQTlpGO7X6i8ypn
 XxQYcBey/qBe58Pvc+WOeGCIDjmX2kujiVS7r6FNP1gfPWIx0Tm9SuWQmssSIr5+uG7F
 ug6M4VITIMr+JyOzPHaqcOinkq4q0k5xw0PqZcc+PIcYwBPdWhjvWiCjb4K7lMpTXAMG
 QzO6AECrtUnJvDm3o1tKJL7/1+fAhZI0AciDQgu7J9RJUf9knc2NZbhgA5zmXzk4tVxk
 Cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588187; x=1788192987;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lgqc4avHOYtkN0PcTIWvaoW0GPZFbigJmHgP26eUwf8=;
 b=Od2YtckSXqZAKap8SBPb0iaWU1ASQ+by2eMhNMRoS2cP1qXNZHmS0V1ZQeO2KxKbK4
 Rgj6fnlpagQ2uWoqnvaqHCVlqTQBbuD4iY0r3ZJHzRGjIfgGkhy0ARmUXlk/4Nepa+4Y
 ytWpxsdPxYL7VNDj5NiYRuyLWys/If93LgaL4CAsembXpVn4ZK6cRZeAAhFvm8tbmMGQ
 DQvx45XR//NcfcD+My5Qba85w2IMwxLaWQl7kbusvLZyDKPAtg3jjKDnhkUY1AP8Ue9X
 lazwppRcP5QpnWE3gr+abk0lCb0Epc9EZtoVzzOhPvd+CzZnjenE1bCoRSkAhhEVPZqj
 eRUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlrUOQvqK6sKyx+hnT+VzmmUPMygfWfWH5kN3eMobZXceTjd4HzTYQbsq8S7FQ5BupTElc8e2UM2se/WAw@lists.sourceforge.net
X-Gm-Message-State: AFuF++myG+TLx5e57VzhUaeL7yWFJU3rN2jwWJa20cvqPiFl8ZEfBJyT
 w/GDXj2cV80j4obnpaiTAquralZdDB689O8vr29ygRD6aLLqe/6wfQU/giRzO3Os1Rytp/86yM2
 6r51FlFzxMleptxZDb0RNAjKQIuFAtHf69oZI+kdq2sN8XLn18N80hnGf6wwbmGaTj8ns
X-Gm-Gg: AR+sD10tYoWFj4FV33X2tT/o/+jK87JuIW8gCi0SaWeDdX+qDgDt9Cf9CUSLjpFEo+J
 aa9gZIgbGmZxUuieS4It6N1f+2GSFJlSxYiDs76zOqswvGboMtosRO3DJrUoly1eQt8FGAqYVGb
 GEFzlE5FX7F6pHchcRnVMkr/rn30xUX3xO1inHvWVaZTS34Ak0wPnag/MEiDGP8X1kjPGHf071b
 Gzy4YZ5JF5PxsWT7FedKn7B+3NojXY7bBobYrsYO9v2pBemICtQ8qdkP6xjT4s9t7ExnNichTsm
 mvxt2MIpPCpiM12PIFR18OI0SUeOSP5WNs8b5ob7a0089ErOdeVT0cXTOXcK8grqbh/HVPSaUdL
 HN64dF3ZzoS+LOPhvq/58czaD6alViPBBPSdLGL6Mz0nxVpOTbtDyG99XsjHJYsVP8v6vjUIrmv
 OKlNESJ5f5951SK1zc8YRzNvQ+DW68+j96GoYLVqM4p3mQYt5zzTKFmJ+Pb2iBDHkQNLzpZue1M
 +8bYLpTy9rNngc+RDP9IStyaAmRKtt+RChU1mZ0WjQYv1OE9LO+XJb8NGHVr/zUsoUePxNh3abg
 zc9VdijQsj9yhL3Vh57kflUII/pIdunsf5kre4q1vWquJ0PSHmPBILDNkyCXhw==
X-Received: by 2002:a05:6402:24a1:b0:69c:76c6:9bef with SMTP id
 4fb4d7f45d1cf-6a582b6278emr21527142a12.10.1787588186781; 
 Mon, 24 Aug 2026 09:16:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1ae4efsm8588024a12.21.2026.08.24.09.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:16:26 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 16:16:25 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
X-Gerrit-Change-Number: 1862
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1862?usp=email>
X-Gerrit-Commit: 0adc13f664119943e96cb7bea70d30add3c04132
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 16:16:25 +0000
In-Reply-To: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
References: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkljZmIxMDk3MTRiNDJjYWIwYWYzNGYyMWY4ZmM4OTcyMDU5MDkxYzhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c69ee368fcf994d0c460bbace9672b3a188d5da2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyXLd-0001cq-I9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interval: Remove
 unused usec_timer functions
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8308845669850840782=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8308845669850840782==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ydADmqk/dko="; charset=UTF-8

--ydADmqk/dko=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1862?usp=3Demail )

Change subject: interval: Remove un=
used usec_timer functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
Gerrit-Chan=
ge-Number: 1862
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Comment-Date: Mon, 24 Aug 2026 16:16:25 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--ydADmqk/dko=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail">change 1862=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfb1=
09714b42cab0af34f21f8fc8972059091c8e </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1862 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 16:=
16:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--ydADmqk/dko=--


--===============8308845669850840782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8308845669850840782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8308845669850840782==--


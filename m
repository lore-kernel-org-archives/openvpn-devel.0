Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF5606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=miZmyU/M;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NFMEr75I;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f9EypoHA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qrwckeh1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Kik+8pBqWLY6FIdF9j9tmKeYhWIttT7Gw+nMwi3vlEs=; b=miZmyU/M2flBl7132CXxu9gXPl
	t+xzBb/6dLyCJc9HH3pxN/P4H4I6yhqzwnf3gfbJW5lP4iSDGqquRHAsCUgDZoLWXLBebCbLLOI8/
	nQIuHfDgRZWewI0nGN8o+xR1TIr5kZSFcUhBcD/On/2JOOR6/Vag+jWiCn8BN8SkobH8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYeO-000000005mZ-0Xyy;
	Wed, 04 Nov 2026 10:55:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYeN-000000005mN-0Wmu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:55:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Iy2NNS9GN+yHfU3CwXI45XiwQQDAY39WrIL6p9c1pM=; b=NFMEr75IpZQzKvjaAmTIWgkS+p
 NVe3peoNRkCs/YdY6wTdtabA5JbPZuBluy3lNxwks5foSYhS5xJa9jSRigH/JEG/un5kyXNBXY9k4
 3Wu1GjEh5KU9y+OKDCgzy5VgBwCBB+ztx5Q3W/8cLjTLSFfrF0+jAZHJmPsmC/B1SubQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Iy2NNS9GN+yHfU3CwXI45XiwQQDAY39WrIL6p9c1pM=; b=f9EypoHAMwKlWUfliXBDVQGH6O
 xvGakj4+oQgumoWijUYCY7iDUSzsUprTlaXwXwa+ngZwjRADn1fOarWu1havoqclLJHO2I6vPfKMP
 JA4vobiyadL8xZ0D9dpXbduu58GLp2gLnUsqhiAc70gmFRSL9Ih0ybXml4B72sy9CXNo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYeM-0000000064S-1J4T for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:55:27 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so4474925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793789720; x=1794394520; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9Iy2NNS9GN+yHfU3CwXI45XiwQQDAY39WrIL6p9c1pM=;
 b=Qrwckeh1NFcMkuNuaHx/z8gzfn2/N6e06rPXByb4hkaKM7RdYhiUoO97o5iJg6FAvH
 vus2rGadtDer1zhFdFyfEziIwsmCtFPEx3s4d6XuorjmOPs2VJ4WPtJPHDqHZPKD2kpq
 Tf+3Vc7KKajYn3X7JQmyoIzN6KP3Heh9rRkeSYD8ASW3bL7uOcRQxPXc5Cu32qnOS6ww
 JSQhOo1YvKyTqsGQ56P/H8QKTw7PPNi9reWGDFGrGvr26G0+kYSp6hmE4gdTrEatZnFG
 lNfvjoLFGSJiC1o4Wk5fMPBJ6FJ6trwu7QuwRVsIFLLEcrsVzVEWhI3RzEbkZCCoTSEJ
 f7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789720; x=1794394520;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9Iy2NNS9GN+yHfU3CwXI45XiwQQDAY39WrIL6p9c1pM=;
 b=TXmNYyblJ9dHmECG3WyogwDmEn7tUcJhiN9VQixrU5m5n+cH6LJDdftuXZ9bw5X6Sm
 xl6NIB5nKEvf8YBlUh/fj8ZIR8+2Nyvomt6Sm1JgPT4TUYRDPCOGShqgyA+BnE7IJtw+
 7aNjrPka9zXz4pjxSPWVqpksBF5ecYAdSl4ALuGVgLnyOAirAHHTCzC7kKYI8ydWRxf6
 pWHyjcDexj9lI9Glz5oisDwKBBlC7iZZZcdeOuvzxclsLxQ8REht3DHLf33lkY/sXz4x
 mZnZtm4JQTJM35afSdi2bwtP47WaAQvkiwKusOGrChyeZSPH/nE90bzK0R6lWgNmDLYk
 QHFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKfYWbS46C3F0zG8W3EgzzpftdyAZKa5F7xtBEElM7ww+p9FcsmoxCEpsk2nxGoUwAjfDWF4QRzKd0nEA7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9zp16EooXxGpklP9RQT630LZOvxMgD/fjvc0wE+uqA1vUNfKPp
 UKZL6zRIjVZ0xo/Fpl+8nJhMzckkZB5aP0wSa+Maoy6mIdEvag6j+jy3C8S42LwqTTa8N/jxIli
 WvTZrdFmAvAzHD5wz0SuqAWz0ia+/DXtRNqp1P46mhy57Bi9MqC51qJYY3D+k+Iz93EwY
X-Gm-Gg: AYBFou0vsbd18VAQVCBoTJuQNvlWBWHfm4wfjpEM37dCuM2CyYsyrgVQJrVDa+CndXH
 VD9Yjas0L6dLgD9+MlC27w4ci8GptkHjuPXS62GbMIu0FRM0BohnhnO5mK9idMBi6cS4KsLndZQ
 YJanFlvhaR97S2uvl3f9cqxR49a7KA1S9qd9Yeepi0TnNdHmi9V929QraqTC50y/8g0s5vAnHUK
 r44KimUW7DjuGWSjKNnkHjp+1ZG6HTjeEI1Xf/ooFsq7GB/hXUgYvxd+7ZOvDtoJFWV0v5pVd0e
 3L4Zakzm6iCinBu5gHKyN67Fy8/6EjmOvFUBbi5bM/7LDRUcdV2EYS0nVyod5JftzLb6X+rLYhI
 Cpgwk4IcMJJbRS4Ex0NgUUzIIU/QhCClVhHQpyCsW68qlouygGzilyufKKYphiZzjHNsz2MB8bd
 lkMf6VG7X5JuZijgInpz1/Gb0yPxn02xrXVMPol3iONNRhJMShTjWH3gr7dQ5H47TQBrY+KdHZ5
 mx2Rap1zpKYrJtuJdU+Gq4s9R6Ags9tL2pvh79OAYwj8cbRuxDOazJiF040kBLP7t0QxPShyQJp
 r2NOmGa6Oc0/k6t+AUmnIfPpKxpmAO3zQ3l3nxj0IeFPK2nthgqWxWatGUU9pp/RHfhVxzWjVQ1
 0z9ZmBeBbPpAYhuxw80EKCq2Zwy3UydJhdE3CzRL0nEx1Gq635XzRpVTriDQVy0SzPozdI8X4ew
 /0zMsdY9aeWg+GzCE=
X-Received: by 2002:a05:600c:3f0a:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4b3c3545341mr57114475e9.20.1793789719603; 
 Wed, 04 Nov 2026 02:55:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4104d600fsm47324765e9.0.2026.11.04.02.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:55:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:55:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
X-Gerrit-Change-Number: 2122
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2122?usp=email>
X-Gerrit-Commit: 71e9f3278cd0b16c9e4862ce99087eeefa2a051f
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:55:18 +0000
In-Reply-To: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
References: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MTcwMDAwLkkyM2M2NDgwOTY3ZDQ3ODViZWFkYTM4Nzk2NjdkNTBkNjBkN2Q4ZGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8934ba482a4c71d7435a5e79d1df759dc4cc6add-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYeM-0000000064S-1J4T
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_mbedtls: remove
 empty tls_ctx_personalise_random()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0869966515449339913=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0869966515449339913==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xrJWu0pBPoY="; charset=UTF-8

--xrJWu0pBPoY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=3Demail )

Change=
 subject: ssl_mbedtls: remove empty tls_ctx_personalise_random()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23c6480967d=
4785beada3879667d50d60d7d8df4
Gerrit-Change-Number: 2122
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <=
gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Wed, 04 Nov 2026 10:55:18 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--xrJWu0pBPoY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=
=3Demail">change 2122</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2122?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2122 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 10:55:18 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xrJWu0pBPoY=--


--===============0869966515449339913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0869966515449339913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0869966515449339913==--


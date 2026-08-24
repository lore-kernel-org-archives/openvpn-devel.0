Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A53C5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zBT/WFyGqQk7qYUh122lTKSAFSx3BUIsQFoKV82h0M0=; b=CzPkgg/WTq7Y06+9tO+UF0+Ajf
	35UqDVAsk6ByEbPcYjjAHPKUBQF823QTGavoyZRJmwKnnY1JbFRpgaVIqBk9YEWiy9R9PyBJHqK44
	3ZVbZVlYPxsMG0LQWIWDK1GWpwdQVPwDwxbaGW674QhuxNzBbzyE+9OD4JFHJ5AOEOtE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXL2-0005OG-M3;
	Mon, 24 Aug 2026 16:15:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyXL0-0005O7-Rd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Nt0FoOUmgZ5xSaoyGkUJS7MCLZ8DL+tUDcH0+lXUSr8=; b=W6tN/sxxjMVHSZDIqthAyv1dMv
 dZxnvujQWZEjjExUrWbglCSW3cSJSPwMHbhYElInYDuKFgnmpmQvfxzWm8G7DgD8UnnkuOY08FsPz
 BYWPgVQ1JRhsurYHEZjEGKGrUqdSsfbIRMCDPcTVU8Jw0J0NFKBZMZQWUJM9e3xATFTA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Nt0FoOUmgZ5xSaoyGkUJS7MCLZ8DL+tUDcH0+lXUSr8=; b=b
 SH69fio0tb+et9xRJLgkJAuveI0jmINlIFEWuuPnhoahYbs0K0UTMY8tZY4t27sreevGMqKMJYvCg
 RHMzp4vb2YI6+ikvNguucQdjnRZhDXwIIiNgx5WcoSjhznMjbpjpipQdYKwpRy2iFjvi5htVYc9d7
 KMmMAJLebRDt5Hjc=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyXKw-0001as-UT for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:15:52 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso521370866b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787588144; x=1788192944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nt0FoOUmgZ5xSaoyGkUJS7MCLZ8DL+tUDcH0+lXUSr8=;
 b=N0jK6VW36KzRwGksyl6PLSydZYR3CYDDxEjk8KA+T/5GLvWcO/mQIaJoGlTAW8bL9X
 j1Kr7CuNvkWdrlXPytYMdu96qRfh/eIvlC/LO9v1mOtJzLKcZiZVGxB7jbZ/DWrV6NFb
 /6I7BdAiPESxpoIsgIVZ7X4r7cgGPtl7RORDk6qvJUaiypiKz2k4FOgJapvjn5w2o2iR
 lEPk4x/o+OAOwcZppVocOnB8HeAUCkGwGRsdrJLGHNbGHl641HMmHzdDea/iXzC8lqsZ
 nQ2Y5wAoDM34Xz7qKsHo1zc+IxPPt3XOVRenb+lGUsvtybt8ut5Q8MO8mUyIX6HcTXtO
 Ri3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588144; x=1788192944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nt0FoOUmgZ5xSaoyGkUJS7MCLZ8DL+tUDcH0+lXUSr8=;
 b=qHvStBYCSyheo1c77lQTBDXRwgIr3ztOLqcuvAHCRvtzsNvo7cSPCzki0W82/H/wIS
 tmjvj7LNr7a+Gn13jxF9rvIeTNTvDMTOoWEpWFKfMD7RHvo31pFXOa+Ma9dyzSrY5ku7
 nF5RnkVvxwiWMmH0Ex1fwW2LYIXEvF1No4h+2J0W9CRD1dx62Tk7YfDShfm64/CtaLdY
 n6wO+H3hHwvm9bZ5wvGZzEh7GfZkw+EtCShe3EK/uM7kFHmf8A26l/eeR4+Heq5X2b7O
 aDlfBveYwkTr/SkFtoe+XbcfeuUluFNu0fAC/6E4bzRt6Q1s6JDKN72FiYnUKF9qttWb
 FMrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqekwkZ/7gvrFk0YId6wsBltGunmhF8SMm3xLuM1/CjjpyYSmPkcrUwsaSSUz0OzQ3BHtD0sjpzYOsrY0sO@lists.sourceforge.net
X-Gm-Message-State: AFuF++k97T9NnzsaP3bBTT1nrDQBINZdgufQmfBJ5xXDf6Lzw5bLf32H
 jHwUNLyO7rrhV91MmdxBnSUL6zctuIK4ermlEqccHuiotUhfhqSbVbg37W9ATEgNvXpyGQEQrkl
 S6zRgqz0ICs8QJ7dM5SnuEYEQmCc5jItWvEn9AJfzU3t6cYYsb6tvs3l4Htxi7Vm5/2K6WZbwLo
 pVRmGPxA==
X-Gm-Gg: AR+sD11+XQRDKAyRWsY+ET1a1NcumzKFvTLBnw77tBa83M/5lBW0rw3HttLZpzzS9jE
 G8AYdVOWr75qvCR63x/nFupeImv3b2Uuo2qui7GLqYsZrxh758WOjYi6rA7Ra0/ye+ycTXT+YJn
 Xvy2e/Ytn6CZ3hRQ/IYDiOAEYENkioPkGn2bg/fWaZolatL75SPxZHW/Tu5XxsteC1cz7zy2zmO
 +qMlEMk507bMwnJhIiMk5qhrzVfYAmip95joQAJ0hYyLKyfsL5yidiOP2+2jcSIj7e+U5MFvsaj
 GxmDFpEKqqT+A8rsWPl4rbwPc+ccgcw/1sVO+MEMe0MSodCgNiJaY3g5eNW9npfhiQf9EcMosYQ
 wv6uLqX8Z9bUd1bC47Ts6pK32RTNu601BTR0OjNdJUptWnDGyhQiRHsucI8tW7bB5untrzXzb9r
 pNDlEwB0H2bv09dRvc8LlWpAZtB33t6PpgA2H7vve1EEOxFK0NPGAkyXbgals9SWH0bjPaAFAYR
 KeavJG2zk0pjj8t7rgmKw+kiCdYwfrXIiP8yQ95vYIuNJJUx47T45Ig0N3c+sikLfb7uxL8xNQf
 q/geYzMrDgaN5SnLf9Ke2qvOQhk13+EpqAGiVl/sL5AUh8RkpQM=
X-Received: by 2002:a17:907:f509:b0:c19:49ee:19b9 with SMTP id
 a640c23a62f3a-c246a654f4emr3378972566b.15.1787588144320; 
 Mon, 24 Aug 2026 09:15:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9cbcsm1486449766b.29.2026.08.24.09.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:15:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 16:15:42 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
X-Gerrit-Change-Number: 1867
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1867?usp=email>
X-Gerrit-Commit: d39b040ce834aa1f6cdab7005b01e8434601353e
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 16:15:42 +0000
In-Reply-To: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
References: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkyY2Y1ZGEyYWE2ZmJiNjgxMTZjN2I2ZWY1ODdhNjQ5NGFjYWUwYjU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8ab2fdacdb06a2f49ec144a3749193c1c824b74d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyXKw-0001as-UT
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: event: Remove
 unused function event_set_return_init
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
Content-Type: multipart/mixed; boundary="===============2305262390901428736=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2305262390901428736==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GsdCcibGoO4="; charset=UTF-8

--GsdCcibGoO4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1867?usp=3Demail )

Change subject: event: Remove unuse=
d function event_set_return_init
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
Gerri=
t-Change-Number: 1867
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Mon, 24 Aug 2026 16:15:42 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--GsdCcibGoO4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail">change 1867=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cf5=
da2aa6fbb68116c7b6ef587a6494acae0b54 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1867 </div>
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
15:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--GsdCcibGoO4=--


--===============2305262390901428736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2305262390901428736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2305262390901428736==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE64C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t8+odxAy2dhrPlDXXI+wMYK2v0ICA47+/q9s1gATluQ=; b=CUh158HgirZPPeB8aXj+8xLgwz
	xrUxzbZuenihYF5qbsuyegrlLDwpJCMq8sNsePylvzHGFS+wxRx1PSZ+8Kno+kKWhIr6jgRu49lwj
	6GqrD6kGL/ausIjotLTaQNLcu5De0dTTbIn6+CgJDG97KwBvG2kDLsB87dRwaTHUeIaY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whULr-0003T2-19;
	Wed, 08 Jul 2026 15:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whULp-0003Sv-Oc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fEYd8JG9WAL3+z4t6J6e7w0QGalDWvkQfbU2ZuYxXdI=; b=cRhd8XkkvN+in1Z6M6rKZlRaKo
 823JLdOl9l8AgO+3ogGp/BeSkt0fZf609OHIwDZzcdsyr+23trwQVAQoQP1RkHX1WT4Br/gFmN7lA
 NpZOxrE9dJuj5KTBsKX7/VRLkTl4aIhAwKe7/lgB6Cefr8zGCuj9STirMhrefvWsdJ/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fEYd8JG9WAL3+z4t6J6e7w0QGalDWvkQfbU2ZuYxXdI=; b=K
 Wdwc6iOMC0bEHbgM2KnXpXiP5qlM3lavKAA1u+xTe5iFMhSnr2IRrFSJcksRP4wZz8ysa9JacoJNe
 wg9RfZoJKsTFpHs37m+A79Sc8gBBsggf9kO87zZdqDQcjBB+S8K6eLX60yRklRzSMqvPpnm3gkJ8J
 Uw2W8ik7lbLoZ4Dg=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whULo-00084G-7L for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:38:17 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so534147f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2026 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783525085; x=1784129885; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fEYd8JG9WAL3+z4t6J6e7w0QGalDWvkQfbU2ZuYxXdI=;
 b=THMSYKeJhHln+GoHq5Nai2vIiv4AuVB820AqAHaRsaPTIdtWZCDsBC1HYKZh3Ua2GH
 zf9nY1Xw3CT7Gi3cxnwUOptM1hYOjsj16S4pNf0I9U/qXnXqEIeGgzlayOd6vfAQQK3y
 vL1U9nCkF9SV8vEl7a6pOjc5XIOZ7o1nqTK9su8VsytQxpgDwHpOpJZYAXeSbyF/kjNg
 yCwkTHZECjrf/98DlBAsD/pxsIQ7LP4lWOP+dGUeijTI8W+0dbk8tUAOE0rx+KNKpghJ
 2D/pB+gv5FyXIS6lDcHEdCCAi4Y3mIBvZQPyzsvr1Io22ytjz3Av13vZuwTtJylvDztb
 SuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525085; x=1784129885;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fEYd8JG9WAL3+z4t6J6e7w0QGalDWvkQfbU2ZuYxXdI=;
 b=S5AN9oTRXNWKutpecNtCzusEGVDUBgdPa9Qf41GjHnrScb10LcnaQ33WPnBXtCJZXn
 gAHXDgibRk2zll0/H7+BXNwA5kt8tvxewfXSengoLqCnzQcubPidf4qlf3n+BRUOYd8t
 PGtotDtMpjqmcwLio9R9QsTC7xV9akxNxGu003aAbtVKXk7MU8HOdu+OpSOWN0f/b/FY
 VbAzCZ640HbAfd5ibBmr7EDt0ER6CxZCZdzUiQKTi1uybjqvfsCqr+5yqMWgNJw92NbG
 7y/XktO2qoC7YKjuYClPFK75yM5mbA9y7xeKPYh4+X+W8lFyr2IKK1+CI8SlPoh0NKkC
 2Z4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RopR8fDlXaZqCPe5fxnS/6fzD+GZkMs4qkbYhrUjFB40CnKTwViiM1gUtv62ZunD5DjlkU+ltjiddvm6P1c@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx+mo/g1PjuQnXaM3djvhfoj/bcimNEYORc5OGHd201nB1FspeI
 DwUaOuxQOjKuc0dKdFZ7BRsuUa0d5zWbgd3M0Fntv+ztUm91emtt/G9u4y9sC+RhV3Q+sC3i2ck
 0NG7DG2kSHXvt8mJ0YLwkXhBU5nHrPkyoI/LT3xgQ86kCWg5uCSydv7rOoIYoVk+NIeNR
X-Gm-Gg: AfdE7cmlkxM+SKbtV8Y9vG7LwoqsK3uxcjAILxL8ufytncG0Sk7KBrkrTAIUzticQ1+
 jNk64657Mr7GiaK+17hTGmoKaGjfhyauqst9qcgFLvu8JhWAh1NVW1KFy+/EZfFg9h3R8e6P75F
 iKyTc9ZAQxAemBbs7DJyEK6M5PqGCOQYeO4PgEtd+A45PpqTzsjseFalLEffcPs5jbA4zshMJeW
 W3jPc5VztKpQDidpgK6W+8SzV4rxnDl/hUVi9+oM2AdvFZBzuFP2q+dEhkAX882qtRODenp6gWt
 R9lsbaVPQ6JS1VUCD+KYMAA0q2MYLr/9WkaxcbcMBbE8wq5yUM8hZ5bJW6UlgtbfsZLucQzLZpU
 +TkDFnmilkdEduTkhaKKEyTwVuT6h785wQ2CupLwsq5VxJUNYfhFILM6YwYw0Epv0z8+Pv7q5uT
 5lP2FQAaaF5DJo9aCpt15tga798l9erpF3gkyw0APLrHDlZMyy8gtha0IUHniDeWlTa49oaIInP
 q041g/kjS48kJm4DLO8qOlQucCAbEF8wTyfSAMxI5oOOd7inIgnh/TSimTJlSf9LdRIrYbzboBQ
 nt0=
X-Received: by 2002:a05:6000:2c08:b0:475:f0f0:9ece with SMTP id
 ffacd0b85a97d-47df0819813mr3352694f8f.57.1783525084381; 
 Wed, 08 Jul 2026 08:38:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm43426656f8f.27.2026.07.08.08.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:38:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 8 Jul 2026 15:38:00 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
X-Gerrit-Change-Number: 1739
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1739?usp=email>
X-Gerrit-Commit: db8e018e3ee3b6932911b2ca65d7eeffb6609e80
X-Gerrit-Comment-Date: Wed, 8 Jul 2026 15:38:00 +0000
In-Reply-To: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
References: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljYzE0YjI4NmYyNDA5NzM4YzczODczYWE3NTUwZGNjMDA1ZWU4Y2JiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1f7bc9aa47f65b77acce909e79571ce7cea1226-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whULo-00084G-7L
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: detect
 cmocka_version.h via include path, not by linking
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8446743154332444935=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8446743154332444935==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="POV9Uy/A8xA="; charset=UTF-8

--POV9Uy/A8xA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1739?usp=3Demail )

Change subject: CMake: detect cmocka_versi=
on=2Eh via include path, not by linking
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8=
cbb
Gerrit-Change-Number: 1739
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lsti=
pakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Comment-Date: Wed, 08 Jul 2026 15:38:00 +0000
Gerrit-HasComments:=
 No
Gerrit-Has-Labels: Yes

--POV9Uy/A8xA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail">change 1739</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc14b286=
f2409738c73873aa7550dcc005ee8cbb </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Jul 2026 15:38:00 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--POV9Uy/A8xA=--


--===============8446743154332444935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8446743154332444935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8446743154332444935==--


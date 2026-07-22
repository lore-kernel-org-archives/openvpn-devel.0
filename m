Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9678AC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKkrpIhBthuXTBDk2pSJe3OrKzEnASYJn0fDiSkwW0w=; b=Zs0n3S2so6EqkDCZUeLbiUa+Cx
	4gPhlM+7Pp5bd4xbC+BURCETM3DzGT50GQ/JbgTmqMZs9YXvaxjlBODLI1fMU1eWvxZKHk11Rsolh
	lPDBJVoM82hh7l6WbX0zI+yrp3xlJdBnieGFQ9LEAvNAaG1p4tijm/TiI03vcGdTvgwY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmdOt-0003ZV-Qc;
	Wed, 22 Jul 2026 20:18:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmdOs-0003ZO-27
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DINsQgSR9iXmQ6sqI/1gMrbfYaZyQmJTcEGLpOs19ug=; b=eq6u2LZk1DgzK/Qm91DELZSuyf
 oYTrUhsETG37TBUMkYTFKfNuQvhYoFTG3GtVNmwBlD87CgszHHgabj4ZJSGW2MaflBs2a0uOv2m/S
 XaSgpKkpx9HvCyQJ1uwq1RUNR+BsjInLQ/U88bHF2325nPKJccqzJNS74Md7Jj4Oqnyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DINsQgSR9iXmQ6sqI/1gMrbfYaZyQmJTcEGLpOs19ug=; b=K
 +4tfGlD13KXAJDts+AB39eDZRme46BijlhIS33kgX5H1nB6E/2jDnQsWRZ1ei1JMHc/zWtKOeFX7p
 cQFIZ3qQ9TVzM0q/P4EaI9zUdesR5X59973ubnk+x3tVbw4hF9pc1DhOO7tWsbH4/sCVYNcCyUQcT
 lTabsNmD1EfMHPlc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmdOr-0004xy-GY for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:18:42 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47362928f65so11807763f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784751510; x=1785356310; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DINsQgSR9iXmQ6sqI/1gMrbfYaZyQmJTcEGLpOs19ug=;
 b=Y+So76b/IcSeHxq0buEgoxrfW06wqCPPHmik8BNJ4Oteueocb03jZQrDU2bfr8hHeY
 qbizoBiDUMtFQUVJbn65hN7vQwP3tET+qeoRjJDP2L/oWLTbQWAxokW5l4Ck4IMzl9/0
 MMySsMEg7elTFuxabE5FsXP53DLVtCRNaX2tFRbNbM6EgEGXOIvX3BvV5QZjIkmeoA9F
 DyeQBCQlgD3vxJzpb02F/adU3nzK2ULYtLEdg86QIE5gW5t9DaRXrHFDc2QU2yICphRg
 9FR+AyeNEeSQlXJK1vBSMd+c1gdrbAyj0lKeCDlMVtqZ4NWDdW3H368fOmqTtwiot/r6
 Ngmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784751510; x=1785356310;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DINsQgSR9iXmQ6sqI/1gMrbfYaZyQmJTcEGLpOs19ug=;
 b=EpZgNmXFIIarMGdaTh/wpHmsmI+nvKkZ0ZvmDCw1G8/g+EcqkdMnPHOw9NpfNvMPIb
 XlYLue91NQDkV1K7aTf6YCe7wSApwc1wYFWy7LGSO3PZOgz4iiTk7b2JMbEqw6L3NdQG
 hO1Z5XC6m0u/iPEHtfqLbhG9Eb9nOLJzqxFwUyf/6xFiVHMZrakC+ZrfkrYWtEMwcRUG
 iNdWo8KB0zy904rJyOLM/qSmVCKX3Mcs9yUle9QRmKF16arHOtgvwp7GYX7e5FEWzqK+
 /JRTyB9+KVbIe8XaK/DzNq8Hp2io2go+dJES6mspVaGeDRjj+4aEoRSvT4ctfpg9FLsp
 cz7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUIviY0B4zOD3B5ppf+uJhBI7b0JDMOyiNuz3wYLC5Ooie/fVbpkGGuDEHDfUeAzN/MLIfn9Hz2jZUSkbv@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzN57kxgwjqk5IuyNBBcqZkGzsNr+XO8Xg8Uu1OzoypxK/ioFIT
 kqwgzbbJ2Oo86uczDQ2HbrZgnv7DvchLm+cAw/jorgscBZuefNdwwY+yh4TAIttGwvPftspNII0
 DiRytm7Uo20z8Kv59RuSTekEyYAFicQE81dJJm1ebrAiJq3ACx2eWb4QojQRc0gngb6Ip
X-Gm-Gg: AR+sD12db+Kfd+kAmfc3Y13po/ikpz7E8ZmP19fNijeNtCfsp62zX3fDR0JaIw5mssx
 8dsWHkej2ydj3UEGzPqL94LLineM3Z5rBbCzwVEL/i+pm6ecMpL1nV5G8nKpTNKg+1/rkLmBg2M
 KHCKgYuSTgXtUUS5nUc4l2gSkNMuTOgspUvm2lXSPjXQccaUNrKwnURB1UeSGcc7NavCR4p18mL
 aFJMVJotUo5ND8XHGcL+77N84YlUirDxPF0gj34sBtEUgQ2q4JHxCWXptAmNCWNMCfULg2jiD0B
 0C9Q256MRia4jUWneDuIKMdrcOxLd9w9qqtP0fnIa8v34yK4C8GPFv9DT2g/kNe4jLk/u8WGd8W
 L1jC2dtjVh/YtErhDTMjQzRRQF/XUsmOsTw8HQX3TUoE/HrIA2gt5r5kEyxauQCcYMqcicnw3xF
 hwOnXLvK1HkJTU8ODW5Z4NvcGJof8ODD10Dm6vteyN/ZDsv5JYe1UMbXybMpQneERLVuXQvJH8D
 L/JTY0+LDIorhdUwKCxMYWV/8NE9htWehOshEcaMZpZYBg7J5ovDFU6kN5t2SJTEhsjPYnJRhwY
 sR4=
X-Received: by 2002:a05:6000:430a:b0:475:f0d1:eb67 with SMTP id
 ffacd0b85a97d-47f8d7716ecmr389456f8f.52.1784751509621; 
 Wed, 22 Jul 2026 13:18:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm7466810f8f.21.2026.07.22.13.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:18:29 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 20:18:27 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: 5999125a3c2d172cc9356b7bd76f4218c226d7b3
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 20:18:27 +0000
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e9ea406360c73fb09607d14c42923170b85ffbf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmdOr-0004xy-GY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mudp: extract
 send_standalone_reply() helper
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7829190181721119002=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7829190181721119002==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5wh0nVKyYzk="; charset=UTF-8

--5wh0nVKyYzk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ordex has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1743?usp=3Demail )

Change subject: mudp: extract send_standalone_rep=
ly() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 8: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1743?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Gerrit-Change-Number: 1743=

Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: ordex <antoni=
o@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 22 Jul 2026 20:18:27 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--5wh0nVKyYzk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 8:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">change 1743</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic75ca2ee=
9b59a4e11f37cd9653df268bba33889c </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1743 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 20:=
18:27 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--5wh0nVKyYzk=--


--===============7829190181721119002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7829190181721119002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7829190181721119002==--


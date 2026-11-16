Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518A606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UsQ+9wuE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fX3DhSNs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FvsVHzKW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZVPHHJ3+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m9iWcwtDqs/TyZhj/U88XZ9H/qmTC8EXyAn9j96EoaE=; b=UsQ+9wuEN+zrXee0YbhQHANJ28
	sw3M92mIoo9M0H+58CWSLiIFPAuUT7NgGdm1A9kPpz8Lj5nBntH/ukiBUl0IaFAtpEpkF+jjzTBXM
	68G5Xz1miHW01DUPCrpe13urLqg4rln3V4ekdpYl/9l0VgkCCD7pntTyF2cB6K6/OVg8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSrjL-000000001b6-2DIg;
	Mon, 16 Nov 2026 08:06:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSrjK-000000001ay-1jo3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MDTS7bo06V3NM4FpAnNXL2ymOKLPsKwf80ZHtk+Yhp4=; b=fX3DhSNstky6Au5IeQnzEHZ7On
 GVv/t67zGBvaq9O0aTQkkC8fcbZVOZ7+6/q95OwrGaiTqixFAZO19cNvYAmIXEDJa2rEaZnM01QP5
 cwxfDQpur1DEtvfS97ujuv8bCzppHY+7n1TENNlYVbSfcOWjf9fxx/sCxokeE2vGHakA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MDTS7bo06V3NM4FpAnNXL2ymOKLPsKwf80ZHtk+Yhp4=; b=FvsVHzKW2SbhRtwWjkcDHtYTou
 h961FqeSLhWFV2u/nTrOXcYLIkzRTiGWY3oyi546R6aE3n8Lj24ObP9VeN/DWsCG/wujlXyMtKP/f
 4ZjtMcYHfIQynaxbLW0Pxx1gnP26dzNsz8HZ0PFyyzoZCUKX71Zh3k1czkPcDFoxhpL0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSrj2-000000005HM-1AGI for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:06:22 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so7955265e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794816358; x=1795421158; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MDTS7bo06V3NM4FpAnNXL2ymOKLPsKwf80ZHtk+Yhp4=;
 b=ZVPHHJ3+mdzYDa6bxYG9elZOj1sMz81e2w1Zg+pkWSTGtEGEnkB1jhFmJCqyUFaZU3
 PxThfg4nVl8czNCiTfRhlvsEUouTyD6UkzrHg9lTv64XQqLO/6ob5KnHP4PUoSjhNBwo
 YbAz51aSx29cobhTJIPvP74T3WnQ2rQHGxRaeDOyY+RGGaPAAn4SA2excA4/H9bJoOpH
 XWZz4+HvGE+4D1SeNchXrTty5WqeLqbkCeXpWjpwGn+56lXjPdDpOonepdF427YlGSRB
 lAi4FbXpant5h+HYYvYszvfZH3el0d7haC/4xwnbfUEbfcZgsPWsKgCt3TqxQjyy7ivD
 c5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794816358; x=1795421158;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MDTS7bo06V3NM4FpAnNXL2ymOKLPsKwf80ZHtk+Yhp4=;
 b=2o/xexNDySO0ZodlP6CJjkPS1ce4T1a9uotbTg+UbVPHp+Q+dT68FXmiGc6+Zyogub
 LyDWEo/sAxf5PW1HRQhvQfx3WkZOuUAGv2Vna/m6dKE6KA8sOPSV5iPdI2jrB5KxCawP
 sFPF4dgbnagZGCiidNDekiBl5IV22CycyzdLscb//cVmBOcA5QerD4bsT+GqNf4f4ZtX
 MHef7A7goePyUzEfqDHQeyjhJs8jjB7oyMxCJp/NZsdzrPh7O4ZpC2QD6pIubTgnruFY
 VinvgFPNWAcAWqxtHD+wDyWBoASEQcbvL4fRcqp9ttK5DPOJFHQjjaT9yYdR8kN+1atW
 /Thg==
X-Forwarded-Encrypted: i=1;
 AL+hErG9jSGTJ3qeMNGAHCcF2r1aaBCKRoe1FCrIUQGjv9kHtyWpthhL72Ch5axcAAtYUgwd+bt/XW+5WzWPcbWZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+z2BCDSV4yuXprj1wDIMxIhGJhpcsunso9Kyt3O53behi2Osft
 pNsW8h+JGsj3xS5/2qhj+3Lsp8U6xe76oqRfMPZb619gCAgmj+sqER4QrCKXKNQIe18PydaEkHl
 4wqCWU6GBHF61LpDLjHE5Lv1YbvMBGMwDdMA1wdbQ4V5aDORPLyX2J+8u2d3rBClix7Cv
X-Gm-Gg: AYBFou3JlEB2iTRZmCyWfvd4hLCts10qKAv2nXkVFKN6Fcit6XUPRkdbz4ichrxNEBk
 HR/CEdC1hQrXucm/yUfJHTDPp0HAiKme3FQIePzseS7ZcrMcZH/92tyNxMguuRwL0e9ESZ4Nfap
 ugvJXROxa/e+CLoinAYDBDm5MHQ2zf2qXiVBBdykUBmv42DRgVxPX03nv3P8wEy6I46xEqDYrIk
 uSW73LAqO/MPea8dH4SrW9qREtEeGQZl//+8ahkiFbjkMpc9cOUsGZ+offjcRMc93H0tyyUqafR
 j7rTOXtIizK3xG0UbgxOZedh8aTRntp2oiFlfPPnUri8kA0IUK1ZTBIAMl8pNSWxTX54xel8wIP
 rzcfKWCRhNtn6BcC8kzo9/7SvVO8TyomTuxdNH9qvRDgQmqeNmx6uLjqsYBcnDHg1bE939PgVZP
 lbGqluJTCq6b4NxIYW/ZDJIoFVInjmY9oDa34BehnQa8urIOieSKZxk9cdqm7SEcf9cwGASxbvx
 ZYkPVWHAOLxcn1uuDwyxf4UGvACZXx6oyid+CaLIa5mYNdchx0FkwGrl/c/lwRi+5tmLjFf9DFw
 +UC3nHOQKJtbQwCQHuj4kSeNsbeynpSbVS1pD0/SbKsV2j6Hyv+CRCdThJe9hso8UqjnYixXvXu
 V++NiufvQIunpwjIHW7atKRzdEJyK4Lbp+1u7edRU2BMMoit01Fa9pf7tPswSKArvvgiYHBeYMc
 UrzC2X5QGFbmxbFF8=
X-Received: by 2002:a05:600c:8b76:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4bb5599adffmr189507495e9.0.1794816357552; 
 Mon, 16 Nov 2026 00:05:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e33ae5bsm321769235e9.3.2026.11.16.00.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:05:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 08:05:54 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f0721149
X-Gerrit-Change-Number: 2185
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2185?usp=email>
X-Gerrit-Commit: e314a5f908aef0f9660c61d932a0f10a7e0f872b
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 08:05:54 +0000
In-Reply-To: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
References: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU2ODU1MDAwLkkyNzJmODQwYjU0N2RkZTk2OGNlY2EyYzI0ZGU1YTkyMmYwNzIxMTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fbd7a844c13cb90ec8c7e395cf699499c33a8b1e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSrj2-000000005HM-1AGI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop no-op
 IFF_ONE_QUEUE on Linux
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
Content-Type: multipart/mixed; boundary="===============3017951783567460871=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3017951783567460871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A0Rn+iE+sqc="; charset=UTF-8

--A0Rn+iE+sqc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail )

Change=
 subject: tun: drop no-op IFF_ONE_QUEUE on Linux
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I272f840b547dde968ceca2c24d=
e5a922f0721149
Gerrit-Change-Number: 2185
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon,=
 16 Nov 2026 08:05:54 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--A0Rn+iE+sqc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=
=3Demail">change 2185</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2185?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f0721149 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2185 </div>
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
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 08:05:54 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--A0Rn+iE+sqc=--


--===============3017951783567460871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3017951783567460871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3017951783567460871==--


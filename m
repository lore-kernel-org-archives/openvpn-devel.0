Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB667606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KqmCk2Zm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fUlb1CMn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YxunqHQ1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OHu7VPWw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IJEAuD7brCbVrMDkZWue3oc2LByFTU8y8EuqEQNWBj8=; b=KqmCk2Zm2kSVRdQJIhlL1lqHXU
	/77P03tSvRpCg4+FNxFZRmmIjSuRmAaDc9q6OmIMpizk4WeE4Bl/H4YyvBzozP+HjSUN1MZju8Kh8
	410u0Muj0mcEBqFdAP1XRhqEH+fiB409bnRadwTlLhB8lCTwnQ88OoHRcXpo9VRmLtKI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxPR-000000003Np-0zPn;
	Fri, 27 Nov 2026 14:58:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxPQ-000000003Nh-1xHu
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z6tXzjpCZFmSMPICbDoqoB+viurSkgywIPGYiQ5/VUI=; b=fUlb1CMnhqSSa2kg/UqCrpx/p1
 VXCa/IwC5Sa4Py/yCw8RGqxWJim3+PA410WBVdArS4/kfWmkjN5o4B74ZWWrFv6n/Fn/kL+GQ29w9
 dYhMrj0j/s4BRCmoWoZHW6ZUwMNcXpgaYJnOdaF8p8Aowga5RYBLuz1dqtUt78xH3TFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z6tXzjpCZFmSMPICbDoqoB+viurSkgywIPGYiQ5/VUI=; b=YxunqHQ1neOR25RboKBNDaecea
 JxV5NroLMrHGftcXDuGUMYIZu42JwBkgyK3/CgKptWfmiLqRhSaVTlnipPTUhrPYDFotEB0ywZd+J
 URa9NC25W/Z/tO6bwMtRxrx9ge0/KXgstbxQBtaFAwMx/nEJrpYSKSBfQK7AxvOcBxjU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxPL-000000006gC-1cug for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:58:40 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so70656095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791513; x=1796396313; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z6tXzjpCZFmSMPICbDoqoB+viurSkgywIPGYiQ5/VUI=;
 b=OHu7VPWw5v29Fz69LU1jqtpmxfq4DPaCtGCKJNnPBZQAmd4Q6/MLpjSp29hz8OWPrA
 pb7kW0PIswH/WnGWNzjvPMrt0JhFzPPstUKB0vW+AJwWEaiE+rxbPa/0QukLSeoW/BRn
 qorHoXrEt0QVbAoyOI/PvN9dRYLfOGRlYuQKciPp1rSJuzTYL23GfbyIUs5TO4/J6oTK
 8uOrwnTyJa4lTMgPW84R4+uJVSTWUk9Mt2jnLzt2f+wOkEd0rEIEQ2PIuDBgbHsa0/s8
 spI7BQB9h3WxaA7bqe71jppAzQiW1nkvEzPfU10kAVPNWbCEslEa1KWewZZZxXzJFsGk
 DoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791513; x=1796396313;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z6tXzjpCZFmSMPICbDoqoB+viurSkgywIPGYiQ5/VUI=;
 b=FflnUkXL5ISmnap1MwWb6+i96T1inZVuVWuBo1WHdORgaGpFSnXpdsWUqJohKCmPrd
 dQhLlpDPzX4x8CIqZPASSm7VRzHYdJ0KN+LSPTBA2TukF2ZJcdWLnv9ZNVv2WH0X+aAW
 PlPyiHyEWOAkvOSu6sk32T2uWHcp4d7xtlKsRpzJpeY/RkZ63d8NugeA3cjGdaWCP8NC
 xcCbPbpEVMt5XYi8lZRxhHmUIPVbl/xCF+bOunC4176b+0fHqYS1w3h+C7YJzLGR2/eg
 9pBGB8of+RrnVPHRPISplpzp73rVvLFh0n0R6qFXsmKMrJk+XQJtG9uRIaWJlfM7IsIF
 1baw==
X-Forwarded-Encrypted: i=1;
 AL+hErFSSQx7p2LK8dxubSpUL3OXemQzyAyTKlRre55I/wn0chARz117k8gOXyfyHvr8GB1BB6+FTFSsIP/vauue@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+XuIfFJLUTMXGNNHw1Mkx2UEGgQmZh+9/uiHqQ7wOfynVylanD
 W1DIKYfcLrBZ3vxC2PLJ/XiHdcqlcK/2j9CEFy7fyPfQ/g6zai0g5fyGtnvHwlfJMaOvy4FTq8w
 GQIq3HqRncHx5rESYLojVhoIbRHApbb9PR+0EIHLXC14rkv0lhT559+SZtE3rFpI81hi2nW4JQ0
 cwWX20vA==
X-Gm-Gg: AZFdTZfLJbol17fDzCy+2/9bqngBamk/I4e0B5mTKt2VPqHrlmUdQIgcNy9Rj6cap1c
 cf9wQLMhxmTIdp+kwO7iN8CnrKdW2YgjeydG7k9w76pqe9Bpf8T94MEW4jPTgr1/YkgzfukPRIn
 E5q5FcwkO+at7+7XbLrM6oe0IQ0XC5px3s2aVn0d0bQ8XHtB83+ljBGtFGfHtEkA48qgSFdrT78
 IiCdyWHo244CSb8MJOW6DyflWAtSLJ+86t+PW0LazcilKRBp7d/I1y7jEa27Y5Ynw8o6yVyqMKL
 O82PF9GEcS7avDoux18PwOp6epKjjHie7hHXm0dfDglWyjDkLjy7E1lPEM6U2B5njAxdUs6S8rZ
 wyY7HfSnc5oOMI51JFPhmDOzWieWRzWct29qQfCeDggXl01ZCsayiOeMFCSMTcVz18klDfVDaW0
 Sh9dZfxqx2UR6eV83SOE9kfWhGOx7rJgZwewTBcDkOBZ1660DTPlM13Pz+kjJ18vno4I8rL/wyP
 /66M5dsgNcpYJtpdn3AqPZ1dSAtT6lvBpMw6dfGaG3FGEXW1JiJ7dr76pw7OBiAHhlLvtoTsVFk
 8E6/l+fcftIxtOvXZuaXN3YOCLrMTUUN6zM4seddPa1EPzIH6bmOD1TNUkzj+1d3MH98AZBe71N
 opPL760PPe1jQjOD/PYYTtyLpnzyR3sl5Igf9qZZ1lCEtINrBSg5QtJ9ihLx7x9fxWX1s5llWjC
 BOFetmPa7tqjZSzOA=
X-Received: by 2002:a05:600c:4f16:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4bb8882a66emr552944675e9.32.1795791511597; 
 Fri, 27 Nov 2026 06:58:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm51599232f8f.59.2026.11.27.06.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:58:31 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:58:29 +0000
To: Ralf Lici <ralf@mandelbit.com>,
 Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ic5c421ec2e9627340924a05509bb8aff0bbf17da
X-Gerrit-Change-Number: 1983
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1983?usp=email>
X-Gerrit-Commit: 6e78d2640936b2c8438bde0dcd587750f907a8b2
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 14:58:29 +0000
In-Reply-To: <gerrit.1791286452000.Ic5c421ec2e9627340924a05509bb8aff0bbf17da@gerrit.openvpn.net>
References: <gerrit.1791286452000.Ic5c421ec2e9627340924a05509bb8aff0bbf17da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkljNWM0MjFlYzJlOTYyNzM0MDkyNGEwNTUwOWJiOGFmZjBiYmYxN2RhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <066b3a84acd383046e8ec0935c4facce68ae0f2b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxPL-000000006gC-1cug
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 asymmetric peer IDs when supported
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3695542296707175539=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3695542296707175539==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2kJO7/mhgZo="; charset=UTF-8

--2kJO7/mhgZo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Antonio Quartulli has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail )

Cha=
nge subject: dco_linux: enable asymmetric peer IDs when supported
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comm=
ent)

File src/openvpn/dco_linux=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1983/comment/a30f02cb_05f88c40?usp=3Demail :
PS5, Line 450:         =
        /* no CTRL_CMD_GETPOLICY before 5=2E7, no command map before 5=2E10=
:
5=2E7 should be 5=2E8?



-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1983?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ic5c421ec2e9627340924a05509bb8aff0bbf17da
Gerrit-Change-Number: 198=
3
Gerrit-PatchSet: 5
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbi=
t=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: Ralf Lici <ralf@=
mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment=
-Date: Fri, 27 Nov 2026 14:58:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No

--2kJO7/mhgZo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1983/comment/a30f02cb_05f88c40?usp=3Demail=
">Patch Set #5, Line 450:</a> <code style=3D"font-family:monospace,monospac=
e">                /* no CTRL_CMD_GETPOLICY before 5=2E7, no command map be=
fore 5=2E10:</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">5=2E7 should be 5=2E8?</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=
=3Demail">change 1983</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1983?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic5c421ec2e9627340924a05509bb8aff0bbf17da </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1983 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 14:58:29 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--2kJO7/mhgZo=--


--===============3695542296707175539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3695542296707175539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3695542296707175539==--


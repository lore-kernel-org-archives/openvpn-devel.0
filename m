Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D7606A325
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=drXfH0mt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y0tK+9XM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HQEVAcry;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dq4b1mQd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Qa9bk20DSEH9ZyWoEWIYjG0KY0UNC1uPpCp6IRBSAT8=; b=drXfH0mtQGEmAC/I3dkdNQJqui
	X5IDsWfMRg3SD7wueQ+nFPLP0LzoeE0/TbWaqzUPIPJ3S2YckdmUTDRY/qHznb0xy4CE8FE3uKdnA
	flRIbwuXmARZLqAMfjs5YVgjcJHou4fcnaE41cwEELuo2CUAi/J4JGJGtJMvwwZ8+hbw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNWPG-000000005Te-36W2;
	Sun, 01 Nov 2026 14:19:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNWPF-000000005TX-0Aml
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 14:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mTW2KiBpMutqGREQ0EVzYTEMiDVXurTD++URrCGhniI=; b=Y0tK+9XMjYyBIziBhqEUu0dh+A
 5x+ZSF4Dw0Asm4Ro7lSQ4G1eHEribo/krMQerSJylZHPzKLww9A/m2BEvdA5VKRjfu3oj0OJft+/s
 fSjDvF7uoTXL8kbgvoEQAB4HeX8cOQeAYqeofQRci/7Mz1UdYzalMBrDPjnxZBjXGPtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mTW2KiBpMutqGREQ0EVzYTEMiDVXurTD++URrCGhniI=; b=HQEVAcryNQJuh42ZwiSH1zlYaA
 b2ERsTtq9ykDagLahBW5E0Hh9GfgnD50SH9mov4VJHnZ8+OaFoAP1v8s89rCfF9Wb7V//VwOA6xUg
 DSdV2DSTyWXMpr2T0/qSULb1P2G7mq99CK2aHdzKlAo3zz7v6Zi9x1wpXcA0Uc+8+B+g=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNWPD-000000004UC-3x1e for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 14:19:32 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so18913075e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793542765; x=1794147565; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mTW2KiBpMutqGREQ0EVzYTEMiDVXurTD++URrCGhniI=;
 b=dq4b1mQdtsOpaRH8W3q9oVS5q+JPfoeHFYKA+/xfaReNTl1QhedQCszflMflR/zKVh
 LvshdWLCJXCO3f8dugPeepIs+FKjbD+D0jRh/VPa0o7TBqWH77Qre0LLIq3JEJPiWo0+
 452wzudpn5tGRKEyllMUaCZlKZLzCpT6IFFeP5btNEs5AJdYEWblNnnQ1njs0G+MKff5
 3woXerybUL/Uv6sdrm3DobhZ7YILSBaG4841VebJy8yYVwL6UvdDTSzgsWxZStPUiBlx
 8LShZfKwpLzChlV1Et2jla2tFmKp4TMQRsN9hB4MSdBgXyHTPPreniwXi7dljBjxtLKk
 DvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793542765; x=1794147565;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mTW2KiBpMutqGREQ0EVzYTEMiDVXurTD++URrCGhniI=;
 b=KLPp84Qk5tLv2A211E6D/7emcydNZ8Kmgreju4DibEmhBCqT1nGbmNf8nS38WH6fTX
 nOmU2Rvunsh0abthd/uzD9O4Dd+q7Zei1OWY22+Sa3F+d/TbVH/iiUug+QOwXOiANMWz
 ogRei2OVDrYcpPwlYHfPFTnmC/uUkMFQar1t6Q4cl9YMsAMm2kjsmsPrsBJyraCjfKVR
 MwLF/jrBT7MsQzpfoMcmK9IhUIUeUnUhzyRWeI5V8K0j2MTgjsXA8/M7mNH9sSpDkDm/
 c6dJsSela6hUYBjnZEcHzMOBvYuH1Ng6MBKHnvgnh2FLjX1ZfJP9zfNVWcb+G9NoYECp
 wl9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwItzx4eqTbyCihddH3yuOD24xL6hCBl0fJQgLYaAG8dVjQSFy6ljLqsk96gO+b+UyDEK69ChSQ68zuokIH@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLKwKgrFU/1v62p8qb0OAesj7i04xxdp8nQCIM+pbBnchU7hkw5
 iKus9b9yFNffBXGkLPrPQ7zN/hFDsXdDS0m5UIJaShPS/GW/1UBZlJI8GuwTpNlqxmgJiWdiGlQ
 W6lm1FafcDzVd2o+i0qWKJLVjY64NOXRoFOcwLnJRjA5ZmiS/mX3jH5+Mjc8Aev9e9Y8Z
X-Gm-Gg: AYBFou2K3b6s13egP9yQRwgbWDwRXdJvM3LMxXmKay/n+NVhdYaYiy8zw++vbWxND9e
 PmHumSyUdoOmjgkm9zACz9R59wSvKRASlmJeNEHT6ZeIlpc80+98OquZj7R+RC88YddqfqHxUG2
 ejjQizWG61SGI20B/QOfPQBbB/v/m5197Er85skEWo/zOXLT+YlZQEeedyQCapj6R3zynfPgYWE
 TyvtojJqtAoWb7HSvuhYnxaN84JdQBxlr2HRL2d75cpe8LjH1Hj2Gw6cMkxkc9IFcDuTWr6CSKl
 yWLv0wWhT2/CuUY6lyiceq8GuMQkOsn5KDxrWlcilkKLWA6GbNIoFosORXPb0Kmcz28D44zRa34
 nyxuE39nUB4qeQtfljD1bqgOifwpU+U/Lb/iOAWzsmIS9R06Oy+Qs+05Dz2/RewlcwSI56AjPOV
 Kesrb2vPYEv0oDjXNKfouPsfss/6/7s16veGKVRynL0vXbS6/HvaRkVZwSHe9iyL8lsB8foquZq
 BoCHMbJM/xWhhOuOBg+wf3GdzDyGO1tnBbDQ7FUbPXAYoQaxIqsCDZm9cWCshcxX3lOdSUmBaCG
 9BsV/utvEiZZI0WMzrBzVIsXOhaTOKtCrJSJg1BP1HcGlO3Zqi1juKBpiYNWBBXIS6YeeLwxiOH
 RztadagPcZPGsQw0iNbTv9obP5bsr/+4O7BJbynUS+DL+Y/sE/dNhD86oW6AUiGHN5zz7hV5zdg
 GMnZiFQdZexfhvG9N+AM1j2WDIzVfZ5an4hrM=
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4b0b9ff2129mr17835305e9.15.1793542765215; 
 Sun, 01 Nov 2026 06:19:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm401554575e9.15.2026.11.01.06.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 06:19:24 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 14:19:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 0ee0687f4274f1408174f4c8bf605b4175fcc448
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 14:19:23 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ae99d69d2660cf0466120a38b553b1c021ae995-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.2 (++)
X-Headers-End: 1xNWPD-000000004UC-3x1e
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1029730408359633478=="
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1029730408359633478==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="82mE5MmIows="; charset=UTF-8

--82mE5MmIows=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

A=
lejandro has posted comments on this change by Alejandro=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail )

Change subject: Keep the =
outgoing control packet in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

Gentle ping on t=
his change: it still applies cleanly to current master=2E Antonio, I have a=
dded you as a reviewer since you mentioned on the list that it was in your =
pipeline=2E Happy to address any comments=2E Thanks!


-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e79=
3
Gerrit-Change-Number: 2002
Gerrit-PatchSet: 1
Gerrit-Owner: Alejandro <al=
epacheco99@gmail=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 01 Nov 2026 14:1=
9:23 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--82mE5MmIows=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Alejandro =
has posted comments on this change by Alejandro=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Gentle ping on this =
change: it still applies cleanly to current master=2E Antonio, I have added=
 you as a reviewer since you mentioned on the list that it was in your pipe=
line=2E Happy to address any comments=2E Thanks!</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379c3=
6e1557178d22d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2002 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepach=
eco99@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Su=
n, 01 Nov 2026 14:19:23 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>

</body></html>
--82mE5MmIows=--


--===============1029730408359633478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1029730408359633478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1029730408359633478==--


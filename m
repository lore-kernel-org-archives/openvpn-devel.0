Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB7606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EmFmTexv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LlCbpmZ3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=apCfHCS3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AcjCBdgH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aEh+wMR57YrLKqq0ZGe8P3jnOjqavuHLa/YXOFtm6E4=; b=EmFmTexvw79llppd+VxylpW3Wh
	ICu1kqFhp9rIEVCxETefdfKUVumBwUVyaEeoyu9kYgmHiBJxBGeEtWUJniLT6SAf0iUgDXxQ/uBeI
	PW/FJFcsAj/lYKyMsxUoR/eJNQYakV6EVGStFnOXxTjJRCIOs00rP57Oh23noV9lxS84=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM5Qc-000000006Fw-1dMO;
	Wed, 28 Oct 2026 15:19:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM5Qa-000000006Fd-1mQ7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Yr325DguJqhOAaTwHMbrHKBpG+xyxPio0eIZhRs1Q8=; b=LlCbpmZ3iM2PQODD0OPcjX6zhJ
 BCBixRogKi3XmrRjQGu5ZZFelU/nS2lzI7cYMtbjHJszzhWi1K0nDLWwwjqsohi1eznyK/Jsos6NY
 CrHExlPQmLzeI17ix+DQO6HwXjnoT3k7LMwmjXoV9FCKOM+g8lyM2lnNG70SnzzbigGI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Yr325DguJqhOAaTwHMbrHKBpG+xyxPio0eIZhRs1Q8=; b=apCfHCS3GbjBBBmRbRUmV3IbTi
 wik1sDobHy7gXIcdCiKRkMDBLYY5jT42dQc5f+UhwWCUfSAYfl3e9+D9J1oVyPMOlAVfAINS6bPqI
 K+MyjxLL9uLsyd220t303U54baC0DgrlSOnJ8jaOYydWA7Y8s3TV2nXvd/JUlu/FGEuY=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5QY-000000001Lj-40Ei for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:19:00 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so969921f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793200732; x=1793805532; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Yr325DguJqhOAaTwHMbrHKBpG+xyxPio0eIZhRs1Q8=;
 b=AcjCBdgHNZ0VLpiRb1FFzXrBjkEQulAAMdpmEyrThq5zdJgZfFI9fHU6GmeDTUwd4T
 Rchvkh0PPq/ZRRhfEp0xbpS1mC4ELl1gv7tPddjENh+HtcMSjFU2CWeEeX7SOE0Xluec
 ahv05l2Il2dQe09C4s1iNrh5DYCSv0M83sRlj8RiRorovVyFsz8CcSjezcJNe7ILuxsW
 VpqzJaQjPAgoRiQj5UkHKOhYIOMAw+rZayVPKi6jtKQYqOQ4YfiOpJbtguWPswzkB2dE
 IKAIpNYNdW1yaR4WdrJAoIk+kXcD4HaLeBqNT+Dzi/AMyLgJXN26iFbvyCgLjozdfHg5
 c97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200732; x=1793805532;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3Yr325DguJqhOAaTwHMbrHKBpG+xyxPio0eIZhRs1Q8=;
 b=SSEXPHG4+BoVAuZuT5DuLFjfZc5wRx+NlLpAnnBT4cROryD7cmrofdHv53xfIrFTvC
 B4WDj26AQjOdp7as5C2Diethgss92I5WUeJHQpaYPmR2KnAhJtG5R2Jq7FX4ypCKcSk/
 F3pKxnYp1DgWW0FNI18JHivfDOfmOFS/lLAySSpnFemat1TDvA1LC5Fx3/ISHNt8p+Nf
 XmdRZ61wvZpjxahV3VEPsnqfTgKqHN+TQ+rWhqxWBEcdxbQHsKROeVrcdy0PgLwTvmIe
 5pBQFjvxH3h7kgc17nFGizGsdBsSj6zJxldj1s5Sk5GbVThSv5V/+Qeuj1iENU71/hAa
 SKZg==
X-Forwarded-Encrypted: i=1;
 AKwUvByv1euBNMkEja/A5WYv3wgvMVEoef8+Ft8vvmcum/v9+1u/Cm7MFy4Hje5BYmyYaXDjQG1qp3CmWz/EUlUg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL6VA6nUngE7q62aXF4SP8FAPC8I5W4jIADIvybVv6bvb6tPrS8
 4Lo26iUhsQC+msfOghQZER63echSO6WkqtMajyJ2iIkYSobu1jNiZq51YAQ6/pTEQdtRp82Sz6l
 EHutER5pLBFIJeoMPVTD/JkPHOKo7Y1l7jB5vcoLeF6Khh2NOEtXfMEFMmXhcvmw4sf5t60gJzH
 OZWf2ATQ==
X-Gm-Gg: AYBFou0l1NHPZP61mvPvbMA70R6QNjOLek9ihhuhP9OCZwgKvSzqXPdwh93K7v2fI1K
 sS8Ej2uvIy9EuejzTPDBNatYtVAEF+Z1Y2weR4P+dFzaJziJ4hGi0HeEw2SPclL4tqoq/WIlKyw
 S+w+zkEy46YKXNDFGp0GKX1Qpb8VjPewTKfhH4GX6l7FGks/Si2M4HCSklrsBfMKht6+y5/ZCpM
 qcXS87tJJ7J+f4xJGgbwvWS4klIzpgKLYUzx3qQoYEZyxFWNWbXJH3bAPhL//SZVwDLu2yYCd4d
 8rDPIcaop9NyyOAIUFi1WdGp1u9YNWRAFFzIiu79qyW/r9gCmOYc1xxdAmagBQxPESA2kPCFKvo
 JpBgX0ncMseoZMIvmhgPFVn9nXLQrUWz9Cit0Y1u1qazsf/ov3plFB3x5pkVDEwAhbdwsuJHN57
 G/N/swDJs1BjkQ17Oc4wSM9CtD8Vv48tbfjlGWZ4Ai2QFdqeZTqBbQ6B2OgAL+M6vvY2LHgnNxh
 bPyHSTF3EvIHHo5Q9Mgp0NbYY4IY1j+RxMBsJospiAklpd+uRcsoCKSda1pLD4b6EBVvYfLZ7B3
 V7sqprIdGYVaoZE8txEJmBga9rBMYQ6sR6PynXQ/EZ+M5X29LnA0Y2tEwVBkCwC4h0otq4K+VD0
 V8mYjYn0vP9KJLMvqfES6dztZ1DuSblpQjRgfwfHHBgsFv44STweKUOSnglPpZ0am+TNMZiDm39
 v0qNjUSq/mBHJcj9YG
X-Received: by 2002:a05:6000:2611:b0:48d:f99d:a0d3 with SMTP id
 ffacd0b85a97d-48e5d312a6dmr7628690f8f.46.1793200731956; 
 Wed, 28 Oct 2026 08:18:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm28910156f8f.4.2026.10.28.08.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:18:51 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 15:18:49 +0000
To: Laptops <jeff@incrediblybased.co>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
X-Gerrit-Change-Number: 2034
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2034?usp=email>
X-Gerrit-Commit: 8a522b832d47a21474e5f06da900e418d050f33f
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 15:18:49 +0000
In-Reply-To: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
References: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkljZjg5MGIwMThiOTk1MGM2OThlNDZjYzQ0YjM5ZWRhYTBjNmVjNTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b183a55ef70630e996bf2a7ad09e7ec082009a7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5QY-000000001Lj-40Ei
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: restructure
 some loops and assignments
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, jeff@incrediblybased.co
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3508174843243383764=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3508174843243383764==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YAOgb6JPNZw="; charset=UTF-8

--YAOgb6JPNZw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Laptops=2E

Arne Schwabe has posted c=
omments on this change by Laptops=2E ( https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2034?usp=3Demail )

Change subject: buffer: restructure some loops a=
nd assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2034?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
Gerrit-Change-Number:=
 2034
Gerrit-PatchSet: 1
Gerrit-Owner: Laptops <jeff@incrediblybased=2Eco>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Laptops <jeff@incred=
iblybased=2Eco>
Gerrit-Comment-Date: Wed, 28 Oct 2026 15:18:49 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--YAOgb6JPNZw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Laptops=2E </p>
<p>Arne Schwabe has posted comments o=
n this change by Laptops=2E</p><p>Patch set 1:<span style=3D"border-radius:=
 3px; display: inline-block; margin: 0 2px; padding: 4px;background-color: =
#d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2034?usp=3Demail">View Change</a></p><ul style=3D"list-s=
tyle: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail">change 2034</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icf890b018b9950c698e=
46cc44b39edaa0c6ec566 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2034 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Laptops &lt;jeff@incrediblybased=2E=
co&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: L=
aptops &lt;jeff@incrediblybased=2Eco&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 28 Oct 2026 15:18:49 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--YAOgb6JPNZw=--


--===============3508174843243383764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3508174843243383764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3508174843243383764==--


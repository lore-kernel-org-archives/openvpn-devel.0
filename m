Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EB606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DdWkXK3U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dIIlQ3z/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XGY8Dg1h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Gs7COYF8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8xUeom2bHQBO1YbFK0VwYb2ciH1NK8l3xFlvuTvtNU8=; b=DdWkXK3UNTsOkILQSPUI3eU56b
	dSOzePswN5j15r0ItBL2MLsKKgcOv+5WSfnpFrG1fb/PiDLLgKHonGyxFdRC2RCfmTxGwJWHtSx6v
	0/MRPWweUUhUqEESCV4mjsFtQripE0rikfplUEPxtS/kDN/Laj9I7zgTB1ThPiiyL90w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGj7-000000004FI-0giI;
	Wed, 25 Nov 2026 17:24:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGis-000000004Eq-3DdH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4pOUPr3ZSGHjDXbzU6x5ejcM+2IAjgL2h6jjgryInIA=; b=dIIlQ3z/2IM463zxSVxImYQ5EB
 dxIwdvP6qF/idWkS3TRjawW/GUjXNBx53wJLiV1TVMRB9csfNa6ssbLfHzH/yGH2EjZHEI7Vi97lt
 MtrSZ2+ocDL6D8PCXmYw8rKYcLc0b9DmAruYJnD2BA8KOEfLVsJeeXPTdDq7w/sSx55U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4pOUPr3ZSGHjDXbzU6x5ejcM+2IAjgL2h6jjgryInIA=; b=XGY8Dg1huzsQoAl9G+Gp/27G77
 XsbMs+d7iISHQ/SyG/bCZaD7cZ+2elkuOmSRg4O0dy2J9ZO1jY5CAWMBneqU6pyh9pdzNyCy/BYXR
 YFJIAGlu/PBFHCPfbn6EW64EOge9Xkrou1uLD1eccZ3uOdTK4YZgzpS4LSAmO7o8szMA=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGio-000000008RN-3b3i for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:23:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so3965590f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795627428; x=1796232228; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4pOUPr3ZSGHjDXbzU6x5ejcM+2IAjgL2h6jjgryInIA=;
 b=Gs7COYF8bU07hZqLGPMwZqQ8jbPERwd3K50nlXadcYkfQI7GW6q6imrtMlbivKQFW0
 STx6bVHc7cMOidMBIGhTRWWPEHILOsqvN/J2W0bHGBgUIewY5mgyKEwUoDctNCAbvrQD
 8QMuXh5fk0KKYDMmZz8CWwfSX2Kl95IDH86d2NYMtVuDcvkAquYVnsBf9awtCmAceFX3
 GSIsCaMrx+Q/l9twiUKkR1zZrwyhFpV58XQ7xGyfsik2Sn1eq5emJ+82dLcljULEFZa8
 /udxRgEIZmpfJQJHSD2HlMVOr99JF1Siw2UXLlt0n23F7rRC9Q6sFD7VeJ+8ob6Gp+5N
 VQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795627428; x=1796232228;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4pOUPr3ZSGHjDXbzU6x5ejcM+2IAjgL2h6jjgryInIA=;
 b=P0SiIU/MWuq/wkXb2M4Q0Y/k8re4ddx0iworwsow5pIyLY6u3yGLCTP0OAZHVSlQM+
 /Pb2YaI+JiGt3MFDpVwkUhMksRm8MmFQXjXNAVcVdZ+nmbPJ1TU0YuYQmu2MyVOYYjPv
 02KwUTyHCqeJYJkNEnIPxitqoBtbVVBDy3+xuJ/oNBOnhkitedbTlVQfcYYW6aBQHFeE
 6c2+ZVlStZYqj0UMDSJxuHJUuQVnCuVsslJTJfp5zd1fDSeLMmgK8/KOIO6R6TiT+Q53
 O0kXNnJ3Yxc+vZ5sbEb+JwkTD7E5NzBip/bgdzIy9rt6XRFpmlx47N7nuB9m4KFwpYsx
 dPNA==
X-Forwarded-Encrypted: i=1;
 AL+hErEHj91sd7TmWJkeS3z1lwDRVVi/BsmyHJkwLnrio1FYuw1136MrRPnUxrQQzvTL43JFFyH7NSlebFglRpTe@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9bksqNmmUmcMbZR6dfErPtvUGDN6NKEHOUYJwdT1hv+9pPfB6O
 WgxUCsRaHJF9w0RVHmnN/hMPpMWhv8DfbjPMADjShoKcJT+KNTSJCAubQKMRA4e+5p4iRwF358J
 hvKrQRH6LGO7B5gL+qShHzi3+cfbGb6UHUnwayyEmE5ddRwmXzbwHltBsls3KS0lh/RePLuFYRs
 IxVkZEUw==
X-Gm-Gg: AZFdTZdw1oMuVSoikmlP3TaTeGJGcmqmaLORqbrDqD87JkEhdVqAWqX3Pk4g3p+MiNC
 TjO1tLL+MDKRc7iTJoomX+TofPXzIhj0Gaw3iCEArizN46qFmTeVEVd+utpqvsPXPfFriL57QCZ
 JdQXmaFoT5Ai0WhuZe0ZsUgYRWsCxZrz68fZoa6TctF4E4nMhL586xD5lCu0XSVP7cj2ZIM7t4J
 lKuK3FRiCq0S0VpbtR7s+cjR2c3E2W9YFANsr21z70GDtL7UHKyz/4d4c+ywT+6bJYExoPu7GUS
 pCR2XFqI7cPfvNQytf+sF70IjYhRe6Px3eKdcP7rnkOXpNkomamLIf0hFfEGoZbw+xCvVUxbiEe
 WPQ0f3wu7KjHpTzlgHx6hVJPGaqBabEJjXDn1HyKthEKps6QuwJSYTjfADqYXA++I2JrwPGfQ06
 e/lyVJDPfQQ7QnZfLgBmePX3xMKcxqAR3DoYDIYnB4P1mSA2kvu2cbVt4ZACFqqlraepHKNIiP1
 /u57YxYAMh6iBv91uSXNz/ZVCyk1ud8pXhp3gVWVJEjcQYzZcesMvsyctU1f1Q9CSe+WRWoNpmY
 VOZIQy7ech6qd0zBLPnZxDyumh4r0R8Vb4VYzM3EA8lUUdYpvGJ3kDuwADp++b5pFaRg4Vu4h36
 Py4WSJEGMTi25nOaFg9rL3asKCpwQ20COiTPfZVXlmd4B65OwtfY0GUnKoN554eM2vAUtK9vbgB
 NMbKXcWY4x4E+Ax/E=
X-Received: by 2002:a05:6000:2c0a:b0:498:1a65:50ce with SMTP id
 ffacd0b85a97d-4abb1ab5d1amr38583222f8f.22.1795627428142; 
 Wed, 25 Nov 2026 09:23:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm34274454f8f.36.2026.11.25.09.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:23:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 17:23:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: f7498a7b2c968dd37b1b8068c93e6982ddbe02bf
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 17:23:46 +0000
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <884f2b5b684263a435feed93d24b062768d647da-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWGio-000000008RN-3b3i
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3839915051940121385=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3839915051940121385==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fmrh6m4blZU="; charset=UTF-8

--fmrh6m4blZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail )

Change=
 subject: Windows: Switch all uses of address family to ADDRESS_FAMILY type=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2342?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit=
-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Wed, 25 Nov 2026 17:23:46 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--fmrh6m4blZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=
=3Demail">change 2342</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2342?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2342 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 17:23:46 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--fmrh6m4blZU=--


--===============3839915051940121385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3839915051940121385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3839915051940121385==--


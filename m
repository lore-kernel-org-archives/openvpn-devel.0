Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEE606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hTj9gvEx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bxnwBqWY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AvqMIJfE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L5JHuRZp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4xNmP3Lldu7HwHhtRTi8OW1J3eSnwdBeQ0oHdkB2Sk4=; b=hTj9gvExDziMJVT4FIOnWL4w+4
	1cp1OJzUJhSdIpTrlapE/1dclu190zRjdWqhmdotOp3wX7yxGsZzJg1VXcr4ursrwpsifnbTQvNu1
	4IIHyD+nX4fPTeBahP5k79iTxjU+307pZEtfZWzlgec9GYfubp0fgr+csynaHUPn8GaM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoT8-0000000063u-0nYN;
	Mon, 02 Nov 2026 09:36:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNoT7-0000000063n-17tD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XU6XE9yfb30qcJ1dS5WyLmLIOVm6L+45Yn4n/kUqlzg=; b=bxnwBqWYwxAnptQ5FFSzc92Uc0
 ZRtw8b/bhY6zUPg0mgtXrNT56mvKi5FDYNrlTeM+vmyJ0ZG0Tsfrafis50jVv+VuRyaV0r5kj6LhM
 2cXUzZHe/QFQh2RtcYvy93HiqQAfJ3DO8RCn/wPnDs2Eax+jnD0JcgU60fUgnC5yrTUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XU6XE9yfb30qcJ1dS5WyLmLIOVm6L+45Yn4n/kUqlzg=; b=AvqMIJfER64lohnNQxjcY2uMK0
 Gwzs9+Y276conGlh6S9ktFeMtrZpqs9k2XEMXIXg+ZjPPTWIjr1MIx4ZfJ1rxSgOwYFA2gfrxeN4y
 Mj4ZnoxUGl39zlJOTa1mJJETXrUH5jwLSZD5ANbk5YmTEllAOcfeeuI0i1MXpT3fGjug=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNoT6-000000002GD-1nTl for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:36:45 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so17059775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793612198; x=1794216998; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XU6XE9yfb30qcJ1dS5WyLmLIOVm6L+45Yn4n/kUqlzg=;
 b=L5JHuRZpqGX33HMSUqZVw+yadRToy/0YZgdc2PxwyOqMWYhllxx3ibpFQTtdcpt47s
 bkhfsEMyaMdYIwVCS+idzsCAh+2nQQI2Rmh8xLBAWCvJ6jAevxSDv8ufTV0C7m8a/nWJ
 etXAwm0I/nyDuxyclQyfce2vNbsMXysumwZJ1bZqdc6kKQwcENUGL85JQsWauG4wotI6
 Y7BUkFyyZOVTSO44DLvmndLdL35lDZJkKuhuv8o9v1T7LNaZCVJ2kC4Me7y4aCn6WN5R
 6Y5B5R1cQor0tz8du5UzyHN16VCLmu65fKSc+RPWy2O/2yHp/HqU2Qcix8It3o9bql/O
 f2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612198; x=1794216998;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XU6XE9yfb30qcJ1dS5WyLmLIOVm6L+45Yn4n/kUqlzg=;
 b=M1smqZV4+N7cqBQZqRYmu7MD1yPOuMkXy0P0x+WIulsU2OwYUbs7BaFbxpzQsppXV2
 MJmRoPmPSGQxh09t9HsVl1x5ryT3C/R+Fuitwpv4gA5Dh5s6lX6ap+mRqb9N8tjaWDcR
 YwZP2/SM79UgAfXzeU4MjtKSCryLJnP+r0xzq8iqJCHUo2ksqgrTIX8zRozcG6x3hhKN
 dehcZLmoYRsTfXDbh26DfUw8wQpe90AQinO5tfT3Q3/N02p0VzSNCM8b4i85RfJSEZAj
 4mtkUQEx/aIA5yasgYrSExCORutIOMQ5K+HcFFeacXqvBglLmypGY+R2VILXgmEHiwfr
 QqLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByAx97TMqZyX6omiBMQq682qsj4DNC/noHPOrxYeegGBhxVmgYcAiuXJY96gZBqkBIbpHiKGzSzXCVFlTyF@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKvL3ac4jsq1S5cd3ClHpe20zvSaQuOfGPy7lcUcqEFW467Zsm7
 AYBiod8LgBJb/6kFED3v14N9l4aLYVIYo8E72n/iQEEc5JBN5rbHy8FH4R4cnjBuQMmesd8Hg2l
 eljSrIFk2iuEqkBz4bsj//Hj7/Wp2pBcNbxR0WWtDQEN76SaJlOF9SekOkK+zyrzH3xZA
X-Gm-Gg: AYBFou1uyIyhoIRoNcRBHOaBlfjq/Nk8JZIUbYRpPuRTUKIsR6howQLts4CItiwhIQE
 MiBvKUvGI0Id1DseMAs5R0yIeL1pCa9HFOdJqka6R1DH9A1gnGH6+tx5elXOyeQenTKS6CvdLeo
 P0OFNxIRJ+X2daJh1BlKymSNU6B8lDg+Wnk06q7Gza8oFFAf0yYxYSSqCQL9IEY0g0bsLiubUBo
 y7k1uxLxKNCn75OTPbtHlffI1kFys2/6M2TrzF0r6EfOvgjw+JacATqyd326KrhWyNQBiysfj9K
 +OXmQv8R/SBMS2DBiAqZ2BaCPCLR9ASJlIMAQjt0FpQ9ozGvf+14jwxbpTGV6xdi6Ajh9//kMrJ
 wBaNicqLUr9SP1Wd9wtv7Zbm1oEwfuKbMelSHqtMg11EoeV4cZS7JmcxCz62466FxTZYMmkQq9K
 eMf22O/N2vb8Z3HfL13NIcW9fIuYYft9thTbIKW8DHXyp/i+VRYFxFJI8273afqmQDZVs4k1JGn
 +iYUp3zGjUo0qV7UCwjpO93mT5AV65E4a2izzZNxa0rchzwS+1815yZWiveQBef2XqhlXo87ZxQ
 13Ahb0fPBBCNVfAQNMXY7E/aj+TNIOW/y90jqs9pMjnCfRsP3oEQLboz9zC3rNbAUe5eBHrObvw
 2wabbux2jahgnG1MhJAmYHfQPt0ProvdOXEd3p6bo8BNkbTksplwM8UReZgKt6ytjrPkTZL7oki
 gzHGdF60iLDBm19g==
X-Received: by 2002:a05:600c:674a:b0:4a1:fb23:68f0 with SMTP id
 5b1f17b1804b1-4ac14ec788emr212908145e9.3.1793612197670; 
 Mon, 02 Nov 2026 01:36:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0b4df257sm154929515e9.4.2026.11.02.01.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:36:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:36:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: 68c131725ae43bf4138fe6b46f9bbe17cd1a26be
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 09:36:36 +0000
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e36c1d2c5a4681fe27f0669fd5009e89bbaa5c6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNoT6-000000002GD-1nTl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: port-share: do not
 write journal file through symlinks or hardlinks
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4919884316722028388=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4919884316722028388==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9oG2DD/2rEA="; charset=UTF-8

--9oG2DD/2rEA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Gert Doering=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2074?usp=3Demail )

Change subject: port-share: do=
 not write journal file through symlinks or hardlinks
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70ebdadd660e41b40ed53f4=
238be6885f0a7bb8b
Gerrit-Change-Number: 2074
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Commen=
t-Date: Mon, 02 Nov 2026 09:36:36 +0000
Gerrit-HasComments: No
Gerrit-Has-L=
abels: Yes

--9oG2DD/2rEA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Gert Doering=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70e=
bdadd660e41b40ed53f4238be6885f0a7bb8b </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2074 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 09:36:36 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9oG2DD/2rEA=--


--===============4919884316722028388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4919884316722028388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4919884316722028388==--


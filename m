Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AE606EE85
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gz42wSXt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VorWQlJ1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lyo3FG/u;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=grHfHaWe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oOKJmoUPUr3p0CDzxbe0LM74+K3FzEj89NLqs5wKCXI=; b=gz42wSXtm/O2+AdaYMQSvPajY6
	iWWY6os9EMt+yUI9aJTFqB3pNpzdAIyB/ulJR3m11LA14AsT/ypQnoztO0mjkenVQQgwLz/ecEWOn
	faRjNOkNUBJJDopuD71bgczRMuwNpkEb79m3I25rWzx5V+XQHcjWfmY3JvJlMgBTAnsI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOEdA-000000003ZM-31dI;
	Tue, 03 Nov 2026 13:32:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOEd9-000000003ZF-16FL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jJQVPDCrWsMsHLLzK88K3fmLT8sB2Pr9EH5mza/ZBOY=; b=VorWQlJ18YIIbIZM21ElQKhIli
 lXah6ZODjngIhnYDy97lqPRrDrQn3gSz5t56dPmCXHHdF6R1RhefCOIqB1pzoDtHBjlkVWmphRzXO
 y6A31Ids1QsQfs1LncCw6PgLniOepJQ1utdAJo2clZR/BsU8sY/7vGH9t3xyGjjm9ycg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jJQVPDCrWsMsHLLzK88K3fmLT8sB2Pr9EH5mza/ZBOY=; b=Lyo3FG/urla3GvuNA9mq1LkMXR
 X6nJCjMIYKRj+a7856U6Bq24Xvjh+tuAdAb8gIGDT91X0Qh7SwVXtWsMTT1jRL/dvWeVEJ/sV4qbN
 1Bwm49S0f2sb6gpTgrWN+pQDWWu9+nB+rsAA+LQ50S+7f84Up7jp2eNdsNVoxJu4U614=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOEd8-000000003ce-2stz for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:32:51 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3284018f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712764; x=1794317564; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jJQVPDCrWsMsHLLzK88K3fmLT8sB2Pr9EH5mza/ZBOY=;
 b=grHfHaWeH/NOxoaMIJKYuolQAYlLww/x4vhh0+eGkSe38aH9sVHiOOkvj/aLOBd84Q
 jPgqw1zgPBny+ymPBH23itoQqxexLOsFusABfRzW1ldSLf+w09UgIzopj2COAvyPq4O3
 G7vLlUCpC3oXiJ2jO9kYQOfiLKRHX1Rr6NmfqLOdrjiXs+Sx0PcX7rgzpWbZck7qWHBI
 O5Qaq1UwWw7DrSEeM3qxi9wlhB1DCVbWFi3stdejyDh07oJRLTG/2dFz+llWCOHYZGZL
 hOFACXkJAAOw3nSq3Dy3tE4BEgS3agZKBJGf4KqFWCQjhKIqyz+T4F07catQb288pMkD
 gMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712764; x=1794317564;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jJQVPDCrWsMsHLLzK88K3fmLT8sB2Pr9EH5mza/ZBOY=;
 b=a+eepAMqncidomYYY20i/rpZ/0zYH8tT0fi++lk8zQ/nX9ojRm8j2iLl8K+/gNN6Zo
 StWRgJb2UJ9Lypg/LUpdQFxzB6/cYXnFBl08zErWAtNFEKA8BkwIrKyBa6bUznGAP8cO
 tXscA3UT9w8sealwJsLW8IHtH+Or8KBDXRTVKFVYTFsv24aBubZ0fOHKKe5SklTi8REI
 Ztb3fvzmtztwADES5AxIVF2/GtYGXiNm4HtrKlkd9tVxIzWGc6DozS2u2DTnPyLeSBM+
 q9S2RdkTFq5NefR/+XLkE4Czqg79OA6NfTEk9qnyaVEbAZl/Zx+Q+Ycw1Gs719DUaF76
 u2MA==
X-Gm-Message-State: APuU4Z8TuKSLdl0jzMVUfqvC9kYvkDIQlXefxYw32dn7P3TcHUC7Vq5Q
 GlEAxlWl44/s7QLM75FiXurpM/iHdK1C22Ot83Hfw2HH7KHnjab2y87Qp17sBqJRom27n9qHRB/
 wzY1UT77P/JcIVWCMQB+m4LpgMi1yybK3bBh/SaiXHiwTWi/1EG1/EVCQoP7CMl1oSvJs
X-Gm-Gg: AYBFou1VP6kA5j3DAQGpLBkYAxbiBfLw14j7pcaUnEq3ZPHcV0NTQDDQ2NTj5316fm/
 eB4HiBBPWmEDFosphv47EfoAo00hdFOHBs6fq95h4TY8fbWtyGN6T7lRXyOASUcGgg0mhTLwMjH
 RcunfaWEepkmkeDhXVPczAFszCKZgcdVEDEeSigXrXdUV9HA0uKpZw5WunZLnndaja55J74fVUN
 YXNXtOWwRMLxak7KwoSn2kytgcpNeEYjcC5ovFsCa1SZicEkhkS4pFkBO85nl7bKZ33/sQ4CPEz
 JnDAlMQ+ulgDvWZJnyNnfM+bwinDu/seI5KdVoQ7bLGcN4Y+JL7OmNIHIK69Lm19A2pH1wRdH8Z
 n3mVzz1dHWzyutsfhbhbfVxIh3KXG+DsMWlKon4/Lcvgy/oLScp2mXkVvSmGVPufXPYVsWq78Ko
 x3HDZj4KYOLPbxjAGfvSUYWbukX6cXNIN0056ukQRnwbfRUaGgw8hKqCdxjV06MiqF+aHZXjQ2A
 mt0yhORU29J/1leZyaUvYZRSBuqzejPPblaUagkZwdtR3P1PBW0mHB2xpd/uJuU0VX0yMdcQ0D0
 GlHN//5osNso3m0D1xQgx2vKc7K35LattshXdqXQ95nV/t4lN1IgdjWc05hLDuWkoALVvFI9Jg8
 cxvUtpWanoeEvn5LcJQkXBdwLzHeUfd8HUfGhwoDapHRYBPI6n8HO+HY723j5xBbY9zOw4is6w0
 uh2FtuhMn0phTOlw==
X-Received: by 2002:a05:6000:26ce:b0:48a:f454:3d4 with SMTP id
 ffacd0b85a97d-48e6e52a7e3mr27220082f8f.53.1793712760389; 
 Tue, 03 Nov 2026 05:32:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm32020555f8f.53.2026.11.03.05.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:32:39 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:32:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 8eb4af5adaff4a6f1f9a8801a45c00eac2a2df24
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 13:32:38 +0000
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <04ab7e79e486bd3337959dfb2e0590f8bd7adce6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOEd8-000000003ce-2stz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0174834570130175099=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0174834570130175099==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LzxD/91No4M="; charset=UTF-8

--LzxD/91No4M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2105?usp=3Demail )

Change subject: Move gc from o=
penvpn_net_ctx_t to local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
=
Gerrit-Change-Number: 2105
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Tue, 03 Nov 2026 13:32:38 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--LzxD/91No4M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail">change 2105</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I494=
a427924ea501382275ea96ef85a6abcd780e5 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2105 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Tue, 03 Nov 2026 13:32:38 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--LzxD/91No4M=--


--===============0174834570130175099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0174834570130175099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0174834570130175099==--


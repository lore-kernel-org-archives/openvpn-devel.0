Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C7606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QxrQfAPp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N8DYLs3+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZDjPqZN9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NvPovNhT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrSm6CSKGHfbCuDEo+0uIi6X+5aKjxITdWZkxFVGW1Y=; b=QxrQfAPp1zmnG5uzvgC5B2+epB
	n7kGaVTupisWRDDZPl+M3pvUnFEOB0kmyzSZEE63x11SqB+uryA5ZJhNczPLAihBX9sgw5xdWKT2T
	/r8wOYGJLPcnq4RN2WuR5KJCO9KdWy07ktZtnhYkdhYME4PyuePAiencDYAHEDWT/iVs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9QN-0007rq-Oc;
	Tue, 20 Oct 2026 12:58:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ9QM-0007ri-4u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lGTPJuiKum0BUNTP8zOsuKjS8nge1HNmM+kOmM00rrc=; b=N8DYLs3+rVUjwMt/eWvkJFgUtm
 Ik8EM4yKhTGp/jl6cVnZc1AUt0O+TPPYoMjURnIpFXIKMxUCTpaM5WtN6wRBCdOFjEGNF99al6Oy4
 hkG9u1WXrLQi+T/t486/hiiMzrHzlAMFYKBL7UeSXlUFeIacm28PGwa94hGinyH+7rkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lGTPJuiKum0BUNTP8zOsuKjS8nge1HNmM+kOmM00rrc=; b=Z
 DjPqZN9ODRnZa3a2V1mny82oLIrPevQjPiCZ864CYf1n+2HWlJyc+bGmbpjsGfPzddAp+SzYcZF0n
 QMiRXos/gij2WplcO2cmb/kQuy/zSH6VqVAhLhFToPOyZtDECiS/uUg4NdO1LW2cOvMxY5vkf3WsG
 cBL5Dchk2WOp0lPw=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ9QL-0004NT-G9 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:58:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2464558f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792501111; x=1793105911; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lGTPJuiKum0BUNTP8zOsuKjS8nge1HNmM+kOmM00rrc=;
 b=NvPovNhTI4CZShg01oNa5f3/OZLfX/nevOqXbryni6YqU9AH6T7qQ2atwZSFB0r20M
 ufgIqKJe2oQP8HHmbgd/C6Vgw2bn9O0c8c3A/t88+H5ghFgKwDPBvNdcUkf4ubnzV4g3
 xq+JtzYSF03g0RUIKUjmoaSK6YJeQ1pX+2t3EdIsOHR6KKTkTPhOkR1CSUm6TofPfaJL
 HCDp7VWuz8J+32UMedfzCcR+kcNC2JHW/ue41UrbIYhyrQS9xUcrbR8I9PhO/MXXhYmf
 eMAfkikqZpyuGCyVj5xj/gsgbeYrjJPLfmEeeWW3SfCyfhFrp/0Xd5ZDa8xoFSN+kGtr
 zwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501111; x=1793105911;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lGTPJuiKum0BUNTP8zOsuKjS8nge1HNmM+kOmM00rrc=;
 b=SooS+Viqed6/ZI4Wc6rEcJDHTn2rIpzTjven5BzYszxsHNtBQdaWTNStN7HtjeED6W
 /gKke92WLyqrUp7WFeW8zKfZpQVjnXdL4EpGtL1hUJ4VqomnkfBMgZY3btEom8gdZQjn
 E2uxX9oReG2tjn+CcSi2YcX0iEGkt4CZvS+aZAULyI+MO2xMTuvlNePcXCamFhuYa9VY
 SN8NxDf24qQIH3rKorvSCXElbdEGdecPCmjAUZar9PEIhK1m1ti3YlvU3rfNw6num/dF
 l35QmheHzj5eqwcF+XoKcgTowS9wxWfbRpTHQ8uIyIjMK62mf1ilmxpOWMmQPkeOekhw
 8fIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4HUD5DdWB/+5QmMOL3XWKhAUe+22AYFYs9WlPYejr2nSAD5Nfxu+9XPbRWoJPTmtk75EBiOoLlgRx6PGr@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLyaOfnHTDfMJMpmnDo+V4fbITfBnLgP71tMbTLGDx4Xe78Uag0
 hA+GNnvaajuQu8QUavEX4IjJ8rV8TcelDZvA3xSlCV13Jyy/71dWhFzeEKLt6W/UxWat8Vc++wq
 xwH/ZY+migXiRZ6aRKa8zXuxO20Yv3tnp3IqGK/T+eqcIna3q9BhdkZCK1z1r06LJt72PxPKOOO
 a0Sflhew==
X-Gm-Gg: AYBFou0xYRZAh2lTk8xo3h0Imi+GmpqD1nvP1DIu7id+eq/o5hfuz4xuqrrLidI5Wxk
 jBC1RlaF6sScPzscJ4ZhhKvaR4mxhxbFWWLADLmrhrtLH9YkkVhZTPAKmhJUsjyV38fvDBS7hHt
 0J/PXMFOY8xIaT0kFxosu6CDxgt2vBOlKG0V0FWomOOlpnbUB+ch2tIBN7UjcEfQmqxWv8anjqa
 375ODquSIMBBMcaeCotfNSHIWhTgh/hgOp9Fp6q1B1u6gfGej4vKSraFhCPkbJSleXW6aX4lf+S
 +N0vOyugxPIKlkPMFbnqKEqwNjWQb+si/9gvxQLFsdLdVVXOKBQhDB47zaAOqSQR5e6P9o/G6e4
 gdhngNg39jrFnQCfUbg1T/B6LZ7uvpQpC9SaKpYRiW+lrR7cxxvPZJWayOpzSevqiqFUBLZyGPy
 4zhrfk542Xf/iEOwqSKHTdjlvUCZIfEySRKy7DckqW6+FJo7MiKqpdHDTVpR4GaolixGLrlCn8a
 un2BEJEXeGaMz7EQqgcHYmK40nsCKLIplyGPkeCtGwGqGasK+KNtlxRof+fVG9EZjBVmG+3H0fW
 HoYF0feF7o+9qwW3FcD2WlIBIEvkxef0xlEk3K9Qt17ZxU9/A8HbkUsxG59ROfLtaf+OXzA=
X-Received: by 2002:a05:6000:4025:b0:48e:1d87:f179 with SMTP id
 ffacd0b85a97d-48e1d87f1bcmr5405357f8f.25.1792501110706; 
 Tue, 20 Oct 2026 05:58:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6db78csm6151050f8f.2.2026.10.20.05.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:58:30 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 12:58:28 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf
X-Gerrit-Change-Number: 2024
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2024?usp=email>
X-Gerrit-Commit: c8c7043dc9d92d650cea7f902bba7c6c1d8bfe10
X-Gerrit-Comment-Date: Tue, 20 Oct 2026 12:58:28 +0000
In-Reply-To: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
References: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTAwODc2MDAwLkliOTIyODJiNWE0YzNjOGRhN2I1ODE4ZDNjZTc4ZTkxNjYwYTEzY2JmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbbee776eeafe18121a95f39ed18246d1fab2af8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ9QL-0004NT-G9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Require
 automake 1.16
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
Content-Type: multipart/mixed; boundary="===============3992481405087223204=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3992481405087223204==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XlSBcPbkTuA="; charset=UTF-8

--XlSBcPbkTuA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail )

Change=
 subject: configure: Require automake 1=2E16
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e916=
60a13cbf
Gerrit-Change-Number: 2024
Gerrit-PatchSet: 1
Gerrit-Owner: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 2=
0 Oct 2026 12:58:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--XlSBcPbkTuA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=
=3Demail">change 2024</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2024?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2024 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
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
lay:none"> Gerrit-Comment-Date: Tue, 20 Oct 2026 12:58:28 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--XlSBcPbkTuA=--


--===============3992481405087223204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3992481405087223204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3992481405087223204==--


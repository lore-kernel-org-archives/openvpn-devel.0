Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE4606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i8LKEfwe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e+9727UP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CF7NzWvf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EpZXgaG/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SHMJYoFY6FmUpfpn09MQmjTAwzU7SQG6xfEVTyU/6TM=; b=i8LKEfwev0RBWcG49j1rbVLSH4
	KHB2Ddf2RWF7/GHNQtE5pBT78G7cMLPfvWOa01rnmLiETpkUX29qpOWlsbZ9AjOxBAJkOOs6V4yVb
	Y52dj8iOlP4TltYdAcCvDFTwfnwS7cFwfoJ/2cTfQLK57E8T4eLSP/LOa3o5QDPboTGE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLhGq-000000003bi-0ZeN;
	Tue, 27 Oct 2026 13:31:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLhGo-000000003bb-3Hin
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OEDJIfiD/r0tG3tyCiKeIlwCBDrDwl4/n9NVenzsWe4=; b=e+9727UPkNR1Vf4KqMMmpId1zu
 op8cnZL3zx7GBHUz4KVXVoolxWa27YfIHfP+7gDrxfoihckFCrzGWPAb0YxaM256F9GU8oYuZRGCz
 NdHNNpBwBwAqXSvJ8EbJ/pJkx4WuDJH4ktM8WTOYnN/bpNkncfkaRgw1FzN/Ld8JwWgQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OEDJIfiD/r0tG3tyCiKeIlwCBDrDwl4/n9NVenzsWe4=; b=CF7NzWvfugVo4ZQC8lsfvzRt/M
 ekq7nBdfoTp1VVo6V1GheCYlpAMbU7ZF/vR2n+63S/RmAg9T/ynEEzZGK5Q11UJoiXhHblwNLDyE9
 eWrAXYHZQz5DBJfXATZJUJZ/8WtdHsQw6Lu8QSkAeBkqu8yq73DvCZ7OxZGHnWBEDktc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLhGm-000000007JQ-3odH for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:31:18 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2411843f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793107870; x=1793712670; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OEDJIfiD/r0tG3tyCiKeIlwCBDrDwl4/n9NVenzsWe4=;
 b=EpZXgaG/b+8eC1qh1M8x5Sx7+WDTVjk4PxLX6PzviRIFA3sDNn9OY6CP5UaNzgT2I4
 CHAdbYsvSo10od8EahEmOlRLoM+FI0fm0hiLl8F6B92gCm1lNKxvhAlRcnExIaJEWqaI
 9timrm/enJmHUcZRFzkBZGO9+H2kJN8M4S/KpWi+md9asfqhTuXIfOyw9buGqUwfi/Zc
 z8/VPT5mLN/u0hC/KwtldNOhpgRji3QLwAwSVrM2pXKlnZ5UsnxVlhTmwUzKSu75yl+/
 j59FlDJda7wammzDQyt88Av0fN06XC35e+Ppkma1zYB8cPta7DP2oLFRdkGafLetxZVO
 Hu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107870; x=1793712670;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OEDJIfiD/r0tG3tyCiKeIlwCBDrDwl4/n9NVenzsWe4=;
 b=RsrywDLVAgNn7Z4vl5kxpleM+YoLQVBKYnL/OPBt8IkAOsFwMM5B1Wj6ahloyqF2ux
 QCCKMzPKhblvu/z5cDZYF5vSJ4WUpUDgFb5PXeMTjDMj4/Yx1XEV1cV3tt+6SmEnsBEE
 +5BGLDRE4C1pgPb35eha6pTQ34Qrd3m4xJxnrNwupuMUxW78oGpFhPPNOLrMQxAi34U2
 omHv8Oa+FqiAOVrzIKAcFRUV2jEevZn4vHzzpLBMcJpINz2sVgBORZZi7ZbXJ8BTciU1
 9pUM6QHFmA3Lt1qZRTbJGJgvyreJ8WP+/uw88HIN/hTZi/4/+LMFsrBBFjCEIwmlV1be
 1FJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxET5F540xXqLFKNkUf5dSpC8VMcvNBdCVA+KnAXq0XkPHm5Ig9ZZRV+tZxkoOKXMh8UYya2uDhSCPl4H28@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJhRQlyNbjIru14weqZHGq3KiskTUjAbuZDFeC0FDL11dSqKhA2
 HobD0uy3ntBJVG57PtTOV8wkjfAmW64OysRhEqYrranpypdjdxEqtPq3N+aJ/KSvByN1LBE1bBA
 +6oxXKVypUbclLLV5FLnyDuHI4Iq6ZlQ7brURUTKJS+/Qi9DqLcTp5kUAuTc/j6w3/kMO
X-Gm-Gg: AYBFou1qcdqMe3Q924zy23iit5sCKbHIjr4Jq9KuC4yN8XsQMFvORAwYXBafe1fGPTn
 Oifc2uBzt+LC/TFLCyRATOSt0uq1vjF8joi5NAEz54lywBywpGnoKPG1TmZNKdogy2dteEx8Wkh
 APzCFXm8QO/oZRCD3rb/HNFDj93aTTZGph+hOl8bKjjlLaahbTPO6Mbc1QpqmGqVhSIv8ZsFqVg
 WWaPnIgoi/TvaaShl3PjKhUqjZUDVeD9ea6TdczrttVnZmOnK/PeR6SolIRvUikyMnktACnLeEv
 o5CkwFFqYqpqrsPJyGbWLYwF5twUzwLvnOnE01A/YcdWV+u6NCCcg3H7A+LUaW1dls7MKnrGvxa
 mcrq4VNiKfJwX2uxJiMe+SzbHY9ag+JIrMafGjWZKKFBKR6+x4VFXUgQQFK/ydwFFLe4uSTBrRT
 Sl8beeiLDLbrG9ydtCXCmP+/WQ0lwLVF19BMRS9lqpeIZWAxaCj7UE5Ax/0HFSkZIls9i2x3Ftr
 Pk4KRs7BQrn8TVZ0E6xmjFCY3zFf1JpEiZ+hRCugYRYThAQYIp1CuxYifNPDHRCstaScd7Aj9oE
 Vq1R66eSDxe5wjRWJTABmdLd9unUb3DRnSSFWhNq1iZsFmOm10tri58P3MzImWZ8Li5hArKKC4K
 A7emSJ95zk1nR0hWqtn2Qqwmu4nMnONnRiVdgT6khJA==
X-Received: by 2002:adf:e282:0:b0:48e:c0:9441 with SMTP id
 ffacd0b85a97d-48e3eb93390mr13361178f8f.29.1793107870152; 
 Tue, 27 Oct 2026 06:31:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4115f496sm21838820f8f.5.2026.10.27.06.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:31:09 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 13:31:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: fb08f2ed58217017e53f66a5bae20280bd48bf1d
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 13:31:07 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6793a6a75924b1c602c35a743409a315d3fa1636-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLhGm-000000007JQ-3odH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6967706870666827809=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6967706870666827809==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="clheVuJqHas="; charset=UTF-8

--clheVuJqHas=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subj=
ect: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16: Code-Revie=
w+1


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436=
aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 16
=
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Tue, 27 Oct 2026 13:31:07 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--clheVuJqHas=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 16:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3De=
mail">change 1852</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 13:31:07 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--clheVuJqHas=--


--===============6967706870666827809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6967706870666827809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6967706870666827809==--


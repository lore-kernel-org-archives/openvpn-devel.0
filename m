Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65965CA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/hYP7jEvm7+T+mVSh+RwND/AtDyO7Gs/UBMgfdNufE=; b=B3X5X+b97NAFz40bf+J1C1wWM4
	Hcbzqdms85Wz8dZC9WPntEf8njsbZPWzdAvMbDuJyXEwyS9DZVb9KZ6123aAspo/HkscbOxcps2AS
	pYG/6xcgLKEirjFKDoiHu9GzPzyAqdp2pZ2IRLP80+4lNJjX9oucDyKgAkkv+JTNEUEg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEmFP-0002Vi-Eb;
	Thu, 08 Oct 2026 11:25:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEmFN-0002Va-IT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pYaVpt1VuqjHK6LGT1SKkvKKD7aCHpox09tnsayAaQQ=; b=KSFVfp0NddVPxi3IUI37uLRjm+
 dRWHrNu4wt/WkbwBGkzpuOqEIGvd6MTeQ4UXWwJJkQxSTfGOiNPHAdaCO7u4ZFpcVj9iExJ6ti0pk
 4UNy3/aGhwpuHZI28bwis2Q3tAzErSa2pur9QoXvWtHJk3ARhvzNDGl4sXjcpepRkRX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pYaVpt1VuqjHK6LGT1SKkvKKD7aCHpox09tnsayAaQQ=; b=Z
 jQBrjjs54GwwUjxVNAnU1K9O4NErHWW6iRvqckJIbeurbHWaO5B9DaBvh1rxlHHm7V5rBPDlJpWrJ
 KNpmrEzMtCty5uxxRCQp04i5zy91SQLIZCyoazfE6C3fGjrWuhWCU+Y8u2Ji4SbxhyFqeRS2/aTam
 7IBOCeaUSWLceIoU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEmFK-0004GF-GG for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:25:10 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso28402945e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791458704; x=1792063504; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pYaVpt1VuqjHK6LGT1SKkvKKD7aCHpox09tnsayAaQQ=;
 b=by4olc3IzBfZP7z2kC4pqPm9NsV9mkynUL+31LFkht96UF1z4JdE9RM+NP84zbV6V2
 AS8LVaj/v/Sug5IEAUz8OQvuNlN76yxUFafsInfPJxPHKFcTIMesRbWO7m1dIAUScWTd
 IAmWezpnuqGJOWZdZL9ks11t8RD/RfSpsMW/P+K3/eKi5VJ7neJhGLi+vJns1YS0lyc3
 pw9JeB+hJuKpfP6OcyyjjlwJEIaHTIfPLBQXL3jrizA1x0AfYkHz7CW+VuRSAXY07N+i
 SbufYvRWZ0lZlgY+tW2Q1wlTtYRyj/Xxtf2548B+s+1r/kV9iqB44ugdcC3Ez52VPYHw
 rVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791458704; x=1792063504;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pYaVpt1VuqjHK6LGT1SKkvKKD7aCHpox09tnsayAaQQ=;
 b=p6MAS5+t7eNy+mrPZHl+5xcy30holN8V/HmYs9FQO8XTF04xOMCLT5yzvIL96luJdt
 opaGqquvlCTtrnp2ApVP/xN4zo4Q86eDkyxemgazf9cAQUxMx9JLZq2f4Jd3sfZGug2g
 Chl762KyjJIUiDCklNK2ADuxbxGBcXlniaZGHoiZNzhXO8MoaCjOBCVs2uQXI40m64Ii
 qtuTh9MzV71nWUrQQl9Ep3UmNWrVwEeqigx0Jtr5iQblf3dRzVt3oyhgGkRw4Iu0ZfsD
 JYVcnvt1K3QX99Zxp1Ob/qYwzY+JOh2zcOGfowcq4hGVsSlhBqD2rZjZTo0UH6iQzQjB
 ZTVQ==
X-Gm-Message-State: AFuF++knzl+8CwFa/iu5jJbDf3XlFb5ZtlK5AarMOGx2WaiBAjJvcFT9
 XDGh9fv5Csl86qvMw3UB9a47PJ+K4TauUaF8CUZUs3XhasOJlXSskydHD7CjuVaelZHrh1BsdDW
 vYnjU0p5plUE0YhjCHGHRNCNziG9mfQMBn7dJv1lNk2bfacAODbHDidMXAIeIubEjsh7E
X-Gm-Gg: AYBFou0KZyFTB9kQGPFgyEYuWqXk7nln/XUp/dhDkU3hZsWZFMIK0db2XcTHiBqHsX5
 QQ5mCzUm6h8VOrq2fSRVGFmZrX3Pj86JSDWrlkVB2+N35xqxK7ayw/WuHevQsZ9J/Dx9Ln9PNLO
 zkQW7Xp5swtWHoji0JHWN4AEy5SWfFHA5wbuKN3k8GN7hii7pHvPsrEu2bEz8Cdvh0eZIo+yF6s
 FU91ljTc3QI6I7rp32gGvfQaDYSgAqaecVnvI7o52sznQ8Oo6x4N02FxaxVpwaEz+bmBsU0FZxf
 go68Qv6jf9Bqp1jArXhsSCAdcM2ERTY0TylA/SqRs8e80NGUa5WjWxN9nrDXMScv0bCuYfHS/js
 /mwpSlkq4AnWHJ7Kco71yEWCjXJUgvOUyNx8dZc7tlemdYbL6mg11fU8XNeTfJaM6LbOBqWATf/
 YgBBfhWtK7PxP5bd98wGhbpTlxKFMgJbOc9L3ET+T00+dGwIxPKWsOCOR7esXIc0EIPBoboPFE8
 O7jBSR5Kg0yiDxTFG0b4BAgHC+egRECKEUpTUzdmS+6/4DQbxMOEKGsw1o+HqP3NVhAAxOwFN/i
 0YMM2zOiX5OacLJCXST3I3kFEw5LOyi/mE5YgntNCzuBM9fuJBGJXLl09yqX
X-Received: by 2002:a05:600c:3f0c:b0:4a0:251c:fa72 with SMTP id
 5b1f17b1804b1-4a1803038damr96892865e9.11.1791458703789; 
 Thu, 08 Oct 2026 04:25:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f4482c4sm248979235e9.0.2026.10.08.04.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 04:25:03 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 11:25:01 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
X-Gerrit-Change-Number: 1901
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1901?usp=email>
X-Gerrit-Commit: e8b3f9aeeddf74dc15ebbb0e21003b4d1a25f833
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 11:25:01 +0000
In-Reply-To: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLkk2M2MxNDEwNzVkODlhZTZhMDc4NzJlNzg0ZmFmZjgxN2RkMzM1MGIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b1af5d8a4511acc1be9bd31441634f096593f634-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEmFK-0004GF-GG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: fix the
 send window width
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6445186730246200989=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6445186730246200989==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B3N2+8D8Hgg="; charset=UTF-8

--B3N2+8D8Hgg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail )

Change subject: reliab=
le: fix the send window width
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
Gerrit=
-Change-Number: 1901
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Comme=
nt-Date: Thu, 08 Oct 2026 11:25:01 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--B3N2+8D8Hgg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 3:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail">change=
 1901</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I63c141075d89ae6a07872e784faff817dd3350b1 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1901 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026 11:25:01 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--B3N2+8D8Hgg=--


--===============6445186730246200989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6445186730246200989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6445186730246200989==--


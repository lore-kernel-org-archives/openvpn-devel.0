Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1640606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HjZymfHW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bUDEoygg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EbDufUv6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Uzs9FPOv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=u0CVMvdZffM7BklaJHwbXIja9PZYGQPKD6LHh92mQkM=; b=HjZymfHWktvwFp5Ba4P9D5LiQK
	ULoaFfvpYwnV16D2mmyT1JlUowiARDuEQt7Ks1ewPrTGfM2VVh0VdeDcHrqxmqkiQ7NGMfDG3Qlba
	iczxjbsUvTtraQOhFRTmJ6FnIubQeC8nUQA5da4LVJpT4cFM1wevB9aVqFGaj2LQCuw8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOEky-0000000074J-0gmX;
	Tue, 03 Nov 2026 13:40:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOEkm-00000000747-2svX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Ds6Le36PgfdhRwhi+/jBcMzRkYZsq8G6l5z+SR4DyA=; b=bUDEoyggqfyNcDR7GkC2IZ+3zl
 qIkrKfASbSEU81vFq6/VCG2i6TIRhq6wmpXza/WdAgoYRB61uWNs2dT+C4zhgecy8DVko6EakS3o9
 DS+2yehEOr1DLKYDFigrhVcGLGqQOnydgK5Of7aYi3pKQZvM6jnGh4fWDN8uyc6rVrkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Ds6Le36PgfdhRwhi+/jBcMzRkYZsq8G6l5z+SR4DyA=; b=EbDufUv6FnAe6tedX6OIy22B25
 VA3ikHuyrkDCZhB4iWPHq4UA7qUw1lb1Ah047Z7OKkvcGlwIAEYh9uCVtYndPXP7bJ5YLdYSSwnFE
 ElQVekJoA22se2DwKbiawfgURMe93OWsjPWuCyoPtQVrQc99EqhZatWazu1mTeaY4K4s=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOEkm-000000005Iz-0FXb for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:40:44 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so32177145e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793713237; x=1794318037; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9Ds6Le36PgfdhRwhi+/jBcMzRkYZsq8G6l5z+SR4DyA=;
 b=Uzs9FPOvtZTA3g4NaeCvUvcDTI3AeLVRj+o3fs9dh8YGwbRFf9W1kgGsCoi/uOTb31
 uNmHgUnoarSy8VWPsKcPcfZRDdBin0TsCrfF+H7O6DWIeiIf6fq9bba9vZSrzAurE6pj
 THJcxGfrhCBBtFXKtR9zGnpO9mLStV5xU5+nfojP7TS+zmV4+upqK9vVZP1KnyDsgXc6
 Zkym/7J/qWixUzH1R4TRtTrNhbeQCs9nBaYQINQpnebiDRODJIJqSupyQNiq2eQLxSJP
 yZlyhX2ypJslHQpOPhh1qk8E6tJonNC0v9QbHwAyHPncb3cBDlyyGHwdmdlUyX7+w5uL
 rhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713237; x=1794318037;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9Ds6Le36PgfdhRwhi+/jBcMzRkYZsq8G6l5z+SR4DyA=;
 b=QPHEGIAb6gjNw/VAeTPbQ/vFZaKceRPEP04Ug8xdyc/eNX2H5Fc2CHhcWpxFqrjExd
 ZtvnbIJxRLLHIqUmxBqCXjgCygQ3s63T7NzC0yDDdoGVYfr71+y5yEX5W9LvJ2CioMV2
 7HkjYXGkzF0GiPWskm7eH7+DnAzFV+kw8hp94TONMdYFLu6Z4bpd4BcNSjr77hms5UgM
 G+ijM26uRrHJ3uq9KA2hA3BE5WPDgH5OouUBzLfycTRA+qcwpwOaxIdjIva2+GV/ACgH
 0xeWiL59dY1vDlDcLP7QyH7MDQ3/YuHaprmTOzKdbK3iCmrVo7EFWe32r5qUelFilbTe
 J8XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTBrrTzzTXFK91+enTyZxi7YSNboiGxrKPQVbPRaw6zymQ08BI6aQgKszkJiftUJ5vpHsJ5G904sdkNXNp@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9uTrvs9xX/LUCTbXaIMDByIDCcjccTnNXkWR4B3gLz5LhsdNso
 lyB+SHbTgloOq6hmFe7tClFCQodpfhI0qKw4bsbLw47XYkKQMEPhf5NVOH2wnWp0J/SiWHj1Esf
 OZVccBMc/2wbvLX1x4hCIG9CejmqP7h1ZI5g/3AeVgR0/ONZ/77norCHRwU9XuuUqk5s/
X-Gm-Gg: AYBFou1mxvU/Hm5yQoca/A0abSAzzY8puqADSOnEUeJd3LbPB1Wufg8ZYWHnDT6Qdak
 thxjckTBnfXi+M2ea0d+kDAcVFJFdqyVD2FWqeOmh1hkxrSxI+FDr2xEAWj0tODgdQhgo1WwVC2
 hNnwd1Q3TJlySd/izSVRd55DCZrUD4PElJ0hcUj3AqmE5EF28hI/LampgR2dYG5xA7gVHRsLNf2
 kUGGlujiscd+HzV1AgmmgFY1V5dvU7E20TdXb0+zJFg1Ur6DLG1F9EKa4AFy17w6c+nbGlZqID/
 Eq2NTZW/UWr2O8BChVvsiKdiSUOQQVLNJYqMtIF4JNjDDY0Ezm9BqmxmzhE5eNXL49JGlUwdKZ3
 ZTKctwFswxjMQS/aMONX/C8TeX6tEq6hWJAtjJppHSPyeZTejBBs/lWc7XhuzYNTXL6WNjmCCY0
 1ZW6tkHyJngTNWYJRxGon9Wz0nYW/pW3XBNa0ToOGRn1tt6j/zPb9UrTZKI9nXze33R5qmuyJyT
 tlOC0iVxE+Pi6mLO8/ACmrqdJJpNFrCuqV3VpE+k5GoDj9Vhka1V02CZdX21shPdaLgNLWDwJHt
 FZQdHjVJHlAsnt4DnCvDdFVzhyXTQAxXTGHRlvifR6oGMgtdTIwV6CuqWxAVcucZpeXGeOHfnMO
 Bf9bX2T4nvuS7W8XbhUAfnR5e9njH3XANmZVZ1GR2+3X6pvvZ4SoFkzXj0f0uu29dli9yG50319
 653GJkzyOwdpcPXg==
X-Received: by 2002:a05:600c:c4a7:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4ac18f52aafmr290698615e9.35.1793713237371; 
 Tue, 03 Nov 2026 05:40:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a5372d8bsm64533045e9.0.2026.11.03.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:40:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:40:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 840af248f93e85d29d3f314fa6cdb24535b780f5
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 13:40:35 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b29f60acfe14b4fe60fade368fc84de93c8696ef-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOEkm-000000005Iz-0FXb
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5284007397048113549=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5284007397048113549==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XfPq5FKDzPA="; charset=UTF-8

--XfPq5FKDzPA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering=2E

R=C4=83zvan Cojocaru has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail =
)

Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2

(1 comment)

Comm=
it Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/05a0f6=
f0_abe7c54b?usp=3Demail :
PS5, Line 12: This feature saves a single packet =
id to persist-replay file=2E
The option name is "replay-persist" (not "pers=
ist-replay")=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2082?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
5ee231d157459e6406f1f4c12cd6c6e0fce93815
Gerrit-Change-Number: 2082
Gerrit-=
PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov=
 2026 13:40:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--XfPq5FKDzPA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=
=2E</p><p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?us=
p=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/05a0f6f0_abe7c54b?usp=3Demail">Pa=
tch Set #5, Line 12:</a> <code style=3D"font-family:monospace,monospace">Th=
is feature saves a single packet id to persist-replay file=2E</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Th=
e option name is &quot;replay-persist&quot; (not &quot;persist-replay&quot;=
)=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f=
4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 13:40:35 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--XfPq5FKDzPA=--


--===============5284007397048113549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5284007397048113549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5284007397048113549==--


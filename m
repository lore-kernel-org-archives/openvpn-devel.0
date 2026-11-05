Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E65606D802
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gjpB52BN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ud04TOOZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GRv7yUxI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V58E8sAQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I5lx5u/YF3kmsb1/LAAIX4tS4tqRPKh0bxbp8hfZ7YE=; b=gjpB52BN6yVTixM18GK9M2+ifD
	/gXiJmjj2bMHpe4s3L6k9dBIgXdeLwUNta6VIIWJa3t8e4cjHWJ6NSXgi/0HRR63CCf1ar4LNGS9P
	lscU3jNSimMAMeR2G6mAO0JWuev69gIbn0uwNHIMlZMoWYYcG8qEy7c97xc/1etC4zSI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOt53-000000001uP-3LR2;
	Thu, 05 Nov 2026 08:44:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOt52-000000001uI-1XMs
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 08:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ogfR+LI5oIeQH4bLryi6at3NTUP1IHSiNVgheIiCF0k=; b=Ud04TOOZS7qzbe7NVcAUZxs7YG
 OKXFeDZuD5LcToHQoTgG4dUqrbxh2gzjBJ0jaTcrVQr2npCpWmH8vX5g0T+wxtytxK52rXgHrj79e
 IusfDySHohFTfYF46JlSaYh6N3SQMPSvEc2cNWZAFy9+6tIR6Dg0dv+1rqfLRVheuzF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ogfR+LI5oIeQH4bLryi6at3NTUP1IHSiNVgheIiCF0k=; b=GRv7yUxIHgkae8Y5rbzwyuoJen
 swz1Rx2V1OJ6Qg8VFiN88ELKIDAZ5xqlmrjN3+xJo0X+dpNXb6Z3iBfwPd0RDuK3CW8lYa62Btbjl
 Hp9Rn0+wvAfur7O8nMmg4Ecg3PN/K5UCejGnZx7NxWBQroshIJExcPqfuMeNJohy4GL8=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOt50-000000000Qs-1gXa for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 08:44:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so11103705e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793868252; x=1794473052; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ogfR+LI5oIeQH4bLryi6at3NTUP1IHSiNVgheIiCF0k=;
 b=V58E8sAQfrqqnPJn1BWLF9ixB3CdCw0aQ/AvOttS5GfgZmkRIsHUpKCXv/ZRtBbV4J
 JT+R6sUebSC+1qHEAP4pm8mx+2Uon9KhCid+vmRYgoMqAurA7uEVsfVr0wgy12gucTzC
 WCvQOww+6wEV7BldfqnGA8D0uNC+lbBhjVvYRSWo+1zDp+HkieXz+AJqOdEl9z909Hdo
 74QWNyZoLudWHxtrSWSw+bq3ufpTM10vgshxYPqmejUjVIkRI+K+pSipj8Q7N52P+866
 m7LES/e5W5/8eNxidRGoislmmQyxXNxkLzcVf12MrPTQcDmrD5p+jgcBL3aMerAhWs2W
 ii6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868252; x=1794473052;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ogfR+LI5oIeQH4bLryi6at3NTUP1IHSiNVgheIiCF0k=;
 b=SOmoHrtMr5S0qyXEvoYGZCp73bqdK6tJycPUqAoGSW/5+crovCIxZIgz6mvY7z/UuP
 o5mT9fFHZjwdkSz6h8XmRuAX8kBmlRk7IpuCNPPs2RIbly/oGjRAJ+4QT0OLbQYOLc+8
 8m1g8q9YGF4QwZf4JxSWhV9zcYrHqUvttdec/6bHHISUr5mHKlglL299LP5+s7OM+Xw4
 IlQDWKO4DOtW/GGom6YiFCBAan62hK3QWsv7FQfJtTCauu5Do9T2hXztUwcN7bPD2VQw
 L84V/6sO9At5w0sBEGla5PdJdN4crnpQcg5QfIwzw+Gx6yJndMpRKqFxUE4mA3Zs/PIv
 i/JQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc+QaWMLkS7w+VCzQO80T0Kx7sznIucyczRsMGS7Z8fZh7/yVwrlkEsUWaIyuFRtw6fhZGRQn8E8uGlNfD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/+rl6h+xgm8laRKy0iwds7o0e2ESTjTxj4ijHAwTFEIghDwoTZ
 qJCV6yaaUCtN3CnFTDo4ee2Wf+cnUq/sAQOWGw9goeL5ECqSN4ZdtBlSW0+C3sb22RwdZdqTPYe
 t0DyNlNdkVxcMgEGGrtFFu3Sq0xtn9l+Qzm2jaEL7gu1ra/oznkVDEhuGDIiGDBPhclUYGs2BaJ
 9KNI+lTg==
X-Gm-Gg: AYBFou0BUSC2podgvlX4E7UeioCh6J1Rw2fGLWPL0bSKAX4ZqOFZxCL2KWGcf+MLkNc
 Z2MSkpcsJQzTUa+L27ntv8sHLa9DEE8hE/uHUTSxBST1QU/RSWHkNxe5kE8EHFIZGVT6InG/j+o
 Umm35kCpKcW4Yka2CKN4icjbcgBFclOWRu5C0gZWCclLAj2OL3g0Zsprcb2n8ewftFLHHsyL+J7
 c0fBLBeQZg1h5tp3ccTjxrBYH0G6N9SgvY+cqjIetapnBD+dofZ6sUF/tHxfPqAysyx0hygW2dV
 OyAePsb/0fG6kzD/Eb2cxLxn4h89snJUelNG4hzRP3svq5nLQxFGWys9ntXW4obkKIiRkv91YBM
 t6vVM8rIbwRqSVYIYbzrOJTiRXetlACDdJPMBbu8f75aVYGs9+OdzIwDKjxHL9SpEmv/OiXY94J
 vpN3pmfBOSottF+wS7lAt4BJeEIstdESw12FW9THSW8MMOnhDEmXuGZl2N0HFeKGX/CfoKc71O8
 hA/WUlBqyjqSDLBQ80LQpRDFtf9CuQs+9swn+sOuQqmKsc7lWAg37Qe4oVScjZ0PN6ipr7+HPQC
 6RdlxSxezkkABsgyFrOud6B8AHp8RIlBNkaF2wbqIFFLszq8bomkmoAm5j6BjlIffQuO1zAiQq8
 xRkAVDkaLBwQedajZL+X7jGYeWdfWy14mAm1k8W1TKqga7Qd8ZAuYQS/nwxGFrMuK8DavFuhWe3
 pKRsm2vrYpvedy0g==
X-Received: by 2002:a05:600c:4fd4:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4ac180f2ff3mr402665595e9.17.1793868251469; 
 Thu, 05 Nov 2026 00:44:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57203a98fsm41904835e9.4.2026.11.05.00.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:44:10 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 08:44:08 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
X-Gerrit-Change-Number: 2075
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2075?usp=email>
X-Gerrit-Commit: a5ec84fdb69a6b63ebab56b260bbe231dfeca50e
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 08:44:08 +0000
In-Reply-To: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
References: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzMyMDAwLkk0ZDM1ZjU0NDAyNDYwYzU4NjZhZWJhMjYyMTZhYzFiMmQyZjhlYmRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da3867f7eb766891f96bfb5f59383d1f51752a84-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOt50-000000000Qs-1gXa
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: Wipe the key
 source material in key_state_free()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1916026559359093338=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1916026559359093338==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wdi80FmyqS4="; charset=UTF-8

--Wdi80FmyqS4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Steffan =
Karger has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail )

Change subject: ssl: Wipe =
the key source material in key_state_free()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2=
d2f8ebdc
Gerrit-Change-Number: 2075
Gerrit-PatchSet: 1
Gerrit-Owner: Hansae=
m Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 08:44:08 +0000
Ge=
rrit-HasComments: No
Gerrit-Has-Labels: Yes

--Wdi80FmyqS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Steffan Karger ha=
s posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail">change 207=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
d35f54402460c5866aeba26216ac1b2d2f8ebdc </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2075 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;ha=
nsaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov 2026 0=
8:44:08 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--Wdi80FmyqS4=--


--===============1916026559359093338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1916026559359093338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1916026559359093338==--


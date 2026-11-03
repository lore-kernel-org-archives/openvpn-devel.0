Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF15606C543
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hqHQuHdL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VcsSi+HV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DVC/VFlY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SBswwPvm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7BuKAG/zwBE+LIjLVMwxCepMuUbxaQbg0pXWbDgAeoE=; b=hqHQuHdLR74X36f+u1N12Mt06O
	kotwFAP0YIqEPKfXUFu8kLmkKedjUGl/4TT7311DgMlVoqtRrvWivVFNfJ4qWOfS6nLMT7wIKcCPw
	lWX6t3RikvBFRJJKqSGVOkHRKS5eSMfPprGgFwm545pPg7XoksHkaWNr3OY6VEBGVUE8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCaU-00000000534-2tZ3;
	Tue, 03 Nov 2026 11:21:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCaU-0000000052y-162K
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKAYgkk9c2ii6ZDouDguYPTp1n8Tt8sKqSsfqFlY1w0=; b=VcsSi+HVEc8Tefqk5o8nEboSLC
 OpVES51woI4qvhgBwfTe7uMLRsylHBRkZX2RXBLU6Dkm2aQc4i12Uuv57LBVqWtu8hvvlJrGQVQro
 tYrkmFMMBN3y8XdhJln5TvKk+UbVyJIOkpRBcnAreqL+IgNZ5T1Ie6/bQpZo9B1s9OSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKAYgkk9c2ii6ZDouDguYPTp1n8Tt8sKqSsfqFlY1w0=; b=DVC/VFlYu+5AAy3JX8d9HgW44P
 fjOGivJovnOFxW8LLGkdNCQ3o3+Zwn3xJbogJdWfPwE9E8ZXI7WogIozMRiOL0Vffh4fJTCE9pqTU
 BCAwSCSSZ8JL2QQIZgTTfcCo0GBpHRgmGIrEMdWw+nSWjUdIgqkGwGnq20VByl3wpUvw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCaS-0000000021k-3VIa for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:21:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3560844f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793704910; x=1794309710; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PKAYgkk9c2ii6ZDouDguYPTp1n8Tt8sKqSsfqFlY1w0=;
 b=SBswwPvm/fZWq33b3pQsv+oLgFB14Gnb7j+HU0YBNSycRQGDdIMwzMRNRz6xtoeL9u
 wE4WfNLSdCtFacMZNdhNqmslGCIg1Znm8hCT/yqwZl9nW6bUsZXUo/Vs5ZVoxOXJphxv
 r7XlKLb90OkepD9X5bmqonwl2hhB32YHv2cRgpH1t40mtrI4kLFR9PZHFDvAQLn2um5f
 6SEGjtlFzJy9IWdBb4QuK7wQ+jfnB9emXq1c6mBGVWB067MvE7gi6kj/llUnA9+eYB+9
 t1Kf3ZqGBw9KdD0MhXBliK/SE2DqPE9L5kafLJx3FzUSp5ehiqp/Qx3VfwhOIRlj+iiH
 BTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704910; x=1794309710;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PKAYgkk9c2ii6ZDouDguYPTp1n8Tt8sKqSsfqFlY1w0=;
 b=eEJ4ycCj3K9VgIf0Tm5QY9SCGDaEk739dv72/2vrkBF4Iyb7QRCzyNpxWqBo51FQ24
 WI1fLis24Q7dUr5jw3TMKrLlyu+g5Mcb/kexDLW/B4wXnQyuGe7Luif6fnuYDGDQuzbI
 lYebRuL/C3K1SAusDMYAZF0db2q7yJe6UxwgP9ehG/UQTBVVNyjlJsrVsu8iW4HqIPrz
 REKFiYKd+9xkLsgnn2u45VlIdAZF541IX1ebnsUdExxNcY7ax/dO/P1eG/K2BWvTO//1
 DrA0kOQRZua65mFi9b3+GPkkK8/lag6Yxlw/xsxu5stG7Ub+hcx0DYYuR8pgbtqPsgX7
 itrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxICM0yhjRQRhfmkuESQ8aLelObPBnoatxvmzKirmIwPmaEUPRV1x6tWRvQQQCaXJR4etWXeYwuMuxo2Hu6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/KvL+gifcXz/nnlqTCbfemgcwUkwQMT7R2knmQysEjzJlxlI15
 p7BS+nCCjZE7xp57aqWVVGHF0QYMuZWgOy+3o9WRVejdRgTlndj3wa8kelWZIc/35M+u6NqjvZc
 lwteo1Yf/yg3a6qcajF3LBWrVkgc2g34PY65u7Qn8LqMkFfHyN4vlElem+c0GX6nZ1F0H
X-Gm-Gg: AYBFou3tympzVFws+hOM/NEo3XcTn+QYSaxK+PMKobmpL8y8nmCzIuZFjZos0AuJJ73
 d5uIJM8vpPEP806BCRtgV0lLLVA9uplKDrUXG750uS7zahMHM5nfpUGwY4d85MBTcSB9+3O9Kww
 ITDl/MihdMMCfEDpK0XCeHg4W5So7BzYNqXCPrDSZ/qBlecB8Evacjz0gGAWlSp85R3wV8XdpGV
 Q2Gfr5AK4BOaYeFxGAsP8Oui4R6SWcSnA/pL5ru0bZRmFaqXKgFuBABahY21Jfon/8c9lD5exwP
 4LK7ws8mY+RJWR25xuu4q0oYPoZGryR+6IU9mAAp/44cLhv3aj4uqFuu9eghdohXwMCBABGo7C/
 GppjE4DovV59TtcXPPlUpnSjXvqLmGx0C61YDLerDiuptLyupXJ0BhLCRb997wTQgcIHghtgdYD
 ifoT/GJo91NSDGBtwnB55zoPE+SU5UueRehWs6SgHgCyZdL0zVNL9ajGsKnT4mMRtLpEtQz/h3u
 7WOmjLbgapGfOP5lKoD/Dk5IUBc0OPdqdtjIjSzRe1gYUw51vxOhwPgTDp7XNS1LxlP7URCYPSo
 sYysI6om7hxGm5FMcySIgZMaCRX2ZchrHIsB+IaffJSW+ItzgR85yOl1RGzvU1wmvEhhfb4QqyK
 Zw/RIARUL1EanK6W4fEhLLgkFdYXd+PVwRidNcfTiAOnR4bF7Q9S4BtRcM8A3OGFyM8oYDhVq/E
 drRgYoXE3ovTMugQ==
X-Received: by 2002:a05:6000:400a:b0:48e:4115:f3e8 with SMTP id
 ffacd0b85a97d-48e6e50096emr30222308f8f.27.1793704910048; 
 Tue, 03 Nov 2026 03:21:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78f95sm22929338f8f.28.2026.11.03.03.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:21:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:21:48 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: 2c83d9e5d30c38ea1aa872ddb2a7d78de2920b95
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 11:21:48 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79a596803aea1f899950aa658423a8e354d2d22d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCaS-0000000021k-3VIa
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0974521331806198642=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0974521331806198642==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DBAzWfVtAjg="; charset=UTF-8

--DBAzWfVtAjg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 3: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2046?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Gerrit-Change-Number: 20=
46
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gi=
anmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 11:21:48 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--DBAzWfVtAjg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2046?usp=3Demail">change 2046</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2046 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 11:2=
1:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--DBAzWfVtAjg=--


--===============0974521331806198642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0974521331806198642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0974521331806198642==--


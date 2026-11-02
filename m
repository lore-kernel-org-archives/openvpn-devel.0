Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DA606FB45
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TBUkiwwX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PJqPVJpk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TbensAyB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Iz6ik4uP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X2F/8ll9d9KJA/uN5MZX+u6gnMci9lvqZqJ3tPd5M+o=; b=TBUkiwwXc41H3G3fQQf2n76UAD
	uAiK4uX+fihGbAXMy4w2Bmb0TEIbjd4y3bvIgPxvwsntxA+pg3P/bCspIUizpya2WQpsY7UILjv2m
	RcnuGGKRSEFDLbP5HUVwPLVoDroCnz/Bm8Dd76YxQheJXlUGHnDgfrkiTx7nbjh4rmZQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtnJ-000000005YQ-0wrh;
	Mon, 02 Nov 2026 15:17:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtnG-000000005YG-45fF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBtZ6rulB90jwcwUsz92nFPSsauQcynPlwJnA3bIvDY=; b=PJqPVJpkWX6n33/WVHr8/IbZcO
 z8JoJZcsW6pNmNBWz0fTvjC7jBvnmTSOVi1ZJ8GkN8fIM7SWVLsr7Nmy6HRP7sQihtE42ui6SdycQ
 gkxWbbUdpTDoKYaCjrGsyA1pDSENTGaVZvhy9Zrv+mUyrMl2Om8CQllQrAJNSqBqpYKU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBtZ6rulB90jwcwUsz92nFPSsauQcynPlwJnA3bIvDY=; b=TbensAyBPFFyUsCJpHBIsXMzAQ
 PGA2o1rfvnI8bqYMIMoa7jgQZfDdnc6y4uN9wIBxl0cqbdoVpxVsYZ53zSzhonfo5JwCh5Z1WfrkS
 ub38KjNbzbIspjrOF/0fJrNHwse8k9Oz+MpFe8dkTvWIh2X2Y4btdg8twe8/A3wzNdUE=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtnF-000000003As-3vyV for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:17:54 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20873405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 07:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793632667; x=1794237467; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cBtZ6rulB90jwcwUsz92nFPSsauQcynPlwJnA3bIvDY=;
 b=Iz6ik4uPNsUm4qpSa7yZNEMqtFXb+/z0wOk7GI4oxNMsCICosQI73D8B3U7Fdd8g85
 EZYGh5MxTAqueH8CbAzzIDiHuhBC5mPgoq7s2bwQCTgFjT5AlD6VOs851HeCvXU35+bA
 4darmMDvnKEtw5Me2e1ll2xSD5YdUpdUQqieQQiwp+g5ZAvz1MAFfCNIClk+4FsRsNYu
 97VQbGsT0Wo9WafUFqkLhxFH5L5kMS5tRa03dj3zGRlu7OoVpWCsMXXaNS5amke2jukP
 2NHVJTJZ13GlodEEra0PV7jGYsqYw4fD/Gco9l5Fq7kqtF/C2onbq9ce2ZdacWV33MHe
 c+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793632667; x=1794237467;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cBtZ6rulB90jwcwUsz92nFPSsauQcynPlwJnA3bIvDY=;
 b=jqKIUvZKw4vtZWO0wWrUN5l1KT/JFD/zY3Vex8pKTFK0lsRBWNjDU7By0C6LdjQjlD
 8YboqaSTJMnShYjmdUNpNX2ha7qTv9+wD+2lSH8IHBd/7tYta3vc2gbJYkqrGDepGf/f
 wX9gaEwdDBIlYLFclDEl5N0CS7uG75MvaPj7kRs9iWHMn7kC+Lk6Sbyq5DIWSPx18hdN
 Zm0LixZUseLNVP7xYpz2ctYV0u+D9ddXFjdLYexVCv9ZvaUjn/a/AjmeMQfMkoHJcPi5
 mEV4BiAr6nK6itophhYAdhhu6zNPu+5xwa8COoD5Q3gTeQLFJOCoo+vpxKJcwdO4pVSE
 P9TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB5rTJAEI/WguDUL0tkeknDRJ6tEwPFGLfwOHT7oYQ5td4cw9txdumw60v5PnvGCkyrdLwdTW6iF6bf+4U@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIg+btfwIrQ+DWwdQdHwjghsF1ZqltaHzC2nThc6ajbAlZ5FjX5
 3RLuiC5AgoV/aKJkTFGpWL7hN0U84BaCOPpwlTeVMTd6oL/ACn+Va7IpQdzY/hVad6CDhdbYXpN
 QG/YKDAqziNjiCxmPhhg/Y52J+yVmMWwMc/K7sY10iGZ3CZXHEOBISCJLGbJhtsxDfMhR
X-Gm-Gg: AYBFou2SETAiOG209Opv8VMso5K48GV4V3xH8wWGrMC62GgYsMl0Ofrho9xKKPrL7do
 HvIwddOR9Rvb+2rwqVKD9u1Zgbap+suglpKEFI9ozBQ5ibtAD64ykiWeyJHQwY8mE0e+N7BAHrg
 IS6uy3cyZMGmT/B/h5qmteRmAcBC2dZaG7kvnHLZVsV/1ln9smvrGcOioZgevMCQabalRqj3bD6
 kzMATseytxlK1ziQaTctyPyLnYm3eWME6GlZA7cWlu/U1bdC4RlhZKIQVV/dJss3G0BtN4AsCYy
 7qX+EhXcKfX38JVA/0VM8h5uyO/IB2VYg53uuYgr10NjbfQkIkchBsnQGF5G7LJKao7d9jp66p8
 CUENFCInSp/n8gA+Va9S2E+433/TA+ByGCN7YzIPhouHwxuu9b3U+AGeWcHJz3LErW1B0FIxdMg
 Mj7Y5+rkA0AswtM+EABFDSbcVM+UDmh15GijeUxDCG1h1suDtKpw/yd2NCWfM6gf+DZKCvmWya+
 X0fshZ3Fu0rVxRugfGV256Tb2IyMnUJ7s8K0uXSx2BfsLVYdMTuinENaEa8hrGZyoOyfcgApI5z
 SaTp/lWwf2ZCzsZyRHKMpUO11TSXfw6IArK61wVYUy9GTRGUHmaXl+sRX0sljFPBVq8ugD38p3Q
 vwaji4uM/YkGRz+9IlGa792M5V3KGf2SqEkJKqX68eJGzdBw7xzIZ8nC7TrU2hHzA5V04mg/bLg
 UPrZZuYneZo89dZw==
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id
 5b1f17b1804b1-4ac187a80bfmr242232595e9.30.1793632667192; 
 Mon, 02 Nov 2026 07:17:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm20505138f8f.10.2026.11.02.07.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:17:46 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 15:17:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 672bb8080dde7a781ca6000f014c241b6009e283
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 15:17:43 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e70261f227577d4e220cb69cf99ef4f2cb177f94-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtnF-000000003As-3vyV
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1079174512165546467=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1079174512165546467==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fzO7udUC0ag="; charset=UTF-8

--fzO7udUC0ag=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subj=
ect: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Gerrit-Ch=
ange-Number: 2082
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02 Nov 2026 15:17:4=
3 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--fzO7udUC0ag=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">Vie=
w Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Dem=
ail">change 2082</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2082?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2082 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 02 Nov 2026 15:17:43 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--fzO7udUC0ag=--


--===============1079174512165546467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1079174512165546467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1079174512165546467==--


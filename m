Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61130606A332
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YAGYiVZp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PLrJqIfP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mC9SVMvX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gJ8L6pAY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pk4G3/yC2IQoHCGjfgh+rP27GMtljEv81DaYYDAlcso=; b=YAGYiVZpJMUo95qnX0TiryDV21
	JsPP5Ngwk1oJmKOHkcAxheb/w9+mqvQrlPLlaMgJrQZ2cqtaWTQTgLJQffYu+98ZDevkzkWRCRTrn
	sJfV1A4tLkbxOCwlaR4w/QQUwsvnjfUdyeA/66lYtBY/Fxw78yDc+l9MM7/ULci1Y5xg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOrwH-000000008RG-0pSY;
	Thu, 05 Nov 2026 07:31:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOrwG-000000008RA-2uJO
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:31:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dgcqswIPsxn1hMkGJ9+VWwqrNbRsI3nYAjWHyKmXU0g=; b=PLrJqIfPG4JgaHuJBqypXD9H5/
 HyPO/Te+edWkTNvOdJuPKKKxhLjWsKUR2WF9XlbABRE0Rz71Z3LzH7cXLZ06ZfeHiMuHty9zWsqeK
 zOp5SUPyC9iR7vWdPd1Jhi3pMtAPhxQlzUvkPed0IcJhLDL/aSNRX77XLHk9DZhaag/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dgcqswIPsxn1hMkGJ9+VWwqrNbRsI3nYAjWHyKmXU0g=; b=mC9SVMvXzoM1YFxtT/mBsRcCZC
 lhQJxB7CLWpTEohblAYJ7uO9Iy9XwIb0mADhxto2lNLpEmJXE7u66SpDgguY0NzFrY28sm+WdeuHQ
 ujMMP8oefx1inyj9dU4bKcQ9oBSbGxsVa0Wu7NGEpRW0vQrvARj71BuKVEoPPLhBglIo=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOrwD-000000008Bu-1kH3 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:31:12 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso159155f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 23:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793863863; x=1794468663; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dgcqswIPsxn1hMkGJ9+VWwqrNbRsI3nYAjWHyKmXU0g=;
 b=gJ8L6pAY6rFGWa5B91/yk6EXcgKfgGJnfrjOElglO/fdmeCkFJUaWK5Kqjbuqdn7vl
 bYBQ0oTb+ghBZLAN0U9+R/6xs/q4OtPrrgp4P6HLRrXp/mxxprXcnLRKIgSwUD/K0weo
 5rplRd7Nn6c8ZNktj1URT7+RsKk+VF0O9nMauP6OUpU3D1qgPfNSvjprdvQrIIJRAHS2
 JtkS8UZ1v7sePMSjkAN9iPyMbrTIf247Y21bxSJcQOhq8FWN7DOACv5EZ1oGZwom0aT1
 ZOFAiNWSWcxiE5MljR0/QNSgF1u1LgG4pNF9YUrHsPAwQFFgIKVR/HrTyx2km0J1BcUG
 l3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793863863; x=1794468663;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dgcqswIPsxn1hMkGJ9+VWwqrNbRsI3nYAjWHyKmXU0g=;
 b=zzSQm6Uu9CyDMowV0xLd01GAM7KUNlA7ZpQpopa4ka0jVIuqRLk2i+Y2ZIiph5c8RO
 8VPX8szdBh5xwMaz5sl3eow53DT07MZSfMBAGFadn+P3NrIAQDhECZgb5KVrbKkXHspL
 VwwEMZufEfmLEtZkcjKhhF4xbH3nLWkUp0EYoiafLJHfv1dTeIM1SslrIbhgLVrcwY4A
 keMSvEVH0wkTtDBCdULGL7IDBAbXEEttjs8+kHfuHSVncQMtj1AhnqozgEmfr7yGB7Tu
 VPxlewZpr6evKJSIy75hhwJRcD7QB8GmC4arUCiYMdwEEW6CVMahg0l8tkk1cRQcOun/
 88hg==
X-Gm-Message-State: APuU4Z9JkDnFCmb9rhIkGuqT4spvVHqoxrlADkYgWI9Ru9J1NFM5m369
 Y+gcUHoJ6NMnkG+UzTqk1l8YFsKLlyrMhriK6//7yGjaPHruhgKMhwZCcryI0DznJBNc2vyCj9Q
 /ntuklxd7Vbya5wQPPT4g/56RFAFHxHHRr+4jy4tfuWUiVzsmOdNVFgN3Lh8u2uEa3b1Gmi9qaE
 gigAAY+Q==
X-Gm-Gg: AYBFou0WG8lmrirbgGN2WETLVdwIwsxgVGTb59CECpUFzz1V0wNZP/DxH49zsI2ztOQ
 u8P674uUz2x3m1mxWOVEUp1JIILiFsESO/97Ez42/YT4oC6OcX9fG1Ln0+1vAbVok5PgP6ObVZ3
 8WDfE+v13YeRvZa7MOThx5RRipbyZaSEevh15XjZdVFfXLxwto6wKgcow3LR9ssC/rWQ90Z/A1Z
 p7GGof6X5OQJB7RoTozTcRtPAc5EMFZHUM9vZWvcjdHyF6x5Fb+iPYLWiKRIveaNvRjlOrjKFsV
 4r6cY57hR/TH29wlVQEt7BiIjcdJmbi8NCDegGtpI2FBYEzDQCaCldJoDpr1Vsz5iTUnHMuGEF1
 umOdZ8FjjZBhUYJdnf5LaZi7zzr9sWNpPIYKb1q7TtDeDQtAQDjnuzW4eZqZQc/vh8iX6xy1Nm9
 Y/x2RvzrbzG8q/2nCBij1AZy7NOaPYDrGeoL788ZjCbcAKwSUMjRaGFb61WoKlb4s8DVIhFLDhZ
 BmiRTwsg4aaNXxdC8/lfAyys5+tKnEXAqFWsEohW+0Wb5HwwQQhhMjY4hS3SckHSCeWhYEn/cyH
 Rky4R5J7K8cHJZWTXr+jY2JB+hRoivktGj8H3epoK9SfCeuoVQpS1RYn7zMSt/Rh9dNmRqjf32A
 YpITu4iYg2vQxdm8bKurqMlIli15Q4Kdgkzbh82pKdh5ovrT7iuoymVc7/gaJMbsm/54FvregRK
 o+6uVFDrc49ArQowPVYzucxnrID5rq7Bi+YDs=
X-Received: by 2002:a05:600c:2945:b0:4a3:5d64:e063 with SMTP id
 5b1f17b1804b1-4b5607d08ddmr20941465e9.9.1793863862638; 
 Wed, 04 Nov 2026 23:31:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d7f7sm8671120f8f.38.2026.11.04.23.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 23:31:02 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 07:30:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: ddbf72ce8b80dbaaab4d1deca12cd40031e34800
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 07:30:59 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f87ce6ff3fb3683969d50681bd114a21b15a232e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOrwD-000000008Bu-1kH3
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6093726174514435697=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6093726174514435697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MGJw6JqnqVA="; charset=UTF-8

--MGJw6JqnqVA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Ralf Lici has posted=
 comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2037?usp=3Demail )

Change subject: Add python scripts that d=
emonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 6:

(1 comment)

Patchset:

PS6: 
Sashiko strik=
es again: https://sashiko=2Edev/#/patchset/308c83b9394bb374da3a22f20f6a38e3=
73e98a5c-EmailReplacePatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I695967524bb9e83887b8c07d=
0d09baff6e41acf4
Gerrit-Change-Number: 2037
Gerrit-PatchSet: 6
Gerrit-Owner=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set=
 #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 07:30:=
59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--MGJw6JqnqVA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Ralf Lici has posted comments=
 on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #6:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Sashiko strikes again: https://sashiko=2E=
dev/#/patchset/308c83b9394bb374da3a22f20f6a38e373e98a5c-EmailReplacePatchSe=
t-HTML@gerrit=2Eopenvpn=2Enet?part=3D1</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail=
">change 2037</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"display:n=
one"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Thu, 05 Nov 2026 07:30:59 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>

</body></html>
--MGJw6JqnqVA=--


--===============6093726174514435697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6093726174514435697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6093726174514435697==--


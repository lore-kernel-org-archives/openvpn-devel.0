Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A2606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BQeEK3LF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hWkdBRxi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Md1DNct8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gi5V4lfk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5p9/ogM23VCigaCW/kocjWusw73wI58yDvpGoIDxLNI=; b=BQeEK3LFUNNaUmd0Z9VJvjaPkL
	BjzzdNO0f+PBx6lEMbwzeweyVVbRf2ptkPPIg4tAKZXB6t48nk6WUh2dclAzb6jYZviH9RawYxR4f
	iR4Fo+M1y8j/Xm+dOUFhJ3fV3ksemV2SYPHaC0Ya2j5D+PiA2H+EEhsHPMaDHHj6aUrg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZ8g-000000004ef-39Rw;
	Thu, 12 Nov 2026 18:03:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZ8e-000000004eY-35zx
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rzsOjbr0QokzHhCXs3sFJsBlk5+3/885yiGQwKzwAwY=; b=hWkdBRxi9cZkK42fIVHooJBGml
 8z2HEL6J9Ezd0JiN5SKVQ7QvxwU2suCwFvnXBA+6E44h0pihhhkcrYoyKiYd6OML/JmCJDC5sixS/
 0EsNy4p0xQojhJZYCsuBi/jiM+WeDO8rTd57zDuRps+69T+08JFI7dbbrcVPssuqQCw0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rzsOjbr0QokzHhCXs3sFJsBlk5+3/885yiGQwKzwAwY=; b=Md1DNct8sLTGjB9ktRNex1K163
 SXXSDB+8xdO3PtDCFdzk/Rm0l+RgInVd5y1CRdV95yoBfsXqj7abHDuyufIvv8ccFZaJXyp53BjnH
 2K5hlvdnvEeb1SCqlSL5GDfhQXY/nx/vNMHJv8mfWLJZP9MMvVgCq47faCxRGDGMql1A=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZ8c-000000000P4-080z for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:03:08 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso788845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794506579; x=1795111379; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rzsOjbr0QokzHhCXs3sFJsBlk5+3/885yiGQwKzwAwY=;
 b=gi5V4lfkdHE3zQogSYcllZL9+QY/NzYkzhdULNme9/uGeoHwFujlfyEAXQjV+gSmDO
 e3y9A49+QgxiPPgoC6mfF9hqtfI3qIz028M6ql/c2XCGZA4GthCZGwtMQzvexucJ8vlQ
 1jVWGOpaqvSBJTs5T3xtIz4pThdw5LHiZop5/0s8Fp7loFKhU9Lr2+SR3WHW/rGAJejB
 FOKn5LTxIWuK8e277cfpZXFM704fnwxugwwLlXUDnu7nVUvO4DHb/cwKM4zSc78YB6Tm
 35OOnUTFqrVJ8sdgKArH0TLHZbxbzAZuK+ypLLjDt3Q1+b3y5Tah4dr9L+aBE8a8Witw
 qIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506579; x=1795111379;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rzsOjbr0QokzHhCXs3sFJsBlk5+3/885yiGQwKzwAwY=;
 b=ndhs9NIUyL1dDk645ELqYiASmiVEYKRk5AwyDUAFbVJo1Q2I4eBwj947goghmpGHtL
 qk3cXybsw/3BAO/HARr/0vlfSNQbYePzo9Pc7ZgD+bGwoKRn4ZdKJgezwARUvvPnWs8a
 RpJfF0wXJJlSCgCE13RaSzBpDF8VEAoAGaz2rOIxeqmJ8RB99gm7xewT3PWdousRyXAW
 RSxGRYR6upnZN/MWZO20P8iniPdcUv2dorFptmgXCxCgG4Obn7D6PvrsM7xElHczR2Xk
 kEClaaP8aups41/sWIekaCfPxiliR58naW3Zamy/31QedytjIhMk6DiwwGozUBvTgD+1
 WrBA==
X-Forwarded-Encrypted: i=1;
 AL+hErHGGaNNJ3enCU4hAYmLhPS1+QMiWKTEMP5sdeuE3DLfcn9r/eAjvqBuig95J4jN7YadCvJFIBjdWMhcqKYg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/zFexxO/xilmBlAmpKtINo2CvNs3iFn28qWt1JRFv3bh6jj1hD
 /NTTbRFtTR6aayqonJtq4xpckK/GMw2No/803hHj5xEegGT6KLzfcX9bmJAmyqJsMYDupwu/UMt
 BHOuRojxz2OB6YGhGCjs3oMrwsP5eHZ287LTiHEJjKFMSuQNgKoX/bYE2DacnOGiqTibg
X-Gm-Gg: AYBFou1XWXr3/q0nNPrS5tDdt2fb3dbtw4gbXFQtWweCTFECmO3zl3IoPCBZVrzIUKm
 CXv54/za9ZglgjWIWCKf373j1Dm/aA8wW7yVWGmD3zQ7LMfnarGZ5IjPXtnJZ39FtKtXdM619mP
 4pxX2J8Pf8jO1J1xVNIf9Ky2y+JCYvK1Z7+fg/aqH8odP9thuBlKOSpqeTurXAuKiNGSKSypcKI
 oim2RUJzedSF2WtG6zgfR1bjkUDF8tDYRbMv2sXH5tId5FqA044Sz9m44pbQu64lk3V9sYaKIOR
 +VcJzy1UFHfo4B71rpj5yn4osmZaR1Yx10Cs6UW619ubhMCYNXujrhKy0DwvQZhasrMBRHZa9KU
 JHv0hlIIhWBvN4XRV6D33mitZCpF1N9edMnYF8skmrVX40FmE/M/sWSzdUVV2T+ezql1sQOl8D0
 Zxw/fUMu3aUNEj3ka+bIU2MXWAa2ThOhW0xgj4PQ0YqAzofpHAhspAOxZZxpIySTynUR8LMrx8f
 PzHUwInk+dXPFgAw4FLH6fWx2SPFN8T2Qxe5gC9NTJolOW3jKCem4xPdKor7+qzMVG6damS6zML
 IGf5gHMKGM0NH3uvnHZ9ATRVQ7CNbeyFyEBzlYwPnISzGouR46fZHXGtg/QAajbGKjWl9K8sw+A
 nggIZALTEgfqPYGBKXJcORgV0gl3N1lFqUB+kAjWWtj6CUEKPuRq0r45kTNt6oTOUdAkV37b27R
 UlxyVrqawKAj9DU1Ku
X-Received: by 2002:a05:600c:4f09:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4ba09383b92mr129570265e9.23.1794506579245; 
 Thu, 12 Nov 2026 10:02:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbfcesm72848145e9.0.2026.11.12.10.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:02:58 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 18:02:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: a8daf527aea3e6b2ba8405f3fd2fb14b961414a8
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 18:02:57 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b2c839363725b75cacb5c185e6ec9e776168da3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRZ8c-000000000P4-080z
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7848471411554034470=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7848471411554034470==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pd5iSJUsitE="; charset=UTF-8

--pd5iSJUsitE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Heiko Hund has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail )

Change subject: openvpnserv: reject a config file passed withou=
t --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 6: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2159?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 21=
59
Gerrit-PatchSet: 6
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko=
 Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@m=
andelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Thu, 12 Nov 2026 18:02:57 +0000
Gerrit-HasComments: No
Gerrit-Has=
-Labels: Yes

--pd5iSJUsitE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Heiko Hund has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p>Patch set 6:<span style=3D"border-radius: 3px; display: inl=
ine-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Rev=
iew +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
159?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding:=
 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9c=
fcf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 18:02:57 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pd5iSJUsitE=--


--===============7848471411554034470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7848471411554034470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7848471411554034470==--


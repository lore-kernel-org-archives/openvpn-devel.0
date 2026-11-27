Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A80606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fl0NuJZ4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R/+f71U2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Js+cfnDX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bubJneT+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xlRa5Xieqi11pgKba7FcveoRuAS/VeX3K0L9HeS7pwE=; b=fl0NuJZ4iMRuqFL8OAdDkiYUYi
	5ApWP3dK8NO7Sz4YNKMLrpmlHFES6QByFuFsgwxg8ryOXGz63TtWiOhnlCuKequKWS342XwRWdM3O
	h59TVY62LeZUumEiq8kt34cbCDLeIRHxsHr1f8tMEI2qqgoMesgsanXqqhxo4sisejvU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWufH-0000000042E-2vVS;
	Fri, 27 Nov 2026 12:02:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWufE-00000000427-2Xet
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N5HPZE+icwszH/HSmzIl5mAr7aPjx1mH6Om2vtlcT0Y=; b=R/+f71U2+dHGYTZhWQlbgpRVN2
 luNPtO+fv4n3lFCZg/pgICJw1cwTvaUKr/vJO8/k347KeDszdyVrOd1oF7pQR7FdSuYDZq/f4jKne
 3axfZTRbKY68SUtpeNOzhVBk3Tf/nPuxpXrsLSmEo2puQ+IoTpXbGvqglPbFrBvK/Cak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N5HPZE+icwszH/HSmzIl5mAr7aPjx1mH6Om2vtlcT0Y=; b=Js+cfnDXCg+wO4Y7xzEMxoOdJI
 HJpE6whzw0HCc7UAM8zwDPaocoFJKv/H1InmGFaKNOAZ6lwPAM6HNzWxAXAflerwH5iakoLf1X6fO
 ACZVrlNsAcUgJRJw4QxLg/gLMuCl4ldXrnHRZG8xVzFYK6X0tZFe0M02DYADQjVTSH78=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWufC-000000002mK-02ug for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:02:52 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so68917575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795780963; x=1796385763; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N5HPZE+icwszH/HSmzIl5mAr7aPjx1mH6Om2vtlcT0Y=;
 b=bubJneT+MB0mBrjzkkKuaBGR0hFZ3dS0Y/8f7IaedTj53RZ8a2alaz9hXmkRwqQLFY
 JW98sQlTgPCcsPxs32rfwm/xAjbe4QUtgWJlzW97RCTlHMVK9VTsxAu9M07X9UNngZ3/
 vRDGONDL7zSCVBEPUAgj57KjbEiaHDSUffOsoNT2XihbMwvL2n/IwhrKh32pDqLGQ3wa
 0YQC20P/pNleKAH++gdNByegCc1v1vCzUPBDJCODIaL6TSFpi0hDqezMmMB5li0XxrVK
 MX4mHohjGVjjy7LND8sau/H1GY9zzSl45+ZnijuAB7jQbtTB/5SEga8G4hjbyhwwvrUR
 D8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795780963; x=1796385763;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5HPZE+icwszH/HSmzIl5mAr7aPjx1mH6Om2vtlcT0Y=;
 b=uei8n3rFlScm7yVc4Bwzic2teOjcqxY2nxMElFljY9PYJ7JcAPLY3RYQPwkH7WxREG
 VnAsKarYmblkjUOTdoL8WjQWnx1WfIAuspLSahBPSVtl64TXoo5Bg5F5RxLfe/vR1kZ5
 rYMpw4/8A9qtIzDYvgfDp6yG5AiyIAk0ybG9Ot3Nk9zexeYnsgg68qpitO8hw9mCgteu
 lVle4f2BaIvKa3eU7FtlB7Fw+yg/9D4mKgutSxyKGWP5jDVzbBgVKZKNwwlKviF8hUq6
 lKGNRO6vRBmlN5j2Qguh1A95pWD5v31QVw1oo6OkcsCI8fcC+cJIBwQM7/bc5VotEIbI
 gfRA==
X-Forwarded-Encrypted: i=1;
 AL+hErFty158PAO/sF0vPjOvS3kFYddjFHVhFlqInwWMmoIojZxe3MnEPOgoHE29e+AhlVO9ccm/LTgC+yPUC+Ea@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8pdR4r3VHYVkDDvetjBuVGpMDdHeq5+c5Njt3/gOcDSLHFYCsg
 IUDlT4ncd8JWNQ63/8J6kLpICKN7wQMeOErAN1CJ9QVUacMv+SMAvdCXLS/8LiEj9RwT4D2KfC8
 2FbXSwOpsyPdcAATEZK65HR6I3tMefI8b1FSHy7uqwafdkpj+oYDCD4zNF/9XIuZzBJOZ
X-Gm-Gg: AZFdTZcKBLHfpcJ1f4vNYzo1C+d6T0fMouEc+YmUWS6KytlfCVpW/k7gQo5IAHyDHs3
 FF0uN2e1mLQMWaI/d3W3AbIzbbyWdb0I0aDzYQf1ucPxeYFXzHSBpdzKTYa0ugDTAWYyQwuxyEE
 NXhSXPWSx1qOMMY09+gdn1/DutN3+CntQt8wz5FOgCnynNvQv40uEY70DZEryJID59fBwxcP7zV
 ynmbGZKRJijdA1T01yt4hobRG/7eW+FLyHsYr98tO20WuucGfiqRQLOiP4SvnBIicZMxXbK0jFz
 J1bF4Ab+3EZ1Ks4bM7+XLPKwuwwaeAePfmkVmsuFNJt/RW1FxQl4Gonlzna3qAbSwEoEeto+Xvn
 2eAjQwGwXN9bXDwnBZ5c5W74Yl5M+U8SQfeOAzhbZqwSK8hAa7mpGEgADwHtDgx2neSlI7JR7+H
 jtOySnZwvnOrjJ44RoCEyvNDO4PF+O+hQbb1crEQG4OSO/y4xMb4OefajQ/x+7OloXtm6Q8Cz6/
 syWXwfyNGmOUg+CfLUaWugX81wXwB/lgXtaWj+eKN3nPdElcppfEPwIRYu3oOP0jl8UcaE/1E8c
 BCpigBuqszT9s2V2VBhob4bVbYqUHrahUdStEj7EPPokIxdXOnqSqkIrfkjz1TG9r7Kt8QqrS23
 QUpwSrZ9DWXZ9EDL21cAPtHK+Yvkn19YTx5xJLEdZ39d7DpdQeZoaOrAIJ5s5D938uwrmOhQQCd
 2q0qHlI2azg2bn2a8=
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4bb88827db0mr522817845e9.30.1795780961787; 
 Fri, 27 Nov 2026 04:02:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm651059335e9.2.2026.11.27.04.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:02:41 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 12:02:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: b1a80291769a90ec1763a5b2b2120adba051e3ba
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:40 +0000
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b73e7c9e334f7955fd4f2e43dc06a75b90d5e069-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWufC-000000002mK-02ug
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0172330144450744520=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0172330144450744520==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M60jvF2Q/8k="; charset=UTF-8

--M60jvF2Q/8k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Deri Hae=
rudi has posted comments on this change by Heiko Hund=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail )

Change subject: dns: pass =
dns vars to the updown runner via pipe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+1


-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c4384=
41
Gerrit-Change-Number: 2348
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <=
heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenprinting@gmail=2E=
com>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:40=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--M60jvF2Q/8k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Deri Haerudi has =
posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">change 234=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie=
0d772af38b66799499b1b5729915ed77c438441 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2348 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;he=
iko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenprinting@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;=
heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:40 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--M60jvF2Q/8k=--


--===============0172330144450744520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0172330144450744520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0172330144450744520==--


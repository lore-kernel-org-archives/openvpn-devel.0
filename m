Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E936606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aedSnPzM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RJFpYuAd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a5RGa8ai;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PRBRXUg3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MJzEC/iJUOF8zRNDDVqTU/SvR39uznP6IGp6nAihDtU=; b=aedSnPzMqXpX0E/fxiTqGES8J7
	c3XcEtyWR+MumJ0iUbfpE11zjnTcw3jFR1JdIw1ZFamSnvLQSpvbrhedVlAQBuOPWedarv0cWuMkx
	L/1vrg/3IGs5yhVKgAJAiNb8Ho0zLHGpjjshhq+r5mhGd3jOm3LOBpn+Z0+ovyXXJAu4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNI00-000000003uI-3LBL;
	Sat, 31 Oct 2026 22:56:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNHzh-000000003tt-2OHe
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 22:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3s+JXSElMR68gjAY+n6OXV8TPYIM8Pm8B6kG67yFJv0=; b=RJFpYuAd1SFUM38nEA6+NWMOwy
 7Arl/X9VHXwGvV/kiXiHcLCDxsbdgJ8wMFzAqFdd7CYoNpXcZqcETgohIxHZhsm9iA1rxsPunoBan
 MfD00+C681J3YkSJqaBoa9myNNYbaXD8Y9qNlJhS/WDvGOLSUn7Feb0wvTVTPUqS9oPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3s+JXSElMR68gjAY+n6OXV8TPYIM8Pm8B6kG67yFJv0=; b=a5RGa8aivUNcaJ8Iy+80tilVhp
 8bnz1m6j0wsjjcaM3r73i/s+b+xZMxebY4S3sRxfi5yhazb8RDd0tt1+XHQCVXDtPpHHFL7aUdUVa
 tucknq73g9fvVEEGVwN+/ccxfgewNGxd15UPLCZiVz4p2MNoBCOZ+GN1eRxJGnsS4bpA=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNHzX-000000005DN-3heW for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 22:56:04 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so14155265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793487357; x=1794092157; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3s+JXSElMR68gjAY+n6OXV8TPYIM8Pm8B6kG67yFJv0=;
 b=PRBRXUg3fQDjev/D8FEdiLSAgHhu7gmEBFbdotkfe7oaUWbeEF1t91PztctVp10sOq
 wuK0MT/VvxyS+9L7njvi0NG2Pcg4zq1jO1HgrST6WV5wD5A4ZlYeEd8ULHgh4c+t1SjW
 a+rFcbZBjMfQmpCuLzE6yhi+OgFofnyI32Jx9JU5gerz0OrC+G07qzx8k72RXWRhY8xl
 QAaLQa20yYICDip3syIlPKoudUld70u+rHJq4FqsGpVPSTgnbs0Q7rgVe4byENCOWq7Q
 RFNyKtvLpb/V1+fWF+zKnF9C/8vhZRBNKas0nZPpIzvw8rD9suSZ8ULy/jDYYfTDeAfF
 keeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793487357; x=1794092157;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3s+JXSElMR68gjAY+n6OXV8TPYIM8Pm8B6kG67yFJv0=;
 b=PkAdG0oIq69cRxflmGWo96OGpLqsDjvIf5dQ/dDmhN4cMlMRPblo9PGLm73M7c5DBv
 WL/4zodjT33JLxmbhsPXYrl4R5QBI8EBNYPC63Pt25kwQr69y2T0QcNst7vG65Zlz241
 fIjtKaWhQ1t57l6WkTJFeToc/jRmxNoDnUtp6NGmZCFqiz6HiGu0ZCCmfr5hfQROlA55
 VBd1SGBj9Urrj9I98gU750BwopGuZAaYNhAW2LlfxTphZi2WVV0xFdWBvd09XwV/jHjG
 uw+OdCm7GVMZmJieOLx5HqGgUMDZ7Xx5eo0HNbaKWNVcMDQSpW9CFZBRaGKTE8DtX1Wj
 jA9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx2Y95Job4XGo9ZaXDqrhffF4jEuPRAnrP6GIbrZ4P7KRes76mgjYRI+OwxriduNegREFuDpucate+Pjhx@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLXXzEq+3rIggSVV40dysRKoecLRHrxBm9grL8oWt5rfHSJ8kPj
 X5QwYYpT4uU6gbtBeCt0vaFJUBPBJJHdS8I1lnJTlD0PFQbB353ggROgQKlxR4XX94+IId1Utx4
 O11aPOUmQpCKMvQha2pYNRhJLO1A9Fm/6mVm6tZn2bBvinHO3iZenpWL6su8gQcBjx4MX
X-Gm-Gg: AYBFou2CmiiVgb37TZC65CZ15Q+SBLrA0oMgAjRFrPWvHXeZpJxyybXrYThE5REqt88
 05bvoEO5f9ph1ZPwGYPxr4NFSe42SP4QLTk650mv+InOfg6lexndItPSY+5Me5y/d1R2ms1fhDN
 sdm4eDYEdFQVuBWYuXVr9ZjaBq4KDKmY5hPN+tUkoY5W2Q/qcld7Up3q/XE9kN1WmMtUWPBdzS1
 rjAreigbkBXABGXm6z4EhIysl5EmPNu/UevcrGtpMT5TWvNTMKqRivZjP/9wl+SiPyuOtDOq+Eb
 cm/sDaHLv9GYWGT6FpfYlFnph1185kEvORdgFBA0TXkbOrro5iiG19T+YVMhT7E6Jt+dYX7G0K4
 qei/u1+DJHj3paieBZ6ZG/Cn6SU7g9Kb2hi/n4yHe6XufZUV4osJRrBImD0f4kBSogk2k3tSd20
 Dp0fiL5QSxoUtuvZPaZBhsptaQB8OgKEROOm8DxyWmP1S5iAJ7rm06yt/5TjiDfSEimlGS+HmRC
 US2OxQoYzijSPwiO6MANIzTyjKR65IBK7KpxbKMAOse+cS/Qho9oKj9kfwKOcR+OnejbwrV/vE7
 q64JFx+HNfK0lClR/UZpPOhHCi4CSY99psyFbSoQhmK7/Y/gKsU3w446WXn9LEstF8TR3y4WGg9
 HFR+gUiCgC1Fr5hOJNl6kdSA4JeOHgzWXnqiqrCSndySClG0RoCJbXxnBPZBIYvhZBCiVNnsyeF
 48tRSeW+fwiLnuLNo=
X-Received: by 2002:a05:600c:3144:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4ac17ffb31cmr137211595e9.10.1793487357176; 
 Sat, 31 Oct 2026 15:55:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm234468785e9.14.2026.10.31.15.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 15:55:56 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 22:55:55 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
X-Gerrit-Change-Number: 2016
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2016?usp=email>
X-Gerrit-Commit: 466d60c16156bd249281784e4561e96dde2d2afe
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 22:55:55 +0000
In-Reply-To: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
References: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI5MDA3MDAwLklkMjFhNmIxMDZjNDlkNjY0Nzc4M2UwOWE1MDZhZGQwNzI2YTFhNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a5f2ca0c7a75a68eb34ac313ccbcd9788c25a2c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNHzX-000000005DN-3heW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: skip
 conversion of empty domain names
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 selva.nair@gmail.com, openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8618794048134795821=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8618794048134795821==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CXsoL6TlbLQ="; charset=UTF-8

--CXsoL6TlbLQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, Lev Stipako=
v, Selva Nair=2E

Gert Doering has posted comments on this change by Heiko =
Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3Demail )

Ch=
ange subject: openvpnserv: skip conversion of empty domain names
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id21a6b106c4=
9d6647783e09a506add0726a1a6d2
Gerrit-Change-Number: 2016
Gerrit-PatchSet: 2=

Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-R=
eviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Selva Nair <selva=
=2Enair@gmail=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-Attention: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 31 Oct 2026 =
22:55:55 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--CXsoL6TlbLQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, Lev Stipakov, Selva Nair=2E=
 </p>
<p>Gert Doering has posted comments on this change by Heiko Hund=2E</=
p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; =
margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</spa=
n></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3De=
mail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016=
?usp=3Demail">change 2016</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2016?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2016 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Le=
v Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Sat, 31 Oct 2026 22:55:55 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--CXsoL6TlbLQ=--


--===============8618794048134795821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8618794048134795821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8618794048134795821==--


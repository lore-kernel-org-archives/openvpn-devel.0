Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D89606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jmGBC4cX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FEYWnzHA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UQm/nUZd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CyGCEAFP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X1cg5qBCZAfHkXtFGaoNGJPnTMAw7cYd2n6BpHeOY/E=; b=jmGBC4cXX57/U5Ou0CQ+jwepnc
	jUDPaMNHR+1wq7nJ4SN1k9YoxSJv0KSCTo7VtuxwD2yQqhg9a4Rn8MVH/w4NfiU45sPCNKSERGde7
	eMXzptl8oPr0fQsiwopBpeD91xw7KDqZlAp2c76jBsZUoC8lSnsOA/qSSZY4rslmzJTw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKKc-000000001U8-3QMM;
	Tue, 03 Nov 2026 19:38:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKKb-000000001U2-3C9S
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0qvFtEdS09ucZNanszhdAcweRNhmxVyDAD14VlibTk=; b=FEYWnzHABWPMGWL/Vnoix3DkbV
 rfvTuzEKEE3Nytjh56g/np2SpB/UB0HpySGQt7RuRwYeyrSPt3rLb+YRRq5Okax/zXP+5G5aJ2CiA
 EKmn2qD09QR4FQ8z149AWkyOyaxdhDpeLHYg1izciKUqbc6RU1udH//G1p+Q+4LjRZX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0qvFtEdS09ucZNanszhdAcweRNhmxVyDAD14VlibTk=; b=UQm/nUZdl8yEBUDZpoyp+N9n5e
 JwuuHrp8kmLBFfjeMqtL8k38hoxCtTZEmJWBx9XrPF9KcrmC1f9UE4fU1f3gdxtziPWjdVFzOU+gA
 UkPWL1k1cKclkoQ1gVALAI2zGhKBKnfGHr5QYlUCUg0VE6TBSET5CBHoJaBZlKOOt3RU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKKa-000000004cQ-0hWB for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso30817675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793734678; x=1794339478; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I0qvFtEdS09ucZNanszhdAcweRNhmxVyDAD14VlibTk=;
 b=CyGCEAFPqSVXlpZj0Y88uj8TOG8Z/37Cvumr7tm84SXRzV47oO7eXmfgIYYelWDquj
 0oU/NjZ7hOGY619gNLCp/Us0nN2L4ikIUdGzcubhLMgsyXWjN2lQvIHaPddHSAVlKlVA
 B/vvJXGIbpvXiyq0xB8Mwnd3l8SqVTuE8r8c/Uf0KZ54jxfwp+EbE4moTrDyvW95w7nX
 D4jB2PvVYSeMQkyBlNQJqtahYdD0+ddavq8P1gT2NNChLNQ15P4Pz7nWKH4VIhnjdEzC
 scwm9sJbFULgrBZ6j7dX6vcPakX5Z1dNqjQ/LDLBDpgO9l+bY716Qn1gTdT1mfTYbG2F
 2iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734678; x=1794339478;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I0qvFtEdS09ucZNanszhdAcweRNhmxVyDAD14VlibTk=;
 b=EiMomvYOYfw/PkBrRhxxAzCapoWc1CRLFaPJGgXJG3Wn5yPbtvE7iSI0TfyigH6Aeb
 ODi5uesLWQp4qwc+6lM7gjiP1xxU+h7P3fJuAy74jZEDl2OYFPU8ys+3bLTlpY+tYOQr
 9aWWOYCMxTw2YQFPdv8y6rxH91jethrWpVq3SEa4v+VtZKTyj5cN5TFXYZChV4A+x+Av
 pbxya5dvget0TygnrsJnhZNaNBcCOBZRAULakEAdphWPLIWVFoy2Xv5gSlS8kcl8FZ8O
 HBlgO1KrO36N5cj8IDfE4E426EHbHhJsmggyFmzedcVLduo7KrfOm4d6Vt5/wpt/fZe8
 23hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlItoCrAkjVTIHDvnWKSxaOP3nW/vCG6u6iThQSemTU0nws2NoYMLKyyPiemB+NO79/60A/sMadAqQbHsq@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+wx+wOKjipHduTQd60RJ2n+bHz7fj5jHa0ONQ/JU34wI5wKl+j
 bKEVpPgKmT2WYX2Yj34KENXcYplPJS7y7Z+FXRp+FkoHir+RSuX4MtxgpHYbOs3mpTbDfXBtr2z
 5IPqoLwq+XdcZ1kGhLErkopJxsD4SMI7n2EQ9ox/JJneybPw48t/CLJnRyaoELB5hNMykexTZvd
 NYOeiQ5g==
X-Gm-Gg: AYBFou1ZBBczWCdboccBce92bmKwkV8wIBu75e7xXSf1J+7mteqgzWYHc1PramYVpAp
 naFqKzXulvSpw9vQFmvfhbh7Femod+1Wj06mOt7W3MkEWC5nf5y6Km1UWwI7AKfg06qmcwwfmmj
 ms5wzGsz9WSF+vgL+oLw94WN5XEsiKy/htCmwqbmlsFYO0m82tRody12w4jkOA2rZAOZsJjPaC2
 +8hPSKfopZ+uQ2n39VeFMaI3Uxm/X4S0l+ZTX3dMH+PCCovCx/x7WeeK38jL53ZwHCjMyjznEwE
 06wUE2iwgkUrcWuwo1yC8MskV4xVFTfE2JACMVOsVS0tDMErCJPojFcT8ZCAkfpPjBI+muLYbq7
 9d9ZY81lebJXQY9eziZx+Pw81oWdeZaahW0syedhqApPgQEp7SedhUQRueocC1TC9vYZTweR8SI
 k4GVP3vXz54OmZbF6ymZWQINkRG8MiJj8zrLpNRAcA0rG9oEmfOIbPTN0JfHZT6lCA23F6zxPZj
 gHMFymMab9FZ6O5rGB8M4RasNPbpTP6Y2bVwSXq+5kdnx9CdOkLhdeqB4EhVaJ36OoR4Vgs4flO
 ngr7R7GzcnUBoSgOTen8FwF0T9qgV4+0/aXERTUpwO9FVx298e3QAzyEZR7SrnuKd2VEI0QQ4a1
 Wve58p64FHGirTHpJc/e3dQDL2pQbilBae9XzMgNH67SdQeN1NuiWVYiG9lPLeNbyjh6kpHxL2w
 zPhZBxvW+fJsufPA==
X-Received: by 2002:a05:600c:4454:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ac1794032cmr331118095e9.16.1793734677427; 
 Tue, 03 Nov 2026 11:37:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebdbsm88256635e9.3.2026.11.03.11.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:37:57 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:37:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 22604de59ef894681fe6056bfcbc90c4c6a9fda7
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 19:37:56 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7e0ba0e4c60da9dc8b892e3b8256b76e5de500bb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOKKa-000000004cQ-0hWB
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0650569920502090732=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0650569920502090732==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kglvsK8xW2c="; charset=UTF-8

--kglvsK8xW2c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate using the dpc1 ACC protocol
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(=
1 comment)

Patchset:

PS5: 
> Pasting here Sashiko's findings (the AI bot =
accidentally picked this patch for review): [=E2=80=A6]
Done



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c=
350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 6
Gerrit-Owner: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #10=
00061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of user no=
t set #1000061
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Co=
mment-Date: Tue, 03 Nov 2026 19:37:56 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: No
Comment-In-Reply-To: Ralf Lici <ralf@mandelbit=2Ecom>

--kglvsK8xW2c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1860?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Pasting here Sashiko&#39;s findings (the AI bot accidentally picked this pa=
tch for review): [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860=
?usp=3Demail">change 1860</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=
=3D"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Name of user not set #1000061 </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 19:37:56 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></=
html>
--kglvsK8xW2c=--


--===============0650569920502090732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0650569920502090732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0650569920502090732==--


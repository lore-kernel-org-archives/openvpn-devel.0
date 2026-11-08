Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D12606A321
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CrKRh12G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QEhEukC6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ev4oyMha;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=e7qRcshn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0c7s+jEpz8XgLT0UBw9WTuIdK8/7zKOUynyPw6rRAik=; b=CrKRh12GOBFcmnITqRpKbkyLGz
	xuCPzt96IvbaLz9mar8cxTpJAWWeWvZ80EkYWTCXOE3jIfhCExORIMRxB4J0+g+NiLMNppA71ttP0
	buGyzQgMKlRz04JM6wijaDOBIKC0EYLs+Sxiborr7LwBzMy1CiYwpfZj7n23RHmDYDGs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ3Z7-000000007gW-2Y9W;
	Sun, 08 Nov 2026 14:08:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ3Z6-000000007gQ-3Fqr
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 14:08:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u/j3exnqw9UsQ6VdI+guZv4bUbpzyCLY5HpFXozDajY=; b=QEhEukC665jOS2GhJ7JWE/AeAR
 uYj7KfpSlAC6GVmMKV+9WnFA+MDpGJYedaTnm8L8K0Y8+QMW1DlpDum9ItnIQhwryrfCGQR3TnEzv
 96ed0ZMpTUeOXAh7tKCZkjmNwTIOCd4QO3Wqd+vU5ikuwxz3GjYtKMN8D/jElFVlncRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u/j3exnqw9UsQ6VdI+guZv4bUbpzyCLY5HpFXozDajY=; b=ev4oyMhan5X/cnFaechhH+a1z1
 uqZ/U/iMy3s02rX2QnLPsGbg+w2esZ21v5XQhaLHx/J4j/V9i8Ma/y7UYP2c2qN36Vkdcuu1qCjEe
 g71dWjywC0sdczu0f6WD9L9gxvycgiQ8Lo8v6Pog6ASUY4BfhbCwERC3EuRVMn51KikM=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ3Z5-000000004Ra-43XU for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 14:08:12 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso452755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794146885; x=1794751685; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u/j3exnqw9UsQ6VdI+guZv4bUbpzyCLY5HpFXozDajY=;
 b=e7qRcshnOcSsRAz+hmFUck91zXUkA+uv0RwdzoGS4N+WimFNe2Yhwfe9k8DXLN/t9M
 LkM1x7Sup8P1KL2LZfS9KX/FmW3jL4uWSeYgai9ol4clLNr4Ea0iSJrz8qP74rwbmXjQ
 4ZdnPjt4Kg7tgkW3ymjk51wv+N4zLTmDsm5s6x6TViQMqdTkHNs3OveJ/Vbnu4zzdy0a
 VVc31txAtmc2B9rsLjcl4NfF8B6R5ZuNYP1lM+qHo8yMdNmP9KTGHg4ms6BJsk8obSKi
 UhXSGRFDj2OtOe7PJtw9uYVvAiOXsgW90S57HEE7kHwMSN7JVySBv3V9QaGodrvTHCIJ
 lwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794146885; x=1794751685;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=u/j3exnqw9UsQ6VdI+guZv4bUbpzyCLY5HpFXozDajY=;
 b=01UE1ztM01+Dj/LdiQ1IXKpZw30Lj9ZtEgIoxsqGcHOr25M1jwTNH/ILb08ZMVbrZ7
 BNHjaw80Q6JdyTuiawe3xEfzDGnfU7KBAIRRX3NtKEjUvcViGDlUgzh+Il85rK4R/O1c
 JMJl3dpnZQVWVHxeWU+Xe6JS9KJCb4H1QiOLz4hvpdz578Y5wResCb6QKeir9ylErbpW
 Yh8KwZVn+vkMXsjBVohO+Zs8elW9ykbCQ+UhdsQCNU34N5e1IepciLiiSU4pErK9L48I
 zgpdlWEscrxYsgk8xbEeBvYEnOjKoOIY15oQ8C9UnNkEKnS1sDwa9cRjVq0Qwi+5ALJO
 VrXw==
X-Forwarded-Encrypted: i=1;
 AL+hErH1yCkQ+Y5tyawShnMTvR0h2QP/vH1zH0SE5BcWb5RVlb69DOfCuMQz6mBwzxw4IjzpygfIrWUCbe5/b9Ih@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+pbIH/2Q+6WDTcOEHTQ0fKa1wWaKHbfYQy1WJhm28uRg7qpS7s
 p8QwIbpbBvNfxHigSdrukeu8I8gUCO3nYIVSBTVcdNEeEXUj81q8gHfaXNGfvVdoJl2poZJrDQG
 jyhGeolRXHltn9O8R3vJu22e1WV0DWvmS44bV9px8ViNhuCc3Fw348LB3uXK/MIq4eE/b69iu6H
 uLPQaOkw==
X-Gm-Gg: AYBFou1vDXJ7iZTJDWAjN+xmkWtMuaeaZABqjKGJWAymvSDq/u33w31x8x4qZrJm5y6
 Bv2fAF49/ptC2jDJC1ZAGVqDW755JPZohz8MraXJCnU7yUKrhsAkpqLlrE/gAAV0/2DjPzsDyBK
 vvx2Pe9uO1/29GQTxWsaJ60w7nLMUQl85Hi6iGsD1cDIqUgtz6oG9ibpxA8gD1ROKPXPadryfEZ
 EEVDqtK/LVXBZD7aNcmWPdSMkOzb1FB4X4Gk+gkw99F/8NZstu7TxjyZkiXvQJJq2zwGHnM+MFu
 IYfbtmtW03VroQC85ZBIteTAsQxZPVJn2TRJaa1GGyhVK9CZclvKFs5heu30xAS+N58iwhKoyQO
 Xl9yVP9l3TcgPGwg69NUVM0JIl5TayqFbdllWOqig/wGAmc+cXcDFiDE2mItVVvQp9ho0QXs1AT
 4XnheMd8liR/rJLFxgfjRB2D7Ns4MODxqDaw4fBcEjA3W8InviOw/oGJvtOK8P0Nf9hCXfCr7Kv
 1Bc04e/YnRdNTN2yY8jyWVIKZzKHBFkKfdEGRTT3MG+QYoRiRqJMte4Tszbj4Cte5GfhGCVcOoH
 t6K0d4kK7kbbfkgNoN5COcRFzPWQ4ztWv7OC5mvg7uuJzEvr4Cvzows4EERjGf+xiSS4DoTjP/x
 bbKUKOQ+9dchHbz6R9gkkwdxgAJsznbz7lfBUFhzSDKXEpY1+tMhW15WC2gio+rV6lhzACC0PSR
 04jIcd52O9qjJeqkc=
X-Received: by 2002:a5d:64e6:0:b0:48e:3767:d885 with SMTP id
 ffacd0b85a97d-4958a8bdd7bmr3265368f8f.53.1794146885142; 
 Sun, 08 Nov 2026 06:08:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495966f36besm3841117f8f.14.2026.11.08.06.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 06:08:04 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 14:08:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 7c11a0f64236ce99cfec2ad3dea9c08be68d76bc
X-Gerrit-Comment-Date: Sun, 8 Nov 2026 14:08:03 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d96f954749cec2498936e15c2a57aaebe7c01bf2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ3Z5-000000004Ra-43XU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
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
Content-Type: multipart/mixed; boundary="===============3598479768773733087=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3598479768773733087==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MsbU/XVp7BQ="; charset=UTF-8

--MsbU/XVp7BQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2130?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a=
268fc602e916bf54853c950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-Pa=
tchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Sun, 08 Nov 2026 14:08:03 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--MsbU/XVp7BQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 6:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">Vie=
w Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Dem=
ail">change 2130</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2130?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2130 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 6 </div>
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
e"> Gerrit-Comment-Date: Sun, 08 Nov 2026 14:08:03 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--MsbU/XVp7BQ=--


--===============3598479768773733087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3598479768773733087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3598479768773733087==--


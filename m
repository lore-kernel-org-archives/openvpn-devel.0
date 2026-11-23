Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E8606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P10gMRHv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c62cdgqh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iKwCDnfK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OSddE6ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cg3qpybq2VETs4kGPwXbITEdqpbHMQPkKKjeLsX0y1M=; b=P10gMRHv+G2rnz8R6i82rzFwBB
	D0T7asc9/S6ftJatrf3wxyDE/YKMa2nSl5Jnvebxwtccboa3NGRBIAhCRD2DhLLaBvqLQ2OMAupq6
	nMMdmMZF+hbHqfZrMrgMJVYqgmC0i4wv6WkpO/FaszLBaxm73+L7AKkH3OIsl0cCxirk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVPVo-000000007fY-06Yy;
	Mon, 23 Nov 2026 08:34:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVPVU-000000007eB-2pgc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e+w9x1e+x8xch/v3DoFzEUiqiLbnpSFBueyysyzzOOU=; b=c62cdgqh5cFp66yF4Bxw98k3Ai
 kikrWNx+WnQ7V3MFAfasi+y8Vu9lldV9BiM42fNuZrDh/eYGbnXFluF3hFjMIa0PHd7yO+8snNIhl
 m3aojJqrQ4lZaRcp2Ie+SqD1Q80IjdgxjIuoSYxh+LP/r4MvpUVuxlktxC9mMLs3uHx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e+w9x1e+x8xch/v3DoFzEUiqiLbnpSFBueyysyzzOOU=; b=iKwCDnfKdwLBOsrLGzBqeS24Wt
 luLREOdbkZ1vsxo9TMww0oqe1FANTIyrLCO7qVvuAv087ZO90FWC4Jj2pZEQDbTYkPZLvjeGyOcUb
 GZMXqc8GENKtZzFKIzAyPTYPXJtDOF75sAAUFSw2kRLuXEiWR5efcpMURMK0tbyPiJvw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVPVG-000000007Ao-07Zc for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:34:24 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so29621265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 00:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795422855; x=1796027655; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e+w9x1e+x8xch/v3DoFzEUiqiLbnpSFBueyysyzzOOU=;
 b=OSddE6ruTw0cN9KYxvM3bucNiqJ1BIRU+aqmP+6nuuf5866fILZL9xagJHuiIObrpx
 aPiCqOD4LOwmHfAa/mN8O6uSZQIIWQ6ZRFru9WbQeHZc7ZNtqD8kr38C9StDxWIZV9gj
 cBAtJnyEvEEswLB9APYM6yWwd+VR5hVH7eCJ2CKQCVwmWOnxX+ZRUKj9gLJWuGhw+7je
 kwDo0GsHB0SS0IGv/NAqXMRg1WiJh63YtfqSyMvaBRjrxun9XWlRXakAZ+8SUvYtXoFv
 mnTFyfzcUsGepxcGztrQWTbHSG/Bu8aDdv3XyMp25wm7P00GTNVmSugUQ+eP7hqDiv0O
 6mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795422855; x=1796027655;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e+w9x1e+x8xch/v3DoFzEUiqiLbnpSFBueyysyzzOOU=;
 b=vvUvBN9B3yRIbEkHm4DoYQTUlC6cdvV3GRMWyQc54lLteFro7VRv+2kq3qPhQQoeul
 GdWpwViqaUOo62cCdjY8D2eEQdyvBmNwHnEtHqkGDHAA0uZVbFu8lTNachwmpwejfziI
 bdUcB5nFQhsiVNTl9kDvy0JPwwrc/vNp9Pa3xlNIJcKN1GJY7gaOl6k3nwMuviA1XSXt
 vcvXOVLJ9ngwKidAgC7lZo2d941C0YwSS6AQJ7cRlYRvVjdfdPUbxKOekARXByiKazyX
 pTTmjFGR3PxMbiAY07zfGyDVHNEya9HMFfC7HvC7YdoQhEgM5eTWbHxyA03q6ZMhQFF5
 iAWw==
X-Forwarded-Encrypted: i=1;
 AL+hErHdENzo52mXmuxlkSYd4W4d2tbZIGpeP1lnaOSt1VPsmITvOa2ByP5V6KZKloCLcBtX2tHSCOTBovBD9/5u@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/FbVnJ8zCNTrHU5JLXLRN5tdPnhWEc8fo/3OQ3CgNcpdyH1B2d
 6eTDwaeW5e7UKgNi0tfBGQj67UTmH0ytE9QYOQTYBUI/vKEMlA4ZViWFXI6R7v+B3AohTI/UVp9
 DIygxY7T2BAXQ/H+2fTOIpQ6zbU+PwKyx3MVYgtFKM3sQzAxt0EezVOW7/djT4K7juBOgy3Enfu
 mKjcgMVA==
X-Gm-Gg: AZFdTZd0r9S9QGWPVMIUseVF3eVwq/+Owq1uj6PWen+Pk7Nw+o1diA4Q7HaBjhNp/dV
 Je1OdQheol7+ecdlqO9+gQwPP+V7sE66B8EB0A4uXbxGT/ocO7J+0Ju/Y8rSKY8f0Si25t26O4i
 oYNegeLCH6hC2KxxRhkOTt0WSE0TN8O4i3e7dBM2hJ+d/Sf4GgAJIuyBLYuMAj+oewhLo8Ee/yq
 bM/AvopeqZY0JjRXDkHkPaBbmd/VPfcFrglOc54gp6pcwP3Pmqpf1INu9/Wt2ezu8rgxHHrQGTD
 j0Li/gTIZkh5gtkV1jIggN0HxyYk1OVHRt5662ZUkdMJDg4YaZkolRjH0lKuBElmzD2SxzzByDb
 BVzpbrBrytS7okz6vHkO5MXxhX9WaR/6spjp1TMZDQ+DBCBGzVUDLzngX1jgfE60Y7s8V+fpkfg
 4GzEdxWoZDbBsYscoQYhS67lU2/2K2Z3x1gwtpHFdjl0bl6MFG4Xtz9UgKrA8fC7UINqgbbVJuE
 R1p4ksyYGQcNtn0O5P9qbsL9I6OesRxZ7jkzkCfz4OCHwnFAXTwVQpkMngyvxH6KZZsJsKR9xU2
 q60pcXVbJt2Dl+Fh8u7jK2c/kGgp8uiUi6Adl0FvlskEQMXesp56d0PkJFVlPpn7WP/Smh4C+hR
 dFPaS+ZXgafNsA+dwjUEJXWtSp8Dazbr7m5GbQSeHW2AnpqxrqQr8q9lNU6v6BtiA8e2/oXDK0V
 X0i20CZccsDTT9ZdA=
X-Received: by 2002:a05:600c:1d08:b0:4a2:392:9de2 with SMTP id
 5b1f17b1804b1-4bb8882bd7bmr216521495e9.28.1795422854979; 
 Mon, 23 Nov 2026 00:34:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm23458208f8f.24.2026.11.23.00.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:34:14 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 08:34:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
X-Gerrit-Change-Number: 2240
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2240?usp=email>
X-Gerrit-Commit: e192ade857772d5540e3ced8b69caae02a94be08
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 08:34:11 +0000
In-Reply-To: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
References: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc5MjE4MDAwLkk3NGVjYTIzNjQ2NTE5MGFiNTVkYjI4OWI5OGU0MzI3NTdjNjFhNGEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fbc49e7a1ae7c1d643f6d705b9492ae52fc1daa8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVPVG-000000007Ao-07Zc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: drop duplicate
 remote address check in tls_pre_decrypt()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5354921548855015739=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5354921548855015739==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WhucW873CF8="; charset=UTF-8

--WhucW873CF8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail )

Change=
 subject: ssl: drop duplicate remote address check in tls_pre_decrypt()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2240?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74eca=
236465190ab55db289b98e432757c61a4a3
Gerrit-Change-Number: 2240
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stip=
akov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Mon, 23 Nov 2026 08:34:11 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--WhucW873CF8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=
=3Demail">change 2240</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2240?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I74eca236465190ab55db289b98e432757c61a4a3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2240 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 08:34:11 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--WhucW873CF8=--


--===============5354921548855015739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5354921548855015739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5354921548855015739==--


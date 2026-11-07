Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59D606A326
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F2LK871o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jD+bHj1t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kxJ38YnH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PLt62ucb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IgKKcRZ14hIkrVFTcDOOUPfkTNiWvnArEgL2tKYMtqQ=; b=F2LK871oieVcxXmbcKAXpd7po5
	R+wkMzyo2gVURt5bUxJiKeFRUKR+O6bBPFifF1nWU3vq1hs9slDdDgwiLTM5ACNE0Q46Vz/tn2hF3
	h1e6NNK6AR+hkFk99kDXkBrwhNjAcUYUkm/1Km80LxZ1kRqQ/Zb4PF5vSx2+s3UPftoM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPld7-0000000012G-3AVk;
	Sat, 07 Nov 2026 18:59:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPld6-00000000125-31Dd
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gohzBWzTm5swpsrbCf08obYk93iBY+aqlpTUn+y/vy4=; b=jD+bHj1tqPAPPzcCT1StuWtCFO
 CfHMRF8Y0GUTwtKXlyZ1k/2YW9DMntUMsiJQv1h5IUgJE26qhHJKIIVcGFmvztuq6iLm61VlJqggx
 ET4z79stjh5kntLedTM9HWT2OmumN1DhnrQlc+XyTDZSBSm9Ewmlg5o9opib/ZSulZ78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gohzBWzTm5swpsrbCf08obYk93iBY+aqlpTUn+y/vy4=; b=kxJ38YnHpCBaAX7fwG7ZHyNrAE
 us5YX86Hn97cLB7ch1M3V63jsfHLVfoJCyAZDjODSaOts2U6APz4KNyhYMQCpssCdYcdC3Hfroroh
 4vVrY5cWH1GrT3THu7o5xsaTMuMSRGHNeTqm9l1/kKyx+OvZgg0WMDCEF/6W7sWN23Bk=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPld6-000000000FX-0Acb for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:59:08 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so874582f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794077941; x=1794682741; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gohzBWzTm5swpsrbCf08obYk93iBY+aqlpTUn+y/vy4=;
 b=PLt62ucbaQJjxfCzX+EWG5/2K6hA9UWwtJPRDCkH/urqu5MJwBA6EVGOOazQkURv03
 y+i1dm/uj1axpG5zg0eidQYdn6q3ICMJr1vrjk9AyMryFXkA154pBrCR9HTCBHJSGvsr
 p7ExIQO3iBXnF7z7X2uMYAw+cr0+lZJ6BnabB09pxt8axFiS0GQbhGaEcdKqQSknqu7b
 cfSM2A1v0i/2L4Z48M6uU+aeLA2GRZ6Abumv4WPHjKtk4ZtVHlYRlwt6iQBd6L0uJKdA
 qYvqiyIfoNIZxTdL+A0xk/0cCUVg0avTOra20qnGVdFuqZyEW5iikptjEdMLR5G3bJp3
 nGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077941; x=1794682741;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gohzBWzTm5swpsrbCf08obYk93iBY+aqlpTUn+y/vy4=;
 b=yuRUfldNnEIvkw7RMyO1BkPeKMdYRMAXqq0HFJ8nCT6YlTg1j31+bNsWkpplYkU32F
 7V5bmyfJTyhlGDS5tAesjZZ68PitNfR4Mk1haQ0vKNB4ABhwDTLpslEY1nHdD0ZIT0c0
 wOyKgRfxyepMMeslU3iK7FjRDzfhUe0WQU5xemS5kw2/WyVo4+oa7vGDXn+GXgj/9Vms
 rTzqZPYQ33Tvh3m1OWY5q9dzAR6X2eppqWecq1t7s6i3RsSEtQGFIGtUnx0uTG+T2j2W
 o8b2d3R91kif/xMCucyC16jh3LHIRRZo+XkK0lJKpm35/SN6tK/tk+U5l0MmidKswcMj
 2cAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIlPxpLcIEt+ZtmwTI1q9eLKJZx77kEET3ybNbQvm18HX0TyerPTY4y+sLulOU7wegx+bdf5899JNjDPkx@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9GNp09D7OwCXuR5cU3cA0cRALANBSVSdv1dhqEHqWGs3IEwG1X
 M/NmnXIQ6GcDM+OsYbjbRdNzLQqnl/0kNzmQWxAPTnSWCI+wlYKHQyQ9/BDK6E+mq/s6d2Ii870
 sjlO1SKIS8wKs5xUyC3jNVfp1RDeZczxTAOBgb5PAFlHr77u4gTFymLl4oNZMoeFEgjow9dClZJ
 et8JRZrw==
X-Gm-Gg: AYBFou2b1/0z6zhW/c1tMGIfD63sI/4p6CXWoBNvCuj1b8uyMhRrjdMz+Y+iMJuPD2Q
 NjZzZJh5IgBqvxNiMQvtchGf/LSfARZj+s9UoLj/402LxmfVPQ3JxfrMyh2sl7mx1sm1NpRE3Kz
 PLVJRifB0KyCJRj/C6lsEx+sSMFBjXTqY8kZR1a65jKhJU3lu6l3MovSNY/y+JBV/xUtj+GaxI2
 JrUSyYOx0xzNoc8FtlBih1uyuyarVIK47fdoup4NCC7U4nptswa6x0VyTuDvjmXvSuODSfJvDyU
 tthMCp1FCFzISete71y79+xiABwQajZ1Pe+EghcaYmOWKzHnhuHc5GGfq2/5WJijF7g7/rXlb5w
 LaT7zqEl1EWqVg7hJkYQFxOfFYKdU/hlIJLkbBBAqZ4lMCRcFnwYXf3TQq+lQS9onBVP233TGmB
 FZCsWn8MkwiPiMuoIAeq2GK0Cw1XI9YDFWk5Sue/w99AXgGTpYsGm2pviEzRpTMDo1HZCkzppcK
 kBkwjUVTMdyFBDHiGkCSkBGFTTtVgIAsZ4VKnhIogJdRUu7jBYkQmtEsDScQcAsjevG3tI9hzmg
 d14Jxe4a8dq1x5IcHjgfl8/BrGvxr/dUd9TVniqLx/dtPzfgPIsQy4UmgCqi3J+ozDj1jN/02ch
 37gjykh32PugEnE8qfr3WXqxW80MpIRxIiWyjwCoZ/LESadPWe04ZQVag+vpT3uMo1XBKfPTAvT
 sSPGJmBOmcSmFJ3A==
X-Received: by 2002:a05:600c:4f4a:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4b6e0267f51mr114175705e9.29.1794077941332; 
 Sat, 07 Nov 2026 10:59:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbe9e31sm83642565e9.2.2026.11.07.10.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:59:01 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 18:59:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: restore
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
X-Gerrit-Change-Number: 2150
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2150?usp=email>
X-Gerrit-Commit: b84bdc3874918f404db839989973dffa373a0859
In-Reply-To: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
References: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkllOWIyNzIzNDg2MjE0MjMyYWFkMzM5OTFiMjY3ZGMwZmY0ZDFjNTM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <efdbe1e4e3acf696b794e2ecfeb4a423edb02763-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPld6-000000000FX-0Acb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: add
 route_exec() for the per-OS route commands
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1436863122109810704=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1436863122109810704==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/tYlQBkmH6k="; charset=UTF-8

--/tYlQBkmH6k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

R=C4=83zvan Cojocaru has restored this change=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2150?usp=3Demail )

Change subject: route: add route_exe=
c() for the per-OS route commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Restored
-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2150?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: restore
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
Gerrit-Change-Number=
: 2150
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--/tYlQBkmH6k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>R=C4=83zvan Cojoc=
aru <strong>restored</strong> this change=2E</p><p><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demail">View Change</a></p><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3D=
email">change 2150</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2150?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: restore </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2150 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--/tYlQBkmH6k=--


--===============1436863122109810704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1436863122109810704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1436863122109810704==--


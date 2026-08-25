Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35A7C61DB9
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eU4ohJJNI3PnEI8tfaetwA5OTWYDnx8gkBiE7cY2TMA=; b=kLcSNCG6vDM3sMoToUs4MhHDgf
	qzzlJubXb4GWBvsMLhWmKSgAQnrXfqY76gnFKrGWTFFMRLu1wJm9aOfYGC1sHtrYnJNzdiBfNpzzb
	d570cU19NzS6tk/Z5hbMebFpfr4+dZooDr6IFut6ICdhYbAJ1HO3hwFYxb9zM1cT+E58=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytBs-0005iB-Pf;
	Tue, 25 Aug 2026 15:35:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytBU-0005gk-3u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VrG4dsnNs/eXYx2f4l7lBIKC9WXAvTPDmiQ7MntdGKo=; b=VImsuLapxMW1C8Mq5SFSFijToK
 L4nGHzIe03HLIjeJctxOcxME6dIq38D5AaO0jQMneu7OGbek/1YUphrW/rXOcl12bEmF86Z67/xcr
 WR5KNYG9XLihXIj+brRrlnXm8VVm3uCGEezkvkojMXVJ34/oqbCFUkznKjcc+NSGBL4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VrG4dsnNs/eXYx2f4l7lBIKC9WXAvTPDmiQ7MntdGKo=; b=L
 AvBQTx7Apybk5yfenv1IJoVywZJ9cjApSo46cZ7Z3ZBwQ0DfTgQBshNZps7QgtJD6pRbaQjv9NPpK
 d2MTgHVnUrR6JWr0N6cyS92ufIvuC+5yoXDuvXNNBj5EqisUhUPswI0kh4i94/5wAzMGQTocYx7X2
 afa6lAVv1pxiwhFk=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytBR-0001wj-Ll for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:35:32 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c15e592da74so685950366b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672123; x=1788276923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VrG4dsnNs/eXYx2f4l7lBIKC9WXAvTPDmiQ7MntdGKo=;
 b=Yi/nJQG192hCjq8swwlnqILDWxxzRHeUuwgH9SNeAgdL4t7gdteVQSvczaFUy2rPoT
 77gRgFFwOuF8Xh9XK/HODNzKf8MSPCVeNgatRCfWw1qKzo0jIlOIcc2fivSVhbK0kljV
 LEMyg5BFT7XD9ByyijtVU90LQFGul+DPg+3wPQim/m4yICC+VWv/aEvcYM9Z9bDbvE5F
 nMzs+cdkG/SUClb4YzX5h3l9D/ZqjhiIIPNbAUwL6s3BSi6/bMJYfPMle/rKhZMBPuMV
 W7hbYWwWglHVAC+dTqUeDVHN3u9T2NJvUZcoYr+UpuUtOGvVSEhXVAVqGFNpcBfNCuET
 abOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672123; x=1788276923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VrG4dsnNs/eXYx2f4l7lBIKC9WXAvTPDmiQ7MntdGKo=;
 b=h/ErEpe0mQ5uBxDXn2rwtKbFVFnfTwglpORODFzzxLClOG/VVBEcIy5PZBbTaBo4Ss
 Z9Zss5FMB+zwBeLgaW6NH+WfDZbFNXRw8CYTvK7wQ+4E+hYxKUXh6MvXpayz/EAluXaV
 g57E07OpjXspdSyKCmBpVypN2ngk8hBOywnSz3A6MHpoEYV2ghBTkmHLhwNlw7juc0Ak
 EIsyuZjv0MBsAvVPxLfksiONStTq4HrqjL07DgNm+uafO8z4vvYvv9jjEgjyyIVJzKgr
 Gnksr+rVVsHsVPi8OlLtxE8tGXYPSIYCacVAccBxdNpO09PD3wl2lX+Cv6E5/d+trVOR
 +ttg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK3QCS/QFbZdFvRqhxpAeokYFI0y9aVFK+ecYiB+DtnLA+H8sl8/GBzVtucII5WgL/bdYNdLkvHNJaU0OD@lists.sourceforge.net
X-Gm-Message-State: AFuF++lytLl0Ajwn0rpQBO+K7O3GSOfUewzM20gF3eDkvLC354ZXuScL
 eAYtKCXY1gHO8VAd/ifi/VrNU2QPt8E64QbInH9RjgN9k+3Y5IBekhLi5CldakIgdOEMBxaejcy
 Ru6M7RaTz+p01lVpEm6LsMur6yUQC3+aLJOLEWQJdXz0rQisqER8+VUcuud3s5uKEfDfF
X-Gm-Gg: AR+sD12d2HA0ZRHE4xq1Y+9a7+Cfb6dkIuEMc2vJjT5TSOYYMw2uOC544Qygf1FoU+m
 9GgDq6iwY8kD2fc36MMijEK/npr9DWx2dTEiB4LvUrq5gijf/SV9zmFpMMg3yWAEVau7IowmEvG
 Vg6zrnSi1fcXNrtN0Bnxh7anBLcFr/sXy+bGRGUFVSYTfR5DODNatLhQVK8N0RuDkwzNidVKrme
 WoydnREJjZHJEV//+WosqMkKcbMxH3YrX/JwBeNa/6Y++tjT8TRUkPm5YCp8/m4B9nhtHInsCVQ
 wEoZxKKhvMJeYjV3RzmcJWn+bwmt3IDjyzz1tGL7DsoN1BskbVC7eBQm3jR8BrqgkeqIMNqNN8z
 9vddmA6ca7NST/ovjW//kNClJ2uBhO/1VOmgG2DfdpWyT+jg9wV6uEg1mNq6CS0G0gR7n/rJsYg
 z2dFJPUAZt6fH75d+a9IzfO1I2JALYah7JoEnk1Os+F9mToGp1mX8F4k3bke267wysIlRiVbtsW
 C68CUIgblKEEW8SSxZ/9xQhJyHu4I1Ypoe5/bdWpp7gBLsKlf7/+iWu4xxIYQN/mzh79yucvjLu
 LNNJq8a7MnIp1U4VFsSFg5iv5VgrDW+SzIUYEv6BKAZ1v55EI38=
X-Received: by 2002:a17:907:8992:b0:c21:8c6a:c680 with SMTP id
 a640c23a62f3a-c24926673cfmr3279115266b.22.1787672122965; 
 Tue, 25 Aug 2026 08:35:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d62easm10621766b.6.2026.08.25.08.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:35:22 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:35:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 580974871f6664ce68e8f5e0034a27970063d7bf
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b477ffa300c8943ebdc9265bf49a367df2e92954-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytBR-0001wj-Ll
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 unused functions
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0177020925870851254=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0177020925870851254==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AIlOe3EzNfI="; charset=UTF-8

--AIlOe3EzNfI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

flichtenheld has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1610?usp=3Demail )

Change subject: Remove various unused functi=
ons
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Abando=
ned

For now I will disable unusedFunction completely=2E It is very prone t=
o FPs due to our complicated #ifdefs
-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-Numb=
er: 1610
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--AIlOe3EzNfI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>flichtenheld <str=
ong>abandoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><div style=3D"wh=
ite-space:pre-wrap">Abandoned

For now I will disable unusedFunction comple=
tely=2E It is very prone to FPs due to our complicated #ifdefs</div><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3D=
email">change 1610</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1610?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: abandon </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1610 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--AIlOe3EzNfI=--


--===============0177020925870851254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0177020925870851254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0177020925870851254==--


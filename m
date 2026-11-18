Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BB606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nol3E6ZO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UKoHMZTr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gf5MIA4+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XighVCtO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VG3NXn7dq7cWigxRu6vBY8h5exlo+tlD/yO3BnzZUy8=; b=Nol3E6ZO+ZEqsu3aybeSg1sPsD
	zgKWOgGrR2+gAvT939hK50rSIfDqQfbxOnHoBLN7bm+98AYGQ5tpXfTrYuueA/gJCTW8knfVtQrrr
	NBBXt4FHiW79fnRk1Sp9CeLqaH/7r2Gp+Ect0I4XSrj2L3ZNvv1rtMpamPDHEDMI+Xp8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThXw-000000005Pz-0Il8;
	Wed, 18 Nov 2026 15:26:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThXv-000000005Ps-1ubC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GCRf9h8JY/1NoZxZ2X4Vrw4UsZBweSGsWOK18EyQfSk=; b=UKoHMZTrdfyWUYMlGvS35AKblh
 UOpZRJ7CJbdUUsJPwLfHecIOHKq9Pp0pvkIOMJYiaonrh3l/bh3ov06Y3l5obsnuP+ua6NSKYjxuF
 4z8SKy2IHq2kolWF3ZMlwd13++GQtthcG9Tb/2d8/+8TJS2enl0DF4uxdbdpQiyLrFF8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GCRf9h8JY/1NoZxZ2X4Vrw4UsZBweSGsWOK18EyQfSk=; b=gf5MIA4+E6DeRQOYblOxO34ZiX
 duE82AxSp2ZI9CsOry/2SbNyrZLYWgdAtxMV6LVlnJs10oyUXHE6Nqn2ufEBxtnPBpczRkuLyWXHa
 HmXx6aoa5pO2uiGWB8vwihr9lrxUgKBHGJ7O+jGkpaEAEj+IJhl5k06+Ol0ckqu4/KEY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThXt-000000002JC-1zoD for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:26:02 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso16723695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795015555; x=1795620355; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GCRf9h8JY/1NoZxZ2X4Vrw4UsZBweSGsWOK18EyQfSk=;
 b=XighVCtOWBYFlrevvnuJOvjcNQH07xPZ41WsG30GNjjiYw/hgUqksyHDir8km4Jw7t
 c7WNPfmE9UlA65Nn7lCr/oJ+i+gpTatEJWOLdkfpGkQpru24Dv9TCyJpgS/8hwc+vEYY
 lsirCLl1ZFnemCfrFo9ZpOtbJ8ng7WCaF1b26A3HEnziDrWSlvF9m46b6Lh/8hh+OWuS
 a64/KZ8f8ZqMz1mLFVe7yfFYBAEmNykj2eg7JPAvbBXGGKT8Pyqqnaty+B9+vR/T9pHR
 Z+zZqzZfPEIBNSvlyLmTmMea16NxiiTF5eVjnuyUqVMhUwrEYgdthug7xJ5QiKA1MN57
 VfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015555; x=1795620355;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GCRf9h8JY/1NoZxZ2X4Vrw4UsZBweSGsWOK18EyQfSk=;
 b=hXnUX9tbvlufDsRky4iMoYPI1Q6R8U/CnE/5V2lTc5H+awzQhquOHsqIb0O601gWYK
 0m6/BcWoM9zZ6NRLvBCFBoGodGRGOqGh6AzECJmUONY486441lrbkd4z2oTUY9dbriFl
 HjDPkxP3jPRfi/b+64uolNBKuckmw4xbXwzjYT+I6v4dmW68KSXt+zYeMMvOl9brSbiR
 jCWl/vLp9/V8LAUhPUJMSvEnYBMLw1ykX6c77NGm4rgwyVzc33bv+RVBo8VxzANp+IBp
 5qFGpk/D37tMM7VWgDJNKJ1BWsUPwR0UKicg8s0f8zcXI+LLWAnAHmWCajaaDrLxNyAa
 wo6A==
X-Forwarded-Encrypted: i=1;
 AL+hErGe8rzYZzEvPYC17wHypjIADfv1Ykzmul8Pz2f2D4uDPC+y+zkWgqDGApYVZ8jI9QYDJm6rqQ9ciW0xyBoA@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9M7l3lqVrSrvpZKkluOU6mBEtoXmOKMhoJ6cW7iSqjFK+bXNqE
 YvgJW5ufNvaaGtNdB022vs5CtvVNSOI88scuy9bASBS/UTcwqxzoiJ4CAmMPCSdYlECh2C/ODFB
 Q/w2gG0Lk9+vLXC+vD4AKi9/Ew01ceoCp1pVwPqRZPsiRfyjOsbtJaEhuNmZPYe4vViGFSwsPKE
 inhTAJYA==
X-Gm-Gg: AYBFou172/2/sUVWFZ7eqGvvNVQ1v4HChjkJ6bk94vZXmmBj8BPwelL5D9FXfpdHf7R
 8NxI4+DA3KBgj538YN4VKDRIodRScUAGN6SlyZN8P8UyJ8MNQkGjD8QwV19il1oE3wFaeVihsY6
 cDue/EfNJz0D7u34nqrCy6b4euLQeDha50zuoq6633mVjLLJWMq2FgcwRSd0EJTdbj1xHxrVQEE
 wCQSBEnDal3pk1LYVeeLXZ059fV9/q+gzkBIpbuFWPkfCrLppSmpeg6JJia8gEDLheidJxwLWEt
 q24GfmwyZnVEzJj2hKuDeBreo/xIaltMBn/e3aJb/f98xtcNKg+DmM8YiCkdvPgqX7eU24yIL6T
 lsc2739HLRwy9gZckTZdZZfywxYniTcqbm/0xY+S+EIbKer7AANFKd4+nTuXA1GBnmup0vY2fB3
 APYVLJa4Itnmv1belBMymdyN6uitzUGM95jLNmvYZ2Qjeaw/fjnyoUdxWLhF5wW+Pu7tBllpCA0
 Jg5WCPmJDLql3sWYsvoLfNzZqHoET3qk8UcuqLJ8GQ2c6LKnyNBvhtPHS8HxEVeAe01j6cPJvI9
 9GMi7kY8L/CIbu8e07cxr84MlGWVMwleOz4qdVruLN/dXxE22lyKbsphrXia6GjM+murWm/GzWz
 beQPSvYBFpLb1lTqGtnL912dnyOSH746DGiKP3iTb8+cmypnzLjww2oF1nuFlUfoufj60Q2uZhw
 /oeLzHZvbF53B/J93kJ1hKjgMLA2DIOGGm7vYO
X-Received: by 2002:a05:600c:45d4:b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4bb7d5d4ed2mr59661235e9.4.1795015554629; 
 Wed, 18 Nov 2026 07:25:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d4e670dsm79581335e9.1.2026.11.18.07.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:25:54 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:25:53 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 6421b734a7d736295fc7220ab74ddca22632790f
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 15:25:53 +0000
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aeb9efc34f573edb58958ff70981a7ff1b437029-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xThXt-000000002JC-1zoD
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: use
 check_for_client_reason() in tls_authentication_status()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2331398163747022241=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2331398163747022241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xbRBHlHOOJU="; charset=UTF-8

--xbRBHlHOOJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail )

Cha=
nge subject: ssl_verify: use check_for_client_reason() in tls_authenticatio=
n_status()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2217?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
Gerrit-Change-Number: 22=
17
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 18 Nov 2026 15:25:53 +0000
Gerr=
it-HasComments: No
Gerrit-Has-Labels: Yes

--xbRBHlHOOJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?=
usp=3Demail">change 2217</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2217?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2217 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 15:25:53 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xbRBHlHOOJU=--


--===============2331398163747022241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2331398163747022241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2331398163747022241==--


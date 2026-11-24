Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70494606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WPVloZEw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CH3aRwX8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aK4goY/3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HgsWkW8Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Wh2fd1P+lPei8pTzDfBDbmw1TCpAWrnHWt7HgB5PeRY=; b=WPVloZEw8KqLtjD8IC60C5X2eU
	waIUuY27m+kvn9RRQUTz8xuvINPlagHRwiIupjIIw1Cban+dqx9uegbGHgQv4iza+fxsgzh7GPXE6
	m99qd+uvf7bdrlFoSJDLawpaEvmRDNVoU8941JJbbJGp4BzKFjsUJunGQhs/epJLFd8Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpE0-000000007r1-1YIh;
	Tue, 24 Nov 2026 12:02:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpDn-000000007ql-0w8F
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uy2d/0EOzhbENPFHk9ObmsLHVHuTCvODgfZvQ/tkwvk=; b=CH3aRwX8w9UbLJbGo7k/2C1suk
 bFRuFaUkH2HaynZrEcWdBrpw/hQbJnR7qloYcbVwcFEZj/Te8lHCH8vvQLlHLnzlaHPH5P1tHiXZy
 uliqFTU+7wz/GSFvB2ftyEsARxFdTU2/rH876CVDtkB5vX5FyyOgFSXcVvTLnBiv6NJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uy2d/0EOzhbENPFHk9ObmsLHVHuTCvODgfZvQ/tkwvk=; b=aK4goY/3ceMLsJOx+N9dbo2K9v
 hrTcKJmPps7JNCoXqO9QEBay3jTCro3OcERif4BFPGkYTQc+VNkRYZ8oJ3jCWuYIo58RxnrxmtB48
 WaBTE4mQ/ukKLXl8m6FiFa1gYeGH4E+dAwR9vr629m9a9cN8udq55n49egDazh/RWIFY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpDl-000000000QV-2XHe for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:02:03 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so20369185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795521715; x=1796126515; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Uy2d/0EOzhbENPFHk9ObmsLHVHuTCvODgfZvQ/tkwvk=;
 b=HgsWkW8Qm5x25G8fFLw5NauWQ3mnjgk6QwIQbBzBpozNg7PRuGS6HNTCdCC1xk6Sie
 8o8I3B2L14Fq+0DT9DqMy1PKIBNpIaoITHualPBtEeVmEzlF04jXfB5afPIQ2EZ8LsnK
 yIo2nWK1agopcUv1VtGT+jA4kb95hEsXnKMlOz3grpUP5L4jq56CzSKycB48VewFKPvu
 SiXh4OVCN0Hb5cJRieDWaHh/mhPghPJ9p9v7GJEXENxrhd0H+GVllFpjmZ80UE0KItR0
 tg5zzf35pGj4niP6yu3hDYJGM3tNYCHMXRCHZVLXpdp3L2+xxngnO7dqv64riDi0zmOz
 KGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521715; x=1796126515;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Uy2d/0EOzhbENPFHk9ObmsLHVHuTCvODgfZvQ/tkwvk=;
 b=T1ivoTfykNhRcUuSF695qw6j+9UXdDRDT+Q4hekep4zByk3MjAp51t2usSFg5+jDW8
 fdB3r2EDMGmzh3f1c06d0Ano9oX2UZrWpcz9Qwr18IVG1d8pTpuHYtxxRHYgNegqJDde
 hH4mOMDOBh3JoYm4Jbww88V2xnNoW/Yx3LRrVUejzudfRIMu7WT09SK9bKwM4pxRwM8k
 VpI99kBmftOhU5M4dyb5E14fI+ZGxoychHG0RddIXD2qRkVkTdDSQUYLhHblFC1gnOAj
 oTdrptqy42W68oUG3KZLnnZv7kiPyvnzL8Nr4l7Ybg6AjMWuGpTp7mI3bt+l4a27lLWk
 DwDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEvy45mSLoZcrltI67HvVeYWsHsxtoiB2mfW1Dhy+LScO81GY+8IQRDWckFNHajz8MQCCzBSlVJqJgx9uJe@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ivgY92oHysaHJNKQ/vw72FkXkiyuc+9p/Dc9chaV3Wo6eyoeD
 FfXamobWmsD23DXl9gSTnWpjxje6go68XrnjI07NXJTvcrSgWw1gNdB06ZkrZNFPPXLnzOm1jSk
 JCOOYL07N99ll94RobUeS+/wQaqK72XE29v7BxoYF/MBN1MbvdjhDB9W5zQZChYHWTmJvZ5DH/o
 ceMJDWkg==
X-Gm-Gg: AZFdTZfP3GIFfsEeQXU7sJn90NKYM1IFVN5BjNaheF/yLtg6YFWFuu835GoxUhl4vGN
 2KfI+TWx489t8SIlakeV/bFky9h/vLwNj+tTTIfoqs4TT8/sRGGLC0a3J2G7hrkMS6lclSI2NgU
 b4AaBa+43I5m3MAp26vhKvaHSWhd+IQCpejDtUApjGPBNfcPxKULMVxgOiSpj2V7TZeRI/SvXFw
 1kZ58qDCAc1JvGDsxlVvS4SORyQ6uocS+4Un+54lZ2LC1mjOShZ/FA7bDBT4yj72NuVfeD7ZVda
 m2/OvnNTZGpEGBs6ihCSOVxyVu0pmhAXLbhBgNFgtE+9j/1O2+O+AdD/DZm1JOoMkQiA8jhJ9kB
 CYp1EJ2H+NHgk4ouiCSR9NBsa8fyYOe7nxA8WuWWOpw9txo0f7rk4v4HT9We3QYb2h2QCfjTQwW
 IFysuuQRMtWyDD0pB7T4MOFRoadcbtMdiEY8pdapgyjQyM29HH+sR88E+FlcCvngK9vvSaQ4Dkn
 PtFKP/751z8H2fkrOza6hO5L0p8Hm9sZvjT0karxsZ5z96iuQPZT99kdS/MIUPdbxwiYsBqPriU
 tiNYTKkpp4wsnF2Ds65a3neAhO0sz0TzXNp0SfQn/R6CpFxBgRyjtUiusr5twy+92H/5F97Ex7l
 IG8pM2sRrj6d3oWscGYTTVCMue9vVpT5G2qAtbfhD9PWbjEcHwMKR6HZdMFcIvGRpE4Kr3wmveO
 lx62wRrvUJZ8GF6g4=
X-Received: by 2002:a05:600d:600b:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb88815f1fmr296880565e9.21.1795521714865; 
 Tue, 24 Nov 2026 04:01:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf62f7sm29433835f8f.13.2026.11.24.04.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:01:52 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:01:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
X-Gerrit-Change-Number: 2335
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2335?usp=email>
X-Gerrit-Commit: 7d9c20fb97390ea1397d58c125d176388dbf9035
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 12:01:51 +0000
In-Reply-To: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
References: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1OTY3MDAwLkk3YjEzZDhiNWUwYmFiYjY5NzE5MWUyMWFkZjI5OThhMDkwYzMxMGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <840311f44bcf73916517f6cb32bd10d9c71396d3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVpDl-000000000QV-2XHe
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: use CM_*
 case labels when switching on context mode
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
Content-Type: multipart/mixed; boundary="===============8734318452712492177=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8734318452712492177==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hPKzvspUeR8="; charset=UTF-8

--hPKzvspUeR8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail )

Change=
 subject: dco_win: use CM_* case labels when switching on context mode
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2

(1 comment)

Patchset:

PS1: 
LGTM=2E

But since you are touch=
ing those constants, maybe also change those in init=2Ec:


- init=2Ec:2366=
 =E2=80=94 if (c->mode =3D=3D MODE_POINT_TO_POINT) before dco_p2p_add_new_p=
eer()
- init=2Ec:2394 =E2=80=94 if (c->mode =3D=3D MODE_POINT_TO_POINT) bef=
ore do_deferred_p2p_ncp()



-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2335?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
Gerrit-Change-Number: 23=
35
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Tue, 24 Nov 2026 12:01:51 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: Yes

--hPKzvspUeR8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2335?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">LGTM=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">But since you are touching those constants, maybe also change those=
 in init=2Ec:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;"></p><ul class=3D"blocks"><li>init=2Ec:2366 =E2=80=94 if (=
c-&gt;mode =3D=3D MODE_POINT_TO_POINT) before dco_p2p_add_new_peer()</li><l=
i>init=2Ec:2394 =E2=80=94 if (c-&gt;mode =3D=3D MODE_POINT_TO_POINT) before=
 do_deferred_p2p_ncp()</li></ul></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail">change 2=
335</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2335 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Tue, 24 Nov 2026 12:01:51 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--hPKzvspUeR8=--


--===============8734318452712492177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8734318452712492177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8734318452712492177==--


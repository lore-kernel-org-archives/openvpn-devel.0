Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D20606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=leG2u0KI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZnI774j7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RQpEuU1V;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ceq122zy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yN+ACqznDcf4ElB7SejLQ4Tcjbd3DuWvsXHg0CChauI=; b=leG2u0KI80weamx3n203vwYZE2
	jL4vfCRhY7WKBnHHNjV+BMv/TFJFvG3W6m6lWvkGGrfrzgBfNG5qt+NfhhTNZsvByKGKkSu+TJVPV
	P78zg7g7tIFlgTNQ/sxDqflJQ8LjJdWN8gnhUDcdb7C0+JdYhB0i6grRugwU1vDq/Zuc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0Pz-000000007tZ-1KEm;
	Mon, 16 Nov 2026 17:22:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0Py-000000007tO-1WrV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=88BWjwTueq6oy4hyJjay6wXZSJNdH1iKbjGQR0LmyYQ=; b=ZnI774j7DWHeEvSqnmuUHaAwQm
 UPsWLtix+AxLoqagomVq0xrSREtu0+KDoZGC6UOMKnPT+eHeqFbyiIST7dLk71ICMs33KWWSYEaiV
 RNmtejwieH2Lp7A4wE8Q2ze0xsD+i4rdaiB8B24pWEmPlNKZkYsFTbslfq9myXVhhoVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=88BWjwTueq6oy4hyJjay6wXZSJNdH1iKbjGQR0LmyYQ=; b=RQpEuU1Vmf3Iqny4vdXAp2Lolk
 Nnn3GjcD6KUSHMZ4VRe+i0hXf+qqyQ/HU9wA5B9wQBRZ+azx2mEJ5JZD6fCRGuHeNPiEaYd+W12wD
 XIlcqTAz18sdQaDWRe2/LT14e37b0TEezG1C/cwXsgM+V6n8Xv/x5uc17VTPehDTMA5A=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0Pw-000000001uy-2RDM for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:22:58 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so39497925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794849770; x=1795454570; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=88BWjwTueq6oy4hyJjay6wXZSJNdH1iKbjGQR0LmyYQ=;
 b=ceq122zyowCbuyUNty5gaL5JYv1ac/cfWGjLOvfBXEUh74xX+7b1oQzsXA/6F9Sscr
 lmVuAE2s6St1wBOicWxZRweSt6+Rse4vba1erodQV4oSSailbTbKhd1nzvQW/rOWQDvo
 7scn35VL4T4RQl7Da827LzgrfcF9WowubeOsvWG4b5eM1dr24CenpdfivBTVTWlXubBP
 plFIM0IuWhydwxYfEY+N/gTEWOB+DBHb+MspsLotPHe71VV9j3edbm6rsasSH/Owqlho
 NxzTlx/PwJaXQuZA9JEwlA32p1rSMovNntfvt+mEspAI/Jl34w+3LchrS84lAuYcs+2N
 JMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849770; x=1795454570;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=88BWjwTueq6oy4hyJjay6wXZSJNdH1iKbjGQR0LmyYQ=;
 b=K21a98UeSfqHZhL+UBCapK7/IX95h4EibUvy5hueSh+8fsRjoxIUXKJJnh9I8NBwlt
 /2wB/pexgtEUD2riXoHvWU6OfS6vpk+3U5rdNLAixNr2u/Kn9iOwow3fbpgKPkt4J38q
 +BoyktUeQHV62bXRd5PoCjdAxEhYwCDOaH/ZLIQvK/H60zGrLtRLa/Sgar4ZXNLhZAa9
 356U9W09GHQm5PcmIFsLTCfEKuzr9AaGHC8/U9rb1b3zKUyIQ005153X+0aHoI1qt/GM
 1BhdS3NnYtXjaXx+mzpeR7j4DpMLS0VhfbNu7DeW6C8L+U3jKLaqUH54KVz0hm7e5eZG
 j3ZQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG1ceoZaC2aYik3Bf0cEtSshllmJi0XN0Ts9EYrKAX2yQtcPxNuqZGDwEYg/X13MYSwwIV+oejcCfj/JHLf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+arNb8JEeG2K2aifcE1spenrSwKpaDenm/fof+aW3pGpbr3VHy
 GQXqWvPR0aclkFIXeUAMnierCVoYrWyHb0CE0OJpGQEuafTVPqfy+WvKb60Agk/VL+s2P2HElHm
 7THZWlEXqq29M4R0sUKh26UiPIaFhuYriQr9ruWYSuHcbKSrIjaUkm/KZDTJtMTruo/9J
X-Gm-Gg: AYBFou2+bFxTdnfGKdp2xlCvPoSL/4v9X15dTk2v4gvlABgKfxux+2k9i/koGqkTouv
 VdrDqPpJwg7cxv46EBN6hHPDW4iAmTQLpmS9nLemUjobG0h+YWcBW3mcsf5w6SxjwUeYR/GqP3n
 stXZzL+2Gj0MXScrIj2gO5sqtfwJMwoSYlKYxM/c+ApjvubunP8NnBfkfGoSh+n1GpTMxlriXgr
 l7dNdDfOejR2y7vGlU0uoMwgDvlRVFdr5DiAUNagsn44o2V3sjdjvoSlUnQWs9Qmx5Gbahv6Pjr
 ueDCNpbVcpO7/3SEpeiIzdRwQvJ/aeVaIymOYM8UPqtq2CY1GMwzdpNH6jZG+AznRr/o2Xb2ZAT
 3QxslTdBYhdI+l1wNHc0zrcf0bN4dQQaHNNDL/YymSLWlvvNjMN7KSKI3eHHPWCEnqe+9bqnf2Z
 leubc7aW/vs+dm8Oc3hNYU0rKd522JyqVcKs4UnJngfZVAdzlXYW/7bdwc3YFeSK9djcKER4Hpp
 f9tTOUYdGYVd7e7y+a3oTb1x26zlXdhCiWcqgERvSYSyKIy1tgpJmfYOJ1/IpkVvrVcZovoDMEA
 5qPi04zmd3f4Xc9wkLHJ2CDiKpP+i5UWIlfWf+SthvC/Syt+KGdaidnUrGtl6n6Oyzl8raOUjei
 krOJH57mmNkqVCoQVMTEM8v2QbUgGk9aeYoQuwLkcg8AXWK+Sw8t0OXwbiE6S+UcuqLUn3nsuBj
 OhDcLPMqrtYseZtPQ=
X-Received: by 2002:a05:600c:a313:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4bb55a50c90mr183675325e9.12.1794849769932; 
 Mon, 16 Nov 2026 09:22:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7839cabbsm2706255e9.11.2026.11.16.09.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:22:49 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:22:48 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 9c8fabfb154d8e55b56aef80ed34175a48cf2504
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 17:22:48 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0fe8cf0a88d5c059a700fcbb8d20eade694ff9f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0Pw-000000001uy-2RDM
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8141067440606041552=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8141067440606041552==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IAsLjQ7vClg="; charset=UTF-8

--IAsLjQ7vClg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov=2E

S=
teffan Karger has posted comments on this change by Lev Stipakov=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Change subject: c=
ontrol_msg: Add a shared TLV codec and use it for early negotiation
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
65?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e=
009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet=
: 8
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 17:22:48 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--IAsLjQ7vClg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov=2E </p>
<p>Steffan Ka=
rger has posted comments on this change by Lev Stipakov=2E</p><p>Patch set =
8:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">c=
hange 1965</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stip=
akov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 =
17:22:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--IAsLjQ7vClg=--


--===============8141067440606041552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8141067440606041552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8141067440606041552==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87235606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R+bAoWVh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C467CpnV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fw78OCjE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PZHx5UNE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7cJEW+V9tQn00nSqIURB3+rAh2+GB0M9YzAnlsClJvA=; b=R+bAoWVhfa3SyLuiNluRWlJE71
	Hs3jmu4Ffqm2KzlcpmbABdRwwXUEPk+HLe1N6tdJWWEQD+R0UCaCejCFFYjiRLRl8+gODCsp4HI9n
	8iRpArIrDxRNLnOBDQ+9lG7Gfil3/+sFCN43+tAdeFwiaxzzNiSsiQTJAF7y2HnlN1QM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNst9-000000005oO-0sjj;
	Mon, 02 Nov 2026 14:19:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNst8-000000005oE-2oEt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02alhYPE/pzYAqf0H+0k61L0YGK2oZmkH+EInum4bWY=; b=C467CpnVYoTrp0UqPuRK7iGlXR
 tAlaFN5iB5HCH0GJ+2oheDq+2uTivudchl7rMMEl7GFbZW5YywqnLzCUz3i0XVR12bUlnxduC9JMG
 MU1vZ1GfZEPCGfaUBbA9Fo8EKRhPTWDRl0yP36NTyxXS0vx38hCGIlEp57M6Y3oit2mU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02alhYPE/pzYAqf0H+0k61L0YGK2oZmkH+EInum4bWY=; b=fw78OCjEduPUIj/yUetmGITgDg
 TjjxaNxv4R4qsNrfypq1fJcaiaxBK5w7Bfl2h7Eb1zqwN23oDCl/KAxenEbA9qmT4Uy84v3HEmItZ
 uwCdz+8iJ8egxSp9b8gC7KONDjFUEemNJmDeryCZMv5h9qFi/Cd3yrq7O4hcbMnGhnVw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNst7-000000001PA-122S for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:19:54 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so29328985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793629187; x=1794233987; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=02alhYPE/pzYAqf0H+0k61L0YGK2oZmkH+EInum4bWY=;
 b=PZHx5UNEXbAGUymRX3dzkU5T4v8m1ZHwOJG9ruOb7C5vicQrElKwyXrP9F/e+V1Qhw
 uHtwHQqaM67ia1tuNhjSdDehre5wtWyHWPdEHUVXQ2jHPc0Npxv4/EzfOhA5ePAE5Lsp
 y0y0+h4Dy27Q2tWo/c9lD9St5yNP+AJp3Oa5Ngs6mqTUmYdOdQPZ6/4rAZ8S7OkkR0DU
 g/s/HkZuqbykZo7mA0uhyiXalcGwAh+lmt7+bDCkjXt9fSqKP5ZQvT3ilsz46QMHmKJ9
 8FHIRMtC4aXLwyGVhDhKR0iJUVe+SM707koVsMc85Eb6Q2YBu51uT0JYVqOLOYWaRj63
 3W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793629187; x=1794233987;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=02alhYPE/pzYAqf0H+0k61L0YGK2oZmkH+EInum4bWY=;
 b=VDFPVX3C+kRKFBdpeFIYuxqcirAHa2GBKcGeCxuWqaNsUNUuevQLvXvebElFLIgzoe
 WfkKuf20VflPZkE5kYL9x6iZQy8HLzDHP9+2y9oIzusEaN6cxktnvYNCNzpixRWrRteR
 E6bQdP7GBNK7n+n1WrzwTTPnZ/TI3DDgSQ3FBLq6tYf9A/3MtEGNTZpRpWl70l7z2oNd
 q4EeGC5Ls5lbOluwAtzqS1mBsMaiwajgxVQAi/Tqmv0/bQtSgnIIxeF3HWtL5f6wGHjE
 3X3yTvINvaJqOo+T21Kr0XOTAZDK/PRr3FRxfxAtHDl2bfTlcfF35nUvb8aUT8cpgyyT
 XCZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh2rwcuxjfd2Oasdb8BebzHIWeJOjoy9ZWzwkzl3FEXHUYMR3oSVDR+FIyXzQw8qBL1S3zhEZbE+YVaCf1@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLFcLNa7GYMOAX7+BHYybll3q0yAEYIMWYvl7HS77Yz272+i77N
 yotsQ6bZAUEGU1N2aeimFkwWvJrjvCfsDrvohot6YNdCr0ECf0RjSmNWbuyhdD2Hdvgdt/+tN/N
 LeJbgsJ7S7lDwM2Wfep4os4x1gtkh37xQ79eW9/Oy4eVwzy4BPYuxxjnyoyCEEUMwDXME
X-Gm-Gg: AYBFou2oFNEg4vs29Tvor4h2sB8UWDBxsT04OpxDU3dccNU2VO5xvoA5CBPwPdl+EYU
 1QgU6EYtBLw48guGi3P1Hcf1KK46lipDJiLfYEH4yUhZul4WnQ/w1iYdHFZyWWBj1Pr9LS/6iIL
 b4X59UDE6jh86F6lNcpMdnPQVTJCBaS4+KN4VTIXasSffIlRg8NCUeu6Hk3RYoA34qJC3k6RPJ2
 y27QntVH/aRirb+mIgFgXenlV+HON8QpH6tDcZ7F/atgo5OiBZM3JTQmV72OAjbRSZg5DBQTEVo
 4IS+MHy1lcCW6c/HbChZKX6xhCiEgSOOiY7S88OA+nT1isimN0oODzj4AEWpLFtxl5fu8BfCk9Q
 xRQtrn9XkZF+6AsO4yErCjE8IDEENkkasmpeS7Z9cJ4T42Np43C32tnEoheG/E3iThth3dYN7lp
 okb9rL7lLHmjLblpnvgo4pPKhmiMt8NLNOOGBENXjz8ES7psXB5DWoz6RgHJ7zarHnb3Sjh+7yQ
 f6gPKLL24zoqoUd5O+zDxA+ZrDSVv4zZyCtLLXJjSMpX3zuDoruzT89tVJtu86MotDODdmjYIX/
 JuFlCfhKnJVdVLc1yM2dESGHp9pLqPNg5n50VtrkBvNnHywLa106vQfDvsjBYsVE29d9kqbMfpb
 WPi0LWZVIBJ++FebTSjmUSghYNj8EAKSqXyT9j9PYUbESKnGk7uwbr/4L014kwQlH1jV/8yx2mR
 6xxmgr6g7MZaHW2A==
X-Received: by 2002:a05:600c:6387:b0:4a2:150f:1605 with SMTP id
 5b1f17b1804b1-4ac1904a81amr238294895e9.24.1793629186575; 
 Mon, 02 Nov 2026 06:19:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1076sm293854135e9.6.2026.11.02.06.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:19:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:19:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
X-Gerrit-Change-Number: 2086
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2086?usp=email>
X-Gerrit-Commit: 564210a5f01fa902c5b3775d06fdfc22ff0e42b5
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 14:19:45 +0000
In-Reply-To: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
References: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MzM2MDAwLkk3M2NlYmNiNzY0OWU3YzJiZmRkMjlmZWU5NTViMTkyZjE0M2E1YWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43acca3d83b4b1fedb4d878a3c0979cdd5cd33c2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNst7-000000001PA-122S
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: print
 net_gateway info instead of unset rgi/rgi6
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7299774191789112761=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7299774191789112761==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2jG+ivMj+VQ="; charset=UTF-8

--2jG+ivMj+VQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail )

Change=
 subject: route: print net_gateway info instead of unset rgi/rgi6
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73cebcb7649=
e7c2bfdd29fee955b192f143a5ab9
Gerrit-Change-Number: 2086
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <=
gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Mon, 02 Nov 2026 14:19:45 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--2jG+ivMj+VQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=
=3Demail">change 2086</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2086?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2086 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 14:19:45 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2jG+ivMj+VQ=--


--===============7299774191789112761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7299774191789112761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7299774191789112761==--


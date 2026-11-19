Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D53606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IFMCFZvj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GRyfKosP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LHSPp/IE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T+oH1LyA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RdokdRjQ7bfiynOf5m73R3IsmHZu4mafEZVDHGEBm+o=; b=IFMCFZvj27653/GT0TXPdfgBKa
	gKsCZXFe0tUjTJSDPPyneNTtG9MidHJALdAPFIf+15idYjwqBTUDZeSY5nM940K2OQ3WNxDhPiHia
	TV2XvpCjDz22Z19QGIBNyBUqHx/6p9CiM9TAiDMvsIFx6JQhWHRA9sbG8CgSlQhFkkss=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0Bt-000000003e7-06VK;
	Thu, 19 Nov 2026 11:20:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0Br-000000003e1-1fkb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QEpFwFMz5aL9k+e7wY/HuJD/3mI+8UMZM3SWBMIodDE=; b=GRyfKosPCeNRC9AradbGzweBOk
 F/LlrWAlFnAdyUNQomjD0zeGfMFJh5uH4MGn1Cq4Ng0eeCo49yQqxMmgUTpcd0oBmq6Eb5msetZvg
 mxZafzEGKcwFsTUMWZEWIxo+qBz/kwWi5MO03Y0YKUOu7tq2bq4aLT8FNXEoonKMrrVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QEpFwFMz5aL9k+e7wY/HuJD/3mI+8UMZM3SWBMIodDE=; b=LHSPp/IErP84flxOnIRlqgVJS7
 2scRarmVf+0a1fgxCFnQ7IKkK8EqN01Isn0x8AQnmFUUVagAbY+YB1XE1mVOR2aHoDpwuCeYh4Zvm
 iztAnlZ2jNQ70CBojjz8hgX3yUgzGjlEnDy/Oo94JD//9n9lS437KSNoZ2jT6eTpmklQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0Bq-0000000076T-32dm for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:20:31 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so792998f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795087224; x=1795692024; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QEpFwFMz5aL9k+e7wY/HuJD/3mI+8UMZM3SWBMIodDE=;
 b=T+oH1LyALOLTAcC6pjZbI7bt3+/vWx5j2Vmqa9a9i8GvscOTsoGxVJvu7251Ilc7Gn
 ekPMMBeZcm4OLSs2zkxqQ+MCEexubN9bWY6SxogYFbqP4uWYIy66Mrhsft66rhiJVxKZ
 gp0MJEOxjSlZlo4c2RG50o1vdXZMECWFwQ0K9t1s+Z3u3y8Ug/NxP9356iGktYF6u6R4
 P223Gf1Tg11/mlK4ohEqqOtgobmHqTYmY9mQ3wkNaHHyz7nqcEoMAaa5L/7o6gHgr1Pf
 YYjWD0Z3Kmu7sxsI3+8D5BHWnshChsC2h4q34KiOALS2zZY32D+fEAz+5jIzkbf2BBfX
 fZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087224; x=1795692024;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QEpFwFMz5aL9k+e7wY/HuJD/3mI+8UMZM3SWBMIodDE=;
 b=bXcX/Ip/npO0+1ySC+ei8DZNZrptvqkww+ADFm3LdZqBV86FQNF8l8MKqYp10ACIZZ
 eZ8k9ey1EWVa2o9lDmem1uu+X5cKsEtzFZj/HpVIET/iGT2S4guCekS5/FYDmSDjci4M
 QwiI4qT4qCfxMwFjkxvpZrvXOuNo0lo5FORF7okrSvCp8nUxPygm8/XTmntZWp+Fxngz
 DzraRfUEPLHrGgMYHGKLB5sZeTvd8EG7mHBNsLnAv2FlPgRv6XMUxRPFzB6TTmvMMnUU
 n7/9p/xFjA4ZjsZ9T7o/GvKhpuIN9eiFBDrU1f0XrwRb+Ezieq4g6DVTCMxfWPDCFxiP
 EIIw==
X-Forwarded-Encrypted: i=1;
 AL+hErGsPI6zVj74MPCo/FwbuCXSmlmZW3EC6oIc1SgXhpkY/IiClvttC9QETQqX8/PiT7+1yRpiJjn6gG3jCPwT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8jZ7zFcmN0SSk9vtAIX2XluZ8iUCrqQL53AktAaTId4oElh7Kl
 1CPiou8bcO4pJn4OI66HYKoXCobmSvhVu0gyIg9z0sV1be7SL059abNCKPX5P7dD1iiWc02b0us
 XIS3wXDusMe/RyHM+mYsl51dpj5p0St5XdqWBFnsTPuGxhe8lckfn3vBLrDMJJhAPkOor47oIC7
 MIv6wb1Q==
X-Gm-Gg: AZFdTZfNBHJ1BwGy9v93aUBAy1oYCOTK3KTu/9Mas5pFYxcfAEVqWXOzqNarto3DhlQ
 bnlcJ0zvaJ359afEqTxhiyXPOcEWcMi+ckVbmjIcI4Mr4bPqRXnD6mfu6Y4fGlaZf6DxgQdb3mu
 8Tq4Evgs0xLi7Lp3pT1vGstVGBSSvsuA7kk+nBNvSMHlVfe+D2TgWpxpDwJB6oX3Phm9wpU5qya
 A/ANWUEFheapkmSCCB4A7WE3kqj7nK3j/+l3bfbC9zMC1eV+d3CWl9WcIa8tRNOS34rUsE+uDKs
 KNodew0OTh+tlFqv0oBrAmjQdnyxkSzWPhxhzi6ujBdYLBHJRMmuKAXoneAHdDR9iMvaP/ugiGE
 7K/VyvwSFCoHnkPP7BI8EpMvsoGONtVqV5Cw5TnqMyw72d4MG/7+SIc7f2RCcJ0YvDxdfQmekNQ
 l+JExmo6fLA7hMPNI9X14zczZeXBM8To8hKM6SY36CMtaaP4lvLbF6xcWouCYHnD2SIFDHncFJr
 nXEZWj93mKUn3FtWZFPVFE4XVJBWVclDE/xz0xjAgQIf+H7w+4LM9n+vpGnRa4RpHfeKkaaDV1m
 iYCy5CBEX2FcY+Lr9ttQKj0sYcRu9Quz7XgDjIqubc6NUB7aL0xzFbnMA1c9yLRclTsefteCPLg
 8qN9pDNAKLZT7YG20JS8KIN3St3Im8BNxGdHyUYncl6YQdfoK8XLGPu/xDHJKcl3/9xix9Rm9hd
 G4P+3RBzY2oVPdmpFV
X-Received: by 2002:a5d:5888:0:b0:48e:5550:c64c with SMTP id
 ffacd0b85a97d-4a63a1e0271mr10757630f8f.14.1795087223939; 
 Thu, 19 Nov 2026 03:20:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6569338acsm10126071f8f.45.2026.11.19.03.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:20:23 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:20:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
X-Gerrit-Change-Number: 2220
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2220?usp=email>
X-Gerrit-Commit: 6131a57429a2bd74c378bb73cf696be4482e79f0
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:20:22 +0000
In-Reply-To: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDI0NjMwMDAwLkk5YTc4ZTU3Y2ZmODA1ZTE4OTZkNzlhMTdmYmNkNDEzMmM1YTRiMWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56d7c1c6a463bc46b7944c6aa4a03c1e6d368f47-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU0Bq-0000000076T-32dm
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: fix MSVC C4047
 in key_method_2_read()
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
Content-Type: multipart/mixed; boundary="===============0896447264128448763=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0896447264128448763==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DDYUmssauO4="; charset=UTF-8

--DDYUmssauO4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail )

Change=
 subject: ssl: fix MSVC C4047 in key_method_2_read()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchs=
et:

PS1: 
> The change is obviously fine, but I cannot reproduce the warni=
ng: [=E2=80=A6]
I mean on the original code=2E



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
Ger=
rit-Change-Number: 2220
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19 Nov 2026 11:20:22 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Lev =
Stipakov <lstipakov@gmail=2Ecom>

--DDYUmssauO4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2220?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">The change is obviously fine, but I cannot reproduce the warning: [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I mean on the original code=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
20?usp=3Demail">change 2220</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2220?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2220 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Lev Stipakov &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Thu, 19 Nov 2026 11:20:22 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--DDYUmssauO4=--


--===============0896447264128448763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0896447264128448763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0896447264128448763==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A8606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e4Z63U7z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fWBgnaz5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z2Zz1lJr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LFFjuPoj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0+54DgotpsT8/Al4Ez1Q+zfKnH4JQ9WZMxS9XxEcJYk=; b=e4Z63U7zgIvJI2PuTm04hs/Jhj
	Q7rlsndYywLxWLWMKqF3VXOIZfoISr5ffc3YaHk2cSB/cBXIhVrr9m7z1hp9eKQBorA6TpYRiTiOw
	wJZvK/+T/kEaBMCx3Ety6pSFefiG2PWpZQ6pzTeBGtEbAbzEDoxvycOI39eLeB2DhuOU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8c8-000000006mS-2Xs2;
	Wed, 28 Oct 2026 18:43:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8c8-000000006mM-0TFA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:43:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4vIYkDbevUZ9ackdnB7a6KGU78iZXzQbgc/CG88Dnf0=; b=fWBgnaz5t4xgWp0T3ZYtAXSRXo
 RjuJ/AZef/JUwytuoOK75+csEt3CV7Yd/S0AHp9GpZYuwNtzwtYC5GCER+nFbICUkxto3ORj0jpZ/
 iAWEfFJEK5/3gNUotSQGF4IiMHYyli2gQdRGgCDRRdwNVH1Q8ifjHPieiUzd/tAq5jCk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4vIYkDbevUZ9ackdnB7a6KGU78iZXzQbgc/CG88Dnf0=; b=Z2Zz1lJrMvPZBasLsMhekSUn0Z
 Ob1jQWqrROx2CkDB6L7069X+rxN54XUu7V+i6G1C/b0N9CDflz79UqdGgS6YTj8LpORGj/QcaO1mO
 ETsw3mIMDhY5JKigrtxzUe9oTtkyXZ09qO6k0oFsocHv95ZXtBBpHURoSjC7YuNydCfw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8c6-0000000018g-2csz for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:43:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so12545175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793212980; x=1793817780; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4vIYkDbevUZ9ackdnB7a6KGU78iZXzQbgc/CG88Dnf0=;
 b=LFFjuPojnrP7P8g1KH9DU1qkMWWoP//7e0X41lMlMppA5vGVOBjzsKc/gIfG90kb1t
 PcCzdwn4xRRAA2mjHi0MEFtW6BD81IygkL3IO/Qj8bQVXVkxFUsGv/mDwcezyWVb9uUx
 1Jee1MsyeEjeZSdymA4CLEv4qSE35Yuf23eDFj+ikyyu/zMI/YVB6yZwadaHo8xuHRf0
 IFkHCgT3IQqHN39/zLbsfkkEbkF7xt8/H6WIpXLw3bjpQ4L3cg3rWHJjw/k8v5smFYjz
 lbDLgrU+WFhRvw8Ye7GckkWfhJpY02kuBFAJlR/5JMzKdpgy8W5uWBH0xwUi18SR2X5x
 I9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212980; x=1793817780;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4vIYkDbevUZ9ackdnB7a6KGU78iZXzQbgc/CG88Dnf0=;
 b=vu+PTsLYiZ89uMxPZ2U0Ho8OKq6zE6ygaYuelB1JlATaPKrtVlZyMEu8E2BfwH8Huf
 GGVpyMiHQm1h8EUD5+PkQ2ouwF5nsNSZ07viSMgDDl1jGfGCS/+jDvztc59qSWRWM8Me
 Vwu9VvSHZjOjs9vaz47GLNkkuDn51AWTgQXdxLdiVZFJ4LojZnbKk0aDGbuPbHw1+l/1
 fYZUosmFxolwUEG46JyJ+PRmrS3lv7ejrx+jAAkdKvln0EWVePtbpMKkzGHHOgAb23DI
 +aC3CgGykpqMChA8u8GUWR/GHOD8dEQkVKGNtXs3d6kNiCCGyYfwA2laVpNThADkJvcT
 7IVQ==
X-Gm-Message-State: AFq9FYLStVaZ3vrYL+kYpZHgC4zoAcU1uNRuxhsAwy2MfittfhC2OEY2
 IowSdDD7bqex2BtfbFyfjQy6ay15OgKe/YO3VCSsmBHxHJuZVDcZAu2zeA2IGiWfGNj6oI78J2U
 Vsn266v41Wt5OV1iD50LW898e/q8pzuwNc545WPPfqD3dA9Ys7FWqFitK9VZf4lUbbsgjzC5X5/
 RffK0ARg==
X-Gm-Gg: AYBFou3vugYkMhJRSD61or56CuYWaAjRrOZ7hDGsoVFFEKSy8DLGEAJd8vKGrjH68NQ
 W7aB7kid1REGQRQay9bsXGbcfCxgCr1qblbhPwg9h8Ns9oCSRYI+90l4sFiYU6wg0ZRzjk85O5u
 3s8EBSlLKp+PzEeqssKwFSK0+tGDvmancpq2sIjlAIz2n+TUFk8c9AXxzMLDn9yINrmGBTEMh7y
 loXUDhq2zpdP8QienpnlksdHIxDybsYw1qnvbPOCuckBx6DKUT7aJYWxv8vh3gGvnbsviKuseeO
 DR5LJeHdAqrCwqtjJlN3ouuC7xrI9Sk17Vdo23bGs3sVnoUe8q5Kb24ukCGwi5oLaAdoPZ62L8V
 5cNiBOEnkffiuA4khpqWo4bPeXYu1Ywc9VGxUqOaCx5Mx2VjOEnU75ZHc8JFiAp44wiwcWymA8B
 ws4d2ybm99GqxQmSQGKKnhLg5Aaco3cghwBycJRl1kYI31NDLF8R4295bvpqCWVHEflWJgIApWs
 IGnEBlN2lyrpIpJLSq1DUoHTwnwVvlMRLboKvjuMIJWnDxmBiacTBYAClP3HbsJN0TNwlKdOOei
 1+WHuVg08PaFNNbaqJVCIMuArfDZ3qwqD50nBdoRX0hVxP0viuhZfe6dirIfWyoFt+R/kqx1wjN
 9XbzLMo2bpN0naQGfvq2NSaBNZNS6glDMM+82JGv0H+i5kCuZ1m3RcDYKBhz2OUuxS7Bx/Sh+2n
 3rGRPvWpznKRnuisI=
X-Received: by 2002:a05:600c:e558:20b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4aa87d702f4mr7424195e9.14.1793212979897; 
 Wed, 28 Oct 2026 11:42:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57594sm10409025e9.3.2026.10.28.11.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:42:59 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:42:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: 77f133502273c61ab3be90774f23d3ab9f03b754
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 18:42:57 +0000
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8d5f244674c34ff12613f576a085acb182c1093-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8c6-0000000018g-2csz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Track number of
 assigned peer ids and use it for max-clients check
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3528329113714046010=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3528329113714046010==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uvCauuZqwB4="; charset=UTF-8

--uvCauuZqwB4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2064?usp=3Demail )

Change subject: Track number o=
f assigned peer ids and use it for max-clients check
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad51b2f31e4215c58e160cc=
6239836015ea4d3cf
Gerrit-Change-Number: 2064
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Wed, 28 Oct 2026 18:42:57 +0000
Gerrit-HasCom=
ments: No
Gerrit-Has-Labels: Yes

--uvCauuZqwB4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">change 2064</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad5=
1b2f31e4215c58e160cc6239836015ea4d3cf </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2064 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Wed, 28 Oct 2026 18:42:57 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--uvCauuZqwB4=--


--===============3528329113714046010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3528329113714046010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3528329113714046010==--


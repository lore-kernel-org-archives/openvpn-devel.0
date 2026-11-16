Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE6606A882
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fPrYuEAd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ggBZ9LQm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cHJdIHim;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AR68wYmn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=in+9BLMYIGwW4aRUR7i7pP1bsytJnNIQY4/t8ABYvUU=; b=fPrYuEAdRDkUHKysLoQ1s0/FHt
	kImmEwR247XWNESpHvV1m8CJcsNakA3wq3bxA7KTUzcLXkSQq4Qnyz6mMYUO43giWT3tYiwRwlWk4
	Ax2qe3M6BaruQoL3+K5A/Omt1ZaeDATFrO+HlQfzKYft2R9IH0n9YS6C/3rKEp710GIM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwVi-000000000HA-474p;
	Mon, 16 Nov 2026 13:12:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwVh-000000000H1-1y0T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:12:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HExpOthh0bzC31jvJP+kaNbF1UyrkOaNmtJcuIBpIfM=; b=ggBZ9LQmdR+c8QQXqNx7/h4V7F
 VkX3GLg6H75dq+MK0zpWL/H2nBXG2xUOhxalTfFKHpxYfcmYIi+2itR3qJ0x1px3ZhCQ9blIDRb8x
 C82QV3yvQGc/KwnxxrEKABFeD2hguKhPMHAC7IbnqHmLbcWG5TeELmGO4M/qNUh7ogYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HExpOthh0bzC31jvJP+kaNbF1UyrkOaNmtJcuIBpIfM=; b=cHJdIHimQr0My0CAZfIwM9XYyU
 oLyY5+/MeTHlcukCOIr0O2ecTLVgQoypcrXyvkXIupYePAjZuNrAiKPvkPISiXPDFIKlgeTP5unPr
 5Y66mFN0i9/lRcu0kgE/z1+3zrYLgYcavEwaLnScrb2Qw0IndrASG+KusnK+NjUu16So=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwVe-000000004Zr-2tpf for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:12:37 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so2480020f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794834748; x=1795439548; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HExpOthh0bzC31jvJP+kaNbF1UyrkOaNmtJcuIBpIfM=;
 b=AR68wYmnJdy7E7+yUx2Li3yTZIvmSuiRYQMY+s1Ffm4E2bUto2bcRp8p7/deXWzKka
 6X2eNLy99vL/S1cDEc/i8ZwJX6b1N8SlUyyVhtPlj/VqmMMIsSjikAAzW4ON7GlAcnSR
 lat2M19TJYT5QelvlR6Ne5klKuMi3P54fa+/CgfA7Rah5KOAaxJi0nOkkhWHH2KUd9zr
 CURCkW+3DU83KKq8C7gbsKbmDkWBq1kSz5UwJkTB0FkakTPfGvdIaby0W1GuXRIeHB4D
 atu0/3/KqPHWyTKEgp56Fs3mjkYmTPnXfpEaIibJHJ62SZJ/dq6e8gMt6JBrOGeU2gf/
 8L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834748; x=1795439548;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HExpOthh0bzC31jvJP+kaNbF1UyrkOaNmtJcuIBpIfM=;
 b=WR7dFyByZ85WTOMkO9rR5iG1WhKFNHDwU791ye6iVruLYSPqtDfFaOyzuz5JeGhlYr
 k2TrD88/62LvAdLjOSM7EzbtBW96ZfXgbakPH3y1HhozafTPZiWUK2S0No2heVYdt4e6
 qUFexlgYOE0Lk85CXo04omi6qybox6MMSMkyvaGzVVOIxlj4D3yGLxe42qL0GJfM+Uk8
 nPIne9GzqjOTBUCBKJUe26QtcPUkc1ixcpL3+nnPTyR32J2l7fWHQC4nFL0CZMGT7LCF
 aMOOBk9D3HxQDuXXjkB/EhRWGO1cZq3pNMVuZ4i3chvfld9tjTx5cDkZp5oHCunDxa1H
 Dbnw==
X-Forwarded-Encrypted: i=1;
 AL+hErHPB5xdjLOtAoqyFeEuc1DzI1R5IubYzgLtRaA6THYtfptY6RCaURopVxLT0ucV7tmKlcKk+Y8DJE1D+51+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/gNO+i+Z3KxdKrDXfP+onLijVG5Ok88I03EZdXZUBGhK/qoeAJ
 qtEU5gWNIlUFakpB4UKbSxOgaigyNHShaao9xkhd136x8zoMzo7cGRzI5b3eywLEhwR5qLrGlVZ
 OuAQ7q0DGg2EIaipwJPIdSwWcf3+otNPJ8I9+DQPVoO0leRzAoJ+hip03mTwnGyHthQM4TkwxLI
 lg9GQqMg==
X-Gm-Gg: AZFdTZcb2XpzdgtKyn9PFHVblcdzHHhSk9opuCqZOkYd2vVW8LnU6Z7YxbNTB3jYofp
 KvmHqbmFnGF5EzDbLFO5f60B/h2lcwzBAQKBT/NKW4cf5eG5ixsk8/hIHJT7dOtlhN5VX+8AvBX
 GzdSKsbEqU8X5A2FBO0cvgWim2eH17skqGVw81Fh0FK/tHFCWv6GSdxKNvj0MfBsnEuvfpb0tS9
 wU8zOCrQF+GUvQJTMw3jsjiqOT5xeerLaoBeyNN8P4h7CDhgUgEwA5Tzir9CdF25NCKdSDkl2l/
 N4++9BktOSAEFmrQZYO24UN/G10H6MFkKpqiNrpayyFg4HvNb70bQfvoARY+vnbcTpIXloA+HDr
 nUDUvGWe8ZLdiXya//UsrTLW+73k731Uio+bMQPaXcQ6cvX2RjlaxFb91byTlQCM9fuEOlvNdy1
 aZ5F4hY9sYCsEyXulH5Vzvo+RsyKR4kogpIhUEUyelsSan56Ar8SuF0G6kdvetfMpDl74NJLQZQ
 ZRGYTSxGw5VooE/+ZDPIkGD1MIOKvRh1BI5K+V96crMniBBpNtTuK4GCZBPSk4WNR3LL/mBWwdT
 DNrQ5LlkUnRIDe9VMmbDczPh1uTZjX+7wcrF7XYFSAOCQUMUDSh3c0adjCoAYNBlXqQXWlA9jf+
 d7Ng6DvO5K/YKRINECMJJCA19LXu/Rr/OqmsX88BakvDgHcjHmCjzSByeFGt60nlA+FFhCUyoTA
 hr856JijUDIaU6Sxw=
X-Received: by 2002:a05:6000:455c:b0:48e:3c5f:a24e with SMTP id
 ffacd0b85a97d-49b01cf32damr20969112f8f.11.1794834747959; 
 Mon, 16 Nov 2026 05:12:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm23674291f8f.45.2026.11.16.05.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:12:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:12:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: 361eebdd53b6542dfbe737298db14e43e2950bd3
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 13:12:25 +0000
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95c99a88a809551a38ba43d1fd4273bfb9b04e43-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSwVe-000000004Zr-2tpf
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: drop
 impossible out-of-memory branches
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7934209056611583773=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7934209056611583773==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tccn3/9/gsQ="; charset=UTF-8

--tccn3/9/gsQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail )

Change subject: option=
s: drop impossible out-of-memory branches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e7=
9d7a3
Gerrit-Change-Number: 2196
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Mon, 16 Nov 2026 13:12:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--tccn3/9/gsQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">change=
 2196</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2196 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Nov=
 2026 13:12:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--tccn3/9/gsQ=--


--===============7934209056611583773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7934209056611583773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7934209056611583773==--


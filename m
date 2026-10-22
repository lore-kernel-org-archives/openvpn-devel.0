Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A2606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QJH6/84K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Bi440/Rh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MeZe4AdG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=b66Gh6CT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jbVZ/OMRXZ2BBUOYGgFWnVAISXHfzQSr6SnabdXuoz4=; b=QJH6/84KfrJxG0eh4IVRUeijDS
	Hqp9Kf0byDd2h9V6tcXl0oFUXJJzmGmtZyf+8Bk6XYX2ZuGtwj/EQhkMTUi+uxg3to6IYtUTRQfS5
	sQMHonQrTAQWkQnQA8xsoeyxotXBrN4QSKMBjsi4hAtOYSfOuiNc0YpSvK4ujFIsMZ0Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJww0-00000000406-16Vz;
	Thu, 22 Oct 2026 17:50:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJwvQ-000000003yf-2Xff
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9Y7azTazTs95FRjokC1FZDg8Eeti197xssavnfOVPg=; b=Bi440/RhCDRQL6ahOC/EGLbuNl
 v/JFh8l/14tSCRJIbpwNKvrAxspoV6nSTme6RHL1wKnzzAQF8C5axw0s8agCSTU5Vb8HHjhOPLXt6
 t6MDV6JBVUvGrD8FHy5FtisTO/8YOaQ5AzxDOme9PCvyCvlPlmha+UhVH5dog3MqV6Bk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9Y7azTazTs95FRjokC1FZDg8Eeti197xssavnfOVPg=; b=MeZe4AdGjsBi5eKTAuZ4I1Pswn
 4YBwAIkYpYNHx+cd6qTkV5HtjTbSc9RvHZ5OnEZfUHC4McOEFVy49RYvXBL2YaBnK3w5U8R9Bq0Jo
 AfHNOwGBNzEKhbJP8Tjcea0+ID6vxxhLLZWc6sMeH5u81k3MUVPYtDu/NIBRFqaXuY9k=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJwvL-000000002BH-3qUM for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:49:58 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so769825e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792691389; x=1793296189; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S9Y7azTazTs95FRjokC1FZDg8Eeti197xssavnfOVPg=;
 b=b66Gh6CTNjOdFDYV3z3VRHvHfWarVrOsNwnFU3rcpBkXXo1Y8QIZ2nrfT5I8OkACNh
 tC+1x8Cd30kvSY5w8UnuY8Wqa4e7D1r0WDTUW1mmtOgQ6RaT7X7dtzr9YFi5/RJZbW5L
 piCxuNogrrVXnDP0qZ7C1Hj6C+xUCRYlQD+YIh8zp/fMgF5Ss4UGEZSQFyl4lLQeDQJl
 ghW+zyP8DY4019xtWB8bHj9xAioi6/D3eLnSNnwRP0jRWKWqOXVjlMosJVeHMxT56gwj
 w532lk3gh5+T3AVF+264+jDxELNKLMeu/Kaw8KVzzrXOmy6FDJFpDjfPXbvOxB877vnF
 t5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792691389; x=1793296189;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S9Y7azTazTs95FRjokC1FZDg8Eeti197xssavnfOVPg=;
 b=CRJwY5DUxbPIEvFiyJZm1E7VLkrgjUYRPd5ifbv1LrJhtUBgv6eyiRA2z6cPnEm7O+
 lMT6/7pCXU3q4Rnw8n5oZKT3guQIwvG4EkyK0QSEqVuBz674eZtSQ2OXRT9pi7WNa3zm
 yYF2yQ+ZArVAfpp5M/pUemUzsrKu0RY4EKYsLKLuXCjvtfDBIAWdMcPK4WSvMWCLavqX
 XLtYL3eyLDP6NmDua3HdJTMcrRMr1xmyWQREvNflR03fPVIALYXxsNDUOzfm32vGrr2X
 jBc4Ix5WN6xAuqVK/wxWgi7IFKEt88K+g6mM8FchEXmjXYFj5YmJykLFfYDjsobJtaLF
 C3kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylPlF8t2ipXGSjwgdhqPF6SFoGvXmgdx+o8lTZms7k7XOdZZo6XQX1uuRu8BQosUFPwweebDgTwgpyRk3b@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIa40/Vwn+yGXfPGfiBjjbtSC7xAFTRkD41RW7hvm5P06frYBMk
 qnFxhSJ7DTFfIhy8sQ5kT9zSPZcxqVPr2CaIYfFSC1DDMezfRJnjWXRcK+CbljeGStJ2KTRwSPY
 uXgcfAElVhTleVswpGV7bb0rvSG6BR2MaGPnBySJ7Nes8lWYv1wpA4ccUwP1TQmyCf9CX
X-Gm-Gg: AYBFou2+6oZf4EZHX+dEC7MaQXROKERm1flGmnkH9nAIc69edJzmibrdASyeXNYKHpH
 WscKaua7ZQlBlM53kk0Nh0UQI0irmdPngDbso6FEzTQblBnsrCf3nXs7vk167OiY4PC4SOEM4y7
 bBmIr1kiKlfdbsgCKOBuxJrp/x+08I8DkMD73zYvmwCV+rujtk03gHmoWAZrgy4WQkXd9eOi6vT
 Md0K9HXaOJjevlQMTF84W1hrvBdzjH5W2bEYyn4cAqyu+m9N/xd5gvtYk9tZmo9NlfGcQSppbqz
 GDAv1aN5Laxm3ihTmMm2uCikGp6kP5WO2pzKQu6mDPuAUPi6PmyhQY4ZiBLQ7sO5c+hxQhRcY6S
 IIGlGLv6ucPm3XUd7RuxApB1M4+tLUvGNyhoejzQhpwLBGThjnHR7pgrmJsrpTQFyPaa+HALsOD
 SimCEibnBApl856PUypd4pztwGnSRecRHr1zmle+rimHwrXZvEXzyn+t1vQy4IqymJJJRnA8VJ6
 ObW37Ar7CHyMU8YyWdb8Xfkf2f8kyMMUuRGhK5kP5MDbeCvuw0PgXnYGs+i3bMCQSRn2pMOWnFM
 uzQmNGeSKwh5tXbzJNMSrPGzxg9WQ3QgGvMD6FVyUaBLmPvmKUQw6A06sta3b8mnGF7MJJnSeWl
 EHOECbpfxta6apVlyzJ12nP2zgkKzmlwIbd0azF1Ksg==
X-Received: by 2002:a05:600c:3e1b:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4a20059f587mr106764675e9.14.1792691389228; 
 Thu, 22 Oct 2026 10:49:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2102995cbsm13959405e9.2.2026.10.22.10.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 10:49:48 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 17:49:46 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 2063f63886796ac4afd05e7509268c03bbee5d3c
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 17:49:46 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c9d5165679ea8119def4bb824afd0e1992455d4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJwvL-000000002BH-3qUM
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7335167770587427411=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7335167770587427411==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gnZCadIgTsA="; charset=UTF-8

--gnZCadIgTsA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Max Fillinger=2E

Frank=
 Lichtenheld has posted comments on this change by Max Fillinger=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail )

Change subject: R=
emove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Ger=
rit-Change-Number: 2029
Gerrit-PatchSet: 1
Gerrit-Owner: Max Fillinger <max=
@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 22 Oct 2026 17:49:46=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--gnZCadIgTsA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Max Fillinger=2E </p>
<p>Frank Lichtenh=
eld has posted comments on this change by Max Fillinger=2E</p><p>Patch set =
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">c=
hange 2029</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fill=
inger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Max Fillinger &lt;max@max-fillinger=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Thu, 22 Oct 2026 17:49:46 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--gnZCadIgTsA=--


--===============7335167770587427411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7335167770587427411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7335167770587427411==--


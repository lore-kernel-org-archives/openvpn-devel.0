Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377F606A330
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YKGsEl2l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aPcMtPFd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R0+060If;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cvXgC881
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pc/JKXw3lUDiNjtd3LlQ5TBcnEWnOqSm2JSSpCBlXMo=; b=YKGsEl2lvfUlf1q4NyaS0GFgSW
	Y3hpbmhy87RwIFvaeg6sVCQl7dZEQFs9AsehbuWt2P7E0Ejo71nWP4WhlSQ3hIPkHN6A9DlJlaACq
	pa6B3dLo6tjiiSotsZGBp3csmrTcX/TJXlh+o+kskb6Yuz/xUqvPCecY2QmydRHGlM+A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTkVV-000000007OR-1BsT;
	Wed, 18 Nov 2026 18:35:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTkVQ-000000007Nw-0OG3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q8/4R4raCalZJV1h/jOIoXqsgxEmLyqhW5uVB6u3s4c=; b=aPcMtPFdMuRJrds8e+vBknIt1T
 PQYAl0m7mgnncFaQiro0/D+hEQmgVSlayHt5tg5d0eEf6pQO7YOt7ZcgnC4Abu4AYKje/F0WIJR1M
 8uMMkZUeuaK4NgMKhXJQR6NpRZdeMSWe0bF0LtdCy4exwXp3QTaOFhD20H5Y8b2Yzdhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q8/4R4raCalZJV1h/jOIoXqsgxEmLyqhW5uVB6u3s4c=; b=R0+060IfY2VRQxYBP8fGazMvYg
 7FSNwNqxlqGZHKfTVe24Z9ymsFVS1JDN8rk5wnVZRIZCRKsrfQxYXwyYQ9/MgwwdKs61O3NN8oK8F
 pkawK6bxApW15pqQ5k2LFj0sjNLW9SHtVrbRUy/xG2YsT1O94m+qdoy4RTNv+ScDHumg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTkVP-000000000QF-1PUn for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:35:40 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso1358285e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795026933; x=1795631733; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q8/4R4raCalZJV1h/jOIoXqsgxEmLyqhW5uVB6u3s4c=;
 b=cvXgC881g0FFC78fodM/be4HdlJiL7w4aYjwdFROr6S+Jyas6fQuu8yEG8EneymDp/
 YyE1qw1hVpki1AaGX6jotSyCdE+Dy7AZQIU9b9uQxwB6RICXIx3043Vz/x7ZLn7WZaIZ
 2In2D5HSZBgBF57MMmS+BroCu1bpaCx9c/paRijfdgcyuOzph4+IyS08q1cP/AGqCCXk
 wH+xGErpisudTeazx8Rpcsl/ys9pCOS3HYZ340/2j6lY8gD9sWei6rjpbk/MN+xCmRLo
 uXj6MTHz8dm/EYQK2LMU4ghIQ9cjITIPmKRWC5UpMTY2w3KKZSQIAyZOcDSBLSR8vq5V
 R+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795026933; x=1795631733;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q8/4R4raCalZJV1h/jOIoXqsgxEmLyqhW5uVB6u3s4c=;
 b=CwmtsKAAvAObRXDjJtaFV0LCI1P+PVRQtAU1XC6Bv1QNtJpiC7NCfrrh+5VCm1GmLI
 mEx+6mQ1s+R2s7hjK6n32kX8MiJ1FYe1a6SJwO4PE8d3/Zgb6xGIix6Uj7VOSel5FxT1
 4KT2PWOkodOVyVQvn3y8NhRt8bGPpHbFarYhjgJzsAyzCYPcUp87VUH3pg/vSIxrxeCK
 kCGdNjE51lIbnRqdmTzns0FAQjILLnPI9TIYdh0sNyOQYzlR1oLcX0ZZeZNceC9WE+cG
 a3n5S4rSokT35uEmqdl53qm0+tkiWq97pbUtcBE4OhGRY+/e+KAT0Jt/0XUgmcJKtUYK
 WjOg==
X-Forwarded-Encrypted: i=1;
 AL+hErGkFcFxtAXeyN3JVULuovVxGOsLynKgD+Sryk9igPg8t6rPVHAIjQW8JWWFibs1kOKL76CfXKmDHehyeSdy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/88/Y9uZelmRcN1fXrMnM/fOGpvGkdpnvzTFSmkYQnEusl1Wb+
 xpgkfzAOTqrQROmB4Bvwptv6OfQvUdhuDvkk2OKCaGp1qR6KTOK9wL6BRzSDd8xJkSorsGMA2JK
 fxqcmYBjo/cl+rxghMIOwSqPAoc4x4I73wE7wVZ2Q3YI4wQPbUnVsXwGySamO3OhM2Gut
X-Gm-Gg: AYBFou3mg5cFMgVC9v+Xr8mDiOIbwHl+hLfutxGLVd4DiawatKcZC0Gi7wTyFgzkbBh
 dNL5FN76KtH5/7nMh13CCAgcv/50DFm2zSlcgGcRtOH/8tT1OjZpAhAPliGAwn6bQm0AAL5SrTi
 NIxHMxirJphjXCjq7sZISzI932UzchiCrITbOhs5r7isalhKIKG7N5tAPmCFQtYRByQGLAK4S6J
 xoy7mUb1bVQkmJ4/gXY+PswkS/iqQcCC+PE9rroIU/v8L3BZu6rQKHs1rppQBdM3z0vXXzLqFfd
 ozrmdzRrmqanDsicYh9cVEbuv5+8McsA4SIl6S22PcVS/Laxtq9+fRvKFMVm8Y/6ClN5BAAMaaH
 4HdOq/TwqSWGAUblYmgCZvlMejteFgqs49k6uSxtYg5ijqWm2Stq/cr1OREc+KDaa8z2NSp7dIi
 JYzOpb3RTlzbsQOUOMKaOa4Bquwyp0tisI9282VcO8QqcAdSp9T4QWtbNvLQwZhq5UuKPCmLLr3
 KaVOmGKkRtSxZJJUcGAc6WuKyVIwW3MnRwvvXQ/tcBsOpJuECnsjLpPQwaoVH88v5RidNvIOTVI
 /JHBmowKfbfmc+UyoxVVIkXKhNW3m99z6haglFBezBHMd1FXrP1eWJAS2V67GamAjvlFCu62lPH
 bFpSHkkDOB/G2NjKajLTIi3w2AaPTrJjlOTCHTRKokZ4w4eT065S6GJ2YqanqyXT3kDRsKCY4g3
 P3
X-Received: by 2002:a05:600c:3555:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb8326a40dmr7435595e9.14.1795026932624; 
 Wed, 18 Nov 2026 10:35:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8324b7fasm7193375e9.1.2026.11.18.10.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 10:35:32 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 18:35:30 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 33
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 01e8763b95e4ad83bb9903fc6803f7b5ed7ea855
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 18:35:30 +0000
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2418c992899db0fa212e44eb797893fa03927f64-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTkVP-000000000QF-1PUn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4196855181353983032=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4196855181353983032==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Chm15dIAVpQ="; charset=UTF-8

--Chm15dIAVpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Lev Stipa=
kov, Ralf Lici=2E

R=C4=83zvan Cojocaru has posted comments on this change =
by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3D=
email )

Change subject: init: Extract init_tls_wrap_ctx() control-channel =
wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 33: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Gerrit-Change-Number:=
 1749
Gerrit-PatchSet: 33
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Ralf Lici <ralf@=
mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipak=
ov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit=
-Comment-Date: Wed, 18 Nov 2026 18:35:30 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--Chm15dIAVpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Lev Stipakov, Ralf Lici=
=2E </p>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev =
Stipakov=2E</p><p>Patch set 33:<span style=3D"border-radius: 3px; display: =
inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-=
Review +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1749?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; paddi=
ng: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1749?usp=3Demail">change 1749</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894=
c61 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1749 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 33 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 18:35:30 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Chm15dIAVpQ=--


--===============4196855181353983032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4196855181353983032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4196855181353983032==--


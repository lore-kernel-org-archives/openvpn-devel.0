Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE9606AA28
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VNErbqDp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OmRtKWl/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FhIYP4Jm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZvCz0K4j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=p+sWJKYxrWP11w2i5ifuhchXl06h8kJ8Mw3DQhfnaqA=; b=VNErbqDp0DC9syb01GdsCp5Vcu
	mgiqmExm74Nsgpq+R1TvuqzTNK8ruAGSfK1GTaZaH97Oo+C+vuQJ0xs/gfIG3E6HdLe/beJV+Atl5
	Phz0l+/EU5ozoUcMf+IVU9SJTi0Fwka+CSXda+s1I+/OeO7kOBjWnX475KqnQD2E8OqE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNr3Z-000000007bK-48ZX;
	Mon, 02 Nov 2026 12:22:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNr3Y-000000007b9-2pfe
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wgbj9eZu12wI/7awpJzDfb+pgNaka+PcEzgUA3Gw6ss=; b=OmRtKWl/w4AZj0iALI6r7owH/7
 xnJhzrR2zjkxyM5xj31ec/vHhUZTKEPe6C/U+Kd0rhqNyn9WWa694l4F+uSOE+dJv5gBokMKCGm3Q
 f4TbfoLaz5n1ZMbRJ+ZHOMfScbmYxJs5ytgsxtSt9EPpH9Xeevy2MI6X9rxPY61fAxiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wgbj9eZu12wI/7awpJzDfb+pgNaka+PcEzgUA3Gw6ss=; b=FhIYP4Jma0AGx8tPlbRZA9yVVy
 yd1NW5FeADVTpHlQe5I+lD4PIweiV94OdmeF+C9B502rQZ66GyMePrWXNRfA6+e7omCtzECQcy/Sx
 IY64D7mHhEaLrrhwsHXJbF+2ARzr58icYAUqWDFj475HzVmko8rFy9Sx0hDRLjYObPAI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNr3W-000000006aM-0xXv for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:22:31 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so2980468f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793622144; x=1794226944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wgbj9eZu12wI/7awpJzDfb+pgNaka+PcEzgUA3Gw6ss=;
 b=ZvCz0K4jty6fAHWzC+VgrTNcHNb89vm9J3+0/zdIqiI/J6EiOvBOEyl8GOb7bXMXs7
 REzMFu1xZuPsWpeIYtrBMwFbBVsHQC9/d5wBeugKeVT/G1m9c/89hQthhjof5YQrKdGQ
 Gx5SJii/tUYMKoX4unherqQ01objffKSQpRa+EuabxgdS3KdhKxQ1YBtnV8ADxn19urD
 lR8Ug4QlV8L/5nD3rxHjqdghuLkm70Vi56O5YPiaUnzPvrz27HxVsZgaraZbE6lXofHV
 RUr7cJwWHpYNxNvWEiHWVVBHpU8MAK5cknEyFRTNT68fu0cHRJ778OM3BL8L8AlkwBzw
 cUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622144; x=1794226944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wgbj9eZu12wI/7awpJzDfb+pgNaka+PcEzgUA3Gw6ss=;
 b=1dceDN4H0lL2d93Um8TyvqNarV0Ru7VG33W6VIMTfjwYlsAptBDYtcus+ZRHh+rYBn
 CUnJS0F3ajNCyE8vThL0rthgKDAgnNJILyE+kqVhKkNFHSRMWFYSBzcJatxXoc8C3/3l
 R0lu7CpnnCDRic9FYFhF/cO0iHPAgQp40ppa8aAEuGROZixtOSHjbCUTe7gB4AMTYGfV
 1a3iKilVNRGa1YasD7YCit1bkph477PlaLFDiDnjZbOhLBTtw7ye8hBrrtVHiOPZJmhs
 Zswv2nEJV8vS/E+WlS7JgbdkYk3B9tx6f2llZv9AMJZqXmJ9BaaiiF3DODXvMPjwkbdZ
 hdGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMEu60qDjMp7Vg1IgGTu2ZFJ8aLGFuz3KUQIB1rreuZMhF+nUiwdnDadkDgdstFXLZ97vDaubbs6eukR0w@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKzOOkVXUGQfWXv82s+4tOKRKTE5wd1UoF0dAuOAIU7qE9apvyK
 hb9ZF5wW5qaNtgrCM7KG6kKE6/1WzdFd5IqTa3cthP5YmaUno8y3wSfmygFZ5VetCXWnXYbXYrr
 qd1kPJEshGeUnKfIpubx6ieEk7TRnSENxW2WWn5+vxz4yYPjWMC0ryqmHSmX497roC5RoA9IsY5
 Q5mzXhnA==
X-Gm-Gg: AYBFou0hpYIA3IwHP35Jld4NK50gRAN2otKIiOtNgZZzhmlXGiaxwSUFF4apr2n8VYJ
 Y6oQ+5ghwYL/NHLnd+a5AQZ4F1OzG1wAABLTWJ9X6GvItSc6sqUwxF7znqMej2c/70bA2749oyk
 3SgLx/N+3hEyl0vYlgVx3ytpDbD6hRPDJvA2OX+1hdA9MXIkkg9wcAz/T2ZBCXi8hoi84oyJFyK
 U57oCJzmltPfeSphz7x8QwkdFj+bnfgwJVeNOTUq6zwgzvAYPuUtp1XD0kqXQIXcwINc2PDTgQB
 ZzKPZar6XSuT1sp0AYJ/AS6+cztOqSKlYYkfQ7B6R9Ay3fbJ+bFQUlcYIYF9+Zt7mELvRkI4lZY
 7awiCXhrzGj2CLrkIA1kH0eTwbuR932mExbQS3AVJyracl3WUYV6z/XQfaz638HNuSRnmd+r9QQ
 7Nesrr5iHw+ko6ZVlf+N4R+55BmzazaUkD5nKIcvslWQUMbyayUeLXRi4j3LfkLaa4agm1U0aCQ
 SukPmtvJwKYCKtEaUSOtjZ7TbVBoyV2KF++152XERBvMRwj93nG2dozqNRovmug1d0GA1y1L9GC
 2OMdJLoJjuQD1qaFEgGYUosN7aUbS6ZzCLcpWQjw2Cn+djXmAQgclBYd5H9zEgKb3DuyAMtjZkh
 AV4sQJ9vVAzXhQZHiy80QpN2HSIqX2Io4O+xgcnqGob5oTrXsjGQ5RhY1VVzh1t4Sl0gtBgE2F/
 ItYQmJJC2a9RSh79PsOtk/HQ59+1o2CGouaoU7
X-Received: by 2002:a05:600c:3554:b0:4a4:7a8d:c436 with SMTP id
 5b1f17b1804b1-4ac17470fdbmr227308565e9.11.1793622143443; 
 Mon, 02 Nov 2026 04:22:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm346605445e9.12.2026.11.02.04.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:22:23 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:22:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 2c288d527374c38f44541b24f54c56ede74f9750
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:22:21 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <888a7da648c78c545fa5aa3b3ea29fce8ea2e8fd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNr3W-000000006aM-0xXv
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7827928470463065659=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7827928470463065659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VOOwSZLBt/k="; charset=UTF-8

--VOOwSZLBt/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subject: Remove replay-per=
sist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1:

(2 comments)

File Changes=2Emd:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2082/comment/97a8aec5_08e9cafa?usp=3Demail :
PS1, Line 36:   serv=
er mode and generally was a nice feature=2E
> "niche"
Done


File doc/man-s=
ections/link-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
2/comment/620312ef_0360760d?usp=3Demail :
PS1, Line 443: --replay-persist f=
ile
> Please add to list of "unsupported options"
Done



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce9=
3815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Mon, 02 Nov 2026 12:22:21 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>

--VOOwSZLBt/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/com=
ment/97a8aec5_08e9cafa?usp=3Demail">Patch Set #1, Line 36:</a> <code style=
=3D"font-family:monospace,monospace">  server mode and generally was a nice=
 feature=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">&quot;niche&quot;</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-secti=
ons/link-options=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/620312ef=
_0360760d?usp=3Demail">Patch Set #1, Line 443:</a> <code style=3D"font-fami=
ly:monospace,monospace">--replay-persist file</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Please =
add to list of &quot;unsupported options&quot;</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fc=
e93815 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2082 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon,=
 02 Nov 2026 12:22:21 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--VOOwSZLBt/k=--


--===============7827928470463065659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7827928470463065659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7827928470463065659==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308A606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m+nD6I7O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E+DteZhq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MP/+ZglY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SV/ZsJEu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xpSoGqXHkwZYG1HTJ/VN+9AHpDR4SSYaT0BSA4Ff+M4=; b=m+nD6I7OBzNq6d7wQqnmBVT1wI
	+T7dN9q1H4O0gSM9ydKkAse3u2fQKI1OQ9fhbXtGzYOCkMwskKLbcQglR2V2ziw3xDAtTa3RTuozX
	lKTEmNCxnyT2lLFgIFYlaRgx81gNAiSm6aI5HIetVAr0YJQ+kkFF7dT9qJZ5UI6azM78=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWU4-000000000tF-2nTe;
	Thu, 26 Nov 2026 10:13:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWWU3-000000000t9-1y5a
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CAk4kuQskWOpwKDVB3F1YOF+h7AzNWD2XLJNnFpNuzQ=; b=E+DteZhq0vy7yGUonwGjycIVbr
 vQaWVQCvbFf5sKNAHOfhRm5Zz9R0KNgRT6tFJcvt6y0viPP4sQbHYfNeOeonnUncrKFVlTJMz2O8J
 e6AcOpaDuA4Y/a2zNVSKrDDyCr6If/IXe0irnWDXDst5epw61gbDEuABws57QAGRIMKk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CAk4kuQskWOpwKDVB3F1YOF+h7AzNWD2XLJNnFpNuzQ=; b=MP/+ZglYAghvAqQTaNfrN7KpNd
 BvXmbzuAjQZ4ZR4nfimic88s1BlGcY+oT6A2jWIOamKUxAUNL1e0+4HfuCD4+KIUJ+xtwZ50ER+51
 WFimu4r/BUgM0Ybvj5D5w9Hr+EX75Tl/7XEMP6QszXrqxt1d4LvGy9pvXL+P03EX+9+U=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWWU2-000000006h1-0EGF for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:13:43 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so42378315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795688015; x=1796292815; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CAk4kuQskWOpwKDVB3F1YOF+h7AzNWD2XLJNnFpNuzQ=;
 b=SV/ZsJEucsATEb21EuFc5XMJG25pt9sgzuwnjI+VxrQo8WEv+V1UjjiYowz3A8qF7C
 xWpwtibLM0j7ny+xKP8LjIY9Hg3omIM05atrWvHSzOQewQ39fVU1qkpvgfo7R0oqw/2Q
 lsbMUnJfLGkfP3w4QuaEWQFE8hW+mSRjedyFwqjfdFpiyAL8/ZahXzJlsmvFKuOXYpWJ
 VHsDV9hR3hLs+4dwCY5J96aiQyhUeyr+WiGNEYa/2QJxSU+0LvMKlIOkjyFvfD43snz0
 tj1nP32TQ4Fy2fdkli6VJZAf6niqzROTiSQMkpgkLbtkWaDo8GEAftB2NjNX3bfuZccr
 SkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795688015; x=1796292815;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CAk4kuQskWOpwKDVB3F1YOF+h7AzNWD2XLJNnFpNuzQ=;
 b=Eoeg3h/WhH7Lrpsk7hiR5yaGb7llUWtrHz4G4mnegi53rKURtX5AfHGom8Wq+GesNj
 3c7tvrgvgAU4jpgmvjH2x+bBBSCe3Tqou22XysTlDD/JUMYFkkUR9cCuTCMVYkfo+iY8
 hY4vBEtwV0pj+P1l3zBSX7AMc/np5hjoZd1Sql9G0MKNc2xedXYwJaYJBScLEcKxRoEF
 sPKfolnYYiH56iq/EAsGAuFqlRiudnCBMo/nBC/yf/nuxksjWhUVeEnBPE/2U2bYWjhi
 IlGs66OmiDV6dkDdHSmt6TugCLBh4Ry56LI15agZprLc5D2fkDa3FjIxYMcX9R091Fi/
 pDPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF2eRui/Wk6pyLho1K4dCgexoGP18xiKHyTiJ4LX2cQKT30zh26xl0lo2St/Zty2QY+IbBRzy50rvGgQ7kU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/7KWbuMKjPbdppZG0o/Fd7UAfG6DOivy8kHP4wIZQ150Od2BoT
 XkY+dWCxz82lF1515+gZTXKOmjplyvYcItmI868bLGFpwUW/XMdO+pooUWUFhmuLcTQR1mt4nBB
 NmsF/Vi1vn6orpqyFGA1RrfKLRK+Dxx8t29pwzen7AJnkjOHxQmvZuakujsyy+a25XUY2FForWx
 3+f/ZehA==
X-Gm-Gg: AZFdTZfOlKXHbJHafxIXc2MGkadewSct107pOb/tPG3c9ubejMky1xeZSGV0uwplu/6
 +8ZdpNOeDFyGCRPbcMutpQ7HW+K+f6O3B3XOY6+EfdP9fKqfzw6kxQBWCE0AXOlRMY6LAq4AbSn
 NqgrfsO8gbrqL9O9gLh2BbZMjnOmQ5rDUjmJvtT635+fW0/+GUNRv2YmxKvclgGlh5R3goX53GK
 MYX4oAWzQe/gj9v9KyE3p81gMmZ8lMgP00ndzYp0Sjjmen2BK9Dj1kY46zdzWA22Pi2yMYZL4SN
 QVuco+ZkKxdnXcrlFykTyQn4/yDtsY3ekhI0lkMBZ3lzMjGMyn1pIRM7Bxbqd8YRQ90TPc54hoi
 O/xYGWZ0cIdiRO9e1HgPlksFNxxdLl64dPNcOHV1X74oMAKzjR7C4zzP4eeuZw8aMyMpirIGbki
 G9eejAsV7SoADY/RLNnXFEGckpk4NjCo5Cb3a0OrufeP2ydTONhpnV9eYHk9/wMI4c9oXuZ/F6t
 DB5IGvrLNu7NINRcmm02hZTO21xcpQP61S4DzETc3iD52yWlnRhTsRPaCE9EM+sJJTjI9Iml5bm
 Mw0dRUqiqGMCoNTXCgDVpiw1hKJjIlrEuKgPE/j21SQOt80Gxjp2cwa4iEY+mZ1irNmGxOhWrUN
 rhr9zoLXNjxScXncqVRkkyXxo+vXA6HV+7NlXUJz6erNjQ9H1tkKgQeWytxsF5ttAOXy32yHjjW
 gejhrJ6wOXELmBiiY=
X-Received: by 2002:a05:600c:491e:b0:4bb:5f12:336a with SMTP id
 5b1f17b1804b1-4bb8614f0d8mr326925035e9.10.1795688015317; 
 Thu, 26 Nov 2026 02:13:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm39892953f8f.41.2026.11.26.02.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:13:35 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 10:13:33 +0000
To: Farshid Rezaiyan <farshidrezaiyan@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic667de6f830fa86e2842f1da2820e1250b9d6054
X-Gerrit-Change-Number: 2350
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2350?usp=email>
X-Gerrit-Commit: 94c2e2c986d1ebe723b000e433f97fa6c6fbc696
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 10:13:33 +0000
In-Reply-To: <gerrit.1795687157000.Ic667de6f830fa86e2842f1da2820e1250b9d6054@gerrit.openvpn.net>
References: <gerrit.1795687157000.Ic667de6f830fa86e2842f1da2820e1250b9d6054@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njg3MTU3MDAwLkljNjY3ZGU2ZjgzMGZhODZlMjg0MmYxZGEyODIwZTEyNTBiOWQ2MDU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d31e08bdb460b2af12b8d3cfdad45b4d8d4f463e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWWU2-000000006h1-0EGF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: call
 client-disconnect handlers when late client setup fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, farshidrezaiyan@gmail.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8213115573723396863=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8213115573723396863==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sqvMpkfqnjo="; charset=UTF-8

--sqvMpkfqnjo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Farshid Rezaiyan=2E

Ra=
lf Lici has posted comments on this change by Farshid Rezaiyan=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2350?usp=3Demail )

Change subject: mul=
ti: call client-disconnect handlers when late client setup fails
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2350?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic667de6f830=
fa86e2842f1da2820e1250b9d6054
Gerrit-Change-Number: 2350
Gerrit-PatchSet: 1=

Gerrit-Owner: Farshid Rezaiyan <farshidrezaiyan@gmail=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <r=
alf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Farshid Rezaiyan <farshidrezaiyan@gmail=2Eco=
m>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comme=
nt-Date: Thu, 26 Nov 2026 10:13:33 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--sqvMpkfqnjo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Farshid Rezaiyan=2E </p>
<p>Ralf Lici h=
as posted comments on this change by Farshid Rezaiyan=2E</p><p>Patch set 1:=
<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pa=
dding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2350?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2350?usp=3Demail">ch=
ange 2350</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2350=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic667de6f830fa86e2842f1da2820e1250b9d6054 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2350 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Farshid =
Rezaiyan &lt;farshidrezaiyan@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Farshid Rezaiyan &lt;farshidrezaiyan@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 26 Nov 2026 10:13:33 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--sqvMpkfqnjo=--


--===============8213115573723396863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8213115573723396863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8213115573723396863==--


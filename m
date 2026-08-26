Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5317CC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nW6b2QOu8+KJb/Il1Z2i2Z17pSK5Twpr3l2m5cP2Uio=; b=MCa9aPa/w7jEbFuO/sDbD8FLJ0
	qmNK7NyodCL3wQ3xfrHUJQFrU9SkmcjEikEYkAA3pKqjMzq+zvdLk3LsrGP0VYboTngH0u/C/meAL
	sFKB+jbrpEnt7YNy2JztAqH0dH2oKyGTpK7VvaAElzyQ7oWim2vwXxIrFyKFyRIx1U9k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFun-0003b2-6c;
	Wed, 26 Aug 2026 15:51:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFuT-0003ah-Px
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:51:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tGEOkUbhb4QozmDyJ2KLzr5nPVZiV2rLZEeOOMbCtkI=; b=X4NQQFTyuH/e0fj8YYPEDemz37
 XhafHyMR7I3acDUZEdVT9TqJ5hgPE+kGEIiS1fW3P3/rrm1YfCOijroXJVsPq/ov6ysM5MgfJYKlM
 MiUauRoEiLDjYZ+R+dcNqRwdGYXRLF1JOXrTAlUOWPNU8+iMppTjoedbuTxT4bpUJ78o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tGEOkUbhb4QozmDyJ2KLzr5nPVZiV2rLZEeOOMbCtkI=; b=N
 pQ7+M8eEF3IfphtmoxdGWOch80ed+OCtRZfx0ZHe2xnK5X0lYNmvh0O3AM2cabrHJG8+6Tvq/0QZW
 kohtfbgIu3WM724NCk5bTMaYhXBhAVcmhQUKWXu0MFNTDJ5sZb9GjzheGeCvtrP9touqNZ9W3yJ5D
 yAGfa/DuZQiK89nQ=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFuJ-0007yC-BI for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:51:20 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso170631066b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787759473; x=1788364273; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tGEOkUbhb4QozmDyJ2KLzr5nPVZiV2rLZEeOOMbCtkI=;
 b=hCnPdlWaTxXTJDsdym1Qt7YxLzUFUhg3nwRY5n4mkXNffFAnjV8Bu9eoiN2PA/0qfG
 AeTORZL8rrpTctjTQbHHR+uh3Bg0KVG5BqcqSpiHgcZkac/8ZguFOSjsKRyK3Ejjb/Uj
 Zn9dCHLlejAxL1W1sVTgALnOox1UPizbH7iGTqQul4lmPJp3V3UJ9Gaq3IsdWNXfePne
 TjjI8c4fPbw24s4/OqCb0PSJ0LxnrmGEeK/3AkLD8mK3AZrrHx+qmVdSedHELHtTntJa
 /oYAbNWmtlZhWR+reJ1x/6Fv7sKaFtq8p0SpMthThgf3Fs2FOS7U0M2yo/4d0x2qpWVA
 M+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787759473; x=1788364273;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tGEOkUbhb4QozmDyJ2KLzr5nPVZiV2rLZEeOOMbCtkI=;
 b=DAg9KnMbBTpLGC2qTnr5gslL4iJPcBXF4s02eQJT27WjcSDokPdOeSE7f6eWJSXiKb
 smCzS8u647q8xDtnGiex+03ibSaaPYJiRCozyvCKDYXmmfUk3pu7/4h9Nrv4euE42zTB
 QN+cnODKqUVFyKBB1DyfcnPI1g/ZN80WxUEh9PCulvIXn/EcYof1oHfKt1ApJBO+jdSB
 oWO/Iotn5FRAgjVh+f+xqo5a6U8/2xQeooW6xjBM+LguUqeMcTlTdMKXh1vYssujdMUV
 bME3ry5Yrsx8CmtZgg0wBcVJSRgbLnXZsrI0+ASKSw1y7NViM71uF/MVHbvxdqtM7s7S
 Ez8g==
X-Gm-Message-State: AFuF++lqa7s24MdHrohE7+7XEem18m654xzGzljvf5/mgdlCHo3pHfPk
 jjfDuL/JK7OvGGSwnhiPe+jO8aGEv5f+QQmSeF/R8kI4lCy2LDWs/GybYELGXIcY5o2fPpQwrMf
 C0MXOIzfks0PP4Cv4PTlCANyfVvu7wd1Tca8W3O8OCAboOf3tSyRYiWcYnyzFumgu0tvoUhdRHT
 0ddd/7Iw==
X-Gm-Gg: AR+sD10xd7ELmivy/bBPvpg8oPKiA4O0PsQU1VY72HkYh9syyccxncO/CwmroSL7g7N
 LYA2k5c6ogO1qvqwbW+9eIH/1y+mPKdcAv0oyp9awxHZovMnwwf8lNZW/VTtiogm96pNftLwKKe
 GWa+pg88A3DNj3f/yLi4f9iMAt7VvCU3LUgKJvjgtAuybHgP05D8oH62eceyFv280jB2BV7tDCP
 wPysxdCLdxgCaAfF8K/Oqfrwi8uOixG8NFy/F16yjsue1ENwKwI4RQb+iAld6Oxb12LrU/cyIGb
 7SmaDXRL41ZUtFDQMCpHZ30IVSv+uTjbYT79/i6D9hnjQK7Vl6H0IVjZZ0SpPGN0Lj1gVqKxwTr
 B18+OcyhtlCvOl87DRCcDw1gfVbRVy/bpohJqD6wfScvgFGyauOzct44teTVfUpI61vXKxvUuY3
 6yxGhYJl9utKW3Yo0eD/lNiqI1+a6nARRoko2+iMtvGFA5doIRTyZy4LoTqJE5ueYzCxnWpDxCs
 4gPPBXvIOZOHTNtRDqw8SiuHtdtNoEBWJmZ73DJ5AWfQixTWNd9TIswmWtxQs9fE7YwPpINtyQk
 Jzy5yLFqpHCwiXlywsnTuEd+4nJ4D/2jF1f1mAFCbCvn7nd1Ru0=
X-Received: by 2002:a17:906:628b:b0:c16:66dc:3ab7 with SMTP id
 a640c23a62f3a-c250c4f025fmr776120966b.10.1787750634331; 
 Wed, 26 Aug 2026 06:23:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a7303casm660728466b.25.2026.08.26.06.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:23:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 13:23:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: ae69bda99914f727fb69583d84c44d0aa04929af
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 13:23:52 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <15bb2b1dd95c15219c78ebbce6439c2ae38b2214-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFuJ-0007yC-BI
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1813225840977123289=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1813225840977123289==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L5BKopwHo8c="; charset=UTF-8

--L5BKopwHo8c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858?usp=3Demail )

Change subject: Implement sending/receiving a=
pp custom control protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 7: Code-Review-1

(6 comments)

Commit Message:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/24794c39_d6c4cd0c?usp=
=3Demail :
PS7, Line 8: 
Should probably have a more informative commit mes=
sage=2E=2E=2E


File doc/management-notes=2Etxt:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/581a5093_d86412d3?usp=3Demail :
PS7, Line 8=
04: the common app custom protocols between the client and the sever and in=
sruct
"instruct"


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6=
b2bd590_3c14cc8c?usp=3Demail :
PS7, Line 814: This commands sends an app cu=
stom control message to a client,
"command"


http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858/comment/9e7ad244_cf52deae?usp=3Demail :
PS7, Line 829: fl=
ags    -- a colon seperated list of the encoding and the flag if
"separated=
"


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/5defbc51_afbedab=
4?usp=3Demail :
PS7, Line 839: This commands sends an app custom command to=
 the peer, the format of the
"command"


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858/comment/2746ddcc_8b99b4c9?usp=3Demail :
PS7, Line 839: This co=
mmands sends an app custom command to the peer, the format of the
It is not=
 directly clear to me why we have two separate commands here? One if for P2=
MP and the other for P2P? Or something else?



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit=
-Change-Number: 1858
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 2=
6 Aug 2026 13:23:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--L5BKopwHo8c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 7:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><p>6 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/247=
94c39_d6c4cd0c?usp=3Demail">Patch Set #7, Line 8:</a> <code style=3D"font-f=
amily:monospace,monospace"></code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Should probably have a more informat=
ive commit message=2E=2E=2E</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58/comment/581a5093_d86412d3?usp=3Demail">Patch Set #7, Line 804:</a> <code=
 style=3D"font-family:monospace,monospace">the common app custom protocols =
between the client and the sever and insruct</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;instruct&quot=
;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/com=
ment/6b2bd590_3c14cc8c?usp=3Demail">Patch Set #7, Line 814:</a> <code style=
=3D"font-family:monospace,monospace">This commands sends an app custom cont=
rol message to a client,</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">&quot;command&quot;</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/9e7ad244_cf52d=
eae?usp=3Demail">Patch Set #7, Line 829:</a> <code style=3D"font-family:mon=
ospace,monospace">flags    -- a colon seperated list of the encoding and th=
e flag if</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">&quot;separated&quot;</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/5defbc51_afbedab4?usp=3Demail=
">Patch Set #7, Line 839:</a> <code style=3D"font-family:monospace,monospac=
e">This commands sends an app custom command to the peer, the format of the=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">&quot;command&quot;</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1858/comment/2746ddcc_8b99b4c9?usp=3Demail">Patch Set=
 #7, Line 839:</a> <code style=3D"font-family:monospace,monospace">This com=
mands sends an app custom command to the peer, the format of the</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>It is not directly clear to me why we have two separate commands here? One=
 if for P2MP and the other for P2P? Or something else?</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit=
-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 13:23:52 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--L5BKopwHo8c=--


--===============1813225840977123289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1813225840977123289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1813225840977123289==--


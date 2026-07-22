Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB82BC44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1UX50/6JH1IAWVm0bvBWaXfZerMaCIi4v2gn22OBdQk=; b=MQrAHTrwtBqIjxxWvym2vFZjOC
	KJW/I9Jb5QTxAJvm0TU2FOoHCESNM8kYqmjxMb6U7LFsGd9JWFkoS/yadnSD4wcAR87NPOpddHcCn
	4REfmnpO8AOeC9dPZMnVNMOWq2dnKT1GX1X/Vex0pHU+Qfee6rAEuWeJRU8gN6MnFezY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmTzw-0006Xw-Jb;
	Wed, 22 Jul 2026 10:16:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmTzm-0006O7-V8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l60luxpG8TcMKsZRs7DpwCwN89PttWdoqYS8rVJ+eZA=; b=H9m3fHxuhMiABG5JtEPMK07AU0
 qJplVLRg0vmNN8Zm1UuUYKAz0koPh3lxHQ/v8QfhzzhUHGQgTDooxyP53Ru78EKnHxvX0EieB0boK
 Xv5nPPBAiXtuyabEpj+UZ1ZwD4djC+tryK5+f3+iqXkKgEKcyVq8yRwzhIsp4bVG9Efk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l60luxpG8TcMKsZRs7DpwCwN89PttWdoqYS8rVJ+eZA=; b=Y
 dNN3T33QQcDdX7Lwy6ExZG5LRVjGT7UaTYkaEUySu3JCvThpY6XMfkN8M7kQ2ECRZkvIOWkO/vuR4
 ir2FqMrHy2BKaK1Nu2nSBmZk1e9/4zR8ScXBBSN+zl6Wih5JmtNZaK0hkebHq1y2Oc1omWy3jbZsr
 7Yk+0QBc37JvQ2N0=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmTzj-0006xz-2o for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:16:08 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-475417f010dso7043636f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784715355; x=1785320155; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l60luxpG8TcMKsZRs7DpwCwN89PttWdoqYS8rVJ+eZA=;
 b=GDzUPVLzXdNs3w9UdhLJPOzJ0JQNiw9sHMvIiPrB8qrG4ViEJwBtv5iqek/EM5LVaZ
 P/CgXVh0OFgnkn9O+y0xd3iH/rNJW3mXNxYHBsnoB3yWRNdlBMFAzNoIuGQ4biBr8BuV
 MVjHF6oSx9ZFLLHYx5Lel64mety4GIv+KVDFUmDG1tMB2Tq9QjRiHO0ps5vJ82I5tqIq
 fvwf92cLvP58czyKaZdZkCphkR/bKFE9hCyzteAzI5Vbcn0mycH8F3eV+UUYgZ58tIsw
 PFCMXp+8aMOmdd8xmzHqDPDgby3FVcxBbwTOlj0xT2knpZMDJhDVe5N42FmbJlh7Uptg
 3sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784715355; x=1785320155;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l60luxpG8TcMKsZRs7DpwCwN89PttWdoqYS8rVJ+eZA=;
 b=PVPME3A+RdS3kB5Yih5FagM0qaFTQ93+njrsoIOWeO0LfnWK4UHYPw8ZO/jjwLq1J8
 0YUrRDl9u2RI796OpI+eK5MQS8hyXAaUIP3YjWxvpcceMFkuzYeXdfM44WBJOguyEqeo
 jz+vvFFQr+FCbHIvarmTvQT1SEiHYtDXQT3URkJajlhCzDh8oymjvl/P0S8ojrOTmcNS
 9/L18ogHIKI0yDhk3o02H1StCGhUhwz3TlrzogLinx1qif1SecoBXuWfSDMC0uYEnPxX
 2uZJF8uaaF+3L8EF1AUo4ee17cKolFCeVlsZLPRoAVMPzbTfb154DDzD6DIuYNLoc/Pk
 Xn7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp59Y89LSOhOoeQKTgJGPAGn8ydqNmgo+nFbH6/QkAjFbKQkQhRP7gqCamHtKy2o3nPkjjCgTprht/Eg/7E@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxY63ivWI4Hmbb/IqW7Ug564QXI83h4d+J3bMeGPZ34cZm1y0vu
 Xm4rsBE7UGmVZ/bd/EhLLDXs/e4RZGQCpoZtWeZSXV12XS1kNBts5vg5fKRpMc8yi086E/KdeLF
 zXBWI7bHrYcywJ7C2dgr2S+Yo2LiXe+BCEQFUgGjYnaDODfh4Larrj2NDkZsOUi77zQbooKkqn3
 aWbNWklA==
X-Gm-Gg: AR+sD11ehfZx3xqIJkizdMvsqZH+OE5HVeKVZqUj5zP0UgWeKyDaHD1oJnjFWyS3k3l
 bRbPibrCtHSy5GiSRvvY7dQyS0YRmMsFcI/ccWb5wWbhYx72QuCSFBJrpVvCjvEBFwriAoaUjVh
 6JbdUK165KYLW0rwSrgqL4Z4Bu6U5wY82ptdQ9YfZnSntHNPip8/alxia12fhm82r8luy39zZAG
 hJNzGcX4p/VskInfcCXKR7isrcbKufd8nd5xRhDhRD4fRpUJMa1AALMDUKQGGB7ICgfGsBKoviQ
 /I2sRoZ/x5Qd0medTP2+POHZGkDMR5VPDK4aZNlVRJhlznJFZXc3z0H+ze6NHa6c48jy6RZvTCN
 Q6RzyBRJfPKVGCJERGrklNqJBz4GZZsKcnL06g097KAudoQkPmALONruad+wEC8B3TQC0KgRLzX
 mEFpFAK67uYiEqYGC43M7rQwNcSScYnp/X5hFbcfWBrV8bKWbmqIlfYU/Iq/Mj9ozeVx6jHj4Kt
 lRygBtAPkoDbRnEwM4ny1AOWzn0XsW8Sp6Rm/ZcYhulCQiTCk0gAlv/BVquKO9JpBlX
X-Received: by 2002:a05:6000:420e:b0:47f:80c3:92a4 with SMTP id
 ffacd0b85a97d-47f80c3946cmr8555645f8f.40.1784715354728; 
 Wed, 22 Jul 2026 03:15:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm4925216f8f.3.2026.07.22.03.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:15:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:15:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 93d8efc4aa02009f633bfaa8ed0622d7eb8d0da2
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 10:15:52 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f88c0598e2e8055526151293f8680328b801380c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmTzj-0006xz-2o
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8045068060795917929=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8045068060795917929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vY6q3pXz59c="; charset=UTF-8

--vY6q3pXz59c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 7:

(1 comment)

File src/openvpn/siphash=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573/comment/9b4410c9_57c144c4?usp=3Demail :
PS7, Lin=
e 46:     if (siphash_cryptolib_available(ctx))
> Isn't this the wrong way =
around? siphash_cryptolib_available needs siphash_cryptolib_init in case of=
 [=E2=80=A6]
Yes, you are right=2E



-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Num=
ber: 1573
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 22 Jul 2026=
 10:15:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: flichtenheld <frank@lichtenheld=2Ecom>

--vY6q3pXz59c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573=
/comment/9b4410c9_57c144c4?usp=3Demail">Patch Set #7, Line 46:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (siphash_cryptolib_available=
(ctx))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Isn&#39;t this the wrong way around? siphash_c=
ryptolib_available needs siphash_cryptolib_init in case of [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Yes, you are right=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">cha=
nge 1573</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 22 Jul 2026 10:15:52 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--vY6q3pXz59c=--


--===============8045068060795917929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8045068060795917929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8045068060795917929==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F9C44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U4lBiPuFX5WteXWV4x21nFbUpx/UHjl1bZrRo7k6L6I=; b=BbNLfroWYHVRqw8OEVIAuj0m7C
	24cKht/ZTgIhg/iu6h4u3o2Vzxd8LjokNk7oJd28VtfUOt398vPSZaQN0CXMsaLzA+GCPDgwG36JH
	idmL/Y/li2bAVHXMTjHUdbfVaI7EwcZNjafoAB32ycwmBe2J87lRjLNn/NCerclzgQVQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1O5-0005Lq-UT;
	Wed, 15 Jul 2026 15:19:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1O4-0005Lk-Ri
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:19:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MlYI5EC51hkQazfGjtXdtw3zY7Vv1StickU+5pwkPJ4=; b=mWmOwYCis7jf9BdfjiJuIdYBzB
 FtTHDzeM0DXwBjK4sdVTQdG7SXBIJrjjYkWcrM5XdUj3pHzz4woNgif58TTEwv0jLDoI6/3TH1//J
 8xniCpRFNEw7fVjC+KLSSxneAW8rFe9/d7UH3huRVXkmB/QFPyDKLLyglejolT+TAjpQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MlYI5EC51hkQazfGjtXdtw3zY7Vv1StickU+5pwkPJ4=; b=J
 K/qvAdz3n0/HwyZrzvt/Ki5ENOMcmGYB2BGxuzT1hE9zFjGULpFOSn6QVEmzowxM9wOR1yE8fytbX
 QoBuLCp5kyeZ4P//ccxedjqzv1/zFhcxFDs+KnLhyynwq6yubimbGmDl812JNjNTfO4Z6PX/K4Ztb
 XrLwE6TviMy/gm8U=;
Received: from mail-lj1-f180.google.com ([209.85.208.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1O3-0007zz-8i for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:19:04 +0000
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-39c7fd21b63so40673741fa.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128736; x=1784733536; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MlYI5EC51hkQazfGjtXdtw3zY7Vv1StickU+5pwkPJ4=;
 b=CcCFfvybt2rOReRWdIUL/0xajcW8mQqMXtgzXS3q/I1AivtmUnGCJ5AJv4OUIG/2rk
 sbFaqLWd6FmLlUz5Nay0/KRN2ErChaYuaHiCcMIVkQdFiIMEHMDfF0PI1lkEN6lrrxr/
 pa9d16mnhbEUaZqjdm+GyFQFCShK89r4TZGcMWFW8UNl31f3SKSDU/ObxZbmFAiFr4mS
 4acZX79sc7mtsnOEJRVI3CP79j/Hzgk+iP6luuoX2FKZWfMQWO7NI1CcbvZiGfWFk5Ii
 tZaohg3Wb7GQo/Cn2RROR/07+pImTL8CEiqG75VAltc/Vim3weLKGySExtQiYD/mG/5H
 YEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128736; x=1784733536;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MlYI5EC51hkQazfGjtXdtw3zY7Vv1StickU+5pwkPJ4=;
 b=JyFLmumv1fSsJCRfDrclD/cfN+cmiLxXBDnN84JB+75yVKCqu3A1xcjDs+DdMdszkB
 k99eOxIuTgbYQKRBGmRDuvGW7wKYfzjhOQGC+hFOt2jBAc++Knk2wLBBXeRsP+0eEUhc
 0tiUodV89Yb0vack4XSx0ArMSYG7UUqxq2b0QjLyky4ggClIZNCuFUUb4Va91skq+YvJ
 TKNNrwKBSQ55k1PtnWIKLHbgkdgSUDsLeWxdVciWAQEbehqPG2eNm2yDUi9j0oifYRdu
 zjRN0EeyDoqHBrBdgOoY4pzDRGibRAnNw3CjA2Nnqhr8b3By/ogtuh8gnDZ2eDbCpLBA
 Dckg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZFUNvExUMaNOLU2KpEFJ3/tHxRgGc8yN/DphThjfed1GDYjECPY1N1bnPArJ8RbQQ0Kf2ungbGVHzPIwb@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzO6C/tI7XaX3/hBcDdg/IuZvtyqL5o7+t/ITanmlGza8rXtxJr
 yvp10g5UWzctgJg/cV1odAYmraY6v8i6LNTl9go7vjiTn1f60wNmHRDwyXtMWSe/ZoVXucWWCkU
 iAA4C3kr5wSg3ViAn07iGr7VTaDRr7pwwpXUneOVn5vSTs7W3elz57QWgko9PJl+XMQQA4GieAw
 rHDgTlnQ==
X-Gm-Gg: AfdE7cmj9yHiACFoDQmppNe/M4v4VTpF/nbi0ibRSiXkV5aYn99L5s59EwqetTQ7282
 d2BulLyyx+DKBJOM/RPHUlgjhpWjb4BHSicgwKuxibnj1Nn3IRHwVR15diUoMz3rOJRF1Pt5Nwy
 YQpyOFKwxKtvaGYRZrmoeEF59DMLec/GLi8pVHmbQ2rP8UMOEdUQNrBOICu7icPXAt31/lekHC2
 lMRoVwtTM8DwjtLGlRnaEdL6z+OUbEwvwhIl8Y/asiPhNnvtBFwp/br5mZWE2jRoyYg6QABXwxi
 2ifJMDsnDxpyErMunSz01o1Dx74FAt3A3DoZyyWrdskSK3+LT/FXmEfUk9O1Zs87E7XZrf5EaQG
 J4B34c/WZLRahzYdVlaaPbvIUfzgEeRBCgK3Pfjy5CF14LlZTvqDlNx+135BDSJgiFNmLWMDwf5
 KYfLoLF2J0BjBss/SP5+8EvGuiACiW5lNhNOqUrYgUHdEd/yaTzvuzOvGyjpQbjQZC7ZyNXtjmT
 vij9u4+ISfBvrSffXKcWeBSi+ZCqANrXXfCfLWWV8tF7Ci1+Ghd5azNlpgTqH3+PNpKPesFcqZQ
 mpI=
X-Received: by 2002:a05:600c:2b06:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-495158c6a10mr63414065e9.5.1784121858637; 
 Wed, 15 Jul 2026 06:24:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f635dsm159225205e9.12.2026.07.15.06.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:24:17 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:24:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id414ce0c8f5ed5b01259590e4eaa1b19f2239362
X-Gerrit-Change-Number: 1785
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1785?usp=email>
X-Gerrit-Commit: 2a490d454859483bd3e4946c7063077a316cf1e9
In-Reply-To: <gerrit.1784067448000.Id414ce0c8f5ed5b01259590e4eaa1b19f2239362@gerrit.openvpn.net>
References: <gerrit.1784067448000.Id414ce0c8f5ed5b01259590e4eaa1b19f2239362@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklkNDE0Y2UwYzhmNWVkNWIwMTI1OTU5MGU0ZWFhMWIxOWYyMjM5MzYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51f9fe4a0d4d9a73bbf9fce8a191e418d6f57a9a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1O3-0007zz-8i
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add
 subnet-pool tag lookup unit test
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4365103599447543440=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4365103599447543440==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BlmhWerQndM="; charset=UTF-8

--BlmhWerQndM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ordex has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1785?usp=3Demail )

Change subject: tests: add subnet-pool tag lookup u=
nit test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Aba=
ndoned
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1785?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id414ce0c8f5ed5=
b01259590e4eaa1b19f2239362
Gerrit-Change-Number: 1785
Gerrit-PatchSet: 2
Ge=
rrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--BlmhWerQndM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>ordex <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1785?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1785?usp=3Demail">change 1785</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1785?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Id414ce0c8f5ed5b01259590e4e=
aa1b19f2239362 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 17=
85 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--BlmhWerQndM=--


--===============4365103599447543440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4365103599447543440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4365103599447543440==--


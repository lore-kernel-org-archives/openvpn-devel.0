Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC295606A329
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JaztQC4b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H0RhP9cw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NDIOEXeo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cT7tjlvF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=76qgphWUL73y7xQQwHgiw87yq5ohTo0Bmxpu9swL7FQ=; b=JaztQC4bI42qpVv6kfTuYemD4O
	y6kl06b4bl6YnlFqXmO4ojB6UpEPjrQcNbs+nYmkInLkZOBuihZHKz7kMrTEhvjxN0yNn4jJ+fifg
	69i8+2hhGAWHPXlRtufIgi5JEPHK7UCMmGvwffanHsw8KOPU4N9qgR98pmwWedNJsa7M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTK6w-0000000032N-2EbD;
	Tue, 17 Nov 2026 14:24:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTK6v-0000000032E-37BR
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=05JazeQPxkKNlsy88i/Og9dAVTN4vsZUY8m9e+uwx4M=; b=H0RhP9cwhbd4ovFdfitzmr8XPD
 TSmLSpsllmC9Bs0Y64mXjPjBnl1st43NGTzzc7AdhxaA6p50BruFXjID22rZs3E+ymth9ELiY89Fo
 oYnfYCqwLD433BJXr0NeftI6s0lvgX5/g4fxYkR4ccdLdap4of6AVoMgtYpp1D8eatkE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=05JazeQPxkKNlsy88i/Og9dAVTN4vsZUY8m9e+uwx4M=; b=NDIOEXeoaDkoq6UacavxbgXfDI
 8caJo63mWC1blQe7fY0l4OFgkxq3/9jX2onDyJThVsSNHyL6HX7NDt+E1As1QcVdWM2hi4rZL37ci
 j6sq5lbcf91WyoVwHnXB3wzPrhvjcfvSnLR1YqX+vOS2tj8gboVewrryQRunE4CC8kLE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTK6t-000000003k9-3iFo for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:24:37 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so44228495e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794925469; x=1795530269; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=05JazeQPxkKNlsy88i/Og9dAVTN4vsZUY8m9e+uwx4M=;
 b=cT7tjlvFg8DmO2eRTkLo2F6dBNkvV1kIUTtbFq+oRvWvH2Cli4LDcOLE+w8ykEFgp9
 y+PaHJs47S3Xffa6aassELoLGEGvSj7YKL0sEYppEEQUsPWFm4K8qxUv1UZCNYrMmdo8
 zCIwXajBtQmQ3YSDN4a5LiwG4M0uILLUW0BJ630vn7RGe0XCAzpQI0oCMh+MFAual55S
 fuilwAB0EhkAK/WPEiQfJyaGUAw5UAFiA+UpEcAK4wKIc74G6+09QW58datlScRj/NcE
 2Bzt+IDzJZ0OYC5pAuKVHftkr3xfj9SU7Ku7uY63mZYewhCbjhSW0tdccMhmCfG5bRKi
 yjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925469; x=1795530269;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=05JazeQPxkKNlsy88i/Og9dAVTN4vsZUY8m9e+uwx4M=;
 b=Yce4WD5DadmyQPNlY7P5zU1CJ08aFkkzHZylDLaS0rDAW/BbArnIzZpv2lGnJDEOJJ
 hCQ9vHkV4lag8b+CjIX900EQjTotXwnJsHODQbu6DX0fGX5eGk1Q7UHG6KAlYBeBPWbe
 ezcfbLCsI9kZbyyJykqMl5Cq4TKX4Q/X6EoKA/DqHhQiLxFxydbrlueCDD8PDMchnNXi
 R5qVP9n+Oa+B6Laiqsw4ghZPW4kqsEjJohvUvf5qjE02Mq8gA5PUzj7cP4qsVylL+5da
 rFC2hZA03Mv9sJm+eDU/53WL63tiKUSBNE5alV24IuhQUzje9iwc7o80pIWrFFWJGs01
 tAyA==
X-Forwarded-Encrypted: i=1;
 AL+hErFGgpBYz7gFglWWXZAvxzIoxHWcS1BL+sEMzP8z5toX/nhUlBiv9380FeRQPvzzojfqTRA+BQPMPq3HjJWA@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/qj2CwULkqmkr+MsZHF3eUSI/QuTQq+4P/grUY8XNgolGBoRZY
 h3eufQurbMSgGORpDmfXzTbxIN/0v6GQkNHLetRt36ZQpMyENknW+fM/oDx+lt1Ap3jursbRJZ3
 MwiE90m8aJIu2i9GdmAbdZDDpw7Fq4yzdTYvHY0dB2F95wKY+RxcabMMT6ZefqqeFRwIBgWoP84
 7Z+r2qxA==
X-Gm-Gg: AYBFou22zGCtMcn9J+jSU8pOSGg6XnnA8gZ1Me+CEfMKI2dGxP1hDYd/w6P+bn4odKt
 xa/J9fNd7QiRBwvEiOdrf6HSULZhFu3sZXrJbR5uFcWcyvwEj/FZ9lrGrjc3siO4BU6ThIyhXnd
 CzqlO3Zd0RrcCBzk8rMlF5vNet85LBOfKT5wcWqEH15AkIOcNjCJ65CTuymcWsVYVo03Dg3qjlr
 EhOeRzSk2InN2Rohf53vyv3zk5oALRkiWPHBFTe69xW4WFhUxf6PBGtIifZix9hoPtk8+lupDuT
 u3sGQBBZgobQfCaB644bGbSzTDpc2hsHfASCX9x8KquG3/KF/zLSUbx4Fw4hzzqn0VXpC+W6dIq
 FGTMRNobeU0Ipghdm7j8uVfDEDVM0hA2KRe5TMa1YvtexyLtOt2ylO/2DAeKBQP65eTKaWuzfZF
 NcllrHfcVgGe0LIDTBKgT4ZJoD/tw468wd6FIRRk+CSrxrBgqeGGvdWv6AC2C61VLVSmiN1jkYE
 /8KwgP9CURmbgT1N13zMOtQYUeYOgnM09LVmogVb0P9uQ/8u9o30c/piVXHkuyIh+R7sx3mlUJa
 VyiBAqxhwdlHVbAAr8KaklBXUuu08kOMEt6Q5sUgoTwtloDK7MS92p1jgiDlDjhiakqxAEuY5Ak
 Sv88c2cwhBUsu6F2AHBe6liGdGn8OnrZzmTtilSdHVrS6ilDIqdwXfDkvyqiKgHwGsmyhvxXW8P
 WwEemn03D0ycZSQhY=
X-Received: by 2002:a05:600c:4f07:b0:4bb:7b4d:6396 with SMTP id
 5b1f17b1804b1-4bb7b4d63f0mr19921405e9.3.1794925469019; 
 Tue, 17 Nov 2026 06:24:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608c5debsm27413887f8f.42.2026.11.17.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:24:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:24:27 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: f535e804ef8c23e7051b8cf566066a35f6598782
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 14:24:27 +0000
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84ac1248491369276d12673a2c8f96104f7bd50c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTK6t-000000003k9-3iFo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7597436193538318748=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7597436193538318748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gQD1WKynXYo="; charset=UTF-8

--gQD1WKynXYo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail )

=
Change subject: socket: pause the listeners when accept() runs out of resou=
rces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review-1

(1 comment)

File src/openvpn/multi_io=2Ec:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/9b995612_d1370825?usp=3Dema=
il :
PS1, Line 202:     if (delay && m->top=2Ec2=2Etimeval=2Etv_sec >=3D de=
lay)
This breaks the mingw build (at least the cross-platform one on my Lin=
ux machine: `-Wconversion -Werror`)=2E

`tv_sec` is `long` on Windows, `tim=
e_t` is 64-bit=2E

This needs a `(tv_sec_t)delay` cast, like `context_resch=
edule_sec()` does=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2210?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-Number: 2210
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2E=
com>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmar=
co@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov 2026 14:24:27 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--gQD1WKynXYo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=
=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mul=
ti_io=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/9b995612_d1370825?usp=
=3Demail">Patch Set #1, Line 202:</a> <code style=3D"font-family:monospace,=
monospace">    if (delay &amp;&amp; m-&gt;top=2Ec2=2Etimeval=2Etv_sec &gt;=
=3D delay)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">This breaks the mingw build (at least the cross-platf=
orm one on my Linux machine: `-Wconversion -Werror`)=2E</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`tv_sec` is `lo=
ng` on Windows, `time_t` is 64-bit=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">This needs a `(tv_sec_t)delay` ca=
st, like `context_reschedule_sec()` does=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3D=
email">change 2210</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2210?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2210 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 14:24:27 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--gQD1WKynXYo=--


--===============7597436193538318748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7597436193538318748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7597436193538318748==--


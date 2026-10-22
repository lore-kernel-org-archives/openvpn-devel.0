Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2E606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K1dVJ0BO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GRmaeNxh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iqenInE5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c2WOiOQC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MGCMhsCr7hYp2TTUAcJnrjFYjXZrHqkqtVuz4kBfHK4=; b=K1dVJ0BO0uiq3yYRmZ75R48YRA
	sl3bYkgR+eVhqFQ9Rko6Vfr1zL+sLEl7mro6vSS3GD+oJm6QFmvJiwuAILAsfiMywucgUTsOubiGE
	t0eiAFIaOElz7DDHaS1aq0V3yGwKYSn5etN3G+x92FxHvJBjOn8Gi4EbhzTC2oJ4FsiY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJwDU-000000004Nq-1FXh;
	Thu, 22 Oct 2026 17:04:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJwDB-000000004BD-3FX2
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qgmn9GOf4E84b9r7OaqhnvjqZaBINFYkYTA0aCiqm2A=; b=GRmaeNxh32hlJgV6geyPk2vC2V
 adPIbTPHZc5Gt7Y13QT1WhSd+3kh+iqzcEwOrAIBEg21oAqHc49eiazqE6jyS9v7Xe/z+KkU94ZGC
 HXr155GTjitdVhOEOCGHGAmk6JJyEpvUazTTQc6dpsFC67VD9RWq83o71DxYjE9UIuUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qgmn9GOf4E84b9r7OaqhnvjqZaBINFYkYTA0aCiqm2A=; b=iqenInE5uSDq2/DKCv/qWMrLat
 UthcK7fguMXUVuK5SAucpdkgtxlHHLTxedFOQkLpn9aLJjHDzh2r8DzwsoTj4lySAsE+RY5EOLVkW
 9OdCxSKzxYkpmylC8tvgbs09beGX3loOXBbiK4LXPOzyetbcuq92VHpL0dw8Dq+1wmzg=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJwCx-000000000N8-2Uyz for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:04:07 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so459715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792688637; x=1793293437; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qgmn9GOf4E84b9r7OaqhnvjqZaBINFYkYTA0aCiqm2A=;
 b=c2WOiOQC7cBb6KAEzDzxGptrJx/M3ixjWQIF27rl5rpn3d9jb3TURW+zDRpY5Gjd9g
 eYgk/MyH7ipU4C0E9ZQHA7hkkYbKs6gOwRh2mfCVMv5Op7e3/jASYrO7TKSHX0rNuSXa
 7RN8SGED08lIBr8yIucdClT0hGbZyCU8limRcNKNMZrIKFo/vx0UrtGRDG84kmk/PAcp
 XH6janka+E18ot8Yqz6YcyHNyzmy/SknUqh1m3Dd96G93jZUk7F/AuivFOIkqs+PeNVy
 wOYOxxJPHvPG6J567nwJ22WRXPbVIurbogZtupjbtqMXXOv098RtVVphY8HqyTJF/Ldi
 8lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688637; x=1793293437;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Qgmn9GOf4E84b9r7OaqhnvjqZaBINFYkYTA0aCiqm2A=;
 b=FXNOMXgnimJapAk9ovuyAnp6Aj24H3IXWOAkvPQwV3EqSYN5zm5BanRlcSN+ogKnuY
 6HiZs3Iyw73G8ROpP/81dq0A/rz9MPNWMUTgoj1g4Ai1d75oMHsvC3CwnBUFPw5s6UCB
 QTLk1Ke24Y3NPlYaQWwLspobZngWjI9lD3lbKcNKsfSS1/fq8pjWLM56KUmGh3/rGHeU
 A0diPGK4H3h52f5WZpF0QuBgmNExXLrfkIm67zeUmB3an6QyWZxbHGaYzT/ddz/IDv4m
 PrHT2ZM3X5uP+GrHTWA8BFJ/VZJ23JFO+ce/y/GcnPEH38YZrmK0cADNbi0Ms9141uOI
 2zeA==
X-Gm-Message-State: AFq9FYKgftqmpiBmsr4+BFIHDy6g++cFzHf1JNKmAglmyqZRTSV0iya7
 vc7NIxy69t2/JpajTZ+ddUAnFE8SZoOQOCZtxC+eHiR0MEIH2HCq8Gg9Q0wxXwjkTEf51tYSzYS
 Nliu18cjJqnKkrlg82xAZqiP/ORN3lqdyXOzdGH1rV9wbsumY8Ec45w9zxN8Z9mZqm1ZV
X-Gm-Gg: AYBFou2oWzJmRxxAicn2ZIvYPo8dUlFQFjKymh9KPz/NKpZl+yhuVmhZ0G3/e9ohQhD
 4PqmpLen0IRVIAo4cBoCHPJhkk8wEX1XKZSQeLFO4DISkPV2nGRK9pz5cKGP7qrdKpzBdKBvNnU
 RjfWJ3e4rjAtsYM+AHuLj2HCXr+gtWWNqbfPTCVFfYr+WBWc4N+t03Ei+omjjoB+m7WnNpX3g8n
 XYuFkoP0MOGJOsr8Cq0F4EHp9RhMyM8M7pqOxvY+3z4qgKnbfXOEs1NZV7jA3uNqs3LcH6KmvLw
 uiJYhBN5wbD76rBowLC2UvcqYAf05mtWC48wMoUuhOl4Rr+KV9v9wsAqYPXu3/UhhsmOgFaVgZk
 wMzVGUog5C7xCIb+0zS2JNMOeS0dRaIZcmgMGcAoCwhMd6jShlM1p0AVr0377KYieri4ymJU8XS
 EAw/pWO1wawS4KFTC6udcjQ3KRZ3QMNdJ8m/PN0IcxYVtibJEU43evHfFwZPvJMshtY/NoRvPzY
 QSSoHPEQab/zCgWB+zItyjKSeso5pKqXqqjduh6VIzN+YPu4qnKTWq2quJF3GauTjncASgd60NZ
 cqjdO8SNlOmljuptL1nFBICo7BEOJ5JXYfWUpqpGvMiJWPB1y98B/BZ5mCoC0DfYIU77idgM/m9
 zYKfTGpLzDuNdIL9Qj7z2+oarEs5EBzN2EFTsz5bNj1l3rDEbGSbVasO6X8cWPsc=
X-Received: by 2002:a05:600c:3b01:b0:4a1:f688:a5d5 with SMTP id
 5b1f17b1804b1-4a1fdd2bfccmr113819245e9.23.1792688636843; 
 Thu, 22 Oct 2026 10:03:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581eed3sm14769412f8f.12.2026.10.22.10.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 10:03:56 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 17:03:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
X-Gerrit-Change-Number: 2018
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2018?usp=email>
X-Gerrit-Commit: 659ff909be1177fb261859de333b0c411d8e04fe
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 17:03:54 +0000
In-Reply-To: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
References: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzMxMzQyMDAwLkk0MWJjMGZjZDQ3NTk0NGYzYzQ3MDE3MDVhNDZmNWE5MTE0ODBiMjgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <78eca96f3fb0423d99197c3c3810d9be99516cdc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJwCx-000000000N8-2Uyz
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make run-cppcheck.sh
 run on FreeBSD and macOS
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3207817046771665614=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3207817046771665614==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e1nrMeBjH2w="; charset=UTF-8

--e1nrMeBjH2w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has pos=
ted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2018?usp=3Demail )

Change subject: Make run-cppcheck=2E=
sh run on FreeBSD and macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Gerrit=
-Change-Number: 2018
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Thu, 22 Oct 2026 17:03:54 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Y=
es

--e1nrMeBjH2w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering has posted comme=
nts on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail">change 2018</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2018?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41bc0fcd475=
944f3c4701705a46f5a911480b283 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2018 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Thu, 22 Oct 2026 17:03:54 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--e1nrMeBjH2w=--


--===============3207817046771665614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3207817046771665614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3207817046771665614==--


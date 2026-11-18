Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F9606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HJZftZCH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ih5ezaTu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h4GIMF4E;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DkqN34S6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2TgGpu+SYLXgo1dRpVzAZq73I/hODRSaqdBv/q3M2QM=; b=HJZftZCHhL1xLGA2xlNWsVc3nQ
	CTp148LZKi6/Jr8hu1EMIBUF3HUDe0Eg3cY1lp1flp+QJBzPJecVznZhYYSweZSv54lnNs7Tbqusi
	N9xWs1NaMy1LfUgEzRPSaP42+2sOBwNbJlyu/WygQyA7tyzauIxzPUaxeHo19+l50L4A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTj9A-000000005GB-09bQ;
	Wed, 18 Nov 2026 17:08:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTj98-000000005G4-45AJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DB99tKXxkA0+jQkiTmu7EHUwfhHOJy7dw2xVdYqJnYs=; b=ih5ezaTuYIz0elXrH7AyFaNAmy
 Tkbaz5l8p4gs0p5/6Jp/0swGYW0cTngUAQe5ICWVMtEG/bzULzY+YlC/HNZXpED5gWjINn+sWzgYx
 1Qs++bm/GD5GryJm7Kt7FdZVqleuVgJ8cNgfNpd1Fm9AmlhfqEilV16vdIVAAaHKblkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DB99tKXxkA0+jQkiTmu7EHUwfhHOJy7dw2xVdYqJnYs=; b=h4GIMF4EP/HIKDACIGafmY333+
 cfKKLU5xY84ET9ZlREqHCUY+wYuuXbjxAMQKE5CND783NPuFJYq2GgtjUXBmROrFDchY1KZxj/zeY
 09wxzZCDIHDRuQy+wPNjCbvuHAYDxu22TvLqdLveVfQIB+MqJZ+4+jwt6Sv0NQhziWN4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTj95-0000000051U-3FSn for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:08:34 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-49a92144733so589449f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795021705; x=1795626505; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DB99tKXxkA0+jQkiTmu7EHUwfhHOJy7dw2xVdYqJnYs=;
 b=DkqN34S6UgbLSNc6f9EJSppnX7yLhSB/9VMeOzzJufHAS49XpVyWPElzIOE0BFrqD+
 KI2+jM0XxH6NwDOru5w1VgV7z1VSxuF3vvzWzKN6ukGe0geYiUvG7bsD6Vuf2pUjp61t
 /Bbutycb28bs5RZ7PACdlqgOhn/NGeQz4B2JlEaqrErxCigGNX9UeuM37O37ApJfZQ/Q
 F/Gg49+UGT8zmRacNI7wxH5E2s+e+rzKrYL25XbR7aU7QxAZnlOMukN0sy8vteIi5qYX
 jMnDHgrCjRJrVzWmRkhWMrm8pK9jH9g0pd8D7ZCBFIZX2f8hWJ4qy3bqRA507/dRMxAg
 X82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021705; x=1795626505;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DB99tKXxkA0+jQkiTmu7EHUwfhHOJy7dw2xVdYqJnYs=;
 b=P5xnQY9rI0LlxQutYYpiS8lGTIe302c2DClI0OfMthOXnrxuLQymJDM0q1ExbMHj03
 /UosG7k3W7bMFJWqhHrU3Po+cgxuOOJbKRTqxP/fY/tD0ayoMXdvHt73UtXXIpBtxzzE
 T3DHX3iHmoZPzUI77QMjebdoRIIfNm98Rdt8DGn33gzL+rxPEpACOB4L8AHqW54q7/4N
 Kp/gW3MON4SxtL2L7f30jmIl1o8/sR0qMN//+JzOLAFNRGLshMdVGYNbUE9DeaNmSIon
 jiyQobn11VQPyqPrBQlpaTiKf7VqcHHD6kwyn+a5iVqWWWv/BYcV/lZ+H94I4rs/wE5J
 vZnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFUJQE2X+4aV6Y3oZuw2VE4PwWC65sWm9HJYHA+qFNNQb66BHd7HD4TEtvJ9ImZNE9SZYi7qQjnJEzav/ah@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+rtQvEYe3OtcpL1vOc5TG4wKHBhNIo0Tfu8AbK2Qb2VyxBCX9Y
 7CdkQwK40HKisamSC4Udf6O/Idl1u5pIwa9HDdqQ67pWK1TmNkL8qlxc6t1fezILEyeCuSDuQti
 C3LsCSaDCDgHiuFVLQMN6P862KFWUuiCcptqfLGsly5WZNypVq/Qlh0Ocrh5BfLpt9Eq4pPfRzk
 QPrcyUyw==
X-Gm-Gg: AZFdTZe9QQlIQ/UVubXQg/CO5WO3pbm3bXBCGhYwSoyd0dCuMTS3pGVvzV8gjUwPnZ8
 TOdvuOU+08r+ExKzXlEFu0tpo/+loU7735jiV/gETeNgVhP+QGpAClcn5qmQMXitUXgaKoN0Vey
 RVMeGVzy/QkNfzMY9HH8pUIQxwduCU4xK/MDhOwzykA7gs0W5Xpqeii5by7VALXY1pnfjVpffy7
 2UlcWBYe8XYfpWyV29lN27E4vPwRaX5IX43Cq72ycYThHsRfHNtDOJcvEJuwHjT7vWcZ31t9B2S
 q9tavTAbm6g3u/kXJv5k97cuWd+iUQRsa+7Q0Pr8FfTFvREjBJP5usKUThSuVG1u99U3V4KDRXy
 cQ5fitnvYQc9yLp0dWl/sq12YVjMoovCQvgLo+9XrOxkKKvUiFdkGMGNXKUCydmIeIaN+rtURWk
 b/DDDPvWK1ucXkEVHAzkatESIZ3cKFLgMi9OIfLVp6ypPxlYx6qyyA8xzBqe9f/XMkIhpaF4FCn
 fixrU6Po9RF581ampJ9+KFKuq8wKBrj1GU8jvSJOalb2IWJxPFqSQGlD3fuoO7fv5mYo8dn3q4L
 YofvCd4EqTcdTvXhTGJsrnF3Aic+KYoAkfomRilU421SrEQzIImMCcKi4WZWsWgXujsigz8z+XK
 M70etUDZlWNb6CjIW19AqkxtZXgDnPnCBhhnPcwyrODWkPBrUuKoQ3bq3GGXr2Ku8rwUsSNNPK9
 YgbM5ZOGyVlvE9OJs=
X-Received: by 2002:a5d:5888:0:b0:4a3:d1d0:a38a with SMTP id
 ffacd0b85a97d-4a638bd699fmr6181425f8f.14.1795021704970; 
 Wed, 18 Nov 2026 09:08:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655f9f4a7sm6039887f8f.34.2026.11.18.09.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:08:24 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:08:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 7804ba8b301e89c1727251a5ee3bf3f4ad5f55e7
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 17:08:22 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5566db6d1a6b93eaf5cd6db030b12bde95338dd2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.3 (++)
X-Headers-End: 1xTj95-0000000051U-3FSn
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2550397345774360724=="
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2550397345774360724==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bTFHAyWV42w="; charset=UTF-8

--bTFHAyWV42w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld, R=C4=83zvan Cojocaru, Steffan Karger=2E

Alejandro has poste=
d comments on this change by Alejandro=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2002?usp=3Demail )

Change subject: Keep the outgoing control p=
acket in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

Patch set 3 only rebases onto curr=
ent master: the one conflict was the test list at the end of test_pkt=2Ec, =
where the new TLV tests were added next to ours=2E The change is otherwise =
the same as patch set 2, which had a +1 from R=C4=83zvan before Gerrit drop=
ped it on the rebase=2E It builds with gcc and clang with -Werror, and the =
unit tests, t_lpback=2Esh and t_cltsrv=2Esh pass=2E


-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793=

Gerrit-Change-Number: 2002
Gerrit-PatchSet: 3
Gerrit-Owner: Alejandro <ale=
pacheco99@gmail=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <s=
teffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
G=
errit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attent=
ion: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Wed, 18 Nov 2026 17:08:22 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: No

--bTFHAyWV42w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld, R=
=C4=83zvan Cojocaru, Steffan Karger=2E </p>
<p>Alejandro has posted comment=
s on this change by Alejandro=2E</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Patch set 3 only rebases onto current =
master: the one conflict was the test list at the end of test_pkt=2Ec, wher=
e the new TLV tests were added next to ours=2E The change is otherwise the =
same as patch set 2, which had a +1 from R=C4=83zvan before Gerrit dropped =
it on the rebase=2E It builds with gcc and clang with -Werror, and the unit=
 tests, t_lpback=2Esh and t_cltsrv=2Esh pass=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><ul s=
tyle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379c3=
6e1557178d22d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2002 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepach=
eco99@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Wed, 18 Nov 2026 17:08:22 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>

</body></html>
--bTFHAyWV42w=--


--===============2550397345774360724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2550397345774360724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2550397345774360724==--


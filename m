Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F5606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W379Shz6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Aj3hTORh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bU1IoGsp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RfYS52eJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5TQqKr612TiQ9RTYFE5XnqcqJ4hIivCa2XkPHbpSztc=; b=W379Shz62J2MJuwFmUVScpWa+N
	tKmEJnOZA/wrRA9t6etP9fx3hHBtclKMKU3WNvTRJ2w0A/Tky1q/FwIxzHHnFLStNA8zxHgFjzHDU
	apYFJi2XxUrxYSOdIA7I9TZVwZB8WwEpH25yXLElPgW78gmTaqxDpcnLhJ4cDEya8Klg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJcM-000000004yB-1XI2;
	Fri, 20 Nov 2026 08:05:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJc8-000000004wW-1BGR
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mru4UONq0wGnyZW6da6dhvRATpfZjCHmdde37ALDf3c=; b=Aj3hTORh6GAaZ/pkenQI/6WHEC
 kV3mvxpszvsVcgT6imp7BOg6rJfNfUljhvsE9ymbh7QoOrthF2c+PKaUpnNv3yHI3nvshlCR5reH4
 H9xYDGBVlYHvCC39/mQNJrQG5VHVfTvhvooCDC/zZoDGmsjU/SdgyIWXDs+12ifoXYk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mru4UONq0wGnyZW6da6dhvRATpfZjCHmdde37ALDf3c=; b=bU1IoGspxLb2mz3FLnVwNenTGb
 KagJXHevSvspIhe6Dw/7SshNjCYu3hjG+wlJdp0NAlTOJPnmjF6Y85rgyAXCVn8v2gxWr9NbnwYu9
 p6OGy3GCEuGw1Qu7M/IA8PnwwhK4pg7rchS1I90VltuLtkaF+nxbkAUcy/2nyAvVbm8I=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJc5-000000007Yj-4BgA for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:04:56 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so6719505e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 00:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795161887; x=1795766687; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mru4UONq0wGnyZW6da6dhvRATpfZjCHmdde37ALDf3c=;
 b=RfYS52eJTDbYrWsTK+X5amnZr7sSNesZWUsIBRkCA1I8E4Zxz4pPROhCNGtBwTXWQG
 CQBdwxrszjSuKlO1FIea7ohEdTVH89lVuApBfF/RalxWpvA1MCEuWCyDuK+OsKAIoAAN
 DEfWmmPV6h2u0VNa/l1B1NeME9/W1UBBOwxJ1KNeVGjz6XAtD+OENnZlT9XZ/wF2Upqp
 OZ5GvbTOxP6ARKq0VpvLLJBs2GBDjH/Mn6v3H6IwdqeKRtm+5kX6XBmdvUJeZKpdn0Yh
 vqM3wslEXDuLwl5FA6oh9XivktxYfeY95HX1MSADzXy4LL7Fo1MN71sk9exN0JszD9wD
 xFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795161887; x=1795766687;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mru4UONq0wGnyZW6da6dhvRATpfZjCHmdde37ALDf3c=;
 b=RA5Crxz8pYHQoqhsso5BoRLlTKGpQXLiv5etlW6D+xfvHjpbyW1H/Eu282Z29RxKpb
 7nrUfTQM0SbmcGJZJs2dlnq1RGdHRKjaOjx+ikjd+22MNE/7ZuWkJBPIat/JZ9Uc8GiN
 u/xAcQN8KCtAw5yf0dl315BojGtldO+TgayJPatoHegAxx4qYyIJL3iYQqpfqKwYSVvG
 6P02S5O8Pd4nCcLMtGsBLmRCwZCjEj9u/FA7w6mujcAFp8k5o73qlnbELfoJUYsSlL0I
 JkeLjgTusgOMx/DT3hE10g0riGphWublx5eLXXh+Knufr7e+3L5Ue8P6cFGZP1pI5uS7
 EDzw==
X-Forwarded-Encrypted: i=1;
 AL+hErHqOAqgSSZABQFztSU6zfoOd/uG0sjpFwuQLtVnoEKgajbZ2Xw+E6XfiJvr0SflK30QYJFcUrkwnkwGKviY@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/0r5FHHNQCzTraAm/l8Gg6+kNTGHJyTLTDxFuy4/yk7xUuMSzM
 ag9CxL1nsmgxlz64z6HsnsgzQSFva0J9RSbmYaUaM68Dx2HRFfCq/SvH3ypG0Yn02EYFGUtpofK
 HeQHqzj0LAbAK3co+cL2HyTormyI+ri7hvIcxrX/kSpnhc0YjDoJEC8NG0Vr7a2XZwcLJ
X-Gm-Gg: AYBFou2Ex2Bqy7qDs600uo8XA7If7Y5h+an1fSVlVf5/lpe+jsXB6tbcya3uD6OgiF+
 O6UzAVMqQNYXstXcvO9hVVtUIJP77H8Ls97U46J6CZgVoLRHMoNdAQSPgrU9qf0KuqY1n+FdBDY
 M6KlgWfnLQxxQvH4jXbA1Uti8Ke2pL1/1ecrT/dDfZK2xzk3HTNBXF6VfJB4bWzw1zTZ/C0Ng9q
 Jnnxnxm7jkCDxxTsm9+9GncgcyWUxqOKJmEh4WNtsZm2VmzBPyl1X7+Am848NfaIQIHyTf7LVNF
 jplbgaxAIcA/JRZieIRA+/EodJHQJq58o7pr4hSKK9pwF2WCKe9nnDW2VOCTzQ57aylajRss4Mg
 NecZHROc/HsRbkFwqLKP0JIivua5YBuPGjdKMMOybvrf81sYPt46jYDAbjCOww1lGMjiD0lMVr3
 C83Kt478atputakasm6lKqkRdxkfUG1dyDCuFlKFj081EeCWB6qpNw52pCa2JXy+YqgLpnOC5QV
 0V9RDyHwhLEKvpD7HS04VWhpnITSgytGSxrXFOJAMs3nbWBn3IvcCN9wNMWJRmyQUNGvmFElSEV
 BfiY6gag5kj+k5l+yWj6vibBb5rAVYyQWmClN1cgqe1jazhEVoIT8x59AglBKxpV/GZXr/BOywB
 z7OmJ/bzQW5EQk3wtMmt/eZ0ZnpAcNin8jMa+qEnitLikXwYhCtKg6oJCumiZUA4WxjMCq9CNCV
 JXpwGhqj0finbsFwU=
X-Received: by 2002:a05:600c:310f:b0:4b5:d95c:2378 with SMTP id
 5b1f17b1804b1-4bb8881f9b7mr48609125e9.34.1795161887178; 
 Fri, 20 Nov 2026 00:04:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960110fsm28386095e9.0.2026.11.20.00.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 00:04:46 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 08:04:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 7804ba8b301e89c1727251a5ee3bf3f4ad5f55e7
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 08:04:46 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2df7c06f531d451148ab7ff3a6eb06e049732970-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.3 (++)
X-Headers-End: 1xUJc5-000000007Yj-4BgA
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
 lstipakov@gmail.com, antonio@mandelbit.com, gert@greenie.muc.de
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5631589224037358530=="
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5631589224037358530==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+W9raeEiNSk="; charset=UTF-8

--+W9raeEiNSk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld, Gert Doering, Lev Stipakov, Steffan Karger=2E

Alejandro has=
 posted comments on this change by Alejandro=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2002?usp=3Demail )

Change subject: Keep the outgoing co=
ntrol packet in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

Lev, Gert: adding you as rev=
iewers=2E Patch set 3 has a +1 from R=C4=83zvan and still merges cleanly on=
 master=2E It replaces the check_session_buf_not_used() and check_keystate_=
buf_not_used() guards with one outgoing control buffer owned by tls_multi, =
so freeing a session or key state can no longer leave to_link pointing into=
 it=2E Would one of you have time for a +2? Thanks!


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
Gerrit-Reviewer: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Lev Stipakov <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipak=
ov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 20 Nov 2026 08:04:46 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: No

--+W9raeEiNSk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld, G=
ert Doering, Lev Stipakov, Steffan Karger=2E </p>
<p>Alejandro has posted c=
omments on this change by Alejandro=2E</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Lev, Gert: adding you as reviewe=
rs=2E Patch set 3 has a +1 from R=C4=83zvan and still merges cleanly on mas=
ter=2E It replaces the check_session_buf_not_used() and check_keystate_buf_=
not_used() guards with one outgoing control buffer owned by tls_multi, so f=
reeing a session or key state can no longer leave to_link pointing into it=
=2E Would one of you have time for a +2? Thanks!</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=
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
iewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 2=
0 Nov 2026 08:04:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--+W9raeEiNSk=--


--===============5631589224037358530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5631589224037358530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5631589224037358530==--


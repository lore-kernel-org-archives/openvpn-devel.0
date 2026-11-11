Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB2606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lZni4A8N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HoHIjzkd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l1jlHXDK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d9mjG0Vm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dUQ0Y/J5FxZrx1uzKINbuig0/v0ePXAesqEzLozN5FY=; b=lZni4A8NwTUAYmfHKWBZ65C28q
	62w4dBtwI2L5qCG4XGEy6TqNnrFsyLiL/NmmK4aDtPuLM4Q7csD8x9Zj1Ddg+u4k2FsMy7AH80Lgw
	uJgp11nSVcurS+Gj7nsZ6r8z7M10GwmNFEhjdLdIUQlq6509MBg+l7ApwGVf5q9KMAkA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR3hx-000000005Fk-0bl2;
	Wed, 11 Nov 2026 08:29:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR3hv-000000005FU-2g5p
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dsKbQKStzJ2TrukuR9zwZVhJV/FLPq6tW0Abvtr1MbQ=; b=HoHIjzkdYbq/f+G/EYqQee+KBi
 vNdEIXyXjzJgZ2GdkQdYKb0C/Qev4dCVu4vSZkLi951RJxKXbveB8mFlEOfXGCqhIJkoDfzSLAQ/q
 K9GE1EEMBd3LF2rqvQ84If1S5SPKe9W27yZjWy1K6iM2dHEhtEcQbSoUFQklZF7G9p1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dsKbQKStzJ2TrukuR9zwZVhJV/FLPq6tW0Abvtr1MbQ=; b=l1jlHXDKzPLKTTbfwU1X+XypK4
 UP0hh1/2wB78y+y16uuMLnqlcDWoRyLZsqco/eplURZ1v2gGIifROBLj39/H27AsJwy/wzxFOzd08
 NCAWOOhoyA+UIUM1FruUK2gsEuJqPaRpZG2fxQf2ra7x9+jEtRL6I2dXI/NDrAi4NB3o=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR3hv-000000007OC-01yf for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:29:27 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so25113635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 00:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794385760; x=1794990560; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dsKbQKStzJ2TrukuR9zwZVhJV/FLPq6tW0Abvtr1MbQ=;
 b=d9mjG0VmVHfRbq1l+1g8mg2ZhVNnj9S8i6CfLX/Qbp0SfGw67wuLzIaQFa/T2mAN7W
 ZU3Sxyn9YOOv0i2Y6l+1FXxh6Q6z1Rf6egx/xyG0/q30uw3k2xpNX30KAtRTVDEMBU9V
 MAPTQukBtRN674npfwWXjj/382fqG4vfgzdH1VgWBkfxtSBZZ6Hx/o+ZDQwv2+H8HHC2
 OOlNHaavzG1z99J9eNbuk5r809gt/IfQrhulk6unu/hgPxOYjEAgicEJkzBbMN6L9YO5
 NXJiVDdD0AszGo8zIitkST325kbn9NP+/SOid50gbwdVSXvWa1mEb6RD/YowRZm5AEus
 6ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794385760; x=1794990560;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dsKbQKStzJ2TrukuR9zwZVhJV/FLPq6tW0Abvtr1MbQ=;
 b=ld/sM2XDEOoRyuPnmSiwHiBcQPrrn2Gd+KwrnZmLHuxEXTktsFGeLgesj6v1gKx9Hl
 9TRUy1WzndREhPsTim7VoFNzaAAVaC1WujdmgAJYFnbPzJ+Ib7AGHJXn0k/Mgqz0kJjq
 q+dMaI0Gmgs95OsimZmACIyT+WgAdiIkmnGed/PRlRKHDUEGCML7Za5nrVvssKfKg3LN
 40y6B9iZJDfJQzTkUWlR7Hn7VPOu9OvEHEPefnuhR4Pe1op8CgqahIQ7gaapbl71LbPK
 nvXlL6LQBLgoUN3eIZK/hkUoL9gElwM6Wn+0OEIC+pQT4i7alRo9SspCUQluFbw4xapy
 O2QA==
X-Gm-Message-State: APuU4Z/NvyZWNTB2PEc4Z3aw4eyqkhSikxm/TbXfmTACZDmhN/MNtVEQ
 xA2MNujEfIv/nph/r+Rr1/xJ8Y6EBxmF2Q2GCCJ/LmJgdH4R4h4hbzbwdbefYfuz2J7CHhWaatI
 MsOmQFzx52VE0KWW3U4ZP63MBCfbv+GqZVhT/ahXcFcpiK6oafA+yyaZE8zLwqsvfBxOxsn2j6K
 ImrzNUsQ==
X-Gm-Gg: AYBFou2si/9aMaO1LiJ6atvcn5enqA47VzfXiB48lQNj/+pyK5qASGPEaE8/bXAhKGj
 3yEXJ55IW07vFcddKx9xdbT0qreJsIKpzk5Y390uXopYbYexdbu7tHiUWWqVc/m++6lmi2gpKpt
 XpUKbT+n2f49yk4lxWmlFMsm8Pld5kmjbUTg/L9hvIuQccOvrthpwS7lCOZMq9YBXA+F4IpiI0m
 na7UF6s9aeXj5E5I014mRH3ttDuhi7z7l+hiIlliwHwiSOF5yogvjSEmYEjimjVlP+CcqK9o1qU
 0L1jVQsB3BGPwr8y+dl9cm5rGqaWqsOqbGLNFR8MyqKfTmz8nHqYMLSpA5IOVizjdVDWQe+2Wtl
 WgLitYXe7XIGUk0GFdJHc5DL4LAxsCtwFpv95R03MXgVMDfvpbzFURtz+ZgcQ9uVCqqh+GPnAX1
 E58870dvdK+0meyjDryZZo0NMyPKHvez7sUt0gNEuKdqE4QR0nQ4qs84MdEbkmdxsf/cD7ODB67
 zDd6CTDi/9LEGCl1hMosP9sl0RP7vFbYP58FShR6E/CkBDekOnyrlfcLoPbAtfiyOKmX2pP5JOv
 Vcu/OVr7Gk0CqIpnF/40b7r2jHVYM7NUnMTuB/bhFjA+58uE039mACVp8rzG/WUOyLoN6BX98T/
 JZBBj2/YB24aseXevEvWpHJfOPuLknjnn6InQNY3c4W57gi6xU/Eqb476zLZEGkw5k19v0LIrAI
 sJayjDNrFkmehOFO0=
X-Received: by 2002:a05:600c:3f0e:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ba09364012mr25222175e9.16.1794385760339; 
 Wed, 11 Nov 2026 00:29:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm189616045e9.5.2026.11.11.00.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:29:20 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 08:29:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 7cf1cf94a453259d7a71acd00ab0acdb5660aa75
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 08:29:18 +0000
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <496c9d6c098f5fba3ec97ae92b922596950d3750-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR3hv-000000007OC-01yf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 tls_pre_decrypt_verify_opcode from tls_pre_decrypt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5936196972705894712=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5936196972705894712==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zAqeVnDb6iI="; charset=UTF-8

--zAqeVnDb6iI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2169?usp=3Demail )

Change subject: Extract tls_pre_d=
ecrypt_verify_opcode from tls_pre_decrypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

Patc=
hset:

PS1: 
the patch by itself looks reasonable, but it is not doing what=
 the commit says=2E=2E=2E
it is adding a whole hunk in the new helper which=
 didn't exist before=2ECan you add that to the commit message? what and why=
 are we doing that?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2169?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I86154e5c997b044f6913bddab58b43193ff539e1
Gerrit-Change-Number: 2169
Ger=
rit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 08=
:29:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--zAqeVnDb6iI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?tab=3Dcomm=
ents&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">the patch by itself looks reas=
onable, but it is not doing what the commit says=2E=2E=2E<br>it is adding a=
 whole hunk in the new helper which didn&#39;t exist before=2ECan you add t=
hat to the commit message? what and why are we doing that?</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2169?usp=3Demail">change 2169</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2169?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2169 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026=
 08:29:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--zAqeVnDb6iI=--


--===============5936196972705894712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5936196972705894712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5936196972705894712==--


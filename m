Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WxupGMYn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H89VAWgQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hbNhkb6I;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VxhhRyFz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VSwh9ANyuCVEvtyAYdzz8ESjFNjLk7ft0d3H3FYpxZI=; b=WxupGMYnVhAoY9uteIizQOeokr
	izc7yqQ+2MElo8iHgQVdqAqypu0lvow1AMO6I4zpCezw/yLgKxQWMjYSr6TZ73YVLcHA19u+paP4S
	kVdYU2mBJaiIxbfGYAft29x7TbW2fgJB8bdMfX/RgnEhGDNexJjDce+VsO2j1TRLSg2A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMOvf-000000004Aq-10dR;
	Thu, 29 Oct 2026 12:08:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMOvN-0000000049i-33gU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 12:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mzT4RUqjNgu4Vm7o+/R46jaeM6foyBi5YiSg08cNUYA=; b=H89VAWgQ/qdx5jZrT9EAKzGIsS
 oPWWRWZoL2Ayb3ohdlCcu9J10p1m/2J+MJh4CC4W0TRu70flO5XwQqsVLsYoZNOgmFU1KUvrd+FKC
 gnVqRv0PaUxbugCKf7+C2heL7cV2MK75kwoijugWOHW+0dEH6Dtb/WSGyjSMj3NNuggM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mzT4RUqjNgu4Vm7o+/R46jaeM6foyBi5YiSg08cNUYA=; b=hbNhkb6I4tu1eHCWt90WdJKL3x
 0qU/qriri37jzwDGRYlSkozigXg4204MCuSkteXRdwd/g2ECFEGdIf8HcnXoFubQDKanvfBiNKEnR
 W1RP1NNqQrgCalcA32ZbOGeIAOzYJWEiZsX0wr972zN+HZhFu7bSOazT8d09HIyHePgg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMOvL-000000001DB-2Mv3 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 12:08:05 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so8983065e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793275677; x=1793880477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mzT4RUqjNgu4Vm7o+/R46jaeM6foyBi5YiSg08cNUYA=;
 b=VxhhRyFzoAvaLjvbYRoGKWGbyBpZVisgMoGKepvrMvP2a299DK1UEvrYPBfqE9Sxrb
 OSBBKVXb+eunPj0sSYKW5A2Fne99reBuoxywYoR5KHYSMfjh9+N87i9UoGdutzRsWRdv
 FCrY/6LzuEK0Xp3lanAglVyzN71Y3Oc/Fx4Ij1w2tSCFpnsogRsWaGitLo3L9KwE+4lW
 o6LA/i/vpIJI6umIvUI+ps0peyBu7OZ5+wcFxSbto461WrqQ3UN/ae7XKSaldk7WcNl1
 bBludmg74IqPjoI1EghHVkSLb4lMR+7n3cIuDVc6AdMpsmQXlvjTyBXjxin/p43vi9c8
 Ekog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793275677; x=1793880477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mzT4RUqjNgu4Vm7o+/R46jaeM6foyBi5YiSg08cNUYA=;
 b=U1awray28DBFnR+Pyf05dn7+TyzpcvezXO9Sr8UAp413UAKsbY7ruO2U13huS76cki
 mtzdBsUfXw8E6e8gZjdCXILqD2DEIpRJWzj2NNz9hZHH0BxOYdwdN24ZnSgbag481bhP
 AwGSZQIqVtV3EGoBG+nG+hva5z5XX5bMn8/rIL/NeyCUC4+Plg1nAfGJkCdUrQN70sJX
 +6yBD1wGBlErdJHmTu17Rd7CxeZiC7IoErC2Z6HmJVKCJ29ujdHVclF2+GURpZ5oeq5w
 pxjeLsbr7c55ikIaGn4BdYNs7jX8yammd0GFYGSkyQDWCa8MlHkZPDrKau1PPC3a+zDs
 HWtg==
X-Gm-Message-State: AFq9FYLh4M6+c28QBcvX3tN1xPc4aCkGi8ov7PMUVBLEAVfrzPuWj3Wl
 p8TQ5ynTGssRIW7ijGdk5Xkl71AwDFtpvVQdNCceqoKzckYRRqjaQb1gzI//v7GfXjSWkazlYZx
 AvwjzOPnLNJR/TiCSnPtGkP9nACANLF2e/4UnfFrMQ22jhIj9gsBf0YPSQ89gUNI61MfL9KZ0IT
 trl+1vLg==
X-Gm-Gg: AYBFou0b9d4zIGOV5r+N0uQQhJxibH5nz2kyFvS/RnoKi1T0ybWIHGlks96PzytUtCg
 noUhbqHksuOsyZ83RLrhd7HbBb8gIE+LcIPtHglSfXD+wnpej8gnwHetUDR396UIprQULPb6SAY
 /ROkP33hO4TTp5UBZFXMdko7H6dBtrEyv1hU4stjhvHw0tKGhEw25vlBoN9KVEftxwQs8gtcxQO
 ihySx9dv52dzkmgcpanMHHuan1/54X8BcT4p2GyADA2QVeCVXSt1bRgWE7oAM6jYHLWFmy4710Q
 W+x9bxOlvLsR5AWQFy7iAezG548AlgPGSyKR3H6tzKESeaFOcNsylIHObg17VK+ZhBQflCyzC/q
 nPZrYAaW1rDxEpXXhllgP9ajs1ib2BQF33nOCjWYg9PjSjKJ4hiEzWGwgth0gURTW4hFR2x1fSD
 vthm4SIZjzAerQmxX5D7fK/DI6XTnag0D3XStu6+nkCV6C6StynuXHM3AymVZMOYtFTef7n0aCx
 NYBqxLpFrMsaHuBHcdIledhvWGuv1PZdDs4RhXwQkJ15/4CFCem0BGJFdRISk14pGKR03IJUv79
 w5h8C1zcwe1/81dvGzdgUB9gwX7oO2EThw6oCZ3iLDBuXEDKpK2K+u+agDwsgSb4nuaOAKnCf98
 sOACCey8bWiWM/4hdiXfsRQPpPBgNOa+O85YJdcTXVzNAk3XVtA5GAuJhXlazlKubZQJCLe+GMr
 NlCmKT1oAP2xNF7o0=
X-Received: by 2002:a05:600c:a47:b0:4a2:180a:3417 with SMTP id
 5b1f17b1804b1-4aa86a424f7mr57803195e9.1.1793275676638; 
 Thu, 29 Oct 2026 05:07:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm69853315e9.2.2026.10.29.05.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 05:07:55 -0700 (PDT)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 12:07:49 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 06dc42834374699b9e924830b95f5dded521fcd5
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 12:07:49 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0981f0f20a9e660584308aa307608a6691614a9d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMOvL-000000001DB-2Mv3
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6902048815311277262=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6902048815311277262==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qfbLGZiLuKQ="; charset=UTF-8

--qfbLGZiLuKQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Name of user not set=
 #1000061 has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the mangement interface
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(28 commen=
ts)

File sample/management/omi=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1859/comment/39c7d200_a6d60073?usp=3Demail :
PS5, Line 32: import as=
yncio
We should have full typing in this file, currently it's only partial
=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/28ac9a86_5f732c88=
?usp=3Demail :
PS5, Line 79:         # Event to
?


https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859/comment/bc90a116_31fb5ccd?usp=3Demail :
PS5, Line =
88:         self=2E_send_queue =3D asyncio=2EQueue()
self=2E_send_queue =3D=
 asyncio=2EQueue() should be declared before self=2E_send_task - its workin=
g because task is started on first await but it still quite fragile


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/757ca94a_d2cf3737?usp=3D=
email :
PS5, Line 99:             logger=2Einfo(f'Connection lost ({excp})=
=2E Shutting down=2E')
Maybe warning? Or even error?


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1859/comment/e3779ffa_5153101f?usp=3Demail :
PS5, Li=
ne 106:             self=2E_send_task=2Ecancel()
Is this enough? What if we=
 still have items left in _send_queue, for example? I know it's just a demo=
, but you never know if someone might just copy-paste it


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/f688d1f9_fe7f0683?usp=3Demail :
P=
S5, Line 109:     async def _send_loop(self):
Shouldn't we wrap this loop i=
n a try-except? If there's any error=E2=80=94like an IndexError or ValueErr=
or=E2=80=94this task will just fail silently=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/d96be9f6_b0855b40?usp=3Demail :
PS5, Line 1=
46:                     pass
We can remove it


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1859/comment/141584c1_660f74b8?usp=3Demail :
PS5, Line 171:=
         if self=2E_connect_data=2Epassword:
If we are checking password, m=
aybe it should be declared as Optional[str]?


File sample/management/omi_c=
lient_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comme=
nt/b8e9bf39_39d266f2?usp=3Demail :
PS5, Line 52:             logger=2Eerror=
(f"Error: trying to send ACC message with protocol {protocol} is not in the=
 negotiated list of protocols ({self=2E_acc_negotiated_protocols})")
Should=
 we have return here?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/com=
ment/7ec580b9_a439f41b?usp=3Demail :
PS5, Line 66:             flags =3D "6=
"
We should move it to well names constant


https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1859/comment/25c00ce0_13f349c8?usp=3Demail :
PS5, Line 73:    =
         await self=2Equeue_command(command)
Could message chunks get mixed=
 up? We yield control here with await, so in theory it could happen?


http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b82f1a77_bba35a09?usp=
=3Demail :
PS5, Line 101:             logger=2Eerror(f"Error parsing ACC me=
ssage: {e}", exc_info=3DTrue)
Shouldn't we have self=2E_partial_acc_msg =3D=
 "" here?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b5cf3b7=
8_9f5084b3?usp=3Demail :
PS5, Line 116:                 handler(self=2E_par=
tial_acc_msg)
Hmm, right now we're not allowing async handlers=2E Not sure =
if that matters for the demo, but they should probably support both sync an=
d async (using nspect=2Eisawaitable)


File sample/management/omi_server_de=
mo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/d5d44d2c_=
707ce064?usp=3Demail :
PS5, Line 82:     logger=2Einfo("pytop module not fo=
und=2E TOTP testing disabled")
typo:)


https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1859/comment/26e6a206_5301f1a0?usp=3Demail :
PS5, Line 89: class Se=
rverDemoProtocol(OMIServerProtocol):
Same as other files - missing typing

=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/55196b65_31eedabe?=
usp=3Demail :
PS5, Line 97:         kid =3D client=2Eauthenticated_kid
Dow =
we need it?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/9309f=
ee4_9008d993?usp=3Demail :
PS5, Line 118:         username =3D client=2Eenv=
=2Eget("username")
get can return None, so it will fail with startswith lat=
er


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/3a67cde5_974e4=
36b?usp=3Demail :
PS5, Line 166:             await self=2Esend_pending_auth=
(client, webauth + "https://community=2Eopenvpn=2Enet")
Missing kid paramet=
er?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/7968b30e_dab4=
1017?usp=3Demail :
PS5, Line 285:     print(f"Management interface version:=
 {management_version}")
Mix of logger and print, should be logger


File sa=
mple/management/omi_server_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1859/comment/cf8bfd05_7dc5a8ab?usp=3Demail :
PS5, Line 112:     =
    elif event in ("ACC", ):
Why tuple?


https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1859/comment/f81ef4da_5a2ddb9e?usp=3Demail :
PS5, Line 116:      =
       logger=2Einfo(f"Client event {event} not handled=2E (message: {args!=
r})")
debug instead of info?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
859/comment/5154b7de_1ea393e8?usp=3Demail :
PS5, Line 127:         if clien=
t=2E_partial_acc_msg and client=2E_kid_acc_msg !=3D kd:
kd? Should be proba=
bly kid


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/aceff9f4_=
5467765b?usp=3Demail :
PS5, Line 186:             handler(client, kid, env,=
 extra)
Exception in the handler will kill connection=2E=2E? + hanlders sho=
uld be async


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/fe51=
64fe_c83c14c9?usp=3Demail :
PS5, Line 197:     async def get_client_status(=
self) -> OmiCommandResult:
Missing import for OmiCommandResult


File sampl=
e/management/omi_tools=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
59/comment/2bde1279_8305f66b?usp=3Demail :
PS5, Line 27: from omi import Om=
iProtocol, ConnectionProperties
Like other files -  missing typing


https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/4ff2526c_d0e702af?usp=3De=
mail :
PS5, Line 72:     transport, protocol, finish_future =3D await start=
_management_protocol()
Missing arguments?


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1859/comment/656a33be_cf3545b2?usp=3Demail :
PS5, Line 87: fork=

asyncio=2Erun !=3D fork


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/=
comment/350a0bde_1627e9ac?usp=3Demail :
PS5, Line 99:         asyncio=2Erun=
(main_func(connect_parameters))
main() does not have any arguments



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09bafabf612e9501ea75764=
7c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: 5
Gerrit-Owner=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set=
 #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Thu, 29 Oct 2026 12:07:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No

--qfbLGZiLuKQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Name of user not set #1000061=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></=
p><p>28 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi=2Epy:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/39c7d200_a6d60073?usp=3Demail">Patch Set #5=
, Line 32:</a> <code style=3D"font-family:monospace,monospace">import async=
io</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">We should have full typing in this file, currently it&#39;s o=
nly partial</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1859/comment/28ac9a86_5f732c88?usp=3Demail">Patch Set #5, Line 79:</a> =
<code style=3D"font-family:monospace,monospace">        # Event to</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859=
/comment/bc90a116_31fb5ccd?usp=3Demail">Patch Set #5, Line 88:</a> <code st=
yle=3D"font-family:monospace,monospace">        self=2E_send_queue =3D asyn=
cio=2EQueue()</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">self=2E_send_queue =3D asyncio=2EQueue() should be=
 declared before self=2E_send_task - its working because task is started on=
 first await but it still quite fragile</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/757ca94a_d2cf3737?usp=3Demail">=
Patch Set #5, Line 99:</a> <code style=3D"font-family:monospace,monospace">=
            logger=2Einfo(f&#39;Connection lost ({excp})=2E Shutting down=
=2E&#39;)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Maybe warning? Or even error?</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/e3779ffa_5153101f?us=
p=3Demail">Patch Set #5, Line 106:</a> <code style=3D"font-family:monospace=
,monospace">            self=2E_send_task=2Ecancel()</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Is this eno=
ugh? What if we still have items left in _send_queue, for example? I know i=
t&#39;s just a demo, but you never know if someone might just copy-paste it=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/com=
ment/f688d1f9_fe7f0683?usp=3Demail">Patch Set #5, Line 109:</a> <code style=
=3D"font-family:monospace,monospace">    async def _send_loop(self):</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Shouldn&#39;t we wrap this loop in a try-except? If there&#39;s any er=
ror=E2=80=94like an IndexError or ValueError=E2=80=94this task will just fa=
il silently=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859/comment/d96be9f6_b0855b40?usp=3Demail">Patch Set #5, Line 146:</=
a> <code style=3D"font-family:monospace,monospace">                    pass=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">We can remove it</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859/comment/141584c1_660f74b8?usp=3Demail">Patch Set #=
5, Line 171:</a> <code style=3D"font-family:monospace,monospace">        if=
 self=2E_connect_data=2Epassword:</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">If we are checking password, m=
aybe it should be declared as Optional[str]?</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File sample/management/omi_client_protocol=2Epy=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b8e9bf39_39d266f2?usp=3Demail"=
>Patch Set #5, Line 52:</a> <code style=3D"font-family:monospace,monospace"=
>            logger=2Eerror(f&quot;Error: trying to send ACC message with p=
rotocol {protocol} is not in the negotiated list of protocols ({self=2E_acc=
_negotiated_protocols})&quot;)</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Should we have return here?</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/7=
ec580b9_a439f41b?usp=3Demail">Patch Set #5, Line 66:</a> <code style=3D"fon=
t-family:monospace,monospace">            flags =3D &quot;6&quot;</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">We should move it to well names constant</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/25c00ce0_13f349c8?usp=3Demai=
l">Patch Set #5, Line 73:</a> <code style=3D"font-family:monospace,monospac=
e">            await self=2Equeue_command(command)</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Could message=
 chunks get mixed up? We yield control here with await, so in theory it cou=
ld happen?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1859/comment/b82f1a77_bba35a09?usp=3Demail">Patch Set #5, Line 101:</a>=
 <code style=3D"font-family:monospace,monospace">            logger=2Eerror=
(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">S=
houldn&#39;t we have self=2E_partial_acc_msg =3D &quot;&quot; here?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b5c=
f3b78_9f5084b3?usp=3Demail">Patch Set #5, Line 116:</a> <code style=3D"font=
-family:monospace,monospace">                handler(self=2E_partial_acc_ms=
g)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Hmm, right now we&#39;re not allowing async handlers=2E Not s=
ure if that matters for the demo, but they should probably support both syn=
c and async (using nspect=2Eisawaitable)</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File sample/management/omi_server_demo=2Epy:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1859/comment/d5d44d2c_707ce064?usp=3Demail">Patch S=
et #5, Line 82:</a> <code style=3D"font-family:monospace,monospace">    log=
ger=2Einfo(&quot;pytop module not found=2E TOTP testing disabled&quot;)</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">typo:)</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859/comment/26e6a206_5301f1a0?usp=3Demail">Patch Set #5, Line 89:</a=
> <code style=3D"font-family:monospace,monospace">class ServerDemoProtocol(=
OMIServerProtocol):</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Same as other files - missing typing</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/551=
96b65_31eedabe?usp=3Demail">Patch Set #5, Line 97:</a> <code style=3D"font-=
family:monospace,monospace">        kid =3D client=2Eauthenticated_kid</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Dow we need it?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1859/comment/9309fee4_9008d993?usp=3Demail">Patch Set #5, Lin=
e 118:</a> <code style=3D"font-family:monospace,monospace">        username=
 =3D client=2Eenv=2Eget(&quot;username&quot;)</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">get can return Non=
e, so it will fail with startswith later</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/3a67cde5_974e436b?usp=3Demail"=
>Patch Set #5, Line 166:</a> <code style=3D"font-family:monospace,monospace=
">            await self=2Esend_pending_auth(client, webauth + &quot;https:=
//community=2Eopenvpn=2Enet&quot;)</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Missing kid parameter?</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/79=
68b30e_dab41017?usp=3Demail">Patch Set #5, Line 285:</a> <code style=3D"fon=
t-family:monospace,monospace">    print(f&quot;Management interface version=
: {management_version}&quot;)</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Mix of logger and print, should be=
 logger</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File samp=
le/management/omi_server_protocol=2Epy:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/=
comment/cf8bfd05_7dc5a8ab?usp=3Demail">Patch Set #5, Line 112:</a> <code st=
yle=3D"font-family:monospace,monospace">        elif event in (&quot;ACC&qu=
ot;, ):</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Why tuple?</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1859/comment/f81ef4da_5a2ddb9e?usp=3Demail">Patch Set =
#5, Line 116:</a> <code style=3D"font-family:monospace,monospace">         =
   logger=2Einfo(f&quot;Client event {event} not handled=2E (message: {args=
!r})&quot;)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">debug instead of info?</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/5154b7de_1ea393e8?usp=3De=
mail">Patch Set #5, Line 127:</a> <code style=3D"font-family:monospace,mono=
space">        if client=2E_partial_acc_msg and client=2E_kid_acc_msg !=3D =
kd:</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">kd? Should be probably kid</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/aceff9f4_5467765b?usp=3Demail=
">Patch Set #5, Line 186:</a> <code style=3D"font-family:monospace,monospac=
e">            handler(client, kid, env, extra)</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Exception in the=
 handler will kill connection=2E=2E? + hanlders should be async</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/fe5164f=
e_c83c14c9?usp=3Demail">Patch Set #5, Line 197:</a> <code style=3D"font-fam=
ily:monospace,monospace">    async def get_client_status(self) -&gt; OmiCom=
mandResult:</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Missing import for OmiCommandResult</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File sample/management/omi_tools=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/2bde1279_8305f66b?usp=3De=
mail">Patch Set #5, Line 27:</a> <code style=3D"font-family:monospace,monos=
pace">from omi import OmiProtocol, ConnectionProperties</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Like ot=
her files -  missing typing</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/4ff2526c_d0e702af?usp=3Demail">Patch Set #5=
, Line 72:</a> <code style=3D"font-family:monospace,monospace">    transpor=
t, protocol, finish_future =3D await start_management_protocol()</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Missing arguments?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1859/comment/656a33be_cf3545b2?usp=3Demail">Patch Set #5, Line 8=
7:</a> <code style=3D"font-family:monospace,monospace">fork</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">asyn=
cio=2Erun !=3D fork</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1859/comment/350a0bde_1627e9ac?usp=3Demail">Patch Set #5, Line 9=
9:</a> <code style=3D"font-family:monospace,monospace">        asyncio=2Eru=
n(main_func(connect_parameters))</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">main() does not have any argume=
nts</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea75=
7647c86a450c73228a5 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1859 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user not =
set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 12=
:07:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></ht=
ml>
--qfbLGZiLuKQ=--


--===============6902048815311277262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6902048815311277262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6902048815311277262==--


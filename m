Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF817606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HAMbBaAl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j6/XbNnp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VHDm7XLr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PwWG5ioM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k0pN23I9yV+YjdjgioUzrHgMMzLxNCuo55dwfRYQTig=; b=HAMbBaAlhIuHrJXQd16lOtnxPe
	oFhbVLMuFRs6wzcrD0u7CoY+yaFtQuNo+64IPzZ7zfnnJ/5ockREjogVRMCWi39OsR3cFTHOSQ2t/
	YsWVJ7cSdMqH82lXbOwiymvs0vGoJPHyvG6ptoS19hRotjMIkOgUUsYgvlVnYatNWq7s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoT1-000000007GG-1SGZ;
	Mon, 02 Nov 2026 09:36:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNoSz-000000007G8-2hC8
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fXLpji1D3JHhjwDYKF2o7UduKwRueEPxoXfBbir6Cco=; b=j6/XbNnpSl+gWsYzK0aDK01kCg
 TbxtdgjglbtPQK5ZWUfvUR82+RPSs6pEKJD/XTWFirhvYfMaQyRC7lIzZaVuq7i0KgRoJD6j/mNOG
 djjdjnwb2/u/4XdLLmQXZ+s2eCL7oyvuKj20/8yX46DO3f9Zpjpg4WxCJRIoDH5kT8vk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fXLpji1D3JHhjwDYKF2o7UduKwRueEPxoXfBbir6Cco=; b=VHDm7XLrmdJeTANBZJO+GHt+NZ
 SBOReZwD8g9MKTk3TLB7W2dvmgSS8HZPKCMG+MseRk2EkZvecLf4LDyz36ocuV+rZA9QJaN/RYBbm
 hKw6jnDegz25J7JK6uf+9RdId5tzykKvAXGqX3OjD60HK3DbOe45U4mgkWjbCUWniImQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNoSx-000000002Fg-3SOX for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:36:37 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so25433985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793612189; x=1794216989; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fXLpji1D3JHhjwDYKF2o7UduKwRueEPxoXfBbir6Cco=;
 b=PwWG5ioMXR5QGZKMSZ6ku0ZFXR/qJudOaQH42iw6EJJJ+JZeF6sxxKtA+zHuLHRGa8
 WqFoL+Zekmv/E202LBgt00EkyvWo0cvnDfZSa65f+vdkbsWEFMlAIII4yXyugqZ8eoCw
 RDxKWAd2ME7866/6f7Aq18Zr09rX+bfAH2ow5Z7lTP51XkoLiqdEBny+mj4ZLRmLSJjm
 VgHW8bM2kCXOITgauPiiNCvQSzyP81TUb1Wac1SZae3BdC/GHyzw7FyGDqVS2sX30W8J
 f6pxZQPRM6+rc030UbqV31lUpKX0qtEDq4lTNFKDu7Gh2ydgfxiBSanJaxzE8LOMSn6j
 dLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612189; x=1794216989;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fXLpji1D3JHhjwDYKF2o7UduKwRueEPxoXfBbir6Cco=;
 b=rjFg7/03DJUsOlS3vOv4lRcZqW3gE0RbjfjUo5dJUUHgEAMPRIf5k++GVaByiBKfPI
 WaVoHkcoL+NMIelDrbVr+pj1qonxXO09IX69oM3m2w64Oh0EZOzdPXcwtX7NtuXdgDV5
 w1LC48yO0JApa13lSBlotOlKqiTel0JWvE26MJILLn+eTNX1NwshLi2mcJJzxxfIkACU
 Uj+SEzkdsa7I4l9CS6Dt4K5PpOf4DwIwUmyEn1hqUvlAZTLyN/i0jXzRf9t83qEbWQ3g
 RJFCebWpMujaEVWMkn9JoNYINgmXPAEwzEjykVHa9xVAbpMCv+RCjufdMa5bn+3n82Ys
 YWAg==
X-Gm-Message-State: AFq9FYJYNMvpTrxBjAQRuIeKJJZTNakyey+53ff3R9YY0W8EMYg6/2+I
 KPJAi4F8UBVcCFB+k1xuoO1xtBMytN+k6foQDkopbuJt+AG8hzklw/w7zoxkNK4BGvEodp/8Anv
 u0PPeYQ4hWAu7p+AZqpyfbnex/LMhg7TaqafH4EImAx3Dc5ku7Mn2h+rHrkLC15kFv8yM
X-Gm-Gg: AYBFou0fZ3BQwAFiHcdWFICpg0mto/Mz7EGqW4mMiHUujFksci8KVXb8OlnDTox/uol
 QuUJVlUX5/5m/JMPFE4x+bgahvtXSWfue4uNfLosazeqiHPijA9duqes9YC+OmLqSna96gMdOup
 wa9G+Im3jcCOH4x4AF933JxrkXiLPX+MxzGJvV18soprM8WZ3mdyyK1l92UgY+sgRz2dNIg2w8X
 DMxuEB60BND4uJaIBrBx8eMm/axH661UchufLbTirXdAHmeQwIwMMuHrXmD4wP2xwqOdWScOH5Z
 QvrSKqewKTB2bPjzVnsUuo1vUj1hRYtnyIa/b+2CSLt/Rb3z3hyR+qrXsFhpduop7yCUi1QWYka
 MxyGbf4vukr5YVHU2rwGgJBcaFUq/BTv9pCKwt38Y3NuZjFzxcklT3jw4NilUrbwiMvl6e1q4yx
 PuufQ32MKMs8jEvXN1DYHzBlWMPU0n1rCRNQkFsKx41ddeutRLY2P2f3ZpBk8wUPke9qhNjfauH
 1o12DjF/PxuoC+BebxKa9oeZlnMWLczrJ9dBG7a/VAQJV7qlLlRGRn/HRUTkCpGCBg43GKlUfqm
 bo7OppuKmLH1K+8a1qybWaP4QIJRLuOrU1Z1Qk4jV32/wSS43pjMei129uwquldKB0qHrnwhlnw
 4eIzuFKGl86TvufozCOb3C0rYC23tyNZEiKjqi3F89R7UpI6Qf89zA/OPeSR4BQO49X3X+knsYP
 Y1z6vcSA35s+Icdw==
X-Received: by 2002:a05:600c:608d:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4ac18b7dcdbmr222853405e9.19.1793612189022; 
 Mon, 02 Nov 2026 01:36:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm330508905e9.3.2026.11.02.01.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:36:28 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:36:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: c6f1c752d4421e47ddb937aa0cbb5dad6361aeca
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 09:36:26 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f4244dba895408404aa9cd48780df96f6e8c94b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNoSx-000000002Fg-3SOX
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
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
Content-Type: multipart/mixed; boundary="===============9168330422546544779=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9168330422546544779==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GUCUHLEUkoE="; charset=UTF-8

--GUCUHLEUkoE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Name of user not set=
 #1000061 has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(8 comments)
=

File sample/management/acc_dpc1_client_demo=2Epy:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860/comment/948de9d4_f5f700ba?usp=3Demail :
PS4, Line =
26: import asyncio
Unused import?


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1860/comment/cd76ff1a_5aff7b5f?usp=3Demail :
PS4, Line 37: class OmiAcc=
Protocol(OmiProtocol):
Shouldn't be OMIClientProtocol + receive_acc_dpc1 ?
=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/bf720054_4a733cf4=
?usp=3Demail :
PS4, Line 40:         self=2Eaccmsg =3D ""
Do we need it in =
class? It looks like a variable only in recv_notify_ACC=2E=2E=2E? Ahh we ca=
n have fragments so we need it, right?


https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1860/comment/6b553e57_49060f01?usp=3Demail :
PS4, Line 56:        =
 self=2EparseDpc1(self=2Eaccmsg)
should be snake_case instead of camelCase
=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/46a55498_7af227f4=
?usp=3Demail :
PS4, Line 62:         logger=2Eerror(f"Received sys_info mes=
sage: {accmsg}")
error?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/c=
omment/d19d8e82_3f627c36?usp=3Demail :
PS4, Line 79:     def _sendDPC1Clien=
tInfo(self):
should be snake_case instead of camelCase


File sample/manage=
ment/acc_dpc1_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1860/comment/76b6fec2_aaf99cf4?usp=3Demail :
PS4, Line 52: class DpcConnec=
tedClient(ConnectedClient):
Missing typing


https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1860/comment/906666c0_f42bb8a1?usp=3Demail :
PS4, Line 117:   =
      await asyncio=2Esleep(20)
Why we need it? If we need maybe we can add=
 comment?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1860?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289=
737d502a25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchS=
et: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Na=
me of user not set #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 09:36:26 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--GUCUHLEUkoE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Name of user not set #1000061=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></=
p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/acc_dpc1_client_demo=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/948de9d4_f5f700ba?usp=3De=
mail">Patch Set #4, Line 26:</a> <code style=3D"font-family:monospace,monos=
pace">import asyncio</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Unused import?</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/cd76ff1a_5aff7b5f?usp=3D=
email">Patch Set #4, Line 37:</a> <code style=3D"font-family:monospace,mono=
space">class OmiAccProtocol(OmiProtocol):</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Shouldn&#39;t be OMICl=
ientProtocol + receive_acc_dpc1 ?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1860/comment/bf720054_4a733cf4?usp=3Demail">Patch =
Set #4, Line 40:</a> <code style=3D"font-family:monospace,monospace">      =
  self=2Eaccmsg =3D &quot;&quot;</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Do we need it in class? It look=
s like a variable only in recv_notify_ACC=2E=2E=2E? Ahh we can have fragmen=
ts so we need it, right?</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1860/comment/6b553e57_49060f01?usp=3Demail">Patch Set #4, L=
ine 56:</a> <code style=3D"font-family:monospace,monospace">        self=2E=
parseDpc1(self=2Eaccmsg)</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">should be snake_case instead of camelCa=
se</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/c=
omment/46a55498_7af227f4?usp=3Demail">Patch Set #4, Line 62:</a> <code styl=
e=3D"font-family:monospace,monospace">        logger=2Eerror(f&quot;Receive=
d sys_info message: {accmsg}&quot;)</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">error?</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/d19d8e82_3f627c=
36?usp=3Demail">Patch Set #4, Line 79:</a> <code style=3D"font-family:monos=
pace,monospace">    def _sendDPC1ClientInfo(self):</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">should be sna=
ke_case instead of camelCase</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File sample/management/acc_dpc1_server_demo=2Epy:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1860/comment/76b6fec2_aaf99cf4?usp=3Demail">Patch Set #4=
, Line 52:</a> <code style=3D"font-family:monospace,monospace">class DpcCon=
nectedClient(ConnectedClient):</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Missing typing</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/906666c0_f42b=
b8a1?usp=3Demail">Patch Set #4, Line 117:</a> <code style=3D"font-family:mo=
nospace,monospace">        await asyncio=2Esleep(20)</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Why we need=
 it? If we need maybe we can add comment?</p></li></ul></li></ul><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Dem=
ail">change 1860</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Mon, 02 Nov 2026 09:36:26 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: No </div>

</body></html>
--GUCUHLEUkoE=--


--===============9168330422546544779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9168330422546544779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9168330422546544779==--


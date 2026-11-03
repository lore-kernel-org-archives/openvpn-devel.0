Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD58606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aOvUZSh7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bFfuS+Ew;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KpvEa6KI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VKDjouaW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=pFRfr44vqna9SaWy70OopcDo2EZyZl4UAXvUihDPKa4=; b=aOvUZSh7zhFY7k+s5k4LLu3B8Z
	GF6GYpYStZUx31bZNyJfxe6X+xnFHPCM4An+hltupX076lAO75QESLABV7qyWbJo/qNuwXEo6VCD4
	6R8w2fB56UDZM+bQW9AYO5ipcLb7Fw9+ob7rCIXJj9v839PrcNlIKTyLRsFQfaoiVXDY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO8W0-0000000044e-41yQ;
	Tue, 03 Nov 2026 07:01:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO8W0-0000000044Y-0pr8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xSw0pPz0Kyf7mByh5WhhYLMRaQrXPfHTZTgTwJ7fTyw=; b=bFfuS+EwkP/aRSFcEW18lwLn05
 jVsr21vZhwqfkdzTMiJFtyfmr0VmcW0Ou4js30+QMeBt71dt6H1Ijogy8K4hbXhxsgyu5grYQ5DaU
 2LXeBPYy1RSpjywcB8DhOM0dKESBmmlhxPiV5O8XyJzU7VOPus3ngHhdJXcGnXQrouZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xSw0pPz0Kyf7mByh5WhhYLMRaQrXPfHTZTgTwJ7fTyw=; b=KpvEa6KIEeFlOpcEwweSpcCdGj
 sJPCXbeMWOWrP1jTbGeHjZ93WZTmfmQAf30UAhmsqFAnqYNAzi9a5faWmDCt/h6G/1pIjVLZQQhmW
 8Gktkk2aV7gVua77VWZ8OQ5brfNZwyajtpNcGSOR0VEdKa+8Q77s9Wrb6DgxjCQxfzJI=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO8Vy-000000000V7-3DyK for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:01:04 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so3585644f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 23:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793689256; x=1794294056; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xSw0pPz0Kyf7mByh5WhhYLMRaQrXPfHTZTgTwJ7fTyw=;
 b=VKDjouaWjHlyMFgpwRM7Hls5/lUvySxi7Y1xyDqEkpXEzZJey938TqjbvS6N+94Ix0
 NeDripcj6NBPaoH6X3krmdeeT6lVq2MmRSRO/mQHzg/klAt93FwzmRBMrR7w5BceXPut
 6/KQDU6tEvEeNkkJwgIYFU0SGDfSrj3xd2J8et6KN2mpqzMqxRhCZo0ziXUkg+SupRc2
 s1Pt+kx4XYrLfqP6kaSTmkg1nYnLPmlcB0Htrsv10J2mlkOhq+TXZyDKuNSapd/MP/qD
 A6vabX8w2Lasexcul9+QmsLMi0i+e59bWYHqIcdRHJgjfj7h1kUQdJq/+vklajiQVqCJ
 a9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689256; x=1794294056;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xSw0pPz0Kyf7mByh5WhhYLMRaQrXPfHTZTgTwJ7fTyw=;
 b=ET2XCmElyxhNEwn7E7GiTLX9av5uFOJ2rFOA0CS1qrcibBoI1UPvYCIZD+ERrqGZFi
 gmuJ+te5+dvBY3DKSnUhw36AEY/lOxFsjid3o8JiJrnqbLMApFJeLaULpCDWXcued/Kn
 KSB/iUOgUSZqaRvacj4P/ApKY+cN63AP/V6ntKamNht5iMBj37/WvoAKYi45rbmal4dW
 0Nsj1tu5oigvB42PJP5JGwF7sPhfSlV9mrtavIQL2Rr1qCOv/93UyBgTQtIMfHEBimvb
 xK2Zx6eskQXO8dFvtgCWAQ3B++NhDLkXfWYUeopJWdkYKfR2vOa8u8HFBDooutEGg+Vr
 +hIQ==
X-Gm-Message-State: APuU4Z/m1PrajbugrlqtD0gJoZqf7FtCufO+qC7BaAWpHa80/6/G7UhU
 aqGeEYsBMaEJI4OOBMpwYSsjdWdYLrAkS325QassLz4Xl6L4vuAXFY+aPPOspgyDtDNYUjmYx8k
 oDxk7xvq2k/yl9J9THjYZk9zYl2OUMz8mJhFVfzZbYlcCqEalEs8OVpJrz9dgx0H8LFOp8FhJY3
 vR6s4DwQ==
X-Gm-Gg: AYBFou2zm5qX7ptSSC4b46d1ocyUU8jPx+xKJV5v+2AqrzTEwIXJWrZtmI+0SSnjhRz
 r4+X5mSf91WcJHfbz2yefLjyLLU/HLoeMIVgsUm6aGU+/AZBXwnZ1S4SJUZI+0o0r3+DndGHz4t
 EIXgYLBPku+w92X/Ix5k9F0dKSQGET0dgXX/QAnDLTgiFrmh81zeHnUE7rPqNbdGuqP68ed5U7g
 qgdkPmVNaPMLo0DJs2qPy3LCfLfmhfGkbpjuzuNjDcOkqS0+OpnERKki/gac7ClHV1Jj+Q3Ljim
 co+kaU1kA3QCEhiw9g54cyXhJvRXafa54LE6TKnoaXeQ/0PZCLmN8WCnv7xbSAsnUu3POxO0HNk
 1dvEH16MFZv4LgOnSUiVt9EMjY9s4pLDHEiSu2KK1T1Lug+ChHjxl25smt4YRIY9yQT6WfEGj8h
 fAfaourMU1Gs1qJgVFZY8SRxS9AhC/NAwZAPCc3KRX94BIcIpXyCDXloApWhh+x8G8Wt+FLkn5c
 305a7NQj6mlzWa9LPAKBC9Kl5aZgEY4NFmKHaX1y4qs992mKIMUL01SvgLe4VKq+waC47oSCmkC
 b/cR93/CDRF6Oo3HpTU08B8hh5/PhARW2p0tM7WPLPfkN48aZhmOLVbhN1QjIuSyMp+k/9kGeZS
 6qeNv1Mp2xgMAWf291HS22Trz+0i3JqLor5bddMEUPZmkwUG0IR6fEL9f0Bak6haCDFje+p6Tb/
 HkdpSGuWs0yp5PHBeY6sQ10ZJSeY+Xc5IemIU=
X-Received: by 2002:a05:6000:46c3:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-48e6e2f069amr18226152f8f.32.1793689255988; 
 Mon, 02 Nov 2026 23:00:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725a2sm22057765f8f.13.2026.11.02.23.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:00:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 07:00:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
X-Gerrit-Change-Number: 2100
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2100?usp=email>
X-Gerrit-Commit: adac8cc9b4bdcd7be7b54a0f0d70f59acaa253a6
References: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg5MjUxMDAwLkk0YmMwOGY0ZDdkOGU1YjMzZjk1MWEzMzQwZGYxODdkYTcyNTM0NDllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <604291ec2bab8b5b9e5a6db3b08fbeb46b2ab713-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO8Vy-000000000V7-3DyK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: remove
 dangling pre_pull_default() declaration
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5896454079177175751=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5896454079177175751==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rw0NbtdnpVo="; charset=UTF-8

--rw0NbtdnpVo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2100?usp=3Demail

to review the following change=2E
=


Change subject: options: remove dangling pre_pull_default() declaration
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: remo=
ve dangling pre_pull_default() declaration

The function has no definition =
or callers=2E The declaration was already
dangling in 6fbf66fa ("This is th=
e start of the BETA21 branch=2E=2E=2E"),
the oldest commit in the history, =
so the commit that removed the
definition predates it=2E

Change-Id: I4bc08=
f4d7d8e5b33f951a3340df187da7253449e
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
---
M src/openvpn/options=2Eh
1 file changed, 0 insertions(=
+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/00/2100/1

diff --git a/src/openvpn/options=2Eh b/src/openvpn=
/options=2Eh
index c58530a=2E=2E1c908c4 100644
--- a/src/openvpn/options=2E=
h
+++ b/src/openvpn/options=2Eh
@@ -929,8 +929,6 @@
                       =
     uint64_t permission_mask, uint64_t *option_types_found,
              =
              struct env_set *es);
 
-void pre_pull_default(struct options =
*o);
-
 void rol_check_alloc(struct options *options);
 
 int parse_line(co=
nst char *line, char *p[], const int n, const char *file, const int line_nu=
m,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4bc08f4d7d8e=
5b33f951a3340df187da7253449e
Gerrit-Change-Number: 2100
Gerrit-PatchSet: 1
=
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--rw0NbtdnpVo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: remove dangling pre_pull_default() declaration=
<br><br>The function has no definition or callers=2E The declaration was al=
ready<br>dangling in 6fbf66fa (&quot;This is the start of the BETA21 branch=
=2E=2E=2E&quot;),<br>the oldest commit in the history, so the commit that r=
emoved the<br>definition predates it=2E<br><br>Change-Id: I4bc08f4d7d8e5b33=
f951a3340df187da7253449e<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>---<br>M src/openvpn/options=2Eh<br>1 file changed, 0 inse=
rtions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/2100/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index c58=
530a=2E=2E1c908c4 100644</span><br><span>--- a/src/openvpn/options=2Eh</spa=
n><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -929,8 +929,6 =
@@</span><br><span>                            uint64_t permission_mask, ui=
nt64_t *option_types_found,</span><br><span>                            str=
uct env_set *es);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void pre_pull_default(struct options *o);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void rol_check_alloc(st=
ruct options *options);</span><br><span> </span><br><span> int parse_line(c=
onst char *line, char *p[], const int n, const char *file, const int line_n=
um,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2100?usp=3Demail">change 2100</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340d=
f187da7253449e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
00 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--rw0NbtdnpVo=--


--===============5896454079177175751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5896454079177175751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5896454079177175751==--


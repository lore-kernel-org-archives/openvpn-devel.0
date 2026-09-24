Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296FAC9830E
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6z3DbbYM6PH+ydrvh1bTBGmrCHcc4be9YhXhVesWC4s=; b=bN5KGCNEryoQG97ymGMSUkScpV
	sTg+VjKyfv+vn9ohSscTQTRjizm9O5mjm/SjbYlSprWiFQ39omm1YgeVSfglJjXi7OubQ0lyG+3Zb
	FBDP4njPSXamZcICK2Cq/yzwUi3ikbB576xZ0hOhdGhYqjnj1wqTGQW29UOUBBs2INVA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9mL4-0005CA-8i;
	Thu, 24 Sep 2026 16:30:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9mL3-0005C4-4U
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 16:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SeO6lpbKCh2g/jyWxW99VSNCVJDF29WQ2/JjQDRJX2Y=; b=FFIL52mM4bcxsvMVS1Y1AjKy4G
 5FvGYWCrrEyyQZp+oOHpQ2ML+s+M6kmj/pVfbMekWpc4RATsAH6f1A6RpD3FZeCEcswGaKvhwnKOa
 3o4pEliK0pEzZtdp2CJUoGmwyXeanZJU+oG+fGV5j/HqKBEvgd0qXjDYLykdYn9T7KRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SeO6lpbKCh2g/jyWxW99VSNCVJDF29WQ2/JjQDRJX2Y=; b=c
 SLDewAEGEce1PGuwDjPw1rL3sys9BGvB2/Apw4bDf9fkmlGwES0sl2IIjTIZSuvNRnBVI33wM9VNm
 eK/Koen7qMj2GkqAevuaxswRtIZRdNSMx4wOTH0H1ZDPcBuf3vpnq+UTHa1WprnGlPOmb7w6ZUKzm
 +JuRB6oRa/QeAEwQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9mL0-0005UB-HH for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 16:30:25 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49e73611928so6756435e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790267416; x=1790872216; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SeO6lpbKCh2g/jyWxW99VSNCVJDF29WQ2/JjQDRJX2Y=;
 b=H0ztEG/mFNjuQkjwPlu0BobnMbi49jHueMKQrzszOk/P03JtxskvIk8bhjRuvgUI00
 DpIRTa/PrLtP6HReqvSH/mHe+u60uKanKOpHYeVW3FJOCTn8gWmYApJDv5CdylAkuFMg
 NrzGZpFkj23b7s+FjEVu/f1tr8Jt0dE/TS529PrkRpAAKsW05vdt/tja40NibCzL/0b/
 cjzDgcxBC5WBRTQNc44irvnepeM2o9XlwhMLfxl3fHXhkpdZCyO6V7puEw1HDcHWPF8X
 sKSjFsCXY5JAx+rCUA2nX5uoRvmtoGNo5C9d+xTc7JqaT5Ng6jnltA//7b0XQbxOGrVx
 sn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790267416; x=1790872216;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SeO6lpbKCh2g/jyWxW99VSNCVJDF29WQ2/JjQDRJX2Y=;
 b=roaR3yRiK+UCHpC9+lQV3bqrVjmI3F6Tp386pfN0TnTWZDbvnBWP7SGgtb3mn+ocKA
 ZeQ13EMxnZYEfLcjYHH/maYceUVeW4gwxNMnpPXRJmACe5K/1jucXr/FL3Xd8sE/E4jn
 GBofWolvOAkMv3LFy0ivuRS7PgssdsjFOtfWAcMiex9GrchSyOLEGpruTp3fJPqKCAVY
 jABzPRpJLgeg9gbhY8ib66rvUF058w1u3KftBHUE9cHirbaVl3bhMwT0VzOJa5a/3ovT
 gNPzn2YavaCJ1sIyPDWcvKaVUf8VFnTJ91PSzfpvhw2JL1UIZYh5dz1X2hjj/Vd71sYr
 n5dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTLwE3FvBBHMSX7aE0V7Tl/PMPxhpypFkasnLIp7AWHmLsswvQ7RbL9PKW0hGitFsE7YdmmH4te28j9AgJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mgoJk9AbBFBKAUAIqSfoaz95E+du7sR9mV7uOrmUaBuLY0CqNp
 sMAqeFmnuiNS07lBPiiWsM7PMpk++sjNv7rqDC0k0yeP0fgg5MDBfuD4GJiLIBtwpQHefjMX38M
 Wka2bWghSITHgOSc6FgzEQJSbJZ59nvhBknkd7GPwiy4bdhU9eQHXWZiMD/6rfabvcJkq
X-Gm-Gg: AYBFou23qrJuDFJf39kxvNh6cuCq6I5PpPFrZxWjPRJ5KQaPBjz2L5ClJrr9XtxwRax
 +R+n660z4t3WlfYkm7QmiznJH7hXKd584xkVNAlbii/5bIMAaAVkKhdgyZ03/Az+lpPaFKfU0Wd
 Ku07m6hbHjp529pgX1+VKChtQ+iLEWA3UlsmnIHJzELZl27uIvd0pTPymQBDKhRsJ6pc6WDGSwk
 z/xJWW8gDT9zdQ+ifbsKXpydBIDFiufCRvM0y2NskewO27Y5H8dYytpbtJHdLFnLCKAQ8+IoP80
 DKsSGIEQUQ+vl2GCv5IZftFwBeaKaya6WCW1LQ/ETNfinF7z4dEOMGksmXRzkF/fknhzFIcBmE3
 xCeee+xEZSiwwDtsbcC5wZe+hjVLzUe0ZHKMblwXeBQN9tR1pIvMYlp101jhCFCjVi5VRgRslUZ
 z2SGyUvtZEAdgmqf/zKB2lyVOP1ZRsOgKPyd92jy4tuDNl1VpSkSDtEOAWTVoM9xZvAWMTS9Zfw
 CwNLJXQmYcS8oS+MSDIktEvbalnNoOUWHleGqLvQbDXwiMNOOacAwz3lhO+0bN86WJmEvSW41El
 CLzm9kpeRZjOCMS65WXFZpPlQ7t0DW3UGqKz+uRqmB6QIlCLfzxU8NZpU/u+
X-Received: by 2002:a05:600d:640f:10b0:49f:bef0:7858 with SMTP id
 5b1f17b1804b1-49fe66fb03amr42986115e9.14.1790267415829; 
 Thu, 24 Sep 2026 09:30:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355c65sm146991f8f.19.2026.09.24.09.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:30:15 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 16:30:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: faaea4c811c3bc93b2121a96b2a4aef893259467
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 16:30:13 +0000
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fcf618c1c9cffeb972d48377d0324c7d0bfd7271-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9mL0-0005UB-HH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: read
 multicast notifications on a dedicated netlink socket
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1018182647774604059=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1018182647774604059==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dP6gjkHrYjo="; charset=UTF-8

--dP6gjkHrYjo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

razvanc has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1737?usp=3Demail )

Change subject: dco_linux: read multicast notif=
ications on a dedicated netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/dco_=
linux=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/comment/9dd7d752=
_434d3488?usp=3Demail :
PS1, Line 1228:         return 0;
So before this pa=
tch, we exit early here if `__is_locked`=2E

In server mode, I _think_ `DEL=
_NTF` goes to `multi_process_incoming_dco()` -> `multi_close_instance()` ->=
 `multi_client_disconnect_setenv()` -> `setenv_stats()` -> `dco_get_peer_st=
ats_multi()` (-> `dco_get_peer()`)=2E

Apologies if I'm misreading this=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7894fc360b12c5a0f=
63fad2abb9bbb1ad9c2bd5
Gerrit-Change-Number: 1737
Gerrit-PatchSet: 1
Gerrit=
-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: o=
rdex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Thu, 24 Sep 2026 16:30:13 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No

--dP6gjkHrYjo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>razvanc has posted commen=
ts on this change by ordex=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1737?usp=3Demail">View Change</a></p><p>1 comment:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/comment=
/9dd7d752_434d3488?usp=3Demail">Patch Set #1, Line 1228:</a> <code style=3D=
"font-family:monospace,monospace">        return 0;</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">So before th=
is patch, we exit early here if `__is_locked`=2E</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">In server mode, I _thi=
nk_ `DEL_NTF` goes to `multi_process_incoming_dco()` -&gt; `multi_close_ins=
tance()` -&gt; `multi_client_disconnect_setenv()` -&gt; `setenv_stats()` -&=
gt; `dco_get_peer_stats_multi()` (-&gt; `dco_get_peer()`)=2E</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Apologies =
if I&#39;m misreading this=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail">change 1=
737</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
a7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1737 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Thu, 24 Sep 2026 16:30:13 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--dP6gjkHrYjo=--


--===============1018182647774604059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1018182647774604059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1018182647774604059==--


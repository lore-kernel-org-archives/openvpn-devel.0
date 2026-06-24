Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F17CCDB479
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+qal3UKXO1ewXVnSyq5VSgKCTKZyU6oK1l+sLZDrJs=; b=DgVfd8Id+dI6w+FlCw/jQQrRtX
	XAPtztHufGnQMyABA+bu6uWVaS/hdYnOzbFgfqzSiaDgga64LQiJeKiBVgVV49dyBrzftwUnmLyAM
	Omkvt0ZOk5zeDP0xUaVSHk2MGylr3cLROXYHQsJhhfRK1+O+emgh3So2Jp91gGuylVQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcOTh-0003Pw-V2;
	Wed, 24 Jun 2026 14:21:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcOTg-0003Pj-Je
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3/trzzvcGebYnekZjorXk4QFHbj2V+Ii6FTBNIvFpKY=; b=Ig1rXLQNdHDew9YnWuPvgDCQmM
 xWjCFRqDwYNuV5A62+DGkRxA2BWQvO4EgEyP1DX1q/IcMzeOrYO0ajili3QjU8go0/mwHCi88ROZl
 YJJDqKfjIv6fJ1MECq8gn8xRyAeQo3ldgdG7Y9Rz8sRe/Y4MSCIQyacg2pYnfIK6VR6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3/trzzvcGebYnekZjorXk4QFHbj2V+Ii6FTBNIvFpKY=; b=Q
 +2XsuDC31ZJ0YX/Ip0lTAb1CIe9jZ+C+mb3Slr2FsoUhovm2coNRahkE9aqZry7ygwyMWvkZBDrhH
 cTsuMC75ZZq53tWw5u4qWs6chKwF3x9fnEz4Tryy1a58Msr4AA/KMhuxn0Y3JdJ78IXrZAt5K0XUj
 Zt7DWvsnV/d8dx2E=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcOTc-0007y9-G2 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:21:21 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-464192ab2e1so808580f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782310865; x=1782915665; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/trzzvcGebYnekZjorXk4QFHbj2V+Ii6FTBNIvFpKY=;
 b=JqM0rSpBT5qvcOOEpwv9C/adfz8k5bYTuu5yjh46IeAzQ1FLQYHeqJTwgehcYXNayx
 QsYo3+KCZw4kQ5y18GjNc4oVEb20rmPMofZzbONiUQRFN8kgxp69CJyk5Z1cu371J+MN
 xYsyrGJy4qIK6mfG0f04TjmqFrocCJCzZtpYrfR/1VgXgX3Sp/t4kNzIImEdxQdz+JjL
 cqy2Da5p+1f7dGJl0L6gw3q2UmwlOtjmP7Roy0f7bo9E9xAyjp2RZZttYtbtGbTsugYX
 q/TuKoBSNEDoEchkgcS2WA9H05wv4yiGv4QXlWQUDpp5Po5IsC9isdjmjXyyGjyM5AGk
 /x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782310865; x=1782915665;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/trzzvcGebYnekZjorXk4QFHbj2V+Ii6FTBNIvFpKY=;
 b=TGZTaiLvMO3evvgN8P+BmbY7f7g/6AC3x5rITuAk+up3RPaqjBNa7Trsd+hECPFWrY
 0lyZqqQg8kdzM8Ma9MOeWTrZu9Umjw8AVs28IH6FNEtV591rTWhZlmv2QyuEoWnxAI/r
 GrvwVcs3ZCUGo8KBbvQ0TSafqI4LmAMtnh7FcYykHLH4OGngXErXquswH7ILRHzsFFnL
 GmXIAG/J6d7teqv77CYgq3x7w4WhmqbCKIMR5vvOyAVk/sz8JdwL0civf8nIKx0hmz27
 EGTwE6hESFo41TORgb5ozyrmLVLTiQMr7sbcxytkLXa/M46aAlbmsfVHlzLo7Q4D82XN
 NWhQ==
X-Gm-Message-State: AOJu0YxphTvRYCWtQom7iko3MwehfMuTN23HM1tyTitCzcILYCwYJ+9Z
 GH0Z+qRCto541Nq2nG64g9Rv2W6Ba1KdwMwSvdj1KACYoDABerqtLssTGQRWSJ0AhAh2bKmSZub
 LM6Bl3R1JHPD41QJ/11SldF06UdTbGuApLqwYIhl3JMWIjgUeK4U6lOaOgpHKNS9tyhpgscRfmR
 ZS0/b2TQ==
X-Gm-Gg: AfdE7ckZjHAsSkpZSQWz4Rnb+OGiKGri71EgGaeUjOMKJmHZyTJmXaOMn5JBshgLbT2
 VjaJh56XAh1nejjXv/i70vG4XSg0E6z/9/h06IqX+pWwp4t6bW722L+MUqr8xMqAO97YpAdpHXv
 1itQVSrwHUcL2ETuIIM8O/JKJhxsf/N6wgCkDa0llIQowuPl8Q+m/NV/j+iEkQN65dhuvZFlFUD
 hf8G0K7EQu7KkBIWh58z6MaN7205pxaQ1YKy1cNpLFbuF/n1QwBCcZUIClg8fN+Mv2x90bpXgFf
 gQ8rzICYiN7sW8LRyWQmhn1lXJMCWOkPvrDAy96PHqbE4Fa5wDeFgmGk2tBu/3dL3q3iOt/yIR2
 pG75g85Y4xcLzenJHKl54yz7t66H0vDxT9KGM9P1Ebg9TGA+js9BLGEJ1zoTTHNXggzvWBA9G+j
 zpYa0zQ7rwq2Oa/IYD+zD/5YT3lyyqngXY2G0JvJKdPF0ocbNx8kq9BwNB2aE82NIm1lV2XDNBH
 ynJy2fJIUdrV9VmVzYaTmDfMe4Oq1yV8LkGljH34QIY1X4nDYPmLy3GcQ2IGac0wchYR9fZ41Js
 dDw=
X-Received: by 2002:a05:600c:4ece:b0:492:40f4:9fab with SMTP id
 5b1f17b1804b1-49260875c0amr49043485e9.29.1782310864333; 
 Wed, 24 Jun 2026 07:21:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1fa34sm520430015e9.5.2026.06.24.07.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:21:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 14:21:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: c0541eaa980ef834b0c33d23aa466d7582ea877b
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 14:21:02 +0000
In-Reply-To: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1382433085613e8764c08a4dc5ef1bc62cb1ba63-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcOTc-0007y9-G2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support p2p NCP
 negotiation in p2mp mode
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0686466217984780051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0686466217984780051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vbLzS6OPYE4="; charset=UTF-8

--vbLzS6OPYE4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1719?usp=3Demail )

Change subject: Support p2p NCP negotiation i=
n p2mp mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review-1

(2 comments)

Commit Message:

http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1719/comment/12a6b108_2c37c3f3?usp=3Demail :
PS2,=
 Line 10: detected=2E This is currently make little difference as peer-id/D=
ATAv2 does
"makes"


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1719/comment/4a09bf76_44215984?usp=3Demail :
PS2, Line 2339:=
                 /* If the peer is using NCP P2P we also use p2p to make co=
nnecting
How is enabling sending peer_info "using p2p"? This comment doesn'=
t make sense to me=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1719?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I8f3545f703126dbe96f809e69ad351749b14b1e1
Gerrit-Change-Number: 1719
Ger=
rit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 24 Jun 2026 14:21:02 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--vbLzS6OPYE4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719/comment/12a=
6b108_2c37c3f3?usp=3Demail">Patch Set #2, Line 10:</a> <code style=3D"font-=
family:monospace,monospace">detected=2E This is currently make little diffe=
rence as peer-id/DATAv2 does</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">&quot;makes&quot;</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1719/comment/4a09bf76_44215984?usp=3Demail">Patch Set =
#2, Line 2339:</a> <code style=3D"font-family:monospace,monospace">        =
        /* If the peer is using NCP P2P we also use p2p to make connecting<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">How is enabling sending peer_info &quot;using p2p&quot;? This co=
mment doesn&#39;t make sense to me=2E</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">=
change 1719</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1719 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Wed, 24 Jun 2026 14:21:02 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--vbLzS6OPYE4=--


--===============0686466217984780051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0686466217984780051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0686466217984780051==--


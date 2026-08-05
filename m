Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B36C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uP9vZ6Krkx/p+I8GZJamG0yh93V5FgXe9ZQ41SEuQ80=; b=Z1hLx5ETS020KO1IR7DBHJ2rWi
	sctI2uSa+Hf8Fpsw5EzkJS73hZHtVBvPFDJ2fSZB9DS9YHzQj+nzR7DZIEgtz8pQLzc+g/757KJhG
	j+XNNrXtATty2ROAng/c5XiqJywNtB2174ICU48AnuYkzBuPu5Rl8WoYyGVNcd97sv+U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrZnE-0007hA-07;
	Wed, 05 Aug 2026 11:28:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrZnC-0007h2-Fx
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dMk9yxTT2TVjfKzJqNOhNx6rKaGv/APpHKem9jyXhts=; b=MCxewLsZq5cST5dIrwQiMxTLIH
 q8lIc2L/1wl0iE2pxMwemGvHmMUsrxwwfzeFkuVV3SbXajTkPj0l4eVdRaINe3Hxtpet7LKnVu1Os
 h97byOSiy+ywAJFRjOLTFr4B9JGjJwWSLYVH1rIdLmgG88njuCIqWXzbUUduAoOFkoyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dMk9yxTT2TVjfKzJqNOhNx6rKaGv/APpHKem9jyXhts=; b=K
 y29X2hehR2IF9NmupKkxJfh1nPxL/mr+DeDlyA72EThZdKvME0JwytRjx7PjHGkwVOc3dGYwlLT/G
 hzLeQhuay87Cc0U7kObJmZGFFMjw6WHCwRjaAdHSjmtFkPOsEuDKvPuJELvIuYgo2a7l6mC0sp6Y9
 8VC9vhjqSOSmXx8o=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrZnC-0004ly-MM for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 11:28:11 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fdd674e17so519623f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785929284; x=1786534084; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dMk9yxTT2TVjfKzJqNOhNx6rKaGv/APpHKem9jyXhts=;
 b=E7Q24OLDjFjGhmfqFhx9BTToGb3N5Sw520l+XD2G1sqlhVrFiCDHUga5fGejaq11m2
 EWClWl7cWwO2k47k3c8Sos8vMaYQ+0sykTGKrzV9D7lTcFaiYLZjOQmo0krOL0kGtI9n
 QJLT2tvYEW9wL4udWJ4E9oYtp511qqwYeJJk5XNjzgMDpSQFpNxe+tdNTKqgRhk3nMQJ
 vQxMmA94iRW9x9cFvATc4RvPREuNP2Em8tmXjcnTxbpna5NuTnFbpEdVzPd1QpYCbK2i
 rESD7q+dd6O3CcshI0lNPg9UTa9afvTMwNCO2ii7Z7K7lzRPvKq3qqDVDzAtXddqNfR9
 XkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785929284; x=1786534084;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dMk9yxTT2TVjfKzJqNOhNx6rKaGv/APpHKem9jyXhts=;
 b=Igx5jndVnWBfhh5NYAJsQRb04bzWiSA6rb42ohvxuaYfsz0t4Q0gUBA2Bh6QnbLoO8
 T0xOorBErycvInCNlKkzHghBkQS5frj4euXZ4Whz+TptD2PuA+RpLDzH3w7tIaPs+5xK
 hUzKDoX1b+NfHZrLqXidak1mbgHyJU9R/tiQbbz1OUR0xCCkPCyHqRxbHSvPqZ0O90f/
 CwRrCfbo0Bl/MECD21SuJmtOYbRyD6OqwHZQpgnSTYhMiMDRfarGDSwFL96M/R/HvdlO
 N9WSUuhJLv/MBsmRZWAigyXcaOWIrWjCHpvdqcimyrTJ0+pbh+abytwwrjHw+Lla8GQs
 keTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJunGKwvQrFsVkyyVUfqynqfBHRPns5qgXWy1VR4ZCtBqFZGBwYm1GSjP1ejqRNKXZSQtmXIRrmlFfLGDQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy8J6Ztqbea749BHXffyy3ZqxyVvWxUqLcCU3+1xpRtQg6Oxe9K
 ANN+hm+OXlz8/ZJ+rWx/QB2Ai6N+MmoZdpbYqZgyVY4McGg/kEtrQKSn6qXG3kJs5oL99Pw3jQT
 NGwLlpumISPpMUba9OZ/HEow+1cTcvoBpYuy1R75fJYW702gaHqSSUOoAGZHK/qPu7DkUHhRzaN
 kXTQy0kA==
X-Gm-Gg: AR+sD13DKiM9U9vQNqZ2tRKRS6UBd2PIaT89qX3EGRkbDLPgjNji1yE7w+J36WMJvQi
 D7x3lb7+7CtOJnSrHnWOCBgpWosyfz5i1ZGt8Njq0etmgNS0fHhKDAvIW6WVaLfuFvjWsybU8AX
 AxZjrVjmETVAVaRTfUG4ql3tAwSVup7Yx94d+g4Qjw27t4BUNbjs9q3H4M295YyFzUugudCtJvX
 /oK1pnLLPCMO4++Gnk7focknC3aYzp4zZZEhuHY99aKwQ1RLGTXLDZ0j1jZk5gCfWPxDKknGaQr
 38/HvTfdF4ksa9t33I5h51VgI8kLHAnkEMEcmPqTMVgzIkC5+MIVpclr3dVVGldeEhqcanHQx4w
 oyPnflRhkrSV6zvCB4/bJF7o9DC5XTc2JF7yVDTkTW2/Op3m2M0tPjRlD+oKfYSt+lQG3OpTx/u
 3p6Lmpc13W4EKx4UtQvJ14of08CNzp2yvFFo5EofSXYb1oV7HniYE9mN8OlnLDVZawljtoK2vQS
 GyPlHqewqserbpfZj1EgUt4TzdRbG5zTqhv6xOjJSAT9x35eFx6e4PHRCm75/JtkdvimuQjOhSJ
 W34V71/GWHFMS2xhyh+WgSvdaR3OpiQVwlsuPzCFirQYJN5/9fI=
X-Received: by 2002:a05:6000:4310:b0:47f:ecbb:55f4 with SMTP id
 ffacd0b85a97d-47fecbb60ecmr9045112f8f.27.1785929284288; 
 Wed, 05 Aug 2026 04:28:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec24a23asm8388873f8f.37.2026.08.05.04.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:28:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 11:28:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 0b8d09de0d5aafe99201f1ad7c26fe95d102f519
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 11:28:01 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <02d501d5ab46ffe3f0c23600422cb7083cac8ac5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrZnC-0004ly-MM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8257111977763855713=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8257111977763855713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f4s/SZuQvYc="; charset=UTF-8

--f4s/SZuQvYc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/init=2Ec:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/678d0749_031a3587?usp=3De=
mail :
PS3, Line 3476:         ASSERT(rand_bytes(c->c2=2Esession_id_key, si=
zeof(c->c2=2Esession_id_key)));
> I have to say that I don't particularly c=
are for sprinkling that `ASSERT(rand_bytes())` all over the [=E2=80=A6]
Don=
e



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb4=
9981bc23eabf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 4
Ger=
rit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Wed, 05 Aug 2026 11:28:01 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@licht=
enheld=2Ecom>

--f4s/SZuQvYc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/co=
mment/678d0749_031a3587?usp=3Demail">Patch Set #3, Line 3476:</a> <code sty=
le=3D"font-family:monospace,monospace">        ASSERT(rand_bytes(c-&gt;c2=
=2Esession_id_key, sizeof(c-&gt;c2=2Esession_id_key)));</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">I have to say that I don&#39;t particularly care for sprinkling that `AS=
SERT(rand_bytes())` all over the [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1827?usp=3Demail">change 1827</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6=
fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1827 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Aug 2026 11:=
28:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--f4s/SZuQvYc=--


--===============8257111977763855713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8257111977763855713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8257111977763855713==--


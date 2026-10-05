Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C651CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EcK7a5Ic1oJsxr/d94gQ8vNrkNqvrjS4DGwL276FhXA=; b=hW5gpKxk6EeYIpWdLSQCNdFI2z
	5hveQ0fTO8e6qgeO/oPktOq2+u62cDjot6nyVgVnisRmRKVfMqzcPrKfhykNTZnbvGb02rHrjOO1T
	0lddh8AVUHOC03ux0HHbVOh2J29kszaKkRSmQ1IVMN/6QciEcKQ7qcJ6De421b/xOAKo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDi98-0002eP-73;
	Mon, 05 Oct 2026 12:50:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDi96-0002dX-CC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SNg8jnZnpPSmY1e3V2YP8hUWnvAdH9gkMSHa4xaL2kU=; b=MWeEWNFIWGdMv9nGsnRJyLRtTB
 CCPCk+Z5bwB1ikgMttkVHZz3xCVcn6NjiDoBTqxu9tlNDpwsAjYxkcE4r6EN8CvY1q2yW0W8YoMTG
 X38KkX7+NJ7tD+TvVNMaD9Yw/Ct9CDXwsBgHbuQ7PyMJcD8WSTgNnppMQhOQtYSJ4yMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SNg8jnZnpPSmY1e3V2YP8hUWnvAdH9gkMSHa4xaL2kU=; b=B
 9Z8FGyvjg/J0jfyEIuShqlkMrcHEcvptJFKst7FLugVR/MM4OV8GDqfa9s70VqSQ7+sgUWQc24YMQ
 1z9uhGCON/WlVYIU3iQLwUpzpvTsUAzyOY2Lbhkn2vOnCNkVc9XH1rY6BRk+zvA8awi5BiHJALLcT
 OmeyLMmHZSQJAlMo=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDi8y-0007Kh-1t for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:50:13 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso14713715e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791204605; x=1791809405; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SNg8jnZnpPSmY1e3V2YP8hUWnvAdH9gkMSHa4xaL2kU=;
 b=aL4OyZYD+p+F9/hv24yesI7S0Qq1LBHUst5oSpjYT89BWWYyoQ1EB8RcLM0Lper/lE
 UU0jsb2aM4ihSR0EQxaS/4l4IodQkroub5iWW/E8XR1UimCaigZQSnprLRpdDwkzBqxD
 GaI8dWLlWOMuIfa0pv1YxbamczhyEL1EzwsgvW+khIv2ejAFLhvOWRCr8fmEmNtjEnH+
 /pEYtyOhJaC0fYbAcrZB7YY43x8am/NyFWFAptsapeN1wiDDVKGmRckXoOtD4kHiRZBY
 5Nr5VzbwNsaz+9vunhTtb7S5zhs+ZjI2ZAz2Rm2fWBnMwNJPax6It1PVvJV9srXQDVH4
 gUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791204605; x=1791809405;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SNg8jnZnpPSmY1e3V2YP8hUWnvAdH9gkMSHa4xaL2kU=;
 b=pYt6kIHcByG6JlwT8wMr3AbLQPLVR1ymo0SkWwvX+W8rWOhYZ7Ic4lV5blg+Gr0M3+
 22D9CSzsl0LllUU0qQOtmMTqJxKt98g8kvoG3Aop2RBwMKswnENvSIUjYe93oGYnwqyH
 cpL7TY5unz25Afh4T4wqiDpiBEzokpRfSX20pna9ttmwYUXgVajPP5RaFPrxnhthDzo7
 GOk63EjarqRO8j+ly+q9WXjyZNHgzX4R1+yI0c0Inh/DeApWjiyd577BoWy54gWpL2vS
 x8rdgEBoIFLoZmUH41qKPVJ2ia6WId8UT0Q6Gtv+XRYqRGH6FEraM39fMuiI6E94cWiu
 2EmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUJdqJfJ7Smrsx3pgYu+3s0URzojhGTe2oIAAuMcwCBBlPe3PfmoUy1Vvf6rYBf0RVZScH4S54Jtp9HCfJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++l1j/3TyEpFUAKDXkQRYnVWnn1Y+LOgH/A3/RLxnzD8JnDv2cZ/
 EWp6ofpBpHpm3P9lR28vHe8nc4dy+jgRpvszvmKlPddEqowib98dboEvY5rCWEkFkmytgZYSGlM
 IUgjOVPObzcViF2Z4RGbqO/oaRHeKBOIFcns2B09hY8iyhuVi+6JGZAqVPQzG7m6rfzbt
X-Gm-Gg: AYBFou2rgKQpKudlXAaFD2QxhjJfdGnj27a/MPlprSDH3Yp6+UyLbhLwHKd1tvUCpRv
 UCBhs38qseF5+XU0Fn9ygbfmeOolSZOU/fH8rOLxZwp7yzrOJoZsgIbUkzXL0b59Lls1YETJQcv
 PZal3FRd+Nvtw08z5uEynGXKJrzRnfHYFw3vhCvUJIBUDwVfkupMXvdxsslpJJz3MwTNl2OtzDh
 FlSIlGvJJVyC33+meZU28W4AcbiGErPOn5y1xrBRmcHWkmyIwFdpL+w5WsQdZ5Xc3yXoNMx3E2N
 VGSStaB08gfWZEXRbEIBqOn1mZPLtUkexZvjOhMo5D/iutbPEYtyR+bOfUexiZF+DQFr58uANEd
 3J/BWqwzde6+73pGH6sJo9AgnYN0ylXmwyb3RGnolTykvH3tFPemgBLsGEJ06GsQ7hb902mo7wx
 fXV7jVHQ3NVH/cNA/gksD5rCsJp2ChPpUARNLuJGGcYrlLEQqyDrZRgnu7WZDK3SEmyRCNk0r1S
 plTI+OvN3OpqhzozASMfHqxxQjwJ7J1fYc2kiLv9WRQjHLbWxieNC4J49eFP793mxNxoER/AlqJ
 MlS1a42MeokZ/Hk3AUzH9ZK77x3RTAU+fp6htz7n+WJKPR2DnwkSf7hxoXVzD1IXmCnEHcCt
X-Received: by 2002:a05:600d:864b:20b0:49f:fbad:29be with SMTP id
 5b1f17b1804b1-4a0276afda9mr125551505e9.34.1791204605392; 
 Mon, 05 Oct 2026 05:50:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229291fsm3567379f8f.27.2026.10.05.05.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:50:05 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 12:50:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: ee5a484f5ed3ead1661e14d2f0b009139fd3d6a7
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 12:50:03 +0000
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fbbaa51d104a4f036608a9ab47ed396483b65a66-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDi8y-0007Kh-1t
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0010595885856426465=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0010595885856426465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Oa7iHanYWr0="; charset=UTF-8

--Oa7iHanYWr0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru, plaisthos=2E

G=
ianmarco De Gregori has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail )

Cha=
nge subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

Commit Message:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/135c2ef4_046ee1d3?usp=
=3Demail :
PS1, Line 16: TCP side copes: it tests proto_is_dgram() and tcp_=
link_out_deferred
> This is confusing: it reads as "neither UDP nor TCP che=
cks the protocol, but only TCP checks the pro [=E2=80=A6]
Done


File src/o=
penvpn/multi_io=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comme=
nt/70c25658_08a7d345?usp=3Demail :
PS1, Line 568:         while (!IS_SIG(&m=
->top) && (mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
> Ah right, I overlooked S=
IGUSR2=2E [=E2=80=A6]
Added a mention about the timeout branch to the commi=
t message=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1962?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I165=
c632da6a837d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number: 1962
Gerrit-Pat=
chSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Comment-Date: Mon, 05 Oct 2026 12:50:03 +0000
Gerrit-HasComments: =
Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Comment-In-Reply-To: Gianmarco De Gregori <gianmarco@mande=
lbit=2Ecom>

--Oa7iHanYWr0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru, plaisthos=2E </p>
<p>Gianmarco =
De Gregori has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"=
>View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1962/comment/135c2ef4_046ee1d3?usp=3Demail">Patch Set #1=
, Line 16:</a> <code style=3D"font-family:monospace,monospace">TCP side cop=
es: it tests proto_is_dgram() and tcp_link_out_deferred</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">This is confusing: it reads as &quot;neither UDP nor TCP checks the prot=
ocol, but only TCP checks the pro [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi_i=
o=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/70c25658_08a7d345?usp=3De=
mail">Patch Set #1, Line 568:</a> <code style=3D"font-family:monospace,mono=
space">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(=
m-&gt;mbuf)) !=3D NULL)</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Ah right, I overlooked SIGUSR=
2=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Added a mention about the timeout branch =
to the commit message=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail">change 196=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
65c632da6a837d0cca55bee4c2cc390b91d1e54 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1962 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Greg=
ori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 05 Oct 2026 12:50:03 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom=
&gt; </div>

</body></html>
--Oa7iHanYWr0=--


--===============0010595885856426465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0010595885856426465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0010595885856426465==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD670C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Vfgznjt8Nqj0vylwy8B5u3qgtTECYuPdkSLRv2r5g4=; b=KPrfPw3EzBEUqlW3KFoLDRLmoI
	t50gCRqRaIjlbxWXr9unhP7sMkHjiCJInEWSYjECy0G4/nWbeZmTUhaUkzF8nPEHIhaUveI7ia/P5
	QUAjl7At0fcqwxYHCkYVdP6GavxM/8rJsuykksIqV6Sjg3+WuPzbTCqbF1n17MpX4dkA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA7f8-0000Sn-Db;
	Fri, 25 Sep 2026 15:16:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA7f6-0000Sf-Os
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DCU3L8p9KULU0hG2rN3q5RyVc7/t64fpf2kSfs3qiGA=; b=cc0m7amW79QnUycucclT73/VX7
 3122sIAIzZ5gM8JMaau5Sg5XrYJWs/HhTPtbN8vf514yfp5QDYX5VpCDB3W9W7KEsdPoWcHpxd77M
 ZIqWbc97VjhlxuxAMdXUbdvOEdWxNZUFuky52fpnEhKmHNnz09614YbVhpQxWqC5W7TQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DCU3L8p9KULU0hG2rN3q5RyVc7/t64fpf2kSfs3qiGA=; b=Q
 UNTm7dlEcvnbXHbTZ/rXVEAvuE1vENLZN9Z7DEfQwBblPp+blGiLEGz0AuxZsafr8KhLOfdCX/GEx
 DeQgVOuAWPBBd6U08Vn9iYs8oV9hE0RMsUvT36PbwGhokDjCuIECaMVNax69fkWRRTQuPC67p1/w1
 0DpEKdVip2FViFPQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA7f5-0001eg-40 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:16:32 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so8521015e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790349384; x=1790954184; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DCU3L8p9KULU0hG2rN3q5RyVc7/t64fpf2kSfs3qiGA=;
 b=LYDTOxHSW7sqWhy0DCPV512nv9oER3HMuAdZcVVIEc3qwqimLohErvR2RCskWXVBSt
 ISoyHcI5hge50lZGkQacNQKquWNyGgqCqUR0gFnm3uBHRYG4JEmo2+8wlFhiDq6IDN8Q
 rc2yKJ1jqs1H34v+AmirQUzeiD0Mwjm5BjI7YqMuiyggNn0VjzJ9rFKpSB8TEO5xsMNB
 b2eGo2d8VijrZwqNn+ZsHzrs8qiztkEsiAWtwfmYOjH2rBM1qmgPhdd96bYRhOiNb8tz
 0kwkZEgiYuaj2L6OwHCz/AzFIzBk4Q8osBKDEx23DSHE/dG+KdskCeIsFOhCansceV04
 GQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349384; x=1790954184;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DCU3L8p9KULU0hG2rN3q5RyVc7/t64fpf2kSfs3qiGA=;
 b=prTKGT2d7oUgDbvlO29+oRCAzi7ZcdWSwK+167cpjdNa1Zteywq1KeeXWt+6NuoolE
 K2iR+GZ5+IwMuP0h2dGyLd98lLnNf4BzGZGOAq83MWJRTDCOeZRXHXwZa+SGW0ROv2bw
 m3gslfF5RvoTDATIiN2zU1y8RThiP+SZ4Ay4Hk5FKbALnlVXeV7QqSHK+2SYvaIVRnVj
 9pnnXrRaYAAGBtDpfsebGUtr3j8WS2eaPVf5bgs3iOqtA6RgST8VjCpxn1TYabW2vrfi
 Cdd2rSaZuqr0U9OQQ+4lNtcvK08u/gt8u7FdXPY64aBA/2/SbDo+FdeOfHNwOEO/DT+S
 TzGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp72ItVt9X9OPKQhvQXyWx1hFZBgL3Rh6iyAQGJg7fuEl9um9mxbQWqsjxTbXMGeAGqIGhuJoaTTPjj93v@lists.sourceforge.net
X-Gm-Message-State: AFuF++kkRRsl+pK44oEi9qjzLRYdh0rTBxRxd+cZMbXo9VLSuVCnQhta
 5kyki9cs2OFN5HY5/8rd2Db5iXYDdDdGMskIuR2ttsWPKj2YYyx8rDP7LhTTw7peGaE3+zYVLwe
 wcWf3xcB+WiOdUXPgrvV50s0ro0+9i1pcwZ+keQryKIXjpVV2FSThCfTDsC+vjGF9gSvL
X-Gm-Gg: AYBFou1seDXtXLoJCU/HhBNNqLlSRx2P/EcYRp7jDSoJ7od5tJ/oNdi7q0m5JCmriiU
 i8//a+PRfaWy9hvPNsjIA1AfwwuUZYkCy/N/L0OTUZYvsmVDhxnYYF4RKimTw3t5YOaVAI1fRTv
 2HuucAD+rGhuvD0EA+dEcRlY7LFJSYqwloam02oU3bIdVHBxg0l9D/21uXE4tHsfQI9B9B3HEF1
 YuQ7eA2q8pFffIpV3Lmyehq/xIet6lPrZ4zjYPUxISuv4bQRJANfDrRhvJik7bRwS8q2eP9d28S
 CBSQC5Rs1rgP3WbLQmFiSEL+HpKng/1jXdBIhMktsXjjepqhD3/ppMQFkRVArhycE5kuW3/8JC3
 A6RpXxZ8UwvGSPuyMDCr5cfbFHS7w+pJ1V2q1LyxY13IQzdvwH3cut2KW0FaX0ZsfqOwVHlzHno
 zyqMdc/S0+VgoslMeFG/XI4IBDpl+pmPtDT4VkNT6v+7rgNr2K/41RdDENL1V6HRB+Eh3sYcTva
 cilnKapI62U/82sfpw3iw3N7ljUs3cT1jJAmy5JPaUzxFsctHFeZ45yQDYOteGs/UY9+ZM68fT5
 jQKhv4WbyNfKOM+37X977qQ8K1ZHdNdtR9mFrunQjANbbjpCLeENHXmF5TAB
X-Received: by 2002:a05:600c:1c05:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49ff63406ddmr23528535e9.9.1790349384341; 
 Fri, 25 Sep 2026 08:16:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6450a3sm7119670f8f.25.2026.09.25.08.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:16:23 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 15:16:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 62781dc17328af91c589e6aa2b3c276188e2383a
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 15:16:22 +0000
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98c16f5407471a84f957d90a182068d2b11d413b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA7f5-0001eg-40
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3457506713778099271=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3457506713778099271==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fsSARwU0wRk="; charset=UTF-8

--fsSARwU0wRk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, razvanc=2E

ralf_li=
ci has posted comments on this change by ralf_lici=2E ( http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1952?usp=3Demail )

Change subject: dco: stop fetchi=
ng peer stats during client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/mul=
ti=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952/comment/948864fb_a0=
d685bb?usp=3Demail :
PS1, Line 507:     }
> Could removing this here end up=
 with stale stats in some corner case? Would it be useful to still ca [=E2=
=80=A6]
Yes this was a real regression=2E Fixed by calling dco_get_peer_sta=
ts_multi in multi_uninit=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/195=
2/comment/f2b618b0_6d782ed9?usp=3Demail :
PS1, Line 506: multi_client_disco=
nnect_setenv(struct multi_context *m, struct multi_instance *mi)
> you shou=
ld remove *m from the param list too=2E [=E2=80=A6]
wiped it out!



-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6f=
d1061247b05de
Gerrit-Change-Number: 1952
Gerrit-PatchSet: 2
Gerrit-Owner: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
G=
errit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 15:16:=
22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To:=
 ordex <antonio@mandelbit=2Ecom>
Comment-In-Reply-To: razvanc <razvanc@mail=
box=2Eorg>

--fsSARwU0wRk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos, razvanc=2E </p>
<p>ralf_lici has po=
sted comments on this change by ralf_lici=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1952/comment/948864fb_a0d685bb?usp=3Demail">Patch Set #1, Line 507:</a> <co=
de style=3D"font-family:monospace,monospace">    }</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Co=
uld removing this here end up with stale stats in some corner case? Would i=
t be useful to still ca [=E2=80=A6]</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Yes this was a real re=
gression=2E Fixed by calling dco_get_peer_stats_multi in multi_uninit=2E</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952/comment=
/f2b618b0_6d782ed9?usp=3Demail">Patch Set #1, Line 506:</a> <code style=3D"=
font-family:monospace,monospace">multi_client_disconnect_setenv(struct mult=
i_context *m, struct multi_instance *mi)</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">you should r=
emove *m from the param list too=2E [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">wiped it o=
ut!</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1952?usp=3Demail">change 1952</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6f=
d1061247b05de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 195=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 15:16:22 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:n=
one"> Comment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--fsSARwU0wRk=--


--===============3457506713778099271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3457506713778099271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3457506713778099271==--


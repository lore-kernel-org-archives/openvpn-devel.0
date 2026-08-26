Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D960C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVPNf6i2ZuinjAnKz/HjperfJvbScaEhHw7GebO8p4w=; b=aw1kKZdiIy69dDJsbi79HF6sEN
	UIjwwx879VpDt0rhpLw9fS0YMBpf8eaY6/ecxyUod0Dvv9v692PkV6ucl7d7dR/kDE83xry69xOVZ
	5AP0Xx+ZoevabvF6LA9wo3o/QTmp5iHZW2g6Zuws/Ol+uZCXYaJHNR5xabxta9kUAc6o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzCBG-0004FG-Bk;
	Wed, 26 Aug 2026 11:52:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzCBE-0004F4-T4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iHzRMQBbEjP1XEW8l0tHm6aZVcE0LXbhxDvTeCuUjcs=; b=kiukh+qZE80hMlmLq1Y+BpbSMg
 Xq2wp795e7XANRP1MQNm5YKEo3gSoxE2wMpl/m9kik1kCsumEhMU0Pnae+lOeeJ8ixF+ho4r3Dlp0
 GYgSjtNB/pIzK3rSTKcqJhqQQa7M54n0h51F/06zqXwTyzBRaF+f/FWi2iT1iXxXDaHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iHzRMQBbEjP1XEW8l0tHm6aZVcE0LXbhxDvTeCuUjcs=; b=D
 CGq3LQsY/agkovpwxIvytM0/+7AlGJxb1iPII/qGB68F57KVoQ/gecT9OPcfPgWRvOrwMRXUzIfUX
 TEfSXtVoUDrC3Y5gFv0SUq+88YZp04LkRQ3P2+UqUEdZF9kFgC7QmlGZmzSt97XbaFgyoqrysVM/H
 WUkJXQltxFjp1M4c=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzCBE-0000zJ-OG for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:33 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so125356266b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787745146; x=1788349946; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iHzRMQBbEjP1XEW8l0tHm6aZVcE0LXbhxDvTeCuUjcs=;
 b=EWNJSUyxm2a44YvZicoJb+BQEgtIJ7mG3qgW4+ArbPZO4prf8Z1IpRYmLBQlI+X9FP
 enqAcQi9ZkphuzVtJOTTCsIPMhJ4sxZa/+587C508NG6RVibX/pqLj/GRai+skplNHsI
 oO8eI2YyWOkFfpFn6JYU85md/KQkttFBGhlautu5KqY/yIHAGb+XbfUZF4nhjhQ4bCFp
 xfCHobrfhkvVAI76jGeesyAbVAV6WYumhJ2aSXEf5qg/RBveRzrkqX560ncs3DLYVz6S
 0iBuZiZyDJo1CW/dXzCgcM7dbJiAAQqHCS2pxXWV8pDY7qfkUGOotIhvZrgUHaDEX+DP
 Xh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787745146; x=1788349946;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iHzRMQBbEjP1XEW8l0tHm6aZVcE0LXbhxDvTeCuUjcs=;
 b=Nj2MKVkabfYch373kJ7opfv/YwsyVdgR8sdOvxIlkctpB4XOsRjnDmsYVod5yK459m
 /SMxODAyn5hIVAZBwDe47f7pRDYD/TuBqZ1CV1oPr/SOWbHExGByr5YXbtTDoez/+oTY
 WnhWttbat0p53BUqnefmpSDGMDuiV05R3eDFF11hcSgYMbA9OrkVZDVfYcuJUKOBW1WC
 i7nV9rPdTJEruYlQfKICgI3aR90c9AAUV/LRX/yqHhIfCvQeJHCEPoSXR+5I3M5nNaR+
 vjlJ6j0xtcpruuzdeNyv8d2lIkc4CzY7MILqK9QabeAHIWGqC6FT4W0Hi6E97SSYRv21
 2w+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RogBfPaPoTV1epSelsZFcnk2jHx6M2TzOK4pjpCEc95UCgKjorftUS7T2r0oM/BKhvr6JMLIeUTHVmSYu3T@lists.sourceforge.net
X-Gm-Message-State: AFuF++mmpYv5spfRtIyj16nwMndbf9rtzxfCisg8gJ/1uYTQ8RXkLfZj
 HI2h/Lqe2QUrfquC9uAcvGXCxaoJIdWh7FX1yg9Tvrc3Yn7kxtd4HHPMeMUo8CNz12awAaRXqDi
 8JbUeYf5jWoa3bjpdev3lbg0lXv4vSzJXLvgLGi5WgQng0TsWXitimDDubi9YUFjxECLg
X-Gm-Gg: AR+sD11rBViTWT5jCtPG9MGP2pk7BH8FNGDIxNv3yIlhtTrgram99PXDEh+jCCeWJAa
 wrCVuBQn9dl+3NPLExV+hhVflu9OQq7CEce8j1M2JBp5zzmUMd84uOTzS+1deqSE7VTghtXSyQQ
 lLSsBhhdq+3h1klV0wGIVDw7AYNjLY9cIQgqyRIZoOujRHRYRx5kcub41zNvc5ns9PCZXR/FOz9
 UH+b30ItZ0TFvunxODHBZbzXMvzvVJb/fHri0kfdnPtN1MnKXUXCx1Frrdp7++DXpuWk3KyCo4r
 Q86ZEBg1eJIiG8bT4Ix83kNmrtJguOWWgPRMtSyNWMcA9qAqISifPTifxbVuv8mACleCSESWQPj
 f16V4PEIXIcwBuyp+FeF7e7t7kEWw0Rq78kee0BFqVSazVJ2WXGfKmSEZJr9EY0qvHZ0vc7bKQw
 hMoJbr5byDfT8DVWuKTWgpfD0uZS617gDUBja92L/k3r1p7op1VM161WeBwyu6fJh+F7kS+a97p
 O4QGV3rbsRAWpFzwGiyvt/Oi4aMJk7FjkhFVxDF6m0YzyCK4JdN6JzOPm38en8ufcyU2HO5uIRN
 FwxH8rLXxOVq0RmNKZ9p67GpZkuNeSZBb8Zw7zd/RtFItpCXmdk=
X-Received: by 2002:a17:907:1b24:b0:c20:7cb1:9046 with SMTP id
 a640c23a62f3a-c250bbce005mr762784166b.8.1787745145915; 
 Wed, 26 Aug 2026 04:52:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9e96bdsm341146766b.55.2026.08.26.04.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:52:25 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 11:52:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
X-Gerrit-Change-Number: 1259
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1259?usp=email>
X-Gerrit-Commit: 4ccfed975151a7bb0601eefcdac5e847c514cf24
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 11:52:23 +0000
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU5OTM5OTE3MDAwLkk0MWI5Zjc2ODYxODBmMjU0OWJkNDk4NGNiYmY2NjA1OWYwYmEyYjE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6bc383a027a6d464781b306b279120cd79be3ac2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzCBE-0000zJ-OG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Fix conversion
 warnings
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4633564806939948258=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4633564806939948258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dvAgPpMJdzY="; charset=UTF-8

--dvAgPpMJdzY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, razvanc=2E

flichte=
nheld has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail )

Change subject: init: Fix =
conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 20:

(4 comments)

File src/openvpn/init=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/ded92b20_f010bc69?usp=3Demail=
 :
PS19, Line 479:             const long j =3D get_random() % (i + 1);
> O=
n systems where `int64_t` (which is what `get_random()` really returns) is =
larger than `long` (whic [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1259/comment/0abac177_ddf43818?usp=3Demail :
PS19, Line 2868:   =
      msg(M_WARN, "TUN MTU value (%zu) must be at least %u", mtu, TUN_MTU_M=
IN);
> Didn't `TUN_MTU_MIN` stay `int`?
Done


http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1259/comment/53d215a9_4e3811ea?usp=3Demail :
PS19, Line 2875:=
     return (unsigned int)mtu;
> `frame_finalize_options()` calls `get_fram=
e_mtu()` and puts the return value in a plain `int` (`fram [=E2=80=A6]
Done=



http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/baaa181d_0575fb2a=
?usp=3Demail :
PS19, Line 2905:     payload_size =3D max_int(payload_size, =
o->ce=2Etls_mtu);
> Should this be `max_uint()` now?
Done



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0b=
a2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: 20
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: ra=
zvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2026 11:52:2=
3 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: =
razvanc <razvanc@mailbox=2Eorg>

--dvAgPpMJdzY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, razvanc=2E </p>
<p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">View Change</a></p><=
p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1259/comment/ded92b20_f010bc69?usp=3Demail">Patch Set #19, Line 479:=
</a> <code style=3D"font-family:monospace,monospace">            const long=
 j =3D get_random() % (i + 1);</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">On systems where `int6=
4_t` (which is what `get_random()` really returns) is larger than `long` (w=
hic [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/0abac177_ddf43818?usp=3Demail">Pa=
tch Set #19, Line 2868:</a> <code style=3D"font-family:monospace,monospace"=
>        msg(M_WARN, &quot;TUN MTU value (%zu) must be at least %u&quot;, m=
tu, TUN_MTU_MIN);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Didn&#39;t `TUN_MTU_MIN` stay `int`=
?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1259/comment/53d215a9_4e3811ea?usp=3Demail">Patch Set #19, Li=
ne 2875:</a> <code style=3D"font-family:monospace,monospace">    return (un=
signed int)mtu;</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">`frame_finalize_options()` calls `get=
_frame_mtu()` and puts the return value in a plain `int` (`fram [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1259/comment/baaa181d_0575fb2a?usp=3Demail">Patch Set #19, Lin=
e 2905:</a> <code style=3D"font-family:monospace,monospace">    payload_siz=
e =3D max_int(payload_size, o-&gt;ce=2Etls_mtu);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Shou=
ld this be `max_uint()` now?</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?=
usp=3Demail">change 1259</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1259?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1259 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-O=
wner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Wed, 26 Aug 2026 11:52:23 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--dvAgPpMJdzY=--


--===============4633564806939948258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4633564806939948258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4633564806939948258==--


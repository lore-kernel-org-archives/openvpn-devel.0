Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B47C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9LjZQ2g1jroc7kFciBI3oywYYzrtUc8NmaUgwl0Prw=; b=GEnyXYjHtsXG06NoL7sNJ2RF5p
	uKBJBHKkTZuBWhLYggnD4vJ3/0fn0lHPwsx5cLt/BEdrt+H0kM2Y/k0jhrUkl8i/djvrwdHF4UKPS
	5Ul1psDxbQ30+CQDp2wb8b0N5S5OaLSBSRk+w8w/Ov+ialJxIzxohmB/qpis2PDe1QFQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGMh-0003QU-5p;
	Wed, 26 Aug 2026 16:20:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGMg-0003QO-32
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l8dhGFthI3MDvKzzclyJ7yPLYg3KQuVIfGpYpJa/FHs=; b=g0THzKddv90VJDim4VIschUpiw
 96mYaYxnyIwom7ujQl5pP1hJhIVDqogn4Qr9ZCN2Dgh7zwN4NDsAaZAIgbxcHJhUN3swuDH4cBI+F
 3+o6QBLDq4qV228PH+Yrscu+ZJ1NXVNZubiQIgwGvoOSIhrL6/mZVZnmQyC2xl7PvYQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l8dhGFthI3MDvKzzclyJ7yPLYg3KQuVIfGpYpJa/FHs=; b=e
 uuCRWWaYbiubnFq7me4BUtwVXhgnV0bPvKqC8EDtiNocDaOrwzXYGkTbRAV2MiET07vffoM5hzlzc
 g7xDi8BaMIR2LrG2iNokclBKfH+/WFqnZU16U/Wj/Mk/ooWAOfMOIhvA16lxau1/X92pm/Z/2cCxw
 gLlSu0nc92m44I/w=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGMd-0000a4-KZ for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:20:37 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c250f28f1cdso185109066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787761229; x=1788366029; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l8dhGFthI3MDvKzzclyJ7yPLYg3KQuVIfGpYpJa/FHs=;
 b=RhM09gvyQ7ZWf28m00iFfSRpLP+TmyQyBGsvx4SaG6dVLZU+Aw9PB/uf1JvKOjWwql
 VZ7R8UxyS5JPYiTlhLZIAh13N2oxpj0oXleqGpLR3TgB0MYvyrEPF5e8Sf/TODt/Jkex
 69caRnH9Pa1K6QUI5CKl4J99xNqEp0UDdvCrEswx7KevzL85pvTzRV0uumOglS48yhf8
 xfDrbuKdLqgmdRrywQikigI2yBHVSbfrBC9f31tBZr1W998a6rh2bKbqWQFf/Pr8p+e7
 qkmbgaojg3xUiITYH6Q5GQzTfglSYXHkFJE1GHclft+tg5hKHNSTCPczl03PjDjYeqzX
 uCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761229; x=1788366029;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l8dhGFthI3MDvKzzclyJ7yPLYg3KQuVIfGpYpJa/FHs=;
 b=pTUgsFqYd/Hnf6khAH1mOnd2RQ5XVFZi/UWKops95lQnVmC3igAmuxP4p+Q8242inv
 +vKP2E+qqqg4X0+Lh/5QXDIXjR7Ih4mRhuitny4ViA538S5+/2alk/QP95WoO14d31cV
 0fCo4PEBygaYnKtl1zND91flbvhdS+o8RklFAycfco2yad8zXgF0oYnzF6MfMi13xjxW
 K7oDgSvoVLHm0o7bqFF6t/ZQv7QFggCHss/zTH7E2UVl4X0uo06XkaIUb0gPH/h7kMTK
 eqF2L7/juRa4smoVAWO7uWyDFAVyipUyRA+WZtvwfB/WQyNkkCE3ykCvMsuB3xtKTRk2
 6S9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKov7eoisZ/mITBhV0zG77LbxNlkWVShKfpsSxAuW45l8DiDqugtNdGqyPp1TH9jUt9TEFO15GFBmqCoW6@lists.sourceforge.net
X-Gm-Message-State: AFuF++kPSqRyAs/K39l3HdQNj4RUpN8q6YW/wgH1CPI79rSbLw7Gyz13
 UR8azuQu3OOwEGTUV60neY/6RL0VHZjpNrh7l56JQyWt5L3RjO8wRt2MZkdDCN/h0deGxZT45G9
 g705SAy/lGl02PKA4WWkLkiiuGgpp5rriYy8QnXhgMauoQhd8A+Ia/g9nLimxCPbx3xnkOGqGF+
 VTW/lbuA==
X-Gm-Gg: AR+sD10c9sk0mLlYpWn6xqFFFfJtv3UoTktiBQ6iT2cugIlB/1WemXNtmTMpXFW5lFk
 ISbOMETXjfS5buHUf8EYbGS4CYp5CyiJQjZKnaIixPFHWTukKfHWxGb30Vp534edhRidlxC+bBZ
 8bE3z6VSLV20Bbv78Btt5/Nv5W0laHXovOyj0x3PIY9PwZ8uIY/8b1wGh/5dHkX/zzhN1/mEsEo
 iIUK+ekc1LKpRilSqYAfh6kS6AcCIv/PV++NT7kJ4RpDn8/d5fQqIitaY6iNGpnpQ5p68/4OtBx
 kkg9bp4r9tSpIorzUknvFWiCc1YU2bzePsXRCsyyWXBhhHUwZDLa0pjiNqWvyPsS8HzBXmDAyGP
 mW4Nq6fwzfeIFVH4LTTuNDhlRiP5igo7e9TWYsD5gbk80vmbKEbdd7VcCattcqbYDSizZ7Sc1rX
 /bODhZQEJne4hzrPW/ekuWO+ScqvXtSXOcN0NXKhBKnNEw2/HFkVhVwWFUyAUTD/g50HhROv68A
 cJ+yu7OdVQ1vilcY8F7+1MUgR23Sq2dyCtKc2ILERj4AG7ScLbX4SO1Zyy6W3uhjmTKhda7OKmP
 G7FUqygsBtKEkH3WIziq8qL63AlFE8rdjBZnvRcZHEY39ZVqnuI=
X-Received: by 2002:a17:906:7947:b0:c15:f598:60c0 with SMTP id
 a640c23a62f3a-c250bb7e838mr1141243766b.4.1787761228907; 
 Wed, 26 Aug 2026 09:20:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a73038asm499053566b.26.2026.08.26.09.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:20:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:20:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: ae69bda99914f727fb69583d84c44d0aa04929af
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 16:20:26 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a068d8821be70c0930aba545e577e3e5741e127-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGMd-0000a4-KZ
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
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
Content-Type: multipart/mixed; boundary="===============2123477254640012365=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2123477254640012365==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qlocYHMkACA="; charset=UTF-8

--qlocYHMkACA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858?usp=3Demail )

Change subject: Implement sending/receiving a=
pp custom control protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 7:

(6 comments)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/a73ff0bf_a28fe2e8?usp=3Demail :
P=
S7, Line 8: 
> Should probably have a more informative commit message=2E=2E=
=2E
I added a bit of detail=2E I am not sure if that is enough or if should=
 add more=2E


File doc/management-notes=2Etxt:

http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1858/comment/2cfc1ab3_fa444e68?usp=3Demail :
PS7, Line 804:=
 the common app custom protocols between the client and the sever and insru=
ct
> "instruct"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comme=
nt/849c64a3_5071de33?usp=3Demail :
PS7, Line 814: This commands sends an ap=
p custom control message to a client,
> "command"
Done


http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858/comment/4d3e874a_f86d254d?usp=3Demail :
PS7, L=
ine 829: flags    -- a colon seperated list of the encoding and the flag if=

> "separated"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/commen=
t/eae2d13b_0570948e?usp=3Demail :
PS7, Line 839: This commands sends an app=
 custom command to the peer, the format of the
> It is not directly clear t=
o me why we have two separate commands here? One if for P2MP and the other =
[=E2=80=A6]
Yes=2E Will explicitly mention that=2E


http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1858/comment/aa0be400_85d94649?usp=3Demail :
PS7, Line =
839: This commands sends an app custom command to the peer, the format of t=
he
> "command"
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerri=
t-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 26 Aug 2026 16:20:26 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichten=
held <frank@lichtenheld=2Ecom>

--qlocYHMkACA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><p>6 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/a73f=
f0bf_a28fe2e8?usp=3Demail">Patch Set #7, Line 8:</a> <code style=3D"font-fa=
mily:monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">Should probably have a mor=
e informative commit message=2E=2E=2E</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">I added a bit of det=
ail=2E I am not sure if that is enough or if should add more=2E</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2E=
txt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2cfc1ab3_fa444e68?usp=3Demai=
l">Patch Set #7, Line 804:</a> <code style=3D"font-family:monospace,monospa=
ce">the common app custom protocols between the client and the sever and in=
sruct</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">&quot;instruct&quot;</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment=
/849c64a3_5071de33?usp=3Demail">Patch Set #7, Line 814:</a> <code style=3D"=
font-family:monospace,monospace">This commands sends an app custom control =
message to a client,</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">&quot;command&quot;</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/4d3e874a_f86d254d?usp=3Demail">Patch Set #7, Line 829:</a> <co=
de style=3D"font-family:monospace,monospace">flags    -- a colon seperated =
list of the encoding and the flag if</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;separated&=
quot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/eae2d13b_0570948e?usp=3Demail">Patch Set #7=
, Line 839:</a> <code style=3D"font-family:monospace,monospace">This comman=
ds sends an app custom command to the peer, the format of the</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">It is not directly clear to me why we have two separate commands h=
ere? One if for P2MP and the other [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes=2E Will=
 explicitly mention that=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/aa0be400_85d94649?usp=3Demail">Patch Set #7=
, Line 839:</a> <code style=3D"font-family:monospace,monospace">This comman=
ds sends an app custom command to the peer, the format of the</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">&quot;command&quot;</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?=
usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 16:20:26 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--qlocYHMkACA=--


--===============2123477254640012365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2123477254640012365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2123477254640012365==--


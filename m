Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F10CC61DD3
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TH/to3/7ncjDCmy+ucrDc/KbO4h6tE9VteRq3FIgujQ=; b=Kkl54qRk5T7Ki+2Z1f4aLth4R9
	lp2PMAUXMs7wOCUW4/Ir+A814OWnXhNYMtGrhK1IGuIdyHrZbm+FzDSdI85Zkjtj5fjcZFUrUCXCN
	bQTG7NSf5ad2ldU52YKhuMP9/EIFkcd+0BwEjdvFkpzmrjGe7nfzpBS1TEDm7aMN8zm8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x15ef-000519-UB;
	Mon, 31 Aug 2026 17:18:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x15ee-000513-9j
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kDeJWkVY92gniG9fAQy+2wa6fBP45mBBsMgLuxEAYBw=; b=QRnJknSXlFwFeC7BxTvbP0/92+
 aHxYU+YTui7omm8BvBBp46EBuMkcg2eH7ZvN1zXkeYqW1yfSproathGZU6D9ee1Ijpowi0Lp0oifu
 kOk338dPDkq1Pr7oAPDC17SurWoHSSx9J/mBJb71mzQZViDKK43PX0Ku39499BtxBI10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kDeJWkVY92gniG9fAQy+2wa6fBP45mBBsMgLuxEAYBw=; b=e
 ZvC+W9mVq5tVnWqmFR1yHfjILNQlhGQtkt6LCSM9ShOnBsRtSGX2Z2WjOJA+w8Va0p42nKEVQv7/O
 2it4Rts/EA0Lt0Nz369A8mK1say+nx/ohVnl5DaHD9koM+7CgrwWnoSDM0eddxjbI72YG1MbALjnE
 TEVy8acXeg1patpc=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15eY-0001lA-UX for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:18:41 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48436216a98so957944f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788196712; x=1788801512; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDeJWkVY92gniG9fAQy+2wa6fBP45mBBsMgLuxEAYBw=;
 b=ULQmDVofzc3NVaRJCeeR96zKsm6TV8MmzFXHzUAHVNoJbnRS/BxlmHB9X6OkFFR6of
 NZ7kZhqepcv8iDa0yZT99zq6wagkg92qK3HdZn6UoRMzHxIWVN12XJFvnBaBwihhZzpc
 zsVyjOCaC6j8XL5PP02OoBtm9+QC+uBeyxoMPIL8PenF/bcdiMlHKixSj5bUjU8pcrJ9
 roXlSfbOASwTDxOBp++P4RAYyiAIsh45cLlaCj0uemArNWdrIaBccsZX1bzTSZa2ZvCP
 7l+0WXsn0Y/ZKOut+u2NzDg78GlWQaEnvM4ZpLDQq1hV8CFMrra/hK8Ihwm542fFgSiw
 iHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788196712; x=1788801512;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kDeJWkVY92gniG9fAQy+2wa6fBP45mBBsMgLuxEAYBw=;
 b=ULqIrQuNxWsm6S+BjckK43/N5wW8h6MA6gzvJH+EcXj6jWSisHJ1Ad5dkOp+C8Wgm2
 NZjCHkK9Flg3k7cgPbN81nbSKrkMifTwce8cix2BEbAevjwvCxIdX/FGKGumhJvS64if
 wI53Er71wriL3jFwbOJ9JI7NC0RDkZNRilkVCTBfoe597DEBTZsd32S8JzjZu6dW/k4S
 sfoAwRd4lt9psV4xSzXmi7j7z5qkiq3H9OBFCFS8kM4O5jGkyRHqU16m30n7w0UGyqp6
 Snh8X5V/hvIJpqIJYPd7OJQjR11J2FHbzqbpMiYqbe51qQTbDTQWRCKbt/2kbltjO2iV
 frkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxG/zdsxbscLofqgNqyhSt7gOwsHoJEVu51B8ukQa83SUogQKGty9A8yYt9SDSwpv/GNfdQnLUZ9TNfZvxC@lists.sourceforge.net
X-Gm-Message-State: AFuF++k7Q82A+7AKmlzXCCL8boKpeTM87YPZ4O5fKV2VrZwsZtOmsAh7
 xjyLnrzi3tOo0h+rNd6/LDDNs0BsdWRzjy1AiT9t8qZZi9k9yWDwLqd3p5QukcI55wtlIPURfA3
 REyb6d+LKPRlW0McXxt2ea5TjCj6IVtjhuKLKxG8A+I/IZYWNI425N8OUi4sm15qrCKhU
X-Gm-Gg: AYBFou2aYpDDGvuEXoWDPKZCKGXe9/3VtDrp7prZOQmF4yrrbELQr06n/ibfr5SzNh0
 Qu7RcoJUkhtJkJVXmrsrrLSsFsHZMOHuybHWuCso02sEytDQjH/ZrF6Wv9W3x0lEfP90aKpi4Tf
 nbdh2oEGL3a/vo+oRvPBScSu8ddv2TOyvDqNa3eYsLZyZec1lAsEkNOmulXBCjBU92sYYVSVvxy
 +CC2pehTBjG/ePhDM/mzVUbJkLYW3SQDmbFN4F143gGqDFR9MJnoIhTdlrLXLdpktp+PNnnF+Wq
 DVeLkt1ShckEQW8OtnVczDx8V37l6I/INlvOHqbYLo2hppfm43hNAwxJ8/tI59DfDryVbVzlYSR
 PostTgrU8434iZaMzqx8Ircqr0Ou3prniu+hLhbHk7xTlwaP1LhrkpnMl56RBlm+DMMtwvUEFdD
 sZ4ggxqASjGExrvZHjnCMaHP5N7C0FgBxU8WqN+s03/z3saiip+HQ0yy7X6YjnvuSDodHk3z3fk
 Ee6pqGxSCIWiw/HXVDRhSUEow1O15Zt+vHi5h+LUC3dIHxM44LGuI+KoZiKVmYjzshDte/DDTUQ
 6UPniuB715GcDSi5EJhUKp8Dv1OIr2hXJaT8UPaPe3yQGmgvh2c=
X-Received: by 2002:a05:6000:4910:b0:482:a8b1:aa6d with SMTP id
 ffacd0b85a97d-482f79c1923mr43175577f8f.10.1788196712109; 
 Mon, 31 Aug 2026 10:18:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm26382530f8f.1.2026.08.31.10.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 10:18:31 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 17:18:30 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
X-Gerrit-Change-Number: 1887
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1887?usp=email>
X-Gerrit-Commit: b97975c423764dd95f9a0b2968aeee773b4169c6
X-Gerrit-Comment-Date: Mon, 31 Aug 2026 17:18:30 +0000
In-Reply-To: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
References: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkk5ZWU0YjZkMWMyMWJlYzM4NzNkYzZhNDc0YmQ2NWQwNDNiNTM3MGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2c05cb9ce13fcf1590c79c5889ab21a55885237-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x15eY-0001lA-UX
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: pass
 correct NRPT domains size
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5161047273067847460=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5161047273067847460==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kS8J5doOQNg="; charset=UTF-8

--kS8J5doOQNg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1887?usp=3Demail )

Change subject: openvpnserv: pass correc=
t NRPT domains size
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1887?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Gerrit-Change-Num=
ber: 1887
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Comment-Date: Mon, 31 Aug 2026 17:18:30 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--kS8J5doOQNg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail">change 1887=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9ee4=
b6d1c21bec3873dc6a474bd65d043b5370c8 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1887 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12f=
k &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Aug=
 2026 17:18:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--kS8J5doOQNg=--


--===============5161047273067847460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5161047273067847460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5161047273067847460==--


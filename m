Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BA1C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FnimaWV/9p/rIiZ/ypZ3ikMVJGuBFSg3tZHA0BydGqM=; b=X9LzMGIoKMdJwNtRIoSar6tF7J
	c1FmGM8PYIbeGU8m+ptKd6sgnREBlUN7jlb4sLBFywOECYNPnKhdpvQ2frAInlILEH3XW3VjuiaPX
	GZR1m01rfuFmhN+EdxDuysguyROx0lXZBjHsEeaSG0sWViK6xOOKML5xQ8mbZaKeiLas=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjc74-000081-Oo;
	Tue, 14 Jul 2026 12:19:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjc73-00007t-8g
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=d9ABJry2QB9m7vIWao45nQWzBOswP0WMt7RIaOEoap4=; b=b7DLqqsaInNCHm2Lk1QtlVNv4D
 nFPVWfiyuszs/zjjOXLMJlm9+LFoyrKVqksChCavYyBiGIoZkCh1l6+ghhlBM8PRuglHu5dyGYLf5
 5OHqPi7nEBL9FpMvl+4mRPAWHtT9igPIQav9605dKN/q8QxKGUg1ZkasyMa1fC/R6ebI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d9ABJry2QB9m7vIWao45nQWzBOswP0WMt7RIaOEoap4=; b=G
 ebJ8voDECKSPmGcI3ZIcqUsTgprUGIiskolXWWiHycz45whUxq08J3IiQJzOiNXauy5teEdR1Zk/N
 tUdGZb6Z720+Ft70cLCdcZyo+Xkqmu/XNzOPKK5r2QUq3SVd8DNhTCU3BJJ6zWcUX0ctBDX4S218z
 j3z9E8HvtWNCxDwQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjc72-0008Fu-KT for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:19:49 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-474560436c3so699807f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784031577; x=1784636377; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d9ABJry2QB9m7vIWao45nQWzBOswP0WMt7RIaOEoap4=;
 b=ccUbepFLtI6kcI+hUyZGaeP0W9zDmr41e9zVE4SZh17MGRo31ucbrZSlj9NEYs3wNy
 9QqDQfXNTjvXdn5mmhVo7aObeHpzV4zj6AHtXQa4AnVlbT7TTD/dfrgPovnMRffMCXRN
 J9eOmImLiuoCkIKRdTsL1GMa1rfuPc5WHiI4U42isEcbjaSP2jf0/ZXu2UbFiLGToj1i
 xv8s/7IojBosURL8OqxBRV5p376VKIZS+Hf7QZwEBMVCYwK0204DKpwWGtG04smuCYMM
 82q5yBfUu9pzBPcCgFnxFqx03ylQdNuqKRMCyBwLRpC5DcMQI1+ACHjHycw+I31zJ1xg
 wTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031577; x=1784636377;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d9ABJry2QB9m7vIWao45nQWzBOswP0WMt7RIaOEoap4=;
 b=ia8vRnPDZPcFGtfUs/fULm1Gf0NCUo6EAvhmE0ckYTnOeFcUTo3QEUpyWoxenhrKTC
 0MUgyU3AUl7gzXgydMDChBRi5AvTMdPdd4rZGO5CQDyJDBa+aJIcq3pT0MRFY8r+riWp
 X8fkTTZhZXc4KmbMhYtptA50H22b8KknwBdtru3P4BPJGODrIpE44eiaeTqZMwuokGT+
 1alyiXf0oPDiB9qXxPx6dtQ62oRqlH44NMqah8sR6xDlv5PNigBi9qNLQL8EamTxtH25
 UAL8W/1BJb6BaR783kVJfZQt8upgbR9DXTvvTTIiNpXlPL9lqNKnhPtPlllHY9t2LVjY
 kr/w==
X-Gm-Message-State: AOJu0Yzm4otcitSLZyPcKDMEPGlto5ljdwR3Sxg0BnJuv89Y8sOEmz/2
 NWhSw5K4paBKaXOmOxIKAKufKUEtEnC8Jek0KtaR6jVhg1VzM46HJLgZZvFew/UWrYypaZ0tGfl
 /FM4QcI9oDyBYszJ6E8ubQyMQ1DSoHNVBcAF08PrvKN6wExbF3nBf8tdYA7cw7uUndhz10oq4DT
 2KRAyoCw==
X-Gm-Gg: AfdE7cn4snlXt1TFQkxE8jVp7+MwaZtZjYWGjS2qInkr0S45ANU2NUZdfW3hoA1h+w5
 4dCn5+/kOE44hIzYPG3aTKcpW/GwtSd+b2BphpMalgoMYu+IBwd+r8H1+Sqgj5Wu1I33oHynAs6
 0lTPWaYrHUwGiYVbCCFWZifcGNnKklX26YWbjajCIOwzEPTyaGtM8t2zHEDyn+KTRIZB5JgNa0e
 OzaXdR4MPC89ktIf7Ld3818yUavAxMYfqmxEjnPcbS3YZRTgjtCMKJzAo1BktcbCx7rKJsKCxhi
 qKf7uUD48jelnROHP0jkZC3fHLIcIxsh1V3zeyGWDneYd6B/0RjvgOvssucepmT8frlnv2hdUiI
 f9xJUtE3P3LviXU7FVuNldc7tXlkasgXjpu3+K+Fa3vrEz0qMSD0trf21JSfZB1TZ+7LyY7GYJ5
 9LZW3axCHHpavJH0PCQfZhUYakcWFeWze+Z+v74rt0MJ3ZdcCPbzSaM5jltB4Th9BVOmKYAiZ4q
 exUH9q6I847ub82GtTnc7Mak7WmZZC2Ec6kekvn4YnFxa9eg5iMMiz1TAatWVTWqyoiFKGfC8ok
 hCE=
X-Received: by 2002:a05:6000:2404:b0:47d:dfc6:b28b with SMTP id
 ffacd0b85a97d-47f2dcf8b7cmr14915136f8f.30.1784031576953; 
 Tue, 14 Jul 2026 05:19:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464caeffsm7394074f8f.36.2026.07.14.05.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:19:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:19:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 02696a6a2bd8999aa0d98b52d9eeaa314fc4843d
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 12:19:35 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f51923b831f0debff120e315f76f83af2e4f68e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjc72-0008Fu-KT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
Content-Type: multipart/mixed; boundary="===============0283108645800141818=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0283108645800141818==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="40WGV4p8ZEg="; charset=UTF-8

--40WGV4p8ZEg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_re=
al_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/810b6890_206acdf5?usp=3Demail :=

PS2, Line 298:         const uint64_t hv =3D hash_value(hash, &real);
> Be=
cause the one in handle_connection_attempt will be removed/replaced by the =
per SID hash lookup wit [=E2=80=A6]
Acknowledged



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Ger=
rit-Change-Number: 1725
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue=
, 14 Jul 2026 12:19:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
=
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Repl=
y-To: flichtenheld <frank@lichtenheld=2Ecom>

--40WGV4p8ZEg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/comme=
nt/810b6890_206acdf5?usp=3Demail">Patch Set #2, Line 298:</a> <code style=
=3D"font-family:monospace,monospace">        const uint64_t hv =3D hash_val=
ue(hash, &amp;real);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">Because the one in handle_connec=
tion_attempt will be removed/replaced by the per SID hash lookup wit [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">=
change 1725</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1725 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
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
"> Gerrit-Comment-Date: Tue, 14 Jul 2026 12:19:35 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>

</body></html>
--40WGV4p8ZEg=--


--===============0283108645800141818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0283108645800141818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0283108645800141818==--


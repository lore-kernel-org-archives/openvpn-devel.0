Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51378C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwFFB2lHy5GbNGGbwJDHBfZJCNHtaRPMsfS0QRLKK8s=; b=iErqBRSoVF/ajtG4BEarQXKnsy
	yb5F8M+xz7FotrkueytQShAFDE9b+sr3cyLv2/KKoGgk2wDBBwfkuFhjnAIESI6XtJIOAT3aJANdM
	9LkdmzhLB7k+FO1sDrJtnfSdt4ASfOBeDwe48O2S97ilziASe8tMbLM+izB64fmkq0zU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wocXe-0000zW-2X;
	Tue, 28 Jul 2026 07:47:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wocXc-0000zO-H7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 07:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G+3SSEmSajiKGMWhCcqe71sZAPhCM8UNLLRJA+3Jo3s=; b=TdyFAFkf7cNouStJqidKn4khcj
 gZeSvsOwDxFOYcx6/aOTUpEL+EODFLIGX0LN9Ucuzi4auYbb7Xm85Erv+FEye8Pj4NZMBPjuQBtt/
 IdZVNupwsFj9poZ9Ala5kAZyxorp2neGtv2sWIeoYlPLpeYRuh2mHdLDmV4XH45Klotc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G+3SSEmSajiKGMWhCcqe71sZAPhCM8UNLLRJA+3Jo3s=; b=H
 4xfBJeT0sIEdIDTUre64iyU3gfdlOdPp0QHGSBj0ckpXSzlo4InnI9OMd4GCi7/eTnLpzcPOTfyzX
 7ReW7lEHXr2d1K/Y3sErogny2S4tkHRY4RQccIIrRPV7nHQeCBd4YZq4oI+2eoGxqZRJ66QBzMO4k
 PDH88eT/BFdSli+c=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wocXf-0002wr-0j for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 07:47:57 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so38138515e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785224869; x=1785829669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G+3SSEmSajiKGMWhCcqe71sZAPhCM8UNLLRJA+3Jo3s=;
 b=gDmfiVJaRmWceZpTndJfruF3wDitg7RmqR+B1Z2GBNfnF0f6KgLtKIpikbcueHVG0J
 zHFplvuCYx0AHeFtQPGhnoonyMIhMA2yafrdv4I5WR4oJV6YgQmouzPAuS4xz40hlr7G
 eJ12ewju9Je2ri5S6Znd/5BMpqQaEokZX/dNpsePHpIBuffN9ldTTMv2aGBrT2WZq0jZ
 ol2dhkVUfKjGdBMwMkmbjgN3DHbPaRGadL7gI3yX7nPuceAT5p+RnN3Ci8QAtEW617Vc
 ijUoToTxc8VXTdb7ZaLOLCGS+qPYpzNw78Rs2RkcflxB8HtY1SlpX1NEJ5yX3l5JvRF3
 Z0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224869; x=1785829669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G+3SSEmSajiKGMWhCcqe71sZAPhCM8UNLLRJA+3Jo3s=;
 b=EnblHmlkAuFUufaf5ZMHCcEDEQ0xBZUMt17ng3j+VwWtRtWGsmLoMqylG4NIqBAm8J
 N9Xsk8vrNCDvWIot4oLoix4eD1UX2hoYvO1hTwIb3z6EMWZJIIKCkXhplRMHTXumU+iU
 A4VDVLmdY15AS89RqPz2z+dgEt5HY7BKxTEmcDFI/9E3bNtbToSfpBKFsr1w7xGlW2Wl
 5PnuFZe7n6YzxXOwp4FxQBMRClFeSPMjrtrvFRHytaZ+7hw5HxDlhst8JnAYpXt0WGR/
 L8pBxgobQlv0p7pZrzRWli4VjVW4ZvbllyW80ugjz3GICGfMVtyvZzcT/H8cB193HX0t
 g80A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRW7pPPm2AuTxBj0cF2z4ooF1249+PiOriH1N+r6yIauP6FKNjgLq9/9FQa9KdzFtQgRgn6mTrFzpMpPT8@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyukNRcWr0nPwI9SRDNLnbp30mgI5+V4ct9gpOV2vsiu0otaaPk
 6vLm0euO25kY5DYJG1c2R6CXkE6SXMoilRvp6ikF0rn3s+hZufqEaPbxdLHiC8LA9lSv4KFdmpv
 K+aq/sophdyQjnam5UA19jfZ5ez4p1A4o67nZ2B6N6jPqy2NZ5qn2Wu2DhDmkj+UlkQkG
X-Gm-Gg: AR+sD13Y5kmHW1L0gqnKK/acCIzG2dK0h03j/cSDpMb2lROiRppcdPqitgXYHPAbVxD
 hm5S9aOLVXFQwSNgoRmtpuTRnzcdE05DQwJ88bH/Pxz2B/NmKaXjvPyRyYQJrnoyk43EuGU0DBb
 X/QvXE4t7HaesSvIkJ8MOZpiEdK+FZj7HfiPIs6XSSCLIDTNMN638WE96xTBbHJRKv1cwl2N9Ce
 PrC8t3NcUxz92sKsEMYZRibKzW2Uad5YEvrm8aA3SCGfoMSrcCn5ToWepKQyWxQpGCCUgg7LW8e
 9EVdDMczafZRFewYww4urhmRpXhW000X1WbljWdlAhF49b+m6xAB8k6foixvV67Okq5s7yemtdR
 aRj+AWENhnzDTAlgCgPEd/i8agHg9mUIX18xarPR2b5YJr5nM2CDNkt31cKnTvgyX6jg/C5Q29N
 9snzFU8Rbs4o2k5SJ6EfMkyB1iJMH+BO+dSd0hNTFynW6fdez8fXHyeNlmdsbygqjSQq2dXcgNn
 122SL/p8/2gAwGEYdyY+0N2pHrRVBAJZMnDivkHQrF9f29dMgFGVzQHXA7UN5CsQDuT
X-Received: by 2002:a05:600c:1f95:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-496c64261d4mr12044855e9.3.1785224868716; 
 Tue, 28 Jul 2026 00:47:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b1c2asm58087005e9.5.2026.07.28.00.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:47:47 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 07:47:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 166bad41b6b290bffc81db9e747967d58833ea1e
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 07:47:45 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65a67d1e53220bb4c32b68e015c417fc69497cda-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wocXf-0002wr-0j
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2892062153366020787=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2892062153366020787==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EuvH+viTncc="; charset=UTF-8

--EuvH+viTncc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
=2E

its_Giaan has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 29:

(7 comments)

File src/openvpn/init=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/bdf8cbc3_8728=
920f?usp=3Demail :
PS28, Line 2210:     if (o->use_peer_id)
> I think we sh=
ould not use o->use_peer_id but rather check tls_multi->use_peer_id instead=
=2E  [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comm=
ent/ba692d43_01149e69?usp=3Demail :
PS28, Line 2686:         }
> I think he=
re you just want to use [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1089/comment/2d9fdbb0_4880cd5f?usp=3Demail :
PS28, Line 3483:    =
     if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
> should that not =
check `tx_peer_id`?  We control "what we send" with `use_peer_id`, and that=
 would be [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089=
/comment/da50ae29_57842b0a?usp=3Demail :
PS28, Line 3485:             c->op=
tions=2Euse_peer_id =3D true;
> I think we can just remove this whole secti=
on=2E See my comment to tls_print_deferred_options_results=2E
Done


File s=
rc/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment=
/233abad1_02fe649c?usp=3Demail :
PS28, Line 2082:     }
> this is still ugl=
y=2E [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comm=
ent/8cf8bc76_6d00696d?usp=3Demail :
PS28, Line 2340:                 multi-=
>tx_peer_id =3D multi->rx_peer_id;
> that comment is confusing=2E [=E2=80=
=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/a87d852e=
_76e6e317?usp=3Demail :
PS28, Line 2352:         }
> Looks like a repeat of=
 the previous code block=2E=2E=2E [=E2=80=A6]
Done



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
G=
errit-Change-Number: 1089
Gerrit-PatchSet: 29
Gerrit-Owner: its_Giaan <gian=
marco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Da=
te: Tue, 28 Jul 2026 07:47:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-=
In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--EuvH+viTncc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos=2E </p>
<p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Cha=
nge</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/bdf8cbc3_8728920f?usp=3Demail">Patch Set #2=
8, Line 2210:</a> <code style=3D"font-family:monospace,monospace">    if (o=
-&gt;use_peer_id)</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">I think we should not use o-&gt;use=
_peer_id but rather check tls_multi-&gt;use_peer_id instead=2E  [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1089/comment/ba692d43_01149e69?usp=3Demail">Patch Set #28, Lin=
e 2686:</a> <code style=3D"font-family:monospace,monospace">        }</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">I think here you just want to use [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1089/comment/2d9fdbb0_4880cd5f?usp=3Demail">Patch Set #28, Line 3483:</a> <=
code style=3D"font-family:monospace,monospace">        if (c-&gt;c2=2Etls_m=
ulti-&gt;rx_peer_id !=3D MAX_PEER_ID)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">should that not=
 check `tx_peer_id`?  We control &quot;what we send&quot; with `use_peer_id=
`, and that would be [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/da50ae29_57842=
b0a?usp=3Demail">Patch Set #28, Line 3485:</a> <code style=3D"font-family:m=
onospace,monospace">            c-&gt;options=2Euse_peer_id =3D true;</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">I think we can just remove this whole section=2E See my co=
mment to tls_print_deferred_options_results=2E</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/233abad1_02fe649c?usp=3Demail"=
>Patch Set #28, Line 2082:</a> <code style=3D"font-family:monospace,monospa=
ce">    }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">this is still ugly=2E [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089/comment/8cf8bc76_6d00696d?usp=3Demail">Patch Set #28, Line 2340:</a=
> <code style=3D"font-family:monospace,monospace">                multi-&gt=
;tx_peer_id =3D multi-&gt;rx_peer_id;</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">that comment is=
 confusing=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/a87d852e_76e6e317?usp=3D=
email">Patch Set #28, Line 2352:</a> <code style=3D"font-family:monospace,m=
onospace">        }</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Looks like a repeat of the previo=
us code block=2E=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 29 </div>
<div style=3D"display:none"> Ger=
rit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 28 Jul 2026 07:47:45 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--EuvH+viTncc=--


--===============2892062153366020787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2892062153366020787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2892062153366020787==--


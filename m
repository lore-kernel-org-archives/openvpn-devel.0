Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11592C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BBS5VpZjbOdfKc12GLda3A8qb370B3mD/6acGFTaEc=; b=QxPeE8ulXzwWpBz2QDZoKuYseU
	rcc7jd3Nyuratjdd9EhjCB3cGfrzHu9XkRTDw6QhB3wJoHoRCNB4W+G6P8Zmdj/ARBltsrsO9UIPC
	cGnOPJgPk+nGKGc3lOTbh/kHB9EAN4l9FVtSrwmHX8z+fO230QQ/PmBv0wAvw6bgdD4g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we0yC-0005yX-RH;
	Mon, 29 Jun 2026 01:39:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we0yB-0005yR-Vx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 01:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=V5Bh81ijuO2XIGzOxSLpIJDXc8SQVeGfcGuv08pF1Kg=; b=A/UzOtX7BKuxQ1NLk+fcGQ/3T+
 IVOyAhgFce7LlMj/fSnkgSpd9/8hBW3L5OZfoGe1u/I5trCp9HMR91vEm1o4H+ukOwbVWc07vppGQ
 JcViViLvdJpmXSMS5HuFuHd/Vul27JPSMTtU7YfHXCBZrR0riVVdhIA+YQc2tuu6FZGE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V5Bh81ijuO2XIGzOxSLpIJDXc8SQVeGfcGuv08pF1Kg=; b=k
 X4MEiYAgQgOYFcl5Grw2GWMEn8SATGAIrUNbtMgp7pGJiW8bzxWv2H4lM9KvQ+6mK/C4gNE5hBQhk
 IkT5DPxxqGvFHtW1SsNodf8sO0BLLWwKO4p03yYkKrIAnIyvQi34QUZTvuxtWenyUA9kd6eN3528X
 OGh3toTq9X3jBA60=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we0yB-0006b0-Fy for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 01:39:32 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4704d652e9cso879803f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782697160; x=1783301960; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5Bh81ijuO2XIGzOxSLpIJDXc8SQVeGfcGuv08pF1Kg=;
 b=e4rJlfo/oD1/1VJKpt01jx0+CRiBrXMoxNnoMGknBQSakKQ6ebFYF/TYxaoIrn3nZr
 Gv/2VzX+jFWjxDC9wC6QUgu0+RvXmaz/mzC8VAY1aYdW16z042m1qswasZbrrwROJdXX
 BBpc2UdbicmgAjlBqcJUejILMZ9qp/QoOSmHwEcwQPmFQHCXf4mKZezw/+aF9t2zNO+E
 N/E+tDIs1EL/6dCs0nm93pGes8LYzUZE38nA+7hcClk2garspbgHNi7E5vx8A7WsxWEi
 Hhha6Rd7sntnmagpFOVehJFFJn+shspXxIiTdiM09NZIo/XNdmoTeD4F0kp51iMAA9mR
 CZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782697160; x=1783301960;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5Bh81ijuO2XIGzOxSLpIJDXc8SQVeGfcGuv08pF1Kg=;
 b=D0wnu1uDiZusYGui0+0i+MS8mTh/XFMc8kUXUuCXiYmQLZZVnRA63CiCl/TsA7dm4y
 LvPLP7RAvBbbZJn2PVTyXQ+NBHbsWq06F94C0drel1ZLfrrq2MUNtKeDwcO/RX25Qyv4
 pruay39uJwMICNAxFD+W9S+WIaEmCjN7EjzMlXbjW1UREz1RG1Ypn4d00dqI3sAsUd8A
 eBgnf1qwqPuMg9vPWx05lHwfgqPDQipu1M8LhPLliy75kNsmFgQDbL0rfo9k0+l9GUMe
 fMKGw9lwv3HmjOACTvw9ItiKCcfFOSa8TpxQGEj5R0NGzelpV9dmjZPeQYxpArPVxBHM
 VEpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUxsxdqB66UnqvrAFeWTRyKR0Q0K4Eq2q8J8s/fYpQypQ0nAgr3ZlNju0GHrfrNsaRNh9/mSeqKLfqUSQy@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzFsaVebU/RjX/J2f+btN0GZw807Vl8+OMtJUs/2SfgI9+Z/RPB
 /8XpsBWgzm1wLlyyLzxd5jfMkDTo9eJFz5nvbSEQwICVqsW6Nm6MlZhA9kpcMIZeAx7NeVzdlIW
 J8atiL5xnjYIOgOYFvufeIG1MQinBfUv/lw9tV5udOuszMUp7p70A+7Y45ZaQkXFW36EvbEyKXC
 icKOK5ug==
X-Gm-Gg: AfdE7cnmRSpT0Dqbx0oiavNaavqArt3Ficf9kZMVDrFJg5gcP/kGcZ74D5uUFIHeWtl
 Ibu0+EdYx/ANnxhgi49y6so155esbOmtE9rjIgZ+5Rw62HMUKSyOoFQxRrEtdw6ZSipg73B6YGg
 WP2rckOBIZf4jZdWh4FsgDtRiV1X93yJ0Dku6JNebWPCJ8zJeEkGvq4ZdMFTkFpvuhVN0WsQk7V
 xghX8j6YN7TYuo9jNHa8n2fCrkqPRz8jOqCRI6V2I6Gu0FrrttxzgHe6sYatlopqLqhstLzaxQv
 9QRgn0zNtpS8Wi/lRAleSMT0gky2Z2Su+moIRtA1Ehzwq6mZ8hl9cO/0M0UroI8LAAblF3B2/UT
 MKg47GnmdSOPAMJi4AiQemQxdpEFgx/4xoftEWuv8UVZgrCk5qhwEokeJd6ttrwwbnxCdB4bEUN
 6JHkxdfPHBN/15XeN5TaJFyjRLDgDdwdr03yU4sqm6aGKoDFQ8Z6sSuhFHbgY95ASHxlCzgayf1
 kbNSCMHqv3znFCiIJ67J04tQ7n4LqYlCDGF4uC+6pnjwPrseL5k6xA0oQGAYTniH4NCOWjRCI6f
 RPBhQNm7mz+ykQ==
X-Received: by 2002:a05:6000:260c:b0:473:d65d:49c1 with SMTP id
 ffacd0b85a97d-473d65d4d48mr1976188f8f.32.1782697160288; 
 Sun, 28 Jun 2026 18:39:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-472c7bec9c2sm10614491f8f.12.2026.06.28.18.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 18:39:19 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 01:39:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 02829edd0828bd5af8934ffba182588901a03440
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 01:39:17 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec856b3d6909214b9b6093da7e2a32bf62933bec-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we0yB-0006b0-Fy
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
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3017799959436762104=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3017799959436762104==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h/uz2P9Qe2Q="; charset=UTF-8

--h/uz2P9Qe2Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 16:

(4 comments)

File src/openvpn/multi=2Ec:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/8d816606_628dd24e?usp=3De=
mail :
PS16, Line 1729: 
> spurious change
Done


File src/openvpn/options=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/58dea1af_17b2=
1c2d?usp=3Demail :
PS16, Line 3890: 
> spurious change
Done


File src/open=
vpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/b9c300=
b5_e281c165?usp=3Demail :
PS16, Line 2347:         free(multi->peer_info);
=
> useless free, we know it is NULL
Done


http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1089/comment/1b54d5fd_1af13e14?usp=3Demail :
PS16, Line 2348:     =
    multi->peer_info =3D read_string_alloc(buf);
> This needs a comment=2E =
[=E2=80=A6]
If I remember correctly we needed this because the server were =
supposed to send an empty string via peer_info (as you can see from the pre=
vious code, when peer_info_details are < 1 we just print an empty string to=
 the buffer) but, we the latest changes we made this else block is no more =
required so I reworked this part a bit=2E



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Cha=
nge-Number: 1089
Gerrit-PatchSet: 16
Gerrit-Owner: its_Giaan <gianmarco@man=
delbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date=
: Mon, 29 Jun 2026 01:39:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--h/uz2P9Qe2Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><p>=
4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1089/comment/8d816606_628dd24e?usp=3Demail">Patch Set #16, Line 1729:=
</a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>spurious change</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1089/comment/58dea1af_17b21c2d?usp=3Demail">Patch Set #16, Line 3890:=
</a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>spurious change</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089/comment/b9c300b5_e281c165?usp=3Demail">Patch Set #16, Line 2347:</a=
> <code style=3D"font-family:monospace,monospace">        free(multi-&gt;pe=
er_info);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">useless free, we know it is NULL</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089/comment/1b54d5fd_1af13e14?usp=3Demail">Patch Set #16, Line 2348:</a=
> <code style=3D"font-family:monospace,monospace">        multi-&gt;peer_in=
fo =3D read_string_alloc(buf);</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This needs a comment=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">If I remember correctly we needed this bec=
ause the server were supposed to send an empty string via peer_info (as you=
 can see from the previous code, when peer_info_details are &lt; 1 we just =
print an empty string to the buffer) but, we the latest changes we made thi=
s else block is no more required so I reworked this part a bit=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639=
bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Mon, 29 Jun 2026 01:39:17 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>

</body></html>
--h/uz2P9Qe2Q=--


--===============3017799959436762104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3017799959436762104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3017799959436762104==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88068C5DF7E
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/usGctc+HCs5ddaqx9Jm41LEtvflX1o1VSe8jNzMCA=; b=dRUzpDjXeuCHohDU/0bYWWg4Yd
	S4GwwMFJENgHNx/i+OcVn8x66lRDERpHKajuK2oFL2HlUI/zbkgD3XLDIZjuPYsGF0078lCbVu0Dy
	MGzegBKV1nGvY4AcZ5ciOsCllg1DCsI0mUk0MM9eGp2o58EaYYr4iPyAmwOCZNQydur4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwHos-0002s9-Um;
	Tue, 18 Aug 2026 11:17:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwHoj-0002rx-6F
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 11:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4Aol4357tPQqoXOF5/LLmuSTDylW4NjSgDLaTJuOUcM=; b=kGla3Ii2G0/teAhCAxLeNRkbJg
 1DWjsyi8QSD4L2fWBZlykX9qeC7D9ibCZ7HfcOAcwTBTMP4XWwfAL3pdCktCJRjwk536tF1d0oUMG
 OdjdXliXXN0n0HFcV27yMeNbGZ5XlBftNnKL8Oz2VIE/mmVj4/IF8YFOMNrGAcs6jXXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4Aol4357tPQqoXOF5/LLmuSTDylW4NjSgDLaTJuOUcM=; b=N
 Ro1yi3oqL1pyifJuryDWiJakP5377OHG03WOaumYj6GVAuQ7UTYKG3jKWJGm6RddegGhE60w8nJY/
 Rh9+KiwfFrBudHFF9WBIAb60dCDTEWUWA54F62TlSjcyRjBOB4JfZcizcS3XAYUlvifKj4W6T2k4q
 e71hGV4fcIowjXCg=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwHoi-0000mz-6L for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 11:17:14 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so2440647f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787051826; x=1787656626; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Aol4357tPQqoXOF5/LLmuSTDylW4NjSgDLaTJuOUcM=;
 b=hEIJWpPm18iZeEQOxIvVAi5WAwNRTo441z0udJz4nwKEXQ+18xVZSofYc+ZQRKOhE6
 hTNGaBLh93gvnney8zsS5Zr4+FzgtfcuN9qDhlW0a7lItBATDw88ddyF8LyW5OPGnT7P
 9FvDZHKSLqSd1e0LWme+le0+w+dr6yDZBOOChO20t+UsOdKAa48E/i5Cn64V19GTn9JN
 4jSv42YL+zvG/MFu3N7dIccQ/ArzJUS16cYGkm2B98H1XupKbPFAFeMYgmHYrCf90m8Y
 5OVOGfhLgfj0jcgrJb4eqwYFvgb+cmw+74JVMnMT2andLRQwSx+yre38w7KGiL83HVYR
 R71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787051826; x=1787656626;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Aol4357tPQqoXOF5/LLmuSTDylW4NjSgDLaTJuOUcM=;
 b=RgSee5aygL7eevPFaVa5nrdyRejM4MkG1mYkezwXBs6vVMYGOt9A0eIbU772/nqbGA
 WpkNuWpeLI7fheKPSPBsaKszX54SoEI3+EULz25G/t5D3Lwprhc5uyFm9+90FB/g0x6S
 Cu8tNwCOnFjC6O0KZRfDqED4nII0W/AcKAz6P++7itMVjvmQQRGxvr4tTSEBgdRIEsGG
 6s4tBkeziMjgNNFDI4R8GcqEz78xYOOmVrPnJMqmlddhlBN/4Nsu11LLGEl3AwvvEkpQ
 fewm/IcYIne1vHdQL3hg44sCpWwQU+hd8rEKLORlOX9OnQlgDyE0+tJXNvqNAK7aGpsc
 mPOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RquhJMFUPUyMFkvYZNCnoufcpUmJyMZwR1fzpD3Ylnn31TdrmqFJurIIhFtmUjnme7NKPxAoO5lUbqmi/JR@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz0PnciBkWmHBB8XVDxulJb7+zI6KOyqEUJSFUP0JrEiIObzSSJ
 SnFh+fuWdFzZLiAkhJekNi2tFR2lbePnn9vVYx2b6aG+jn9aj5XIGA9eKCkRLAwEcjEa4FDv2yF
 F7lnviHzOw8h356jFNRFqCJYrNn3ynvM7c/PQgauD90QqPQ9ZTYbndAhfQ5vXO6UEM81t
X-Gm-Gg: AR+sD118KiLJNGxyrt1UJ7BIqsw9DTUhDq+pwjDg2x+sBQ5nphY+2vl18eJgbCe7Gmu
 6xIfKAu8egOGHlUYZ99e+QoD6Y/D/vGK1fu54yLfN8LQrC45zEUAh0q2iI9mvI8XB+W1u6W4/eB
 mVSJmrGdoc6lDQzLxeKfLzGPbJAbRW2CBdjzjz2ewoED2eqHvTLrNFgwPgTAi1at6iOKH3c82Ys
 oAY9J18PxEp+UAHsfsYpQUy/eEWZpYbE660K9vYQ8iTHgarH3S9BIp/kVQjMHJ0fkd++BkmEK/c
 9ugyYccWhNWjc/2kdnfUAcIi2tCi9IlNwDRKkPAszoqgMkHp/SIsdfBB+wvFFJ5d0a6MCkTZ258
 U2KhCbJMOwp8CjWlfSKlISnx8EP09esbFpDecIYqVC38mct+lxdsySP+7c21M25IDXaiSIzIX/j
 vOkglmmNlIKLsa+SMCaXLiP9COPi6HgNMyKCClF7wIa+vpZlYKr3WwoMmSeunrUTcNsVOuFtEsZ
 7qmYQa37NqqS3bG2ry7Au2AySoa0z8RyRI9uZcQnh1m9S9pc6MFUuY8xLjZlobO5tU9770VfuRc
 SJqmGoSVeL3WAhea4BV9BAJYXRMgarKZh7eQO94R4dWXdbamyO6G
X-Received: by 2002:a05:6000:40c5:b0:482:aa0b:db55 with SMTP id
 ffacd0b85a97d-482aa0bdc7cmr10852895f8f.16.1787051825881; 
 Tue, 18 Aug 2026 04:17:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b43dsm10985480f8f.12.2026.08.18.04.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:17:04 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 11:17:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9
X-Gerrit-Change-Number: 1586
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1586?usp=email>
X-Gerrit-Commit: 103f2bd05530c0ed4e3670018c3dbe4a6dc02d59
X-Gerrit-Comment-Date: Tue, 18 Aug 2026 11:17:03 +0000
In-Reply-To: <gerrit.1774440822000.Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9@gerrit.openvpn.net>
References: <gerrit.1774440822000.Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDQwODIyMDAwLkliYWY4NGNiYTAxMjQzMjBmN2M0OWUyOGQxYjMzNjRkYWM5ZThiNmQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5eff0fc5fb2436b34dd52e43d65f3a53618c6875-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwHoi-0000mz-6L
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_networking:
 Allow to test --netns
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7751747232760329067=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7751747232760329067==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BBT/9a+f5tE="; charset=UTF-8

--BBT/9a+f5tE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


razvanc has posted comments on this change by flichtenheld=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail )

Change subject: test_n=
etworking: Allow to test --netns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3:

(5 comments)

File tests/t_net=2Esh:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586/comment/96fc37e2_1e4267d8?usp=
=3Demail :
PS3, Line 30:     $RUN_SUDO $IP_EXEC ip link set dev $IFACE stat=
e up
`$IP_EXEC` is already defined as calling `$RUN_SUDO`, so the `$RUN_SUD=
O` on these 3 line now appears to be superfluous=2E


http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1586/comment/2c48207f_99e26859?usp=3Demail :
PS3, Line=
 32:     if [ $? -ne 0 ]; then
Doesn't `set -e` exit before this can even b=
e reached?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586/comment/072ad77=
b_f1c9c60c?usp=3Demail :
PS3, Line 33:         echo "can't create interface=
 $IFACE $IP_NETNS"
I can't find `IP_NETNS` as defined anywhere=2E


File te=
sts/unit_tests/openvpn/test_networking=2Ec:

http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1586/comment/6a9933b2_a59067f2?usp=3Demail :
PS3, Line 216:    =
 printf("Usage: %s <0-8>\n", name);
Should `usage()` be changed as well now=
?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586/comment/d2ab3f93_912c229=
7?usp=3Demail :
PS3, Line 246:         ctx->gc =3D gc_new();
Maybe acceptab=
le because this is just a test, but we never check that `ctx` it not `NULL`=
=2E

There's also no corresponding `free()` for it=2E



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ibaf84cba0124320f7c49e28d1b3364dac9e8b6d=
9
Gerrit-Change-Number: 1586
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: its_Giaan <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Atte=
ntion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 18 =
Aug 2026 11:17:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--BBT/9a+f5tE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail">View Change=
</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File tests/t_net=2Esh:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1586/comment/96fc37e2_1e4267d8?usp=3Demail">Patch Set #3, Line =
30:</a> <code style=3D"font-family:monospace,monospace">    $RUN_SUDO $IP_E=
XEC ip link set dev $IFACE state up</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">`$IP_EXEC` is already define=
d as calling `$RUN_SUDO`, so the `$RUN_SUDO` on these 3 line now appears to=
 be superfluous=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1586/comment/2c48207f_99e26859?usp=3Demail">Patch Set #3, Line 32:=
</a> <code style=3D"font-family:monospace,monospace">    if [ $? -ne 0 ]; t=
hen</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Doesn&#39;t `set -e` exit before this can even be reached?</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586/commen=
t/072ad77b_f1c9c60c?usp=3Demail">Patch Set #3, Line 33:</a> <code style=3D"=
font-family:monospace,monospace">        echo &quot;can&#39;t create interf=
ace $IFACE $IP_NETNS&quot;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">I can&#39;t find `IP_NETNS` as define=
d anywhere=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e tests/unit_tests/openvpn/test_networking=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1586/comment/6a9933b2_a59067f2?usp=3Demail">Patch Set #3, Line 216:</a> =
<code style=3D"font-family:monospace,monospace">    printf(&quot;Usage: %s =
&lt;0-8&gt;\n&quot;, name);</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Should `usage()` be changed as well =
now?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586/=
comment/d2ab3f93_912c2297?usp=3Demail">Patch Set #3, Line 246:</a> <code st=
yle=3D"font-family:monospace,monospace">        ctx-&gt;gc =3D gc_new();</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Maybe acceptable because this is just a test, but we never check t=
hat `ctx` it not `NULL`=2E</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">There&#39;s also no corresponding `free()` f=
or it=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail">change 1586</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1586?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibaf84cba0124320f7c49e=
28d1b3364dac9e8b6d9 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1586 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;=
gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 18 Aug 2026 11:17:03 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>

</body></html>
--BBT/9a+f5tE=--


--===============7751747232760329067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7751747232760329067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7751747232760329067==--


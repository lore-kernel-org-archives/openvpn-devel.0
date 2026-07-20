Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632BDC44520
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vhnCNLallJIOrTV0/pE9I518zYM9Ch5V5CBhiDEyXUw=; b=kxaTdU5zOVUHQnURjmjB0RWlzW
	BbzE0IE8O9TzkxSyHDKrjYLK7JdekJ159N2cr22sCB25NCSL4stsM0dmGneKev2cSVFqYvFsycTJZ
	nGYMfD4k5K9KR369K29/lLoVVpgTDNVAwfbTq6UxwowV4818xFoGY02xPUc537aHZk74=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlmnp-0005vE-Nw;
	Mon, 20 Jul 2026 12:08:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlmno-0005v5-HB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 12:08:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qy/yw2vO8bDS9vnMr933+342BWYAaENLw5jdYETA9MU=; b=FxVt5EUQOCp9/yWUXQJMKGSSm/
 0VxbNMv3mBq+oJRm0SXc8K2LUiN8TMCODplECfZ/iRdG7JA2e3C18C3J/3RuOiwz91msdzxrK9s84
 vFqjKLPlP+pTmLUJbe5vSMMEAhIlnaSjysFn1r8esUqmyxbmP7Qi1Y5uG8s7z2T7W2mM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qy/yw2vO8bDS9vnMr933+342BWYAaENLw5jdYETA9MU=; b=J
 u3iSUjJQor3G7ewADbUORNKXhxW0PC+b0VFozHvd0fL5ykxcw2x8tAEeDoTF9jhmugjnP3AuotXPz
 fn6+lsDzHTM7xMif1stQB3t2ZkbdjumWwVQDhQ6HM+0iWg3uZDycS7ebQ5kv1uumbKrXnqFazyuRl
 F/0l1AZGA61ZepLs=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlmnf-0007WZ-9P for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 12:08:48 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so107091866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784549316; x=1785154116; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qy/yw2vO8bDS9vnMr933+342BWYAaENLw5jdYETA9MU=;
 b=GK8h9V1NLxSRK3yg4k0EZy5Y+eJclu/O7yQA72/mFv1w2x3SraayCzAChRASMIXrEA
 hw+l9jUb7ZZdqYAP/6vxtrl87EQHEp3IoChmUxisEXiT3SMZmKPgr38Gx/GWiAQnOaEQ
 GJr5q4wIIKPS/TFa+Tw0COUcONqsHIbgjg62yeiuMcIN9DAw8LImdUv8AavMas41+uKL
 YbZQG0moZPVxSvuGet9hbUJ7qyJ/gtKYasNE3YNBAf2oHhsDyx7a76hAeC8nXWx46EsK
 OS5Y737seCUMFN9hsnTCJHwzqvrQQ1rW+hFL7WLgUJtdTp8hPwIw5QsazaeECjOXBL1W
 v/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549316; x=1785154116;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qy/yw2vO8bDS9vnMr933+342BWYAaENLw5jdYETA9MU=;
 b=CUWaxtRmDDcqA+I6jrmXVRUGL0yqfrJJkVkwuYr23+G39g5lkPz30Iur/dSA6BBEbE
 s1OyQOWOcr6X6jFp9BikUIYnpssN+wLytK99lELmcsfAnT1NBIpaD5wTWshZwqYsrxpc
 +0sYbb5/3zjl2JRHv04SZorrUF1EVm7jctHVcWuSeGn0046ZVc5/Jvxolmxd5ZZjyxZg
 oa2KY3zMq4LRc3dKE6eU3IvH1HrPZXqywo+M7Z/FtPdskz4dHsxrRBZCyZjYjfGxXbRT
 +3nDsNNip7Z/+JquKrs3kp5KoVk7DiHz5V5JgC+h5N1e0fky88+a3m60gI2s+ddRoesG
 uWGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrm/IT/tX8vseZO8q4UFbrP55C6FhsbKiOCnGH9x9cIEErt+5BkTqV9Rhcqas/cmqluJLNdwQ5Aa7cnHJ+k@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyRH899zLDWfeS4igdkZQYGxgSuRcMrWa6aW9fytcbrHhBoXgYp
 mSJv4A/djuoDyHK5kzDb2CJU1aPQAS86YtzJWs8GVVy3J7UqNKoYv6zbAtmqVdRU4LqYz9fa9YB
 LQTtNEmI3DJj0hQfI3FSYBv/FQW4tZHoeVA1iGGFoJOIM4DUrBFQiKgbv7Amapndal16YDMK7hS
 /vnn93cw==
X-Gm-Gg: AfdE7ckFsQltsdOVzfGzdHJQxLHhtERRhwIn+rf5wDsTxgtIeEZN2O+vEeULfSfNzDU
 LE2m3+qQaeDMCurnOK7Ocr4sxfei14sfjV/sfMVMneEbc1QjggnOV3S4FalmTfNTyL56tSNWm4W
 EMwWrZYj4CWp1WUmCJIplXAnBhg2Zy5rHM2FemR/vrz1XN9xlW/bcWOpMlPmj1P31rHlkuhbwUf
 sEWf2LsK6b2Vv+X0A7adV3Q1/RqnFJnImeV06zgP92cISbWFoNi9zCZL5af9oSNm1UFaoa/vmmP
 gIbLqqxBSa9KTM6FvZ/K+M0ZrM/y8nl1RBrogk9vbHvIryY6yVJVrCZwiTy0g1Ib/eee0WN9Mye
 aCn6e3x0QJYYATVq4ls+zCTzxHWgQ/x/7tI5UAjNGZa2x7dRf8+53y2In95xMWUseH49ExQrm5q
 OVxLkUn3++hsQulc3HKoGBSl1XBgxTwOyWkVGk7unoPEl6rJD8YUlU3UCVQa9plZ3MX3gLcjtTh
 X5xNKbrwMAXBXhogfrhNuA3yfSItJ2AA3EYkNH1QNxByYdFgVKR8gKmL/xZHrYFze8u
X-Received: by 2002:a05:6000:4615:b0:473:1ccc:15bf with SMTP id
 ffacd0b85a97d-47f62334c16mr16279108f8f.42.1784548869203; 
 Mon, 20 Jul 2026 05:01:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eea8afsm30833402f8f.33.2026.07.20.05.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:01:08 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 12:01:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 5738669616b166a39c7b91d031672c8e7fabb5c8
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 12:01:06 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <57c436a594a87308c46dd5389b607fb82a2ccf7f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlmnf-0007WZ-9P
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
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
Content-Type: multipart/mixed; boundary="===============7693063785508200822=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7693063785508200822==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ILGkdov+MGA="; charset=UTF-8

--ILGkdov+MGA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

it=
s_Giaan has posted comments on this change by its_Giaan=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer:=
 introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 19:

(6 comments)

File src/openvpn/dco=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/60ec1c4c_82ec962f?usp=
=3Demail :
PS18, Line 693:         dco_win_add_iroute_ipv6(&c->c1=2Etuntap-=
>dco, addr->v6=2Eaddr, addr->netbits, c->c2=2Etls_multi->rx_peer_id);
> is =
this unwrapping intentional?
Unintentional


File src/openvpn/init=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/e495bd2c_9f3ac369?usp=
=3Demail :
PS18, Line 2695:             c->c2=2Etls_multi->tx_peer_id =3D c=
->options=2Epeer_id;
> why set `tx_peer_id` twice, to the same value?
Done
=


File src/openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/10=
89/comment/d9f5177e_03242945?usp=3Demail :
PS18, Line 3144:         print_l=
ink_socket_actual(&m->top=2Ec2=2Efrom, &gc));
> this change looks like a re=
base artefact - the `rx_peer_id` is clear, but the `mroute_addr_print` pa [=
=E2=80=A6]
Done


File src/openvpn/push=2Ec:

http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1089/comment/8eaa710e_d2d3ae5e?usp=3Demail :
PS18, Line 667:  =
                       tls_multi->rx_peer_id);
> was this wrapping intentio=
nal? it makes reading the diff harder=2E=2E=2E
Uintentional=2E


File src/o=
penvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/c63=
de6c1_f1737fb4?usp=3Demail :
PS18, Line 2079:                   : write_emp=
ty_string(buf)))
> please do not call functions with side effects as part o=
f a ternary condition in an if() - it's real [=E2=80=A6]
Done


File src/op=
envpn/ssl_ncp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/=
40aeeff6_de002fe1?usp=3Demail :
PS18, Line 457:             multi->tx_peer_=
id =3D 0x76706e; /* 'v' 'p' 'n' */
> setting the magic number for p2p peer-=
id should be done once=2E [=E2=80=A6]
Done



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Ch=
ange-Number: 1089
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmarco@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 20 Jul 2026 12:01=
:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: cron2 <gert@greenie=2Emuc=2Ede>

--ILGkdov+MGA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a>=
</p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1089/comment/60ec1c4c_82ec962f?usp=3Demail">Patch Set #18, Line =
693:</a> <code style=3D"font-family:monospace,monospace">        dco_win_ad=
d_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;=
netbits, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">is thi=
s unwrapping intentional?</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Unintentional</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089/comment/e495bd2c_9f3ac369?usp=3Demail">Patch Set =
#18, Line 2695:</a> <code style=3D"font-family:monospace,monospace">       =
     c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=2Epeer_id;</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">why set `tx_peer_id` twice, to the same value?</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/d9f5177e_03=
242945?usp=3Demail">Patch Set #18, Line 3144:</a> <code style=3D"font-famil=
y:monospace,monospace">        print_link_socket_actual(&amp;m-&gt;top=2Ec2=
=2Efrom, &amp;gc));</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">this change looks like a rebase a=
rtefact - the `rx_peer_id` is clear, but the `mroute_addr_print` pa [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comm=
ent/8eaa710e_d2d3ae5e?usp=3Demail">Patch Set #18, Line 667:</a> <code style=
=3D"font-family:monospace,monospace">                        tls_multi-&gt;=
rx_peer_id);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">was this wrapping intentional? it makes =
reading the diff harder=2E=2E=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Uintentional=2E</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/c63de6c1_f1737fb4?usp=3Demail">P=
atch Set #18, Line 2079:</a> <code style=3D"font-family:monospace,monospace=
">                  : write_empty_string(buf)))</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">pleas=
e do not call functions with side effects as part of a ternary condition in=
 an if() - it&#39;s real [=E2=80=A6]</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1089/comment/40aeeff6_de002fe1?usp=3Demail">Patch=
 Set #18, Line 457:</a> <code style=3D"font-family:monospace,monospace">   =
         multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39=
;n&#39; */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">setting the magic number for p2p peer-id s=
hould be done once=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerr=
it-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 12:01:06 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

=
</body></html>
--ILGkdov+MGA=--


--===============7693063785508200822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7693063785508200822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7693063785508200822==--


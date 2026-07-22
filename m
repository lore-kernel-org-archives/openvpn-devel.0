Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E42C4453D
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8PcDqYXEqv33yZlZV0ZSo1oPs8+3gBWzxCMXWZ41bw=; b=lv2ITQoRpmjL3+XZ/9IOiYoP7h
	Ime/u3sjq8VYjrQmcGPf/leT59WvtTez9/CuZrwyV1NOZQAVLrx5fV4dh9kPPY8zlZYYnjzW/Fg3Y
	NQ5+DsAMzcI7irzrzoDqjhwDL9Bot5rwFIEocwW7TjbvVuckmt2zI3jxH3hRkTsYFnTs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmU8R-0006t7-Fv;
	Wed, 22 Jul 2026 10:25:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmU8Q-0006t0-GP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tV8xfxyUaSElaxhyM6aBzSgyO9AgQnmBgZ77lXPBLl0=; b=F4QRYFcDAOnBTeJ0O5o9Ofr2o3
 7SZOSl7v6rUtti4XGLAFwvju//Y0uxqQidYNwqCHXtoTJ+u/KSQcZd6S0InG4lpOGU+TtdisLPFyH
 LUCbVjCOddg+ptHzF+clF13piBwpJtEiNElCT8SreSbMOBPJSv+h1DmnCMXTjVh+6m5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tV8xfxyUaSElaxhyM6aBzSgyO9AgQnmBgZ77lXPBLl0=; b=d
 z1ROaL1mUVWdNuHN5BYRHOm2wfkQw14NMpiYUnPd7Ez2J+3qb+o6ri0V6Adqi/+dNxTk+g7OPc4yt
 nsHvxC3KrQn7n1p/mJbeJ7jQjxh0u3CagnmZvw/JnkI/55QaciJGdN506B4BGWog7al17pO0YK8CV
 rEjU8j7n9/HvFVvs=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmU8M-0007Zz-Cy for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:25:03 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so10884089f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784715891; x=1785320691; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tV8xfxyUaSElaxhyM6aBzSgyO9AgQnmBgZ77lXPBLl0=;
 b=bk6MuvTfowpZKPC28WXTlsPM2HeKVFxxmFJB/gVSgxAD3AGThxacBKSBCGKcK7Yach
 R9PnD51vT0SFAlAB57EDMtKWlnhG3EOV+AwUNKlJ4SXHdHYPtxHRyclDJMOUkMrGH0KB
 OcWcsfjOIKQotSzcjqRadJvVaHbobIUQscj6lIq6X/Qn7pMzhO0O1EuIv5S06c7epb8F
 2nsMhnCiQzVU7uy4Kz1WzI2UGU2DLJ+ySaFNkdIKL6Dcy6um0Iq8gqn3QztPEhP4flR8
 kKTQsANVD19G8rFw7Fg4J770TPJnYmpLs8Q2gHzTX1wCpPKWy/2eEzWQaOn7qXNLAXZl
 RY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784715891; x=1785320691;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tV8xfxyUaSElaxhyM6aBzSgyO9AgQnmBgZ77lXPBLl0=;
 b=BQu1HupELYtpPxkRhaKtEhr6ScrqBknpNfCBG650XOHEl/FPIgjueRRZR4tDqG+z7v
 O/n0aylhkSe2YrIDJMJKVud9/7GSxZ/IKP/qaIPcXsmSczMictY5r692L1xhhPAp/Qci
 SXFLyTtqXHXgPkGOOHNlJw71Z39mEXpBCnOcOOZiHdO5MJQZ4rGjBrAFj+z/nHycPrE4
 ei+W6FMYbwrmVmck5GEMugAGvbRvKM6TVl0sgKWLdwVDzV96kS6wo/b3+4fBhi03MuDb
 jbWINbIrEOHjQqUsHkfoavOB0L5pJXNhk/wIW4S/bP0V0oFuzmnXLOOhYLDG546bi39g
 2epg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh2hyABcsJcPmKatZKmyeRJhDokBwxvlhMwoe5x5rQ23FyVSFTofXshrw7jmj/QJEOrBAln4Z1OL+P3pHf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw+t4BG8PXEoQQ91KRWqEInlcvPDl/OOMeDdskBt4gTrRMXuGp9
 xmkc882g/0a5f7E/FWC65AyhNtahrzinNOkNJcxy/ycFJgfP9Wj81Sa4LWjLW2LRR8+CYPJMitU
 3ywsnmMBv+A9JkinSwveeXphWf3VbAttHrqrz3VEpweBVVuI/sRFLZPoNnvmqRyqj4a3RtCV1/z
 +iLQxFSg==
X-Gm-Gg: AR+sD13AgQB8iecjPBgc42dw8QoL7DSWwXLBTKvKjPKO/cwbXYu1X49FROXxFo8Br0t
 wA9tO5VdPkBEiLs0Zr51yc9oKTsBs4aRG3Sr17HmN5XSHNb3yTi8bmuRVX/gwNNyEnbwZXVMp+0
 ErTZtcBOyKQVIJdX16c7JuAErhIUIiszNWb+eqgtsbHU1in0TOXrVyH6BQ1/Ia6pqDat4023jD8
 ExfMrv7Q3oS6EqQ1+xxFDlakplQw3iMWqwlDyvH5suMEDVGQajKidUdCwf8nj9EX1tyM/2qIPSt
 ndToAJvfRP5RDhqqi/bTVHpSsnQD/ueJc/cV4+Uu+aK8fZkZYV92NOfww9V6cfzOXf+LMMVQg+F
 JFe8s5c/RWQcCZE7boG05Qp6nERaKXcqumrmo6uIask+YqYV8OtVeBydocHauVWr/wEEhXSyYK/
 tkOpE56MayxTh+rGcUq55DisbZQftHKlonUn7qNhr4vX33Tuizsq2wlJ0VTr0h4NCYG5hKyBb9A
 /dT/xyubCUhmJZOKZ0b8jdhzQxkB8XO+veWKElROodQzLQlt1+URaGGdjvdWEpXqEXU
X-Received: by 2002:a05:6000:41cb:b0:478:3f4b:348b with SMTP id
 ffacd0b85a97d-47f622fcdc1mr26192139f8f.7.1784715890675; 
 Wed, 22 Jul 2026 03:24:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm4726032f8f.37.2026.07.22.03.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:24:50 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:24:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: d25ee55822a9d23aaa20648ed86b0d14607f3e0e
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 10:24:47 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c96a29ccfb515dba003c63ccae04d4c6b08dfd7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmU8M-0007Zz-Cy
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
Content-Type: multipart/mixed; boundary="===============8635834484331566499=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8635834484331566499==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="50BDHeLN6AI="; charset=UTF-8

--50BDHeLN6AI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 17:

(4 comments)

File src/openvpn/siphash=2Eh=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/688ba2b3_578a30d1?u=
sp=3Demail :
PS17, Line 74:     if (siphash_cryptolib_available(ctx) && fal=
se)
> && false
Acknowledged


File src/openvpn/siphash_openssl=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/0d436523_940cec29?usp=3Demai=
l :
PS17, Line 27: #include "config-msvc=2Eh"
> This shows how old this pat=
ch is: config-msvc is gone for years, please remove the reference=2E
Done

=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/c5d23503_7391547a?usp=
=3Demail :
PS17, Line 32: #include "siphash=2Eh"
> these includes could mov=
e below the enable check
I trimmed the includes to just siphash=2Eh and add=
ed crypto_backend=2Eh in the OpenSSL path=2E


File tests/unit_tests/openvp=
n/test_crypto=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/d9=
4e0796_6dd8a399?usp=3Demail :
PS17, Line 960:         cmocka_unit_test_pres=
tate_setup_teardown(crypto_test_epoch_edge,
> Removes this test=2E [=E2=80=
=A6]
Acknowledged



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09=
aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-Patc=
hSet: 17
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 22 Jul 2026 10:24:47 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld =
<frank@lichtenheld=2Ecom>

--50BDHeLN6AI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>4 comments:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/co=
mment/688ba2b3_578a30d1?usp=3Demail">Patch Set #17, Line 74:</a> <code styl=
e=3D"font-family:monospace,monospace">    if (siphash_cryptolib_available(c=
tx) &amp;&amp; false)</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">&amp;&amp; false</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/siphash_openssl=2Ec:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/commen=
t/0d436523_940cec29?usp=3Demail">Patch Set #17, Line 27:</a> <code style=3D=
"font-family:monospace,monospace">#include &quot;config-msvc=2Eh&quot;</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">This shows how old this patch is: config-msvc is gone for=
 years, please remove the reference=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/c5d23503_7391=
547a?usp=3Demail">Patch Set #17, Line 32:</a> <code style=3D"font-family:mo=
nospace,monospace">#include &quot;siphash=2Eh&quot;</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">t=
hese includes could move below the enable check</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I trimmed =
the includes to just siphash=2Eh and added crypto_backend=2Eh in the OpenSS=
L path=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File te=
sts/unit_tests/openvpn/test_crypto=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/com=
ment/d94e0796_6dd8a399?usp=3Demail">Patch Set #17, Line 960:</a> <code styl=
e=3D"font-family:monospace,monospace">        cmocka_unit_test_prestate_set=
up_teardown(crypto_test_epoch_edge,</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Removes this test=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3De=
mail">change 31</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Wed, 22 Jul 2026 10:24:47 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--50BDHeLN6AI=--


--===============8635834484331566499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8635834484331566499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8635834484331566499==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915F6CC6B27
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w7zN3kjgiOfvhtHPHQIHUvFIbePlrdfkRd/Jwf4g0iQ=; b=eiNJ15uPa9SgtK1pxjZ+oQVTL+
	oijUhX256cA+olKKmd69bLyxU51AMP8DubbF45MebU3oeW61bhXEwNpYcxC97x5gkfdZ2Jb6Nmv6G
	TIrN+LbtljwQhvLXS5GQQN8k0RObnMefluMlHMj8nLIz98y7WY2mWkl8XpxFj9wb232o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGtUi-0001YM-Ne;
	Wed, 14 Oct 2026 07:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGtUi-0001YD-5h
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 07:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UKpo1/UQ8ivCKUNmyObDnR/LL4YDhMw5scDk8fHJ3Pc=; b=HGYbqj1rvfmHRinL250VTW9lc9
 c2KmC4ORL8JGb/BZwM9af1VSX1WmjfDg82BQtBon84kXCpGZowgk8Uf4oQoh9VOoDUPP4AJeVrq7e
 uWg5bPorPPf9H7TrndiPZvdVA06SgLmRIP3Lr74bXBvO3GLYjDQ8AGrsteXI1eFEGRVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UKpo1/UQ8ivCKUNmyObDnR/LL4YDhMw5scDk8fHJ3Pc=; b=f
 RDICTNgE4IR0E5VWLyiYDMifLBAHlfxOJhaTSE4vl1YO9NlVAXcj7AmTXzsRsq9ARiDyiFyT3jNNZ
 2OOp1zeoZ4Uzx0VDPDUf+3KZP2/KEO9jromMMqJrrQVFJiA3YFojeT2Up+QMD9zTD8nMG62eVgN5v
 e+juJH+BHrcb1CSA=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGtUg-0007R4-07 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 07:33:48 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2088558f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791963219; x=1792568019; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UKpo1/UQ8ivCKUNmyObDnR/LL4YDhMw5scDk8fHJ3Pc=;
 b=WPV1jDjiHgm+PC4MSq+syRE2YQSBpaD4pprk5mrsLZquS4h0+nPEdQpc4S4HoyIleU
 fHd/FFiWYJaAEmwOP08SAn8okRlK4KHnjF713x+q134Qq32rTT7BZRdAErf3xhb33BYK
 AFfO6oZFlIsa81+XsP0LLVweSjtPXc4+LT3WmJXC0X37JfUThJHGS9OFk++zcYTkiEiK
 rPLyx2zLD9RjjrMKXhGW8N8ETQecL3dNoY2aMIvakbrq6VdfOk2aVzaNtldo8J9IeqoK
 ASIXLZTE6fa0Y+P8AEjyp1ke4i281PNujCA7oV91gvR/jieb8wwhm+gxtYuEL0HEBg1x
 hc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791963219; x=1792568019;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UKpo1/UQ8ivCKUNmyObDnR/LL4YDhMw5scDk8fHJ3Pc=;
 b=02r24HK/0JGnlLM2X+PcpX2nuCKHNKpGAQ343eRP+iYosq0ZwWGmKl9OmMIBZ6a2iR
 3pzrN/Rn4gKPZEQkPDctZT0rhWs2oYm0CFSFQAisvtD9t320JryR11N3P0H1kOT9+4XZ
 l29EFYw0mvKxf9JOuFH2qol4vMxAwqqAEoQ5NkG6SHcRENY4PhXe40XDC/kZbC4gN41n
 9CwYi4HtaiSh3mYxoCiIYPxXzYAie3W5onVGPiv3TiLnMBqsXoTWNMbOxWLlZJUeA3tk
 Cqv3PN6W+Cbbsfav+dJjmgePGnPNSZIifSCcF4oOfvGK+bNozAsXP/j+fZFU9Ug2Vkph
 zdUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGpL++IVVv2oiPW3oZyuYAZAhFLapsO92lO7rQBVyZZUNn8ttBvIq5ox4iwL3WzgLXRgaFUsMYs2GoJdpd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIWsspT7oaAlyuQVs13BR3wFnWuAD7tTflJ2rHfjSJUjXnwybAi
 yqujtQlBuEXuWBqougjvFpkci8kFoPtrO/uGBIgrsdBdofr14uQKt5H+w1TGvrUO6z+vULmkMR9
 9boms1j1x0Wt173XVz/AElR3Y0jD6SKctW4iVGToIfhQED0F0ZozzN4EvJw4FyY6YJNLu
X-Gm-Gg: AYBFou2+4/hXUOqFgxlMhWF5tHBHhhbUEML6BYOxI3i4slrIVuUDR3GV4utusYYdiBE
 8Utv8mWmIZFde0P7FTwT52qwN/50zMC8Zkf72t6T0E8vVbemeYOHsr/ZMUFEZ/1xzCrwue0PdjM
 KNVkxZBzKux6v8xzDFavX4zQeV7r64bYnLPM4PeoLClSxEjFe0vqJBtnLmPfTXPndYFOjArbApA
 5zRzqcUOMs9fcdpc0L81MDlS4r58iOKhlyytKZDeoUQvmJ8XmNHEH0aVghaQ6Jq7kAzg1j9cKrx
 OtndNl8oRbXvx+mFmSLMXzLP13xO5ex+26+ObG0CvjSDJRGCvK0gNykZKtFpyotJ2pUrHpAWi/j
 cscgq5wxEdpcWVQUfwmSHiczBx5n+OLC4/Few2VeFyDSTvzuXNvxhZQ8A2S1Dzb3/SctyKpZ915
 +fl6y+LDRDJqK+IGCdhpuNyx4xBPxA7ksD5orqeNgGhKQo6zyzrtlzfjMNX0K1DU8kaessqtRfb
 mOg04aPyp4lVWYsCSaZI8fThIchvGsw+KL+lL/Ss8mP1M7xrp31lDjQW22I0ffWf57kfm+5wdnu
 FgiuAJVS+e3AROGMxrjr6C2kTCcypGRA4+xsnjFlt8kRJVWndnCww/+tmJxt
X-Received: by 2002:a05:6000:4553:b0:487:106f:ee31 with SMTP id
 ffacd0b85a97d-48dbaae8703mr20769338f8f.27.1791963219036; 
 Wed, 14 Oct 2026 00:33:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm10055139f8f.56.2026.10.14.00.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:33:38 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 07:33:36 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: 041a72adf5fb8166d03d3dc9ef543207bfc6ccec
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 07:33:36 +0000
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce54e44fe23c7331d2004cd2405b7d349ed77895-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGtUg-0007R4-07
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace strncat with
 strlcat
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6033030147414180713=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6033030147414180713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kEDM6C9n0uw="; charset=UTF-8

--kEDM6C9n0uw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail )

Change=
 subject: Replace strncat with strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(4 comments)

File s=
rc/openvpn/xkey_helper=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/199=
6/comment/72545cf8_7c8c9f5d?usp=3Demail :
PS1, Line 253:         }
This fun=
ction says it will return `-1` on error, so this is technically correct in =
that sense=2E However, it's callback type says `0` or `1`, which is confusi=
ng:

```
/**
 * Callback for sign operation -- must be implemented for each=
 backend and
 * is used in xkey_signature_sign(), or set when loading the k=
ey=2E
 * (custom key loading not yet implemented)=2E
 *
 * @param handle op=
aque key handle provided by the backend -- could be null
 *               o=
r unused for management interface=2E
 * @param sig    On return caller shou=
ld fill this with the signature
 * @param siglen On entry *siglen has max s=
ize of sig and on return must be
 *               set to the actual size of=
 the signature
 * @param tbs    buffer to sign
 * @param tbslen size of dat=
a in tbs buffer
 * @sigalg       contains the signature algorithm parameter=
s
 *
 * @returns 1 on success, 0 on error=2E
 *
 * If sigalg=2Eop =3D "Sign=
", the data in tbs is the digest=2E If sigalg=2Eop =3D "DigestSign"
 * it i=
s the message that the backend should hash wih appropriate hash algorithm b=
efore
 * signing=2E In the former case no DigestInfo header is added to tbs=
=2E This is
 * unlike the deprecated RSA_sign callback which provides encod=
ed digest=2E
 * For RSA_PKCS1 signatures, the external signing function mus=
t encode the digest
 * before signing=2E The digest algorithm used (or to b=
e used) is passed in the sigalg
 * structure=2E
 */
typedef int(XKEY_EXTERN=
AL_SIGN_fn)(void *handle, unsigned char *sig, size_t *siglen,
             =
                      const unsigned char *tbs, size_t tbslen, XKEY_SIGALG =
sigalg);
```


File src/plugins/auth-pam/utils=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1996/comment/2c765722_cab83dde?usp=3Demail :
PS1, Line=
 75:     char temp[templen + 1] =3D { 0 };
This is a variable-length array,=
 and C11 doesn't allow that, so GCC 16 rejects it:

```
error: variable-siz=
ed object may not be initialized except with an empty initializer

```


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/29c88cdc_abdb959e?usp=
=3Demail :
PS1, Line 83:         memcpy(target, replacewith, replacewithlen=
);
`target` isn't advanced after copying `replacewith`=2E I think we want `=
target +=3D replacewithlen;` here=2E


https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1996/comment/cfb1de43_43c90eb9?usp=3Demail :
PS1, Line 85:         s=
earching =3D scratch + tosearchlen;
Shouldn't we use the length of `searchf=
or` here?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1996?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I61e29d=
d2af9302b240c93735179d43c72e37b335
Gerrit-Change-Number: 1996
Gerrit-PatchS=
et: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Comment-Date: Wed, 14 Oct 2026 07:33:36 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: Yes

--kEDM6C9n0uw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail=
">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/xkey_helpe=
r=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/72545cf8_7c8c9f5d?usp=3De=
mail">Patch Set #1, Line 253:</a> <code style=3D"font-family:monospace,mono=
space">        }</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">This function says it will return `-1` on error=
, so this is technically correct in that sense=2E However, it&#39;s callbac=
k type says `0` or `1`, which is confusing:</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>/**<br=
> * Callback for sign operation -- must be implemented for each backend and=
<br> * is used in xkey_signature_sign(), or set when loading the key=2E<br>=
 * (custom key loading not yet implemented)=2E<br> *<br> * @param handle op=
aque key handle provided by the backend -- could be null<br> *             =
  or unused for management interface=2E<br> * @param sig    On return calle=
r should fill this with the signature<br> * @param siglen On entry *siglen =
has max size of sig and on return must be<br> *               set to the ac=
tual size of the signature<br> * @param tbs    buffer to sign<br> * @param =
tbslen size of data in tbs buffer<br> * @sigalg       contains the signatur=
e algorithm parameters<br> *<br> * @returns 1 on success, 0 on error=2E<br>=
 *<br> * If sigalg=2Eop =3D &quot;Sign&quot;, the data in tbs is the digest=
=2E If sigalg=2Eop =3D &quot;DigestSign&quot;<br> * it is the message that =
the backend should hash wih appropriate hash algorithm before<br> * signing=
=2E In the former case no DigestInfo header is added to tbs=2E This is<br> =
* unlike the deprecated RSA_sign callback which provides encoded digest=2E<=
br> * For RSA_PKCS1 signatures, the external signing function must encode t=
he digest<br> * before signing=2E The digest algorithm used (or to be used)=
 is passed in the sigalg<br> * structure=2E<br> */<br>typedef int(XKEY_EXTE=
RNAL_SIGN_fn)(void *handle, unsigned char *sig, size_t *siglen,<br>        =
                           const unsigned char *tbs, size_t tbslen, XKEY_SI=
GALG sigalg);<br>```</pre></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/plugins/auth-pam/utils=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
96/comment/2c765722_cab83dde?usp=3Demail">Patch Set #1, Line 75:</a> <code =
style=3D"font-family:monospace,monospace">    char temp[templen + 1] =3D { =
0 };</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">This is a variable-length array, and C11 doesn&#39;t allow =
that, so GCC 16 rejects it:</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">```<br>error: variable-sized object may not=
 be initialized except with an empty initializer</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">```</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/29c88cdc_abdb=
959e?usp=3Demail">Patch Set #1, Line 83:</a> <code style=3D"font-family:mon=
ospace,monospace">        memcpy(target, replacewith, replacewithlen);</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">`target` isn&#39;t advanced after copying `replacewith`=2E I think w=
e want `target +=3D replacewithlen;` here=2E</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/cfb1de43_43c90eb9?usp=3Dem=
ail">Patch Set #1, Line 85:</a> <code style=3D"font-family:monospace,monosp=
ace">        searching =3D scratch + tosearchlen;</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Shouldn&#39;t =
we use the length of `searchfor` here?</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail=
">change 1996</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
996?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I61e29dd2af9302b240c93735179d43c72e37b335 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1996 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 14 Oct 2026 07:33:36 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--kEDM6C9n0uw=--


--===============6033030147414180713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6033030147414180713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6033030147414180713==--


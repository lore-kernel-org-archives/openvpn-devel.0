Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71116C5DF70
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9j/1OWZ/lpgJljaQZOtTQlgmT0DRvlK3f/+Z97FUB+A=; b=D3hKGos9Q9SuKlbjnwwtD/RviW
	JbSxlP6lAisy3POcBscD8FGY3pMoIboP9CyM2BHErBjzziDyZJ1qT6ZFBCFlIP3lwk82nlHDzbbI1
	u+EFS2y2NHZCgunrs/UySsV3/MAZZj/lO1iqCGXmzmhJLw7GoaVskZhDfWAQHdUd7kGo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvugJ-00036O-Ha;
	Mon, 17 Aug 2026 10:35:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvugG-00035Z-1L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 10:35:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hS5EgzHQshcAuoL7u7ACd8gmmg3etahZe6xrc9l5MzY=; b=NMlvqZfCBy/mIYYGInvH/SbOR1
 gVAtrqwD4QvMfmngVZLeSnNWycX+nGYi5LknrIUaUn5+Ks3ei2KT9Vw0qdEfzeWGoKWpBKH12Z5BX
 hPGD/Os+tEsMDVCs70CwsPy6l5W/aJTEAyUYz5XH7K9MI9McggbTkme/TCWuKrXjH59Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hS5EgzHQshcAuoL7u7ACd8gmmg3etahZe6xrc9l5MzY=; b=c
 fNV5/4d1+MNfP0OId0CVMznb84/9eoT4eX46c3bJkjK20CCntEUZpAx6Vw7vK0qcHdeCP+x8aBi5E
 1yEOTsLILKLv6/ZXc8zH1gT0zenjgQlG4Koua8irHUa7OGHIU4X34x1gpYyF8ZGWM7b7ciaN235m9
 kTzh20UPup5sVC2M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvugJ-0005US-4o for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 10:35:00 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so29988785e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786962893; x=1787567693; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hS5EgzHQshcAuoL7u7ACd8gmmg3etahZe6xrc9l5MzY=;
 b=WU58jDlUsAb1G0l/4nFwiZajz/H8erMdtL7nQHuLmy2PB4ZjiLEoyzrehCaspWQLyJ
 xQ1CyEOo2folZSBcwVqED46lEQ9XDlzV6OVTbJyjLhm/IYirckdY6HejeuQkfa/8UKnS
 O241KxNMV46lirwpwmtdi9T4bMOB5jka/JulttKN2y9t8NXoY+JB+vw2a0eZrn7l09SY
 q7mJpafPtFkkgvfR+PsKK29lTOHrKIvwv4i4hycApf/8wSVPnyK+1YdiYZVMdvqQUIkr
 YN7j0WkgXs3/nFgJK98qCTv9zpuLPuvcs+cxuuN7r8LA+1qmrAHVK9vB1HKoDeZHFS/z
 7uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786962893; x=1787567693;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hS5EgzHQshcAuoL7u7ACd8gmmg3etahZe6xrc9l5MzY=;
 b=PhrcXjx8zSSDg98hIt8sBjwRaGvi+Yx0zomynWtXkwPiLxR/OqMwQ6qJnPc4wFb4TJ
 ZqrtHSUhhxB+LZ+m7z4c/WIwVcW+fBbpb3ysqJc1KwA9ooFxKdBXopqza3iQbTDRNrcV
 ZoPg093LGPIy8EBgJtxLuZX6fx3pgzW+e6XT8hSnQLxvvRSx8c6kV0JoRJ1vQYEfSDSq
 Ux/mTkblHBDLSujayCUdmWTeJc5VeVgbg0W7Dkht+O+PzGh0LEDZXnHvxvNeADXSPw29
 Po/U9m/n0/lgCuBczL3GcKt4iAXr5wInlJ45RBSflcFCLyCtrXXqT/zrpqLRBQtm1AX8
 nhrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNmOjz3786AaN/4OMBo+ACYxxeu3m73gB+DBA5jN3JSMyPLDbkkRptedbHkteylVJHuI5HwOeAS1Q8UiRF@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwxaWhBid2eMJKWZ/1+lR4DeLVqqppBj+lC/csDaNWhUG1ImXiY
 lVuvAll5Vpi4RlcbCcoRFkIC3eeMyjQUc1Tfl30pxtpgFVavn2amfZnp+m1ae3f3zyGwuYPXM3Q
 ur38wuPkIvlQ9tXDdxNaPtFwiVaDQBHK/1WjXV/Cwq/5XC71s7Ro8Ars3mam8AEozA6BS
X-Gm-Gg: AR+sD12SNgQFhNv4OncYeB2dL7UyESHz7EEMt1em+NS7Da3D+T08woMWswkPC+IYgxr
 JzrUk+TnILgGi0OU9aBaO1Xsi4Iqe72jkN8+1u6Cvcjngzw+GeJ7epCIHftR3P5X429htKpri/2
 dqFdpMmB+cf0LT4oBBqqaAEBJj0EYTyVATpq/m0roWatHo9lI9YlHdBIPKycrkPUceHs6gqLYtD
 6rPgYnp3twz7mv7YAtfDiu0U4wjyIc2wZM9j0YCriUIAVK0Tg/DVo4Srp59CjXV0KFoVRRXXzEX
 HTMvS7P9DsApewemKYRQExnFlFxCf23EcBV7xICbw8YIPBjrDxjGd0b3AYgc5GuPT436YIvaqpL
 CtIcEdXHUEgI/3YK7g+eH5eC5w8QEI8y8NtELAyUPtuOp/rZNZXEmpqgA2BZ0mefdp3nzeuKeFC
 /hRRKkgpk08wQxGRwkZDAcb108RpCN4N11M8Ujh27jOqRsFaGsU+QIqWoWaFrdYa4g4R4iIOJ0e
 2mzLjZCLhv1vt1R8130QWfTuzlegWx/LWKAh++WGq3SGGxZo0Y2cAniwvU10yvNvTPxhDv8c2ZX
 KmNEbmLTCe3nQCut+RQjJU8PpUbGdZrV9WSoAeNYRKqtWSsguJY=
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id
 5b1f17b1804b1-4998807e4c9mr361178245e9.14.1786962892828; 
 Mon, 17 Aug 2026 03:34:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b2a176sm275480635e9.4.2026.08.17.03.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:34:52 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 10:34:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 0ed03b5aa12f834249b9ecd2e8edb20d5e4d6fef
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 10:34:49 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0946f258b227a1a1d079ea415c60d073df96b685-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvugJ-0005US-4o
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8595956806950849347=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8595956806950849347==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7v2AbzQrHmo="; charset=UTF-8

--7v2AbzQrHmo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required=
 action returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(4 comments)

Pa=
tchset:

PS8: 
Just a few minor-ish comments=2E =F0=9F=98=8A


Commit Messa=
ge:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/790ac71f_746918=
84?usp=3Demail :
PS8, Line 10: is defined to decided if session_skip_to_pre=
_start should be used=2E
Typo: "to decide"=2E


File src/openvpn/mudp=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/7b4c0a0a_8072e62c?u=
sp=3Demail :
PS8, Line 282:                  * state is using the same */
T=
his comment now appears to be stale=2E


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1826/comment/cd87a5b4_c13c3108?usp=3Demail :
PS8, Line 283:        =
         if (session_id_defined((&state=2Epeer_session_id)))
Is it possible=
 for this check to be false here?

It's possible that I'm missing something=
, but I _think_ tls_pre_decrypt_lite() is supposed to have run before we're=
 here, and it rejects packets with no defined peer id=2E

If true, we can j=
ust remove this test and do something like:

    if (verdict =3D=3D PRE_DEC=
RYPT_CREATE_SESSION_SKIP)
    {
        ASSERT(session_id_defined(&state=2E=
peer_session_id));
    
        mi->context=2Ec2=2Etls_multi->n_sessions++;=

        struct tls_session *session =3D &mi->context=2Ec2=2Etls_multi->ses=
sion[TM_INITIAL];
        session_skip_to_pre_start(session, &state, &m->to=
p=2Ec2=2Efrom);
    }



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1826?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Change-Number: 1826
Ger=
rit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Comment-Date: Mon, 17 Aug 2026 10:34:49 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: No

--7v2AbzQrHmo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a>=
</p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?=
tab=3Dcomments&amp;usp=3Demail">Patch Set #8:</a> </p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Just a few minor-ish=
 comments=2E =F0=9F=98=8A</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/790ac71f=
_74691884?usp=3Demail">Patch Set #8, Line 10:</a> <code style=3D"font-famil=
y:monospace,monospace">is defined to decided if session_skip_to_pre_start s=
hould be used=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Typo: &quot;to decide&quot;=2E</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1826/comment/7b4c0a0a_8072e62c?usp=3Demail">Patch Se=
t #8, Line 282:</a> <code style=3D"font-family:monospace,monospace">       =
          * state is using the same */</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This comment now appears=
 to be stale=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1826/comment/cd87a5b4_c13c3108?usp=3Demail">Patch Set #8, Line 283:</=
a> <code style=3D"font-family:monospace,monospace">                if (sess=
ion_id_defined((&amp;state=2Epeer_session_id)))</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Is it possible f=
or this check to be false here?</p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">It&#39;s possible that I&#39;m missing =
something, but I _think_ tls_pre_decrypt_lite() is supposed to have run bef=
ore we&#39;re here, and it rejects packets with no defined peer id=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
f true, we can just remove this test and do something like:</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">    if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)<br>    {<br>   =
     ASSERT(session_id_defined(&amp;state=2Epeer_session_id));<br>    <br> =
       mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;<br>        struct =
tls_session *session =3D &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[T=
M_INITIAL];<br>        session_skip_to_pre_start(session, &amp;state, &amp;=
m-&gt;top=2Ec2=2Efrom);<br>    }</pre></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">cha=
nge 1826</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Mon, 17 Aug 2026 10:34:49 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: No </div>

</body></html>
--7v2AbzQrHmo=--


--===============8595956806950849347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8595956806950849347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8595956806950849347==--


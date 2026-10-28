Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15B606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AkCRq8dU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NVoEUzLd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SHf/cOBw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JAS7bwBa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yE/VTfKWP8fX8FWj7Ovr/no19nKC/CIw43VXSh7xHho=; b=AkCRq8dUA8Paoz/MP0jj1K7OCQ
	rKObwspwJesp07cBMOh0kjAagxUbyVQQJnqRYvpMzDh5nxL7MzibfHCTZsLmrWJ6mrHUGxuncGjOd
	WpzDILh6q3q5cTmSVzBvQ9iC9MFltx0j1aq55Zo13dXsKfA5GnYRSxWKX8LV4ZhW9WYA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3i5-0000000070D-1kOg;
	Wed, 28 Oct 2026 13:28:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3i3-00000000706-2d7H
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=enLcYPQ6oxnjIPcYH5St5qXtI0AanwMFf/c4P0tlbKo=; b=NVoEUzLdZxpAbG1GNWyDJ3DiwJ
 UUjjO7LN04/hXDvFRtPErmGpVffmrsQm/8wEClC8QSbW47zYTZuIDYeBmWoDMM4Bd3R590QvzE5Ay
 vABF+E2btbwbpgjhL1yjZymy9/UnOzjB8JcaGM+v3hifJB+pExjyJAT+7HRb0qQPtaaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=enLcYPQ6oxnjIPcYH5St5qXtI0AanwMFf/c4P0tlbKo=; b=SHf/cOBw/AaQEFO6j78Vi0sapC
 R0qIkKnGzVtcu9WooUoI6AyRY6wGYifbba4vbujLdNbzSmGWato27kSSzHFPrDd94SjNxzc08NYfD
 7Nwlw+eKgxHMi9qC2W4PmVPH1x9B3l3el08Wi4LxVrOqCvi83C/JH5jWONw6cew0H+54=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3i1-000000007xx-1tS1 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:28:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so7683515e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194127; x=1793798927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=enLcYPQ6oxnjIPcYH5St5qXtI0AanwMFf/c4P0tlbKo=;
 b=JAS7bwBaAUBUhV9FOGVasN7vcoJMXNrP42Hrp/+KXUuMwmFdVzTCeXQ6wPX3LGQVNa
 x/jp7QKUD3KB8uEr5NNMl4/zWoieOvMyhVobP2/pNr0tTYNAGIrGoxpqhR+2VdgA6BVy
 pLXq3UwzWjkL5pr87XUEmdoPb0+glGFq3c99eNLKyLR5INvilZ549g725sUmHZ+O/yfZ
 0zdVTJJHg2xlBc6s7SZDI44DXSUCf7aknH2QbTUnnd/3iQZx+v0AT+kOmHQz4PFTrTRM
 9PCzKBZT2CKGvRbQQYT7kp9a/ExnOn24JxlvaFxsYhQvBlyhmxZBj+XBRH4VTq6KwjUs
 oGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194127; x=1793798927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=enLcYPQ6oxnjIPcYH5St5qXtI0AanwMFf/c4P0tlbKo=;
 b=UWYve5ksEhqI+1KO9LH42KYyRsKREjpprElxxFGyZ4cH3OiaalSCVKRCWRD7sYnqZt
 8HrL08yXZu+Gs+gZ5XG3tiwQGhCMvgpeiwCY8DzE39ghLi5C4zXu40p0pYeffWED7UE3
 ZBP6DHRIlIgxVxkwmUMlSlxeoV6No2YLi57B6XrA8AmbVGCbGR3Sw1ZZAVV+V2ME/yVQ
 aDW4evlDHbycLtxv7EjKueKUrZ+XGAcaDRAnRJzV9w69JByxKjq5cCVGhIS4M59ODyKv
 cWEobNfy+OxfasudSOYbLlvbXZ5w2wjxCwCtwIxbEnRs5fBucsdrCZf+Wzct+0VLZiPx
 gWEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+wH7Hq/lTM9blneSis4ByS4pWGVO+AySFycThgElbw3DpFT0PXlrM2HGDaER1nW0qcnUDyAUSdyfurUNn@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIDnYNIeuqUKMbDv71MDy4zpl4ou1IQCszFhPq7miBB53K5hNXi
 clr6V/ZDrLCewUzU7s4skD4C8XhV8l8JLYEf6JfhuO1Do6Ejy0D8lYY+GCogEUp8/af9VzHR8rG
 KaGnMFc8sZlm8HJrH1VyzOpc7sQ/mJtMjKlE1CcWqrDD+DQQ2q8R/465EDSVc590J6uqJ
X-Gm-Gg: AYBFou1Nd33xFpx6lYcoy2b4gwXzkKra1dRgggMqxmUB6Wm2514hjWI5fQcvP2cM7MC
 PCVJmK7MvrtvFD04Z9rCvSu0KEdl4GD1DwgZlFyikgBbxqvk/MdZXncilSovK3qylQj0WxBcDoj
 2DPnQmPgxpqxhhUnMyqEGt3JPZVClQ+MHAld6tf5ByWebdplOmFdjlYhAx9wxHkFOIaBJjgAh7y
 yWRWgOb4HxUvGqJ6mT/4AtwCgJmyhU/gEikGmz8bUcpNsIUTQwM2++su+uk6N58nMXgzu5FE21u
 NTZvKZx8OTCw0fZFn5nssnUjXfjHZjTpBxLZA1d/R5vuTiPka+yvdG0rZObaBii2x1J600hggq/
 Q+CuQrhB8x4yYD0eZOQy2g/U9c16Wo0i9DRweMb5w1CKL47JQ+tV7a/gtBDf5KPY1wpAai101Hf
 mNcuPAdzCQ8YDM5kIwnhECQpwVM5NuAT8R4cLe6N7oj3uz4RM0zTAWeq9KPIzUU5FEpx8dkTc/d
 ZoraOdj5Ig6qBbU54xj0tsxbDRk8QqplGBHiiPQrQ2I73+grPVW4upCvMIGY+1stZJrQBoGwCxa
 OeoEqHenFrUPB5us/8m3AEdb+USZVQhORkTiQi7/umyhv26HqCEB+EAsDj72yIB3LNVtvJYnnQi
 e6BGdpTI/qzuHkz9U6HWnwCU8ZTASG3WzK9PTdxKGSOVpm3IeA5hooFj5iJCtRpipvKGCIzzhkX
 BkK5z06c3j2poYFlYzPg2h/GhkZ3HpWcsHlyRD
X-Received: by 2002:a05:600c:3b29:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a997bfaa4fmr39972945e9.16.1793194125556; 
 Wed, 28 Oct 2026 06:28:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a978d57b39sm75154295e9.10.2026.10.28.06.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:28:45 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:28:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6380386c5690d29661f083b8501d2f65ee967f24
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 13:28:37 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0e9cb7a714dc67dddd65549cdce82147035be59-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM3i1-000000007xx-1tS1
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============5078925698199730133=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5078925698199730133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A0dcIMyXPzU="; charset=UTF-8

--A0dcIMyXPzU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16:

=
(12 comments)

File doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/97aa9591_cb515ed1?usp=3Demail :
PS15, Line =
838: The server should then use acc-msg command to send app custom control =
messages
> client-acc-msg?
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858/comment/d429c14a_385298f5?usp=3Demail :
PS15, Line 882: >>>>=
>>> fd23ffa35a (Implement sending/receiving app custom control protocol mes=
sages)
> Leftover conflict marker=2E
Done


File src/openvpn/acc=2Ec:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/adf6fb7b_6a94ffd9?usp=
=3Demail :
PS16, Line 207:     log_acc_message(c, &buf, payload_len, protoc=
ol, flags);
> Should we drop ACC messages that are not within `acc_max_mess=
age_length`, or from a peer than never  [=E2=80=A6]
I added dropping ACC me=
ssage that are not in the negotiated protocol list (that also cover if a cl=
ient/server never configured ACC) but did not implement a message 
length c=
heck but added comment in the source code and management-notes=2Etxt that p=
oints out the reasoning for this (robustness principle)=2E


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/c463697b_aefd4c38?usp=3Demail :
P=
S16, Line 372:          * again would just add an extra string allocation t=
o options->gc */
> We're no longer allocating to options-gc=2E
Yepp=2E I wi=
ll that part of the comment=2E


File src/openvpn/init=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/baca3bba_59eca459?usp=3Demail :
P=
S16, Line 2283:     if (multi->acc_negotiated_protocols)
> There's a line h=
igher up in this function that checks `if (c->c2=2Etls_multi && c->c2=2E [=
=E2=80=A6]
Yeah=2E Although we are removing --secret so that will not happe=
n in the future=2E


File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/3c66338b_3d94e771?usp=3Demail :
PS16, Line =
1741:     struct context *c =3D &mi->context;
> This function only uses `&m=
i->context` but now takes `mi` as a parameter=2E [=E2=80=A6]
It is a leftov=
er=2E I will revert it=2E


File src/openvpn/push=2Ec:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858/comment/e774eb3e_383c269c?usp=3Demail :
PS15, =
Line 235:                            "without client announcing support for=
 it");
> This is missing a space (will print "control listwithout")=2E
Done=



https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/72b6b737_f529d37=
0?usp=3Demail :
PS15, Line 247:     struct buffer common_list =3D get_list_=
intersection(&gc, protocols, multi->opt=2Eacc_protocols);
> Isn't the `if (=
protocols)` check below too late if we're already using `protocols` here?
A=
cknowledged=2E That should be way earlier=2E


https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1858/comment/aae4fa55_84bdf5f2?usp=3Demail :
PS15, Line 260:=
         multi->acc_negotiated_protocols =3D string_alloc(protocols, &c->op=
tions=2Egc);
> This is use after free=2E There's a `gc_free()` before `stri=
ng_alloc(protocols, &c->options=2Egc);`=2E
Acknowledged


https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1858/comment/6a66ba9f_b793c9f3?usp=3Demail :
PS15=
, Line 260:         multi->acc_negotiated_protocols =3D string_alloc(protoc=
ols, &c->options=2Egc);
> This also allocates `acc_negotiated_protocols` on=
 `&c->options=2E [=E2=80=A6]
yeah this is a double free then=2E Fixed=2E


=
File src/openvpn/push=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
/comment/88db7f51_11455ac4?usp=3Demail :
PS16, Line 262:     multi->acc_neg=
otiated_protocols =3D string_alloc(protocols, NULL);
> If `acc_negotiated_p=
rotocols` has previously already been set, this leaks=2E [=E2=80=A6]
Yeah, =
or ignore further INFO messages=2E


File tests/unit_tests/openvpn/test_mis=
c=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6e56644d_f5=
3e4078?usp=3Demail :
PS16, Line 71: }
> These new mocks don't appear to be =
used anywhere?
Hm yeah=2E It looks like that is really not needed=2E



-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d7=
95b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 16
Gerrit-Ow=
ner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 28 Oct 2026 =
13:28:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--A0dcIMyXPzU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/97aa9591_cb515ed1?usp=3Demail">Pa=
tch Set #15, Line 838:</a> <code style=3D"font-family:monospace,monospace">=
The server should then use acc-msg command to send app custom control messa=
ges</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">client-acc-msg?</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment=
/d429c14a_385298f5?usp=3Demail">Patch Set #15, Line 882:</a> <code style=3D=
"font-family:monospace,monospace">&gt;&gt;&gt;&gt;&gt;&gt;&gt; fd23ffa35a (=
Implement sending/receiving app custom control protocol messages)</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Leftover conflict marker=2E</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/adf6fb7b_6a94ffd9?usp=3Demail">Pa=
tch Set #16, Line 207:</a> <code style=3D"font-family:monospace,monospace">=
    log_acc_message(c, &amp;buf, payload_len, protocol, flags);</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Should we drop ACC messages that are not within `acc_max_message=
_length`, or from a peer than never  [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I added=
 dropping ACC message that are not in the negotiated protocol list (that al=
so cover if a client/server never configured ACC) but did not implement a m=
essage <br>length check but added comment in the source code and management=
-notes=2Etxt that points out the reasoning for this (robustness principle)=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/=
comment/c463697b_aefd4c38?usp=3Demail">Patch Set #16, Line 372:</a> <code s=
tyle=3D"font-family:monospace,monospace">         * again would just add an=
 extra string allocation to options-&gt;gc */</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We&#39;=
re no longer allocating to options-gc=2E</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yepp=2E I will th=
at part of the comment=2E</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comm=
ent/baca3bba_59eca459?usp=3Demail">Patch Set #16, Line 2283:</a> <code styl=
e=3D"font-family:monospace,monospace">    if (multi-&gt;acc_negotiated_prot=
ocols)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">There&#39;s a line higher up in this function =
that checks `if (c-&gt;c2=2Etls_multi &amp;&amp; c-&gt;c2=2E [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Yeah=2E Although we are removing --secret so that will not h=
appen in the future=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/commen=
t/3c66338b_3d94e771?usp=3Demail">Patch Set #16, Line 1741:</a> <code style=
=3D"font-family:monospace,monospace">    struct context *c =3D &amp;mi-&gt;=
context;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">This function only uses `&amp;mi-&gt;context=
` but now takes `mi` as a parameter=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It is a=
 leftover=2E I will revert it=2E</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58/comment/e774eb3e_383c269c?usp=3Demail">Patch Set #15, Line 235:</a> <cod=
e style=3D"font-family:monospace,monospace">                           &quo=
t;without client announcing support for it&quot;);</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Th=
is is missing a space (will print &quot;control listwithout&quot;)=2E</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858/comment/72b6b737_f529d370?usp=3Demail">Patch Set #15, Line 247=
:</a> <code style=3D"font-family:monospace,monospace">    struct buffer com=
mon_list =3D get_list_intersection(&amp;gc, protocols, multi-&gt;opt=2Eacc_=
protocols);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">Isn&#39;t the `if (protocols)` check belo=
w too late if we&#39;re already using `protocols` here?</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged=2E That should be way earlier=2E</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/aae4fa55_84bdf5f2?usp=3Dema=
il">Patch Set #15, Line 260:</a> <code style=3D"font-family:monospace,monos=
pace">        multi-&gt;acc_negotiated_protocols =3D string_alloc(protocols=
, &amp;c-&gt;options=2Egc);</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is use after free=2E=
 There&#39;s a `gc_free()` before `string_alloc(protocols, &amp;c-&gt;optio=
ns=2Egc);`=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6a66ba9f_b793c9f3?usp=3Dema=
il">Patch Set #15, Line 260:</a> <code style=3D"font-family:monospace,monos=
pace">        multi-&gt;acc_negotiated_protocols =3D string_alloc(protocols=
, &amp;c-&gt;options=2Egc);</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">This also allocates `acc_=
negotiated_protocols` on `&amp;c-&gt;options=2E [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">yeah this is a double free then=2E Fixed=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858/comment/88db7f51_11455ac4?usp=3Demail">Patch Set #16, Lin=
e 262:</a> <code style=3D"font-family:monospace,monospace">    multi-&gt;ac=
c_negotiated_protocols =3D string_alloc(protocols, NULL);</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">If `acc_negotiated_protocols` has previously already been set, this le=
aks=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Yeah, or ignore further INFO messages=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/un=
it_tests/openvpn/test_misc=2Ec:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/=
6e56644d_f53e4078?usp=3Demail">Patch Set #16, Line 71:</a> <code style=3D"f=
ont-family:monospace,monospace">}</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">These new mocks don=
&#39;t appear to be used anywhere?</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Hm yeah=2E It looks lik=
e that is really not needed=2E</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change=
 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugly =
&lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 13:28:37 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--A0dcIMyXPzU=--


--===============5078925698199730133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5078925698199730133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5078925698199730133==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AADC43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12WYtF7MVsvBl3u98XEEEIs9O13VftbgBQ3jytUrpKk=; b=C909nuZMj9sxj0YsBsWx116mzP
	fzsyknJ1mdLZgb/CYgSIZdKCnAl54LdDH/Xvj1nlhuxVxpjoME6nw5iL9YrOvmAc7noqRw0+G2rcO
	FRdYcy3/2lwk7hV3cTdk/t4lb7qZI+ywwL14xJJ/zBWDp5cT/PsJ2l/4Auz/pqK/Yjsc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgiji-000085-9d;
	Mon, 06 Jul 2026 12:47:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgijh-00007z-Om
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=T1QICSVKryN5maN6JiMyLFeqBUXkS5flAbpETdGEPXs=; b=hiFa+HFn4agWaZMiu37bakJB+y
 Muti3X0t5BqQn+tvNz1ZcJSxV1ExcYf2d47pVublRUg3pIaJhTHhEpV9043qy2sTGJgpQEbxmCNAh
 MLZiKjLTEmpKC6URw5tNOSxX1N6NvULWbXzWi6dd4Odi6W7kxGLqZnKh9hFIY+LXJPe4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T1QICSVKryN5maN6JiMyLFeqBUXkS5flAbpETdGEPXs=; b=E
 ToRHAhNioukUPHXLmlbEuQB6VCLOUYWolfBW3cWFrJaiz+aj17Y7waD77y0Igt0l/3pOz1cF/W066
 +vDgnw1Nu6B/lOoS8UnYo/tsj0NDtxLEAoleqwPsHAOld39T29voUthq63/XIxhuv9DAZbSa18aFj
 Xrm9b/nFFWsjqGnI=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgijf-0003MH-Tk for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:47:46 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so36073975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783342053; x=1783946853; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1QICSVKryN5maN6JiMyLFeqBUXkS5flAbpETdGEPXs=;
 b=UwyT8Zk+Dd9SwltJ5E8JQ34MWCRRrwHpgMsvFfNKEFZBryIELVC6ylTcIfkat0zW/4
 gwsLJNNV2Um6W0XXeQuSdZSCJf2tTvjbO4sZhhEHw1f1YGOUTrPpCC49bfUgJVvkaWXV
 2RA9YXfE7Bj1/oLrdJ3gqMO8Pu+q54ZRR/Cg46j8iuymiEBY+Fw+OZOSSL7h67qoKRP5
 oyJTfscDVZTmAG2KAHgG9orcgCqp1ko4YLYG1Gi5gMET1atilRSbPmoDdzxrThucwQws
 IDAZa0D6BnoGWrRUPg2d+MfUAkkj2SdLjZ74luUESfWPzos5jkzfqk+RO0sF6lYyZ5+o
 5CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783342053; x=1783946853;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1QICSVKryN5maN6JiMyLFeqBUXkS5flAbpETdGEPXs=;
 b=gWH4QM5P8KfJn0KOFJOKQmW/KIIxyXGu24YFW1yuc0IrJO6Y0a8NpKPfigQ+wOmSyB
 lI6LOwnJu27YwqmPlMxoW2D7qmPEctqYIZ2x9PjyKsCfsKmNV0b5fQiJiNkF8oZbCBr0
 EVBN4PAWNkeG3aR0JyrmShzw4u/+RkoDZKxKsqg3oNTDj2OAhRzqLSQ2rIEYGJGZ3K/X
 DAa8A20wXPTbWtKtg6GtlQpWvCpNIW/qqKyJZnsr4RkoHWihw01H9WqE6OG0bVMVFXqy
 ejbfY66pdSFNehiUJcELiVd1+M30Nr+ujU/YhCju3v2T9hSjEPk5uEQqpDAZ4SzimPvA
 ETAg==
X-Gm-Message-State: AOJu0Yy1gyZaZfvZbGrGf2fn2yPdbMTj61IGvEBmP1e+0l2rfit2jaSY
 RGa2DuNDgtx/H7HS+3uFe02j6/3ck8YScjj20nAGLOVoPa1waPctKu5iDhjdspFo8UIHSy9JoXY
 Vf7dDi47GF25rrvuNx5bNLS8ahlB7OvKr4w3voyaIqP+3xapfPTSu7d0oLNUZhQLj0z/+6KRWA4
 DI86dj2g==
X-Gm-Gg: AfdE7cmIPcYjXK3M7Uk3ADYaI0mfJf1jF4lbNH1OReo/RfTzzpyULhmg3U0hTfE0mAi
 ba+7V1bcfS0RSHJ5UTl3Zy6ctmcivsgEeLPYh+V+iNtmPY+aDJtOUM4ZF0wv6yQ6qvmFvuy8rO8
 zXWNJNOAYB18utTvN8I3gXMMCbIcwN/ekhBKlK84sO4sL+ux+1PE8dhWwwYDKPSgDjzIircTlrb
 EN34EpS2QypFfkQFi0uZx/t329MFwTKyFBxmnwERGHcFWzb5tOZDKFUTaQPMst/ZDQqPuh2n094
 hev0wavLz8AH2rGVTqJAqhpkqzb40BvKHfZ+3EU7fXFcOqChW+a2WKcqIGuyK5ixY05s7Jq7kLw
 OZ5Fi0gDmLpY1kpqlNBMsORjoWgrB1qCz6WX3qoi7sgXcJ8F5Rwr5jimGVMVwwa7IMRzJp5XKlf
 WbY0JiKNJEc0Qxtf3KCDHc5nKVkSf9O+7FevNfil5Mv8W+QOOZLs4JRAJY8V2SJx0hYMGJLuY1z
 hZRi5bsi1anBwU4B3080KmHdpaN2I4IcQ8AZsGU++D086TDbg6qlbCUKQuBK61xexYRyxzi/jkd
 ZKM=
X-Received: by 2002:a05:600c:1908:b0:493:d3c5:6c32 with SMTP id
 5b1f17b1804b1-493decbf10amr7509385e9.6.1783342052665; 
 Mon, 06 Jul 2026 05:47:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636e9e9sm352146845e9.2.2026.07.06.05.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:47:32 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 12:47:29 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 3d148280b63a069b8d6879a7d9be7e5175292aa9
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 12:47:29 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b4618739f3cb09b1211ec06646c238950d46563-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgijf-0003MH-Tk
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
Content-Type: multipart/mixed; boundary="===============1158351574912861135=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1158351574912861135==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Pd7bCTr5e0="; charset=UTF-8

--0Pd7bCTr5e0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3: Code-Review-2

(10 comments)

File doc/man-sections/advance=
d-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/06=
3287a6_ad77a9f8?usp=3Demail :
PS3, Line 32:   address table to ``v``=2E And=
 if specified the session id hash table to
"If specified set the size of th=
e session id hash table to"


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/adc8d07e_8b554a73?usp=3Demail :
PS3, Line 33:   ``s``=2E Otherwis=
e ``s`` be set to the same value as ``r``=2E
"will be"


File src/openvpn/m=
udp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/d3040fdc_2=
606f6b9?usp=3Demail :
PS3, Line 383:         if (m->top=2Ec2=2Ebuf=2Elen < =
9)
Why hardcode 9 instead of "sizeof(struct session_id) + 1" ?


File src/o=
penvpn/multi=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/f=
186bf4c_f7a8e8df?usp=3Demail :
PS3, Line 138:      * id here is non-null an=
d the hash map's key pointer uses is pointing
Not sure what "uses" is suppo=
sed to mean here?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/=
4df36e1e_1916a232?usp=3Demail :
PS3, Line 139:      * here */
What is "here=
"? Sounds like it points to this part of the struct, but it actually points=
 to the beginning of the struct, doesn't it?


http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/2fd8e60c_76963cb3?usp=3Demail :
PS3, Line 178:  =
                                           session id=2E We do not care col=
lisions here
"care about"


File src/openvpn/multi=2Ec:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727/comment/ad114933_bf7dfcce?usp=3Demail :
PS3, L=
ine 441:         if (mi->context=2Ec2=2Etls_multi && true)
"&& true" ?


Fi=
le src/openvpn/sid_hash=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/30682dc5_7bd0156f?usp=3Demail :
PS3, Line 35:     /* This only be=
 called if the multi instance is not already present
"This should" or "This=
 must"?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/1001dcdb_1=
6f4167a?usp=3Demail :
PS3, Line 52:     struct hash_element *he =3D hash_lo=
okup_fast(m->sid_hash, bucket, sid, hv);
Could reduce code duplication slig=
htly by using multi_hash_sid_lookup here=2E


File tests/unit_tests/openvpn=
/test_misc=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/c82=
c40ee_2c2abdc4?usp=3Demail :
PS3, Line 143: get_random(void)
```
test_misc=
=2Ec: In function =E2=80=98test_list=E2=80=99:
test_misc=2Ec:258:19: error:=
 conversion from =E2=80=98long int=E2=80=99 to =E2=80=98uint32_t=E2=80=99 {=
aka =E2=80=98unsigned int=E2=80=99} may change value [-Werror=3Dconversion]=

  258 |             inc =3D (get_random() % 3) + 1;
      |               =
    ^
```



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd1=
19331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet=
: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Mon, 06 Jul 2026 12:47:29 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--0Pd7bCTr5e0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>10 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File doc/man-sections/advanced-options=2Erst:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/063287a6_ad77a9f8?usp=3Demail">Patch Set #3=
, Line 32:</a> <code style=3D"font-family:monospace,monospace">  address ta=
ble to ``v``=2E And if specified the session id hash table to</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&q=
uot;If specified set the size of the session id hash table to&quot;</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/adc8=
d07e_8b554a73?usp=3Demail">Patch Set #3, Line 33:</a> <code style=3D"font-f=
amily:monospace,monospace">  ``s``=2E Otherwise ``s`` be set to the same va=
lue as ``r``=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">&quot;will be&quot;</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1727/comment/d3040fdc_2606f6b9?usp=3Demail">Patch Set #3, Line =
383:</a> <code style=3D"font-family:monospace,monospace">        if (m-&gt;=
top=2Ec2=2Ebuf=2Elen &lt; 9)</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Why hardcode 9 instead of &quot;siz=
eof(struct session_id) + 1&quot; ?</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/multi=2Eh:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1727/comment/f186bf4c_f7a8e8df?usp=3Demail">Patch Set #3, Line 138:</a> <co=
de style=3D"font-family:monospace,monospace">     * id here is non-null and=
 the hash map&#39;s key pointer uses is pointing</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure what &=
quot;uses&quot; is supposed to mean here?</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/4df36e1e_1916a232?usp=3Demail"=
>Patch Set #3, Line 139:</a> <code style=3D"font-family:monospace,monospace=
">     * here */</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">What is &quot;here&quot;? Sounds like it points=
 to this part of the struct, but it actually points to the beginning of the=
 struct, doesn&#39;t it?</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1727/comment/2fd8e60c_76963cb3?usp=3Demail">Patch Set #3, Li=
ne 178:</a> <code style=3D"font-family:monospace,monospace">               =
                             session id=2E We do not care collisions here</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">&quot;care about&quot;</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
27/comment/ad114933_bf7dfcce?usp=3Demail">Patch Set #3, Line 441:</a> <code=
 style=3D"font-family:monospace,monospace">        if (mi-&gt;context=2Ec2=
=2Etls_multi &amp;&amp; true)</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">&quot;&amp;&amp; true&quot; ?</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/sid_=
hash=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/30682dc5_7bd0156f?usp=
=3Demail">Patch Set #3, Line 35:</a> <code style=3D"font-family:monospace,m=
onospace">    /* This only be called if the multi instance is not already p=
resent</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">&quot;This should&quot; or &quot;This must&quot;?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/1001=
dcdb_16f4167a?usp=3Demail">Patch Set #3, Line 52:</a> <code style=3D"font-f=
amily:monospace,monospace">    struct hash_element *he =3D hash_lookup_fast=
(m-&gt;sid_hash, bucket, sid, hv);</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Could reduce code duplication=
 slightly by using multi_hash_sid_lookup here=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/c82c40ee_2c2abdc4?usp=3Demail">=
Patch Set #3, Line 143:</a> <code style=3D"font-family:monospace,monospace"=
>get_random(void)</code></p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">```<br>test_misc=2Ec: In function=
 =E2=80=98test_list=E2=80=99:<br>test_misc=2Ec:258:19: error: conversion fr=
om =E2=80=98long int=E2=80=99 to =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98u=
nsigned int=E2=80=99} may change value [-Werror=3Dconversion]<br>  258 |   =
          inc =3D (get_random() % 3) + 1;<br>      |                   ^<br=
>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792a=
d1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon,=
 06 Jul 2026 12:47:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--0Pd7bCTr5e0=--


--===============1158351574912861135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1158351574912861135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1158351574912861135==--


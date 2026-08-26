Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99652C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZfOiiRVZ0kPwEvtBJGY1lEIEmRkp0IUDCONZ4dWTFg=; b=jswVVK2+bemxaG7OEziYl8/rEm
	XPu/E8oxsfTnVRw5zvMl3WFxPj0rof6TLGnAQAXu9uXMHO6XWgxNsQs4RcETS4bcyxm0GCwp5SpRI
	0AFWU+ZA84vLlfl8gG9gXm4hSP45oFBLfMO+o/zPZarsWNRlHINH2W7IOCpAMDe2Kf/w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFPf-0002WB-FO;
	Wed, 26 Aug 2026 15:19:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFOy-0002VW-3s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bgo0Coyk5uO10CZlFILPLErtQyDfBXDp8rLY8tIdbD0=; b=V4VLokPojt6+yRoKZm6l0raKYz
 Q94ACBtJgItaSEB4m1LX0XRsXRxabyurJqNWakGWMMP6qbpm7Z+xpbsFgAeKIDSIW/3e/p5THFA1j
 K2htEnhmg8elbo2grthLRwczuXJ0fhccKK3S8YXglCSh41Ru4yJrrXJ6KJXWgPxw9KHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bgo0Coyk5uO10CZlFILPLErtQyDfBXDp8rLY8tIdbD0=; b=S
 lTBfr5/AqpInSppOB2xeJQm5pK1gCwdtWp453JTsDs3ivh0MqN/JTPh1McM0PdBciE2r3YfY36fq3
 2WWeXTKmpY13tCMwvNQKdzcTr9v8Hd7dshEBUf/eWwaU/24LYe/0eSDPRAg4tDuomNWGIUvkU9uwL
 V5dBcwWX678z6mn4=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFOx-00074T-QT for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:18:56 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so161700566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787757529; x=1788362329; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bgo0Coyk5uO10CZlFILPLErtQyDfBXDp8rLY8tIdbD0=;
 b=DIrG2HmyEhjC8a95HYMHVEtRH5WzgaLvNinp17XTDjeDDhMAezrUFNzGCrJi4IOBwu
 mQ2o9iF3T5Yq8VXPUNKq1JPclzvHZza5urY23eV/tPb31ZgY1cSPtmG591JaYO0fdCqL
 DO/QIIlB6IB/ORt2nIdEyQw8uAyygpLrvjB2k6w9FYDqUg0+dZNmGnwXP5L56fhSrl/X
 hyaUapVw7CxJef5E6YhxJfDvDgrrW7dM8mRqEM0ICZEmSWuIfw5TqZ12YsEQgDOHMrot
 QlfqUUjrc/obASIkiC2AobpymB+u/cfpU1iihXsHguxcVQlIWgJL42zLOp7AJWYv3is7
 6tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787757529; x=1788362329;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bgo0Coyk5uO10CZlFILPLErtQyDfBXDp8rLY8tIdbD0=;
 b=iYYodgq/bVeroi6iBQlgAk9/uR60UCld5OCFPzh2NSGfGJLAXpSrC7Qhnxy4N5pwCz
 SK0pxyk0MXmqAhXdYnGXKLcJu5UFEh0OEebeQCLt/ZOL3rLuQq87UDRuxmT9hWRRAzGo
 Gq4DlxilNj7jXyKSo5qwZyLcoJcPPSYe3rP5aDEPj3TsXnCwQXJd/NH1ANysQWwBpTr6
 v3W55kjBPFd3MfFfEBpteGFR1scAt7inwEsDsgu58CH6GJY9ij+wG97+BbqAuFHDKwzq
 bZQMbD46RUvEkADhLaSgCdz4/sovap7eQZrUOwpQWBAlvlTfijgdSJGtu4iFrkqmxYFI
 FfYA==
X-Gm-Message-State: AFuF++mDpUSaA86rEB6XG1Kj5EwoPua4L/PMibHHLQ2M3CVNdH3FcqeU
 inJ2ShAVR1RxQ7HC7XP51gaxFvcVY5XAXzAYJnA0MwCUP5Y1i1zev+cmjZKt8+xt0ykEYYZYIFi
 sEY5iaB7kFNcXqECs6NCBmRyN2LGZj2jabMff40WyEwnbmHfD14lsY7eo56/DyQZcu0DEySfQuy
 txzaMi9Q==
X-Gm-Gg: AR+sD11oEQHqREGs3yWuN5VAGmrGPtswkcpZ9EXpuOVJrK8HBNOOu1MvUynoGtvFYCE
 TILMK/3beUapttNqUIZFG/kkc3y4myu1snj0gMbgsNkXhUaU+w/cfaYkHBAwa3CsGPlNNmKw438
 wiQbx2jY23YcgaHuGxVheN2B6I36sk26Gn7Xxq9nFJPXBgI+DVTIG2k7RAbMWiJA57b344jHa3Q
 DM7tTpWp9b1x9AeuJyFMSGWbQD/x2GS++0mrnHSl51Ou1Dh1sWR31iv38h4s4awbaIDLsMI1RpG
 ir5cy0hZqHUdjQEufUKZ9vJyvERXWEFmtpu1hdKHUBIQUyzKfaCmkI5GMXsc7RdSyZbWUu6J3SB
 QXkREL9WE8IpOojfmqZRE72cxQl1Kv5I8zokBVHagh+oJkeg0edoam3uMBmJN11ToppHMQL2mAJ
 hp65lRwzXuL3nA2+MpPQisPBaXxH880uQyVSE07xv+QHUfJ6bHfCumalmoqN+1QunTA0b1G2Brt
 8yb0NlpUecWPGIYpnJH0ecdb52ZzLLocANpXZ9dhkebgeI5MRycVZoAAqJxM/RSFUOnUjdoIuF2
 gSKeHjL8wW3FR1SAXmuNUC6ZVr1Hj+H2uaOXsDJAj4Q6x69Mg64=
X-Received: by 2002:a17:907:8b91:b0:c25:3001:4699 with SMTP id
 a640c23a62f3a-c2530014f82mr151891666b.12.1787747598628; 
 Wed, 26 Aug 2026 05:33:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25271e4cbcsm277907166b.18.2026.08.26.05.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:33:18 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:33:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08677f114c3ac26073656d1be4ba3ce62e3583fa
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:33:14 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <90c29e32f1a3a2472758bf7102bbcd735f056e07-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFOx-00074T-QT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extra a field from a buffer
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6479391399921511448=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6479391399921511448==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DZZHzkLCeWI="; charset=UTF-8

--DZZHzkLCeWI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

razvanc has post=
ed comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1855?usp=3Demail )

Change subject: Add helper method to extra =
a field from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 6:

(8 comments)

Commit Message:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1855/comment/3d741555_2dbdb0cc?usp=3Demail :
PS6, L=
ine 7: Add helper method to extra a field from a buffer
Typo: "extract"


F=
ile src/openvpn/buffer=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855=
/comment/a4d6d932_08ee6782?usp=3Demail :
PS6, Line 2247:  * Extract a field=
 from buf that end with the \c sep character=2E The
Typo: "ends"=2E


http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/38d87af4_b0194d78?usp=3De=
mail :
PS6, Line 2255: #endif /* BUFFER_H */
Probably want a newline betwee=
n the function name and `#endif`=2E


File src/openvpn/buffer=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/6ddfc3d3_5bd9e116?usp=3Dema=
il :
PS6, Line 1389: extract_field(struct buffer *buf, char sep, struct gc_=
arena *gc)
Just a nitpick, and possibly wrong but just in case you think it=
's worth a think: most other functions in these files are prefixed with `bu=
f_`=2E Would `buf_extract_field()` make more sense?


http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1855/comment/e48fa955_a2ea0218?usp=3Demail :
PS6, Line=
 1391:     const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));
=
`BPTR(buf)` seems capable of returning `NULL`, so should we check we're not=
 passing `NULL` to `memchr()` before the call?

Maybe as:

```
if (!buf_val=
id(buf))
    return NULL;
```


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
855/comment/78dc6664_ca817865?usp=3Demail :
PS6, Line 1400:     strncpy(fie=
ld, BSTR(buf), field_len);
We already know the length (don't need to look f=
or `NUL` characters anymore), so `memcpy(field, BPTR(buf), field_len);` sho=
uld be enough here=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comm=
ent/13cf5451_c9f30ca1?usp=3Demail :
PS6, Line 1403:     buf_advance(buf, (i=
nt)field_len + 1);
The `(int)` cast is unnecessary, `buf_advance()` already=
 takes a `size_t` parameter there=2E


http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1855/comment/5ba75d93_7c9f51c5?usp=3Demail :
PS6, Line 1405: }
Minor =
nitpick: this lost the trailing endline=2E



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Gerrit-Ch=
ange-Number: 1855
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed,=
 26 Aug 2026 12:33:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--DZZHzkLCeWI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><p>8 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment=
/3d741555_2dbdb0cc?usp=3Demail">Patch Set #6, Line 7:</a> <code style=3D"fo=
nt-family:monospace,monospace">Add helper method to extra a field from a bu=
ffer</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Typo: &quot;extract&quot;</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1855/comment/a4d6d932_08ee6782?usp=3Demail">Patch Set #6, Line 2247=
:</a> <code style=3D"font-family:monospace,monospace"> * Extract a field fr=
om buf that end with the \c sep character=2E The</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;end=
s&quot;=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1855/comment/38d87af4_b0194d78?usp=3Demail">Patch Set #6, Line 2255:</a>=
 <code style=3D"font-family:monospace,monospace">#endif /* BUFFER_H */</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Probably want a newline between the function name and `#endif`=2E</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bu=
ffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/6ddfc3d3_5bd9e116?usp=
=3Demail">Patch Set #6, Line 1389:</a> <code style=3D"font-family:monospace=
,monospace">extract_field(struct buffer *buf, char sep, struct gc_arena *gc=
)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Just a nitpick, and possibly wrong but just in case you think =
it&#39;s worth a think: most other functions in these files are prefixed wi=
th `buf_`=2E Would `buf_extract_field()` make more sense?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/e48fa955_a2ea0=
218?usp=3Demail">Patch Set #6, Line 1391:</a> <code style=3D"font-family:mo=
nospace,monospace">    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf=
_len(buf));</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">`BPTR(buf)` seems capable of returning `NULL`, so sh=
ould we check we&#39;re not passing `NULL` to `memchr()` before the call?</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Maybe as:</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">```<br>if (!buf_valid(buf))<br>    return NUL=
L;<br>```</pre></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1855/comment/78dc6664_ca817865?usp=3Demail">Patch Set #6, Line 1400:</a>=
 <code style=3D"font-family:monospace,monospace">    strncpy(field, BSTR(bu=
f), field_len);</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">We already know the length (don&#39;t need to lo=
ok for `NUL` characters anymore), so `memcpy(field, BPTR(buf), field_len);`=
 should be enough here=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1855/comment/13cf5451_c9f30ca1?usp=3Demail">Patch Set #6, L=
ine 1403:</a> <code style=3D"font-family:monospace,monospace">    buf_advan=
ce(buf, (int)field_len + 1);</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">The `(int)` cast is unnecessary, `b=
uf_advance()` already takes a `size_t` parameter there=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/5ba75d93_7c9f5=
1c5?usp=3Demail">Patch Set #6, Line 1405:</a> <code style=3D"font-family:mo=
nospace,monospace">}</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Minor nitpick: this lost the trailing endli=
ne=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9d=
f67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Wed, 26 Aug 2026 12:33:14 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>

</body></html>
--DZZHzkLCeWI=--


--===============6479391399921511448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6479391399921511448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6479391399921511448==--


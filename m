Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5656ECA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fi5AGboOAf5Beig9iT2caQa/LJQAIFsBTD1xUpAUcwk=; b=PIY0L0Ab0CbEfetksK0fe9MeDO
	AGCINqq3gtNuACGAX3Ng99NY5EDpLqsFGZoCL0D7e89h2XryEkixaV8lWrbh1/6tKvAncSmwJeI5V
	HNWz9u7hQ/YTsT8JoIZ82kTXlVxK2YbnYUfZ5prjkh+JLULhHt3bDS1Km0GnCbdaBwXs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEQ35-0006FL-Qf;
	Wed, 07 Oct 2026 11:43:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEQ33-0006F5-SK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i8Tm3Q8GMM746616ebIER/IFjPqK5AbHicF4YHi2j2s=; b=hI1bRLpPliuhqrdCh1wSLRIqVy
 HJAUsiJMAiyeTptjrT2zSm6NjZPn0KRQndAy3HjIjNivI4IX0R1FO0DgWKID1WqFnhyHogbUYcw0J
 I8ibyoMKQsCtnr/duw47dZI2U8WZuaukxxnxJ8BYCGcoeX79xj9z6LnfSuGxLH9oCpeY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i8Tm3Q8GMM746616ebIER/IFjPqK5AbHicF4YHi2j2s=; b=T
 Ye4dSONO3Ca43ZfxP4rGMX5mBLT0MO1TLuQXZZmwALuol3eI7fN8fbTIGjF6IV0z0QT+Ne1ijgN3G
 l2rg1G+ojkVo9uVPYJZdJd8Rrxk2cp2+fdNwqPgJD7bs0bsJCRlfUvWI7TbjrLmI0I5R17OjpUOVN
 uoCymQJ/PARg6Jds=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEQ32-0004st-I1 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:43:02 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4956869750eso10594715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791373374; x=1791978174; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i8Tm3Q8GMM746616ebIER/IFjPqK5AbHicF4YHi2j2s=;
 b=RTmRrAdTvU7tNtuJFXdaTLD/NSyCQesOmsEac5LCr+/C90f2wPkpMritiPvujYtDFP
 Zq0/gr9Gy3Op7qZqRXSaT6fgzjJeGHXpgk3Y1cVvJxRdhgrm0nbYT2hKcBd6Iu9KN6k1
 xoMi8lXUIynsvrjhWbtJQu/Ao2bYq0qplkL/MC0qBgS7CLNRLmhNlzZT4OA6c1zMopQ7
 CymRvpJrbOEtYyAJ4D3MCDfBl9eWt/SfBj4e2qtsw65zn6CJoyWhLqR/tuiYPmQ9Khst
 0q+t+H/Bhokazkb+V9MrnbnpFxpXjma4SOEa58aDKfCnklLzkdoC7QL1IBDZUZw5FI92
 jbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373374; x=1791978174;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i8Tm3Q8GMM746616ebIER/IFjPqK5AbHicF4YHi2j2s=;
 b=Vwoalx3So3Bgx+gtGB1C7iPW16IX/UHf30LyLebv2MDsL6zUwVANzpD+lglkEz94zs
 J0+Nl2lZkPl+B2UCvM1/Cp8i5xlnkRjKDsaIv+Mo0LbbvOCUlePd/PrrjbOi63VtqTD5
 06pzIHmLz+JBOJAuEH6c4Nkh1dZzdYwbEIOlJUs2/DVMvlfDyzOdQ1MarziQ1lTOys7q
 oohP9QaaVip8jedfP+F6VXCL5J4YpIGgui77It78+R3eXXcCFshHh+vBmBQ2R60/Jd5f
 At7RK+tuF3EfgsKsZ6S2CupbY9/yxcrqtm1SWaRGfRAljzWZIpCVWiGBKQSBFWFwbJZv
 XSHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZZMqHDRLxOyicyMsDqApUgDKzDGyLkOrI02Wf3Upp5LWfqK/2a+ed/fx+iYNkwX2hqO66Wp8bpardyCEP@lists.sourceforge.net
X-Gm-Message-State: AFuF++lzQqcDofqXMDE//KXFKbxwEEgMkBlpdvlA7j8ED6lz9WNEPETb
 J125dBYhQnxvip6tiv8qO3geOneuq4xC0I4EMxLensLf3s9OATEucOl+Td2Jfcka+/8SRc3HmkE
 x5tk5k2PELF8jC9afzhfLgtH9/EO/bYhrkfkLLHdWo2a623T7GfpbmeB/te2wVAaZGUWghqjRhH
 VLXW5ANQ==
X-Gm-Gg: AYBFou1hOZKNAKJQuzKbDrf308CgLez26pI2ngR20V0PwepGrW+3Nvno49e3OIUzPWI
 cbXVN+jG64v51XeE7BjP1BWY6oruxjr4yvjpQZIyqfvPbSwMsHsx70GK+/lrLK6WUaqhHb16LJP
 tGVTacrwxyZN2E1waqI3esPM0v0GfRczGTffQE0b0vI0OqZqweQcDoFmLm2V0J8M0Ou4nSjGsGQ
 kodChRjdLghzqWMU2xb9uUFLo3MJVLmRO4CoqsSk9vwiS0uRL602VNKTb3X3OYy293eGCtvq+IQ
 1o80+t1tTkVHtq2U2I9La1XiExOHuchGr8euGbjjOASJSqoXKR3oC9Bi3jgc+wCL3qLHpOSH9LP
 qwLnv1DgCjBagPgSp8VxmsROK6TcWDnOrIEowN9RN/jGAc52spjzdOfcxUpKjuarns0EUZMgNq2
 cRJuQ9LzKRhEbIsftjEw1e+eeKE3W+kJpmkrzf3qK3B7fPHfzRjIrMI1lXZk9/VOYN6Iy+hRLY2
 cBl0PK8Sydoiazo78y1wCyi+6X7+EWK6XXcf5GZCx45StNvhDKq40L0eUeJpyYnDylMe6ml4KXt
 PuJ0MVoaS41fFjowiqgdDr115bG3dTaZcDhoYKehWxm7ihTfAGj2946RAKWcNSCRs/IWfUI=
X-Received: by 2002:a05:600c:1546:b0:4a0:2867:d8a9 with SMTP id
 5b1f17b1804b1-4a180648e92mr32764475e9.30.1791373373721; 
 Wed, 07 Oct 2026 04:42:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c4008esm138046335e9.6.2026.10.07.04.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:42:53 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 11:42:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 5acd7a922b4bcdb4579db8006d8db02c2d38fc3e
X-Gerrit-Comment-Date: Wed, 7 Oct 2026 11:42:50 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5bcc1ab9d2225eefd45a8a93c17d967f18bed694-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEQ32-0004st-I1
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3397448856693666433=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3397448856693666433==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n1vUXWnRwdI="; charset=UTF-8

--n1vUXWnRwdI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E ( h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subjec=
t: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32:

(9 comments)

Commit Messag=
e:

PS31: 
> Re-opening=2E
Done


File doc/man-sections/advanced-options=2E=
rst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/9e5cecb2_734d=
de43?usp=3Demail :
PS31, Line 40:   By default, all three tables are sized =
at 4 times ``--max-clients`` buckets=2E
> Re-opening=2E
Done


File src/ope=
nvpn/mtcp=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/36d=
48a52_53e0a9c9?usp=3Demail :
PS31, Line 63:                 "MULTI TCP: new=
 incoming client address matches existing client address -- new client take=
s precedence");
> Re-opening=2E
Acknowledged

Add a paragraph in the commit=
 message about this=2E


File src/openvpn/mudp=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1727/comment/2b9c0873_781e6e79?usp=3Demail :
PS31, Lin=
e 329:     /* Copy buffer, to a tmp buffer, so that reading the sesison doe=
s not
> Re-opening=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/fb39a7a4_5d143735?usp=3Demail :
PS31, Line 335:     (void)op;
> R=
e-opening=2E
Acknowledged


File src/openvpn/multi=2Ec:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727/comment/d384efa1_ef7dbd15?usp=3Demail :
PS31,=
 Line 437:         if (mi->context=2Ec2=2Etls_multi)
> Re-opening=2E
I chan=
ged it to also print the rx_pid at D_MULTI_DEBUG (verb 7) and not only when=
 DCO is enabled and D_DCO_DEBUG (verb 6)=2E


https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/a2e854b2_f02ac73d?usp=3Demail :
PS31, Line 2473:=
 multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instan=
ce *mi, struct mroute_addr *real);
> Re-opening=2E
Not sure if we prefer lo=
osing easier way to annotate in git history to eliminating a forward declar=
ation=2E


File src/openvpn/sid_hash=2Eh:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1727/comment/204548f2_e2afe61f?usp=3Demail :
PS31, Line 25: #inc=
lude "session_id=2Eh"
> Re-opening=2E
Acknowledged


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1727/comment/4cf3e54b_d6a05372?usp=3Demail :
PS31, Lin=
e 31: multi_hash_sid_add(struct multi_context *m, struct session_id *sid,
>=
 Re-opening=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Ger=
rit-PatchSet: 32
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: Anton=
io Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio=
@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Wed, 07 Oct 2026 11:42:50 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>

--n1vUXWnRwdI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Arne =
Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Chang=
e</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727/comment/dc49a4fb_1ec1415e?usp=3Demail">Patch Set #31:</a> </p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File doc/man-sections/advanced-options=2Erst=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/9e5cecb2_734dde43?usp=3Demail"=
>Patch Set #31, Line 40:</a> <code style=3D"font-family:monospace,monospace=
">  By default, all three tables are sized at 4 times ``--max-clients`` buc=
kets=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mtcp=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/36d48a52_53e0a9c9?usp=3Demail">=
Patch Set #31, Line 63:</a> <code style=3D"font-family:monospace,monospace"=
>                &quot;MULTI TCP: new incoming client address matches exist=
ing client address -- new client takes precedence&quot;);</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Acknowledged</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Add a paragraph in the=
 commit message about this=2E</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/=
comment/2b9c0873_781e6e79?usp=3Demail">Patch Set #31, Line 329:</a> <code s=
tyle=3D"font-family:monospace,monospace">    /* Copy buffer, to a tmp buffe=
r, so that reading the sesison does not</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Re-opening=2E=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/fb39a7a4_5d143735?usp=3Demail">Patch Set #31, Li=
ne 335:</a> <code style=3D"font-family:monospace,monospace">    (void)op;</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/d384efa1_ef7dbd15?usp=3Demail">=
Patch Set #31, Line 437:</a> <code style=3D"font-family:monospace,monospace=
">        if (mi-&gt;context=2Ec2=2Etls_multi)</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Re-ope=
ning=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I changed it to also print the rx_pid at D_MULTI_D=
EBUG (verb 7) and not only when DCO is enabled and D_DCO_DEBUG (verb 6)=2E<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comm=
ent/a2e854b2_f02ac73d?usp=3Demail">Patch Set #31, Line 2473:</a> <code styl=
e=3D"font-family:monospace,monospace">multi_check_dest_addr_allowed(struct =
multi_context *m, struct multi_instance *mi, struct mroute_addr *real);</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure if we prefer lo=
osing easier way to annotate in git history to eliminating a forward declar=
ation=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/204548f2_=
e2afe61f?usp=3Demail">Patch Set #31, Line 25:</a> <code style=3D"font-famil=
y:monospace,monospace">#include &quot;session_id=2Eh&quot;</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/4cf3e54b_d6a05372?usp=
=3Demail">Patch Set #31, Line 31:</a> <code style=3D"font-family:monospace,=
monospace">multi_hash_sid_add(struct multi_context *m, struct session_id *s=
id,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec86002116=
51b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartull=
i &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Wed, 07 Oct 2026 11:42:50 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:n=
one"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>

</body></html>
--n1vUXWnRwdI=--


--===============3397448856693666433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3397448856693666433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3397448856693666433==--


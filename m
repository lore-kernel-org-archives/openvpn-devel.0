Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C09FCA600E
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oCBoP9spVIf7lWL4FWdQf5ltAkWCTa0JOOyNcC58K2Q=; b=AJJxcoOsMGatJyhGNu9j2FipVp
	Q5aV++Cfu1N9Hv0ieYeSSODVyYWGKFZOjm2QqTZh2EJyuOdjDS/wywgHplUylYApAEC6Ez26+ZC8N
	Mf6N2U5BEW+VRWHWoZdz5tzNIr4Rewhq8lzwAjN34A4YWUVEB1wT5TBt9BzK2/l2Qq9c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEl3K-0006HX-Ff;
	Thu, 08 Oct 2026 10:08:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEl3J-0006HK-49
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jC21gWSjKM5xGlYuOz9xalvRaHOjbcRuCkFufAqYGTI=; b=QBQtfIZbBj+CQYNou0wXec1YH4
 hRCSDwOSfpejkYtkurT5oMV0JzRlAUnc6gLmZ9wVXkf+ia0edQN02FofAezpM+KlLT2Lj0LgumGaD
 ZsoTfJ9pTW4c1dCAAq4IfOiXYe/JjbAZ8uCpgXJTUC6V8hMvI/Q8ugPWhDS0V7iKCFTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jC21gWSjKM5xGlYuOz9xalvRaHOjbcRuCkFufAqYGTI=; b=Z
 I1h8nL6bgEueKoMvzRnq3BoQ3bq+/3gSX9tQbuvz23zeLY9I3CTEUPULklcfDR55Ix4wFI21T9ISl
 WbOouMc79WgQ6dE6O5DINGNWvwAS3Bo6AymzuAvlnx1fbcqbNZB/uG5kzWMMwOx+mRAF++TP74frc
 Cif9RlOQCKcusYV4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEl3E-0002HH-Dl for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:08:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48b0be347b8so2286907f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791454110; x=1792058910; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jC21gWSjKM5xGlYuOz9xalvRaHOjbcRuCkFufAqYGTI=;
 b=QWOYHqXZRBfJkYXmoWcd+iL6f/xhnmgrQyvBhx29jzCf0DdWIt7VMYufns7FEUgqZk
 O3fXv0FhJLAD1n/FuXe0D/uhFQ55ETa2GvJ+Cg2OmQ7eXTYcLXmdW5c2BMmIVB2YfgFM
 vD7VnT26cG9KYn2AVZGRPZz6n3IsP7MBV/nUFYq9QOgNgfoaVwYXvvvI/bt/eF/h6XE2
 GaPCYy5E/G23+mjjkpw8Fo7r//jFH+3gnQTmzLQLxa5+HAzGi7a5hQ/wQcCJ0a7k+mH8
 VQ5a3pu97m9eyazvG3+IWRdSXXDVlg4ClW1x/D51V0hrzFdKUMDMoEEPWGoh5P07oS4b
 jksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791454110; x=1792058910;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jC21gWSjKM5xGlYuOz9xalvRaHOjbcRuCkFufAqYGTI=;
 b=nRZ3MTGQ7vT35wyTltTQmkn0zPIW0RS76GG1tQOYeNRk+lan6l76dto0ltYLG05THE
 VMErl3a86evlCqSjFJ9wAJUAU6lzT2JiHwBjZqpANWRN33/eBTny4DqnsJLphmJf+5Od
 /XaY+WEjXTZ8O2FevlsZ2hI9CpEpr85QaalL4VpaUsc8A+BSUj3r58IOxpxXpKdJFr/M
 +RkvKNsHzMOQkUT65G/UMVlzARXtdV3uZJYbarFZ2hQ5zkiesmjvaA9FEOiPo49h5IKx
 gIWD9X8GgAN3fJZaRFiTAogGqn90GUNKeI0VNAmVQIL4OZSH9Pu1m0omg+UVuINKq8OI
 8vsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMKRnJcoRCnyeAq35yzrH9ZkWtC9bTJmI386tLYlCuaQvkbnasKeE6QeHu2rVf6Eum9xuwQ4NT6bR0dpCj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYILthYel6PLbT9t7l8o8WwEQ8BVgPgO+ltBPQ97oroac6JxBH6m
 dUZrfbSweNrihoCzogcn6Lwk+6zj2mDLqtnreYkOQiyKmZGMyHSRez2G1MMjS+YvJwcu/u58ODU
 7T08wXsm2wxbV+vDIyQRXFGc2HgQIzof8Blv6J7E68SY7CiXmBFCRYjcyhb+aey3xwOu1
X-Gm-Gg: AYBFou3Wp2zPqygoOHWzDE0o/AXs0B3vxtBDzoiTGpW0wM8f08xyZ7r3Nc0kOwVVPp5
 4hY3CeSk0pHxmvPkGrcC33BsLOJCWc2Mzk01xc+teAO2tv76IPrHEr5s4ZGmR6Jit2V8eXdoVtv
 gKmTFzBfgdQHSIIRYwN4lHfOiwFY0svcBThkGroYTqyYc6M5+myoAxbJqGfYIP3O40K6yaBNjnn
 2ayaqOdiAmeO0i8gvCxCuI+6k5ciTTf/2dtkhYq5gC1R99nwMpZWcrJRLmIYYCCLTVylhl8bNPH
 YLYSBioHeD8CgTuq9ZN9OSKi27uQYlwkRNjc0m22UERwCLb/pb45KY7MgoLVo6x699MlX7qWjdn
 G7gV0Pu8qU3Z9dj61K5F0hOmnwnh7IQPP1T+Qqsan80UEsvpB6zm6ZHprwNFR8OO0Sflooyxfsq
 imd4ZJ+xRIfiWB/wdlNVeGfYxW9taMHhZvU+xgbIyOoFhTdO+nB93KSll4lqCcYEEzMwcAuCXDK
 4feucb1yXIvyOMGVWDFZTCcpNBGD//XR7Mt9VOEXXRAOCQ1J4UMureLxqn4eU+9Kj6XsXTjIuQj
 hkurGfev2NiFqmfxuvtGUHVYVUEpLmSWE+BglV5sIZnDXonp5K0UXBHQKNwu
X-Received: by 2002:a05:6000:4557:b0:487:aff:9952 with SMTP id
 ffacd0b85a97d-48c7277eb98mr6115912f8f.16.1791454109580; 
 Thu, 08 Oct 2026 03:08:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2fba1sm9965197f8f.48.2026.10.08.03.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:08:29 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 10:08:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 5acd7a922b4bcdb4579db8006d8db02c2d38fc3e
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 10:08:25 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d917b805de67fcbc28071b4ac6e003802903639-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEl3E-0002HH-Dl
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6049034255455116243=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6049034255455116243==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c7XRb8vTs2M="; charset=UTF-8

--c7XRb8vTs2M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Antonio Quartulli has posted comments on this change by Arne Schwabe=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change=
 subject: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32:

(8 comments)

Comm=
it Message:

PS31: 
> Re-opening=2E
Done


File doc/man-sections/advanced-o=
ptions=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/8059=
fadd_cd066173?usp=3Demail :
PS31, Line 40:   By default, all three tables a=
re sized at 4 times ``--max-clients`` buckets=2E
> Re-opening=2E
Done


Fil=
e src/openvpn/mtcp=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/co=
mment/246e24e6_0b69bf03?usp=3Demail :
PS31, Line 63:                 "MULTI=
 TCP: new incoming client address matches existing client address -- new cl=
ient takes precedence");
> Re-opening=2E
Done


File src/openvpn/mudp=2Ec:
=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/49849e80_ea8cbe5f?=
usp=3Demail :
PS31, Line 329:     /* Copy buffer, to a tmp buffer, so that =
reading the sesison does not
> Re-opening=2E
Done


File src/openvpn/multi=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/006e7d24_aa1=
9b0f9?usp=3Demail :
PS31, Line 437:         if (mi->context=2Ec2=2Etls_mult=
i)
> Re-opening=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/c=
omment/909f4428_7c0b0654?usp=3Demail :
PS31, Line 2473: multi_check_dest_ad=
dr_allowed(struct multi_context *m, struct multi_instance *mi, struct mrout=
e_addr *real);
> Re-opening=2E
Done


File src/openvpn/sid_hash=2Eh:

https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/6d20232e_2d865ebb?usp=3D=
email :
PS31, Line 25: #include "session_id=2Eh"
> Re-opening=2E
Done


htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/1e942f9b_24f9fe27?usp=
=3Demail :
PS31, Line 31: multi_hash_sid_add(struct multi_context *m, struc=
t session_id *sid,
> Re-opening=2E
Done



-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Cha=
nge-Number: 1727
Gerrit-PatchSet: 32
Gerrit-Owner: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 08 Oct 2026 10:08:25 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Anton=
io Quartulli <antonio@mandelbit=2Ecom>

--c7XRb8vTs2M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Anton=
io Quartulli has posted comments on this change by Arne Schwabe=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View =
Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1727/comment/cbfcdce3_fea008f2?usp=3Demail">Patch Set #31:</a> =
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File doc/man-sections/advanced-options=
=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/8059fadd_cd066173?usp=3D=
email">Patch Set #31, Line 40:</a> <code style=3D"font-family:monospace,mon=
ospace">  By default, all three tables are sized at 4 times ``--max-clients=
`` buckets=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">Re-opening=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mt=
cp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/246e24e6_0b69bf03?usp=3D=
email">Patch Set #31, Line 63:</a> <code style=3D"font-family:monospace,mon=
ospace">                &quot;MULTI TCP: new incoming client address matche=
s existing client address -- new client takes precedence&quot;);</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1727/comment/49849e80_ea8cbe5f?usp=3Demail">Patch Set #31, Lin=
e 329:</a> <code style=3D"font-family:monospace,monospace">    /* Copy buff=
er, to a tmp buffer, so that reading the sesison does not</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Re-opening=2E</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727/comment/006e7d24_aa19b0f9?usp=3Demail">Patch Set #31, Line 437:=
</a> <code style=3D"font-family:monospace,monospace">        if (mi-&gt;con=
text=2Ec2=2Etls_multi)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Re-opening=2E</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/909f4428_7c0b0654?usp=3Demail">Patch Set #31, Line 2473:</a> <cod=
e style=3D"font-family:monospace,monospace">multi_check_dest_addr_allowed(s=
truct multi_context *m, struct multi_instance *mi, struct mroute_addr *real=
);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Re-opening=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/sid_hash=2Eh:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/6d20232e_2d865ebb?usp=3Demail">P=
atch Set #31, Line 25:</a> <code style=3D"font-family:monospace,monospace">=
#include &quot;session_id=2Eh&quot;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Re-opening=2E</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727/comment/1e942f9b_24f9fe27?usp=3Demail">Patch Set #31, Line 3=
1:</a> <code style=3D"font-family:monospace,monospace">multi_hash_sid_add(s=
truct multi_context *m, struct session_id *sid,</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Re-op=
ening=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change=
 1727</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 32 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 08 Oct 2026 10:08:25 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--c7XRb8vTs2M=--


--===============6049034255455116243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6049034255455116243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6049034255455116243==--


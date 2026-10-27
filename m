Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D58606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hXiUA3qi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ISilFPQW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cTuzgv+d;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P8ktm47O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IH5j3TlKRVgr3ToGYbipX40sFTAd5dGREBOG7OwPuSs=; b=hXiUA3qi8SHfv7072sm8KVZVG3
	xDtdxbPLiObU5L8fBVeLDXYZq10eYTyidPOmHBDr/OvLHXTRf8LtqXpvnwK59ba1ZgV3DYtqI0Sda
	Uz2qdDIUStqp0eK+01PRxbHe+GB/199Q/q3ybdoVngeAJFuH2cCBfwBHjpLWej9mGP1E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLfZY-000000000s7-3vcB;
	Tue, 27 Oct 2026 11:42:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLfZX-000000000s1-2fsk
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jH+6w5Rril0cKwzGPBlhPDKi3u8ANGCULHfLUOYK36U=; b=ISilFPQWwkAxP4EXn47VQulyoq
 TgSJIcTzd0uEWhy6RYXW+J0zQ0zQ9zpSjCVoRrDYTzvNZSarkFN2vnvwhxbScmOFkXI5oKNqEiXYU
 Gn8PDGJxNDvMvoz6LiaWrBYtDRAemudue81qu5sXcHxLy7Tw7NI5hPdKuUql0GREG/gc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jH+6w5Rril0cKwzGPBlhPDKi3u8ANGCULHfLUOYK36U=; b=cTuzgv+d076RjIl3rtQBvY4fLa
 QD14TWtH91CiWqMPgsSkJFMGx0pN9QHnwAh/blh8KRufVdXy914DusdJ7aAyW/t0vjqRtdg5NWEwT
 aK4AlCucqZPel/m+GuVv1g+Xtm0V7ks1x1O5p6295xViaD92X8/bXa7s9UcEmNXs0s5g=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLfZU-000000004uz-1xXD for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:42:31 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso16198535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793101342; x=1793706142; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jH+6w5Rril0cKwzGPBlhPDKi3u8ANGCULHfLUOYK36U=;
 b=P8ktm47OchDHs01VP6MI94o0W6aoDA2o9X5WmOZDoc2nY8rTba1EHPzT3Rn9DTdMJh
 DdWHhJ4Sd84uZygQYVyTcKr9iclTHvTKo+O6NcZ0P/Zq8FeMthU7g2z5hq3Q5G2UZjud
 JCV8LQkN7KInmqSTgkn/3fjWjr2+6EI0tmsKSyiSI5LldugVqu9NVzN33SW6/jnIfJSE
 OyuZ8fFdxDlg8+GrYoLcBHvY1AhfgTNb5OPgJifwsGl08cIwjuhdvXHKIPOqcnNkKeQj
 4kx1e0A9UUrTBUbM4GwJQjVg2YvLAHocHK/vou4jRoEcUsGflEvkf1uuW3fDTzmn4VQ3
 X9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101342; x=1793706142;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jH+6w5Rril0cKwzGPBlhPDKi3u8ANGCULHfLUOYK36U=;
 b=iTYoeG/O8Ky0P9vrqpRcB95Q2z7/MbtkyW/o1YcAU9XCGcrwSWeHuTEAyhY9wXRRRn
 3GshIhO9UDeFvlWvrV1hxJW3tbgXoBVaTqqZazWfUMLJIx+UcWf0y0K/UebSn9ToAz/S
 0/v/ics+KUMu3CSoZwhwqGaRD38pWYVwO8X0fOUTcHwCxm1YUYaQ6BYnyKtFF7vrvXjp
 GGHkToZ6to1mwC5PsG8ZP/7LYnCB8cnKcrZMDoZXabKNFhgyW1r3uBkp+O1G7fd3t3l/
 lk7BtxD2lyQKM4CqF3gcxOn9rL5mLEpClhC7WpORmUIX2sFfm4XKKNlcPviz+jgeB45k
 Whlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJgegrF/fAqGU+4jG6aY/NNSJThj7vxtX6OaLlasNkx9ZwyKJemA15etE9pT1DOrWY94MipM31bGb2B2jA@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJQ70zuQ1vSYcaAROqyWZozpjStYldSvIzHfu9xJHUaMSgnd4eM
 THVvsWNSc+suU0WSBApQLyUihXikV2H9+VTYXBSY2pB8hX0Qfm8PNY3ULSlYC8T7VN17jkKZwNz
 xTo4CwGzCiG/VMnp+jBbOt6ngjhX30LrPpgK1EFbWfH0hte81zb8jd0BK+2+zpWQ+WijG
X-Gm-Gg: AYBFou3PFq1qhFKxmttRUVOiMxJ+8nvh2dMvgnAhf0xNBRV9fEB6YTo9ODH1KUMdJo9
 4LUIG3U9RJGTE29dLij4/RbVkb5HnsrfPVYESeR7hC0UuhOmwMnhzo7lu5uneXlk8zPzW+PUIIL
 S8ibjHC6ODAEcunz+Z3nSp9HhY8l/YSxD7oMZW8Z/YWjQayyGs9c5suvQz3/iuHshjPbXdU28TL
 MgLx5q5Yjfmo/bUJ92AwM7yiVIAj3Lz2ekPVwENUmffQ7uRwGlinSPk2bRGn7a95tpmMRB23TMM
 Zj/+XjBjTPh+bexflizbGTwUOQTKSOcL3PdJQxLIJFj6FqVo+5oyrtlfd+E/9s2oCW/41OE9AMI
 qpXA/KSATu+czsdVRKxNJeUWFloyw9wKdEkKCFdK5L1W7mYI3CLim3n5/eC2p63dZEQOWge0PBd
 wjOie/5IQL9k72ETdBRNR1kxi06LMhY5GsMjMOeKIqAYm2TDjnIH8gEC+E6b8836FEXGqfKza2a
 oa+D4Btt07LMAvx7qP91y92/ZqbXz31Nl1LF+o9M5gAZ3cNK0qW11v2JupbIKnGN6kw2vwsXcVm
 qE5DyeqjYIbT/EkbkSMVeL68dwq5jPeh9X/qbyzolfy3YHHHZZeTZ8ZBjwpummAtFIc2sKvKy82
 V495f2u1RpdMD+JhE+6IIDPNry19Ym0BMHlcC0w5JptToWOfhuveEvk2SXmNz2Qs=
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4a642ccc70emr102435825e9.11.1793101341683; 
 Tue, 27 Oct 2026 04:42:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbc718sm220627115e9.2.2026.10.27.04.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:42:21 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:42:18 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d
X-Gerrit-Change-Number: 2052
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2052?usp=email>
X-Gerrit-Commit: 7c3b3c27e2814443ff37e0e87102a0f148ec71ee
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:42:18 +0000
In-Reply-To: <gerrit.1793096063000.I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d@gerrit.openvpn.net>
References: <gerrit.1793096063000.I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLkkyZmQ3ZDk3M2JlOWExZWI5MGVhMjAxYjIyNzhiZTczZTZlZTZmMjdkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ac9bf35867b928f977e7b89a29f5bef201d979c7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLfZU-000000004uz-1xXD
Subject: [Openvpn-devel] [L] Change in openvpn[master]: transport: introduce
 transport API plugin codebase
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8541864157528807007=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8541864157528807007==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P74gxASpfhU="; charset=UTF-8

--P74gxASpfhU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Frank Lichtenheld has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052?usp=3Demail )

Cha=
nge subject: transport: introduce transport API plugin codebase
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew-1

(10 comments)

Patchset:

PS1: 
Shows its age in some parts


File i=
nclude/openvpn-transport=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
052/comment/3409bc85_10981516?usp=3Demail :
PS1, Line 18:  *  59 Temple Pla=
ce, Suite 330, Boston, MA  02111-1307  USA
Old header


File src/openvpn/so=
cket_util=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/975=
071b0_515cab34?usp=3Demail :
PS1, Line 143: #ifdef ENABLE_PLUGIN
Do we real=
ly need to ifdef out everything? Can't we just define PROTO_INDIRECT always=
?


File src/openvpn/transport=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2052/comment/4ed03f1b_e26dfaa0?usp=3Demail :
PS1, Line 18:  *  59 Temp=
le Place, Suite 330, Boston, MA  02111-1307  USA
Old header


https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/ea289a71_b9abc2e7?usp=3Demail :
=
PS1, Line 30: i
Comments should use doxygen format


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2052/comment/ac5b9636_9aab62d7?usp=3Demail :
PS1, Line=
 66: unsigned transport_update_event(openvpn_transport_socket_t vsocket,
Al=
l functions should have documentation


File src/openvpn/transport=2Ec:

ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/0bf0046b_1da80568?usp=
=3Demail :
PS1, Line 18:  *  59 Temple Place, Suite 330, Boston, MA  02111-=
1307  USA
Old header


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/comm=
ent/be337f9f_6fd5e74a?usp=3Demail :
PS1, Line 25: #include "config-msvc=2Eh=
"
Does not exist anymore


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/=
comment/7d641313_d5c69b02?usp=3Demail :
PS1, Line 200: translate_rwflags_in=
(unsigned vrwflags)
We generally use "unsigned int"


https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2052/comment/da9677c6_d1694031?usp=3Demail :
PS1, Lin=
e 238: encapsulated_event_set_set_event(openvpn_transport_event_set_handle_=
t handle,
static functions should be documented as well



-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee=
6f27d
Gerrit-Change-Number: 2052
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco=
 De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: =
Tue, 27 Oct 2026 11:42:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
Yes

--P74gxASpfhU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052?usp=3Dem=
ail">View Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2052?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> <=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Shows its age in some parts</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File include/openvpn-transport=2Eh:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2052/comment/3409bc85_10981516?usp=3Demail">Patch Set #1, Line 18:</a=
> <code style=3D"font-family:monospace,monospace"> *  59 Temple Place, Suit=
e 330, Boston, MA  02111-1307  USA</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Old header</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket_util=2Eh:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/975071b0_515cab34?usp=3Demail">Pa=
tch Set #1, Line 143:</a> <code style=3D"font-family:monospace,monospace">#=
ifdef ENABLE_PLUGIN</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Do we really need to ifdef out everything? C=
an&#39;t we just define PROTO_INDIRECT always?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/transport=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2052/comment/4ed03f1b_e26dfaa0?usp=3Demail">Patch Set #1=
, Line 18:</a> <code style=3D"font-family:monospace,monospace"> *  59 Templ=
e Place, Suite 330, Boston, MA  02111-1307  USA</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Old header</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/e=
a289a71_b9abc2e7?usp=3Demail">Patch Set #1, Line 30:</a> <code style=3D"fon=
t-family:monospace,monospace">i</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Comments should use doxygen form=
at</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/c=
omment/ac5b9636_9aab62d7?usp=3Demail">Patch Set #1, Line 66:</a> <code styl=
e=3D"font-family:monospace,monospace">unsigned transport_update_event(openv=
pn_transport_socket_t vsocket,</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">All functions should have documen=
tation</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/transport=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/0bf0046b_1=
da80568?usp=3Demail">Patch Set #1, Line 18:</a> <code style=3D"font-family:=
monospace,monospace"> *  59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Old header</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2052/comment/be337f9f_6fd5e74a?usp=3Demail">Patch Set #1=
, Line 25:</a> <code style=3D"font-family:monospace,monospace">#include &qu=
ot;config-msvc=2Eh&quot;</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Does not exist anymore</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/7d641313_d5c=
69b02?usp=3Demail">Patch Set #1, Line 200:</a> <code style=3D"font-family:m=
onospace,monospace">translate_rwflags_in(unsigned vrwflags)</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We g=
enerally use &quot;unsigned int&quot;</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2052/comment/da9677c6_d1694031?usp=3Demail">Pa=
tch Set #1, Line 238:</a> <code style=3D"font-family:monospace,monospace">e=
ncapsulated_event_set_set_event(openvpn_transport_event_set_handle_t handle=
,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">static functions should be documented as well</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2052?usp=3Demail">change 2052</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2052?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I2fd7d973be9a1eb90ea201b2278be73e6ee6f27d </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2052 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 11:42:1=
8 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--P74gxASpfhU=--


--===============8541864157528807007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8541864157528807007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8541864157528807007==--


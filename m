Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764BFC61DD9
	for <openvpn-devel@archiver.kernel.org>; Sat, 29 Aug 2026 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hq4Bk5B0t/ceuRD722IUpvBu5x/RdteKkLPluM/d0oQ=; b=dlfutKJjKlXZRYjNe3CkSlqehE
	TmU9izl9yvSDuOM3uucevX4pmKcBYZog5iAgv7qBe0hf5acRQIX5Uo4QWQ+q01yu5/vdGihN8LCQG
	j50Dey3Cy19SH8YTx8EeOcQEXHeGGDLLMafmuYtZl3kG9xTe4fn9x7SaJd+BSB4NnxTw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0JvI-0006ou-Bo;
	Sat, 29 Aug 2026 14:20:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0Juh-0006oU-Sa
 for openvpn-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 14:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rvfmVHHWntjDfX578HBjduMCVMPKM3BfRQCvAAYjQpw=; b=SKfFTzj+Y1CdMKPj50XgdOSC2M
 oe6ozlTUpbl+dHXHr5st5Z6a8WZhj6fkdp4CKh7grKjKPvhYakxxWi9MB3iRmfqgWB6eKTBXh0eGR
 lSqnudoaBVB+oT62zjdrOoVDDE80lkzLyCuBtqKQr6u0ApTdxJ9UIQTArNrLNiYDr6SQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rvfmVHHWntjDfX578HBjduMCVMPKM3BfRQCvAAYjQpw=; b=H
 cvZMvSRpPJ40Vq6bI6kEURp997GHDjaCx3kAi1+S9bzSOwO/5XaX/Jmz45MbTRqRHDsr0AH25jqYn
 wK2O+DUc+S0fO2Jd+fWgWK+egi9P/wPwnMklAHV+EQiXZuXWN9MGicSDHwua3kttX3Xo69P9gH2g2
 Xrk+fGE+jzzUqlnM=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0Jug-0006p5-Ou for openvpn-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 14:20:07 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-482e2fdf5abso879632f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788013200; x=1788618000; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rvfmVHHWntjDfX578HBjduMCVMPKM3BfRQCvAAYjQpw=;
 b=f0HIzQLH6y+SxnsDe0qib+TyTKDXSCplxFiaq/lJTksLXc1TbCaDZiHMi8epSLeAa3
 eI/X37B5YY8NY69iS1g3/JIU1kYtjh48/jMk2KEGo00/UI1wefRRrhpOGnx3COxDT4j9
 UdXbbXVEsEeKfFlyIuq5UNMQJ87fReqENiREn2GcY66mP63IN4OsxSUQTpdrVzf0Gh3h
 BIQPA33T6qUWF9up8qE59bYCPtIGd5XJ2vWKKdlyJCsJR5CHDGDS0KTRMgWtlWjKWvaG
 OlxwWCHTGuvDlz4ZP3hIR7foJjMMAPU4kTlHTYcsEmNEyBJXoRtuJHJ5MP8rb97SfR1i
 rsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788013200; x=1788618000;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rvfmVHHWntjDfX578HBjduMCVMPKM3BfRQCvAAYjQpw=;
 b=GgaBJxU0b0sheQ67Ei3fg1E3hFoZ9PtQ922M7L1B53sDO9LA/dMxfEsXVQvIbgzPgg
 gp/3gcL4rlJw8tLBdoMhpuqxgFsf4/d2oqxGZkd9abjyfXPMqij/ay8tE8RbL6U2y400
 GOvFP5hTKWyFFhiKKyu0t8AmKhCwmXVGDBjVAayX1xDLK/zk6RvxmbOdUMlFLANBdNV8
 lZs2GbHVxB9/znZNtRUAAVWIMIy4Y286k8Y0jCkqSCnUCol3nP9I5HX6Hz399YEBDHDa
 01k5X4ig9ktHE9LkKr0Qj/U1SycYWoUqN/vwdmrydmvBtvvm5cXmrIGvcN1FHqI8w2km
 qZCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwa9wmafWPE93qJ1d3ouXajX5Ay3mt1QEwTc00ibB6WmODGpIHE40SWWDl8aykpRxzRTMm2GiC8IHXiXlFi@lists.sourceforge.net
X-Gm-Message-State: AFuF++mGVgyaqYkldvEpssVhGYnY5bDQR77UESsG9+5UODMapIby0dGx
 mFalxLukxdTkgpganLj410XkeZwbz+2t58RhUKm6W+5PZjaDwRl8xOlZb6xhvMlPSZUbZng7YhS
 c+wbgFY/tKbZokAYwFc9aP3IXBbRsTGxMm3Olyhlp0+Gfz6MpatY8Ajvk5QFBZvclv58w
X-Gm-Gg: AYBFou2y0finmiaLV40sG+MPMH0Jd7JGDk/ZKdouwGh3rpzYjzjghuX+G41vDQBFKZO
 +yXovTI5l0lTRupNljieAAX7dKpXubQEz9kIjFmmf2KRPCswtlblgpvBwf3lz3vGvfHumFDGpP8
 Yqsxp1q2wIF7gBwKUJFIn1VtzY6KcJXZgHwKiXffodArKeyWqGatgu0b9+Fqkml9PhEopRy+IvO
 1rLWTYzW2d0wG1itsKjjbXyus/Q/TS/ZLVZO73L8P5zoFNE8W1kOdjGCc2oV5sQo6VInuWbhS4a
 OAidi5THgTYyPZ+NVZg8nx6atCwvFGkw+6seV80oprFnXTLoD4nVKXtivbOt320L0Frt9pPq6kd
 hrIivBK9pZmsr9KdCqMba6fOxgPZJjC9k8QfJebRqubASNeDKtIhjskGiagDMvQ99i/iBEjtbAV
 OX1lIJzQvCwvFbfS6UE+5Yybv7Fn7Rc2loR9EOUfZXssa3waR/FMGueceQ6NyCUYHAUUAr2aNeP
 nNDsEahCqUzPjoU1nGqoyIndOpItgiCRnlwC9A/Bi3gtA/hCNZf5Z77nf2Vhuf6VpCuRP7AUAxg
 b1DD4S5b4kLIRAHgtj5V9Lj5oJbaflUpMsr9gpu9ZbezmgXgmKc=
X-Received: by 2002:a05:6000:186e:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-482fd9c384dmr16504093f8f.22.1788013199937; 
 Sat, 29 Aug 2026 07:19:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm11121291f8f.1.2026.08.29.07.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 07:19:59 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 29 Aug 2026 14:19:58 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: af724b68aea7ad161492da8aad1cd8a5ff456bd5
X-Gerrit-Comment-Date: Sat, 29 Aug 2026 14:19:58 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a9818a68d9a9f67d041bc61bc096dc0687aaa2f0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0Jug-0006p5-Ou
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, david@srkyn.com,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3574111134943994992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3574111134943994992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dm3yoKITf7Q="; charset=UTF-8

--Dm3yoKITf7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, srkyn=2E

razvanc has post=
ed comments on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1881?usp=3Demail )

Change subject: compat: close all unrelated fds=
 in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2:

(5 comments)

File CMakeLists=2Etxt:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/3ffd533d_2460ca4e?usp=3Demail :
P=
S2, Line 699:             )
This makes it look as if test_close_fds is some=
how related to test_cryptoapi=2E Might be clearer to just put it under a se=
parate `if (NOT WIN32)` block=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1881/comment/4823d90e_d2c1c613?usp=3Demail :
PS2, Line 852:             t=
ests/unit_tests/openvpn/mock_get_random=2Ec
Do you need `mock_get_random=2E=
c` here? The Automake version doesn't add it and it seems fine=2E


File sr=
c/compat/close-fds=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/com=
ment/ac18c82a_b964a594?usp=3Demail :
PS2, Line 39: #ifdef HAVE_CLOSE_RANGE
=
I could be wrong (maybe I missed something subtle), but AFAICT this path ca=
n never be exercised under the CMake build=2E


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1881/comment/3da10afb_ecf791a5?usp=3Demail :
PS2, Line 42:  =
       const int lower_closed =3D keep =3D=3D 3 || close_range(3, (unsigned=
 int)keep - 1, 0) =3D=3D 0;
This should probably be `bool` instead=2E


Fil=
e tests/unit_tests/openvpn/Makefile=2Eam:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1881/comment/39623fc0_62c1a8bd?usp=3Demail :
PS2, Line 52: close_=
fds_testdriver_CFLAGS =3D -I$(top_srcdir)/src/compat @TEST_CFLAGS@
This is =
the only testdriver whose CFLAGS omit `-I$(top_srcdir)/src/openvpn`=2E That=
 breaks the mbedTLS build=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-Number: =
1881
Gerrit-PatchSet: 2
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: srkyn <david@srkyn=2Ecom>
Gerrit-Comment-Date: Sat, 29 Aug 2026 =
14:19:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Dm3yoKITf7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, srkyn=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>5 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/=
comment/3ffd533d_2460ca4e?usp=3Demail">Patch Set #2, Line 699:</a> <code st=
yle=3D"font-family:monospace,monospace">            )</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This makes=
 it look as if test_close_fds is somehow related to test_cryptoapi=2E Might=
 be clearer to just put it under a separate `if (NOT WIN32)` block=2E</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/48=
23d90e_d2c1c613?usp=3Demail">Patch Set #2, Line 852:</a> <code style=3D"fon=
t-family:monospace,monospace">            tests/unit_tests/openvpn/mock_get=
_random=2Ec</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Do you need `mock_get_random=2Ec` here? The Automake=
 version doesn&#39;t add it and it seems fine=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/compat/close-fds=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881/comment/ac18c82a_b964a594?usp=3Demail">Patch Set #2=
, Line 39:</a> <code style=3D"font-family:monospace,monospace">#ifdef HAVE_=
CLOSE_RANGE</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">I could be wrong (maybe I missed something subtle), =
but AFAICT this path can never be exercised under the CMake build=2E</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/3da=
10afb_ecf791a5?usp=3Demail">Patch Set #2, Line 42:</a> <code style=3D"font-=
family:monospace,monospace">        const int lower_closed =3D keep =3D=3D =
3 || close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This sh=
ould probably be `bool` instead=2E</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881/comment/39623fc0_62c1a8bd?usp=3Demail">Patch Set #2=
, Line 52:</a> <code style=3D"font-family:monospace,monospace">close_fds_te=
stdriver_CFLAGS =3D -I$(top_srcdir)/src/compat @TEST_CFLAGS@</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thi=
s is the only testdriver whose CFLAGS omit `-I$(top_srcdir)/src/openvpn`=2E=
 That breaks the mbedTLS build=2E</p></li></ul></li></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">chan=
ge 1881</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt;=
david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Sat, 29 Aug 2026 14:19:58 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--Dm3yoKITf7Q=--


--===============3574111134943994992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3574111134943994992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3574111134943994992==--


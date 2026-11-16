Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCC606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OzhsxQ6C;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rg+Bkp8j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jicfEtQk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GrAev0AM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3mUgXlc0Qy42+6kdpH+MgqG+vApZK24bMJQZUEkLCqs=; b=OzhsxQ6CIQthZxSi2OhznAUQ1t
	7wRnKFHMyWmvJHlfBfku16EKAt1hHBrrSgwg4tWwz3VfduW0fytckMzh+OkihXiGwLKgpwYi5/W1e
	FcksN4pHVYteI09C4lbkjYj4os2LvczzoZiIE3NNFIO8nsqPz+VYlPZdd48eWX8Dn0uw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSw28-000000007u4-3TUw;
	Mon, 16 Nov 2026 12:42:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSw28-000000007ty-0srM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yZtPBXmFZZP4UaG2riPq8dEUeVZh54N441Jw6kNjxk8=; b=Rg+Bkp8jPJQxh6hLuYy0wWnBYf
 gkAMz0C0kh/XnD/zS0cthitMFm0bBX5hkErME97rbI/BaVW00SFz0kWUrJ9McK9CKVI6tRkDgKdjY
 UF/VJQ42X3EdSYxtSiRizs4Z7bPykEMz2soDnQdk8gzVeJxltPyOlqMxoB2l6N0x43/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yZtPBXmFZZP4UaG2riPq8dEUeVZh54N441Jw6kNjxk8=; b=jicfEtQktQq24+yQoMenKxqBFj
 gJ+0DYem2JDsH3Q44vh4NFDNY++pO3DPs7WAgIZHIHZBvvpFw0qJLPypKcyW0T3o2anK3OFEqsB16
 NVpV4V1S1o8sQNP7c+ebUgdG2iWk8X/K6uDEuQ7dcGTVq/cXvHEGwtBwoynFUf/RBets=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSw24-000000003pz-1F2h for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:42:04 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1812880f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794832914; x=1795437714; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yZtPBXmFZZP4UaG2riPq8dEUeVZh54N441Jw6kNjxk8=;
 b=GrAev0AM5hZg7PxMM/Gp3sXfNQ4PF2KR3Elw90sWK3CEiOlSg/Uc6eEvfocxJiQVmt
 2Ld9y6UPi6OeIjir/eI9E2f+YMEd50vQWuPKUcd78ruACIPI6lz9YsTv54XE8rg23SNz
 rq6+8G89byo2MgP3dzym3/CNgJG9Cq4c0zA0cZEce0sp6VBWTMb0sL0hmvpjljgttln4
 ecYpjsIe4exjrDgiKzoVCeVDudvJYdY6rf0tZNLZvth8N91/t4i4ct0x2D2M+LidUfc8
 hKLJhnXq/7tDxQUkGBHgOhyEseK4EDJW6kXSWwy8/A/vKtBVm8uAgLUfJDIJJ2ZFtDsL
 PM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794832914; x=1795437714;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yZtPBXmFZZP4UaG2riPq8dEUeVZh54N441Jw6kNjxk8=;
 b=efeTvQn5h4v+9gHyULBjSJ0xjAd3C3tdthUt4+CJhSg3DdH1QG9Eqs2kXH0kt5e8Mq
 rumcFNBJwuxn3da4PhYCZs1faplmNbuzOpsvey31uOPE+JuGbqn+JVUSGbbBU2UEjgJ3
 gblD0Q5x4N9lCw5syWriUEnY3K9jH8nL7UgGxdp+K9hpsRTm0lYMb0vVHF2b/FfBHEIB
 l8+n9ya8Wi6/X4+dEycgdqFlj4XqnpvMvkxUS9xT1hT7npg2oeRfIGWsBJR+zikGvPLy
 DOJUfZtiLEGPs85VJcu5hIwEw2FsvhWtbJNGOEsglmV6fSmve873uo+KwPEB1+IGipFD
 oo6A==
X-Gm-Message-State: APuU4Z/AfMvJjFqYwuoQb1fKYbUXfBaaPc64UWX5G0ILDm1V5IWnpfPK
 IXFP1MUl1EYPK5DgKg4sfptaOrpGMcd4IXoCpNNZps3Wzw6x78oPB25tdof9pYKvTRYsa9eNFGG
 Zfy7+PJMTqjDnEgSVkUFvKoSxaF328f//QIOpVXSFt9VtMC0VNtGsHIttO7kvddTycLD4dmG6CA
 kBevnttA==
X-Gm-Gg: AZFdTZdmh/mN9hYRNslqdYqscr9RyjgcUdQbU1XRahw+WeAapnowkqSkO6NST/CwFeF
 DiehfvMz1r0yyPUeWgVJBeFfgpN0IgowePl2K6wDJyTVfzPzZf5MYdasWkHFJFLGH7c1MSycXTO
 1MgYrHQyaBYjyUYa/3VMOT0bFiyC5piQ+GaipOB2odXdhoOOnScreSPB1YAyNBoikrN/fQHgH25
 VO22vNxQBhXYjFjuWE2Uu/of/e7z1O6GlOI+LW5rcr71QFACVVmyvCS47CE8t503n/MmiUf8Cu5
 /gbUxlDIeYWFE6tpXZMnCauWoCbRHkcSXd2CbyzKociOHdJTm5KdqVt4nlNPNjpHosRUnMa4TY3
 9KuWq28lIlMic1d9t4HZV9yPvB5ddryQsO4gxmi9o4K4T2IVBwzMfbtJiYdWzSVRQUM4Rps4For
 wSN2BElQF+/FjAfz88u7ksEbERlC2CERuaINT065H1RFgAlRTcyi8LyvgAGx67NP4lTCv+kvHLP
 1HL1VNi3EhJlBR9/H1Cgi1kK3p00hx3wOkzFfbPr2uEQGR/w+n6vI+PqkcXJg9Fsy5tRnA+Up4R
 t1/Ej6YhDbNpMCy7XDpYQeN6BPlyT/BTTl83RM3AsymC3jIUHwIgxPBkMlaLrm7wihbjlO/Dxps
 bFM5BVrLPoFVABPpolQc4ivihk6AdxSb6uNdI0aWhnAahdRfXr6+LjVeoXC0nzTezuEh9FcsL3m
 CiErdWRmEebrWmipU=
X-Received: by 2002:a5d:59c2:0:b0:48c:4f6f:62e3 with SMTP id
 ffacd0b85a97d-49c70ed9397mr23663052f8f.18.1794832913498; 
 Mon, 16 Nov 2026 04:41:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm24455493f8f.11.2026.11.16.04.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:41:53 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:41:52 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
X-Gerrit-Change-Number: 2193
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2193?usp=email>
X-Gerrit-Commit: ed299147a61cba4f6055da955c847588632b625c
References: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkk2MDc5ZjQ1NGU1YmIxY2U3YzRlY2M1MzQzY2UyMjMxYzQxN2NhODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5031b8db3548b9051c33a6523f62137f8d716e22-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSw24-000000003pz-1F2h
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Disable
 -Werror for MinGW 32bit
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
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5701177039721648694=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5701177039721648694==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S5obaFRWu24="; charset=UTF-8

--S5obaFRWu24=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2193?usp=3Demail

to review the following change=2E
=


Change subject: GHA: Disable -Werror for MinGW 32bit
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Disable -Werror for MinGW =
32bit

There are some build failures related to -Wsign-conversion
now that =
look like clear bugs in MinGW=2E Since we do not plan
to support 32bit Wind=
ows going forward, let's not worry too
much about compiler warnings anymore=
=2E We will still detect if
we break the build completely, for now=2E

Whil=
e investigating the issue, remove a wrong comment=2E With
-Wsign-conversion=
, all builds need the casts=2E

Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231=
c417ca879
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =
=2Egithub/workflows/build=2Eyaml
M src/openvpn/auth_token=2Ec
2 files chang=
ed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/93/2193/1

diff --git a/=2Egithub/workflows/b=
uild=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index 27f08df=2E=2Ed50b7ff 1=
00644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/buil=
d=2Eyaml
@@ -81,6 +81,10 @@
         arch: [x86, x64]
         build: [Rele=
ase, Debug]
 
+        include:
+         - arch: x86
+           configure=
-args: "['-DUSE_WERROR=3DOFF']"
+
     name: "gcc-mingw - ${{ matrix=2Earch=
 }} - ${{ matrix=2Ebuild }} - OSSL"
     runs-on: ubuntu-26=2E04
     env:
=
@@ -113,6 +117,7 @@
         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516=
d8d572297e03a956 # v10=2E9
         with:
           configurePreset: mingw=
-${{ matrix=2Earch }}
+          configurePresetAdditionalArgs: ${{ matrix=
=2Econfigure-args }}
           buildPreset: mingw-${{ matrix=2Earch }}
   =
        buildPresetAdditionalArgs: "['--config ${{ matrix=2Ebuild }}']"
 
d=
iff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index 7=
03a0b2=2E=2E261c7c2 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openv=
pn/auth_token=2Ec
@@ -364,7 +364,6 @@
 
     /* Accept session tokens only =
if their timestamp is in the acceptable range
      * for renegotiations=2E=

-     * Cast is required for systems with 32bit time_t, e=2Eg=2E Windows x=
86=2E
      */
     const time_t token_reneg_deadline =3D (time_t)timestamp=
 + 2 * session->opt->auth_token_renewal;
     bool in_renegotiation_time =
=3D now >=3D (time_t)timestamp && now < token_reneg_deadline;

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce22=
31c417ca879
Gerrit-Change-Number: 2193
Gerrit-PatchSet: 1
Gerrit-Owner: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--S5obaFRWu24=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">GHA: Disable -Werror for MinGW 32bit<br><br>There are some=
 build failures related to -Wsign-conversion<br>now that look like clear bu=
gs in MinGW=2E Since we do not plan<br>to support 32bit Windows going forwa=
rd, let&#39;s not worry too<br>much about compiler warnings anymore=2E We w=
ill still detect if<br>we break the build completely, for now=2E<br><br>Whi=
le investigating the issue, remove a wrong comment=2E With<br>-Wsign-conver=
sion, all builds need the casts=2E<br><br>Change-Id: I6079f454e5bb1ce7c4ecc=
5343ce2231c417ca879<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M src/openvpn/=
auth_token=2Ec<br>2 files changed, 5 insertions(+), 1 deletion(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/93/2193/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=
=2Egithub/workflows/build=2Eyaml</span><br><span>index 27f08df=2E=2Ed50b7ff=
 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><s=
pan>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -81,6 +81,10 =
@@</span><br><span>         arch: [x86, x64]</span><br><span>         build=
: [Release, Debug]</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        include:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         - arch: x86</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+           configure-args: &quot;[&#39;-DUSE_WERROR=3DOFF&#3=
9;]&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     name: &quot;gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebui=
ld }} - OSSL&quot;</span><br><span>     runs-on: ubuntu-26=2E04</span><br><=
span>     env:</span><br><span>@@ -113,6 +117,7 @@</span><br><span>        =
 uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9</=
span><br><span>         with:</span><br><span>           configurePreset: m=
ingw-${{ matrix=2Earch }}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          configurePresetAdditionalArgs: ${{ matrix=2Econfigure-args =
}}</span><br><span>           buildPreset: mingw-${{ matrix=2Earch }}</span=
><br><span>           buildPresetAdditionalArgs: &quot;[&#39;--config ${{ m=
atrix=2Ebuild }}&#39;]&quot;</span><br><span> </span><br><span>diff --git a=
/src/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>in=
dex 703a0b2=2E=2E261c7c2 100644</span><br><span>--- a/src/openvpn/auth_toke=
n=2Ec</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -=
364,7 +364,6 @@</span><br><span> </span><br><span>     /* Accept session to=
kens only if their timestamp is in the acceptable range</span><br><span>   =
   * for renegotiations=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * Cast is required for systems with 32bit time_t, e=2Eg=2E Window=
s x86=2E</span><br><span>      */</span><br><span>     const time_t token_r=
eneg_deadline =3D (time_t)timestamp + 2 * session-&gt;opt-&gt;auth_token_re=
newal;</span><br><span>     bool in_renegotiation_time =3D now &gt;=3D (tim=
e_t)timestamp &amp;&amp; now &lt; token_reneg_deadline;</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?u=
sp=3Demail">change 2193</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2193?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2193 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--S5obaFRWu24=--


--===============5701177039721648694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5701177039721648694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5701177039721648694==--


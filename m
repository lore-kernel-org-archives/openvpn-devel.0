Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D39606A325
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EmuuWziI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gOx1ymFL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gFfTa9PR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YvKye+Dm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m3gS16bPBOlx/3S5b1EmaRvEZT1/LwNX6NQsJjTvwZY=; b=EmuuWziII0vqfW8HpAj+C7CAcX
	A4rvF8ORhmgezk2dDlgjEAKPVJU6zhIqDnnmhHPmdq/PC0cPl9M6HmfrbtGFC3cFlcVunosRzDwKZ
	QbdZjwjGDp0369vwU9iKSIjUEKwmmT0Bxig3l3RdwObewaWsj0u/Z0XrFSrA5o5L3lqM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0Eo-0000000014K-0aAx;
	Thu, 19 Nov 2026 11:23:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0Ed-00000000146-48cR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:23:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G/EMSZXZLYSOcfPwyZCj91WrtpYDwd7nCtevyrIwqNY=; b=gOx1ymFL5pFED/7stFGQ1WpDQy
 3YVZPaZPqexqxMUKdqjA+hy+Y2fnsW7Hv+ByoKGrJNczFvEpo95WfmhSxZIV06kNpRhvPNgxtbrCt
 qx4zTsYStaxdJ069cpMjSylFeVEabPt+OvksCwYO1hC4EAOMq2q2QwU9/tY/w02H3PjA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G/EMSZXZLYSOcfPwyZCj91WrtpYDwd7nCtevyrIwqNY=; b=gFfTa9PR5ET7REYGDpML+VmKGN
 xclftwv5OtNl51PuMa3aJUD/WUqq9RVdBN3Mr38TBALeysiFUAH3ZT5YkpHmOGIDMI/+/Fzqj+AJ6
 LK+AqDXx4gKxVZnnieNqE8OD8mDRLRNZG+xK+J+z/Rhi867GDm3gQEPonvaGhUIjd6Ac=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0Ec-000000006ad-0yuj for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:23:23 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso29502935e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795087395; x=1795692195; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G/EMSZXZLYSOcfPwyZCj91WrtpYDwd7nCtevyrIwqNY=;
 b=YvKye+DmiVy723/F8+uwUTLdeCp4JL3ucbQ/MQ8YqmFzPbtzZx8oG4VYa0UebYr6PW
 SN6xTROnlmENoHZ9KGt3hUx5jsHp8AiM62wrnuIoKXhGzCf38XoNBXQoZjOESH1i0wmN
 kb9l+mN1HTb04B8UFi3E1YLcICCCI7SZGCZ7ERKl9l6lZz/0fsIoEUSR0G0b9Lxnsbvy
 bsT3veAu4JYMO4QwjSD3+Pv2eWrlxv7PxOiF3Zlp7fW/NTD574goyNsuuULs/vYmkMqz
 77Owf7+EDLg0h+JKE2FL8TOaXpOrSXhf7QV8enfRbix7Gl36CH2tlW133nEg8tJ6Uw/R
 v3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087396; x=1795692196;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G/EMSZXZLYSOcfPwyZCj91WrtpYDwd7nCtevyrIwqNY=;
 b=ZLNbG2czy8/NSvOi6MF6HFqyxzPxnGXlzcZQgyh9eocNZzbWxFwlyz0tzi3Xc2WVWm
 ak4ryalKD454zVbwx+SRQSDT2D7nn05KbqP1ma7zkQS6tlvIopyu7Pp22gIh+GLkEFuX
 YQuV7ADhPklYhp8PccX8p+GgtEqpSOmXybXB8TflVXrduHUqGzXyHk8uhnchApkKrmcl
 SnP90OIw4aAyPCWqCpamrrMSZAbOOsthZH+Z1xysrKePgJhqYbFGwLdTSrwJCSSTuaEj
 yl9jtcRXgteCggvnPJvrYDTD8Iw96FOoMo7gNqwxe5g+2Mu6FYESVZeZldGcIc+Zg3k0
 GbZA==
X-Forwarded-Encrypted: i=1;
 AL+hErHblfThaeDnbA25CVvQgFLW6lH+RoN9Dw9t0a4egHrlASqTlB3DAWLPh1PKnKZsOAndv/HhWOw528Xi3kcY@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+u8fSb2EYFMYKAdP70IwD9fVEVRWtLZTSRWcaKhNmmRpzK/x5j
 P3nJ7DZgASS7CUeHJT4cW98I7nVpZaSLU3PjdTpu3ns0Vw/0fsRvfQCRJTWD1A9GoRvU+cOkGlK
 JdCmBR08OBMOBnC1segGt/tz6a9mLeQMYblcVgJl+zfyr/d1tHaU+zhxTc537eyYBW1Hz
X-Gm-Gg: AYBFou2qwQUgKRfdEVMikkkGOfF9u5S/lSLgacYStYDh9HQlq4DouuW6oYx5caFjqHW
 Dptlh8v1ClT30W1K34ylsqxOJNcQaUB3mIiJnBfuRYERGtmM8OMy1l48BDrxX0oPBfAy4nMWPcB
 9XOSSqC4vN8Dm1nIc0lbecWM4F2YoxHPUB2PmJAnqdsOebdNZ0Bi1uCD7tmAPSdDoER3EXKVwSw
 ApPWQAClYz2+S3yhaEfpH1PEzDxiZvPibIxN99NKoHcIO9CDOJFT9xgb+qlN8NtjTHFMQl6NV6R
 QF8ufNFiOYv1wPR3tRSjonvsaAZhOIRtoy2/67Ve6xZrrW3MIEDniehCoKVL6Cpdo5SrUZ8Q5YX
 wNIpKN49bABcYWtQpLx0I4hEfoT+moCe4e4Or09PkmH9vDS7qsEvS+M0Qunv9CjYDdLlt7PRzro
 chxCox2rmCxFrTEQdmmg46zdRFBt7uzH0FIt+XhGN184qljHh4thraeZ6rICHxmn0MhZqll4ymg
 +4ydgohKyMkfw5j6/0V+gmxlgGAfqjyoHiGn/AsAnGszNCgx2Iq6FcKZfg4/9rkiO/fEpMY2+LX
 iEcarQsWiMF5yZrziNmeuxTbPjqTg9f2OoEi81R/PtF9+wQSeN2xo91qEpxs3bMAv9zHyn+Nye/
 txEqL+SYO2RoMBDLdzXPvVKEr8WgHbzWqu/tvmX7tpGG0CPH9I4CaZiRHQx03nkP0xUNZPCJhdh
 2iprZGlVYGn4qD8qi8ZgKXh/OaE4Os3IfDlW8y
X-Received: by 2002:a05:600c:45d4:b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4bb7d5d4ed2mr115129035e9.4.1795087393657; 
 Thu, 19 Nov 2026 03:23:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm30568965e9.14.2026.11.19.03.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:23:13 -0800 (PST)
X-Google-Original-From: "Aravind O R (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:23:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: eace777a91aea4065622707b07668aaed6b3883b
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:23:12 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <28f1505b94960d7378f5950d9f61ceea63ec19f6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xU0Ec-000000006ad-0yuj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Aravind O R \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Aravind O R \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8749323965036910167=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8749323965036910167==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gdg8So3sfUU="; charset=UTF-8

--Gdg8So3sfUU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ravind O R has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File configu=
re=2Eac:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213/comment/566cf8c9_=
ee5c3abb?usp=3Demail :
PS1, Line 1273: # Hardening flags, a subset of the O=
penSSF "Compiler Options Hardening
> How did you choose the subset? There s=
eem to be quite a few missing=2E
I took the run-time protections that distr=
ibution package builds already apply: Fedora's and Arch's default flags, an=
d Debian/Ubuntu dpkg-buildflags with hardening=3D+all=2E So they are known =
to work with this code, and they only add checks=2E They do not change what=
 correct C code does=2E I should have written that rule into the comment=2E=
 The rest of the guide's list, and why I left it out:

* Warnings (-Wformat=
=3D2, -Werror=3Dformat-security, -Werror=3Dimplicit, =2E=2E=2E): configure=
=2Eac already has its own list, so I kept this change to code generation=2E=
 On master, -Wformat=3D2 gives 12 -Wformat-nonliteral warnings (dns=2Ec, op=
tions=2Ec, platform=2Ec, resolve=2Ec, ssl_util=2Ec, ssl_verify=2Ec), so it =
would break --enable-werror=2E -Werror=3Dformat-security, -Werror=3Dimplici=
t, -Werror=3Dincompatible-pointer-types, -Werror=3Dint-conversion and -Wtra=
mpolines build clean with GCC 16=2E

* Not relevant here: -D_GLIBCXX_ASSERT=
IONS and the libc++ hardening mode (C++ only), -fexceptions (for pthread ca=
ncellation, openvpn has no threads), -fPIC -shared (libtool does it for the=
 plugins)=2E

* Not usable in a global LDFLAGS, because the plugins link wi=
th it too: -Wl,-z,nodlopen would stop openvpn from loading its own plugins,=
 and -pie is only for the executable=2E PIE is already the default of most =
Linux toolchains (Debian, Ubuntu, Arch and Alpine GCC, clang 15 and later)=
=2E

* Not just a check, they change code generation or what the compiler m=
ay assume: -fno-strict-overflow, -fno-strict-aliasing, -fno-delete-null-poi=
nter-checks, -ftrivial-auto-var-init=3Dzero and -fzero-call-used-regs=2E No=
 distribution sets them by default, and zero-initialising makes uninitialis=
ed reads invisible to valgrind=2E I think that is your decision, not someth=
ing to switch on in a hardening default=2E

* -fstrict-flex-arrays=3D3 (GCC=
 13, clang 16): openvpn has no [0] or [1] trailing arrays, and with FORTIFY=
=3D3 it builds without warnings and the unit tests pass=2E But it also chan=
ges the FORTIFY bounds for system structs such as struct sockaddr, so I wou=
ld rather do it separately than hide it in this change=2E

* GCC-only short=
cuts and newer flags: -fhardened (GCC 14, the same set plus PIE, _GLIBCXX_A=
SSERTIONS and -ftrivial-auto-var-init=3Dzero), -fzero-init-padding-bits=3Da=
ll (GCC 15), -Wbidi-chars=3Dany (GCC 12 already warns about unpaired ones b=
y default)=2E

* Missed: -Wl,-z,noexecstack=2E It is the default for C with=
out assembly, but being explicit costs nothing=2E

* Left out on purpose: -=
Wl,--as-needed and --no-copy-dt-needed-entries, which are link hygiene rath=
er than hardening=2E

If you agree with this split, I will add -Wl,-z,noexe=
cstack and put the selection rule into the comment=2E Any of the others can=
 come as a separate change if you want them=2E



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
Ger=
rit-Change-Number: 2213
Gerrit-PatchSet: 1
Gerrit-Owner: Aravind O R <aravi=
ndor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 19 Nov 2026 11:23:12 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>

--Gdg8So3sfUU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Aravind O =
R has posted comments on this change by Aravind O R=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>File configure=2Eac:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2213/comment/566cf8c9_ee5c3abb?usp=3Demail">Patch Set #1, Line 1273:</a=
> <code style=3D"font-family:monospace,monospace"># Hardening flags, a subs=
et of the OpenSSF &quot;Compiler Options Hardening</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Ho=
w did you choose the subset? There seem to be quite a few missing=2E</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I took the run-time protections that distribution package builds=
 already apply: Fedora&#39;s and Arch&#39;s default flags, and Debian/Ubunt=
u dpkg-buildflags with hardening=3D+all=2E So they are known to work with t=
his code, and they only add checks=2E They do not change what correct C cod=
e does=2E I should have written that rule into the comment=2E The rest of t=
he guide&#39;s list, and why I left it out:</p><ul class=3D"blocks"><li>War=
nings (-Wformat=3D2, -Werror=3Dformat-security, -Werror=3Dimplicit, =2E=2E=
=2E): configure=2Eac already has its own list, so I kept this change to cod=
e generation=2E On master, -Wformat=3D2 gives 12 -Wformat-nonliteral warnin=
gs (dns=2Ec, options=2Ec, platform=2Ec, resolve=2Ec, ssl_util=2Ec, ssl_veri=
fy=2Ec), so it would break --enable-werror=2E -Werror=3Dformat-security, -W=
error=3Dimplicit, -Werror=3Dincompatible-pointer-types, -Werror=3Dint-conve=
rsion and -Wtrampolines build clean with GCC 16=2E</li></ul><ul class=3D"bl=
ocks"><li>Not relevant here: -D_GLIBCXX_ASSERTIONS and the libc++ hardening=
 mode (C++ only), -fexceptions (for pthread cancellation, openvpn has no th=
reads), -fPIC -shared (libtool does it for the plugins)=2E</li></ul><ul cla=
ss=3D"blocks"><li>Not usable in a global LDFLAGS, because the plugins link =
with it too: -Wl,-z,nodlopen would stop openvpn from loading its own plugin=
s, and -pie is only for the executable=2E PIE is already the default of mos=
t Linux toolchains (Debian, Ubuntu, Arch and Alpine GCC, clang 15 and later=
)=2E</li></ul><ul class=3D"blocks"><li>Not just a check, they change code g=
eneration or what the compiler may assume: -fno-strict-overflow, -fno-stric=
t-aliasing, -fno-delete-null-pointer-checks, -ftrivial-auto-var-init=3Dzero=
 and -fzero-call-used-regs=2E No distribution sets them by default, and zer=
o-initialising makes uninitialised reads invisible to valgrind=2E I think t=
hat is your decision, not something to switch on in a hardening default=2E<=
/li></ul><ul class=3D"blocks"><li>-fstrict-flex-arrays=3D3 (GCC 13, clang 1=
6): openvpn has no [0] or [1] trailing arrays, and with FORTIFY=3D3 it buil=
ds without warnings and the unit tests pass=2E But it also changes the FORT=
IFY bounds for system structs such as struct sockaddr, so I would rather do=
 it separately than hide it in this change=2E</li></ul><ul class=3D"blocks"=
><li>GCC-only shortcuts and newer flags: -fhardened (GCC 14, the same set p=
lus PIE, _GLIBCXX_ASSERTIONS and -ftrivial-auto-var-init=3Dzero), -fzero-in=
it-padding-bits=3Dall (GCC 15), -Wbidi-chars=3Dany (GCC 12 already warns ab=
out unpaired ones by default)=2E</li></ul><ul class=3D"blocks"><li>Missed: =
-Wl,-z,noexecstack=2E It is the default for C without assembly, but being e=
xplicit costs nothing=2E</li></ul><ul class=3D"blocks"><li>Left out on purp=
ose: -Wl,--as-needed and --no-copy-dt-needed-entries, which are link hygien=
e rather than hardening=2E</li></ul><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">If you agree with this split, I will a=
dd -Wl,-z,noexecstack and put the selection rule into the comment=2E Any of=
 the others can come as a separate change if you want them=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2213?usp=3Demail">change 2213</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2213?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e2=
9e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2213 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 11:23:12 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>

</body></html>
--Gdg8So3sfUU=--


--===============8749323965036910167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8749323965036910167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8749323965036910167==--


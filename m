Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C9FCCF2D6
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vaqo7SU3cM2sHphPEKK0owAWS9qCF/jcMaw1BukoSOU=; b=OrZcSdpIjE5OnCBnMeZ8JVJIZF
	ZrdpZnR2bL/Z8B8yfLKiF7jfBECfqX6pZ6CXkxbEZvZoZwGUh1v4LCwUO4WKOl6xjzOXI9TN1l8gR
	gs18cqaVWchiLoXYPnJY0HSPSrB2BFHkcWWcsD3G8eMVBoNjKvsVV+lnNu5fXZhclhKY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xImve-000388-4j;
	Mon, 19 Oct 2026 12:57:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xImvc-00037u-CO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CszIX6kamKG2Y+2JwZCD/F0V3lxIjo2v1c0pZYhuukI=; b=PiH/Ws8t+t6bf4Mou6mCpjNafU
 aMZ5yUc0pZvJQv/DIXZpLKnal3HEuekn6W50myQybRspEmO4/vRf905t7ZzUPBIvhZ2W4ecXmNlXY
 M8wCSTVkkSLKUXKgXDnVBCecT5zM7mOas8svGE/ukXL29gOxIJjaMA8B0536GJsrK+Hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CszIX6kamKG2Y+2JwZCD/F0V3lxIjo2v1c0pZYhuukI=; b=e
 p9JKMHyEVU47AO8za9O05iGcQhvpjeKf2WocCKlIt/M2FqpAI9zjjcL4A13WghyKcBlGuCrCZPTI/
 h90jKMKHlYT17OHksJstAO2f+IjtCsqziSXGBDRBAdUuDzsNuSztWR7MrJvwtNpRMUTlk1qtSQcRi
 IhD/7y14W7dvXRzA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xImvZ-0007Ng-5x for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:57:25 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so20568085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792414635; x=1793019435; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CszIX6kamKG2Y+2JwZCD/F0V3lxIjo2v1c0pZYhuukI=;
 b=Qj1OFMzHSALM6Z6gV4bvr7/BduROIkQwQK92YAN52nEjL2IZvRtpg0n+t7BbWZ4cED
 1lCSqCG8yStK5uq7Y15XrMPkzVMaIVzzg8zeqrYpjFnek0IKhw7Fb3ubckH+qYp+JXR7
 8wbYAJEbBB5I6o+6iKMgFbhG1GhkLLKyFKMA+qJdyPu9M5M9pAJ9D9XxkPplSIIHHFPS
 bUWqXUJTFgzPK7HmGdj6ngTLudbBJWwciFCfNuAIQ/i2fPD2Jc+IJZ4PBpFGwpLcfX7o
 lNmyU2Vc/nveyHP/CkfwclLj6EoLGLTdWU+KTnYgk0E0xPMkSt+ZyTYCc0KU4S8Dh171
 pKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414635; x=1793019435;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CszIX6kamKG2Y+2JwZCD/F0V3lxIjo2v1c0pZYhuukI=;
 b=j+MzCrPN8W0r5F7oUVKwUGn6nF9iDD31+P/1cVzLzaeA+ASHxyu05fx5vB7llpPy+v
 QmLaDPdE4mwshUwsP+5FarEWrQ2T8vVNZO+yIMB3K7d7cep1qHDftSdTuJEsMUsd9NQ7
 HKLH7MPORuINKC9txCQMMIziwqvZzDNNZVH2eK/GfoDREEI+6NVrsbblc5NcycOACqLf
 Xs6XEv+ldVpfn/PwwYdjGLCYJLaEoCqj2hOj400s09NfOPtWMBgCWs6j+4Ced0ckKO6G
 XzKL3RSrumNDNhdOeRGgiQILoE2d/sijwCWwf37f0+ukgsKp7UMdlMneZn5so13/2FEf
 w84A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQ6d/b2NE8G7NsgV/cVCbH0y4VTewfV7+9YnjLKPAzm8oeQ058c3vS0l+qeQIFDx71LcIZoUZ24FRL6LA8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKhtywQuqFJhaMTgn5PXZ6uByjXdgI3ALJ2ShO1j7KaOdms5R0Y
 oFyTPP1ud2uFGS6IhDSc9SmahDrvcx3hf8ata3deurdHIm1M0mr1bWEcjAX7IQvJRIX4e043eEm
 cz7Ye1Qax/Pg0gb6XgqSiyUrHrboAcU91nvtEDIJ2NgCyHdShJlzKyONhSWo9aX5mCLXQc/ZMhY
 y9UNXruw==
X-Gm-Gg: AYBFou2vbKHcVHgWLTN77V7wj7Ou+s4acwgUlaV9ncmiD2pmSvlXBDTxK6e+5HP5VBh
 +VxxNxz3kNrC8fFqJEVbEOXayzhWpZy56VMFax9tcHpHEOe7rRF4PNviJMnC0Anr2Y00IPkIFtB
 WDJK93esfqvdYykS/AIEliQ3qqgDbdEtAZPlmSTziUoknZI8tg1EDAyUg7FtzSF1n0GrGk0MgGg
 bs/tnskIe/Ieft3Z2lTsZRXR1tcIQFn/zvBn5EuC42kyx+sLPgm2hrUJEgJnw6CwHngh1mHz2H3
 saxdnZq1uYU41HYqd2OBoqjaEKL7l1bIb3eaGfKgLRH921f3DRweQcSu6taB5c/OViOxv4BzLSs
 GJkeI9QV7l3S1YYNljJtHs8ZM8tAeysnP+AHjpx56m+z57AOX7wUc++cJUinhNf4xfxfl9nqj6u
 7IEZYbKlkgPrNYnG+n320O/jggFO7UPdlLWZRM/TxxJvDzRWAyAG713YlNGijrizfFboKDwWDk3
 4+wgJXFmm4Z/D3pqAqU9DFy/XJ0/9q5tiU48+qft0kphk0xjcwg8KaiVK2ZQzkIXLSm6Y9GFVG5
 JoKN1Dl49stfIA7B9JarzF31L9E+p0QVWjzwojv/4oC72KnpSw7KYA3rjxbmrl+c5VP9oHs=
X-Received: by 2002:a05:600c:8a0d:20b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-4a1d7616d29mr112294035e9.23.1792414633042; 
 Mon, 19 Oct 2026 05:57:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dea678cdsm193541925e9.1.2026.10.19.05.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:57:12 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 12:57:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 2b8e1791c89fe2b5ea9f63b1fdb874771db2a4b3
X-Gerrit-Comment-Date: Mon, 19 Oct 2026 12:57:10 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e5e92a0e1030360456d22bf2cd054cac8a0744a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xImvZ-0007Ng-5x
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5171012952366330287=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5171012952366330287==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hiA1l1tzMZ0="; charset=UTF-8

--hiA1l1tzMZ0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subj=
ect: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: Code-Revie=
w-1

(4 comments)

File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1852/comment/322d0efd_b8df0985?usp=3Demail :
PS13, Line 4352=
:     setenv_str(env, "MANAGEMENT_USER", management->settings=2Eup=2Euserna=
me);
One patchset v8 comment says that management auth has no username (so =
presumably this would set it to an empty string)=2E

Do we need this line a=
t all?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/0b4ee1f7_f=
07c028e?usp=3Demail :
PS13, Line 4356:     argv_printf(&argv, "%s", c->opti=
ons=2Emanagement_script);
Should this be `argv_parse_cmd()` instead?


http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/71465742_8dd4e49f?usp=
=3Demail :
PS13, Line 4360:     const char *msg_prefix =3D "WARNING: Failed=
 running management unix-script";
Seems like `WARNING` might be the wrong p=
refix for `M_FATAL`=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/co=
mment/676423c5_c9495be6?usp=3Demail :
PS13, Line 4390:             c->optio=
ns=2Emanagement_addr =3D platform_gen_path(platform_get_tmp_dir(), sockname=
, &c->gc);
Should we use `c->options=2Etmp_dir` here? Otherwise this could =
ignore `--tmp-dir`=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
G=
errit-PatchSet: 13
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Mon, 19 Oct 2026 12:57:10 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--hiA1l1tzMZ0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 13:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1852/comment/322d0efd_b8df0985?usp=3Demail">Patch=
 Set #13, Line 4352:</a> <code style=3D"font-family:monospace,monospace">  =
  setenv_str(env, &quot;MANAGEMENT_USER&quot;, management-&gt;settings=2Eup=
=2Eusername);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">One patchset v8 comment says that management auth =
has no username (so presumably this would set it to an empty string)=2E</p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Do we need this line at all?</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1852/comment/0b4ee1f7_f07c028e?usp=3Demail">Patch Set =
#13, Line 4356:</a> <code style=3D"font-family:monospace,monospace">    arg=
v_printf(&amp;argv, &quot;%s&quot;, c-&gt;options=2Emanagement_script);</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Should this be `argv_parse_cmd()` instead?</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/71465742_8dd4e49f?us=
p=3Demail">Patch Set #13, Line 4360:</a> <code style=3D"font-family:monospa=
ce,monospace">    const char *msg_prefix =3D &quot;WARNING: Failed running =
management unix-script&quot;;</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Seems like `WARNING` might be the =
wrong prefix for `M_FATAL`=2E</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1852/comment/676423c5_c9495be6?usp=3Demail">Patch Set =
#13, Line 4390:</a> <code style=3D"font-family:monospace,monospace">       =
     c-&gt;options=2Emanagement_addr =3D platform_gen_path(platform_get_tmp=
_dir(), sockname, &amp;c-&gt;gc);</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Should we use `c-&gt;options=
=2Etmp_dir` here? Otherwise this could ignore `--tmp-dir`=2E</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Mon, 19 Oct 2026 12:57:10 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--hiA1l1tzMZ0=--


--===============5171012952366330287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5171012952366330287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5171012952366330287==--


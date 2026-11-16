Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fGKTLZg7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Auvj/pEj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LljbErrP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HIdZFb6G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4iy1PPV1Zjwg+yp8gFa2vUnWZuLyPuHNqvNG52B014M=; b=fGKTLZg76wVqV6DaIJO5gM2iB2
	be2McV39g+gTOhVYNbL+lzL6IrDZtornJAq3398UOjqWrt1/43aTrup8aPztDxbGMNj0v5qqgADFy
	cxsELJMsOFf4g4BHvsc/lPbQd9fnX54zThv17kJXXD5ewEPyYAI1tneS3ARGYA0XmWgw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxHE-000000004Y5-339k;
	Mon, 16 Nov 2026 14:01:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxHC-000000004Xy-3ssu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=moJeJT7qmJ+HMuaLkzWAM5bBVQKWfmUzMdicp4HsU3k=; b=Auvj/pEjP4amRVkN9ES92kUhKx
 10wFQniJxf1mBKOnH6G8s95i0UbrvlI7BkRccz5WXMGk8ciUp22lifKdstYfMcC9MZORbnazY5p9u
 kfUHkbgaRLfNxnN+LiBsIAsxp2OS1Sm66pjILJBV1mbnRadv8ZafDjN1r0J5KgSnCVaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=moJeJT7qmJ+HMuaLkzWAM5bBVQKWfmUzMdicp4HsU3k=; b=LljbErrPYu006jarIG1dO9gfDQ
 WETgGms0qCM/OBPrqQQezzqDYUQ/DVHfysK1XJp1f+3kjQgQa+2/8Ibg2UAsB0EgZkrMIdnVb7ER0
 HzD5Ypr/cC2fRMV24hGhN4x9DvOELTzfAqy+K+octsxAG4/G2eHKAlvupCUjhj7N5glk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxH8-0000000088P-3k2c for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:01:42 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so21446275e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794837692; x=1795442492; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=moJeJT7qmJ+HMuaLkzWAM5bBVQKWfmUzMdicp4HsU3k=;
 b=HIdZFb6GgZD5x5SL5RwOsMgsGOolG5w+Yl3F857Hh2mTKXUJAthAuz0zL6/ggu4Zfj
 LKMQuZG8vsn15ehV0ohx5eBpdzYlnXiV/WMPt3C5VfZzNJsOr4Gnh9hBVyorDWSw1RH4
 Prz42FnWIj0Pu1MciUsGjWpHFNYLe2/08/WaP7LC0eL1yqRhrOomJbz/ImKWKCyW2nE8
 eKPg3mthihWq3QIGuJ88+uzP3PI2pLMQUshlnMBWiz00LK8EEXqQ7F5BfAbigdggi+KO
 MMM/6SBD0aphP/kTjUeelvM22Sw2z5Z1G/bkDYoA61dMcd2FAXy2p3c5zrmk4UQkv9VK
 Kv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837692; x=1795442492;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=moJeJT7qmJ+HMuaLkzWAM5bBVQKWfmUzMdicp4HsU3k=;
 b=awdefF/YkgtIM+TAXMpiIoJatQ2cwLr10tos+ERbEepmK+4acLMrgE6kst0AREqaY6
 JS4Xa9fmLvcXEE5ISs61SX6ZIAtto3hPxVG2ZGydQTeSqgUXLAxSrvssemp7wsfb5b0L
 admPqfGnrXyRAfrfyDgY5PiN+0AsSSnm3tCOeGKQtsUv3yH7aaSnGR1tIRyh/SqkyPUW
 S5dtaxCpf9pbcgsn9mnxywXcuXD29xQMjI+++AzVhZVceKTNO+APiNEU7Uag8wV4Gd6C
 AYLDw4BEBcBF5MAHPeHtd9dkti/MuXvC9vhEZ0YItURA/AExUwf9PsezfnTwiP07BlAh
 DIZA==
X-Gm-Message-State: APuU4Z9BMT6EYBa6BKF8azKCRPlAzAi9Il16wIni+OxTjnu49v/3Wn4T
 5GA+VpbnlNL0+gk1pSECqg6y56urqQhDfyRYlgl9f76J0BKq6INa8bRxKCLy85Xr/1/rLZHhY7a
 rt4dDITqoG+x+gIKuZfzelAhNFWUtyKomg9dG9zspM6XcV7nRrQtS3E/e23uL1ScjEtjK
X-Gm-Gg: AYBFou2aIwKx2AXz2cF4m0HLUj9cd+QlG48wXwNfNNGphrCygvp8rarjugBUOxzicyd
 Gn4yZ5KKM16Y19Yf1xXXWfMAfinPGAHAHVVOnipVUiatjQucuhqa2U26HsO3oG4Yg5Bw84vjypI
 MgM2RA3+/cx+LikKCcddtFmefFLyD8pTNg+OWz/frLrJ2iwNXwIVqpYAfaEPRRFCWKLuiMlw28Q
 jJR3W3tMynM4VFACU1YLsGYalQ377ojWsq05aqhJ/fSV1biZZtBH9L/2uDscG7llmWIv2A9eGHL
 1gjWvqyc3GbOTdZQSVb+3M1v+vm7Z/6UF43xc/cKcg1lZSbJWfLeWJ/19LADjcDa4E3FJt/shK4
 zfQbqYzpxMLYXvnOET/zTm0QBjTJfbj/3SXx0W7HDw0FS4vv4W7GS9DAEJR8B0Fl36HrD87N3u5
 lWDu+2M2XWKlVt+3QZK2FoaB6BcmMkyLln9nf+5cbVy2cCJ22fb4T1P8qEroXxoq0H7rIzKoZf3
 dwRdXWqnmbBlls4EciTe3y86ZItGwkKxTJFwyRkaVwR4WKo/+c+WqmzigD6kaKsGnlxhJqJcRd7
 dY/ghx8G7SQYHvRUavbRO9S4bF4O7WtMCJzqAbbNsrEqZGRC8TQNotk5Q76+37oA7Tt0mStioPc
 CPDCR8YsEEhFEGSyXo4OLrY5yyjNpiO+sTZY98zTD1mqDqymnZxCClgHesemZPjc5dtgx8M0OnC
 /mwmJlGHQmesvdez0=
X-Received: by 2002:a05:600c:4e13:b0:4ba:38a9:85e3 with SMTP id
 5b1f17b1804b1-4bb55a47fabmr223883305e9.12.1794837691820; 
 Mon, 16 Nov 2026 06:01:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm201470775e9.3.2026.11.16.06.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:01:29 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
X-Gerrit-Change-Number: 2193
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2193?usp=email>
X-Gerrit-Commit: 38b0d5d07e5b0108bc8ffb789d82fa11c685c5f5
In-Reply-To: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
References: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkk2MDc5ZjQ1NGU1YmIxY2U3YzRlY2M1MzQzY2UyMjMxYzQxN2NhODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <27708121864af843a35801933a70eadb9157695a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxH8-0000000088P-3k2c
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1643557890807076518=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1643557890807076518==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tKZeiAMnBbA="; charset=UTF-8

--tKZeiAMnBbA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
193?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: GHA: Disable -Werror=
 for MinGW 32bit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

GHA: Disable -Werror for MinGW 32bit

There are some build failures re=
lated to -Wsign-conversion
now that look like clear bugs in MinGW=2E Since =
we do not plan
to support 32bit Windows going forward, let's not worry too
=
much about compiler warnings anymore=2E We will still detect if
we break th=
e build completely, for now=2E

While investigating the issue, remove a wro=
ng comment=2E With
-Wsign-conversion, all builds need the casts=2E

Change-=
Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193
Message-Id=
: <20261116132828=2E31945-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41439=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflow=
s/build=2Eyaml
M src/openvpn/auth_token=2Ec
2 files changed, 5 insertions(+=
), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/93/2193/2

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egi=
thub/workflows/build=2Eyaml
index 27f08df=2E=2Ed50b7ff 100644
--- a/=2Egith=
ub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -81,6 +=
81,10 @@
         arch: [x86, x64]
         build: [Release, Debug]
 
+    =
    include:
+         - arch: x86
+           configure-args: "['-DUSE_WER=
ROR=3DOFF']"
+
     name: "gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2E=
build }} - OSSL"
     runs-on: ubuntu-26=2E04
     env:
@@ -113,6 +117,7 @@=

         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # =
v10=2E9
         with:
           configurePreset: mingw-${{ matrix=2Earch =
}}
+          configurePresetAdditionalArgs: ${{ matrix=2Econfigure-args }}=

           buildPreset: mingw-${{ matrix=2Earch }}
           buildPresetA=
dditionalArgs: "['--config ${{ matrix=2Ebuild }}']"
 
diff --git a/src/open=
vpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index 703a0b2=2E=2E261c7c2 =
100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@=
 -364,7 +364,6 @@
 
     /* Accept session tokens only if their timestamp i=
s in the acceptable range
      * for renegotiations=2E
-     * Cast is req=
uired for systems with 32bit time_t, e=2Eg=2E Windows x86=2E
      */
     =
const time_t token_reneg_deadline =3D (time_t)timestamp + 2 * session->opt-=
>auth_token_renewal;
     bool in_renegotiation_time =3D now >=3D (time_t)t=
imestamp && now < token_reneg_deadline;

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
Gerrit-=
Change-Number: 2193
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--tKZeiAMnBbA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2193?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">GHA: Disable -Werror for MinGW 32bit<br><br>There are some build failur=
es related to -Wsign-conversion<br>now that look like clear bugs in MinGW=
=2E Since we do not plan<br>to support 32bit Windows going forward, let&#39=
;s not worry too<br>much about compiler warnings anymore=2E We will still d=
etect if<br>we break the build completely, for now=2E<br><br>While investig=
ating the issue, remove a wrong comment=2E With<br>-Wsign-conversion, all b=
uilds need the casts=2E<br><br>Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c=
417ca879<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193<br>Message-Id: &lt;2026111=
6132828=2E31945-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41439=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egith=
ub/workflows/build=2Eyaml<br>M src/openvpn/auth_token=2Ec<br>2 files change=
d, 5 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/2193/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml=
</span><br><span>index 27f08df=2E=2Ed50b7ff 100644</span><br><span>--- a/=
=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/=
build=2Eyaml</span><br><span>@@ -81,6 +81,10 @@</span><br><span>         ar=
ch: [x86, x64]</span><br><span>         build: [Release, Debug]</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        inclu=
de:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         - arch:=
 x86</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           conf=
igure-args: &quot;[&#39;-DUSE_WERROR=3DOFF&#39;]&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     name: &quot;gcc-mi=
ngw - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><=
span>     runs-on: ubuntu-26=2E04</span><br><span>     env:</span><br><span=
>@@ -113,6 +117,7 @@</span><br><span>         uses: lukka/run-cmake@5d55ea7=
949e25f69f0ecb516d8d572297e03a956 # v10=2E9</span><br><span>         with:<=
/span><br><span>           configurePreset: mingw-${{ matrix=2Earch }}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          configurePrese=
tAdditionalArgs: ${{ matrix=2Econfigure-args }}</span><br><span>           =
buildPreset: mingw-${{ matrix=2Earch }}</span><br><span>           buildPre=
setAdditionalArgs: &quot;[&#39;--config ${{ matrix=2Ebuild }}&#39;]&quot;</=
span><br><span> </span><br><span>diff --git a/src/openvpn/auth_token=2Ec b/=
src/openvpn/auth_token=2Ec</span><br><span>index 703a0b2=2E=2E261c7c2 10064=
4</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/sr=
c/openvpn/auth_token=2Ec</span><br><span>@@ -364,7 +364,6 @@</span><br><spa=
n> </span><br><span>     /* Accept session tokens only if their timestamp i=
s in the acceptable range</span><br><span>      * for renegotiations=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Cast is required f=
or systems with 32bit time_t, e=2Eg=2E Windows x86=2E</span><br><span>     =
 */</span><br><span>     const time_t token_reneg_deadline =3D (time_t)time=
stamp + 2 * session-&gt;opt-&gt;auth_token_renewal;</span><br><span>     bo=
ol in_renegotiation_time =3D now &gt;=3D (time_t)timestamp &amp;&amp; now &=
lt; token_reneg_deadline;</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail">change 2193</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6079=
f454e5bb1ce7c4ecc5343ce2231c417ca879 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2193 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--tKZeiAMnBbA=--


--===============1643557890807076518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1643557890807076518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1643557890807076518==--


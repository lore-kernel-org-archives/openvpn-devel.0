Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0B9CA9EC5
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rm2U2VzzyB+gASrXY9gd8yhZfg4ZPuyx3Lqk9ypQGBQ=; b=NbDN8isZ8tX2rO5FliF1BRLSSf
	YfmY21LGbx7tKK5TTjsmIguv2pDGqnFgIu+ae4Ty3uf6us84Ds8SUnu6ycudIWrOJ2PL5afvHUrTi
	6KGtz87SjuxvTfp7y6RPoF1ybAKZju90im8fYVEfS7pWp3+jJVlLQRT+2eyEdsy8cPio=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGAZM-0008IS-HV;
	Mon, 12 Oct 2026 07:35:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGAZL-0008IG-4Z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ozuT2u3Ma5zFTremviQqSPgSlng/rZo4KCO7nVoV8c4=; b=e86LsZa+quiRm7MuOBblYEyT2f
 Mdwq5/FA7FGlfQnabweo58DRSA4O98x83/8QARxg1fNJyp1yWwlO6igggzidUdPnNBip/rmDM44za
 T7P3pA/k0tpmirFKRSeY29SVW11mpXF0DpP9opHuEqnF+uxfFg5yiP9yHin6FBGtbJEY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ozuT2u3Ma5zFTremviQqSPgSlng/rZo4KCO7nVoV8c4=; b=F
 BceBP7+4KOMziYisEpGeIeqFZ6GdYMh64NMEV9MQ690Ph7GqoN5ywMsyDpKxQglZc+BJ58LoObO1U
 QOu6ZDvupNZi9d8qvdXIEcsoN9e5woCd2C7RTncCh6HQLYWxMil9Nf41WjVCoyBf55KHSjPEXEjYQ
 0M5e1mGA1CthklEs=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGAZJ-0007Is-R8 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:35:35 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so11252165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791790527; x=1792395327; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ozuT2u3Ma5zFTremviQqSPgSlng/rZo4KCO7nVoV8c4=;
 b=XrBR82vAAgDsDyY3Na88/Et7vw4EA4FEC3V3tQ05Kh15k91Za6x5p9inv81ePhgz8z
 Rl4mPRQ4+H9NPC3/7MYQLbNK1ERd9e/bQrnMuLo1eBFDTfcrMSF70AxHORfqDjRiploQ
 exD4Gxg1kjIDXbipkf3zXdMDa30FouDut9txomMLzdRK3GF26pjl2C34m9VtmOeFdVpw
 5t8PcmwBfcj/XqRzhkfWCrj2e0sV8MZdXLNqQKzlzh511eMLO/MNO04FuiTUNjMTjcgG
 +cBmssCFlYEA1XOl0R1+wGZ/o/M8mJVCHgMMCkhLrl0erd5cVqqhJpDG9qlPzfOgYrb5
 7QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790527; x=1792395327;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ozuT2u3Ma5zFTremviQqSPgSlng/rZo4KCO7nVoV8c4=;
 b=VXaDg6eGikHVny624UDJaGC14BUn/JRJYi/2Wvd/k2OIzG/68TrTpTBGWZFQ4KZhDf
 joTTNlZBCZ1hb9bi7C2SgbxX7U84j0PV7dS+NxJiFzZViI30rAFAdhWG2mQcp5P++ebj
 KXHiaX2rKyN+iVD0LZZB3Ew+OdBt4ZVOggQ24d8MhZTNLfyShI7MGN2F08oUUdxbnUCU
 rHCwtAhJoK2Ti9EcHl0Ipuxah+N+NtlwYvJDhjqleAam7x2BwYQa045tsSSsSU3dMK4Y
 +YJi4r0QT7swBJYTgYpzltfmg2kvBy1B200gpQnDwzVVeb0katRdgzRZz6SU9vu8kaY8
 1JZw==
X-Gm-Message-State: AFq9FYIxSXaYGaz5ftR4J/+XVBPKyKL8YA9UA8mRVZsVfEhtWrq/WIl9
 yFumqVe/cFdkb/EEIPO1Df5annamAVlaOlPmaYBaxfwJ2D1rE1XhjvrsqKIDOvxQAgxq6CKtdf0
 yOQMEqQhp1PJ0xdlhsuLQ+t8sBIiM2Q5agWFvKaIdsqHalyJA5hOQ/XQ8GQiAD5JEMxpfeoFYCP
 7fbSGsYg==
X-Gm-Gg: AYBFou1zDI3Q0jQ2SQNSvibop6GSJbd1ycoU8WfRt4ECeQnJrN1s/puraYtVig+Nc36
 98zuy/9mYFIaXI8DoV7hEjOMNOBh7avknV0JGAi2rVu7RlG3/ieQuOewainT25DT2sdNzHJZbdL
 I86jEdOHR2Z+RSxiOUYIoyGfNJX5NO36ZEX3T75o6AgjMe/2VncrsQO0dxXnndF1ApWAsD9BBCJ
 kDsBts4ck3dkUscaW2KCYCLNtFlK/5aDg4Sxx+AoD+LwAWGGOyONMd9ePvfGRN3FvcqGjbnZLtC
 FAmsRXcS6ljZltnojeAZhfJn/PWJmd2EpYTU1FsGtJq3vkR9y2/ZPt7aN/AVmwRT/4YJFZCpFP1
 l5WWSnMDP5go5Q0Zy5tWwagbMLx5dA679Y9NHPlrp6/aCbWw4lU53i8mNLUfopSR65jtrcW7uVm
 WV/Y9tvhYm9GlNdFsQO+jCWfaOefpNUm1qv6P466IY1M9cL3lvHG1UJOfJKUwzr88fxYkOqpD6b
 Zwtd5nQk9+IymGPtDpk2ngq47C6P50D7SJV80o5icqz2ge5xwgWBuZHi7GX66GTRRxAQDyhKAGO
 GRClVH6ujC+RlaUBcy2NazhsfghOM/NPVnGQI5581PImpcymGtMsjx9v4cDX
X-Received: by 2002:a05:600c:1c21:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-4a18e4b6241mr196689725e9.16.1791790525670; 
 Mon, 12 Oct 2026 00:35:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bbbdd75sm211090275e9.1.2026.10.12.00.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:35:25 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 07:35:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: 6aab116b2955902fe81349e5cfd1e92f6a49fb8a
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b908300620943f2b95b29b9a574b66fe36cb0a53-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGAZJ-0007Is-R8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not look up the
 "none" cipher or digest in OpenSSL
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
 razvanc@mailbox.org
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6242819578347143971=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6242819578347143971==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3fcD5Ph8oD8="; charset=UTF-8

--3fcD5Ph8oD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#2)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1950?usp=3Demail )


Change subject: Do not look up the=
 "none" cipher or digest in OpenSSL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Do not look up the "none" cipher or digest in OpenSS=
L

cipher_get() hands EVP_CIPHER_fetch() whatever name it is given, and the=

callers that only ask whether a cipher exists or which mode it has
(cipher=
_kt_mode_cbc/ofb_cfb/aead(), cipher_kt_block_size(),
cipher_kt_insecure()) =
treat NULL as "not that"=2E For the "none" cipher
that is the expected answ=
er, but under OpenSSL 3 the failed fetch also
pushes EVP_R_UNSUPPORTED ("di=
gital envelope routines::unsupported,
Algorithm (none : 0)") onto the threa=
d's error queue, and nothing pops
it=2E

"none" is what every server withou=
t --cipher carries in its
pre-negotiation key_type: the legacy BF-CBC defau=
lt is not in
--data-ciphers, so do_init_crypto_tls() initialises the key_ty=
pe with
cipher "none"=2E Each new client instance walks it in init_instance=
() ->
do_init_crypto_tls() -> cipher_kt_mode_ofb_cfb("none") and in the fra=
me
and OCC calculations, and tls_ctx_reload_crl() runs right after=2E Its
E=
OF test reads ERR_peek_error(), the OLDEST queued entry, so on the
first ha=
ndshake after the CRL file changed it finds the stale
"unsupported" error a=
nd logs "CRL: cannot read CRL from file" for a CRL
it loaded fine (GitHub #=
1103)=2E Traced with gdb on 2=2E7=2E0 and master
against OpenSSL 3=2E5=2E5=
=2E

Return NULL for "none" before touching OpenSSL, as cipher_kt_name()
al=
ready does=2E Real cipher names behave as before, and
cipher_valid_reason()=
 still finds the OpenSSL reason on the queue when
it reports an unknown cip=
her=2E md_get() gets the same guard: no caller
passes "none" today (md_kt_n=
ame(), md_kt_size() and md_defined() check
first), but it has the same shap=
e and would leave the same entry=2E

Left alone on purpose: cipher_kt_block=
_size()'s probe for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 ->=
 "CHACHA20-CBC") and
md_valid() leave the same kind of entry, but neither r=
uns between
client instance creation and the CRL reload=2E The next commit =
makes that
reload robust against any leftover and reports one when it sees =
it=2E

With this change the queue is empty at multi_create_instance() and a=
t
backend_tls_ctx_reload_crl() entry for UDP, TCP and CHACHA20-POLY1305
cli=
ents; CRL replacements give clean reloads (unpatched: a warning
every time)=
=2E

Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
Signed-off-by: Dr=
ew Blokzyl <drew@linuxkids=2Ecom>
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/crypto_openssl=2Ec
1 file changed, 17 insertions(=
+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/50/1950/2

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/o=
penvpn/crypto_openssl=2Ec
index 29c5fa6=2E=2Eb44d079 100644
--- a/src/openv=
pn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -568,6 +568,1=
5 @@
 {
     ASSERT(ciphername);
 
+    /* "none" is a valid OpenVPN cipher=
 name that OpenSSL does not know=2E
+     * Return NULL without asking Open=
SSL: a failed EVP_CIPHER_fetch() would
+     * leave an "unsupported" entry=
 on the error queue that the cipher_kt_*()
+     * callers never clear=2E *=
/
+    if (strcmp("none", ciphername) =3D=3D 0)
+    {
+        return NULL=
;
+    }
+
     ciphername =3D translate_cipher_name_from_openvpn(ciphernam=
e);
     return EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }
@@ -981,6 +990=
,14 @@
 {
     evp_md_type *md =3D NULL;
     ASSERT(digest);
+
+    /* "no=
ne" is a valid OpenVPN digest name that OpenSSL does not know=2E
+     * Re=
turn NULL without asking OpenSSL, see cipher_get()=2E */
+    if (strcmp("n=
one", digest) =3D=3D 0)
+    {
+        return NULL;
+    }
+
     md =3D E=
VP_MD_fetch(NULL, digest, NULL);
     if (!md)
     {

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0=
e2438
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--3fcD5Ph8oD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Do not look up the &quot;none&quot; cipher or digest in OpenS=
SL<br><br>cipher_get() hands EVP_CIPHER_fetch() whatever name it is given, =
and the<br>callers that only ask whether a cipher exists or which mode it h=
as<br>(cipher_kt_mode_cbc/ofb_cfb/aead(), cipher_kt_block_size(),<br>cipher=
_kt_insecure()) treat NULL as &quot;not that&quot;=2E For the &quot;none&qu=
ot; cipher<br>that is the expected answer, but under OpenSSL 3 the failed f=
etch also<br>pushes EVP_R_UNSUPPORTED (&quot;digital envelope routines::uns=
upported,<br>Algorithm (none : 0)&quot;) onto the thread&#39;s error queue,=
 and nothing pops<br>it=2E<br><br>&quot;none&quot; is what every server wit=
hout --cipher carries in its<br>pre-negotiation key_type: the legacy BF-CBC=
 default is not in<br>--data-ciphers, so do_init_crypto_tls() initialises t=
he key_type with<br>cipher &quot;none&quot;=2E Each new client instance wal=
ks it in init_instance() -&gt;<br>do_init_crypto_tls() -&gt; cipher_kt_mode=
_ofb_cfb(&quot;none&quot;) and in the frame<br>and OCC calculations, and tl=
s_ctx_reload_crl() runs right after=2E Its<br>EOF test reads ERR_peek_error=
(), the OLDEST queued entry, so on the<br>first handshake after the CRL fil=
e changed it finds the stale<br>&quot;unsupported&quot; error and logs &quo=
t;CRL: cannot read CRL from file&quot; for a CRL<br>it loaded fine (GitHub =
#1103)=2E Traced with gdb on 2=2E7=2E0 and master<br>against OpenSSL 3=2E5=
=2E5=2E<br><br>Return NULL for &quot;none&quot; before touching OpenSSL, as=
 cipher_kt_name()<br>already does=2E Real cipher names behave as before, an=
d<br>cipher_valid_reason() still finds the OpenSSL reason on the queue when=
<br>it reports an unknown cipher=2E md_get() gets the same guard: no caller=
<br>passes &quot;none&quot; today (md_kt_name(), md_kt_size() and md_define=
d() check<br>first), but it has the same shape and would leave the same ent=
ry=2E<br><br>Left alone on purpose: cipher_kt_block_size()&#39;s probe for =
the CBC<br>sibling of an AEAD cipher (CHACHA20-POLY1305 -&gt; &quot;CHACHA2=
0-CBC&quot;) and<br>md_valid() leave the same kind of entry, but neither ru=
ns between<br>client instance creation and the CRL reload=2E The next commi=
t makes that<br>reload robust against any leftover and reports one when it =
sees it=2E<br><br>With this change the queue is empty at multi_create_insta=
nce() and at<br>backend_tls_ctx_reload_crl() entry for UDP, TCP and CHACHA2=
0-POLY1305<br>clients; CRL replacements give clean reloads (unpatched: a wa=
rning<br>every time)=2E<br><br>Change-Id: I440c4c73865fdbd80f2c607e83c50e34=
5a0e2438<br>Signed-off-by: Drew Blokzyl &lt;drew@linuxkids=2Ecom&gt;<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn=
/crypto_openssl=2Ec<br>1 file changed, 17 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/50/1950/2</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl=2Ec=
 b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 29c5fa6=2E=2Eb44d07=
9 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><sp=
an>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -568,6 +568,15 @=
@</span><br><span> {</span><br><span>     ASSERT(ciphername);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* &quot;no=
ne&quot; is a valid OpenVPN cipher name that OpenSSL does not know=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Return NULL withou=
t asking OpenSSL: a failed EVP_CIPHER_fetch() would</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * leave an &quot;unsupported&quot; e=
ntry on the error queue that the cipher_kt_*()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * callers never clear=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(&quot;none&quot;, ci=
phername) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ciphe=
rname =3D translate_cipher_name_from_openvpn(ciphername);</span><br><span> =
    return EVP_CIPHER_fetch(NULL, ciphername, NULL);</span><br><span> }</sp=
an><br><span>@@ -981,6 +990,14 @@</span><br><span> {</span><br><span>     e=
vp_md_type *md =3D NULL;</span><br><span>     ASSERT(digest);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* &quot;none&quot; is a valid OpenVPN digest na=
me that OpenSSL does not know=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * Return NULL without asking OpenSSL, see cipher_get()=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(&=
quot;none&quot;, digest) =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     md =3D EVP_MD_fetch(NULL, digest, NULL);</span><br><span>     if =
(!md)</span><br><span>     {</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">change 1950</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
40c4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1950 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--3fcD5Ph8oD8=--


--===============6242819578347143971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6242819578347143971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6242819578347143971==--


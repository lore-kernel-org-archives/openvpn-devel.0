Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F0606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E2AEwm9s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cDnA3Mgz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WfPkjRkJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Jn1yzUlN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qR9BaF2wTylzbhrqbUFaoQUxTGqrUtvDlPCJfrrme4I=; b=E2AEwm9sHWlFu+ez+kL/mmZuCE
	oHeJ8bT8a1Uy9MZQWA8KabgEQyJto6oS75T530ta4VGmPAcMWXuMJ323NTkLC6arDX0uGpNM2c+EX
	Z31pC1f/wY7/OJ8EmPTKnz33LDK+o7aIdGQ09JdASO/Vd8UyR35uHMSI2cqCjo51lkxs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKLV-000000008A4-08kK;
	Tue, 03 Nov 2026 19:39:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKLT-0000000089s-30I6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2OTiLpHwi2GjXJfwxZUF41GUMVW6dbb2ias1AnJ4Lq4=; b=cDnA3MgzTmhPqdega53RhwZPWH
 ab7Y731Wb+Ra7V3vQaRmc2HGSTpEAQN26gDrx/BHMKAZZhsCcVhcUETCfnmjEL5hl6hRl6LkqJ44n
 cNasUhgoMLZ1h6AaVNcwhImkDt0vaytxOC0w9e3jlp1xwMRqK5Rg8WO364FUrBpj99z4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2OTiLpHwi2GjXJfwxZUF41GUMVW6dbb2ias1AnJ4Lq4=; b=WfPkjRkJVXK4YOmbnu/oXO8NaV
 I2aHECwTNL30OM3TgynG+qcvE5DisxIqv8LOBQ5uWNJ/Jm3HkH0bpSlYZofGLqO/URGnBK1Ro1cNJ
 EG5iWjI6jHWwJ0/GLe4aCB8VCbHG9lggE0wLgvtRBnyJeyG5uLGbViKTtyMEHre0tWsg=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKLS-000000006TC-2wPS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:59 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso2339956f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793734732; x=1794339532; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2OTiLpHwi2GjXJfwxZUF41GUMVW6dbb2ias1AnJ4Lq4=;
 b=Jn1yzUlNoNRBaCzSpy77/H2F/5y41z37AFPL19jSZKyQTMiHOrdHEOSs5n1IfqG1Oy
 EFf48DybvSNWX+oJeeNX/BPBCZb1f1Kxqj2uGQiYXC1WBBMabkaQ2BXa/JVCJ76ws9ja
 5qItyYfbZI9XCtwA05NrMjoABYXmeG9dkhHq40EuFPSKTfBS51s0t88Z2T9foRCYenCd
 qCuFeg3ga1AXuuz5bTHLiPjRNI+o0/GcNhYCZPzkFsJlh8AmM40zn/rVyPaIGCR3cvLh
 gXxp85vZCND0FIqk3tZ53v20bRt9MZdUPUbelXHJGkxORlPXknAPLzs3KOYR/XtWtM+e
 3Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734732; x=1794339532;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2OTiLpHwi2GjXJfwxZUF41GUMVW6dbb2ias1AnJ4Lq4=;
 b=YtyTcHUCXy9z6Ggl/j1MtYLpC5vpO4Cj4kPtp0fnK27jiGHtVYxmVNx7Z43SLZEsG5
 j3TDY781S7wvrQK8k3+3uF01uQnXeYzixrH0Lr6PfLWSFK0GOGOY1cOZG+38RkVicHZG
 r/A+3E7mCmVhUIJEAPvac4vT8+6WqIUlwKmkxoJglZh+sQJmaFx9MGBNtVrGTflCH3em
 uvXCnj2K82SW1pvM5W8HQO7u56oTUrzTn20G6C8PwcffEHMPRYpIuKOdN5QxL6TKj34L
 kcejiPMZVjXZ/bDNqyDf3n1Jvfw2ZytDAzQMWbQF4XIvlWZASz8YWHcNga7UVXANIaZa
 2p1g==
X-Gm-Message-State: APuU4Z+BCHoOdLMMS7jotZM8alZrx89c7a1XADBWoG7/Z+ZyP5U8Y/VV
 jAX/3x/PWIURVnoUZfsF+/mX9DMiLKhJZJhBsGe+qqUXPsgKa0fDVqIY4YFr9fkzHuq7yngxQsy
 aKfcnH4BG7/Blk8VIOPBR8hAMHWRgf/A8UF+MY3Us4pNJaVITyI1pRfZR6bqWe7Fy6+0G
X-Gm-Gg: AYBFou1XpdOVtcVOpVwyiYwISI5vPKG3Ah1E7nnElkiRtV3X6UVNltX+VRl1eWjfTVo
 VaDpOo+E/J5rmzSBI3pA2FEeQ+XclxWopxuSbwW+m3m0flJo/NG85xCFaQowq+J1gM1lvkiG1yC
 LRwh0kAWMrQQ0/SK9gyaz9quv5cJwULTqFzVwsm8fUOuCUm10VzPmDJeAmWAiPocp5DXTqBE0jP
 e0M4hzr/8lQebEm8dwux6y+q7OJ26zfTWslWhKsy3TQCLmH0D1bYs2kb4Ci5ZUBXGdASIob5Zc6
 c/qIQOUPvxQymp5brD7TUYqf6iD+xj0qAz+YOCyH6fnvj3mWRhMMXudlG0S+UkIileSlcGp8so7
 9HL7g+RLEE2TLDPmc2X4iWdpfvlsW7Y8AKdfJMcCN8y0Y72WLHsztc6IkMel7X3E0erG4UHiLpg
 OGb/zjLOG7jaO0CG9LQIYGRMtnlXBj6LDkxnPg3Kr7pG4pd6qVHEYxuwszmdb0KtSOROI27bItc
 XdeZlBTApJmhnpb3ifahPEP1Hk9u+d9m4dVsaAdVHkukw4zymUc6EUDUSsLcofD/054MT3cqpdB
 QK91p7Z/TiTlW1P1TKCtAMnWm6gxae3zBzxJ2fAlLKUAWvILYU+UvSj35hyV+BiWRVA9K+AHo8f
 okBMBZfWd/tJtskUtkEF9tlpbZDHj3TtMpt1WhbMbJHgWRbtpwMbZgcToSNWGIc7AJyBx/w3GVj
 AKUMrVHR2G5k20WdI=
X-Received: by 2002:adf:fc0d:0:b0:48d:f383:2356 with SMTP id
 ffacd0b85a97d-48e6e500514mr25023775f8f.53.1793734731748; 
 Tue, 03 Nov 2026 11:38:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcca7d49fsm254173f8f.39.2026.11.03.11.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:38:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:38:49 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: d42fbb1f40fdc9ef20dbe524db108e4920e388ac
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <055e1f89f0c556e397b96ea8024c70319b14556a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKLS-000000006TC-2wPS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not look up the
 "none" cipher in OpenSSL
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1234582861315776183=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1234582861315776183==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z2MeoSdIVDM="; charset=UTF-8

--Z2MeoSdIVDM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Do not look up the "none"=
 cipher in OpenSSL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Do not look up the "none" cipher in OpenSSL

cipher_get() hands EVP=
_CIPHER_fetch() whatever name it is given, and the
callers that only ask wh=
ether a cipher exists or which mode it has
(cipher_kt_mode_cbc/ofb_cfb/aead=
(), cipher_kt_block_size(),
cipher_kt_insecure()) treat NULL as "not that"=
=2E For the "none" cipher
that is the expected answer, but under OpenSSL 3 =
the failed fetch also
pushes EVP_R_UNSUPPORTED ("digital envelope routines:=
:unsupported,
Algorithm (none : 0)") onto the thread's error queue, and not=
hing pops
it=2E

"none" is what every server without --cipher carries in it=
s
pre-negotiation key_type: the legacy BF-CBC default is not in
--data-ciph=
ers, so do_init_crypto_tls() initialises the key_type with
cipher "none"=2E=
 Each new client instance walks it in init_instance() ->
do_init_crypto_tls=
() -> cipher_kt_mode_ofb_cfb("none") and in the frame
and OCC calculations,=
 and tls_ctx_reload_crl() runs right after=2E Before
commit 15a1465f ("Make=
 CRL reload EOF detection independent of stale
error queue entries") that s=
tale entry made the first handshake after a
CRL change log "CRL: cannot rea=
d CRL from file" for a CRL it loaded fine
(GitHub #1103); since then the re=
load reports it at D_LOW as "CRL:
OpenSSL error queue not empty on CRL load=
" and clears it=2E

Return NULL for "none" before touching OpenSSL, as ciph=
er_kt_name()
already does=2E Real cipher names behave as before, and
cipher=
_valid_reason() still finds the OpenSSL reason on the queue when
it reports=
 an unknown cipher=2E

Left alone on purpose: cipher_kt_block_size()'s prob=
e for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 -> "CHACHA20-CBC=
") and
md_valid() leave the same kind of entry, but neither runs between
cl=
ient instance creation and the CRL reload=2E

With this change the queue is=
 empty when the CRL reload runs for UDP
and TCP clients, and CRL replacemen=
ts give clean reloads with no
"error queue not empty" report (current maste=
r: one per replacement)=2E

Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0=
e2438
Signed-off-by: Drew Blokzyl <drew@linuxkids=2Ecom>
Acked-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1950
Message-Id: <20261103192732=2E13656-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40626=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/crypto_openssl=2Ec
1 file changed, 9 insertions(+)=
, 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/50/1950/4

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/ope=
nvpn/crypto_openssl=2Ec
index 3c708c2=2E=2Eb7f2ef3 100644
--- a/src/openvpn=
/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -569,6 +569,15 =
@@
 {
     ASSERT(ciphername);
 
+    /* "none" is a valid OpenVPN cipher n=
ame that OpenSSL does not know=2E
+     * Return NULL without asking OpenSS=
L: a failed EVP_CIPHER_fetch() would
+     * leave an "unsupported" entry o=
n the error queue that the cipher_kt_*()
+     * callers never clear=2E */
=
+    if (strcmp("none", ciphername) =3D=3D 0)
+    {
+        return NULL;
=
+    }
+
     ciphername =3D translate_cipher_name_from_openvpn(ciphername)=
;
     return EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e=
345a0e2438
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 4
Gerrit-Owner: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--Z2MeoSdIVDM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/195=
0?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Do =
not look up the &quot;none&quot; cipher in OpenSSL<br><br>cipher_get() hand=
s EVP_CIPHER_fetch() whatever name it is given, and the<br>callers that onl=
y ask whether a cipher exists or which mode it has<br>(cipher_kt_mode_cbc/o=
fb_cfb/aead(), cipher_kt_block_size(),<br>cipher_kt_insecure()) treat NULL =
as &quot;not that&quot;=2E For the &quot;none&quot; cipher<br>that is the e=
xpected answer, but under OpenSSL 3 the failed fetch also<br>pushes EVP_R_U=
NSUPPORTED (&quot;digital envelope routines::unsupported,<br>Algorithm (non=
e : 0)&quot;) onto the thread&#39;s error queue, and nothing pops<br>it=2E<=
br><br>&quot;none&quot; is what every server without --cipher carries in it=
s<br>pre-negotiation key_type: the legacy BF-CBC default is not in<br>--dat=
a-ciphers, so do_init_crypto_tls() initialises the key_type with<br>cipher =
&quot;none&quot;=2E Each new client instance walks it in init_instance() -&=
gt;<br>do_init_crypto_tls() -&gt; cipher_kt_mode_ofb_cfb(&quot;none&quot;) =
and in the frame<br>and OCC calculations, and tls_ctx_reload_crl() runs rig=
ht after=2E Before<br>commit 15a1465f (&quot;Make CRL reload EOF detection =
independent of stale<br>error queue entries&quot;) that stale entry made th=
e first handshake after a<br>CRL change log &quot;CRL: cannot read CRL from=
 file&quot; for a CRL it loaded fine<br>(GitHub #1103); since then the relo=
ad reports it at D_LOW as &quot;CRL:<br>OpenSSL error queue not empty on CR=
L load&quot; and clears it=2E<br><br>Return NULL for &quot;none&quot; befor=
e touching OpenSSL, as cipher_kt_name()<br>already does=2E Real cipher name=
s behave as before, and<br>cipher_valid_reason() still finds the OpenSSL re=
ason on the queue when<br>it reports an unknown cipher=2E<br><br>Left alone=
 on purpose: cipher_kt_block_size()&#39;s probe for the CBC<br>sibling of a=
n AEAD cipher (CHACHA20-POLY1305 -&gt; &quot;CHACHA20-CBC&quot;) and<br>md_=
valid() leave the same kind of entry, but neither runs between<br>client in=
stance creation and the CRL reload=2E<br><br>With this change the queue is =
empty when the CRL reload runs for UDP<br>and TCP clients, and CRL replacem=
ents give clean reloads with no<br>&quot;error queue not empty&quot; report=
 (current master: one per replacement)=2E<br><br>Change-Id: I440c4c73865fdb=
d80f2c607e83c50e345a0e2438<br>Signed-off-by: Drew Blokzyl &lt;drew@linuxkid=
s=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950<br>Message-Id: &=
lt;20261103192732=2E13656-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40626=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/crypto_openssl=2Ec<br>1 file changed, 9 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/50/1950/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypt=
o_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 3c708c=
2=2E=2Eb7f2ef3 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec<=
/span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -56=
9,6 +569,15 @@</span><br><span> {</span><br><span>     ASSERT(ciphername);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* &quot;none&quot; is a valid OpenVPN cipher name that OpenSSL does not =
know=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Retur=
n NULL without asking OpenSSL: a failed EVP_CIPHER_fetch() would</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * leave an &quot;unsuppor=
ted&quot; entry on the error queue that the cipher_kt_*()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * callers never clear=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(&quot;non=
e&quot;, ciphername) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     ciphername =3D translate_cipher_name_from_openvpn(ciphername);</span>=
<br><span>     return EVP_CIPHER_fetch(NULL, ciphername, NULL);</span><br><=
span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1950?usp=3Demail">change 1950</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I440c4c73865fdbd80f2c60=
7e83c50e345a0e2438 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1950 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--Z2MeoSdIVDM=--


--===============1234582861315776183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1234582861315776183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1234582861315776183==--


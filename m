Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7D4C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=FFBpeBa6dJGti6kTevYiC/aZ4aFPS40YBIztnicuGlc=; b=CLLnkQtgpev+q9
	oePO8KFxuzSXTGclvbk8XCed13/hkb30uFd6uo97cylMgLh61sQMmJw8mm5G0dI54iWz2EJGj+AIR
	nG1AkHOh9WLcZuZM9zmlGTYIjaKfcDm+0yZvRMUSn9LssWjNiS4k7MugdYShgVsLdGlyYMkF0kDtO
	NwI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6NQt-0004hj-BO;
	Tue, 15 Sep 2026 07:18:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6NQq-0004hb-Ar
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I2adhwi2I7b75bmZlzL214TX9o9aea4D1wuf5Pg1VaU=; b=hR5CrVyIdodXNZU8P3FYKEHlTk
 ku1Ph3c3YTFH76xnWUcKD5c9icaUym2wgG9MmDLSld0iJJol1F5p7JUeoPWD85nk/yfXX/hGXDw75
 8CMf7DdPeNKdl6+l12UM+RC1Cyo8Qi8Owh8bs5SwSDBkPf7fLgviE/g4/pcs4xDNoSlE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I2adhwi2I7b75bmZlzL214TX9o9aea4D1wuf5Pg1VaU=; b=k
 a241b38QU4pIsa+JQHsfskXedfzOCP2t1ks/CAnngpD/SET6r91PZE4cKGHg3kIzFVmSXykXJVj3G
 SwX3eYsZ6/oa2YSZ7Zufr8TZ6/YuRcPf2FNQTbxr1w+zMQrJHby+DhczXr1Rn+sYWoTAVsoL1wupV
 uWf831gfTsJ44THQ=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6NQq-0008UI-5T for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:18:20 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so1439315f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789456694; x=1790061494; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I2adhwi2I7b75bmZlzL214TX9o9aea4D1wuf5Pg1VaU=;
 b=BUy9XBNI/EjEy6rr41o/zd5lDpHlOdO46EAbrjYa8kXkojI8ilbZSljVyc2f927DAJ
 tO1w33qDTLNPXMNBQkm8c6Hx13QOiyylr0vNckpofwv73HX9wpMuqd8X4Ex/YH+R9o8P
 0HztUXYjzneZ4lnGlrvpr3VgTtXh4OXoYWNNI+ttA1G9mwh+3Mh6a6NOrYx8axAxiK/0
 0+Rtq37qd7cyfPG57H5Lw0IAuKYTeAFxKSoEGDKgAeTFfXp2IVju8/n7chvVVoSpm7Iw
 6ljGEZmxakQY5HRfqFaYXmepHM2uVWCJFpUlyv5NDFFksv8E/zeC0C1QcOhxaCuARdH1
 JD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789456694; x=1790061494;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I2adhwi2I7b75bmZlzL214TX9o9aea4D1wuf5Pg1VaU=;
 b=c2/zU88LUdVOmcnxqUmj+oslWn17LLwzQ6ekI8e8X620Bbt59yQ+y106/x9nE/Al/v
 yeFFciG1F5naiBb7G5ElxZP5WoXmhOM1dilTYLVb/SIzFnRyNWz0ilW3ODMCvzWTKTO6
 02pmTY+uorXf3YKpfr7IpYk0BQ800Vz/MyAwCnOC7ZW/3xFeAYuZrnFNNDnJ0eQ0Qzvp
 Hc0JHfHlE8WLTmiO+bDMvUXIEncwdEcueeeSicXZaHF2YExz/RI0ivxofrtmNCdjKBYs
 jkfsY8Mzscli+jq5L98tgjcaZfs5wqkXIiZyZ3brUr4KBhauygKSK/U9r6VutIb1iI+g
 rCYA==
X-Gm-Message-State: AFuF++kVh/p+9sR3OdaR5lbdNq6kwMx+unBQlTB/6LnCY3+XFfwaqlCX
 Xn9XQofXQP5EGYEeCKDkTEjou0QQAWd7oYI5U5VdzW8EAusTAOZVuRDk3KdPCEzws3g+bGRhPNA
 GsTvhsOdSx1xvwutDdROY0updDKDgOpZJ76NDVOqKZUma3Jkxg4HJunK+MNUcJSO4o+uh2+O110
 6yhdZEiQ==
X-Gm-Gg: AYBFou3KTncQhq58TSfG5XwchPa08UI+aQWmVm/JbdXJtr04003nc7DQyqp++S8RhbD
 N7PlKgoSmuZruBiA+GNnMy4CWcGPdJp10y+aorMRAVDF2VKtIdcM3nWyfi8piGMTWe9Br8s1ExF
 Logf0DhEEPIldOFlxIFP3K6asDYcBXzNrOia+wknue4xpLFrAVC+3zMn4mNETXbKUPBiAti9QEJ
 o8bxFO64Jv8A1sUaWFyaLEcYURjSOzBlBLaNkSyup2/0dA303zg/Km2kL/WmRL199Scme4sWdXn
 R0t5yEpsYOnVl1JTpF0pgCkhX1LCguJtfIHtgITlSkVKTxVk7DPRcYlNGgHvuGkrnL8o+cnKw9B
 2C+v7QhRnLVUZ/CYjYVAgxmhPdDtBphCneXePK/SgPft4Lffxv0ALHJUHudNGMM0zJx9iMwHFX3
 YDXaWtUFPohsdAeWWn55Y0YHcedg6RDf0gyLOaAQ3Tp18wP+ZiWedcSYtVRnSy1QCiZvSHL55Q1
 OdKDoKJ06YuDDo1iQ2nHo7CtwOaMJCdVNn7q+KLuGyOT2lRAYZ/xRKkoPJTVkSwCSmPHRMjUlyG
 UGk4jBZYiaN+QU6QzRRR2Z8AICtMF3ETFOXIZvB21AbjaZnpNWLdnal83kNeBg==
X-Received: by 2002:a05:6000:4811:b0:487:210:ce1a with SMTP id
 ffacd0b85a97d-48702a9a3f3mr6971806f8f.1.1789456693466; 
 Tue, 15 Sep 2026 00:18:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f301121asm27124971f8f.0.2026.09.15.00.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:18:13 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 07:18:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5e038f577838cd050300fc39be6d2c3f67a51f2c
X-Gerrit-Change-Number: 1917
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1917?usp=email>
X-Gerrit-Commit: 6d7c7fd7037d9ed1221b0efdb52acfd9167fa3e6
References: <gerrit.1789456688000.I5e038f577838cd050300fc39be6d2c3f67a51f2c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLkk1ZTAzOGY1Nzc4MzhjZDA1MDMwMGZjMzliZTZkMmMzZjY3YTUxZjJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5dabfb91165f311dfd0616a660b9ecefb69c3ebc-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6NQq-0008UI-5T
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tests: check that we
 only append a WKc we actually have
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7639698419908981787=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7639698419908981787==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R94aR7EZhf8="; charset=UTF-8

--R94aR7EZhf8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1917?usp=3Demail

to review the following change=2E


Chang=
e subject: tests: check that we only append a WKc we actually have
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: check that w=
e only append a WKc we actually have

tls_reset_standalone() drives tls_wra=
p_control() directly, so use it to
build the two control packets that carry=
 a wrapped client key with
tls_crypt_v2_wkc unset=2E Without the previous c=
ommit both segfault=2E Also
check that the key is still appended when we do=
 have one=2E

Change-Id: I5e038f577838cd050300fc39be6d2c3f67a51f2c
Signed-o=
ff-by: Lev Stipakov <lev@openvpn=2Enet>
---
M tests/unit_tests/openvpn/test=
_pkt=2Ec
1 file changed, 47 insertions(+), 0 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/1917/1

diff --git =
a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=
=2Ec
index a732c2b=2E=2E51c73d8 100644
--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -695,6 +695,52 @@
  =
   free_tas(&tas_server);
 }
 
+/* A peer can ask us to append the wrapped =
client key (WKc) to our next
+ * control packet=2E Only a tls-crypt-v2 clie=
nt has one, so check that we
+ * refuse to build such a packet when we have=
 no key instead of walking
+ * into the NULL pointer=2E */
+static void
+te=
st_wkc_not_appended_without_key(void **ut_state)
+{
+    struct tls_auth_st=
andalone tas =3D init_tas_crypt(false);
+    struct session_id own_id =3D {=
 { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    struct session_id remote_id =3D { { 8, =
7, 6, 5, 4, 3, 2, 1 } };
+    struct frame frame =3D { =2Ebuf =3D { =2Ehead=
room =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
=
+
+    packet_id_init(&tas=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", =
0);
+    reset_packet_id_send(&tas=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+ =
   now =3D 0x22446688;
+
+    /* no WKc configured, so both opcodes that wo=
uld append one must fail */
+    assert_null(tas=2Etls_wrap=2Etls_crypt_v2_=
wkc);
+
+    uint8_t header =3D 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+=
    struct buffer buf =3D
+        tls_reset_standalone(&tas=2Etls_wrap, &t=
as, &own_id, &remote_id, header, false);
+    assert_int_equal(BLEN(&buf), =
0);
+
+    header =3D 0 | (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT=
);
+    buf =3D tls_reset_standalone(&tas=2Etls_wrap, &tas, &own_id, &remot=
e_id, header, false);
+    assert_int_equal(BLEN(&buf), 0);
+
+    /* with =
a WKc the same packet is built and the key ends up at its end */
+    uint8=
_t wkc_data[32];
+    memset(wkc_data, 0x5a, sizeof(wkc_data));
+    struct=
 buffer wkc =3D alloc_buf(sizeof(wkc_data));
+    assert_true(buf_write(&wk=
c, wkc_data, sizeof(wkc_data)));
+    tas=2Etls_wrap=2Etls_crypt_v2_wkc =3D=
 &wkc;
+
+    header =3D 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    buf=
 =3D tls_reset_standalone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, heade=
r, false);
+    assert_true(BLEN(&buf) > (int)sizeof(wkc_data));
+    asser=
t_memory_equal(BPTR(&buf) + BLEN(&buf) - sizeof(wkc_data), wkc_data, sizeof=
(wkc_data));
+
+    free_buf(&wkc);
+    packet_id_free(&tas=2Etls_wrap=2Eo=
pt=2Epacket_id);
+    free_tas(&tas);
+}
+
 static void
 test_extract_contr=
ol_message(void **ut_state)
 {
@@ -745,6 +791,7 @@
         cmocka_unit_tes=
t(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_g=
enerate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_=
packet_tls_auth),
+        cmocka_unit_test(test_wkc_not_appended_without_k=
ey),
         cmocka_unit_test(test_extract_control_message)
     };
 

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1917?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e038f577838cd050300fc=
39be6d2c3f67a51f2c
Gerrit-Change-Number: 1917
Gerrit-PatchSet: 1
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--R94aR7EZhf8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1917?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">te=
sts: check that we only append a WKc we actually have<br><br>tls_reset_stan=
dalone() drives tls_wrap_control() directly, so use it to<br>build the two =
control packets that carry a wrapped client key with<br>tls_crypt_v2_wkc un=
set=2E Without the previous commit both segfault=2E Also<br>check that the =
key is still appended when we do have one=2E<br><br>Change-Id: I5e038f57783=
8cd050300fc39be6d2c3f67a51f2c<br>Signed-off-by: Lev Stipakov &lt;lev@openvp=
n=2Enet&gt;<br>---<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>1 file cha=
nged, 47 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/1917/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>index a732c2b=2E=2E51c73d8 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -695,6 +695,52 @@</sp=
an><br><span>     free_tas(&amp;tas_server);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A peer can=
 ask us to append the wrapped client key (WKc) to our next</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * control packet=2E Only a tls-cryp=
t-v2 client has one, so check that we</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * refuse to build such a packet when we have no key inst=
ead of walking</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in=
to the NULL pointer=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_wkc_not_appended_without_key(void **ut_state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct tls_auth_standalone tas =3D init_tas_crypt(false);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id =
own_id =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct session_id remote_id =3D { { 8, 7, 6, 5, =
4, 3, 2, 1 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =
=3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 tas=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_i=
nit(&amp;tas=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_=
send(&amp;tas=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* no WKc configured, so both opcodes that would app=
end one must fail */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(tas=2Etls_wrap=2Etls_crypt_v2_wkc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t header =3D 0 | (P_CONTROL_WKC_V1 &lt;&lt; P_OPCO=
DE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;=
remote_id, header, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    header =3D 0 | (P_CONTROL_HARD_RESET_CLIENT_V3 &lt;&lt; P_OPCO=
DE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =
=3D tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;r=
emote_id, header, false);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* with a WKc the same packet is built and the key ends up at i=
ts end */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_=
t wkc_data[32];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
memset(wkc_data, 0x5a, sizeof(wkc_data));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer wkc =3D alloc_buf(sizeof(wkc_data))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(bu=
f_write(&amp;wkc, wkc_data, sizeof(wkc_data)));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;=
wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    header =3D 0 | (P_CONTROL_WKC_=
V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf =3D tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &a=
mp;own_id, &amp;remote_id, header, false);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(BLEN(&amp;buf) &gt; (int)sizeof(wkc_=
data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_m=
emory_equal(BPTR(&amp;buf) + BLEN(&amp;buf) - sizeof(wkc_data), wkc_data, s=
izeof(wkc_data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;wkc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_fre=
e(&amp;tas=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    free_tas(&amp;tas);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> static void</span><br><span> test_extract_control=
_message(void **ut_state)</span><br><span> {</span><br><span>@@ -745,6 +791=
,7 @@</span><br><span>         cmocka_unit_test(test_verify_hmac_none_out_o=
f_range_ack),</span><br><span>         cmocka_unit_test(test_generate_reset=
_packet_plain),</span><br><span>         cmocka_unit_test(test_generate_res=
et_packet_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_wkc_not_appended_without_key),</span><br><sp=
an>         cmocka_unit_test(test_extract_control_message)</span><br><span>=
     };</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1917?usp=3Demail">ch=
ange 1917</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1917?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I5e038f577838cd050300fc39be6d2c3f67a51f2c </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1917 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--R94aR7EZhf8=--


--===============7639698419908981787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7639698419908981787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7639698419908981787==--


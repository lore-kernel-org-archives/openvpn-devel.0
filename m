Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FBBC982D2
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1s+MlFlX8xHa/d+ZOQcx41Fe5phQnQ722rBrSwn70A=; b=KaBB6w/uyBQ5ucTLmbuOXvh93M
	5l1G94WR7aIBzk3hkoeSzI5dAvu1lJkgFREsVjCFgoLi76PpyfRH5Hl6dL65yjPHKu9Rw6QOMUkw1
	5NHHj+dxqfhPbf/xBUkWWGNuLjvm2BJsxEf9SiXi6hP0mBMyVwJ/vsh01jYYJgLRQaig=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7FcO-0007fI-8P;
	Thu, 17 Sep 2026 17:09:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7FcM-0007f4-HR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=O0B+T9clxRMy/cpr8fN+GP/6rPZucSzFJGfFqvACORc=; b=Sh4s37AGLa/SeXwnljlzSXg22v
 V4g68NfebC1FGYZH1jwy+0GlyHKn0DbaDvUf8A2x2vJlVjHiJAlBNVvGKBZdoPZEgl/Un51HL9POh
 2hsecMsCPlDUD4MA5A9blaWXM8Y2cpnMJDZ64IGjagk+ymEPU5v9/eZ/FYysDPQrpcWk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O0B+T9clxRMy/cpr8fN+GP/6rPZucSzFJGfFqvACORc=; b=Q
 Mk3ShqdM8/ojXzNzb7fYLX0pnD3lMApej1VlFFKWbEyccjcAG3D3Mbrik5I0Jq5YmpfNyzfJF2F4f
 xdoa78cIW9bsXM925E7oCuRt/mBSP/SGvE/27rRdQ+6DtWLdLj/J+Bf4ix6Qd8nDcgsBMRVO68w6u
 mls5+x1SUEU4En3Y=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7FcL-0006gz-MZ for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:09:51 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so860412f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789664983; x=1790269783; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O0B+T9clxRMy/cpr8fN+GP/6rPZucSzFJGfFqvACORc=;
 b=Tog3vwUR3isHvtDHmKm3bTLYBsFv5xZP3t9FeSHRrk6m3LOWI1NyC8a2YrDwBPyN1h
 xSyU7Wm/KYL2FRieRb+IKiqcQ65c36AvLXOXqJ+RJJfi82sB4ik6JWc9MequJp7j4WaT
 Kx0eDoZ53UyiEcNXVu42OMYg4qPboeXu3VEZ0Krt5oPKXYwu/f9se2+DR6nU2WPJYrAN
 U4eZCmNhI0JRPORYIG4LRhd1rfCj6CMDFyAklQ9pY2KE3A9xvOSs1pmW+KjxXcMtV9cD
 AjzeUwP+fjfVFTabTgJef7wDfalQmwi7h3ure5Bd9LulS4EADT9rG362tFZoTifu5rdF
 XyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664983; x=1790269783;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O0B+T9clxRMy/cpr8fN+GP/6rPZucSzFJGfFqvACORc=;
 b=vQwMHVPu2sSslOYfh6fk/m0LjtFpY5k9QPweLIzzEgWuvigYoNRVqlq5kY5fURJGKo
 Efwd+j0GC3KgKU0XAOOjb2bc/na+EVtjqaFHvnpnjMhpfpQI+eh6/JPzWqsVTmrnCW1W
 Z2akCq6AobR3g29IALjqvFKcy5+3+mbLg2Zl9vEw9zE2OWYCVPEzN1p7lOuSGYmwz2Hd
 eiTsPaVdqFOT2AXVH3v+KLsvnqz+e1vgBk+SnQRK9sLPkBx5tF7Qhzg2gOP6gF/oGbil
 4p46y7BCnKCAjpSYOCkU4wxuV4KHi0XEYxUQWUGjhBkz+4P5ziTtdSoNFWCk/oSzXc2a
 1LUg==
X-Gm-Message-State: AFuF++kxx2WV4EMaFwosn+W+lgtWGImP6i0X8AORp/mYgNoTS5zvtM6O
 kg3wl7taekIYlE1o8jeHo3GMKomwPNHVh0E5QSGzh62tzKpRXz7/cA+BvUKXQh5bMTRUt8R+AlZ
 N/lezLm33D0RnmKBBavoz322xnrDoz8V9tXtA7QshMziB7RSqAhDjBn1BYLgh/zbIRhGZzFsWim
 X0NxKhTg==
X-Gm-Gg: AYBFou3aKBYQ7l67m0X5Kj5DE7+DUX4dl7bdbhaqtXHBTh0gk05LqKAKC/RJv6OS+cx
 HivkHnzyBdd2i1PJNST6BI75vrpNXAzxeGJiITM3PsdVEMrqdHwwcQrk9rjFsQ0eYbRZEmZKKtR
 ifcy2bU1rsN5FEBskJxNoPAw2RSJeIyY/uE+c6rY35CSoWTyLrd3mBWF77vL0E29j0LPm4TDRDb
 d7lTFrmqHCt/HxEm7i1bzJo0mPnTGQFD43bV1h+55CKj2fRBDQ1hQNWrjg03iMwWam9byxtNh5T
 Lpro+V7Qp8jt2Aw78kNkqZHPnzJhMNyRiai5GO/uMeHt2XmjvUVz/nXZi+9AU3HLA7uGl5dtQE/
 9gVi/KZWw995+Ys3dFRAE1+7PQ6msSpXKOE5s1G0lplTE0nrKTlmqRpgtBU5Hw8fDGuskxKDgIH
 bk5evCFn6YVHDpdcigOMOBijPQ7EMnrmV6R5Dz4wPnSxQJa8pHR9BbkYmqKctC/zr1JtWBSd3/3
 Gv/litQQ61rK8lhjsvyBzFanQyY4ORatU7YCMZ8j4VYJPnjyqX2rjy3tPq7pEozOhULGQs630uV
 2mFh6F82lsxGiIU9qTwogKRmqwifsOVNAkfL/MpkP4ZNFUmKHRNCz/adskqw1g==
X-Received: by 2002:a05:6000:41f6:b0:486:f767:8be9 with SMTP id
 ffacd0b85a97d-4870cee4697mr11192701f8f.10.1789664982948; 
 Thu, 17 Sep 2026 10:09:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf43511sm16043056f8f.33.2026.09.17.10.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:09:42 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 17:09:41 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: bc7f77ea2b6a8e5d964f6cbb403e6bbf1fe77fa4
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee855aa002fe6cc846706b45f638eaf02a196b31-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7FcL-0006gz-MZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: do not trust
 the peer's request to resend the wrapped client key
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4549431517962668205=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4549431517962668205==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wRVJuCUwaKM="; charset=UTF-8

--wRVJuCUwaKM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by plai=
sthos


Change subject: ssl: do not trust the peer's request to resend the =
wrapped client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

ssl: do not trust the peer's request to resend the wrapped client k=
ey

parse_early_negotiation_tlvs() sets CO_RESEND_WKC just because the peer=

set EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without checking that
t=
his client has a wrapped client key at all=2E control_packet_needs_wkc()
th=
en reports that our first control packet needs the key appended and
write_o=
utgoing_tls_ciphertext() sizes it with

    maxlen -=3D buf_len(session->tl=
s_wrap=2Etls_crypt_v2_wkc);

tls_crypt_v2_wkc is only set with --tls-crypt-=
v2 and buf_len() is not
NULL-safe, so a client without --tls-crypt-v2 dies =
with SIGSEGV while
processing the server's first reset packet, before the p=
eer has been
authenticated=2E

Only set the flag if we have a key to resend=
, and let tls_wrap_control()
refuse to append a key it does not have=2E

tl=
s_reset_standalone() drives tls_wrap_control() directly, so the test
uses i=
t to build the two control packets that carry a wrapped client key
with tls=
_crypt_v2_wkc unset=2E Both segfault without the fix=2E

Github: OpenVPN/op=
envpn-private-issues#181
Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45c=
b4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1916
Message-Id: <20260916203212=2E21285-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg39268=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M tests/unit_tests/openv=
pn/test_pkt=2Ec
3 files changed, 62 insertions(+), 4 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/1916/4

diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 76150d4=2E=2Eddbf0=
67 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2591,7 +2=
591,8 @@
  * Parses the TLVs (type, length, value) in the early negotiation=

  */
 static bool
-parse_early_negotiation_tlvs(struct buffer *buf, struct=
 key_state *ks)
+parse_early_negotiation_tlvs(struct buffer *buf, const str=
uct tls_session *session,
+                             struct key_state *k=
s)
 {
     while (buf->len > 0)
     {
@@ -2618,7 +2619,17 @@
 
           =
      if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
-          =
          ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+                 =
   /* Only accept the EARLY_NEG_FLAG_RESEND_WKC flag
+                     =
* from the server if we are configured with tls-crypt-v2 */
+              =
      if (session->tls_wrap=2Etls_crypt_v2_wkc)
+                    {
+   =
                     ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+      =
              }
+                    else
+                    {
+         =
               msg(D_TLS_ERRORS, "TLS Error: peer asked us to resend the wr=
apped "
+                                          "client key, but this is=
 not a tls-crypt-v2 client");
+                    }
                 }
   =
              break;
 
@@ -2901,7 +2912,7 @@
          * contains early pro=
tocol negotiation */
         if (entry->packet_id =3D=3D 0 && is_hard_rese=
t_method2(entry->opcode))
         {
-            if (!parse_early_negotiat=
ion_tlvs(&entry->buf, ks))
+            if (!parse_early_negotiation_tlvs(&=
entry->buf, session, ks))
             {
                 goto error;
     =
        }
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
in=
dex 90b2aec=2E=2E940f089 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/ope=
nvpn/ssl_pkt=2Ec
@@ -147,7 +147,7 @@
         if ((header >> P_OPCODE_SHIFT=
) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
             || (header >> P_OPCODE=
_SHIFT) =3D=3D P_CONTROL_WKC_V1)
         {
-            if (!buf_copy(&ctx=
->work, ctx->tls_crypt_v2_wkc))
+            if (!ctx->tls_crypt_v2_wkc || =
!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
              =
   msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 client key");
         =
        buf->len =3D 0;
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec =
b/tests/unit_tests/openvpn/test_pkt=2Ec
index a732c2b=2E=2E51c73d8 100644
-=
-- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_pkt=2Ec
@@ -695,6 +695,52 @@
     free_tas(&tas_server);
 }
 
+/* A pee=
r can ask us to append the wrapped client key (WKc) to our next
+ * control=
 packet=2E Only a tls-crypt-v2 client has one, so check that we
+ * refuse =
to build such a packet when we have no key instead of walking
+ * into the =
NULL pointer=2E */
+static void
+test_wkc_not_appended_without_key(void **u=
t_state)
+{
+    struct tls_auth_standalone tas =3D init_tas_crypt(false);
=
+    struct session_id own_id =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    stru=
ct session_id remote_id =3D { { 8, 7, 6, 5, 4, 3, 2, 1 } };
+    struct fra=
me frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }=
, 0 };
+    tas=2Eframe =3D frame;
+
+    packet_id_init(&tas=2Etls_wrap=2E=
opt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas=2Etls=
_wrap=2Eopt=2Epacket_id=2Esend);
+    now =3D 0x22446688;
+
+    /* no WKc =
configured, so both opcodes that would append one must fail */
+    assert_=
null(tas=2Etls_wrap=2Etls_crypt_v2_wkc);
+
+    uint8_t header =3D 0 | (P_C=
ONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    struct buffer buf =3D
+        tls_r=
eset_standalone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, header, false);=

+    assert_int_equal(BLEN(&buf), 0);
+
+    header =3D 0 | (P_CONTROL_HAR=
D_RESET_CLIENT_V3 << P_OPCODE_SHIFT);
+    buf =3D tls_reset_standalone(&ta=
s=2Etls_wrap, &tas, &own_id, &remote_id, header, false);
+    assert_int_eq=
ual(BLEN(&buf), 0);
+
+    /* with a WKc the same packet is built and the k=
ey ends up at its end */
+    uint8_t wkc_data[32];
+    memset(wkc_data, 0=
x5a, sizeof(wkc_data));
+    struct buffer wkc =3D alloc_buf(sizeof(wkc_dat=
a));
+    assert_true(buf_write(&wkc, wkc_data, sizeof(wkc_data)));
+    ta=
s=2Etls_wrap=2Etls_crypt_v2_wkc =3D &wkc;
+
+    header =3D 0 | (P_CONTROL_=
WKC_V1 << P_OPCODE_SHIFT);
+    buf =3D tls_reset_standalone(&tas=2Etls_wra=
p, &tas, &own_id, &remote_id, header, false);
+    assert_true(BLEN(&buf) >=
 (int)sizeof(wkc_data));
+    assert_memory_equal(BPTR(&buf) + BLEN(&buf) -=
 sizeof(wkc_data), wkc_data, sizeof(wkc_data));
+
+    free_buf(&wkc);
+   =
 packet_id_free(&tas=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas);
+}=

+
 static void
 test_extract_control_message(void **ut_state)
 {
@@ -745,6=
 +791,7 @@
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack=
),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cm=
ocka_unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_t=
est(test_wkc_not_appended_without_key),
         cmocka_unit_test(test_extr=
act_control_message)
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1916?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Gerrit-Change-Numb=
er: 1916
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--wRVJuCUwaKM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">ssl: do not trust the peer&#3=
9;s request to resend the wrapped client key<br><br>parse_early_negotiation=
_tlvs() sets CO_RESEND_WKC just because the peer<br>set EARLY_NEG_FLAG_RESE=
ND_WKC in its reset packet, without checking that<br>this client has a wrap=
ped client key at all=2E control_packet_needs_wkc()<br>then reports that ou=
r first control packet needs the key appended and<br>write_outgoing_tls_cip=
hertext() sizes it with<br><br>    maxlen -=3D buf_len(session-&gt;tls_wrap=
=2Etls_crypt_v2_wkc);<br><br>tls_crypt_v2_wkc is only set with --tls-crypt-=
v2 and buf_len() is not<br>NULL-safe, so a client without --tls-crypt-v2 di=
es with SIGSEGV while<br>processing the server&#39;s first reset packet, be=
fore the peer has been<br>authenticated=2E<br><br>Only set the flag if we h=
ave a key to resend, and let tls_wrap_control()<br>refuse to append a key i=
t does not have=2E<br><br>tls_reset_standalone() drives tls_wrap_control() =
directly, so the test<br>uses it to build the two control packets that carr=
y a wrapped client key<br>with tls_crypt_v2_wkc unset=2E Both segfault with=
out the fix=2E<br><br>Github: OpenVPN/openvpn-private-issues#181<br>Change-=
Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4<br>Signed-off-by: Lev Stipako=
v &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/191=
6<br>Message-Id: &lt;20260916203212=2E21285-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39268=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>=
M tests/unit_tests/openvpn/test_pkt=2Ec<br>3 files changed, 62 insertions(+=
), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/16/1916/4</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 76150d4=2E=2Eddbf067=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -2591,7 +2591,8 @@</span><br><span>  * =
Parses the TLVs (type, length, value) in the early negotiation</span><br><s=
pan>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-parse_early_negotiation_tlvs(struct buffer *buf, struct key=
_state *ks)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_ea=
rly_negotiation_tlvs(struct buffer *buf, const struct tls_session *session,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
          struct key_state *ks)</span><br><span> {</span><br><span>     whi=
le (buf-&gt;len &gt; 0)</span><br><span>     {</span><br><span>@@ -2618,7 +=
2619,17 @@</span><br><span> </span><br><span>                 if (flags &am=
p; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                 {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    ks-&gt;crypt=
o_options=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    /* Only accept the EARLY_NEG_FLAG_RES=
END_WKC flag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              * from the server if we are configured with tls-crypt-v2 */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
f (session-&gt;tls_wrap=2Etls_crypt_v2_wkc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        ks-&gt;crypto_options=2Ef=
lags |=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        msg(D_TLS_ERRORS, &quot;TLS Error: pe=
er asked us to resend the wrapped &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                          &quot;client=
 key, but this is not a tls-crypt-v2 client&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span>   =
              }</span><br><span>                 break;</span><br><span> </=
span><br><span>@@ -2901,7 +2912,7 @@</span><br><span>          * contains e=
arly protocol negotiation */</span><br><span>         if (entry-&gt;packet_=
id =3D=3D 0 &amp;&amp; is_hard_reset_method2(entry-&gt;opcode))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (!parse_early_negotiation_tlvs(&amp;entry-&gt;buf, ks))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (!parse_early_n=
egotiation_tlvs(&amp;entry-&gt;buf, session, ks))</span><br><span>         =
    {</span><br><span>                 goto error;</span><br><span>        =
     }</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/s=
sl_pkt=2Ec</span><br><span>index 90b2aec=2E=2E940f089 100644</span><br><spa=
n>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Ec</span><br><span>@@ -147,7 +147,7 @@</span><br><span>         if ((head=
er &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br=
><span>             || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WK=
C_V1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v=
2_wkc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!ctx-&gt;tls_crypt_v2_wkc || !buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_c=
rypt_v2_wkc))</span><br><span>             {</span><br><span>              =
   msg(D_TLS_ERRORS, &quot;Could not append tls-crypt-v2 client key&quot;);=
</span><br><span>                 buf-&gt;len =3D 0;</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/tes=
t_pkt=2Ec</span><br><span>index a732c2b=2E=2E51c73d8 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -695,6 +695,52 @@</span><b=
r><span>     free_tas(&amp;tas_server);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A peer can ask =
us to append the wrapped client key (WKc) to our next</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * control packet=2E Only a tls-crypt-v2 =
client has one, so check that we</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * refuse to build such a packet when we have no key instead o=
f walking</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * into th=
e NULL pointer=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_wk=
c_not_appended_without_key(void **ut_state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tls_auth_standalone tas =3D init_tas_crypt(false);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id own_i=
d =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct session_id remote_id =3D { { 8, 7, 6, 5, 4, 3,=
 2, 1 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1=
400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=
=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(=
&amp;tas=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send=
(&amp;tas=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* no WKc configured, so both opcodes that would append =
one must fail */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_null(tas=2Etls_wrap=2Etls_crypt_v2_wkc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint8_t header =3D 0 | (P_CONTROL_WKC_V1 &lt;&lt; P_OPCODE_SH=
IFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;remot=
e_id, header, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    header =3D 0 | (P_CONTROL_HARD_RESET_CLIENT_V3 &lt;&lt; P_OPCODE_SH=
IFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D tl=
s_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;remote_=
id, header, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* with a WKc the same packet is built and the key ends up at its end=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t wkc_=
data[32];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset=
(wkc_data, 0x5a, sizeof(wkc_data));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer wkc =3D alloc_buf(sizeof(wkc_data));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_writ=
e(&amp;wkc, wkc_data, sizeof(wkc_data)));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tas=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;wkc;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    header =3D 0 | (P_CONTROL_WKC_V1 &lt=
;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf =3D tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own=
_id, &amp;remote_id, header, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(BLEN(&amp;buf) &gt; (int)sizeof(wkc_data))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_=
equal(BPTR(&amp;buf) + BLEN(&amp;buf) - sizeof(wkc_data), wkc_data, sizeof(=
wkc_data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;wkc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp=
;tas=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free_tas(&amp;tas);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> static void</span><br><span> test_extract_control_messa=
ge(void **ut_state)</span><br><span> {</span><br><span>@@ -745,6 +791,7 @@<=
/span><br><span>         cmocka_unit_test(test_verify_hmac_none_out_of_rang=
e_ack),</span><br><span>         cmocka_unit_test(test_generate_reset_packe=
t_plain),</span><br><span>         cmocka_unit_test(test_generate_reset_pac=
ket_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_wkc_not_appended_without_key),</span><br><span>   =
      cmocka_unit_test(test_extract_control_message)</span><br><span>     }=
;</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail">change 1=
916</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1916 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--wRVJuCUwaKM=--


--===============4549431517962668205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4549431517962668205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4549431517962668205==--


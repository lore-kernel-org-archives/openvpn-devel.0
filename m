Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02EBC982D6
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HzEGAGskxXEw967wLHMy4ef4yl3zzVpDkIrlKpRhW0=; b=hlmOYod3iFTczoP1vj8w5PGxTu
	HxAOdKwD9lsZBLur8uifqzr9IJ5vy805SRJDxu9frJ9NlQL1S0qi0Xj5bLNrWPjKDvyonG8mJFblk
	C3Io4AjAUWpqg3OLLU1jMTKacqujCsYdKXEqAAiFWcJSY/NpwDk0VsfgckFyN8wJkfvo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7FcP-0004AK-PR;
	Thu, 17 Sep 2026 17:09:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7FcO-0004AC-G3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IPgd+UJiPJUkLmOsiaAozJq/A15uIW26xpAYTHSZJlE=; b=B6zBV8cq3gbgqQz4xPE+9uGwz8
 80uEZ6drjSNwXibJE1InIhLw5zwmeZvPT2aRtq1UHMLirpCbw1+2fP3UzUWsPi9kHOAIlAmElS+2h
 QkJw5fOktgZ3zYG2GModfABwB/oQAxLrX9fifD5vulZ5ZUIJsltLwqvcFS33k7dqIGd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IPgd+UJiPJUkLmOsiaAozJq/A15uIW26xpAYTHSZJlE=; b=L
 VZvcQgMzDv3cBZ3LNtZcbLfEpqAG2V51xIchUPyARlp1bgvbGQ2XJX1Ig8W3ZHPiFqse/dm8Tj7a+
 cQAOGuyRR/SxipptBrNuhZxBkoDcGJgHQq1bT9A/esYTs55BBOMojV+/0ozPL9RvZ7hqiI76nQ3L6
 nfuXD3JGnTCVwW9o=;
Received: from mail-wr2-f27.google.com ([74.125.225.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7FcM-0006h0-BW for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:09:53 +0000
Received: by mail-wr2-f27.google.com with SMTP id
 ffacd0b85a97d-4843796e373so650040f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789664984; x=1790269784; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IPgd+UJiPJUkLmOsiaAozJq/A15uIW26xpAYTHSZJlE=;
 b=ORdnEIm5EOahn1KtWgIW8LZqkywEeXcu18KgkMrJ2IOVcV8iCK/buDCbGykWyt+3Ih
 fn9Nf8F5DODkT9Y+gXt+U9tG2X4bc0W5Fc/YWUTYbl2SH1demHhbFpnkTin+eWWiDA5Z
 akAKGD9G3hmNqRhhw4wMmeIcXzSNi6MkuQJloOaL28xGBrRinubQbuicWVfInhaGMjkR
 KQfkmxEWAbitJj1lHFDKrfELS758T1ZtBNvnPUjGtqU3FVCOeQcUU5j395JYHcCSpKAG
 1PBX8gNjLgsuUJCShXOxDZIg09ZfEoWRcX6Okk+6a00/iwYAF/MS0vMbQEWVYn06EsJ5
 NLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664984; x=1790269784;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IPgd+UJiPJUkLmOsiaAozJq/A15uIW26xpAYTHSZJlE=;
 b=sfswVfjkASBknJ+2xd56EvTDaPDwLpc9OoXH7iXuk8AmUYfZZgOl+IC1aGN6XzXJIm
 oapFUWaXJJIyNLgrASf4UNFmNgkCte/D94YRtR5DpzbKzmNdoAVxFhMjGz62R0dps1nV
 jgAyx4we/2twQ6XiSq/Fa64fiwr2C1VsdA6I5OlmRxUfQAr0TqE+iMxfzx4ccqb0tlKQ
 +1FnRTmeKyyUw+72hguCpLBUDK/l8F8QS/NeKJ9s5l7Jj9ZQEnTSOKLqslw73nTFWbO0
 +8fiD29mNR6AK8dy/WgWqruMpsI1CPTxjrpNpXn+shYGrNs7r7vV6l3JlOzyqlEqCgWU
 U4rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEzE1Jq/42QmJOPBtpOs6ZIOiYZ877zyBN9541FtuNZCCndSdx8o6vVOL8hnp7seoShhZdppCL8cdKbz6P@lists.sourceforge.net
X-Gm-Message-State: AFuF++lU3BI+ijsF9wQIEHpQX1Dxh4eOAhlJuksMSxnEC5IyItqtkl8j
 JaLTOXkI+Bld+mO5/r1u41oIh38IyqROrHFLia/x+MidqB0dysRTUwTHHJEaXiqurXC76AOW7mL
 D2kxSBXW+akWUaFcTgVJqGvmUkBbTk7wEfX3m2PNAMKWFze8yv29RJHak9m0trjjn6LVx
X-Gm-Gg: AYBFou25MFGs442/tRujHdm9unOQ29Zoz/0xyxI9mQ44igiHaen130hW+yWqc70+mrH
 IyHHKl5AyJSVb+A4AeeJk09Y2AVHW/olHC1KXbH3e2m1+k4Fy76OuXqMRrJL8xz6lbDpjzEP8KF
 CB9Mw3KDST45eSmUZ0TMOf6jnLTejHCmF1eSp3C/IdpW5hHP9xKuPIs/W59YxBVScWriYDK2r2k
 csvLTryYTrAcArEnl9sulvCmHtt45dJdAP6+mdN2yDc8mcVcdRRvgecdQAaxo4nEKlSG3VtGvF5
 iBGLpBXr5iBFMQWMwBgaiw65laQdwT0YY9Eil2QjfDhDCPK9vaENXp0+OmzWsvR/IcURyni0Xdo
 6HzCSseTQQPar7lmAWEz63ksGkBOUvdAGcLzuL5H8sWzuVO+G6QLu0k3nSaO3/CKhsdU9BxX46u
 ArPG+hd0hJD46uWCLMAqVh1J8oaw+U5xTvbBWPQ8ihBzDu59aaZ4xB84C8BkhF6QnhpqTT3eO4v
 G7PCxwV/avu4Ykbg18ZHTGLfujW1gSFHYADYfZYLsw44Qw3VBjyB2OuqwCUtLNxN0sc3hNSOHSX
 L87ezJvuF9IbFIiH3sLK5Ng9JXI4yML1MvF3qbhji1ktAtFUgMAPTifN6YBxBA==
X-Received: by 2002:a05:600c:3511:b0:49e:6e7c:d895 with SMTP id
 5b1f17b1804b1-49eb733ce1fmr91746795e9.26.1789664983736; 
 Thu, 17 Sep 2026 10:09:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd2563ccsm111544805e9.13.2026.09.17.10.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:09:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 17:09:43 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: bc7f77ea2b6a8e5d964f6cbb403e6bbf1fe77fa4
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee855aa002fe6cc846706b45f638eaf02a196b31-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7FcM-0006h0-BW
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7149446781642987062=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7149446781642987062==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zeovlXQTUKQ="; charset=UTF-8

--zeovlXQTUKQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1916?usp=3Demail )

Change subject: ssl: do not trust the peer's reques=
t to resend the wrapped client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

ssl: do not trust the peer's request to resend the w=
rapped client key

parse_early_negotiation_tlvs() sets CO_RESEND_WKC just b=
ecause the peer
set EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without =
checking that
this client has a wrapped client key at all=2E control_packet=
_needs_wkc()
then reports that our first control packet needs the key appen=
ded and
write_outgoing_tls_ciphertext() sizes it with

    maxlen -=3D buf_=
len(session->tls_wrap=2Etls_crypt_v2_wkc);

tls_crypt_v2_wkc is only set wi=
th --tls-crypt-v2 and buf_len() is not
NULL-safe, so a client without --tls=
-crypt-v2 dies with SIGSEGV while
processing the server's first reset packe=
t, before the peer has been
authenticated=2E

Only set the flag if we have =
a key to resend, and let tls_wrap_control()
refuse to append a key it does =
not have=2E

tls_reset_standalone() drives tls_wrap_control() directly, so =
the test
uses it to build the two control packets that carry a wrapped clie=
nt key
with tls_crypt_v2_wkc unset=2E Both segfault without the fix=2E

Git=
hub: OpenVPN/openvpn-private-issues#181
Change-Id: Iac6d49d064215510bde9a4c=
d4600ab3a50a45cb4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1916
Message-Id: <20260916203212=2E21285-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39268=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M tests=
/unit_tests/openvpn/test_pkt=2Ec
3 files changed, 62 insertions(+), 4 delet=
ions(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 76=
150d4=2E=2Eddbf067 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -2591,7 +2591,8 @@
  * Parses the TLVs (type, length, value) in the=
 early negotiation
  */
 static bool
-parse_early_negotiation_tlvs(struct b=
uffer *buf, struct key_state *ks)
+parse_early_negotiation_tlvs(struct buff=
er *buf, const struct tls_session *session,
+                             s=
truct key_state *ks)
 {
     while (buf->len > 0)
     {
@@ -2618,7 +2619,1=
7 @@
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
            =
     {
-                    ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
=
+                    /* Only accept the EARLY_NEG_FLAG_RESEND_WKC flag
+   =
                  * from the server if we are configured with tls-crypt-v2 =
*/
+                    if (session->tls_wrap=2Etls_crypt_v2_wkc)
+        =
            {
+                        ks->crypto_options=2Eflags |=3D CO_R=
ESEND_WKC;
+                    }
+                    else
+              =
      {
+                        msg(D_TLS_ERRORS, "TLS Error: peer asked u=
s to resend the wrapped "
+                                          "clien=
t key, but this is not a tls-crypt-v2 client");
+                    }
    =
             }
                 break;
 
@@ -2901,7 +2912,7 @@
          * =
contains early protocol negotiation */
         if (entry->packet_id =3D=3D=
 0 && is_hard_reset_method2(entry->opcode))
         {
-            if (!pa=
rse_early_negotiation_tlvs(&entry->buf, ks))
+            if (!parse_early_=
negotiation_tlvs(&entry->buf, session, ks))
             {
                =
 goto error;
             }
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/open=
vpn/ssl_pkt=2Ec
index 90b2aec=2E=2E940f089 100644
--- a/src/openvpn/ssl_pkt=
=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -147,7 +147,7 @@
         if ((header=
 >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
             || (=
header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
         {
-            =
if (!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
+            if (!ctx->tl=
s_crypt_v2_wkc || !buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
           =
  {
                 msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 clien=
t key");
                 buf->len =3D 0;
diff --git a/tests/unit_tests/ope=
nvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index a732c2b=2E=
=2E51c73d8 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_pkt=2Ec
@@ -695,6 +695,52 @@
     free_tas(&tas_serv=
er);
 }
 
+/* A peer can ask us to append the wrapped client key (WKc) to o=
ur next
+ * control packet=2E Only a tls-crypt-v2 client has one, so check =
that we
+ * refuse to build such a packet when we have no key instead of wa=
lking
+ * into the NULL pointer=2E */
+static void
+test_wkc_not_appended_w=
ithout_key(void **ut_state)
+{
+    struct tls_auth_standalone tas =3D init=
_tas_crypt(false);
+    struct session_id own_id =3D { { 1, 2, 3, 4, 5, 6, =
7, 8 } };
+    struct session_id remote_id =3D { { 8, 7, 6, 5, 4, 3, 2, 1 }=
 };
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayl=
oad_size =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+
+    packet_id_init=
(&tas=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet=
_id_send(&tas=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+    now =3D 0x22446688=
;
+
+    /* no WKc configured, so both opcodes that would append one must f=
ail */
+    assert_null(tas=2Etls_wrap=2Etls_crypt_v2_wkc);
+
+    uint8_t =
header =3D 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    struct buffer buf=
 =3D
+        tls_reset_standalone(&tas=2Etls_wrap, &tas, &own_id, &remote_=
id, header, false);
+    assert_int_equal(BLEN(&buf), 0);
+
+    header =3D=
 0 | (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT);
+    buf =3D tls_r=
eset_standalone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, header, false);=

+    assert_int_equal(BLEN(&buf), 0);
+
+    /* with a WKc the same packet=
 is built and the key ends up at its end */
+    uint8_t wkc_data[32];
+   =
 memset(wkc_data, 0x5a, sizeof(wkc_data));
+    struct buffer wkc =3D alloc=
_buf(sizeof(wkc_data));
+    assert_true(buf_write(&wkc, wkc_data, sizeof(w=
kc_data)));
+    tas=2Etls_wrap=2Etls_crypt_v2_wkc =3D &wkc;
+
+    header =
=3D 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    buf =3D tls_reset_standa=
lone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, header, false);
+    asser=
t_true(BLEN(&buf) > (int)sizeof(wkc_data));
+    assert_memory_equal(BPTR(&=
buf) + BLEN(&buf) - sizeof(wkc_data), wkc_data, sizeof(wkc_data));
+
+    f=
ree_buf(&wkc);
+    packet_id_free(&tas=2Etls_wrap=2Eopt=2Epacket_id);
+   =
 free_tas(&tas);
+}
+
 static void
 test_extract_control_message(void **ut_=
state)
 {
@@ -745,6 +791,7 @@
         cmocka_unit_test(test_verify_hmac_no=
ne_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_=
plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
+  =
      cmocka_unit_test(test_wkc_not_appended_without_key),
         cmocka_=
unit_test(test_extract_control_message)
     };
 

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Gerri=
t-Change-Number: 1916
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zeovlXQTUKQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1916?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">ssl: do not trust the peer&#39;s request t=
o resend the wrapped client key<br><br>parse_early_negotiation_tlvs() sets =
CO_RESEND_WKC just because the peer<br>set EARLY_NEG_FLAG_RESEND_WKC in its=
 reset packet, without checking that<br>this client has a wrapped client ke=
y at all=2E control_packet_needs_wkc()<br>then reports that our first contr=
ol packet needs the key appended and<br>write_outgoing_tls_ciphertext() siz=
es it with<br><br>    maxlen -=3D buf_len(session-&gt;tls_wrap=2Etls_crypt_=
v2_wkc);<br><br>tls_crypt_v2_wkc is only set with --tls-crypt-v2 and buf_le=
n() is not<br>NULL-safe, so a client without --tls-crypt-v2 dies with SIGSE=
GV while<br>processing the server&#39;s first reset packet, before the peer=
 has been<br>authenticated=2E<br><br>Only set the flag if we have a key to =
resend, and let tls_wrap_control()<br>refuse to append a key it does not ha=
ve=2E<br><br>tls_reset_standalone() drives tls_wrap_control() directly, so =
the test<br>uses it to build the two control packets that carry a wrapped c=
lient key<br>with tls_crypt_v2_wkc unset=2E Both segfault without the fix=
=2E<br><br>Github: OpenVPN/openvpn-private-issues#181<br>Change-Id: Iac6d49=
d064215510bde9a4cd4600ab3a50a45cb4<br>Signed-off-by: Lev Stipakov &lt;lev@o=
penvpn=2Enet&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916<br>Messag=
e-Id: &lt;20260916203212=2E21285-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg392=
68=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M tests/unit_=
tests/openvpn/test_pkt=2Ec<br>3 files changed, 62 insertions(+), 4 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c</span><br><span>index 76150d4=2E=2Eddbf067 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><spa=
n>@@ -2591,7 +2591,8 @@</span><br><span>  * Parses the TLVs (type, length, =
value) in the early negotiation</span><br><span>  */</span><br><span> stati=
c bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_early_neg=
otiation_tlvs(struct buffer *buf, struct key_state *ks)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+parse_early_negotiation_tlvs(struct buf=
fer *buf, const struct tls_session *session,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                             struct key_state *ks)=
</span><br><span> {</span><br><span>     while (buf-&gt;len &gt; 0)</span><=
br><span>     {</span><br><span>@@ -2618,7 +2619,17 @@</span><br><span> </s=
pan><br><span>                 if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</=
span><br><span>                 {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    ks-&gt;crypto_options=2Eflags |=3D CO_RESEN=
D_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       /* Only accept the EARLY_NEG_FLAG_RESEND_WKC flag</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                     * from the server=
 if we are configured with tls-crypt-v2 */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    if (session-&gt;tls_wrap=2Etls_c=
rypt_v2_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       msg(D_TLS_ERRORS, &quot;TLS Error: peer asked us to resend the wrapp=
ed &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                &quot;client key, but this is not a tls-cry=
pt-v2 client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    }</span><br><span>                 }</span><br><span> =
                break;</span><br><span> </span><br><span>@@ -2901,7 +2912,7=
 @@</span><br><span>          * contains early protocol negotiation */</spa=
n><br><span>         if (entry-&gt;packet_id =3D=3D 0 &amp;&amp; is_hard_re=
set_method2(entry-&gt;opcode))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (!parse_early_negotiatio=
n_tlvs(&amp;entry-&gt;buf, ks))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!parse_early_negotiation_tlvs(&amp;entry-&gt;bu=
f, session, ks))</span><br><span>             {</span><br><span>           =
      goto error;</span><br><span>             }</span><br><span>diff --git=
 a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index =
90b2aec=2E=2E940f089 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</=
span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -147,7 +147=
,7 @@</span><br><span>         if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D =
P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span>             || (header &gt;=
&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!buf_cop=
y(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!ctx-&gt;tls_crypt_v2_wkc || !b=
uf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</span><br><span>     =
        {</span><br><span>                 msg(D_TLS_ERRORS, &quot;Could no=
t append tls-crypt-v2 client key&quot;);</span><br><span>                 b=
uf-&gt;len =3D 0;</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index a73=
2c2b=2E=2E51c73d8 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span>@@ -695,6 +695,52 @@</span><br><span>     free_tas(&amp;tas_serv=
er);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* A peer can ask us to append the wrapped client key=
 (WKc) to our next</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* control packet=2E Only a tls-crypt-v2 client has one, so check that we</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * refuse to build suc=
h a packet when we have no key instead of walking</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * into the NULL pointer=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_wkc_not_appended_without_key(void **=
ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalo=
ne tas =3D init_tas_crypt(false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct session_id own_id =3D { { 1, 2, 3, 4, 5, 6, 7, 8 }=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessi=
on_id remote_id =3D { { 8, 7, 6, 5, 4, 3, 2, 1 } };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D {=
 =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas=2Etls_wrap=2Eopt=2Epacke=
t_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    reset_packet_id_send(&amp;tas=2Etls_wrap=2Eopt=2Epack=
et_id=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=
ow =3D 0x22446688;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no WKc config=
ured, so both opcodes that would append one must fail */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(tas=2Etls_wrap=2Etls_c=
rypt_v2_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D 0 =
| (P_CONTROL_WKC_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Et=
ls_wrap, &amp;tas, &amp;own_id, &amp;remote_id, header, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    header =3D 0 | (P_CONTROL=
_HARD_RESET_CLIENT_V3 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf =3D tls_reset_standalone(&amp;tas=2Etls=
_wrap, &amp;tas, &amp;own_id, &amp;remote_id, header, false);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;bu=
f), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* with a WKc the same pack=
et is built and the key ends up at its end */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t wkc_data[32];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memset(wkc_data, 0x5a, sizeof(wkc_dat=
a));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er wkc =3D alloc_buf(sizeof(wkc_data));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(buf_write(&amp;wkc, wkc_data, sizeof(wk=
c_data)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=
=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;wkc;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    header =3D 0 | (P_CONTROL_WKC_V1 &lt;&lt; P_OPCODE_SHIFT);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D tls_reset_stan=
dalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;remote_id, header, =
false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(BLEN(&amp;buf) &gt; (int)sizeof(wkc_data));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + BLEN(&=
amp;buf) - sizeof(wkc_data), wkc_data, sizeof(wkc_data));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    free_buf(&amp;wkc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas=2Etls_wrap=2Eopt=2Epacke=
t_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(=
&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static vo=
id</span><br><span> test_extract_control_message(void **ut_state)</span><br=
><span> {</span><br><span>@@ -745,6 +791,7 @@</span><br><span>         cmoc=
ka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><br><span>     =
    cmocka_unit_test(test_generate_reset_packet_plain),</span><br><span>   =
      cmocka_unit_test(test_generate_reset_packet_tls_auth),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_wkc_=
not_appended_without_key),</span><br><span>         cmocka_unit_test(test_e=
xtract_control_message)</span><br><span>     };</span><br><span> </span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1916?usp=3Demail">change 1916</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab=
3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1916 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"=
display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--zeovlXQTUKQ=--


--===============7149446781642987062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7149446781642987062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7149446781642987062==--


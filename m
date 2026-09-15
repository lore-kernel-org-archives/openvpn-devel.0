Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC22C88E73
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJnBkkOeJCJEaAvryxd4lw1eM+EaUixJzG3WF+hhSdo=; b=HuTIgjdDwBFco2P5wWcC5fUtg5
	jZLFjRRInLsOCxT+XjGvv3svVIPtzBwoxxXu2//x7bw7zbuuQ8/MdrBSxgLLeim1RoOEuBpruS765
	6dMUz95RgIl7BVbw2F1ZJ8fA9FNdV+zWN7vo8Ge7WzxuJDPLx0AXHYRPm2Eteu378TdE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6O2g-0005mH-94;
	Tue, 15 Sep 2026 07:57:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6O2e-0005m9-J4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XebK3YA5+B9Bj5/nTf50cXj3lxKtQwTvGGKpHcpl8JU=; b=baUF4TOCeqBEz0FR9Zy09l7tWP
 8a7eAl0KcM//YgUd53KlaxEN6OEsokb4/1RFvCCdGVoVmBREI+lZi7HEdkeJemMR329IDjHQFVT77
 JiV/Wo/09pZexX7pWkRaWP4vhL5Ea6obqP2KhWwEvE95Q9yGegN/QQaOw29Py2zRwtMA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XebK3YA5+B9Bj5/nTf50cXj3lxKtQwTvGGKpHcpl8JU=; b=O
 apbvtCokAJ5n7tbAI8w9S5AKl3F23aYD74TfONAYDMnm6suud9VVn6cJqXM7Nlg1SNlU5DhTB7z/Z
 YCbUb2j2QvhVljBVGKz5RvP67DQ5bL2GcitqPbdKgG06SqZ/hPCUGN8BKZ7LiocOiBsOloM4Px+ix
 tsR6undTA0oRlT0E=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6O2d-0000u3-9b for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:57:25 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso8603135e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789459037; x=1790063837; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XebK3YA5+B9Bj5/nTf50cXj3lxKtQwTvGGKpHcpl8JU=;
 b=P1ZyH9aYxCGW+t9xXGWPoACt8Ffh2LJP73kRicjvjXcRsbS8ZnBQJgy+kmMQIPYyzI
 zmaOyqoSrUlj8op28XhGK/FCfCQuefuvW+qnt/dDnJAt/k9s0KLvB6CDbxbGdBspgBtz
 b3esdKwQLk2mHzFadIyCEN+EDtjsMxyTTuYTZ1e/jUzxeuAa4Ry45qmvnQJvLfKmfm1h
 Ye7Me8xWyAj4yAgN0/oMj7kLpAmC008Wx3/xXKBNco6di/UxvMtQhcgsv6BZa1pbDHvo
 vffcpZMU6ZYPi0NEpvQYjcW2/sDIBcFravt8ei3JmNkoj9UA32N3DmORcxeVMufq4qIH
 bkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459037; x=1790063837;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XebK3YA5+B9Bj5/nTf50cXj3lxKtQwTvGGKpHcpl8JU=;
 b=kZaykuEAR4gkN0I8St3HFWkndRqxPgUhoGlw6HJcSng8ge31itcMb5L1C+ZItmF3Fm
 BC4+onT3OJm/w/rD2QmZLYYMAklRfsj1WGc+8ytANHh8t1J5IyVcGMKLHDPbiMUljFVu
 FPIvn79HOPbsUM0Tgo16818bwvxKiahT6xL3PkKz/b44JjilrNZXBqrVcqSyGNGKiH7C
 gZyRDIS5VFrcWSpYC5uvaGz2+OJoyBFiLf+rRQ6GgnvwP4URKMyQrsMZctghxzZU4jeg
 6q871LAXL2ue5TFhEqP3oJ3+gJ1xZnuVD2gfjHZ11yTwEqcjvQ0tFc6ZuEerGhu+sotz
 9/LA==
X-Gm-Message-State: AFuF++mc/pEsNaiA8AHlrYGPJiQyO3virkFN1btpLFpt96yQHliiMSo1
 jMoV4CBisCknB2q1FgncnDoMdlqzctcqhwjKe+K7DUvsQtyhcZy1RrunRKQnjRlyoYaq16t4cRJ
 +PQ4Gyq6qgiLDKkavpeem/FliDRXJbrdvmepF5zguLtkrVWdHEWj0lmt8C9i8mKMQvF2m
X-Gm-Gg: AYBFou28D7bGMEC9jdVwzvx5DRI6/y8WRibP/1tlQHpVYJCNZYL6Is5SE/6atxnfdHl
 JPpb8nBKRRcjhwq9L2KrZYhC2IuK2tyhFz8p3jFWxBnj49LOrqHYSZ5qhc/wHn2px6e7d2YUYfM
 XAKJ3hXfo+XZMOpdMvCDQ6+vuyF8B+GHnnPK2KIPM5vMN8ud1RDs3yV865yEv2VZgNxwnnBC+kc
 ctD0u2Vq1pG0QS6gI6qD9KPMCbpD8Kt7CpLFHlvUDi5HI916awnv9Dx9zlNLwp/VHvHR94U9NSS
 IyIZpmB8jD7I7513EWJuOs1MfjgO59C8UsZEiY/AY+jkfaQ9emwESF+PwRmeq28lw1W68fiKhM4
 yNIsAA/paBwLR9iIhujlKPiIIkEYMIrsU0qWjylyGxIBv9Hl6K3c/JwRnyplPm4OJ9/IyWRaUoL
 NLMeMCQLU9GuULQ2aNhR4HdTxCT2JrwaEFTunvmu7lAf6lsYU75lRuopQoWqnFaSJdEMYBcqltZ
 sjeJF0ruV3kXFP450EyBWhI8OsxGWQqY9Y73X1b68tGsimDP/Y4YIZm/nLawWtLmBHwSUTBGaYu
 xCnonUPEgAgUy6RsODZqbs6iVzdV+XfCYaXGYbXRvDxFLGy5jgbupedEdJWztUXT7EDD2xFa
X-Received: by 2002:a05:600c:5306:b0:49d:1916:59c7 with SMTP id
 5b1f17b1804b1-49e7a65c930mr72796845e9.7.1789459036360; 
 Tue, 15 Sep 2026 00:57:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef8a7b1sm39506705e9.12.2026.09.15.00.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:57:15 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 07:57:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: 65262c0afd5095fa68f320d23fdacd1b8c8a8e92
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d3a3fdfd8251060921750fcd87c6e144a95bda7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6O2d-0000u3-9b
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3230239238495081010=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3230239238495081010==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S2dgTRXK1NU="; charset=UTF-8

--S2dgTRXK1NU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1916?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: ssl: do not trust the peer's request to resend the wrapped=
 client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

s=
sl: do not trust the peer's request to resend the wrapped client key

parse=
_early_negotiation_tlvs() sets CO_RESEND_WKC just because the peer
set EARL=
Y_NEG_FLAG_RESEND_WKC in its reset packet, without checking that
this clien=
t has a wrapped client key at all=2E control_packet_needs_wkc()
then report=
s that our first control packet needs the key appended and
write_outgoing_t=
ls_ciphertext() sizes it with

    maxlen -=3D buf_len(session->tls_wrap=2E=
tls_crypt_v2_wkc);

tls_crypt_v2_wkc is only set with --tls-crypt-v2 and bu=
f_len() is not
NULL-safe, so a client without --tls-crypt-v2 dies with SIGS=
EGV while
processing the server's first reset packet, before the peer has b=
een
authenticated=2E

Only set the flag if we have a key to resend, check t=
he same in
control_packet_needs_wkc(), and let tls_wrap_control() refuse to=
 append a
key it does not have=2E

tls_reset_standalone() drives tls_wrap_c=
ontrol() directly, so the test
uses it to build the two control packets tha=
t carry a wrapped client key
with tls_crypt_v2_wkc unset=2E Both segfault w=
ithout the fix=2E

Github: OpenVPN/openvpn-private-issues#181
Change-Id: Ia=
c6d49d064215510bde9a4cd4600ab3a50a45cb4
Signed-off-by: Lev Stipakov <lev@op=
envpn=2Enet>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M tests/un=
it_tests/openvpn/test_pkt=2Ec
3 files changed, 70 insertions(+), 9 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/1=
6/1916/2

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 7615=
0d4=2E=2E5e2fc23 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec=

@@ -2591,7 +2591,8 @@
  * Parses the TLVs (type, length, value) in the ear=
ly negotiation
  */
 static bool
-parse_early_negotiation_tlvs(struct buffe=
r *buf, struct key_state *ks)
+parse_early_negotiation_tlvs(struct buffer *=
buf, const struct tls_session *session,
+                             struc=
t key_state *ks)
 {
     while (buf->len > 0)
     {
@@ -2618,7 +2619,19 @@=

 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                =
 {
-                    ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+   =
                 /* Only a tls-crypt-v2 client has a wrapped client key to
=
+                     * resend=2E The flag comes from the peer, so a peer t=
hat asks
+                     * anyone else is broken or hostile; ignore i=
t rather than
+                     * promising a key we do not have=2E */
=
+                    if (session->tls_wrap=2Etls_crypt_v2_wkc)
+           =
         {
+                        ks->crypto_options=2Eflags |=3D CO_RESE=
ND_WKC;
+                    }
+                    else
+                 =
   {
+                        msg(D_TLS_ERRORS, "TLS Error: peer asked us t=
o resend the wrapped "
+                                          "client k=
ey, but this is not a tls-crypt-v2 client");
+                    }
       =
          }
                 break;
 
@@ -2666,9 +2679,10 @@
 }
 
 static b=
ool
-control_packet_needs_wkc(const struct key_state *ks)
+control_packet_n=
eeds_wkc(const struct tls_session *session, const struct key_state *ks)
 {
=
-    return (ks->crypto_options=2Eflags & CO_RESEND_WKC) && (ks->send_relia=
ble->packet_id =3D=3D 1);
+    return (ks->crypto_options=2Eflags & CO_RESE=
ND_WKC) && (ks->send_reliable->packet_id =3D=3D 1)
+           && session->=
tls_wrap=2Etls_crypt_v2_wkc;
 }
 
 
@@ -2719,7 +2733,7 @@
     int maxlen =
=3D max_pkt_len * rel_avail;
 
     /* Is first packet one that will have a=
 WKC appended? */
-    if (control_packet_needs_wkc(ks))
+    if (control_p=
acket_needs_wkc(session, ks))
     {
         maxlen -=3D buf_len(session->=
tls_wrap=2Etls_crypt_v2_wkc);
     }
@@ -2759,7 +2773,7 @@
         {
     =
        int len =3D max_pkt_len;
             int opcode =3D P_CONTROL_V1;
=
-            if (control_packet_needs_wkc(ks))
+            if (control_pac=
ket_needs_wkc(session, ks))
             {
                 opcode =3D P_CO=
NTROL_WKC_V1;
                 len =3D max_int(0, len - buf_len(session->tl=
s_wrap=2Etls_crypt_v2_wkc));
@@ -2901,7 +2915,7 @@
          * contains ear=
ly protocol negotiation */
         if (entry->packet_id =3D=3D 0 && is_har=
d_reset_method2(entry->opcode))
         {
-            if (!parse_early_ne=
gotiation_tlvs(&entry->buf, ks))
+            if (!parse_early_negotiation_=
tlvs(&entry->buf, session, ks))
             {
                 goto error;=

             }
@@ -3157,7 +3171,7 @@
     /* Send 1 or more ACKs (each rec=
eived control packet gets one ACK) */
     if (!to_link->len && !reliable_a=
ck_empty(ks->rec_ack))
     {
-        if (control_packet_needs_wkc(ks))
+ =
       if (control_packet_needs_wkc(session, ks))
         {
             s=
truct buffer *buf =3D reliable_get_buf_output_sequenced(ks->send_reliable);=

             if (!buf)
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/=
ssl_pkt=2Ec
index 90b2aec=2E=2E940f089 100644
--- a/src/openvpn/ssl_pkt=2Ec=

+++ b/src/openvpn/ssl_pkt=2Ec
@@ -147,7 +147,7 @@
         if ((header >> =
P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
             || (head=
er >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
         {
-            if (=
!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
+            if (!ctx->tls_cr=
ypt_v2_wkc || !buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
=
                 msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 client ke=
y");
                 buf->len =3D 0;
diff --git a/tests/unit_tests/openvpn=
/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index a732c2b=2E=2E51=
c73d8 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_t=
ests/openvpn/test_pkt=2Ec
@@ -695,6 +695,52 @@
     free_tas(&tas_server);
=
 }
 
+/* A peer can ask us to append the wrapped client key (WKc) to our ne=
xt
+ * control packet=2E Only a tls-crypt-v2 client has one, so check that =
we
+ * refuse to build such a packet when we have no key instead of walking=

+ * into the NULL pointer=2E */
+static void
+test_wkc_not_appended_withou=
t_key(void **ut_state)
+{
+    struct tls_auth_standalone tas =3D init_tas_=
crypt(false);
+    struct session_id own_id =3D { { 1, 2, 3, 4, 5, 6, 7, 8 =
} };
+    struct session_id remote_id =3D { { 8, 7, 6, 5, 4, 3, 2, 1 } };
+=
    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_s=
ize =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+
+    packet_id_init(&tas=
=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_s=
end(&tas=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+    now =3D 0x22446688;
+
+=
    /* no WKc configured, so both opcodes that would append one must fail *=
/
+    assert_null(tas=2Etls_wrap=2Etls_crypt_v2_wkc);
+
+    uint8_t heade=
r =3D 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    struct buffer buf =3D
=
+        tls_reset_standalone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, h=
eader, false);
+    assert_int_equal(BLEN(&buf), 0);
+
+    header =3D 0 | =
(P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT);
+    buf =3D tls_reset_=
standalone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, header, false);
+   =
 assert_int_equal(BLEN(&buf), 0);
+
+    /* with a WKc the same packet is b=
uilt and the key ends up at its end */
+    uint8_t wkc_data[32];
+    mems=
et(wkc_data, 0x5a, sizeof(wkc_data));
+    struct buffer wkc =3D alloc_buf(=
sizeof(wkc_data));
+    assert_true(buf_write(&wkc, wkc_data, sizeof(wkc_da=
ta)));
+    tas=2Etls_wrap=2Etls_crypt_v2_wkc =3D &wkc;
+
+    header =3D 0=
 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    buf =3D tls_reset_standalone(=
&tas=2Etls_wrap, &tas, &own_id, &remote_id, header, false);
+    assert_tru=
e(BLEN(&buf) > (int)sizeof(wkc_data));
+    assert_memory_equal(BPTR(&buf) =
+ BLEN(&buf) - sizeof(wkc_data), wkc_data, sizeof(wkc_data));
+
+    free_b=
uf(&wkc);
+    packet_id_free(&tas=2Etls_wrap=2Eopt=2Epacket_id);
+    free=
_tas(&tas);
+}
+
 static void
 test_extract_control_message(void **ut_state=
)
 {
@@ -745,6 +791,7 @@
         cmocka_unit_test(test_verify_hmac_none_ou=
t_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain=
),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
+       =
 cmocka_unit_test(test_wkc_not_appended_without_key),
         cmocka_unit_=
test(test_extract_control_message)
     };
 

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Gerri=
t-Change-Number: 1916
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>

--S2dgTRXK1NU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1916?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl: do n=
ot trust the peer&#39;s request to resend the wrapped client key<br><br>par=
se_early_negotiation_tlvs() sets CO_RESEND_WKC just because the peer<br>set=
 EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without checking that<br>th=
is client has a wrapped client key at all=2E control_packet_needs_wkc()<br>=
then reports that our first control packet needs the key appended and<br>wr=
ite_outgoing_tls_ciphertext() sizes it with<br><br>    maxlen -=3D buf_len(=
session-&gt;tls_wrap=2Etls_crypt_v2_wkc);<br><br>tls_crypt_v2_wkc is only s=
et with --tls-crypt-v2 and buf_len() is not<br>NULL-safe, so a client witho=
ut --tls-crypt-v2 dies with SIGSEGV while<br>processing the server&#39;s fi=
rst reset packet, before the peer has been<br>authenticated=2E<br><br>Only =
set the flag if we have a key to resend, check the same in<br>control_packe=
t_needs_wkc(), and let tls_wrap_control() refuse to append a<br>key it does=
 not have=2E<br><br>tls_reset_standalone() drives tls_wrap_control() direct=
ly, so the test<br>uses it to build the two control packets that carry a wr=
apped client key<br>with tls_crypt_v2_wkc unset=2E Both segfault without th=
e fix=2E<br><br>Github: OpenVPN/openvpn-private-issues#181<br>Change-Id: Ia=
c6d49d064215510bde9a4cd4600ab3a50a45cb4<br>Signed-off-by: Lev Stipakov &lt;=
lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_=
pkt=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>3 files changed, 70 i=
nsertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/1916/2</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 76150d4=
=2E=2E5e2fc23 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2591,7 +2591,8 @@</span><=
br><span>  * Parses the TLVs (type, length, value) in the early negotiation=
</span><br><span>  */</span><br><span> static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-parse_early_negotiation_tlvs(struct buffer *bu=
f, struct key_state *ks)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+parse_early_negotiation_tlvs(struct buffer *buf, const struct tls_sess=
ion *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                       struct key_state *ks)</span><br><span> {</span><br><=
span>     while (buf-&gt;len &gt; 0)</span><br><span>     {</span><br><span=
>@@ -2618,7 +2619,19 @@</span><br><span> </span><br><span>                 =
if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    /* Only a tls-crypt-v2 c=
lient has a wrapped client key to</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                     * resend=2E The flag comes from the peer=
, so a peer that asks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     * anyone else is broken or hostile; ignore it rather=
 than</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
       * promising a key we do not have=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    if (session-&gt;tls_wrap=2Etl=
s_crypt_v2_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          msg(D_TLS_ERRORS, &quot;TLS Error: peer asked us to resend the wr=
apped &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                   &quot;client key, but this is not a tls-=
crypt-v2 client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    }</span><br><span>                 }</span><br><spa=
n>                 break;</span><br><span> </span><br><span>@@ -2666,9 +267=
9,10 @@</span><br><span> }</span><br><span> </span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-control_packet_needs_wk=
c(const struct key_state *ks)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+control_packet_needs_wkc(const struct tls_session *session, const=
 struct key_state *ks)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return (ks-&gt;crypto_options=2Eflags &amp; CO_RESE=
ND_WKC) &amp;&amp; (ks-&gt;send_reliable-&gt;packet_id =3D=3D 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return (ks-&gt;crypto_opt=
ions=2Eflags &amp; CO_RESEND_WKC) &amp;&amp; (ks-&gt;send_reliable-&gt;pack=
et_id =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &amp;&amp; session-&gt;tls_wrap=2Etls_crypt_v2_wkc;</span><br><span>=
 }</span><br><span> </span><br><span> </span><br><span>@@ -2719,7 +2733,7 @=
@</span><br><span>     int maxlen =3D max_pkt_len * rel_avail;</span><br><s=
pan> </span><br><span>     /* Is first packet one that will have a WKC appe=
nded? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (contr=
ol_packet_needs_wkc(ks))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (control_packet_needs_wkc(session, ks))</span><br><span>     {<=
/span><br><span>         maxlen -=3D buf_len(session-&gt;tls_wrap=2Etls_cry=
pt_v2_wkc);</span><br><span>     }</span><br><span>@@ -2759,7 +2773,7 @@</s=
pan><br><span>         {</span><br><span>             int len =3D max_pkt_l=
en;</span><br><span>             int opcode =3D P_CONTROL_V1;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (control_packet_need=
s_wkc(ks))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (control_packet_needs_wkc(session, ks))</span><br><span>             =
{</span><br><span>                 opcode =3D P_CONTROL_WKC_V1;</span><br><=
span>                 len =3D max_int(0, len - buf_len(session-&gt;tls_wrap=
=2Etls_crypt_v2_wkc));</span><br><span>@@ -2901,7 +2915,7 @@</span><br><spa=
n>          * contains early protocol negotiation */</span><br><span>      =
   if (entry-&gt;packet_id =3D=3D 0 &amp;&amp; is_hard_reset_method2(entry-=
&gt;opcode))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (!parse_early_negotiation_tlvs(&amp;entry-=
&gt;buf, ks))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!parse_early_negotiation_tlvs(&amp;entry-&gt;buf, session, ks))</=
span><br><span>             {</span><br><span>                 goto error;<=
/span><br><span>             }</span><br><span>@@ -3157,7 +3171,7 @@</span>=
<br><span>     /* Send 1 or more ACKs (each received control packet gets on=
e ACK) */</span><br><span>     if (!to_link-&gt;len &amp;&amp; !reliable_ac=
k_empty(ks-&gt;rec_ack))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (control_packet_needs_wkc(ks))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (control_packet_=
needs_wkc(session, ks))</span><br><span>         {</span><br><span>        =
     struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-&gt;send_r=
eliable);</span><br><span>             if (!buf)</span><br><span>diff --git=
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
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4=
600ab3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
916 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--S2dgTRXK1NU=--


--===============3230239238495081010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3230239238495081010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3230239238495081010==--


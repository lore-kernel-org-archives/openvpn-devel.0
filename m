Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE1C624D6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rihk0UfdFrchUW2ng1xmX/er4F/QOJixx0n2bdzZiJ0=; b=QPJExGtguG3o/rkWze/TmS2xRu
	zBi+x9F+IX3nMdaDd06cMbHmE63He6EyBFK2b7E540QTAt9GhvQkJ82EC+n4rw7eBC/HbHYbY3Hmu
	rJBOGPr94WCjHoNILjPK9wClPTIJ/wD6K1x3qbrRYFW7RGWgVxyF6LJpUkY8FrLIQ4Oo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1oSn-0007zC-A1;
	Wed, 02 Sep 2026 17:09:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1oSl-0007z6-Hd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 17:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7JqIXauaSWtNPiY5xKTKxcuasSZs8yKwfHPVpeMN/no=; b=KaOr0LtLRcSHo2OswNV/+4GujS
 2JwR8qO5dDs1f9SXdPZ55Tg4LnPyocCqoj8e+qhF+a/JXCTTBP2RBVR7h0wLlU17SS+6Pdg7wmuWX
 LSqnzIk3WFeQZ9DN4ajIzax1FMnqFJ+VENBEoDmnkk93QduHFtdZl9OKkr/fCaAYN4ck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7JqIXauaSWtNPiY5xKTKxcuasSZs8yKwfHPVpeMN/no=; b=L
 silqd5gudXVA+MreyoTlfLT7tl7aAbXydnvBIpuFI7oaDzyz4ouyuIvS1InU5YERI8Sj84YdPBele
 Fw98ioKlH8VvxLiPHMRdl4dXmFLQz0ArFUAUA2RPMfIVtDhi0HBKb95GuUiTQFeOUgObSjAlFG+n6
 Z40jrh+VHTvzlPqU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1oSg-00033J-Dt for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 17:09:27 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so823623f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788368956; x=1788973756; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7JqIXauaSWtNPiY5xKTKxcuasSZs8yKwfHPVpeMN/no=;
 b=QxuInNGm5oFaMyb5g0/0YarlS1UOmYQoaZejlyt3hudcnElUl1ZRP4fTB66GnEqxVa
 eS1RQ9uRrD/LIlPtbXM9RYeT0V8ST6bDEfAkXibpqOnL/khffllRGkzPNe2Ixuxqfjzz
 sAz5L0l5MyUprVHBQ14v74AWEqbi9UphvGZjtmY12pBmlVDrKkQ2rEySs60ob6INIXT0
 lKZma0L7tYtX55lwapDizcgEsajFO6ugx+vWABoaRawtwzSlFYaS5MGtn7Lkfa4COSmr
 cC+M48gCyw2HCbGQjaKn+KwALvG4lpXitUdQxBJyumrpIHnL8t/q2e5j5paBq3KYVE/Z
 HpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368956; x=1788973756;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7JqIXauaSWtNPiY5xKTKxcuasSZs8yKwfHPVpeMN/no=;
 b=FrBmv777zy3mGlQgVztWepaSEnfN31nD+9TzfhI5uGNK02HCzt2pAD4RFcQDfN9gDT
 ivpOIGUgqtEZqLQFUqBFOdygV9CD/NQe6BJbh5i1e/agiKrRN2keRtHZ6fJDLceWUmYk
 4loBhmbboXpvenKipJ8ev+cG9daKMoUZoCoQTVrQBVxVM9G/QdknFnOkeBkpMhAj5CYF
 25EMF5kArOmAvOuwDjmaiXPVyyZm9rA7apIrHSAtxk8KhqiHWVusd++xcY0yHPoFj33y
 /0wnJfUAgphGI2JWOcDW+mufO4l/7WYcaDIoOc86gSiHZVLjNMPSXHHu7NpvPxxDQ81X
 RZvw==
X-Gm-Message-State: AFuF++mNaaMamKXCbLOJ0PaL8Pep57GorSTbRUxdeNhZRNedcdkWQN5L
 or0hJgmrgzyXCE9AnXr+by5bObu9C951GODEVFobVFh85Y0YOOjNBs64LPtwZItmEVKlFm2Ulf1
 fyXsH4H7VN1M/Dgy4Wta+dcbc314wqyewZeRSlKqgdhVxkwfIPaFE8C5MQvvjtjJV/Iwr
X-Gm-Gg: AYBFou1mD42r92VCU58evrp7E+IMM5FkiWF5RP2W1VRt7Ml2xsQFqaf+3Vw1cKUq8bU
 1Lrxi0hhEkU8/JX/XWRwTUS5RqdPeNqZo2/kzbV4OAhXDcjuUuumE61HG+D8eWRkEGQJR7AeUdG
 lYDRjSA8ilebVjqiEJwbDAc917M4qPvorN4QCEv+579AfoZyY3FiIOatLNJSWnbPaef7IG/7MK/
 7gUj2eA+EwgNkmCs3cH3KL3AFQR3nGNpvxoijhH125zrCWK2JhQULGQ6kFrgwj9MdfB3K/YzBCx
 6Lll4dfhBQcBwGdIlLMnx7r+aMgGHs/4VgaaYTMbV119+dIsoIYjLWd72TEqpsr18hHvDriYKme
 cI9f428gcpzmI+hyd8xXhiL6mOX+ynARRQ7kM5wcrAJL7dqE8vGhIygOHABN0LFDkd4xZQUc5Xy
 h7PXiih9Ixf5VvIZbdxs6pdZMslFJq832PEe3EaBZLa+HffE9P2/rACVDrCCLWydrpsHpr89X1g
 QO2JCecordbdCfwHyaZsyyvFSAPFAqj8c2l0gsGoF7oL/6T4KhloHnsaXhXszlL5o6VDFGV4ouC
 sKrZ34l24xkd6ZlbEETiZIp6VAclMlOYw8PFsFb+ckIeKeMBkxw=
X-Received: by 2002:a5d:6d52:0:b0:481:5167:abda with SMTP id
 ffacd0b85a97d-48488f06d5emr9504140f8f.9.1788368955576; 
 Wed, 02 Sep 2026 10:09:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeacbbsm7277475f8f.30.2026.09.02.10.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:09:15 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 17:09:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1893
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1893?usp=email>
X-Gerrit-Commit: 7c988280ca5399c68799882b08a524ef746cee8a
In-Reply-To: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MzY4NjE4MDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9beb196d0575355f3cb69ca472a457ef62b8dcb2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1oSg-00033J-Dt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move
 check_session_buf_not_used method into the method that free the ...
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4812750226335106670=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4812750226335106670==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4mVhWpVUblg="; charset=UTF-8

--4mVhWpVUblg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

Hello MaxF, plaisthos, 

I'd=
 like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1893?usp=3Demail

to look at the new patch set (#2)=2E
=


Change subject: Move check_session_buf_not_used method into the method th=
at free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Move check_session_buf_not_used method into the method that free th=
e buffer

This cleans the code up a bit and ensure that we do not miss an i=
nvocation
of a problematic code path=2E This is still a band-aid fix and a =
real fix
requires more refactoring and changing the logic=2E

v2: sprinkle =
some "const" over check_keystate_buf_not_used() args

CVE: 2026-84471
Repor=
ted-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Github: openvpn/op=
envpn-private-issues#157
Reported-By: Haruki Oyama (Waseda University)
Gith=
ub: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f714803604d76c6d=
f6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by:=
 MaxF <max@max-fillinger=2Enet>
---
M src/openvpn/ssl=2Ec
1 file changed, 8=
6 insertions(+), 58 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/93/1893/2

diff --git a/src/openvpn/ssl=2Ec b/sr=
c/openvpn/ssl=2Ec
index 5f5d1f9=2E=2E92838fb 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -96,6 +96,14 @@
 
 #endif /* ifdef MEASUR=
E_TLS_HANDSHAKE_STATS */
 
+/* forward decleration since tls_process needs =
this function prototype */
+static void
+check_session_buf_not_used(struct =
buffer *to_link, struct tls_session *session);
+
+static void
+check_keysta=
te_buf_not_used(struct buffer *to_link, const struct key_state *ks);
+
+
 /=
**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) ci=
pher=2E
  *
@@ -896,10 +904,15 @@
  *                       cleaned up=2E
 =
 * @param clear        - Whether the memory allocated for the \a ks object
=
  *                       should be overwritten with 0s=2E
+ *
+ * @param t=
o_link      - if not NULL, check that the buffer does not contain
+ *      =
                 any pointer to one of the internal structs of ks
  */
 sta=
tic void
-key_state_free(struct key_state *ks, bool clear)
+key_state_free(=
struct key_state *ks, bool clear, struct buffer *to_link)
 {
+    check_key=
state_buf_not_used(to_link, ks);
+
     ks->state =3D S_UNDEF;
 
     key_s=
tate_ssl_free(&ks->ks_ssl);
@@ -1046,8 +1059,9 @@
  *
  */
 static void
-tl=
s_session_free(struct tls_session *session, bool clear)
+tls_session_free(s=
truct tls_session *session, bool clear, struct buffer *to_link)
 {
+    che=
ck_session_buf_not_used(to_link, session);
     tls_wrap_free(&session->tls=
_wrap);
     tls_wrap_free(&session->tls_wrap_reneg);
 
@@ -1056,7 +1070,7 =
@@
         /* we don't need clear=3Dtrue for this call since
          * t=
he structs are part of session and get cleared
          * as part of sessi=
on */
-        key_state_free(&session->key[i], false);
+        key_state_=
free(&session->key[i], false, to_link);
     }
 
     free(session->common_=
name);
@@ -1075,14 +1089,16 @@
 
 
 static void
-move_session(struct tls_mu=
lti *multi, int dest, int src, bool reinit_src)
+move_session(struct tls_mu=
lti *multi, int dest, int src, bool reinit_src,
+             struct buffer=
 *to_link)
 {
+    check_session_buf_not_used(to_link, &multi->session[dest=
]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=3D%s src=3D%s reinit=
_src=3D%d",
         session_index_name(dest), session_index_name(src), rei=
nit_src);
     ASSERT(src !=3D dest);
     ASSERT(src >=3D 0 && src < TM_SI=
ZE);
     ASSERT(dest >=3D 0 && dest < TM_SIZE);
-    tls_session_free(&mul=
ti->session[dest], false);
+    tls_session_free(&multi->session[dest], fal=
se, to_link);
     multi->session[dest] =3D multi->session[src];
 
     if =
(reinit_src)
@@ -1098,9 +1114,9 @@
 }
 
 static void
-reset_session(struct =
tls_multi *multi, struct tls_session *session)
+reset_session(struct tls_mu=
lti *multi, struct tls_session *session, struct buffer *to_link)
 {
-    tl=
s_session_free(session, false);
+    tls_session_free(session, false, to_li=
nk);
     tls_session_init(multi, session);
 }
 
@@ -1265,7 +1281,7 @@
 
  =
   for (int i =3D 0; i < TM_SIZE; ++i)
     {
-        tls_session_free(&mu=
lti->session[i], false);
+        tls_session_free(&multi->session[i], fals=
e, NULL);
     }
 
     if (clear)
@@ -1764,13 +1780,13 @@
  * active key=
=2E
  */
 static void
-key_state_soft_reset(struct tls_session *session)
+k=
ey_state_soft_reset(struct tls_session *session, struct buffer *to_link)
 {=

     struct key_state *ks =3D &session->key[KS_PRIMARY];        /* primary=
 key */
     struct key_state *ks_lame =3D &session->key[KS_LAME_DUCK]; /* =
retiring key */
 
     ks->must_die =3D now + session->opt->transition_wind=
ow;    /* remaining lifetime of old key */
-    key_state_free(ks_lame, fal=
se);
+    key_state_free(ks_lame, false, to_link);
     *ks_lame =3D *ks;
 =

     key_state_init(session, ks);
@@ -1781,7 +1797,7 @@
 void
 tls_session=
_soft_reset(struct tls_multi *tls_multi)
 {
-    key_state_soft_reset(&tls_=
multi->session[TM_ACTIVE]);
+    key_state_soft_reset(&tls_multi->session[T=
M_ACTIVE], NULL);
 }
 
 /*
@@ -3101,13 +3117,13 @@
             session->op=
t->aead_usage_limit,
             ks->crypto_options=2Ekey_ctx_bi=2Edecrypt=
=2Eplaintext_blocks + ks->n_packets,
             session->opt->aead_usage_=
limit);
-        key_state_soft_reset(session);
+        key_state_soft_res=
et(session, to_link);
     }
 
     /* Kill lame duck key transition_window=
 seconds after primary key negotiation */
     if (lame_duck_must_die(sessi=
on, wakeup))
     {
-        key_state_free(ks_lame, true);
+        key_st=
ate_free(ks_lame, true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_p=
rocess: killed expiring key");
     }
 
@@ -3200,6 +3216,55 @@
     return =
false;
 }
 
+static void
+check_keystate_buf_not_used(struct buffer *to_lin=
k, const struct key_state *ks)
+{
+    if (ks->state =3D=3D S_UNDEF || !to_=
link || !to_link->data)
+    {
+        return;
+    }
+
+    uint8_t *data=
ptr =3D to_link->data;
+
+    /* we don't expect send_reliable to be NULL w=
hen state is
+     * not S_UNDEF, but people have reported crashes nonethel=
ess,
+     * therefore we better catch this event, report and exit=2E
+    =
 */
+    if (!ks->send_reliable)
+    {
+        msg(M_FATAL,
+            =
"ERROR: ks=2Esend_reliable (key-id %d), is NULL "
+            "while key s=
tate is %s=2E Exiting=2E",
+            ks->key_id, state_name(ks->state));=

+    }
+
+    for (int j =3D 0; j < ks->send_reliable->size; j++)
+    {
+=
        if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D dataptr)
+     =
   {
+            msg(M_INFO,
+                "Warning buffer of freed TLS=
 session is still in"
+                " use (key-id %d, ks=2Esend_reliable=
->array[%d])",
+                ks->key_id, j);
+
+            goto used;
+=
        }
+    }
+
+    if (ks->ack_write_buf=2Edata =3D=3D dataptr)
+    {=

+        msg(M_INFO, "Warning buffer of freed TLS session is still in use =
"
+                    "(ks=2Eack_write_buf, key-id %d)",
+            ks->=
key_id);
+
+        goto used;
+    }
+    return;
+
+used:
+    to_link->l=
en =3D 0;
+    to_link->data =3D 0;
+}
 
 /**
  * This is a safe guard func=
tion to double check that a buffer from a session is
@@ -3211,11 +3276,11 @=
@
 static void
 check_session_buf_not_used(struct buffer *to_link, struct t=
ls_session *session)
 {
-    const uint8_t *dataptr =3D to_link->data;
-   =
 if (!dataptr)
+    if (!to_link || !to_link->data)
     {
         return;=

     }
+    const uint8_t *dataptr =3D to_link->data;
 
     /* Checks buf=
fers in tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=3D dataptr=
)
@@ -3234,41 +3299,7 @@
     for (int i =3D 0; i < KS_SIZE; i++)
     {
  =
       const struct key_state *ks =3D &session->key[i];
-        if (ks->st=
ate =3D=3D S_UNDEF)
-        {
-            continue;
-        }
-
-       =
 /* we don't expect send_reliable to be NULL when state is
-         * not =
S_UNDEF, but people have reported crashes nonetheless,
-         * therefor=
e we better catch this event, report and exit=2E
-         */
-        if (=
!ks->send_reliable)
-        {
-            msg(M_FATAL,
-                "=
ERROR: session->key[%d]->send_reliable is NULL "
-                "while ke=
y state is %s=2E Exiting=2E",
-                i, state_name(ks->state));
-=
        }
-
-        for (int j =3D 0; j < ks->send_reliable->size; j++)
- =
       {
-            if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D d=
ataptr)
-            {
-                msg(M_INFO,
-                    "W=
arning buffer of freed TLS session is still in"
-                    " use =
(session->key[%d]=2Esend_reliable->array[%d])",
-                    i, j);=

-
-                goto used;
-            }
-        }
-        if (ks->a=
ck_write_buf=2Edata =3D=3D dataptr)
-        {
-            msg(M_INFO, "Wa=
rning buffer of freed TLS session is still in use (session->key[%d]=2Eack_w=
rite_buf)", i);
-
-            goto used;
-        }
+        check_keystat=
e_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3362,13 +3393,11 @@
=
                 if (i =3D=3D TM_ACTIVE && ks_lame->state >=3D S_GENERATED_=
KEYS
                     && !multi->opt=2Esingle_session)
                =
 {
-                    check_session_buf_not_used(to_link, session);
-    =
                move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+      =
              move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
=
                 }
                 else
                 {
-              =
      check_session_buf_not_used(to_link, session);
-                    re=
set_session(multi, session);
+                    reset_session(multi, sess=
ion, to_link);
                 }
             }
         }
@@ -3421,7 +345=
0,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], =
wakeup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], tr=
ue);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link=
);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring k=
ey");
     }
 
@@ -3436,8 +3465,7 @@
      */
     if (TLS_AUTHENTICATED(mu=
lti, &multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]))
     {
-        check_=
session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        move_se=
ssion(multi, TM_ACTIVE, TM_INITIAL, true);
+        move_session(multi, TM_=
ACTIVE, TM_INITIAL, true, to_link);
         tas =3D tls_authentication_sta=
tus(multi);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tls_multi_proc=
ess: initial untrusted "
@@ -3839,7 +3867,7 @@
                 goto error;=

             }
 
-            key_state_soft_reset(session);
+            =
key_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_DEBUG, "TLS:=
 received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s", i,
                  se=
ssion_id_print(&sid, &gc));

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1893?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Change-Number: =
1893
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--4mVhWpVUblg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>cron2 <strong>uploaded patch set #2</=
strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1893?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">Move check_se=
ssion_buf_not_used method into the method that free the buffer<br><br>This =
cleans the code up a bit and ensure that we do not miss an invocation<br>of=
 a problematic code path=2E This is still a band-aid fix and a real fix<br>=
requires more refactoring and changing the logic=2E<br><br>v2: sprinkle som=
e &quot;const&quot; over check_keystate_buf_not_used() args<br><br>CVE: 202=
6-84471<br>Reported-By: Andreas Gabriel Berbescu &lt;aberbescu@gmail=2Ecom&=
gt;<br>Github: openvpn/openvpn-private-issues#157<br>Reported-By: Haruki Oy=
ama (Waseda University)<br>Github: openvpn/openvpn-private-issues#132<br>Ch=
ange-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d<br>Signed-off-by: Arne S=
chwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=
=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 86 insertions=
(+), 58 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/93/1893/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f9=2E=2E9283=
8fb 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl=2Ec</span><br><span>@@ -96,6 +96,14 @@</span><br><span> </s=
pan><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* forward decl=
eration since tls_process needs this function prototype */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+check_session_buf_not_used(struct buffer *to=
_link, struct tls_session *session);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_keys=
tate_buf_not_used(struct buffer *to_link, const struct key_state *ks);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Limit the reneg_bytes value when using a small-block (&lt;128 bytes) ciphe=
r=2E</span><br><span>  *</span><br><span>@@ -896,10 +904,15 @@</span><br><s=
pan>  *                       cleaned up=2E</span><br><span>  * @param clea=
r        - Whether the memory allocated for the \a ks object</span><br><spa=
n>  *                       should be overwritten with 0s=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param to_link      - if not NULL, check that th=
e buffer does not contain</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *                       any pointer to one of the internal structs o=
f ks</span><br><span>  */</span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state *ks, bool =
clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_state_fre=
e(struct key_state *ks, bool clear, struct buffer *to_link)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_keysta=
te_buf_not_used(to_link, ks);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><span> =
</span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><sp=
an>@@ -1046,8 +1059,9 @@</span><br><span>  *</span><br><span>  */</span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tl=
s_session_free(struct tls_session *session, bool clear)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+tls_session_free(struct tls_session *se=
ssion, bool clear, struct buffer *to_link)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_not_used(to=
_link, session);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wr=
ap);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap_reneg);</=
span><br><span> </span><br><span>@@ -1056,7 +1070,7 @@</span><br><span>    =
     /* we don&#39;t need clear=3Dtrue for this call since</span><br><span>=
          * the structs are part of session and get cleared</span><br><span=
>          * as part of session */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        key_state_free(&amp;session-&gt;key[i], false);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_free(&am=
p;session-&gt;key[i], false, to_link);</span><br><span>     }</span><br><sp=
an> </span><br><span>     free(session-&gt;common_name);</span><br><span>@@=
 -1075,14 +1089,16 @@</span><br><span> </span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-move_sessi=
on(struct tls_multi *multi, int dest, int src, bool reinit_src)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+move_session(struct tls_multi *=
multi, int dest, int src, bool reinit_src,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             struct buffer *to_link)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_sessio=
n_buf_not_used(to_link, &amp;multi-&gt;session[dest]);</span><br><span>    =
 msg(D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=3D%s reinit_sr=
c=3D%d&quot;,</span><br><span>         session_index_name(dest), session_in=
dex_name(src), reinit_src);</span><br><span>     ASSERT(src !=3D dest);</sp=
an><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SIZE);</span>=
<br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZE);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(&amp;mul=
ti-&gt;session[dest], false);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    tls_session_free(&amp;multi-&gt;session[dest], false, to_link=
);</span><br><span>     multi-&gt;session[dest] =3D multi-&gt;session[src];=
</span><br><span> </span><br><span>     if (reinit_src)</span><br><span>@@ =
-1098,9 +1114,9 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reset_sessio=
n(struct tls_multi *multi, struct tls_session *session)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+reset_session(struct tls_multi *multi, =
struct tls_session *session, struct buffer *to_link)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(sess=
ion, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls=
_session_free(session, false, to_link);</span><br><span>     tls_session_in=
it(multi, session);</span><br><span> }</span><br><span> </span><br><span>@@=
 -1265,7 +1281,7 @@</span><br><span> </span><br><span>     for (int i =3D 0=
; i &lt; TM_SIZE; ++i)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;session[i],=
 false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls=
_session_free(&amp;multi-&gt;session[i], false, NULL);</span><br><span>    =
 }</span><br><span> </span><br><span>     if (clear)</span><br><span>@@ -17=
64,13 +1780,13 @@</span><br><span>  * active key=2E</span><br><span>  */</s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-key_state_soft_reset(struct tls_session *session)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls_session =
*session, struct buffer *to_link)</span><br><span> {</span><br><span>     s=
truct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];        /* primary=
 key */</span><br><span>     struct key_state *ks_lame =3D &amp;session-&gt=
;key[KS_LAME_DUCK]; /* retiring key */</span><br><span> </span><br><span>  =
   ks-&gt;must_die =3D now + session-&gt;opt-&gt;transition_window;    /* r=
emaining lifetime of old key */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    key_state_free(ks_lame, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    key_state_free(ks_lame, false, to_link);</spa=
n><br><span>     *ks_lame =3D *ks;</span><br><span> </span><br><span>     k=
ey_state_init(session, ks);</span><br><span>@@ -1781,7 +1797,7 @@</span><br=
><span> void</span><br><span> tls_session_soft_reset(struct tls_multi *tls_=
multi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    key_state_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    key_state_soft_reset(&=
amp;tls_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span> }</span><br><=
span> </span><br><span> /*</span><br><span>@@ -3101,13 +3117,13 @@</span><b=
r><span>             session-&gt;opt-&gt;aead_usage_limit,</span><br><span>=
             ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_block=
s + ks-&gt;n_packets,</span><br><span>             session-&gt;opt-&gt;aead=
_usage_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 key_state_soft_reset(session);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        key_state_soft_reset(session, to_link);</span><br><span=
>     }</span><br><span> </span><br><span>     /* Kill lame duck key transi=
tion_window seconds after primary key negotiation */</span><br><span>     i=
f (lame_duck_must_die(session, wakeup))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks_lame, tr=
ue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_sta=
te_free(ks_lame, true, to_link);</span><br><span>         msg(D_TLS_DEBUG_L=
OW, &quot;TLS: tls_process: killed expiring key&quot;);</span><br><span>   =
  }</span><br><span> </span><br><span>@@ -3200,6 +3216,55 @@</span><br><spa=
n>     return false;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct buffer *to=
_link, const struct key_state *ks)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* we don&#39;t expect send_reliable to be NULL when state is</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * not S_UNDEF, but peop=
le have reported crashes nonetheless,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * therefore we better catch this event, report and e=
xit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ks-&gt;send_reli=
able)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;ERROR: ks=
=2Esend_reliable (key-id %d), is NULL &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;while key state is %s=2E Exiting=
=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ks-&gt;key_id, state_name(ks-&gt;state));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=
=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_INFO,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              &quot;Warning buffer of freed TLS session is still in&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot=
; use (key-id %d, ks=2Esend_reliable-&gt;array[%d])&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                ks-&gt;key_id, j);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto used;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_INFO, &quot;Warning buffer of freed TLS session =
is still in use &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &quot;(ks=2Eack_write_buf, key-id %d)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;key_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto used;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+used:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;len=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_link-=
&gt;data =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span> </span><br><span> /**</span><br><span>  * This is a safe gua=
rd function to double check that a buffer from a session is</span><br><span=
>@@ -3211,11 +3276,11 @@</span><br><span> static void</span><br><span> chec=
k_session_buf_not_used(struct buffer *to_link, struct tls_session *session)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!dataptr)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!to_link || !to_link-&gt;data)</span><br><sp=
an>     {</span><br><span>         return;</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =
=3D to_link-&gt;data;</span><br><span> </span><br><span>     /* Checks buff=
ers in tls_wrap */</span><br><span>     if (session-&gt;tls_wrap=2Ework=2Ed=
ata =3D=3D dataptr)</span><br><span>@@ -3234,41 +3299,7 @@</span><br><span>=
     for (int i =3D 0; i &lt; KS_SIZE; i++)</span><br><span>     {</span><b=
r><span>         const struct key_state *ks =3D &amp;session-&gt;key[i];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;state=
 =3D=3D S_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            conti=
nue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* we don&#39;t expect send_reliable to be=
 NULL when state is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * not S_UNDEF, but people have reported crashes nonetheless,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         * therefore we bette=
r catch this event, report and exit=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (!ks-&gt;send_reliable)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                &quot;ERROR: session-&gt;key[%d]-&gt;send_reliab=
le is NULL &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            &quot;while key state is %s=2E Exiting=2E&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                i, state_name(ks-&gt=
;state));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        for (int j =3D 0; j &lt; ks-&gt;sen=
d_reliable-&gt;size; j++)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;Wa=
rning buffer of freed TLS session is still in&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot; use (session-&gt=
;key[%d]=2Esend_reliable-&gt;array[%d])&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    i, j);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                goto used;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_INFO, &quot;Warning buffer of freed T=
LS session is still in use (session-&gt;key[%d]=2Eack_write_buf)&quot;, i);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            goto used;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        check_keystate_buf_not_used(to_link, ks);</=
span><br><span>     }</span><br><span>     return;</span><br><span> </span>=
<br><span>@@ -3362,13 +3393,11 @@</span><br><span>                 if (i =
=3D=3D TM_ACTIVE &amp;&amp; ks_lame-&gt;state &gt;=3D S_GENERATED_KEYS</spa=
n><br><span>                     &amp;&amp; !multi-&gt;opt=2Esingle_session=
)</span><br><span>                 {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    check_session_buf_not_used(to_link, sess=
ion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    move_session(multi,=
 TM_LAME_DUCK, TM_ACTIVE, true, to_link);</span><br><span>                 =
}</span><br><span>                 else</span><br><span>                 {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ch=
eck_session_buf_not_used(to_link, session);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    reset_session(multi, session);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    re=
set_session(multi, session, to_link);</span><br><span>                 }</s=
pan><br><span>             }</span><br><span>         }</span><br><span>@@ =
-3421,7 +3450,7 @@</span><br><span>      */</span><br><span>     if (lame_d=
uck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_se=
ssion_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt=
;session[TM_LAME_DUCK], true, to_link);</span><br><span>         msg(D_TLS_=
DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring key&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span>@@ -3436,8 +3465,7 @@</s=
pan><br><span>      */</span><br><span>     if (TLS_AUTHENTICATED(multi, &a=
mp;multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_session=
_buf_not_used(to_link, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        move_session(multi, TM_ACTIVE,=
 TM_INITIAL, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);</span><b=
r><span>         tas =3D tls_authentication_status(multi);</span><br><span>=
         msg(D_TLS_DEBUG_LOW,</span><br><span>             &quot;TLS: tls_m=
ulti_process: initial untrusted &quot;</span><br><span>@@ -3839,7 +3867,7 @=
@</span><br><span>                 goto error;</span><br><span>            =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           key_state_soft_reset(session);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            key_state_soft_reset(session, NULL);</spa=
n><br><span> </span><br><span>             dmsg(D_TLS_DEBUG, &quot;TLS: rec=
eived P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,</span><br><span>   =
               session_id_print(&amp;sid, &amp;gc));</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1893?usp=3Demail">change 1893</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1893?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce76=
26d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1893 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

=
</body></html>
--4mVhWpVUblg=--


--===============4812750226335106670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4812750226335106670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4812750226335106670==--


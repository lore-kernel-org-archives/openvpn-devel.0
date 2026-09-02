Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE88C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=L71u4jVzDHpXv/DeEOxbgrilXOpvoRBglQRix2Kd+oA=; b=k6s7sw5j/IdmPN
	MeUTq4v5nknyQCp7QG51qXeuZfwPsCU8PnLV8wO2hw+HFYJo+MtNCLtwXSdroWuW+TbPv+0sV8ee9
	AEAUuyIOgq1VVsMMr69XzXBEvYyhlqP7olvTPNQF90A6rLnqOVhMwSsSTKjwR9mMUlPhjRTpQaDPd
	pfY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1oNT-0002Li-GX;
	Wed, 02 Sep 2026 17:03:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1oNR-0002Lb-IU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 17:03:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ildvncCvF2CuE7kGEwwsyLyAZPh9IrzrAFZsAzJuQQA=; b=idSW3GgzzOx3UCqZYKBbDnizde
 k1lXZZWw41BN+GqKGX0O4YAeg7YkZPqFXn/6Cirm4I+0JMRpSwl5oo6VI9K9t4W936ZQjze3ELn30
 VdvnY3nihbLnoKKHSwUA14wfwNIAVs09+TDoGbl+WbGvAfr2KUQAl8iBzx19E7z6HCaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ildvncCvF2CuE7kGEwwsyLyAZPh9IrzrAFZsAzJuQQA=; b=d
 lda6DHGuHhAYw47LZjFauYZgDZ6nFfFU4mmd4Kq9ciF226YWHEYMVHYvPSao3dKzbBqOgiUNAlINJ
 VAwuxigYxaa+QqdxAEqsCFUxRoLIzrKw3O1VQBlKg/g1wLqfedOgeO8qKdGZ6g1gkjT2I7uxA2tL9
 +YEWW68TWSZPK3vk=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1oNI-0002td-Sg for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 17:03:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so11038845e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788368622; x=1788973422; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ildvncCvF2CuE7kGEwwsyLyAZPh9IrzrAFZsAzJuQQA=;
 b=FqHFDgiBi0JkdXEPFle3oQ31fl/EPaht54BbkZ2Fc0J+b+uDUf3ZyXwIJxsp3aViKe
 M3PXI3MkjA0sq1rp1O9qekDJH/eEyRFMvlcUWX83Bp6szJHMnrPRKW5jt8V3ZCAz10lG
 pnflBoqav2jm6j4ucTE05pSsp4SJCKmwfh7DrDrMsSO7U8jLuhDvbvYdPMRUF5S5gsfe
 pX7rojH0Ks9v8DpAiJdFTw7AocEjsGAZNvyt10wQQxdkPzJgasBiCmEF+2nXxC7kbUqB
 uCN1bJ+cBSkU5VGQbCC8vFKaNFE5An9L+C/GwyghurdFj92XuZsbWyMlncQu6Jt0BHsI
 n0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368622; x=1788973422;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ildvncCvF2CuE7kGEwwsyLyAZPh9IrzrAFZsAzJuQQA=;
 b=Z9lHpyCe9LaLql1ZsEiqx6l/VFi82UqrrshAs61JDchTXFe7Ax7Zw2XUCu6KAQS4/v
 QlqlK/Y8z/7kDbpImogsKGFMXCWNbv3WHamodju8GLYkxGq6N1L7v4rMrCRCYlP6Z6UJ
 L/Ox8M/QfkIjZFyHGCVM+OcH0sSp8yK7VJjzpLTy3aK8k/dnQ5HQnxmaKIyjilaaUvnh
 Bbx9PC5jyfFUowBTMYfmgmxc5WR5ydcLAQKTiar2nK5ogOd9FVDlFJtsFyuwXwVtSyWH
 CKNBwUjrswN1bzahAqLqs3UpAg5gGiJmGt3WvO4vpipNY6CeFSkurouEF6Qg52+pXemZ
 qg/w==
X-Gm-Message-State: AFuF++mpXxQTKqk1eyaserSvMw1BDm8LSj0WW+JBlgzkz+BkCHmsOJ4r
 PvQJUs2qKmSmZESMq4bEPxYcRM5OmE3JnYTc16mMmz78yPyaNgTTOgcah4QBMsoXgL7LKDFoZpl
 7L/3g47JEs6XY48ksiSi1AHsvVJmVzBo5d9mamg4GnKywIICk42yL2yzBcPzxPbTYBGp8RUx/82
 4N1FbAlQ==
X-Gm-Gg: AR+sD11BxaLmEhoKJDgCLAeblcCqlaewgIcct4OnkOw2G30etE4lPR8FN/a5gJ/roZv
 iazL2gtEJEon9jcuQHrR8J88hxMjPFKrfsVvFFs1Edif8Lxha0mYJsP+uWjaWVPWenqAZpJS7oF
 VLKwGlajzPdC7/Vuq9QVB1NurFyc2TEs1oSduBvlZLUuGkWklkj+PeyeD+4WHU1K7BnbbNcD99C
 uW0sGCupdOehfuNTqIQAlqtYF/353Nl9MzCc5qk2WdBUojLRZoQ9S2dCbGlr2uRKADPC5zpVw5q
 CORdAXNsHkfqSUZVYSU8cl4akcuQBHLzU88Ml1Qr81RJjHz1JJEJlVxdQtrv8yemSTpqeYWp0gY
 DXXyCB4eg1ruTsYK8PTqwkpNTgrkwBVW4Dxbi8oq/MdrVGG4yNaPy0t32DY9BxLIGZMb7tpKPNP
 w9sQ+qIZrobj9rlctPa9Jr9ElQh4FejkKkcUuXSdtQEMU20IJQCx1oFgICEO/n86NzTWFOZy5U8
 AuwJq2OuREVMYphNop90V9vovZW57VHzLjqItQkD7BadNbptlEeGYnA6TtrOobu5vcQyiFbJUQi
 0xXbX6NCtSZKb23yeIlDs/qaAEsJ4SgpmeJahZcpvpyR6wFyFdM=
X-Received: by 2002:a05:600c:a55:b0:49c:d60c:74e0 with SMTP id
 5b1f17b1804b1-49ce582a35emr116839715e9.13.1788368621426; 
 Wed, 02 Sep 2026 10:03:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60d8a6sm4604025e9.10.2026.09.02.10.03.40
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:03:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 17:03:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1893
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1893?usp=email>
X-Gerrit-Commit: 59c042b3002ef0030dc644710282e591cdb4a0b8
References: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MzY4NjE4MDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e95c97be129099aff62b59a8c63a9a97d21e464-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1oNI-0002td-Sg
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
Reply-To: gert@greenie.muc.de, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6488050118241960536=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6488050118241960536==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mCR0RvrGUhE="; charset=UTF-8

--mCR0RvrGUhE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

cron2 has uploade=
d this change for review=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/189=
3?usp=3Demail )


Change subject: Move check_session_buf_not_used method in=
to the method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Move check_session_buf_not_used method into the meth=
od that free the buffer

This cleans the code up a bit and ensure that we d=
o not miss an invocation
of a problematic code path=2E This is still a band=
-aid fix and a real fix
requires more refactoring and changing the logic=2E=


CVE: 2026-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gmail=2E=
com>
Github: openvpn/openvpn-private-issues#157
Reported-By: Haruki Oyama (=
Waseda University)
Github: openvpn/openvpn-private-issues#132
Change-Id: I6=
4920ed9f714803604d76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@r=
fc2549=2Eorg>
Acked-by: MaxF <max@max-fillinger=2Enet>
---
M src/openvpn/ss=
l=2Ec
1 file changed, 86 insertions(+), 58 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1893/1

diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 5f5d1f9=2E=2Ed259ff7 100644=

--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -96,6 +96,14 @@
 
 =
#endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
+/* forward decleration si=
nce tls_process needs this function prototype */
+static void
+check_sessio=
n_buf_not_used(struct buffer *to_link, struct tls_session *session);
+
+sta=
tic void
+check_keystate_buf_not_used(struct buffer *to_link, struct key_st=
ate *ks);
+
+
 /**
  * Limit the reneg_bytes value when using a small-block=
 (<128 bytes) cipher=2E
  *
@@ -896,10 +904,15 @@
  *                      =
 cleaned up=2E
  * @param clear        - Whether the memory allocated for t=
he \a ks object
  *                       should be overwritten with 0s=2E
=
+ *
+ * @param to_link      - if not NULL, check that the buffer does not c=
ontain
+ *                       any pointer to one of the internal structs=
 of ks
  */
 static void
-key_state_free(struct key_state *ks, bool clear)
=
+key_state_free(struct key_state *ks, bool clear, struct buffer *to_link)
 =
{
+    check_keystate_buf_not_used(to_link, ks);
+
     ks->state =3D S_UND=
EF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1046,8 +1059,9 @@
  *
  */
=
 static void
-tls_session_free(struct tls_session *session, bool clear)
+tl=
s_session_free(struct tls_session *session, bool clear, struct buffer *to_l=
ink)
 {
+    check_session_buf_not_used(to_link, session);
     tls_wrap_fr=
ee(&session->tls_wrap);
     tls_wrap_free(&session->tls_wrap_reneg);
 
@@ =
-1056,7 +1070,7 @@
         /* we don't need clear=3Dtrue for this call sin=
ce
          * the structs are part of session and get cleared
          * =
as part of session */
-        key_state_free(&session->key[i], false);
+  =
      key_state_free(&session->key[i], false, to_link);
     }
 
     free(=
session->common_name);
@@ -1075,14 +1089,16 @@
 
 
 static void
-move_sessi=
on(struct tls_multi *multi, int dest, int src, bool reinit_src)
+move_sessi=
on(struct tls_multi *multi, int dest, int src, bool reinit_src,
+          =
   struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, &mul=
ti->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=3D%s=
 src=3D%s reinit_src=3D%d",
         session_index_name(dest), session_inde=
x_name(src), reinit_src);
     ASSERT(src !=3D dest);
     ASSERT(src >=3D =
0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && dest < TM_SIZE);
-    tls_s=
ession_free(&multi->session[dest], false);
+    tls_session_free(&multi->se=
ssion[dest], false, to_link);
     multi->session[dest] =3D multi->session[=
src];
 
     if (reinit_src)
@@ -1098,9 +1114,9 @@
 }
 
 static void
-reset=
_session(struct tls_multi *multi, struct tls_session *session)
+reset_sessi=
on(struct tls_multi *multi, struct tls_session *session, struct buffer *to_=
link)
 {
-    tls_session_free(session, false);
+    tls_session_free(sessi=
on, false, to_link);
     tls_session_init(multi, session);
 }
 
@@ -1265,7=
 +1281,7 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)
     {
-        tls_=
session_free(&multi->session[i], false);
+        tls_session_free(&multi->=
session[i], false, NULL);
     }
 
     if (clear)
@@ -1764,13 +1780,13 @@
=
  * active key=2E
  */
 static void
-key_state_soft_reset(struct tls_sessio=
n *session)
+key_state_soft_reset(struct tls_session *session, struct buffe=
r *to_link)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];    =
    /* primary key */
     struct key_state *ks_lame =3D &session->key[KS_L=
AME_DUCK]; /* retiring key */
 
     ks->must_die =3D now + session->opt->t=
ransition_window;    /* remaining lifetime of old key */
-    key_state_fre=
e(ks_lame, false);
+    key_state_free(ks_lame, false, to_link);
     *ks_l=
ame =3D *ks;
 
     key_state_init(session, ks);
@@ -1781,7 +1797,7 @@
 voi=
d
 tls_session_soft_reset(struct tls_multi *tls_multi)
 {
-    key_state_so=
ft_reset(&tls_multi->session[TM_ACTIVE]);
+    key_state_soft_reset(&tls_mu=
lti->session[TM_ACTIVE], NULL);
 }
 
 /*
@@ -3101,13 +3117,13 @@
          =
   session->opt->aead_usage_limit,
             ks->crypto_options=2Ekey_ct=
x_bi=2Edecrypt=2Eplaintext_blocks + ks->n_packets,
             session->op=
t->aead_usage_limit);
-        key_state_soft_reset(session);
+        key_=
state_soft_reset(session, to_link);
     }
 
     /* Kill lame duck key tra=
nsition_window seconds after primary key negotiation */
     if (lame_duck_=
must_die(session, wakeup))
     {
-        key_state_free(ks_lame, true);
+=
        key_state_free(ks_lame, true, to_link);
         msg(D_TLS_DEBUG_LO=
W, "TLS: tls_process: killed expiring key");
     }
 
@@ -3200,6 +3216,55 @=
@
     return false;
 }
 
+static void
+check_keystate_buf_not_used(struct =
buffer *to_link, struct key_state *ks)
+{
+    if (ks->state =3D=3D S_UNDEF=
 || !to_link || !to_link->data)
+    {
+        return;
+    }
+
+    uint8=
_t *dataptr =3D to_link->data;
+
+    /* we don't expect send_reliable to b=
e NULL when state is
+     * not S_UNDEF, but people have reported crashes =
nonetheless,
+     * therefore we better catch this event, report and exit=
=2E
+     */
+    if (!ks->send_reliable)
+    {
+        msg(M_FATAL,
+   =
         "ERROR: ks=2Esend_reliable (key-id %d), is NULL "
+            "wh=
ile key state is %s=2E Exiting=2E",
+            ks->key_id, state_name(ks-=
>state));
+    }
+
+    for (int j =3D 0; j < ks->send_reliable->size; j++)=

+    {
+        if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D datapt=
r)
+        {
+            msg(M_INFO,
+                "Warning buffer of =
freed TLS session is still in"
+                " use (key-id %d, ks=2Esend=
_reliable->array[%d])",
+                ks->key_id, j);
+
+            got=
o used;
+        }
+    }
+
+    if (ks->ack_write_buf=2Edata =3D=3D datapt=
r)
+    {
+        msg(M_INFO, "Warning buffer of freed TLS session is stil=
l in use "
+                    "(ks=2Eack_write_buf, key-id %d)",
+       =
     ks->key_id);
+
+        goto used;
+    }
+    return;
+
+used:
+    t=
o_link->len =3D 0;
+    to_link->data =3D 0;
+}
 
 /**
  * This is a safe g=
uard function to double check that a buffer from a session is
@@ -3211,11 +=
3276,11 @@
 static void
 check_session_buf_not_used(struct buffer *to_link,=
 struct tls_session *session)
 {
-    const uint8_t *dataptr =3D to_link->d=
ata;
-    if (!dataptr)
+    if (!to_link || !to_link->data)
     {
       =
  return;
     }
+    const uint8_t *dataptr =3D to_link->data;
 
     /* C=
hecks buffers in tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=
=3D dataptr)
@@ -3234,41 +3299,7 @@
     for (int i =3D 0; i < KS_SIZE; i++=
)
     {
         const struct key_state *ks =3D &session->key[i];
-       =
 if (ks->state =3D=3D S_UNDEF)
-        {
-            continue;
-        }=

-
-        /* we don't expect send_reliable to be NULL when state is
-    =
     * not S_UNDEF, but people have reported crashes nonetheless,
-        =
 * therefore we better catch this event, report and exit=2E
-         */
- =
       if (!ks->send_reliable)
-        {
-            msg(M_FATAL,
-      =
          "ERROR: session->key[%d]->send_reliable is NULL "
-              =
  "while key state is %s=2E Exiting=2E",
-                i, state_name(ks-=
>state));
-        }
-
-        for (int j =3D 0; j < ks->send_reliable->si=
ze; j++)
-        {
-            if (ks->send_reliable->array[j]=2Ebuf=2Eda=
ta =3D=3D dataptr)
-            {
-                msg(M_INFO,
-           =
         "Warning buffer of freed TLS session is still in"
-               =
     " use (session->key[%d]=2Esend_reliable->array[%d])",
-               =
     i, j);
-
-                goto used;
-            }
-        }
-      =
  if (ks->ack_write_buf=2Edata =3D=3D dataptr)
-        {
-            msg(=
M_INFO, "Warning buffer of freed TLS session is still in use (session->key[=
%d]=2Eack_write_buf)", i);
-
-            goto used;
-        }
+        ch=
eck_keystate_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3362,13 +=
3393,11 @@
                 if (i =3D=3D TM_ACTIVE && ks_lame->state >=3D S=
_GENERATED_KEYS
                     && !multi->opt=2Esingle_session)
     =
            {
-                    check_session_buf_not_used(to_link, sess=
ion);
-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, tru=
e);
+                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true,=
 to_link);
                 }
                 else
                 {
-   =
                 check_session_buf_not_used(to_link, session);
-           =
         reset_session(multi, session);
+                    reset_session(=
multi, session, to_link);
                 }
             }
         }
@@ -=
3421,7 +3450,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_L=
AME_DUCK], wakeup))
     {
-        tls_session_free(&multi->session[TM_LAM=
E_DUCK], true);
+        tls_session_free(&multi->session[TM_LAME_DUCK], tr=
ue, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed=
 expiring key");
     }
 
@@ -3436,8 +3465,7 @@
      */
     if (TLS_AUTHE=
NTICATED(multi, &multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]))
     {
-   =
     check_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-    =
    move_session(multi, TM_ACTIVE, TM_INITIAL, true);
+        move_session=
(multi, TM_ACTIVE, TM_INITIAL, true, to_link);
         tas =3D tls_authent=
ication_status(multi);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tls=
_multi_process: initial untrusted "
@@ -3839,7 +3867,7 @@
                 =
goto error;
             }
 
-            key_state_soft_reset(session);
+ =
           key_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_D=
EBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s", i,
         =
         session_id_print(&sid, &gc));

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1893?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Change=
-Number: 1893
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2E=
de>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--mCR0RvrGUhE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>cron2 has uploaded this ch=
ange for <strong>review</strong>=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1893?usp=3Demail">View Change</a></p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Move=
 check_session_buf_not_used method into the method that free the buffer<br>=
<br>This cleans the code up a bit and ensure that we do not miss an invocat=
ion<br>of a problematic code path=2E This is still a band-aid fix and a rea=
l fix<br>requires more refactoring and changing the logic=2E<br><br>CVE: 20=
26-84471<br>Reported-By: Andreas Gabriel Berbescu &lt;aberbescu@gmail=2Ecom=
&gt;<br>Github: openvpn/openvpn-private-issues#157<br>Reported-By: Haruki O=
yama (Waseda University)<br>Github: openvpn/openvpn-private-issues#132<br>C=
hange-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=
=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 86 insertions=
(+), 58 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/93/1893/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f9=2E=2Ed259=
ff7 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl=2Ec</span><br><span>@@ -96,6 +96,14 @@</span><br><span> </s=
pan><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* forward decl=
eration since tls_process needs this function prototype */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+check_session_buf_not_used(struct buffer *to=
_link, struct tls_session *session);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_keys=
tate_buf_not_used(struct buffer *to_link, struct key_state *ks);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Limit t=
he reneg_bytes value when using a small-block (&lt;128 bytes) cipher=2E</sp=
an><br><span>  *</span><br><span>@@ -896,10 +904,15 @@</span><br><span>  * =
                      cleaned up=2E</span><br><span>  * @param clear       =
 - Whether the memory allocated for the \a ks object</span><br><span>  *   =
                    should be overwritten with 0s=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param to_link      - if not NULL, check that the buffe=
r does not contain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                       any pointer to one of the internal structs of ks</s=
pan><br><span>  */</span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-key_state_free(struct key_state *ks, bool clear)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_state_free(struc=
t key_state *ks, bool clear, struct buffer *to_link)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_keystate_buf_=
not_used(to_link, ks);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><span> </span>=
<br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><span>@@ -=
1046,8 +1059,9 @@</span><br><span>  *</span><br><span>  */</span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_sessi=
on_free(struct tls_session *session, bool clear)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tls_session_free(struct tls_session *session, =
bool clear, struct buffer *to_link)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_not_used(to_link, =
session);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap);</s=
pan><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap_reneg);</span><b=
r><span> </span><br><span>@@ -1056,7 +1070,7 @@</span><br><span>         /*=
 we don&#39;t need clear=3Dtrue for this call since</span><br><span>       =
   * the structs are part of session and get cleared</span><br><span>      =
    * as part of session */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        key_state_free(&amp;session-&gt;key[i], false);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        key_state_free(&amp;sessi=
on-&gt;key[i], false, to_link);</span><br><span>     }</span><br><span> </s=
pan><br><span>     free(session-&gt;common_name);</span><br><span>@@ -1075,=
14 +1089,16 @@</span><br><span> </span><br><span> </span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-move_session(stru=
ct tls_multi *multi, int dest, int src, bool reinit_src)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+move_session(struct tls_multi *multi, =
int dest, int src, bool reinit_src,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             struct buffer *to_link)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_n=
ot_used(to_link, &amp;multi-&gt;session[dest]);</span><br><span>     msg(D_=
TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=3D%s reinit_src=3D%d&=
quot;,</span><br><span>         session_index_name(dest), session_index_nam=
e(src), reinit_src);</span><br><span>     ASSERT(src !=3D dest);</span><br>=
<span>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SIZE);</span><br><sp=
an>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZE);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(&amp;multi-&gt;=
session[dest], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    tls_session_free(&amp;multi-&gt;session[dest], false, to_link);</spa=
n><br><span>     multi-&gt;session[dest] =3D multi-&gt;session[src];</span>=
<br><span> </span><br><span>     if (reinit_src)</span><br><span>@@ -1098,9=
 +1114,9 @@</span><br><span> }</span><br><span> </span><br><span> static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reset_session(struc=
t tls_multi *multi, struct tls_session *session)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+reset_session(struct tls_multi *multi, struct =
tls_session *session, struct buffer *to_link)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(session, fa=
lse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_sessio=
n_free(session, false, to_link);</span><br><span>     tls_session_init(mult=
i, session);</span><br><span> }</span><br><span> </span><br><span>@@ -1265,=
7 +1281,7 @@</span><br><span> </span><br><span>     for (int i =3D 0; i &lt=
; TM_SIZE; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;session[i], false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_sessio=
n_free(&amp;multi-&gt;session[i], false, NULL);</span><br><span>     }</spa=
n><br><span> </span><br><span>     if (clear)</span><br><span>@@ -1764,13 +=
1780,13 @@</span><br><span>  * active key=2E</span><br><span>  */</span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ke=
y_state_soft_reset(struct tls_session *session)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls_session *sessio=
n, struct buffer *to_link)</span><br><span> {</span><br><span>     struct k=
ey_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];        /* primary key */=
</span><br><span>     struct key_state *ks_lame =3D &amp;session-&gt;key[KS=
_LAME_DUCK]; /* retiring key */</span><br><span> </span><br><span>     ks-&=
gt;must_die =3D now + session-&gt;opt-&gt;transition_window;    /* remainin=
g lifetime of old key */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    key_state_free(ks_lame, false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    key_state_free(ks_lame, false, to_link);</span><br><=
span>     *ks_lame =3D *ks;</span><br><span> </span><br><span>     key_stat=
e_init(session, ks);</span><br><span>@@ -1781,7 +1797,7 @@</span><br><span>=
 void</span><br><span> tls_session_soft_reset(struct tls_multi *tls_multi)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 key_state_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    key_state_soft_reset(&amp;tls=
_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span> }</span><br><span> <=
/span><br><span> /*</span><br><span>@@ -3101,13 +3117,13 @@</span><br><span=
>             session-&gt;opt-&gt;aead_usage_limit,</span><br><span>       =
      ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks + ks-=
&gt;n_packets,</span><br><span>             session-&gt;opt-&gt;aead_usage_=
limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_st=
ate_soft_reset(session);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        key_state_soft_reset(session, to_link);</span><br><span>     }=
</span><br><span> </span><br><span>     /* Kill lame duck key transition_wi=
ndow seconds after primary key negotiation */</span><br><span>     if (lame=
_duck_must_die(session, wakeup))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks_lame, true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_free=
(ks_lame, true, to_link);</span><br><span>         msg(D_TLS_DEBUG_LOW, &qu=
ot;TLS: tls_process: killed expiring key&quot;);</span><br><span>     }</sp=
an><br><span> </span><br><span>@@ -3200,6 +3216,55 @@</span><br><span>     =
return false;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct buffer *to_link, =
struct key_state *ks)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;s=
tate =3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *data=
ptr =3D to_link-&gt;data;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we don=
&#39;t expect send_reliable to be NULL when state is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * not S_UNDEF, but people have repor=
ted crashes nonetheless,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * therefore we better catch this event, report and exit=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!ks-&gt;send_reliable)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;ERROR: ks=2Esend_relia=
ble (key-id %d), is NULL &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;while key state is %s=2E Exiting=2E&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;key=
_id, state_name(ks-&gt;state));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int j =3D 0;=
 j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D=
 dataptr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_IN=
FO,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
&quot;Warning buffer of freed TLS session is still in&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                &quot; use (key-id =
%d, ks=2Esend_reliable-&gt;array[%d])&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ks-&gt;key_id, j);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            goto used;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;ack_=
write_buf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_INFO, &quot;Warning buffer of freed TLS session is still in us=
e &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &quot;(ks=2Eack_write_buf, key-id %d)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;key_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        goto used;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+used:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;len =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;data =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
 </span><br><span> /**</span><br><span>  * This is a safe guard function to=
 double check that a buffer from a session is</span><br><span>@@ -3211,11 +=
3276,11 @@</span><br><span> static void</span><br><span> check_session_buf_=
not_used(struct buffer *to_link, struct tls_session *session)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_=
t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!dataptr)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!to_link || !to_link-&gt;data)</span><br><span>     {</spa=
n><br><span>         return;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =3D to_link-&g=
t;data;</span><br><span> </span><br><span>     /* Checks buffers in tls_wra=
p */</span><br><span>     if (session-&gt;tls_wrap=2Ework=2Edata =3D=3D dat=
aptr)</span><br><span>@@ -3234,41 +3299,7 @@</span><br><span>     for (int =
i =3D 0; i &lt; KS_SIZE; i++)</span><br><span>     {</span><br><span>      =
   const struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;state =3D=3D S_UNDE=
F)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* we don&#39;t expect send_reliable to be NULL when sta=
te is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * not S=
_UNDEF, but people have reported crashes nonetheless,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * therefore we better catch this e=
vent, report and exit=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!ks-&gt;send_reliable)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             &quot;ERROR: session-&gt;key[%d]-&gt;send_reliable is NULL &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &q=
uot;while key state is %s=2E Exiting=2E&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                i, state_name(ks-&gt;state));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;s=
ize; j++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (ks-&gt;s=
end_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(M_INFO,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;Warning buffer of=
 freed TLS session is still in&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    &quot; use (session-&gt;key[%d]=2Esend_r=
eliable-&gt;array[%d])&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    i, j);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        goto used;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;ack_=
write_buf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(M_INFO, &quot;Warning buffer of freed TLS session is still i=
n use (session-&gt;key[%d]=2Eack_write_buf)&quot;, i);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            goto used;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        check_keystate_buf_not_used(to_link, ks);</span><br><span>     }=
</span><br><span>     return;</span><br><span> </span><br><span>@@ -3362,13=
 +3393,11 @@</span><br><span>                 if (i =3D=3D TM_ACTIVE &amp;&=
amp; ks_lame-&gt;state &gt;=3D S_GENERATED_KEYS</span><br><span>           =
          &amp;&amp; !multi-&gt;opt=2Esingle_session)</span><br><span>     =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            check_session_buf_not_used(to_link, session);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    move_session(multi,=
 TM_LAME_DUCK, TM_ACTIVE, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    move_session(multi, TM_LAME_DUCK, TM_ACTIV=
E, true, to_link);</span><br><span>                 }</span><br><span>     =
            else</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    check_session_buf_not_u=
sed(to_link, session);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    reset_session(multi, session);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    reset_session(multi, =
session, to_link);</span><br><span>                 }</span><br><span>     =
        }</span><br><span>         }</span><br><span>@@ -3421,7 +3450,7 @@<=
/span><br><span>      */</span><br><span>     if (lame_duck_must_die(&amp;m=
ulti-&gt;session[TM_LAME_DUCK], wakeup))</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&amp;mul=
ti-&gt;session[TM_LAME_DUCK], true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;session[TM_LAME_DU=
CK], true, to_link);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TL=
S: tls_multi_process: killed expiring key&quot;);</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -3436,8 +3465,7 @@</span><br><span>     =
 */</span><br><span>     if (TLS_AUTHENTICATED(multi, &amp;multi-&gt;sessio=
n[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        check_session_buf_not_used(to_li=
nk, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        move_session(multi, TM_ACTIVE, TM_INITIAL, true);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        move_sessio=
n(multi, TM_ACTIVE, TM_INITIAL, true, to_link);</span><br><span>         ta=
s =3D tls_authentication_status(multi);</span><br><span>         msg(D_TLS_=
DEBUG_LOW,</span><br><span>             &quot;TLS: tls_multi_process: initi=
al untrusted &quot;</span><br><span>@@ -3839,7 +3867,7 @@</span><br><span> =
                goto error;</span><br><span>             }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            key_stat=
e_soft_reset(session);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            key_state_soft_reset(session, NULL);</span><br><span> </span=
><br><span>             dmsg(D_TLS_DEBUG, &quot;TLS: received P_CONTROL_SOF=
T_RESET_V1 s=3D%d sid=3D%s&quot;, i,</span><br><span>                  sess=
ion_id_print(&amp;sid, &amp;gc));</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893?usp=3De=
mail">change 1893</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1893?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1893 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt;=
 </div>

</body></html>
--mCR0RvrGUhE=--


--===============6488050118241960536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6488050118241960536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6488050118241960536==--


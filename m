Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8304BCCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFZRIcUh7m9Cn4GnOIBfwZgGlFatry9gOKrJOTTqwXU=; b=BwfClhZIpsRxHewvW3sbgQgpDw
	gTrWyd5qQgnXNJaUR+OXuPCNx8TeXv2/mUuLaHGd5nEyiqX2sTW7QIKS2zXrH9j9+uZnqU66QwN+7
	Gik9Ld81rmPjXJl50rRWQfMscMip8LA7Z1bCVZ/oTqQvLcru7YheyU7VSqZQJMb78f5c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISWR-0001bE-Ft;
	Sun, 18 Oct 2026 15:10:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xISWQ-0001b4-FD
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jdteYLLGfnUDEpzx2i19lawwt4a/1ItfRjKIlyzP+XI=; b=WDlxA4PzcXKbDyWCYjL6fXWFaG
 qyAuG3gz8Pdhwhf1V7KNDWy6SE2cBxHxAsulRPwZCfFfrWt9mOuDF3m5dGmfiMt7NFXCSAFVpnaBS
 aS5LyDKHn+oLG8ExjunBaLhpbPT4itp2C6hEQfA4WDXJe7Sx24DL2t7Tf4636uBMpBBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jdteYLLGfnUDEpzx2i19lawwt4a/1ItfRjKIlyzP+XI=; b=H
 pxnw9IAbgxsfJOxyhx1LzDxMUk8GhCGsG+FIYBoqeTeY4aAI3jnqbxboXZw5Bmufb5WrCll12QLpT
 8w2Js/sarv1N1Fu1dj3cg0X7GI4qtt3EzETq0Jrewxs4hIdkcGg0eFlXnu7e8n1GOaKKaX5/zA4dx
 rowQL0+Zrv4Q9GU8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xISWM-00014O-V0 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:10:03 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso722922f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792336192; x=1792940992; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jdteYLLGfnUDEpzx2i19lawwt4a/1ItfRjKIlyzP+XI=;
 b=grGKFEWpWUzT6YwN4Yje95vzRkl/HiEN9HsCAv2LZYB85lMdIrRFX4HI7YTAUjp9XF
 pmoORpJOzoFuU9OTCm8DpdZ2srPjBBoRa7uq1l+bBQBMqz1z4QF1oHsgiq7lA8i5k2E5
 xaY2YJAYwTfzx6kcwhdKG6bEkePfPngk8vyYUyn1sBMGkWHZhSrSn9Jzjo9C6Xq3vC3I
 IkVKyWaWYeI5wrh/yAEKJJHduMKIrlr0cfdLebkMUID36LgaXGJm6C5fqYPNwGB6E+Y4
 PXAZpMRuA/kQC9nfre6ZltV1+oDHgaEX5xWtabQbjB/aLswennb7k/zZHBTxR168fkf5
 LoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792336192; x=1792940992;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jdteYLLGfnUDEpzx2i19lawwt4a/1ItfRjKIlyzP+XI=;
 b=RgMw+lBpYmrxHxTZrOLEw/tuNEFNyE1DlWugLM8woexltKLmEbKBYii3hK1bUvZFsi
 yeXQC38ii8dFnG+Kh05ugjntTPMXVGxfPWqeIHMwfDSwqhNhIBuxBqTZ66+IbuyeP4k/
 EfalKHcMs8iaF+xqyqB6+K3vfXYhmeivouYeYmOXl0KTGp4o+0fiJnSd/ZtkaLbNGaBp
 NlTQ9xwNSIMxiUbxbC/PVDAcnxkSmWgcqfyRZr5b2ugha7kTQztsPbR6LBQUhH49LeJm
 R+icLglf0dtFmuGjTghgNQNwalstH39lJpo9zG/B0lvlpr1CWxG2uHI0q/bstufSaych
 hsJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznsPlz494ujrSfIkx1carvhbHhQ7M8j4MY/Mb92XL4esmqEivVJ6o8kUrN9pNvn97qqeXhBZoU91mwczia@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKLQANvCVTd7HURDoBAILuovexveh8T+4I/ArbQz5/tNiskmLpa
 BtfstAAt8/hs6l+4vyI/q0jixakL+oewqMiMI/bVZObmISHZe1FOGxiJJDYKJDYDq3Y+DFDsQub
 39i96HzpjkAeYT0Wl5F3WZQAJpOQ2MeqalQOGvq9CKhcPdqSMFP/4EkGvN7RzX+n2nxbX
X-Gm-Gg: AYBFou2Vbij+4Q3FVoZa1lS9M4CLRkvWnnZ6bMYOKAZFbFQxu7Ca8ihtQD/NwclEP9J
 H1gW04alkcvvXTHcqo85WeyIip0THejjfv5JsyMmwwNZbjBsUEM9oHoGweyvg2eJ68XSfeePgJu
 pcORdC8+Bzz7ygC4YlQ/T/4kWk1lr+YH0Saxe7hhnpNpc6FBwip62OQ9FdqEuZr2Yhf2xVjY17V
 aOICsK91zg5HlmB4UyMr6wJtwB5xB9tb1xEoGL2Kzi4w2vUDQUbPHMfBeCJqZHu1aeh7QNPq46M
 98rmI+kc9Gb7cfST8nHgo7MGT18JCBlibLxVMXQjCSyqDpil5mJhp+7Or53SNyxwuYnZyx5utkm
 7ojcTget+Z1J081tWghx0nCGd/aQ+fyosRJ9Cxzb3beDhZZW168eqiRWktbUHcBfHrzPAMlj/DO
 rqA29dwXcnr+P3n9br42CbgyKfmmBQ6u22n2u2HWzdWsesX4+0eKS+17U+nzA1p7mvDUAvy+bkx
 Dl2A9qpBkgkewm4xrl1sz7lpI5EHQWhzmhRjMwsAHF0s7O5Fl/TOeFcnaPN4eOP8yczgb3Spl+Z
 UdyqdtVTUjRY3FYRsOo5k6JnEVxE2VwpqnaqY319EKxdusMvHlgfdBEi+t2/
X-Received: by 2002:a05:6000:454c:b0:48d:b75d:30f6 with SMTP id
 ffacd0b85a97d-48e07fa048amr6907510f8f.35.1792336190793; 
 Sun, 18 Oct 2026 08:09:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50ae5esm18834147f8f.51.2026.10.18.08.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:09:50 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:09:49 +0000
To: Max Fillinger <max@max-fillinger.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 592ee5036d5931e0aefa536cb3e5494d8a2b9dc3
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb6f1a3ff5637ed03202fbc3dfadd25c283cbe61-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xISWM-00014O-V0
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.5]: Move
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4191960751157788611=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4191960751157788611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JP7cdTJp52s="; charset=UTF-8

--JP7cdTJp52s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1985?usp=3Demail )

Change subject: Move check_session_buf_not_=
used method into the method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move check_session_buf_not_used metho=
d into the method that free the buffer

This cleans the code up a bit and e=
nsure that we do not miss an invocation
of a problematic code path=2E This =
is still a band-aid fix and a real fix
requires more refactoring and changi=
ng the logic=2E

v2: sprinkle some "const" over check_keystate_buf_not_used=
() args
v3: add missing doxygen for to_link parameter to tls_session_free()=


CVE: 2026-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gmail=2E=
com>
Tested-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Github: op=
envpn/openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda Universi=
ty)
Github: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f7148036=
04d76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893
Acked-by: MaxF <=
max@max-fillinger=2Enet>
Message-Id: <20260903061209=2E12599-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38913=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985
(cherry picked from commit 2a8=
81d737b2562ee28247148160cfb60f0ba4645)
Message-Id: <20261013194518=2E30653-=
1-gert@greenie=2Emuc=2Ede>
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 99 insertions(+), 62 delet=
ions(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9b=
6cfa0=2E=2E26a1b5d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -93,6 +93,14 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 =

+/* forward decleration since tls_process needs this function prototype */=

+static void
+check_session_buf_not_used(struct buffer *to_link, struct tl=
s_session *session);
+
+static void
+check_keystate_buf_not_used(struct buf=
fer *to_link, const struct key_state *ks);
+
+
 /**
  * SSL/TLS Cipher suit=
e name translation table
  */
@@ -989,10 +997,15 @@
  *                    =
   cleaned up=2E
  * @param clear        - Whether the memory allocated for=
 the \a ks object
  *                       should be overwritten with 0s=
=2E
+ *
+ * @param to_link      - if not NULL, check that the buffer does n=
ot contain
+ *                       any pointer to one of the internal str=
ucts of ks
  */
 static void
-key_state_free(struct key_state *ks, bool cle=
ar)
+key_state_free(struct key_state *ks, bool clear, struct buffer *to_lin=
k)
 {
+    check_keystate_buf_not_used(to_link, ks);
+
     ks->state =3D S=
_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1143,16 +1156,25 @@
  *=
 @param session      - A pointer to the \c tls_session structure to be
  * =
                      cleaned up=2E
  * @param clear        - Whether the m=
emory allocated for the \a session
- *                       object should =
be overwritten with 0s=2E
+ *                       object should be overwr=
itten with 0s=2E This
+ *                       implicitly sets many states=
 to 0/false,
+ *                       e=2Eg=2E the validity of the keys in=
 the structure
+ * @param to_link      - if not NULL, check that the buffer=
 does not contain
+ *                       any pointer to one of the inter=
nal structs of ks
+ *
  */
 static void
-tls_session_free(struct tls_sessio=
n *session, bool clear)
+tls_session_free(struct tls_session *session, bool=
 clear, struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link,=
 session);
     tls_wrap_free(&session->tls_wrap);
 
     for (size_t i =3D=
 0; i < KS_SIZE; ++i)
     {
-        key_state_free(&session->key[i], fals=
e);
+        /* we don't need clear=3Dtrue for this call since
+         * =
the structs are part of session and get cleared
+         * as part of sess=
ion */
+        key_state_free(&session->key[i], false, to_link);
     }
 
=
     if (session->common_name)
@@ -1174,8 +1196,10 @@
 
 
 static void
-mov=
e_session(struct tls_multi *multi, int dest, int src, bool reinit_src)
+mov=
e_session(struct tls_multi *multi, int dest, int src, bool reinit_src,
+   =
          struct buffer *to_link)
 {
+    check_session_buf_not_used(to_lin=
k, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: de=
st=3D%s src=3D%s reinit_src=3D%d",
         session_index_name(dest),
     =
    session_index_name(src),
@@ -1183,7 +1207,7 @@
     ASSERT(src !=3D des=
t);
     ASSERT(src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && de=
st < TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+    tl=
s_session_free(&multi->session[dest], false, to_link);
     multi->session[=
dest] =3D multi->session[src];
 
     if (reinit_src)
@@ -1199,9 +1223,9 @@=

 }
 
 static void
-reset_session(struct tls_multi *multi, struct tls_sessi=
on *session)
+reset_session(struct tls_multi *multi, struct tls_session *se=
ssion, struct buffer *to_link)
 {
-    tls_session_free(session, false);
+ =
   tls_session_free(session, false, to_link);
     tls_session_init(multi, =
session);
 }
 
@@ -1369,7 +1393,7 @@
 
     for (int i =3D 0; i < TM_SIZE; =
++i)
     {
-        tls_session_free(&multi->session[i], false);
+        =
tls_session_free(&multi->session[i], false, NULL);
     }
 
     if (clear)=

@@ -2125,13 +2149,13 @@
  * active key=2E
  */
 static void
-key_state_sof=
t_reset(struct tls_session *session)
+key_state_soft_reset(struct tls_sessi=
on *session, struct buffer *to_link)
 {
     struct key_state *ks =3D &sess=
ion->key[KS_PRIMARY];      /* primary key */
     struct key_state *ks_lame=
 =3D &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die =
=3D now + session->opt->transition_window; /* remaining lifetime of old key=
 */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, false=
, to_link);
     *ks_lame =3D *ks;
 
     key_state_init(session, ks);
@@ -=
2249,7 +2273,7 @@
          * push request, also signal that the client wan=
ts
          * to get push-reply messages without without requiring a round=

          * trip for a push request message*/
-        if(session->opt->pu=
ll)
+        if (session->opt->pull)
         {
             iv_proto |=3D =
IV_PROTO_REQUEST_PUSH;
         }
@@ -2426,7 +2450,7 @@
      * NCP options=
 are processed and we have no extra state for NCP finished=2E
      */
    =
 if (session->opt->server && (session->opt->mode !=3D MODE_SERVER
-        =
    || multi->multi_state =3D=3D CAS_SUCCEEDED))
+                         =
        || multi->multi_state =3D=3D CAS_SUCCEEDED))
     {
         if (ks=
->authenticated > KS_AUTH_FALSE)
         {
@@ -2679,13 +2703,13 @@
       =
      (int) (now - ks->established), session->opt->renegotiate_seconds,
   =
          ks->n_bytes, session->opt->renegotiate_bytes,
             ks->n_=
packets, session->opt->renegotiate_packets);
-        key_state_soft_reset(=
session);
+        key_state_soft_reset(session, to_link);
     }
 
     /*=
 Kill lame duck key transition_window seconds after primary key negotiation=
 */
     if (lame_duck_must_die(session, wakeup))
     {
-        key_state=
_free(ks_lame, true);
+        key_state_free(ks_lame, true, to_link);
    =
     msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
=
 
@@ -3009,6 +3033,56 @@
     return false;
 }
 
+static void
+check_keysta=
te_buf_not_used(struct buffer *to_link, const struct key_state *ks)
+{
+   =
 if (ks->state =3D=3D S_UNDEF || !to_link || !to_link->data)
+    {
+      =
  return;
+    }
+
+    uint8_t *dataptr =3D to_link->data;
+
+    /* we do=
n't expect send_reliable to be NULL when state is
+     * not S_UNDEF, but =
people have reported crashes nonetheless,
+     * therefore we better catch=
 this event, report and exit=2E
+     */
+    if (!ks->send_reliable)
+    =
{
+        msg(M_FATAL,
+            "ERROR: ks=2Esend_reliable (key-id %d)=
, is NULL "
+            "while key state is %s=2E Exiting=2E",
+          =
  ks->key_id, state_name(ks->state));
+    }
+
+    for (int j =3D 0; j < k=
s->send_reliable->size; j++)
+    {
+        if (ks->send_reliable->array[j=
]=2Ebuf=2Edata =3D=3D dataptr)
+        {
+            msg(M_INFO,
+       =
         "Warning buffer of freed TLS session is still in"
+               =
 " use (key-id %d, ks=2Esend_reliable->array[%d])",
+                ks->ke=
y_id, j);
+
+            goto used;
+        }
+    }
+
+    if (ks->ack_wr=
ite_buf=2Edata =3D=3D dataptr)
+    {
+        msg(M_INFO, "Warning buffer =
of freed TLS session is still in use "
+            "(ks=2Eack_write_buf, k=
ey-id %d)",
+            ks->key_id);
+
+        goto used;
+    }
+    ret=
urn;
+
+used:
+    to_link->len =3D 0;
+    to_link->data =3D 0;
+}
+
 /**
=
  * This is a safe guard function to double check that a buffer from a sess=
ion is
  * not used in a session to avoid a use after free=2E
@@ -3019,58 +=
3093,24 @@
 static void
 check_session_buf_not_used(struct buffer *to_link,=
 struct tls_session *session)
 {
-    uint8_t *dataptr =3D to_link->data;
-=
    if (!dataptr)
+    if (!to_link || !to_link->data)
     {
         retu=
rn;
     }
+    const uint8_t *dataptr =3D to_link->data;
 
     /* Checks =
buffers in tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=3D data=
ptr)
     {
         msg(M_INFO, "Warning buffer of freed TLS session is "
=
-                    "still in use (tls_wrap=2Ework=2Edata)");
+           =
 "still in use (tls_wrap=2Ework=2Edata)");
         goto used;
     }
 
   =
  for (int i =3D 0; i < KS_SIZE; i++)
     {
-        struct key_state *ks =
=3D &session->key[i];
-        if (ks->state =3D=3D S_UNDEF)
-        {
-  =
          continue;
-        }
-
-        /* we don't expect send_reliable =
to be NULL when state is
-         * not S_UNDEF, but people have reported =
crashes nonetheless,
-         * therefore we better catch this event, repo=
rt and exit=2E
-         */
-        if (!ks->send_reliable)
-        {
-  =
          msg(M_FATAL,
-                "ERROR: session->key[%d]->send_reli=
able is NULL "
-                "while key state is %s=2E Exiting=2E",
-   =
             i, state_name(ks->state));
-        }
-
-        for (int j =
=3D 0; j < ks->send_reliable->size; j++)
-        {
-            if (ks->se=
nd_reliable->array[j]=2Ebuf=2Edata =3D=3D dataptr)
-            {
-        =
        msg(M_INFO,
-                    "Warning buffer of freed TLS sessi=
on is still in"
-                    " use (session->key[%d]=2Esend_reliabl=
e->array[%d])",
-                    i, j);
-
-                goto used;
-=
            }
-        }
-        if (ks->ack_write_buf=2Edata =3D=3D datap=
tr)
-        {
-            msg(M_INFO, "Warning buffer of freed TLS sessio=
n is still in use (session->key[%d]=2Eack_write_buf)", i);
-
-            g=
oto used;
-        }
+        const struct key_state *ks =3D &session->key[=
i];
+        check_keystate_buf_not_used(to_link, ks);
     }
     return;
=
 
@@ -3170,13 +3210,11 @@
                     && ks_lame->state >=3D S_ACT=
IVE
                     && !multi->opt=2Esingle_session)
                 =
{
-                    check_session_buf_not_used(to_link, session);
-     =
               move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+       =
             move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
 =
                }
                 else
                 {
-               =
     check_session_buf_not_used(to_link, session);
-                    res=
et_session(multi, session);
+                    reset_session(multi, sessi=
on, to_link);
                 }
             }
         }
@@ -3191,7 +3229=
,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], w=
akeup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], tru=
e);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link)=
;
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring ke=
y");
     }
 
@@ -3206,8 +3244,7 @@
      */
     if (DECRYPT_KEY_ENABLED(m=
ulti, &multi->session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))
     {
-        che=
ck_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        move=
_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
+        move_session(multi=
, TM_ACTIVE, TM_UNTRUSTED, true, to_link);
         msg(D_TLS_DEBUG_LOW, "T=
LS: tls_multi_process: untrusted session promoted to %strusted",
          =
   tas =3D=3D TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
     }
@@ -3622=
,7 +3659,7 @@
                 goto error;
             }
 
-            ke=
y_state_soft_reset(session);
+            key_state_soft_reset(session, NUL=
L);
 
             dmsg(D_TLS_DEBUG,
                  "TLS: received P_CON=
TROL_SOFT_RESET_V1 s=3D%d sid=3D%s",

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1985?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/=
2=2E5
Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Ch=
ange-Number: 1985
Gerrit-PatchSet: 4
Gerrit-Owner: Max Fillinger <max@max-f=
illinger=2Enet>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerri=
t-CC: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--JP7cdTJp52s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1985?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Move check_session_buf_not_used me=
thod into the method that free the buffer<br><br>This cleans the code up a =
bit and ensure that we do not miss an invocation<br>of a problematic code p=
ath=2E This is still a band-aid fix and a real fix<br>requires more refacto=
ring and changing the logic=2E<br><br>v2: sprinkle some &quot;const&quot; o=
ver check_keystate_buf_not_used() args<br>v3: add missing doxygen for to_li=
nk parameter to tls_session_free()<br><br>CVE: 2026-84471<br>Reported-By: A=
ndreas Gabriel Berbescu &lt;aberbescu@gmail=2Ecom&gt;<br>Tested-By: Andreas=
 Gabriel Berbescu &lt;aberbescu@gmail=2Ecom&gt;<br>Github: openvpn/openvpn-=
private-issues#157<br>Reported-By: Haruki Oyama (Waseda University)<br>Gith=
ub: openvpn/openvpn-private-issues#132<br>Change-Id: I64920ed9f714803604d76=
c6df6b38cf20ce7626d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893<br>Acked-=
by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>Message-Id: &lt;20260903061209=
=2E12599-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38913=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Steffan Kar=
ger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1985<br>(cherry picked from commit 2a881d737b2562ee282471481=
60cfb60f0ba4645)<br>Message-Id: &lt;20261013194518=2E30653-1-gert@greenie=
=2Emuc=2Ede&gt;<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 99 insertions(+), 62=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openv=
pn/ssl=2Ec</span><br><span>index 9b6cfa0=2E=2E26a1b5d 100644</span><br><spa=
n>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span=
><br><span>@@ -93,6 +93,14 @@</span><br><span> </span><br><span> #endif /* =
ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* forward decleration since tls_process=
 needs this function prototype */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+check_session_buf_not_used(struct buffer *to_link, struct tls_session=
 *session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct =
buffer *to_link, const struct key_state *ks);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /**</span><br><span>  * SSL/TLS Cipher suite name =
translation table</span><br><span>  */</span><br><span>@@ -989,10 +997,15 @=
@</span><br><span>  *                       cleaned up=2E</span><br><span> =
 * @param clear        - Whether the memory allocated for the \a ks object<=
/span><br><span>  *                       should be overwritten with 0s=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param to_link      - if not NULL,=
 check that the buffer does not contain</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *                       any pointer to one of the inte=
rnal structs of ks</span><br><span>  */</span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_st=
ate *ks, bool clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+key_state_free(struct key_state *ks, bool clear, struct buffer *to_link)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  check_keystate_buf_not_used(to_link, ks);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</sp=
an><br><span> </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);=
</span><br><span>@@ -1143,16 +1156,25 @@</span><br><span>  * @param session=
      - A pointer to the \c tls_session structure to be</span><br><span>  *=
                       cleaned up=2E</span><br><span>  * @param clear      =
  - Whether the memory allocated for the \a session</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *                       object should be o=
verwritten with 0s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                       object should be overwritten with 0s=2E This</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                     =
  implicitly sets many states to 0/false,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *                       e=2Eg=2E the validity of the=
 keys in the structure</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param to_link      - if not NULL, check that the buffer does not con=
tain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
          any pointer to one of the internal structs of ks</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  */</span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_s=
ession_free(struct tls_session *session, bool clear)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_session_free(struct tls_session *sess=
ion, bool clear, struct buffer *to_link)</span><br><span> {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_not_used(to_l=
ink, session);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap=
);</span><br><span> </span><br><span>     for (size_t i =3D 0; i &lt; KS_SI=
ZE; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        key_state_free(&amp;session-&gt;key[i], false);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* we don&#39;t need =
clear=3Dtrue for this call since</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * the structs are part of session and get cleared</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * as part of s=
ession */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ke=
y_state_free(&amp;session-&gt;key[i], false, to_link);</span><br><span>    =
 }</span><br><span> </span><br><span>     if (session-&gt;common_name)</spa=
n><br><span>@@ -1174,8 +1196,10 @@</span><br><span> </span><br><span> </spa=
n><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-move_session(struct tls_multi *multi, int dest, int src, bool reinit_src=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+move_session(struc=
t tls_multi *multi, int dest, int src, bool reinit_src,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             struct buffer *to_link)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 check_session_buf_not_used(to_link, &amp;multi-&gt;session[dest]);</span><=
br><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=
=3D%s reinit_src=3D%d&quot;,</span><br><span>         session_index_name(de=
st),</span><br><span>         session_index_name(src),</span><br><span>@@ -=
1183,7 +1207,7 @@</span><br><span>     ASSERT(src !=3D dest);</span><br><sp=
an>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SIZE);</span><br><span>=
     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZE);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(&amp;multi-&gt;ses=
sion[dest], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tls_session_free(&amp;multi-&gt;session[dest], false, to_link);</span><=
br><span>     multi-&gt;session[dest] =3D multi-&gt;session[src];</span><br=
><span> </span><br><span>     if (reinit_src)</span><br><span>@@ -1199,9 +1=
223,9 @@</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-reset_session(struct t=
ls_multi *multi, struct tls_session *session)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+reset_session(struct tls_multi *multi, struct tls=
_session *session, struct buffer *to_link)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(session, false=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_session_f=
ree(session, false, to_link);</span><br><span>     tls_session_init(multi, =
session);</span><br><span> }</span><br><span> </span><br><span>@@ -1369,7 +=
1393,7 @@</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; T=
M_SIZE; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        tls_session_free(&amp;multi-&gt;session[i], false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_session_f=
ree(&amp;multi-&gt;session[i], false, NULL);</span><br><span>     }</span><=
br><span> </span><br><span>     if (clear)</span><br><span>@@ -2125,13 +214=
9,13 @@</span><br><span>  * active key=2E</span><br><span>  */</span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_s=
tate_soft_reset(struct tls_session *session)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls_session *session, =
struct buffer *to_link)</span><br><span> {</span><br><span>     struct key_=
state *ks =3D &amp;session-&gt;key[KS_PRIMARY];      /* primary key */</spa=
n><br><span>     struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME=
_DUCK]; /* retiring key */</span><br><span> </span><br><span>     ks-&gt;mu=
st_die =3D now + session-&gt;opt-&gt;transition_window; /* remaining lifeti=
me of old key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    k=
ey_state_free(ks_lame, false);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    key_state_free(ks_lame, false, to_link);</span><br><span>   =
  *ks_lame =3D *ks;</span><br><span> </span><br><span>     key_state_init(s=
ession, ks);</span><br><span>@@ -2249,7 +2273,7 @@</span><br><span>        =
  * push request, also signal that the client wants</span><br><span>       =
   * to get push-reply messages without without requiring a round</span><br=
><span>          * trip for a push request message*/</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if(session-&gt;opt-&gt;pull)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;op=
t-&gt;pull)</span><br><span>         {</span><br><span>             iv_prot=
o |=3D IV_PROTO_REQUEST_PUSH;</span><br><span>         }</span><br><span>@@=
 -2426,7 +2450,7 @@</span><br><span>      * NCP options are processed and w=
e have no extra state for NCP finished=2E</span><br><span>      */</span><b=
r><span>     if (session-&gt;opt-&gt;server &amp;&amp; (session-&gt;opt-&gt=
;mode !=3D MODE_SERVER</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            || multi-&gt;multi_state =3D=3D CAS_SUCCEEDED))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                 |=
| multi-&gt;multi_state =3D=3D CAS_SUCCEEDED))</span><br><span>     {</span=
><br><span>         if (ks-&gt;authenticated &gt; KS_AUTH_FALSE)</span><br>=
<span>         {</span><br><span>@@ -2679,13 +2703,13 @@</span><br><span>  =
           (int) (now - ks-&gt;established), session-&gt;opt-&gt;renegotiat=
e_seconds,</span><br><span>             ks-&gt;n_bytes, session-&gt;opt-&gt=
;renegotiate_bytes,</span><br><span>             ks-&gt;n_packets, session-=
&gt;opt-&gt;renegotiate_packets);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        key_state_soft_reset(session);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        key_state_soft_reset(session, to_lin=
k);</span><br><span>     }</span><br><span> </span><br><span>     /* Kill l=
ame duck key transition_window seconds after primary key negotiation */</sp=
an><br><span>     if (lame_duck_must_die(session, wakeup))</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_sta=
te_free(ks_lame, true);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        key_state_free(ks_lame, true, to_link);</span><br><span>       =
  msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_process: killed expiring key&quot;);<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -3009,6 +3033,5=
6 @@</span><br><span>     return false;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_use=
d(struct buffer *to_link, const struct key_state *ks)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link=
-&gt;data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* we don&#39;t expect send_reliable to be NULL when=
 state is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * not=
 S_UNDEF, but people have reported crashes nonetheless,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * therefore we better catch this e=
vent, report and exit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!ks-&gt;send_reliable)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_FATAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;ERROR: ks=2Esend_reliable (key-id %d), is NULL &quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;while key stat=
e is %s=2E Exiting=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ks-&gt;key_id, state_name(ks-&gt;state));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;send_reliable-&=
gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_INFO,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &quot;Warning buffer of freed TLS session is=
 still in&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            &quot; use (key-id %d, ks=2Esend_reliable-&gt;array[%d])&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ks-=
&gt;key_id, j);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto used;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Warning buffer of f=
reed TLS session is still in use &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;(ks=2Eack_write_buf, key-id %d)&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt=
;key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto used;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+used:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_lin=
k-&gt;len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 to_link-&gt;data =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /**</span><br><span>  * This is a safe guard function to double check =
that a buffer from a session is</span><br><span>  * not used in a session t=
o avoid a use after free=2E</span><br><span>@@ -3019,58 +3093,24 @@</span><=
br><span> static void</span><br><span> check_session_buf_not_used(struct bu=
ffer *to_link, struct tls_session *session)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&=
gt;data;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!data=
ptr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!to_lin=
k || !to_link-&gt;data)</span><br><span>     {</span><br><span>         ret=
urn;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span> <=
/span><br><span>     /* Checks buffers in tls_wrap */</span><br><span>     =
if (session-&gt;tls_wrap=2Ework=2Edata =3D=3D dataptr)</span><br><span>    =
 {</span><br><span>         msg(M_INFO, &quot;Warning buffer of freed TLS s=
ession is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               &quot;still in use (tls_wrap=2Ework=2Edata)&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;still in u=
se (tls_wrap=2Ework=2Edata)&quot;);</span><br><span>         goto used;</sp=
an><br><span>     }</span><br><span> </span><br><span>     for (int i =3D 0=
; i &lt; KS_SIZE; i++)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct key_state *ks =3D &amp;session-&gt;k=
ey[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ks-=
&gt;state =3D=3D S_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    continue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* we don&#39;t expect send_relia=
ble to be NULL when state is</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         * not S_UNDEF, but people have reported crashes nonetheless=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * therefore=
 we better catch this event, report and exit=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!ks-&gt;send_reliable)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(M_FATAL,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                &quot;ERROR: session-&gt;key[%d]-&gt;se=
nd_reliable is NULL &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;while key state is %s=2E Exiting=2E&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                i, state_na=
me(ks-&gt;state));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        for (int j =3D 0; j &lt; ks-=
&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D datapt=
r)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &=
quot;Warning buffer of freed TLS session is still in&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    &quot; use (sessio=
n-&gt;key[%d]=2Esend_reliable-&gt;array[%d])&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    i, j);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                goto used;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;Warning buffer of free=
d TLS session is still in use (session-&gt;key[%d]=2Eack_write_buf)&quot;, =
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            goto used;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const struct key_state *ks =3D &amp;sess=
ion-&gt;key[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    check_keystate_buf_not_used(to_link, ks);</span><br><span>     }</span>=
<br><span>     return;</span><br><span> </span><br><span>@@ -3170,13 +3210,=
11 @@</span><br><span>                     &amp;&amp; ks_lame-&gt;state &gt=
;=3D S_ACTIVE</span><br><span>                     &amp;&amp; !multi-&gt;op=
t=2Esingle_session)</span><br><span>                 {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    check_session_buf_not_=
used(to_link, session);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
ove_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);</span><br><span=
>                 }</span><br><span>                 else</span><br><span> =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                check_session_buf_not_used(to_link, session);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    reset_session(m=
ulti, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                reset_session(multi, session, to_link);</span><br><span>   =
              }</span><br><span>             }</span><br><span>         }</=
span><br><span>@@ -3191,7 +3229,7 @@</span><br><span>      */</span><br><sp=
an>     if (lame_duck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup=
))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        tls_session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_session_f=
ree(&amp;multi-&gt;session[TM_LAME_DUCK], true, to_link);</span><br><span> =
        msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring =
key&quot;);</span><br><span>     }</span><br><span> </span><br><span>@@ -32=
06,8 +3244,7 @@</span><br><span>      */</span><br><span>     if (DECRYPT_K=
EY_ENABLED(multi, &amp;multi-&gt;session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        check_session_buf_not_used(to_link, &amp;multi-&gt;session[TM_ACTI=
VE]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        move_ses=
sion(multi, TM_ACTIVE, TM_UNTRUSTED, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        move_session(multi, TM_ACTIVE, TM_UNTRUSTED=
, true, to_link);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: =
tls_multi_process: untrusted session promoted to %strusted&quot;,</span><br=
><span>             tas =3D=3D TLS_AUTHENTICATION_SUCCEEDED ? &quot;&quot; =
: &quot;semi-&quot;);</span><br><span>     }</span><br><span>@@ -3622,7 +36=
59,7 @@</span><br><span>                 goto error;</span><br><span>      =
       }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            key_state_soft_reset(session);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            key_state_soft_reset(session, NULL)=
;</span><br><span> </span><br><span>             dmsg(D_TLS_DEBUG,</span><b=
r><span>                  &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%=
d sid=3D%s&quot;,</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">change 1985</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64920ed9f7=
14803604d76c6df6b38cf20ce7626d </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1985 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-=
fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--JP7cdTJp52s=--


--===============4191960751157788611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4191960751157788611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4191960751157788611==--


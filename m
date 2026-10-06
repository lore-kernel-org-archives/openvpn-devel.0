Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D6ACA5FFC
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyaF+GdhFXK92ksXKU7ky2v4BbkE7JOdl6vDg1a4f6g=; b=KFNUKrlOQQ8U5LUTZAN3J60jdT
	be7fYHHlZ4hTgjg0jSoMKFa1FVM4NmG93YOgeWci8tp872iQpbaYZ74HMJTsNP0UA+Vh47PcfPnSG
	6OASMDOz3y2VDl6c/SEptCdt9BigcXXZHGCuB8ata2jnWcWn30rcKqg7PZGlWBNhjfrY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xED4T-0004eJ-PU;
	Tue, 06 Oct 2026 21:51:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xED4S-0004eC-VN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 21:51:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OvOMai1HFrNivQCq0kfOqvZxAXfIr4doNF75szXMYfM=; b=jmneHQSuHsE0R/a6VAmQRLmrjM
 /Ad1uDScHeJSCJpAa0sCzz8r3QmH7Hd+DKzRBfBHeQLpQYFTmY/zjbY6LBSwMAw1R9POxDbwqGBKo
 JVnXVerytGRqfPl7pnkHAbgufwAw+u1xFX11Iz36g28Cq7C0T2NqzEsUu9WlXsfnlVD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OvOMai1HFrNivQCq0kfOqvZxAXfIr4doNF75szXMYfM=; b=J
 xKcrYjl6vYzBnVdC8jK7yzy6cGxwi0CT+cj5TXJo2gsn0bDt2tWNVIBaIhDxh91QbPfswtGu9oZlQ
 Us2goF4FBDTY+b9wS1ZJFt7Yj5mrwlfIFa4JUd9BVUjdIeh8qmmnVDIRxstb/lBUsp/ni13MABFQo
 dwFYVVzvj+q7WNA8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xED4M-0001No-Dm for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 21:51:33 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso18162755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791323484; x=1791928284; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OvOMai1HFrNivQCq0kfOqvZxAXfIr4doNF75szXMYfM=;
 b=PYIBoEEys5ft6fbM08H744hfivNL4SR1wGL2utcU9XxwKk7gw86o/3x3fDsnOe4j7y
 2eJb35HuBiNLXVn0UEO/OWC18QiFKKDDyTUSa3bGrjnoVhXoMmotbgBytKYqD7XEaN24
 v3/XhyvsCuBhMaMYGuDy806ug0DlS9+dqkyCYjPQonX1KF5sXLJfZTw41OvxZ+warzon
 bEvoKRMUJIsMDy22HDS3NY0ZjYxgtaRUDE4oxSnWjfhcdIlBu8crG6MN4Q7z/7LfO4+h
 JTDAlWK0riSvn2zXuajK9IGP8jzBnsmrs1H/cqi8EhT+CMp+rGg9Cz2SJXwyc7wXLfWm
 p1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791323484; x=1791928284;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OvOMai1HFrNivQCq0kfOqvZxAXfIr4doNF75szXMYfM=;
 b=ZGHY10Vi9MiaCc+HGHeJme1uj/3fJpFbNzdS25BZuDctyo3ludQAmyJWbgfWh71I/A
 dNiPNKacU/V3LNC5e/Q9LjjrI+mj5LppA1AddT5Xc4OBM6DNdk+4B+61KPd4CIhLhvGL
 XaI/n0d6pztPNHKd4K3MbEFElmHSqrPrC9hTW/KsfhdUscStNvZ7lLdAZ0fZ9FREDi08
 5EzmlZYNuM5UK80OwHJ3/sdzSs3YjrdThfC2Qx/o7+6+OKMpGFhL2TSrRtMHKvTuMTLD
 /00enUIqg8TXCj8ayW9oxQvbFCy7msQ7lojYcN5+CfpBJ4Er2F23Mf3ICVJqbeU+2kG+
 9nZA==
X-Gm-Message-State: AFuF++kdVADN6yYZrGp7048CXTyeFTL7O9F3QNU+BOXqfGwCWgfDATnZ
 rdun72G6xoBX68WmuB6YtbHCRSTcmFP2NwjyJpOqwMDNZX54NyhcT/o1vk+mB3nqlG234l/avi2
 xv8J+Gl7RGUfmo7Sy2k72JdxV59GWxobQstFBqa6T0SAXMwrM8uMNtCs5atZdjwdZb4kKaVLWtP
 MXPXKpkQ==
X-Gm-Gg: AYBFou0mc6vt/6+kPx+438oixEddRYxMRZc70efvM2fYRJdaTNOtBG3z9jU+jphc/p6
 2RhvcFoMiTt0a+26OgRuEVtOwlcrssyzbQKe7JG+TBLx/hbcZkXD6MDHzO2ioVctvdn03XhX8Jg
 hzmomFR9KkBOxgOJAZ9Z57bkMtlcVCnDmastpptp5VvYMqAgRlkCtSLAWUWA5+G89lE/L4RY8D6
 EmnHQ0vN9YMYYfUJWnzhrPV66m47MjK3v8AyoAu/bj8qfkCe51Iq7L7ln0AlbIZ9F7OtMDN3J6A
 HCG6NCjIWTVyStHsIKN8+VwjP+SNxWlQC/BSB/ndRHMCkWEgNoSunQFiX6fcDN1e91cUf1o22iM
 6Nn9W+viN6qmDA2IFwDyW6th+jgBbvZ0vyrbJ9qj5CYSgZT07tDuiM7DwTcN5jl86EmMwvZUmIR
 XhCTuyjewQ3P/VDWW4kEgjuqqGro3Q5SaPVPMi4KwxlKAOCbLH/xm5EV5l9yt5LLgk7oQELPfoj
 BKv1bkaqdS60vZdOEy9o8pQWedZXmcWmq2VQCAoRP92yYL0bLdLoOEFEgEqCx3YrMdusPY3VH1q
 5SGwQXJSy529yRQmOBQ+McYVtG/YinF8hwBBLYUK45ihXdHYKLXjIWad2sd/tg==
X-Received: by 2002:a05:600c:34d5:b0:4a0:25c:8af2 with SMTP id
 5b1f17b1804b1-4a18064cf50mr2000075e9.17.1791323483565; 
 Tue, 06 Oct 2026 14:51:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f48ab77sm18536465e9.1.2026.10.06.14.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:51:23 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 21:51:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>, Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 57ab873ae6a4ce3f1352838ed33ca090ef89d5c9
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f6a5976da69932f96e9a8d62902178c892e2a9d9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xED4M-0001No-Dm
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
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0673402589046268216=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0673402589046268216==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TI0GjLXE2LU="; charset=UTF-8

--TI0GjLXE2LU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Max Fillinger, Steffan Karger=2E

Hel=
lo Steffan Karger, 

I'd like you to reexamine a change=2E Please visit

  =
  https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail

to look at t=
he new patch set (#2)=2E

The following approvals got outdated and were rem=
oved:
Code-Review-1 by Steffan Karger


Change subject: Move check_session_=
buf_not_used method into the method that free the buffer
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move check_session_buf_not_used=
 method into the method that free the buffer

This cleans the code up a bit=
 and ensure that we do not miss an invocation
of a problematic code path=2E=
 This is still a band-aid fix and a real fix
requires more refactoring and =
changing the logic=2E

v2: sprinkle some "const" over check_keystate_buf_no=
t_used() args
v3: add missing doxygen for to_link parameter to tls_session_=
free()

CVE: 2026-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gm=
ail=2Ecom>
Tested-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Gith=
ub: openvpn/openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda Un=
iversity)
Github: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f7=
14803604d76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2E=
org>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893
Acked-by: =
MaxF <max@max-fillinger=2Enet>
Message-Id: <20260903061209=2E12599-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38913=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
(cherry picked from commit 2a881d737b2562ee28247148160cfb6=
0f0ba4645)
---
M src/openvpn/ssl=2Ec
1 file changed, 101 insertions(+), 63 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/85/1985/2

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
in=
dex 9b6cfa0=2E=2E11bffd6 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn=
/ssl=2Ec
@@ -93,6 +93,14 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS =
*/
 
+/* forward decleration since tls_process needs this function prototyp=
e */
+static void
+check_session_buf_not_used(struct buffer *to_link, struc=
t tls_session *session);
+
+static void
+check_keystate_buf_not_used(struct=
 buffer *to_link, const struct key_state *ks);
+
+
 /**
  * SSL/TLS Cipher =
suite name translation table
  */
@@ -989,10 +997,15 @@
  *                =
       cleaned up=2E
  * @param clear        - Whether the memory allocated=
 for the \a ks object
  *                       should be overwritten with =
0s=2E
+ *
+ * @param to_link      - if not NULL, check that the buffer does=
 not contain
+ *                       any pointer to one of the internal s=
tructs of ks
  */
 static void
-key_state_free(struct key_state *ks, bool c=
lear)
+key_state_free(struct key_state *ks, bool clear, struct buffer *to_l=
ink)
 {
+    check_keystate_buf_not_used(to_link, ks);
+
     ks->state =3D=
 S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1143,16 +1156,25 @@
 =
 * @param session      - A pointer to the \c tls_session structure to be
  =
*                       cleaned up=2E
  * @param clear        - Whether the=
 memory allocated for the \a session
- *                       object shoul=
d be overwritten with 0s=2E
+ *                       object should be over=
written with 0s=2E This
+ *                       implicitly sets many stat=
es to 0/false,
+ *                       e=2Eg=2E the validity of the keys =
in the structure
+ * @param to_link      - if not NULL, check that the buff=
er does not contain
+ *                       any pointer to one of the int=
ernal structs of ks
+ *
  */
 static void
-tls_session_free(struct tls_sess=
ion *session, bool clear)
+tls_session_free(struct tls_session *session, bo=
ol clear, struct buffer *to_link)
 {
+    check_session_buf_not_used(to_lin=
k, session);
     tls_wrap_free(&session->tls_wrap);
 
     for (size_t i =
=3D 0; i < KS_SIZE; ++i)
     {
-        key_state_free(&session->key[i], f=
alse);
+        /* we don't need clear=3Dtrue for this call since
+        =
 * the structs are part of session and get cleared
+         * as part of s=
ession */
+        key_state_free(&session->key[i], false, to_link);
     }=

 
     if (session->common_name)
@@ -1174,8 +1196,10 @@
 
 
 static void
-=
move_session(struct tls_multi *multi, int dest, int src, bool reinit_src)
+=
move_session(struct tls_multi *multi, int dest, int src, bool reinit_src,
+=
             struct buffer *to_link)
 {
+    check_session_buf_not_used(to_=
link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session:=
 dest=3D%s src=3D%s reinit_src=3D%d",
         session_index_name(dest),
  =
       session_index_name(src),
@@ -1183,7 +1207,7 @@
     ASSERT(src !=3D =
dest);
     ASSERT(src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 &&=
 dest < TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+   =
 tls_session_free(&multi->session[dest], false, to_link);
     multi->sessi=
on[dest] =3D multi->session[src];
 
     if (reinit_src)
@@ -1199,9 +1223,9=
 @@
 }
 
 static void
-reset_session(struct tls_multi *multi, struct tls_se=
ssion *session)
+reset_session(struct tls_multi *multi, struct tls_session =
*session, struct buffer *to_link)
 {
-    tls_session_free(session, false);=

+    tls_session_free(session, false, to_link);
     tls_session_init(mult=
i, session);
 }
 
@@ -1369,7 +1393,7 @@
 
     for (int i =3D 0; i < TM_SIZ=
E; ++i)
     {
-        tls_session_free(&multi->session[i], false);
+     =
   tls_session_free(&multi->session[i], false, NULL);
     }
 
     if (cle=
ar)
@@ -2118,20 +2142,20 @@
 
 /* true if no in/out acknowledgements pendin=
g */
 #define FULL_SYNC \
-    (reliable_empty(ks->send_reliable) && reliab=
le_ack_empty(ks->rec_ack))
+        (reliable_empty(ks->send_reliable) && r=
eliable_ack_empty(ks->rec_ack))
 
 /*
  * Move the active key to the lame d=
uck key and reinitialize the
  * active key=2E
  */
 static void
-key_state=
_soft_reset(struct tls_session *session)
+key_state_soft_reset(struct tls_s=
ession *session, struct buffer *to_link)
 {
     struct key_state *ks =3D &=
session->key[KS_PRIMARY];      /* primary key */
     struct key_state *ks_=
lame =3D &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_di=
e =3D now + session->opt->transition_window; /* remaining lifetime of old k=
ey */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, fal=
se, to_link);
     *ks_lame =3D *ks;
 
     key_state_init(session, ks);
@@=
 -2249,7 +2273,7 @@
          * push request, also signal that the client w=
ants
          * to get push-reply messages without without requiring a rou=
nd
          * trip for a push request message*/
-        if(session->opt->=
pull)
+        if (session->opt->pull)
         {
             iv_proto |=
=3D IV_PROTO_REQUEST_PUSH;
         }
@@ -2426,7 +2450,7 @@
      * NCP opt=
ions are processed and we have no extra state for NCP finished=2E
      */
=
     if (session->opt->server && (session->opt->mode !=3D MODE_SERVER
-    =
        || multi->multi_state =3D=3D CAS_SUCCEEDED))
+                     =
            || multi->multi_state =3D=3D CAS_SUCCEEDED))
     {
         if=
 (ks->authenticated > KS_AUTH_FALSE)
         {
@@ -2679,13 +2703,13 @@
   =
          (int) (now - ks->established), session->opt->renegotiate_seconds,=

             ks->n_bytes, session->opt->renegotiate_bytes,
             ks=
->n_packets, session->opt->renegotiate_packets);
-        key_state_soft_re=
set(session);
+        key_state_soft_reset(session, to_link);
     }
 
   =
  /* Kill lame duck key transition_window seconds after primary key negotia=
tion */
     if (lame_duck_must_die(session, wakeup))
     {
-        key_s=
tate_free(ks_lame, true);
+        key_state_free(ks_lame, true, to_link);
=
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
   =
  }
 
@@ -3009,6 +3033,56 @@
     return false;
 }
 
+static void
+check_ke=
ystate_buf_not_used(struct buffer *to_link, const struct key_state *ks)
+{
=
+    if (ks->state =3D=3D S_UNDEF || !to_link || !to_link->data)
+    {
+  =
      return;
+    }
+
+    uint8_t *dataptr =3D to_link->data;
+
+    /* w=
e don't expect send_reliable to be NULL when state is
+     * not S_UNDEF, =
but people have reported crashes nonetheless,
+     * therefore we better c=
atch this event, report and exit=2E
+     */
+    if (!ks->send_reliable)
+=
    {
+        msg(M_FATAL,
+            "ERROR: ks=2Esend_reliable (key-id=
 %d), is NULL "
+            "while key state is %s=2E Exiting=2E",
+      =
      ks->key_id, state_name(ks->state));
+    }
+
+    for (int j =3D 0; j=
 < ks->send_reliable->size; j++)
+    {
+        if (ks->send_reliable->arr=
ay[j]=2Ebuf=2Edata =3D=3D dataptr)
+        {
+            msg(M_INFO,
+   =
             "Warning buffer of freed TLS session is still in"
+           =
     " use (key-id %d, ks=2Esend_reliable->array[%d])",
+                ks=
->key_id, j);
+
+            goto used;
+        }
+    }
+
+    if (ks->ac=
k_write_buf=2Edata =3D=3D dataptr)
+    {
+        msg(M_INFO, "Warning buf=
fer of freed TLS session is still in use "
+            "(ks=2Eack_write_bu=
f, key-id %d)",
+            ks->key_id);
+
+        goto used;
+    }
+   =
 return;
+
+used:
+    to_link->len =3D 0;
+    to_link->data =3D 0;
+}
+
 =
/**
  * This is a safe guard function to double check that a buffer from a =
session is
  * not used in a session to avoid a use after free=2E
@@ -3019,=
58 +3093,24 @@
 static void
 check_session_buf_not_used(struct buffer *to_l=
ink, struct tls_session *session)
 {
-    uint8_t *dataptr =3D to_link->dat=
a;
-    if (!dataptr)
+    if (!to_link || !to_link->data)
     {
         =
return;
     }
+    const uint8_t *dataptr =3D to_link->data;
 
     /* Che=
cks buffers in tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=3D =
dataptr)
     {
         msg(M_INFO, "Warning buffer of freed TLS session i=
s "
-                    "still in use (tls_wrap=2Ework=2Edata)");
+       =
     "still in use (tls_wrap=2Ework=2Edata)");
         goto used;
     }
 =

     for (int i =3D 0; i < KS_SIZE; i++)
     {
-        struct key_state =
*ks =3D &session->key[i];
-        if (ks->state =3D=3D S_UNDEF)
-        {=

-            continue;
-        }
-
-        /* we don't expect send_relia=
ble to be NULL when state is
-         * not S_UNDEF, but people have repor=
ted crashes nonetheless,
-         * therefore we better catch this event, =
report and exit=2E
-         */
-        if (!ks->send_reliable)
-        {=

-            msg(M_FATAL,
-                "ERROR: session->key[%d]->send_=
reliable is NULL "
-                "while key state is %s=2E Exiting=2E",
=
-                i, state_name(ks->state));
-        }
-
-        for (int =
j =3D 0; j < ks->send_reliable->size; j++)
-        {
-            if (ks->=
send_reliable->array[j]=2Ebuf=2Edata =3D=3D dataptr)
-            {
-      =
          msg(M_INFO,
-                    "Warning buffer of freed TLS ses=
sion is still in"
-                    " use (session->key[%d]=2Esend_relia=
ble->array[%d])",
-                    i, j);
-
-                goto used;=

-            }
-        }
-        if (ks->ack_write_buf=2Edata =3D=3D dat=
aptr)
-        {
-            msg(M_INFO, "Warning buffer of freed TLS sess=
ion is still in use (session->key[%d]=2Eack_write_buf)", i);
-
-           =
 goto used;
-        }
+        const struct key_state *ks =3D &session->ke=
y[i];
+        check_keystate_buf_not_used(to_link, ks);
     }
     return=
;
 
@@ -3170,13 +3210,11 @@
                     && ks_lame->state >=3D S_A=
CTIVE
                     && !multi->opt=2Esingle_session)
               =
  {
-                    check_session_buf_not_used(to_link, session);
-   =
                 move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+     =
               move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);=

                 }
                 else
                 {
-             =
       check_session_buf_not_used(to_link, session);
-                    r=
eset_session(multi, session);
+                    reset_session(multi, ses=
sion, to_link);
                 }
             }
         }
@@ -3191,7 +32=
29,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK],=
 wakeup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], t=
rue);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_lin=
k);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring =
key");
     }
 
@@ -3206,8 +3244,8 @@
      */
     if (DECRYPT_KEY_ENABLED=
(multi, &multi->session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))
     {
-        c=
heck_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        mo=
ve_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
+        move_session(mul=
ti, TM_ACTIVE, TM_UNTRUSTED, true, to_link);
+        tas =3D tls_authentic=
ation_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
         msg(D_TLS_DEB=
UG_LOW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
=
             tas =3D=3D TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
     =
}
@@ -3622,7 +3660,7 @@
                 goto error;
             }
 
-    =
        key_state_soft_reset(session);
+            key_state_soft_reset(se=
ssion, NULL);
 
             dmsg(D_TLS_DEBUG,
                  "TLS: rece=
ived P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s",

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: release/2=2E5
Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce=
7626d
Gerrit-Change-Number: 1985
Gerrit-PatchSet: 2
Gerrit-Owner: Max Filli=
nger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Steffan Karger <steffan@kar=
ger=2Eme>
Gerrit-CC: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ma=
x Fillinger <max@max-fillinger=2Enet>
Gerrit-Attention: Steffan Karger <ste=
ffan@karger=2Eme>

--TI0GjLXE2LU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Max Fillinger, Steffan Karger=2E </p>
<p>Max Fillinge=
r <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review=
-1 by Steffan Karger</p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">Move check_session_buf_not_used metho=
d into the method that free the buffer<br><br>This cleans the code up a bit=
 and ensure that we do not miss an invocation<br>of a problematic code path=
=2E This is still a band-aid fix and a real fix<br>requires more refactorin=
g and changing the logic=2E<br><br>v2: sprinkle some &quot;const&quot; over=
 check_keystate_buf_not_used() args<br>v3: add missing doxygen for to_link =
parameter to tls_session_free()<br><br>CVE: 2026-84471<br>Reported-By: Andr=
eas Gabriel Berbescu &lt;aberbescu@gmail=2Ecom&gt;<br>Tested-By: Andreas Ga=
briel Berbescu &lt;aberbescu@gmail=2Ecom&gt;<br>Github: openvpn/openvpn-pri=
vate-issues#157<br>Reported-By: Haruki Oyama (Waseda University)<br>Github:=
 openvpn/openvpn-private-issues#132<br>Change-Id: I64920ed9f714803604d76c6d=
f6b38cf20ce7626d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893<br>Acked-by:=
 MaxF &lt;max@max-fillinger=2Enet&gt;<br>Message-Id: &lt;20260903061209=2E1=
2599-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38913=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>(cherry picked from commit =
2a881d737b2562ee28247148160cfb60f0ba4645)<br>---<br>M src/openvpn/ssl=2Ec<b=
r>1 file changed, 101 insertions(+), 63 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/19=
85/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><=
br><span>index 9b6cfa0=2E=2E11bffd6 100644</span><br><span>--- a/src/openvp=
n/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -93,=
6 +93,14 @@</span><br><span> </span><br><span> #endif /* ifdef MEASURE_TLS_=
HANDSHAKE_STATS */</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* forward decleration since tls_process needs this functi=
on prototype */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_sessio=
n_buf_not_used(struct buffer *to_link, struct tls_session *session);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+check_keystate_buf_not_used(struct buffer *to_link, c=
onst struct key_state *ks);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /**</span><br><span>  * SSL/TLS Cipher suite name translation table<=
/span><br><span>  */</span><br><span>@@ -989,10 +997,15 @@</span><br><span>=
  *                       cleaned up=2E</span><br><span>  * @param clear   =
     - Whether the memory allocated for the \a ks object</span><br><span>  =
*                       should be overwritten with 0s=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param to_link      - if not NULL, check that the bu=
ffer does not contain</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                       any pointer to one of the internal structs of ks=
</span><br><span>  */</span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state *ks, bool clea=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_state_free(st=
ruct key_state *ks, bool clear, struct buffer *to_link)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_keystate_b=
uf_not_used(to_link, ks);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><span> </sp=
an><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><span>@=
@ -1143,16 +1156,25 @@</span><br><span>  * @param session      - A pointer =
to the \c tls_session structure to be</span><br><span>  *                  =
     cleaned up=2E</span><br><span>  * @param clear        - Whether the me=
mory allocated for the \a session</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *                       object should be overwritten with 0s=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
         object should be overwritten with 0s=2E This</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                       implicitly sets =
many states to 0/false,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *                       e=2Eg=2E the validity of the keys in the struc=
ture</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_li=
nk      - if not NULL, check that the buffer does not contain</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *                       any poin=
ter to one of the internal structs of ks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span>  */</span><br><span> static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_session_free(struct=
 tls_session *session, bool clear)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tls_session_free(struct tls_session *session, bool clear, st=
ruct buffer *to_link)</span><br><span> {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_session_buf_not_used(to_link, session);</spa=
n><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap);</span><br><span>=
 </span><br><span>     for (size_t i =3D 0; i &lt; KS_SIZE; ++i)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        k=
ey_state_free(&amp;session-&gt;key[i], false);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* we don&#39;t need clear=3Dtrue for th=
is call since</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * the structs are part of session and get cleared</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * as part of session */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_free(&amp;=
session-&gt;key[i], false, to_link);</span><br><span>     }</span><br><span=
> </span><br><span>     if (session-&gt;common_name)</span><br><span>@@ -11=
74,8 +1196,10 @@</span><br><span> </span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-move_session(st=
ruct tls_multi *multi, int dest, int src, bool reinit_src)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+move_session(struct tls_multi *multi=
, int dest, int src, bool reinit_src,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             struct buffer *to_link)</span><br><span> {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf=
_not_used(to_link, &amp;multi-&gt;session[dest]);</span><br><span>     msg(=
D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=3D%s reinit_src=3D%=
d&quot;,</span><br><span>         session_index_name(dest),</span><br><span=
>         session_index_name(src),</span><br><span>@@ -1183,7 +1207,7 @@</s=
pan><br><span>     ASSERT(src !=3D dest);</span><br><span>     ASSERT(src &=
gt;=3D 0 &amp;&amp; src &lt; TM_SIZE);</span><br><span>     ASSERT(dest &gt=
;=3D 0 &amp;&amp; dest &lt; TM_SIZE);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    tls_session_free(&amp;multi-&gt;session[dest], false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_session_free=
(&amp;multi-&gt;session[dest], false, to_link);</span><br><span>     multi-=
&gt;session[dest] =3D multi-&gt;session[src];</span><br><span> </span><br><=
span>     if (reinit_src)</span><br><span>@@ -1199,9 +1223,9 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-reset_session(struct tls_multi *multi, str=
uct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+reset_session(struct tls_multi *multi, struct tls_session *session, s=
truct buffer *to_link)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    tls_session_free(session, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(session, false, =
to_link);</span><br><span>     tls_session_init(multi, session);</span><br>=
<span> }</span><br><span> </span><br><span>@@ -1369,7 +1393,7 @@</span><br>=
<span> </span><br><span>     for (int i =3D 0; i &lt; TM_SIZE; ++i)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  tls_session_free(&amp;multi-&gt;session[i], false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;s=
ession[i], false, NULL);</span><br><span>     }</span><br><span> </span><br=
><span>     if (clear)</span><br><span>@@ -2118,20 +2142,20 @@</span><br><s=
pan> </span><br><span> /* true if no in/out acknowledgements pending */</sp=
an><br><span> #define FULL_SYNC \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    (reliable_empty(ks-&gt;send_reliable) &amp;&amp; reliable_a=
ck_empty(ks-&gt;rec_ack))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        (reliable_empty(ks-&gt;send_reliable) &amp;&amp; reliable_ack=
_empty(ks-&gt;rec_ack))</span><br><span> </span><br><span> /*</span><br><sp=
an>  * Move the active key to the lame duck key and reinitialize the</span>=
<br><span>  * active key=2E</span><br><span>  */</span><br><span> static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_soft_rese=
t(struct tls_session *session)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+key_state_soft_reset(struct tls_session *session, struct buffer =
*to_link)</span><br><span> {</span><br><span>     struct key_state *ks =3D =
&amp;session-&gt;key[KS_PRIMARY];      /* primary key */</span><br><span>  =
   struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK]; /* ret=
iring key */</span><br><span> </span><br><span>     ks-&gt;must_die =3D now=
 + session-&gt;opt-&gt;transition_window; /* remaining lifetime of old key =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_state_free(=
ks_lame, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 key_state_free(ks_lame, false, to_link);</span><br><span>     *ks_lame =3D=
 *ks;</span><br><span> </span><br><span>     key_state_init(session, ks);</=
span><br><span>@@ -2249,7 +2273,7 @@</span><br><span>          * push reque=
st, also signal that the client wants</span><br><span>          * to get pu=
sh-reply messages without without requiring a round</span><br><span>       =
   * trip for a push request message*/</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if(session-&gt;opt-&gt;pull)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt-&gt;pull)</sp=
an><br><span>         {</span><br><span>             iv_proto |=3D IV_PROTO=
_REQUEST_PUSH;</span><br><span>         }</span><br><span>@@ -2426,7 +2450,=
7 @@</span><br><span>      * NCP options are processed and we have no extra=
 state for NCP finished=2E</span><br><span>      */</span><br><span>     if=
 (session-&gt;opt-&gt;server &amp;&amp; (session-&gt;opt-&gt;mode !=3D MODE=
_SERVER</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ||=
 multi-&gt;multi_state =3D=3D CAS_SUCCEEDED))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                 || multi-&gt;mul=
ti_state =3D=3D CAS_SUCCEEDED))</span><br><span>     {</span><br><span>    =
     if (ks-&gt;authenticated &gt; KS_AUTH_FALSE)</span><br><span>         =
{</span><br><span>@@ -2679,13 +2703,13 @@</span><br><span>             (int=
) (now - ks-&gt;established), session-&gt;opt-&gt;renegotiate_seconds,</spa=
n><br><span>             ks-&gt;n_bytes, session-&gt;opt-&gt;renegotiate_by=
tes,</span><br><span>             ks-&gt;n_packets, session-&gt;opt-&gt;ren=
egotiate_packets);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     key_state_soft_reset(session);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        key_state_soft_reset(session, to_link);</span><br><=
span>     }</span><br><span> </span><br><span>     /* Kill lame duck key tr=
ansition_window seconds after primary key negotiation */</span><br><span>  =
   if (lame_duck_must_die(session, wakeup))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks_lame=
, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key=
_state_free(ks_lame, true, to_link);</span><br><span>         msg(D_TLS_DEB=
UG_LOW, &quot;TLS: tls_process: killed expiring key&quot;);</span><br><span=
>     }</span><br><span> </span><br><span>@@ -3009,6 +3033,56 @@</span><br>=
<span>     return false;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct buffer=
 *to_link, const struct key_state *ks)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* we don&#39;t expect send_reliable to be NULL when state is</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * not S_UNDEF, but =
people have reported crashes nonetheless,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * therefore we better catch this event, report a=
nd exit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ks-&gt;send_=
reliable)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;ERROR=
: ks=2Esend_reliable (key-id %d), is NULL &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;while key state is %s=2E Exi=
ting=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ks-&gt;key_id, state_name(ks-&gt;state));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (ks-&gt;send_reliable-&gt;array[j]=2E=
buf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_INFO,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &quot;Warning buffer of freed TLS session is still in&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &q=
uot; use (key-id %d, ks=2Esend_reliable-&gt;array[%d])&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                ks-&gt;key_id, j)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            goto used;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_INFO, &quot;Warning buffer of freed TLS sessi=
on is still in use &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;(ks=2Eack_write_buf, key-id %d)&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;key_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto used;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+used:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_link-&=
gt;data =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</=
span><br><span>  * This is a safe guard function to double check that a buf=
fer from a session is</span><br><span>  * not used in a session to avoid a =
use after free=2E</span><br><span>@@ -3019,58 +3093,24 @@</span><br><span> =
static void</span><br><span> check_session_buf_not_used(struct buffer *to_l=
ink, struct tls_session *session)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!dataptr)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!to_link || !to_=
link-&gt;data)</span><br><span>     {</span><br><span>         return;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span> </span><br=
><span>     /* Checks buffers in tls_wrap */</span><br><span>     if (sessi=
on-&gt;tls_wrap=2Ework=2Edata =3D=3D dataptr)</span><br><span>     {</span>=
<br><span>         msg(M_INFO, &quot;Warning buffer of freed TLS session is=
 &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      &quot;still in use (tls_wrap=2Ework=2Edata)&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;still in use (tls_w=
rap=2Ework=2Edata)&quot;);</span><br><span>         goto used;</span><br><s=
pan>     }</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; =
KS_SIZE; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct key_state *ks =3D &amp;session-&gt;key[i];</s=
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
 hsl(120, 100%, 40%);">+        const struct key_state *ks =3D &amp;session=
-&gt;key[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 check_keystate_buf_not_used(to_link, ks);</span><br><span>     }</span><br=
><span>     return;</span><br><span> </span><br><span>@@ -3170,13 +3210,11 =
@@</span><br><span>                     &amp;&amp; ks_lame-&gt;state &gt;=
=3D S_ACTIVE</span><br><span>                     &amp;&amp; !multi-&gt;opt=
=2Esingle_session)</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    check_session_buf_not_u=
sed(to_link, session);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mo=
ve_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);</span><br><span>=
                 }</span><br><span>                 else</span><br><span>  =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               check_session_buf_not_used(to_link, session);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    reset_session(mu=
lti, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               reset_session(multi, session, to_link);</span><br><span>    =
             }</span><br><span>             }</span><br><span>         }</s=
pan><br><span>@@ -3191,7 +3229,7 @@</span><br><span>      */</span><br><spa=
n>     if (lame_duck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        tls_session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_session_fr=
ee(&amp;multi-&gt;session[TM_LAME_DUCK], true, to_link);</span><br><span>  =
       msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring k=
ey&quot;);</span><br><span>     }</span><br><span> </span><br><span>@@ -320=
6,8 +3244,8 @@</span><br><span>      */</span><br><span>     if (DECRYPT_KE=
Y_ENABLED(multi, &amp;multi-&gt;session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        check_session_buf_not_used(to_link, &amp;multi-&gt;session[TM_ACTIV=
E]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        move_sess=
ion(multi, TM_ACTIVE, TM_UNTRUSTED, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        move_session(multi, TM_ACTIVE, TM_UNTRUSTED,=
 true, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tas =3D tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVA=
L);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_proc=
ess: untrusted session promoted to %strusted&quot;,</span><br><span>       =
      tas =3D=3D TLS_AUTHENTICATION_SUCCEEDED ? &quot;&quot; : &quot;semi-&=
quot;);</span><br><span>     }</span><br><span>@@ -3622,7 +3660,7 @@</span>=
<br><span>                 goto error;</span><br><span>             }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   key_state_soft_reset(session);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            key_state_soft_reset(session, NULL);</span><br><s=
pan> </span><br><span>             dmsg(D_TLS_DEBUG,</span><br><span>      =
            &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quo=
t;,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1985?usp=3Demail">change 1985</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=
=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64920ed9f714803=
604d76c6df6b38cf20ce7626d </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1985 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-filli=
nger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan=
 Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Max =
Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>

</b=
ody></html>
--TI0GjLXE2LU=--


--===============0673402589046268216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0673402589046268216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0673402589046268216==--


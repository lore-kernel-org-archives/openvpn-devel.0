Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA76CA5FF1
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Go6Fut6UYVETQJMGMtmbRuK5HJw12qaPFjovLRET4RY=; b=K9FAuotcOYl7iN1qSk9dnwKlLp
	hbRxZfucovegEqVx2aDTgEwoS2eVRwA8UldVNSI6KJgSNf5i2gq+RP0mbwh4b96vgmLSDPU2kZRZ8
	tAfQ23axipAEgLMUC4y0f135R/66lMLosrHUOfsaN3rMpGmaTmBJgI22tP8aJCDnxp2o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEOu7-00061V-Dr;
	Wed, 07 Oct 2026 10:29:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEOu6-00061P-C6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 10:29:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A9TJwhrt0FHJZyp0e13Oh0fncmYXECkTlmDD1+vwfgE=; b=OK2N0Yn1bGxh9ntp6FbV1EJl96
 JB70YZ/VOLAEnkPR8O0Qi58YnyUdGLrMb0e4PSCx+J/vmdzzvE7lnj/tSI2Tw8pNF+jMfmBr5qm/D
 NQL4wXLRxoJV4AjYitBXCEjRD58lYhja3XPksa0MT0NwqQnyI7cpQbBJ3olHZZ0em+50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A9TJwhrt0FHJZyp0e13Oh0fncmYXECkTlmDD1+vwfgE=; b=C
 WstavhOaHWwvHK4edH2aarxIIiYCAnYLsYGWehIPNGL9xh0cXjU5wmpDHmNSSi5J7XykX4c8YME9Y
 omKDmFLdTTc0NzUPzttbrNO6mHtgA+0UL3yZRXtd3GCESdYL+R6RfOX4Bj6U1rds1tzgbZwsOrqQO
 1uIgJpv2n+e8nxIs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEOu0-00085f-Pf for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 10:29:39 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so11890065e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791368970; x=1791973770; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A9TJwhrt0FHJZyp0e13Oh0fncmYXECkTlmDD1+vwfgE=;
 b=OM9ZVc4BNNmqN85v4Y0cSSsZk+YI10qN3OpHm/aNGEWkitqR2SuBG169hf/Gy5ely5
 NwL7EIEi+RdoEk/vdAr20YZR3mzUmbJLe+fPfGbPjjFISYQ/kRzFls6Kej1Nmey+CsCT
 JBxb1w3sijLW1s3fUSRM647juYNXuFsjvC0QGH+FjtYh3m1kYEyKVscSpZcK37x8CqXE
 S6ROQ5k3dY5hzVv+ExKQu99nmn2ZsgTJzZKiHMNla9rrFENnrMD+NpYqlgioy7gCAV+p
 h2M7TdXMg/9ZcLEs+jvy2yXhXT8EU+Svvc2TIyjsczkF+qQo/lBD5TdUuR2TCBHz2y/E
 iWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368970; x=1791973770;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A9TJwhrt0FHJZyp0e13Oh0fncmYXECkTlmDD1+vwfgE=;
 b=1eaEbBUUh4SnCXAHiuN2x5IubmLhD9clS2/STcSLCcyU8n0h9is6zuEWP2nnKiMP+g
 Xy4LPIiYpgtZ6PLETMZEk7T80eTQBTjt6aBGnG3RKuj1t0CKyoD6BUbSdSEqUAw68GC4
 QBX62+wq4x2FoqFYiyPy7uTEFfj/piOLyfKBMWa6zupwMqJ5XEdBkriDMgtIlR/z7uDK
 lqAMftWh+YZY7QJJy2T7eitdveycDLq7NYeX5KxZYGHMHMSy1cVWtnUbqQxWpJHDyu/c
 1hy6gAqubqYNaf5vxaUMFwmgGZrghaPoz0dWCbuas3YZvFLwP51rARivAR2+QuepO4KC
 W7wA==
X-Gm-Message-State: AFuF++kvXP3BaksqmYVVhYyQmTYxVJO905axK6oPkywZOIeyT/1aXpal
 3Wq7VCx+qeIuRfHbO5l8Bo8s9qfM2ZLDHTcLOFsyDFQOGSi/gwNqm/2qszGnlhYblBIdwXyoEeO
 z5tIJ2iTyeVv+sAEEC6fQ9qkeO1b/gEhm98fgvQHytTymKThg8hxj8VaYnuQaCuDSzkQeTbV2KL
 W5pCOmmQ==
X-Gm-Gg: AYBFou25bYwSN5PJbBtnz7tXxdJrX3NtAZUehAKv83h5XAu09aEWUGafJZ7dDPRI7F4
 2NnqCIVOkiSp8aBGAdiyGNtNxsWVOosXRzYp4ZcVSU8qs+ty6j2hvsLMDXEJB38UxY1dkgJGlSs
 2sZmtl3oVlw2/47nHfesbtDMvBHKwTmnGxVzDklyOfC9IYQsE7XVYKoRnS1MoH6jlT7G/7SlTxd
 9GPpdfxxFIUJsckoXWyPrLwWAlYNJGVRi8RiwV3doIxeuf4u5BzxRq016gfxmraoKWdL5TgQRSM
 rT4MxSGWSPyTclWO9BsF8k+nSQOUpVOnhJQG8z5rn+g5kfFekcjBDkcoV3AzsXge55MU/sqTEaO
 MxxMZ82HalXZ58lpbM+exk4niiVroEmTNIjoJxhtemYrBZ+H5uWrcqHfsWThElheKNA1xgHQssy
 aoze/LHrP3Px/BFIqJcA9gl/HfkZijspAwT3s6d1psvKznbora2xcsfPymt3uskbSmA7cLyxVEe
 GdT4i5MytWuvCYsg71U09FROlgZBi+/FeOSnxDw6cNhHLJgRAN7ZqRTVrbQ3O+Z/s/Uh2CclHB4
 H4GZxd/qYmk/Fa3toEEzSVyk6V3M4ysq2jxmXIZWJ8LpUG9tu/r214KAGxNI5w8HiDHUdSg=
X-Received: by 2002:a05:600c:6296:b0:4a1:7093:409a with SMTP id
 5b1f17b1804b1-4a18043b480mr25885265e9.27.1791368969659; 
 Wed, 07 Oct 2026 03:29:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71b786d8sm4759405f8f.0.2026.10.07.03.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:29:29 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 10:29:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>, Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 25b617465c79b2b7a5609f1f1a4194162168fd15
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8bf722011bbf609be97297ae3973432a5e40ba1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEOu0-00085f-Pf
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
Content-Type: multipart/mixed; boundary="===============7690258582160051087=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7690258582160051087==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QhfT+f+hNN8="; charset=UTF-8

--QhfT+f+hNN8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Steffan Karger=2E

Hello Steffan Karg=
er, 

I'd like you to reexamine a change=2E Please visit

    https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail

to look at the new patch se=
t (#3)=2E


Change subject: Move check_session_buf_not_used method into the=
 method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Move check_session_buf_not_used method into the method tha=
t free the buffer

This cleans the code up a bit and ensure that we do not =
miss an invocation
of a problematic code path=2E This is still a band-aid f=
ix and a real fix
requires more refactoring and changing the logic=2E

v2: =
sprinkle some "const" over check_keystate_buf_not_used() args
v3: add missi=
ng doxygen for to_link parameter to tls_session_free()

CVE: 2026-84471
Rep=
orted-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Tested-By: Andre=
as Gabriel Berbescu <aberbescu@gmail=2Ecom>
Github: openvpn/openvpn-private=
-issues#157
Reported-By: Haruki Oyama (Waseda University)
Github: openvpn/o=
penvpn-private-issues#132
Change-Id: I64920ed9f714803604d76c6df6b38cf20ce76=
26d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1893
Acked-by: MaxF <max@max-fillinger=2En=
et>
Message-Id: <20260903061209=2E12599-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38=
913=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
(cherry pi=
cked from commit 2a881d737b2562ee28247148160cfb60f0ba4645)
---
M src/openvp=
n/ssl=2Ec
1 file changed, 99 insertions(+), 62 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/1985/3

diff --git=
 a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9b6cfa0=2E=2E26a1b5d 100=
644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -93,6 +93,14 @@
=
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
+/* forward decleration=
 since tls_process needs this function prototype */
+static void
+check_ses=
sion_buf_not_used(struct buffer *to_link, struct tls_session *session);
+
+=
static void
+check_keystate_buf_not_used(struct buffer *to_link, const stru=
ct key_state *ks);
+
+
 /**
  * SSL/TLS Cipher suite name translation table=

  */
@@ -989,10 +997,15 @@
  *                       cleaned up=2E
  * @pa=
ram clear        - Whether the memory allocated for the \a ks object
  *   =
                    should be overwritten with 0s=2E
+ *
+ * @param to_link=
      - if not NULL, check that the buffer does not contain
+ *            =
           any pointer to one of the internal structs of ks
  */
 static vo=
id
-key_state_free(struct key_state *ks, bool clear)
+key_state_free(struct=
 key_state *ks, bool clear, struct buffer *to_link)
 {
+    check_keystate_=
buf_not_used(to_link, ks);
+
     ks->state =3D S_UNDEF;
 
     key_state_s=
sl_free(&ks->ks_ssl);
@@ -1143,16 +1156,25 @@
  * @param session      - A p=
ointer to the \c tls_session structure to be
  *                       clea=
ned up=2E
  * @param clear        - Whether the memory allocated for the \a=
 session
- *                       object should be overwritten with 0s=2E
=
+ *                       object should be overwritten with 0s=2E This
+ * =
                      implicitly sets many states to 0/false,
+ *          =
             e=2Eg=2E the validity of the keys in the structure
+ * @param =
to_link      - if not NULL, check that the buffer does not contain
+ *     =
                  any pointer to one of the internal structs of ks
+ *
  */=

 static void
-tls_session_free(struct tls_session *session, bool clear)
+t=
ls_session_free(struct tls_session *session, bool clear, struct buffer *to_=
link)
 {
+    check_session_buf_not_used(to_link, session);
     tls_wrap_f=
ree(&session->tls_wrap);
 
     for (size_t i =3D 0; i < KS_SIZE; ++i)
    =
 {
-        key_state_free(&session->key[i], false);
+        /* we don't n=
eed clear=3Dtrue for this call since
+         * the structs are part of se=
ssion and get cleared
+         * as part of session */
+        key_state_=
free(&session->key[i], false, to_link);
     }
 
     if (session->common_n=
ame)
@@ -1174,8 +1196,10 @@
 
 
 static void
-move_session(struct tls_multi=
 *multi, int dest, int src, bool reinit_src)
+move_session(struct tls_multi=
 *multi, int dest, int src, bool reinit_src,
+             struct buffer *t=
o_link)
 {
+    check_session_buf_not_used(to_link, &multi->session[dest]);=

     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=3D%s src=3D%s reinit_sr=
c=3D%d",
         session_index_name(dest),
         session_index_name(src=
),
@@ -1183,7 +1207,7 @@
     ASSERT(src !=3D dest);
     ASSERT(src >=3D 0=
 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && dest < TM_SIZE);
-    tls_se=
ssion_free(&multi->session[dest], false);
+    tls_session_free(&multi->ses=
sion[dest], false, to_link);
     multi->session[dest] =3D multi->session[s=
rc];
 
     if (reinit_src)
@@ -1199,9 +1223,9 @@
 }
 
 static void
-reset_=
session(struct tls_multi *multi, struct tls_session *session)
+reset_sessio=
n(struct tls_multi *multi, struct tls_session *session, struct buffer *to_l=
ink)
 {
-    tls_session_free(session, false);
+    tls_session_free(sessio=
n, false, to_link);
     tls_session_init(multi, session);
 }
 
@@ -1369,7 =
+1393,7 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)
     {
-        tls_s=
ession_free(&multi->session[i], false);
+        tls_session_free(&multi->s=
ession[i], false, NULL);
     }
 
     if (clear)
@@ -2125,13 +2149,13 @@
 =
 * active key=2E
  */
 static void
-key_state_soft_reset(struct tls_session=
 *session)
+key_state_soft_reset(struct tls_session *session, struct buffer=
 *to_link)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];     =
 /* primary key */
     struct key_state *ks_lame =3D &session->key[KS_LAME=
_DUCK]; /* retiring key */
 
     ks->must_die =3D now + session->opt->tran=
sition_window; /* remaining lifetime of old key */
-    key_state_free(ks_l=
ame, false);
+    key_state_free(ks_lame, false, to_link);
     *ks_lame =
=3D *ks;
 
     key_state_init(session, ks);
@@ -2249,7 +2273,7 @@
        =
  * push request, also signal that the client wants
          * to get push=
-reply messages without without requiring a round
          * trip for a pu=
sh request message*/
-        if(session->opt->pull)
+        if (session->=
opt->pull)
         {
             iv_proto |=3D IV_PROTO_REQUEST_PUSH;
   =
      }
@@ -2426,7 +2450,7 @@
      * NCP options are processed and we have=
 no extra state for NCP finished=2E
      */
     if (session->opt->server =
&& (session->opt->mode !=3D MODE_SERVER
-            || multi->multi_state =
=3D=3D CAS_SUCCEEDED))
+                                 || multi->multi_st=
ate =3D=3D CAS_SUCCEEDED))
     {
         if (ks->authenticated > KS_AUTH_=
FALSE)
         {
@@ -2679,13 +2703,13 @@
             (int) (now - ks->est=
ablished), session->opt->renegotiate_seconds,
             ks->n_bytes, ses=
sion->opt->renegotiate_bytes,
             ks->n_packets, session->opt->ren=
egotiate_packets);
-        key_state_soft_reset(session);
+        key_sta=
te_soft_reset(session, to_link);
     }
 
     /* Kill lame duck key transi=
tion_window seconds after primary key negotiation */
     if (lame_duck_mus=
t_die(session, wakeup))
     {
-        key_state_free(ks_lame, true);
+   =
     key_state_free(ks_lame, true, to_link);
         msg(D_TLS_DEBUG_LOW, =
"TLS: tls_process: killed expiring key");
     }
 
@@ -3009,6 +3033,56 @@
 =
    return false;
 }
 
+static void
+check_keystate_buf_not_used(struct buf=
fer *to_link, const struct key_state *ks)
+{
+    if (ks->state =3D=3D S_UN=
DEF || !to_link || !to_link->data)
+    {
+        return;
+    }
+
+    ui=
nt8_t *dataptr =3D to_link->data;
+
+    /* we don't expect send_reliable t=
o be NULL when state is
+     * not S_UNDEF, but people have reported crash=
es nonetheless,
+     * therefore we better catch this event, report and ex=
it=2E
+     */
+    if (!ks->send_reliable)
+    {
+        msg(M_FATAL,
+ =
           "ERROR: ks=2Esend_reliable (key-id %d), is NULL "
+            "=
while key state is %s=2E Exiting=2E",
+            ks->key_id, state_name(k=
s->state));
+    }
+
+    for (int j =3D 0; j < ks->send_reliable->size; j+=
+)
+    {
+        if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D data=
ptr)
+        {
+            msg(M_INFO,
+                "Warning buffer o=
f freed TLS session is still in"
+                " use (key-id %d, ks=2Ese=
nd_reliable->array[%d])",
+                ks->key_id, j);
+
+            g=
oto used;
+        }
+    }
+
+    if (ks->ack_write_buf=2Edata =3D=3D data=
ptr)
+    {
+        msg(M_INFO, "Warning buffer of freed TLS session is st=
ill in use "
+            "(ks=2Eack_write_buf, key-id %d)",
+            k=
s->key_id);
+
+        goto used;
+    }
+    return;
+
+used:
+    to_link=
->len =3D 0;
+    to_link->data =3D 0;
+}
+
 /**
  * This is a safe guard f=
unction to double check that a buffer from a session is
  * not used in a s=
ession to avoid a use after free=2E
@@ -3019,58 +3093,24 @@
 static void
 c=
heck_session_buf_not_used(struct buffer *to_link, struct tls_session *sessi=
on)
 {
-    uint8_t *dataptr =3D to_link->data;
-    if (!dataptr)
+    if =
(!to_link || !to_link->data)
     {
         return;
     }
+    const uint=
8_t *dataptr =3D to_link->data;
 
     /* Checks buffers in tls_wrap */
   =
  if (session->tls_wrap=2Ework=2Edata =3D=3D dataptr)
     {
         msg(M=
_INFO, "Warning buffer of freed TLS session is "
-                    "stil=
l in use (tls_wrap=2Ework=2Edata)");
+            "still in use (tls_wrap=
=2Ework=2Edata)");
         goto used;
     }
 
     for (int i =3D 0; i < =
KS_SIZE; i++)
     {
-        struct key_state *ks =3D &session->key[i];
- =
       if (ks->state =3D=3D S_UNDEF)
-        {
-            continue;
-   =
     }
-
-        /* we don't expect send_reliable to be NULL when state is=

-         * not S_UNDEF, but people have reported crashes nonetheless,
-  =
       * therefore we better catch this event, report and exit=2E
-        =
 */
-        if (!ks->send_reliable)
-        {
-            msg(M_FATAL,
-=
                "ERROR: session->key[%d]->send_reliable is NULL "
-        =
        "while key state is %s=2E Exiting=2E",
-                i, state_na=
me(ks->state));
-        }
-
-        for (int j =3D 0; j < ks->send_reliab=
le->size; j++)
-        {
-            if (ks->send_reliable->array[j]=2Ebu=
f=2Edata =3D=3D dataptr)
-            {
-                msg(M_INFO,
-     =
               "Warning buffer of freed TLS session is still in"
-         =
           " use (session->key[%d]=2Esend_reliable->array[%d])",
-         =
           i, j);
-
-                goto used;
-            }
-        }
-=
        if (ks->ack_write_buf=2Edata =3D=3D dataptr)
-        {
-          =
  msg(M_INFO, "Warning buffer of freed TLS session is still in use (session=
->key[%d]=2Eack_write_buf)", i);
-
-            goto used;
-        }
+    =
    const struct key_state *ks =3D &session->key[i];
+        check_keystat=
e_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3170,13 +3210,11 @@
=
                     && ks_lame->state >=3D S_ACTIVE
                     &=
& !multi->opt=2Esingle_session)
                 {
-                    che=
ck_session_buf_not_used(to_link, session);
-                    move_sessio=
n(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+                    move_session(=
multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
                 }
        =
         else
                 {
-                    check_session_buf_not=
_used(to_link, session);
-                    reset_session(multi, session)=
;
+                    reset_session(multi, session, to_link);
            =
     }
             }
         }
@@ -3191,7 +3229,7 @@
      */
     if (la=
me_duck_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tl=
s_session_free(&multi->session[TM_LAME_DUCK], true);
+        tls_session_f=
ree(&multi->session[TM_LAME_DUCK], true, to_link);
         msg(D_TLS_DEBUG=
_LOW, "TLS: tls_multi_process: killed expiring key");
     }
 
@@ -3206,8 +=
3244,7 @@
      */
     if (DECRYPT_KEY_ENABLED(multi, &multi->session[TM_U=
NTRUSTED]=2Ekey[KS_PRIMARY]))
     {
-        check_session_buf_not_used(to=
_link, &multi->session[TM_ACTIVE]);
-        move_session(multi, TM_ACTIVE,=
 TM_UNTRUSTED, true);
+        move_session(multi, TM_ACTIVE, TM_UNTRUSTED,=
 true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: unt=
rusted session promoted to %strusted",
             tas =3D=3D TLS_AUTHENTI=
CATION_SUCCEEDED ? "" : "semi-");
     }
@@ -3622,7 +3659,7 @@
            =
     goto error;
             }
 
-            key_state_soft_reset(session=
);
+            key_state_soft_reset(session, NULL);
 
             dmsg(D_=
TLS_DEBUG,
                  "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d =
sid=3D%s",

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
985?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Change-I=
d: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Change-Number: 1985
Ger=
rit-PatchSet: 3
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerri=
t-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>

--QhfT+f+hNN8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Steffan Karger=2E </p>
<p>Max Fillinger <strong>uploa=
ded patch set #3</strong> to this change=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Move check_session_buf_not_used method into the method that free the b=
uffer<br><br>This cleans the code up a bit and ensure that we do not miss a=
n invocation<br>of a problematic code path=2E This is still a band-aid fix =
and a real fix<br>requires more refactoring and changing the logic=2E<br><b=
r>v2: sprinkle some &quot;const&quot; over check_keystate_buf_not_used() ar=
gs<br>v3: add missing doxygen for to_link parameter to tls_session_free()<b=
r><br>CVE: 2026-84471<br>Reported-By: Andreas Gabriel Berbescu &lt;aberbesc=
u@gmail=2Ecom&gt;<br>Tested-By: Andreas Gabriel Berbescu &lt;aberbescu@gmai=
l=2Ecom&gt;<br>Github: openvpn/openvpn-private-issues#157<br>Reported-By: H=
aruki Oyama (Waseda University)<br>Github: openvpn/openvpn-private-issues#1=
32<br>Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1893<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet=
&gt;<br>Message-Id: &lt;20260903061209=2E12599-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg38913=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>(cherry picked from commit 2a881d737b2562ee28247148160cfb60f=
0ba4645)<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 99 insertions(+=
), 62 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/85/1985/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 9b6cfa0=2E=2E26a1b5=
d 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl=2Ec</span><br><span>@@ -93,6 +93,14 @@</span><br><span> </spa=
n><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* forward decler=
ation since tls_process needs this function prototype */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+check_session_buf_not_used(struct buffer *to_l=
ink, struct tls_session *session);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_keysta=
te_buf_not_used(struct buffer *to_link, const struct key_state *ks);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * SSL=
/TLS Cipher suite name translation table</span><br><span>  */</span><br><sp=
an>@@ -989,10 +997,15 @@</span><br><span>  *                       cleaned =
up=2E</span><br><span>  * @param clear        - Whether the memory allocate=
d for the \a ks object</span><br><span>  *                       should be =
overwritten with 0s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_l=
ink      - if not NULL, check that the buffer does not contain</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *                       any poi=
nter to one of the internal structs of ks</span><br><span>  */</span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_s=
tate_free(struct key_state *ks, bool clear)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+key_state_free(struct key_state *ks, bool clear, st=
ruct buffer *to_link)</span><br><span> {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_keystate_buf_not_used(to_link, ks);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ks-&gt=
;state =3D S_UNDEF;</span><br><span> </span><br><span>     key_state_ssl_fr=
ee(&amp;ks-&gt;ks_ssl);</span><br><span>@@ -1143,16 +1156,25 @@</span><br><=
span>  * @param session      - A pointer to the \c tls_session structure to=
 be</span><br><span>  *                       cleaned up=2E</span><br><span=
>  * @param clear        - Whether the memory allocated for the \a session<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                    =
   object should be overwritten with 0s=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *                       object should be overwritte=
n with 0s=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
                       implicitly sets many states to 0/false,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *                       e=2Eg=
=2E the validity of the keys in the structure</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param to_link      - if not NULL, check that =
the buffer does not contain</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                       any pointer to one of the internal structs=
 of ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span>  */</span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tls_session_free(struct tls_session *session, bool clear)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_session_free(st=
ruct tls_session *session, bool clear, struct buffer *to_link)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_ses=
sion_buf_not_used(to_link, session);</span><br><span>     tls_wrap_free(&am=
p;session-&gt;tls_wrap);</span><br><span> </span><br><span>     for (size_t=
 i =3D 0; i &lt; KS_SIZE; ++i)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        key_state_free(&amp;session-&gt;key=
[i], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* we don&#39;t need clear=3Dtrue for this call since</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * the structs are part of sessi=
on and get cleared</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * as part of session */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        key_state_free(&amp;session-&gt;key[i], false, to_link)=
;</span><br><span>     }</span><br><span> </span><br><span>     if (session=
-&gt;common_name)</span><br><span>@@ -1174,8 +1196,10 @@</span><br><span> <=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-move_session(struct tls_multi *multi, int dest, in=
t src, bool reinit_src)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+move_session(struct tls_multi *multi, int dest, int src, bool reinit_sr=
c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             stru=
ct buffer *to_link)</span><br><span> {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    check_session_buf_not_used(to_link, &amp;multi-&gt;s=
ession[dest]);</span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move_se=
ssion: dest=3D%s src=3D%s reinit_src=3D%d&quot;,</span><br><span>         s=
ession_index_name(dest),</span><br><span>         session_index_name(src),<=
/span><br><span>@@ -1183,7 +1207,7 @@</span><br><span>     ASSERT(src !=3D =
dest);</span><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SIZ=
E);</span><br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZE=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_fre=
e(&amp;multi-&gt;session[dest], false);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tls_session_free(&amp;multi-&gt;session[dest], fals=
e, to_link);</span><br><span>     multi-&gt;session[dest] =3D multi-&gt;ses=
sion[src];</span><br><span> </span><br><span>     if (reinit_src)</span><br=
><span>@@ -1199,9 +1223,9 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-re=
set_session(struct tls_multi *multi, struct tls_session *session)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+reset_session(struct tls_mult=
i *multi, struct tls_session *session, struct buffer *to_link)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session=
_free(session, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    tls_session_free(session, false, to_link);</span><br><span>     tls_=
session_init(multi, session);</span><br><span> }</span><br><span> </span><b=
r><span>@@ -1369,7 +1393,7 @@</span><br><span> </span><br><span>     for (i=
nt i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;s=
ession[i], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       tls_session_free(&amp;multi-&gt;session[i], false, NULL);</span><br>=
<span>     }</span><br><span> </span><br><span>     if (clear)</span><br><s=
pan>@@ -2125,13 +2149,13 @@</span><br><span>  * active key=2E</span><br><sp=
an>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-key_state_soft_reset(struct tls_session *session)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tl=
s_session *session, struct buffer *to_link)</span><br><span> {</span><br><s=
pan>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];      /*=
 primary key */</span><br><span>     struct key_state *ks_lame =3D &amp;ses=
sion-&gt;key[KS_LAME_DUCK]; /* retiring key */</span><br><span> </span><br>=
<span>     ks-&gt;must_die =3D now + session-&gt;opt-&gt;transition_window;=
 /* remaining lifetime of old key */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    key_state_free(ks_lame, false);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    key_state_free(ks_lame, false, to_link);=
</span><br><span>     *ks_lame =3D *ks;</span><br><span> </span><br><span> =
    key_state_init(session, ks);</span><br><span>@@ -2249,7 +2273,7 @@</spa=
n><br><span>          * push request, also signal that the client wants</sp=
an><br><span>          * to get push-reply messages without without requiri=
ng a round</span><br><span>          * trip for a push request message*/</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if(session-&gt;o=
pt-&gt;pull)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (session-&gt;opt-&gt;pull)</span><br><span>         {</span><br><span> =
            iv_proto |=3D IV_PROTO_REQUEST_PUSH;</span><br><span>         }=
</span><br><span>@@ -2426,7 +2450,7 @@</span><br><span>      * NCP options =
are processed and we have no extra state for NCP finished=2E</span><br><spa=
n>      */</span><br><span>     if (session-&gt;opt-&gt;server &amp;&amp; (=
session-&gt;opt-&gt;mode !=3D MODE_SERVER</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            || multi-&gt;multi_state =3D=3D CAS_SUCCEED=
ED))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                  || multi-&gt;multi_state =3D=3D CAS_SUCCEEDED))</span><br=
><span>     {</span><br><span>         if (ks-&gt;authenticated &gt; KS_AUT=
H_FALSE)</span><br><span>         {</span><br><span>@@ -2679,13 +2703,13 @@=
</span><br><span>             (int) (now - ks-&gt;established), session-&gt=
;opt-&gt;renegotiate_seconds,</span><br><span>             ks-&gt;n_bytes, =
session-&gt;opt-&gt;renegotiate_bytes,</span><br><span>             ks-&gt;=
n_packets, session-&gt;opt-&gt;renegotiate_packets);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        key_state_soft_reset(session);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_soft_r=
eset(session, to_link);</span><br><span>     }</span><br><span> </span><br>=
<span>     /* Kill lame duck key transition_window seconds after primary ke=
y negotiation */</span><br><span>     if (lame_duck_must_die(session, wakeu=
p))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        key_state_free(ks_lame, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        key_state_free(ks_lame, true, to_link);</sp=
an><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_process: killed e=
xpiring key&quot;);</span><br><span>     }</span><br><span> </span><br><spa=
n>@@ -3009,6 +3033,56 @@</span><br><span>     return false;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_=
keystate_buf_not_used(struct buffer *to_link, const struct key_state *ks)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;state =3D=3D S_UNDEF || =
!to_link || !to_link-&gt;data)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint8_t *dataptr =3D to_link-&gt;dat=
a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* we don&#39;t expect send_reli=
able to be NULL when state is</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * not S_UNDEF, but people have reported crashes nonetheless,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * therefore we=
 better catch this event, report and exit=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!ks-&gt;send_reliable)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_FATAL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;ERROR: ks=2Esend_reliable (key-id %d), is NULL=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;while key state is %s=2E Exiting=2E&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            ks-&gt;key_id, state_name(ks-&gt;s=
tate));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int j =3D 0; j &lt; ks-&gt;send_reli=
able-&gt;size; j++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ks=
-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_INFO,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                &quot;Warning buffer of =
freed TLS session is still in&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                &quot; use (key-id %d, ks=2Esend_reliable-&=
gt;array[%d])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                ks-&gt;key_id, j);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto used;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;ack_write_buf=2Edata =3D=
=3D dataptr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &=
quot;Warning buffer of freed TLS session is still in use &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;(ks=2Eack_wri=
te_buf, key-id %d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ks-&gt;key_id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto used;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+used:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    to_link-&gt;len =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    to_link-&gt;data =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /**</span><br><span>  * This is a safe guard f=
unction to double check that a buffer from a session is</span><br><span>  *=
 not used in a session to avoid a use after free=2E</span><br><span>@@ -301=
9,58 +3093,24 @@</span><br><span> static void</span><br><span> check_sessio=
n_buf_not_used(struct buffer *to_link, struct tls_session *session)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_=
t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!dataptr)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!to_link || !to_link-&gt;data)</span><br><span>     {</spa=
n><br><span>         return;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =3D to_link-&g=
t;data;</span><br><span> </span><br><span>     /* Checks buffers in tls_wra=
p */</span><br><span>     if (session-&gt;tls_wrap=2Ework=2Edata =3D=3D dat=
aptr)</span><br><span>     {</span><br><span>         msg(M_INFO, &quot;War=
ning buffer of freed TLS session is &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    &quot;still in use (tls_wrap=2Ewor=
k=2Edata)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;still in use (tls_wrap=2Ework=2Edata)&quot;);</span><br><sp=
an>         goto used;</span><br><span>     }</span><br><span> </span><br><=
span>     for (int i =3D 0; i &lt; KS_SIZE; i++)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_state =
*ks =3D &amp;session-&gt;key[i];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (ks-&gt;state =3D=3D S_UNDEF)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            continue;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* we=
 don&#39;t expect send_reliable to be NULL when state is</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-         * not S_UNDEF, but people have =
reported crashes nonetheless,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         * therefore we better catch this event, report and exit=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!ks-&gt;send_reliab=
le)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;ERROR=
: session-&gt;key[%d]-&gt;send_reliable is NULL &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                &quot;while key state is %=
s=2E Exiting=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                i, state_name(ks-&gt;state));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (ks-&gt;send_reliable-&gt;array[j=
]=2Ebuf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    &quot;Warning buffer of freed TLS session is sti=
ll in&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          &quot; use (session-&gt;key[%d]=2Esend_reliable-&gt;array[%d])&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   i, j);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                goto used;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (ks-&gt;ack_write_buf=2Edata =3D=3D d=
ataptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &q=
uot;Warning buffer of freed TLS session is still in use (session-&gt;key[%d=
]=2Eack_write_buf)&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            g=
oto used;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct k=
ey_state *ks =3D &amp;session-&gt;key[i];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        check_keystate_buf_not_used(to_link, ks);</sp=
an><br><span>     }</span><br><span>     return;</span><br><span> </span><b=
r><span>@@ -3170,13 +3210,11 @@</span><br><span>                     &amp;&=
amp; ks_lame-&gt;state &gt;=3D S_ACTIVE</span><br><span>                   =
  &amp;&amp; !multi-&gt;opt=2Esingle_session)</span><br><span>             =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    check_session_buf_not_used(to_link, session);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    move_session(multi, TM_LAME=
_DUCK, TM_ACTIVE, true);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true,=
 to_link);</span><br><span>                 }</span><br><span>             =
    else</span><br><span>                 {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    check_session_buf_not_used(to_lin=
k, session);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           reset_session(multi, session);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    reset_session(multi, session, to_=
link);</span><br><span>                 }</span><br><span>             }</s=
pan><br><span>         }</span><br><span>@@ -3191,7 +3229,7 @@</span><br><s=
pan>      */</span><br><span>     if (lame_duck_must_die(&amp;multi-&gt;ses=
sion[TM_LAME_DUCK], wakeup))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;ses=
sion[TM_LAME_DUCK], true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tls_session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true,=
 to_link);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_mul=
ti_process: killed expiring key&quot;);</span><br><span>     }</span><br><s=
pan> </span><br><span>@@ -3206,8 +3244,7 @@</span><br><span>      */</span>=
<br><span>     if (DECRYPT_KEY_ENABLED(multi, &amp;multi-&gt;session[TM_UNT=
RUSTED]=2Ekey[KS_PRIMARY]))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        check_session_buf_not_used(to_link, &a=
mp;multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        move_session(mu=
lti, TM_ACTIVE, TM_UNTRUSTED, true, to_link);</span><br><span>         msg(=
D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: untrusted session promoted t=
o %strusted&quot;,</span><br><span>             tas =3D=3D TLS_AUTHENTICATI=
ON_SUCCEEDED ? &quot;&quot; : &quot;semi-&quot;);</span><br><span>     }</s=
pan><br><span>@@ -3622,7 +3659,7 @@</span><br><span>                 goto e=
rror;</span><br><span>             }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            key_state_soft_reset(session);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            key_sta=
te_soft_reset(session, NULL);</span><br><span> </span><br><span>           =
  dmsg(D_TLS_DEBUG,</span><br><span>                  &quot;TLS: received P=
_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;,</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail=
">change 1985</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
985?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: release/2=2E5 </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1985 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; <=
/div>

</body></html>
--QhfT+f+hNN8=--


--===============7690258582160051087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7690258582160051087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7690258582160051087==--


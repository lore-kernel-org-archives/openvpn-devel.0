Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F73AC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8kFaayQeikLaEHsrhN/G3UyiazPDfVv6wmdPRkJcfko=; b=Q14G8fMc156hx4
	zz7wGhItEDddhZUu7Wi9Xpwnp1Gi9yUl/YrUUzoLrDeCJyPq66YMAIEsoZ1OhEdmlOCYWbmk2upjA
	6Fwk+5N8WEwxyBEGijrDZBG+v4VaJNeH/sTHdADu3rHrKo4s1ZCEMKbI2qNwweueTB+Fk2iFg1Al+
	3hw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wezZM-0002JP-Du;
	Wed, 01 Jul 2026 18:21:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wezZK-0002JE-8R
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmK2FgItDFj7bzB2YHiiamcGmBdSZTypgUshcgmCXMU=; b=Cf3iR9n0W4//79P/+c4/A47Br7
 LHJuI2+TLfcURCZdfGklgC8CFynL2RKTg+Z8JAlyLF2S2NQGq6Sxg1pX5Z69KmSr1jYRGsfmFR3I8
 NlZnVlQRKKHSddi38FGAZrfgK/WUQHJ1BPBbnevvc35irHAzUbaxqcLxcjJf9Lm/Ff3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JmK2FgItDFj7bzB2YHiiamcGmBdSZTypgUshcgmCXMU=; b=B
 h7rCPnWOAYMhYBxmkio+pbJfegFpVAx+a5hDzF/ZyXJocd29Xs1E2tPvW/BEuwhX1VYTD47DHcMiB
 f7M4jwtl9rmhGeIRKcz6jDvb8W0NCUwh5HLXCaU8UvXdF0NU/lzD6SDNTn1ig6HVjSmJDXUmX1swj
 bdKp6J87ACftCbxg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wezZG-00045O-Vf for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:21:54 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c486f012so947675e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782930100; x=1783534900; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmK2FgItDFj7bzB2YHiiamcGmBdSZTypgUshcgmCXMU=;
 b=gjS2gmLSAKWsNOOJxEYMIHXDqnJSGneB4l1s72XEJdBNzaMMu58srOAiH9qFWxvVUV
 kUk2rKPAnetyy9XAqUQOO9q7gQDymzfyukMUJZRR5kXRnSO1lHtMolqgM9fqdP/W3Xkm
 h5/qMtkyDeXmEx0xvuZMqzNAGVtgt0nIAEXyC1crsOujva3quSXimdXLxPm3xwusZHn0
 x2oZVwCCHM77EmHtqmGhBmxOwzAxJV15wBN2QEtIy33PApjh3e3uDLLX6D6W2TKv2KAX
 HddlWu4L6DQXO3WMRkfh9oXyt8mOIBWJjayNOor5GsLssc+zTbBFtmH8moeRhIv6/Hzw
 czEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930100; x=1783534900;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JmK2FgItDFj7bzB2YHiiamcGmBdSZTypgUshcgmCXMU=;
 b=lV7d/xd6KSEW48dt4OekTjnWPCJcPTqj/IDMHDfpmej7wUZjRGaG2CUCl5GEWiKJaU
 RxORCww/YxlRNJKmFtKQVzy4syiZbbUanm1J5xcg2xnHNJCPI2eOI+YQfh6xtZZB58hq
 DLCNgoth8RK6yvWBTkzGqnVRWmpwN/2QsTyWlmCeDrKK472OVru0sl3DmGeKicmX5gWl
 ESPNVxgamJl+D8CjFlZFzpLnFSfFp9CXp51B1mu0YjOTJEdt+99NroL745mlZH2O/9yB
 Yx2mWPANjHTIP7h2KM4aOR4ANCwAZG++NqeMkddhKprjJdGr4tH4UWWs8NX+ycBdRQKa
 RjIA==
X-Gm-Message-State: AOJu0Yw3B1gfM2sugh0yLd+HeivjY3wUAdu3troqgCss4zOI3WrhvsQN
 8NqVO354cU/QEQ6OMaBdBxImJDF6J6ZjhX528cyHSLoBXIaoQWntMR++A77CYUbXS1sjsIcrMQ/
 d53CY+gCKKg7Z9F669BIpKgms4IVJASLysy+2wzF/5epH+1/AGjD4IyY7rbN3gvsigiNzMGc/iV
 F1nIsAIw==
X-Gm-Gg: AfdE7cmfBV5L8yJh4TjdwFAipoHVDxdVXsiIZg1bTs9tYBbnP5Z8cJOVL7WUQ1HMcvK
 gGHWYDUCsXYh4Ng/cnyJF6tondQjA/6opD0Jk38AekvCB6AjlOD9NlDRMVKDFqRLG0xPyC6mDqv
 iDhJftwCF1iTJu2zlk2azrNgSdoQmEbZJFKy+7kIcXsHrnOrOZzBWbrPGmXL0qXCipyqSziw7pr
 32gA+7o5X+M9ZVGSvFJpoSCIeuWlw/2TMpJvfAejVdt7oasaHmTqb4bikEeg+Fq9KwdF11LR6qs
 EBoFyX+Us5CQzjETUAmxPaQHESB2BlOIlK4Y2uN+ofM9OtaQwkVxFu0AX2mqHnvWHYFk9Y1X5Dw
 Md3b2db49L5ftWdd3vJUxER5jn19wrjAxbMjavd6wzlzFl2qinIEotMQhDyl1E4jv6mx8CqnWD3
 QGcP+RrlPD+dyLV6eFn4ZAZLT19HOUg//ymXUufmFvSwLWNlPxr+UMaMZ23MOnWEsjyJhpX/Mqd
 BesPOtmOsDS6pbW44LVzbiHNBtL98FdWnqGeG8oi0ALR2uss2ikM8Ow1JKwVGRsxqbuufWHqcxz
 LTw=
X-Received: by 2002:a05:600c:1c1b:b0:492:3c7e:57aa with SMTP id
 5b1f17b1804b1-493c2ac8669mr55622915e9.0.1782930099581; 
 Wed, 01 Jul 2026 11:21:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4fef11sm86827735e9.15.2026.07.01.11.21.39
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:21:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 18:21:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id9781a21a21637a12488fab857bc10aacc4a73c0
X-Gerrit-Change-Number: 1762
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1762?usp=email>
X-Gerrit-Commit: 87c9ec12651664d020f69e6efd8b4d23fa2283b0
References: <gerrit.1782930097000.Id9781a21a21637a12488fab857bc10aacc4a73c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMwMDk3MDAwLklkOTc4MWEyMWEyMTYzN2ExMjQ4OGZhYjg1N2JjMTBhYWNjNGE3M2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45a0732783d31ac40ccf8c75adba80247b5049a2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wezZG-00045O-Vf
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3474798393746272618=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3474798393746272618==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qozh9ySC4+U="; charset=UTF-8

--Qozh9ySC4+U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1762?usp=3Demail )


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

Change-Id: Id9781a21a21637a12488fab857bc10aacc4a73c0=

---
M src/openvpn/ssl=2Ec
1 file changed, 86 insertions(+), 58 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/=
1762/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df7c=
e=2E=2E5535207 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@=
@ -95,6 +95,14 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
+/* f=
orward decleration since tls_process needs this function prototype */
+stat=
ic void
+check_session_buf_not_used(struct buffer *to_link, struct tls_sess=
ion *session);
+
+static void
+check_keystate_buf_not_used(struct buffer *t=
o_link, struct key_state *ks);
+
+
 /**
  * Limit the reneg_bytes value whe=
n using a small-block (<128 bytes) cipher=2E
  *
@@ -902,10 +910,15 @@
  * =
                      cleaned up=2E
  * @param clear        - Whether the m=
emory allocated for the \a ks object
  *                       should be ov=
erwritten with 0s=2E
+ *
+ * @param to_link      - if not NULL, check that =
the buffer does not contain
+ *                       any pointer to one of=
 the internal structs of ks
  */
 static void
-key_state_free(struct key_st=
ate *ks, bool clear)
+key_state_free(struct key_state *ks, bool clear, stru=
ct buffer *to_link)
 {
+    check_keystate_buf_not_used(to_link, ks);
+
   =
  ks->state =3D S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1052,8=
 +1065,9 @@
  *
  */
 static void
-tls_session_free(struct tls_session *ses=
sion, bool clear)
+tls_session_free(struct tls_session *session, bool clear=
, struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, sessi=
on);
     tls_wrap_free(&session->tls_wrap);
     tls_wrap_free(&session->t=
ls_wrap_reneg);
 
@@ -1062,7 +1076,7 @@
         /* we don't need clear=3Dt=
rue for this call since
          * the structs are part of session and get=
 cleared
          * as part of session */
-        key_state_free(&session=
->key[i], false);
+        key_state_free(&session->key[i], false, to_link)=
;
     }
 
     free(session->common_name);
@@ -1081,14 +1095,16 @@
 
 
 st=
atic void
-move_session(struct tls_multi *multi, int dest, int src, bool re=
init_src)
+move_session(struct tls_multi *multi, int dest, int src, bool re=
init_src,
+             struct buffer *to_link)
 {
+    check_session_buf_n=
ot_used(to_link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: mo=
ve_session: dest=3D%s src=3D%s reinit_src=3D%d",
         session_index_nam=
e(dest), session_index_name(src), reinit_src);
     ASSERT(src !=3D dest);
=
     ASSERT(src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && dest <=
 TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+    tls_se=
ssion_free(&multi->session[dest], false, to_link);
     multi->session[dest=
] =3D multi->session[src];
 
     if (reinit_src)
@@ -1104,9 +1120,9 @@
 }
=
 
 static void
-reset_session(struct tls_multi *multi, struct tls_session *=
session)
+reset_session(struct tls_multi *multi, struct tls_session *sessio=
n, struct buffer *to_link)
 {
-    tls_session_free(session, false);
+    t=
ls_session_free(session, false, to_link);
     tls_session_init(multi, sess=
ion);
 }
 
@@ -1259,7 +1275,7 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)=

     {
-        tls_session_free(&multi->session[i], false);
+        tls_=
session_free(&multi->session[i], false, NULL);
     }
 
     if (clear)
@@ =
-1754,13 +1770,13 @@
  * active key=2E
  */
 static void
-key_state_soft_re=
set(struct tls_session *session)
+key_state_soft_reset(struct tls_session *=
session, struct buffer *to_link)
 {
     struct key_state *ks =3D &session-=
>key[KS_PRIMARY];        /* primary key */
     struct key_state *ks_lame =
=3D &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die =3D=
 now + session->opt->transition_window;    /* remaining lifetime of old key=
 */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, false=
, to_link);
     *ks_lame =3D *ks;
 
     key_state_init(session, ks);
@@ -=
1771,7 +1787,7 @@
 void
 tls_session_soft_reset(struct tls_multi *tls_multi=
)
 {
-    key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
+    key_st=
ate_soft_reset(&tls_multi->session[TM_ACTIVE], NULL);
 }
 
 /*
@@ -3041,13 =
+3057,13 @@
             session->opt->aead_usage_limit,
             ks->c=
rypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks + ks->n_packets,
  =
           session->opt->aead_usage_limit);
-        key_state_soft_reset(s=
ession);
+        key_state_soft_reset(session, to_link);
     }
 
     /* =
Kill lame duck key transition_window seconds after primary key negotiation =
*/
     if (lame_duck_must_die(session, wakeup))
     {
-        key_state_=
free(ks_lame, true);
+        key_state_free(ks_lame, true, to_link);
     =
    msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
 =

@@ -3140,6 +3156,55 @@
     return false;
 }
 
+static void
+check_keystat=
e_buf_not_used(struct buffer *to_link, struct key_state *ks)
+{
+    if (ks=
->state =3D=3D S_UNDEF || !to_link || !to_link->data)
+    {
+        retur=
n;
+    }
+
+    uint8_t *dataptr =3D to_link->data;
+
+    /* we don't exp=
ect send_reliable to be NULL when state is
+     * not S_UNDEF, but people =
have reported crashes nonetheless,
+     * therefore we better catch this e=
vent, report and exit=2E
+     */
+    if (!ks->send_reliable)
+    {
+    =
    msg(M_FATAL,
+            "ERROR: ks=2Esend_reliable (key-id %d), is NU=
LL "
+            "while key state is %s=2E Exiting=2E",
+            ks->k=
ey_id, state_name(ks->state));
+    }
+
+    for (int j =3D 0; j < ks->send=
_reliable->size; j++)
+    {
+        if (ks->send_reliable->array[j]=2Ebuf=
=2Edata =3D=3D dataptr)
+        {
+            msg(M_INFO,
+              =
  "Warning buffer of freed TLS session is still in"
+                " use =
(key-id %d, ks=2Esend_reliable->array[%d])",
+                ks->key_id, j=
);
+
+            goto used;
+        }
+    }
+
+    if (ks->ack_write_buf=
=2Edata =3D=3D dataptr)
+    {
+        msg(M_INFO, "Warning buffer of free=
d TLS session is still in use "
+                    "(ks=2Eack_write_buf, =
key-id %d)",
+            ks->key_id);
+
+        goto used;
+    }
+    re=
turn;
+
+used:
+    to_link->len =3D 0;
+    to_link->data =3D 0;
+}
 
 /**=

  * This is a safe guard function to double check that a buffer from a ses=
sion is
@@ -3151,11 +3216,11 @@
 static void
 check_session_buf_not_used(st=
ruct buffer *to_link, struct tls_session *session)
 {
-    uint8_t *dataptr=
 =3D to_link->data;
-    if (!dataptr)
+    if (!to_link || !to_link->data)=

     {
         return;
     }
+    uint8_t *dataptr =3D to_link->data;
 
=
     /* Checks buffers in tls_wrap */
     if (session->tls_wrap=2Ework=2Ed=
ata =3D=3D dataptr)
@@ -3174,41 +3239,7 @@
     for (int i =3D 0; i < KS_SI=
ZE; i++)
     {
         struct key_state *ks =3D &session->key[i];
-      =
  if (ks->state =3D=3D S_UNDEF)
-        {
-            continue;
-        =
}
-
-        /* we don't expect send_reliable to be NULL when state is
-   =
      * not S_UNDEF, but people have reported crashes nonetheless,
-       =
  * therefore we better catch this event, report and exit=2E
-         */
-=
        if (!ks->send_reliable)
-        {
-            msg(M_FATAL,
-     =
           "ERROR: session->key[%d]->send_reliable is NULL "
-             =
   "while key state is %s=2E Exiting=2E",
-                i, state_name(ks=
->state));
-        }
-
-        for (int j =3D 0; j < ks->send_reliable->s=
ize; j++)
-        {
-            if (ks->send_reliable->array[j]=2Ebuf=2Ed=
ata =3D=3D dataptr)
-            {
-                msg(M_INFO,
-          =
          "Warning buffer of freed TLS session is still in"
-              =
      " use (session->key[%d]=2Esend_reliable->array[%d])",
-              =
      i, j);
-
-                goto used;
-            }
-        }
-     =
   if (ks->ack_write_buf=2Edata =3D=3D dataptr)
-        {
-            msg=
(M_INFO, "Warning buffer of freed TLS session is still in use (session->key=
[%d]=2Eack_write_buf)", i);
-
-            goto used;
-        }
+        c=
heck_keystate_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3302,13 =
+3333,11 @@
                 if (i =3D=3D TM_ACTIVE && ks_lame->state >=3D =
S_GENERATED_KEYS
                     && !multi->opt=2Esingle_session)
    =
             {
-                    check_session_buf_not_used(to_link, ses=
sion);
-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, tr=
ue);
+                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true=
, to_link);
                 }
                 else
                 {
-  =
                  check_session_buf_not_used(to_link, session);
-          =
          reset_session(multi, session);
+                    reset_session=
(multi, session, to_link);
                 }
             }
         }
@@ =
-3361,7 +3390,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_=
LAME_DUCK], wakeup))
     {
-        tls_session_free(&multi->session[TM_LA=
ME_DUCK], true);
+        tls_session_free(&multi->session[TM_LAME_DUCK], t=
rue, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: kille=
d expiring key");
     }
 
@@ -3376,8 +3405,7 @@
      */
     if (TLS_AUTH=
ENTICATED(multi, &multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]))
     {
-  =
      check_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-   =
     move_session(multi, TM_ACTIVE, TM_INITIAL, true);
+        move_sessio=
n(multi, TM_ACTIVE, TM_INITIAL, true, to_link);
         tas =3D tls_authen=
tication_status(multi);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tl=
s_multi_process: initial untrusted "
@@ -3779,7 +3807,7 @@
                =
 goto error;
             }
 
-            key_state_soft_reset(session);
+=
            key_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_=
DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s", i,
        =
          session_id_print(&sid, &gc));

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1762?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Id9781a21a21637a12488fab857bc10aacc4a73c0
Gerrit-Cha=
nge-Number: 1762
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--Qozh9ySC4+U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1762?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Move check_session_buf_not_used method into the method that free t=
he buffer<br><br>This cleans the code up a bit and ensure that we do not mi=
ss an invocation<br>of a problematic code path=2E This is still a band-aid =
fix and a real fix<br>requires more refactoring and changing the logic=2E<b=
r><br>Change-Id: Id9781a21a21637a12488fab857bc10aacc4a73c0<br>---<br>M src/=
openvpn/ssl=2Ec<br>1 file changed, 86 insertions(+), 58 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/62/1762/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec</span><br><span>index 60df7ce=2E=2E5535207 100644</span><br><span>=
--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><=
br><span>@@ -95,6 +95,14 @@</span><br><span> </span><br><span> #endif /* if=
def MEASURE_TLS_HANDSHAKE_STATS */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* forward decleration since tls_process =
needs this function prototype */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+check_session_buf_not_used(struct buffer *to_link, struct tls_session =
*session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct b=
uffer *to_link, struct key_state *ks);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /**</span><br><span>  * Limit the reneg_bytes value when =
using a small-block (&lt;128 bytes) cipher=2E</span><br><span>  *</span><br=
><span>@@ -902,10 +910,15 @@</span><br><span>  *                       clea=
ned up=2E</span><br><span>  * @param clear        - Whether the memory allo=
cated for the \a ks object</span><br><span>  *                       should=
 be overwritten with 0s=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
to_link      - if not NULL, check that the buffer does not contain</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *                       any=
 pointer to one of the internal structs of ks</span><br><span>  */</span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-k=
ey_state_free(struct key_state *ks, bool clear)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+key_state_free(struct key_state *ks, bool clear=
, struct buffer *to_link)</span><br><span> {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    check_keystate_buf_not_used(to_link, ks);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ks=
-&gt;state =3D S_UNDEF;</span><br><span> </span><br><span>     key_state_ss=
l_free(&amp;ks-&gt;ks_ssl);</span><br><span>@@ -1052,8 +1065,9 @@</span><br=
><span>  *</span><br><span>  */</span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-tls_session_free(struct tls_session =
*session, bool clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+tls_session_free(struct tls_session *session, bool clear, struct buffer *=
to_link)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    check_session_buf_not_used(to_link, session);</span><br><span> =
    tls_wrap_free(&amp;session-&gt;tls_wrap);</span><br><span>     tls_wrap=
_free(&amp;session-&gt;tls_wrap_reneg);</span><br><span> </span><br><span>@=
@ -1062,7 +1076,7 @@</span><br><span>         /* we don&#39;t need clear=3D=
true for this call since</span><br><span>          * the structs are part o=
f session and get cleared</span><br><span>          * as part of session */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_fre=
e(&amp;session-&gt;key[i], false);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        key_state_free(&amp;session-&gt;key[i], false, to_li=
nk);</span><br><span>     }</span><br><span> </span><br><span>     free(ses=
sion-&gt;common_name);</span><br><span>@@ -1081,14 +1095,16 @@</span><br><s=
pan> </span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-move_session(struct tls_multi *multi, int d=
est, int src, bool reinit_src)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+move_session(struct tls_multi *multi, int dest, int src, bool re=
init_src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   struct buffer *to_link)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    check_session_buf_not_used(to_link, &amp;mult=
i-&gt;session[dest]);</span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: =
move_session: dest=3D%s src=3D%s reinit_src=3D%d&quot;,</span><br><span>   =
      session_index_name(dest), session_index_name(src), reinit_src);</span=
><br><span>     ASSERT(src !=3D dest);</span><br><span>     ASSERT(src &gt;=
=3D 0 &amp;&amp; src &lt; TM_SIZE);</span><br><span>     ASSERT(dest &gt;=
=3D 0 &amp;&amp; dest &lt; TM_SIZE);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    tls_session_free(&amp;multi-&gt;session[dest], false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(=
&amp;multi-&gt;session[dest], false, to_link);</span><br><span>     multi-&=
gt;session[dest] =3D multi-&gt;session[src];</span><br><span> </span><br><s=
pan>     if (reinit_src)</span><br><span>@@ -1104,9 +1120,9 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-reset_session(struct tls_multi *multi, stru=
ct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+reset_session(struct tls_multi *multi, struct tls_session *session, st=
ruct buffer *to_link)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    tls_session_free(session, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(session, false, t=
o_link);</span><br><span>     tls_session_init(multi, session);</span><br><=
span> }</span><br><span> </span><br><span>@@ -1259,7 +1275,7 @@</span><br><=
span> </span><br><span>     for (int i =3D 0; i &lt; TM_SIZE; ++i)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 tls_session_free(&amp;multi-&gt;session[i], false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;s=
ession[i], false, NULL);</span><br><span>     }</span><br><span> </span><br=
><span>     if (clear)</span><br><span>@@ -1754,13 +1770,13 @@</span><br><s=
pan>  * active key=2E</span><br><span>  */</span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_soft_reset(stru=
ct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+key_state_soft_reset(struct tls_session *session, struct buffer *to_li=
nk)</span><br><span> {</span><br><span>     struct key_state *ks =3D &amp;s=
ession-&gt;key[KS_PRIMARY];        /* primary key */</span><br><span>     s=
truct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK]; /* retirin=
g key */</span><br><span> </span><br><span>     ks-&gt;must_die =3D now + s=
ession-&gt;opt-&gt;transition_window;    /* remaining lifetime of old key *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_state_free(k=
s_lame, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
key_state_free(ks_lame, false, to_link);</span><br><span>     *ks_lame =3D =
*ks;</span><br><span> </span><br><span>     key_state_init(session, ks);</s=
pan><br><span>@@ -1771,7 +1787,7 @@</span><br><span> void</span><br><span> =
tls_session_soft_reset(struct tls_multi *tls_multi)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_state_soft_reset(&=
amp;tls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    key_state_soft_reset(&amp;tls_multi-&gt;session[TM_A=
CTIVE], NULL);</span><br><span> }</span><br><span> </span><br><span> /*</sp=
an><br><span>@@ -3041,13 +3057,13 @@</span><br><span>             session-&=
gt;opt-&gt;aead_usage_limit,</span><br><span>             ks-&gt;crypto_opt=
ions=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks + ks-&gt;n_packets,</span><b=
r><span>             session-&gt;opt-&gt;aead_usage_limit);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        key_state_soft_reset(session)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_=
soft_reset(session, to_link);</span><br><span>     }</span><br><span> </spa=
n><br><span>     /* Kill lame duck key transition_window seconds after prim=
ary key negotiation */</span><br><span>     if (lame_duck_must_die(session,=
 wakeup))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        key_state_free(ks_lame, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        key_state_free(ks_lame, true, to_link=
);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_process: ki=
lled expiring key&quot;);</span><br><span>     }</span><br><span> </span><b=
r><span>@@ -3140,6 +3156,55 @@</span><br><span>     return false;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
check_keystate_buf_not_used(struct buffer *to_link, struct key_state *ks)</=
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
span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;(ks=
=2Eack_write_buf, key-id %d)&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ks-&gt;key_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        goto used;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+used:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    to_link-&gt;len =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    to_link-&gt;data =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span>=
 /**</span><br><span>  * This is a safe guard function to double check that=
 a buffer from a session is</span><br><span>@@ -3151,11 +3216,11 @@</span><=
br><span> static void</span><br><span> check_session_buf_not_used(struct bu=
ffer *to_link, struct tls_session *session)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&=
gt;data;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!data=
ptr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!to_lin=
k || !to_link-&gt;data)</span><br><span>     {</span><br><span>         ret=
urn;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span> </span>=
<br><span>     /* Checks buffers in tls_wrap */</span><br><span>     if (se=
ssion-&gt;tls_wrap=2Ework=2Edata =3D=3D dataptr)</span><br><span>@@ -3174,4=
1 +3239,7 @@</span><br><span>     for (int i =3D 0; i &lt; KS_SIZE; i++)</s=
pan><br><span>     {</span><br><span>         struct key_state *ks =3D &amp=
;session-&gt;key[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (ks-&gt;state =3D=3D S_UNDEF)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            continue;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* we don&#39;t exp=
ect send_reliable to be NULL when state is</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * not S_UNDEF, but people have reported crash=
es nonetheless,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * therefore we better catch this event, report and exit=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!ks-&gt;send_reliable)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                &quot;ERROR: session-&g=
t;key[%d]-&gt;send_reliable is NULL &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                &quot;while key state is %s=2E Exiting=
=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     i, state_name(ks-&gt;state));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int j =
=3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Ed=
ata =3D=3D dataptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                &quot;Warning buffer of freed TLS session is still in&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &=
quot; use (session-&gt;key[%d]=2Esend_reliable-&gt;array[%d])&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    i, j);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                goto used;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;Warnin=
g buffer of freed TLS session is still in use (session-&gt;key[%d]=2Eack_wr=
ite_buf)&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto used;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        check_keystate_buf_not_u=
sed(to_link, ks);</span><br><span>     }</span><br><span>     return;</span=
><br><span> </span><br><span>@@ -3302,13 +3333,11 @@</span><br><span>      =
           if (i =3D=3D TM_ACTIVE &amp;&amp; ks_lame-&gt;state &gt;=3D S_GE=
NERATED_KEYS</span><br><span>                     &amp;&amp; !multi-&gt;opt=
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
pan><br><span>@@ -3361,7 +3390,7 @@</span><br><span>      */</span><br><spa=
n>     if (lame_duck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        tls_session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_session_fr=
ee(&amp;multi-&gt;session[TM_LAME_DUCK], true, to_link);</span><br><span>  =
       msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring k=
ey&quot;);</span><br><span>     }</span><br><span> </span><br><span>@@ -337=
6,8 +3405,7 @@</span><br><span>      */</span><br><span>     if (TLS_AUTHEN=
TICATED(multi, &amp;multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    check_session_buf_not_used(to_link, &amp;multi-&gt;session[TM_ACTIVE]);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        move_session(=
multi, TM_ACTIVE, TM_INITIAL, true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        move_session(multi, TM_ACTIVE, TM_INITIAL, true, t=
o_link);</span><br><span>         tas =3D tls_authentication_status(multi);=
</span><br><span>         msg(D_TLS_DEBUG_LOW,</span><br><span>            =
 &quot;TLS: tls_multi_process: initial untrusted &quot;</span><br><span>@@ =
-3779,7 +3807,7 @@</span><br><span>                 goto error;</span><br><=
span>             }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            key_state_soft_reset(session);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            key_state_soft_reset(ses=
sion, NULL);</span><br><span> </span><br><span>             dmsg(D_TLS_DEBU=
G, &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,</s=
pan><br><span>                  session_id_print(&amp;sid, &amp;gc));</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1762?usp=3Demail">change 1762</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1762?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Id9781a21a21637a12488fab8=
57bc10aacc4a73c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1762 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Qozh9ySC4+U=--


--===============3474798393746272618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3474798393746272618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3474798393746272618==--


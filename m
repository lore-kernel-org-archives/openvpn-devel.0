Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07830C624D7
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BWFd6P5sPV39r7yeu130Xha2Sui2jJujajic3+YVfSY=; b=YBD9AUWu5zkXuhof1ReaAZ1qfg
	jOSw5gsPhHKCZzp/2PzNMRL3HLuaMdMbQU+YWA4DgH0NdUiEmdLhZLFLuWOaUqiMcaaqn8mBzyGj1
	fm4aNqIA+7KftALp96GyZp/aWT1ULzqIhBa2/eDAVDGL18FkAEYwQt/r1yrIGM/IQRkI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x21ls-00088C-8o;
	Thu, 03 Sep 2026 07:22:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x21lq-000884-Kx
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 07:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=J2fHcLf/PP06ZbmFtj1z2m7U9rPAdEDPN7MZpJlyKnc=; b=fgeFYez9ujdWINF2slu5/LOY8r
 xN5Gq7vmcAD1ZidWuO00C6qtYk9klYGlNhhDiPzah7Li1/WuPIXve2QnwjNgbWL55GwsHp4MGFMob
 /SBrmdr+J9SF+D8nU2+B56cK0t1RwJ625YEl9nPO/7SaZETJ3HOPWgBTZaw9Yj29Vd40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=J2fHcLf/PP06ZbmFtj1z2m7U9rPAdEDPN7MZpJlyKnc=; b=H
 G6V/ElUjkVIPSIcCXxoOBm3yi6cURtQ7UIxWwE+Ye5cXrf3Vlp15vtk2SybqTpCv6ryd2aGvunXXc
 tCvNyiFSwbmVEirFCjO+8UbA9WR2yIQT2GEc8WWGUg39Vo67X7XYkqSZRQ0sYBQuWKOdz9+av34l4
 97QmDiBc2wR9W8ig=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x21lp-0004cy-Gz for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 07:22:03 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso14503775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788420115; x=1789024915; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J2fHcLf/PP06ZbmFtj1z2m7U9rPAdEDPN7MZpJlyKnc=;
 b=G6kTqtLQnJN70c6PJ1qfuWTSUm2QWTxuCBQt+126lsJWiTO2L/X5A2sioG0cHUZDMs
 KhS1zSNplFHue2Ig4jpfEoNnVGmI9OYNnmsTarFR0jnUyJBR7ClrNRTrc4VHTr+3qmf1
 TG6tX3rsJeJvUeCSda029+x7g3LaopPyCyIqFIR90jx8HdD44QWZMJj3XxV8qhY5A627
 CcxuJUEqBRK2NWwLnCniGlIJ4K924jYg8EtYztRq3lyNlwYNvlYiTU2mpA2ncsQhYast
 JBJJwx8mR5+HP+fgOewNRm3f+MKJ9MJXrURc+2uvI9mkxsP+ZgGtx2ArY+TBoaHCshEe
 X3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788420115; x=1789024915;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J2fHcLf/PP06ZbmFtj1z2m7U9rPAdEDPN7MZpJlyKnc=;
 b=XLo0RFBRa69/AEFQ/ckRhNFLORNtKFPYyjvxa3PxDby5H9eJzE3mENfg2btpOHaDe4
 sk70cHSiZtksSYxMmcoK2rlxkg8eP+uhA2c4Q4tekHcEmjFjEC9/uJxuHonWEwMyT3DG
 lXxYaUgj3RcGr+sKH2EO62bM79gDlfVm/38NkN0LKAjC3sAGFzxjF56HHHQ75Po2K1jb
 gFfdrbXgPDmaLu5aEFBQkYyyLiBkbRJLDzQF53K2X2gS/UvKILHwjZkxAD6rpSyBQcrm
 K1Kxc5nGZK8TUugWel3yHSMOXMbvg+bqaHYzd7O/IPF6OQOuhF6ifVzY3aMS4cRHSKu/
 UaJA==
X-Gm-Message-State: AFuF++mqIdX9Q4yUKcMHBJNNhTz5E+YrW3NEu3b3GNwUZXixsGEFB6GH
 /xXI5pyudl3gSITDlU9Pk1wkg8qJai6A10awSY50hXJP3LAr6ZiAzUj5ekJB794RN/UzBoRi3Ek
 fiXE3cc9axq4h6KJVU6czl2IK16gqmSJYlo+vw+MCrfT+vVYzteuoS2OnDnOmApvGXq+d
X-Gm-Gg: AYBFou1THj7RknMfJ2t5U3wg2Nf+Wl7JrPy5ugRQIYA3LsY2VaAMjZk65q+vp5Ui9gk
 X9XjOIYIBStTYLPo6Nax7GYshry3/dt1BlPHwD448FsYbz5XgcLChJ4b1FyXFrQGJIkts/8tgUW
 qgSxZa7G4Djj/Z57WcovbOsrO1xsH5543r4GkIVWXQLCskpoea/36rdzRdQYCuuRKbyY72lxBb3
 qHLAzRO51UPqashdCOnH6oVZpIHXwLyWqOHXG2ULaeL0LpJwlUSO9bZyaRfnTEAtskI0ETE5ZqA
 +nPIVRUsAABulubfvmESO5ydv+H6nzgjVV3sqEkYR6qsQGJ8caBzuaqWu8WNwIirN/CqKOcijri
 7y9WrCZFkVxjgONnxwWLRBMWOVqw4HdgmJo87nPii2kHiPLfdCGZVd+OObCK59xJ7W6XstTN8LI
 npP4ZzmflJBj0rMfxSPCubBDBjAebBpmNPG1CQ/8CbTs8j3Xoqpu9+l1XgY/yB24lwmoWdEepL6
 sSSgzlUsTSBe8IBl0avrRuH7B+ZDj24WutZoCau//vQkvhTj8E4+jAMB14zrVBIqUix+8eKa5ih
 RE6tvERWt0KRX46CCDXzAqBw7rocHLKLCTwjajpTjpPmmR5LP1clFUAX1V4srw==
X-Received: by 2002:a05:600c:c48f:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49ce582276dmr152641605e9.14.1788420114722; 
 Thu, 03 Sep 2026 00:21:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm105498465e9.1.2026.09.03.00.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:21:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 07:21:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1893
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1893?usp=email>
X-Gerrit-Commit: 2a881d737b2562ee28247148160cfb60f0ba4645
In-Reply-To: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MzY4NjE4MDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <34a22995dd74832ba244d7d8cacd347dda69ad43-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x21lp-0004cy-Gz
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
Content-Type: multipart/mixed; boundary="===============6917483707773103668=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6917483707773103668==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yi9Z1nez0qs="; charset=UTF-8

--Yi9Z1nez0qs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello MaxF, plaisthos, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893?usp=3Demail

to look a=
t the new patch set (#4)=2E


Change subject: Move check_session_buf_not_us=
ed method into the method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move check_session_buf_not_used method i=
nto the method that free the buffer

This cleans the code up a bit and ensu=
re that we do not miss an invocation
of a problematic code path=2E This is =
still a band-aid fix and a real fix
requires more refactoring and changing =
the logic=2E

v2: sprinkle some "const" over check_keystate_buf_not_used() =
args
v3: add missing doxygen for to_link parameter to tls_session_free()

C=
VE: 2026-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom=
>
Tested-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Github: openv=
pn/openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda University)=

Github: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f714803604d=
76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893
Acked-by: MaxF <max=
@max-fillinger=2Enet>
Message-Id: <20260903061209=2E12599-1-gert@greenie=2E=
muc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg38913=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emu=
c=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 88 insertions(+), 58 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/93/1893/4

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index =
5f5d1f9=2E=2E71459ee 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -96,6 +96,14 @@
 
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
  * Limit the reneg_byt=
es value when using a small-block (<128 bytes) cipher=2E
  *
@@ -896,10 +90=
4,15 @@
  *                       cleaned up=2E
  * @param clear        - W=
hether the memory allocated for the \a ks object
  *                       =
should be overwritten with 0s=2E
+ *
+ * @param to_link      - if not NULL,=
 check that the buffer does not contain
+ *                       any point=
er to one of the internal structs of ks
  */
 static void
-key_state_free(s=
truct key_state *ks, bool clear)
+key_state_free(struct key_state *ks, bool=
 clear, struct buffer *to_link)
 {
+    check_keystate_buf_not_used(to_link=
, ks);
+
     ks->state =3D S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl)=
;
@@ -1043,11 +1056,14 @@
  *                       object should be overwr=
itten with 0s=2E This
  *                       implicitly sets many states=
 to 0/false,
  *                       e=2Eg=2E the validity of the keys in=
 the structure
+ * @param to_link      - if not NULL, check that the buffer=
 does not contain
+ *                       any pointer to one of the inter=
nal structs of ks
  *
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
     tls_wrap_free(&sess=
ion->tls_wrap_reneg);
 
@@ -1056,7 +1072,7 @@
         /* we don't need cle=
ar=3Dtrue for this call since
          * the structs are part of session a=
nd get cleared
          * as part of session */
-        key_state_free(&s=
ession->key[i], false);
+        key_state_free(&session->key[i], false, to=
_link);
     }
 
     free(session->common_name);
@@ -1075,14 +1091,16 @@
 =

 
 static void
-move_session(struct tls_multi *multi, int dest, int src, b=
ool reinit_src)
+move_session(struct tls_multi *multi, int dest, int src, b=
ool reinit_src,
+             struct buffer *to_link)
 {
+    check_session=
_buf_not_used(to_link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "T=
LS: move_session: dest=3D%s src=3D%s reinit_src=3D%d",
         session_ind=
ex_name(dest), session_index_name(src), reinit_src);
     ASSERT(src !=3D d=
est);
     ASSERT(src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && =
dest < TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+    =
tls_session_free(&multi->session[dest], false, to_link);
     multi->sessio=
n[dest] =3D multi->session[src];
 
     if (reinit_src)
@@ -1098,9 +1116,9 =
@@
 }
 
 static void
-reset_session(struct tls_multi *multi, struct tls_ses=
sion *session)
+reset_session(struct tls_multi *multi, struct tls_session *=
session, struct buffer *to_link)
 {
-    tls_session_free(session, false);
=
+    tls_session_free(session, false, to_link);
     tls_session_init(multi=
, session);
 }
 
@@ -1265,7 +1283,7 @@
 
     for (int i =3D 0; i < TM_SIZE=
; ++i)
     {
-        tls_session_free(&multi->session[i], false);
+      =
  tls_session_free(&multi->session[i], false, NULL);
     }
 
     if (clea=
r)
@@ -1764,13 +1782,13 @@
  * active key=2E
  */
 static void
-key_state_s=
oft_reset(struct tls_session *session)
+key_state_soft_reset(struct tls_ses=
sion *session, struct buffer *to_link)
 {
     struct key_state *ks =3D &se=
ssion->key[KS_PRIMARY];        /* primary key */
     struct key_state *ks_=
lame =3D &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_di=
e =3D now + session->opt->transition_window;    /* remaining lifetime of ol=
d key */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, =
false, to_link);
     *ks_lame =3D *ks;
 
     key_state_init(session, ks);=

@@ -1781,7 +1799,7 @@
 void
 tls_session_soft_reset(struct tls_multi *tls_=
multi)
 {
-    key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
+    k=
ey_state_soft_reset(&tls_multi->session[TM_ACTIVE], NULL);
 }
 
 /*
@@ -310=
1,13 +3119,13 @@
             session->opt->aead_usage_limit,
             =
ks->crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks + ks->n_packet=
s,
             session->opt->aead_usage_limit);
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
 
@@ -3200,6 +3218,55 @@
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
+                    "(ks=2Eack_=
write_buf, key-id %d)",
+            ks->key_id);
+
+        goto used;
+  =
  }
+    return;
+
+used:
+    to_link->len =3D 0;
+    to_link->data =3D 0=
;
+}
 
 /**
  * This is a safe guard function to double check that a buffer=
 from a session is
@@ -3211,11 +3278,11 @@
 static void
 check_session_buf_=
not_used(struct buffer *to_link, struct tls_session *session)
 {
-    const=
 uint8_t *dataptr =3D to_link->data;
-    if (!dataptr)
+    if (!to_link |=
| !to_link->data)
     {
         return;
     }
+    const uint8_t *datapt=
r =3D to_link->data;
 
     /* Checks buffers in tls_wrap */
     if (sessi=
on->tls_wrap=2Ework=2Edata =3D=3D dataptr)
@@ -3234,41 +3301,7 @@
     for =
(int i =3D 0; i < KS_SIZE; i++)
     {
         const struct key_state *ks =
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
+        check_keystate_buf_not_used(to_link, ks);
   =
  }
     return;
 
@@ -3362,13 +3395,11 @@
                 if (i =3D=3D TM=
_ACTIVE && ks_lame->state >=3D S_GENERATED_KEYS
                     && !mu=
lti->opt=2Esingle_session)
                 {
-                    check_se=
ssion_buf_not_used(to_link, session);
-                    move_session(mul=
ti, TM_LAME_DUCK, TM_ACTIVE, true);
+                    move_session(multi=
, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
                 }
             =
    else
                 {
-                    check_session_buf_not_used=
(to_link, session);
-                    reset_session(multi, session);
+  =
                  reset_session(multi, session, to_link);
                 =
}
             }
         }
@@ -3421,7 +3452,7 @@
      */
     if (lame_du=
ck_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tls_ses=
sion_free(&multi->session[TM_LAME_DUCK], true);
+        tls_session_free(&=
multi->session[TM_LAME_DUCK], true, to_link);
         msg(D_TLS_DEBUG_LOW,=
 "TLS: tls_multi_process: killed expiring key");
     }
 
@@ -3436,8 +3467,=
7 @@
      */
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL]=
=2Ekey[KS_PRIMARY]))
     {
-        check_session_buf_not_used(to_link, &m=
ulti->session[TM_ACTIVE]);
-        move_session(multi, TM_ACTIVE, TM_INITI=
AL, true);
+        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_lin=
k);
         tas =3D tls_authentication_status(multi);
         msg(D_TLS_D=
EBUG_LOW,
             "TLS: tls_multi_process: initial untrusted "
@@ -383=
9,7 +3869,7 @@
                 goto error;
             }
 
-            k=
ey_state_soft_reset(session);
+            key_state_soft_reset(session, NU=
LL);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V=
1 s=3D%d sid=3D%s", i,
                  session_id_print(&sid, &gc));

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64920ed9f714803604d7=
6c6df6b38cf20ce7626d
Gerrit-Change-Number: 1893
Gerrit-PatchSet: 4
Gerrit-O=
wner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: MaxF <max@max-fillin=
ger=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-CC: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Yi9Z1nez0qs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1893?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Move check_session_buf_not_used method into the method that free the =
buffer<br><br>This cleans the code up a bit and ensure that we do not miss =
an invocation<br>of a problematic code path=2E This is still a band-aid fix=
 and a real fix<br>requires more refactoring and changing the logic=2E<br><=
br>v2: sprinkle some &quot;const&quot; over check_keystate_buf_not_used() a=
rgs<br>v3: add missing doxygen for to_link parameter to tls_session_free()<=
br><br>CVE: 2026-84471<br>Reported-By: Andreas Gabriel Berbescu &lt;aberbes=
cu@gmail=2Ecom&gt;<br>Tested-By: Andreas Gabriel Berbescu &lt;aberbescu@gma=
il=2Ecom&gt;<br>Github: openvpn/openvpn-private-issues#157<br>Reported-By: =
Haruki Oyama (Waseda University)<br>Github: openvpn/openvpn-private-issues#=
132<br>Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d<br>Signed-off-b=
y: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1893<br>Acked-by: MaxF &lt;max@max-fillinger=2Ene=
t&gt;<br>Message-Id: &lt;20260903061209=2E12599-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg38913=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 88 insertio=
ns(+), 58 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/93/1893/4</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f9=2E=2E71=
459ee 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ =
b/src/openvpn/ssl=2Ec</span><br><span>@@ -96,6 +96,14 @@</span><br><span> <=
/span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* forward de=
cleration since tls_process needs this function prototype */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_session_buf_not_used(struct buffer =
*to_link, struct tls_session *session);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_k=
eystate_buf_not_used(struct buffer *to_link, const struct key_state *ks);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  =
* Limit the reneg_bytes value when using a small-block (&lt;128 bytes) ciph=
er=2E</span><br><span>  *</span><br><span>@@ -896,10 +904,15 @@</span><br><=
span>  *                       cleaned up=2E</span><br><span>  * @param cle=
ar        - Whether the memory allocated for the \a ks object</span><br><sp=
an>  *                       should be overwritten with 0s=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param to_link      - if not NULL, check that t=
he buffer does not contain</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *                       any pointer to one of the internal structs =
of ks</span><br><span>  */</span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state *ks, bool=
 clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_state_fr=
ee(struct key_state *ks, bool clear, struct buffer *to_link)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_keyst=
ate_buf_not_used(to_link, ks);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><span>=
 </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><s=
pan>@@ -1043,11 +1056,14 @@</span><br><span>  *                       objec=
t should be overwritten with 0s=2E This</span><br><span>  *                =
       implicitly sets many states to 0/false,</span><br><span>  *         =
              e=2Eg=2E the validity of the keys in the structure</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_link      - if no=
t NULL, check that the buffer does not contain</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *                       any pointer to one of t=
he internal structs of ks</span><br><span>  *</span><br><span>  */</span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-t=
ls_session_free(struct tls_session *session, bool clear)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+tls_session_free(struct tls_session *s=
ession, bool clear, struct buffer *to_link)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_not_used(t=
o_link, session);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_w=
rap);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap_reneg);<=
/span><br><span> </span><br><span>@@ -1056,7 +1072,7 @@</span><br><span>   =
      /* we don&#39;t need clear=3Dtrue for this call since</span><br><span=
>          * the structs are part of session and get cleared</span><br><spa=
n>          * as part of session */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        key_state_free(&amp;session-&gt;key[i], false);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_free(&a=
mp;session-&gt;key[i], false, to_link);</span><br><span>     }</span><br><s=
pan> </span><br><span>     free(session-&gt;common_name);</span><br><span>@=
@ -1075,14 +1091,16 @@</span><br><span> </span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-move_sess=
ion(struct tls_multi *multi, int dest, int src, bool reinit_src)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+move_session(struct tls_multi =
*multi, int dest, int src, bool reinit_src,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             struct buffer *to_link)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_sessi=
on_buf_not_used(to_link, &amp;multi-&gt;session[dest]);</span><br><span>   =
  msg(D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=3D%s reinit_s=
rc=3D%d&quot;,</span><br><span>         session_index_name(dest), session_i=
ndex_name(src), reinit_src);</span><br><span>     ASSERT(src !=3D dest);</s=
pan><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SIZE);</span=
><br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZE);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(&amp;mu=
lti-&gt;session[dest], false);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tls_session_free(&amp;multi-&gt;session[dest], false, to_lin=
k);</span><br><span>     multi-&gt;session[dest] =3D multi-&gt;session[src]=
;</span><br><span> </span><br><span>     if (reinit_src)</span><br><span>@@=
 -1098,9 +1116,9 @@</span><br><span> }</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reset_sessi=
on(struct tls_multi *multi, struct tls_session *session)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+reset_session(struct tls_multi *multi,=
 struct tls_session *session, struct buffer *to_link)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(ses=
sion, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tl=
s_session_free(session, false, to_link);</span><br><span>     tls_session_i=
nit(multi, session);</span><br><span> }</span><br><span> </span><br><span>@=
@ -1265,7 +1283,7 @@</span><br><span> </span><br><span>     for (int i =3D =
0; i &lt; TM_SIZE; ++i)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;session[i]=
, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tl=
s_session_free(&amp;multi-&gt;session[i], false, NULL);</span><br><span>   =
  }</span><br><span> </span><br><span>     if (clear)</span><br><span>@@ -1=
764,13 +1782,13 @@</span><br><span>  * active key=2E</span><br><span>  */</=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-key_state_soft_reset(struct tls_session *session)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls_session=
 *session, struct buffer *to_link)</span><br><span> {</span><br><span>     =
struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];        /* primar=
y key */</span><br><span>     struct key_state *ks_lame =3D &amp;session-&g=
t;key[KS_LAME_DUCK]; /* retiring key */</span><br><span> </span><br><span> =
    ks-&gt;must_die =3D now + session-&gt;opt-&gt;transition_window;    /* =
remaining lifetime of old key */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    key_state_free(ks_lame, false);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    key_state_free(ks_lame, false, to_link);</sp=
an><br><span>     *ks_lame =3D *ks;</span><br><span> </span><br><span>     =
key_state_init(session, ks);</span><br><span>@@ -1781,7 +1799,7 @@</span><b=
r><span> void</span><br><span> tls_session_soft_reset(struct tls_multi *tls=
_multi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    key_state_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_state_soft_reset(=
&amp;tls_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span> }</span><br>=
<span> </span><br><span> /*</span><br><span>@@ -3101,13 +3119,13 @@</span><=
br><span>             session-&gt;opt-&gt;aead_usage_limit,</span><br><span=
>             ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_bloc=
ks + ks-&gt;n_packets,</span><br><span>             session-&gt;opt-&gt;aea=
d_usage_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  key_state_soft_reset(session);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        key_state_soft_reset(session, to_link);</span><br><spa=
n>     }</span><br><span> </span><br><span>     /* Kill lame duck key trans=
ition_window seconds after primary key negotiation */</span><br><span>     =
if (lame_duck_must_die(session, wakeup))</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks_lame, t=
rue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_st=
ate_free(ks_lame, true, to_link);</span><br><span>         msg(D_TLS_DEBUG_=
LOW, &quot;TLS: tls_process: killed expiring key&quot;);</span><br><span>  =
   }</span><br><span> </span><br><span>@@ -3200,6 +3218,55 @@</span><br><sp=
an>     return false;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct buffer *t=
o_link, const struct key_state *ks)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
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
>@@ -3211,11 +3278,11 @@</span><br><span> static void</span><br><span> chec=
k_session_buf_not_used(struct buffer *to_link, struct tls_session *session)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!dataptr)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!to_link || !to_link-&gt;data)</span><br><sp=
an>     {</span><br><span>         return;</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =
=3D to_link-&gt;data;</span><br><span> </span><br><span>     /* Checks buff=
ers in tls_wrap */</span><br><span>     if (session-&gt;tls_wrap=2Ework=2Ed=
ata =3D=3D dataptr)</span><br><span>@@ -3234,41 +3301,7 @@</span><br><span>=
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
<br><span>@@ -3362,13 +3395,11 @@</span><br><span>                 if (i =
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
-3421,7 +3452,7 @@</span><br><span>      */</span><br><span>     if (lame_d=
uck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_se=
ssion_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt=
;session[TM_LAME_DUCK], true, to_link);</span><br><span>         msg(D_TLS_=
DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring key&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span>@@ -3436,8 +3467,7 @@</s=
pan><br><span>      */</span><br><span>     if (TLS_AUTHENTICATED(multi, &a=
mp;multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_session=
_buf_not_used(to_link, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        move_session(multi, TM_ACTIVE,=
 TM_INITIAL, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);</span><b=
r><span>         tas =3D tls_authentication_status(multi);</span><br><span>=
         msg(D_TLS_DEBUG_LOW,</span><br><span>             &quot;TLS: tls_m=
ulti_process: initial untrusted &quot;</span><br><span>@@ -3839,7 +3869,7 @=
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
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Yi9Z1nez0qs=--


--===============6917483707773103668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6917483707773103668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6917483707773103668==--


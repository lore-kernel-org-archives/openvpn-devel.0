Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2477DC624D4
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJdMqVBIMGAJdFjbWOP+PBd7OkOlCJWpw432rAL/ZVg=; b=ZSmSWoAJWx7XdSSGd2Cc56M21L
	0u36xP2BcXlDH7tcq6itAQCM3+EZ5vpplpk4YjG1zuRYgI9PRWLodiVyjdpOC3hs2Wx3u/89ilWG8
	p1OfJ4Ngu2Z/+8qdxPjRyAi7BGeIuQnX1F2DUQ+es2UrHbXP3KdkSoUAcf8piTSfFYEU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1psW-0007aZ-9h;
	Wed, 02 Sep 2026 18:40:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1ps8-0007ZM-M6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 18:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9d9cRbxnXpTXlgvMtU0TBljkKrHUze8NsrxWWRS2Bbs=; b=jBaLj2ZgAy4pJmUGASXF8L42Do
 c8t+LV2wq4wlcZmz1qdwkY/lW97LME9dDj7GlSv2CuHs1h5oG16ob87rTcKUT0lSkSrhA0OC2OqcN
 9unRmVQuALbrCwElE6+ll1zKIwikX+xzWvN8l6chun+8xkuQBYxIijpO759X2Rci9c0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9d9cRbxnXpTXlgvMtU0TBljkKrHUze8NsrxWWRS2Bbs=; b=a
 SpQ8i3GBQtIyBbOCHf9vA5xfsKEjDDMovjDMHorcoHPwSPn6+BSfOuguR4XymbdW3BNZnshJXXsor
 +VsWJOol4v3CRJnVfMIoEa7o4u6Ec47p1TwBosgVENyVJuPYdfJ9R4ul+3Uwo+NM67ioWphlyM6F1
 lkzIRDSja25vYp60=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1ps2-0005hx-MI for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 18:39:42 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495590dde14so15124055e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788374372; x=1788979172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9d9cRbxnXpTXlgvMtU0TBljkKrHUze8NsrxWWRS2Bbs=;
 b=AHOYivhr7Gb2nKqJIhwtsEyf2KYUHyyCds/r7SJePrhKxbsFVuzzuae6EUkAM+OO5P
 WyBCXLq1G502boeoOMcMAp/vRiEE+xRVgOz7N9n0Q+pjOCHwT954Y7avcknhYcWejUV2
 uWVp9+uJQilguD6/5slwNIxLLA2fRXMZRaWEDlMG9u2ddFJMVkGCEL4fpfEJIGnL++15
 ZE+2wxR5pIZhZDgtB21aLeSQ0DMs0I0ycCT7c0RQSXt5ZAW6/JFPW39vpGPE7quWq2Vd
 3rz+VsUeTNboTI1SiKNabp76mJC5ZhtGvI71AFQm61PxIsJDLEV+7+HIc8BoIRxqCXKO
 vAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788374372; x=1788979172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9d9cRbxnXpTXlgvMtU0TBljkKrHUze8NsrxWWRS2Bbs=;
 b=T7sj/x0hlikWWdOoSYicuzpa2fn2RWejmAmTkPSAINCS7K9nZo89BdzcMARTaxFUJp
 iHK4WhYuYH8tfYxhuf/eYCfRC6pWrW5ZgBBJv0uIt0aNZfOGwBJIfZYWNialFYpNRRn+
 S1jydRIz9rb44mmG/JKQjCKg8eL0cgpUzDGZXIpgPwAzF6HhQLbKEZLFeflQ9JFkDkVe
 2cpr8UK4e+eB70P0Alu3Tb6CONrpRIyRk/uQYEmi+NHG7VF01sZNAnw8fY0NrnGUYXVE
 aJjwIt+pjvqZPE5KwhljYEUgwpla5felgO+7M0KSSRVDXzTyUExFW6hvp8YKR4W7ZwF0
 r5MA==
X-Gm-Message-State: AFuF++nvGPmUeRt7KioTiwhTCSp+exTqpCKV0luI6obVtItjV84sMRkE
 eMhhN1zQgbWM3PAaqaqwmh7MA1JxBrxvi8+riBRBQy7hlkDeVAUicgc45aTXy9605E9Afkdubz7
 hgT26S2QmXxKsOT7CYstYe5UCYjzPlI/H8Gl+Ew1fxof97OpkV/4vXrLqdH+OnrUYNHSX
X-Gm-Gg: AYBFou18+xO7WSkScCnSit7Gn02SbiTET96BV2ePwmZZqgZfDd6LpWJBIyDVYeu77hO
 wbbyOfGxMjenDeBNMomJstLNhZe6vVgkQ8CQBlNrqK2s1oznOgIa54uCxieD4toTxNXMw0TUk+7
 tZKYtMKLqFhWHhLCHeL5SwUDGadSLDn8q0eWQL/gfYtL1jEirsnN+lfzPiuVluUYj8HTFVSgCud
 HFM+j52VDc6uvpwgvXIIXRy71OqomsKRVAGJxBfGGFMra/zz9YC8Fh2BLqdN67qGhj8GWO1G4cy
 v0u4SmrcSvJZ862sb0oLY78nvOHHZoyIU06qjRA04jOm0upUbiwqm/JiAYljDgmrskKDGywQWD/
 ZROEduFC62DX43uUT3n5K5FNlYDBIBpDs0hs695Vhm4jw+bcYWKZ10XbBulgBPlGs0wBwW0fgdf
 GIqPL0yyWQf2DJ+17hHIxCY4JXNnpDVPHOpuXLLF/SPaVfj5gndPSpv9kGunVwMqgxLa86UZOkn
 ikq/YdvSdeUYdEkpnoKX2/HVc0CH+Z+iW5T0K3WnHLhBG2ybzpGDc9PsSTNH1DNBnNDn5wsk8tG
 VSM3CtJu/010XAjsn9XbVDAFCnk+qs+SiaZZ/irna1oxzS5d4X0=
X-Received: by 2002:a05:600c:6290:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-49ce55d0fbamr148152085e9.0.1788374371784; 
 Wed, 02 Sep 2026 11:39:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492ce236sm9270407f8f.35.2026.09.02.11.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:39:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 18:39:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1893
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1893?usp=email>
X-Gerrit-Commit: 76fb884d03d459ca4cbfd5771c41320e52acc104
In-Reply-To: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MzY4NjE4MDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7556d38a943d7111cea80aa2d872cae11a2b75ba-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1ps2-0005hx-MI
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
Content-Type: multipart/mixed; boundary="===============8989081203584189516=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8989081203584189516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jB79OPxFtK8="; charset=UTF-8

--jB79OPxFtK8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

Hello MaxF, plais=
thos, 

I'd like you to reexamine a change=2E Please visit

    http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1893?usp=3Demail

to look at the new patch s=
et (#3)=2E


Change subject: Move check_session_buf_not_used method into th=
e method that free the buffer
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
Github: openvpn/=
openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda University)
Gi=
thub: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f714803604d76c=
6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-b=
y: MaxF <max@max-fillinger=2Enet>
---
M src/openvpn/ssl=2Ec
1 file changed,=
 88 insertions(+), 58 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/93/1893/3

diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec
index 5f5d1f9=2E=2E71459ee 100644
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
@@ -1043,11 +1056,14 @@
  *                    =
   object should be overwritten with 0s=2E This
  *                       i=
mplicitly sets many states to 0/false,
  *                       e=2Eg=2E t=
he validity of the keys in the structure
+ * @param to_link      - if not N=
ULL, check that the buffer does not contain
+ *                       any p=
ointer to one of the internal structs of ks
  *
  */
 static void
-tls_sess=
ion_free(struct tls_session *session, bool clear)
+tls_session_free(struct =
tls_session *session, bool clear, struct buffer *to_link)
 {
+    check_ses=
sion_buf_not_used(to_link, session);
     tls_wrap_free(&session->tls_wrap)=
;
     tls_wrap_free(&session->tls_wrap_reneg);
 
@@ -1056,7 +1072,7 @@
   =
      /* we don't need clear=3Dtrue for this call since
          * the str=
ucts are part of session and get cleared
          * as part of session */
=
-        key_state_free(&session->key[i], false);
+        key_state_free(&=
session->key[i], false, to_link);
     }
 
     free(session->common_name);=

@@ -1075,14 +1091,16 @@
 
 
 static void
-move_session(struct tls_multi *m=
ulti, int dest, int src, bool reinit_src)
+move_session(struct tls_multi *m=
ulti, int dest, int src, bool reinit_src,
+             struct buffer *to_l=
ink)
 {
+    check_session_buf_not_used(to_link, &multi->session[dest]);
  =
   msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=3D%s src=3D%s reinit_src=
=3D%d",
         session_index_name(dest), session_index_name(src), reinit_=
src);
     ASSERT(src !=3D dest);
     ASSERT(src >=3D 0 && src < TM_SIZE);=

     ASSERT(dest >=3D 0 && dest < TM_SIZE);
-    tls_session_free(&multi->=
session[dest], false);
+    tls_session_free(&multi->session[dest], false, =
to_link);
     multi->session[dest] =3D multi->session[src];
 
     if (rei=
nit_src)
@@ -1098,9 +1116,9 @@
 }
 
 static void
-reset_session(struct tls_=
multi *multi, struct tls_session *session)
+reset_session(struct tls_multi =
*multi, struct tls_session *session, struct buffer *to_link)
 {
-    tls_se=
ssion_free(session, false);
+    tls_session_free(session, false, to_link);=

     tls_session_init(multi, session);
 }
 
@@ -1265,7 +1283,7 @@
 
     f=
or (int i =3D 0; i < TM_SIZE; ++i)
     {
-        tls_session_free(&multi-=
>session[i], false);
+        tls_session_free(&multi->session[i], false, N=
ULL);
     }
 
     if (clear)
@@ -1764,13 +1782,13 @@
  * active key=2E
  =
*/
 static void
-key_state_soft_reset(struct tls_session *session)
+key_sta=
te_soft_reset(struct tls_session *session, struct buffer *to_link)
 {
     =
struct key_state *ks =3D &session->key[KS_PRIMARY];        /* primary key *=
/
     struct key_state *ks_lame =3D &session->key[KS_LAME_DUCK]; /* retiri=
ng key */
 
     ks->must_die =3D now + session->opt->transition_window;   =
 /* remaining lifetime of old key */
-    key_state_free(ks_lame, false);
+=
    key_state_free(ks_lame, false, to_link);
     *ks_lame =3D *ks;
 
     =
key_state_init(session, ks);
@@ -1781,7 +1799,7 @@
 void
 tls_session_soft_=
reset(struct tls_multi *tls_multi)
 {
-    key_state_soft_reset(&tls_multi-=
>session[TM_ACTIVE]);
+    key_state_soft_reset(&tls_multi->session[TM_ACTI=
VE], NULL);
 }
 
 /*
@@ -3101,13 +3119,13 @@
             session->opt->aea=
d_usage_limit,
             ks->crypto_options=2Ekey_ctx_bi=2Edecrypt=2Epla=
intext_blocks + ks->n_packets,
             session->opt->aead_usage_limit)=
;
-        key_state_soft_reset(session);
+        key_state_soft_reset(ses=
sion, to_link);
     }
 
     /* Kill lame duck key transition_window secon=
ds after primary key negotiation */
     if (lame_duck_must_die(session, wa=
keup))
     {
-        key_state_free(ks_lame, true);
+        key_state_fr=
ee(ks_lame, true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process=
: killed expiring key");
     }
 
@@ -3200,6 +3218,55 @@
     return false;=

 }
 
+static void
+check_keystate_buf_not_used(struct buffer *to_link, con=
st struct key_state *ks)
+{
+    if (ks->state =3D=3D S_UNDEF || !to_link |=
| !to_link->data)
+    {
+        return;
+    }
+
+    uint8_t *dataptr =
=3D to_link->data;
+
+    /* we don't expect send_reliable to be NULL when =
state is
+     * not S_UNDEF, but people have reported crashes nonetheless,=

+     * therefore we better catch this event, report and exit=2E
+     */
=
+    if (!ks->send_reliable)
+    {
+        msg(M_FATAL,
+            "ERR=
OR: ks=2Esend_reliable (key-id %d), is NULL "
+            "while key state=
 is %s=2E Exiting=2E",
+            ks->key_id, state_name(ks->state));
+  =
  }
+
+    for (int j =3D 0; j < ks->send_reliable->size; j++)
+    {
+    =
    if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D dataptr)
+        {=

+            msg(M_INFO,
+                "Warning buffer of freed TLS ses=
sion is still in"
+                " use (key-id %d, ks=2Esend_reliable->ar=
ray[%d])",
+                ks->key_id, j);
+
+            goto used;
+    =
    }
+    }
+
+    if (ks->ack_write_buf=2Edata =3D=3D dataptr)
+    {
+  =
      msg(M_INFO, "Warning buffer of freed TLS session is still in use "
+ =
                   "(ks=2Eack_write_buf, key-id %d)",
+            ks->key_=
id);
+
+        goto used;
+    }
+    return;
+
+used:
+    to_link->len =
=3D 0;
+    to_link->data =3D 0;
+}
 
 /**
  * This is a safe guard functio=
n to double check that a buffer from a session is
@@ -3211,11 +3278,11 @@
 =
static void
 check_session_buf_not_used(struct buffer *to_link, struct tls_=
session *session)
 {
-    const uint8_t *dataptr =3D to_link->data;
-    if=
 (!dataptr)
+    if (!to_link || !to_link->data)
     {
         return;
  =
   }
+    const uint8_t *dataptr =3D to_link->data;
 
     /* Checks buffer=
s in tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=3D dataptr)
@=
@ -3234,41 +3301,7 @@
     for (int i =3D 0; i < KS_SIZE; i++)
     {
     =
    const struct key_state *ks =3D &session->key[i];
-        if (ks->state=
 =3D=3D S_UNDEF)
-        {
-            continue;
-        }
-
-        /*=
 we don't expect send_reliable to be NULL when state is
-         * not S_U=
NDEF, but people have reported crashes nonetheless,
-         * therefore w=
e better catch this event, report and exit=2E
-         */
-        if (!ks=
->send_reliable)
-        {
-            msg(M_FATAL,
-                "ERR=
OR: session->key[%d]->send_reliable is NULL "
-                "while key s=
tate is %s=2E Exiting=2E",
-                i, state_name(ks->state));
-   =
     }
-
-        for (int j =3D 0; j < ks->send_reliable->size; j++)
-    =
    {
-            if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D data=
ptr)
-            {
-                msg(M_INFO,
-                    "Warn=
ing buffer of freed TLS session is still in"
-                    " use (se=
ssion->key[%d]=2Esend_reliable->array[%d])",
-                    i, j);
-
=
-                goto used;
-            }
-        }
-        if (ks->ack_=
write_buf=2Edata =3D=3D dataptr)
-        {
-            msg(M_INFO, "Warni=
ng buffer of freed TLS session is still in use (session->key[%d]=2Eack_writ=
e_buf)", i);
-
-            goto used;
-        }
+        check_keystate_b=
uf_not_used(to_link, ks);
     }
     return;
 
@@ -3362,13 +3395,11 @@
   =
              if (i =3D=3D TM_ACTIVE && ks_lame->state >=3D S_GENERATED_KEY=
S
                     && !multi->opt=2Esingle_session)
                 {
=
-                    check_session_buf_not_used(to_link, session);
-       =
             move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+         =
           move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
   =
              }
                 else
                 {
-                 =
   check_session_buf_not_used(to_link, session);
-                    reset=
_session(multi, session);
+                    reset_session(multi, session=
, to_link);
                 }
             }
         }
@@ -3421,7 +3452,7=
 @@
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], wak=
eup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], true)=
;
+        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link);
=
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring key"=
);
     }
 
@@ -3436,8 +3467,7 @@
      */
     if (TLS_AUTHENTICATED(multi=
, &multi->session[TM_INITIAL]=2Ekey[KS_PRIMARY]))
     {
-        check_ses=
sion_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        move_sessi=
on(multi, TM_ACTIVE, TM_INITIAL, true);
+        move_session(multi, TM_ACT=
IVE, TM_INITIAL, true, to_link);
         tas =3D tls_authentication_status=
(multi);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tls_multi_process=
: initial untrusted "
@@ -3839,7 +3869,7 @@
                 goto error;
  =
           }
 
-            key_state_soft_reset(session);
+            key=
_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_DEBUG, "TLS: re=
ceived P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s", i,
                  sessi=
on_id_print(&sid, &gc));

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1893?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Change-Number: 189=
3
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: MaxF <max@max-fillinger=2Enet>

--jB79OPxFtK8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>cron2 <strong>uploaded pat=
ch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1893?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Mov=
e check_session_buf_not_used method into the method that free the buffer<br=
><br>This cleans the code up a bit and ensure that we do not miss an invoca=
tion<br>of a problematic code path=2E This is still a band-aid fix and a re=
al fix<br>requires more refactoring and changing the logic=2E<br><br>v2: sp=
rinkle some &quot;const&quot; over check_keystate_buf_not_used() args<br>v3=
: add missing doxygen for to_link parameter to tls_session_free()<br><br>CV=
E: 2026-84471<br>Reported-By: Andreas Gabriel Berbescu &lt;aberbescu@gmail=
=2Ecom&gt;<br>Github: openvpn/openvpn-private-issues#157<br>Reported-By: Ha=
ruki Oyama (Waseda University)<br>Github: openvpn/openvpn-private-issues#13=
2<br>Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d<br>Signed-off-by:=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fill=
inger=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 88 inser=
tions(+), 58 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1893/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1f9=2E=
=2E71459ee 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -96,6 +96,14 @@</span><br><sp=
an> </span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* forwa=
rd decleration since tls_process needs this function prototype */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+check_session_buf_not_used(struct buf=
fer *to_link, struct tls_session *session);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+che=
ck_keystate_buf_not_used(struct buffer *to_link, const struct key_state *ks=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><spa=
n>  * Limit the reneg_bytes value when using a small-block (&lt;128 bytes) =
cipher=2E</span><br><span>  *</span><br><span>@@ -896,10 +904,15 @@</span><=
br><span>  *                       cleaned up=2E</span><br><span>  * @param=
 clear        - Whether the memory allocated for the \a ks object</span><br=
><span>  *                       should be overwritten with 0s=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param to_link      - if not NULL, check th=
at the buffer does not contain</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *                       any pointer to one of the internal stru=
cts of ks</span><br><span>  */</span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state *ks, =
bool clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_stat=
e_free(struct key_state *ks, bool clear, struct buffer *to_link)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_k=
eystate_buf_not_used(to_link, ks);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><s=
pan> </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><b=
r><span>@@ -1043,11 +1056,14 @@</span><br><span>  *                       o=
bject should be overwritten with 0s=2E This</span><br><span>  *            =
           implicitly sets many states to 0/false,</span><br><span>  *     =
                  e=2Eg=2E the validity of the keys in the structure</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_link      - i=
f not NULL, check that the buffer does not contain</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *                       any pointer to one =
of the internal structs of ks</span><br><span>  *</span><br><span>  */</spa=
n><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-tls_session_free(struct tls_session *session, bool clear)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+tls_session_free(struct tls_sessio=
n *session, bool clear, struct buffer *to_link)</span><br><span> {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_not_us=
ed(to_link, session);</span><br><span>     tls_wrap_free(&amp;session-&gt;t=
ls_wrap);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap_rene=
g);</span><br><span> </span><br><span>@@ -1056,7 +1072,7 @@</span><br><span=
>         /* we don&#39;t need clear=3Dtrue for this call since</span><br><=
span>          * the structs are part of session and get cleared</span><br>=
<span>          * as part of session */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        key_state_free(&amp;session-&gt;key[i], false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_fre=
e(&amp;session-&gt;key[i], false, to_link);</span><br><span>     }</span><b=
r><span> </span><br><span>     free(session-&gt;common_name);</span><br><sp=
an>@@ -1075,14 +1091,16 @@</span><br><span> </span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-move_=
session(struct tls_multi *multi, int dest, int src, bool reinit_src)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+move_session(struct tls_mu=
lti *multi, int dest, int src, bool reinit_src,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             struct buffer *to_link)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_s=
ession_buf_not_used(to_link, &amp;multi-&gt;session[dest]);</span><br><span=
>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=3D%s rein=
it_src=3D%d&quot;,</span><br><span>         session_index_name(dest), sessi=
on_index_name(src), reinit_src);</span><br><span>     ASSERT(src !=3D dest)=
;</span><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SIZE);</=
span><br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZE);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free(&am=
p;multi-&gt;session[dest], false);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    tls_session_free(&amp;multi-&gt;session[dest], false, to=
_link);</span><br><span>     multi-&gt;session[dest] =3D multi-&gt;session[=
src];</span><br><span> </span><br><span>     if (reinit_src)</span><br><spa=
n>@@ -1098,9 +1116,9 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reset_s=
ession(struct tls_multi *multi, struct tls_session *session)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+reset_session(struct tls_multi *mu=
lti, struct tls_session *session, struct buffer *to_link)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_free=
(session, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  tls_session_free(session, false, to_link);</span><br><span>     tls_sessi=
on_init(multi, session);</span><br><span> }</span><br><span> </span><br><sp=
an>@@ -1265,7 +1283,7 @@</span><br><span> </span><br><span>     for (int i =
=3D 0; i &lt; TM_SIZE; ++i)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;sessio=
n[i], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tls_session_free(&amp;multi-&gt;session[i], false, NULL);</span><br><span=
>     }</span><br><span> </span><br><span>     if (clear)</span><br><span>@=
@ -1764,13 +1782,13 @@</span><br><span>  * active key=2E</span><br><span>  =
*/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-key_state_soft_reset(struct tls_session *session)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls_ses=
sion *session, struct buffer *to_link)</span><br><span> {</span><br><span> =
    struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];        /* pr=
imary key */</span><br><span>     struct key_state *ks_lame =3D &amp;sessio=
n-&gt;key[KS_LAME_DUCK]; /* retiring key */</span><br><span> </span><br><sp=
an>     ks-&gt;must_die =3D now + session-&gt;opt-&gt;transition_window;   =
 /* remaining lifetime of old key */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    key_state_free(ks_lame, false);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    key_state_free(ks_lame, false, to_link);=
</span><br><span>     *ks_lame =3D *ks;</span><br><span> </span><br><span> =
    key_state_init(session, ks);</span><br><span>@@ -1781,7 +1799,7 @@</spa=
n><br><span> void</span><br><span> tls_session_soft_reset(struct tls_multi =
*tls_multi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    key_state_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_state_soft_re=
set(&amp;tls_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span> }</span>=
<br><span> </span><br><span> /*</span><br><span>@@ -3101,13 +3119,13 @@</sp=
an><br><span>             session-&gt;opt-&gt;aead_usage_limit,</span><br><=
span>             ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_=
blocks + ks-&gt;n_packets,</span><br><span>             session-&gt;opt-&gt=
;aead_usage_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      key_state_soft_reset(session);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        key_state_soft_reset(session, to_link);</span><br>=
<span>     }</span><br><span> </span><br><span>     /* Kill lame duck key t=
ransition_window seconds after primary key negotiation */</span><br><span> =
    if (lame_duck_must_die(session, wakeup))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks_lam=
e, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ke=
y_state_free(ks_lame, true, to_link);</span><br><span>         msg(D_TLS_DE=
BUG_LOW, &quot;TLS: tls_process: killed expiring key&quot;);</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -3200,6 +3218,55 @@</span><br=
><span>     return false;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct buffe=
r *to_link, const struct key_state *ks)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
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
%);">+                    &quot;(ks=2Eack_write_buf, key-id %d)&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;key_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto used;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+us=
ed:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;=
len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_li=
nk-&gt;data =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span> </span><br><span> /**</span><br><span>  * This is a safe =
guard function to double check that a buffer from a session is</span><br><s=
pan>@@ -3211,11 +3278,11 @@</span><br><span> static void</span><br><span> c=
heck_session_buf_not_used(struct buffer *to_link, struct tls_session *sessi=
on)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!dataptr)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!to_link || !to_link-&gt;data)</span><br>=
<span>     {</span><br><span>         return;</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr=
 =3D to_link-&gt;data;</span><br><span> </span><br><span>     /* Checks buf=
fers in tls_wrap */</span><br><span>     if (session-&gt;tls_wrap=2Ework=2E=
data =3D=3D dataptr)</span><br><span>@@ -3234,41 +3301,7 @@</span><br><span=
>     for (int i =3D 0; i &lt; KS_SIZE; i++)</span><br><span>     {</span><=
br><span>         const struct key_state *ks =3D &amp;session-&gt;key[i];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;stat=
e =3D=3D S_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cont=
inue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* we don&#39;t expect send_reliable to b=
e NULL when state is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * not S_UNDEF, but people have reported crashes nonetheless,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         * therefore we bett=
er catch this event, report and exit=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (!ks-&gt;send_reliable)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;ERROR: session-&gt;key[%d]-&gt;send_relia=
ble is NULL &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             &quot;while key state is %s=2E Exiting=2E&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                i, state_name(ks-&g=
t;state));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
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
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@m=
ax-fillinger=2Enet&gt; </div>

</body></html>
--jB79OPxFtK8=--


--===============8989081203584189516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8989081203584189516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8989081203584189516==--


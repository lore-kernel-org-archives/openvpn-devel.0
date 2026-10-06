Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D6ECA6009
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Jh31L3I4nExhj9uT7cgn6Qt0MAgwga4o0BN2noAItTo=; b=SCkLYGDIiGwZto
	ta5HKnEUOAyF06z0jqZyh7thNhEiezy4gP46bBIKyc0vFrUw/UavlCjjgEo7DoFNjcO7xjeSQa7s4
	wpI6H1+WVFT3cAqx7WbNme22mAkBHp7hyzWIAnEVGtbq4YWRoOkpYMj2qZov3VfyIlpto0Ltywdgl
	alg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE9jh-0005TS-KV;
	Tue, 06 Oct 2026 18:17:55 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE9jg-0005TM-0g
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 18:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I3GgE+3SbyASkxi3cMHMAzMKvd/H46LsTIrTXm+4Klo=; b=PSVr9LJ/EmL0uLVTs6TrtVrRU1
 ezqMedm3zMKemDkxcjkWbka5f5pov+XYz85DI84C1KBLBIsLO3J37l6bEHg2pLgVGIMVPCkb+/Cd8
 +c4jTLEW4CXQJXW9gFYHXfJTALitGp3jfRV7COUHRADyYHb0dwmpBG3bcQHhDGdABNxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I3GgE+3SbyASkxi3cMHMAzMKvd/H46LsTIrTXm+4Klo=; b=R
 J5iYCspSyC+LzN4xbLDLgG66yg16nCyZovJh8HuCn2Ov66VYTTtMciJjZXfHl8EPPSxnQz/avU0nj
 whM1dgjZ5P0K8PXoWnQiscIfXM6T2mVhKTdpkzsf8OKbEC4X8vJe3RdCOgAlMaf/n6lgpzesXtqld
 cC0fKNMdfgvGI3xE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE9jb-0005P6-0K for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 18:17:53 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so18455095e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791310664; x=1791915464; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I3GgE+3SbyASkxi3cMHMAzMKvd/H46LsTIrTXm+4Klo=;
 b=aBraDTZSuGDuk07A4zfDUE4ktDp4fL6IhRreli/BIBwj8aE6hTpnxpy4Uo5omTGzPt
 mT+hvpzPelIh5+VDht0mP4O15cPkhNuisAHRdgC7UVhaY/bCQEGQGcnCudcDs7Hy94xG
 E7bbtE6lFokmW75l0dYoB2DPHVxjVqaV4f1Kobrg+2NMtk11Lj1HXpX0AKRsItLI3lar
 2MRGT2fss0M5YPylVDNmV7y+qA8oIi5thnLsd45JgrwLnMeGg63NvZHWFFJhFWWsGD/f
 yGirNL1+hDpc7BN2LD+h/PypexRtFZ90bjNF6EovSZ0X5lxRGViNMVfzJHdRH6do2eO4
 1s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310664; x=1791915464;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I3GgE+3SbyASkxi3cMHMAzMKvd/H46LsTIrTXm+4Klo=;
 b=uh2YlievsweKK1Vn/5aPTLpGbB9rKa70e6WSQS2fWXWXM3JU0d6LvftTjnCF9C5wth
 a5Ayhjheo0M9tjLKbvzigmktqL/ygJOMlnoIXPNQAoA2cNHHOlrckqj7c/s0fnONQ0Rp
 QCeCFmwQjUhDD+XDPPIaNB7zA/fbJ35feaWZDPie9csbcMZFTRzZGnG5A+mR1PxY1WiF
 77Jeq2LE22EmLy16bCbjXKssUA4JfaP1yhesSxGucwS36s72P+ZEUI9XyOOfVtPFYKWs
 Gc/jZUNL9EB83v8NjleZu63n0LB+CMS7RQb5P2cT2ZMXLsrZcnbCgeLqfpTmFPvNsH76
 czPQ==
X-Gm-Message-State: AFuF++kneTrV68I4rr8nWEiDJw0+VsTGou9I5MR4v1bOKkY+aQHYgvW0
 Y3VFFvXhHSX2kuBr8W4Nn/LP4XwkuAPv9pAxK9v9b3GSGA83JXVtvj3mKbHIZBRPP6pRI/NxyMb
 SfDKfohU2gTymQawiGWIjaz1mLYt3YkBWHR1ipSmgY/p+BWWtsMvGJe1/aA2atLobIGhPCml8om
 +E1tWNMg==
X-Gm-Gg: AYBFou1OcrL1hFvOwjRboPMUb4ZrAgwAWTRTiZuOlPhJqLuuUbDeIwClGuvF9wb4jYW
 BRsbhMoOAhHiMEYmJ3pmcFuHQUhXd1Gtkcq3ek7K0JMRnO3ta6uVIFoNwGLFlPqnE0iRbGKET0v
 jAI70+Zb8Lw3cyHebpYHamIbEM5GQyhHXM3DbDA2ss+I41R8290o0/eAEoamKkZZeYNAhz8v+Rr
 tuULz2eEtuaf2dUNPR8D/ubpZdGyXcVsPE09/KCGoLzbN07zmCeV6Nm1oh5KLdWSdPlL+Gn2CLh
 Ce5cGE2Olz+tT+UD13EIgeUEmQpnPfkKasbwvctg44WJGN8kJQjlwYS4atoL8IIcJ1E89albV/i
 fr+g2HliKseGKuCdrHl9sBdgOxWPAtBIUmUQ95Wn8vjwhdORAjujZMEV/1QiMMiLTGEAeFw+rYw
 m6uchEdGbSNjwUvGpYflB0hhc/YXxlub9hkNzYcIMuwlPH6LZrdTlbfBb9bm9ip0/VG5U/+pwU8
 nRN0U8lrl7agk+CxbawfoeXYCzmM+S2EJ+eiFHf5IR0ink3W06isQx41UehWZ8WJpAJeCn52DBa
 CfW9KCIPoTH2UAdLSc/mZLrZ07zP+WEWDZs6EkiBxNmGWV0wXFhWpoCUCcI9
X-Received: by 2002:a05:600c:4f54:b0:4a1:7701:f863 with SMTP id
 5b1f17b1804b1-4a17b548f39mr38756555e9.15.1791310663879; 
 Tue, 06 Oct 2026 11:17:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c7202fa0bsm686871f8f.3.2026.10.06.11.17.43
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:17:43 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 18:17:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 839053fc589d76782e799c427b5f9cce59aa2221
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a1995a46b84fe1935b951ba8fd4ba12e73b35645-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE9jb-0005P6-0K
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6369415702807819147=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6369415702807819147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ti663OmBaDc="; charset=UTF-8

--Ti663OmBaDc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

MaxF has uploaded this change for review=2E ( https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1985?usp=3Demail )


Change subject: Move check_session_buf_n=
ot_used method into the method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move check_session_buf_not_used me=
thod into the method that free the buffer

This cleans the code up a bit an=
d ensure that we do not miss an invocation
of a problematic code path=2E Th=
is is still a band-aid fix and a real fix
requires more refactoring and cha=
nging the logic=2E

v2: sprinkle some "const" over check_keystate_buf_not_u=
sed() args
v3: add missing doxygen for to_link parameter to tls_session_fre=
e()

CVE: 2026-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gmail=
=2Ecom>
Tested-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Github:=
 openvpn/openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda Unive=
rsity)
Github: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f7148=
03604d76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893
Acked-by: Max=
F <max@max-fillinger=2Enet>
Message-Id: <20260903061209=2E12599-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38913=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
(cherry picked from commit 2a881d737b2562ee28247148160cfb60=
f0ba4645)
---
M src/openvpn/ssl=2Ec
1 file changed, 102 insertions(+), 63 d=
eletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/85/1985/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
in=
dex 9b6cfa0=2E=2Ecedefa2 100644
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
@@ -2125,13 +2149,13 @@
  * active key=2E
  */
 static void
-key_state_=
soft_reset(struct tls_session *session)
+key_state_soft_reset(struct tls_se=
ssion *session, struct buffer *to_link)
 {
     struct key_state *ks =3D &s=
ession->key[KS_PRIMARY];      /* primary key */
     struct key_state *ks_l=
ame =3D &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die=
 =3D now + session->opt->transition_window; /* remaining lifetime of old ke=
y */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, fals=
e, to_link);
     *ks_lame =3D *ks;
 
     key_state_init(session, ks);
@@ =
-2249,7 +2273,7 @@
          * push request, also signal that the client wa=
nts
          * to get push-reply messages without without requiring a roun=
d
          * trip for a push request message*/
-        if(session->opt->p=
ull)
+        if (session->opt->pull)
         {
             iv_proto |=3D=
 IV_PROTO_REQUEST_PUSH;
         }
@@ -2426,7 +2450,7 @@
      * NCP option=
s are processed and we have no extra state for NCP finished=2E
      */
   =
  if (session->opt->server && (session->opt->mode !=3D MODE_SERVER
-       =
     || multi->multi_state =3D=3D CAS_SUCCEEDED))
+                        =
         || multi->multi_state =3D=3D CAS_SUCCEEDED))
     {
         if (k=
s->authenticated > KS_AUTH_FALSE)
         {
@@ -2679,13 +2703,13 @@
      =
       (int) (now - ks->established), session->opt->renegotiate_seconds,
  =
           ks->n_bytes, session->opt->renegotiate_bytes,
             ks->n=
_packets, session->opt->renegotiate_packets);
-        key_state_soft_reset=
(session);
+        key_state_soft_reset(session, to_link);
     }
 
     /=
* Kill lame duck key transition_window seconds after primary key negotiatio=
n */
     if (lame_duck_must_die(session, wakeup))
     {
-        key_stat=
e_free(ks_lame, true);
+        key_state_free(ks_lame, true, to_link);
   =
      msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }=

 
@@ -3009,6 +3033,56 @@
     return false;
 }
 
+static void
+check_keyst=
ate_buf_not_used(struct buffer *to_link, const struct key_state *ks)
+{
+  =
  if (ks->state =3D=3D S_UNDEF || !to_link || !to_link->data)
+    {
+     =
   return;
+    }
+
+    uint8_t *dataptr =3D to_link->data;
+
+    /* we d=
on't expect send_reliable to be NULL when state is
+     * not S_UNDEF, but=
 people have reported crashes nonetheless,
+     * therefore we better catc=
h this event, report and exit=2E
+     */
+    if (!ks->send_reliable)
+   =
 {
+        msg(M_FATAL,
+            "ERROR: ks=2Esend_reliable (key-id %d=
), is NULL "
+            "while key state is %s=2E Exiting=2E",
+         =
   ks->key_id, state_name(ks->state));
+    }
+
+    for (int j =3D 0; j < =
ks->send_reliable->size; j++)
+    {
+        if (ks->send_reliable->array[=
j]=2Ebuf=2Edata =3D=3D dataptr)
+        {
+            msg(M_INFO,
+      =
          "Warning buffer of freed TLS session is still in"
+              =
  " use (key-id %d, ks=2Esend_reliable->array[%d])",
+                ks->k=
ey_id, j);
+
+            goto used;
+        }
+    }
+
+    if (ks->ack_w=
rite_buf=2Edata =3D=3D dataptr)
+    {
+        msg(M_INFO, "Warning buffer=
 of freed TLS session is still in use "
+            "(ks=2Eack_write_buf, =
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
+
 /**=

  * This is a safe guard function to double check that a buffer from a ses=
sion is
  * not used in a session to avoid a use after free=2E
@@ -3019,58 =
+3093,24 @@
 static void
 check_session_buf_not_used(struct buffer *to_link=
, struct tls_session *session)
 {
-    uint8_t *dataptr =3D to_link->data;
=
-    if (!dataptr)
+    if (!to_link || !to_link->data)
     {
         ret=
urn;
     }
+    const uint8_t *dataptr =3D to_link->data;
 
     /* Checks=
 buffers in tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=3D dat=
aptr)
     {
         msg(M_INFO, "Warning buffer of freed TLS session is "=

-                    "still in use (tls_wrap=2Ework=2Edata)");
+          =
  "still in use (tls_wrap=2Ework=2Edata)");
         goto used;
     }
 
  =
   for (int i =3D 0; i < KS_SIZE; i++)
     {
-        struct key_state *ks=
 =3D &session->key[i];
-        if (ks->state =3D=3D S_UNDEF)
-        {
- =
           continue;
-        }
-
-        /* we don't expect send_reliable=
 to be NULL when state is
-         * not S_UNDEF, but people have reported=
 crashes nonetheless,
-         * therefore we better catch this event, rep=
ort and exit=2E
-         */
-        if (!ks->send_reliable)
-        {
- =
           msg(M_FATAL,
-                "ERROR: session->key[%d]->send_rel=
iable is NULL "
-                "while key state is %s=2E Exiting=2E",
-  =
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
 
@@ -3206,9 +3244,10 @@
      */
     if (DECRYPT_KEY_ENABLED(=
multi, &multi->session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))
     {
-        ch=
eck_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        mov=
e_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
-        msg(D_TLS_DEBUG_L=
OW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
+   =
     move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true, to_link);
+        =
tas =3D tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
+=
        msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: initial untrusted "
+=
            "session promoted to %strusted",
             tas =3D=3D TLS_AU=
THENTICATION_SUCCEEDED ? "" : "semi-");
     }
 
@@ -3622,7 +3661,7 @@
    =
             goto error;
             }
 
-            key_state_soft_reset=
(session);
+            key_state_soft_reset(session, NULL);
 
            =
 dmsg(D_TLS_DEBUG,
                  "TLS: received P_CONTROL_SOFT_RESET_V1=
 s=3D%d sid=3D%s",

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1985?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Ch=
ange-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Change-Number: 19=
85
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-C=
C: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--Ti663OmBaDc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>MaxF has uploaded=
 this change for <strong>review</strong>=2E</p><p><a href=3D"https://gerrit=
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
0ba4645)<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 102 insertions(=
+), 63 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/85/1985/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 9b6cfa0=2E=2Ecedef=
a2 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl=2Ec</span><br><span>@@ -93,6 +93,14 @@</span><br><span> </sp=
an><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* forward decle=
ration since tls_process needs this function prototype */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+check_session_buf_not_used(struct buffer *to_=
link, struct tls_session *session);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_keyst=
ate_buf_not_used(struct buffer *to_link, const struct key_state *ks);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * SS=
L/TLS Cipher suite name translation table</span><br><span>  */</span><br><s=
pan>@@ -989,10 +997,15 @@</span><br><span>  *                       cleaned=
 up=2E</span><br><span>  * @param clear        - Whether the memory allocat=
ed for the \a ks object</span><br><span>  *                       should be=
 overwritten with 0s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_=
link      - if not NULL, check that the buffer does not contain</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *                       any po=
inter to one of the internal structs of ks</span><br><span>  */</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_=
state_free(struct key_state *ks, bool clear)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+key_state_free(struct key_state *ks, bool clear, s=
truct buffer *to_link)</span><br><span> {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    check_keystate_buf_not_used(to_link, ks);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ks-&g=
t;state =3D S_UNDEF;</span><br><span> </span><br><span>     key_state_ssl_f=
ree(&amp;ks-&gt;ks_ssl);</span><br><span>@@ -1143,16 +1156,25 @@</span><br>=
<span>  * @param session      - A pointer to the \c tls_session structure t=
o be</span><br><span>  *                       cleaned up=2E</span><br><spa=
n>  * @param clear        - Whether the memory allocated for the \a session=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                   =
    object should be overwritten with 0s=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *                       object should be overwritt=
en with 0s=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                       implicitly sets many states to 0/false,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *                       e=2Eg=
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
pan> </span><br><span>@@ -3206,9 +3244,10 @@</span><br><span>      */</span=
><br><span>     if (DECRYPT_KEY_ENABLED(multi, &amp;multi-&gt;session[TM_UN=
TRUSTED]=2Ekey[KS_PRIMARY]))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        check_session_buf_not_used(to_link,=
 &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_DEBU=
G_LOW, &quot;TLS: tls_multi_process: untrusted session promoted to %struste=
d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mov=
e_session(multi, TM_ACTIVE, TM_UNTRUSTED, true, to_link);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        tas =3D tls_authentication_st=
atus(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_=
process: initial untrusted &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;session promoted to %strusted&quot;,</span>=
<br><span>             tas =3D=3D TLS_AUTHENTICATION_SUCCEEDED ? &quot;&quo=
t; : &quot;semi-&quot;);</span><br><span>     }</span><br><span> </span><br=
><span>@@ -3622,7 +3661,7 @@</span><br><span>                 goto error;</=
span><br><span>             }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            key_state_soft_reset(session);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            key_state_soft=
_reset(session, NULL);</span><br><span> </span><br><span>             dmsg(=
D_TLS_DEBUG,</span><br><span>                  &quot;TLS: received P_CONTRO=
L_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;,</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">chang=
e 1985</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: release/2=2E5 </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1985 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Max=
F &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--Ti663OmBaDc=--


--===============6369415702807819147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6369415702807819147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6369415702807819147==--


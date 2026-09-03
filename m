Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE5CC624DB
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xt+hTt5t+QMETWekdrQ9ViS0peyt72F+ZtUtsTWkL24=; b=HX2mSQzTn9OTJAsMPY1tD67FRR
	ETyVAuPaLK/SN5Ktn5bLHhyCOyCa7+gH1R6npbdA3595dZT2brf5B8/Ht7ZI4PJPUbw8g4r7RGfQ6
	qXt5UPcsq/Q7joaCmAE2YZmfYy0vrYjNn8KNqK1zf2h99szmvgAW36NbNylbgcrvwSgA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x21lt-0007ty-N8;
	Thu, 03 Sep 2026 07:22:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x21ls-0007tq-Ce
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 07:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mhdZlg7NHkxqTW2QPkeKmD7AUzRBTVGkwCB4bHWhjqs=; b=BMGsiUQDaT09EY53vDCX5cejU3
 ZCvwmqwOH7ul8mgRoKu+QB90dbwpO2HcnPx+za6goAxQy5tMaxKE9WKeU7l1CC1SHGKKkwVqbQJ+4
 ngnTEGXCSHSFAAoXkZr8NrwNmGc3wfhzOWOuds39kWmM23Lb9L8G/uFfALglT7YS8P7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mhdZlg7NHkxqTW2QPkeKmD7AUzRBTVGkwCB4bHWhjqs=; b=O
 l2mpnOWT04YhehtZjfoRnlQcYtFATvYUy0FdyWHLFaqrb1UEmBA1purmtux/TvjvvgjhX2gnMK8Sw
 g4IMe2peQVujQLepEUBwEOa+Bvpn2k601yo2bvjwqrzLszyvOGfGVXoo1y78IdzL3HxR0cYKgbblf
 RiEtopJgqlVtkNZg=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x21lq-0004cz-Du for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 07:22:04 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495590dde14so21307085e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788420116; x=1789024916; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mhdZlg7NHkxqTW2QPkeKmD7AUzRBTVGkwCB4bHWhjqs=;
 b=JLVTNOVbi7MapHPYugS7PEGMBEdElcw7tCnZKj8DUc6KNJQmAbPF13Lslq4n1vcAMl
 6p+RLNuuSSl8mMxs05gWCLzgVETs2H1WrSuvt1JwRHjMx7U/RGenbQC2coK/fJx2XLo7
 IQJiq9raegGbd5RnnrnQRU25PWiHWh60NWGNvw9vRYav4320rbeZNCCs/HesYu/bnuC4
 B3k/a9MLqgoSQHZtpw77+iv6ZWkFUgUFJt6JMQ0rZtiwwojj4RXFZfo1QILeIhgio2ak
 EtbgPtl9csu/hQGCHzUDFNZgfILuCwYNDSl2uuylJCS4Yp8QcUQpSxbORjBnYl/eJw9D
 EMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788420116; x=1789024916;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mhdZlg7NHkxqTW2QPkeKmD7AUzRBTVGkwCB4bHWhjqs=;
 b=KeV76NSl7e8YUNpmLUq2MSAWp8VnXbODNMO18Oe389GbT7TnIViU0tGI6vLtCUiGis
 ACUkpHv9iT92qNlzuMdih5sTd9zF1D6E9KBdhWzT8JSOeT0vT9fToiQSCwGzkzun07xU
 jNkk3oUpConJZVK/kdRynefQqtdgUfCP7cJxrOYApUEyxCrtCAH+7tbZqpU4LXLGpRKV
 v+3eRB6JOkkIkAxBFDsDBhiBC033N5XIk5x/3qwxBBQY0FSNrED/HYZiXj/XbgP58jkw
 E8s0PieiGn0vSulbUHPa4LOdpxxwGAUTtY+nGj8emkWr1CQhpTSFXKx5Ji33nvDabwXE
 2Uvg==
X-Gm-Message-State: AFuF++nnaCaDcpNCs+FTMaYyeQi0Mtw71j9jiAp9vgahRkacKys7TbSH
 CoP33z6XjMm9Frxm0ifERtIz93odC1heyh/xWH2K6WoU9VAO0hdTAITLneOdGN8h/miJd+OZtRO
 LWclgBlWHaip3gznZhlxRlue9Zl4o6y4atMQGd2L7rAlx9PWqGz6JbbhtskvlbH6lQEmj
X-Gm-Gg: AYBFou3NY/CNq8Amw1s6PoN1VmH3KP30+gTzdI4iy4dRoX4LvAr1nJCOX/fy/VdB64P
 N1mMat2cvUCsoMmXP4ZmAqEz1X99kfMvdf51TlJW73lqVMH+kTNxHZdt7MTGG98SNsnBVJsFVKL
 cEjv4a4H26rIy/j2MhGKt/ryDW95wod11Fl57G5LPUAEph/pqEJd1v1B7dGQGIh49g8s1hsH0gR
 GdGtZEKT811saOp4YQmgzoGs8h/AFKFs6Upe/O3paKJVVswhaCGOVL0ZxjO/kzprWR+IIrHuXed
 2R7zcztK0PPIeM+6WltdSLHO3ZFnxQIzo6PGKg0HsLGIq0QYQm0qU+wJPCkZVeSw65my2GULT/s
 rxsxucigmxs5tYVfLj8aH+8w9Ip6NwSTiT84Z2lIe1xQMI7rLIfUnG1wcm64Mbk+vYQyI9tFdQl
 Cpkzla4hX5SDrQawT9Pf0puog3YPyEP0QwqPvWsgGp0VFtb/2/qra9e538IqoJVe+Ork046HrrI
 nsDHTND3XZwvB0iOwPZONj8Xer3fpMfVuiPGU6i2Jo1A7p0VNS5nqG0AOJe3UCTF+EiBzpvYdEh
 jjcrYwha5yvSJsj1RAlviuAeI/7NOdogM29OWVppkRjVDopCKLk=
X-Received: by 2002:a05:600c:8b86:b0:49c:d27e:8f7c with SMTP id
 5b1f17b1804b1-49ce5843b42mr178883915e9.12.1788420115660; 
 Thu, 03 Sep 2026 00:21:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm53012635e9.13.2026.09.03.00.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:21:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 07:21:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1893
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1893?usp=email>
X-Gerrit-Commit: 2a881d737b2562ee28247148160cfb60f0ba4645
In-Reply-To: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MzY4NjE4MDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <34a22995dd74832ba244d7d8cacd347dda69ad43-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x21lq-0004cz-Du
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============0124866215224942249=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0124866215224942249==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XG5/zUyGDLI="; charset=UTF-8

--XG5/zUyGDLI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1893?usp=3Demail )

Change subject: Move check_session_buf_not_used met=
hod into the method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move check_session_buf_not_used method into th=
e method that free the buffer

This cleans the code up a bit and ensure tha=
t we do not miss an invocation
of a problematic code path=2E This is still =
a band-aid fix and a real fix
requires more refactoring and changing the lo=
gic=2E

v2: sprinkle some "const" over check_keystate_buf_not_used() args
v=
3: add missing doxygen for to_link parameter to tls_session_free()

CVE: 20=
26-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Test=
ed-By: Andreas Gabriel Berbescu <aberbescu@gmail=2Ecom>
Github: openvpn/ope=
nvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda University)
Githu=
b: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f714803604d76c6df=
6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893
Acked-by: MaxF <max@max-f=
illinger=2Enet>
Message-Id: <20260903061209=2E12599-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38913=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/ssl=2Ec
1 file changed, 88 insertions(+), 58 deletions(=
-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 5f5d1f9=
=2E=2E71459ee 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -96,6 +96,14 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
+/* fo=
rward decleration since tls_process needs this function prototype */
+stati=
c void
+check_session_buf_not_used(struct buffer *to_link, struct tls_sessi=
on *session);
+
+static void
+check_keystate_buf_not_used(struct buffer *to=
_link, const struct key_state *ks);
+
+
 /**
  * Limit the reneg_bytes valu=
e when using a small-block (<128 bytes) cipher=2E
  *
@@ -896,10 +904,15 @@=

  *                       cleaned up=2E
  * @param clear        - Whether =
the memory allocated for the \a ks object
  *                       should =
be overwritten with 0s=2E
+ *
+ * @param to_link      - if not NULL, check =
that the buffer does not contain
+ *                       any pointer to o=
ne of the internal structs of ks
  */
 static void
-key_state_free(struct k=
ey_state *ks, bool clear)
+key_state_free(struct key_state *ks, bool clear,=
 struct buffer *to_link)
 {
+    check_keystate_buf_not_used(to_link, ks);
=
+
     ks->state =3D S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1=
043,11 +1056,14 @@
  *                       object should be overwritten w=
ith 0s=2E This
  *                       implicitly sets many states to 0/f=
alse,
  *                       e=2Eg=2E the validity of the keys in the st=
ructure
+ * @param to_link      - if not NULL, check that the buffer does n=
ot contain
+ *                       any pointer to one of the internal str=
ucts of ks
  *
  */
 static void
-tls_session_free(struct tls_session *sess=
ion, bool clear)
+tls_session_free(struct tls_session *session, bool clear,=
 struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, sessio=
n);
     tls_wrap_free(&session->tls_wrap);
     tls_wrap_free(&session->tl=
s_wrap_reneg);
 
@@ -1056,7 +1072,7 @@
         /* we don't need clear=3Dtr=
ue for this call since
          * the structs are part of session and get =
cleared
          * as part of session */
-        key_state_free(&session-=
>key[i], false);
+        key_state_free(&session->key[i], false, to_link);=

     }
 
     free(session->common_name);
@@ -1075,14 +1091,16 @@
 
 
 sta=
tic void
-move_session(struct tls_multi *multi, int dest, int src, bool rei=
nit_src)
+move_session(struct tls_multi *multi, int dest, int src, bool rei=
nit_src,
+             struct buffer *to_link)
 {
+    check_session_buf_no=
t_used(to_link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: mov=
e_session: dest=3D%s src=3D%s reinit_src=3D%d",
         session_index_name=
(dest), session_index_name(src), reinit_src);
     ASSERT(src !=3D dest);
 =
    ASSERT(src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && dest < =
TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+    tls_ses=
sion_free(&multi->session[dest], false, to_link);
     multi->session[dest]=
 =3D multi->session[src];
 
     if (reinit_src)
@@ -1098,9 +1116,9 @@
 }
 =

 static void
-reset_session(struct tls_multi *multi, struct tls_session *s=
ession)
+reset_session(struct tls_multi *multi, struct tls_session *session=
, struct buffer *to_link)
 {
-    tls_session_free(session, false);
+    tl=
s_session_free(session, false, to_link);
     tls_session_init(multi, sessi=
on);
 }
 
@@ -1265,7 +1283,7 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)
=
     {
-        tls_session_free(&multi->session[i], false);
+        tls_s=
ession_free(&multi->session[i], false, NULL);
     }
 
     if (clear)
@@ -=
1764,13 +1782,13 @@
  * active key=2E
  */
 static void
-key_state_soft_res=
et(struct tls_session *session)
+key_state_soft_reset(struct tls_session *s=
ession, struct buffer *to_link)
 {
     struct key_state *ks =3D &session->=
key[KS_PRIMARY];        /* primary key */
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
1781,7 +1799,7 @@
 void
 tls_session_soft_reset(struct tls_multi *tls_multi=
)
 {
-    key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
+    key_st=
ate_soft_reset(&tls_multi->session[TM_ACTIVE], NULL);
 }
 
 /*
@@ -3101,13 =
+3119,13 @@
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

@@ -3200,6 +3218,55 @@
     return false;
 }
 
+static void
+check_keystat=
e_buf_not_used(struct buffer *to_link, const struct key_state *ks)
+{
+    =
if (ks->state =3D=3D S_UNDEF || !to_link || !to_link->data)
+    {
+       =
 return;
+    }
+
+    uint8_t *dataptr =3D to_link->data;
+
+    /* we don=
't expect send_reliable to be NULL when state is
+     * not S_UNDEF, but p=
eople have reported crashes nonetheless,
+     * therefore we better catch =
this event, report and exit=2E
+     */
+    if (!ks->send_reliable)
+    {=

+        msg(M_FATAL,
+            "ERROR: ks=2Esend_reliable (key-id %d),=
 is NULL "
+            "while key state is %s=2E Exiting=2E",
+           =
 ks->key_id, state_name(ks->state));
+    }
+
+    for (int j =3D 0; j < ks=
->send_reliable->size; j++)
+    {
+        if (ks->send_reliable->array[j]=
=2Ebuf=2Edata =3D=3D dataptr)
+        {
+            msg(M_INFO,
+        =
        "Warning buffer of freed TLS session is still in"
+                =
" use (key-id %d, ks=2Esend_reliable->array[%d])",
+                ks->key=
_id, j);
+
+            goto used;
+        }
+    }
+
+    if (ks->ack_wri=
te_buf=2Edata =3D=3D dataptr)
+    {
+        msg(M_INFO, "Warning buffer o=
f freed TLS session is still in use "
+                    "(ks=2Eack_write=
_buf, key-id %d)",
+            ks->key_id);
+
+        goto used;
+    }
+=
    return;
+
+used:
+    to_link->len =3D 0;
+    to_link->data =3D 0;
+}
=
 
 /**
  * This is a safe guard function to double check that a buffer from=
 a session is
@@ -3211,11 +3278,11 @@
 static void
 check_session_buf_not_u=
sed(struct buffer *to_link, struct tls_session *session)
 {
-    const uint=
8_t *dataptr =3D to_link->data;
-    if (!dataptr)
+    if (!to_link || !to=
_link->data)
     {
         return;
     }
+    const uint8_t *dataptr =3D=
 to_link->data;
 
     /* Checks buffers in tls_wrap */
     if (session->t=
ls_wrap=2Ework=2Edata =3D=3D dataptr)
@@ -3234,41 +3301,7 @@
     for (int =
i =3D 0; i < KS_SIZE; i++)
     {
         const struct key_state *ks =3D &=
session->key[i];
-        if (ks->state =3D=3D S_UNDEF)
-        {
-       =
     continue;
-        }
-
-        /* we don't expect send_reliable to be=
 NULL when state is
-         * not S_UNDEF, but people have reported crash=
es nonetheless,
-         * therefore we better catch this event, report an=
d exit=2E
-         */
-        if (!ks->send_reliable)
-        {
-       =
     msg(M_FATAL,
-                "ERROR: session->key[%d]->send_reliable =
is NULL "
-                "while key state is %s=2E Exiting=2E",
-        =
        i, state_name(ks->state));
-        }
-
-        for (int j =3D 0; =
j < ks->send_reliable->size; j++)
-        {
-            if (ks->send_reli=
able->array[j]=2Ebuf=2Edata =3D=3D dataptr)
-            {
-               =
 msg(M_INFO,
-                    "Warning buffer of freed TLS session is s=
till in"
-                    " use (session->key[%d]=2Esend_reliable->arra=
y[%d])",
-                    i, j);
-
-                goto used;
-       =
     }
-        }
-        if (ks->ack_write_buf=2Edata =3D=3D dataptr)
-  =
      {
-            msg(M_INFO, "Warning buffer of freed TLS session is st=
ill in use (session->key[%d]=2Eack_write_buf)", i);
-
-            goto use=
d;
-        }
+        check_keystate_buf_not_used(to_link, ks);
     }
   =
  return;
 
@@ -3362,13 +3395,11 @@
                 if (i =3D=3D TM_ACTIVE=
 && ks_lame->state >=3D S_GENERATED_KEYS
                     && !multi->op=
t=2Esingle_session)
                 {
-                    check_session_b=
uf_not_used(to_link, session);
-                    move_session(multi, TM_=
LAME_DUCK, TM_ACTIVE, true);
+                    move_session(multi, TM_LA=
ME_DUCK, TM_ACTIVE, true, to_link);
                 }
                 els=
e
                 {
-                    check_session_buf_not_used(to_lin=
k, session);
-                    reset_session(multi, session);
+         =
           reset_session(multi, session, to_link);
                 }
     =
        }
         }
@@ -3421,7 +3452,7 @@
      */
     if (lame_duck_must=
_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tls_session_fr=
ee(&multi->session[TM_LAME_DUCK], true);
+        tls_session_free(&multi->=
session[TM_LAME_DUCK], true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: =
tls_multi_process: killed expiring key");
     }
 
@@ -3436,8 +3467,7 @@
  =
    */
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL]=2Ekey[=
KS_PRIMARY]))
     {
-        check_session_buf_not_used(to_link, &multi->s=
ession[TM_ACTIVE]);
-        move_session(multi, TM_ACTIVE, TM_INITIAL, tru=
e);
+        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);
   =
      tas =3D tls_authentication_status(multi);
         msg(D_TLS_DEBUG_LO=
W,
             "TLS: tls_multi_process: initial untrusted "
@@ -3839,7 +38=
69,7 @@
                 goto error;
             }
 
-            key_stat=
e_soft_reset(session);
+            key_state_soft_reset(session, NULL);
 
=
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%=
d sid=3D%s", i,
                  session_id_print(&sid, &gc));

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf2=
0ce7626d
Gerrit-Change-Number: 1893
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--XG5/zUyGDLI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1893?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Move check_session_buf_not_used method int=
o the method that free the buffer<br><br>This cleans the code up a bit and =
ensure that we do not miss an invocation<br>of a problematic code path=2E T=
his is still a band-aid fix and a real fix<br>requires more refactoring and=
 changing the logic=2E<br><br>v2: sprinkle some &quot;const&quot; over chec=
k_keystate_buf_not_used() args<br>v3: add missing doxygen for to_link param=
eter to tls_session_free()<br><br>CVE: 2026-84471<br>Reported-By: Andreas G=
abriel Berbescu &lt;aberbescu@gmail=2Ecom&gt;<br>Tested-By: Andreas Gabriel=
 Berbescu &lt;aberbescu@gmail=2Ecom&gt;<br>Github: openvpn/openvpn-private-=
issues#157<br>Reported-By: Haruki Oyama (Waseda University)<br>Github: open=
vpn/openvpn-private-issues#132<br>Change-Id: I64920ed9f714803604d76c6df6b38=
cf20ce7626d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1893<br>Acked-by: MaxF=
 &lt;max@max-fillinger=2Enet&gt;<br>Message-Id: &lt;20260903061209=2E12599-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg38913=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>=
1 file changed, 88 insertions(+), 58 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 5f5d1=
f9=2E=2E71459ee 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -96,6 +96,14 @@</span><b=
r><span> </span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
forward decleration since tls_process needs this function prototype */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+check_session_buf_not_used(struc=
t buffer *to_link, struct tls_session *session);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+check_keystate_buf_not_used(struct buffer *to_link, const struct key_stat=
e *ks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Limit the reneg_bytes value when using a small-block (&lt;128 by=
tes) cipher=2E</span><br><span>  *</span><br><span>@@ -896,10 +904,15 @@</s=
pan><br><span>  *                       cleaned up=2E</span><br><span>  * @=
param clear        - Whether the memory allocated for the \a ks object</spa=
n><br><span>  *                       should be overwritten with 0s=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param to_link      - if not NULL, che=
ck that the buffer does not contain</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *                       any pointer to one of the internal=
 structs of ks</span><br><span>  */</span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state =
*ks, bool clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key=
_state_free(struct key_state *ks, bool clear, struct buffer *to_link)</span=
><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
eck_keystate_buf_not_used(to_link, ks);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><=
br><span> </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</sp=
an><br><span>@@ -1043,11 +1056,14 @@</span><br><span>  *                   =
    object should be overwritten with 0s=2E This</span><br><span>  *       =
                implicitly sets many states to 0/false,</span><br><span>  *=
                       e=2Eg=2E the validity of the keys in the structure</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_link    =
  - if not NULL, check that the buffer does not contain</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *                       any pointer to=
 one of the internal structs of ks</span><br><span>  *</span><br><span>  */=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tls_session_free(struct tls_session *session, bool clear)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tls_session_free(struct tls_s=
ession *session, bool clear, struct buffer *to_link)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_n=
ot_used(to_link, session);</span><br><span>     tls_wrap_free(&amp;session-=
&gt;tls_wrap);</span><br><span>     tls_wrap_free(&amp;session-&gt;tls_wrap=
_reneg);</span><br><span> </span><br><span>@@ -1056,7 +1072,7 @@</span><br>=
<span>         /* we don&#39;t need clear=3Dtrue for this call since</span>=
<br><span>          * the structs are part of session and get cleared</span=
><br><span>          * as part of session */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        key_state_free(&amp;session-&gt;key[i], fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_stat=
e_free(&amp;session-&gt;key[i], false, to_link);</span><br><span>     }</sp=
an><br><span> </span><br><span>     free(session-&gt;common_name);</span><b=
r><span>@@ -1075,14 +1091,16 @@</span><br><span> </span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
move_session(struct tls_multi *multi, int dest, int src, bool reinit_src)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+move_session(struct t=
ls_multi *multi, int dest, int src, bool reinit_src,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             struct buffer *to_link)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
heck_session_buf_not_used(to_link, &amp;multi-&gt;session[dest]);</span><br=
><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D%s src=3D%=
s reinit_src=3D%d&quot;,</span><br><span>         session_index_name(dest),=
 session_index_name(src), reinit_src);</span><br><span>     ASSERT(src !=3D=
 dest);</span><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp; src &lt; TM_SI=
ZE);</span><br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &lt; TM_SIZ=
E);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_fr=
ee(&amp;multi-&gt;session[dest], false);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    tls_session_free(&amp;multi-&gt;session[dest], fal=
se, to_link);</span><br><span>     multi-&gt;session[dest] =3D multi-&gt;se=
ssion[src];</span><br><span> </span><br><span>     if (reinit_src)</span><b=
r><span>@@ -1098,9 +1116,9 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-r=
eset_session(struct tls_multi *multi, struct tls_session *session)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+reset_session(struct tls_mul=
ti *multi, struct tls_session *session, struct buffer *to_link)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_sessio=
n_free(session, false);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    tls_session_free(session, false, to_link);</span><br><span>     tls=
_session_init(multi, session);</span><br><span> }</span><br><span> </span><=
br><span>@@ -1265,7 +1283,7 @@</span><br><span> </span><br><span>     for (=
int i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&amp;multi-&gt;=
session[i], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        tls_session_free(&amp;multi-&gt;session[i], false, NULL);</span><br=
><span>     }</span><br><span> </span><br><span>     if (clear)</span><br><=
span>@@ -1764,13 +1782,13 @@</span><br><span>  * active key=2E</span><br><s=
pan>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-key_state_soft_reset(struct tls_session *session)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct t=
ls_session *session, struct buffer *to_link)</span><br><span> {</span><br><=
span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];       =
 /* primary key */</span><br><span>     struct key_state *ks_lame =3D &amp;=
session-&gt;key[KS_LAME_DUCK]; /* retiring key */</span><br><span> </span><=
br><span>     ks-&gt;must_die =3D now + session-&gt;opt-&gt;transition_wind=
ow;    /* remaining lifetime of old key */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    key_state_free(ks_lame, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    key_state_free(ks_lame, false, to_=
link);</span><br><span>     *ks_lame =3D *ks;</span><br><span> </span><br><=
span>     key_state_init(session, ks);</span><br><span>@@ -1781,7 +1799,7 @=
@</span><br><span> void</span><br><span> tls_session_soft_reset(struct tls_=
multi *tls_multi)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    key_state_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIV=
E]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_state_s=
oft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span> }<=
/span><br><span> </span><br><span> /*</span><br><span>@@ -3101,13 +3119,13 =
@@</span><br><span>             session-&gt;opt-&gt;aead_usage_limit,</span=
><br><span>             ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplai=
ntext_blocks + ks-&gt;n_packets,</span><br><span>             session-&gt;o=
pt-&gt;aead_usage_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        key_state_soft_reset(session);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        key_state_soft_reset(session, to_link);</spa=
n><br><span>     }</span><br><span> </span><br><span>     /* Kill lame duck=
 key transition_window seconds after primary key negotiation */</span><br><=
span>     if (lame_duck_must_die(session, wakeup))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(=
ks_lame, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    key_state_free(ks_lame, true, to_link);</span><br><span>         msg(D_=
TLS_DEBUG_LOW, &quot;TLS: tls_process: killed expiring key&quot;);</span><b=
r><span>     }</span><br><span> </span><br><span>@@ -3200,6 +3218,55 @@</sp=
an><br><span>     return false;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+check_keystate_buf_not_used(struct=
 buffer *to_link, const struct key_state *ks)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt;dat=
a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* we don&#39;t expect send_reliable to be NULL when state i=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * not S_UNDEF=
, but people have reported crashes nonetheless,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * therefore we better catch this event, re=
port and exit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ks-&gt=
;send_reliable)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATA=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;ERROR: ks=2Esend_reliable (key-id %d), is NULL &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;while key state is %s=
=2E Exiting=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            ks-&gt;key_id, state_name(ks-&gt;state));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;send_reliable-&gt;arra=
y[j]=2Ebuf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(M_INFO,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                &quot;Warning buffer of freed TLS session is still =
in&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     &quot; use (key-id %d, ks=2Esend_reliable-&gt;array[%d])&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                ks-&gt;key=
_id, j);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            goto used;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Warning buffer of freed TL=
S session is still in use &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    &quot;(ks=2Eack_write_buf, key-id %d)&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&g=
t;key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        goto used;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+used:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to_=
link-&gt;len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    to_link-&gt;data =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span> </span><br><span> /**</span><br><span>  * This i=
s a safe guard function to double check that a buffer from a session is</sp=
an><br><span>@@ -3211,11 +3278,11 @@</span><br><span> static void</span><br=
><span> check_session_buf_not_used(struct buffer *to_link, struct tls_sessi=
on *session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!dataptr)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!to_link || !to_link-&gt;data)</=
span><br><span>     {</span><br><span>         return;</span><br><span>    =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t=
 *dataptr =3D to_link-&gt;data;</span><br><span> </span><br><span>     /* C=
hecks buffers in tls_wrap */</span><br><span>     if (session-&gt;tls_wrap=
=2Ework=2Edata =3D=3D dataptr)</span><br><span>@@ -3234,41 +3301,7 @@</span=
><br><span>     for (int i =3D 0; i &lt; KS_SIZE; i++)</span><br><span>    =
 {</span><br><span>         const struct key_state *ks =3D &amp;session-&gt=
;key[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (k=
s-&gt;state =3D=3D S_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      continue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* we don&#39;t expect send_rel=
iable to be NULL when state is</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * not S_UNDEF, but people have reported crashes nonethele=
ss,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * therefo=
re we better catch this event, report and exit=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!ks-&gt;send_reliable)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_FATAL,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot;ERROR: session-&gt;key[%d]-&gt=
;send_reliable is NULL &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                &quot;while key state is %s=2E Exiting=2E&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                i, state=
_name(ks-&gt;state));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        for (int j =3D 0; j &lt; =
ks-&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dat=
aptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_IN=
FO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  &quot;Warning buffer of freed TLS session is still in&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    &quot; use (ses=
sion-&gt;key[%d]=2Esend_reliable-&gt;array[%d])&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    i, j);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                goto used;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;Warning buffer of fre=
ed TLS session is still in use (session-&gt;key[%d]=2Eack_write_buf)&quot;,=
 i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            goto used;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        check_keystate_buf_not_used(to_link, ks=
);</span><br><span>     }</span><br><span>     return;</span><br><span> </s=
pan><br><span>@@ -3362,13 +3395,11 @@</span><br><span>                 if (=
i =3D=3D TM_ACTIVE &amp;&amp; ks_lame-&gt;state &gt;=3D S_GENERATED_KEYS</s=
pan><br><span>                     &amp;&amp; !multi-&gt;opt=2Esingle_sessi=
on)</span><br><span>                 {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    check_session_buf_not_used(to_link, se=
ssion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    move_session(mult=
i, TM_LAME_DUCK, TM_ACTIVE, true, to_link);</span><br><span>               =
  }</span><br><span>                 else</span><br><span>                 =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
check_session_buf_not_used(to_link, session);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    reset_session(multi, session);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
reset_session(multi, session, to_link);</span><br><span>                 }<=
/span><br><span>             }</span><br><span>         }</span><br><span>@=
@ -3421,7 +3452,7 @@</span><br><span>      */</span><br><span>     if (lame=
_duck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_=
session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&=
gt;session[TM_LAME_DUCK], true, to_link);</span><br><span>         msg(D_TL=
S_DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring key&quot;);</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -3436,8 +3467,7 @@<=
/span><br><span>      */</span><br><span>     if (TLS_AUTHENTICATED(multi, =
&amp;multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_sessi=
on_buf_not_used(to_link, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        move_session(multi, TM_ACTIV=
E, TM_INITIAL, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);</span>=
<br><span>         tas =3D tls_authentication_status(multi);</span><br><spa=
n>         msg(D_TLS_DEBUG_LOW,</span><br><span>             &quot;TLS: tls=
_multi_process: initial untrusted &quot;</span><br><span>@@ -3839,7 +3869,7=
 @@</span><br><span>                 goto error;</span><br><span>          =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            key_state_soft_reset(session);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            key_state_soft_reset(session, NULL);</s=
pan><br><span> </span><br><span>             dmsg(D_TLS_DEBUG, &quot;TLS: r=
eceived P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,</span><br><span> =
                 session_id_print(&amp;sid, &amp;gc));</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1893?usp=3Demail">change 1893</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1893?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
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
--XG5/zUyGDLI=--


--===============0124866215224942249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0124866215224942249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0124866215224942249==--


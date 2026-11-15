Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FAE606A32C
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZErIaBwS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GptYJXpB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j7Rkh+f4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D1j3piiS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R0K32E+zrsXYtuqMgGOqdQERa22S9FRVfQBGzmyCVg0=; b=ZErIaBwSg2mCfnmB22FrUSdUvo
	fV8QRKy37iLijpyR87dfINun6pfbn2vhIylo07U0AT7f2B8ylAMbzquVaUIwLmONIYqYnUWzhpOLd
	xhmqEDE9g0pG8dciJm8uYaS7rZXMoRuhNu1ZcxHEiTSTK7ymxYugn5oYPzkTpe5my2LU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSR95-000000003Qw-2mLg;
	Sun, 15 Nov 2026 03:43:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSR93-000000003Qp-30hs
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 03:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+XjJbKJRuEr1deN9i2evVXC6WZiuDWIZFx9psFXkYD8=; b=GptYJXpBmQNT/WP7g+zWF0+APa
 42omT9yG/IRel22eN3iRcSeyuF88EYxREYrgAOHHG1LKhccrHC3DaXPSt3G+O4s/2sxquilrGhN0K
 PDgZtdXQKHSt1LbbvRv9VJfQUtyXEE9nYFxGyzgI6YGlOnMFDiHblc5Ls0n0PQc7dGTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+XjJbKJRuEr1deN9i2evVXC6WZiuDWIZFx9psFXkYD8=; b=j7Rkh+f4Xd461u89rJ1whcMNv9
 LJfEqVbyjurqvM3ind/zd9095HzXmc2/Uda+JCkeVfiEMP8xG+T5FixfVjVNHyuCV47uelVJAEz7L
 qcJfNRCXaTO42mIat9A9o3t1LQUWeE9g4AJIhWIiil1epY88SHyWcldcjpgVVanw0Iug=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSR8z-000000003NS-2gYx for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 03:43:09 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so3390555e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 19:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794714179; x=1795318979; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+XjJbKJRuEr1deN9i2evVXC6WZiuDWIZFx9psFXkYD8=;
 b=D1j3piiSu8iOfnLnD9qCH9fwnoJdBO+81swDzY0wpfahqU8DqYL/20DufqrggOxdle
 HOHqvRIMT/b6St07rO+7vwWvRq5nJSbedz0jcr3GvqwZOUrZYDIBkQPM1hjkLm+YhYiM
 3LkGnmIPmh1q4nLadiffePCg/R+boj7MZmyET5wRERdkpab5XQulmznpAfCrY2Xbs7Zz
 G6hZklfZBhY9767+1YW21MxqixlZhKnj0wAdbhQ3DJTwbHkEGVQB03dj7IABj+2MqA1I
 1SdrdrJT0pOXk2C/7FDQO9+ABDFO/osQugjcStKLa63I5ejxannp2R9QOWYm43MqSaPr
 sGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794714179; x=1795318979;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+XjJbKJRuEr1deN9i2evVXC6WZiuDWIZFx9psFXkYD8=;
 b=PNdmaj2ldbMSIbuZ920v/qKPh1Aeoi63PEAaw48NYFMMJJEnbPoedTzjeB66SmzUvc
 iiViB6ya2l+aFZ/RaZzeO3FaZ8F7fuugmeHFtTShGo3bmcaVPrBgSVLZsGEqFCgtWXgz
 BW7AXgLpjgUV5Tw82/IaMaiG4YicR363BzSJCfUfWq8QtOejQl+AE507sudO+BFNmLiv
 iNGmGMAr9FvqJ25B7LPPAwNxXwfXbPUTWNlBVnnNSzvkhQNKerkNCTZlJuBgE4vclaMb
 LciiPrRZXT0X+udMwHPLItLgvyDaWC+LsomvD8ycAEzl2wqjrBSHVJ2sK8E2NkH04P3y
 XyeA==
X-Gm-Message-State: APuU4Z8nQvCIq3eVLJlr3ZIbHYCcp5MSs942HeU+wIWBKieeQbqmLemm
 ZZAQJ4WGYB4cMtKmYJmBGzloFj5XSqy57TVgkp4YHBzsGY29rbjxsFI1a4bRd+NyTNtq75CB70C
 HuZER4YWNYjTTpYcSPb8TfGxSD+C8HlhZ68jLzxO+lVQMEktOvu0V4/wW6J5Hhfz9uTCI
X-Gm-Gg: AYBFou3xm9n0GTtbWolsktyjb6gSv5M32HWcOUBCW49aVMAkadJMqb6F0gpNIE9XqKa
 7wHri8O720HN4ofcLEpxAKjHKh4XsAPv7xZshKRIHEwDFicXgihWBhE2+u7KEb6E/2ILknCH529
 cnnRO8KJ7dByM/t5PYl+icjdr8PA27Au7bWhRuAGgp9j1sf/UBXp7qf64DJy5p2U2KecvnJZBsc
 v2HkcITY9R38bIwdpslEk2i/7uHIa628t3mLtPgO/mS+T11ZPIMXM4fuIwcWJbH28hVc5sE1yXb
 kLeqgFQ4Zu9RPcq4ZcRJCqUZ5K7RDXF6oRufxHYGnO/AOf8JGbV5db+7WVDdRe9G7kYrjg6lNQ+
 7ojjWDG+khvBNSOAhMG144x/geeryKvAWKhDnIw1s4ECjUTkquFfurHgOL3xAfa6BB+KZuLB2fe
 bDEkIIjC2rgV00RQ6tK1lAtFn2w5/SLySBwgMpub+RKDEu8OHjQcsuO3JnJM1x9SBAyjt77oV8y
 bjNrrFXa70SUiZ5k+fgPToGBJnFwuHhW0vEHJ3s7YWRg7GlM6+GXXRKvo444t1A8YT648jMRmaw
 qRLGLrZ2Es4nn/eILxZ596qiNvNo1J+ArMMCsiXPJXNG8ZqaRyaxxUmFtak10RqEKQ4AR1LrcvR
 wn3NlrSFxIo8pQnLjC7z7QJnPsz1TSWs4st/jgGfvc9I9kIX5b8CBIfwu7axRIFyHITgcgcUQdd
 j9O5+8yIoWjyTmupU=
X-Received: by 2002:a05:600c:3114:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb55a5de41mr142699825e9.21.1794714178553; 
 Sat, 14 Nov 2026 19:42:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb65ce005bsm97995605e9.14.2026.11.14.19.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 19:42:57 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 03:42:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: f76f976134a1bb257fda97ccde77d6c06ce1b612
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <243622c130c7028cf9e459db7167cbc3d155c6b1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSR8z-000000003NS-2gYx
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1928058239667094724=="
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1928058239667094724==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+oRw+WS8vhY="; charset=UTF-8

--+oRw+WS8vhY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Antonio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=
=3Demail

to look at the new patch set (#2)=2E


Change subject: Keep the o=
utgoing control packet in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Keep the outgoing control packet i=
n a buffer owned by tls_multi

tls_multi_process() returns the outgoing con=
trol packet in to_link=2E
Until now to_link pointed into memory owned by a =
session or key state:
the reliable send buffer, ks->ack_write_buf, or the t=
ls_wrap or
tls_wrap_reneg work buffer=2E  When that session or key state wa=
s freed
or reset before the packet was written to the link, to_link was lef=
t
pointing to freed memory=2E  This caused CVE-2023-46850, CVE-2026-40215,
=
CVE-2026-12996, CVE-2026-13117 and CVE-2026-84471=2E

The fixes so far adde=
d check_session_buf_not_used() and
check_keystate_buf_not_used(), which com=
pare to_link against a list of
the buffers of a session or key state before=
 it is freed and drop the
packet on a match=2E  This only works as long as =
the list names every
buffer a packet can end up in and every caller that fr=
ees a session or
key state passes to_link down: key_state_soft_reset() is c=
alled without
it from tls_pre_decrypt() and tls_session_soft_reset()=2E

Fi=
x the ownership instead=2E  write_control_auth() now copies the
finished pa=
cket into a buffer the caller owns, and tls_multi_process()
returns it in m=
ulti->to_link_buf, which lives as long as the tls_multi,
like multi->to_lin=
k_addr already does for the address=2E  Freeing or
moving sessions and key =
states no longer affects a pending packet, so
the checks and the to_link pa=
rameters of key_state_free(),
tls_session_free(), move_session(), reset_ses=
sion() and
key_state_soft_reset() are removed=2E  A packet that is pending =
when its
session is freed is now sent instead of dropped; the peer handles =
it
like any late packet of that session=2E

The copy costs one memcpy of a =
control channel packet=2E  The new unit
test checks that the packet written=
 by write_control_auth() stays
intact and valid after the buffers it was bu=
ilt from are overwritten,
with no wrapping, tls-auth and tls-crypt=2E

Chan=
ge-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Signed-off-by: Alejandro P=
acheco <alepacheco99@gmail=2Ecom>
---
M src/openvpn/ssl=2Ec
M src/openvpn/s=
sl_common=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/u=
nit_tests/openvpn/test_pkt=2Ec
5 files changed, 178 insertions(+), 147 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/02/2002/2

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index =
00e1712=2E=2E8091c75 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -97,14 +97,6 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 =

-/* forward decleration since tls_process needs this function prototype */=

-static void
-check_session_buf_not_used(struct buffer *to_link, struct tl=
s_session *session);
-
-static void
-check_keystate_buf_not_used(struct buf=
fer *to_link, const struct key_state *ks);
-
-
 /**
  * Limit the reneg_byt=
es value when using a small-block (<128 bytes) cipher=2E
  *
@@ -917,15 +90=
9,10 @@
  *                       cleaned up=2E
  * @param clear        - W=
hether the memory allocated for the \a ks object
  *                       =
should be overwritten with 0s=2E
- *
- * @param to_link      - if not NULL,=
 check that the buffer does not contain
- *                       any point=
er to one of the internal structs of ks
  */
 static void
-key_state_free(s=
truct key_state *ks, bool clear, struct buffer *to_link)
+key_state_free(st=
ruct key_state *ks, bool clear)
 {
-    check_keystate_buf_not_used(to_link=
, ks);
-
     ks->state =3D S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl)=
;
@@ -1074,14 +1061,10 @@
  *                       object should be overwr=
itten with 0s=2E This
  *                       implicitly sets many states=
 to 0/false,
  *                       e=2Eg=2E the validity of the keys in=
 the structure
- * @param to_link      - if not NULL, check that the buffer=
 does not contain
- *                       any pointer to one of the inter=
nal structs of ks
- *
  */
 static void
-tls_session_free(struct tls_sessio=
n *session, bool clear, struct buffer *to_link)
+tls_session_free(struct tl=
s_session *session, bool clear)
 {
-    check_session_buf_not_used(to_link,=
 session);
     tls_wrap_free(&session->tls_wrap);
     tls_wrap_free(&sess=
ion->tls_wrap_reneg);
 
@@ -1090,7 +1073,7 @@
         /* we don't need cle=
ar=3Dtrue for this call since
          * the structs are part of session a=
nd get cleared
          * as part of session */
-        key_state_free(&s=
ession->key[i], false, to_link);
+        key_state_free(&session->key[i], =
false);
     }
 
     free(session->common_name);
@@ -1109,16 +1092,14 @@
 =

 
 static void
-move_session(struct tls_multi *multi, int dest, int src, b=
ool reinit_src,
-             struct buffer *to_link)
+move_session(struct =
tls_multi *multi, int dest, int src, bool reinit_src)
 {
-    check_session=
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
-    tls_session_free(&multi->session[dest], false, to_lin=
k);
+    tls_session_free(&multi->session[dest], false);
     multi->sessio=
n[dest] =3D multi->session[src];
 
     if (reinit_src)
@@ -1134,9 +1115,9 =
@@
 }
 
 static void
-reset_session(struct tls_multi *multi, struct tls_ses=
sion *session, struct buffer *to_link)
+reset_session(struct tls_multi *mul=
ti, struct tls_session *session)
 {
-    tls_session_free(session, false, t=
o_link);
+    tls_session_free(session, false);
     tls_session_init(multi=
, session);
 }
 
@@ -1210,6 +1191,8 @@
 tls_multi_init_finalize(struct tls_=
multi *multi, int tls_mtu)
 {
     tls_init_control_channel_frame_parameter=
s(&multi->opt=2Eframe, tls_mtu);
+    multi->to_link_buf =3D alloc_buf((siz=
e_t)BUF_SIZE(&multi->opt=2Eframe));
+
     /* initialize the active and unt=
rusted sessions */
 
     tls_session_init(multi, &multi->session[TM_ACTIVE=
]);
@@ -1302,9 +1285,11 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)
     =
{
-        tls_session_free(&multi->session[i], false, NULL);
+        tls_=
session_free(&multi->session[i], false);
     }
 
+    free_buf(&multi->to_=
link_buf);
+
     if (clear)
     {
         secure_memzero(multi, sizeof(*=
multi));
@@ -1840,13 +1825,13 @@
  * active key=2E
  */
 static void
-key_s=
tate_soft_reset(struct tls_session *session, struct buffer *to_link)
+key_s=
tate_soft_reset(struct tls_session *session)
 {
     struct key_state *ks =
=3D &session->key[KS_PRIMARY];        /* primary key */
     struct key_sta=
te *ks_lame =3D &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->=
must_die =3D now + session->opt->transition_window;    /* remaining lifetim=
e of old key */
-    key_state_free(ks_lame, false, to_link);
+    key_stat=
e_free(ks_lame, false);
     *ks_lame =3D *ks;
 
     key_state_init(sessio=
n, ks);
@@ -1857,7 +1842,7 @@
 void
 tls_session_soft_reset(struct tls_mult=
i *tls_multi)
 {
-    key_state_soft_reset(&tls_multi->session[TM_ACTIVE], =
NULL);
+    key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
 }
 
 /*
=
@@ -2945,18 +2930,15 @@
 
         const struct buffer *buf =3D reliable_se=
nd(ks->send_reliable, &opcode);
         ASSERT(buf);
-        struct buffe=
r b =3D *buf;
         INCR_SENT;
 
-        write_control_auth(session, ks=
, &b, to_link_addr, opcode, CONTROL_SEND_ACK_MAX, true);
-        *to_link =
=3D b;
+        write_control_auth(session, ks, buf, &multi->to_link_buf, t=
o_link_addr, opcode,
+                           CONTROL_SEND_ACK_MAX, true=
);
+        *to_link =3D multi->to_link_buf;
         dmsg(D_TLS_DEBUG, "Re=
liable -> TCP/UDP");
 
-        /* This changed the state of the outgoing b=
uffer=2E In order to avoid
-         * running this function again/further =
and invalidating the key_state
-         * buffer and accessing the buffer =
that is now in to_link after it being
-         * freed for a potential err=
or, we shortcircuit exiting of the outer
-         * process here=2E */
+  =
      /* This changed the state of the outgoing buffer=2E Stop this
+      =
   * processing pass so that the event loop can send the packet=2E */
     =
    return false;
     }
 
@@ -3196,13 +3178,13 @@
             session->op=
t->aead_usage_limit,
             ks->crypto_options=2Ekey_ctx_bi=2Edecrypt=
=2Eplaintext_blocks + ks->n_packets,
             session->opt->aead_usage_=
limit);
-        key_state_soft_reset(session, to_link);
+        key_state=
_soft_reset(session);
     }
 
     /* Kill lame duck key transition_window=
 seconds after primary key negotiation */
     if (lame_duck_must_die(sessi=
on, wakeup))
     {
-        key_state_free(ks_lame, true, to_link);
+     =
   key_state_free(ks_lame, true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_p=
rocess: killed expiring key");
     }
 
@@ -3251,8 +3233,9 @@
         {
  =
           struct buffer buf =3D ks->ack_write_buf;
             ASSERT(buf=
_init(&buf, multi->opt=2Eframe=2Ebuf=2Eheadroom));
-            write_contr=
ol_auth(session, ks, &buf, to_link_addr, P_ACK_V1, RELIABLE_ACK_SIZE, false=
);
-            *to_link =3D buf;
+            write_control_auth(session, =
ks, &buf, &multi->to_link_buf, to_link_addr, P_ACK_V1,
+                   =
            RELIABLE_ACK_SIZE, false);
+            *to_link =3D multi->to_=
link_buf;
             dmsg(D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
     =
    }
     }
@@ -3295,98 +3278,6 @@
     return false;
 }
 
-static void
-c=
heck_keystate_buf_not_used(struct buffer *to_link, const struct key_state *=
ks)
-{
-    if (ks->state =3D=3D S_UNDEF || !to_link || !to_link->data)
-  =
  {
-        return;
-    }
-
-    const uint8_t *dataptr =3D to_link->data=
;
-
-    /* we don't expect send_reliable to be NULL when state is
-     * =
not S_UNDEF, but people have reported crashes nonetheless,
-     * therefor=
e we better catch this event, report and exit=2E
-     */
-    if (!ks->sen=
d_reliable)
-    {
-        msg(M_FATAL,
-            "ERROR: ks=2Esend_rel=
iable (key-id %d), is NULL "
-            "while key state is %s=2E Exiting=
=2E",
-            ks->key_id, state_name(ks->state));
-    }
-
-    for (i=
nt j =3D 0; j < ks->send_reliable->size; j++)
-    {
-        if (ks->send_=
reliable->array[j]=2Ebuf=2Edata =3D=3D dataptr)
-        {
-            msg=
(M_INFO,
-                "Warning buffer of freed TLS session is still in"=

-                " use (key-id %d, ks=2Esend_reliable->array[%d])",
-     =
           ks->key_id, j);
-
-            goto used;
-        }
-    }
-
- =
   if (ks->ack_write_buf=2Edata =3D=3D dataptr)
-    {
-        msg(M_INFO,=
 "Warning buffer of freed TLS session is still in use "
-                  =
  "(ks=2Eack_write_buf, key-id %d)",
-            ks->key_id);
-
-        g=
oto used;
-    }
-    return;
-
-used:
-    to_link->len =3D 0;
-    to_lin=
k->data =3D 0;
-}
-
-/**
- * This is a safe guard function to double check =
that a buffer from a session is
- * not used in a session to avoid a use af=
ter free=2E
- *
- * @param to_link
- * @param session
- */
-static void
-ch=
eck_session_buf_not_used(struct buffer *to_link, struct tls_session *sessio=
n)
-{
-    if (!to_link || !to_link->data)
-    {
-        return;
-    }
-=
    const uint8_t *dataptr =3D to_link->data;
-
-    /* Checks buffers in t=
ls_wrap */
-    if (session->tls_wrap=2Ework=2Edata =3D=3D dataptr)
-    {
=
-        msg(M_INFO, "Warning buffer of freed TLS session is "
-           =
         "still in use (tls_wrap=2Ework=2Edata)");
-        goto used;
-   =
 }
-    if (session->tls_wrap_reneg=2Ework=2Edata =3D=3D dataptr)
-    {
- =
       msg(M_INFO, "Warning buffer of freed TLS session is "
-             =
       "still in use (tls_wrap_reneg=2Ework=2Edata)");
-        goto used;
=
-    }
-
-    for (int i =3D 0; i < KS_SIZE; i++)
-    {
-        const str=
uct key_state *ks =3D &session->key[i];
-        check_keystate_buf_not_use=
d(to_link, ks);
-    }
-    return;
-
-used:
-    to_link->len =3D 0;
-    =
to_link->data =3D 0;
-    /* for debugging, you can add an ASSERT(0); here =
to trigger an abort */
-}
 /*
  * Called by the top-level event loop=2E
  *=

@@ -3475,11 +3366,11 @@
                 if (i =3D=3D TM_ACTIVE && ks_lame=
->state >=3D S_GENERATED_KEYS
                     && !multi->opt=2Esingle_=
session)
                 {
-                    move_session(multi, TM_LAM=
E_DUCK, TM_ACTIVE, true, to_link);
+                    move_session(multi,=
 TM_LAME_DUCK, TM_ACTIVE, true);
                 }
                 else
 =
                {
-                    reset_session(multi, session, to_lin=
k);
+                    reset_session(multi, session);
                 }
=
             }
         }
@@ -3542,7 +3433,7 @@
      */
     if (lame_duck=
_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tls_sessi=
on_free(&multi->session[TM_LAME_DUCK], true, to_link);
+        tls_session=
_free(&multi->session[TM_LAME_DUCK], true);
         msg(D_TLS_DEBUG_LOW, "=
TLS: tls_multi_process: killed expiring key");
     }
 
@@ -3557,7 +3448,7 =
@@
      */
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL]=
=2Ekey[KS_PRIMARY]))
     {
-        move_session(multi, TM_ACTIVE, TM_INIT=
IAL, true, to_link);
+        move_session(multi, TM_ACTIVE, TM_INITIAL, tr=
ue);
         tas =3D tls_authentication_status(multi);
         msg(D_TLS_=
DEBUG_LOW,
             "TLS: tls_multi_process: initial untrusted "
@@ -40=
42,7 +3933,7 @@
                 goto done;
             }
 
-            k=
ey_state_soft_reset(session, NULL);
+            key_state_soft_reset(sessi=
on);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V=
1 s=3D%d sid=3D%s", i,
                  session_id_print(&sid, &gc));
diff=
 --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 4367=
70b=2E=2Ecf22be5 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/=
ssl_common=2Eh
@@ -635,6 +635,14 @@
      */
     struct link_socket_actual=
 to_link_addr;
 
+    /**
+     * Holds the outgoing control packet returne=
d by tls_multi_process=2E
+     * It belongs to the tls_multi and not to a =
session or key state, so
+     * it stays valid when these are freed or mov=
ed before the packet is
+     * written to the link=2E
+     */
+    struct=
 buffer to_link_buf;
+
     int n_sessions; /**< Number of sessions negotia=
ted thus
                      *   far=2E */
     enum multi_status multi_s=
tate;
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index =
60573ee=2E=2E9b2877b 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn=
/ssl_pkt=2Ec
@@ -168,10 +168,14 @@
 }
 
 void
-write_control_auth(struct tl=
s_session *session, struct key_state *ks, struct buffer *buf,
-            =
       struct link_socket_actual **to_link_addr, int opcode, int max_ack,
-=
                   bool prepend_ack)
+write_control_auth(struct tls_session=
 *session, struct key_state *ks, const struct buffer *payload,
+           =
        struct buffer *out, struct link_socket_actual **to_link_addr, int o=
pcode,
+                   int max_ack, bool prepend_ack)
 {
+    /* Work o=
n a copy so that tls_wrap_control can point it at another
+     * buffer wi=
thout modifying the caller's buffer */
+    struct buffer buf =3D *payload;=

+
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
     AS=
SERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
     uint8_t header =3D (=
uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
@@ -186,14 +190,20 @@
  =
   }
 
     ASSERT(link_socket_actual_defined(&ks->remote_addr));
-    ASSE=
RT(reliable_ack_write(ks->rec_ack, ks->lru_acks, buf, &ks->session_id_remot=
e, max_ack,
+    ASSERT(reliable_ack_write(ks->rec_ack, ks->lru_acks, &buf,=
 &ks->session_id_remote, max_ack,
                               prepend_ac=
k));
 
     msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcod=
e));
 
-    tls_wrap_control(tls_session_get_tls_wrap(session, ks->key_id),=
 header, buf,
+    tls_wrap_control(tls_session_get_tls_wrap(session, ks->k=
ey_id), header, &buf,
                      &session->session_id);
 
+    /=
* buf now points into memory owned by ks or session (the payload's
+     * =
buffer or the tls_wrap work buffer)=2E  Either can be freed before
+     * =
the packet is written to the link, so copy the packet to out=2E */
+    ASS=
ERT(buf_init(out, buf=2Eoffset));
+    ASSERT(buf_copy(out, &buf));
+
     =
*to_link_addr =3D &ks->remote_addr;
 }
 
diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh
index 8203e4a=2E=2Ed02b4b0 100644
--- a/src/=
openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -185,10 +185,29 @@
 bo=
ol check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const=
 struct openvpn_sockaddr *from,
                                    const u=
int8_t *key, int handwindow, bool pkt_is_ack);
 
-/*
- * Write a control ch=
annel authentication record=2E
+/**
+ * Write a control channel packet: add=
 the ACKs, the opcode and session id
+ * header and the tls-auth/tls-crypt =
wrapping to \c payload=2E
+ *
+ * @param session           the TLS session =
the packet belongs to
+ * @param ks                the key state the packet=
 belongs to
+ * @param payload           the packet payload=2E Its data is =
left
+ *                          unchanged, but the space around it in its=

+ *                          buffer is used to build the packet=2E
+ * @pa=
ram out               buffer the finished packet is written to, at
+ *     =
                     the offset it was built at=2E It must be owned
+ *    =
                      by the caller, not share memory with \c payload
+ *  =
                        or the tls_wrap work buffers, and have room for
+ *=
                          the packet at that offset (a buffer of
+ *       =
                   BUF_SIZE() of the session's frame does)=2E
+ * @param to=
_link_addr      set to the address the packet is sent to
+ * @param opcode =
           opcode of the packet
+ * @param max_ack           maximum number=
 of ACKs to add
+ * @param prepend_ack       add the ACKs in front of the p=
ayload instead
+ *                          of writing them into it
  */
-v=
oid write_control_auth(struct tls_session *session, struct key_state *ks, s=
truct buffer *buf,
+void write_control_auth(struct tls_session *session, st=
ruct key_state *ks,
+                        const struct buffer *payload, =
struct buffer *out,
                         struct link_socket_actual **to=
_link_addr, int opcode, int max_ack,
                         bool prepend_=
ack);
 
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tes=
ts/openvpn/test_pkt=2Ec
index 49ba833=2E=2E7614326 100644
--- a/tests/unit_=
tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -=
742,6 +742,108 @@
     free_tas(&tas);
 }
 
+/* write_control_auth() writes=
 the finished packet to the out buffer of the
+ * caller, so the packet sta=
ys valid when the buffers of the session and key
+ * state are reused or fr=
eed before it is sent=2E */
+static void
+check_write_control_auth_out_buf(=
struct tls_wrap_ctx *wrap, struct tls_wrap_ctx *peer_wrap)
+{
+    struct t=
ls_options opt =3D { 0 };
+    opt=2Eserver =3D true;
+
+    struct tls_ses=
sion session =3D { 0 };
+    session=2Eopt =3D &opt;
+    session=2Etls_wra=
p =3D *wrap;
+    session=2Esession_id =3D (struct session_id){ { 1, 2, 3, =
4, 5, 6, 7, 8 } };
+
+    struct reliable_ack rec_ack =3D { =2Elen =3D 1, =
=2Epacket_id =3D { 7 } };
+    struct reliable_ack lru_acks =3D { 0 };
+   =
 struct key_state ks =3D { 0 };
+    ks=2Erec_ack =3D &rec_ack;
+    ks=2El=
ru_acks =3D &lru_acks;
+    ks=2Esession_id_remote =3D (struct session_id){=
 { 8, 7, 6, 5, 4, 3, 2, 1 } };
+    ks=2Eremote_addr=2Edest=2Eaddr=2Esa=2Es=
a_family =3D AF_INET;
+    ks=2Eremote_addr=2Edest=2Eaddr=2Ein4=2Esin_addr=
=2Es_addr =3D htonl(0x01020304);
+
+    const uint8_t data[] =3D "control c=
hannel payload";
+    struct buffer payload =3D alloc_buf(1600);
+    struc=
t buffer out =3D alloc_buf(1600);
+
+    /* a control packet with the ACK i=
n front of its payload, as sent from
+     * the reliability layer, and a d=
edicated ACK packet */
+    for (int i =3D 0; i < 2; i++)
+    {
+        c=
onst bool dedicated_ack =3D (i =3D=3D 1);
+        const size_t len =3D ded=
icated_ack ? 0 : sizeof(data);
+
+        assert_true(buf_init(&payload, 20=
0));
+        assert_true(buf_write(&payload, data, len));
+
+        struc=
t link_socket_actual *to_link_addr =3D NULL;
+        write_control_auth(&s=
ession, &ks, &payload, &out, &to_link_addr,
+                           ded=
icated_ack ? P_ACK_V1 : P_CONTROL_V1, RELIABLE_ACK_SIZE,
+                 =
          !dedicated_ack);
+
+        assert_ptr_equal(to_link_addr, &ks=2E=
remote_addr);
+        assert_int_equal(BLEN(&payload), len);
+        asse=
rt_memory_equal(BPTR(&payload), data, len);
+        assert_true(BLENZ(&out=
) > len);
+
+        /* the packet is still intact after the session buffer=
s are overwritten */
+        memset(payload=2Edata, 0x55, (size_t)payload=
=2Ecapacity);
+        if (session=2Etls_wrap=2Ework=2Edata)
+        {
+  =
          memset(session=2Etls_wrap=2Ework=2Edata, 0x55, (size_t)session=2E=
tls_wrap=2Ework=2Ecapacity);
+        }
+
+        struct link_socket_actua=
l from =3D { 0 };
+        assert_true(read_control_auth(&out, peer_wrap, &=
from, &opt));
+
+        struct reliable_ack ack;
+        struct session_i=
d sid;
+        assert_true(reliable_ack_parse(&out, &ack, &sid));
+       =
 assert_int_equal(ack=2Elen, 1);
+        assert_int_equal(ack=2Epacket_id[=
0], 7);
+        assert_memory_equal(&sid, &ks=2Esession_id_remote, SID_SIZ=
E);
+        assert_int_equal(BLEN(&out), len);
+        assert_memory_equa=
l(BPTR(&out), data, len);
+    }
+
+    free_buf(&out);
+    free_buf(&payl=
oad);
+}
+
+static void
+test_write_control_auth_out_buf(void **ut_state)
+=
{
+    now =3D 0x22446688;
+
+    struct tls_wrap_ctx none =3D { =2Emode =
=3D TLS_WRAP_NONE };
+    check_write_control_auth_out_buf(&none, &none);
+=

+    struct tls_auth_standalone tas_client =3D init_tas_auth(KEY_DIRECTION=
_INVERSE);
+    struct tls_auth_standalone tas_server =3D init_tas_auth(KEY=
_DIRECTION_NORMAL);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epack=
et_id, 5, 5, "UNITTEST", 0);
+    packet_id_init(&tas_server=2Etls_wrap=2Eo=
pt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas_client=
=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+    check_write_control_auth_out_bu=
f(&tas_client=2Etls_wrap, &tas_server=2Etls_wrap);
+    packet_id_free(&tas=
_client=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_server=2Etl=
s_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_s=
erver);
+
+    tas_client =3D init_tas_crypt(false);
+    tas_server =3D in=
it_tas_crypt(true);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epack=
et_id, 5, 5, "UNITTEST", 0);
+    packet_id_init(&tas_server=2Etls_wrap=2Eo=
pt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas_client=
=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+    check_write_control_auth_out_bu=
f(&tas_client=2Etls_wrap, &tas_server=2Etls_wrap);
+    packet_id_free(&tas=
_client=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_server=2Etl=
s_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_s=
erver);
+}
+
 static void
 test_extract_control_message(void **ut_state)
 {=

@@ -793,6 +895,7 @@
         cmocka_unit_test(test_generate_reset_packet_p=
lain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
    =
     cmocka_unit_test(test_wkc_not_appended_without_key),
+        cmocka_u=
nit_test(test_write_control_auth_out_buf),
         cmocka_unit_test(test_e=
xtract_control_message)
     };
 

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Gerrit-Change-=
Number: 2002
Gerrit-PatchSet: 2
Gerrit-Owner: Alejandro <alepacheco99@gmail=
=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quar=
tulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--+oRw+WS8vhY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Alejandro =
<strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a>=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Keep the outgoing control packet in a buffer owned by tls=
_multi<br><br>tls_multi_process() returns the outgoing control packet in to=
_link=2E<br>Until now to_link pointed into memory owned by a session or key=
 state:<br>the reliable send buffer, ks-&gt;ack_write_buf, or the tls_wrap =
or<br>tls_wrap_reneg work buffer=2E  When that session or key state was fre=
ed<br>or reset before the packet was written to the link, to_link was left<=
br>pointing to freed memory=2E  This caused CVE-2023-46850, CVE-2026-40215,=
<br>CVE-2026-12996, CVE-2026-13117 and CVE-2026-84471=2E<br><br>The fixes s=
o far added check_session_buf_not_used() and<br>check_keystate_buf_not_used=
(), which compare to_link against a list of<br>the buffers of a session or =
key state before it is freed and drop the<br>packet on a match=2E  This onl=
y works as long as the list names every<br>buffer a packet can end up in an=
d every caller that frees a session or<br>key state passes to_link down: ke=
y_state_soft_reset() is called without<br>it from tls_pre_decrypt() and tls=
_session_soft_reset()=2E<br><br>Fix the ownership instead=2E  write_control=
_auth() now copies the<br>finished packet into a buffer the caller owns, an=
d tls_multi_process()<br>returns it in multi-&gt;to_link_buf, which lives a=
s long as the tls_multi,<br>like multi-&gt;to_link_addr already does for th=
e address=2E  Freeing or<br>moving sessions and key states no longer affect=
s a pending packet, so<br>the checks and the to_link parameters of key_stat=
e_free(),<br>tls_session_free(), move_session(), reset_session() and<br>key=
_state_soft_reset() are removed=2E  A packet that is pending when its<br>se=
ssion is freed is now sent instead of dropped; the peer handles it<br>like =
any late packet of that session=2E<br><br>The copy costs one memcpy of a co=
ntrol channel packet=2E  The new unit<br>test checks that the packet writte=
n by write_control_auth() stays<br>intact and valid after the buffers it wa=
s built from are overwritten,<br>with no wrapping, tls-auth and tls-crypt=
=2E<br><br>Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793<br>Signed-o=
ff-by: Alejandro Pacheco &lt;alepacheco99@gmail=2Ecom&gt;<br>---<br>M src/o=
penvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_pkt=2Ec=
<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br=
>5 files changed, 178 insertions(+), 147 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2=
002/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span>=
<br><span>index 00e1712=2E=2E8091c75 100644</span><br><span>--- a/src/openv=
pn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -97=
,14 +97,6 @@</span><br><span> </span><br><span> #endif /* ifdef MEASURE_TLS=
_HANDSHAKE_STATS */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/* forward decleration since tls_process needs this functio=
n prototype */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_session_buf=
_not_used(struct buffer *to_link, struct tls_session *session);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-check_keystate_buf_not_used(struct buffer *to_link, const struct=
 key_state *ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * Limit the reneg_bytes value when using a small-block (&lt;1=
28 bytes) cipher=2E</span><br><span>  *</span><br><span>@@ -917,15 +909,10 =
@@</span><br><span>  *                       cleaned up=2E</span><br><span>=
  * @param clear        - Whether the memory allocated for the \a ks object=
</span><br><span>  *                       should be overwritten with 0s=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param to_link      - if not NULL, ch=
eck that the buffer does not contain</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *                       any pointer to one of the internal =
structs of ks</span><br><span>  */</span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state *=
ks, bool clear, struct buffer *to_link)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+key_state_free(struct key_state *ks, bool clear)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    check=
_keystate_buf_not_used(to_link, ks);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><s=
pan> </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><b=
r><span>@@ -1074,14 +1061,10 @@</span><br><span>  *                       o=
bject should be overwritten with 0s=2E This</span><br><span>  *            =
           implicitly sets many states to 0/false,</span><br><span>  *     =
                  e=2Eg=2E the validity of the keys in the structure</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param to_link      - if =
not NULL, check that the buffer does not contain</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *                       any pointer to one of t=
he internal structs of ks</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span>  */</span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tls_session_free(struct tls_session *ses=
sion, bool clear, struct buffer *to_link)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tls_session_free(struct tls_session *session, bool cl=
ear)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    check_session_buf_not_used(to_link, session);</span><br><span>     tl=
s_wrap_free(&amp;session-&gt;tls_wrap);</span><br><span>     tls_wrap_free(=
&amp;session-&gt;tls_wrap_reneg);</span><br><span> </span><br><span>@@ -109=
0,7 +1073,7 @@</span><br><span>         /* we don&#39;t need clear=3Dtrue f=
or this call since</span><br><span>          * the structs are part of sess=
ion and get cleared</span><br><span>          * as part of session */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(&amp=
;session-&gt;key[i], false, to_link);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        key_state_free(&amp;session-&gt;key[i], false);</=
span><br><span>     }</span><br><span> </span><br><span>     free(session-&=
gt;common_name);</span><br><span>@@ -1109,16 +1092,14 @@</span><br><span> <=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-move_session(struct tls_multi *multi, int dest, in=
t src, bool reinit_src,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             struct buffer *to_link)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+move_session(struct tls_multi *multi, int dest, int src,=
 bool reinit_src)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    check_session_buf_not_used(to_link, &amp;multi-&gt;sessi=
on[dest]);</span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move_sessio=
n: dest=3D%s src=3D%s reinit_src=3D%d&quot;,</span><br><span>         sessi=
on_index_name(dest), session_index_name(src), reinit_src);</span><br><span>=
     ASSERT(src !=3D dest);</span><br><span>     ASSERT(src &gt;=3D 0 &amp;=
&amp; src &lt; TM_SIZE);</span><br><span>     ASSERT(dest &gt;=3D 0 &amp;&a=
mp; dest &lt; TM_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    tls_session_free(&amp;multi-&gt;session[dest], false, to_link);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(&amp=
;multi-&gt;session[dest], false);</span><br><span>     multi-&gt;session[de=
st] =3D multi-&gt;session[src];</span><br><span> </span><br><span>     if (=
reinit_src)</span><br><span>@@ -1134,9 +1115,9 @@</span><br><span> }</span>=
<br><span> </span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-reset_session(struct tls_multi *multi, struct tls_sessio=
n *session, struct buffer *to_link)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+reset_session(struct tls_multi *multi, struct tls_session *=
session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    tls_session_free(session, false, to_link);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(session, false);</sp=
an><br><span>     tls_session_init(multi, session);</span><br><span> }</spa=
n><br><span> </span><br><span>@@ -1210,6 +1191,8 @@</span><br><span> tls_mu=
lti_init_finalize(struct tls_multi *multi, int tls_mtu)</span><br><span> {<=
/span><br><span>     tls_init_control_channel_frame_parameters(&amp;multi-&=
gt;opt=2Eframe, tls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    multi-&gt;to_link_buf =3D alloc_buf((size_t)BUF_SIZE(&amp;multi-&=
gt;opt=2Eframe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     /* initialize the active and untrusted sessions */</spa=
n><br><span> </span><br><span>     tls_session_init(multi, &amp;multi-&gt;s=
ession[TM_ACTIVE]);</span><br><span>@@ -1302,9 +1285,11 @@</span><br><span>=
 </span><br><span>     for (int i =3D 0; i &lt; TM_SIZE; ++i)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_=
session_free(&amp;multi-&gt;session[i], false, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;s=
ession[i], false);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;multi-&gt;to_link=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     if (clear)</span><br><span>     {</span><br><span>         secure_=
memzero(multi, sizeof(*multi));</span><br><span>@@ -1840,13 +1825,13 @@</sp=
an><br><span>  * active key=2E</span><br><span>  */</span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_soft_r=
eset(struct tls_session *session, struct buffer *to_link)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+key_state_soft_reset(struct tls_sessi=
on *session)</span><br><span> {</span><br><span>     struct key_state *ks =
=3D &amp;session-&gt;key[KS_PRIMARY];        /* primary key */</span><br><s=
pan>     struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK]; =
/* retiring key */</span><br><span> </span><br><span>     ks-&gt;must_die =
=3D now + session-&gt;opt-&gt;transition_window;    /* remaining lifetime o=
f old key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_s=
tate_free(ks_lame, false, to_link);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    key_state_free(ks_lame, false);</span><br><span>     *k=
s_lame =3D *ks;</span><br><span> </span><br><span>     key_state_init(sessi=
on, ks);</span><br><span>@@ -1857,7 +1842,7 @@</span><br><span> void</span>=
<br><span> tls_session_soft_reset(struct tls_multi *tls_multi)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_state_s=
oft_reset(&amp;tls_multi-&gt;session[TM_ACTIVE], NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    key_state_soft_reset(&amp;tls_multi=
-&gt;session[TM_ACTIVE]);</span><br><span> }</span><br><span> </span><br><s=
pan> /*</span><br><span>@@ -2945,18 +2930,15 @@</span><br><span> </span><br=
><span>         const struct buffer *buf =3D reliable_send(ks-&gt;send_reli=
able, &amp;opcode);</span><br><span>         ASSERT(buf);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct buffer b =3D *buf;</span=
><br><span>         INCR_SENT;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        write_control_auth(session, ks, &amp;b, =
to_link_addr, opcode, CONTROL_SEND_ACK_MAX, true);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        *to_link =3D b;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        write_control_auth(session, ks, b=
uf, &amp;multi-&gt;to_link_buf, to_link_addr, opcode,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           CONTROL_SEND_A=
CK_MAX, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   *to_link =3D multi-&gt;to_link_buf;</span><br><span>         dmsg(D_TLS_=
DEBUG, &quot;Reliable -&gt; TCP/UDP&quot;);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* This changed the state o=
f the outgoing buffer=2E In order to avoid</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * running this function again/further and inv=
alidating the key_state</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * buffer and accessing the buffer that is now in to_link after i=
t being</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * fre=
ed for a potential error, we shortcircuit exiting of the outer</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         * process here=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This changed =
the state of the outgoing buffer=2E Stop this</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * processing pass so that the event loop=
 can send the packet=2E */</span><br><span>         return false;</span><br=
><span>     }</span><br><span> </span><br><span>@@ -3196,13 +3178,13 @@</sp=
an><br><span>             session-&gt;opt-&gt;aead_usage_limit,</span><br><=
span>             ks-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_=
blocks + ks-&gt;n_packets,</span><br><span>             session-&gt;opt-&gt=
;aead_usage_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      key_state_soft_reset(session, to_link);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        key_state_soft_reset(session);</span><br>=
<span>     }</span><br><span> </span><br><span>     /* Kill lame duck key t=
ransition_window seconds after primary key negotiation */</span><br><span> =
    if (lame_duck_must_die(session, wakeup))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(ks_lam=
e, true, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       key_state_free(ks_lame, true);</span><br><span>         msg(D_TLS_DE=
BUG_LOW, &quot;TLS: tls_process: killed expiring key&quot;);</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -3251,8 +3233,9 @@</span><br>=
<span>         {</span><br><span>             struct buffer buf =3D ks-&gt;=
ack_write_buf;</span><br><span>             ASSERT(buf_init(&amp;buf, multi=
-&gt;opt=2Eframe=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            write_control_auth(session, ks, &amp;buf, to_lin=
k_addr, P_ACK_V1, RELIABLE_ACK_SIZE, false);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            *to_link =3D buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            write_control_auth(session, k=
s, &amp;buf, &amp;multi-&gt;to_link_buf, to_link_addr, P_ACK_V1,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
 RELIABLE_ACK_SIZE, false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            *to_link =3D multi-&gt;to_link_buf;</span><br><span>   =
          dmsg(D_TLS_DEBUG, &quot;Dedicated ACK -&gt; TCP/UDP&quot;);</span=
><br><span>         }</span><br><span>     }</span><br><span>@@ -3295,98 +3=
278,6 @@</span><br><span>     return false;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-check_keystate_buf_not_use=
d(struct buffer *to_link, const struct key_state *ks)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (ks-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt=
;data)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* we don&#39;t expect send_reliable to be NULL when state is</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * not S_UNDEF, but =
people have reported crashes nonetheless,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * therefore we better catch this event, report and=
 exit=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ks-&gt;send_reliab=
le)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &quot;ERROR: ks=2Esend_=
reliable (key-id %d), is NULL &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &quot;while key state is %s=2E Exiting=2E&quot;,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;ke=
y_id, state_name(ks-&gt;state));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int j =3D 0; j &l=
t; ks-&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Warning b=
uffer of freed TLS session is still in&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot; use (key-id %d, ks=2Esend_rel=
iable-&gt;array[%d])&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                ks-&gt;key_id, j);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          goto used;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Warning bu=
ffer of freed TLS session is still in use &quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    &quot;(ks=2Eack_write_buf, k=
ey-id %d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       ks-&gt;key_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto used;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-used:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to_link=
-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to=
_link-&gt;data =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * This is a safe guard function to double check that a buf=
fer from a session is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * not used in a session to avoid a use after free=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param to_link</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param session</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_session_buf_not_u=
sed(struct buffer *to_link, struct tls_session *session)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!to_link || !to_link-&gt;data)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* Checks buffers in tls_wrap */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (session-&gt;tls_wrap=2Ework=2Edata =3D=3D dataptr)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Warning buffe=
r of freed TLS session is &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    &quot;still in use (tls_wrap=2Ework=2Edata)&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto u=
sed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (session-&gt;tls_wrap_rene=
g=2Ework=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_INFO, &quot;Warning buffer of freed TLS session is &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;still=
 in use (tls_wrap_reneg=2Ework=2Edata)&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        goto used;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =
=3D 0; i &lt; KS_SIZE; i++)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        check_keystate_buf_not_used(to_link=
, ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-used:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 to_link-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    to_link-&gt;data =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* for debugging, you can add an ASSERT(0); here to trigger an =
abort */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span> /*</span><br><span>  * Called by the top-level event loop=2E</span><b=
r><span>  *</span><br><span>@@ -3475,11 +3366,11 @@</span><br><span>       =
          if (i =3D=3D TM_ACTIVE &amp;&amp; ks_lame-&gt;state &gt;=3D S_GEN=
ERATED_KEYS</span><br><span>                     &amp;&amp; !multi-&gt;opt=
=2Esingle_session)</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    move_session(multi, TM_=
LAME_DUCK, TM_ACTIVE, true, to_link);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    move_session(multi, TM_LAME_DUCK, TM_=
ACTIVE, true);</span><br><span>                 }</span><br><span>         =
        else</span><br><span>                 {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    reset_session(multi, session,=
 to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           reset_session(multi, session);</span><br><span>                 =
}</span><br><span>             }</span><br><span>         }</span><br><span=
>@@ -3542,7 +3433,7 @@</span><br><span>      */</span><br><span>     if (la=
me_duck_must_die(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tl=
s_session_free(&amp;multi-&gt;session[TM_LAME_DUCK], true, to_link);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&=
amp;multi-&gt;session[TM_LAME_DUCK], true);</span><br><span>         msg(D_=
TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: killed expiring key&quot;);</s=
pan><br><span>     }</span><br><span> </span><br><span>@@ -3557,7 +3448,7 @=
@</span><br><span>      */</span><br><span>     if (TLS_AUTHENTICATED(multi=
, &amp;multi-&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        move_sess=
ion(multi, TM_ACTIVE, TM_INITIAL, true, to_link);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        move_session(multi, TM_ACTIVE, TM_INI=
TIAL, true);</span><br><span>         tas =3D tls_authentication_status(mul=
ti);</span><br><span>         msg(D_TLS_DEBUG_LOW,</span><br><span>        =
     &quot;TLS: tls_multi_process: initial untrusted &quot;</span><br><span=
>@@ -4042,7 +3933,7 @@</span><br><span>                 goto done;</span><b=
r><span>             }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            key_state_soft_reset(session, NULL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            key_state_soft_=
reset(session);</span><br><span> </span><br><span>             dmsg(D_TLS_D=
EBUG, &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,=
</span><br><span>                  session_id_print(&amp;sid, &amp;gc));</s=
pan><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_com=
mon=2Eh</span><br><span>index 436770b=2E=2Ecf22be5 100644</span><br><span>-=
-- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_commo=
n=2Eh</span><br><span>@@ -635,6 +635,14 @@</span><br><span>      */</span><=
br><span>     struct link_socket_actual to_link_addr;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * Holds the outgoing control p=
acket returned by tls_multi_process=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * It belongs to the tls_multi and not to a session =
or key state, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * it stays valid when these are freed or moved before the packet is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * written to the lin=
k=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer to_link_b=
uf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     int n_sessions; /**&lt; Number of sessions negotiated thus</span><br>=
<span>                      *   far=2E */</span><br><span>     enum multi_s=
tatus multi_state;</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/s=
rc/openvpn/ssl_pkt=2Ec</span><br><span>index 60573ee=2E=2E9b2877b 100644</s=
pan><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openv=
pn/ssl_pkt=2Ec</span><br><span>@@ -168,10 +168,14 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-write_control_auth(struct tls_session *session, struct key_s=
tate *ks, struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                   struct link_socket_actual **to_link_addr, int op=
code, int max_ack,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                bool prepend_ack)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+write_control_auth(struct tls_session *session, struct key_st=
ate *ks, const struct buffer *payload,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                   struct buffer *out, struct link_socke=
t_actual **to_link_addr, int opcode,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                   int max_ack, bool prepend_ack)</span><b=
r><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wo=
rk on a copy so that tls_wrap_control can point it at another</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * buffer without modifying t=
he caller&#39;s buffer */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D *payload;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 =
&amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span>     ASSER=
T(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><spa=
n>     uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCO=
DE_SHIFT));</span><br><span>@@ -186,14 +190,20 @@</span><br><span>     }</s=
pan><br><span> </span><br><span>     ASSERT(link_socket_actual_defined(&amp=
;ks-&gt;remote_addr));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ASSERT(reliable_ack_write(ks-&gt;rec_ack, ks-&gt;lru_acks, buf, &amp;k=
s-&gt;session_id_remote, max_ack,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(reliable_ack_write(ks-&gt;rec_ack, ks-&gt;lru_acks=
, &amp;buf, &amp;ks-&gt;session_id_remote, max_ack,</span><br><span>       =
                        prepend_ack));</span><br><span> </span><br><span>  =
   msg(D_TLS_DEBUG, &quot;%s(): %s&quot;, __func__, packet_opcode_name(opco=
de));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    tls_wrap_control(tls_session_get_tls_wrap(session, ks-&gt;key_id), he=
ader, buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_w=
rap_control(tls_session_get_tls_wrap(session, ks-&gt;key_id), header, &amp;=
buf,</span><br><span>                      &amp;session-&gt;session_id);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* buf now points into memory owned by ks or session (the payload&#39;s</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * buffer or the tl=
s_wrap work buffer)=2E  Either can be freed before</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * the packet is written to the link, so=
 copy the packet to out=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(buf_init(out, buf=2Eoffset));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(buf_copy(out, &amp;buf));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     *to_l=
ink_addr =3D &amp;ks-&gt;remote_addr;</span><br><span> }</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>index 8203e4a=2E=2Ed02b4b0 100644</span><br><span>--- =
a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>@@ -185,10 +185,29 @@</span><br><span> bool check_session_hmac=
_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_socka=
ddr *from,</span><br><span>                                    const uint8_=
t *key, int handwindow, bool pkt_is_ack);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Write a control channel authentication record=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Write a control channel packet: add t=
he ACKs, the opcode and session id</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * header and the tls-auth/tls-crypt wrapping to \c payload=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param session           the T=
LS session the packet belongs to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param ks                the key state the packet belongs t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload =
          the packet payload=2E Its data is left</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                          unchanged, but the=
 space around it in its</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *                          buffer is used to build the packet=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param out            =
   buffer the finished packet is written to, at</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *                          the offset it was b=
uilt at=2E It must be owned</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                          by the caller, not share memory with \c=
 payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
                 or the tls_wrap work buffers, and have room for</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *                          th=
e packet at that offset (a buffer of</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                          BUF_SIZE() of the session&#39;=
s frame does)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param to_link_addr      set to the address the packet is sent to</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opcode            o=
pcode of the packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param max_ack           maximum number of ACKs to add</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param prepend_ack       add the A=
CKs in front of the payload instead</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *                          of writing them into it</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void wri=
te_control_auth(struct tls_session *session, struct key_state *ks, struct b=
uffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void wri=
te_control_auth(struct tls_session *session, struct key_state *ks,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        cons=
t struct buffer *payload, struct buffer *out,</span><br><span>             =
            struct link_socket_actual **to_link_addr, int opcode, int max_a=
ck,</span><br><span>                         bool prepend_ack);</span><br><=
span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b=
/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index 49ba833=2E=2E7=
614326 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>=
@@ -742,6 +742,108 @@</span><br><span>     free_tas(&amp;tas);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* write_control_auth() writes the finished packet to the out buffer o=
f the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * caller, so =
the packet stays valid when the buffers of the session and key</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * state are reused or freed bef=
ore it is sent=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_w=
rite_control_auth_out_buf(struct tls_wrap_ctx *wrap, struct tls_wrap_ctx *p=
eer_wrap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_options opt =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt=
=2Eserver =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_sess=
ion session =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    session=2Eopt =3D &amp;opt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    session=2Etls_wrap =3D *wrap;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    session=2Esession_id =3D (struct session_i=
d){ { 1, 2, 3, 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct reliable_ack rec_ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 7 } };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable_ac=
k lru_acks =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct key_state ks =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ks=2Erec_ack =3D &amp;rec_ack;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ks=2Elru_acks =3D &amp;lru_acks;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks=2Esession_id_remo=
te =3D (struct session_id){ { 8, 7, 6, 5, 4, 3, 2, 1 } };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ks=2Eremote_addr=2Edest=2Eaddr=2E=
sa=2Esa_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ks=2Eremote_addr=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ht=
onl(0x01020304);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t data=
[] =3D &quot;control channel payload&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf(1600);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =
=3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a control p=
acket with the ACK in front of its payload, as sent from</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * the reliability layer, and a de=
dicated ACK packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (int i =3D 0; i &lt; 2; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const bool dedicated_ack =3D (i =3D=3D 1);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const size_t len =3D dedicated_=
ack ? 0 : sizeof(data);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_=
true(buf_init(&amp;payload, 200));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        assert_true(buf_write(&amp;payload, data, len));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct link_socket_actual *to_lin=
k_addr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     write_control_auth(&amp;session, &amp;ks, &amp;payload, &amp;out, &amp=
;to_link_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                      dedicated_ack ? P_ACK_V1 : P_CONTROL_V1, RELIABLE_ACK=
_SIZE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              !dedicated_ack);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_ptr_equal(to_link_addr, &amp;ks=2Eremote_addr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(BLEN(&amp;paylo=
ad), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
ssert_memory_equal(BPTR(&amp;payload), data, len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        assert_true(BLENZ(&amp;out) &gt; len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* the packet is still intac=
t after the session buffers are overwritten */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        memset(payload=2Edata, 0x55, (size_t)pay=
load=2Ecapacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (session=2Etls_wrap=2Ework=2Edata)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            memset(session=2Etls_wrap=2Ework=2Edata, 0x55, (s=
ize_t)session=2Etls_wrap=2Ework=2Ecapacity);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct link_socket_actual from =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        assert_true(read_control_auth(&amp;out, p=
eer_wrap, &amp;from, &amp;opt));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct reliable_ack ack;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct session_id sid;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        assert_true(reliable_ack_parse(&amp;out, &amp;ack=
, &amp;sid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  assert_int_equal(ack=2Elen, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        assert_int_equal(ack=2Epacket_id[0], 7);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(&amp=
;sid, &amp;ks=2Esession_id_remote, SID_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        assert_int_equal(BLEN(&amp;out), len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_=
equal(BPTR(&amp;out), data, len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;o=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&a=
mp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_write_control_auth_out_buf(void **ut_state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_wrap_ctx none =3D { =2Emode =3D TLS_WRAP_=
NONE };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_wr=
ite_control_auth_out_buf(&amp;none, &amp;none);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct tls_auth_standalone tas_client =3D init_tas_auth(KEY_DI=
RECTION_INVERSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECTION_NOR=
MAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_=
init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quo=
t;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_i=
d_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&q=
uot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_=
packet_id_send(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    check_write_control_au=
th_out_buf(&amp;tas_client=2Etls_wrap, &amp;tas_server=2Etls_wrap);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas=
_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epa=
cket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_t=
as(&amp;tas_client);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free_tas(&amp;tas_server);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=
_client =3D init_tas_crypt(false);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    tas_server =3D init_tas_crypt(true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etl=
s_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_server=2E=
tls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;tas_c=
lient=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    check_write_control_auth_out_buf(&amp;tas_clien=
t=2Etls_wrap, &amp;tas_server=2Etls_wrap);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=
=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
acket_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_s=
erver);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void<=
/span><br><span> test_extract_control_message(void **ut_state)</span><br><s=
pan> {</span><br><span>@@ -793,6 +895,7 @@</span><br><span>         cmocka_=
unit_test(test_generate_reset_packet_plain),</span><br><span>         cmock=
a_unit_test(test_generate_reset_packet_tls_auth),</span><br><span>         =
cmocka_unit_test(test_wkc_not_appended_without_key),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_write_contr=
ol_auth_out_buf),</span><br><span>         cmocka_unit_test(test_extract_co=
ntrol_message)</span><br><span>     };</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">chang=
e 2002</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2002 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Alejandr=
o &lt;alepacheco99@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--+oRw+WS8vhY=--


--===============1928058239667094724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1928058239667094724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1928058239667094724==--


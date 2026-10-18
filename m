Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CFACCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdY0MNwafYX2fRQoTKSTYlxoGTwrbnMdB4Dw8UnwIwY=; b=glbnkGhQIXiGM5j22WcROpULaT
	BsqviqmTj1+G2hjKO4ld9aB3lqCeahFy22Ma9A1tTMloLsGHqn+5VYXNRglv4QiSIypuV7sNFOyKF
	dNbqnAarg2LeTvBaoxxQGW2qOK8QSpbFjW/jpXs/h5ZUm2WdgnXzHp5aYrI5kvOoYSt8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISWP-0001Ak-1a;
	Sun, 18 Oct 2026 15:10:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xISWN-0001Ac-3m
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WVLbh8izq2i0PH00OuyhMqjB6TFLZok7hotsqk9LmXs=; b=VOZamLMcbYZBQQjAmZ1Pu/pm6L
 xxnTnztIxYlDLX0sAF/I8qHxVHnvJ/1wX1u0a+9zW2YrvayC4qRDbETjFnYLFWunOBTw6TwYxhQWC
 U9ugIsBbjiN6pkPRbFPhulZUpVLt7lwYXEHm8kupmg/XYpBcFnkYAMNAdNQJbYIeTyfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WVLbh8izq2i0PH00OuyhMqjB6TFLZok7hotsqk9LmXs=; b=g
 QnHISbOnAL7qtKg3csbrL+GOgTF5HpQLIBPQobJPiIQW3bVEBwyBe/+JGLg3CdPTf9ZOCjeAgLIav
 vYY6inzFwUAK4onI11J7SIZal7pFKBSnmMTqyqg7faM4plCUrjevmYgirL/Yi311tSSApOAtcxkLP
 /3ScqDqXMlhurn8c=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xISWK-0007Hg-H1 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:09:58 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so12491685e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792336190; x=1792940990; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WVLbh8izq2i0PH00OuyhMqjB6TFLZok7hotsqk9LmXs=;
 b=J8L8cLYWQO23aWMC4eWqLLB60x/VMi+0rbuS6eEdeuHSI1VAvRMmFRIJ2WHkN+ml5V
 zEgGJmSXPhJn2CGRaTbG82CF5wFXhmHFEVQI+AS+S4gNroclV696/FwsBwlkhZL+W/uA
 ULNSqC4HJt/o7laGutEf/U8HzHw7nHd3wLciNpvWSXoQ6OpSGT+y5XdmE/BUlQKIEr4o
 fsv1v2OOgHkzGKrYfz4VmQEm6vLOsLJgXmFlf5xT7a50fBDhcPe4El/wWGv7Vf1QBLiX
 2Z69fcEePioyBzpvK9VKp3M6XAjrSM7iBzroG2PyDWBkWODMtewXW6Qeo8t6Z02N5G/Y
 PQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792336190; x=1792940990;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WVLbh8izq2i0PH00OuyhMqjB6TFLZok7hotsqk9LmXs=;
 b=JCrlwjTclCbOYaPclGK7DnApdJOYnHubvmYWHsnVGQaVWo+fzo46ggbLA+AURVb9BO
 hrIMY4dZN2F9FLsUpRwPOLHVd3ynYF/cJCs12hoxg/EZEWB2yvOWBgtF6bcmLuMMdCP3
 HaJzEJV47lDufT1De7lf3ACLwEFHZflo6JO8pKguC7T0k+GO4GAzHj4YrwQzf/Li1NtC
 UeuIgMGI1tuUhQ7ZgX5wEIIkVEq7LP2nR6jBnVwIGXuyVgJljdCGUJUqXT2wTa0ntxJi
 RBHFccg8OhoRDkqkibZ3QOoRZeSgu9uQ+HxBGPudYiCzoSGVh20mlAvSbYUAr2Yqsu9I
 IiCA==
X-Gm-Message-State: AFq9FYJsswxta+5KrOvUqILeq5W1eF4wP5EvTCozz7dSfdlH8U5iyhT1
 L6jibOEQaxrNFuHS0hq7eCugSO/8gmIThbK9FKRAtDPM4sT9TGSecJAgfnnvGoLqT/YYQewvIAY
 jO0JcANROnJmNx8XZvu8G9jMVJXr403Kkowkw+G8QIh63HXAp/cA3Jow2hLQ14qYdNaxJ
X-Gm-Gg: AYBFou14AQyV+yIp/gOimwsVrUmuVAnRqwQkj1IUPeGFHKgRYqWO30BNeWTK4OKvSax
 ApY+VcO2/ePI5dVSaINZgEC8DOZA+A2PM6sNDIKY2IUrV90LDO7OqyDAUrg7b538OruosrAjePw
 qTNVDK+U6smjFMRXGkSF408WvRoOCTJ2Y3/3wI9/Om5XHPyQ+i1DCEui89PnRsP1NZMD0trHerC
 dBvqWEs12PvgspAaky5ehLa84kLqHhwcUhQKAy3Or9ySvQKB+iv+niXRP1juGnGduG/SjO4DxDi
 45ETy+CrCARIEw4Jx9SSxencGSt0cWfV4Ubi3CzH9JoJAClZP/W8XSJ5P/svsGKos3u3cGQ6lB2
 qpUJq5o7xDSJh7IgdK//UtGtbWMn2V1jmJ1JpuRq66P7JlS7+CYSlBMpQzdSSCMEhWcT40VwUEo
 zYUC/8qbuIwn2r7R0dQ8dy3gugnbA/l5xt1yaS9qpLh9rhXzNZ1zdb+Bevjx/Bqh7K1yEQYLxlz
 apRQolKfJEuIIHDpXw4ZWI352JLmYmFJj+ufxkgxxqzUNwexmdaAufrjOdoEDreKOgI9Rvf2Tj0
 +5/HxRIrvKPWWJAc6aPWaZE83BQ9RklVMp0aCpM4F/YJDVDhDI8ili27Wo45
X-Received: by 2002:a05:600c:3155:b0:4a0:251f:a726 with SMTP id
 5b1f17b1804b1-4a1d760dce9mr129001855e9.24.1792336189698; 
 Sun, 18 Oct 2026 08:09:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8bd9sm17978210f8f.35.2026.10.18.08.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:09:49 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:09:47 +0000
To: Max Fillinger <max@max-fillinger.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>, Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 592ee5036d5931e0aefa536cb3e5494d8a2b9dc3
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb6f1a3ff5637ed03202fbc3dfadd25c283cbe61-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xISWK-0007Hg-H1
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
Content-Type: multipart/mixed; boundary="===============0041585187539308371=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0041585187539308371==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7BF7lptGAPs="; charset=UTF-8

--7BF7lptGAPs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Max Fillinger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?=
usp=3Demail )

The following approvals got outdated and were removed:
Code-=
Review+2 by Steffan Karger


Change subject: Move check_session_buf_not_use=
d method into the method that free the buffer
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
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985
(cherry picked from commit 2a881d73=
7b2562ee28247148160cfb60f0ba4645)
Message-Id: <20261013194518=2E30653-1-ger=
t@greenie=2Emuc=2Ede>
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>=

---
M src/openvpn/ssl=2Ec
1 file changed, 99 insertions(+), 62 deletions(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/1=
985/4

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9b6cfa0=
=2E=2E26a1b5d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -93,6 +93,14 @@
 
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
  * SSL/TLS Cipher suite name =
translation table
  */
@@ -989,10 +997,15 @@
  *                       clea=
ned up=2E
  * @param clear        - Whether the memory allocated for the \a=
 ks object
  *                       should be overwritten with 0s=2E
+ *
+=
 * @param to_link      - if not NULL, check that the buffer does not contai=
n
+ *                       any pointer to one of the internal structs of k=
s
  */
 static void
-key_state_free(struct key_state *ks, bool clear)
+key_=
state_free(struct key_state *ks, bool clear, struct buffer *to_link)
 {
+  =
  check_keystate_buf_not_used(to_link, ks);
+
     ks->state =3D S_UNDEF;
 =

     key_state_ssl_free(&ks->ks_ssl);
@@ -1143,16 +1156,25 @@
  * @param s=
ession      - A pointer to the \c tls_session structure to be
  *          =
             cleaned up=2E
  * @param clear        - Whether the memory all=
ocated for the \a session
- *                       object should be overwr=
itten with 0s=2E
+ *                       object should be overwritten wit=
h 0s=2E This
+ *                       implicitly sets many states to 0/fal=
se,
+ *                       e=2Eg=2E the validity of the keys in the stru=
cture
+ * @param to_link      - if not NULL, check that the buffer does not=
 contain
+ *                       any pointer to one of the internal struc=
ts of ks
+ *
  */
 static void
-tls_session_free(struct tls_session *sessio=
n, bool clear)
+tls_session_free(struct tls_session *session, bool clear, s=
truct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, session)=
;
     tls_wrap_free(&session->tls_wrap);
 
     for (size_t i =3D 0; i < K=
S_SIZE; ++i)
     {
-        key_state_free(&session->key[i], false);
+    =
    /* we don't need clear=3Dtrue for this call since
+         * the struc=
ts are part of session and get cleared
+         * as part of session */
+ =
       key_state_free(&session->key[i], false, to_link);
     }
 
     if (=
session->common_name)
@@ -1174,8 +1196,10 @@
 
 
 static void
-move_session=
(struct tls_multi *multi, int dest, int src, bool reinit_src)
+move_session=
(struct tls_multi *multi, int dest, int src, bool reinit_src,
+            =
 struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, &multi=
->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=3D%s s=
rc=3D%s reinit_src=3D%d",
         session_index_name(dest),
         sessi=
on_index_name(src),
@@ -1183,7 +1207,7 @@
     ASSERT(src !=3D dest);
     =
ASSERT(src >=3D 0 && src < TM_SIZE);
     ASSERT(dest >=3D 0 && dest < TM_S=
IZE);
-    tls_session_free(&multi->session[dest], false);
+    tls_session=
_free(&multi->session[dest], false, to_link);
     multi->session[dest] =3D=
 multi->session[src];
 
     if (reinit_src)
@@ -1199,9 +1223,9 @@
 }
 
 st=
atic void
-reset_session(struct tls_multi *multi, struct tls_session *sessi=
on)
+reset_session(struct tls_multi *multi, struct tls_session *session, st=
ruct buffer *to_link)
 {
-    tls_session_free(session, false);
+    tls_se=
ssion_free(session, false, to_link);
     tls_session_init(multi, session);=

 }
 
@@ -1369,7 +1393,7 @@
 
     for (int i =3D 0; i < TM_SIZE; ++i)
    =
 {
-        tls_session_free(&multi->session[i], false);
+        tls_sessi=
on_free(&multi->session[i], false, NULL);
     }
 
     if (clear)
@@ -2125=
,13 +2149,13 @@
  * active key=2E
  */
 static void
-key_state_soft_reset(s=
truct tls_session *session)
+key_state_soft_reset(struct tls_session *sessi=
on, struct buffer *to_link)
 {
     struct key_state *ks =3D &session->key[=
KS_PRIMARY];      /* primary key */
     struct key_state *ks_lame =3D &ses=
sion->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die =3D now + s=
ession->opt->transition_window; /* remaining lifetime of old key */
-    ke=
y_state_free(ks_lame, false);
+    key_state_free(ks_lame, false, to_link);=

     *ks_lame =3D *ks;
 
     key_state_init(session, ks);
@@ -2249,7 +227=
3,7 @@
          * push request, also signal that the client wants
        =
  * to get push-reply messages without without requiring a round
          =
* trip for a push request message*/
-        if(session->opt->pull)
+      =
  if (session->opt->pull)
         {
             iv_proto |=3D IV_PROTO_RE=
QUEST_PUSH;
         }
@@ -2426,7 +2450,7 @@
      * NCP options are proces=
sed and we have no extra state for NCP finished=2E
      */
     if (sessio=
n->opt->server && (session->opt->mode !=3D MODE_SERVER
-            || mult=
i->multi_state =3D=3D CAS_SUCCEEDED))
+                                 || =
multi->multi_state =3D=3D CAS_SUCCEEDED))
     {
         if (ks->authentic=
ated > KS_AUTH_FALSE)
         {
@@ -2679,13 +2703,13 @@
             (int)=
 (now - ks->established), session->opt->renegotiate_seconds,
             k=
s->n_bytes, session->opt->renegotiate_bytes,
             ks->n_packets, se=
ssion->opt->renegotiate_packets);
-        key_state_soft_reset(session);
+=
        key_state_soft_reset(session, to_link);
     }
 
     /* Kill lame =
duck key transition_window seconds after primary key negotiation */
     if=
 (lame_duck_must_die(session, wakeup))
     {
-        key_state_free(ks_la=
me, true);
+        key_state_free(ks_lame, true, to_link);
         msg(D_=
TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
 
@@ -3009,=
6 +3033,56 @@
     return false;
 }
 
+static void
+check_keystate_buf_not_=
used(struct buffer *to_link, const struct key_state *ks)
+{
+    if (ks->st=
ate =3D=3D S_UNDEF || !to_link || !to_link->data)
+    {
+        return;
+=
    }
+
+    uint8_t *dataptr =3D to_link->data;
+
+    /* we don't expect =
send_reliable to be NULL when state is
+     * not S_UNDEF, but people have=
 reported crashes nonetheless,
+     * therefore we better catch this event=
, report and exit=2E
+     */
+    if (!ks->send_reliable)
+    {
+        =
msg(M_FATAL,
+            "ERROR: ks=2Esend_reliable (key-id %d), is NULL "=

+            "while key state is %s=2E Exiting=2E",
+            ks->key_i=
d, state_name(ks->state));
+    }
+
+    for (int j =3D 0; j < ks->send_rel=
iable->size; j++)
+    {
+        if (ks->send_reliable->array[j]=2Ebuf=2Ed=
ata =3D=3D dataptr)
+        {
+            msg(M_INFO,
+                "W=
arning buffer of freed TLS session is still in"
+                " use (key=
-id %d, ks=2Esend_reliable->array[%d])",
+                ks->key_id, j);
+=

+            goto used;
+        }
+    }
+
+    if (ks->ack_write_buf=2Ed=
ata =3D=3D dataptr)
+    {
+        msg(M_INFO, "Warning buffer of freed TL=
S session is still in use "
+            "(ks=2Eack_write_buf, key-id %d)",=

+            ks->key_id);
+
+        goto used;
+    }
+    return;
+
+use=
d:
+    to_link->len =3D 0;
+    to_link->data =3D 0;
+}
+
 /**
  * This is=
 a safe guard function to double check that a buffer from a session is
  * =
not used in a session to avoid a use after free=2E
@@ -3019,58 +3093,24 @@
=
 static void
 check_session_buf_not_used(struct buffer *to_link, struct tls=
_session *session)
 {
-    uint8_t *dataptr =3D to_link->data;
-    if (!da=
taptr)
+    if (!to_link || !to_link->data)
     {
         return;
     }
=
+    const uint8_t *dataptr =3D to_link->data;
 
     /* Checks buffers in =
tls_wrap */
     if (session->tls_wrap=2Ework=2Edata =3D=3D dataptr)
     {=

         msg(M_INFO, "Warning buffer of freed TLS session is "
-          =
          "still in use (tls_wrap=2Ework=2Edata)");
+            "still in =
use (tls_wrap=2Ework=2Edata)");
         goto used;
     }
 
     for (int =
i =3D 0; i < KS_SIZE; i++)
     {
-        struct key_state *ks =3D &sessio=
n->key[i];
-        if (ks->state =3D=3D S_UNDEF)
-        {
-            c=
ontinue;
-        }
-
-        /* we don't expect send_reliable to be NULL =
when state is
-         * not S_UNDEF, but people have reported crashes non=
etheless,
-         * therefore we better catch this event, report and exit=
=2E
-         */
-        if (!ks->send_reliable)
-        {
-            m=
sg(M_FATAL,
-                "ERROR: session->key[%d]->send_reliable is NUL=
L "
-                "while key state is %s=2E Exiting=2E",
-              =
  i, state_name(ks->state));
-        }
-
-        for (int j =3D 0; j < ks=
->send_reliable->size; j++)
-        {
-            if (ks->send_reliable->=
array[j]=2Ebuf=2Edata =3D=3D dataptr)
-            {
-                msg(M=
_INFO,
-                    "Warning buffer of freed TLS session is still i=
n"
-                    " use (session->key[%d]=2Esend_reliable->array[%d])=
",
-                    i, j);
-
-                goto used;
-            }=

-        }
-        if (ks->ack_write_buf=2Edata =3D=3D dataptr)
-        =
{
-            msg(M_INFO, "Warning buffer of freed TLS session is still in=
 use (session->key[%d]=2Eack_write_buf)", i);
-
-            goto used;
-  =
      }
+        const struct key_state *ks =3D &session->key[i];
+        =
check_keystate_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3170,13=
 +3210,11 @@
                     && ks_lame->state >=3D S_ACTIVE
         =
            && !multi->opt=2Esingle_session)
                 {
-          =
          check_session_buf_not_used(to_link, session);
-                  =
  move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+                    =
move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
              =
   }
                 else
                 {
-                    check_se=
ssion_buf_not_used(to_link, session);
-                    reset_session(mu=
lti, session);
+                    reset_session(multi, session, to_link);=

                 }
             }
         }
@@ -3191,7 +3229,7 @@
      *=
/
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     =
{
-        tls_session_free(&multi->session[TM_LAME_DUCK], true);
+        =
tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link);
         ms=
g(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring key");
     }
 =

@@ -3206,8 +3244,7 @@
      */
     if (DECRYPT_KEY_ENABLED(multi, &multi-=
>session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))
     {
-        check_session_bu=
f_not_used(to_link, &multi->session[TM_ACTIVE]);
-        move_session(mult=
i, TM_ACTIVE, TM_UNTRUSTED, true);
+        move_session(multi, TM_ACTIVE, =
TM_UNTRUSTED, true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi=
_process: untrusted session promoted to %strusted",
             tas =3D=3D=
 TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
     }
@@ -3622,7 +3659,7 @@=

                 goto error;
             }
 
-            key_state_soft_=
reset(session);
+            key_state_soft_reset(session, NULL);
 
       =
      dmsg(D_TLS_DEBUG,
                  "TLS: received P_CONTROL_SOFT_RES=
ET_V1 s=3D%d sid=3D%s",

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1985?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Ge=
rrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Gerrit-Change-Num=
ber: 1985
Gerrit-PatchSet: 4
Gerrit-Owner: Max Fillinger <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--7BF7lptGAPs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Max =
Fillinger=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
85?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Move che=
ck_session_buf_not_used method into the method that free the buffer<br><br>=
This cleans the code up a bit and ensure that we do not miss an invocation<=
br>of a problematic code path=2E This is still a band-aid fix and a real fi=
x<br>requires more refactoring and changing the logic=2E<br><br>v2: sprinkl=
e some &quot;const&quot; over check_keystate_buf_not_used() args<br>v3: add=
 missing doxygen for to_link parameter to tls_session_free()<br><br>CVE: 20=
26-84471<br>Reported-By: Andreas Gabriel Berbescu &lt;aberbescu@gmail=2Ecom=
&gt;<br>Tested-By: Andreas Gabriel Berbescu &lt;aberbescu@gmail=2Ecom&gt;<b=
r>Github: openvpn/openvpn-private-issues#157<br>Reported-By: Haruki Oyama (=
Waseda University)<br>Github: openvpn/openvpn-private-issues#132<br>Change-=
Id: I64920ed9f714803604d76c6df6b38cf20ce7626d<br>Signed-off-by: Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1893<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>Messa=
ge-Id: &lt;20260903061209=2E12599-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38=
913=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985<br>(cherry picked from commit 2a=
881d737b2562ee28247148160cfb60f0ba4645)<br>Message-Id: &lt;20261013194518=
=2E30653-1-gert@greenie=2Emuc=2Ede&gt;<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file change=
d, 99 insertions(+), 62 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/1985/4</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 9=
b6cfa0=2E=2E26a1b5d 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -93,6 +93,14 @@</spa=
n><br><span> </span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS =
*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* forward decleration since tls_process needs this function prototype */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+check_session_buf_not_used(s=
truct buffer *to_link, struct tls_session *session);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+check_keystate_buf_not_used(struct buffer *to_link, const struct key=
_state *ks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</spa=
n><br><span>  * SSL/TLS Cipher suite name translation table</span><br><span=
>  */</span><br><span>@@ -989,10 +997,15 @@</span><br><span>  *            =
           cleaned up=2E</span><br><span>  * @param clear        - Whether =
the memory allocated for the \a ks object</span><br><span>  *              =
         should be overwritten with 0s=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param to_link      - if not NULL, check that the buffer does not c=
ontain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
            any pointer to one of the internal structs of ks</span><br><spa=
n>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-key_state_free(struct key_state *ks, bool clear)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+key_state_free(struct key_state =
*ks, bool clear, struct buffer *to_link)</span><br><span> {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    check_keystate_buf_not_used(to_=
link, ks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     ks-&gt;state =3D S_UNDEF;</span><br><span> </span><br><span>  =
   key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><span>@@ -1143,16 +115=
6,25 @@</span><br><span>  * @param session      - A pointer to the \c tls_s=
ession structure to be</span><br><span>  *                       cleaned up=
=2E</span><br><span>  * @param clear        - Whether the memory allocated =
for the \a session</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
                      object should be overwritten with 0s=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *                       object s=
hould be overwritten with 0s=2E This</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                       implicitly sets many states to 0/=
false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
            e=2Eg=2E the validity of the keys in the structure</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param to_link      - if not =
NULL, check that the buffer does not contain</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *                       any pointer to one of the=
 internal structs of ks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span>  */</span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tls_session_free(struct tls_session *ses=
sion, bool clear)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tl=
s_session_free(struct tls_session *session, bool clear, struct buffer *to_l=
ink)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    check_session_buf_not_used(to_link, session);</span><br><span>     =
tls_wrap_free(&amp;session-&gt;tls_wrap);</span><br><span> </span><br><span=
>     for (size_t i =3D 0; i &lt; KS_SIZE; ++i)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(&am=
p;session-&gt;key[i], false);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* we don&#39;t need clear=3Dtrue for this call since</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the structs =
are part of session and get cleared</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * as part of session */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        key_state_free(&amp;session-&gt;key[i]=
, false, to_link);</span><br><span>     }</span><br><span> </span><br><span=
>     if (session-&gt;common_name)</span><br><span>@@ -1174,8 +1196,10 @@</=
span><br><span> </span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-move_session(struct tls_multi *mu=
lti, int dest, int src, bool reinit_src)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+move_session(struct tls_multi *multi, int dest, int sr=
c, bool reinit_src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             struct buffer *to_link)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    check_session_buf_not_used(to_link,=
 &amp;multi-&gt;session[dest]);</span><br><span>     msg(D_TLS_DEBUG_LOW, &=
quot;TLS: move_session: dest=3D%s src=3D%s reinit_src=3D%d&quot;,</span><br=
><span>         session_index_name(dest),</span><br><span>         session_=
index_name(src),</span><br><span>@@ -1183,7 +1207,7 @@</span><br><span>    =
 ASSERT(src !=3D dest);</span><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp=
; src &lt; TM_SIZE);</span><br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; =
dest &lt; TM_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  tls_session_free(&amp;multi-&gt;session[dest], false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(&amp;multi-&gt;se=
ssion[dest], false, to_link);</span><br><span>     multi-&gt;session[dest] =
=3D multi-&gt;session[src];</span><br><span> </span><br><span>     if (rein=
it_src)</span><br><span>@@ -1199,9 +1223,9 @@</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-reset_session(struct tls_multi *multi, struct tls_session *s=
ession)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_sessio=
n(struct tls_multi *multi, struct tls_session *session, struct buffer *to_l=
ink)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    tls_session_free(session, false);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tls_session_free(session, false, to_link);</span><b=
r><span>     tls_session_init(multi, session);</span><br><span> }</span><br=
><span> </span><br><span>@@ -1369,7 +1393,7 @@</span><br><span> </span><br>=
<span>     for (int i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_session_free=
(&amp;multi-&gt;session[i], false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;session[i], false, =
NULL);</span><br><span>     }</span><br><span> </span><br><span>     if (cl=
ear)</span><br><span>@@ -2125,13 +2149,13 @@</span><br><span>  * active key=
=2E</span><br><span>  */</span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-key_state_soft_reset(struct tls_session *se=
ssion)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_state_sof=
t_reset(struct tls_session *session, struct buffer *to_link)</span><br><spa=
n> {</span><br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_=
PRIMARY];      /* primary key */</span><br><span>     struct key_state *ks_=
lame =3D &amp;session-&gt;key[KS_LAME_DUCK]; /* retiring key */</span><br><=
span> </span><br><span>     ks-&gt;must_die =3D now + session-&gt;opt-&gt;t=
ransition_window; /* remaining lifetime of old key */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    key_state_free(ks_lame, false);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    key_state_free(ks_lame,=
 false, to_link);</span><br><span>     *ks_lame =3D *ks;</span><br><span> <=
/span><br><span>     key_state_init(session, ks);</span><br><span>@@ -2249,=
7 +2273,7 @@</span><br><span>          * push request, also signal that the=
 client wants</span><br><span>          * to get push-reply messages withou=
t without requiring a round</span><br><span>          * trip for a push req=
uest message*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if(session-&gt;opt-&gt;pull)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (session-&gt;opt-&gt;pull)</span><br><span>         {<=
/span><br><span>             iv_proto |=3D IV_PROTO_REQUEST_PUSH;</span><br=
><span>         }</span><br><span>@@ -2426,7 +2450,7 @@</span><br><span>   =
   * NCP options are processed and we have no extra state for NCP finished=
=2E</span><br><span>      */</span><br><span>     if (session-&gt;opt-&gt;s=
erver &amp;&amp; (session-&gt;opt-&gt;mode !=3D MODE_SERVER</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            || multi-&gt;multi_state =
=3D=3D CAS_SUCCEEDED))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                 || multi-&gt;multi_state =3D=3D CAS_SUC=
CEEDED))</span><br><span>     {</span><br><span>         if (ks-&gt;authent=
icated &gt; KS_AUTH_FALSE)</span><br><span>         {</span><br><span>@@ -2=
679,13 +2703,13 @@</span><br><span>             (int) (now - ks-&gt;establi=
shed), session-&gt;opt-&gt;renegotiate_seconds,</span><br><span>           =
  ks-&gt;n_bytes, session-&gt;opt-&gt;renegotiate_bytes,</span><br><span>  =
           ks-&gt;n_packets, session-&gt;opt-&gt;renegotiate_packets);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_soft_res=
et(session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 key_state_soft_reset(session, to_link);</span><br><span>     }</span><br><=
span> </span><br><span>     /* Kill lame duck key transition_window seconds=
 after primary key negotiation */</span><br><span>     if (lame_duck_must_d=
ie(session, wakeup))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        key_state_free(ks_lame, true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        key_state_free(ks_lame, tr=
ue, to_link);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_=
process: killed expiring key&quot;);</span><br><span>     }</span><br><span=
> </span><br><span>@@ -3009,6 +3033,56 @@</span><br><span>     return false=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_keystate_buf_not_used(struct buffer *to_link, const struct=
 key_state *ks)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;state =
=3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *dataptr =
=3D to_link-&gt;data;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we don&#39=
;t expect send_reliable to be NULL when state is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * not S_UNDEF, but people have reported c=
rashes nonetheless,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * therefore we better catch this event, report and exit=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ks-&gt;send_reliable)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;ERROR: ks=2Esend_reliab=
le (key-id %d), is NULL &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;while key state is %s=2E Exiting=2E&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;key_=
id, state_name(ks-&gt;state));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int j =3D 0; =
j &lt; ks-&gt;send_reliable-&gt;size; j++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (ks-&gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D =
dataptr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INF=
O,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &=
quot;Warning buffer of freed TLS session is still in&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot; use (key-id %=
d, ks=2Esend_reliable-&gt;array[%d])&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                ks-&gt;key_id, j);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            goto used;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;ack_w=
rite_buf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_INFO, &quot;Warning buffer of freed TLS session is still in use=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;(ks=2Eack_write_buf, key-id %d)&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ks-&gt;key_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto used;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+used:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;len =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    to_link-&gt;data =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Th=
is is a safe guard function to double check that a buffer from a session is=
</span><br><span>  * not used in a session to avoid a use after free=2E</sp=
an><br><span>@@ -3019,58 +3093,24 @@</span><br><span> static void</span><br=
><span> check_session_buf_not_used(struct buffer *to_link, struct tls_sessi=
on *session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!dataptr)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!to_link || !to_link-&gt;data)</span>=
<br><span>     {</span><br><span>         return;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dat=
aptr =3D to_link-&gt;data;</span><br><span> </span><br><span>     /* Checks=
 buffers in tls_wrap */</span><br><span>     if (session-&gt;tls_wrap=2Ewor=
k=2Edata =3D=3D dataptr)</span><br><span>     {</span><br><span>         ms=
g(M_INFO, &quot;Warning buffer of freed TLS session is &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    &quot;still in =
use (tls_wrap=2Ework=2Edata)&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;still in use (tls_wrap=2Ework=2Edata)&qu=
ot;);</span><br><span>         goto used;</span><br><span>     }</span><br>=
<span> </span><br><span>     for (int i =3D 0; i &lt; KS_SIZE; i++)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;state =3D=3D S_UNDEF)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        /* we don&#39;t expect send_reliable to be NULL when state is=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * not S_UNDE=
F, but people have reported crashes nonetheless,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         * therefore we better catch this event,=
 report and exit=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!ks-&gt;send_reliable)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        &quot;ERROR: session-&gt;key[%d]-&gt;send_reliable is NULL &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;w=
hile key state is %s=2E Exiting=2E&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                i, state_name(ks-&gt;state));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; =
j++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (ks-&gt;send_r=
eliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                msg(M_INFO,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    &quot;Warning buffer of freed=
 TLS session is still in&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    &quot; use (session-&gt;key[%d]=2Esend_reliabl=
e-&gt;array[%d])&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    i, j);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  goto used;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&gt;ack_write_=
buf=2Edata =3D=3D dataptr)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_INFO, &quot;Warning buffer of freed TLS session is still in use =
(session-&gt;key[%d]=2Eack_write_buf)&quot;, i);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            goto used;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     const struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        check_keystate_buf_not_use=
d(to_link, ks);</span><br><span>     }</span><br><span>     return;</span><=
br><span> </span><br><span>@@ -3170,13 +3210,11 @@</span><br><span>        =
             &amp;&amp; ks_lame-&gt;state &gt;=3D S_ACTIVE</span><br><span>=
                     &amp;&amp; !multi-&gt;opt=2Esingle_session)</span><br>=
<span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    check_session_buf_not_used(to_link, session);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    move_ses=
sion(multi, TM_LAME_DUCK, TM_ACTIVE, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    move_session(multi, TM_LAME_DUC=
K, TM_ACTIVE, true, to_link);</span><br><span>                 }</span><br>=
<span>                 else</span><br><span>                 {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    check_session_=
buf_not_used(to_link, session);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    reset_session(multi, session);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    reset_session(=
multi, session, to_link);</span><br><span>                 }</span><br><spa=
n>             }</span><br><span>         }</span><br><span>@@ -3191,7 +322=
9,7 @@</span><br><span>      */</span><br><span>     if (lame_duck_must_die=
(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&=
amp;multi-&gt;session[TM_LAME_DUCK], true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;session[TM_=
LAME_DUCK], true, to_link);</span><br><span>         msg(D_TLS_DEBUG_LOW, &=
quot;TLS: tls_multi_process: killed expiring key&quot;);</span><br><span>  =
   }</span><br><span> </span><br><span>@@ -3206,8 +3244,7 @@</span><br><spa=
n>      */</span><br><span>     if (DECRYPT_KEY_ENABLED(multi, &amp;multi-&=
gt;session[TM_UNTRUSTED]=2Ekey[KS_PRIMARY]))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        check_session_buf_not=
_used(to_link, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        move_session(multi, TM_ACTIVE, TM_UNTR=
USTED, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true, to_link);</span><br><s=
pan>         msg(D_TLS_DEBUG_LOW, &quot;TLS: tls_multi_process: untrusted s=
ession promoted to %strusted&quot;,</span><br><span>             tas =3D=3D=
 TLS_AUTHENTICATION_SUCCEEDED ? &quot;&quot; : &quot;semi-&quot;);</span><b=
r><span>     }</span><br><span>@@ -3622,7 +3659,7 @@</span><br><span>      =
           goto error;</span><br><span>             }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            key_state_sof=
t_reset(session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          key_state_soft_reset(session, NULL);</span><br><span> </span><br>=
<span>             dmsg(D_TLS_DEBUG,</span><br><span>                  &quo=
t;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;,</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1985?usp=3Demail">change 1985</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1985?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20=
ce7626d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1985 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffa=
n@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--7BF7lptGAPs=--


--===============0041585187539308371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0041585187539308371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0041585187539308371==--


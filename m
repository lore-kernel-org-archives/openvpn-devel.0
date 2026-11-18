Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EC606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E+FNi2hR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QpbAbLeR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HyEsvwn0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KjGjwJFd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QlwUkVOlDMY4Qv/WEnv8BmGmrDSz40CdyEbLgUvQljM=; b=E+FNi2hRaUjvZZE3ijazFQj0WY
	F8kPoQNUAjVKqWRNj/dTIlwIxe+VG6eNIFo8h+nllPA2GwmEQChh/ZWSV+2zVCKdx+YMrvEYLVdYH
	tOQ4pVjPhv7Rzm6E/zF/vNivItxMp4RORPmP0ZphXW1enE4p6+x24DfxvMFO5xAE00hM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjCv-000000000pF-1GKy;
	Wed, 18 Nov 2026 17:12:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjCt-000000000oz-1pEq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:12:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2jIB6cvJI6FbO2jgNJhT05CWciZUrZsErOWZ/zrMo0=; b=QpbAbLeRdprZIoUcFvG3PnUAsg
 SMWhvPJH1AiSSXH3ry4sbbl5t4PMBmWuJPBvF7SJ2qZIFksed+fWs15mLErLd5OyJkjHkwWWDOh2l
 BVhEYrzYHhBvNGYIs8Qe8w/mWPW8EOK/zawMVeYL20aDwB1MVSHRCI06xn9/eZm9GDpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2jIB6cvJI6FbO2jgNJhT05CWciZUrZsErOWZ/zrMo0=; b=HyEsvwn0Rra6ITAwBtwE2kGJue
 hwGgqeKQ+/HHGv1vxObqX8ZN+BIEQwdqpClbA5mXVYGyp+2GL8hm6GbIRTr/RosmqkogP6/XDpS1e
 MYo2glT4P6xBs5Phx/sHP+yc/dEZUyGU4rbgLf9CaBy/GCSJl6Epo8atxpjuKaHHL0Js=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjCq-0000000056p-3pSB for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:12:27 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so733077f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795021938; x=1795626738; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x2jIB6cvJI6FbO2jgNJhT05CWciZUrZsErOWZ/zrMo0=;
 b=KjGjwJFd1EVAmFd2376PtDVP7FMb2t3wc8l3IrN4UGx6xFUNJBV9WAxMzcsh9j2+Jb
 ekcw7FP8HamUCcDm7m3u494CljANQwQXoUg/H20sD0lM+engk2jSrA16+698QmIynODd
 W8r+hQG15NAt20AtYgC9TnTm3oK9LAF91gRIqMuW+Jr0/aMOhRnfmXwlkHqQa4o3Qoqt
 H04z/7MvMc1j9egQISJqVUKu0IpoIjEJ9WLT5h1nt99cg7Nt38mcpQ6bz1KMIz92WR+I
 qre1snN6rpgvP8Hh6ZHF3Qd/FjNSBphm+ILLPAc4EJLzaAIFqxL1XLuOExRe8sO7xG+Y
 YNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021938; x=1795626738;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x2jIB6cvJI6FbO2jgNJhT05CWciZUrZsErOWZ/zrMo0=;
 b=CwRAwWx2b5E81wAvfUcwAiuieiRNMW0OEw69o3n8gcydy+USDIbEfzezCnQbRvzNJd
 HfMphwg4SXO04oRL0byx8TaJl8aUpVnstRurK3lMPm/ywClj1R9FbneAJwUZba9+kn8z
 b7hF0eJZehA0pm+vPW/I3S+VqP7GWnswDl2Zzqk1Dq6uF8vuX89KMDvs3BGrkBztYOgH
 V9zkCoqiFxIPQLJyQw9BiQJbse8L1sKVYDXb/XEltylInPFaGGEct563kBRbl4kcMoOD
 8XysvH6Lp1+SIpY82dq1yWlNmY5vlolfPE+jVB2nSeP7o4jKyv1aZXKjzQJjwbkiVMtN
 ETxw==
X-Gm-Message-State: APuU4Z9j+YNacxLksaA6rjbu0BBOAbfv3eVkLiGSCxtMpelj4Pxp01cM
 bYFTxpaapp4exXqctA6aS9pAoFulSA2juIC+G4eavMkqLxWmRhogQow9vQ7GLK0tGgOqqkVwTpR
 9U9aoe7VnIjcH/pTQKt6pTFmAktBvmBqsUJQn/c8MO58ZIHXCLZ1Vibxl2eg0F183m4E2GoKC0T
 qfa5bpYQ==
X-Gm-Gg: AZFdTZc3KhUymWvIEbZObf83iJGDdGggesNQVXJkOFHGipYjXOrPFhn/czNlf2L5QVG
 2O0u5GDUypQ61Oei9mQ1GQla/N3rriUX2Zx3JNcoxv3yyWK6lLb0unKdiYX/IGL5juFO8gNCxOV
 N0K1C6ImBX5Sr5vfGnof8cXGuGH8Qq5WluMS2yVXLZg3oqHWv3aO5RXHjDtminLhKX4YobxIwRb
 j9t3ngsW/O+SQkkXfUjRazt5ixCr1o5ViJ9jRNmaWpFEnuARggKeKC7c7YeAdUEQ/zUW8f6MoXg
 GMhGJEZg1xh3q4QZqEY4nzcm7UAP9qu7DPmfSm98xjfZUFYa+VYFILoFbp69dFfoZO8u7aRb5OQ
 MGbiXAAZ2D7RtE3PCs8AjkFNJUlaDRasYZLZ2AHS6A58RlHn0b5+MpGTt+gCkEO+/doXoKRA3g6
 vZyLKKZ500o41BFaqfcnCf3pXkROA7yCLhZLMgAMispIpn/+ibVo+XAF8qVWHc73Wdk6k+ejENr
 l2RtaxT6q/53os+rL8aFZUY3uiCmV7feVgUqV6mwyOO4G1GrW7B/wkrJJ335cHw3fSUkHqL8xZB
 2g4pK8Lh2r0XOGoAAv9VppNkQBhWN3Md2JbQUMtVJYOOw/dFRe7d46W/Jz/RqLlOlvxaq3hlXLe
 rGQHNt6tkEvpAMWQKox2xujGzHx0foNQF6cCvBf5efIpCb+6ZYcEmJtLFBP6TliSNB87FIkW5r6
 RdmGVVHU7BgL6/sSQ=
X-Received: by 2002:a05:6000:4553:b0:4a3:8b21:51bc with SMTP id
 ffacd0b85a97d-4a63c468b74mr5088469f8f.46.1795021938105; 
 Wed, 18 Nov 2026 09:12:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65499752asm5667879f8f.11.2026.11.18.09.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:12:17 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:12:16 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: d0b779bd20b6c6da7510f24ecba66afa73bbbb40
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2063e30c8ed68ff0ddde81a14bf597a0cf6c47b2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTjCq-0000000056p-3pSB
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Switch all
 sleep methods to unsigned
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7808444696640138525=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7808444696640138525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bx+w5RuPy2A="; charset=UTF-8

--bx+w5RuPy2A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
200?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: manage: Switch all s=
leep methods to unsigned
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

manage: Switch all sleep methods to unsigned

That is consist=
ent with sleep(3)=2E

Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
=
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2200
Message-Id: <20261117102414=2E31377-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41512=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/=
resolve=2Ec
M src/openvpn/win32=2Ec
M src/openvpn/win32=2Eh
M tests/unit_te=
sts/openvpn/mock_management=2Ec
6 files changed, 34 insertions(+), 77 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/00/2200/3

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
i=
ndex ae30930=2E=2E86c498e 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/ope=
nvpn/manage=2Ec
@@ -3615,32 +3615,23 @@
     }
 }
 
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic =
ignored "-Wsign-conversion"
-#endif
-
 /*
  * Process the management event =
loop for sec seconds
  */
 void
-management_event_loop_n_seconds(struct man=
agement *man, int sec)
+management_event_loop_n_seconds(struct management *=
man, unsigned int sec)
 {
     if (man_standalone_ok(man))
     {
         =
volatile int signal_received =3D 0;
         const bool standalone_disabled=
_save =3D man->persist=2Estandalone_disabled;
-        time_t expire =3D 0;=

+        time_t expire =3D now + sec;
 
         /* This is so M_CLIENT me=
ssages will be correctly passed through msg() */
         man->persist=2Est=
andalone_disabled =3D false;
 
         /* set expire time */
         upda=
te_time();
-        if (sec >=3D 0)
-        {
-            expire =3D now =
+ sec;
-        }
 
         /* if no client connection, wait for one */
  =
       man_wait_for_client_connection(man, &signal_received, expire, 0);
@@=
 -3662,7 +3653,7 @@
                 return;
             }
             up=
date_time();
-        } while (expire && expire > now);
+        } while (e=
xpire > now);
 
         /* revert state */
         man->persist=2Estandal=
one_disabled =3D standalone_disabled_save;
@@ -4026,7 +4017,7 @@
  * Return=
 true if the caller should not sleep for an additional time interval=2E
  *=
/
 bool
-management_hold(struct management *man, int holdtime)
+management_=
hold(struct management *man, unsigned int holdtime)
 {
     if (management_=
would_hold(man))
     {
@@ -4044,7 +4035,7 @@
         if (!signal_received=
)
         {
             struct buffer out =3D alloc_buf_gc(128, &gc);
-  =
          buf_printf(&out, ">HOLD:Waiting for hold release:%d", holdtime);
=
+            buf_printf(&out, ">HOLD:Waiting for hold release:%u", holdtime=
);
             man->persist=2Especial_state_msg =3D BSTR(&out);
          =
   msg(M_CLIENT, "%s", man->persist=2Especial_state_msg);
 
@@ -4244,8 +423=
5,9 @@
 log_history_obj_init(struct log_history *h, int capacity)
 {
     C=
LEAR(*h);
+    ASSERT(capacity > 0);
     h->capacity =3D capacity;
-    AL=
LOC_ARRAY_CLEAR(h->array, struct log_entry, capacity);
+    ALLOC_ARRAY_CLE=
AR(h->array, struct log_entry, (size_t)capacity);
 }
 
 struct log_history =
*
@@ -4332,34 +4324,6 @@
 }
 
 void
-management_sleep(const int n)
-{
-    =
if (n < 0)
-    {
-        return;
-    }
-    else if (management)
-    {
=
-        management_event_loop_n_seconds(management, n);
-    }
-    else
-=
    {
-#ifdef _WIN32
-        win32_sleep(n);
-#else
-        if (n > 0)
- =
       {
-            sleep(n);
-        }
-#endif
-    }
-}
-
-#if defined=
(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-voi=
d
 management_check_bytecount_client(struct context *c, struct management *=
man, struct timeval *timeval)
 {
     if (man->persist=2Ecallback=2Eflags &=
 MCF_SERVER)
@@ -4490,30 +4454,28 @@
     gc_free(&gc);
     return false;
=
 }
-#else /* ifdef ENABLE_MANAGEMENT */
+#endif /* ENABLE_MANAGEMENT */
 
 =
#include "win32=2Eh"
 
-#if !defined(_WIN32) && (defined(__GNUC__) || defin=
ed(__clang__))
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
-#endif
-
 void
-management_sleep(const int n)
+manage=
ment_sleep(const unsigned int n)
 {
-#ifdef _WIN32
-    win32_sleep(n);
-#e=
lse
-    if (n > 0)
+#ifdef ENABLE_MANAGEMENT
+    if (management)
     {
-=
        sleep(n);
+        management_event_loop_n_seconds(management, n);
=
     }
-#endif /* ifdef _WIN32 */
-}
-
-#if !defined(_WIN32) && (defined(__=
GNUC__) || defined(__clang__))
-#pragma GCC diagnostic pop
+    else
 #endi=
f
-
-#endif /* ENABLE_MANAGEMENT */
+    {
+#ifdef _WIN32
+        win32_sl=
eep(n);
+#else
+        if (n > 0)
+        {
+            sleep(n);
+     =
   }
+#endif
+    }
+}
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/ma=
nage=2Eh
index 82c0caa=2E=2E697f830 100644
--- a/src/openvpn/manage=2Eh
+++=
 b/src/openvpn/manage=2Eh
@@ -387,9 +387,9 @@
 
 bool management_would_hold=
(struct management *man);
 
-bool management_hold(struct management *man, i=
nt holdtime);
+bool management_hold(struct management *man, unsigned int ho=
ldtime);
 
-void management_event_loop_n_seconds(struct management *man, in=
t sec);
+void management_event_loop_n_seconds(struct management *man, unsig=
ned int sec);
 
 void management_up_down(const struct management *man, cons=
t char *updown, const struct env_set *es);
 
@@ -522,6 +522,6 @@
  * A slee=
p function that services the management layer for n seconds rather
  * than=
 doing nothing=2E
  */
-void management_sleep(const int n);
+void managemen=
t_sleep(const unsigned int n);
 
 #endif /* ifndef MANAGE_H */
diff --git a=
/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec
index b8d9899=2E=2E544e5=
ea 100644
--- a/src/openvpn/resolve=2Ec
+++ b/src/openvpn/resolve=2Ec
@@ -1=
61,13 +161,13 @@
     }
 
     status =3D getaddrinfo(hostname, servname, &=
hints, res);
-
-    if (status !=3D 0)                      /* parse as num=
eric address failed? */
+    /* parse as numeric address failed? */
+    if=
 (status !=3D 0)
     {
-        const int fail_wait_interval =3D 5; /* sec=
onds */
+        const unsigned int fail_wait_interval =3D 5; /* seconds */=

         /* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0=
+4)/5=3D0 */
         int resolve_retries =3D
-            (flags & GETADDR=
_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+     =
       (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int=
)fail_wait_interval);
         const char *fmt;
         msglvl_t level =3D=
 0;
 
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 0798=
69f=2E=2Ef10c16d 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=
=2Ec
@@ -1533,13 +1533,8 @@
 }
 
 void
-win32_sleep(const int n)
+win32_sle=
ep(const unsigned int n)
 {
-    if (n < 0)
-    {
-        return;
-    }
=
-
     /* Sleep() is not interruptible=2E Use a WAIT_OBJECT to catch signal=
 */
 
     if (!HANDLE_DEFINED(win32_signal=2Ein=2Eread))
diff --git a/src/=
openvpn/win32=2Eh b/src/openvpn/win32=2Eh
index 39ff7d8=2E=2E8152e71 100644=

--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -323,7 +323,7 @=
@
 int openvpn_execve(const struct argv *a, const struct env_set *es, const=
 unsigned int flags);
 
 /* Sleep that can be interrupted by signals and ex=
it event */
-void win32_sleep(const int n);
+void win32_sleep(const unsigne=
d int n);
 
 /**
  * @brief Fetches a registry value for OpenVPN registry k=
ey=2E
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/uni=
t_tests/openvpn/mock_management=2Ec
index f572dbb=2E=2Eaea43da 100644
--- a=
/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvp=
n/mock_management=2Ec
@@ -59,6 +59,6 @@
 #endif
 
 void
-management_sleep(c=
onst int n)
+management_sleep(const unsigned int n)
 {
 }

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759=
715bb847c
Gerrit-Change-Number: 2200
Gerrit-PatchSet: 3
Gerrit-Owner: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--bx+w5RuPy2A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2200?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: Switch all sleep methods to unsigned<br><br>That is consistent =
with sleep(3)=2E<br><br>Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847=
c<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ac=
ked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200<br>Message-Id: &lt;20261117102414=
=2E31377-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41512=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/resolve=2Ec<br>M sr=
c/openvpn/win32=2Ec<br>M src/openvpn/win32=2Eh<br>M tests/unit_tests/openvp=
n/mock_management=2Ec<br>6 files changed, 34 insertions(+), 77 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/00/2200/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/s=
rc/openvpn/manage=2Ec</span><br><span>index ae30930=2E=2E86c498e 100644</sp=
an><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn=
/manage=2Ec</span><br><span>@@ -3615,32 +3615,23 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /*</span><br><span>  * Process the management event loop for sec =
seconds</span><br><span>  */</span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-management_event_loop_n_seconds(struct managem=
ent *man, int sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
anagement_event_loop_n_seconds(struct management *man, unsigned int sec)</s=
pan><br><span> {</span><br><span>     if (man_standalone_ok(man))</span><br=
><span>     {</span><br><span>         volatile int signal_received =3D 0;<=
/span><br><span>         const bool standalone_disabled_save =3D man-&gt;pe=
rsist=2Estandalone_disabled;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        time_t expire =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        time_t expire =3D now + sec;</span><br><span> </spa=
n><br><span>         /* This is so M_CLIENT messages will be correctly pass=
ed through msg() */</span><br><span>         man-&gt;persist=2Estandalone_d=
isabled =3D false;</span><br><span> </span><br><span>         /* set expire=
 time */</span><br><span>         update_time();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (sec &gt;=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            expire =3D now + sec;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> </span><br><span=
>         /* if no client connection, wait for one */</span><br><span>     =
    man_wait_for_client_connection(man, &amp;signal_received, expire, 0);</=
span><br><span>@@ -3662,7 +3653,7 @@</span><br><span>                 retur=
n;</span><br><span>             }</span><br><span>             update_time(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        } while (ex=
pire &amp;&amp; expire &gt; now);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        } while (expire &gt; now);</span><br><span> </span><b=
r><span>         /* revert state */</span><br><span>         man-&gt;persis=
t=2Estandalone_disabled =3D standalone_disabled_save;</span><br><span>@@ -4=
026,7 +4017,7 @@</span><br><span>  * Return true if the caller should not s=
leep for an additional time interval=2E</span><br><span>  */</span><br><spa=
n> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_hol=
d(struct management *man, int holdtime)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+management_hold(struct management *man, unsigned int ho=
ldtime)</span><br><span> {</span><br><span>     if (management_would_hold(m=
an))</span><br><span>     {</span><br><span>@@ -4044,7 +4035,7 @@</span><br=
><span>         if (!signal_received)</span><br><span>         {</span><br>=
<span>             struct buffer out =3D alloc_buf_gc(128, &amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;=
out, &quot;&gt;HOLD:Waiting for hold release:%d&quot;, holdtime);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;o=
ut, &quot;&gt;HOLD:Waiting for hold release:%u&quot;, holdtime);</span><br>=
<span>             man-&gt;persist=2Especial_state_msg =3D BSTR(&amp;out);<=
/span><br><span>             msg(M_CLIENT, &quot;%s&quot;, man-&gt;persist=
=2Especial_state_msg);</span><br><span> </span><br><span>@@ -4244,8 +4235,9=
 @@</span><br><span> log_history_obj_init(struct log_history *h, int capaci=
ty)</span><br><span> {</span><br><span>     CLEAR(*h);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capacity &gt; 0);</span><br><=
span>     h-&gt;capacity =3D capacity;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ALLOC_ARRAY_CLEAR(h-&gt;array, struct log_entry, capac=
ity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRA=
Y_CLEAR(h-&gt;array, struct log_entry, (size_t)capacity);</span><br><span> =
}</span><br><span> </span><br><span> struct log_history *</span><br><span>@=
@ -4332,34 +4324,6 @@</span><br><span> }</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_sleep=
(const int n)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n &lt; 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    else if (management)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
management_event_loop_n_seconds(management, n);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        win32_sleep(n);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (n &gt; 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            sleep(n);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void</span><br><span> management_check_bytecount_client(struct context =
*c, struct management *man, struct timeval *timeval)</span><br><span> {</sp=
an><br><span>     if (man-&gt;persist=2Ecallback=2Eflags &amp; MCF_SERVER)<=
/span><br><span>@@ -4490,30 +4454,28 @@</span><br><span>     gc_free(&amp;g=
c);</span><br><span>     return false;</span><br><span> }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef ENABLE_MANAGEMENT */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGE=
MENT */</span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !=
defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic=
 ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-management_sleep(const int n)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+management_sleep(const unsigned int n)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    win32_sleep(n);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (n &gt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (management)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        sleep(n);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        management_event_loop_=
n_seconds(management, n);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defi=
ned(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span>=
 #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_MANAGEMENT */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        win32_sleep(n);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (n &gt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            sleep(n);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff=
 --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>in=
dex 82c0caa=2E=2E697f830 100644</span><br><span>--- a/src/openvpn/manage=2E=
h</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -387,9 +3=
87,9 @@</span><br><span> </span><br><span> bool management_would_hold(struc=
t management *man);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bool management_hold(struct management *man, int holdtime);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool management_hol=
d(struct management *man, unsigned int holdtime);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void management_event_loop_n_=
seconds(struct management *man, int sec);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void management_event_loop_n_seconds(struct managemen=
t *man, unsigned int sec);</span><br><span> </span><br><span> void manageme=
nt_up_down(const struct management *man, const char *updown, const struct e=
nv_set *es);</span><br><span> </span><br><span>@@ -522,6 +522,6 @@</span><b=
r><span>  * A sleep function that services the management layer for n secon=
ds rather</span><br><span>  * than doing nothing=2E</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_sleep(co=
nst int n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void man=
agement_sleep(const unsigned int n);</span><br><span> </span><br><span> #en=
dif /* ifndef MANAGE_H */</span><br><span>diff --git a/src/openvpn/resolve=
=2Ec b/src/openvpn/resolve=2Ec</span><br><span>index b8d9899=2E=2E544e5ea 1=
00644</span><br><span>--- a/src/openvpn/resolve=2Ec</span><br><span>+++ b/s=
rc/openvpn/resolve=2Ec</span><br><span>@@ -161,13 +161,13 @@</span><br><spa=
n>     }</span><br><span> </span><br><span>     status =3D getaddrinfo(host=
name, servname, &amp;hints, res);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (s=
tatus !=3D 0)                      /* parse as numeric address failed? */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* parse as numer=
ic address failed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (status !=3D 0)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        const int fail_wait_interval =3D 5; /* se=
conds */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st unsigned int fail_wait_interval =3D 5; /* seconds */</span><br><span>   =
      /* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/=
5=3D0 */</span><br><span>         int resolve_retries =3D</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            (flags &amp; GETADDR_TRY_ON=
CE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            (flags &amp; GETADDR_=
TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)fail_wait_interval);</s=
pan><br><span>         const char *fmt;</span><br><span>         msglvl_t l=
evel =3D 0;</span><br><span> </span><br><span>diff --git a/src/openvpn/win3=
2=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 079869f=2E=2Ef10c16d 10=
0644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/=
openvpn/win32=2Ec</span><br><span>@@ -1533,13 +1533,8 @@</span><br><span> }=
</span><br><span> </span><br><span> void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-win32_sleep(const int n)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+win32_sleep(const unsigned int n)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n &lt; 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>     /* Sleep() is not interruptible=2E Use a=
 WAIT_OBJECT to catch signal */</span><br><span> </span><br><span>     if (=
!HANDLE_DEFINED(win32_signal=2Ein=2Eread))</span><br><span>diff --git a/src=
/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>index 39ff7d8=2E=
=2E8152e71 100644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><sp=
an>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -323,7 +323,7 @@</span><b=
r><span> int openvpn_execve(const struct argv *a, const struct env_set *es,=
 const unsigned int flags);</span><br><span> </span><br><span> /* Sleep tha=
t can be interrupted by signals and exit event */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void win32_sleep(const int n);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void win32_sleep(const unsigned int =
n);</span><br><span> </span><br><span> /**</span><br><span>  * @brief Fetch=
es a registry value for OpenVPN registry key=2E</span><br><span>diff --git =
a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/m=
ock_management=2Ec</span><br><span>index f572dbb=2E=2Eaea43da 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>@@ -59=
,6 +59,6 @@</span><br><span> #endif</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_sleep(cons=
t int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
sleep(const unsigned int n)</span><br><span> {</span><br><span> }</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2200?usp=3Demail">change 2200</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2200?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2200 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--bx+w5RuPy2A=--


--===============7808444696640138525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7808444696640138525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7808444696640138525==--


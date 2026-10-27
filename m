Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16E606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mnF/H/qI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lk35NePf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nCd8i3wu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QsdAaS9X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=KQdL0pHs+6N32XTmzcAGTyIYgdT5usIJMVcsRav9Xjw=; b=mnF/H/qIiIqMYdTYoy3QBegOpe
	rZJOaqwXTLXA4OnDuELb3AH27VgB5PPzbwahzsngdLvfQ8K89WeYe0L/bxRFCdTfxEXw4IvVwLvXn
	H1FzOi5JJYF8CwEW3PfPmisN7lHUNNa7l6x34IN+Yh+L4E7iOXCYQDPcx4qr3PkxEZ8o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdm5-000000001q8-2S9t;
	Tue, 27 Oct 2026 09:47:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdm1-000000001pN-1lVH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4nW/TQ742zCGxYO2pRMRi+CYgMGBCz8aj2t0SqicDKE=; b=lk35NePfa5O+tqs9Pf49fz6msZ
 Stdv5AUU49GsS8UvGZcss78BEEFUSIbtBOC+pPYSK6hllS4wRDePCDHO3feMBSoIfqAaGfEGWiAaH
 NrzWF2ZuJv4m1lzp3MsLytwkpQtgmemVNZEm3W/RJ4+Wgh431yS8tIjF2Hz7pPUeCyC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4nW/TQ742zCGxYO2pRMRi+CYgMGBCz8aj2t0SqicDKE=; b=nCd8i3wu/66gRHr++AEMAHAg2y
 QDvcAL/tveRQX74UTgrg+t4h79P2/08p5ryYPJ9EJWkMPEAp2Zvna+RuHxHR3CvdWlZVfgRx9NEsa
 HBp3O553+5YTXbOwovNkw7YEzPxwcH/FbMEotejL0mdYjhL0m3Zlg3pZRHfAgBHCeblc=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlz-0000000021r-0LUx for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so27172705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094428; x=1793699228; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4nW/TQ742zCGxYO2pRMRi+CYgMGBCz8aj2t0SqicDKE=;
 b=QsdAaS9XLSBisG2zQjJMSyHDCG++88+pJmo1ooQACxHuejwUt61o+7cleSc2+fkB1e
 msUyF6lNuZHTugtJkYBGiy21LprsFAkgOGatcgbY10oza8iHAly0KQ/qqLh6IB/fZLT6
 cekfjsKDEKq4RQwQ/T3mtvVMuyWi5ZZ4aPhsscjtjrLFupbpusUXvV8BwN9ZkJp++twW
 mIb89sBTcWMkqXFjMDURWX62b5NMRIGrP2jn1/9pdhqhxUc88a9cn8jeM+Wk/9rqTGCY
 XF0zBf9lI1cIMYQv+yMCWv08Mn6gqGneQtcvnuiHxEqYOHnFmjh10YOmtXuvba9XK+9n
 2KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094428; x=1793699228;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4nW/TQ742zCGxYO2pRMRi+CYgMGBCz8aj2t0SqicDKE=;
 b=NY6cwQBzy6p52+0mIyiYweb4w9Wwg4rY3X3mW0tZS/a+yoOPWmu8xoEOi3zfbw19zM
 k1noZEzxO/zki3/Ws9BzU1wenNMjWZgRpvafyvnmzgiWxcJF0fVYCilwm7eaxLi5IQVC
 /2rIU3OfWCKpyPsLenfJ3ltlqwQ0Pz0o9n5uxsvnoWmI2+fcv+nQQDJStKyEyEkU5A3b
 hSu3I+kqkzPceYvz9CpF7hk1Hkbv/Aj+NDytaxYR/xlb8O1VjbTf4dlOimQ4tPgRGTAC
 S0JEGfkFszKmLLcydevD+bwovwt3w/UVnMW1Pqe0lSjy0y5aYIKlkVRTH0x/oHWJqJhb
 Y8KA==
X-Gm-Message-State: AFq9FYLTYSkWSgWy4toypdcvzaEu4qzu9cViUQdAYO+ZfO2UUj1PC3Ap
 laU+QSyzEiY6z699ZE2ovm9ZeYOEmgi0sDFJKeO0SnXB78lhXgCmjhfIJeXROVUvgSuytGnSJ9/
 bKvquAmROHNo6aXS6gQlKSW465XWmeC+3aoANaQ9ri9XhtjupQ+pvTUilR6ASlftdhTLRTgaCMW
 9k87M7aw==
X-Gm-Gg: AYBFou3kt67FnMpLmvfLLRInXV3T9ODYLIAKgMlE5w7ANj5EkD7MC23Gblfbaj7dedB
 0wSA98Gn0wc0YbGyjjOCtejJ/AfSjIcgF/dCYXCAYWDMuTYMrF2dcMvQGUSASMuxgFhZXJ+UmQE
 5nlIW95gjZl7dAWrviPASW5Jt4IPzwB6fyY1R5J4N345ytLbfrNeVOU722YuagjJ3eQaTTnNEqk
 Vfy5qwtlrgEIgNMZcUmE3hlGvQXaZXo3XZPpXuCARDKWBY+zYA/m09PGgqeoZSmyc8yrR6k/FoB
 T7Ev+rZRwfl/h/E+vLDrOxgMxL8njghJV+6INPlMh8VNgbIjubfpmsH6SyZLKKsnfaI/Jb/As9w
 FGDemqxhzIDvCPN5DHS/JA2eEUJdG5kcTWT/y2sDypBe/YdjjPXvY0cbhAsDxjd5P4dURpNau83
 g2As/EDapVqWtQWCPKBNL6rj4NPUQAJ3TfJ2GPKAX21JlvR7sTDhR3loWWy5JQBZRMtAV0fj1Z0
 R5Jk7AZ7TZ6MpYWkiQFB5X/avT7GGmKoAa7yIbsdx0rOMOn8RDbiO01uK1lQNhTwErFS3zVcQeg
 IfBhu6Wee272B0KjOiwfVhtdzBcxzhaEnNegUw1UH+Z+lqW5kFKebhPQj8mAUOzaFdiexG/426K
 aX2yF+swZTN7iMZFXcH7Zyb4SWZ2h3XUt0rC930rZZg==
X-Received: by 2002:a05:600c:3e86:b0:4a2:cbe:bebc with SMTP id
 5b1f17b1804b1-4a35aca5f94mr174375605e9.23.1793094428245; 
 Tue, 27 Oct 2026 02:47:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm21748523f8f.54.2026.10.27.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:07 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
X-Gerrit-Change-Number: 2051
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2051?usp=email>
X-Gerrit-Commit: 85e80583244f6839e1e9e4cfd900604911c0e146
References: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllNzU1MTY5YmIzMmRhODU2ZTk0MWEyMTRmNDNmYmIyNDNiNzY4ZDc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f99fa530822f32c6ce197d03d91f23c0730c0805-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlz-0000000021r-0LUx
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: drop
 MPP_CLOSE_ON_SIGNAL
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8834114754560167796=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8834114754560167796==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TTGWQUnLDJw="; charset=UTF-8

--TTGWQUnLDJw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2051?usp=3Demail

to review the following change=2E
=


Change subject: multi: drop MPP_CLOSE_ON_SIGNAL
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: drop MPP_CLOSE_ON_SIGNAL

The =
UDP path, the last user of MPP_CLOSE_ON_SIGNAL, now goes through
multi_io_a=
ction(), which closes the signalled instance itself=2E Without
the flag mul=
ti_process_post() always returns true, and the functions
that only passed i=
ts result along return a value nobody reads=2E

Drop the flag and make mult=
i_process_post(), the incoming and timeout
processing functions and the sta=
tic write functions of multi_io=2Ec
return void=2E The check of the multi_p=
rocess_post() result in
multi_create_instance() could never fail and goes a=
way as well=2E

Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
Signed=
-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn=
/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
3 files chang=
ed, 26 insertions(+), 74 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/51/2051/1

diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index b1d7713=2E=2E868ebc3 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -775,11 +775,7 @@
     mi->i=
notify_watch =3D -1;
 #endif
 
-    if (!multi_process_post(m, mi, MPP_PRE_=
SELECT))
-    {
-        msg(D_MULTI_ERRORS, "MULTI: signal occurred during=
 client instance initialization");
-        goto err;
-    }
+    multi_pro=
cess_post(m, mi, MPP_PRE_SELECT);
 
     mi->ev_arg=2Etype =3D EVENT_ARG_MU=
LTI_INSTANCE;
     mi->ev_arg=2Eu=2Emi =3D mi;
@@ -3021,14 +3017,10 @@
  * =
Figure instance-specific timers, convert
  * earliest to absolute time in m=
i->wakeup,
  * call scheduler with our future wakeup time=2E
- *
- * Also c=
lose context on signal=2E
  */
-bool
+void
 multi_process_post(struct multi=
_context *m, struct multi_instance *mi, const unsigned int flags)
 {
-    b=
ool ret =3D true;
-
     if (!IS_SIG(&mi->context)
         && ((flags & MP=
P_PRE_SELECT)))
     {
@@ -3086,16 +3078,8 @@
         }
     }
 
-    if (=
IS_SIG(&mi->context))
-    {
-        if (flags & MPP_CLOSE_ON_SIGNAL)
-   =
     {
-            multi_close_instance_on_signal(m, mi);
-            ret=
 =3D false;
-        }
-    }
 #ifdef MULTI_DEBUG_EVENT_LOOP
-    else
+   =
 if (!IS_SIG(&mi->context))
     {
         printf("POST %s[%d] to=3D%d lo=
=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(mi), (int)ANY_OUT(&mi->context),
      =
          mi->context=2Ec2=2Eto_tun=2Elen, mi->context=2Ec2=2Eto_link=2Elen=
,
@@ -3108,8 +3092,6 @@
     {
         *m->mpp_touched =3D mi;
     }
-
- =
   return ret;
 }
 
 /**
@@ -3541,13 +3523,12 @@
  * Process packets in the=
 TCP/UDP socket -> TUN/TAP interface direction,
  * i=2Ee=2E client -> serv=
er direction=2E
  */
-bool
+void
 multi_process_incoming_link(struct multi_=
context *m, struct multi_instance *instance,
                             c=
onst unsigned int mpp_flags, struct link_socket *sock)
 {
     struct multi=
_instance *mi =3D instance;
     struct context *c;
-    bool ret =3D true;=

     bool floated =3D false;
 
     if (!mi)
@@ -3560,7 +3541,7 @@
 
     =
if (!mi)
     {
-        return true;
+        return;
     }
     set_pref=
ix(mi);
 
@@ -3585,22 +3566,18 @@
     }
 
     /* postprocess and set wake=
up */
-    ret =3D multi_process_post(m, mi, mpp_flags);
+    multi_process=
_post(m, mi, mpp_flags);
 
     clear_prefix();
-
-    return ret;
 }
 
 /*=

  * Process packets in the TUN/TAP interface -> TCP/UDP socket direction,
=
  * i=2Ee=2E server -> client direction=2E
  */
-bool
+void
 multi_process_=
incoming_tun(struct multi_context *m, const unsigned int mpp_flags)
 {
-   =
 bool ret =3D true;
-
     if (BLEN(&m->top=2Ec2=2Ebuf) > 0)
     {
       =
  unsigned int mroute_flags;
@@ -3617,7 +3594,7 @@
             vid =3D vla=
n_decapsulate(&m->top, &m->top=2Ec2=2Ebuf);
             if (vid < 0)
     =
        {
-                return false;
+                return;
         =
    }
         }
 
@@ -3668,14 +3645,13 @@
                     process_inc=
oming_tun(c, c->c2=2Elink_sockets[0]);
 
                     /* postproces=
s and set wakeup */
-                    ret =3D multi_process_post(m, mi, =
mpp_flags);
+                    multi_process_post(m, mi, mpp_flags);
 
  =
                   clear_prefix();
                 }
             }
      =
   }
     }
-    return ret;
 }
 
 /*
@@ -3718,11 +3694,9 @@
  * Called whe=
n an I/O wait times out=2E  Usually means that a particular
  * client inst=
ance object needs timer-based service=2E
  */
-bool
+void
 multi_process_ti=
meout(struct multi_context *m, const unsigned int mpp_flags)
 {
-    bool r=
et =3D true;
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TIMEOUT\n"=
, id(m->earliest_wakeup));
 #endif
@@ -3739,12 +3713,11 @@
         else
  =
       {
             set_prefix(m->earliest_wakeup);
-            ret =3D =
multi_process_post(m, m->earliest_wakeup, mpp_flags);
+            multi_pr=
ocess_post(m, m->earliest_wakeup, mpp_flags);
             clear_prefix();
=
         }
         m->earliest_wakeup =3D NULL;
     }
-    return ret;
 }=

 
 /*
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 028=
41af=2E=2E103c0334 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/mul=
ti=2Eh
@@ -282,11 +282,10 @@
 
 void multi_close_instance(struct multi_cont=
ext *m, struct multi_instance *mi, bool shutdown);
 
-bool multi_process_ti=
meout(struct multi_context *m, const unsigned int mpp_flags);
+void multi_p=
rocess_timeout(struct multi_context *m, const unsigned int mpp_flags);
 
-#=
define MPP_PRE_SELECT      (1 << 0)
-#define MPP_CLOSE_ON_SIGNAL (1 << 1)
-=
#define MPP_RECORD_TOUCH    (1 << 2)
+#define MPP_PRE_SELECT   (1 << 0)
+#d=
efine MPP_RECORD_TOUCH (1 << 2)
 
 
 /*************************************=
*************************************/
@@ -305,13 +304,8 @@
  * @param mi  =
         - The \c multi_instance of the VPN tunnel to be
  *               =
        postprocessed=2E
  * @param flags        - Fast I/O optimization fl=
ags=2E
- *
- * @return
- *  - True, if the VPN tunnel instance \a mi was no=
t closed due to a
- *    signal during processing=2E
- *  - False, if the V=
PN tunnel instance \a mi was closed=2E
  */
-bool multi_process_post(struct=
 multi_context *m, struct multi_instance *mi,
+void multi_process_post(stru=
ct multi_context *m, struct multi_instance *mi,
                         co=
nst unsigned int flags);
 
 /**
@@ -345,7 +339,7 @@
  * @param mpp_flags   =
 - Fast I/O optimization flags=2E
  * @param sock         - Socket where th=
e packet was received=2E
  */
-bool multi_process_incoming_link(struct mult=
i_context *m, struct multi_instance *instance,
+void multi_process_incoming=
_link(struct multi_context *m, struct multi_instance *instance,
           =
                       const unsigned int mpp_flags, struct link_socket *so=
ck);
 
 
@@ -364,7 +358,7 @@
  * @param m            - The single \c multi_=
context structure=2E
  * @param mpp_flags    - Fast I/O optimization flags=
=2E
  */
-bool multi_process_incoming_tun(struct multi_context *m, const un=
signed int mpp_flags);
+void multi_process_incoming_tun(struct multi_contex=
t *m, const unsigned int mpp_flags);
 
 
 struct multi_instance *multi_get_=
queue(struct mbuf_set *ms);
diff --git a/src/openvpn/multi_io=2Ec b/src/ope=
nvpn/multi_io=2Ec
index 59afb51=2E=2E31da970 100644
--- a/src/openvpn/multi=
_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -253,26 +253,18 @@
  * @param m  =
          - The single \c multi_context structure=2E
  * @param mi         =
  - The \c multi_instance with the packet to send=2E
  * @param mpp_flags  =
  - Fast I/O optimization flags=2E
- *
- * @return
- *  - True, if the \c m=
ulti_instance associated with the packet sent was
- *    not closed due to =
a signal during processing=2E
- *  - Falls, if the \c multi_instance was cl=
osed=2E
  */
-static bool
+static void
 multi_io_write_tun(struct multi_con=
text *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    b=
ool ret =3D true;
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TUN l=
en=3D%d\n", id(mi), mi->context=2Ec2=2Eto_tun=2Elen);
 #endif
     set_pref=
ix(mi);
     vlan_process_outgoing_tun(m, mi);
     process_outgoing_tun(&m=
i->context, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_process=
_post(m, mi, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
     cl=
ear_prefix();
-    return ret;
 }
 
 /*
@@ -311,23 +303,20 @@
     return N=
ULL;
 }
 
-static bool
+static void
 multi_io_send_link(struct multi_contex=
t *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    bool=
 ret =3D true;
     set_prefix(mi);
     process_outgoing_link(&mi->context=
, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_process_post(m, m=
i, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
     clear_prefix=
();
-    return ret;
 }
 
-static bool
+static void
 multi_io_write_link_de=
ferred(struct multi_context *m, struct multi_instance *mi,
                =
              const unsigned int mpp_flags)
 {
     struct mbuf_item item;
=
-    bool ret =3D true;
     ASSERT(mi);
 
     /* extract from queue */
@@=
 -337,18 +326,15 @@
 
         ASSERT(mi =3D=3D item=2Einstance);
         =
mi->context=2Ec2=2Eto_link =3D item=2Ebuffer->buf;
-        ret =3D multi_i=
o_send_link(m, mi, mpp_flags);
+        multi_io_send_link(m, mi, mpp_flags=
);
         mbuf_free_buf(item=2Ebuffer);
     }
-    return ret;
 }
 
-sta=
tic bool
+static void
 multi_io_write_link(struct multi_context *m, struct =
multi_instance *mi, bool defer,
                     const unsigned int mpp=
_flags)
 {
-    bool ret =3D true;
-
     mi =3D multi_io_write_link_pre(m,=
 mi);
     if (mi)
     {
@@ -369,16 +355,15 @@
                 mbuf_add_i=
tem(mi->tcp_link_out_deferred, &item);
                 mbuf_free_buf(mb);
=
                 buf_reset(buf);
-                ret =3D multi_process_pos=
t(m, mi, mpp_flags);
+                multi_process_post(m, mi, mpp_flags);=

                 clear_prefix();
             }
         }
         else
 =
        {
-            ret =3D multi_io_send_link(m, mi, mpp_flags);
+     =
       multi_io_send_link(m, mi, mpp_flags);
         }
     }
-    return =
ret;
 }
 
 static struct multi_instance *

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
Gerrit-C=
hange-Number: 2051
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <g=
ianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--TTGWQUnLDJw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi: drop MPP_CLOSE_ON_SIGNAL<br><br>The UDP path, th=
e last user of MPP_CLOSE_ON_SIGNAL, now goes through<br>multi_io_action(), =
which closes the signalled instance itself=2E Without<br>the flag multi_pro=
cess_post() always returns true, and the functions<br>that only passed its =
result along return a value nobody reads=2E<br><br>Drop the flag and make m=
ulti_process_post(), the incoming and timeout<br>processing functions and t=
he static write functions of multi_io=2Ec<br>return void=2E The check of th=
e multi_process_post() result in<br>multi_create_instance() could never fai=
l and goes away as well=2E<br><br>Change-Id: Ie755169bb32da856e941a214f43fb=
b243b768d75<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=
=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>=
M src/openvpn/multi_io=2Ec<br>3 files changed, 26 insertions(+), 74 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/51/2051/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec=
 b/src/openvpn/multi=2Ec</span><br><span>index b1d7713=2E=2E868ebc3 100644<=
/span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openv=
pn/multi=2Ec</span><br><span>@@ -775,11 +775,7 @@</span><br><span>     mi-&=
gt;inotify_watch =3D -1;</span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!multi_process_post(m,=
 mi, MPP_PRE_SELECT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MU=
LTI_ERRORS, &quot;MULTI: signal occurred during client instance initializat=
ion&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        go=
to err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    multi_process_post(m, mi=
, MPP_PRE_SELECT);</span><br><span> </span><br><span>     mi-&gt;ev_arg=2Et=
ype =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span>     mi-&gt;ev_arg=2Eu=2E=
mi =3D mi;</span><br><span>@@ -3021,14 +3017,10 @@</span><br><span>  * Figu=
re instance-specific timers, convert</span><br><span>  * earliest to absolu=
te time in mi-&gt;wakeup,</span><br><span>  * call scheduler with our futur=
e wakeup time=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Also close context on=
 signal=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span> multi_process_post(struct multi_context *m, struct multi_i=
nstance *mi, const unsigned int flags)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!IS_SIG(&amp=
;mi-&gt;context)</span><br><span>         &amp;&amp; ((flags &amp; MPP_PRE_=
SELECT)))</span><br><span>     {</span><br><span>@@ -3086,16 +3078,8 @@</sp=
an><br><span>         }</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(&amp;mi-&gt;conte=
xt))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; MPP_CLOSE=
_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_clos=
e_instance_on_signal(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ret =3D false;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!IS_SIG(&amp;mi-&gt;context))</span><br><span>=
     {</span><br><span>         printf(&quot;POST %s[%d] to=3D%d lo=3D%d/%d=
 w=3D%&quot; PRIi64 &quot;/%ld\n&quot;, id(mi), (int)ANY_OUT(&amp;mi-&gt;co=
ntext),</span><br><span>                mi-&gt;context=2Ec2=2Eto_tun=2Elen,=
 mi-&gt;context=2Ec2=2Eto_link=2Elen,</span><br><span>@@ -3108,8 +3092,6 @@=
</span><br><span>     {</span><br><span>         *m-&gt;mpp_touched =3D mi;=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</sp=
an><br><span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -=
3541,13 +3523,12 @@</span><br><span>  * Process packets in the TCP/UDP sock=
et -&gt; TUN/TAP interface direction,</span><br><span>  * i=2Ee=2E client -=
&gt; server direction=2E</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span> multi_process_incoming_link(struct multi_con=
text *m, struct multi_instance *instance,</span><br><span>                 =
            const unsigned int mpp_flags, struct link_socket *sock)</span><=
br><span> {</span><br><span>     struct multi_instance *mi =3D instance;</s=
pan><br><span>     struct context *c;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    bool ret =3D true;</span><br><span>     bool floated =
=3D false;</span><br><span> </span><br><span>     if (!mi)</span><br><span>=
@@ -3560,7 +3541,7 @@</span><br><span> </span><br><span>     if (!mi)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span>     }</span><br><span>     set_prefix(mi);</s=
pan><br><span> </span><br><span>@@ -3585,22 +3566,18 @@</span><br><span>   =
  }</span><br><span> </span><br><span>     /* postprocess and set wakeup */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_pro=
cess_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    multi_process_post(m, mi, mpp_flags);</span><br><span> </span>=
<br><span>     clear_prefix();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return r=
et;</span><br><span> }</span><br><span> </span><br><span> /*</span><br><spa=
n>  * Process packets in the TUN/TAP interface -&gt; TCP/UDP socket directi=
on,</span><br><span>  * i=2Ee=2E server -&gt; client direction=2E</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> mul=
ti_process_incoming_tun(struct multi_context *m, const unsigned int mpp_fla=
gs)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    bool ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>     if (BLEN(&amp;m-&gt;top=2Ec2=2Ebuf) &gt; 0)</span><=
br><span>     {</span><br><span>         unsigned int mroute_flags;</span><=
br><span>@@ -3617,7 +3594,7 @@</span><br><span>             vid =3D vlan_de=
capsulate(&amp;m-&gt;top, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>     =
        if (vid &lt; 0)</span><br><span>             {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                return;</span><b=
r><span>             }</span><br><span>         }</span><br><span> </span><=
br><span>@@ -3668,14 +3645,13 @@</span><br><span>                     proce=
ss_incoming_tun(c, c-&gt;c2=2Elink_sockets[0]);</span><br><span> </span><br=
><span>                     /* postprocess and set wakeup */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    ret =3D multi_pr=
ocess_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    multi_process_post(m, mi, mpp_flags);</span><=
br><span> </span><br><span>                     clear_prefix();</span><br><=
span>                 }</span><br><span>             }</span><br><span>    =
     }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return ret;</span><br><span> }</span><br><span> </span><br><spa=
n> /*</span><br><span>@@ -3718,11 +3694,9 @@</span><br><span>  * Called whe=
n an I/O wait times out=2E  Usually means that a particular</span><br><span=
>  * client instance object needs timer-based service=2E</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> multi_proces=
s_timeout(struct multi_context *m, const unsigned int mpp_flags)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     printf(&quot;%s -&=
gt; TIMEOUT\n&quot;, id(m-&gt;earliest_wakeup));</span><br><span> #endif</s=
pan><br><span>@@ -3739,12 +3713,11 @@</span><br><span>         else</span><=
br><span>         {</span><br><span>             set_prefix(m-&gt;earliest_=
wakeup);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r=
et =3D multi_process_post(m, m-&gt;earliest_wakeup, mpp_flags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi_process_post(=
m, m-&gt;earliest_wakeup, mpp_flags);</span><br><span>             clear_pr=
efix();</span><br><span>         }</span><br><span>         m-&gt;earliest_=
wakeup =3D NULL;</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return ret;</span><br><span> }</span><br><span> </spa=
n><br><span> /*</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/op=
envpn/multi=2Eh</span><br><span>index 02841af=2E=2E103c0334 100644</span><b=
r><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=
=2Eh</span><br><span>@@ -282,11 +282,10 @@</span><br><span> </span><br><spa=
n> void multi_close_instance(struct multi_context *m, struct multi_instance=
 *mi, bool shutdown);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool multi_process_timeout(struct multi_context *m, const=
 unsigned int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void multi_process_timeout(struct multi_context *m, const unsigned in=
t mpp_flags);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define MPP_PRE_SELECT      (1 &lt;&lt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define MPP_CLOSE_ON_SIGNAL (1 &lt;&lt; 1)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MPP_RECORD_TOU=
CH    (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define MPP_PRE_SELECT   (1 &lt;&lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define MPP_RECORD_TOUCH (1 &lt;&lt; 2)</span><br><spa=
n> </span><br><span> </span><br><span> /***********************************=
***************************************/</span><br><span>@@ -305,13 +304,8 =
@@</span><br><span>  * @param mi           - The \c multi_instance of the V=
PN tunnel to be</span><br><span>  *                       postprocessed=2E<=
/span><br><span>  * @param flags        - Fast I/O optimization flags=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  - True, if the VPN tunnel instance \a mi was not c=
losed due to a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    s=
ignal during processing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  - False, if the VPN tunnel instance \a mi was closed=2E</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_=
process_post(struct multi_context *m, struct multi_instance *mi,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void multi_process_post(struct=
 multi_context *m, struct multi_instance *mi,</span><br><span>             =
            const unsigned int flags);</span><br><span> </span><br><span> /=
**</span><br><span>@@ -345,7 +339,7 @@</span><br><span>  * @param mpp_flags=
    - Fast I/O optimization flags=2E</span><br><span>  * @param sock       =
  - Socket where the packet was received=2E</span><br><span>  */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool multi_process_incoming_link=
(struct multi_context *m, struct multi_instance *instance,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void multi_process_incoming_link(str=
uct multi_context *m, struct multi_instance *instance,</span><br><span>    =
                              const unsigned int mpp_flags, struct link_soc=
ket *sock);</span><br><span> </span><br><span> </span><br><span>@@ -364,7 +=
358,7 @@</span><br><span>  * @param m            - The single \c multi_cont=
ext structure=2E</span><br><span>  * @param mpp_flags    - Fast I/O optimiz=
ation flags=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool multi_process_incoming_tun(struct multi_context *m, cons=
t unsigned int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void multi_process_incoming_tun(struct multi_context *m, const unsig=
ned int mpp_flags);</span><br><span> </span><br><span> </span><br><span> st=
ruct multi_instance *multi_get_queue(struct mbuf_set *ms);</span><br><span>=
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br>=
<span>index 59afb51=2E=2E31da970 100644</span><br><span>--- a/src/openvpn/m=
ulti_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>=
@@ -253,26 +253,18 @@</span><br><span>  * @param m            - The single =
\c multi_context structure=2E</span><br><span>  * @param mi           - The=
 \c multi_instance with the packet to send=2E</span><br><span>  * @param mp=
p_flags    - Fast I/O optimization flags=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @return</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - Tr=
ue, if the \c multi_instance associated with the packet sent was</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *    not closed due to a signal=
 during processing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  - Falls, if the \c multi_instance was closed=2E</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> mul=
ti_io_write_tun(struct multi_context *m, struct multi_instance *mi, const u=
nsigned int mpp_flags)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span>=
<br><span>     printf(&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;c=
ontext=2Ec2=2Eto_tun=2Elen);</span><br><span> #endif</span><br><span>     s=
et_prefix(mi);</span><br><span>     vlan_process_outgoing_tun(m, mi);</span=
><br><span>     process_outgoing_tun(&amp;mi-&gt;context, mi-&gt;context=2E=
c2=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    multi_process_post(m, mi, mpp_flags);</s=
pan><br><span>     clear_prefix();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return ret;</span><br><span> }</span><br><span> </span><br=
><span> /*</span><br><span>@@ -311,23 +303,20 @@</span><br><span>     retur=
n NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span> multi_io_send_link(struct multi=
_context *m, struct multi_instance *mi, const unsigned int mpp_flags)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 ret =3D true;</span><br><span>     set_prefix(mi);</span><br><span>     pr=
ocess_outgoing_link(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets=
[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D mult=
i_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    multi_process_post(m, mi, mpp_flags);</span><br><span>   =
  clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span> multi_io_write_link_deferre=
d(struct multi_context *m, struct multi_instance *mi,</span><br><span>     =
                         const unsigned int mpp_flags)</span><br><span> {</=
span><br><span>     struct mbuf_item item;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span>     ASSERT(mi)=
;</span><br><span> </span><br><span>     /* extract from queue */</span><br=
><span>@@ -337,18 +326,15 @@</span><br><span> </span><br><span>         ASS=
ERT(mi =3D=3D item=2Einstance);</span><br><span>         mi-&gt;context=2Ec=
2=2Eto_link =3D item=2Ebuffer-&gt;buf;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        ret =3D multi_io_send_link(m, mi, mpp_flags);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_io_send_li=
nk(m, mi, mpp_flags);</span><br><span>         mbuf_free_buf(item=2Ebuffer)=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return ret;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span> multi_io_write_link(=
struct multi_context *m, struct multi_instance *mi, bool defer,</span><br><=
span>                     const unsigned int mpp_flags)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 mi =3D multi_io_write_link_pre(m, mi);</span><br><span>     if (mi)</span>=
<br><span>     {</span><br><span>@@ -369,16 +355,15 @@</span><br><span>    =
             mbuf_add_item(mi-&gt;tcp_link_out_deferred, &amp;item);</span>=
<br><span>                 mbuf_free_buf(mb);</span><br><span>             =
    buf_reset(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                multi_process_post(=
m, mi, mpp_flags);</span><br><span>                 clear_prefix();</span><=
br><span>             }</span><br><span>         }</span><br><span>        =
 else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            ret =3D multi_io_send_link(m, mi, mpp_flags);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_io_send_=
link(m, mi, mpp_flags);</span><br><span>         }</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><=
br><span> }</span><br><span> </span><br><span> static struct multi_instance=
 *</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2051?usp=3Demail">change 2051</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb=
243b768d75 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2051 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--TTGWQUnLDJw=--


--===============8834114754560167796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8834114754560167796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8834114754560167796==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41F606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KavjBHUj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UpQ8nVbf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dFUH8hn5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BAUz6Rj1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=CNInPTyMeo9O3AzofPl0Qq4K9inY6K06pqk+LPejcdY=; b=KavjBHUjVW3Z/BQjTtJyuWOCkP
	fxPC2UAUUGX2+J7d3EaDVSjJZ1Vvz0WZNQpdk3cLhi5y/nUIr/yDE7jYga5CyJUjoEQ9/E2Vi9Ub8
	O7kx+el5SVZ5I59HH4QSAiStnaq1qMSr7Lckd/ZrDOeJZpl6q1CZVKUFkER9gS5i2WfA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWYiO-000000003uE-2kKv;
	Thu, 26 Nov 2026 12:36:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWYiE-000000003u1-2hhp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4RlkYnpuLUjVRFjn9q1h4fNNxOXTG0mDz2ZcK1zDr7w=; b=UpQ8nVbfjMJ7ufnV23kvRjJgyX
 emN/Q7buTmDj+gib3gDwbtK78jijUa/HX7cQLFtSID/l0/NnKNdzz6MWz7+krFKCcyC3yZlOO+vY4
 4ZEmvgl3xrjrZNHhBE9llkhgurAI4HaGpsFarKQ51/xAHdSobPRGH0pgyfQOoQkfBGeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4RlkYnpuLUjVRFjn9q1h4fNNxOXTG0mDz2ZcK1zDr7w=; b=dFUH8hn5oX0bELRTkmapHta+rn
 O0hfrdVVKwdphGZ3pzco3DbqXcwJ4BPaimx2qFFeDuAWSgR2BkReOKBk+hkL0wuC80cIX3eyCdcyk
 rCIWxSP+oygPETQx/rpHpTJlgfUEQgVR1edKe3mazjLzMFylWFL7RGrrPft5wXc/0Ti4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWYiA-000000002Rb-1eHB for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:36:29 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4aa5833c263so6699319f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795696580; x=1796301380; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4RlkYnpuLUjVRFjn9q1h4fNNxOXTG0mDz2ZcK1zDr7w=;
 b=BAUz6Rj12UCRkQoaUXUIKlXd5Jttp2qpn/X5/yvUDrTo+RilWKOrYopY1XhdskkvIs
 gmFQ0iSBAAdBi881XUp4gm+qy4j7Mv90qpQw5wVGqug6uMGJk10iVVjjMUOxpzut+LXK
 eleGXLd4irXnrtTJDdzR5ItNfH7uMjbgCJO/RVEhSaHjrxn0KuKr6PjPfcezUyAEv8jg
 Ed13PdXe3BNxP1V600ICOvxpjRiQmDuXQ6q/lZjsq3o/bM+20zspEvCeKKlszW5RqtNn
 MJInFW+h26VvMrlbrnYrHgt/B/NFkjtGos010g3nLdSvCylGsDcHk4J7dzI/x4fbwam4
 Z0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795696580; x=1796301380;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4RlkYnpuLUjVRFjn9q1h4fNNxOXTG0mDz2ZcK1zDr7w=;
 b=Em+j6TPVlHZkz0OfQcVxjim8T5uU8Q29J/ERvE0rkAB+UuRjJyzi+C2h22q4TRnCzy
 J9wrN8Beb3KxiD3ohmKwQEY/PaHtJ+LOQ2ytmbGTrq1hrS9+wpLhZxoKgY4anHS5Zf6z
 bHFRoiJT/PVpYz5D3u2OcK2/P4vuxvyDFJSdr6dYskp2sbJaER8nycxCu6Z3Q2Dj/FBe
 tlB0gfh/uKUePsVMDXPNIHiPZXL8sPSSDyDwmW97CbpsGEksYqD78GeYwvgc+F2E/PXd
 9L9lCkeIiiPOq70wNu2Ojtds+UYolKv54l2GL9Ys9SRYT25qXcFw4G3/PlRBCyuoEGsy
 Teqg==
X-Gm-Message-State: APuU4Z+UvMkAq2c5k3W3okLzIsD0iW8SxhuLJahQ5QW89ONRrXC12G+6
 /7k+JPxqYv2wz9RojpV9up9mhDpzBHi69/RJgPpFTLyzZsrbSeOCL/ftLSsZNIQnZjYzYz+tDvK
 oj6RXECv4KouXKfivr0ur/KAk/0kQybs0hUOyz+3aKag2V/r/nFbVQL/ob7NiiATZ1TIwKQFXtd
 PKynQJjg==
X-Gm-Gg: AZFdTZfPcdjkzzSEkxWpgqgNKaBaMV4yGzj6TGB4HEdvEO/gD4k0NMXHT6AQJEL49Dq
 oh3cO2Vc/kLlMmdiaTXiOVvcHEq7CMhUDJFZOUBqlYKursrQRsEpbwKu3Vw6FzlBL5GE4jNiY5k
 h/sr1/wcOy14vc7n4agPB49cHjnNfGf0xAY7xPstEzkCwmW2P2jcZ+EL7Kos/8HqDMvdpH2XHyZ
 ntGCzMQWFPRHWviB16AlNURkUH0ik1O1U0Q4nCesbf4lHXa6CNE+EcBDxsMCidAKTMNIVJlIERn
 +bD/IL89gT5IU0jn6oEldU51Uej1WWdnb3QxypNNkF1C8/xL9WRZJOA9GpjCPfHFhA85lSKwvMa
 TJiqlS3/ufTzKVH1tnPuF7vMlK4KtXnj+0HXTgt/S2/fVHW2xce/iE4Z/8xdbH8waGngXQN4Fik
 PpULunb0P4SQYRwDk9JbpadZRCi+cPWVVfw60mOzJMblJw+y5AnQDOKy8ZgbzAKXnUv7tRQmjMr
 Og/N9hxV6oHhmeIlspfYTSi8VphTDN0biqVnNZysB7DRVd342AxKrhobEiJg5fFyqPbs0G8Hc1L
 Ghp4/fBMlqVtGcmFwGDYHWokRGEDgpuLKkaSXoDyE/Ozz2YWZJ7SbZDP0dTuBKLt0a58CrPNtCO
 b/AkWFb3eNZXb1sWJgYLZnIwI9LDZ+0kZKFnkKdaPZQNw4fyCf/AP+ztS77+n7gYBFGU0fXXSV5
 nds+PkpSkCu02cjbU=
X-Received: by 2002:a05:600c:3b99:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4bb8880b984mr489310505e9.14.1795696579639; 
 Thu, 26 Nov 2026 04:36:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm666627965e9.14.2026.11.26.04.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 04:36:19 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 12:36:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9f3ee97589606af5904a580f594fc1647eb91395
X-Gerrit-Change-Number: 2354
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2354?usp=email>
X-Gerrit-Commit: 1eb03578121af19fba8b714436e237397a2eb08e
References: <gerrit.1795696577000.I9f3ee97589606af5904a580f594fc1647eb91395@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk2NTc3MDAwLkk5ZjNlZTk3NTg5NjA2YWY1OTA0YTU4MGY1OTRmYzE2NDdlYjkxMzk1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d44d17e646eb7d55d347cdf3e87af5c2bf112fb-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWYiA-000000002Rb-1eHB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove redundant
 statements
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5384462956507471984=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5384462956507471984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NNRJdxZqr6c="; charset=UTF-8

--NNRJdxZqr6c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2354?usp=3Demail

to review the following change=2E
=


Change subject: Remove redundant statements
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove redundant statements

- Fields se=
t to zero right after ALLOC_OBJ_CLEAR (buffer_list_new,
  env_set_create, s=
tatus_open)=2E
- hash_init(): ALLOC_ARRAY_CLEAR instead of ALLOC_ARRAY plus=
 a loop
  setting each bucket list to NULL=2E
- route=2Ec: CLEAR(rtm) after=
 CLEAR(m_rtmsg); rtm is m_rtmsg=2Em_rtm=2E
- win32-util=2Ec: checks on gc_m=
alloc() results; it never returns NULL=2E
- should_trigger_renegotiation():=
 return the comparison directly=2E
- peer_info_extract_varstr(): NULL check=
 the while loop already does=2E

Change-Id: I9f3ee97589606af5904a580f594fc1=
647eb91395
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src=
/openvpn/buffer=2Ec
M src/openvpn/env_set=2Ec
M src/openvpn/list=2Ec
M src/=
openvpn/route=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_util=2Ec
M src/op=
envpn/status=2Ec
M src/openvpn/win32-util=2Ec
8 files changed, 3 insertions=
(+), 30 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/54/2354/1

diff --git a/src/openvpn/buffer=2Ec b/src/openvp=
n/buffer=2Ec
index c33a987=2E=2E4b660da 100644
--- a/src/openvpn/buffer=2Ec=

+++ b/src/openvpn/buffer=2Ec
@@ -1186,7 +1186,6 @@
 {
     struct buffer_l=
ist *ret;
     ALLOC_OBJ_CLEAR(ret, struct buffer_list);
-    ret->size =3D=
 0;
     return ret;
 }
 
diff --git a/src/openvpn/env_set=2Ec b/src/openvp=
n/env_set=2Ec
index 55190b8=2E=2E5bbb17b 100644
--- a/src/openvpn/env_set=
=2Ec
+++ b/src/openvpn/env_set=2Ec
@@ -156,7 +156,6 @@
 {
     struct env_s=
et *es;
     ALLOC_OBJ_CLEAR_GC(es, struct env_set, gc);
-    es->list =3D =
NULL;
     es->gc =3D gc;
     return es;
 }
diff --git a/src/openvpn/list=
=2Ec b/src/openvpn/list=2Ec
index 505be30=2E=2E7b385da 100644
--- a/src/ope=
nvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -49,12 +49,7 @@
     /* create =
random hash key */
     prng_bytes(h->hash_key, sizeof(h->hash_key));
 
-  =
  ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
-    for (uint=
32_t i =3D 0; i < h->n_buckets; ++i)
-    {
-        struct hash_bucket *b =
=3D &h->buckets[i];
-        b->list =3D NULL;
-    }
+    ALLOC_ARRAY_CLEA=
R(h->buckets, struct hash_bucket, h->n_buckets);
     return h;
 }
 
diff -=
-git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 82cb7f0=2E=2E455=
3e73 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -333=
4,7 +3334,6 @@
     CLEAR(m_rtmsg);
     CLEAR(so_dst);
     CLEAR(so_mask)=
;
-    CLEAR(rtm);
 
     rtm=2Ertm_type =3D RTM_GET;
     rtm=2Ertm_flags =
=3D RTF_UP | RTF_GATEWAY;
@@ -3552,7 +3551,6 @@
     CLEAR(m_rtmsg);
     C=
LEAR(so_dst);
     CLEAR(so_mask);
-    CLEAR(rtm);
 
     rtm=2Ertm_type =
=3D RTM_GET;
     rtm=2Ertm_flags =3D RTF_UP;
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index ca5958f=2E=2E5c72b56 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3105,14 +3105,7 @@
     {
       =
  /* We only need to check the send key as we always keep send
          * =
key epoch >=3D recv key epoch in \c epoch_replace_update_recv_key */
-     =
   if (ks->crypto_options=2Eepoch_key_send=2Eepoch >=3D 0xF000)
-        {
=
-            return true;
-        }
-        else
-        {
-            =
return false;
-        }
+        return ks->crypto_options=2Eepoch_key_sen=
d=2Eepoch >=3D 0xF000;
     }
 
 
diff --git a/src/openvpn/ssl_util=2Ec b/s=
rc/openvpn/ssl_util=2Ec
index 6c17fe5=2E=2E9bfb75f 100644
--- a/src/openvpn=
/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -35,11 +35,6 @@
 static con=
st char *
 peer_info_extract_varstr(const char *peer_info, const char *fiel=
d)
 {
-    if (!peer_info)
-    {
-        return NULL;
-    }
-
     while=
 (peer_info)
     {
         /* peer info starts with this field */
diff --=
git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index 0a3fc019=2E=2Ee=
96ff51 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ =
-72,8 +72,6 @@
         so->msglevel =3D msglevel;
         so->vout =3D vo=
ut;
         so->fd =3D -1;
-        buf_reset(&so->read_buf);
-        eve=
nt_timeout_clear(&so->et);
         if (filename)
         {
             s=
witch (so->flags)
diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win=
32-util=2Ec
index 5f99e2b=2E=2Ef586e09 100644
--- a/src/openvpn/win32-util=
=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -92,7 +92,6 @@
     }
 
     work =
=3D gc_malloc(maxlen + 1, false, gc);
-    check_malloc_return(work);
     =
buf =3D alloc_buf_gc(nchars, gc);
 
     for (i =3D 0; i < a->argc; ++i)
@@=
 -128,10 +127,7 @@
     if (n > 0)
     {
         utf8 =3D gc_malloc(n, tr=
ue, gc);
-        if (utf8)
-        {
-            WideCharToMultiByte(CP_=
UTF8, 0, utf16, -1, utf8, n, NULL, NULL);
-        }
+        WideCharToMul=
tiByte(CP_UTF8, 0, utf16, -1, utf8, n, NULL, NULL);
     }
     return utf8=
;
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2354?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9f3ee975896=
06af5904a580f594fc1647eb91395
Gerrit-Change-Number: 2354
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>

--NNRJdxZqr6c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2354?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Remove redundant statements<br><br>- Fields set to zero=
 right after ALLOC_OBJ_CLEAR (buffer_list_new,<br>  env_set_create, status_=
open)=2E<br>- hash_init(): ALLOC_ARRAY_CLEAR instead of ALLOC_ARRAY plus a =
loop<br>  setting each bucket list to NULL=2E<br>- route=2Ec: CLEAR(rtm) af=
ter CLEAR(m_rtmsg); rtm is m_rtmsg=2Em_rtm=2E<br>- win32-util=2Ec: checks o=
n gc_malloc() results; it never returns NULL=2E<br>- should_trigger_renegot=
iation(): return the comparison directly=2E<br>- peer_info_extract_varstr()=
: NULL check the while loop already does=2E<br><br>Change-Id: I9f3ee9758960=
6af5904a580f594fc1647eb91395<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/env_s=
et=2Ec<br>M src/openvpn/list=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvp=
n/ssl=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/status=2Ec<br>M sr=
c/openvpn/win32-util=2Ec<br>8 files changed, 3 insertions(+), 30 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/54/2354/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b=
/src/openvpn/buffer=2Ec</span><br><span>index c33a987=2E=2E4b660da 100644</=
span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openv=
pn/buffer=2Ec</span><br><span>@@ -1186,7 +1186,6 @@</span><br><span> {</spa=
n><br><span>     struct buffer_list *ret;</span><br><span>     ALLOC_OBJ_CL=
EAR(ret, struct buffer_list);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ret-&gt;size =3D 0;</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/env_set=
=2Ec b/src/openvpn/env_set=2Ec</span><br><span>index 55190b8=2E=2E5bbb17b 1=
00644</span><br><span>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/s=
rc/openvpn/env_set=2Ec</span><br><span>@@ -156,7 +156,6 @@</span><br><span>=
 {</span><br><span>     struct env_set *es;</span><br><span>     ALLOC_OBJ_=
CLEAR_GC(es, struct env_set, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    es-&gt;list =3D NULL;</span><br><span>     es-&gt;gc =3D gc=
;</span><br><span>     return es;</span><br><span> }</span><br><span>diff -=
-git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index 50=
5be30=2E=2E7b385da 100644</span><br><span>--- a/src/openvpn/list=2Ec</span>=
<br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -49,12 +49,7 @@</sp=
an><br><span>     /* create random hash key */</span><br><span>     prng_by=
tes(h-&gt;hash_key, sizeof(h-&gt;hash_key));</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(h-&gt;buckets, str=
uct hash_bucket, h-&gt;n_buckets);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    for (uint32_t i =3D 0; i &lt; h-&gt;n_buckets; ++i)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *b =3D &amp;h-&g=
t;buckets[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
b-&gt;list =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY=
_CLEAR(h-&gt;buckets, struct hash_bucket, h-&gt;n_buckets);</span><br><span=
>     return h;</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index =
82cb7f0=2E=2E4553e73 100644</span><br><span>--- a/src/openvpn/route=2Ec</sp=
an><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -3334,7 +3334,6=
 @@</span><br><span>     CLEAR(m_rtmsg);</span><br><span>     CLEAR(so_dst)=
;</span><br><span>     CLEAR(so_mask);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    CLEAR(rtm);</span><br><span> </span><br><span>     rtm=
=2Ertm_type =3D RTM_GET;</span><br><span>     rtm=2Ertm_flags =3D RTF_UP | =
RTF_GATEWAY;</span><br><span>@@ -3552,7 +3551,6 @@</span><br><span>     CLE=
AR(m_rtmsg);</span><br><span>     CLEAR(so_dst);</span><br><span>     CLEAR=
(so_mask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(r=
tm);</span><br><span> </span><br><span>     rtm=2Ertm_type =3D RTM_GET;</sp=
an><br><span>     rtm=2Ertm_flags =3D RTF_UP;</span><br><span>diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ca5958f=2E=
=2E5c72b56 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3105,14 +3105,7 @@</span><br=
><span>     {</span><br><span>         /* We only need to check the send ke=
y as we always keep send</span><br><span>          * key epoch &gt;=3D recv=
 key epoch in \c epoch_replace_update_recv_key */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (ks-&gt;crypto_options=2Eepoch_key_s=
end=2Eepoch &gt;=3D 0xF000)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return ks-&gt;crypto_options=2Eep=
och_key_send=2Eepoch &gt;=3D 0xF000;</span><br><span>     }</span><br><span=
> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_util=2Ec =
b/src/openvpn/ssl_util=2Ec</span><br><span>index 6c17fe5=2E=2E9bfb75f 10064=
4</span><br><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_util=2Ec</span><br><span>@@ -35,11 +35,6 @@</span><br><span> st=
atic const char *</span><br><span> peer_info_extract_varstr(const char *pee=
r_info, const char *field)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!peer_info)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     while (peer_info)</span><br><span>     {</span><br><span>       =
  /* peer info starts with this field */</span><br><span>diff --git a/src/o=
penvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><span>index 0a3fc019=
=2E=2Ee96ff51 100644</span><br><span>--- a/src/openvpn/status=2Ec</span><br=
><span>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -72,8 +72,6 @@</span=
><br><span>         so-&gt;msglevel =3D msglevel;</span><br><span>         =
so-&gt;vout =3D vout;</span><br><span>         so-&gt;fd =3D -1;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        buf_reset(&amp;so-&gt;re=
ad_buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event=
_timeout_clear(&amp;so-&gt;et);</span><br><span>         if (filename)</spa=
n><br><span>         {</span><br><span>             switch (so-&gt;flags)</=
span><br><span>diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-=
util=2Ec</span><br><span>index 5f99e2b=2E=2Ef586e09 100644</span><br><span>=
--- a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/win32-ut=
il=2Ec</span><br><span>@@ -92,7 +92,6 @@</span><br><span>     }</span><br><=
span> </span><br><span>     work =3D gc_malloc(maxlen + 1, false, gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(wo=
rk);</span><br><span>     buf =3D alloc_buf_gc(nchars, gc);</span><br><span=
> </span><br><span>     for (i =3D 0; i &lt; a-&gt;argc; ++i)</span><br><sp=
an>@@ -128,10 +127,7 @@</span><br><span>     if (n &gt; 0)</span><br><span>=
     {</span><br><span>         utf8 =3D gc_malloc(n, true, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (utf8)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            WideCharToMultiByte(CP_UTF8, 0, utf1=
6, -1, utf8, n, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     WideCharToMultiByte(CP_UTF8, 0, utf16, -1, utf8, n, NULL, NULL);</span=
><br><span>     }</span><br><span>     return utf8;</span><br><span> }</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2354?usp=3Demail">change 2354</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2354?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I9f3ee97589606af5904a580f594fc1647eb9=
1395 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2354 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--NNRJdxZqr6c=--


--===============5384462956507471984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5384462956507471984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5384462956507471984==--


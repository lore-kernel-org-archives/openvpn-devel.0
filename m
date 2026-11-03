Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAB606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OC/h8RVJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z3yae/Um;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KnOQAZvq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BHvP0ZNi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R/ha00+3/MdnFQIwt+b7IjHVD07fZ+SMVA+UtD7u6ms=; b=OC/h8RVJIp3o9kRgciVehuM/jO
	kvKjinez8dylOkXCe9qb4eg+aUhQiJfcmRHmRZA0o3MF2A6gvvScl/bf6WMZQeri1uJr7D6EZT461
	hzlOjQ8PDUAahPl/3WdnZZOD82/LSqqh2UNlE9lVDDlX4KfMMD9S+k0JgFlQtvzxYExk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOAL9-000000000sG-0d5r;
	Tue, 03 Nov 2026 08:57:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOAL7-000000000ri-37l9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWvnKo8m1ubU5VNzR4bLZnWbN88duUw7tGyChkA/v5U=; b=Z3yae/UmU7/4gQbJtit4YiyhmI
 E/+k+pdlANsAgmhthRr7JYk1FBijGbYLLNCT1YwN4UrftYVj4CWltxu9CHP7wZZpaMMFtJOV+cN8q
 MKda+Xq3sQluxH8m1ENZPorIU4xZzn0gtVRObY2qU1fDVkIzGDisW0Sn91hcPdNFcuEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWvnKo8m1ubU5VNzR4bLZnWbN88duUw7tGyChkA/v5U=; b=KnOQAZvqt63RGwvFXE/YhezETd
 R8EMNCuCd4Y1pveElgRYCU7LMQHBWhEahWwuqbB10p8DmYIM9wTYKGAquH/ezzKjsf/vV1UJGEXCk
 6rwz8iDzbro2hKo6HcRV/wqFV59T7rQUxNd+gDl0tlG8OXV/mfL+0r7xSFFrTYlPt/FE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOAKs-000000004wS-3hxB for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:57:57 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so24821235e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793696256; x=1794301056; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gWvnKo8m1ubU5VNzR4bLZnWbN88duUw7tGyChkA/v5U=;
 b=BHvP0ZNiyjNh5uJ222j4pDxgx4mUqe+qHQHUBDYo98uJwgzA+UUMvCFV+X97LLVuq9
 966ChFniLBg2GGwKbUvCbUopAa+7ZIpXqxps6ZgMvoNJ04sADSt6eUH6ZoV7+g+t19eK
 Lfi9mXw0tOve/P2SK20OR7es8siRanTWr6zZy33Dgb9ET/rf6Dtf254MrEz9xSFpScE7
 G0z6bZdeWxd4nxAon8LJ3ocICK/RNOntjWnhi3+x4roMW1Z+39uqQxSWwqRmB43e/0k7
 AxGWg9lowafwVkmNVQiQbe0HCzwfDjeGLtF4UgR1S76zjndgu8cqbV85T+nKad6Tvt+P
 1FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696256; x=1794301056;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gWvnKo8m1ubU5VNzR4bLZnWbN88duUw7tGyChkA/v5U=;
 b=nMIL0rmUqWG8ap0BP0rVmuhB+q4OiK1ISU8R+f7sN5qKyV6Yijg+O+cWRIp+h7+4Tm
 Z7YnB6fF5ScpSG/YqCWtNu0xORprvFZGUrIXb8U7L38IwbfRLw2pSuMeGbYuksJSwPEG
 6hIkLbWBKohxltzXWnoTdqYCVeoqDD7aVdVbSaNxXVj1WXN/3wzqY02UUWx6lzkf779r
 sC4dRjl8BUA0867jJjejCiWks4rIGpMKXsTt+sDa5Q7yuZJLo8g4f8N0upn3DVF3f19H
 FK2CltJ/Vyiaq77xwDFiurjDYli4+5+pXDQxjPkRzE8Jt1Kj9HG/bMgJI/hWGsJAwARf
 VquA==
X-Gm-Message-State: APuU4Z+sg1Q/UrmMYpFNvTLYU/WYWrN6wnHz0sdh3KE/J4BSBLau2wCB
 dkZq9hMD1LmnTIo6Rq44H0TH1vBtZlpFq1nC84oWnAG/5PXxH+hb4HBWa8OfpfjUj60xpMAdnEs
 fUHxMFuDPQuhcqdQ24UnZNGKOmCb7RRKFFmJh441Zhof85A2fmefeMCpGE9G78wKk5GVk
X-Gm-Gg: AYBFou33XWYn7epnyGqKevqRbwl8e36vd3ZVB8qWnlFIupBhL9xM2m7wzacBwlUzPEZ
 WZDTHvYnhkBt7vV1ZIoXmQat8Vz0OCt23W4oNzM+ffi6rgHZkV3TgqYQFndC/ph21G6289xIiFR
 I7KnBB2AHo/JToqr36qzURsC5i/pcpyfk9AW/Axb2Fz1Qz3KxgWpgGW02OsuwaFMv6bbJsG35Gz
 +olWU4P+uqCPXkroSdt5vmLcSHR6vqrO4xKZpA2Hk4HEDBrUXiHOnez6w/3yJoGF0BI6q0TNzyh
 Qy7JLTRf88TzogPXxpZwtuxkpsAktVp0ta9PEu3T1b2sKR0Q+nbycYvZAWNrQ5SKU91uwOTKGHP
 d9XSAolQ6hlikErJya3S35JFbqaMRDxUmf0GKW64JUzogcEnRQsUQKMq5HqA2GNM6DFbHPuedfw
 2Hg6I4RM0uvPCUeXWnfGLoCrrGdwcZfJKd8MC7Em65c5gALJ7O4tArl8erZ3gGmh8DLm50pgmvk
 7AJuOpUDcGJEACu9zTADY9fc8QVx9XMqrcVidWfWS+I8GxEHekwBvy4/W8mpiAZuqNff2LnGWAY
 Wri23KLk00gCM72wapOqLPMx36Nf0YqqNtHaT9hx2VkrIeENW5MduuRaiWvdfwKmboMfwbaBpae
 mXfudzfMBMTN5KY1dwTSStbQIwA+9scX41stBzQJtKlwrrE2yUWAS6AeAFnj/DS9Y5kB8rliFAG
 Pj2aa1Y0t3QWPX6g==
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4ac17ffb2ffmr288315925e9.9.1793696256085; 
 Tue, 03 Nov 2026 00:57:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm223321475e9.2.2026.11.03.00.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:57:35 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:57:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
X-Gerrit-Change-Number: 2051
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2051?usp=email>
X-Gerrit-Commit: e30b37ae898619b96ac42577cb58b47af0d2a783
In-Reply-To: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllNzU1MTY5YmIzMmRhODU2ZTk0MWEyMTRmNDNmYmIyNDNiNzY4ZDc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a3ab6bed09408a7adeb23ef36d34ec95203d735-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOAKs-000000004wS-3hxB
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
Content-Type: multipart/mixed; boundary="===============8693943880916216300=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8693943880916216300==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XK1Des4MgMg="; charset=UTF-8

--XK1Des4MgMg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2051?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: multi: drop MPP_CLOSE_ON_SIGNAL
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: drop MPP_CLOSE_ON_SIGNAL=


The UDP path, the last user of MPP_CLOSE_ON_SIGNAL, now goes through
mult=
i_io_action(), which closes the signalled instance itself=2E Without
the fl=
ag multi_process_post() always returns true, and the functions
that only pa=
ssed its result along return a value nobody reads=2E

Drop the flag and mak=
e multi_process_post(), the incoming and timeout
processing functions and t=
he static write functions of multi_io=2Ec
return void=2E The check of the m=
ulti_process_post() result in
multi_create_instance() could never fail and =
goes away as well=2E

Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
=
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/o=
penvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
3 files=
 changed, 26 insertions(+), 74 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/51/2051/2

diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index 2a4f78b=2E=2E05bdf91 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -778,11 +778,7 @@
     m=
i->inotify_watch =3D -1;
 #endif
 
-    if (!multi_process_post(m, mi, MPP_=
PRE_SELECT))
-    {
-        msg(D_MULTI_ERRORS, "MULTI: signal occurred du=
ring client instance initialization");
-        goto err;
-    }
+    multi=
_process_post(m, mi, MPP_PRE_SELECT);
 
     mi->ev_arg=2Etype =3D EVENT_AR=
G_MULTI_INSTANCE;
     mi->ev_arg=2Eu=2Emi =3D mi;
@@ -3033,14 +3029,10 @@
=
  * Figure instance-specific timers, convert
  * earliest to absolute time =
in mi->wakeup,
  * call scheduler with our future wakeup time=2E
- *
- * Al=
so close context on signal=2E
  */
-bool
+void
 multi_process_post(struct m=
ulti_context *m, struct multi_instance *mi, const unsigned int flags)
 {
- =
   bool ret =3D true;
-
     if (!IS_SIG(&mi->context)
         && ((flags =
& MPP_PRE_SELECT)))
     {
@@ -3098,16 +3090,8 @@
         }
     }
 
-    =
if (IS_SIG(&mi->context))
-    {
-        if (flags & MPP_CLOSE_ON_SIGNAL)
=
-        {
-            multi_close_instance_on_signal(m, mi);
-           =
 ret =3D false;
-        }
-    }
 #ifdef MULTI_DEBUG_EVENT_LOOP
-    else
=
+    if (!IS_SIG(&mi->context))
     {
         printf("POST %s[%d] to=3D%d=
 lo=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(mi), (int)ANY_OUT(&mi->context),
   =
             mi->context=2Ec2=2Eto_tun=2Elen, mi->context=2Ec2=2Eto_link=2E=
len,
@@ -3120,8 +3104,6 @@
     {
         *m->mpp_touched =3D mi;
     }
-=

-    return ret;
 }
 
 /**
@@ -3554,13 +3536,12 @@
  * Process packets in =
the TCP/UDP socket -> TUN/TAP interface direction,
  * i=2Ee=2E client -> s=
erver direction=2E
  */
-bool
+void
 multi_process_incoming_link(struct mul=
ti_context *m, struct multi_instance *instance,
                           =
  const unsigned int mpp_flags, struct link_socket *sock)
 {
     struct mu=
lti_instance *mi =3D instance;
     struct context *c;
-    bool ret =3D tr=
ue;
     bool floated =3D false;
 
     if (!mi)
@@ -3573,7 +3554,7 @@
 
  =
   if (!mi)
     {
-        return true;
+        return;
     }
     set_p=
refix(mi);
 
@@ -3598,22 +3579,18 @@
     }
 
     /* postprocess and set w=
akeup */
-    ret =3D multi_process_post(m, mi, mpp_flags);
+    multi_proc=
ess_post(m, mi, mpp_flags);
 
     clear_prefix();
-
-    return ret;
 }
 
=
 /*
  * Process packets in the TUN/TAP interface -> TCP/UDP socket directio=
n,
  * i=2Ee=2E server -> client direction=2E
  */
-bool
+void
 multi_proce=
ss_incoming_tun(struct multi_context *m, const unsigned int mpp_flags)
 {
-=
    bool ret =3D true;
-
     if (BLEN(&m->top=2Ec2=2Ebuf) > 0)
     {
    =
     unsigned int mroute_flags;
@@ -3630,7 +3607,7 @@
             vid =3D =
vlan_decapsulate(&m->top, &m->top=2Ec2=2Ebuf);
             if (vid < 0)
  =
           {
-                return false;
+                return;
      =
       }
         }
 
@@ -3681,14 +3658,13 @@
                     process_=
incoming_tun(c, c->c2=2Elink_sockets[0]);
 
                     /* postpro=
cess and set wakeup */
-                    ret =3D multi_process_post(m, m=
i, mpp_flags);
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
@@ -3731,11 +3707,9 @@
  * Called =
when an I/O wait times out=2E  Usually means that a particular
  * client i=
nstance object needs timer-based service=2E
  */
-bool
+void
 multi_process=
_timeout(struct multi_context *m, const unsigned int mpp_flags)
 {
-    boo=
l ret =3D true;
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TIMEOUT=
\n", id(m->earliest_wakeup));
 #endif
@@ -3752,12 +3726,11 @@
         else=

         {
             set_prefix(m->earliest_wakeup);
-            ret =
=3D multi_process_post(m, m->earliest_wakeup, mpp_flags);
+            mult=
i_process_post(m, m->earliest_wakeup, mpp_flags);
             clear_prefix=
();
         }
         m->earliest_wakeup =3D NULL;
     }
-    return ret=
;
 }
 
 /*
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index=
 305208a=2E=2E9d0fa85 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/=
multi=2Eh
@@ -284,11 +284,10 @@
 
 void multi_close_instance(struct multi_c=
ontext *m, struct multi_instance *mi, bool shutdown);
 
-bool multi_process=
_timeout(struct multi_context *m, const unsigned int mpp_flags);
+void mult=
i_process_timeout(struct multi_context *m, const unsigned int mpp_flags);
 =

-#define MPP_PRE_SELECT      (1 << 0)
-#define MPP_CLOSE_ON_SIGNAL (1 << 1=
)
-#define MPP_RECORD_TOUCH    (1 << 2)
+#define MPP_PRE_SELECT   (1 << 0)
=
+#define MPP_RECORD_TOUCH (1 << 2)
 
 
 /**********************************=
****************************************/
@@ -307,13 +306,8 @@
  * @param m=
i           - The \c multi_instance of the VPN tunnel to be
  *            =
           postprocessed=2E
  * @param flags        - Fast I/O optimization=
 flags=2E
- *
- * @return
- *  - True, if the VPN tunnel instance \a mi was=
 not closed due to a
- *    signal during processing=2E
- *  - False, if th=
e VPN tunnel instance \a mi was closed=2E
  */
-bool multi_process_post(str=
uct multi_context *m, struct multi_instance *mi,
+void multi_process_post(s=
truct multi_context *m, struct multi_instance *mi,
                        =
 const unsigned int flags);
 
 /**
@@ -347,7 +341,7 @@
  * @param mpp_flags=
    - Fast I/O optimization flags=2E
  * @param sock         - Socket where=
 the packet was received=2E
  */
-bool multi_process_incoming_link(struct m=
ulti_context *m, struct multi_instance *instance,
+void multi_process_incom=
ing_link(struct multi_context *m, struct multi_instance *instance,
        =
                          const unsigned int mpp_flags, struct link_socket =
*sock);
 
 
@@ -366,7 +360,7 @@
  * @param m            - The single \c mul=
ti_context structure=2E
  * @param mpp_flags    - Fast I/O optimization fla=
gs=2E
  */
-bool multi_process_incoming_tun(struct multi_context *m, const =
unsigned int mpp_flags);
+void multi_process_incoming_tun(struct multi_cont=
ext *m, const unsigned int mpp_flags);
 
 
 struct multi_instance *multi_ge=
t_queue(struct mbuf_set *ms);
diff --git a/src/openvpn/multi_io=2Ec b/src/o=
penvpn/multi_io=2Ec
index 2a88356d=2E=2E30676ce 100644
--- a/src/openvpn/mu=
lti_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -253,26 +253,18 @@
  * @param =
m            - The single \c multi_context structure=2E
  * @param mi      =
     - The \c multi_instance with the packet to send=2E
  * @param mpp_flag=
s    - Fast I/O optimization flags=2E
- *
- * @return
- *  - True, if the \=
c multi_instance associated with the packet sent was
- *    not closed due =
to a signal during processing=2E
- *  - Falls, if the \c multi_instance was=
 closed=2E
  */
-static bool
+static void
 multi_io_write_tun(struct multi_=
context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-  =
  bool ret =3D true;
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TU=
N len=3D%d\n", id(mi), mi->context=2Ec2=2Eto_tun=2Elen);
 #endif
     set_p=
refix(mi);
     vlan_process_outgoing_tun(m, mi);
     process_outgoing_tun=
(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_proc=
ess_post(m, mi, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
    =
 clear_prefix();
-    return ret;
 }
 
 /*
@@ -292,23 +284,20 @@
     clear=
_prefix();
 }
 
-static bool
+static void
 multi_io_send_link(struct multi_=
context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-  =
  bool ret =3D true;
     set_prefix(mi);
     process_outgoing_link(&mi->c=
ontext, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_process_pos=
t(m, mi, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
     clear_=
prefix();
-    return ret;
 }
 
-static bool
+static void
 multi_io_write_l=
ink_deferred(struct multi_context *m, struct multi_instance *mi,
          =
                    const unsigned int mpp_flags)
 {
     struct mbuf_item =
item;
-    bool ret =3D true;
     ASSERT(mi);
 
     /* extract from queue=
 */
@@ -318,18 +307,15 @@
 
         ASSERT(mi =3D=3D item=2Einstance);
   =
      mi->context=2Ec2=2Eto_link =3D item=2Ebuffer->buf;
-        ret =3D m=
ulti_io_send_link(m, mi, mpp_flags);
+        multi_io_send_link(m, mi, mpp=
_flags);
         mbuf_free_buf(item=2Ebuffer);
     }
-    return ret;
 }
=
 
-static bool
+static void
 multi_io_write_link(struct multi_context *m, s=
truct multi_instance *mi, bool defer,
                     const unsigned i=
nt mpp_flags)
 {
-    bool ret =3D true;
-
     if (mi && LINK_OUT(&mi->con=
text))
     {
         if ((defer && !proto_is_dgram(mi->context=2Ec2=2Elin=
k_sockets[0]->info=2Eproto))
@@ -349,16 +335,15 @@
                 mbuf_ad=
d_item(mi->tcp_link_out_deferred, &item);
                 mbuf_free_buf(mb=
);
                 buf_reset(buf);
-                ret =3D multi_process_=
post(m, mi, mpp_flags);
+                multi_process_post(m, mi, mpp_flag=
s);
                 clear_prefix();
             }
         }
         els=
e
         {
-            ret =3D multi_io_send_link(m, mi, mpp_flags);
+  =
          multi_io_send_link(m, mi, mpp_flags);
         }
     }
-    retu=
rn ret;
 }
 
 static struct multi_instance *

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
Ge=
rrit-Change-Number: 2051
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Greg=
ori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--XK1Des4MgMg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">multi: drop MPP_CLOSE_ON_SIGNAL<br><br>The UDP path, the last use=
r of MPP_CLOSE_ON_SIGNAL, now goes through<br>multi_io_action(), which clos=
es the signalled instance itself=2E Without<br>the flag multi_process_post(=
) always returns true, and the functions<br>that only passed its result alo=
ng return a value nobody reads=2E<br><br>Drop the flag and make multi_proce=
ss_post(), the incoming and timeout<br>processing functions and the static =
write functions of multi_io=2Ec<br>return void=2E The check of the multi_pr=
ocess_post() result in<br>multi_create_instance() could never fail and goes=
 away as well=2E<br><br>Change-Id: Ie755169bb32da856e941a214f43fbb243b768d7=
5<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<=
br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openv=
pn/multi_io=2Ec<br>3 files changed, 26 insertions(+), 74 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/51/2051/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/open=
vpn/multi=2Ec</span><br><span>index 2a4f78b=2E=2E05bdf91 100644</span><br><=
span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2E=
c</span><br><span>@@ -778,11 +778,7 @@</span><br><span>     mi-&gt;inotify_=
watch =3D -1;</span><br><span> #endif</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!multi_process_post(m, mi, MPP_PR=
E_SELECT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS,=
 &quot;MULTI: signal occurred during client instance initialization&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto err;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    multi_process_post(m, mi, MPP_PRE_S=
ELECT);</span><br><span> </span><br><span>     mi-&gt;ev_arg=2Etype =3D EVE=
NT_ARG_MULTI_INSTANCE;</span><br><span>     mi-&gt;ev_arg=2Eu=2Emi =3D mi;<=
/span><br><span>@@ -3033,14 +3029,10 @@</span><br><span>  * Figure instance=
-specific timers, convert</span><br><span>  * earliest to absolute time in =
mi-&gt;wakeup,</span><br><span>  * call scheduler with our future wakeup ti=
me=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Also close context on signal=2E<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span> multi_process_post(struct multi_context *m, struct multi_instance *mi=
, const unsigned int flags)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     if (!IS_SIG(&amp;mi-&gt;con=
text)</span><br><span>         &amp;&amp; ((flags &amp; MPP_PRE_SELECT)))</=
span><br><span>     {</span><br><span>@@ -3098,16 +3090,8 @@</span><br><spa=
n>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(&amp;mi-&gt;context))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; MPP_CLOSE_ON_SIGNAL=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            multi_close_instance=
_on_signal(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ret =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!IS_SIG(&amp;mi-&gt;context))</span><br><span>     {</spa=
n><br><span>         printf(&quot;POST %s[%d] to=3D%d lo=3D%d/%d w=3D%&quot=
; PRIi64 &quot;/%ld\n&quot;, id(mi), (int)ANY_OUT(&amp;mi-&gt;context),</sp=
an><br><span>                mi-&gt;context=2Ec2=2Eto_tun=2Elen, mi-&gt;con=
text=2Ec2=2Eto_link=2Elen,</span><br><span>@@ -3120,8 +3104,6 @@</span><br>=
<span>     {</span><br><span>         *m-&gt;mpp_touched =3D mi;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><spa=
n> }</span><br><span> </span><br><span> /**</span><br><span>@@ -3554,13 +35=
36,12 @@</span><br><span>  * Process packets in the TCP/UDP socket -&gt; TU=
N/TAP interface direction,</span><br><span>  * i=2Ee=2E client -&gt; server=
 direction=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span> multi_process_incoming_link(struct multi_context *m, st=
ruct multi_instance *instance,</span><br><span>                            =
 const unsigned int mpp_flags, struct link_socket *sock)</span><br><span> {=
</span><br><span>     struct multi_instance *mi =3D instance;</span><br><sp=
an>     struct context *c;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool ret =3D true;</span><br><span>     bool floated =3D false;</s=
pan><br><span> </span><br><span>     if (!mi)</span><br><span>@@ -3573,7 +3=
554,7 @@</span><br><span> </span><br><span>     if (!mi)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span>     }</span><br><span>     set_prefix(mi);</span><br><span=
> </span><br><span>@@ -3598,22 +3579,18 @@</span><br><span>     }</span><br=
><span> </span><br><span>     /* postprocess and set wakeup */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_process_post(m, =
mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_process_post(m, mi, mpp_flags);</span><br><span> </span><br><span>   =
  clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br=
><span> }</span><br><span> </span><br><span> /*</span><br><span>  * Process=
 packets in the TUN/TAP interface -&gt; TCP/UDP socket direction,</span><br=
><span>  * i=2Ee=2E server -&gt; client direction=2E</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> multi_process_in=
coming_tun(struct multi_context *m, const unsigned int mpp_flags)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret=
 =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     if (BLEN(&amp;m-&gt;top=2Ec2=2Ebuf) &gt; 0)</span><br><span>    =
 {</span><br><span>         unsigned int mroute_flags;</span><br><span>@@ -=
3630,7 +3607,7 @@</span><br><span>             vid =3D vlan_decapsulate(&am=
p;m-&gt;top, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>             if (v=
id &lt; 0)</span><br><span>             {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                return;</span><br><span>     =
        }</span><br><span>         }</span><br><span> </span><br><span>@@ -=
3681,14 +3658,13 @@</span><br><span>                     process_incoming_t=
un(c, c-&gt;c2=2Elink_sockets[0]);</span><br><span> </span><br><span>      =
               /* postprocess and set wakeup */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    ret =3D multi_process_post(m,=
 mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 multi_process_post(m, mi, mpp_flags);</span><br><span> </s=
pan><br><span>                     clear_prefix();</span><br><span>        =
         }</span><br><span>             }</span><br><span>         }</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn ret;</span><br><span> }</span><br><span> </span><br><span> /*</span><=
br><span>@@ -3731,11 +3707,9 @@</span><br><span>  * Called when an I/O wait=
 times out=2E  Usually means that a particular</span><br><span>  * client i=
nstance object needs timer-based service=2E</span><br><span>  */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span> multi_process_timeout(str=
uct multi_context *m, const unsigned int mpp_flags)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef =
MULTI_DEBUG_EVENT_LOOP</span><br><span>     printf(&quot;%s -&gt; TIMEOUT\n=
&quot;, id(m-&gt;earliest_wakeup));</span><br><span> #endif</span><br><span=
>@@ -3752,12 +3726,11 @@</span><br><span>         else</span><br><span>    =
     {</span><br><span>             set_prefix(m-&gt;earliest_wakeup);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D multi_=
process_post(m, m-&gt;earliest_wakeup, mpp_flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            multi_process_post(m, m-&gt;earl=
iest_wakeup, mpp_flags);</span><br><span>             clear_prefix();</span=
><br><span>         }</span><br><span>         m-&gt;earliest_wakeup =3D NU=
LL;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return ret;</span><br><span> }</span><br><span> </span><br><span> =
/*</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 305208a=2E=2E9d0fa85 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -284,11 +284,10 @@</span><br><span> </span><br><span> void mult=
i_close_instance(struct multi_context *m, struct multi_instance *mi, bool s=
hutdown);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-bool multi_process_timeout(struct multi_context *m, const unsigned in=
t mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void m=
ulti_process_timeout(struct multi_context *m, const unsigned int mpp_flags)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine MPP_PRE_SELECT      (1 &lt;&lt; 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define MPP_CLOSE_ON_SIGNAL (1 &lt;&lt; 1)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define MPP_RECORD_TOUCH    (1 &lt;=
&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MPP_=
PRE_SELECT   (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define MPP_RECORD_TOUCH (1 &lt;&lt; 2)</span><br><span> </span><br=
><span> </span><br><span> /************************************************=
**************************/</span><br><span>@@ -307,13 +306,8 @@</span><br>=
<span>  * @param mi           - The \c multi_instance of the VPN tunnel to =
be</span><br><span>  *                       postprocessed=2E</span><br><sp=
an>  * @param flags        - Fast I/O optimization flags=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @return</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  - True, if the VPN tunnel instance \a mi was not closed due to =
a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    signal during =
processing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - Fa=
lse, if the VPN tunnel instance \a mi was closed=2E</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_process_post(=
struct multi_context *m, struct multi_instance *mi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void multi_process_post(struct multi_cont=
ext *m, struct multi_instance *mi,</span><br><span>                        =
 const unsigned int flags);</span><br><span> </span><br><span> /**</span><b=
r><span>@@ -347,7 +341,7 @@</span><br><span>  * @param mpp_flags    - Fast =
I/O optimization flags=2E</span><br><span>  * @param sock         - Socket =
where the packet was received=2E</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool multi_process_incoming_link(struct mul=
ti_context *m, struct multi_instance *instance,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void multi_process_incoming_link(struct multi_c=
ontext *m, struct multi_instance *instance,</span><br><span>               =
                   const unsigned int mpp_flags, struct link_socket *sock);=
</span><br><span> </span><br><span> </span><br><span>@@ -366,7 +360,7 @@</s=
pan><br><span>  * @param m            - The single \c multi_context structu=
re=2E</span><br><span>  * @param mpp_flags    - Fast I/O optimization flags=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool multi_process_incoming_tun(struct multi_context *m, const unsigned =
int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp=
_flags);</span><br><span> </span><br><span> </span><br><span> struct multi_=
instance *multi_get_queue(struct mbuf_set *ms);</span><br><span>diff --git =
a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index=
 2a88356d=2E=2E30676ce 100644</span><br><span>--- a/src/openvpn/multi_io=2E=
c</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -253,26=
 +253,18 @@</span><br><span>  * @param m            - The single \c multi_c=
ontext structure=2E</span><br><span>  * @param mi           - The \c multi_=
instance with the packet to send=2E</span><br><span>  * @param mpp_flags   =
 - Fast I/O optimization flags=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ret=
urn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - True, if the=
 \c multi_instance associated with the packet sent was</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *    not closed due to a signal during pr=
ocessing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - Fall=
s, if the \c multi_instance was closed=2E</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> multi_io_wri=
te_tun(struct multi_context *m, struct multi_instance *mi, const unsigned i=
nt mpp_flags)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span=
>     printf(&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;context=2E=
c2=2Eto_tun=2Elen);</span><br><span> #endif</span><br><span>     set_prefix=
(mi);</span><br><span>     vlan_process_outgoing_tun(m, mi);</span><br><spa=
n>     process_outgoing_tun(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink=
_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =
=3D multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    multi_process_post(m, mi, mpp_flags);</span><br><=
span>     clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return ret;</span><br><span> }</span><br><span> </span><br><span> /=
*</span><br><span>@@ -292,23 +284,20 @@</span><br><span>     clear_prefix()=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span> multi_io_send_link(struct multi_conte=
xt *m, struct multi_instance *mi, const unsigned int mpp_flags)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =
=3D true;</span><br><span>     set_prefix(mi);</span><br><span>     process=
_outgoing_link(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_pro=
cess_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    multi_process_post(m, mi, mpp_flags);</span><br><span>     cle=
ar_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span> multi_io_write_link_deferred(str=
uct multi_context *m, struct multi_instance *mi,</span><br><span>          =
                    const unsigned int mpp_flags)</span><br><span> {</span>=
<br><span>     struct mbuf_item item;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    bool ret =3D true;</span><br><span>     ASSERT(mi);</sp=
an><br><span> </span><br><span>     /* extract from queue */</span><br><spa=
n>@@ -318,18 +307,15 @@</span><br><span> </span><br><span>         ASSERT(m=
i =3D=3D item=2Einstance);</span><br><span>         mi-&gt;context=2Ec2=2Et=
o_link =3D item=2Ebuffer-&gt;buf;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        ret =3D multi_io_send_link(m, mi, mpp_flags);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        multi_io_send_link(m,=
 mi, mpp_flags);</span><br><span>         mbuf_free_buf(item=2Ebuffer);</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return ret;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span> multi_io_write_link(struc=
t multi_context *m, struct multi_instance *mi, bool defer,</span><br><span>=
                     const unsigned int mpp_flags)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (=
mi &amp;&amp; LINK_OUT(&amp;mi-&gt;context))</span><br><span>     {</span><=
br><span>         if ((defer &amp;&amp; !proto_is_dgram(mi-&gt;context=2Ec2=
=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span>@@ -349,16 +335,15 @@=
</span><br><span>                 mbuf_add_item(mi-&gt;tcp_link_out_deferre=
d, &amp;item);</span><br><span>                 mbuf_free_buf(mb);</span><b=
r><span>                 buf_reset(buf);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                ret =3D multi_process_post(m, mi, mpp_fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  multi_process_post(m, mi, mpp_flags);</span><br><span>                 cl=
ear_prefix();</span><br><span>             }</span><br><span>         }</sp=
an><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ret =3D multi_io_send_link(m, m=
i, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       multi_io_send_link(m, mi, mpp_flags);</span><br><span>         }</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return ret;</span><br><span> }</span><br><span> </span><br><span> static =
struct multi_instance *</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail">change 2051</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2051?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:n=
one"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Br=
anch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie755169=
bb32da856e941a214f43fbb243b768d75 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 2051 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &l=
t;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--XK1Des4MgMg=--


--===============8693943880916216300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8693943880916216300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8693943880916216300==--


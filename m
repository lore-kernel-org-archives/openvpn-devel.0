Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B2606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=csjld3mH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AuTBm3xW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Nw9+t9QU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B9Cd7epi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LWUK5yTTzAHLEf2uVjUKBSKihmQQd3IxlgmNUZQFp/Q=; b=csjld3mHQFgpnqZs1RC9NmKYgi
	WMMQXpCcxETVnaTfApmNjjjMDxpW45YNaLon8s5RmcSWwNDdTTnsEk34wge3NCLe9ymNJXIbIuiZf
	CYgBjl0/kxCEQkQJoN0D2JnYdKUtbiqVQ/FoshwMfv/JN03w+bV/JaOynMcXV+zwSf0Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrEx-000000008BA-0EUH;
	Fri, 30 Oct 2026 18:22:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrEu-000000008B1-2ISb
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:22:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GNDHzfMR6cxf/MuOVnZRKLbflgmFKr+BOXzANr0uIQU=; b=AuTBm3xWDQ54jYCoqA2cej7t4d
 K07Fnb/p5rzD1p8Dqxe5GX9dSZz1H2lvxiFpMYySOZG5UcEf1zCYGJpAZYAIc7UwdfCPQ27R08ikl
 mnshx7b8pC/PWNv/rS+4ouBLydLLxLrYpU74NB0evThh3lTprA7LiK4Vh/daEGEJY/dk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GNDHzfMR6cxf/MuOVnZRKLbflgmFKr+BOXzANr0uIQU=; b=Nw9+t9QUdp4hsjUIyPEbwKAz96
 V7K/zPOrDTrkBjBfx+rLLhYaiM3b/tvTlJqtE/52W8snIs+C9LCxCnz3hsuSIwH0VErv2KVRKt5KI
 wZNHClgvnnpRp93VYGBSqFoYzRXFLCp1XtGdD+V7Z0GEJrkf0Q+JlZpBvIiXnf+WSVq8=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrEs-000000005Pm-3Lw2 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:22:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so637382f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793384520; x=1793989320; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GNDHzfMR6cxf/MuOVnZRKLbflgmFKr+BOXzANr0uIQU=;
 b=B9Cd7epiVBlu2mYTpozfyvMZgeGNEa0PglwleE+Ot37zPswhuy1I9nIm5TF1Qy1ef8
 QVf/HPqT2eKxlhQ9MBikmOwO45ek/V2Mz5fHfQ0EMGtcmzaXBsNpdaLAlWHDCF/2AVUC
 Haum/OPJ/7koegTdNmEP0lV2BrRdfBLdCiInBSuDXZrVROE5xtjHxH54FoNUSpvs4dZ6
 jS42uJZptzTDf8p7lzIG9tdj/hVYnehLjXw7BurM7TNjDTRhiB2uTrNUDQ23+SE13X10
 WEOWgmf64QwjEah4gkg5XWQtAs5AWdkbJPNPAlhH0wM3leopR2A+SpJMUsVyBKKNN2oh
 52/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384520; x=1793989320;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GNDHzfMR6cxf/MuOVnZRKLbflgmFKr+BOXzANr0uIQU=;
 b=HLcAMmltv89wmHK5QixIsCIboJJY4IaAUuhvW92pN8VRYk7sf/9ryduwIQ+MGZGTN2
 n5QHjwlRbKTJB+7XNzFX2LGoWVpfM5QE7TXy+kv9UoGeLFI/XTsiYQTeJ6zBubGlLBye
 Vaj6K0d3vuusV+lg+jJhARUcWQcKLS7U7utG39BbHUkIEy9BBK0ydKLKfjy5CwC3cqBv
 C79bj2kz/cfPpNcHrDhxqqcuRuLc0Y/e4q4A1OZyFaOwJMdxkTThLWoMYGPRh5JyvabU
 74KijfsZ7aSG0sbReZIaKO436PivsQ6hdXDJciHmW4n6ChfDPQqucpUoi/D7y3lOzm3X
 8b9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByZsgv44BGeKafIr5VVcNzQqU4npJIU8xE1FwjSUANdA7uJtvwN0eUAHVcWET5Gf6xSCaYmrta8fdPuJluC@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL/TUktgnAVsGymGjx3meCD4zGVYjnbtx7vnBqvh6LH1K1T24Lr
 NAKRrGgxdfYCSDxiYySrdw5gAMto/yksh/RORZXW0nfr4eMSbJ8ecO1YwyN26pqYSckUvzapQmL
 6A5ne7l27k3h+hZfrlforYVW7IPudFwbK3yMISSc50M0W0t7IY+PmjUYaqYWWNOrLeaB4
X-Gm-Gg: AYBFou268GssIlNV9a99tbbff5XZeO5L0CFhjfseanLoV8hUg/xAOyEMSGNIIQvR9yO
 13LdchTNwr8v6cq1LSBQiziy4yu1bTjD9wAFIH9vb3JBsepGG8tcWV0bq6pMg7QXczr0AB4MRyx
 Xaz9g925AUqg/VWDXXNFWn2i+O38Cn0DebKcFsBlQ3tThtGit+C2izRLGKmVJMAIQrB5VgIZAMu
 RGxUhdVRuGCM1QOjQ3SH1pRigQr9Vigwb8ZYBdrzouJ4rwTyAVzBlK0yYSyC08IS5Xsnv9TiEiI
 RKfZZ8ScfysL2IIB93n8MBWqBF32BQVDMQL/aT/PgrYAQGC1uA4QvfN17eSrl2s5X5aHE3tXC5q
 NLzT2sNwF/F+ghAmFsiSV3x89TY4nv1581+dSAg7U+nUHTTkIMzFPFHf3vWH1bSvUXHgLngQa2g
 d/7J09HbdGHfTEChliT3m1Rcx0MWG4pSm+PjqW/+18Ke2+0NRwG6Jlb+kqCMiSpCqKDd/63sUYO
 3mb1W77bSGpmJvWWilVNTDW9Ywg92G7qx52kJg3h/llsIAs80o8svfO0aSP0mDGF6JqV1XJg1MV
 MiIUhfWhWA+CylPhUzlyuD7MX7ixrVHT7ZgqVPP0kISWuQr2HERkhdEhI+QVBhmkBil4jcLfT7r
 lVx3yKNTuKyWLN6/Cj1iVjgtAzErGS/Yv3OIh8QRyr5GEgXQUm7V36aJeLtP22HV49g8pc2npGL
 cZgnzE8t8AHAw19js=
X-Received: by 2002:a05:6000:40db:b0:48e:5d06:8b66 with SMTP id
 ffacd0b85a97d-48e6e2dbbc5mr7914784f8f.19.1793384520093; 
 Fri, 30 Oct 2026 11:22:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e77409821sm218801f8f.0.2026.10.30.11.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:21:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:21:59 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
X-Gerrit-Change-Number: 2042
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2042?usp=email>
X-Gerrit-Commit: c18ebde866d2985885a0c0d338c7c5d5d7754dae
In-Reply-To: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
References: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk4OTMwMzk3NWRkNTU5ZDdjYzA2NDg0YTk5ZjE1YzcwNjJkM2EzNDM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18460dec27d12bfc8c0db1a04e5cc70e0659a4fc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrEs-000000005Pm-3Lw2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: move the
 tun write functions to multi_io.c
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1311120410625820403=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1311120410625820403==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MgKCn0uu0ms="; charset=UTF-8

--MgKCn0uu0ms=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2042?usp=3Demail )

Change subject: multi_io: move the tun writ=
e functions to multi_io=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

multi_io: move the tun write functions to multi_io=2Ec

mu=
lti_process_outgoing_tun() lived as a static inline in multi=2Eh and
multi_=
process_drop_outgoing_tun() in multi=2Ec, while their only caller
is multi_=
io_dispatch()=2E Move both next to it, as static functions named
multi_io_w=
rite_tun() and multi_io_drop_tun(), so that writing to the
tun device is fo=
und where the state machine decides to do it=2E

No functional change=2E

C=
hange-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
Signed-off-by: Gianmarc=
o De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042=

Message-Id: <20261027102325=2E19448-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40183=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
3 files c=
hanged, 59 insertions(+), 61 deletions(-)




diff --git a/src/openvpn/mult=
i=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2E2e804ff 100644
--- a/src/o=
penvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3766,27 +3766,6 @@
 }
 
 /=
*
- * Drop a TUN/TAP outgoing packet=2E=2E
- */
-void
-multi_process_drop_o=
utgoing_tun(struct multi_context *m, const unsigned int mpp_flags)
-{
-    =
struct multi_instance *mi =3D m->pending;
-
-    ASSERT(mi);
-
-    set_pre=
fix(mi);
-
-    msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, droppe=
d packet len=3D%d",
-        mi->context=2Ec2=2Eto_tun=2Elen);
-
-    buf_r=
eset(&mi->context=2Ec2=2Eto_tun);
-
-    multi_process_post(m, mi, mpp_flag=
s);
-    clear_prefix();
-}
-
-/*
  * Per-client route quota management
  *=
/
 
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5db714=
7=2E=2E2d4983c 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=
=2Eh
@@ -295,7 +295,7 @@
  * function controls the necessary postprocessing=
=2E  It is called by many
  * other functions that handle VPN tunnel relate=
d activity, such as \c
  * multi_process_incoming_link(), \c multi_process_=
outgoing_link(), \c
- * multi_process_incoming_tun(), \c multi_process_outg=
oing_tun(), and \c
+ * multi_process_incoming_tun(), \c multi_io_write_tun(=
), and \c
  * multi_process_timeout(), among others=2E
  *
  * @param m    =
        - The single \c multi_context structure=2E
@@ -364,8 +364,6 @@
 boo=
l multi_process_incoming_tun(struct multi_context *m, const unsigned int mp=
p_flags);
 
 
-void multi_process_drop_outgoing_tun(struct multi_context *m=
, const unsigned int mpp_flags);
-
 struct multi_instance *multi_get_queue(=
struct mbuf_set *ms);
 
 void multi_ifconfig_pool_persist(struct multi_cont=
ext *m, bool force);
@@ -627,41 +625,6 @@
 }
 
 
-/**
- * Send a packet ove=
r the virtual tun/tap network interface to its locally
- * reachable destin=
ation=2E
- * @ingroup internal_multiplexer
- *
- * This function calls \c p=
rocess_outgoing_tun() to perform the actual
- * sending of the packet=2E  A=
fterwards, it calls \c multi_process_post() to
- * perform server-mode post=
processing=2E
- *
- * @param m            - The single \c multi_context str=
ucture=2E
- * @param mpp_flags    - Fast I/O optimization flags=2E
- *
- * =
@return
- *  - True, if the \c multi_instance associated with the packet se=
nt was
- *    not closed due to a signal during processing=2E
- *  - Falls,=
 if the \c multi_instance was closed=2E
- */
-static inline bool
-multi_pro=
cess_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags)
-{=

-    struct multi_instance *mi =3D m->pending;
-    bool ret =3D true;
-
-=
    ASSERT(mi);
-#ifdef MULTI_DEBUG_EVENT_LOOP
-    printf("%s -> TUN len=
=3D%d\n", id(mi), mi->context=2Ec2=2Eto_tun=2Elen);
-#endif
-    set_prefix=
(mi);
-    vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi-=
>context, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_process_p=
ost(m, mi, mpp_flags);
-    clear_prefix();
-    return ret;
-}
-
 #define =
CLIENT_CONNECT_OPT_MASK                                                    =
        \
     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER |=
 OPT_P_CONFIG | OPT_P_ECHO \
      | OPT_P_COMP | OPT_P_SOCKFLAGS)
diff --g=
it a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index ebee86c=2E=
=2E164b214 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=
=2Ec
@@ -290,6 +290,62 @@
     }
 }
 
+/**
+ * Send a packet over the virtu=
al tun/tap network interface to its locally
+ * reachable destination=2E
+ =
* @ingroup internal_multiplexer
+ *
+ * This function calls \c process_outg=
oing_tun() to perform the actual
+ * sending of the packet=2E  Afterwards, =
it calls \c multi_process_post() to
+ * perform server-mode postprocessing=
=2E
+ *
+ * @param m            - The single \c multi_context structure=2E
=
+ * @param mpp_flags    - Fast I/O optimization flags=2E
+ *
+ * @return
+ =
*  - True, if the \c multi_instance associated with the packet sent was
+ *=
    not closed due to a signal during processing=2E
+ *  - Falls, if the \c=
 multi_instance was closed=2E
+ */
+static bool
+multi_io_write_tun(struct =
multi_context *m, const unsigned int mpp_flags)
+{
+    struct multi_instan=
ce *mi =3D m->pending;
+    bool ret =3D true;
+
+    ASSERT(mi);
+#ifdef M=
ULTI_DEBUG_EVENT_LOOP
+    printf("%s -> TUN len=3D%d\n", id(mi), mi->conte=
xt=2Ec2=2Eto_tun=2Elen);
+#endif
+    set_prefix(mi);
+    vlan_process_out=
going_tun(m, mi);
+    process_outgoing_tun(&mi->context, mi->context=2Ec2=
=2Elink_sockets[0]);
+    ret =3D multi_process_post(m, mi, mpp_flags);
+  =
  clear_prefix();
+    return ret;
+}
+
+/*
+ * Drop a TUN/TAP outgoing pac=
ket=2E=2E
+ */
+static void
+multi_io_drop_tun(struct multi_context *m, con=
st unsigned int mpp_flags)
+{
+    struct multi_instance *mi =3D m->pending=
;
+
+    ASSERT(mi);
+
+    set_prefix(mi);
+
+    msg(D_MULTI_ERRORS, "MUL=
TI: Outgoing TUN queue full, dropped packet len=3D%d",
+        mi->context=
=2Ec2=2Eto_tun=2Elen);
+
+    buf_reset(&mi->context=2Ec2=2Eto_tun);
+
+   =
 multi_process_post(m, mi, mpp_flags);
+    clear_prefix();
+}
+
 static st=
ruct multi_instance *
 multi_io_dispatch(struct multi_context *m, struct mu=
lti_instance *mi, const int action)
 {
@@ -334,11 +390,11 @@
             b=
reak;
 
         case TA_TUN_WRITE:
-            multi_process_outgoing_tun=
(m, mpp_flags);
+            multi_io_write_tun(m, mpp_flags);
            =
 break;
 
         case TA_TUN_WRITE_TIMEOUT:
-            multi_process_dr=
op_outgoing_tun(m, mpp_flags);
+            multi_io_drop_tun(m, mpp_flags)=
;
             break;
 
         case TA_SOCKET_WRITE_READY:

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062=
d3a3437
Gerrit-Change-Number: 2042
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmar=
co De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--MgKCn0uu0ms=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2042?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi_io: move the tun write funct=
ions to multi_io=2Ec<br><br>multi_process_outgoing_tun() lived as a static =
inline in multi=2Eh and<br>multi_process_drop_outgoing_tun() in multi=2Ec, =
while their only caller<br>is multi_io_dispatch()=2E Move both next to it, =
as static functions named<br>multi_io_write_tun() and multi_io_drop_tun(), =
so that writing to the<br>tun device is found where the state machine decid=
es to do it=2E<br><br>No functional change=2E<br><br>Change-Id: I89303975dd=
559d7cc06484a99f15c7062d3a3437<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042=
<br>Message-Id: &lt;20261027102325=2E19448-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40183=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M=
 src/openvpn/multi_io=2Ec<br>3 files changed, 59 insertions(+), 61 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mult=
i=2Ec</span><br><span>index e302a81=2E=2E2e804ff 100644</span><br><span>---=
 a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span>=
<br><span>@@ -3766,27 +3766,6 @@</span><br><span> }</span><br><span> </span=
><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Drop=
 a TUN/TAP outgoing packet=2E=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_drop_outgo=
ing_tun(struct multi_context *m, const unsigned int mpp_flags)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-&gt;pending;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_ERRORS,=
 &quot;MULTI: Outgoing TUN queue full, dropped packet len=3D%d&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=
=2Eto_tun=2Elen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_reset(&amp;mi-&gt=
;context=2Ec2=2Eto_tun);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_process_=
post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Per-client route q=
uota management</span><br><span>  */</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>inde=
x 5db7147=2E=2E2d4983c 100644</span><br><span>--- a/src/openvpn/multi=2Eh</=
span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -295,7 +295,7=
 @@</span><br><span>  * function controls the necessary postprocessing=2E  =
It is called by many</span><br><span>  * other functions that handle VPN tu=
nnel related activity, such as \c</span><br><span>  * multi_process_incomin=
g_link(), \c multi_process_outgoing_link(), \c</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * multi_process_incoming_tun(), \c multi_process_=
outgoing_tun(), and \c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * multi_process_incoming_tun(), \c multi_io_write_tun(), and \c</span><=
br><span>  * multi_process_timeout(), among others=2E</span><br><span>  *</=
span><br><span>  * @param m            - The single \c multi_context struct=
ure=2E</span><br><span>@@ -364,8 +364,6 @@</span><br><span> bool multi_proc=
ess_incoming_tun(struct multi_context *m, const unsigned int mpp_flags);</s=
pan><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void multi_process_drop_outgoing_tun(struct multi_context *m, c=
onst unsigned int mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> struct multi_instance *multi_get_queue(struct mbu=
f_set *ms);</span><br><span> </span><br><span> void multi_ifconfig_pool_per=
sist(struct multi_context *m, bool force);</span><br><span>@@ -627,41 +625,=
6 @@</span><br><span> }</span><br><span> </span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Send a packet over the virtual tun/tap network inter=
face to its locally</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 reachable destination=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @ingroup internal_multiplexer</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * T=
his function calls \c process_outgoing_tun() to perform the actual</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * sending of the packet=2E  A=
fterwards, it calls \c multi_process_post() to</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * perform server-mode postprocessing=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param m            - The single \c multi_conte=
xt structure=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram mpp_flags    - Fast I/O optimization flags=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @return</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  - True, if the \c multi_instance associated with the packet sent was</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *    not closed due to a =
signal during processing=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *  - Falls, if the \c multi_instance was closed=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_process_outgoing_tun(struct multi_context *m, const un=
signed int mpp_flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_ins=
tance *mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    bool ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MULTI_DEBUG_=
EVENT_LOOP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(=
&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;context=2Ec2=2Eto_tun=
=2Elen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    set_prefix(mi);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    vlan_process_outgoing_tun(=
m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_ou=
tgoing_tun(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_process=
_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define=
 CLIENT_CONNECT_OPT_MASK                                                   =
         \</span><br><span>     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUS=
H | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \</span><br><span>      | OPT_P=
_COMP | OPT_P_SOCKFLAGS)</span><br><span>diff --git a/src/openvpn/multi_io=
=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index ebee86c=2E=2E164b214 =
100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b=
/src/openvpn/multi_io=2Ec</span><br><span>@@ -290,6 +290,62 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Send a packet over the virtual tun/tap network interface to =
its locally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reach=
able destination=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @ingroup internal_multiplexer</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
his function calls \c process_outgoing_tun() to perform the actual</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * sending of the packet=2E =
 Afterwards, it calls \c multi_process_post() to</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * perform server-mode postprocessing=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param m            - The single \c mu=
lti_context structure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param mpp_flags    - Fast I/O optimization flags=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  - True, if the \c multi_instance associated with the pac=
ket sent was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    n=
ot closed due to a signal during processing=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  - Falls, if the \c multi_instance was closed=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+multi_io_write_tun(struct multi_context =
*m, const unsigned int mpp_flags)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct multi_instance *mi =3D m-&gt;pending;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    printf(&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&=
gt;context=2Ec2=2Eto_tun=2Elen);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    set_prefix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    vlan_process_outgoing_tun(m, mi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    process_outgoing_tun(&amp;mi-&gt;context, mi-&gt;cont=
ext=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    clear_prefix();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Drop a TUN/TAP o=
utgoing packet=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_drop_tun(struc=
t multi_context *m, const unsigned int mpp_flags)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct multi_instance *mi =3D m-&gt;pending;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(mi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   set_prefix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_ERRO=
RS, &quot;MULTI: Outgoing TUN queue full, dropped packet len=3D%d&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=
=2Ec2=2Eto_tun=2Elen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_reset(&a=
mp;mi-&gt;context=2Ec2=2Eto_tun);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
ulti_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    clear_prefix();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> static struct multi_instance *</span><br><span> multi_io_d=
ispatch(struct multi_context *m, struct multi_instance *mi, const int actio=
n)</span><br><span> {</span><br><span>@@ -334,11 +390,11 @@</span><br><span=
>             break;</span><br><span> </span><br><span>         case TA_TUN=
_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mu=
lti_process_outgoing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi_io_write_tun(m, mpp_flags);</span><br=
><span>             break;</span><br><span> </span><br><span>         case =
TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            multi_process_drop_outgoing_tun(m, mpp_flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi_io_drop_tun(m, mpp=
_flags);</span><br><span>             break;</span><br><span> </span><br><s=
pan>         case TA_SOCKET_WRITE_READY:</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail">cha=
nge 2042</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I89303975dd559d7cc06484a99f15c7062d3a3437 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2042 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco=
 De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--MgKCn0uu0ms=--


--===============1311120410625820403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1311120410625820403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1311120410625820403==--


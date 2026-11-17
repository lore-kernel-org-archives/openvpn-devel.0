Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0E606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L40P7NqQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ldCq4Bt1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dJSJHwkk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YwGu262U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JIwSafRlKbl9CMqJopxUVPd6umaSVVmwe3CLXaZ8L3U=; b=L40P7NqQhuthSqSquAi7nlc3KT
	2lW3GsJDpZI6VkDmOgg3nPgs5EkFBGsiTcM7sc7noV3DJpL+DUpJTUtQ3w1CUzDOtUUn4XGPjO51s
	060w+oueQsj+7wFu3Tg52sbtmQ6tlMB7WRbQ/TUboZY7Mjd8d+4c0QpJ4HdmdtJQtw3U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKdo-000000005aH-2qKL;
	Tue, 17 Nov 2026 14:58:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKdn-000000005a4-1aCC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zx5/vOtjmUJRa3Igl0vxevETe8V2ehEmznDpvPGO+rg=; b=ldCq4Bt14TS5+fvC5Z3zEG7hVc
 YBPgc3OYH7E06U52uIlcJGE0A4/hjHO3SNPGbj5MlEyKmdTTuON/uaZ8QfroN217AiVozqhQMZD5L
 6QuGXkli5l51lHSgI0Amd1Ft4nKUj2ZgCNJPEM1Dvw3xBVzLnCn3hTb9wx1NSHTZRAq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zx5/vOtjmUJRa3Igl0vxevETe8V2ehEmznDpvPGO+rg=; b=dJSJHwkkpJL/AxMeBD2fcGB2XP
 2K4ip6O/mE2JO0pVALyk95uoZysfV3WAXxrSuFtsRK3P3Ezt1brqPkuqhYXZy8bGiHoZrOgbGPls3
 ZplAotmrqJMgzgKPTmh2RFq4IXQksbGTUI7qcFgDvye1f2jZ5kOreT/XZ64IYGZrJY44=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKdl-000000004a4-2MAw for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:58:35 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so44771065e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794927507; x=1795532307; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zx5/vOtjmUJRa3Igl0vxevETe8V2ehEmznDpvPGO+rg=;
 b=YwGu262UF0TeMPHCkyewjsCEeMe4UuJTr945KKyp1f507Nh934WajqTMSir4w+92wJ
 R6PNn0Ua5Wqz7TBePQKT6tGGI0LpRWElYfn7rkBlZ76kusNCeVZS2YEacq9LnpciKEe8
 AHre3o9W4YLdcLq2cNXlMSvIgrvWxjZSYKydIYc7TA5QSc/xf5LaEcgiY6RJsbTcxOsI
 HEbOAoUdEvSyyyWw/RFLq97IRTZf5YcmuhZDsuXksNiaw+0nHz7cuiPYrq4AaDNYBVI9
 zJl5HAVVFp4XYItCvW0NXlOAY1dDBxXNERoRDgp9yZTo8cG4zXsLWpjDw0Fg5n6IRJag
 86Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927507; x=1795532307;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zx5/vOtjmUJRa3Igl0vxevETe8V2ehEmznDpvPGO+rg=;
 b=qY6RPvcnefb3/HNj84w1aL4lHFVLJS/m3f7+gvMZEPkhFPJhPwtUGeiZwLlgs3lWfN
 oe1lHGQfpAdLZdgLMqWPC7L0B5e+jx2SQGvxa+dxjpuQ1nq4hpygFNWdS4+nQvlaMB0+
 1FHN/y/xpBtsaJSECKrN5RLVRp3Cc1vsnFjQgvhIKHKcFLQBKLU3/mqTPypresRYFWd5
 605kRxOV1zW6H0IoH2xDsRuGoxzrAt9sAl8a8sQ0Ci1IIt/skELgUV/cLalOjlI4IOk2
 0zyp4LhdLanvmUB4ESz9AZ+CngvfW8Dv17f8clSvzdwynXmouYlqc0fEzpsPLn3KIZH/
 LJRw==
X-Gm-Message-State: APuU4Z+cX/ldWjUlJdGp/QdMRkLItK889E5peGXMV1e+1u6rx/8el10W
 rx206+PXB06i9ob2M74HGNCfS7LBVBrEldPYRGZx4zTQiI9oqbx5mn1CMBigSFlJRN5YB5P/AQ0
 dBf9VzIu2Ab6ZXpHPji35sJk4+cZwYSOwe25Udb8yQUXHKdFUXGNppZfrNIubFzI1vKft
X-Gm-Gg: AYBFou3519cy2/gtW8SQcR6GSL+ibZSBw9lSOC1qAr0xNl30kfZ15hXwXwo/qZ4EOWg
 PebwQq4mQZJtTj0V9db/q+rlox9Wi6sJGwcKMV7hbJmLZc0AcaLPBUTHDjxcW1ojoCiu8ZFmxuU
 qxMKK2rHZCCwqlmyN1MrYk5zRJmCRM0M+Zf8IO2EC/bfozmYzDLt5OTuINWpm0Y05EAzc/fF+HS
 lW/LYoKrsFGZx6+2Lllw+6+GnKMrZWl45C2XnRMDYfbNg8/XXTmOVtlV8Cl6UNoD7pplxMtxGhP
 zLWhX/qis77/9dXURExMZhSU0jTVMVyEfWj4F9zeiFQD9ZDMCMe2hr+FHN/0Ih4HQJnMJzViniO
 amjPWg/Op+bn9XaunWnz7Nk+a8sPKqJgk49VO2JmGjpreWc+24HQnxg6yFubh7ptZbuikZCJ94i
 Ep6AOKcP5tY6mmtC4nYQMLTdSuqVyidY4xZoBnbNLgNZyuCnN65h1Um27PqyBDPXzEohg21dTY0
 29X7nv3cokS/Nsg9czWFpIFz3cUmBL2Th2aV7qdmdSOnj8YBbk1tQcshGLAleNLhI9aPMouF1ts
 RWPZPsHUdjUTxttWy0G292mobmzfY0ELScSTfc+qpILeGof/y8x9UEN/MdKcqBdWZUkiEPpdlpD
 qZbixqdqZ9szYJULjDKb8lwhAxuD7mPEOIqrMzqizUkADO/b5nT3n1B2lwcVNZzwFP012pi2ScB
 KNEzbkgxTRhP67JlU=
X-Received: by 2002:a05:600d:12:b0:4bb:6d61:af7c with SMTP id
 5b1f17b1804b1-4bb6d61b56fmr154551405e9.35.1794927506721; 
 Tue, 17 Nov 2026 06:58:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7ad9426asm36210405e9.4.2026.11.17.06.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:58:26 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:58:24 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 6e544f6320d31ce0143df4a8253cb988a4e4c8b4
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <438e9af08df45078a56999a130f99c29a5c2d512-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKdl-000000004a4-2MAw
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2207794434626896328=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2207794434626896328==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ex3VYNmzQ5w="; charset=UTF-8

--ex3VYNmzQ5w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd lik=
e you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2210?usp=3Demail

to look at the new patch set (#2)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: socket: pause the listeners when acce=
pt() runs out of resources
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

socket: pause the listeners when accept() runs out of resourc=
es

When accept() fails with EMFILE, Linux and FreeBSD leave the pending
co=
nnection in the listen queue and the level-triggered listener is
reported a=
gain on every wait=2E The server keeps creating and destroying
an instance =
for it, never gets an empty event set, so the timers do not
run and hand-wi=
ndow never reaps the idle connections that hold the
descriptors: the server=
 stays at 100% CPU, writes the failure to the log
in a loop and stops servi=
ng new TCP and UDP clients until the peer
closes its connections=2E A manag=
ement client connecting while the
descriptors are exhausted causes the same=
 loop on the management
listener=2E

When accept() fails for lack of resour=
ces, stop polling the TCP
listeners and, in server mode, the management lis=
tener for up to a
second=2E

GitHub: OpenVPN/openvpn#1148
Change-Id: I97804=
1ea4e6323f5a92d8721809f0fa44b9c2e03
Signed-off-by: Gianmarco De Gregori <gi=
anmarco@mandelbit=2Ecom>
---
M src/openvpn/manage=2Ec
M src/openvpn/multi_i=
o=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
4 files changed, 70=
 insertions(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/10/2210/2

diff --git a/src/openvpn/manage=2Ec b/s=
rc/openvpn/manage=2Ec
index ae30930=2E=2Ee0a490e 100644
--- a/src/openvpn/m=
anage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3320,11 +3320,14 @@
         swi=
tch (man->connection=2Estate)
         {
             case MS_LISTEN:
-    =
            if (man_persist_state(persistent, 1))
+            {
+         =
       const bool paused =3D (man->settings=2Eflags & MF_SERVER) && socket_=
accept_paused();
+                if (man_persist_state(persistent, paused =
? 4 : 1))
                 {
-                    event_ctl(es, ev, EVENT_R=
EAD, arg);
+                    event_ctl(es, ev, paused ? 0 : EVENT_READ, =
arg);
                 }
                 break;
+            }
 
         =
    case MS_CC_WAIT_READ:
                 if (man_persist_state(persistent=
, 2))
@@ -3402,11 +3405,14 @@
     switch (man->connection=2Estate)
     {
=
         case MS_LISTEN:
-            if (man_persist_state(persistent, 1))=

+        {
+            const bool paused =3D (man->settings=2Eflags & MF_=
SERVER) && socket_accept_paused();
+            if (man_persist_state(persi=
stent, paused ? 4 : 1))
             {
-                event_ctl(es, man->=
connection=2Esd_top, EVENT_READ, arg);
+                event_ctl(es, man->=
connection=2Esd_top, paused ? 0 : EVENT_READ, arg);
             }
        =
     break;
+        }
 
         case MS_CC_WAIT_READ:
             if (ma=
n_persist_state(persistent, 2))
diff --git a/src/openvpn/multi_io=2Ec b/src=
/openvpn/multi_io=2Ec
index e07b691=2E=2Ec06fbda 100644
--- a/src/openvpn/m=
ulti_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -187,10 +187,25 @@
         }=

         else if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
         {
-  =
          socket_set_listen_persistent(sock, m->multi_io->es, &sock->ev_arg=
);
+            if (socket_accept_paused())
+            {
+               =
 socket_unset_listen_persistent(sock, m->multi_io->es);
+            }
+   =
         else
+            {
+                socket_set_listen_persistent(=
sock, m->multi_io->es, &sock->ev_arg);
+            }
         }
     }
 
+=
    const time_t delay =3D socket_accept_paused();
+    if (delay && m->top=
=2Ec2=2Etimeval=2Etv_sec >=3D delay)
+    {
+        m->top=2Ec2=2Etimeval=
=2Etv_sec =3D (tv_sec_t)delay;
+        m->top=2Ec2=2Etimeval=2Etv_usec =3D=
 0;
+        m->earliest_wakeup =3D NULL;
+    }
+
     tun_set(m->top=2Ec1=
=2Etuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
 #if def=
ined(ENABLE_DCO)
     dco_event_set(&m->top=2Ec1=2Etuntap->dco, m->multi_io=
->es, MULTI_IO_DCO);
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/sock=
et=2Ec
index c07ef60=2E=2E8a5225f 100644
--- a/src/openvpn/socket=2Ec
+++ b=
/src/openvpn/socket=2Ec
@@ -422,6 +422,29 @@
     gc_free(&gc);
 }
 
+/* ac=
cept() failed for lack of resources: no new accept() before this time */
+s=
tatic time_t accept_resume =3D 0; /* GLOBAL */
+
+static void
+accept_check=
_resources(const int err)
+{
+#ifdef _WIN32
+    const bool out_of_resource=
s =3D err =3D=3D WSAEMFILE || err =3D=3D WSAENOBUFS;
+#else
+    const bool=
 out_of_resources =3D err =3D=3D EMFILE || err =3D=3D ENFILE || err =3D=3D =
ENOBUFS || err =3D=3D ENOMEM;
+#endif
+    if (out_of_resources)
+    {
+  =
      accept_resume =3D now + 1;
+    }
+}
+
+time_t
+socket_accept_paused(=
void)
+{
+    return now < accept_resume ? accept_resume - now : 0;
+}
+
 #=
if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #p=
ragma GCC diagnostic ignored "-Wsign-conversion"
@@ -456,6 +479,10 @@
     =
else
     {
         new_sd =3D accept(sd, &act->dest=2Eaddr=2Esa, &remote_=
len);
+        if (!socket_defined(new_sd))
+        {
+            accept_=
check_resources(openvpn_errno());
+        }
     }
 
 #if 0 /* For debuggi=
ng only, test the effect of accept() failures */
@@ -2700,6 +2727,10 @@
   =
       * scripts don't have access to it */
         set_cloexec(ret);
    =
 }
+    else
+    {
+        accept_check_resources(openvpn_errno());
+    =
}
     return ret;
 }
 
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/s=
ocket=2Eh
index 2210bfe=2E=2E6324a17 100644
--- a/src/openvpn/socket=2Eh
++=
+ b/src/openvpn/socket=2Eh
@@ -410,6 +410,9 @@
                            =
                      const char *bind_dev, struct addrinfo *bind_addr,
   =
                                               bool bind_ipv6_only, bool op=
tional);
 
+/* Seconds left before accept() is retried after it failed for =
lack of resources */
+time_t socket_accept_paused(void);
+
 socket_descript=
or_t socket_do_accept(socket_descriptor_t sd, struct link_socket_actual *ac=
t,
                                      const bool nowait);
 
@@ -846,6 +8=
49,16 @@
 }
 
 static inline void
+socket_unset_listen_persistent(struct li=
nk_socket *sock, struct event_set *es)
+{
+    if (sock && sock->listen_per=
sistent_queued)
+    {
+        event_del(es, socket_listen_event_handle(so=
ck));
+        sock->listen_persistent_queued =3D false;
+    }
+}
+
+stati=
c inline void
 socket_reset_listen_persistent(struct link_socket *sock)
 {
=
 #ifdef _WIN32

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-Number: 2210
Gerrit=
-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>

--ex3VYNmzQ5w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, R=C4=83zvan Cojoc=
aru=2E </p>
<p>Gianmarco De Gregori <strong>uploaded patch set #2</strong> =
to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2210?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">socket: pause the listeners when accept() runs out of resources<br><br>=
When accept() fails with EMFILE, Linux and FreeBSD leave the pending<br>con=
nection in the listen queue and the level-triggered listener is<br>reported=
 again on every wait=2E The server keeps creating and destroying<br>an inst=
ance for it, never gets an empty event set, so the timers do not<br>run and=
 hand-window never reaps the idle connections that hold the<br>descriptors:=
 the server stays at 100% CPU, writes the failure to the log<br>in a loop a=
nd stops serving new TCP and UDP clients until the peer<br>closes its conne=
ctions=2E A management client connecting while the<br>descriptors are exhau=
sted causes the same loop on the management<br>listener=2E<br><br>When acce=
pt() fails for lack of resources, stop polling the TCP<br>listeners and, in=
 server mode, the management listener for up to a<br>second=2E<br><br>GitHu=
b: OpenVPN/openvpn#1148<br>Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c=
2e03<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&g=
t;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/multi_io=2Ec<br>M sr=
c/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>4 files changed, 70 ins=
ertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/2210/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ae309=
30=2E=2Ee0a490e 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><=
br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3320,11 +3320,14 =
@@</span><br><span>         switch (man-&gt;connection=2Estate)</span><br><=
span>         {</span><br><span>             case MS_LISTEN:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                if (man_persist_stat=
e(persistent, 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        const bool paused =3D (man-&gt;settings=2Eflags &amp; MF_SERVER) &a=
mp;&amp; socket_accept_paused();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if (man_persist_state(persistent, paused ? 4 :=
 1))</span><br><span>                 {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    event_ctl(es, ev, EVENT_READ, arg);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    e=
vent_ctl(es, ev, paused ? 0 : EVENT_READ, arg);</span><br><span>           =
      }</span><br><span>                 break;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span> </span><br><span=
>             case MS_CC_WAIT_READ:</span><br><span>                 if (ma=
n_persist_state(persistent, 2))</span><br><span>@@ -3402,11 +3405,14 @@</sp=
an><br><span>     switch (man-&gt;connection=2Estate)</span><br><span>     =
{</span><br><span>         case MS_LISTEN:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (man_persist_state(persistent, 1))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const bool paused =3D =
(man-&gt;settings=2Eflags &amp; MF_SERVER) &amp;&amp; socket_accept_paused(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (m=
an_persist_state(persistent, paused ? 4 : 1))</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                even=
t_ctl(es, man-&gt;connection=2Esd_top, EVENT_READ, arg);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                event_ctl(es, man-&gt;=
connection=2Esd_top, paused ? 0 : EVENT_READ, arg);</span><br><span>       =
      }</span><br><span>             break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span>       =
  case MS_CC_WAIT_READ:</span><br><span>             if (man_persist_state(=
persistent, 2))</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src=
/openvpn/multi_io=2Ec</span><br><span>index e07b691=2E=2Ec06fbda 100644</sp=
an><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openv=
pn/multi_io=2Ec</span><br><span>@@ -187,10 +187,25 @@</span><br><span>     =
    }</span><br><span>         else if (!tuntap_is_dco_win(m-&gt;top=2Ec1=
=2Etuntap))</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            socket_set_listen_persistent(sock, m-&gt;multi=
_io-&gt;es, &amp;sock-&gt;ev_arg);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (socket_accept_paused())</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                socket_unset_listen_persistent=
(sock, m-&gt;multi_io-&gt;es);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            socket_set_listen_persistent(sock, m-&gt;multi_io-&gt;es, &amp;=
sock-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span>         }</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const time_=
t delay =3D socket_accept_paused();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (delay &amp;&amp; m-&gt;top=2Ec2=2Etimeval=2Etv_sec =
&gt;=3D delay)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;top=
=2Ec2=2Etimeval=2Etv_sec =3D (tv_sec_t)delay;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        m-&gt;top=2Ec2=2Etimeval=2Etv_usec =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;earli=
est_wakeup =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_READ=
, MULTI_IO_TUN, persistent);</span><br><span> #if defined(ENABLE_DCO)</span=
><br><span>     dco_event_set(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, m-&gt;m=
ulti_io-&gt;es, MULTI_IO_DCO);</span><br><span>diff --git a/src/openvpn/soc=
ket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index c07ef60=2E=2E8a5225f=
 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/=
src/openvpn/socket=2Ec</span><br><span>@@ -422,6 +422,29 @@</span><br><span=
>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* accept() failed for lack of res=
ources: no new accept() before this time */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static time_t accept_resume =3D 0; /* GLOBAL */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+accept_check_resources(const int err)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const bool out_of_resources =3D err =3D=3D WSAEMFIL=
E || err =3D=3D WSAENOBUFS;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst bool out_of_resources =3D err =3D=3D EMFILE || err =3D=3D ENFILE || err=
 =3D=3D ENOBUFS || err =3D=3D ENOMEM;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (out_of_resources)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     accept_resume =3D now + 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+time_t</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+socket_accept_paused(void)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return now &lt; accept_resume ? accept_resume - now : 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(__GNUC__) =
|| defined(__clang__)</span><br><span> #pragma GCC diagnostic push</span><b=
r><span> #pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span=
><br><span>@@ -456,6 +479,10 @@</span><br><span>     else</span><br><span> =
    {</span><br><span>         new_sd =3D accept(sd, &amp;act-&gt;dest=2Ead=
dr=2Esa, &amp;remote_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!socket_defined(new_sd))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            accept_check_resources(openvpn_errno());</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
   }</span><br><span> </span><br><span> #if 0 /* For debugging only, test t=
he effect of accept() failures */</span><br><span>@@ -2700,6 +2727,10 @@</s=
pan><br><span>          * scripts don&#39;t have access to it */</span><br>=
<span>         set_cloexec(ret);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        accept_check_resources(openvpn_errno());</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     return r=
et;</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 2210bfe=2E=
=2E6324a17 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><s=
pan>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -410,6 +410,9 @@</span>=
<br><span>                                                  const char *bin=
d_dev, struct addrinfo *bind_addr,</span><br><span>                        =
                          bool bind_ipv6_only, bool optional);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Seconds lef=
t before accept() is retried after it failed for lack of resources */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+time_t socket_accept_paus=
ed(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct=
 link_socket_actual *act,</span><br><span>                                 =
     const bool nowait);</span><br><span> </span><br><span>@@ -846,6 +849,1=
6 @@</span><br><span> }</span><br><span> </span><br><span> static inline vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_unset_list=
en_persistent(struct link_socket *sock, struct event_set *es)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (sock &amp;&amp; sock-&gt;listen_persistent_=
queued)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        event_del(es, sock=
et_listen_event_handle(sock));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sock-&gt;listen_persistent_queued =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline void</span><br><span> socket_reset_listen_persistent(struct link_soc=
ket *sock)</span><br><span> {</span><br><span> #ifdef _WIN32</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
210?usp=3Demail">change 2210</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2210?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2210 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt; </div>

</body></html>
--ex3VYNmzQ5w=--


--===============2207794434626896328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2207794434626896328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2207794434626896328==--


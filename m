Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C670606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kbek/Iod;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ACwxa6a/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SLN3TnHW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bxc6oIeN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CVTuogxD5bC27vV/moay4xYmB2i9F5c0qSNTIgfkh4g=; b=Kbek/IodMn6UmUluMEKE6/zIT6
	F/I8ENPmLgT7eQ26ILenSnNuchjxIyQn744bgpLOrENCrvptk7h0nOuObVt+w1dfWcYrIvc1E/kf+
	nlo1I+dFwYMgVnSc4w3Z2JHr+0pjoKUuHuV1YNNQCrPM3BeBnxUFJ+0U1dal5TJ6pUdc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLSml-000000001p2-3puf;
	Mon, 26 Oct 2026 22:03:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLSmk-000000001ow-0yZB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 22:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VOO/Et5v3b2T3lody905Bs9VEKh3KdOb6ZdApVBwW8s=; b=ACwxa6a/UiMad+UUYB1v8BWOGM
 7htIGidiuhTFrpNBSwvtKH6HGxzXpR3Xv6sLQuDPHpY8ZK9J7211lPFQE+fnxlPh7fMf1IOMeNoaW
 9j25Bz7Ojlltl433kv07pjYKwTcLojSqKvHvdbhRHsdfRjA0AtRTSF+cIWPoolCNOsc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VOO/Et5v3b2T3lody905Bs9VEKh3KdOb6ZdApVBwW8s=; b=SLN3TnHW7IKeg6RZPXlwK5stsA
 zuEbnntFJFD1DfR7r0knKFVwG6bT1AMwaKuxGLu+xchUoggKEbVFlWME0+ClcIx+OBpofya5XSRd+
 nGkm0a5eg7I6GOUh++X4tLiKl0I4yPnC4dSir+aYP+UBBGWpSSzM9V6UzSZlKnycn290=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLSmi-000000005vi-0Ku7 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 22:03:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so16934645e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793052189; x=1793656989; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VOO/Et5v3b2T3lody905Bs9VEKh3KdOb6ZdApVBwW8s=;
 b=Bxc6oIeNHWedJPwAH5sTikJF5ox6B8yhP3NRfZbtbF7MPOVPq7zbgsjXlFpEMS+jYu
 5nURK7XDbNPW/mXsR1iHSiZbkVutXGQZgUloV0uzRBjGRrHALOii65ifr80br/dosrrs
 2vNMC76tJB9IqJglSYRcjqE1QP1FMUcJQKK8aiZg7/8AjTkg7H0Ll7SeAn4SdWOz/gIb
 2PGbEQYysv8ZDLqyka4MdnDctnR0XGKhcDHaH/Uzm+Y0TbI5SAW6b7OfPxjWCNJYoYWv
 RfdLNt40KVkdJxd6dTW69ia5HzcYyM8hBWrbHjQPU8AXgiGAMWh6s5QKOq16PpM/NpB3
 6Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793052189; x=1793656989;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VOO/Et5v3b2T3lody905Bs9VEKh3KdOb6ZdApVBwW8s=;
 b=getgq181UYioHeRH3CfidULG8pjPLuUTtj/dbcSjASmumxpesnGiIx3SvQUli5jDyW
 c4ARx7T0kh53p6excVrQJizpGZ4JXEWSDI982Yo2NmVMdebyyD8RRKaE8vdC8UibtPhr
 QoeyMjTY/CcdMWfDPXKRmzYOtPpktvvX4EXGgNhvB2vMfiNrbLmt4QESGs6NC2L3DFtZ
 O0s7aMeI30NnU9GTI2bSgd0f+/cVR/KyrbRHpi/RI3xNOiOGVnioqKckldHqJUoERNy5
 +nSb8Cx0vcevaUAv23S3i4ezwZtlL2J0fWQKqmTD0ab0KZp5ki7L4ZzWvglxX1cWiSzR
 TdAw==
X-Gm-Message-State: AFq9FYL2NuXCMAHU9KBTKyzZZYSiLiZaulneL1CDj3iakC6XkVyyvR7c
 Iwe/rmii/QZd1eOQ32PwOrdQeW1YnC19G0xGk67p/hrbsZCGI4Uic12vwY4Eeye9TbAL9WWwj4C
 9S30H2MgMXSIw1PBHGolN+3AfqDlZ+zrZONPiXJhsgF8PE9d5iV91tZQLDUIe4xhvPZ7A
X-Gm-Gg: AYBFou1hb8RhfLFPKibmiI2vJDH0x5soR8+hC3z7bb0i686WVm0NFmtsTELi7G4MrIf
 EOcMCyX0O+bsNiUK/71t0FiCl9ArdSL07rcQ1q64BvyIyZ/DbCPPQxKg89vWoYjBaSYxeK6HUBU
 eI+bP27cJXjuqBwjM3gj2JZiEXyqPdqbH/IVy7vFel84Ow0p7AhmqkzZubf71zpcSnacObVx1ym
 ozGD3iix8XGpLodRoaHRcrYrRgZXXtZjIRYK3i1oL2UTfEbNb7dvXqSWz6Zs0aKrvlM7oD4LDJY
 6RG6h3aoQcRNZYG5BU06qNdNdxqnGAGCWbZnkBb8WL7UK4+EgqeWZTAUqqcD6qKy5uXDqT8G6Hd
 oemSFCX27ziJnTyMPhOEkIeaohD7qgYdFw/OZs//35dZBKNJiVJAO8u9klR1mQJIhZ9ZCCCs7hL
 Mo3mlWTjdZygP2YKK20kYQPo7Hq2JZQND6+bAhnojS8xw0FT7e+eFAVRMt9mJQjer4Q4v9sfJA7
 5BDsDJAwld6WO7BiULJZBW7dhAquO3jo6UOfm2Kzmr7SbmbwbTNxPTaZ0DjSyuEL38MT0ouM4qu
 3kpuBVgKy5P6rWYkGnouf3CiEwpOuWQQKLpS0zKXTig2DijKwdU7Re96A4En4sFOssMBfuhw9Cm
 EWeSONyYf9bQri/9jNw0LtoL6S+VCyhgfftEsMHpevw==
X-Received: by 2002:a05:600c:4f0f:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a35ac803e2mr181446225e9.10.1793052189347; 
 Mon, 26 Oct 2026 15:03:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm18624930f8f.53.2026.10.26.15.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 15:03:09 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 22:03:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
X-Gerrit-Change-Number: 2040
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2040?usp=email>
X-Gerrit-Commit: c1a16cc7487324a97613d3be7f62d233999a1f9e
In-Reply-To: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
References: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDUxODI5MDAwLkllYTE1MTk4OGYyZmExMjBiMTI2MjA1MTU3MjYwNGUzZjQyZWY0YjFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b158cd98c313b815df0555c4f54bee996d4bb758-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLSmi-000000005vi-0Ku7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: p2p: don't report
 WAIT/AUTH for a new session while connected
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3530002719278430219=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3530002719278430219==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0ysvjbYtBtg="; charset=UTF-8

--0ysvjbYtBtg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2040?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: p2p: don't report WAIT/AUTH for a new session while=
 connected
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

p=
2p: don't report WAIT/AUTH for a new session while connected

In p2p mode, =
a hard reset that starts a new session moves the management
state to AUTH a=
nd WAIT even while the tunnel is up=2E If that session
never completes (e=
=2Eg=2E an unauthenticated probe without tls-auth/tls-crypt,
or a peer that=
 gives up), CONNECTED is never announced again and the
state stays WAIT alt=
hough the tunnel works fine=2E

Don't announce AUTH/WAIT when an establishe=
d session already exists=2E
A successful new session still re-announces CON=
NECTED via
CAS_RECONNECT_PENDING=2E

Also document that WAIT and AUTH are r=
eported in p2p mode too=2E

Change-Id: Iea151988f2fa120b1262051572604e3f42e=
f4b1c
Link: https://bugzilla=2Eipfire=2Eorg/show_bug=2Ecgi?id=3D13897
Repor=
ted-by: Neil Chittenden <neilchittenden@quintessa=2Eorg>
Signed-off-by: Ant=
onio Quartulli <antonio@mandelbit=2Ecom>
---
M doc/management-notes=2Etxt
M=
 src/openvpn/ssl=2Ec
2 files changed, 30 insertions(+), 10 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/2040/2=


diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
inde=
x a28a1a8=2E=2E5b32ba6 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/ma=
nagement-notes=2Etxt
@@ -427,9 +427,10 @@
 These are the OpenVPN states:
 
=
 CONNECTING    -- OpenVPN's initial state=2E
-WAIT          -- (Client only=
) Waiting for initial response
-                 from server=2E
-AUTH      =
    -- (Client only) Authenticating with server=2E
+WAIT          -- (Clien=
t and point-to-point only) Waiting for
+                 initial response f=
rom server or peer=2E
+AUTH          -- (Client and point-to-point only) Au=
thenticating
+                 with server or peer=2E
 GET_CONFIG    -- (Cl=
ient only) Downloading configuration options
                  from server=
=2E
 ASSIGN_IP     -- Assigning IP address to virtual network
diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=2E=2Ea0edf69 100644=

--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2517,6 +2517,18 @@=

 }
 
 /**
+ * Returns true if this multi context has an established sessio=
n, i=2Ee=2E the
+ * initial connection has completed and the tunnel is up=
=2E  A new session
+ * that is being negotiated in TM_INITIAL in this state=
 does not change the
+ * state of the tunnel until it is promoted to TM_ACT=
IVE=2E
+ */
+static bool
+tls_multi_established(const struct tls_multi *mul=
ti)
+{
+    return multi->multi_state >=3D CAS_CONNECT_DONE;
+}
+
+/**
  * =
Move the session from S_INITIAL to S_PRE_START=2E This will also generate
 =
 * the initial message based on ks->initial_opcode
  *
@@ -2554,12 +2566,6 =
@@
          session_id_print(&session->session_id, &gc));
     gc_free(&gc=
);
 
-#ifdef ENABLE_MANAGEMENT
-    if (management && ks->initial_opcode !=
=3D P_CONTROL_SOFT_RESET_V1)
-    {
-        management_set_state(managemen=
t, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);
-    }
-#endif
     r=
eturn true;
 }
 
@@ -2883,6 +2889,18 @@
     if (ks->state =3D=3D S_INITIAL=
)
     {
         continue_tls_process =3D session_move_pre_start(session, =
ks, false);
+#ifdef ENABLE_MANAGEMENT
+        /* Do not report a new sessi=
on attempt (e=2Eg=2E a peer restart in p2p
+         * mode or a stray hard=
 reset packet) as WAIT when we already have
+         * an established sess=
ion: the tunnel is still up and, unless the
+         * new session succeed=
s, nothing would ever report CONNECTED again */
+        if (continue_tls_p=
rocess && management
+            && ks->initial_opcode !=3D P_CONTROL_SOFT=
_RESET_V1
+            && !tls_multi_established(multi))
+        {
+      =
      management_set_state(management, OPENVPN_STATE_WAIT, NULL, NULL, NULL=
, NULL, NULL);
+        }
+#endif
     }
 
     /* Are we timed out on rece=
ive? */
@@ -3891,7 +3909,8 @@
         }
 
 #ifdef ENABLE_MANAGEMENT
-     =
   if (management)
+        /* see the WAIT state in tls_process_state() */=

+        if (management && !tls_multi_established(multi))
         {
     =
        management_set_state(management, OPENVPN_STATE_AUTH, NULL, NULL, NU=
LL, NULL, NULL);
         }

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2040?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
Gerrit-Change-Number=
: 2040
Gerrit-PatchSet: 2
Gerrit-Owner: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--0ysvjbYtBtg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">p2p: don&#39;t report WAIT/AUTH for a new session while connected<br=
><br>In p2p mode, a hard reset that starts a new session moves the manageme=
nt<br>state to AUTH and WAIT even while the tunnel is up=2E If that session=
<br>never completes (e=2Eg=2E an unauthenticated probe without tls-auth/tls=
-crypt,<br>or a peer that gives up), CONNECTED is never announced again and=
 the<br>state stays WAIT although the tunnel works fine=2E<br><br>Don&#39;t=
 announce AUTH/WAIT when an established session already exists=2E<br>A succ=
essful new session still re-announces CONNECTED via<br>CAS_RECONNECT_PENDIN=
G=2E<br><br>Also document that WAIT and AUTH are reported in p2p mode too=
=2E<br><br>Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c<br>Link: ht=
tps://bugzilla=2Eipfire=2Eorg/show_bug=2Ecgi?id=3D13897<br>Reported-by: Nei=
l Chittenden &lt;neilchittenden@quintessa=2Eorg&gt;<br>Signed-off-by: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/management-not=
es=2Etxt<br>M src/openvpn/ssl=2Ec<br>2 files changed, 30 insertions(+), 10 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/40/2040/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/management=
-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index a28a1a8=2E=
=2E5b32ba6 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><b=
r><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -427,9 +427,10 =
@@</span><br><span> These are the OpenVPN states:</span><br><span> </span><=
br><span> CONNECTING    -- OpenVPN&#39;s initial state=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-WAIT          -- (Client only) Waiting =
for initial response</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                from server=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-AUTH          -- (Client only) Authenticating with server=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+WAIT          -- (Client =
and point-to-point only) Waiting for</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 initial response from server or peer=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+AUTH          -- (Cli=
ent and point-to-point only) Authenticating</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 with server or peer=2E</span><br><=
span> GET_CONFIG    -- (Client only) Downloading configuration options</spa=
n><br><span>                  from server=2E</span><br><span> ASSIGN_IP    =
 -- Assigning IP address to virtual network</span><br><span>diff --git a/sr=
c/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2E=
a0edf69 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>++=
+ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2517,6 +2517,18 @@</span><br><s=
pan> }</span><br><span> </span><br><span> /**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Returns true if this multi context has an esta=
blished session, i=2Ee=2E the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * initial connection has completed and the tunnel is up=2E  A ne=
w session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that is=
 being negotiated in TM_INITIAL in this state does not change the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * state of the tunnel until =
it is promoted to TM_ACTIVE=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_multi_est=
ablished(const struct tls_multi *multi)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span>  * Move the session from S_INITIAL to S_PRE_START=
=2E This will also generate</span><br><span>  * the initial message based o=
n ks-&gt;initial_opcode</span><br><span>  *</span><br><span>@@ -2554,12 +25=
66,6 @@</span><br><span>          session_id_print(&amp;session-&gt;session=
_id, &amp;gc));</span><br><span>     gc_free(&amp;gc);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (management &a=
mp;&amp; ks-&gt;initial_opcode !=3D P_CONTROL_SOFT_RESET_V1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        management_set_state(management, OPENVPN_STA=
TE_WAIT, NULL, NULL, NULL, NULL, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span>     return true;</span><br><span> }</span><br><sp=
an> </span><br><span>@@ -2883,6 +2889,18 @@</span><br><span>     if (ks-&gt=
;state =3D=3D S_INITIAL)</span><br><span>     {</span><br><span>         co=
ntinue_tls_process =3D session_move_pre_start(session, ks, false);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Do not repor=
t a new session attempt (e=2Eg=2E a peer restart in p2p</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * mode or a stray hard reset p=
acket) as WAIT when we already have</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * an established session: the tunnel is still up a=
nd, unless the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * new session succeeds, nothing would ever report CONNECTED again */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (continue_t=
ls_process &amp;&amp; management</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &amp;&amp; ks-&gt;initial_opcode !=3D P_CONTROL_SO=
FT_RESET_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &amp;&amp; !tls_multi_established(multi))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            management_set_state(management, OPENVPN_STATE_=
WAIT, NULL, NULL, NULL, NULL, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span>     }</span><br><span> </span><br><span>    =
 /* Are we timed out on receive? */</span><br><span>@@ -3891,7 +3909,8 @@</=
span><br><span>         }</span><br><span> </span><br><span> #ifdef ENABLE_=
MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* see the WAIT state in tls_process_state() */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (management &amp;&amp; !tls_multi_e=
stablished(multi))</span><br><span>         {</span><br><span>             =
management_set_state(management, OPENVPN_STATE_AUTH, NULL, NULL, NULL, NULL=
, NULL);</span><br><span>         }</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">change 2=
040</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2040 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio =
Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html=
>
--0ysvjbYtBtg=--


--===============3530002719278430219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3530002719278430219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3530002719278430219==--


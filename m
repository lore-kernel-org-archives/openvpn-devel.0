Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22E606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JCk0osVX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CjaiI/rh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fGkRug4P;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OXHla8XS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Wr6pNQdeIkGXkaA5MQyIu6cIGz/Va1va02lH3Y3+Hc4=; b=JCk0osVX/vW/1k/CIUB88C4KUb
	6niIVE/Z/6SrSh3VbRCPM0MiEqnGYLfCrPtpgjFgjwovS9nk/09/M9HDYa1m0i5m6+EFWB3zT23bT
	T9m3dPmeLUZgvNCBx7Hw5xQ0fYs8TpAJOeRzMKGAOFE+B5FBUGO2NZu9E9Evt6irMGT0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdkr-000000001ci-3Qbq;
	Tue, 27 Oct 2026 09:46:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdkq-000000001cc-3ttQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SPle3k2riGvICBe9WvMQiFelNiRKdZN4rnF+IcTm3/s=; b=CjaiI/rhiX+zAtqpwzEKMjQSXk
 HduS8cNaell4Hx67eHC1M+UOS6c+JkIbqejLRpCbolA+kQsnq7dncsT6vU9Pyz8LgZxN3I14IGu5u
 6ZNTkJ+geJta7CpOW2ptRHEifakfZdbnT6Tv0k74g01PK2Vy2nti+CsaoauIR18Ho5M0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SPle3k2riGvICBe9WvMQiFelNiRKdZN4rnF+IcTm3/s=; b=fGkRug4P22Ui9rmFbPzYyphs02
 6/DP8rIm/afjHepvtwEqnQYOK4tqBEsqqP+uB5aUZ5Rf7WIULckI6Icz+cEjVojHwiXlZ9RxWAHw6
 0VjMvuMEhGQrYf88+sB1ryS1A1gbMYwTBcBEP/BLHzZsHYn+r/P26WSk41DKTF3vN3ak=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdko-000000001CL-0idC for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:04 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so2159355f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094355; x=1793699155; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SPle3k2riGvICBe9WvMQiFelNiRKdZN4rnF+IcTm3/s=;
 b=OXHla8XSpw8CKkWIWmMF6zgPAbvNT9CFL64uz2KHK8EzIi7f2SHu0xCJ1gGpPpIGTe
 jThZ9xw1ZPbgmhJdRabytz7jWKURjm3KkyH4FMshU5ylA8NaTNhnY3WmG9yUKrfYC4or
 EHZJvuTVFSA1YlEWf0pjSdX8zEw0NtUIi+pADj9CWHOqY40C894KyluSqbc+nKdxvcgP
 K2q1t3AXtaGZBb0WeNPAACClwponR8IBy1eDt+gOEPobVRjSmHgBtUu19bYYj6t/DoXM
 +ZNcK/9s6ZJCj6HbD+Foq3zYN50dcCk3DxExkw2kQsbGeS+l+YQDLzkvWcExBdu9teQ6
 0zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094355; x=1793699155;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SPle3k2riGvICBe9WvMQiFelNiRKdZN4rnF+IcTm3/s=;
 b=PxV6VcEQl9Egiwo47+rVqYzCXJCOmyHgeO0RuUBYkLZZTPibUmQOPc1jKHkDihgXqT
 rodSgM90tGTw6WRDHSAoKpvVspUFXHDRozZqwG0LZLkpw0dV/nJY67RZb9dMipAnGRmM
 Dq8GE0DKWPCu+v4qaJeN+WMuBUqJk+nAU8PXpkq7CXRT1KgaEt+/BdM07CtF7KFyRmf9
 O4T42nVnkZIS5IJ9w6JGlXrHaFR/IS4CZjGKvp4x0/Ma/8i5gkhwlSCpCWl6Zylp+na7
 S96v15a2/DXcaXhds1A+9x434crWWQtPMH4ClD6cfNnKct37YRf3CLQMz2Sy+JxQt7Sh
 JYXQ==
X-Gm-Message-State: AFq9FYIVqxRmdJaNWTFIYwJT9PvRDnQFnVSKTsUU6M9NBubPe2Jk+25n
 TUfPwLoYNGNQQvZcvaynnQE9kPxPgqCePtDxK7p6q5/RMa/78QQLZSUebH30a+PJm8wSQ3QkF6z
 lFK6v4WHScHHvUb4YfFfLVUDziJ12JtHkWO/h9lKNg2FQBaTezdgczgUMx5agxfqLYIDS22FsvK
 5CXmMhew==
X-Gm-Gg: AYBFou3lKKFWesIHVQLRudDX38MHRw2AvaYNDpF7lyWMEVctFrhIfingS/hmIjr9JsI
 HXGOUFrc2njT5eRfj0q4h7vetKEso53uI9ZRqYthh3A/xrFvy/+bYb5FZCUDzu4RUo0K14Q1I26
 siM4q3rfcQg+H77xtQOKEP96D+D1WMP+0j/Nbyh2iwkIu9xTGcaWtbg+kzVncy5rwPAcjGaZ3gz
 4Qet4wfaklGa2sYL7KjXJuS+zcFfs/Z4MGlSs+RNX9cI7F+/nHb6N2WR6boyn2qtr1Ci8syCPYt
 fsXAL7LfYSiJwmnpSPM8afKz5WP18xQAzs517ZOqPda3RZEKjQ8VNTrY7CeI8czzW3RFWXkqfW4
 JIQhJWqmU9FsQY4QkQM7WIW97XYfU41oCW+7Fse/ndlimnEQvhgli5UnkGHFtuDBIaoOvmP+YbI
 IhxaWbfUVWGKNd5eGX+gd4x/sWB90IuQXapDqj/xQCd6Hdltsmpl16rdvKEXcCHrlw9FTVH4xPs
 bS9941iOKxOY6jB5PQjisfna7k3zx0i54qyzChUKGZ/XwYAxs03yGJ7FT5heGY6c+hXNEXOcV0d
 kfl/vgTWLzDaXGKMROcQlbN522ZQWdNC7Ejl5EMSUUmnf23y3+zK5W073t9QooaxOE0K/I9Hj9R
 0ITeLvguPbVqIzz7CvE4PwOt30WMwYZ0df51qod1Mrg==
X-Received: by 2002:a05:6000:481b:b0:48e:82f:48fc with SMTP id
 ffacd0b85a97d-48e3eb971ccmr20290073f8f.31.1793094355296; 
 Tue, 27 Oct 2026 02:45:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb99esm21091516f8f.23.2026.10.27.02.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:45:54 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:45:52 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
X-Gerrit-Change-Number: 2040
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2040?usp=email>
X-Gerrit-Commit: b88f198569da0953b6e64fcc5886f04d35802f9d
In-Reply-To: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
References: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDUxODI5MDAwLkllYTE1MTk4OGYyZmExMjBiMTI2MjA1MTU3MjYwNGUzZjQyZWY0YjFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d8aa249c03ca203dee32f62267a6275a70e8e26-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdko-000000001CL-0idC
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
Content-Type: multipart/mixed; boundary="===============3128184456725619370=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3128184456725619370==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V//gR0Hlb0M="; charset=UTF-8

--V//gR0Hlb0M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2040?usp=3Demail

to look at the new patch set (#=
3)=2E


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
2 files changed, 32 insertions(+), 10 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/2040/3=


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
index 086a6fc=2E=2E264a17f 100644=

--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2516,6 +2516,20 @@=

     return ret;
 }
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Returns true if t=
his multi context has an established session, i=2Ee=2E the
+ * initial conn=
ection has completed and the tunnel is up=2E  A new session
+ * that is bei=
ng negotiated in TM_INITIAL in this state does not change the
+ * state of =
the tunnel until it is promoted to TM_ACTIVE=2E
+ */
+static bool
+tls_mult=
i_established(const struct tls_multi *multi)
+{
+    return multi->multi_st=
ate >=3D CAS_CONNECT_DONE;
+}
+#endif
+
 /**
  * Move the session from S_IN=
ITIAL to S_PRE_START=2E This will also generate
  * the initial message bas=
ed on ks->initial_opcode
@@ -2554,12 +2568,6 @@
          session_id_print(=
&session->session_id, &gc));
     gc_free(&gc);
 
-#ifdef ENABLE_MANAGEMENT=

-    if (management && ks->initial_opcode !=3D P_CONTROL_SOFT_RESET_V1)
- =
   {
-        management_set_state(management, OPENVPN_STATE_WAIT, NULL, NU=
LL, NULL, NULL, NULL);
-    }
-#endif
     return true;
 }
 
@@ -2883,6 +28=
91,18 @@
     if (ks->state =3D=3D S_INITIAL)
     {
         continue_tls_=
process =3D session_move_pre_start(session, ks, false);
+#ifdef ENABLE_MANA=
GEMENT
+        /* Do not report a new session attempt (e=2Eg=2E a peer res=
tart in p2p
+         * mode or a stray hard reset packet) as WAIT when we =
already have
+         * an established session: the tunnel is still up and=
, unless the
+         * new session succeeds, nothing would ever report CO=
NNECTED again */
+        if (continue_tls_process && management
+         =
   && ks->initial_opcode !=3D P_CONTROL_SOFT_RESET_V1
+            && !tls_=
multi_established(multi))
+        {
+            management_set_state(mana=
gement, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);
+        }
+#end=
if
     }
 
     /* Are we timed out on receive? */
@@ -3891,7 +3911,8 @@
 =
        }
 
 #ifdef ENABLE_MANAGEMENT
-        if (management)
+        /* =
see the WAIT state in tls_process_state() */
+        if (management && !tl=
s_multi_established(multi))
         {
             management_set_state(ma=
nagement, OPENVPN_STATE_AUTH, NULL, NULL, NULL, NULL, NULL);
         }

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea151988f2fa120b1=
262051572604e3f42ef4b1c
Gerrit-Change-Number: 2040
Gerrit-PatchSet: 3
Gerri=
t-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>

--V//gR0Hlb0M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://gerr=
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
es=2Etxt<br>M src/openvpn/ssl=2Ec<br>2 files changed, 32 insertions(+), 10 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/40/2040/3</pre><pre style=3D"font-family: mon=
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
264a17f 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>++=
+ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2516,6 +2516,20 @@</span><br><s=
pan>     return ret;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Returns true if this multi context has an est=
ablished session, i=2Ee=2E the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * initial connection has completed and the tunnel is up=2E  A n=
ew session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that i=
s being negotiated in TM_INITIAL in this state does not change the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * state of the tunnel until=
 it is promoted to TM_ACTIVE=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_multi_es=
tablished(const struct tls_multi *multi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /**</span><br><span>  * Move the session from =
S_INITIAL to S_PRE_START=2E This will also generate</span><br><span>  * the=
 initial message based on ks-&gt;initial_opcode</span><br><span>@@ -2554,12=
 +2568,6 @@</span><br><span>          session_id_print(&amp;session-&gt;ses=
sion_id, &amp;gc));</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGE=
MENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (managemen=
t &amp;&amp; ks-&gt;initial_opcode !=3D P_CONTROL_SOFT_RESET_V1)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        management_set_state(management, OPENVPN=
_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span>     return true;</span><br><span> }</span><br=
><span> </span><br><span>@@ -2883,6 +2891,18 @@</span><br><span>     if (ks=
-&gt;state =3D=3D S_INITIAL)</span><br><span>     {</span><br><span>       =
  continue_tls_process =3D session_move_pre_start(session, ks, false);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Do not r=
eport a new session attempt (e=2Eg=2E a peer restart in p2p</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * mode or a stray hard res=
et packet) as WAIT when we already have</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * an established session: the tunnel is still =
up and, unless the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * new session succeeds, nothing would ever report CONNECTED again *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (contin=
ue_tls_process &amp;&amp; management</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &amp;&amp; ks-&gt;initial_opcode !=3D P_CONTRO=
L_SOFT_RESET_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &amp;&amp; !tls_multi_established(multi))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            management_set_state(management, OPENVPN_ST=
ATE_WAIT, NULL, NULL, NULL, NULL, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>     }</span><br><span> </span><br><span>=
     /* Are we timed out on receive? */</span><br><span>@@ -3891,7 +3911,8 =
@@</span><br><span>         }</span><br><span> </span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* see the WAIT state in tls_process_state() */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (management &amp;&amp; !tls_mu=
lti_established(multi))</span><br><span>         {</span><br><span>        =
     management_set_state(management, OPENVPN_STATE_AUTH, NULL, NULL, NULL,=
 NULL, NULL);</span><br><span>         }</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">cha=
nge 2040</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2040 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--V//gR0Hlb0M=--


--===============3128184456725619370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3128184456725619370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3128184456725619370==--


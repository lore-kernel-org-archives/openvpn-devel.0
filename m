Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C623606A332
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RqmCtD6L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EInLXQqH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ROsONWMT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c2ihN0Pe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=rGEC5aDGNd1q0YIvLPzzNusD3MBBfXCYDJn3b3xkTs0=; b=RqmCtD6LbJdN9FcL2k18+E5lvf
	2CC/l8Nh9qCJw8/YqJfW4ExUaJfGjUR8I9fyQXlv9ZiPtK7nfHsq1lexO1wzGxUuuRYfLA5/16H7k
	u5fkZ/7aFtOoreYW9fCudj89kKbDju1XWpbDw2We/64DOmhZda+HH/hC+5fVeQFzrKQE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLShC-000000001dz-12JG;
	Mon, 26 Oct 2026 21:57:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLSgz-000000001dj-1i1f
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 21:57:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DjN48prjcNaKK1rFgTjDgxh3FjnIXc9jEhFWLDE070U=; b=EInLXQqH+gw1ajYj8dP4dfNANR
 daj2fP4QepeA5LIBVLWaFNvmMdaURmmmaI1UYUrrmIXYl6hAk4Zlew4Hb3nlh549BUwBkbdpVWab+
 fhaBNRpLAmkixfD2vd2HUVfSvYeg4cfTlQ2l4ZFjS0MR+CpBGREmcPpE5H8JwwzkKf5g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DjN48prjcNaKK1rFgTjDgxh3FjnIXc9jEhFWLDE070U=; b=ROsONWMTFvhdIEnVyTieM4fj+e
 5n6Dgkie6fDyLyuHs6xdfNGUSvMJWk1Ii+MZz55OuxTs46EgZ3peG5mKD4t+bA+7zyFZryij+Z2Dn
 DkZHu4B13/mnPDIOk8/XdqNWtfxfzvTgcrMj1G/E2K08UmmvW3mmFARWYmaRNJBxLXP4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLSgx-000000005nM-1Jf7 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 21:57:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so33736735e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793051833; x=1793656633; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DjN48prjcNaKK1rFgTjDgxh3FjnIXc9jEhFWLDE070U=;
 b=c2ihN0Pet+vR9rIBVVMChisgAb1MTxEYzW+EHQKOqvCg3TJlXr98lvdrGQEPKtaeGe
 dKo1WDZmEyNBu5rxS8b/cFlbqjB8d7fQcSaGyAJnrjyv7XzUmO1pYSLI9u41N7xl1A0L
 qCBTxXRxcLjE/J8xk99DALmSR7j1daAlYnlY0mrD+jNYnROJ+k+z1KgcdZK3yU/UM0a8
 thEI0kja1+qh2PT40tmFAHLpv7XRrsSKoLmfJhUuAmt5iK14uM8xoha7z31WR+h4H14m
 0hag9FgpYUP+v1XIyD14l5sDZYYr8mWIz61WolpK2CW0yuWdDBLn4SFmBZOegaa8ezZN
 wn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793051833; x=1793656633;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DjN48prjcNaKK1rFgTjDgxh3FjnIXc9jEhFWLDE070U=;
 b=MgeOca3GZ3Ut117euL+dQACsNAuWrkJ303l5n4mEr3eDhoUhPrVOJvpuJY2zfK2rQw
 VPFc4tqHC2HYFvWOc6feoeUg4g1hJcl58HTux6YsMbPEomv4ygWbbsdNfEmLk5SLR7ok
 2j40yyaK73ir3CsLAgpmDZf0LdZfftMrii1xPEoKWLxi4Xy8KrtlwM3nYgXr0jh/gFsA
 ze4weRr6JQk+Sk3trhDQ9UXN/+HXVfXTv05Pgb0iQGTZhgs4jSxLzJvTu67LOSv2PrUs
 59eEll7JcopW8nqL9i92+1/bx3W18vxL2MWRSxJB/Nf5n0JTUq6sqOVd4Gmqwk81i8V7
 dVYw==
X-Gm-Message-State: AFq9FYL4jwpWDSnWsAJqrYakwx7J6kKz4Edbof0854Kx6rCqh74HmmAz
 1rBerI7p8nIiGC49BdVMo1t1u85eL4OzMDq1D83efILa8FOvKYFVaiRoo1beR/XlZoWj1rVb4q2
 TvgOeI0c44vjmnV79scnUTsusx9OkTsjS+tXGDlSM2kVcL8Sve0YIQzeHtIMWhaXbuZ6bnIReJD
 W5Pd2kQg==
X-Gm-Gg: AYBFou0Ro/gkmmTZV1lE9ouTTbwnlbcL3eJ1YpgEifBGp1E1bpr9J8Asui5M3gkC3ns
 0dylGWxI8aMvYErv6JNfXI65IDxr12CSPElb415lqnZMcRq5or1UFJKWMGoAFlD3qstb1UkEdu7
 hpguXd5L+e9TKc9wfBs1o6wRZNAlXwNNRv2Rz9sIkkEpbvyNOUpCaEaTC5j2JJPNAUZRXm0H68j
 TkekDRpHzUqKRYbnqVKrnCDy9R5i3aqcXkpUNeoFrfGgtdBzNpYFJdeEoIgqwDYSofxf/YOsB/X
 HV55IgPjPRii32ffcWggpK/oepE9w6X9vZOFGsapO9CTMqWIp/pX3GAVdmdktXJ3b164IndZ8QZ
 WO9z1VYcOgYUSCGllpQxEJqOZr4JzUEVhY+XebNLrmKlTderbnpkXm5CYbhKoF+TQZsKHULj6zQ
 2zqlacKGwOxqIfpaLBYqxTC6FHVnMPM2ROHpYthpXgN73lOygyGImBJvCiwahJmw16t80jgDOZO
 sj2hKmMj5AZEfM3Yw/dL2dUmEjc1gTwkk2OkZOEh/9po0wgYr1Llak7tDL7368afRsH9/x1vsP7
 usugAfp78Q0JP8HEs4iS3iGhKQsZIXAt9r+Pzi+RUW2fJV9dcgaGiMtjUdmbjZCXdrWXmKxsb5I
 8K1QqdTz1NpOVzCCizjUB1XVX8ZwQfU+XqUIyUtuHFw==
X-Received: by 2002:a05:600c:3b93:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4a35ac96004mr169473025e9.12.1793051832591; 
 Mon, 26 Oct 2026 14:57:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm19663082f8f.24.2026.10.26.14.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:57:12 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 21:57:11 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
X-Gerrit-Change-Number: 2040
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2040?usp=email>
X-Gerrit-Commit: 3ff05875a4425599b11d1cb3f6b8134f0d95fe76
References: <gerrit.1793051829000.Iea151988f2fa120b1262051572604e3f42ef4b1c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDUxODI5MDAwLkllYTE1MTk4OGYyZmExMjBiMTI2MjA1MTU3MjYwNGUzZjQyZWY0YjFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0a4ea88d022ea2c3edb0c5a979ae9364459f0264-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLSgx-000000005nM-1Jf7
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
Content-Type: multipart/mixed; boundary="===============8911628947599136575=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8911628947599136575==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C+DEVxM49XU="; charset=UTF-8

--C+DEVxM49XU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2040?usp=3Demail

to review the following change=2E
=


Change subject: p2p: don't report WAIT/AUTH for a new session while conne=
cted
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

p2p: do=
n't report WAIT/AUTH for a new session while connected

In p2p mode, a hard=
 reset that starts a new session moves the management
state to AUTH and WAI=
T even while the tunnel is up=2E If that session
never completes (e=2Eg=2E =
an unauthenticated probe without tls-auth/tls-crypt,
or a peer that gives u=
p), CONNECTED is never announced again and the
state stays WAIT although th=
e tunnel works fine=2E

Don't announce AUTH/WAIT when an established sessio=
n already exists=2E
A successful new session still re-announces CONNECTED v=
ia
CAS_RECONNECT_PENDING=2E

Also document that WAIT and AUTH are reported =
in p2p mode too=2E

Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
Si=
gned-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M doc/manageme=
nt-notes=2Etxt
M src/openvpn/ssl=2Ec
2 files changed, 30 insertions(+), 10 =
deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/40/2040/1

diff --git a/doc/management-notes=2Etxt b/doc/management=
-notes=2Etxt
index a28a1a8=2E=2E5b32ba6 100644
--- a/doc/management-notes=
=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -427,9 +427,10 @@
 These are the=
 OpenVPN states:
 
 CONNECTING    -- OpenVPN's initial state=2E
-WAIT      =
    -- (Client only) Waiting for initial response
-                 from se=
rver=2E
-AUTH          -- (Client only) Authenticating with server=2E
+WAIT=
          -- (Client and point-to-point only) Waiting for
+                =
 initial response from server or peer=2E
+AUTH          -- (Client and poin=
t-to-point only) Authenticating
+                 with server or peer=2E
 G=
ET_CONFIG    -- (Client only) Downloading configuration options
           =
       from server=2E
 ASSIGN_IP     -- Assigning IP address to virtual net=
work
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=
=2E=2Ea0edf69 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -2517,6 +2517,18 @@
 }
 
 /**
+ * Returns true if this multi context has a=
n established session, i=2Ee=2E the
+ * initial connection has completed an=
d the tunnel is up=2E  A new session
+ * that is being negotiated in TM_INI=
TIAL in this state does not change the
+ * state of the tunnel until it is =
promoted to TM_ACTIVE=2E
+ */
+static bool
+tls_multi_established(const str=
uct tls_multi *multi)
+{
+    return multi->multi_state >=3D CAS_CONNECT_DO=
NE;
+}
+
+/**
  * Move the session from S_INITIAL to S_PRE_START=2E This wi=
ll also generate
  * the initial message based on ks->initial_opcode
  *
@@=
 -2554,12 +2566,6 @@
          session_id_print(&session->session_id, &gc))=
;
     gc_free(&gc);
 
-#ifdef ENABLE_MANAGEMENT
-    if (management && ks-=
>initial_opcode !=3D P_CONTROL_SOFT_RESET_V1)
-    {
-        management_se=
t_state(management, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);
-   =
 }
-#endif
     return true;
 }
 
@@ -2883,6 +2889,18 @@
     if (ks->state=
 =3D=3D S_INITIAL)
     {
         continue_tls_process =3D session_move_pr=
e_start(session, ks, false);
+#ifdef ENABLE_MANAGEMENT
+        /* Do not r=
eport a new session attempt (e=2Eg=2E a peer restart in p2p
+         * mod=
e or a stray hard reset packet) as WAIT when we already have
+         * an=
 established session: the tunnel is still up and, unless the
+         * ne=
w session succeeds, nothing would ever report CONNECTED again */
+        i=
f (continue_tls_process && management
+            && ks->initial_opcode !=
=3D P_CONTROL_SOFT_RESET_V1
+            && !tls_multi_established(multi))
=
+        {
+            management_set_state(management, OPENVPN_STATE_WAIT=
, NULL, NULL, NULL, NULL, NULL);
+        }
+#endif
     }
 
     /* Are we=
 timed out on receive? */
@@ -3891,7 +3909,8 @@
         }
 
 #ifdef ENABLE=
_MANAGEMENT
-        if (management)
+        /* see the WAIT state in tls_=
process_state() */
+        if (management && !tls_multi_established(multi)=
)
         {
             management_set_state(management, OPENVPN_STATE_AU=
TH, NULL, NULL, NULL, NULL, NULL);
         }

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c
Gerr=
it-Change-Number: 2040
Gerrit-PatchSet: 1
Gerrit-Owner: Antonio Quartulli <=
antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--C+DEVxM49XU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2040?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">p2p: don&#39;t report WAIT/AUTH for a new session while co=
nnected<br><br>In p2p mode, a hard reset that starts a new session moves th=
e management<br>state to AUTH and WAIT even while the tunnel is up=2E If th=
at session<br>never completes (e=2Eg=2E an unauthenticated probe without tl=
s-auth/tls-crypt,<br>or a peer that gives up), CONNECTED is never announced=
 again and the<br>state stays WAIT although the tunnel works fine=2E<br><br=
>Don&#39;t announce AUTH/WAIT when an established session already exists=2E=
<br>A successful new session still re-announces CONNECTED via<br>CAS_RECONN=
ECT_PENDING=2E<br><br>Also document that WAIT and AUTH are reported in p2p =
mode too=2E<br><br>Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c<br>=
Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>=
M doc/management-notes=2Etxt<br>M src/openvpn/ssl=2Ec<br>2 files changed, 3=
0 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/2040/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><=
span>index a28a1a8=2E=2E5b32ba6 100644</span><br><span>--- a/doc/management=
-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><sp=
an>@@ -427,9 +427,10 @@</span><br><span> These are the OpenVPN states:</spa=
n><br><span> </span><br><span> CONNECTING    -- OpenVPN&#39;s initial state=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-WAIT          -- (=
Client only) Waiting for initial response</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 from server=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-AUTH          -- (Client only) Authenticati=
ng with server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+WA=
IT          -- (Client and point-to-point only) Waiting for</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 initial response f=
rom server or peer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+AUTH          -- (Client and point-to-point only) Authenticating</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 with server=
 or peer=2E</span><br><span> GET_CONFIG    -- (Client only) Downloading con=
figuration options</span><br><span>                  from server=2E</span><=
br><span> ASSIGN_IP     -- Assigning IP address to virtual network</span><b=
r><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><s=
pan>index 086a6fc=2E=2Ea0edf69 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2517,6 +=
2517,18 @@</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns true if this mu=
lti context has an established session, i=2Ee=2E the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * initial connection has completed and t=
he tunnel is up=2E  A new session</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * that is being negotiated in TM_INITIAL in this state does =
not change the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * st=
ate of the tunnel until it is promoted to TM_ACTIVE=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_multi_established(const struct tls_multi *multi)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return multi-&gt;multi_state &gt;=3D CAS_CONN=
ECT_DONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span>  * Move the session from S=
_INITIAL to S_PRE_START=2E This will also generate</span><br><span>  * the =
initial message based on ks-&gt;initial_opcode</span><br><span>  *</span><b=
r><span>@@ -2554,12 +2566,6 @@</span><br><span>          session_id_print(&=
amp;session-&gt;session_id, &amp;gc));</span><br><span>     gc_free(&amp;gc=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (management &amp;&amp; ks-&gt;initial_opcode !=3D P_CONTROL_SOFT_R=
ESET_V1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        management_set_state(=
management, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span>     return true;</span><br=
><span> }</span><br><span> </span><br><span>@@ -2883,6 +2889,18 @@</span><b=
r><span>     if (ks-&gt;state =3D=3D S_INITIAL)</span><br><span>     {</spa=
n><br><span>         continue_tls_process =3D session_move_pre_start(sessio=
n, ks, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Do not report a new session attempt (e=2Eg=2E a peer restart in =
p2p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * mode =
or a stray hard reset packet) as WAIT when we already have</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * an established session: t=
he tunnel is still up and, unless the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * new session succeeds, nothing would ever repor=
t CONNECTED again */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (continue_tls_process &amp;&amp; management</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; ks-&gt;initial_o=
pcode !=3D P_CONTROL_SOFT_RESET_V1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &amp;&amp; !tls_multi_established(multi))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            management_set_state(man=
agement, OPENVPN_STATE_WAIT, NULL, NULL, NULL, NULL, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span>     }</span><br><span=
> </span><br><span>     /* Are we timed out on receive? */</span><br><span>=
@@ -3891,7 +3909,8 @@</span><br><span>         }</span><br><span> </span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (management)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* see the WAIT state in tls_process_state() */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (management =
&amp;&amp; !tls_multi_established(multi))</span><br><span>         {</span>=
<br><span>             management_set_state(management, OPENVPN_STATE_AUTH,=
 NULL, NULL, NULL, NULL, NULL);</span><br><span>         }</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/204=
0?usp=3Demail">change 2040</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2040?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Iea151988f2fa120b1262051572604e3f42ef4b1c </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2040 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--C+DEVxM49XU=--


--===============8911628947599136575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8911628947599136575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8911628947599136575==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F0606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NDkSUIzH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lS2Zpw0Y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XnPUmLFt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K6So4WmX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JcV0U31bEYbOzZhCUHOAHGH6wU+0rn5i1kEVB/5fuNU=; b=NDkSUIzHiwbYRFFY3XMU7UkxcA
	OLpuQmbSCcvXybTQpYMq4lh3SfdGlVd1ZChfHU+serQwS70B3ay0bnjZgwFwUBexkynPGB5mPjcVO
	mTrAxdgysllpk8s/UbE4crFsEs7FGiMYDwAmUjmNiJDrLuHTEVr1IIpf6Q7CAIFPvgLw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR6A7-0000000087P-1v43;
	Wed, 11 Nov 2026 11:06:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR6A3-0000000087G-0sIl
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nfVWH2bcLV6HLFWRL2/ITzMWm43wNjmqjCJ5xjZVmks=; b=lS2Zpw0Y/nPDvBkIdQIvnGJa36
 ezio8xrY0qg373Fyh13xMrTNsJgeUmKyOyHejYx9zUviNST7ukyq6L70FkAHBO48p2jiNz2qKzZCO
 uQ58fAPvnmqlvTp2Sdp05kCBXJp6C4xLyZYNz6ErEtBTS8C55SQ3lE1WJQqiRMybQ7ak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nfVWH2bcLV6HLFWRL2/ITzMWm43wNjmqjCJ5xjZVmks=; b=XnPUmLFtv33Fu0fachGqJeA2fO
 6jdPTm2VKumRC8c2uD6ElNo54gSW7WT1qg9xWUekkzoF1K45YxPAbpMazokuvcZKRiOhDtKd7Ujvv
 rSZ7Ippczc2u4g4SN412TwNRxe2vdguZo0+ucXsg1AXgFTOhGF5HD+aclo4kI8N0Ke8Q=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR69z-000000003LA-1k20 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:06:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so18054075e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794395189; x=1794999989; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nfVWH2bcLV6HLFWRL2/ITzMWm43wNjmqjCJ5xjZVmks=;
 b=K6So4WmX2LyNKeIkG9RVXNwUb60JdbOpm9fpaVRrQ13IOpojY3eZB1zD27K1nD/dZW
 E/W/Sl79eaPq2oN+Ax9ck7knvlhdG5VpCF4XaqJAvSJXF74219RM4Ey8lJDOtlwrEKJs
 PI1avHBPMsuYa3zCYgnjl6nC9ndctkU+DwfPn5r174W+yH1P/82tQoyHwiYdf9W6qB9Y
 tBcVHgjTrzbPv5o2oF/Ei4J9pF/Vhh2Ag1/2wnQmJ5rHJ4yA2IdByizZmNijy4Y2BAJm
 VttsMhQkst6uv8Kj+dGQmGQ4sNuz8Seufq7X8tLc3AxzOI/8Wjidm2xORj6zjZZRiGtC
 zHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794395189; x=1794999989;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nfVWH2bcLV6HLFWRL2/ITzMWm43wNjmqjCJ5xjZVmks=;
 b=W2AkYa8XTMi0lpkhdVzFYaBkrYIdbIBw7K1BfX2f56S6pryw9eitnC8L1d64Bdu1Ft
 fJ3qG6kpeLOw5oMtYM3wMobkYF7JU6a7Fz58ZkXSFzP4hxcFwsPtmb+f7QKiZNddofE+
 zq2MksP2Eake4sAkLhF0FfgpaGQYu/ED3R2pKurTA//hUIrEFjr585//d+eojFL7muMS
 QqsJHqP496KTwcGraOUXmIuXH7rWHJQpCmzljOpfYph3CSCbKOBUPtiWhS3dSKsh864r
 3Nfd2Hv8KNV6SZjXlwEvokq0JgVFtlqXECdxzruFU7g1lwk80tesrA8GUOJSMhkB2aSm
 SBnw==
X-Gm-Message-State: APuU4Z8Fwh8Q6vPVQV7BMY3DjCX1mb2j4NtpsxwYYbAxBp0YlZOD4Pbz
 2SkaaJGti0vYzN78bjJXviJouK4yIzJHHZy426xKeFXYxdplhXC5MXot6dCnW/JOvOq3lk1UGu1
 FUdomjYGE2Gy8yGgF4wFtl2JUgKYULblVUEA1i4/KGiZxtPCeuCUVn1JSQC5l6NR1OAJcS3yYhw
 63l2CDkg==
X-Gm-Gg: AYBFou2sNpkJCWAc4FtDZFKWxxEjeMxSXWv3ibnbvY9Ur9QnmfdNXxtQxFdQ4FDsA6t
 QSsR7dMItPtMHNW+AOiFwgzJceWv7mE+HK/0SxsBkPaWjssvioIycDlHcU0LxrAQF4OtkFB+EmO
 9ymYH0YguccGMFp3wy316m6CzSCS20MXcK5EcK3x+YVpCRyIeh9O+EYt5jDzw24QSKHsYwi9LI/
 VLL1aWLlBN4zANfZwE/7QN0dYMJ3TpYSSGA00wT7GRnGCUUSY4KQbOH5IPjPr19BxM4DRn7fN0P
 Z44rKXkxgioBaLTbTi5UNSIoz77Sb07130iIRLrATYQR9OKb2VIzkb9L0POxXdHvwhOgWlYFT/P
 mffC+eX2voUmGUFupLaYJuXJ/5wUtUBrTMOPb3AthrsQT7sACR1IYgMnFS6mDBLTrgTUXQaoVhN
 nHyheXCIic0ywP4xctoJt2LR/or5NpQ3WnRxMBL2LxpwiL9nfXtlMWEeLOJRCC11h6tdYz68q6g
 EIiOMkVBcf4gE6dU4y7PdSOKDv7rZbVSAZCOsNI/wZ2cBPpGcvWhVyrAw1QBebE/Ri9kP+Wm26D
 6oMr1DXiwbnESna85exN+SxvSStm9GccoinTFXe0aJc3dUGkmzCbmIW8vDdUtsWMHm+0dwvLrre
 VJ989ihJg57qgzJl4w++md/38UCzH/wfHAbp6e0Kd9YyhuZXNWmKLfSvBDk6PlfMbDX1ouHSLCH
 19+ZNcd8/pwxHmdfs=
X-Received: by 2002:a05:600c:c10f:b0:4b7:6cae:63a7 with SMTP id
 5b1f17b1804b1-4ba08e0c5ecmr31529035e9.10.1794395188661; 
 Wed, 11 Nov 2026 03:06:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c5b9sm10113163f8f.9.2026.11.11.03.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:06:28 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:06:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 07f6f57e5f8ddd13fe97d81397579999a4e84442
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <09c9bc9415c79553db8034fec54046515f3021d1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR69z-000000003LA-1k20
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_verify_opcode from tls_pre_decrypt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1714904689527591474=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1714904689527591474==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="28v9FAcVCko="; charset=UTF-8

--28v9FAcVCko=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Antonio Quartulli, 

I'd like you to reexamine a change=2E Please visi=
t

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail

to look=
 at the new patch set (#2)=2E

The following approvals got outdated and wer=
e removed:
Code-Review-1 by Antonio Quartulli


Change subject: Extract tls=
_pre_decrypt_verify_opcode from tls_pre_decrypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_verify_opcode fr=
om tls_pre_decrypt

This extracts the pre-check to verify allowed op codes =
into its own
method to reduce the complexity=2E

Change-Id: I86154e5c997b04=
4f6913bddab58b43193ff539e1
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>=

---
M src/openvpn/ssl=2Ec
1 file changed, 41 insertions(+), 22 deletions(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2=
169/2

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index cdb94ed=
=2E=2E3ad7fe7 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -3725,6 +3725,46 @@
     *opt =3D NULL;
 }
 
+/**
+ * Does a very coarse c=
heck on the received opcode=2E It only checks if the
+ * opcode is an allow=
ed op code for the peer to send at all, not if this
+ * opcode is valid for=
 the current state=2E
+ */
+static bool
+tls_pre_decrypt_verify_opcode(int =
op, bool server, const struct link_socket_actual *from)
+{
+    if (op < P_=
FIRST_OPCODE || op > P_LAST_OPCODE)
+    {
+        if (op =3D=3D P_CONTROL=
_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
+       =
 {
+            msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
+=
        }
+        struct gc_arena gc =3D gc_new();
+        msg(D_TLS_ERRO=
RS, "TLS Error: unknown opcode received from %s op=3D%d",
+            prin=
t_link_socket_actual(from, &gc), op);
+        gc_free(&gc);
+        retur=
n false;
+    }
+
+    /* hard reset ? */
+    if (is_hard_reset_method2(op=
))
+    {
+        /* verify client -> server or server -> client connectio=
n */
+        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D P=
_CONTROL_HARD_RESET_CLIENT_V3)
+             && !server)
+            || ((=
op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && server))
+        {
+         =
   struct gc_arena gc =3D gc_new();
+            msg(D_TLS_ERRORS,
+       =
         "TLS Error: client->client or server->server connection attempted =
from %s",
+                print_link_socket_actual(from, &gc));
+         =
   gc_free(&gc);
+            return false;
+        }
+    }
+    return t=
rue;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routine wh=
ich sees
@@ -3783,32 +3823,11 @@
     struct session_id sid; /* remote sess=
ion ID */
 
     /* verify legal opcode */
-    if (op < P_FIRST_OPCODE || =
op > P_LAST_OPCODE)
+    if (!tls_pre_decrypt_verify_opcode(op, multi->opt=
=2Eserver, from))
     {
-        if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT=
_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
-        {
-            ms=
g(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
-        }
-       =
 msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=3D%d",
- =
           print_link_socket_actual(from, &gc), op);
         goto error;
 =
    }
 
-    /* hard reset ? */
-    if (is_hard_reset_method2(op))
-    {
=
-        /* verify client -> server or server -> client connection */
-    =
    if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D P_CONTROL_H=
ARD_RESET_CLIENT_V3)
-             && !multi->opt=2Eserver)
-            ||=
 ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt=2Eserver))
-    =
    {
-            msg(D_TLS_ERRORS,
-                "TLS Error: client->c=
lient or server->server connection attempted from %s",
-                pri=
nt_link_socket_actual(from, &gc));
-            goto error;
-        }
-   =
 }
-
     /*
      * Authenticate Packet
      */

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e=
1
Gerrit-Change-Number: 2169
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@ma=
ndelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--28v9FAcVCko=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Arne Schwa=
be <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by Antonio Quartulli</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Extract tls_pre_decrypt_verify_=
opcode from tls_pre_decrypt<br><br>This extracts the pre-check to verify al=
lowed op codes into its own<br>method to reduce the complexity=2E<br><br>Ch=
ange-Id: I86154e5c997b044f6913bddab58b43193ff539e1<br>Signed-off-by: Arne S=
chwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file=
 changed, 41 insertions(+), 22 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2169/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>=
index cdb94ed=2E=2E3ad7fe7 100644</span><br><span>--- a/src/openvpn/ssl=2Ec=
</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3725,6 +3725=
,46 @@</span><br><span>     *opt =3D NULL;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Does a very coarse check on =
the received opcode=2E It only checks if the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * opcode is an allowed op code for the peer to se=
nd at all, not if this</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * opcode is valid for the current state=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+tls_pre_decrypt_verify_opcode(int op, bool server, const struct link_soc=
ket_actual *from)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op &lt; P_FI=
RST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONT=
ROL_HARD_RESET_SERVER_V1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(D_TLS_ERRORS, &quot;Peer tried unsupported key-method 1&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode received from %s op=3D%=
d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 print_link_socket_actual(from, &amp;gc), op);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* hard reset ? */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (is_hard_reset_method2(op))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* verify client -&gt; server or server -&gt; client connect=
ion */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((=
(op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D P_CONTROL_HARD_RESET=
_CLIENT_V3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     &amp;&amp; !server)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) &amp;&amp; =
server))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                &quot;TLS Error: client-&gt;client or server-=
&gt;server connection attempted from %s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                print_link_socket_actual(from, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  =
*</span><br><span>  * When we are in TLS mode, this is the first routine wh=
ich sees</span><br><span>@@ -3783,32 +3823,11 @@</span><br><span>     struc=
t session_id sid; /* remote session ID */</span><br><span> </span><br><span=
>     /* verify legal opcode */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_pre_decrypt_ver=
ify_opcode(op, multi-&gt;opt=2Eserver, from))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (op =3D=3D P_CONT=
ROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;Pee=
r tried unsupported key-method 1&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode received f=
rom %s op=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            print_link_socket_actual(from, &amp;gc), op);</span><br><span> =
        goto error;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* hard reset ? */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (is_hard_reset_method2(op))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /* verify client -&gt; server =
or server -&gt; client connection */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op=
 =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-             &amp;&amp; !multi-&gt;opt=2Eserver)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            || ((op =3D=3D P_C=
ONTROL_HARD_RESET_SERVER_V2) &amp;&amp; multi-&gt;opt=2Eserver))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                &quot;TLS Error: cl=
ient-&gt;client or server-&gt;server connection attempted from %s&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                print_li=
nk_socket_actual(from, &amp;gc));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            goto error;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     /*</span><br><span>      * Authenticate Packet</span><br><span>    =
  */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2169?usp=3Demail">change 2169</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I86154e5c997b044f6913bdda=
b58b43193ff539e1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2169 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartu=
lli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--28v9FAcVCko=--


--===============1714904689527591474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1714904689527591474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1714904689527591474==--


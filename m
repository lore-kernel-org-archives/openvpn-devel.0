Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B17606A336
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KwAY8Nhs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DOr1WCnM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TJx5yxts;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cub3MvL4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hdflzPLUWel/0zPAKvYwUCVGwJyIDkNGjdmpt7+VJkk=; b=KwAY8NhsZtYX0vphZ1Ija+/eaa
	Tyj5CYLtMbfAUmkFMYvK+UkQbh+muAsriCDWDl6taGgB/wRCMADGsTTrxUqpsv7hRoCrWiPYN0PCu
	O8h2bWrPGLwR8UfSg5D2ZmjZGBBFK4z9d3RcUaD1/aBPhd1gPZZtDTE9h635JlJDZKI8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRpQd-000000001Jl-44Jh;
	Fri, 13 Nov 2026 11:26:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRpQc-000000001JZ-1tHC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aYv8WdQ1+f6um8MKG7LMkWFQeAv2uFmzLQqCqvwKXJc=; b=DOr1WCnMYbyE3jqexFRwSZou/S
 DU/IOz5HLfOiZyzjdjtPW34Bzbp6W7mKL+b/zPJiF+0GnVX7JoinfW48/lgEr1i/xSUkxd5ttZvve
 4WddfH3oXndhwyFcHYQlEU0G1ip6FhxRTHzDtVAZDVsXu4h3zH3P85u2brpNBVYKcN+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aYv8WdQ1+f6um8MKG7LMkWFQeAv2uFmzLQqCqvwKXJc=; b=TJx5yxtslyVAiGOISxMZL4P3q7
 EL9+1WnwtFj7lu1jR5fa83MRxEUBmTbzjAAmnlzb5qZXX/LA93mL0femAc6js/kIe7IdwJRNKnfZY
 KKHmhQ5dWVj4JPUZkgrVdPaeOqcTUumTW/Z2s5VEMNTFlZFZm53fsR5C3oFsMmyNKN3c=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRpQS-000000007f2-0UAr for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:26:38 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so568271f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 03:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794569189; x=1795173989; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aYv8WdQ1+f6um8MKG7LMkWFQeAv2uFmzLQqCqvwKXJc=;
 b=cub3MvL4XaaZJRXf0qOQ52RfDrIIlQmcB+IvCppv298T6vLKOan7Wtj3xt/FfpfALM
 uITPUZz0tLpVi0fhq/MzBSOdOtoPyK5YfRbJX5LZzNaOsaXCU8llwenruvSg/vqIe6/U
 OWmS9w4w8lukwLjus/a+uYsghv+G5JA8HvYsEF+7AGOkEFKmvdn/Wl0ZZjtQCkDba0fR
 mGPkURAM2XgBJuYe658rhlVh04wUP1OHX7oR6UYmZ+xXT/xECisKs8CdX27en7ocK1UA
 n/uD83/DoEQ0jhJ0PJsrXZDA4lapmEYUIwuKT8K7RdaDS8kviY0E/Jh5XTgtfxaZhd19
 TBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794569189; x=1795173989;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aYv8WdQ1+f6um8MKG7LMkWFQeAv2uFmzLQqCqvwKXJc=;
 b=ycwqTaXmogfAKzqnIukVJTJeQSncqk3V/133/Gg+Zz9/euvbb8utuAyJgmc1gPZac8
 HylUmk3obewxlgqMbWjI4CBTfj/atAhjoae8CUBYOaRqO5QuH+ImGq1Y1CByl5Wl7nIw
 nvKxSO/9wQovcwwY6XQ3sYsvSGXvUQia4d5XRHTmkviK/f6Jyp1RS3PHqe2Zwk959wH/
 Tuwu8wkd/0Tr4M7PLbBoXjVu7F/BahhhLN/PQT8ew3a7Ln2P18HMI4lvuBGcmQ5NUMNq
 TwoMRvLUxK/DDxV+IK+YQC4obPmZhDaFHnSXm9pJ6bdBe3eouV5LO/hINwbZkBFOGy+N
 EJWg==
X-Gm-Message-State: APuU4Z+2YE+Kql2XLMg/pJFnyHEL875+VGPE7ci4m2ngeDZ/gzSi8dFv
 c+/86ckvSbAf19aCXNmxh0Vgr123ve+LFCRSGGNXjgxoAmp/YrS3OiPqD8x00M/1OPkUZ7YweS4
 CUZUKBItFBEMsUbPilcwkOKig/5zzAsjlLU/ki/rLuHmOsagGUVIBXU/NxDvypwZw4j5M
X-Gm-Gg: AYBFou3xAIBrR0A7qFGF6puTgRXU4fu1yig9fufPAA7eXu7WtUhHrvXvQ92drGtBoep
 qLxLZID5SrN+XZ3Fgr3zwHDwedlTUF27+9yMXnJKlGv7BdK7ihIXalGMDhy0U8b5duoC44RNXu8
 YafYOKKfSnFBC/WCXVLdF37SHzkuDqC+tKYiYZjAYTMkbcNSmt6yCtUMcUGULRNUfXlpXVaRUny
 lIdmgpInIjPIa8D0y/27CoYmzO/fdyXrenGymr3OYbjmESxZWTGzwbcYRZwYLHI/EI84j0x4mQ8
 7xVKgZbsKMrD9dB7xBVaYTe97lvgi/NbZ8TDPd9tE2E5gL0GUK507A9Qutl863NJx9GIxGCoKS6
 v+j26PY8RchM6cpj1zWNpv7zoqEJE7AWMoZ4ALuk4Kn2eIuf8cHqTLrLc3/dwOEO+np8LAERvJ4
 xZViQDbx+6NixDgcXEcWBkLjFofgVVUMUMCD9PovL1ffLW4QNDRom5ZUrw4K3E3MUW6AyhzhsLh
 TJBM+uUCCTORmsZHE4hGpvwOIcS+zviXxDSAZqWJMnpRTIvH/e0nE3AM6AmpJnA3tVkdKYE5rtq
 Utg79kU5NS7YpdZmBYfVO9vGjzPv11lVwixiIZo4GYz9ANiwtjPsxLSoPJDKCWhoaMqf7Sqejeb
 yKqYBeUjNnYf67lEuKaI7XfL/Vv0sS+rXIEmzK2wuTwBV2l5AYi+C4lI0EuJZiAtB+uxYmgahb5
 9+poJa/+3oSCYKxww=
X-Received: by 2002:a05:6000:4a07:b0:48e:f47:273c with SMTP id
 ffacd0b85a97d-49c6d7340famr4805664f8f.8.1794569189364; 
 Fri, 13 Nov 2026 03:26:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f7828a4sm4857103f8f.23.2026.11.13.03.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 03:26:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 11:26:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 1c960855fd63dced713252698131d99f789a0bb3
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8974775d46d6b4bf6952e48a20b9f09133f07da8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRpQS-000000007f2-0UAr
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2971849757471929868=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2971849757471929868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e7RxuziDlAk="; charset=UTF-8

--e7RxuziDlAk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2169?usp=3Demail )

Change subject: Extract tls_pre_decrypt_ver=
ify_opcode from tls_pre_decrypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_verify_opcode from tls_pre_decr=
ypt

This extracts the pre-check to verify allowed op codes into its own
me=
thod to reduce the complexity=2E

Change-Id: I86154e5c997b044f6913bddab58b4=
3193ff539e1
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Anto=
nio Quartulli <antonio@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2169
Message-Id: <20261111140934=2E24057-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41159=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 41 insertions(+), 22=
 deletions(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
in=
dex d13a0d3=2E=2Ef91f226 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn=
/ssl=2Ec
@@ -3725,6 +3725,46 @@
     *opt =3D NULL;
 }
 
+/**
+ * Does a ve=
ry coarse check on the received opcode=2E It only checks if the
+ * opcode =
is an allowed op code for the peer to send at all, not if this
+ * opcode i=
s valid for the current state=2E
+ */
+static bool
+tls_pre_decrypt_verify_=
opcode(int op, bool server, const struct link_socket_actual *from)
+{
+    =
if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    {
+        if (op =3D=
=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER=
_V1)
+        {
+            msg(D_TLS_ERRORS, "Peer tried unsupported key-=
method 1");
+        }
+        struct gc_arena gc =3D gc_new();
+        m=
sg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=3D%d",
+   =
         print_link_socket_actual(from, &gc), op);
+        gc_free(&gc);
+=
        return false;
+    }
+
+    /* hard reset ? */
+    if (is_hard_res=
et_method2(op))
+    {
+        /* verify client -> server or server -> cli=
ent connection */
+        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 |=
| op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3)
+             && !server)
+    =
        || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && server))
+       =
 {
+            struct gc_arena gc =3D gc_new();
+            msg(D_TLS_ERR=
ORS,
+                "TLS Error: client->client or server->server connecti=
on attempted from %s",
+                print_link_socket_actual(from, &gc)=
);
+            gc_free(&gc);
+            return false;
+        }
+    }
=
+    return true;
+}
+
 /*
  *
  * When we are in TLS mode, this is the fir=
st routine which sees
@@ -3783,32 +3823,11 @@
     struct session_id sid; /=
* remote session ID */
 
     /* verify legal opcode */
-    if (op < P_FIR=
ST_OPCODE || op > P_LAST_OPCODE)
+    if (!tls_pre_decrypt_verify_opcode(op=
, multi->opt=2Eserver, from))
     {
-        if (op =3D=3D P_CONTROL_HARD_=
RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
-        {
-  =
          msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
-      =
  }
-        msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s =
op=3D%d",
-            print_link_socket_actual(from, &gc), op);
         g=
oto error;
     }
 
-    /* hard reset ? */
-    if (is_hard_reset_method2(=
op))
-    {
-        /* verify client -> server or server -> client connect=
ion */
-        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D=
 P_CONTROL_HARD_RESET_CLIENT_V3)
-             && !multi->opt=2Eserver)
-  =
          || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt=2Ese=
rver))
-        {
-            msg(D_TLS_ERRORS,
-                "TLS Erro=
r: client->client or server->server connection attempted from %s",
-       =
         print_link_socket_actual(from, &gc));
-            goto error;
-  =
      }
-    }
-
     /*
      * Authenticate Packet
      */

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I86154e5c997b044f6913bddab58b4319=
3ff539e1
Gerrit-Change-Number: 2169
Gerrit-PatchSet: 3
Gerrit-Owner: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--e7RxuziDlAk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2169?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Extract tls_pre_decrypt_verify_opc=
ode from tls_pre_decrypt<br><br>This extracts the pre-check to verify allow=
ed op codes into its own<br>method to reduce the complexity=2E<br><br>Chang=
e-Id: I86154e5c997b044f6913bddab58b43193ff539e1<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@m=
andelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2169<br>Message-Id: &lt;20261111140934=2E24057-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41159=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 41 inser=
tions(+), 22 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec</span><br><span>index d13a0d3=2E=2Ef91f226 100644</s=
pan><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl=2Ec</span><br><span>@@ -3725,6 +3725,46 @@</span><br><span>     *opt =3D=
 NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Does a very coarse check on the received opcode=2E It only check=
s if the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * opcode i=
s an allowed op code for the peer to send at all, not if this</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * opcode is valid for the curren=
t state=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_verify_opcode(int=
 op, bool server, const struct link_socket_actual *from)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (op =3D=3D P_CONTROL_H=
ARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;Peer=
 tried unsupported key-method 1&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERRORS, &quot;TLS Error: u=
nknown opcode received from %s op=3D%d&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            print_link_socket_actual(from, &amp;g=
c), op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* hard reset ? */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (is_hard_reset_method2(op)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* verify client -&gt; s=
erver or server -&gt; client connection */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_=
V2 || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             &amp;&amp; !server)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            || ((op =3D=3D P_CONTR=
OL_HARD_RESET_SERVER_V2) &amp;&amp; server))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;TLS=
 Error: client-&gt;client or server-&gt;server connection attempted from %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    print_link_socket_actual(from, &amp;gc));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /*</span><br><span>  *</span><br><span>  * When we are in =
TLS mode, this is the first routine which sees</span><br><span>@@ -3783,32 =
+3823,11 @@</span><br><span>     struct session_id sid; /* remote session I=
D */</span><br><span> </span><br><span>     /* verify legal opcode */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPC=
ODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!tls_pre_decrypt_verify_opcode(op, multi-&gt;opt=2Eserver=
, from))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D=
 P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(D_TLS_ERRORS, &quot;Peer tried unsupported key-method 1&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS, &quo=
t;TLS Error: unknown opcode received from %s op=3D%d&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            print_link_socket_actual(=
from, &amp;gc), op);</span><br><span>         goto error;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* hard reset ? */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (is_hard_reset_method2(op))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* verify client -&gt; server or server -&gt; client connection */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (((op =3D=
=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D P_CONTROL_HARD_RESET_CLIENT=
_V3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             &amp=
;&amp; !multi-&gt;opt=2Eserver)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) &amp;&=
amp; multi-&gt;opt=2Eserver))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                &quot;TLS Error: client-&gt;client or server-&gt;server=
 connection attempted from %s&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                print_link_socket_actual(from, &amp;gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto error;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br><span>      * A=
uthenticate Packet</span><br><span>      */</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail">=
change 2169</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/216=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I86154e5c997b044f6913bddab58b43193ff539e1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2169 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--e7RxuziDlAk=--


--===============2971849757471929868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2971849757471929868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2971849757471929868==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9346606A321
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WSsICqc/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X0RZKoNv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U6PmFTD/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VWewgcjS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Jf21FqV4Q5xlj5Ptq2gwCbboIR9RxETBxHPM4pGdJoI=; b=WSsICqc/D5WOkp+uXTe0dwogQq
	/daLaFq/F0/LKbQx/Tx+pURv0ioGmxh9bdh8exRaQ1jF//fCabJRG64fT7GpGXIFBQJ51mq63w4cl
	oTqfRa79h3YNpRtzatiQSX4zu0Clpr6Z2LYSYVSLj7VpN0tmdpSuEY+bYSPFod+4+U9g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRpQU-000000002tk-37hO;
	Fri, 13 Nov 2026 11:26:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRpQT-000000002tU-0YHu
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9a6SFZuNaSX7/zQm8Z260LY7xnufRJF26zg5+BN05wY=; b=X0RZKoNvC5b474+eEnGDQkdW8Q
 H0tznu0OfvZA23yHX0ETuKxo3fygENcRegfvwwRF6At7FwLJFxEta9dXmWdcHznOIT+0vlCr3o7x3
 8+scxLVIuSaF4PllirwOhq+uJWpfX+1qaAI4KcFB44L3InBY9OFQxqakEA4okQuJib10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9a6SFZuNaSX7/zQm8Z260LY7xnufRJF26zg5+BN05wY=; b=U6PmFTD/Z/d1hZNRrZU2i/JgoP
 QnzkXwC7ZUr8HXNItH5zbGsC73uKf4DGNGlVunlY6E/ME5+N9uhwn0iW8VYStEu9MT0pU346dRQkZ
 pLNnjiQRoDqWZhp6H11bgLPIBHoWJXjmRQ1HDUje6w7vsGGyS2pUPWjG+9vKVKS60Rco=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRpQQ-000000007f1-2Vmu for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:26:37 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so8988835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 03:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794569188; x=1795173988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9a6SFZuNaSX7/zQm8Z260LY7xnufRJF26zg5+BN05wY=;
 b=VWewgcjSMBwt7CcFQZghqNd0eltpNSTKiX1gRL4gaHZrQpzGj7SFSzk7qPj89z8m3j
 AeOmV22rBp3GYb2Wlk+h0AO47o1NSj5Huj7U2ULexdH+t3cRqCLjlnfVYwGCcsW9viUP
 M0LSQ2SPslDoU8uEZVWuYO9tvcDLJ05nPevO4ejF5rOAz1sIBNg6yTMKfvDxfC2ULTox
 FXMGi3RxjNbgNBfybQsEQkFD14BCdT/Xe+Sz88d7QHovA4ouU1SrSW5p7saMUnBrrl+x
 cAlNiJa8ZP15QAy9slSPGnE+ZHBwBBvIkMDwMKYh/uylE+iMV+dF3WUqRRAoAWG51uQU
 CMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794569188; x=1795173988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9a6SFZuNaSX7/zQm8Z260LY7xnufRJF26zg5+BN05wY=;
 b=pPHDhQcqtj0vLPB86IYweTqRn4+528tzomdAtNpyGrBQb4U71cG/SkmqgZTwbeGQ7Z
 PapfahK0XNhTd8ChvbouwA/2rtUuz6mR+39ADnKVVbsjlBA7PDbO1+Exhr8quCHseEte
 JnVlwt7yJGWkTjVuBl0q2JmyFZCizQJMaZgDJMgdOt7w2+gMqe15TTvEbsny/k7F9+i5
 c5b7fwy9nY2bWWKql0AvzHDNmL+voB5G/ukFiCJ7m+tAzphkYe1zbzlrc20RUh4C+Otl
 rf/C3rw7RalumTPvsjBvXvY6Gnn7Xeb2pjO9jOy7RNjOKkHMSKV8eEwQjW17GC33mruM
 Smew==
X-Gm-Message-State: APuU4Z9OhnnzoNpjaQMPDdASk5EbbpzhdvXSt5md1trcS0TIAmJweLNY
 FShgPgAhWvSQz6j4yshe763WeAuNK1T+i5+Sfl8RX/pNIq5eKg7SsqA7sBgR8w6ogQCIcBm5CHt
 uYl3rK4i7AYM6dm/5nfJ7bHdeRb1icBtCJrOuufEB20y45p0g4PQ6U6bHnerRKHJvxhTnLYabfD
 vdKk0CNA==
X-Gm-Gg: AYBFou2S7LeNj/oHq0KN3L2dHuNaIb/nUsCL6bs+wlz+vdYTtm78jEJzj4DTc1p+Pcf
 LHjh8uKO+rhPUR3sDM/vfHw7kU3+zg0Ec5a3RW+xBCxxC86mdIhDgrusbIigxUAODmt/cPVBlDn
 YKJFaRqg6iH846tMsoMtWMbYsOB7tA0IKGF2EayuyJypNZIM3JAI5SwEL8MKrIofhTrL5VtJ/eF
 b9fcvTdQMTUBEpHyEgFF21i5crg8dW58tm5cF4NG1FecxypHOkGFoJdWY10NmCy41TUIU/IEPok
 +A0F1Gf6nS8+deqs53Evhwu9y0yin3Cbo3XPjVRc0vzoCdgNXqYrW3pKrUWHE6UYpvjjDdvoI0h
 WWRdC2SF4AL8pMK8CZ23hwKRvLWydgxql/xJOxnnnM7KSDzn45vl06gi/gEVfrXawhqHfpzI3Wy
 Nz56fhDyfJW+8uZS249PJLHOVV+8NFLCqgc84ziFxrnmzbxlK+ThXIewA7G6GibkFlBrpaVBycv
 Kznz0qpcMhLVZyiwPHnEJCqU3/aaePG+ACWhfPZI1ri+v/DGgJfoppSrkl6qEuJjx3YqmMr9uXK
 7tCLKGx/KYGqx7zO1l7oIocBApTdtfHMyX5cUxyRl+OkYvmGRpnvijHDSeQ1l0Rc07iKjWXOI8/
 cFoZlPD920hNAk47GBj/GV+WTch6GYdIXWzSqN8z/En8N5Ud1ttOZu4ipaucK7LXiw6tHpiNL7m
 4Su9bf6yfxvglEBZKByK0u25jc6uysvDcRwMBI
X-Received: by 2002:a05:600c:46c5:b0:4b6:5dac:b61e with SMTP id
 5b1f17b1804b1-4bb55a9b453mr43787145e9.32.1794569187788; 
 Fri, 13 Nov 2026 03:26:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49d673ce75fsm495832f8f.55.2026.11.13.03.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 03:26:27 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 11:26:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 1c960855fd63dced713252698131d99f789a0bb3
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8974775d46d6b4bf6952e48a20b9f09133f07da8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRpQQ-000000007f1-2Vmu
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
Content-Type: multipart/mixed; boundary="===============7596826838615574299=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7596826838615574299==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6n6CcH0z90s="; charset=UTF-8

--6n6CcH0z90s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Antonio Quartulli


Change subject: Extract tls_pre_decrypt_veri=
fy_opcode from tls_pre_decrypt
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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/69/2169/3

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
i=
ndex d13a0d3=2E=2Ef91f226 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvp=
n/ssl=2Ec
@@ -3725,6 +3725,46 @@
     *opt =3D NULL;
 }
 
+/**
+ * Does a v=
ery coarse check on the received opcode=2E It only checks if the
+ * opcode=
 is an allowed op code for the peer to send at all, not if this
+ * opcode =
is valid for the current state=2E
+ */
+static bool
+tls_pre_decrypt_verify=
_opcode(int op, bool server, const struct link_socket_actual *from)
+{
+   =
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

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86154e5c997b044f6913bddab58=
b43193ff539e1
Gerrit-Change-Number: 2169
Gerrit-PatchSet: 3
Gerrit-Owner: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli=
 <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--6n6CcH0z90s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/216=
9?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Extrac=
t tls_pre_decrypt_verify_opcode from tls_pre_decrypt<br><br>This extracts t=
he pre-check to verify allowed op codes into its own<br>method to reduce th=
e complexity=2E<br><br>Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1=
<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2169<br>Message-Id: &lt;20261111140934=2E2405=
7-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg41159=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<b=
r>1 file changed, 41 insertions(+), 22 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/216=
9/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><b=
r><span>index d13a0d3=2E=2Ef91f226 100644</span><br><span>--- a/src/openvpn=
/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3725=
,6 +3725,46 @@</span><br><span>     *opt =3D NULL;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Does a very coarse c=
heck on the received opcode=2E It only checks if the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * opcode is an allowed op code for the p=
eer to send at all, not if this</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * opcode is valid for the current state=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tls_pre_decrypt_verify_opcode(int op, bool server, const struct=
 link_socket_actual *from)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op =
&lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=
=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_TLS_ERRORS, &quot;Peer tried unsupported key-method=
 1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode received from %=
s op=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         print_link_socket_actual(from, &amp;gc), op);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* hard reset ? */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (is_hard_reset_method2(op))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* verify client -&gt; server or server -&gt; client =
connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D P_CONTROL_HAR=
D_RESET_CLIENT_V3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            &amp;&amp; !server)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) &amp=
;&amp; server))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_TLS_ERRORS,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot;TLS Error: client-&gt;client or =
server-&gt;server connection attempted from %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                print_link_socket_actual(=
from, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><=
span>  *</span><br><span>  * When we are in TLS mode, this is the first rou=
tine which sees</span><br><span>@@ -3783,32 +3823,11 @@</span><br><span>   =
  struct session_id sid; /* remote session ID */</span><br><span> </span><b=
r><span>     /* verify legal opcode */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_pre_decr=
ypt_verify_opcode(op, multi-&gt;opt=2Eserver, from))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (op =3D=3D=
 P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &q=
uot;Peer tried unsupported key-method 1&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode rec=
eived from %s op=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            print_link_socket_actual(from, &amp;gc), op);</span><br>=
<span>         goto error;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* hard reset ? */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_hard_reset_method=
2(op))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        /* verify client -&gt; =
server or server -&gt; client connection */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V=
2 || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-             &amp;&amp; !multi-&gt;opt=2Eserver)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || ((op =3D=
=3D P_CONTROL_HARD_RESET_SERVER_V2) &amp;&amp; multi-&gt;opt=2Eserver))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;TLS Err=
or: client-&gt;client or server-&gt;server connection attempted from %s&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                pr=
int_link_socket_actual(from, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            goto error;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /*</span><br><span>      * Authenticate Packet</span><br><spa=
n>      */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2169?usp=3Demail">change 2169</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86154e5c997b044f6=
913bddab58b43193ff539e1 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2169 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio=
 Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--6n6CcH0z90s=--


--===============7596826838615574299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7596826838615574299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7596826838615574299==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93449C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ue9KilHHBGyUlmnhDtOlH1Mcy6OzZ5rZG3tnJbuy2Lw=; b=kRnpAAmrX8q1cxqrO9ncgFHaii
	IXwXrwpqvqpDrIwIfyi9V7pi0B7H2qdxUjL3TENNMILVInX3bd9OPNqloJ9TpbCcWSoGXn8q+iE/8
	QIpv/xexGbgQjTeksDj0WMNMO6NtPYZTBqAqndAA4qaY1GigCYoZsf6hv1QEUyev5Qg4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wTA-0003hs-Hp;
	Fri, 11 Sep 2026 08:18:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wT8-0003hJ-3w
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o7BfdV52rMYjhh1frmvPL+hcs005q9ZsyKqMn3Uv01s=; b=Jw34oB81HGmahipIgoW/OeD8Q3
 2Hs2IeR1a9f6RuA2tHKwrnm9LWXQPyL44jw0HzbVwB5WjzzVWlaz4hatihbvRAHLOY/zNxfxKlR/j
 xXGo4HShsa43b1VpUOuMWm60Wf4qDdQv8Gh+sotSQAY6dHuh6Ec2FcA5AiB43JqESo9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o7BfdV52rMYjhh1frmvPL+hcs005q9ZsyKqMn3Uv01s=; b=O
 2kmOrGuHiTXgAp2v/RDp6YbVshWKhKujB20RFA2vKmWxJvPy5VuEYcK9j7wvoKG63A6wd21KqBrjM
 uZQuNJBzclAkT6f5NzTRn7l/+C3xrh1lqF/MStMQxUmzBrDDyolRSufAXvD6O8lgK3sbtl4WhT8wf
 ILuCpRHH7eNVGF0k=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wSt-00040t-5L for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:46 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso332169f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114704; x=1789719504; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o7BfdV52rMYjhh1frmvPL+hcs005q9ZsyKqMn3Uv01s=;
 b=WAZnUfo7gwcuw9W4P3jL0XUAMfhfTZxc1G+S0sdCw6bP1Q2BvD9tibAuzIaTtwK4KN
 Fm1gRldr3uAidd3W5RiwlRXtWmZB2S87yc8cQoxCtkcfJHzH704Vn44j1QUhU3dpdPJs
 cIowK6cWmgGy9DZgqeOd1GpUuodxXEh4ishfKmkV76HB5lrUL0oF3TY+YAUkxr6T3AmR
 Z+A1EgS5B+StZgVEWbag4Wad+VruqAcDyd/c8wsvK92GckPy3MwzwOZY9u3kXJX8kdMr
 xPVa5tQds5KIRL/P6s8AoBM1TB4Uf0ABuinGiF0ZqPqIbpMZZxPvHcqIOLZbNGRllkuj
 2MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114704; x=1789719504;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o7BfdV52rMYjhh1frmvPL+hcs005q9ZsyKqMn3Uv01s=;
 b=ejuL3YpAsIqGUFITGKv98EITJwMqh5vSLwkxMq9Ot50gND1TrZ10u+0qo2FrTsQzH2
 y8G5wD02rqtARluSxg7RaWwqTsNXFWwgY0Ppfqbb9tBa+0ZXPbemvVZ6rYkLImrXcH1h
 MTIm27YoNVTENi8xm215XxO21e0lC+ADaUK2wxUwwB9JVHCitK/j+vFhGdw+PPhcJdSz
 uX8Qi0pnyNRkFTPAGoiohjL9W9XE6/lRIlJRVWrnco/yLX+oTJbLf4TUiKV89DV0arXj
 8CJKBjpxhXNE1MSNchN9CUvUFmByjbYfmDurYIF5khxJdmhY1vzfGmRmc/Cx59FocxPW
 X7CA==
X-Gm-Message-State: AFuF++mz03r3tp1pYNmjP0T5fhsqe4o0v5uCgWphwE7y8URbojb3yerU
 rMljausFlJtbGdUA8FaU3SXuLW0LPgHn+quFIw2b6/oqx52Zw1TYLDeQxpBP35xzlGXJzrIu53r
 o9GRniqhFNgdTaqlOzd0vpjZ1NDsi9vHkysJxSI2CdbFROcck8Fm446CHTcbC8TFiErzf
X-Gm-Gg: AYBFou1lIiYvcf9rYyNsTontU0ffAe4Dt4jh9EiYcMHaijiPpfkpsI4f244rFTNDpSW
 +B3T0N53AbVrdVh3TceUlNNcGy8fmhXWfxFH44MSlJGhGcMZwTpASghY3xwX99jumBWuzY1At1f
 7SJjGb8FuiSLdLlCPM5x/RogdjWugjhif0ptyzrRuQ24VchjvwkbQsYOVkhCvVTo7B5RaUZJ3bt
 Fyqh5mK9N961kFGwWAXu44YqUPBVJJkxhK8nN9Pw1QnN8mg7F87XPyGHuRiLieUeLe4neGgQ9dA
 vy+HT7k9gWZUGgiGRnqvXu+UUuRr29Zk8sGprYCG45W2yGFW3aqwfJp3ohPDrTTD/XtOdfp0ihY
 6PsEaLUXGft567SCBuFtGoQ9g1Oa/LlWT6mkt3gdfDwd7aDoRDLRSQO6BcLLoG0ZtYo5bDjzNiS
 sa5o5GxzcKgoPLlm1GJJmDmHucDgrQw4JSBevFx+30Pu5t49SZF+qdUevhwig6WF0A498e7peNb
 x2bs6POgmiWgJJ2boDjtfawEUgNXQzPb3uGxxTswZ99p3xsd+14gsDXk6ceFE8/ajUY/phfVFv0
 SgZOZ+PajxkUqpfiIJCfWlweVjQaE6EAahwHkqut4gUpckvyolbjzWdcrtLb5A==
X-Received: by 2002:a05:6000:454f:b0:485:acfd:4fa2 with SMTP id
 ffacd0b85a97d-486eb35833cmr3947558f8f.28.1789114703794; 
 Fri, 11 Sep 2026 01:18:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e81asm4324368f8f.7.2026.09.11.01.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:23 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0bafb513d396895314c155e94f0eb3df1ca7ecda
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62368ee1919e70d3460c6d263ac9797dcb6ab8c7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wSt-00040t-5L
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1041325090005469133=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1041325090005469133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CYshZWG8qAw="; charset=UTF-8

--CYshZWG8qAw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look a=
t the new patch set (#18)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


Change subject: oob: Add --server-pr=
obe to order client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --server-probe to order client remotes b=
y probe

With --server-probe [max-latency-diff], before connecting a client=
 sends an
out-of-band SERVER_PROBE to all configured UDP remotes, collects =
the PROBE_REPLYs
within a short window, and reorders the connection list so=
 the best-responding
server is tried first=2E Unanswered probes are resent =
once within that window to
ride out packet loss=2E The option is off by def=
ault; its optional argument
overrides the margin the server advertises=2E

=
The probe phase is self-contained in oob_client=2Ec behind a single call fr=
om
init=2Ec (before next_connection_entry())=2E It opens one UDP socket per=
 address
family in use through create_socket_udp_configured(), so a probe s=
ocket is
set up and bound like the connection socket it may later become (-=
-local,
--lport, --bind-dev, --mark), fans probes out and collects replies =
on them,
matches each reply to its remote by source address, and rejects sp=
oofed
replies via the session id the server echoes back=2E An address sever=
al
entries resolve to is probed once and its reply credited to each of them=
=2E
Remotes resolve with their own udp4/udp6 family=2E Probing is declined =
when
connection entries bind differently or reach the server through a SOCK=
S
proxy, since one socket set cannot represent both=2E Ranking and reorderi=
ng
use oob_rank_probe_results()=2E

For now the probe is sent unwrapped, so=
 it only works against a server without
tls-auth/tls-crypt (wrapping is a f=
ollow-up); only UDP remotes are probed; and
probing runs once, before the f=
irst connection=2E

Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Si=
gned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M doc/=
man-sections/client-options=2Erst
M src/openvpn/Makefile=2Eam
M src/openvpn=
/init=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
A src/openvpn/oob_cli=
ent=2Ec
A src/openvpn/oob_client=2Eh
M src/openvpn/options=2Ec
M src/openvp=
n/options=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
11 files changed, 857=
 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/47/1747/18

diff --git a/CMakeLists=2Etxt b/CMakeL=
ists=2Etxt
index fbc69f0=2E=2Eb87f1ef 100644
--- a/CMakeLists=2Etxt
+++ b/C=
MakeLists=2Etxt
@@ -527,6 +527,8 @@
     src/openvpn/occ=2Eh
     src/openv=
pn/oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=2Ec
+    sr=
c/openvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn/open=
vpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --git a/doc/man-=
sections/client-options=2Erst b/doc/man-sections/client-options=2Erst
index=
 87c138a=2E=2E0db010e 100644
--- a/doc/man-sections/client-options=2Erst
++=
+ b/doc/man-sections/client-options=2Erst
@@ -595,6 +595,32 @@
   seconds f=
or a response before trying the next server=2E The default value
   is :cod=
e:`120`=2E This timeout includes proxy and TCP connect timeouts=2E
 
+--ser=
ver-probe args
+  Before the first connection attempt, probe all configured=
 UDP remotes
+  out-of-band and reorder the connection list based on the re=
plies=2E
+
+  Valid syntaxes::
+
+     server-probe
+     server-probe max-=
latency-diff
+
+  A small probe message is sent to the first resolved addre=
ss of every UDP
+  remote, and each answering server replies with its adver=
tised priority
+  and weight=2E Remotes are then reordered following DNS SR=
V (RFC 2782)
+  semantics: servers that answered are tried before those tha=
t did not,
+  grouped by priority (lowest first); within a priority group, =
servers are
+  picked by weighted-random selection=2E Round-trip time is no=
t yet taken
+  into account, so ``max-latency-diff`` has no effect for now=
=2E
+
+  The probe is currently sent without control-channel wrapping, so i=
t only
+  works against a server configured without ``--tls-auth``,
+  ``--=
tls-crypt`` or ``--tls-crypt-v2``=2E
+
+  Only UDP remotes are probed=2E Re=
motes that answered are tried first, in
+  the order described above; all o=
ther remotes, including TCP ones, follow
+  in their configured order=2E Pr=
obing runs once, before the first connection
+  attempt=2E See ``--server-p=
robe-reply`` for the server side=2E
+
 --static-challenge args
   Enable st=
atic challenge/response protocol
 
diff --git a/src/openvpn/Makefile=2Eam b=
/src/openvpn/Makefile=2Eam
index 5e6b4d9=2E=2Ef8a5835 100644
--- a/src/open=
vpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -109,6 +109,7 @@
 	pkc=
s11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
 	oob=2Ec oob=2Eh \
+	oob_client=
=2Ec oob_client=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh=
 \
 	options_show=2Ec options_show=2Eh \
diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec
index 1109a13=2E=2E1b6372d 100644
--- a/src/openvpn/=
init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48,6 +48,7 @@
 #include "ssl_ncp=2E=
h"
 #include "tls_crypt=2Eh"
 #include "forward=2Eh"
+#include "oob_client=
=2Eh"
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #include "mudp=2Eh"
@=
@ -4446,6 +4447,10 @@
         }
     }
 
+    /* Probe configured remotes =
and reorder them best-first (--server-probe);
+     * no-op otherwise=2E Mu=
st run before next_connection_entry() picks a remote=2E */
+    client_prob=
e_and_order_remotes(c);
+
     /* Resets all values to the initial values f=
rom the config where needed */
     pre_connect_restore(&c->options, &c->c2=
=2Egc);
 
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 4c6d=
13f=2E=2E344f370 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec=

@@ -148,6 +148,33 @@
     return oob_timestamp_in_window(param=2Etimestamp=
, now, window_secs);
 }
 
+int
+oob_probe_next_target_at(const struct openv=
pn_sockaddr *from, const struct oob_probe_target *targets,
+               =
          const struct oob_probe_result *results, int n, int start)
+{
+   =
 for (int i =3D start; i < n; i++)
+    {
+        if (targets[i]=2Esent &&=
 !results[i]=2Eresponded && addr_port_match(from, &targets[i]=2Edest))
+   =
     {
+            return i;
+        }
+    }
+    return -1;
+}
+
+bool
=
+oob_addr_list_contains(const struct openvpn_sockaddr *list, int n, const s=
truct openvpn_sockaddr *addr)
+{
+    for (int i =3D 0; i < n; i++)
+    {
=
+        if (addr_port_match(&list[i], addr))
+        {
+            retur=
n true;
+        }
+    }
+    return false;
+}
+
 /* Base ordering: respon=
ders before non-responders, then by priority (lower
  * first), then by RTT=
 (lower first), then by original index for determinism=2E
  * This groups r=
esponders into priority runs pre-sorted by RTT, which the
diff --git a/src/=
openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index e637b90=2E=2Eb26f3a4 100644
---=
 a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -37,6 +37,7 @@
 
 #incl=
ude "buffer=2Eh"
 #include "session_id=2Eh"
+#include "socket_util=2Eh"
 
 =
/* OOB message types: the 16-bit value at the start of an OOB payload, befo=
re
  * its TLV entries=2E Distinct from the TLV-type space (0x2xx); see the=
 "Messages"
@@ -189,6 +190,37 @@
     struct oob_probe_reply reply; /* the =
values the server advertised */
 };
 
+/* Where the client probed one conne=
ction entry=2E */
+struct oob_probe_target
+{
+    struct openvpn_sockaddr =
dest;
+    socklen_t destlen;
+    bool sent;
+};
+
+/**
+ * Find the next =
entry, from index @p start on, that was probed at @p from and
+ * has not a=
nswered yet=2E Several entries can resolve to the same address, so a
+ * re=
ply is credited to each of them: call again with the returned index + 1
+ *=
 until it returns -1=2E
+ *
+ * @param from     source address of the reply=

+ * @param targets  where each entry was probed
+ * @param results  per-en=
try results; entries already marked responded are skipped
+ * @param n     =
   number of entries
+ * @param start    first index to consider
+ * @retur=
n the entry index, or -1 if none
+ */
+int oob_probe_next_target_at(const s=
truct openvpn_sockaddr *from,
+                             const struct oo=
b_probe_target *targets,
+                             const struct oob_pro=
be_result *results, int n, int start);
+
+/**
+ * Is @p addr (address and p=
ort) one of the @p n addresses in @p list?
+ */
+bool oob_addr_list_contain=
s(const struct openvpn_sockaddr *list, int n,
+                            =
const struct openvpn_sockaddr *addr);
+
 /**
  * Order results best-first, =
in place, per the server-probe selection policy:
  *   - remotes that respo=
nded rank before those that did not (non-responders keep
diff --git a/src/o=
penvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
new file mode 100644
ind=
ex 0000000=2E=2E75c553d
--- /dev/null
+++ b/src/openvpn/oob_client=2Ec
@@ -=
0,0 +1,618 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netw=
orks
+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased
+ *             session authentication and key exchange,
+ *          =
   packet encryption, packet authentication, and
+ *             packet com=
pression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2En=
et>
+ *
+ *  This program is free software; you can redistribute it and/or =
modify
+ *  it under the terms of the GNU General Public License version 2
=
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#=
endif
+
+#include "syshead=2Eh"
+
+#include "oob_client=2Eh"
+#include "ope=
nvpn=2Eh"
+#include "oob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "session_id=
=2Eh"
+#include "socket=2Eh"
+#include "socket_util=2Eh"
+#include "otime=
=2Eh"
+#include "fdmisc=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+=

+#include "memdbg=2Eh"
+
+/* Total time we wait for probe replies before g=
iving up and connecting=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+/* Numbe=
r of times an unanswered probe is resent within the window, to ride out
+ *=
 UDP packet loss=2E With this set to 1, each remote is probed up to 2 times=
,
+ * which removes the single-packet-loss false negative; further retries =
give
+ * sharply diminishing returns for a low-stakes selection=2E */
+#def=
ine OOB_PROBE_RETRIES 1
+
+/* The probe uses one socket per address family,=
 each set up and bound like the
+ * connection socket, so every remote is p=
robed on a socket of its own family and
+ * the winning remote's socket can=
 be reused as its connection socket, presenting
+ * the same source IP+port=
 the server bound its handshake cookie to=2E */
+#define PROBE_AF_V4    0
+=
#define PROBE_AF_V6    1
+#define PROBE_AF_COUNT 2
+
+struct probe_ctx
+{
+=
    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF =
is unavailable */
+    /* Addresses probed so far in the current send round=
: an address several
+     * entries resolve to is probed once, and its rep=
ly is credited to each=2E */
+    struct openvpn_sockaddr *probed;
+    int=
 n_probed;
+};
+
+/* af is an int (not sa_family_t) so callers can pass add=
rinfo::ai_family
+ * directly without a narrowing conversion (-Werror=3Dcon=
version)=2E */
+static int
+probe_af_index(int af)
+{
+    return (af =3D=
=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext SERVE=
R_PROBE packet:
+ *   [opcode | key_id=3D0] [client session id] [SERVER_PRO=
BE message]
+ * This is the unauthenticated OOB wire format; adding tls-aut=
h/tls-crypt
+ * wrapping for the probe is a follow-up (it only works agains=
t a server with
+ * no control-channel wrapping for now)=2E */
+static bool=

+oob_probe_build_packet(struct buffer *buf, const struct session_id *clien=
t_sid)
+{
+    const struct oob_probe_parameter param =3D {
+        =2Etim=
estamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };
+    uint8_t hea=
der =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    return buf_writ=
e_u8(buf, header) && session_id_write(client_sid, buf)
+           && oob_s=
erver_probe_write(buf, &param);
+}
+
+/* The local address and port ce's co=
nnection socket binds: its first --local,
+ * with --lport taking precedenc=
e in client mode, as link_socket_init_phase1()
+ * picks them for socket 0=
=2E */
+static void
+oob_probe_bind_target(const struct connection_entry *c=
e, const struct options *o,
+                      const char **host, const=
 char **port)
+{
+    *host =3D NULL;
+    *port =3D ce->local_port;
+    i=
f (ce->local_list && ce->local_list->len)
+    {
+        *host =3D ce->loc=
al_list->array[0]->local;
+        *port =3D ce->local_list->array[0]->port=
;
+    }
+    if (o->mode =3D=3D MODE_POINT_TO_POINT && ce->local_port_defi=
ned)
+    {
+        *port =3D ce->local_port;
+    }
+}
+
+/* Equal string=
s, or both absent=2E */
+static bool
+str_equal_or_both_null(const char *a,=
 const char *b)
+{
+    return (!a && !b) || (a && b && strcmp(a, b) =3D=3D=
 0);
+}
+
+/* Do a and b bind their connection socket the same way (--bind/=
--nobind,
+ * --local, --lport, --bind ipv6only)? One probe socket set serv=
es all remotes,
+ * so every probed entry must agree with entry 0, whose so=
cket the winner adopts=2E */
+static bool
+oob_probe_same_bind(const struct=
 connection_entry *a, const struct connection_entry *b,
+                  =
  const struct options *o)
+{
+    if (a->bind_local !=3D b->bind_local)
+ =
   {
+        return false;
+    }
+    if (!a->bind_local)
+    {
+       =
 return true;
+    }
+    const char *host_a, *port_a, *host_b, *port_b;
+ =
   oob_probe_bind_target(a, o, &host_a, &port_a);
+    oob_probe_bind_targe=
t(b, o, &host_b, &port_b);
+    return a->bind_ipv6_only =3D=3D b->bind_ipv=
6_only && str_equal_or_both_null(host_a, host_b)
+           && str_equal_o=
r_both_null(port_a, port_b);
+}
+
+/* Resolve the local bind address of ce'=
s connection socket; NULL with --nobind=2E
+ * Fatal on failure, like the l=
ink socket=2E */
+static struct addrinfo *
+oob_probe_bind_addrinfo(const s=
truct connection_entry *ce, const struct options *o)
+{
+    if (!ce->bind_=
local)
+    {
+        return NULL;
+    }
+    const char *host, *port;
+ =
   oob_probe_bind_target(ce, o, &host, &port);
+
+    struct addrinfo *ai =
=3D NULL;
+    const unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_=
ON_SIGNAL | GETADDR_FATAL
+                               | GETADDR_PASSIVE=
 | GETADDR_DATAGRAM;
+    int status =3D openvpn_getaddrinfo(flags, host, p=
ort, 0, NULL, AF_UNSPEC, &ai);
+    if (status !=3D 0)
+    {
+        msg(=
M_FATAL, "getaddrinfo() failed for local \"%s:%s\": %s", host, port,
+     =
       gai_strerror(status));
+    }
+    return ai;
+}
+
+/* Does the addr=
ess list hold an entry of family af? */
+static bool
+addrinfo_has_family(c=
onst struct addrinfo *ai, int af)
+{
+    for (; ai; ai =3D ai->ai_next)
+ =
   {
+        if (ai->ai_family =3D=3D af)
+        {
+            return t=
rue;
+        }
+    }
+    return false;
+}
+
+/* Open the probe socket of=
 each address family in use, set up and bound exactly
+ * as the connection=
 socket (create_socket_udp_configured()), so the winner's
+ * socket can be=
come that connection socket unchanged=2E A family with no --local
+ * addre=
ss to bind is left SOCKET_UNDEFINED and its remotes are not probed, as the
=
+ * connection could not reach them either=2E Returns the number of sockets=
 opened=2E */
+static int
+oob_probe_sockets_open(struct probe_ctx *pc, con=
st bool need[PROBE_AF_COUNT],
+                       struct addrinfo *bind=
_local, const struct connection_entry *ce,
+                       const st=
ruct options *o)
+{
+    static const int families[PROBE_AF_COUNT] =3D { AF=
_INET, AF_INET6 };
+    const struct socket_buffer_size sbs =3D { =2Ercvbuf=
 =3D o->rcvbuf, =2Esndbuf =3D o->sndbuf };
+    int opened =3D 0;
+
+    fo=
r (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if (!need[i])
+   =
     {
+            continue;
+        }
+        if (bind_local && !addrin=
fo_has_family(bind_local, families[i]))
+        {
+            msg(D_LOW, =
"server-probe: no %s address to bind, not probing %s remotes",
+           =
     addr_family_name(families[i]), addr_family_name(families[i]));
+      =
      continue;
+        }
+        pc->sd[i] =3D create_socket_udp_configu=
red((sa_family_t)families[i], o->sockflags, &sbs,
+                        =
                         o->mark, o->bind_dev, bind_local,
+               =
                                  ce->bind_ipv6_only);
+        opened++;
+=
    }
+    return opened;
+}
+
+static void
+oob_probe_sockets_close(struct=
 probe_ctx *pc)
+{
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+=
        if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        {
+            openvp=
n_close_socket(pc->sd[i]);
+            pc->sd[i] =3D SOCKET_UNDEFINED;
+  =
      }
+    }
+}
+
+/* Parse one received datagram as a PROBE_REPLY and, i=
f valid and matching one
+ * of the probes we sent, record the reply in res=
ults=2E */
+static void
+oob_probe_handle_reply(const uint8_t *data, int le=
n, const struct session_id *client_sid,
+                       const struc=
t openvpn_sockaddr *from, const struct oob_probe_target *targets,
+        =
               struct oob_probe_result *results, int n)
+{
+    /* Need at =
least the opcode byte and the session id=2E */
+    if (len < 1 + (int)SID_=
SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
+    {
+        =
return;
+    }
+
+    struct buffer buf;
+    buf_set_read(&buf, data, (siz=
e_t)len);
+    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server ses=
sion id */
+
+    struct oob_probe_reply reply;
+    if (!oob_client_reply_=
read(&buf, &reply))
+    {
+        return;
+    }
+
+    /* Reject spoofed=
 replies: the reply must echo our probe's session id=2E */
+    if (!sessio=
n_id_equal(&reply=2Epeer_session_id, client_sid))
+    {
+        return;
+=
    }
+
+    /* Credit the reply to every still-unanswered remote probed at=
 its source
+     * address: several entries can resolve to the same addres=
s, and each takes
+     * the first reply for it=2E */
+    int i =3D oob_p=
robe_next_target_at(from, targets, results, n, 0);
+    while (i >=3D 0)
+ =
   {
+        results[i]=2Eresponded =3D true;
+        results[i]=2Ereply =
=3D reply;
+
+        i =3D oob_probe_next_target_at(from, targets, results=
, n, i + 1);
+    }
+}
+
+/* Count how many of the probes we sent have been=
 answered so far=2E */
+static int
+oob_count_answered(const struct oob_pro=
be_target *targets, const struct oob_probe_result *results,
+              =
     int n)
+{
+    int answered =3D 0;
+    for (int i =3D 0; i < n; i++)
=
+    {
+        answered +=3D (targets[i]=2Esent && results[i]=2Eresponded)=
 ? 1 : 0;
+    }
+    return answered;
+}
+
+/* Receive replies for one tim=
e slice (until deadline), recording each that
+ * matches a probe we sent=
=2E Returns true if every sent probe has been answered=2E */
+static bool
+=
oob_probe_receive_slice(const struct probe_ctx *pc, const struct timeval *d=
eadline,
+                        const struct session_id *client_sid, cons=
t struct oob_probe_target *targets,
+                        struct oob_pro=
be_result *results, int n, int outstanding)
+{
+    while (true)
+    {
+  =
      struct timeval tnow, timeout;
+        openvpn_gettimeofday(&tnow, NU=
LL);
+        timeout=2Etv_sec =3D deadline->tv_sec - tnow=2Etv_sec;
+     =
   timeout=2Etv_usec =3D deadline->tv_usec - tnow=2Etv_usec;
+        if (t=
imeout=2Etv_usec < 0)
+        {
+            timeout=2Etv_sec -=3D 1;
+   =
         timeout=2Etv_usec +=3D 1000000;
+        }
+        if (timeout=2E=
tv_sec < 0)
+        {
+            return false; /* slice elapsed */
+    =
    }
+
+        fd_set readfds;
+        FD_ZERO(&readfds);
+        socke=
t_descriptor_t maxsd =3D 0;
+        for (int i =3D 0; i < PROBE_AF_COUNT; =
i++)
+        {
+            if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        =
    {
+                openvpn_fd_set(pc->sd[i], &readfds);
+              =
  if (pc->sd[i] > maxsd)
+                {
+                    maxsd =3D =
pc->sd[i];
+                }
+            }
+        }
+        if (openvp=
n_select((int)maxsd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+        {=

+            return false; /* slice timed out, or error */
+        }
+
+ =
       for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            i=
f (pc->sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc->sd[i], &readfds))
+  =
          {
+                continue;
+            }
+            uint8_t =
data[256];
+            struct openvpn_sockaddr from;
+            socklen_=
t fromlen =3D sizeof(from);
+            int len =3D (int)recvfrom(pc->sd[i=
], (char *)data, (int)sizeof(data), 0,
+                                   =
 (struct sockaddr *)&from, &fromlen);
+            if (len > 0)
+          =
  {
+                oob_probe_handle_reply(data, len, client_sid, &from, t=
argets, results, n);
+            }
+        }
+        if (oob_count_answe=
red(targets, results, n) >=3D outstanding)
+        {
+            return t=
rue; /* every probe we sent has been answered */
+        }
+    }
+}
+
+/*=
 Resend the probe to every remote that we probed but that has not answered=
=2E */
+static void
+oob_probe_resend_unanswered(struct probe_ctx *pc, cons=
t struct buffer *probe,
+                            const struct oob_probe=
_target *targets,
+                            const struct oob_probe_resul=
t *results, int n)
+{
+    pc->n_probed =3D 0; /* a new round: probe each u=
nanswered address once again */
+    for (int i =3D 0; i < n; i++)
+    {
+=
        if (!targets[i]=2Esent || results[i]=2Eresponded
+            || oo=
b_addr_list_contains(pc->probed, pc->n_probed, &targets[i]=2Edest))
+      =
  {
+            continue;
+        }
+        socket_descriptor_t sd =3D p=
c->sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
+        =
if (sd !=3D SOCKET_UNDEFINED
+            && sendto(sd, (const char *)BPTR(=
probe), (int)BLEN(probe), 0,
+                      (const struct sockaddr =
*)&targets[i]=2Edest, targets[i]=2Edestlen)
+                   >=3D 0)
+  =
      {
+            pc->probed[pc->n_probed++] =3D targets[i]=2Edest;
+   =
     }
+    }
+}
+
+/* Collect replies over the probe window, resending una=
nswered probes up to
+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe =
carries no retransmission
+ * of its own)=2E The window is split into equal=
 slices, one per send round; after
+ * each slice but the last we resend to=
 whoever has not answered yet=2E Returns
+ * once the window elapses or eve=
ry sent probe has been answered=2E */
+static void
+oob_probe_collect(struc=
t probe_ctx *pc, const struct buffer *probe,
+                  const struc=
t session_id *client_sid, const struct oob_probe_target *targets,
+        =
          struct oob_probe_result *results, int n)
+{
+    /* number of pro=
bes we actually sent: stop early once they all answer */
+    int want =3D =
0;
+    for (int i =3D 0; i < n; i++)
+    {
+        want +=3D targets[i]=
=2Esent ? 1 : 0;
+    }
+
+    const int slices =3D 1 + OOB_PROBE_RETRIES;
=
+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;
+
+    for (int =
slice =3D 0; slice < slices; slice++)
+    {
+        struct timeval deadli=
ne;
+        openvpn_gettimeofday(&deadline, NULL);
+        deadline=2Etv_=
sec +=3D slice_ms / 1000;
+        deadline=2Etv_usec +=3D (slice_ms % 1000=
) * 1000;
+        if (deadline=2Etv_usec >=3D 1000000)
+        {
+       =
     deadline=2Etv_sec +=3D 1;
+            deadline=2Etv_usec -=3D 1000000=
;
+        }
+
+        if (oob_probe_receive_slice(pc, &deadline, client_s=
id, targets, results, n, want))
+        {
+            return; /* all answ=
ered */
+        }
+
+        if (slice + 1 < slices)
+        {
+         =
   oob_probe_resend_unanswered(pc, probe, targets, results, n);
+        }
=
+    }
+}
+
+/* Permute the connection list so entries appear in ranked ord=
er=2E */
+static void
+oob_apply_order(struct connection_list *l, const str=
uct oob_probe_result *ranked,
+                struct gc_arena *gc)
+{
+   =
 struct connection_entry **reordered =3D gc_malloc(sizeof(*reordered) * l->=
len, false, gc);
+    for (int i =3D 0; i < l->len; i++)
+    {
+        re=
ordered[i] =3D l->array[ranked[i]=2Eindex];
+    }
+    memcpy(l->array, re=
ordered, sizeof(*l->array) * l->len);
+}
+
+void
+client_probe_and_order_re=
motes(struct context *c)
+{
+    /* Probe only once, before the first conne=
ction attempt=2E */
+    if (!c->options=2Eserver_probe || !c->first_time)
=
+    {
+        return;
+    }
+
+    struct connection_list *l =3D c->opti=
ons=2Econnection_list;
+    if (!l || l->len <=3D 1)
+    {
+        return=
; /* nothing to choose between */
+    }
+
+    struct gc_arena gc =3D gc_n=
ew();
+
+    /* A single random session id identifies all of our probes; se=
rvers echo it
+     * back in the reply's peer_session_id, letting us rejec=
t spoofed replies=2E */
+    struct session_id client_sid;
+    session_id_=
random(&client_sid);
+
+    /* The probe sockets are set up like the connec=
tion socket of entry 0, which
+     * the winner's socket becomes; probing =
cannot serve entries that bind
+     * differently=2E */
+    for (int i =
=3D 1; i < l->len; i++)
+    {
+        const struct connection_entry *ce =
=3D l->array[i];
+        if (ce->remote && proto_is_udp(ce->proto)
+      =
      && !oob_probe_same_bind(l->array[0], ce, &c->options))
+        {
+  =
          msg(D_LOW, "server-probe: %s:%s binds differently from the first =
remote;"
+                       " not probing, using configured order",
+ =
               ce->remote, ce->remote_port);
+            gc_free(&gc);
+  =
          return;
+        }
+    }
+
+    struct probe_ctx pc =3D { =2Esd =
=3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
+    struct oob_probe_target =
*targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
+    struct o=
ob_probe_result *results =3D gc_malloc(sizeof(*results) * l->len, true, &gc=
);
+
+    struct buffer probe =3D alloc_buf_gc(256, &gc);
+    if (!oob_pro=
be_build_packet(&probe, &client_sid))
+    {
+        msg(D_LOW, "server-pr=
obe: could not build probe packet; using configured order");
+        oob_p=
robe_sockets_close(&pc);
+        gc_free(&gc);
+        return;
+    }
+
+=
    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l-=
>len,
+        OOB_PROBE_WINDOW_MS);
+
+    /* Resolve every remote first, =
so only the address families actually in use
+     * get a probe socket=2E =
*/
+    bool need_af[PROBE_AF_COUNT] =3D { false, false };
+    for (int i =
=3D 0; i < l->len; i++)
+    {
+        results[i]=2Eindex =3D i;
+        =
results[i]=2Eresponded =3D false;
+
+        const struct connection_entry =
*ce =3D l->array[i];
+        if (!ce->remote)
+        {
+            cont=
inue; /* nothing to probe (e=2Eg=2E a connection block with no --remote) */=

+        }
+        if (!proto_is_udp(ce->proto))
+        {
+            =
msg(D_LOW, "server-probe: %s:%s: skipping (not a UDP remote)", ce->remote,
=
+                ce->remote_port);
+            continue;
+        }
+     =
   if (ce->socks_proxy_server)
+        {
+            /* the connection go=
es through the proxy; a direct probe would not */
+            msg(D_LOW, "=
server-probe: %s:%s: skipping (reached through a SOCKS proxy)", ce->remote,=

+                ce->remote_port);
+            continue;
+        }
+
+  =
      /* ce->af honours a udp4/udp6 remote, as the connection does */
+    =
    struct addrinfo *ai =3D NULL;
+        int status =3D openvpn_getaddrin=
fo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+                =
                         ce->remote, ce->remote_port, 0, NULL, ce->af, &ai)=
;
+        if (status !=3D 0 || !ai)
+        {
+            msg(D_LOW, "se=
rver-probe: %s:%s: could not resolve", ce->remote, ce->remote_port);
+     =
       continue;
+        }
+
+        /* Store the first resolved address =
natively (no IPv4-mapping); it is
+         * later probed on its family's =
socket=2E */
+        memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrle=
n);
+        targets[i]=2Edestlen =3D (socklen_t)ai->ai_addrlen;
+        n=
eed_af[probe_af_index(ai->ai_family)] =3D true;
+        freeaddrinfo(ai);
=
+    }
+
+    struct addrinfo *bind_local =3D oob_probe_bind_addrinfo(l->ar=
ray[0], &c->options);
+    if (oob_probe_sockets_open(&pc, need_af, bind_lo=
cal, l->array[0], &c->options) =3D=3D 0)
+    {
+        msg(D_LOW, "server=
-probe: nothing to probe; using configured order");
+        if (bind_local=
)
+        {
+            freeaddrinfo(bind_local);
+        }
+        gc_=
free(&gc);
+        return;
+    }
+
+    /* Send a probe to each resolved =
remote, on the socket of its address family=2E
+     * An address several e=
ntries resolve to is probed once; its reply is
+     * credited to each of =
them=2E */
+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, fa=
lse, &gc);
+    pc=2En_probed =3D 0;
+
+    int sent_count =3D 0;
+    for =
(int i =3D 0; i < l->len; i++)
+    {
+        const struct connection_entr=
y *ce =3D l->array[i];
+        if (!targets[i]=2Edestlen)
+        {
+    =
        continue;
+        }
+        socket_descriptor_t sd =3D pc=2Esd[pr=
obe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
+        if (sd =
=3D=3D SOCKET_UNDEFINED)
+        {
+            continue; /* family not pr=
obed, see oob_probe_sockets_open() */
+        }
+        if (!oob_addr_lis=
t_contains(pc=2Eprobed, pc=2En_probed, &targets[i]=2Edest))
+        {
+   =
         if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
+=
                       (struct sockaddr *)&targets[i]=2Edest, targets[i]=2E=
destlen)
+                < 0)
+            {
+                msg(D_LOW, "=
server-probe: %s:%s: probe send failed", ce->remote, ce->remote_port);
+   =
             continue;
+            }
+            pc=2Eprobed[pc=2En_probe=
d++] =3D targets[i]=2Edest;
+        }
+        targets[i]=2Esent =3D true;=

+        sent_count++;
+    }
+
+    if (sent_count > 0)
+    {
+        o=
ob_probe_collect(&pc, &probe, &client_sid, targets, results, l->len);
+    =
}
+    oob_probe_sockets_close(&pc);
+    if (bind_local)
+    {
+        f=
reeaddrinfo(bind_local);
+    }
+
+    /* Log each remote's outcome while r=
esults[i] still maps to array[i]=2E */
+    int responded =3D 0;
+    for (=
int i =3D 0; i < l->len; i++)
+    {
+        const struct connection_entry=
 *ce =3D l->array[i];
+        if (results[i]=2Eresponded)
+        {
+    =
        responded++;
+            msg(D_LOW, "server-probe: %s:%s answered =
(priority %d, weight %d)", ce->remote,
+                ce->remote_port, re=
sults[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);
+        }
+    =
    else
+        {
+            msg(D_LOW, "server-probe: %s:%s did not an=
swer", ce->remote, ce->remote_port);
+        }
+    }
+
+    /* Rank best-=
first and reorder the connection list accordingly=2E */
+    oob_rank_probe=
_results(results, l->len, c->options=2Eserver_probe_latency_margin, get_ran=
dom, &gc);
+    oob_apply_order(l, results, &gc);
+
+    msg(D_LOW, "server=
-probe: connecting in this order:");
+    for (int i =3D 0; i < l->len; i++=
)
+    {
+        msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, l->array=
[i]->remote,
+            l->array[i]->remote_port);
+    }
+
+    msg(M_IN=
FO, "server-probe: %d of %d remote(s) answered; connecting best-first", res=
ponded,
+        l->len);
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/=
oob_client=2Eh b/src/openvpn/oob_client=2Eh
new file mode 100644
index 0000=
000=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvpn/oob_client=2Eh
@@ -0,0 +1,=
44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *=
             over a single TCP/UDP port, with support for SSL/TLS-based
+ *=
             session authentication and key exchange,
+ *             packe=
t encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
=
+ *  This program is free software; you can redistribute it and/or modify
+=
 *  it under the terms of the GNU General Public License version 2
+ *  as =
published by the Free Software Foundation=2E
+ *
+ *  This program is distr=
ibuted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more deta=
ils=2E
+ *
+ *  You should have received a copy of the GNU General Public L=
icense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/l=
icenses/>=2E
+ */
+
+/**
+ * @file
+ * Client-side server-probe phase: befo=
re connecting, optionally probe all
+ * configured remotes with an out-of-b=
and SERVER_PROBE and order them
+ * best-first, so the connection loop trie=
s the most suitable server first=2E
+ */
+
+#ifndef OOB_CLIENT_H
+#define O=
OB_CLIENT_H
+
+struct context;
+
+/**
+ * Probe all configured remotes and =
reorder the connection list best-first=2E
+ *
+ * Does nothing unless --ser=
ver-probe is enabled=2E On any failure (or if no
+ * server answers), the c=
onfigured remote order is left unchanged and the
+ * normal connection sequ=
ence proceeds=2E
+ */
+void client_probe_and_order_remotes(struct context *=
c);
+
+#endif /* OOB_CLIENT_H */
diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec
index 5f3f4e9=2E=2E8b5afd0 100644
--- a/src/openvpn/op=
tions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -809,6 +809,11 @@
     o->topolo=
gy =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_=
UNSPEC;
+
+    /* The client latency margin is -1 =3D "not set": the client=
's value is
+     * authoritative when given, otherwise each server's adver=
tised margin (or
+     * the built-in default) applies=2E */
+    o->server=
_probe_latency_margin =3D -1;
     o->ce=2Ebind_ipv6_only =3D false;
     o=
->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =
=3D 300;
@@ -5085,6 +5090,21 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
=
         options->mtu_test =3D true;
     }
+    else if (streq(p[0], "serv=
er-probe") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+   =
     options->server_probe =3D true;
+        if (p[1])
+        {
+       =
     int margin =3D positive_atoi(p[1], msglevel);
+            if (margin =
> 0xffff)
+            {
+                msg(msglevel, "--server-probe: ma=
x-latency-diff must be 0 to 65535 ms");
+                goto err;
+       =
     }
+            options->server_probe_latency_margin =3D margin;
+     =
   }
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
    =
     VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/=
src/openvpn/options=2Eh
index f472676=2E=2Ec2cde60 100644
--- a/src/openvpn=
/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -337,6 +337,11 @@
 
     bool=
 mtu_test;
 
+    bool server_probe; /* client: probe remotes (--server-pro=
be) and connect best-first */
+    /* client: default candidate-band margin=
 in ms (--server-probe [max-latency-diff]):
+     * servers within this RTT=
 of the fastest are treated as equally fast */
+    int server_probe_latenc=
y_margin;
+
     bool mlock;
 
     int keepalive_ping; /* a proxy for ping=
/ping-restart */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests=
/unit_tests/openvpn/test_oob=2Ec
index 5af09e8=2E=2E2728825 100644
--- a/te=
sts/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec
@@ -472,6 +472,80 @@
     gc_free(&gc);
 }
 
+static struct openvpn_so=
ckaddr
+v4_addr(uint32_t addr, uint16_t port)
+{
+    struct openvpn_sockad=
dr sa =3D { 0 };
+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+    sa=2Ea=
ddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);
+    sa=2Eaddr=2Ein4=2Esin_p=
ort =3D htons(port);
+    return sa;
+}
+
+static struct oob_probe_target
+=
probe_target(struct openvpn_sockaddr dest, bool sent)
+{
+    return (struc=
t oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2E=
in4), =2Esent =3D sent };
+}
+
+/* Two entries resolving to the same addres=
s are both credited by one reply,
+ * and a second reply from that address =
credits nothing more=2E */
+static void
+test_probe_reply_credits_every_ent=
ry_at_address(void **state)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0=
x7f000001, 1194);
+    struct oob_probe_target targets[2] =3D { probe_targe=
t(a, true), probe_target(a, true) };
+    struct oob_probe_result results[2=
] =3D { 0 };
+
+    int i =3D oob_probe_next_target_at(&a, targets, results=
, 2, 0);
+    assert_int_equal(i, 0);
+    results[i]=2Eresponded =3D true;=

+    i =3D oob_probe_next_target_at(&a, targets, results, 2, i + 1);
+    =
assert_int_equal(i, 1);
+    results[i]=2Eresponded =3D true;
+    assert_i=
nt_equal(oob_probe_next_target_at(&a, targets, results, 2, i + 1), -1);
+
+=
    /* the server's second reply finds nothing left to credit */
+    asser=
t_int_equal(oob_probe_next_target_at(&a, targets, results, 2, 0), -1);
+}
+=

+/* A reply only matches entries probed at its address, and only those act=
ually
+ * sent; a different port is a different address=2E */
+static void
=
+test_probe_reply_matches_only_its_address(void **state)
+{
+    struct ope=
nvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    struct openvpn_sockaddr=
 b =3D v4_addr(0x7f000002, 1194);
+    struct openvpn_sockaddr a_other_port=
 =3D v4_addr(0x7f000001, 1195);
+    struct oob_probe_target targets[3] =3D=
 {
+        probe_target(a, true),
+        probe_target(b, true),
+       =
 probe_target(a, false), /* resolved but never sent */
+    };
+    struct =
oob_probe_result results[3] =3D { 0 };
+
+    assert_int_equal(oob_probe_ne=
xt_target_at(&b, targets, results, 3, 0), 1);
+    assert_int_equal(oob_pro=
be_next_target_at(&b, targets, results, 3, 2), -1);
+    assert_int_equal(o=
ob_probe_next_target_at(&a, targets, results, 3, 0), 0);
+    assert_int_eq=
ual(oob_probe_next_target_at(&a, targets, results, 3, 1), -1);
+    assert_=
int_equal(oob_probe_next_target_at(&a_other_port, targets, results, 3, 0), =
-1);
+}
+
+/* The per-round list of probed addresses compares address and p=
ort=2E */
+static void
+test_addr_list_contains(void **state)
+{
+    struc=
t openvpn_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f000=
002, 1194) };
+    struct openvpn_sockaddr same =3D v4_addr(0x7f000002, 119=
4);
+    struct openvpn_sockaddr other_port =3D v4_addr(0x7f000002, 1195);
=
+    struct openvpn_sockaddr other_host =3D v4_addr(0x7f000003, 1194);
+
+ =
   assert_true(oob_addr_list_contains(list, 2, &same));
+    assert_false(o=
ob_addr_list_contains(list, 2, &other_port));
+    assert_false(oob_addr_li=
st_contains(list, 2, &other_host));
+    assert_false(oob_addr_list_contain=
s(list, 0, &same));
+}
+
 /* A PROBE_REPLY carrying a probe_reply is found =
by the client scan, with all
  * fields surviving=2E */
 static void
@@ -81=
3,6 +887,9 @@
         cmocka_unit_test(test_server_probe_accept_valid),
  =
       cmocka_unit_test(test_server_probe_accept_stale),
         cmocka_un=
it_test(test_server_probe_accept_no_parameter),
+        cmocka_unit_test(t=
est_probe_reply_credits_every_entry_at_address),
+        cmocka_unit_test(=
test_probe_reply_matches_only_its_address),
+        cmocka_unit_test(test_=
addr_list_contains),
         cmocka_unit_test(test_client_reply_read_finds=
_reply),
         cmocka_unit_test(test_client_reply_read_skips_unknown),
 =
        cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f954=
8b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 18
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici=
 <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--CYshZWG8qAw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #18</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Add --server-probe to order client remotes by p=
robe<br><br>With --server-probe [max-latency-diff], before connecting a cli=
ent sends an<br>out-of-band SERVER_PROBE to all configured UDP remotes, col=
lects the PROBE_REPLYs<br>within a short window, and reorders the connectio=
n list so the best-responding<br>server is tried first=2E Unanswered probes=
 are resent once within that window to<br>ride out packet loss=2E The optio=
n is off by default; its optional argument<br>overrides the margin the serv=
er advertises=2E<br><br>The probe phase is self-contained in oob_client=2Ec=
 behind a single call from<br>init=2Ec (before next_connection_entry())=2E =
It opens one UDP socket per address<br>family in use through create_socket_=
udp_configured(), so a probe socket is<br>set up and bound like the connect=
ion socket it may later become (--local,<br>--lport, --bind-dev, --mark), f=
ans probes out and collects replies on them,<br>matches each reply to its r=
emote by source address, and rejects spoofed<br>replies via the session id =
the server echoes back=2E An address several<br>entries resolve to is probe=
d once and its reply credited to each of them=2E<br>Remotes resolve with th=
eir own udp4/udp6 family=2E Probing is declined when<br>connection entries =
bind differently or reach the server through a SOCKS<br>proxy, since one so=
cket set cannot represent both=2E Ranking and reordering<br>use oob_rank_pr=
obe_results()=2E<br><br>For now the probe is sent unwrapped, so it only wor=
ks against a server without<br>tls-auth/tls-crypt (wrapping is a follow-up)=
; only UDP remotes are probed; and<br>probing runs once, before the first c=
onnection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2<br=
>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLis=
ts=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/Makefi=
le=2Eam<br>M src/openvpn/init=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn=
/oob=2Eh<br>A src/openvpn/oob_client=2Ec<br>A src/openvpn/oob_client=2Eh<br=
>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M tests/unit_tes=
ts/openvpn/test_oob=2Ec<br>11 files changed, 857 insertions(+), 0 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/47/1747/18</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMa=
keLists=2Etxt</span><br><span>index fbc69f0=2E=2Eb87f1ef 100644</span><br><=
span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><b=
r><span>@@ -527,6 +527,8 @@</span><br><span>     src/openvpn/occ=2Eh</span>=
<br><span>     src/openvpn/oob=2Ec</span><br><span>     src/openvpn/oob=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=
_client=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/oob_client=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><=
br><span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/open=
vpn_win32_resources=2Erc</span><br><span>diff --git a/doc/man-sections/clie=
nt-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>in=
dex 87c138a=2E=2E0db010e 100644</span><br><span>--- a/doc/man-sections/clie=
nt-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Ers=
t</span><br><span>@@ -595,6 +595,32 @@</span><br><span>   seconds for a res=
ponse before trying the next server=2E The default value</span><br><span>  =
 is :code:`120`=2E This timeout includes proxy and TCP connect timeouts=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--=
server-probe args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Before the first connection attempt, probe all configured UDP remotes</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  out-of-band and reorder=
 the connection list based on the replies=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-pr=
obe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-prob=
e max-latency-diff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A small probe mess=
age is sent to the first resolved address of every UDP</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  remote, and each answering server repl=
ies with its advertised priority</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  and weight=2E Remotes are then reordered following DNS SRV (=
RFC 2782)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  semantic=
s: servers that answered are tried before those that did not,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  grouped by priority (lowest fir=
st); within a priority group, servers are</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  picked by weighted-random selection=2E Round-trip t=
ime is not yet taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  into account, so ``max-latency-diff`` has no effect for now=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  The probe is currently sent without control-ch=
annel wrapping, so it only</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  works against a server configured without ``--tls-auth``,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt`` or ``--tls=
-crypt-v2``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Only UDP remotes are p=
robed=2E Remotes that answered are tried first, in</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  the order described above; all other remot=
es, including TCP ones, follow</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  in their configured order=2E Probing runs once, before the fir=
st connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  atte=
mpt=2E See ``--server-probe-reply`` for the server side=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --static-challenge=
 args</span><br><span>   Enable static challenge/response protocol</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/open=
vpn/Makefile=2Eam</span><br><span>index 5e6b4d9=2E=2Ef8a5835 100644</span><=
br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/=
Makefile=2Eam</span><br><span>@@ -109,6 +109,7 @@</span><br><span> 	pkcs11_=
openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span> 	oob=
=2Ec oob=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob_=
client=2Ec oob_client=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</sp=
an><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2Ec=
 options_show=2Eh \</span><br><span>diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec</span><br><span>index 1109a13=2E=2E1b6372d 100644</span><=
br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><br><span> #include &quot;ssl_=
ncp=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br=
><span> #include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;oob_client=2Eh&quot;</span><br><span> #=
include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&=
quot;</span><br><span> #include &quot;mudp=2Eh&quot;</span><br><span>@@ -44=
46,6 +4447,10 @@</span><br><span>         }</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Pro=
be configured remotes and reorder them best-first (--server-probe);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * no-op otherwise=2E M=
ust run before next_connection_entry() picks a remote=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    client_probe_and_order_remotes(=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     /* Resets all values to the initial values from the config where need=
ed */</span><br><span>     pre_connect_restore(&amp;c-&gt;options, &amp;c-&=
gt;c2=2Egc);</span><br><span> </span><br><span>diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 4c6d13f=2E=2E344f370 10064=
4</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openv=
pn/oob=2Ec</span><br><span>@@ -148,6 +148,33 @@</span><br><span>     return=
 oob_timestamp_in_window(param=2Etimestamp, now, window_secs);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_n=
ext_target_at(const struct openvpn_sockaddr *from, const struct oob_probe_t=
arget *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                     const struct oob_probe_result *results, int n, int sta=
rt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D start; i &lt; n=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Ese=
nt &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr_port_match(from, &amp=
;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_addr_list=
_contains(const struct openvpn_sockaddr *list, int n, const struct openvpn_=
sockaddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (addr_po=
rt_match(&amp;list[i], addr))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base ordering: res=
ponders before non-responders, then by priority (lower</span><br><span>  * =
first), then by RTT (lower first), then by original index for determinism=
=2E</span><br><span>  * This groups responders into priority runs pre-sorte=
d by RTT, which the</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh</span><br><span>index e637b90=2E=2Eb26f3a4 100644</span><br=
><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh<=
/span><br><span>@@ -37,6 +37,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;buffer=2Eh&quot;</span><br><span> #include &quot;session_id=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
ocket_util=2Eh&quot;</span><br><span> </span><br><span> /* OOB message type=
s: the 16-bit value at the start of an OOB payload, before</span><br><span>=
  * its TLV entries=2E Distinct from the TLV-type space (0x2xx); see the &q=
uot;Messages&quot;</span><br><span>@@ -189,6 +190,37 @@</span><br><span>   =
  struct oob_probe_reply reply; /* the values the server advertised */</spa=
n><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* Where the client probed one connection entry=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_target</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr dest;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t destlen;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sent;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fin=
d the next entry, from index @p start on, that was probed at @p from and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * has not answered ye=
t=2E Several entries can resolve to the same address, so a</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * reply is credited to each of them=
: call again with the returned index + 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * until it returns -1=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param from     source address of the reply</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param targets  where each entry wa=
s probed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param r=
esults  per-entry results; entries already marked responded are skipped</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n        numb=
er of entries</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram start    first index to consider</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return the entry index, or -1 if none</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int oob_probe_next_target_at(const struct openvpn_so=
ckaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                       const struct oob_probe_target *targets,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                             con=
st struct oob_probe_result *results, int n, int start);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Is @p addr (address and port) one of the @p n addresses in @p list?</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool oob_addr_list_contains(const struc=
t openvpn_sockaddr *list, int n,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            const struct openvpn_sockaddr *add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /**</span><br><span>  * Order results best-first, in place, per the serve=
r-probe selection policy:</span><br><span>  *   - remotes that responded ra=
nk before those that did not (non-responders keep</span><br><span>diff --gi=
t a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2E75c553d</span><br>=
<span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span>=
<br><span>@@ -0,0 +1,618 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;oob_client=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;session=
_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;socket_util=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;otime=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;fdmisc=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;er=
ror=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;memdbg=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Total time we wait for probe =
replies before giving up and connecting=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OOB_PROBE_WINDOW_MS 1000</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Number of times an unanswered probe is resent within=
 the window, to ride out</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * UDP packet loss=2E With this set to 1, each remote is probed up to =
2 times,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which re=
moves the single-packet-loss false negative; further retries give</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * sharply diminishing return=
s for a low-stakes selection=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define OOB_PROBE_RETRIES 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* The probe uses one socket per address family, each set up and bound =
like the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connecti=
on socket, so every remote is probed on a socket of its own family and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the winning remote&#3=
9;s socket can be reused as its connection socket, presenting</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * the same source IP+port the se=
rver bound its handshake cookie to=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define PROBE_AF_V4    0</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define PROBE_AF_V6    1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define PROBE_AF_COUNT 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct probe_ctx</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is u=
navailable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Addresses probed so far in the current send round: an address several</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * entries resolve t=
o is probed once, and its reply is credited to each=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr *probed;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_probed;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* af is an int (not sa_family_t) so callers can pass addr=
info::ai_family</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * d=
irectly without a narrowing conversion (-Werror=3Dconversion)=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+probe_af_index(int af)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PRO=
BE_AF_V4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Build a plaintext SERVER_PROBE packet:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   [opcode | key_id=3D0=
] [client session id] [SERVER_PROBE message]</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * This is the unauthenticated OOB wire format; ad=
ding tls-auth/tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * wrapping for the probe is a follow-up (it only works against a serve=
r with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * no control=
-channel wrapping for now)=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+oob_probe_build_packet(struct buffer *buf, const struct session_id *cl=
ient_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_p=
arameter param =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OP=
CODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn buf_write_u8(buf, header) &amp;&amp; session_id_write(client_sid, buf)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp=
; oob_server_probe_write(buf, &amp;param);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The local a=
ddress and port ce&#39;s connection socket binds: its first --local,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * with --lport taking pre=
cedence in client mode, as link_socket_init_phase1()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * picks them for socket 0=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_probe_bind_target(const struct c=
onnection_entry *ce, const struct options *o,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                      const char **host, const ch=
ar **port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    *host =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    *port =3D ce-&gt;local_=
port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt=
;local_list &amp;&amp; ce-&gt;local_list-&gt;len)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *host =3D ce-&gt;local_list-&gt;array[0]-&gt;local;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *port =3D c=
e-&gt;local_list-&gt;array[0]-&gt;port;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; ce-&gt;local=
_port_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *port =3D c=
e-&gt;local_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Equal strings, or both absent=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+str_equal_or_both_null(const char *a, con=
st char *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return (!a &amp;&amp; =
!b) || (a &amp;&amp; b &amp;&amp; strcmp(a, b) =3D=3D 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Do a and b bind their connection socket the same way (--bind/--nobind,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --local, --lport,=
 --bind ipv6only)? One probe socket set serves all remotes,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * so every probed entry must agree=
 with entry 0, whose socket the winner adopts=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_probe_same_bind(const struct connection_entry=
 *a, const struct connection_entry *b,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    const struct options *o)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (a-&gt;bind_local !=3D b-&gt;bind_local)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!a-&gt;bind_local)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *host_a, *port_a, *host_b, *port_b;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target(a, o, &amp=
;host_a, &amp;port_a);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    oob_probe_bind_target(b, o, &amp;host_b, &amp;port_b);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return a-&gt;bind_ipv6_only =
=3D=3D b-&gt;bind_ipv6_only &amp;&amp; str_equal_or_both_null(host_a, host_=
b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&=
amp; str_equal_or_both_null(port_a, port_b);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Resolve t=
he local bind address of ce&#39;s connection socket; NULL with --nobind=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fatal on failure,=
 like the link socket=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static struct addrinfo *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+oob_probe_bind_addrinfo(const struct connection_entry *ce, con=
st struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt;=
bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *host, *port;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target(=
ce, o, &amp;host, &amp;port);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIG=
NAL | GETADDR_FATAL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                               | GETADDR_PASSIVE | GETADDR_DATAGRAM;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int status =3D openvpn=
_getaddrinfo(flags, host, port, 0, NULL, AF_UNSPEC, &amp;ai);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;getaddrinfo() fai=
led for local \&quot;%s:%s\&quot;: %s&quot;, host, port,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            gai_strerror(status));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ai;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Does the address list hold an entry of family af? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+addrinfo_has_family(const struct addrinfo *ai, in=
t af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (; ai; ai =3D ai-&gt;ai_=
next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (ai-&gt;ai_family=
 =3D=3D af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Open the probe socket of each address family in use, set up and bound exa=
ctly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as the conne=
ction socket (create_socket_udp_configured()), so the winner&#39;s</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * socket can become that co=
nnection socket unchanged=2E A family with no --local</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * address to bind is left SOCKET_UNDEFIN=
ED and its remotes are not probed, as the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * connection could not reach them either=2E Returns =
the number of sockets opened=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+oob_probe_sockets_open(struct probe_ctx *pc, const bool need[PROBE_AF=
_COUNT],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
            struct addrinfo *bind_local, const struct connection_entry *ce,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
    const struct options *o)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stati=
c const int families[PROBE_AF_COUNT] =3D { AF_INET, AF_INET6 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct socket_buffer_=
size sbs =3D { =2Ercvbuf =3D o-&gt;rcvbuf, =2Esndbuf =3D o-&gt;sndbuf };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int opened =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; PROBE_AF_C=
OUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!need[i])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (bind_local &amp;&amp; !addr=
info_has_family(bind_local, families[i]))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_LOW, &quot;server-probe: no %s address to bin=
d, not probing %s remotes&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                addr_family_name(families[i]), addr_family_nam=
e(families[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pc-=
&gt;sd[i] =3D create_socket_udp_configured((sa_family_t)families[i], o-&gt;=
sockflags, &amp;sbs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                                 o-&gt;mark, o-&gt;bind_de=
v, bind_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                            ce-&gt;bind_ipv6_only);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        opened++;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return opened;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_s=
ockets_close(struct probe_ctx *pc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            openvpn_close_socket(pc-&gt;sd[i=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pc-&=
gt;sd[i] =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Parse one received datagram as a PROBE_REPLY an=
d, if valid and matching one</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * of the probes we sent, record the reply in results=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_reply(const uint8=
_t *data, int len, const struct session_id *client_sid,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                       const struct ope=
nvpn_sockaddr *from, const struct oob_probe_target *targets,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       struct oob_=
probe_result *results, int n)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* N=
eed at least the opcode byte and the session id=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 1 + (int)SID_SIZE || (da=
ta[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_re=
ad(&amp;buf, data, (size_t)len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + serv=
er session id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_r=
eply reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!oob_client_reply_read(&amp;buf, &amp;reply))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reject spoofed rep=
lies: the reply must echo our probe&#39;s session id=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!session_id_equal(&amp;reply=
=2Epeer_session_id, client_sid))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply to every still=
-unanswered remote probed at its source</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * address: several entries can resolve to the same=
 address, and each takes</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * the first reply for it=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int i =3D oob_probe_next_target_at(from, targets, =
results, n, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
while (i &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        result=
s[i]=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        results[i]=2Ereply =3D reply;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        i =3D oob_probe_next_target_at(from, targets, results, n, i +=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Count how many of the probes we sent have been answered so far=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_count_answered(con=
st struct oob_probe_target *targets, const struct oob_probe_result *results=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
 int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int answered =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &l=
t; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        answered +=3D (=
targets[i]=2Esent &amp;&amp; results[i]=2Eresponded) ? 1 : 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return answered;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Recei=
ve replies for one time slice (until deadline), recording each that</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * matches a probe we sent=
=2E Returns true if every sent probe has been answered=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_probe_receive_slice(const struct prob=
e_ctx *pc, const struct timeval *deadline,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        const struct session_id *cli=
ent_sid, const struct oob_probe_target *targets,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        struct oob_probe_resul=
t *results, int n, int outstanding)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while (true)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct time=
val tnow, timeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       openvpn_gettimeofday(&amp;tnow, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        timeout=2Etv_sec =3D deadline-&gt;tv_sec =
- tnow=2Etv_sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     timeout=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (timeout=2Etv_usec=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            timeout=
=2Etv_sec -=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          timeout=2Etv_usec +=3D 1000000;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (timeout=2Etv_sec &lt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return false; /* slice elapsed */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fd_set readfds;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        FD_ZERO(&amp;readfds);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        socket_descriptor_t maxsd =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D =
0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                openvpn_fd_set(pc-&gt;sd[i], &a=
mp;readfds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         if (pc-&gt;sd[i] &gt; maxsd)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    maxsd =3D pc-&gt;sd[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (openvpn_select((int)maxsd + 1, &amp;rea=
dfds, NULL, NULL, &amp;timeout) &lt;=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return false; /* slice timed out, or error */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (pc-&gt;sd[i] =
=3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;readfds))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            uint8_t data[256];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct openv=
pn_sockaddr from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          socklen_t fromlen =3D sizeof(from);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            int len =3D (int)recvfrom(pc-&gt;sd[i=
], (char *)data, (int)sizeof(data), 0,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                    (struct sockaddr *)&=
amp;from, &amp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (len &gt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                oob_probe_handle_reply(data, len, client_sid, &amp;f=
rom, targets, results, n);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (oob_count_answered(targets, results, n) &gt;=3D outstanding)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return true; /* every probe w=
e sent has been answered */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Resend the probe to every remote that we probed bu=
t that has not answered=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buffer *pr=
obe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             const struct oob_probe_target *targets,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            const struct =
oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
pc-&gt;n_probed =3D 0; /* a new round: probe each unanswered address once a=
gain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int=
 i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!targets[i]=2Esent || results[i]=2Eresponded</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            || oob_addr_list_contains(pc-&gt;pr=
obed, pc-&gt;n_probed, &amp;targets[i]=2Edest))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            continue;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(targe=
ts[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (sd !=3D SOCKET_UNDEFINED</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; sendto(sd, (con=
st char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      (const struct sockaddr *)&amp=
;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            pc-&gt;probed[pc-&gt;n_probed++] =3D ta=
rgets[i]=2Edest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Collect replies over the probe window, resending unanswered p=
robes up to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB_P=
ROBE_RETRIES times (UDP is lossy and a probe carries no retransmission</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of its own)=2E The wi=
ndow is split into equal slices, one per send round; after</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * each slice but the last we resend=
 to whoever has not answered yet=2E Returns</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * once the window elapses or every sent probe has =
been answered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_prob=
e_collect(struct probe_ctx *pc, const struct buffer *probe,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                  const struct sess=
ion_id *client_sid, const struct oob_probe_target *targets,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                  struct oob_probe_=
result *results, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* number =
of probes we actually sent: stop early once they all answer */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int want =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        want +=3D targets[i]=
=2Esent ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const int slices =3D 1 + OOB_PRO=
BE_RETRIES;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (int slice =3D 0; slice &lt; slices; slice++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct timeval deadline;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&a=
mp;deadline, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        deadline=2Etv_sec +=3D slice_ms / 1000;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        deadline=2Etv_usec +=3D (slice_ms % 100=
0) * 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (deadline=2Etv_usec &gt;=3D 1000000)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            deadline=2Etv_sec +=3D 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            deadline=2Etv_usec -=3D 1000000;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (oob_probe_receive_slice(pc, &amp;deadlin=
e, client_sid, targets, results, n, want))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return; /* all answered */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (slice + 1 &lt; slices)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            oob_probe_resend_unanswered(pc, probe, targets, resul=
ts, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Permute the connection list so entries appear in ranked order=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+oob_apply_order(struct connect=
ion_list *l, const struct oob_probe_result *ranked,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct connection_entry **reordered =
=3D gc_malloc(sizeof(*reordered) * l-&gt;len, false, gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;le=
n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        reordered[i] =3D l=
-&gt;array[ranked[i]=2Eindex];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 memcpy(l-&gt;array, reordered, sizeof(*l-&gt;array) * l-&gt;len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clien=
t_probe_and_order_remotes(struct context *c)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Probe only once, before the first connection attempt=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=
=2Eserver_probe || !c-&gt;first_time)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct connection_list *l =3D=
 c-&gt;options=2Econnection_list;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!l || l-&gt;len &lt;=3D 1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return; /* nothing to choose between */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* A single random session id identifies all of our probes; ser=
vers echo it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
back in the reply&#39;s peer_session_id, letting us reject spoofed replies=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct se=
ssion_id client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    session_id_random(&amp;client_sid);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* The probe sockets are set up like the connection socket of entry 0=
, which</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the w=
inner&#39;s socket becomes; probing cannot serve entries that bind</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * differently=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 1; i=
 &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t struct connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (ce-&gt;remote &amp;&amp; proto_is=
_udp(ce-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &amp;&amp; !oob_probe_same_bind(l-&gt;array[0], ce, &amp;c-&gt;o=
ptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW=
, &quot;server-probe: %s:%s binds differently from the first remote;&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
   &quot; not probing, using configured order&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&gt;rem=
ote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct probe_ctx pc =3D { =2Esd =3D {=
 SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_target *targets =3D gc_malloc(siz=
eof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct oob_probe_result *results =3D gc_malloc(s=
izeof(*results) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_build_packet(&=
amp;probe, &amp;client_sid))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(D_LOW, &quot;server-probe: could not build probe packet; using confi=
gured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_LOW, &quot;server-probe: probing %d remote(s) with a %d ms window&quot;, l=
-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OO=
B_PROBE_WINDOW_MS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Resolve ever=
y remote first, so only the address families actually in use</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * get a probe socket=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool need_af[PROBE=
_AF_COUNT] =3D { false, false };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        results[i]=2Eindex =3D i;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eresponded =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const struct connection_en=
try *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!ce-&gt;remote)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            continue; /* nothing to probe (e=2Eg=2E a connection bloc=
k with no --remote) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!proto_is_udp(ce-&gt;proto))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(D_LOW, &quot;server-probe: %s:%s: skipping (not a UDP r=
emote)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                ce-&gt;remote_port);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (ce-&gt;socks_proxy_server)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* the connection goes through the p=
roxy; a direct probe would not */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: skipping (r=
eached through a SOCKS proxy)&quot;, ce-&gt;remote,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_port);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* ce-&gt;af honours a udp4/udp6 remote, as=
 the connection does */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct addrinfo *ai =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int status =3D openvpn_getaddrinfo(GETADDR_RE=
SOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                         ce-&gt;re=
mote, ce-&gt;remote_port, 0, NULL, ce-&gt;af, &amp;ai);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (status !=3D 0 || !ai)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server=
-probe: %s:%s: could not resolve&quot;, ce-&gt;remote, ce-&gt;remote_port);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* Store the first resolved address na=
tively (no IPv4-mapping); it is</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * later probed on its family&#39;s socket=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;target=
s[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        targets[i]=2Edestlen =3D (socklen_t)ai=
-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     need_af[probe_af_index(ai-&gt;ai_family)] =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct addrinfo *bind_local =3D oob_probe_bind_addrinfo(l-&gt=
;array[0], &amp;c-&gt;options);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (oob_probe_sockets_open(&amp;pc, need_af, bind_local, l-=
&gt;array[0], &amp;c-&gt;options) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_LOW, &quot;server-probe: nothing to probe; using co=
nfigured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (bind_local)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send a probe to eac=
h resolved remote, on the socket of its address family=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * An address several entries res=
olve to is probed once; its reply is</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * credited to each of them=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=
=2Eprobed) * l-&gt;len, false, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    pc=2En_probed =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int sent_count =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt=
;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock=
et_descriptor_t sd =3D pc=2Esd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=
=2Esa_family)];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            continue; /* family not probed, see oob_probe_sockets_ope=
n() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_addr_l=
ist_contains(pc=2Eprobed, pc=2En_probed, &amp;targets[i]=2Edest))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (sendto(sd, (const char =
*)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                       (struct sockaddr *)&amp;ta=
rgets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                msg(D_LOW, &quot;server-probe: %s:%s: prob=
e send failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            pc=2Eprobed[pc=2En_probed+=
+] =3D targets[i]=2Edest;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    targets[i]=2Esent =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        sent_count++;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sent_count =
&gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_collect(=
&amp;pc, &amp;probe, &amp;client_sid, targets, results, l-&gt;len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind_local)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(bind_local);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Log each remote&#39;s outcome while results[i] st=
ill maps to array[i]=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int responded =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt;=
array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (results[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        responded++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_LOW, &quot;server-probe: %s:%s answered (priority %d, we=
ight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                ce-&gt;remote_port, results[i]=2Ereply=2Epriorit=
y, results[i]=2Ereply=2Eweight);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(D_LOW, &quot;server-probe: %s:%s did not answer&quot;, ce-&gt;remote, ce-=
&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Rank best-first and reorder the connec=
tion list accordingly=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    oob_rank_probe_results(results, l-&gt;len, c-&gt;options=2Eserv=
er_probe_latency_margin, get_random, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    oob_apply_order(l, results, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: connecting=
 in this order:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_LOW, &quot;server-probe:   %d=2E %s:%s&quot;, =
i + 1, l-&gt;array[i]-&gt;remote,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            l-&gt;array[i]-&gt;remote_port);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(M_INFO, &quot;server-probe: %d of %d remote(s) answered; conn=
ecting best-first&quot;, responded,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        l-&gt;len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span>diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_=
client=2Eh</span><br><span>new file mode 100644</span><br><span>index 00000=
00=2E=2Eac44cdb</span><br><span>--- /dev/null</span><br><span>+++ b/src/ope=
nvpn/oob_client=2Eh</span><br><span>@@ -0,0 +1,44 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN =
Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  T=
his program is free software; you can redistribute it and/or modify</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of t=
he GNU General Public License version 2</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the h=
ope that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Client-side server-probe phase: before connecting=
, optionally probe all</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * configured remotes with an out-of-band SERVER_PROBE and order them</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * best-first, so the =
connection loop tries the most suitable server first=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef OOB_CLIENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define OOB_CLIENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct context;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Probe all configured remotes and reorder the connect=
ion list best-first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Does nothin=
g unless --server-probe is enabled=2E On any failure (or if no</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * server answers), the configur=
ed remote order is left unchanged and the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * normal connection sequence proceeds=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void client_probe_and_order_remotes(struct cont=
ext *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_CLIENT_H */</spa=
n><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec<=
/span><br><span>index 5f3f4e9=2E=2E8b5afd0 100644</span><br><span>--- a/src=
/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><b=
r><span>@@ -809,6 +809,11 @@</span><br><span>     o-&gt;topology =3D TOP_UN=
DEF;</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span> =
    o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 The client latency margin is -1 =3D &quot;not set&quot;: the client&#39;s =
value is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * auth=
oritative when given, otherwise each server&#39;s advertised margin (or</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the built-in def=
ault) applies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o-&gt;server_probe_latency_margin =3D -1;</span><br><span>     o-&gt;ce=
=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_=
seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =
=3D 300;</span><br><span>@@ -5085,6 +5090,21 @@</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;mtu_te=
st =3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (streq(p[0], &quot;server-probe&quot;) &amp;&am=
p; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSIO=
N(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;server_probe =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (p[1])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            int margin =3D positive_atoi(p[1], msglevel);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (margin &gt; =
0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(msglevel, &quot;--server-probe: max-latency-diff must be 0 to 65535 ms&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            op=
tions-&gt;server_probe_latency_margin =3D margin;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;n=
ice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><=
br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git=
 a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index =
f472676=2E=2Ec2cde60 100644</span><br><span>--- a/src/openvpn/options=2Eh</=
span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -337,6 +337=
,11 @@</span><br><span> </span><br><span>     bool mtu_test;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server_=
probe; /* client: probe remotes (--server-probe) and connect best-first */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* client: defau=
lt candidate-band margin in ms (--server-probe [max-latency-diff]):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * servers within this =
RTT of the fastest are treated as equally fast */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int server_probe_latency_margin;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool m=
lock;</span><br><span> </span><br><span>     int keepalive_ping; /* a proxy=
 for ping/ping-restart */</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>i=
ndex 5af09e8=2E=2E2728825 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>@@ -472,6 +472,80 @@</span><br><span>     gc_free(&amp=
;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static struct openvpn_sockaddr</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+v4_addr(uint32_t addr, uint16_t port)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr sa =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=
=2Esin_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sa=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_port =
=3D htons(port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static struct oob_probe_target</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+probe_target(struct openvpn_sockad=
dr dest, bool sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (struct=
 oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ei=
n4), =2Esent =3D sent };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Two entries resolving to the =
same address are both credited by one reply,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * and a second reply from that address credits no=
thing more=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_=
reply_credits_every_entry_at_address(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
target targets[2] =3D { probe_target(a, true), probe_target(a, true) };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_re=
sult results[2] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =
=3D oob_probe_next_target_at(&amp;a, targets, results, 2, 0);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(i, 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    results[i]=2Eresponde=
d =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =
=3D oob_probe_next_target_at(&amp;a, targets, results, 2, i + 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(i, 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    results[i]=2Eresp=
onded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(oob_probe_next_target_at(&amp;a, targets, results, 2, i + =
1), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* the server&#39;s second=
 reply finds nothing left to credit */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, ta=
rgets, results, 2, 0), -1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* A reply only matches entri=
es probed at its address, and only those actually</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * sent; a different port is a different addr=
ess=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_m=
atches_only_its_address(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr b =3D =
v4_addr(0x7f000002, 1194);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 119=
5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_p=
robe_target targets[3] =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        probe_target(a, true),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        probe_target(b, true),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        probe_target(a, false), /* resolved =
but never sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_result results[3] =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(oob_probe_next_target_at(&amp;b, targets, results, 3, 0), =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(oob_probe_next_target_at(&amp;b, targets, results, 3, 2), -1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_pr=
obe_next_target_at(&amp;a, targets, results, 3, 0), 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_tar=
get_at(&amp;a, targets, results, 3, 1), -1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp=
;a_other_port, targets, results, 3, 0), -1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The per-r=
ound list of probed addresses compares address and port=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_addr_list_contains(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr list[2] =3D {=
 v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr same =3D v=
4_addr(0x7f000002, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct openvpn_sockaddr other_port =3D v4_addr(0x7f000002, 1195);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_=
sockaddr other_host =3D v4_addr(0x7f000003, 1194);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(oob_addr_list_contains(list, 2, &amp;same));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_a=
ddr_list_contains(list, 2, &amp;other_port));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(oob_addr_list_contains(list, 2, =
&amp;other_host));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(oob_addr_list_contains(list, 0, &amp;same));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /* A PROBE_REPLY carrying a probe_=
reply is found by the client scan, with all</span><br><span>  * fields surv=
iving=2E */</span><br><span> static void</span><br><span>@@ -813,6 +887,9 @=
@</span><br><span>         cmocka_unit_test(test_server_probe_accept_valid)=
,</span><br><span>         cmocka_unit_test(test_server_probe_accept_stale)=
,</span><br><span>         cmocka_unit_test(test_server_probe_accept_no_par=
ameter),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_probe_reply_credits_every_entry_at_address),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_p=
robe_reply_matches_only_its_address),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_addr_list_contains),</span>=
<br><span>         cmocka_unit_test(test_client_reply_read_finds_reply),</s=
pan><br><span>         cmocka_unit_test(test_client_reply_read_skips_unknow=
n),</span><br><span>         cmocka_unit_test(test_client_reply_read_reject=
s_unknown_mandatory),</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change=
 1747</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>

</body></html>
--CYshZWG8qAw=--


--===============1041325090005469133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1041325090005469133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1041325090005469133==--


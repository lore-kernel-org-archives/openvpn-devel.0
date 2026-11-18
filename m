Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B647606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PLssyN+J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B5smRkON;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IsmAgI5y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Jf5tvTrI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vTWuMroLKWD2Nc5rzjruUI7tDMAk0LrmceqUNS/J9f0=; b=PLssyN+JBpeHReojdeYB7jvC4l
	dFnmq/DONOYZOpUi0poyX99Gs7T/xDfntEiuyYXv0sleAm9BiEAA5kBe7hVJq4eJ369/U3LmxKKQ6
	+t5ouAjZGRG/992fpWleA6CJDUEJCQkBcdtvySawzvpWZj/peDPfEHLhQpjdVtNwzdj4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdQ3-000000003RL-0E8r;
	Wed, 18 Nov 2026 11:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTdQ1-000000003RE-1tvr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X/B0/NyRA2Ol4QqEng+9aTKDckd1MfUxBS7k92k4FoY=; b=B5smRkONr8uazwqBcjTKhEaEia
 66iggRs6ZRliZa4kJCJ6cYwAyPKRsgpYbur+RG8YJ+IoNdH1qHOSYCQB8E0B4PTL7H8s/uWh0kKSA
 a1pz30iBMbNID2cVT6hSuWvqbTfiEGXB+x7pyOsKgPHp2mCLknjMZWizw79aprNow5uA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X/B0/NyRA2Ol4QqEng+9aTKDckd1MfUxBS7k92k4FoY=; b=IsmAgI5y9AblGOOFFPVMQ7ZNbv
 dBJ+EnUYMvCKRv0BAD6Ru+UI/bZiZbM0RLp1ZLS/oW6nAay0Hs4Zwj5FrH6Eon0OM2EmqqkVMhLxU
 uwt2iy1j+Y1OuqT1gPBbdfyPsXScZwPHQigNEH9gCRZzK4KkXPtUQ6wI2j42/rkdpHMw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTdPz-000000004WH-2cav for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:01:37 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so8556285e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794999689; x=1795604489; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X/B0/NyRA2Ol4QqEng+9aTKDckd1MfUxBS7k92k4FoY=;
 b=Jf5tvTrIPC+8w3j6U7XaUgo6ic4DhYaE4O3/nk74Ubyy9cDbBtyBvzrLb8YUjE8v54
 vZei39/UECSgs9pN142UlJQb67FxkrJmsXDclyEM2ae7vUe9Moe3DQi0mK6P0clfdIt2
 uy2FN0Jmeapj763T4dLKcg/BtDzOGKhYa1Bk8bRruL3zvl4n1sr6RY7JpmSTx385aQC/
 Hd12oh0LijpKh5eNpWUg2vC358YvyuT0LZLEJVK6q5DoD4LHXIPk64FqR3ltwT5SRYvV
 evMz0k5hjZL1sUfAeRxrFt+Y0VoBah2hqJMgl66/EkTo77ow4bFdpkLmlo4CTSz4A+vS
 QZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794999689; x=1795604489;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X/B0/NyRA2Ol4QqEng+9aTKDckd1MfUxBS7k92k4FoY=;
 b=ejjLYoW6q2f1m+EHKfecBJVn2SfOf9gTWyCqZRM9XPIG5bknEZfqQ9F3/8W1iJsKit
 sh9n9cLCyd36znAlqm4N/NJO4HawHH947YdH+dCWB0q0UmqztOln/wcMtr2HksF+swcJ
 NaJVImq1iWREZU2grkOdKSOSsq6RurdPPBu5S+FIBtz8t8ghyORpYQz3A9f9IIG/Q3ln
 4SYs2W4bqWZJZ19zRpP6uN5XADGb1Z0SxdfXQkyPiRUQoRTxt116TPquEPp8M98iIEl/
 9AR8cEZwffUIOWlpyIKPPKGc2mhxIPgNMOrh9Tpoe4txOdWj6mlvXp9toND/BAN2nB11
 YlCQ==
X-Gm-Message-State: APuU4Z896tAKoF90vLOu+yIhWWm5dnv9XXpEIvz/E2JjPX+43pUKqp6D
 vgGT5ZI3jtOR+ovkrfTPuJsyIbyY1ltsL9YND4qk1pdyTbLXEIxo949AVaubZgp7ANX6J5tC+h0
 uXdvX1rQYmV+hzkAW7E6v6jxV/uYQ0Nmw2nldFENd1Y/x1CzICv5VAYjrChAAMYX1rZArcpCr2P
 /en71QQQ==
X-Gm-Gg: AYBFou28BRrG/2c2++A/UqXwmNqQYy3SeThjugZ9wb7wz4LFoXdfgwFf/yTbiBzxmeh
 NNJq5OnUhirN9dVRptkbwj7brMa9o0vWoP2Mfe7Tz7kIiOG38C948jE3qYdR4S7duMC7l4bz+E4
 eFvDh3NymphTsTuIFstP4TbaSdMccDnato+viLHb+uMnAaj4g6Il+aGNry0nLlOgt7gmceiRqlr
 XpksQjMNSkpPbs1TbYc7szGMGDOwqiSHS1fnFcw6rAKcg5A4S8ZxVK2l0SBdIMm72plfPfj0bfP
 q0FWB4WVBt1CWsNvciTMjxNAy5XP7CfX3MrEMg24LMfGDO6sO750sQvOZ2Re5l4XOyuzKlmcw8K
 wQ56jcFyhGbmk/cUADUuxNJUO55WcIlHLQxh94KEL8fTV9p8M978HAF24VXLI4UQoPK+MO4lGZO
 bbJ04s2aziPFB+Bps8mhL9CkNr4QY8AeLTkPm64f2Mtr9EUN5R+sghiUeHCC8rcqgo90g0Zbgx6
 xXUam7gCnH33rYkWmj+c46VdxyMuAgPS3lqba2i0pLFskQvI062Fko4xBSLn8ybCmMQ+OqxJBni
 U18rEAB5L0W9yjSKn/i9xgs5ablaF9sZSbmipCfZmnbwil/idWO7Buyn2qcN+BFd//koFyfipPS
 HyvAVbuYdElma1gCdwKGN4iOTdA3R5s0Rnq284kQP5A2YRRBtqrhSkHKZgbZ6sssVw/sVOCyaMO
 WIMcywPsoZ3Wt2HaY=
X-Received: by 2002:a05:600c:354b:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4bb7da3a1bcmr38457235e9.26.1794999688720; 
 Wed, 18 Nov 2026 03:01:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2b8032sm58466935e9.10.2026.11.18.03.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:01:28 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 11:01:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: 3c042b1a83e5b23c394dec93018c80b9fcceea52
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ae56ea02500a2fe816f22c3bcfcc2f83b58d66e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTdPz-000000004WH-2cav
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: raise the
 open files limit for --max-clients
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5943286422999488249=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5943286422999488249==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KeWPLyRBzRM="; charset=UTF-8

--KeWPLyRBzRM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Gianmarco=
 De Gregori=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2211?usp=3Demail

to look at the new patch set (#3)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Gert Doering


Change=
 subject: multi: raise the open files limit for --max-clients
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: raise the open fil=
es limit for --max-clients

Every TCP client takes a file descriptor and ac=
cept() happens before the
--max-clients check, so with the default limits (=
soft limit 1024,
--max-clients 1024) the server runs out of descriptors bef=
ore it can
refuse a client=2E

When the server has a TCP listener, raise th=
e soft limit to
--max-clients plus some room for the other descriptors, up =
to the hard
limit, and warn if that is not enough=2E Processes started by O=
penVPN
inherit the new limit=2E

Not on macOS, where the event loop uses se=
lect() and cannot watch
descriptors >=3D FD_SETSIZE=2E

GitHub: closes Open=
VPN/openvpn#1148
Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
Signe=
d-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M doc/man-se=
ctions/server-options=2Erst
M src/openvpn/multi=2Ec
2 files changed, 66 ins=
ertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/11/2211/3

diff --git a/doc/man-sections/server-option=
s=2Erst b/doc/man-sections/server-options=2Erst
index 7a09809=2E=2E5c1b129 =
100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/s=
erver-options=2Erst
@@ -418,6 +418,9 @@
 --max-clients n
   Limit server to=
 a maximum of ``n`` concurrent clients=2E Defaults to 1024=2E
 
+  With a T=
CP listener, the soft limit on open files is raised up to the hard
+  limit=
 if needed to accept ``n`` clients (not on Windows and macOS)=2E
+
 --max-r=
outes-per-client n
   Allow a maximum of ``n`` internal routes per client (=
default
   :code:`256`)=2E This is designed to help contain DoS attacks whe=
re an
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index ad9f=
9f4=2E=2E900b5a3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -270,6 +270,68 @@
 #endif
 
 /*
+ * Every TCP client takes a file d=
escriptor, and accept() happens before the
+ * --max-clients check: raise t=
he soft limit so that --max-clients is reached
+ * first, or warn if the ha=
rd limit does not allow it=2E
+ */
+static void
+multi_check_nofile_limit(c=
onst struct context *t)
+{
+#if defined(HAVE_GETRLIMIT) && defined(RLIMIT_N=
OFILE) && !defined(TARGET_DARWIN)
+    bool tcp =3D false;
+    for (int i =
=3D 0; i < t->c1=2Elink_sockets_num; i++)
+    {
+        if (!proto_is_dgr=
am(t->c2=2Elink_sockets[i]->info=2Eproto))
+        {
+            tcp =3D =
true;
+            break;
+        }
+    }
+    if (!tcp)
+    {
+        =
return;
+    }
+
+    /* room for the tun device, the listeners, log, manag=
ement, scripts=2E=2E=2E */
+    const rlim_t needed =3D (rlim_t)t->options=
=2Emax_clients + 64;
+
+    struct rlimit rl;
+    if (getrlimit(RLIMIT_NOF=
ILE, &rl) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RL=
IMIT_NOFILE) failed");
+        return;
+    }
+    if (rl=2Erlim_cur >=3D =
needed)
+    {
+        return;
+    }
+
+    const rlim_t old =3D rl=2Erli=
m_cur;
+    rl=2Erlim_cur =3D rl=2Erlim_max < needed ? rl=2Erlim_max : need=
ed;
+    if (rl=2Erlim_cur > old)
+    {
+        if (setrlimit(RLIMIT_NOFI=
LE, &rl) =3D=3D 0)
+        {
+            msg(M_INFO, "NOTE: raised the op=
en files limit from %lu to %lu", (unsigned long)old,
+                (unsi=
gned long)rl=2Erlim_cur);
+        }
+        else
+        {
+            =
msg(M_WARN | M_ERRNO, "WARNING: setrlimit(RLIMIT_NOFILE) failed");
+       =
     rl=2Erlim_cur =3D old;
+        }
+    }
+    if (rl=2Erlim_cur < need=
ed)
+    {
+        msg(M_WARN,
+            "WARNING: the open files limit=
 (soft %lu, hard %lu) is too low for "
+            "--max-clients %" PRIu3=
2 ", TCP clients may be refused before --max-clients is reached",
+        =
    (unsigned long)rl=2Erlim_cur, (unsigned long)rl=2Erlim_max, t->options=
=2Emax_clients);
+    }
+#endif /* if defined(HAVE_GETRLIMIT) && defined(RL=
IMIT_NOFILE) && !defined(TARGET_DARWIN) */
+}
+
+/*
  * Main initialization=
 function, init multi_context object=2E
  */
 static void
@@ -398,6 +460,7 =
@@
      * Per-client limits
      */
     m->max_clients =3D t->options=2E=
max_clients;
+    multi_check_nofile_limit(t);
 
     m->instances =3D call=
oc(m->max_clients, sizeof(struct multi_instance *));
     check_malloc_retu=
rn(m->instances);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2211?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
Gerrit-Change-Number: 2211
Ger=
rit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--KeWPLyRBzRM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Gianmarco De Gregori=2E <=
/p>
<p>Gianmarco De Gregori <strong>uploaded patch set #3</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">multi: raise =
the open files limit for --max-clients<br><br>Every TCP client takes a file=
 descriptor and accept() happens before the<br>--max-clients check, so with=
 the default limits (soft limit 1024,<br>--max-clients 1024) the server run=
s out of descriptors before it can<br>refuse a client=2E<br><br>When the se=
rver has a TCP listener, raise the soft limit to<br>--max-clients plus some=
 room for the other descriptors, up to the hard<br>limit, and warn if that =
is not enough=2E Processes started by OpenVPN<br>inherit the new limit=2E<b=
r><br>Not on macOS, where the event loop uses select() and cannot watch<br>=
descriptors &gt;=3D FD_SETSIZE=2E<br><br>GitHub: closes OpenVPN/openvpn#114=
8<br>Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2<br>Signed-off-by:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M doc/man=
-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec<br>2 files change=
d, 66 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/2211/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-op=
tions=2Erst</span><br><span>index 7a09809=2E=2E5c1b129 100644</span><br><sp=
an>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc/ma=
n-sections/server-options=2Erst</span><br><span>@@ -418,6 +418,9 @@</span><=
br><span> --max-clients n</span><br><span>   Limit server to a maximum of `=
`n`` concurrent clients=2E Defaults to 1024=2E</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  With a TCP listener, the sof=
t limit on open files is raised up to the hard</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  limit if needed to accept ``n`` clients (not o=
n Windows and macOS)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> --max-routes-per-client n</span><br><span>   Allow a =
maximum of ``n`` internal routes per client (default</span><br><span>   :co=
de:`256`)=2E This is designed to help contain DoS attacks where an</span><b=
r><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><b=
r><span>index ad9f9f4=2E=2E900b5a3 100644</span><br><span>--- a/src/openvpn=
/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -=
270,6 +270,68 @@</span><br><span> #endif</span><br><span> </span><br><span>=
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Every TCP cli=
ent takes a file descriptor, and accept() happens before the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * --max-clients check: raise the =
soft limit so that --max-clients is reached</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * first, or warn if the hard limit does not allow =
it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_check_nofile_limit(const struct =
context *t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_GETRLIMIT=
) &amp;&amp; defined(RLIMIT_NOFILE) &amp;&amp; !defined(TARGET_DARWIN)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tcp =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0=
; i &lt; t-&gt;c1=2Elink_sockets_num; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!proto_is_dgram(t-&gt;c2=2Elink_sockets[i]-&gt;info=2E=
proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            tcp =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!tcp)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* room for the tun=
 device, the listeners, log, management, scripts=2E=2E=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const rlim_t needed =3D (rlim_=
t)t-&gt;options=2Emax_clients + 64;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct rlimit rl;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (getrlimit(RLIMIT_NOFILE, &amp;rl) &lt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;WARNING: getrlimit(RLIMI=
T_NOFILE) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl=2E=
rlim_cur &gt;=3D needed)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const rlim_t old =3D rl=2Erlim_cur;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rl=2Erlim_cur =3D rl=
=2Erlim_max &lt; needed ? rl=2Erlim_max : needed;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &gt; old)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (setrlimit(RLIMIT_NOFILE, &amp;rl) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_IN=
FO, &quot;NOTE: raised the open files limit from %lu to %lu&quot;, (unsigne=
d long)old,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        (unsigned long)rl=2Erlim_cur);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_WARN | M_ERRNO, &quot;WARNING: setrlimit(RLIMIT_NOFILE) failed&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            rl=
=2Erlim_cur =3D old;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &=
lt; needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WARN=
ING: the open files limit (soft %lu, hard %lu) is too low for &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;--max-cl=
ients %&quot; PRIu32 &quot;, TCP clients may be refused before --max-client=
s is reached&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            (unsigned long)rl=2Erlim_cur, (unsigned long)rl=2Erlim_max, t-&=
gt;options=2Emax_clients);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif =
/* if defined(HAVE_GETRLIMIT) &amp;&amp; defined(RLIMIT_NOFILE) &amp;&amp; =
!defined(TARGET_DARWIN) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Main in=
itialization function, init multi_context object=2E</span><br><span>  */</s=
pan><br><span> static void</span><br><span>@@ -398,6 +460,7 @@</span><br><s=
pan>      * Per-client limits</span><br><span>      */</span><br><span>    =
 m-&gt;max_clients =3D t-&gt;options=2Emax_clients;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_check_nofile_limit(t);</span><b=
r><span> </span><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients=
, sizeof(struct multi_instance *));</span><br><span>     check_malloc_retur=
n(m-&gt;instances);</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">change 2211</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I17fafbe65fd=
3ff510a72ed809c85b0d19343fad2 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2211 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gianmarco=
 De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</body></html>
--KeWPLyRBzRM=--


--===============5943286422999488249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5943286422999488249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5943286422999488249==--


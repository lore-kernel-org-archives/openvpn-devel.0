Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5B606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FclftSiL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NXTGlPVF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PoHVtuzt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bXA5MVNq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NeQfzueby2iJ/xd1K5NdcyLEDqweeuycBR0ho4mH20k=; b=FclftSiLAAAVCs54d+Im4SVzhQ
	f9CwuRXPtXY/AtVXoPiQZV/ZDdVT34c/PlgGpzkRQSMxQUDZZmmSHSqlujBk9BiAv91kCX/ZUBQop
	voom/xAL7RojN/bkMyslsxIblviOadNU/gYO6FRFViXtVp2RX/oTAkAepW0Ty8+BO3uU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5qS-000000000TO-0wIr;
	Sun, 22 Nov 2026 11:34:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5qQ-000000000TG-05iO
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:34:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OyZzslxpO2pn8/8MY4qGkQO2Q97tDt6g6/h9ZvQXwV4=; b=NXTGlPVFkpeqEtObFGCIeif4Ff
 +46qnY0+XgtzIxhIncd+Tc2Ovmn7pwzsaxBZ39WxPpgj/deVNg3LjW+4h7tnuzW48JL/mgkI3Zs5d
 zQe7geOGLAaO9jIo3IP+jt2eSZ/eUJPJkOCaj7ubMuUCJ6WI7x8wzXKSTWiDHQrZy4Z4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OyZzslxpO2pn8/8MY4qGkQO2Q97tDt6g6/h9ZvQXwV4=; b=PoHVtuztXMRaCQxi8C7k0+2C5/
 lEbxtuMQ3UsHngr10Py/YfC2W2rcFShjfeHg1ZSsZGo++l286geRPZVPN7swzGP/KQf+FMoyjYrWz
 IYpDX5mlEmq0M2Iiq8IrLR27+ncDzo4vTwfn03MBrEvB2UCplFS2Plow2ruQDt+v/F+4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5qO-000000005Z9-1BDF for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:34:53 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so16931755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795347284; x=1795952084; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OyZzslxpO2pn8/8MY4qGkQO2Q97tDt6g6/h9ZvQXwV4=;
 b=bXA5MVNqbUmG6UJR9wRs1G2S9kzmgt0mK7R3Bsz87hcYJ9wqzhYJQ/GEBMtJ50Xt0s
 hojgmuHA7ftUHGci1PT39EYc8PkxgGBQ7a6nsAKjM/E/r5vBynGH3leQrR7TEASzwIZW
 th/GyPCMdckrveZS8l/I/J4mKG6offzZm22nyjKQX0iqez2ho0LBB542/+p8xgE8YVTo
 fXo6B12cAqe/UBrlzHtmmCpT/iavtLaozyG0nfFbgZlFyv6bnI+SVi4l20BKK3i7NplR
 fEZohvpzr76Tr8OtxrrLycEvfukA9HG+1qFPTedLb0ejgWdbMhkufw0tu7h/yUgIz29A
 5ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795347284; x=1795952084;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OyZzslxpO2pn8/8MY4qGkQO2Q97tDt6g6/h9ZvQXwV4=;
 b=hAahQX5R4sk+ypskkRA9amzPquK2dLOZHmAjl6AtD8s4K7vuX8oj98bAuZvPaDy5jK
 5jhWS4PIUwMMpc63meiq6av8Ii477atvofSD7q6G2GOcXWXFFsdVdd09rbze8OTLfsrb
 pwzIZPv/9s2GNUdT80IFT5T1ZLsDxGNGOXTxlr7bFR6UO7Q6E9cmt3S61ylHO9g1uftp
 UaQ/75P9YB1/P6J/UyDZ4Ees4WGcZNl+Z9++j8a5PDmTZOC8AxRGY/Urd/h1O3cPGEbt
 ZGmrX1ZH5fPgsCIAFiNYg5wiV38hN+WlEwadj988qGkTfcDHcKPCez/RKAa8A/FGaBBs
 sQqQ==
X-Gm-Message-State: APuU4Z+ulGC1NKftmBR3nxZ+ibfGGYUu6s/Po3iTZDCf6c4kbqRujtvH
 0+r8+Wfe9iqRPsTgXagE+QH4JstikswhBsszFAufRJfMfmPzsjwQLrgiEiH6KrbEb1UvwkA0Ev7
 NB+0Zjtn0jmASS0ulI/7KBCloeevLlDVBWQWWPMjnUsJJYWwOwqx9v4CWgjVBDN5r0HjW
X-Gm-Gg: AZFdTZfij8jF8v7JrmOe7Je4WS8flpv7XbC8K8LX9CtJWjq89lU5PSwMsglvEpqjuYO
 XnbEvGWvGd/HQL7m2XxwlLsW4jm0BDBsVWJMbxCPu+cZDxpGRsPFV8zhHj58nS9HweUHF60E7Wl
 9GH1Ak6uPaGcoBoCGoQ9gZWke4X6M4pfnYWORI4omd0vhY5xVEp5NhhuJaoDKZgC4A2rT4BkiqH
 0imkU7FXQMir6v0whIYyadUby6lVdA3tQ5xBeXtvMQcFd4ehF5B0L24udQXsEy/HIVrvK7AROFB
 sY6Kx8a2sUc9Lr+36/TP1h0Uycg+6bliWEKz+sJ0tLQil45eun5tJa8NkGHZl+JVWF4ujcvPpMP
 bEfRmFmhVCh9On2nBrW2vxn0ddohGXXBtw0UhdEmSk8Wq1GBTCkman4G0+fPNOa0Lsl8L2W/SZz
 SLoVpEeRbB2q3i/F+L4ba24NKf6Sbh8PqXLtTxRrRMqtFth+UMEUaFs/0aMco6b3kZ2C8R6+6Ve
 nMK2zgvCQolh06eU3ui8x8LSehEgpA+T6DE2RtZFsJEpGPwFVa7uVqFETxCQyxEHrva+plt80h5
 dNRZXFXnZ5x2gjs19cDVc1jw+nEJFvriAz1YHlttncPF8Q2u/8CQz0zEXBWHYMoR1GYLEshOZzQ
 ZTX3CoW6Xa90GE9iyupsVC8pmzLooA3gKb4lwo2ykv+CjN6bkJM2W0h5vivTcdAca90p0o+ILVr
 vGP3XfAuY6B9TyRA0=
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb88819be1mr166374035e9.16.1795347284327; 
 Sun, 22 Nov 2026 03:34:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm399400615e9.13.2026.11.22.03.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:34:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:34:42 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: ca24a09f2f8916fe4af3f839a8929c74e0b868b0
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce4464a01944c2d7c246f1ccde5b811fb10b2fa8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5qO-000000005Z9-1BDF
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8078532271528781170=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8078532271528781170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PJtpyOmdc7E="; charset=UTF-8

--PJtpyOmdc7E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2211?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: multi: raise the open fil=
es limit for --max-clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

multi: raise the open files limit for --max-clients

Every TC=
P client takes a file descriptor and accept() happens before the
--max-clie=
nts check, so with the default limits (soft limit 1024,
--max-clients 1024)=
 the server runs out of descriptors before it can
refuse a client=2E

When =
the server has a TCP listener, raise the soft limit to
--max-clients plus s=
ome room for the other descriptors, up to the hard
limit, and warn if that =
is not enough=2E Processes started by OpenVPN
inherit the new limit=2E

Not=
 on macOS, where the event loop uses select() and cannot watch
descriptors =
>=3D FD_SETSIZE=2E

GitHub: OpenVPN/openvpn#1148
Change-Id: I17fafbe65fd3ff=
510a72ed809c85b0d19343fad2
Signed-off-by: Gianmarco De Gregori <gianmarco@m=
andelbit=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211
Message-Id: <202611181727=
53=2E29962-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg41638=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man-sections/server-options=
=2Erst
M src/openvpn/multi=2Ec
2 files changed, 66 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
11/2211/4

diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sec=
tions/server-options=2Erst
index 7a09809=2E=2E5c1b129 100644
--- a/doc/man-=
sections/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@=
@ -418,6 +418,9 @@
 --max-clients n
   Limit server to a maximum of ``n`` c=
oncurrent clients=2E Defaults to 1024=2E
 
+  With a TCP listener, the soft=
 limit on open files is raised up to the hard
+  limit if needed to accept =
``n`` clients (not on Windows and macOS)=2E
+
 --max-routes-per-client n
  =
 Allow a maximum of ``n`` internal routes per client (default
   :code:`256=
`)=2E This is designed to help contain DoS attacks where an
diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index ad9f9f4=2E=2E900b5a3 1006=
44
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -270,6 +270,6=
8 @@
 #endif
 
 /*
+ * Every TCP client takes a file descriptor, and accept=
() happens before the
+ * --max-clients check: raise the soft limit so that=
 --max-clients is reached
+ * first, or warn if the hard limit does not all=
ow it=2E
+ */
+static void
+multi_check_nofile_limit(const struct context *=
t)
+{
+#if defined(HAVE_GETRLIMIT) && defined(RLIMIT_NOFILE) && !defined(TA=
RGET_DARWIN)
+    bool tcp =3D false;
+    for (int i =3D 0; i < t->c1=2Eli=
nk_sockets_num; i++)
+    {
+        if (!proto_is_dgram(t->c2=2Elink_socke=
ts[i]->info=2Eproto))
+        {
+            tcp =3D true;
+            br=
eak;
+        }
+    }
+    if (!tcp)
+    {
+        return;
+    }
+
+   =
 /* room for the tun device, the listeners, log, management, scripts=2E=2E=
=2E */
+    const rlim_t needed =3D (rlim_t)t->options=2Emax_clients + 64;
=
+
+    struct rlimit rl;
+    if (getrlimit(RLIMIT_NOFILE, &rl) < 0)
+    {=

+        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RLIMIT_NOFILE) failed")=
;
+        return;
+    }
+    if (rl=2Erlim_cur >=3D needed)
+    {
+     =
   return;
+    }
+
+    const rlim_t old =3D rl=2Erlim_cur;
+    rl=2Erlim=
_cur =3D rl=2Erlim_max < needed ? rl=2Erlim_max : needed;
+    if (rl=2Erli=
m_cur > old)
+    {
+        if (setrlimit(RLIMIT_NOFILE, &rl) =3D=3D 0)
+ =
       {
+            msg(M_INFO, "NOTE: raised the open files limit from %=
lu to %lu", (unsigned long)old,
+                (unsigned long)rl=2Erlim_c=
ur);
+        }
+        else
+        {
+            msg(M_WARN | M_ERRNO,=
 "WARNING: setrlimit(RLIMIT_NOFILE) failed");
+            rl=2Erlim_cur =
=3D old;
+        }
+    }
+    if (rl=2Erlim_cur < needed)
+    {
+       =
 msg(M_WARN,
+            "WARNING: the open files limit (soft %lu, hard %l=
u) is too low for "
+            "--max-clients %" PRIu32 ", TCP clients ma=
y be refused before --max-clients is reached",
+            (unsigned long)=
rl=2Erlim_cur, (unsigned long)rl=2Erlim_max, t->options=2Emax_clients);
+  =
  }
+#endif /* if defined(HAVE_GETRLIMIT) && defined(RLIMIT_NOFILE) && !def=
ined(TARGET_DARWIN) */
+}
+
+/*
  * Main initialization function, init mult=
i_context object=2E
  */
 static void
@@ -398,6 +460,7 @@
      * Per-clien=
t limits
      */
     m->max_clients =3D t->options=2Emax_clients;
+    mu=
lti_check_nofile_limit(t);
 
     m->instances =3D calloc(m->max_clients, s=
izeof(struct multi_instance *));
     check_malloc_return(m->instances);

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I17fafbe65fd3ff=
510a72ed809c85b0d19343fad2
Gerrit-Change-Number: 2211
Gerrit-PatchSet: 4
Ge=
rrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--PJtpyOmdc7E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2211?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mul=
ti: raise the open files limit for --max-clients<br><br>Every TCP client ta=
kes a file descriptor and accept() happens before the<br>--max-clients chec=
k, so with the default limits (soft limit 1024,<br>--max-clients 1024) the =
server runs out of descriptors before it can<br>refuse a client=2E<br><br>W=
hen the server has a TCP listener, raise the soft limit to<br>--max-clients=
 plus some room for the other descriptors, up to the hard<br>limit, and war=
n if that is not enough=2E Processes started by OpenVPN<br>inherit the new =
limit=2E<br><br>Not on macOS, where the event loop uses select() and cannot=
 watch<br>descriptors &gt;=3D FD_SETSIZE=2E<br><br>GitHub: OpenVPN/openvpn#=
1148<br>Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2<br>Signed-off-=
by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2211<br>Message-Id: &lt;20261118172753=2E29962-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg41638=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sections/server-op=
tions=2Erst<br>M src/openvpn/multi=2Ec<br>2 files changed, 66 insertions(+)=
, 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/11/2211/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-se=
ctions/server-options=2Erst b/doc/man-sections/server-options=2Erst</span><=
br><span>index 7a09809=2E=2E5c1b129 100644</span><br><span>--- a/doc/man-se=
ctions/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server-o=
ptions=2Erst</span><br><span>@@ -418,6 +418,9 @@</span><br><span> --max-cli=
ents n</span><br><span>   Limit server to a maximum of ``n`` concurrent cli=
ents=2E Defaults to 1024=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  With a TCP listener, the soft limit on open fil=
es is raised up to the hard</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  limit if needed to accept ``n`` clients (not on Windows and macOS=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> --max-routes-per-client n</span><br><span>   Allow a maximum of ``n`` in=
ternal routes per client (default</span><br><span>   :code:`256`)=2E This i=
s designed to help contain DoS attacks where an</span><br><span>diff --git =
a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index ad9f9=
f4=2E=2E900b5a3 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><b=
r><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -270,6 +270,68 @@</s=
pan><br><span> #endif</span><br><span> </span><br><span> /*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Every TCP client takes a file de=
scriptor, and accept() happens before the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * --max-clients check: raise the soft limit so that =
--max-clients is reached</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * first, or warn if the hard limit does not allow it=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_check_nofile_limit(const struct context *t)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(HAVE_GETRLIMIT) &amp;&amp; define=
d(RLIMIT_NOFILE) &amp;&amp; !defined(TARGET_DARWIN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool tcp =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; t-&gt;c1=
=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!proto_is_dgram(t-&gt;c2=2Elink_sockets[i]-&gt;info=2Eproto))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            tcp =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!tcp)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* room for the tun device, the list=
eners, log, management, scripts=2E=2E=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const rlim_t needed =3D (rlim_t)t-&gt;options=
=2Emax_clients + 64;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rlimit =
rl;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (getrlimi=
t(RLIMIT_NOFILE, &amp;rl) &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_WARN | M_ERRNO, &quot;WARNING: getrlimit(RLIMIT_NOFILE) faile=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &gt;=
=3D needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const rlim_t old =3D rl=2Erlim_cur;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rl=2Erlim_cur =3D rl=2Erlim_max &lt=
; needed ? rl=2Erlim_max : needed;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (rl=2Erlim_cur &gt; old)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (setrlimit(RLIMIT_NOFILE, &amp;rl) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;NOTE: =
raised the open files limit from %lu to %lu&quot;, (unsigned long)old,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                (unsigne=
d long)rl=2Erlim_cur);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN |=
 M_ERRNO, &quot;WARNING: setrlimit(RLIMIT_NOFILE) failed&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            rl=2Erlim_cur =3D =
old;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &lt; needed)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNING: the open fi=
les limit (soft %lu, hard %lu) is too low for &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;--max-clients %&quot; P=
RIu32 &quot;, TCP clients may be refused before --max-clients is reached&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (un=
signed long)rl=2Erlim_cur, (unsigned long)rl=2Erlim_max, t-&gt;options=2Ema=
x_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(H=
AVE_GETRLIMIT) &amp;&amp; defined(RLIMIT_NOFILE) &amp;&amp; !defined(TARGET=
_DARWIN) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Main initialization fu=
nction, init multi_context object=2E</span><br><span>  */</span><br><span> =
static void</span><br><span>@@ -398,6 +460,7 @@</span><br><span>      * Per=
-client limits</span><br><span>      */</span><br><span>     m-&gt;max_clie=
nts =3D t-&gt;options=2Emax_clients;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    multi_check_nofile_limit(t);</span><br><span> </span><=
br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeof(struct m=
ulti_instance *));</span><br><span>     check_malloc_return(m-&gt;instances=
);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2211?usp=3Demail">change 2211</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85=
b0d19343fad2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2211=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--PJtpyOmdc7E=--


--===============8078532271528781170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8078532271528781170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8078532271528781170==--


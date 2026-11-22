Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1157F606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GqrcPZ9b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iKWm291Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gn0/THj1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YMlcfJ8I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RMWF9LdMPnSY/sm2X4NaOYL9GGdaYC9TuAtivHxcqN4=; b=GqrcPZ9bDrwJsG9aU8KK1TCK3D
	UicmolWYkljVr+fj+GIrIeI9zaJ9vSoVMBzeawQMJinnIRLsGs8rhM+j9BeZXWhY5tTRpj2E6Ae77
	iEQeCesUQjM2NcgAXjDPSJ5GbXk4Iuhw9NmScs9A84ZYzrzjYzxYeCOos16pSPFaHeZM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5qQ-000000007By-35Ut;
	Sun, 22 Nov 2026 11:34:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5qP-000000007Bl-1pzv
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:34:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XYy0x0dc7QjVITeCvU/wzqc1mpOWBR0YQrKXZRkREmA=; b=iKWm291Q3O52OBLl1FE5xD0Tnd
 3zwG8N8C/1USptWJngjeh6rGdI+Izzj/vZrk7hSiBn+Ba1KLMigTG89yssHJKRv2sOkAnEP4TX6E5
 JYSTOvdQf2OBNsSZsqvi8QeG/6NaitToBtOOcsaJ/Weg2NXB6nX8qJQ3rLL6mpb9U5pU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XYy0x0dc7QjVITeCvU/wzqc1mpOWBR0YQrKXZRkREmA=; b=gn0/THj12ZOaQLKdCQyYZFxI4F
 nrIdMNObBcI0bjieCKtv7/lPFyHUipeqoObkjdHxcdbr0I/4gsseB0gGElfIcDQv1crqATE9lYd/+
 sIJxqSwk6ycRI24WwSJz0X+370u+2oxYp5ZpJNjINcINbJH27JpRc0hDLKV4577f/N5o=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5qN-000000008Dq-3OiY for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:34:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so14866165e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795347285; x=1795952085; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XYy0x0dc7QjVITeCvU/wzqc1mpOWBR0YQrKXZRkREmA=;
 b=YMlcfJ8I9D7B2Q+HyQ4aWFGz3xdKurHhsi4d2RDbvGic1245VQeqf60kj6HEkyqBKJ
 7puhX3GoNHrt/BncRLDagCU+c4FfZyvGKNSuJJ7cSse0unk9u/hyWCe6TUiPn1b6++Su
 NREHzksv+R9MkDjrH/L6SQwISb/WMx88keC22txK8vuYy5dh6zMyfqT7eZEGbJo7zWCZ
 AroAxudhCMjRZ+jPj8AqmJOndP6A0Mbuk1ZL9yiXypKl6KiI315YyHvRaoOJOPHADj6j
 a4JNlfrPtnsWkDuIgWUg8ktB8Fmh2Yr6wZgvxywYbMdzNjSQTHGDKtiJoG+2y1brp/J7
 Q8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795347285; x=1795952085;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XYy0x0dc7QjVITeCvU/wzqc1mpOWBR0YQrKXZRkREmA=;
 b=kbHNn7D0V6tOVB7cMSv1hOLW1WV/FEht1T1So+Mg3gen9NoyEUAlNphjXIs/3KxAMK
 LWqzJtSOYLrsXku9B54lK06RKpq0g+/0lW6cCNgAktin75rFHdeHqIyc4C++sx26XpA8
 ZUVPLaE7vFp0yaekovhG3+lwuRWfBWXq7zZjfrvWDlI/+09qF9kz+7d7OB0psuLnt+aB
 LnAWeHdntIohuC0v3ow5RrbMgBPmkovTRy9sA3CmObxMqg88K4f9YNNfIwE+1GXc2kmL
 dacIgHBj2B0k2KqMq249dXQtP/IsMOx4HZJjTFRZ6qGAxFfrA9chFmVMbMjoyztv0uNv
 4dhA==
X-Forwarded-Encrypted: i=1;
 AL+hErF/1Bq1Lt8OiOxqRVyrtWEWma8rT+QD3PswAUrxJwJPEGMVafGppmHVnS1+2RPugtoe0cQDFqv25mGBp/Am@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8HnoXCW2M2qZYNDLYPzfM6VAJNyTRxpo2gFVAnXtdkoL5BUTpI
 zasp597p8O2pj53EliYWzUI4YYy7ZFpAl+MqFnBbempXdVfCB6CAv2/w1pb2cIAkVuL/WFXS+eN
 UYx9d8oEm60B+dQuONjl3N8cdreeRLx5ZsycKwlBVzDOtoWHrzVtPXyYVe+qs/3g6Dmk9Fo/gcx
 gErJemrQ==
X-Gm-Gg: AZFdTZcGdd9Nvp9GnIa4+QixKECUPJ2YOwdhSZF0TaNI/KAFgr41fDm95OEIM3siQdR
 UeU8KhwWrjQbZUwZJd79tDrFbXhOSNMp+12m1C7ePrDp+lejyTvDWl32opnWU7wrCgqzmEV0JL5
 lUsytMS9t5GOlrf/L+dMf9AuOghOmQaPhcvRPnmTIxFNiSwaPkPuX758ESfDWzw95uphuYeP3DI
 HCBsmOXa6Tg92sOzFCuwW8Y6idfFFfibh0ucvL7ItUGVvAZgtJ1UrPRQASuDjFu8rsDq3gPAQfE
 PBpxKrEX/43BlOxnQNxPgT5BJIeyfZvq6ZAMCqpkO5NtmTGNy33kN+BWtR9XZbgLmG3OfNTV5Vh
 AwcXmg0GXyp7dd/j3fyKIB7u8VbBZ4Y30b9x+WMdTcnYp4fZWPcBZE3XXxWAo2IlpHPBbAXlgkZ
 I0EsFzDubK07UMtFt2ZqIxht7R1dMhUaYsxcuH1k7mf2/x4S3Iwm2RU6ryep4KCaCp1OTvCA0QY
 zQUU5yLhcnS6qqRXDxQ5Z23IT991VT8jKhNI8zTmnLBzOyMseWV/9Ek3xeofAfqlKNrOWC6zR3m
 6vXZXT1ZtSNdld8Hs3dj/S6DvHN7hMan8UglsJaZLh5pEMV4SKK74tUsdPKwHYR0XY+yOAVsxlp
 7lWjw++DfxbxqMHZ7TRkzslhQes1JMplnctKKGFnVRjYMtFKnQUzEyOM18N8mj657Pd0UnalD9N
 /QezPgcKbQNuvuhkz4hsfN0LxDC8xVvFw44KMM
X-Received: by 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4bb887865b5mr179261585e9.0.1795347285123; 
 Sun, 22 Nov 2026 03:34:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm199865255e9.0.2026.11.22.03.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:34:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:34:44 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: ca24a09f2f8916fe4af3f839a8929c74e0b868b0
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce4464a01944c2d7c246f1ccde5b811fb10b2fa8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5qN-000000008Dq-3OiY
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0579971101264575495=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0579971101264575495==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JqtaBMzg3tg="; charset=UTF-8

--JqtaBMzg3tg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2211?usp=3Demail )

Change subject: multi: raise the open files=
 limit for --max-clients
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




diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sect=
ions/server-options=2Erst
index 7a09809=2E=2E5c1b129 100644
--- a/doc/man-s=
ections/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@=
 -418,6 +418,9 @@
 --max-clients n
   Limit server to a maximum of ``n`` co=
ncurrent clients=2E Defaults to 1024=2E
 
+  With a TCP listener, the soft =
limit on open files is raised up to the hard
+  limit if needed to accept `=
`n`` clients (not on Windows and macOS)=2E
+
 --max-routes-per-client n
   =
Allow a maximum of ``n`` internal routes per client (default
   :code:`256`=
)=2E This is designed to help contain DoS attacks where an
diff --git a/src=
/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index ad9f9f4=2E=2E900b5a3 10064=
4
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -270,6 +270,68=
 @@
 #endif
 
 /*
+ * Every TCP client takes a file descriptor, and accept(=
) happens before the
+ * --max-clients check: raise the soft limit so that =
--max-clients is reached
+ * first, or warn if the hard limit does not allo=
w it=2E
+ */
+static void
+multi_check_nofile_limit(const struct context *t=
)
+{
+#if defined(HAVE_GETRLIMIT) && defined(RLIMIT_NOFILE) && !defined(TAR=
GET_DARWIN)
+    bool tcp =3D false;
+    for (int i =3D 0; i < t->c1=2Elin=
k_sockets_num; i++)
+    {
+        if (!proto_is_dgram(t->c2=2Elink_socket=
s[i]->info=2Eproto))
+        {
+            tcp =3D true;
+            bre=
ak;
+        }
+    }
+    if (!tcp)
+    {
+        return;
+    }
+
+    =
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

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I17fafbe65fd3ff510a7=
2ed809c85b0d19343fad2
Gerrit-Change-Number: 2211
Gerrit-PatchSet: 4
Gerrit-=
Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--JqtaBMzg3tg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2211?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi: raise the open files limit =
for --max-clients<br><br>Every TCP client takes a file descriptor and accep=
t() happens before the<br>--max-clients check, so with the default limits (=
soft limit 1024,<br>--max-clients 1024) the server runs out of descriptors =
before it can<br>refuse a client=2E<br><br>When the server has a TCP listen=
er, raise the soft limit to<br>--max-clients plus some room for the other d=
escriptors, up to the hard<br>limit, and warn if that is not enough=2E Proc=
esses started by OpenVPN<br>inherit the new limit=2E<br><br>Not on macOS, w=
here the event loop uses select() and cannot watch<br>descriptors &gt;=3D F=
D_SETSIZE=2E<br><br>GitHub: OpenVPN/openvpn#1148<br>Change-Id: I17fafbe65fd=
3ff510a72ed809c85b0d19343fad2<br>Signed-off-by: Gianmarco De Gregori &lt;gi=
anmarco@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211<b=
r>Message-Id: &lt;20261118172753=2E29962-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41638=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mu=
lti=2Ec<br>2 files changed, 66 insertions(+), 0 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/se=
rver-options=2Erst</span><br><span>index 7a09809=2E=2E5c1b129 100644</span>=
<br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b=
/doc/man-sections/server-options=2Erst</span><br><span>@@ -418,6 +418,9 @@<=
/span><br><span> --max-clients n</span><br><span>   Limit server to a maxim=
um of ``n`` concurrent clients=2E Defaults to 1024=2E</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  With a TCP listener, =
the soft limit on open files is raised up to the hard</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  limit if needed to accept ``n`` clients=
 (not on Windows and macOS)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> --max-routes-per-client n</span><br><span>   A=
llow a maximum of ``n`` internal routes per client (default</span><br><span=
>   :code:`256`)=2E This is designed to help contain DoS attacks where an</=
span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</=
span><br><span>index ad9f9f4=2E=2E900b5a3 100644</span><br><span>--- a/src/=
openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><sp=
an>@@ -270,6 +270,68 @@</span><br><span> #endif</span><br><span> </span><br=
><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Every =
TCP client takes a file descriptor, and accept() happens before the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * --max-clients check: rai=
se the soft limit so that --max-clients is reached</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * first, or warn if the hard limit does not=
 allow it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+multi_check_nofile_limit(const =
struct context *t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_GE=
TRLIMIT) &amp;&amp; defined(RLIMIT_NOFILE) &amp;&amp; !defined(TARGET_DARWI=
N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tcp =3D =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; t-&gt;c1=2Elink_sockets_num; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!proto_is_dgram(t-&gt;c2=2Elink_sockets[i]-&gt;=
info=2Eproto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tcp=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!tcp)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* room for =
the tun device, the listeners, log, management, scripts=2E=2E=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const rlim_t needed =3D=
 (rlim_t)t-&gt;options=2Emax_clients + 64;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct rlimit rl;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (getrlimit(RLIMIT_NOFILE, &amp;rl) &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;WARNING: getrlimi=
t(RLIMIT_NOFILE) failed&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (rl=2Erlim_cur &gt;=3D needed)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const rlim_t old =3D rl=2Erlim_cur;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rl=2Erlim_cur =
=3D rl=2Erlim_max &lt; needed ? rl=2Erlim_max : needed;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &gt; old)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (setrlimit(RLIMIT_NOFILE, &amp=
;rl) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_INFO, &quot;NOTE: raised the open files limit from %lu to %lu&quot;, (un=
signed long)old,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             (unsigned long)rl=2Erlim_cur);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_WARN | M_ERRNO, &quot;WARNING: setrlimit(RLIMIT_NOFILE) fail=
ed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   rl=2Erlim_cur =3D old;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl=2Erlim_=
cur &lt; needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;WARNING: the open files limit (soft %lu, hard %lu) is too low for &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;--m=
ax-clients %&quot; PRIu32 &quot;, TCP clients may be refused before --max-c=
lients is reached&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            (unsigned long)rl=2Erlim_cur, (unsigned long)rl=2Erlim_max=
, t-&gt;options=2Emax_clients);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* if defined(HAVE_GETRLIMIT) &amp;&amp; defined(RLIMIT_NOFILE) &amp;&=
amp; !defined(TARGET_DARWIN) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Ma=
in initialization function, init multi_context object=2E</span><br><span>  =
*/</span><br><span> static void</span><br><span>@@ -398,6 +460,7 @@</span><=
br><span>      * Per-client limits</span><br><span>      */</span><br><span=
>     m-&gt;max_clients =3D t-&gt;options=2Emax_clients;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi_check_nofile_limit(t);</span=
><br><span> </span><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clie=
nts, sizeof(struct multi_instance *));</span><br><span>     check_malloc_re=
turn(m-&gt;instances);</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">change 2211</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I17fafbe65fd3f=
f510a72ed809c85b0d19343fad2 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2211 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--JqtaBMzg3tg=--


--===============0579971101264575495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0579971101264575495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0579971101264575495==--


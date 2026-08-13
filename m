Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0732C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQouhBwXrjQZcILIWWxHS5qU/5zPm2vt4nUJLZHbnJs=; b=EvCezqqTCX8/wXakAHqFNaQrd+
	fnAqGmgAGJyuwiosB9hy96zyypeZL4AXyRn94IG/z80QUcftJqH5k25rVcpGHlR0Pw4uVd0jPe13I
	o4cXI9o6t3K7pVqnxVFKuk/h8H9pjTCoHNeHYQ4DChJRbr71iImPefrBjeugx12FwUe4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuPAz-0008Tx-T6;
	Thu, 13 Aug 2026 06:44:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuPAy-0008Ti-CZ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 06:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zM+ezYz0mVvK9SmoBiXuynAn+oh6QUYFGMRTHRA4dC8=; b=P+2DpQKM2pIVrMx8Szyj86Espe
 UEOJYMX6aAU3QP/F+bR/9Q6x77P9TxaBoCSRs7wbY3fH9s6JUkhNC7vv/XbDGpee2rXQ2TrWtyz1U
 JjWJWGNZZGfxJG1n7jRcwKYUD8yC2Nq6NWBUviMvDftYxib/MrKId5XxDSgAFE0jC2GY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zM+ezYz0mVvK9SmoBiXuynAn+oh6QUYFGMRTHRA4dC8=; b=V
 6sDg7znMTGsITiI/dAV5t1r/+mJ7P/1tJvvHFegplBZiq43EpkeqL2uSvhpLOxWAk9So3PkT8Uv35
 sKTPeK+MREyFhEd2iOv5uvjvYl48QuZx5h3eY0B4FtvvwfPNgwlZjTKNs4SOAz44qw5sdZ/pAjz4F
 7eTiPOiwwzRLTZOM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuPB0-0008CL-W0 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 06:44:29 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso8446865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786603461; x=1787208261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zM+ezYz0mVvK9SmoBiXuynAn+oh6QUYFGMRTHRA4dC8=;
 b=e9PqeUKlpafseUTgQhL6qJWQqp6TzYhjVqpdGT1mqcBfQibDWU5FB8Q4+yT40fNZTC
 khIib675Ke7fMXgUwI/Onv+SW8c44f45Eg+yjUeSfTM0msXoP604qlmXmettXgXk7atr
 akVYtmTRa1+l/4HuD+YOjKJx5GKKhs3B2HCQjx3PG6ZQSPkv/BcPX7+XTeEdUxn215G/
 3vWZWkNK3Bxl2tC7UkyVwYUpXnTlrvvEgCguOZnRHEaZp1tPu01oK7Qe6KbGuF8kc6rO
 nezPQ+4s1LSyeH2JZlFRaaL0T94nKvgryh+lCgwKgJ7HhTa2qtTfCNmiu2iYKnJhtmkg
 /ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603461; x=1787208261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zM+ezYz0mVvK9SmoBiXuynAn+oh6QUYFGMRTHRA4dC8=;
 b=HQ8AIqu2LHJ1EQy6su5PNPssLPOuk0bIjaAA3xdV5Fs+8hgDunyXXJptgu8AMGHVYz
 Z6qsjKKoutqhlFOD5rh1l+jcWioUY/cMoHeUJhlPWsW7rdCvYQ9W7HFekTTouMYEucDf
 zp2kz9Z/X2RgvTHCQnJEcdv8bd0gvjVbwAd5kVIWZ5J51WZKsO9WHlwIScwnDBA07yQE
 4u2jdObe1SX3aht6iV1Yj6s3lca6YEQ0qW/oPxdnOsN72XtdJMcfvLUMiv6tin7l6S6W
 zyCFsUbUT1jlzOxf1smacS9OOlekDbmU7V1L4at7BbE3P2Q0COBJSwEbHeBCIvoHsshP
 LXvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqu+toUDMvmEx6Xvj/oMifzccTsKVhKKGZsijK/LE8PJeTvTcBvAn5b5/fA+nbyB0SOU5OB06D7jfsbXEx/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzAbTtbUkK7nYwT2a2CDYb2xqHFB6Ug7Vcp1Y5IOGuQgRoUueej
 VCJbCG4moxsw4ciZO0TTdhpvetlL9ueIZ80/S5Odrpq6/hBurFqA7e7Ew8NKSWtxOSJ9XAyxIwT
 XdG0omAgCFghDhOnpCvFRctfHAf/BGWM2i/XXCPE+JhyTbCmRY3rVFqYjcGfpzGpPd0iNzI6tfw
 5mTDvXHQ==
X-Gm-Gg: AR+sD11t/SFy6noVul/7I1dJXijBGalxHh8bdv9pQ5clXrG/xhIsZCXtxojyDj0L1u2
 Cd1h2bO95anqKne6AOEezM7pE0imQEW8pmBP25By1P5b4mtEO1QULBu+RLXI6YiBgFAm8hwmNAr
 SWUX5In7F5jVqfJ0wFm/AhT4+VALKXJBMe8xgxCaOYcLZyq1JHnnaMwkhObKZvMxNy/QMd9NOvv
 ULrhKU6jFzo9tt+pp9zgEysuuem7ysa6rXlGQMcXNPCrak3US31idSdMIFc5sr4ntgOu797szq0
 sIdedcebqvRb0e9RSrPhdm87OWjPJnvrkdR3VOD7Yc72JYtlYkht3+sWUCDojgeFz2T1ge1CAtN
 waYg8IMKOr5D2QQcYiFwh3jOocQGNH9guWYFP4UH1ZUZ5MJl5J9GMOJc9B1U5NUvd2bGHnMx0UK
 n8iKtl4PhyuRu5FEy8ACbQ5KJ0UyFfKijCh3ByV9YO4umJ4YaYA9d8+51/c5UNMJKbPGi1n1N+m
 gLa01U8fdUVD95vnHrmo+trg350X7VJ7VNEAqXWznV4v0O9GNiwhIdMv44xtZj3D+AFX/jyZH3t
 peYlQjMG2MsW9xqfcYaj2nJ053dOKQmigMGg2YvwWSEyd6vFMwgtDscmgXW8+w==
X-Received: by 2002:a05:600c:820a:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-499821acb31mr38670575e9.10.1786603460736; 
 Wed, 12 Aug 2026 23:44:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499821652dbsm33165545e9.9.2026.08.12.23.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:44:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 06:44:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
X-Gerrit-Change-Number: 1841
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1841?usp=email>
X-Gerrit-Commit: dbd0b53611e96bbc18f9dfade4c0fd3e65b25222
In-Reply-To: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
References: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDY1NjI4MDAwLkkyYmQ1MjU5ZGU3MDJmY2U1ZDRlZjY5MjZjMWRlZTdjNmU2ZTU5N2Q3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71f115c6cd825300354c3d7d4c9abddca47f6a2e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuPB0-0008CL-W0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: otime: Remove
 openvpn_time()
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5476916934103441495=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5476916934103441495==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GX9ijCrsTYs="; charset=UTF-8

--GX9ijCrsTYs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1841?usp=3Demail )

Change subject: otime: Remove openvpn_time()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

otime: Remove openv=
pn_time()

Using this function seems to be more complicated
than just using=
 now directly=2E

Suggested by Arne in review of cppcheck fixes=2E

Change-=
Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841
Message=
-Id: <20260811184408=2E3535-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38286=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/otim=
e=2Eh
M src/openvpn/pkcs11=2Ec
M src/openvpn/push=2Ec
3 files changed, 3 in=
sertions(+), 15 deletions(-)




diff --git a/src/openvpn/otime=2Eh b/src/o=
penvpn/otime=2Eh
index f02cc31=2E=2Ed14f01e 100644
--- a/src/openvpn/otime=
=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -93,17 +93,6 @@
 #endif
 }
 
-static in=
line time_t
-openvpn_time(time_t *t)
-{
-    update_time();
-    if (t)
-  =
  {
-        *t =3D now;
-    }
-    return now;
-}
-
 static inline void
 =
tv_clear(struct timeval *tv)
 {
diff --git a/src/openvpn/pkcs11=2Ec b/src/o=
penvpn/pkcs11=2Ec
index cfcd372=2E=2E8b06fd0 100644
--- a/src/openvpn/pkcs1=
1=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -42,7 +42,8 @@
 static time_t
 __myti=
me(void)
 {
-    return openvpn_time(NULL);
+    update_time();
+    return=
 now;
 }
 
 #if !defined(_WIN32)
diff --git a/src/openvpn/push=2Ec b/src/op=
envpn/push=2Ec
index ce2baf2=2E=2E97f352e 100644
--- a/src/openvpn/push=2Ec=

+++ b/src/openvpn/push=2Ec
@@ -999,9 +999,7 @@
     else if (tls_authentic=
ation_status(c->c2=2Etls_multi) =3D=3D TLS_AUTHENTICATION_SUCCEEDED
       =
       && c->c2=2Etls_multi->multi_state >=3D CAS_CONNECT_DONE)
     {
-   =
     time_t now;
-
-        openvpn_time(&now);
+        update_time();
   =
      if (c->c2=2Esent_push_reply_expiry > now)
         {
             ret=
 =3D PUSH_MSG_ALREADY_REPLIED;

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1841?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
Gerrit-Change-Number: 1=
841
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--GX9ijCrsTYs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1841?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">otime: Remove openvpn_time()<br><br>Using =
this function seems to be more complicated<br>than just using now directly=
=2E<br><br>Suggested by Arne in review of cppcheck fixes=2E<br><br>Change-I=
d: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1841<br>Message-Id: &lt;20260811184408=2E3535-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38286=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/otime=2Eh<br>M src/openvpn/pkcs=
11=2Ec<br>M src/openvpn/push=2Ec<br>3 files changed, 3 insertions(+), 15 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/otime=2Eh b/src/openvp=
n/otime=2Eh</span><br><span>index f02cc31=2E=2Ed14f01e 100644</span><br><sp=
an>--- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2Eh<=
/span><br><span>@@ -93,17 +93,6 @@</span><br><span> #endif</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline time_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-op=
envpn_time(time_t *t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    update_time();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        *t =3D now;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return now;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> s=
tatic inline void</span><br><span> tv_clear(struct timeval *tv)</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/p=
kcs11=2Ec</span><br><span>index cfcd372=2E=2E8b06fd0 100644</span><br><span=
>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec<=
/span><br><span>@@ -42,7 +42,8 @@</span><br><span> static time_t</span><br>=
<span> __mytime(void)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return openvpn_time(NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    update_time();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return now;</span><br><span> }</span><br><=
span> </span><br><span> #if !defined(_WIN32)</span><br><span>diff --git a/s=
rc/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index ce2baf2=2E=
=2E97f352e 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><spa=
n>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -999,9 +999,7 @@</span><br>=
<span>     else if (tls_authentication_status(c-&gt;c2=2Etls_multi) =3D=3D =
TLS_AUTHENTICATION_SUCCEEDED</span><br><span>              &amp;&amp; c-&gt=
;c2=2Etls_multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        time_t n=
ow;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        openvpn_time(&amp;now);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        update_time();</spa=
n><br><span>         if (c-&gt;c2=2Esent_push_reply_expiry &gt; now)</span>=
<br><span>         {</span><br><span>             ret =3D PUSH_MSG_ALREADY_=
REPLIED;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail">change 1841</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bd5259de702f=
ce5d4ef6926c1dee7c6e6e597d7 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1841 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--GX9ijCrsTYs=--


--===============5476916934103441495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5476916934103441495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5476916934103441495==--


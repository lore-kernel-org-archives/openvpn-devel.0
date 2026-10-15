Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3218ACC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ULEyT6TC06W+i2ScEHM9ruERHikLjRBxlRDkocsqs7s=; b=mxDcw6A746CRdx
	whW3DZPzk61+Vpf0dUwCKvwk2IkaQIosak9zdmeXn2Q2Syy4wTjR/0hJZCf5/sS4E+Hq12eVXrJ2W
	Eq4ja1le2LbSWVH7UfC+3AF9Te/PQE5hn1OOq3CuoHcmiYYVm+MIWYxEj3yYWQ2y8BRv58iM0V/de
	tMg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJIo-00071M-U0;
	Thu, 15 Oct 2026 11:07:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJIn-000715-8b
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JibdY+KImujd5QR44zOUd3nJl2oeyRkRZ5bJ+uGS/lQ=; b=QXnlQDSIWc9M5KygE9uBoq1/Zb
 z91zeuvXXvgTlWAyxfonNj8gu0psR4bKB5NbKxBhO2LcDAC8Epw63vsfKDeFfLHy8FaXrCLpnySgT
 EQI9pX3/bj8vvo75XbRZBPKVF5ooizVHG87mclXC5l4zzBiluVEL8DKDs7xfwXFq/3xs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JibdY+KImujd5QR44zOUd3nJl2oeyRkRZ5bJ+uGS/lQ=; b=B
 KbJfzJmDg3WcUAQCAf86yeHUpaFVX+SWBRZFhwR2swpLVSD343Fmd2Vi9xH3KB9BgfLEgXTtCHdiC
 HczZtTK9RfKoaBNU/EHdV4Fy9htzAIsAtLwoheCQ8OFFMOMN9/H1fGxFh6z+wboxX/I2yFXxUrvtk
 tbbUMUayl923RUxE=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJIm-0004MO-HZ for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:07:13 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c6f764f82so655544f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792062426; x=1792667226; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JibdY+KImujd5QR44zOUd3nJl2oeyRkRZ5bJ+uGS/lQ=;
 b=PiDIJIwneDEbtGE+xBgumNCtzGQ3pObZgXVwk1UuFXFiq7D0WP1UpAjsIrY/9auC/i
 jJq7BykXfIwNNlJ/WkggGcIT+9a17piGSHLO9FR2vJc9RfoDO9rrhkxKnOK2l/WFcucI
 4QxgBnlUyjTsSLTzEoM1mf0mabDAk+8o6Y12xbF17BiraTiCdNDaLIR8y119XJl0QCW6
 W8RmASPl1T3RVUEcbNUHy5e58y70v+ql8MBrkSOtnqLi7PCAPSnnTub/avvDjXUSdgY4
 7I7S4wqsAuUkjQPgjPJp0EtzIW67jRpAdSfdqj3xmXBd0cruVfdyIf5y8OfnrhDjKhhQ
 899Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062426; x=1792667226;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JibdY+KImujd5QR44zOUd3nJl2oeyRkRZ5bJ+uGS/lQ=;
 b=D95WpaeTlHDemPAnJGdyLi5cyIhdZ7Izw47Z5hEqtfTA12MddahZbYZH2wEJLaye68
 GF7R1yuGqMT7d+vxNtK6gNApjBZ5A2ruOYkrcQ7yOIZfZCTPYgWQBm0xNwHLyalFTDlf
 N38fb9KUJCTzC1SvlSAFWWnFhI+SkQTCBtvMmnhXnTKMjPX7DLZs/HPG0/4olsKBpNkW
 oKL4VtkYT0aEeNZNfzoS/YsyLfWfXcDL3uUgqBqqv6etnhPfmHEr+ATl94V55lFkOCV6
 4ksLU71ff0d1vEpYvUecw4wLKzd6+icezuX7ahoAQZDzSijIBrcy5d7ffUf3qV+h4ykU
 HAmw==
X-Gm-Message-State: AFq9FYJrwMaSOyQEQPvrogHX22BViPI8mEwRGPMsLzs29aaOjrdUt1pJ
 7LhdvMWeFGuoTRkTcK2h8isXjhWOEA2e2jBM+xx4JJFF3CrZrVETK6qFFRMTAUdW63th7NaXFpd
 WnwxavITPyNtLiY+4iHK2HffkUw6NVXx8udgWCw4kjcANnoLUAKMcsfckDgLhlCN8ho7ckXOq+c
 qvv19wlQ==
X-Gm-Gg: AYBFou0aOQsu89TeMJfU4fGKm4iMkTHBdf9JzHr/I2Ixk/SA+JmOT6YwmrwiNN7stBk
 vt0lsLZMc8IxMHk4rKBo+A7fHP7yGUiPPUY0+ypmQZD9annRPHAR3/p3jE8/vTfZS6EEJFESdho
 DzFv8FIdy7RNsQb0mFOwM//tFUHaPdv/MNGwIOxVU7mQCWMPuCEk/FWtH4pTpflj4pqCf8Nzf7G
 WNJyRdYNQh5hVQzuZWKralgf2SF5WLG3F4Ypj52yxpJUpOmk1RWWeKxiVoe0r81itQ8pFLCwdP4
 sCsOFPay2hIyF3qSXgA/3CO17U/+/6G4wFIf73jM+XhkKn8IJK65ymhRmYTigmOS2dS+koGZY7s
 Im99RsUOYMnHAFFCEP/EGahCpKCm2Ly239IL7Le917dDgntuRoeMCOcXU2McI2HsQmG8dxawjYC
 +6zg+GetDQ6tJ9MC6YujjVF4mprSG1TIU2bmiUGl8Etc0ooieSp0oiLDwwJWa/XbNwpehnnMBbg
 0sGDOCKYRIid7uWroiAf4c1DMdo6VY5oi8nNx9xplb3i/tcXKhGu6kr6xeu9LhQ5itIBvE7gv8T
 5/Gjuj43nnf8wJ8OWUu6snSQzsaPQkSJsLKZpFNOT0QwD8LPuKAk841Szk9+
X-Received: by 2002:a05:6000:2210:b0:48d:f25f:e7a with SMTP id
 ffacd0b85a97d-48df25f0fe9mr5079710f8f.55.1792062424507; 
 Thu, 15 Oct 2026 04:07:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa9f9sm18221127f8f.19.2026.10.15.04.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:07:04 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 11:07:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
X-Gerrit-Change-Number: 1999
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1999?usp=email>
X-Gerrit-Commit: 1164885b3fb963d16f9b0649f3995618b975db64
References: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDYyNDIxMDAwLkk2Mjk0NjY1ZTM5ZGRmMDEyZjBhMzk0M2QwZTM1NjU3NmY0ZmUwMmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9075f14a83b79db0836db86c05fe13e185bf5552-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJIm-0004MO-HZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clang-format: Enable
 InsertNewlineAtEOF
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0706319716424419894=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0706319716424419894==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aX+bc8E8kag="; charset=UTF-8

--aX+bc8E8kag=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1999?usp=3Demail

to review the following change=2E
=


Change subject: clang-format: Enable InsertNewlineAtEOF
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

clang-format: Enable InsertN=
ewlineAtEOF

We had some patches recently that committed files
without newl=
ine at EOF=2E Enforce consistency=2E

Change-Id: I6294665e39ddf012f0a3943d0=
e356576f4fe02e1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
---
M =2Eclang-format
M src/compat/compat-strtok_r=2Ec
M src/openvpn/schedu=
le=2Ec
M src/openvpn/siphash=2Ec
M tests/unit_tests/openvpn/siphash_openssl=
=2Eh
M tests/unit_tests/openvpn/test_schedule=2Eh
6 files changed, 6 insert=
ions(+), 5 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/99/1999/1

diff --git a/=2Eclang-format b/=2Eclang-forma=
t
index 0823739=2E=2E23d224b 100644
--- a/=2Eclang-format
+++ b/=2Eclang-fo=
rmat
@@ -32,6 +32,7 @@
 IndentWidth: '4'
 IndentWrappedFunctionNames: false=

 InsertBraces: true
+InsertNewlineAtEOF: true
 KeepEmptyLines:
   AtEndOfF=
ile: false
   AtStartOfBlock: false
diff --git a/src/compat/compat-strtok_r=
=2Ec b/src/compat/compat-strtok_r=2Ec
index debcdd3=2E=2E4240458 100644
---=
 a/src/compat/compat-strtok_r=2Ec
+++ b/src/compat/compat-strtok_r=2Ec
@@ -=
98,4 +98,4 @@
     }
     /* NOTREACHED */
 }
-#endif
\ No newline at end o=
f file
+#endif
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=
=2Ec
index 6c60dc2=2E=2Eff243dc 100644
--- a/src/openvpn/schedule=2Ec
+++ b=
/src/openvpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {
     s->earliest_wakeup =
=3D NULL; /* invalidate cache */
     schedule_remove_node(s, e);
-}
\ No n=
ewline at end of file
+}
diff --git a/src/openvpn/siphash=2Ec b/src/openvpn=
/siphash=2Ec
index e31b708=2E=2Eb9fc5e3 100644
--- a/src/openvpn/siphash=2E=
c
+++ b/src/openvpn/siphash=2Ec
@@ -46,4 +46,4 @@
     } ret;
     siphash(=
k, length, hash_key, ret=2Eout, sizeof(ret=2Eout));
     return ret=2Ehash;=

-}
\ No newline at end of file
+}
diff --git a/tests/unit_tests/openvpn/si=
phash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh
index 0f1d=
329=2E=2E49c6a9d 100644
--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh
=
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -61,4 +61,4 @@
  */
 =
bool
 siphash_openssl_available(void *sip_context);
-#endif /* ifndef SIPHA=
SH_OPENSSL_H */
\ No newline at end of file
+#endif /* ifndef SIPHASH_OPENS=
SL_H */
diff --git a/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/uni=
t_tests/openvpn/test_schedule=2Eh
index 55dc591=2E=2E3705af9 100644
--- a/t=
ests/unit_tests/openvpn/test_schedule=2Eh
+++ b/tests/unit_tests/openvpn/te=
st_schedule=2Eh
@@ -24,4 +24,4 @@
 /** Runs the schedule test */
 void
 sch=
edule_test(void **state);
-#endif
\ No newline at end of file
+#endif

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6294665e39ddf012f0a39=
43d0e356576f4fe02e1
Gerrit-Change-Number: 1999
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--aX+bc8E8kag=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">clang-format: Enable InsertNewlineAtEOF<br><br>We had some=
 patches recently that committed files<br>without newline at EOF=2E Enforce=
 consistency=2E<br><br>Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M =2Eclang-format<br>M src/compat/compat-strtok_r=2Ec<br>M src/openvpn/=
schedule=2Ec<br>M src/openvpn/siphash=2Ec<br>M tests/unit_tests/openvpn/sip=
hash_openssl=2Eh<br>M tests/unit_tests/openvpn/test_schedule=2Eh<br>6 files=
 changed, 6 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/1999/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/=2Eclang-format b/=2Eclang-format</span><br><span>index 0823=
739=2E=2E23d224b 100644</span><br><span>--- a/=2Eclang-format</span><br><sp=
an>+++ b/=2Eclang-format</span><br><span>@@ -32,6 +32,7 @@</span><br><span>=
 IndentWidth: &#39;4&#39;</span><br><span> IndentWrappedFunctionNames: fals=
e</span><br><span> InsertBraces: true</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+InsertNewlineAtEOF: true</span><br><span> KeepEmptyLines:=
</span><br><span>   AtEndOfFile: false</span><br><span>   AtStartOfBlock: f=
alse</span><br><span>diff --git a/src/compat/compat-strtok_r=2Ec b/src/comp=
at/compat-strtok_r=2Ec</span><br><span>index debcdd3=2E=2E4240458 100644</s=
pan><br><span>--- a/src/compat/compat-strtok_r=2Ec</span><br><span>+++ b/sr=
c/compat/compat-strtok_r=2Ec</span><br><span>@@ -98,4 +98,4 @@</span><br><s=
pan>     }</span><br><span>     /* NOTREACHED */</span><br><span> }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>\ No n=
ewline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvp=
n/schedule=2Ec</span><br><span>index 6c60dc2=2E=2Eff243dc 100644</span><br>=
<span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/sche=
dule=2Ec</span><br><span>@@ -389,4 +389,4 @@</span><br><span> {</span><br><=
span>     s-&gt;earliest_wakeup =3D NULL; /* invalidate cache */</span><br>=
<span>     schedule_remove_node(s, e);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span>\ No newline at end of file</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/s=
rc/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec</span><br><span>index e31b=
708=2E=2Eb9fc5e3 100644</span><br><span>--- a/src/openvpn/siphash=2Ec</span=
><br><span>+++ b/src/openvpn/siphash=2Ec</span><br><span>@@ -46,4 +46,4 @@<=
/span><br><span>     } ret;</span><br><span>     siphash(k, length, hash_ke=
y, ret=2Eout, sizeof(ret=2Eout));</span><br><span>     return ret=2Ehash;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No =
newline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=
=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>index 0=
f1d329=2E=2E49c6a9d 100644</span><br><span>--- a/tests/unit_tests/openvpn/s=
iphash_openssl=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_o=
penssl=2Eh</span><br><span>@@ -61,4 +61,4 @@</span><br><span>  */</span><br=
><span> bool</span><br><span> siphash_openssl_available(void *sip_context);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef SIPH=
ASH_OPENSSL_H */</span><br><span>\ No newline at end of file</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH_OPENSSL_H=
 */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_schedule=2Eh=
 b/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>index 55dc591=
=2E=2E3705af9 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_sc=
hedule=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_schedule=2Eh=
</span><br><span>@@ -24,4 +24,4 @@</span><br><span> /** Runs the schedule t=
est */</span><br><span> void</span><br><span> schedule_test(void **state);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail">change 1999</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6294665e39ddf012f=
0a3943d0e356576f4fe02e1 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1999 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--aX+bc8E8kag=--


--===============0706319716424419894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0706319716424419894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0706319716424419894==--


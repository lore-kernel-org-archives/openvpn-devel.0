Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBADDCD98CE
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NtLY2IGNWg6IKulDgdYWRmwB59AeW2tQhdOOjtW6oLM=; b=QMr6TvAgXuRVVYGGlMM/enCec3
	uYixC5wB/3gyuN4OqNodu32ow06b7k3KRtmXybwAwWBHrF2LeUxgQuvnM9T49GhhLPV6GZ+SRMSQ8
	HqBmaY+Fape1MJIY3YlvK0VbqqtGJkPeJPdbOXWw8m9YDoy1PcXme/ervcBJd2GS4eH4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2cE-00007k-FE;
	Fri, 12 Jun 2026 14:12:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY2cD-00007d-JY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tHSExrIinzAE81rDNG83YBsekKAf8MV0PFkmSu8MEXs=; b=eJ5B8yoELDWuqHli49EXIA/Vis
 p984x1LKOeBO0PcYLAXiAHlUOaF98NEGI3yOmitL9Pt4l9LgUxOOAFOHsDLG2M0kwQU4+ASbkVAul
 PxwkOux8z3DfGoGZMIxSl2RP5Z+WGLspvNOgixwJ+4NHfq5Pt7JvzZ3gAH7z04Z8Ovd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tHSExrIinzAE81rDNG83YBsekKAf8MV0PFkmSu8MEXs=; b=a
 NuAjvZJ5f/NMqNcRyuCA7+HW291kTKBdxin6M46KTjKVfvPHourn1xIpHUylwjelQ4/10vRWFO8DQ
 AgjQbxbE0rbuRAm0pS4nOIrXZS2yVTXy4LWc0tuyw7yG8ALjhETggfuzB4Uu5SRpEbcyOtykO0XXn
 2MbBkfAeRpOKb3RQ=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY2cA-0001kX-EK for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:12:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so10784045e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781273515; x=1781878315; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tHSExrIinzAE81rDNG83YBsekKAf8MV0PFkmSu8MEXs=;
 b=NIf0R3xvM/PjilM2Fs2PJ2XXdBCKVLpS5YTh4rDMs9XpC5FPiiaoLaIcjIzVdXHFB2
 6j1jXVYncCw1CGoYPlMopiDKMEuHVNru87LPOlH7qJfepSgOSAsCn/ADHWJo5MHIhB7v
 vvEQ0VM6ck7aNphxTxkcmee+uNiLKrzFOhCourbeayftoYt+GNqn5V6tTgjp0d+r9NTF
 0yYOmkzGyJr4ylZgyz6aWMX0SWVIuI7E433VhTHkSBMed4k4Vk8fHEPsrVdDfB8gosq5
 EhyVhDCQz3CkC1JgNE4oNp9IHfEONydkqKxw9bcCjTkkcB4BSPT+LUBiOf75q4VsxX/g
 4cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273515; x=1781878315;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHSExrIinzAE81rDNG83YBsekKAf8MV0PFkmSu8MEXs=;
 b=plCVxOLM6+X2+2gJpPYhknv1j2nFvYPTk7V5fZpBBHJtaWqZP3ExQV2E/Gz/AbBWa6
 cZcSKCHWqXEGrChBSY3J/33HjhKY+QFx5mzTLemZSNxCQR1tCUdzQCgsziuJNZT49BpV
 pSq/0JDK/mcvDa0v5eQcevN87tn2BnX61xYHlt9I+CytXqmT/lCaNYjcJb3/JU49ZzPA
 B+thSIEQ3g+3TRLzM5PkQ6Ii6QynTdUJe+onTVo6k9Bp8Jfc2jaoABOtZwHpSusBMQ8P
 /X8XkPhqRP7U9ZgIQ8mamwYKpWiAGgnSeKBh4Xe9MAkjFIP6nxmGSjwsTkkmLif+/oOc
 +/qw==
X-Gm-Message-State: AOJu0Yz88sxRFUTRATyFbTfUS7yM6e6eizoEC9h1Wj0jEsz1fbvyzsc2
 DNKmLICAFjFmOjpkXU4bnfvMeP9QXvQ4MX7LOblfnXqV2G6KXyzVhxg7883W3XcevUFiJWEKGjE
 F9mDpT0NuGYhmXdzkacVMrZ8tGx75/Lzjp0q0nlyUI9WBCDEhnALM9LWncDUPWVBWu8ES
X-Gm-Gg: Acq92OFJEFvwW7bUqZRS/H1IwK5+Dhj7l1kZBDdVPGN6nqmunMPHPov7nYzG/MbqVkn
 Vchsl8QEjwU1gYB3A+d0oM/ovGqAb+LYQLQmy/WceiPP7aOcKq/sU0DXbxBFM0BxEi7RV0ZNJFX
 U0vLanOFXlW08uKdWlMFDkPlFyP1ctkleNzikjF/x/s6zRbAy0+nHUoKdLepx12INkMX7jNi2MU
 BqP+E/T94WvHmw8d6vEaNDgO5n1leW2xhL+9bViZ6cy5l7EauuhqWprRSuxX8S0+YftZggJzAVF
 aS93yff7xPV3FuZ7Yf8ISdiadtKuag+dcQBKjYixmCNWPQ8v6TNfZRmijYFNAfQWchkVQBfY8tV
 9y8DHJbTOdJPEpJXYyfNtjLLIOgudCvDHgiVIeKS3SS05C63we4g9cs3/TfmoHnr3tlV+k2mX6s
 QgLfsHYEVLEX16pZfktB7JM1eKmwsNcyMoE5blsP6sCUJ0UqldkHmKl9afkhQGoyLF3QNXu+Z6q
 65ch0mEBPcgj/u323j7nyrnmq23ut8S5gfJhZysFDQC16Wp/+PHd7jA0lysD5cSxmShULkc6dKH
 fLPx92uuMdOzPZTt7505i8Gk
X-Received: by 2002:a05:600c:314a:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-490ec503f0cmr37365355e9.31.1781273514271; 
 Fri, 12 Jun 2026 07:11:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea83da91sm77962665e9.10.2026.06.12.07.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:11:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 14:11:52 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
X-Gerrit-Change-Number: 1293
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1293?usp=email>
X-Gerrit-Commit: 8d23076babece34581ae9396b6280eb34c86c422
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYxMDYzODIwMDAwLkljYzMxYjdmYTBkYTg2MjIwZGY0NTU1MmFlY2MxNWRjNmM3NjljZDU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a07182af7d038af54017aaf859b34404c6cafbff-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY2cA-0001kX-EK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Fix conversion
 issues related to timeout in send_auth_pending_m...
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6684736470717576936=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6684736470717576936==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tWSJS+1a6RA="; charset=UTF-8

--tWSJS+1a6RA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#13) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by plaisthos


Change subject: push: Fix conversion issues related to time=
out in send_auth_pending_messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

push: Fix conversion issues related to timeout in se=
nd_auth_pending_messages

Add additional checking to make sure that the req=
uired
casts are safe=2E

Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd=
54
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1293
Message-Id: <20260612113309=2E29903-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37184=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/push=2Ec
M src/openvpn/ssl_verify=2Ec
2 file=
s changed, 13 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/93/1293/13

diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec
index 564ce86=2E=2Ee391147 100644
--- a/src=
/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -429,11 +429,6 @@
     gc_f=
ree(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 boo=
l
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_sessi=
on *session,
                            const char *extra, unsigned int ti=
meout)
@@ -449,7 +444,12 @@
     /* Calculate the maximum timeout and subtr=
act the time we already waited */
     unsigned int max_timeout =3D
       =
  max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehands=
hake_window);
-    max_timeout =3D max_timeout - (now - ks->initial);
+    =
time_t time_elapsed =3D now - ks->initial;
+    if (time_elapsed < 0 || tim=
e_elapsed >=3D (time_t)max_timeout)
+    {
+        return false;
+    }
+ =
   max_timeout -=3D (unsigned int)time_elapsed;
     timeout =3D min_uint(m=
ax_timeout, timeout);
 
     struct gc_arena gc =3D gc_new();
@@ -734,6 +73=
4,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+=

 static bool
 send_push_options(struct context *c, struct buffer *buf, str=
uct push_list *push_list, int safe_cap,
                   bool *push_sent,=
 bool *multi_push)
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ss=
l_verify=2Ec
index 0804d2d=2E=2E31ecf13 100644
--- a/src/openvpn/ssl_verify=
=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -922,8 +922,9 @@
             buf_=
chomp(iv_buf);
             buf_chomp(extra_buf);
 
+            errno =3D =
0;
             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);
-    =
        if (timeout <=3D 0)
+            if (timeout <=3D 0 || (unsigned lo=
ng)timeout > UINT_MAX || errno)
             {
                 msg(M_WARN,=
 "could not parse auth pending file timeout");
                 buffer_list=
_free(lines);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1293?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc=
31b7fa0da86220df45552aecc15dc6c769cd54
Gerrit-Change-Number: 1293
Gerrit-Pa=
tchSet: 13
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--tWSJS+1a6RA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #13</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">push: Fix conversio=
n issues related to timeout in send_auth_pending_messages<br><br>Add additi=
onal checking to make sure that the required<br>casts are safe=2E<br><br>Ch=
ange-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1293<br>Message-Id: &lt;20260612113309=2E29903-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg37184=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push=2Ec<br>M src/openvpn=
/ssl_verify=2Ec<br>2 files changed, 13 insertions(+), 7 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/93/1293/13</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/push=2Ec b/src/openv=
pn/push=2Ec</span><br><span>index 564ce86=2E=2Ee391147 100644</span><br><sp=
an>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</s=
pan><br><span>@@ -429,11 +429,6 @@</span><br><span>     gc_free(&amp;gc);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> bool</span><br><span> send_auth_pending_messages(struct tls_multi *tls_=
multi, struct tls_session *session,</span><br><span>                       =
     const char *extra, unsigned int timeout)</span><br><span>@@ -449,7 +44=
4,12 @@</span><br><span>     /* Calculate the maximum timeout and subtract =
the time we already waited */</span><br><span>     unsigned int max_timeout=
 =3D</span><br><span>         max_uint(tls_multi-&gt;opt=2Erenegotiate_seco=
nds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    max_timeout =3D max_timeout - (now - ks-&gt;i=
nitial);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    time_t =
time_elapsed =3D now - ks-&gt;initial;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (time_elapsed &lt; 0 || time_elapsed &gt;=3D (tim=
e_t)max_timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    max_timeout -=3D (unsigne=
d int)time_elapsed;</span><br><span>     timeout =3D min_uint(max_timeout, =
timeout);</span><br><span> </span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>@@ -734,6 +734,11 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static bool</span><br><span> send_push_options(struct context *c, s=
truct buffer *buf, struct push_list *push_list, int safe_cap,</span><br><sp=
an>                   bool *push_sent, bool *multi_push)</span><br><span>di=
ff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><b=
r><span>index 0804d2d=2E=2E31ecf13 100644</span><br><span>--- a/src/openvpn=
/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br>=
<span>@@ -922,8 +922,9 @@</span><br><span>             buf_chomp(iv_buf);</=
span><br><span>             buf_chomp(extra_buf);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            errno =3D 0;</s=
pan><br><span>             long timeout =3D strtol(BSTR(timeout_buf), NULL,=
 10);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
timeout &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (timeout &lt;=3D 0 || (unsigned long)timeout &gt; UINT_MAX ||=
 errno)</span><br><span>             {</span><br><span>                 msg=
(M_WARN, &quot;could not parse auth pending file timeout&quot;);</span><br>=
<span>                 buffer_list_free(lines);</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1293?usp=3Demail">change 1293</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1293?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1293 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--tWSJS+1a6RA=--


--===============6684736470717576936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6684736470717576936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6684736470717576936==--


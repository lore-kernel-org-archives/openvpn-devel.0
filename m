Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D669ECD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zu/z/OvnGSX4jXLiVY/uSIcPoGLt1YoIy2RbU0wzr8E=; b=Y++kLcAEymXqjULTUgFQUyQq8B
	zceqlCUyzYkKWOqdXljMdbVlYLZ/kGve9RRpAlmJL8g4bcyMcKMAsDCzdvQt4RfE4z9q9Yxhf9l/v
	/00wgsg6Yg0xCLgLZAQdEr2KwjlbucC7MttHfQbr70teNQEicfJw/IiXiTDUCWHUCZeY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXyW3-0002VH-CG;
	Fri, 12 Jun 2026 09:49:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXyVl-0002Tc-KV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fpfCP+UVW4CWVeOzX52uQhoeK2Jnk/sYF/eclgQre1s=; b=IYjejl1rsdEUIvIj87ossvS3zq
 8rkwNo/CyxELGf/Vb2fygfCBkxazPBMKqGQJ4rPYgCsKORtLSho49H9mUtZqggOWp12F4ogdcNDOb
 hUwFpjrOl541B6KqFv9SgaRNZKg+7j/p1opDgZfowEC+72zg6lUa5Rml4b2FDn3usDZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fpfCP+UVW4CWVeOzX52uQhoeK2Jnk/sYF/eclgQre1s=; b=R
 w1OKJwWRNjxyranJHagrrdBh23fQFVXueifJMgvxzPW2iJij9hKyNNF9Ija5eVwyj7TRNt0i6SnPU
 rkfjcCN4z76vWnFh70DDOm+h532mo1nJS7MmxEEacumZ48f7BShltZ8j6T2ygY1mKYpivTyizPOXu
 6RrNGEysS70/K3c4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXyVZ-0005Fz-NF for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:49:04 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso7857765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781257731; x=1781862531; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fpfCP+UVW4CWVeOzX52uQhoeK2Jnk/sYF/eclgQre1s=;
 b=GS5guJ6oaYb5ngLuXAnrjIO9nM6DHw941kHOn6JT+L3WiGb3rKahQ0R5jMdso7VKp8
 i9mAA3faAX1QYhFFgLga0/L70Vx04icL69D7P3F247fBP1U3kZVb1P47wBazDNzB6/Su
 yKqUpVyWfpLvWf0NCVbt2VZkvHRGq7cgmDjln3FGZVgHUTKC3ID0lvnzUJlEBCsc5h5m
 oKkbpa+LUblG1FTzw5tYUhYgqKi/QFvkNkSTRDUDgHccxvOvycFhgC9FRLNsZYfqdALd
 A7+m+9iRiIao28wppx1FIfbKT7aaq85pbqYleZ/vsAue/Z04E7b61di27PGmXKVVcT3c
 /Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781257731; x=1781862531;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fpfCP+UVW4CWVeOzX52uQhoeK2Jnk/sYF/eclgQre1s=;
 b=gFCkgSJNvUX75+pDJAOTRC2p31XqLqnXOF54fzhwq3SQ2fDypD50aI8JRG7Ot6n9Du
 fACbopXpFH+RKHE14GByqyETWQ7F/bvO74Ut62rAI8+NovcANP04NKUcjwpo7sh3hqKh
 sRlriSRYRK9hlt3AhGZ32ipyEPhCxU9Zv+LaRJpMDE0YfmYLc9ETFmLsDZhjSFnRynmW
 c1T29d8NV7CeXtUR1sfyJludEQ8G65tyd7kJ1Op0MkjQWcD8Wq45DQ+EVzHXYQgh80XD
 VS9ZcEKpLToEhMlXYFDfjRo9sDyJSv7BCoAtwtR5QjsFL0CRCImTIo/ySvPFEJvT98oG
 0h0A==
X-Gm-Message-State: AOJu0YxkQtS+deQ3n209bBpECoideJ1mvOW8hUiLBVgCVG8buYExap6r
 Ksx6m+PBFuJUU954rBH66dOvA/qTuPxB4OPSWnOn9480iKDbCMwWQO9gpIwBU2IJrM5jEDrmw0t
 Zr2JK2eQpY+1kviNUh7n6NNMnHo3VXqcE1LDviep3AOZR4fhKdm8dIh/tzxE6FLcFLpSaokxa5z
 lojtPv7Q==
X-Gm-Gg: Acq92OEUIXAASONrtXmYtRi9KkAAPlJMlNQ19hnpOQ0Itqu0bazQHCcbrjhR+xyoD8q
 fz8GYkJJ/rxucBXmZ9AjuO9MS3r4rfOI6+NYEGUPeimY1bxx6+LgW/f0jxtACnxVLmCtkrEa3q0
 1ifu1oHnYIDvN9OCZYdbAdit8GtWGzaZWfmRWepwiNnrSDYXqXQpWQQJXe4YjFAZ9fGYkANMA+1
 n0a3HeRg7hC/MlM+2IUuod9tzlolxp332PXiGc+o10ZjAC6l0NXkTm+WVtBgu/C1Hi3qAxfpdfX
 QKeQRST/VFbscXQWaY4CqAlTMuoOwPQuSC4vRDPiNZt1iOSH18mIgWlyt24uHLHL2sMQ+BvRLw7
 V+adF53lSvojaXmzoSVT0Ke8DW2LnnRBliocNhxoGFg8XF2K+tyOaB2m6t9GDd+/3Qu1PJbpdxX
 k6wKYDXaIqFw5Oxdip9ttrH4eNqKQmqulmt9v0fl9g5XfDXx91+78GppKg2ZkWyMP2k5C7lKhIW
 yTiGpcJHhSFabhe6+YLe3XV+VfbQQLbrYgk/Ha/Y3SvSxYVRimZRYLplqxartRmLNRPbjVCc4iS
 0KDSjC/E2cVRFF+nVxAAm8hJ
X-Received: by 2002:a05:600c:3422:b0:490:c682:e37d with SMTP id
 5b1f17b1804b1-490ec5214d6mr14964955e9.32.1781257730421; 
 Fri, 12 Jun 2026 02:48:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm4211210f8f.18.2026.06.12.02.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:48:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 09:48:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
X-Gerrit-Change-Number: 1293
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1293?usp=email>
X-Gerrit-Commit: 7949db0a820ba50e21c2a301a687ecf0c40f99a0
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYxMDYzODIwMDAwLkljYzMxYjdmYTBkYTg2MjIwZGY0NTU1MmFlY2MxNWRjNmM3NjljZDU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0e9c1c1059acdc3bd488e9bc93228ad9134819b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXyVZ-0005Fz-NF
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5869037765377402982=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5869037765377402982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WtEdCwVUp+c="; charset=UTF-8

--WtEdCwVUp+c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

Hello cron2, =
plaisthos, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail

to look at the new pa=
tch set (#12)=2E


Change subject: push: Fix conversion issues related to t=
imeout in send_auth_pending_messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

push: Fix conversion issues related to timeout in=
 send_auth_pending_messages

Add additional checking to make sure that the =
required
casts are safe=2E

Change-Id: Icc31b7fa0da86220df45552aecc15dc6c76=
9cd54
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/=
openvpn/push=2Ec
M src/openvpn/ssl_verify=2Ec
2 files changed, 13 insertion=
s(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/93/1293/12

diff --git a/src/openvpn/push=2Ec b/src/openvpn/=
push=2Ec
index 564ce86=2E=2Ee391147 100644
--- a/src/openvpn/push=2Ec
+++ b=
/src/openvpn/push=2Ec
@@ -429,11 +429,6 @@
     gc_free(&gc);
 }
 
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma =
GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 send_auth_pending_me=
ssages(struct tls_multi *tls_multi, struct tls_session *session,
          =
                  const char *extra, unsigned int timeout)
@@ -449,7 +444,1=
2 @@
     /* Calculate the maximum timeout and subtract the time we already=
 waited */
     unsigned int max_timeout =3D
         max_uint(tls_multi->o=
pt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_window);
-    max_=
timeout =3D max_timeout - (now - ks->initial);
+    time_t time_elapsed =3D=
 now - ks->initial;
+    if (time_elapsed < 0 || time_elapsed >=3D (time_t)=
max_timeout)
+    {
+        return false;
+    }
+    max_timeout -=3D (un=
signed int)time_elapsed;
     timeout =3D min_uint(max_timeout, timeout);
 =

     struct gc_arena gc =3D gc_new();
@@ -734,6 +734,11 @@
     }
 }
 
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pr=
agma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 send_pus=
h_options(struct context *c, struct buffer *buf, struct push_list *push_lis=
t, int safe_cap,
                   bool *push_sent, bool *multi_push)
diff=
 --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0804=
d2d=2E=2E31ecf13 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/=
ssl_verify=2Ec
@@ -922,8 +922,9 @@
             buf_chomp(iv_buf);
        =
     buf_chomp(extra_buf);
 
+            errno =3D 0;
             long ti=
meout =3D strtol(BSTR(timeout_buf), NULL, 10);
-            if (timeout <=
=3D 0)
+            if (timeout <=3D 0 || (unsigned long)timeout > UINT_MAX=
 || errno)
             {
                 msg(M_WARN, "could not parse aut=
h pending file timeout");
                 buffer_list_free(lines);

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc31b7fa0da86220df45552=
aecc15dc6c769cd54
Gerrit-Change-Number: 1293
Gerrit-PatchSet: 12
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>

--WtEdCwVUp+c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>flichtenheld <strong>u=
ploaded patch set #12</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">push: Fix conversion issues related to timeout in send_auth_pendin=
g_messages<br><br>Add additional checking to make sure that the required<br=
>casts are safe=2E<br><br>Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769c=
d54<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>=
---<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>2 files ch=
anged, 13 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1293/12</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>i=
ndex 564ce86=2E=2Ee391147 100644</span><br><span>--- a/src/openvpn/push=2Ec=
</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -429,11 +429=
,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> sen=
d_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *se=
ssion,</span><br><span>                            const char *extra, unsig=
ned int timeout)</span><br><span>@@ -449,7 +444,12 @@</span><br><span>     =
/* Calculate the maximum timeout and subtract the time we already waited */=
</span><br><span>     unsigned int max_timeout =3D</span><br><span>        =
 max_uint(tls_multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2E=
handshake_window);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 max_timeout =3D max_timeout - (now - ks-&gt;initial);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    time_t time_elapsed =3D now - ks-&gt=
;initial;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ti=
me_elapsed &lt; 0 || time_elapsed &gt;=3D (time_t)max_timeout)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    max_timeout -=3D (unsigned int)time_elapsed;</span><br=
><span>     timeout =3D min_uint(max_timeout, timeout);</span><br><span> </=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -73=
4,6 +734,11 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br>=
<span> send_push_options(struct context *c, struct buffer *buf, struct push=
_list *push_list, int safe_cap,</span><br><span>                   bool *pu=
sh_sent, bool *multi_push)</span><br><span>diff --git a/src/openvpn/ssl_ver=
ify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 0804d2d=2E=2E31e=
cf13 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><spa=
n>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -922,8 +922,9 @@</spa=
n><br><span>             buf_chomp(iv_buf);</span><br><span>             bu=
f_chomp(extra_buf);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            errno =3D 0;</span><br><span>             lon=
g timeout =3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (timeout &lt;=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (timeout &lt;=3D=
 0 || (unsigned long)timeout &gt; UINT_MAX || errno)</span><br><span>      =
       {</span><br><span>                 msg(M_WARN, &quot;could not parse=
 auth pending file timeout&quot;);</span><br><span>                 buffer_=
list_free(lines);</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail">change 129=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Icc31b7fa0da86220df45552aecc15dc6c769cd54 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1293 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--WtEdCwVUp+c=--


--===============5869037765377402982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5869037765377402982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5869037765377402982==--


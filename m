Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ACCC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5Zo+TRCrDJTLne55J4FgRvBp7jh1bZzA87wBWE559I=; b=PV9b0GCcN5UV1wOtldy8GcqpBI
	z7t67tSFkGtBnDLptHZQeUWxOOKzhF3q7AX3No2VFOcge1m3zg+uWtIHT6CQwP0H5A5eJgpYCOYCF
	gAdvEwwlN5L8JMkJNEKtkG5PPL3e9w22fVqPNXTBlR+FKrMMgSlGXnweM1FAX4o9tXU8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclh-0000rK-AW;
	Tue, 14 Jul 2026 13:01:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclf-0000rB-Ty
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FAyC11sIoSeG0ZLjzofYJjmqRy8gJyP93XKcufRLPss=; b=NEruuiiBFcp/dnOwBcnDPGpQOV
 AsignmPx6qYmCbz0TJGYC+iJbPngURhS9jBgVrRmrRC9CmJJTpGfS23NPsLDuoqusxCfkYUIJedEw
 nBAm2UIukpBJRpmaDPBq5aipy+wDkC8u8VPgu5LBdLndOMQCWunBfFA2TOJUhegmw0zw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FAyC11sIoSeG0ZLjzofYJjmqRy8gJyP93XKcufRLPss=; b=f
 XwBN7QwJb9lJYSNA0G8oy3kxcG0c+RS4gr+GPFkWFVfIRz5EUQCU9670sTrCxuE1R291lAeBXcsCX
 Obl3XwzMFX9pquLA1TMJCQAeP1fJfhXccwC8waUEtpUH4wN0cHYiFafn5k+wLezffODA9RJx8kceN
 O5Mj4HhEQmf5cIeQ=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjcla-0002AE-Ls for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:45 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so11298215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034091; x=1784638891; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FAyC11sIoSeG0ZLjzofYJjmqRy8gJyP93XKcufRLPss=;
 b=NdfL8HH9CdVIrq8PbzrmcUR/VSEgvejWS7RprIc8pYyeIkB6dT7opt2ZLE5rOcOsh6
 j0+Z8socAKWq2BPbHxOomwie3I31zlxoKcyLmbBVabjFaGhveHLLApbfgCSSu1fgN272
 bL9S1A9PmOmYf+I5sMANn7Ldh3Klhpskczv7KQpxS8uAe0vv/vThn+iWLncUUFb+iN1I
 a8UncqUFwkG+7R4AQoH/y8Xw+XdsVWKSN3NEMiJUou57jjQ7Az5NTQ7kXJP3dOr/j8vL
 IkY/3kJ8bIE/9lVYIbHRjfW3Vjo1XLAFMLA4f+qcehrt0zu3IZ3uy7mhWowaHltoe8qF
 IvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034091; x=1784638891;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FAyC11sIoSeG0ZLjzofYJjmqRy8gJyP93XKcufRLPss=;
 b=HlOfDZa7++wQyYp/RH3WBQ5unoKjFs9WCghT3WGRidIXZyRRGiDAPIp60YXraSZDxu
 yNGF0tqzehWSH0NroFQyLFZgLcNjMLZqgbl+iA474yx6vupxaoYF1tZl7Z4nrKtQaHX8
 D94A2sJ91GNr57deAPyUE1FFsLMlZ3yC8oL3eO5CICsxj2FLhWlhKKu7i5z1oQkHOirD
 54tEq8/6x68lnQ1DPqaKiIm3M/ORl6YkvBvFrRVGe1JSja+L1NQXRpQblYcsTp8KJElJ
 lqrbUIDK3ERGCMG6qiHLeifT/RC7wnfTzPpZNCeWpuTe/KtM3SDqGfhycyp+iJgU5v8r
 +jsg==
X-Gm-Message-State: AOJu0YzgyK/KRnYObMiyxUsH3M7QqDlk5VXMFrdjPeyg3cySl1mHfmix
 fJH5so2p2ukA9Z6GlGlk+6N2xXoYyay+/X7TWvESgWij4ZvuyM8SUGrTykYTtV+Fl0gsC7x+fuR
 7yaah4EcKk1QS3fxkgw3iYf5SX1P46gvSMVz5q0TNFPfwo9GYtSRjyQlhS1/GZRKKhX3/W02V8Q
 B4C/NrKw==
X-Gm-Gg: AfdE7cl9VQ1cR+IBKQ1bIi1AKSrrMbu0lqnTHO4QJ/4EPwwgG/ljRFWnd4cEi5nYbfT
 rI4xzFvpyo+0WRVHCdwfBGRDT9sPlkSi5CjLb7SRvSS0kLxQvba51tRAw1CaPFQWzln42zT7T2R
 XTBrSJ0Lk7rIdgnWoQDl/yrCRqRyELD/oin1iqrrOcVdJAfCRXQdTXn4hhplCvpCohuB4+Qsdhi
 gqW4BBH5dfr2ywVSLd1oupeOsWFTjgJMWJtNhvdHOk88ASxW9UgPYLJRUt7e0zyYiHQPqfxZzn9
 bA+1vGuY9ruXTN37uy4msr7NxxJJcJWey0Qa/tlM9VrvA4w6qW0Ctyi7Jb79BoNaBsceLARX6oq
 ghx2hFVB7DygJFH+RLcodwoHD4iXKKf1eCxrOc9p1yQf6Dhg302BTXfijVCdriyWO0OvVi2Bo7M
 kAcTxsH8O+IJwAmtPbkVFxJOBKMpOQtzR9avuQBukFRqNv9I98HWTWKi8dyhLMOv0+qQJ4Juf2C
 MyaQKSn6uGA+RYPSjdfby9svZvb4Bo773BVNivztR9YdJrC/9Kx73VzlOS+bAb7IaphwUBIJFXr
 0IqjfILB++Ro9A==
X-Received: by 2002:a05:600c:3222:b0:493:b36b:4933 with SMTP id
 5b1f17b1804b1-493f2a85bdfmr133533345e9.3.1784034090657; 
 Tue, 14 Jul 2026 06:01:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0e4sm8546046f8f.4.2026.07.14.06.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 80db22e527814dc2b948f04afb83b6e93de5395d
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bf35f39a37b95d611002a9ecd4542fa8b5bfcaa7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjcla-0002AE-Ls
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_udp_real method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7217866624024532254=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7217866624024532254==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CIiJEt35q3k="; charset=UTF-8

--CIiJEt35q3k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1725?usp=3Demail

to look at the new patch set (#4)=
=2E


Change subject: Extract multi_get_instance_udp_real method
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract multi_get_inst=
ance_udp_real method

This is just a small refactoring to make the code a l=
ittle bit
better organised=2E

Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad=
42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn=
/mudp=2Ec
1 file changed, 25 insertions(+), 8 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/4

diff --git =
a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2Ed22c53b 10=
0644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -205,7 +205,6=
 @@
 handle_connection_attempt(struct multi_context *m,
                   =
        struct link_socket *sock,
                           struct mroute_=
addr *real,
-                          const uint64_t hv,
                 =
          struct hash_bucket *bucket)
 {
     struct hash *hash =3D m->hash=
;
@@ -236,6 +235,7 @@
             mi =3D multi_create_instance(m, real, so=
ck);
             if (mi)
             {
+                const uint64_t hv=
 =3D hash_value(hash, real);
                 hash_add_fast(hash, bucket, &=
mi->real, hv, mi);
                 mi->did_real_hash =3D true;
           =
      multi_assign_peer_id(m, mi);
@@ -265,6 +265,28 @@
 }
 
 /**
+ * Looks=
 up an multi instance by its real address (IP and port)
+ * @param m     mu=
lti context
+ * @param real  Address to look up
+ * @return      instance m=
atching the address, NULL otherwise
+ */
+static struct multi_instance *
+m=
ulti_get_instance_udp_real(struct multi_context *m, struct mroute_addr *rea=
l)
+{
+    struct hash *hash =3D m->hash;
+    struct hash_element *he;
+  =
  const uint64_t hv =3D hash_value(hash, real);
+    struct hash_bucket *bu=
cket =3D hash_bucket(hash, hv);
+    he =3D hash_lookup_fast(hash, bucket, =
real, hv);
+    if (he)
+    {
+        return he->value;
+    }
+    retur=
n NULL;
+}
+
+
+/**
  * Get a client instance based on real address=2E  If
=
  * the instance doesn't exist, create it while
  * maintaining real addres=
s hash table atomicity=2E
@@ -280,7 +302,6 @@
 
     if (mroute_extract_ope=
nvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=
=2Elen > 0)
     {
-        struct hash_element *he;
         const uint64_=
t hv =3D hash_value(hash, &real);
         struct hash_bucket *bucket =3D h=
ash_bucket(hash, hv);
         uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
@=
@ -317,17 +338,13 @@
         }
         if (!v2 || peer_id_disabled)
     =
    {
-            he =3D hash_lookup_fast(hash, bucket, &real, hv);
-     =
       if (he)
-            {
-                mi =3D (struct multi_instanc=
e *)he->value;
-            }
+            mi =3D multi_get_instance_udp_re=
al(m, &real);
         }
 
         /* we have no existing multi instance f=
or this connection */
         if (!mi)
         {
-            mi =3D hand=
le_connection_attempt(m, sock, &real, hv, bucket);
+            mi =3D hand=
le_connection_attempt(m, sock, &real, bucket);
         }
 
 #ifdef ENABLE_=
DEBUG

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37ade55d76=
74c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 1725
Gerrit-PatchSet: =
4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--CIiJEt35q3k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Extra=
ct multi_get_instance_udp_real method<br><br>This is just a small refactori=
ng to make the code a little bit<br>better organised=2E<br><br>Change-Id: I=
37ade55d7674c68dd98cf4dfde35c4ad42e20d39<br>Signed-off-by: Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 file changed,=
 25 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9=
acf297=2E=2Ed22c53b 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span=
><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -205,7 +205,6 @@</=
span><br><span> handle_connection_attempt(struct multi_context *m,</span><b=
r><span>                           struct link_socket *sock,</span><br><spa=
n>                           struct mroute_addr *real,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                          const uint64_t h=
v,</span><br><span>                           struct hash_bucket *bucket)</=
span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</s=
pan><br><span>@@ -236,6 +235,7 @@</span><br><span>             mi =3D multi=
_create_instance(m, real, sock);</span><br><span>             if (mi)</span=
><br><span>             {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const uint64_t hv =3D hash_value(hash, real);</span><=
br><span>                 hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv,=
 mi);</span><br><span>                 mi-&gt;did_real_hash =3D true;</span=
><br><span>                 multi_assign_peer_id(m, mi);</span><br><span>@@=
 -265,6 +265,28 @@</span><br><span> }</span><br><span> </span><br><span> /*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Looks up an mul=
ti instance by its real address (IP and port)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param m     multi context</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param real  Address to look up</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return      instance=
 matching the address, NULL otherwise</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static struct multi_instance *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+multi_get_instance_udp_real(struct multi_context *m, struct mr=
oute_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash=
 =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct hash_element *he;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const uint64_t hv =3D hash_value(hash, real);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash=
_bucket(hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   he =3D hash_lookup_fast(hash, bucket, real, hv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return he-&gt;value;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span>  * Get a client instance based =
on real address=2E  If</span><br><span>  * the instance doesn&#39;t exist, =
create it while</span><br><span>  * maintaining real address hash table ato=
micity=2E</span><br><span>@@ -280,7 +302,6 @@</span><br><span> </span><br><=
span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec=
2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct hash_element *he;</span><br><span>         const uint64_t hv =3D =
hash_value(hash, &amp;real);</span><br><span>         struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);</span><br><span>         uint8_t *ptr =3D =
BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -317,17 +338,13 @@</spa=
n><br><span>         }</span><br><span>         if (!v2 || peer_id_disabled=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            he =3D hash_lookup_fast(hash, bucket, &amp;real, hv);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (he)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                mi =3D (struct mul=
ti_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            mi =3D multi_get_instance_udp_real(m, &amp;real);</span><br><sp=
an>         }</span><br><span> </span><br><span>         /* we have no exis=
ting multi instance for this connection */</span><br><span>         if (!mi=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            mi =3D handle_connection_attempt(m, sock, &amp;real, hv,=
 bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  mi =3D handle_connection_attempt(m, sock, &amp;real, bucket);</span><br><=
span>         }</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ade55d7674c68dd=
98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--CIiJEt35q3k=--


--===============7217866624024532254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7217866624024532254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7217866624024532254==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA925C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KTcxWxVvmiO1BDmtGC0A3B0XaxdqxtUJaF3pgkGAxM=; b=R8JsIj+hOsualH9hXLvMZGdDM8
	Y/rCVgaUfuU8COJQSy9MNbkSfRHiNNFMwzZIon2xmpGKikbd6Ljw0vqL0VP41/MeGpVXsGfEKOZUl
	BWP27CpeMqBwNlHpx1rjHh0oDSvemVDxeDK56DvbSFApDBdTU3X3ndFd8235NcOcwCiU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYjB-0007fW-9K;
	Thu, 13 Aug 2026 16:56:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYj8-0007fP-MR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vEd0s8dk70IprBnwe3TUyPJ10YLDE2VU8yDxlicpASI=; b=kFOfS0P1yMIbuiFtZ5sR3GTAYD
 LjFqIm4NYlbRQ8BwKKTsTgIZXDl97vmBY7gZ/G0svftSIaO+kbyTO/KULM0QN5vFOXZLK1RQSsxdx
 bVY1HXnw4lDQlVqZR1/EQuqN30bbo6NLClDy36fiEPl+qfUBC2N2631U+eDsJSq2/xIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vEd0s8dk70IprBnwe3TUyPJ10YLDE2VU8yDxlicpASI=; b=C
 jRPJwGk5+BLu07NOA4yCGHm7hbxgzo08h4rqS7WH/2kmGNJm0tVvaZ2OHSFXkwX7tAvTXMNSXMLuk
 7bFDbn3fbI3BSRTV/SYlfz7Pi6gp4lffbveTMx2uS/ngE0H47MpqnzFBrhyhZHZbRjXQJhxfdfY5Y
 6UWvT2kUPwBzatFQ=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYj8-0004yg-9L for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:56:23 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso2124685e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786640176; x=1787244976; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vEd0s8dk70IprBnwe3TUyPJ10YLDE2VU8yDxlicpASI=;
 b=XQjpwSTm0QmpQKlOH3VJ5J6aXauppgr7zNtrgZMNj7IpIQD4BoyiWac60Qf4MKA1Zx
 7QFo6HVYDqhJPgYJzMcePPgOH2gwRN/ZKa9l2fHEER82qMu1/mpeeF75xoRk+PM2q1AM
 7CT6ejkd72IuzBJNYmOITh0QiGwnJ25VHqWjTjBTcQgBIeoxHxM7KvLO6Gg2ABeF6v70
 7XvKLuqdTy7CmnyOg69j0ojX6VGxHyvnZo43SHxmIOdYC5vMCXJNu0WNWxmhV2E4Pj2X
 bjMirv/VlGAKySme/QajzKhSLB/VhyFNH0gKoqpzCBVieteRQWQMXeauvNZjpoVXA1Ej
 xI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640176; x=1787244976;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vEd0s8dk70IprBnwe3TUyPJ10YLDE2VU8yDxlicpASI=;
 b=H0Yyhf6M0sm61iJlqDQkImrvTm7RuHt43it9X9gWu6n0eI9CmLHmBGSj/abwrqrBUT
 Ex4iQ41o/nWgOgj9AUqDRNPSQ0MD5yKPYzM4US2kxfvIHldJD/ZFmvF4PmPpVkmqLmu4
 GdJuieRVFzfqzOaARBeIgHaiZcuU3TiQ6OfjUmzHQqSReckJmOruSOMCtLeQ5msByx3X
 HqNEyauO+RMTHpBWM2Ll5MIA32Sz6sZlyBQ1IICM0OFKwfBahx846ks4w+gVJ+MFfeYk
 QYhe5AqNPNb+0Ql3WT3JRE8CPReEqWI8LnWld1ZoFukD1gYAS7sTTugSU5Yfaoqy27lV
 gRDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYJXsccgfyir2Noo1Yj39LC4+gN3cnAXZ0XnBDEzDI8233ucr/SzD7cyN3rCIiVDQATC6aqavbrMF9fDfz@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwKlrASzBVAeyJdrijLDQ/fw1Kn3Y/WtM4duYinuCMsRC35t+DZ
 18WnTSnMnGj40EjDM0zNQ/t9slJjKhVoTXrrIlt/nZxDeEhIgVCdmT4EebrKTZ6/KhqPvnGING8
 +i1VgCC1OxI3PsnKva3T1urgX6mtsIoOresWhgVvtdzNTJfQ0AS1GEljeDRPqhyO9aTOlEFB2RE
 kjTWAA5g==
X-Gm-Gg: AR+sD11OnSARdVvOZ3uOxaiqSfQVA+3E86F1WZIciX5ZQNwb/AlZptDXQZ6ymFTOR3E
 mdTohrkgFeeUF7djPMyzdJQ6NMq6tLtSErWc1w1sfStk1+uUBkpT8K9cuHGqH+QJ7EUrYdcWi7E
 aT3e8uRZnHhR+lpvnooePe5mNFovK7H79X2PNVwEvVb73SuP+eGayldE3pb3WPdD7uEP8JQgk3T
 6TF2kPO2bOxSTn1HN37iGKl5gtC8Evf5Kmol1WuVdC6DBhXBsEB7r4+TD3l+eKh4Snt1b5rQQrf
 6fBbTfei2t+4tDI6Sxc+BXChIa2+m054fDlnTL/d4jvPD4oIpmPHNETWO/xMkV14HMam3lMk6ge
 t6pCDT5xd6ckSM0lGcACaRuu9vG/UcvJWO1Tfu2JgEc8eymQdCJ2aud9V+uwHIoaXAPfaBTfAjz
 6suOLAeHOg5UOg0WbNvSzZWk+jOI5IW1rv7WIeP3cVl0MKrqUw0h93dX/vDERmipWSs++/G56vB
 W0j+K1+HsYNwf2lWSN/FuOtgLw2W1H4XF3Jig0HUPGd1S4aWsnQS5Iv+0VVq9VwVG4JusUgqw+Q
 EWdLOp3vAZweVdetN/XhzFvvD3IojUsT0qnfqvLiJN7JEm1s3Qs=
X-Received: by 2002:a05:600c:35c1:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499821bd037mr97323495e9.3.1786640175461; 
 Thu, 13 Aug 2026 09:56:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998212a3a1sm76167875e9.6.2026.08.13.09.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:56:15 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:56:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: ac70ce4ad161b3840edbb4e9d89fb979b06d6562
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a49b2b6f82fad7148db2acf2f090f733b99e1e6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYj8-0004yg-9L
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4072396300650484274=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4072396300650484274==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UJKQJ8imrmk="; charset=UTF-8

--UJKQJ8imrmk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_udp_real=
 method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extr=
act multi_get_instance_udp_real method

This is just a small refactoring to=
 make the code a little bit
better organised=2E

Change-Id: I37ade55d7674c6=
8dd98cf4dfde35c4ad42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>=

Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725
Message-Id: <20260731100844=2E3467-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38096=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
1 file changed, 25 inse=
rtions(+), 8 deletions(-)




diff --git a/src/openvpn/mudp=2Ec b/src/openv=
pn/mudp=2Ec
index 2be085f=2E=2E0979002 100644
--- a/src/openvpn/mudp=2Ec
++=
+ b/src/openvpn/mudp=2Ec
@@ -219,7 +219,6 @@
 handle_connection_attempt(str=
uct multi_context *m,
                           struct link_socket *sock,
=
                           struct mroute_addr *real,
-                     =
     const uint64_t hv,
                           struct hash_bucket *buck=
et)
 {
     struct hash *hash =3D m->hash;
@@ -250,6 +249,7 @@
            =
 mi =3D multi_create_instance(m, real, sock);
             if (mi)
        =
     {
+                const uint64_t hv =3D hash_value(hash, real);
     =
            hash_add_fast(hash, bucket, &mi->real, hv, mi);
               =
  mi->did_real_hash =3D true;
                 multi_assign_peer_id(m, mi);=

@@ -279,6 +279,28 @@
 }
 
 /**
+ * Looks up an multi instance by its real =
address (IP and port)
+ * @param m     multi context
+ * @param real  Addre=
ss to look up
+ * @return      instance matching the address, NULL otherwis=
e
+ */
+static struct multi_instance *
+multi_get_instance_udp_real(struct =
multi_context *m, struct mroute_addr *real)
+{
+    struct hash *hash =3D m=
->hash;
+    struct hash_element *he;
+    const uint64_t hv =3D hash_value=
(hash, real);
+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);
+ =
   he =3D hash_lookup_fast(hash, bucket, real, hv);
+    if (he)
+    {
+  =
      return he->value;
+    }
+    return NULL;
+}
+
+
+/**
  * Get a clie=
nt instance based on real address=2E  If
  * the instance doesn't exist, cr=
eate it while
  * maintaining real address hash table atomicity=2E
@@ -294,=
7 +316,6 @@
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=
=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
     {
-        struc=
t hash_element *he;
         const uint64_t hv =3D hash_value(hash, &real);=

         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
         ui=
nt8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
@@ -331,17 +352,13 @@
         }
 =
        if (!v2 || peer_id_disabled)
         {
-            he =3D hash_lo=
okup_fast(hash, bucket, &real, hv);
-            if (he)
-            {
-  =
              mi =3D (struct multi_instance *)he->value;
-            }
+  =
          mi =3D multi_get_instance_udp_real(m, &real);
         }
 
      =
   /* we have no existing multi instance for this connection */
         if=
 (!mi)
         {
-            mi =3D handle_connection_attempt(m, sock, &r=
eal, hv, bucket);
+            mi =3D handle_connection_attempt(m, sock, &r=
eal, bucket);
         }
 
 #ifdef ENABLE_DEBUG

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-=
Change-Number: 1725
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--UJKQJ8imrmk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1725?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Extract multi_get_instance_udp_real method=
<br><br>This is just a small refactoring to make the code a little bit<br>b=
etter organised=2E<br><br>Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20=
d39<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1725<br>Message-Id: &lt;20260731100844=2E3=
467-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg38096=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2E=
c<br>1 file changed, 25 insertions(+), 8 deletions(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index =
2be085f=2E=2E0979002 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</spa=
n><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -219,7 +219,6 @@<=
/span><br><span> handle_connection_attempt(struct multi_context *m,</span><=
br><span>                           struct link_socket *sock,</span><br><sp=
an>                           struct mroute_addr *real,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                          const uint64_t =
hv,</span><br><span>                           struct hash_bucket *bucket)<=
/span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</=
span><br><span>@@ -250,6 +249,7 @@</span><br><span>             mi =3D mult=
i_create_instance(m, real, sock);</span><br><span>             if (mi)</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                const uint64_t hv =3D hash_value(hash, real);</span>=
<br><span>                 hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv=
, mi);</span><br><span>                 mi-&gt;did_real_hash =3D true;</spa=
n><br><span>                 multi_assign_peer_id(m, mi);</span><br><span>@=
@ -279,6 +279,28 @@</span><br><span> }</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Looks up an mu=
lti instance by its real address (IP and port)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param m     multi context</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param real  Address to look up</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return      instanc=
e matching the address, NULL otherwise</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static struct multi_instance *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_get_instance_udp_real(struct multi_context *m, struct m=
route_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *has=
h =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct hash_element *he;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint64_t hv =3D hash_value(hash, real);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D has=
h_bucket(hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
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
micity=2E</span><br><span>@@ -294,7 +316,6 @@</span><br><span> </span><br><=
span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec=
2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct hash_element *he;</span><br><span>         const uint64_t hv =3D =
hash_value(hash, &amp;real);</span><br><span>         struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);</span><br><span>         uint8_t *ptr =3D =
BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -331,17 +352,13 @@</spa=
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
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ade55d7674c68dd98cf4=
dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--UJKQJ8imrmk=--


--===============4072396300650484274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4072396300650484274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4072396300650484274==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA00606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QPECrB0i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CQz6NIvm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XpDyPKNg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=g8ABJD8R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wHdAa3p0HLWO41pRidjv6MAHXhshM9wAlmaz6cQv+3U=; b=QPECrB0iLtZgygMlrPCdNPa7uM
	lv5KeCLqTNYuj86+x/T6hR3zjVmVe8mjDcRG5r+7hXZATMiFzeTpGfw+80vZMEXHeY3WD9AIyERzl
	vrMWCZp6bGRaL+wJXD/5hAFvD/ZSXT+UwQgABNJc40BhYrivJl3A9zTQkppCzAMAoePU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRR2-000000001X5-4A5R;
	Mon, 09 Nov 2026 15:37:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRR2-000000001Wz-2ZH7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=llesxjK8Us+oRsOQAGq753uVwbjkrczUUkWmC2IHUCE=; b=CQz6NIvm00hqWjsnj4tu7Ybx8j
 +GF0xld5VSvfeYi0+EyzIAFq8490sfnxo+7ZOYDwyogACpFkeFF/Mw/iWSB8fxN0zs/NVcvDebYWH
 surIJQiP1zsM/N41QCVPk68p3YWaK7WQJOa0UA9pC2uxezJnvjRdGDOHQmKbNTdZRrDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=llesxjK8Us+oRsOQAGq753uVwbjkrczUUkWmC2IHUCE=; b=XpDyPKNgdNP7GpUB6eOS5QZnUH
 rkP2DGQEaf+HfFmKvtwnbfO6C1Nc8DFNDAg/WWTPaQTnWEl+sTBw2dsD+CvQq+A5GivG2sRCqy4zf
 OrkjtDJ19RTa4V5jW1ERRqevsO35NWDXj4VoE+gM0g6lq9gzAZV+adj62Vl6LQLtZjB8=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRQx-000000002Kd-46Zn for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:37:28 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso7817445e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794238637; x=1794843437; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=llesxjK8Us+oRsOQAGq753uVwbjkrczUUkWmC2IHUCE=;
 b=g8ABJD8RRpOx8ao5lujSPbae+F+NH50R2a53bkPPIbUlrQ5i9wZcibteSZDTj2XUnW
 JJklHqmsXOWeyzC9ohgHTGgb/o3Ojf37nu7iMAsNizynxEIHR0PiHgxtzxjFD2zNUepR
 QwGmK2EVH4Ly6AxI8e3DgjYbonwe9ws2DAxl0WlkTKkpuYcbMc21fgNd6h+PC7agyV2Y
 gSOnO6bHFIBRjPNBeVNLwKKlTtuzwXWQ4imVTyY71cie5vflvGxsQAFibnTKOzVEmm1E
 MFPBn3BCO1v3c+m4QGtnUyU+9q/OMMx6/YJVaT9jV/SmNCowew/lOThWb2oig6S9YIRj
 bhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794238637; x=1794843437;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=llesxjK8Us+oRsOQAGq753uVwbjkrczUUkWmC2IHUCE=;
 b=d8eQAumifzP7beeOAbGlE3eBpB8ivpu21k6FYaYtEIJ8HrXaHivMTkH5Gt4e3hYuAo
 CzYMdnCXME6OWG3ydp7yu3WXp8M+aKqsrcxVV0spSqMt/YUKZ/ZuQwKoae4LtjEhROYW
 bkBwRU1A5+KCFbBQEeUZ8aXuZh4xI+gyoz6HHZOqQPT7VnmudgSX4TjUKB0HCGCIe/CP
 nPQ5g9fZHzpVb7lhjcI8vVQP2OxcMfpvJ5QzhFz3eOW6wJ2tmeQGlYzq/1NGDh9XR9Nh
 mFmcloTgUsK8j+ZwOkE3rHwo1wgvz7sntUW4uMnBeaQd0UhqoDAhuxyWrIqdK526tZGN
 InPw==
X-Forwarded-Encrypted: i=1;
 AL+hErFH246poX4JGqugOLW3wUJlqUzZtjl/gW+4BQG1VkDoONNd1we+mAO7wYkTztLo8hHbhSVByM8pf20p02J8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/KHnKgpje60qOqiPb1iip1dHIygtj8OVRg692mbU0IzK0OVUig
 v97mHqFJxKIdgFhS6BlVPoaVK4r0c6QxN27pmE4KuXVW9/OJDVr0kNDCDW3eFboJV9Qexj+yfRc
 lZxXWcTJqqZC1jKpQmNW3EZ5qcOMt9K5vC1qhA/yBMreNyVnBqxeJJiBE4yRGVuJDB60I
X-Gm-Gg: AYBFou3sN/zPV9gAvsbDYaKNqHQZuzdkwssE+kOv3bEy3/QFD37fcHFXLzWRt4tyIyj
 xsvKtHGGYbIWjdUC8ZXgxVB99g+ZDtTU3GQCuT9IR6AJfZOcA8cH3OjXrzmDxFrYwzy+HT7faGj
 AlW9yhPYOjYraZODXtFlwiwhNxGhr4lLFBUCd/hrJhsWqh5+K6as6eOw4VGSIDuxBxvCpAI3rpl
 bvuddX0t9AkUkXJ2vsw+ltqK1IeljFLlE3f1HfBXfnnk8BoGnqnQo9t5WZgak0Zpe0SN5rDqDW2
 QtgZzETnZmHvQaAgAKoa1y7dscywuDLhdNQK/+AAb2oY02IMPwYLkW5/JtDeedzXmo5TQDOaxqZ
 +b1s2whqQzaKUEbuc9DVTglyM13nvpEL3WR8Y68BFFwuncZ/vCh44lzyAoHfYpEuu2FZ0ynifVq
 +BaDgIbbjbYxhbmCnhCPZX889XTUjcIKmPnntjn6S+VP4UIxiyLm4+T91MoVgr3mefC037JCuRY
 9PzZWax9UjcH9bcnrlECM/8ORy4pS+ptIxmOrhjylata0JPOmIxy3edMknSfMPO6zpOqCcyqVfH
 GoN5xPGt704g3nhjdmSGLancJnqlHV8qGWYvniQ10Y311mixBRc+5VFGbuCyHVbj6Sw1/o+Y3tV
 iDCu2DFAssWj/PWi9BFIwEUfffRVF4xty4r7n/tc934gIeGVj2CkdAVNXlip++PQ6fmVrhzQFkI
 nt6oEMmchlKuEFCQ==
X-Received: by 2002:a05:600c:8b6f:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4b9633cddd6mr78365305e9.16.1794238637079; 
 Mon, 09 Nov 2026 07:37:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597090444sm11268745f8f.31.2026.11.09.07.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:37:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:37:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3
X-Gerrit-Change-Number: 2065
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2065?usp=email>
X-Gerrit-Commit: 0cd21e9dea09359529eb51b0a4536f14761a8a7b
In-Reply-To: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
References: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA1NTExMDAwLkllZmQ4OGNkNTM3ZmEzMDFkNDdhMGM4MGQ2ZmE1MjAwNTNjMDkyYmIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <490a1aa43f57724add1f4ec8d14c90257e6da7cb-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRQx-000000002Kd-46Zn
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use m->instances
 instead of m->hash to iterate clients
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8842206781831307318=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8842206781831307318==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZzeaqBsRmjM="; charset=UTF-8

--ZzeaqBsRmjM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2065?usp=3Demail )

Change subject: Use m->instances instead of=
 m->hash to iterate clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Use m->instances instead of m->hash to iterate clients

Th=
is simplifies the code a bit and also fixes a problem introduced by
66f8cdb=
 that connections in the early stages of connection are not shown
in the st=
atus file (e=2Eg=2E telnet openvpn-server 1194)=2E

Since this removes an i=
ndentation area, it is best to look at the changes
of this commit while ign=
oring white-space changes=2E

Change-Id: Iefd88cd537fa301d47a0c80d6fa520053=
c092bb3
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2065
Message-Id: <20261102094418=2E30344-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40550=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/manage=2Ec
M src/openvpn/multi=2Ec
2 files changed=
, 173 insertions(+), 177 deletions(-)




diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index d3b2e7c=2E=2E3e3b1c2 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -4390,12 +4390,14 @@
    =
     }
 
         /* iterate over peers and report counters for each connec=
ted peer */
-        struct hash_iterator hi;
-        struct hash_element =
*he;
-        hash_iterator_init(multi->hash, &hi);
-        while ((he =3D=
 hash_iterator_next(&hi)))
+        for (uint32_t i =3D 0; i <=3D multi->ma=
x_peerid; i++)
         {
-            struct multi_instance *mi =3D (struc=
t multi_instance *)he->value;
+            struct multi_instance *mi =3D mu=
lti->instances[i];
+
+            if (!mi)
+            {
+                =
continue;
+            }
             struct context_2 *c2 =3D &mi->context=
=2Ec2;
 
             if ((c2->mda_context=2Eflags & (DAF_CONNECTION_ESTABL=
ISHED | DAF_CONNECTION_CLOSED)) =3D=3D DAF_CONNECTION_ESTABLISHED)
@@ -4403=
,7 +4405,6 @@
                 man_bytecount_output_server(c2->dco_read_byt=
es + c2->link_read_bytes, c2->dco_write_bytes + c2->link_write_bytes, &c2->=
mda_context);
             }
         }
-        hash_iterator_free(&hi);
 =
    }
 }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index=
 3f514d6=2E=2E77ebfae 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/=
multi=2Ec
@@ -809,210 +809,205 @@
 static void
 multi_print_status(struct m=
ulti_context *m, struct status_output *so, const int version)
 {
-    if (m=
->hash)
+    struct gc_arena gc_top =3D gc_new();
+    struct hash_iterator=
 hi;
+    const struct hash_element *he;
+
+    status_reset(so);
+
+    if=
 (dco_enabled(&m->top=2Eoptions))
     {
-        struct gc_arena gc_top =
=3D gc_new();
-        struct hash_iterator hi;
-        const struct hash_=
element *he;
-
-        status_reset(so);
-
-        if (dco_enabled(&m->to=
p=2Eoptions))
+        if (dco_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->=
dco, true) < 0)
         {
-            if (dco_get_peer_stats_multi(&m->to=
p=2Ec1=2Etuntap->dco, true) < 0)
+            return;
+        }
+    }
+
+=
    if (version =3D=3D 1)
+    {
+        /*
+         * Status file versio=
n 1
+         */
+        status_printf(so, "OpenVPN CLIENT LIST");
+      =
  status_printf(so, "Updated,%s", time_string(0, 0, false, &gc_top));
+    =
    status_printf(so, "Common Name,Real Address,Bytes Received,Bytes Sent,C=
onnected Since");
+
+        for (uint32_t i =3D 0; i <=3D m->max_peerid; i=
++)
+        {
+            const struct multi_instance *mi =3D m->instance=
s[i];
+
+            struct gc_arena gc =3D gc_new();
+            if (mi &=
& !mi->halt)
             {
-                return;
+                statu=
s_printf(so, "%s,%s," counter_format "," counter_format ",%s",
+           =
                   tls_common_name(mi->context=2Ec2=2Etls_multi, false),
+ =
                             mroute_addr_print(&mi->real, &gc),
+          =
                    mi->context=2Ec2=2Elink_read_bytes + mi->context=2Ec2=
=2Edco_read_bytes,
+                              mi->context=2Ec2=2Elink_w=
rite_bytes + mi->context=2Ec2=2Edco_write_bytes,
+                         =
     time_string(mi->created, 0, false, &gc));
             }
+            =
gc_free(&gc);
         }
 
-        if (version =3D=3D 1)
+        status_p=
rintf(so, "ROUTING TABLE");
+        status_printf(so, "Virtual Address,Com=
mon Name,Real Address,Last Ref");
+        hash_iterator_init(m->vhash, &hi=
);
+        while ((he =3D hash_iterator_next(&hi)))
         {
-          =
  /*
-             * Status file version 1
-             */
-            st=
atus_printf(so, "OpenVPN CLIENT LIST");
-            status_printf(so, "Upd=
ated,%s", time_string(0, 0, false, &gc_top));
-            status_printf(so=
, "Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since");
- =
           hash_iterator_init(m->hash, &hi);
-            while ((he =3D ha=
sh_iterator_next(&hi)))
-            {
-                struct gc_arena gc =
=3D gc_new();
-                const struct multi_instance *mi =3D (struct =
multi_instance *)he->value;
+            struct gc_arena gc =3D gc_new();
+=
            const struct multi_route *route =3D (struct multi_route *)he->v=
alue;
 
-                if (!mi->halt)
+            if (multi_route_define=
d(m, route))
+            {
+                const struct multi_instance *m=
i =3D route->instance;
+                const struct mroute_addr *ma =3D &r=
oute->addr;
+                char flags[2] =3D { 0, 0 };
+
+               =
 if (route->flags & MULTI_ROUTE_CACHE)
                 {
-                =
    status_printf(so, "%s,%s," counter_format "," counter_format ",%s",
-  =
                                tls_common_name(mi->context=2Ec2=2Etls_mult=
i, false),
-                                  mroute_addr_print(&mi->real, =
&gc),
-                                  mi->context=2Ec2=2Elink_read_bytes=
 + mi->context=2Ec2=2Edco_read_bytes,
-                                  mi=
->context=2Ec2=2Elink_write_bytes + mi->context=2Ec2=2Edco_write_bytes,
-  =
                                time_string(mi->created, 0, false, &gc));
+=
                    flags[0] =3D 'C';
                 }
-                g=
c_free(&gc);
+                status_printf(so, "%s%s,%s,%s,%s", mroute_add=
r_print(ma, &gc), flags,
+                              tls_common_name(mi-=
>context=2Ec2=2Etls_multi, false),
+                              mroute_ad=
dr_print(&mi->real, &gc),
+                              time_string(route-=
>last_reference, 0, false, &gc));
             }
-            hash_iterator=
_free(&hi);
-
-            status_printf(so, "ROUTING TABLE");
-           =
 status_printf(so, "Virtual Address,Common Name,Real Address,Last Ref");
- =
           hash_iterator_init(m->vhash, &hi);
-            while ((he =3D h=
ash_iterator_next(&hi)))
-            {
-                struct gc_arena gc=
 =3D gc_new();
-                const struct multi_route *route =3D (struct=
 multi_route *)he->value;
-
-                if (multi_route_defined(m, rou=
te))
-                {
-                    const struct multi_instance *m=
i =3D route->instance;
-                    const struct mroute_addr *ma =
=3D &route->addr;
-                    char flags[2] =3D { 0, 0 };
-
-     =
               if (route->flags & MULTI_ROUTE_CACHE)
-                    {=

-                        flags[0] =3D 'C';
-                    }
-       =
             status_printf(so, "%s%s,%s,%s,%s", mroute_addr_print(ma, &gc),=
 flags,
-                                  tls_common_name(mi->context=2Ec2=
=2Etls_multi, false),
-                                  mroute_addr_print(=
&mi->real, &gc),
-                                  time_string(route->last=
_reference, 0, false, &gc));
-                }
-                gc_free(&g=
c);
-            }
-            hash_iterator_free(&hi);
-
-            sta=
tus_printf(so, "GLOBAL STATS");
-            if (m->mbuf)
-            {
- =
               status_printf(so, "Max bcast/mcast queue length,%d", mbuf_ma=
ximum_queued(m->mbuf));
-            }
-
-            status_printf(so, "EN=
D");
+            gc_free(&gc);
         }
-        else if (version =3D=3D=
 2 || version =3D=3D 3)
+        hash_iterator_free(&hi);
+
+        status=
_printf(so, "GLOBAL STATS");
+        if (m->mbuf)
         {
-            =
const char sep =3D (version =3D=3D 3) ? '\t' : ',';
+            status_pri=
ntf(so, "Max bcast/mcast queue length,%d", mbuf_maximum_queued(m->mbuf));
+=
        }
 
-            /*
-             * Status file version 2 and 3
-  =
           */
-            status_printf(so, "TITLE%c%s", sep, title_string=
);
-            status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, =
false, &gc_top), sep,
-                          (unsigned int)now);
-     =
       status_printf(
-                so,
-                "HEADER%cCLIENT=
_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBy=
tes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUserna=
me%cClient ID%cPeer ID%cData Channel Cipher",
-                sep, sep, se=
p, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
-            hash_ite=
rator_init(m->hash, &hi);
-            while ((he =3D hash_iterator_next(&h=
i)))
+        status_printf(so, "END");
+    }
+    else if (version =3D=3D=
 2 || version =3D=3D 3)
+    {
+        const char sep =3D (version =3D=3D =
3) ? '\t' : ',';
+
+        /*
+         * Status file version 2 and 3
+   =
      */
+        status_printf(so, "TITLE%c%s", sep, title_string);
+     =
   status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_to=
p), sep,
+                      (unsigned int)now);
+        status_printf(=

+            so,
+            "HEADER%cCLIENT_LIST%cCommon Name%cReal Addr=
ess%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cCon=
nected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData =
Channel Cipher",
+            sep, sep, sep, sep, sep, sep, sep, sep, sep, =
sep, sep, sep, sep);
+
+        for (uint32_t i =3D 0; i <=3D m->max_peerid=
; i++)
+        {
+            const struct multi_instance *mi =3D m->insta=
nces[i];
+            struct gc_arena gc =3D gc_new();
+
+            if (m=
i && !mi->halt)
             {
-                struct gc_arena gc =3D gc_n=
ew();
-                const struct multi_instance *mi =3D (struct multi_in=
stance *)he->value;
-
-                if (!mi->halt)
-                {
- =
                   status_printf(
-                        so,
-           =
             "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" counter_fo=
rmat
-                        "%c%s%c%u%c%s%c"
+                status_prin=
tf(
+                    so,
+                    "CLIENT_LIST%c%s%c%s%c%s%=
c%s%c" counter_format "%c" counter_format
+                    "%c%s%c%u%c%=
s%c"
 #ifdef ENABLE_MANAGEMENT
-                        "%lu"
+            =
        "%lu"
 #else
-                        ""
+                    ""
 #=
endif
-                        "%c%" PRIu32 "%c%s",
-                      =
  sep, tls_common_name(mi->context=2Ec2=2Etls_multi, false), sep,
-        =
                mroute_addr_print(&mi->real, &gc), sep,
-                  =
      print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc), sep,
-  =
                      print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_U=
NDEF, &gc), sep,
-                        mi->context=2Ec2=2Elink_read_byte=
s + mi->context=2Ec2=2Edco_read_bytes, sep,
-                        mi->co=
ntext=2Ec2=2Elink_write_bytes + mi->context=2Ec2=2Edco_write_bytes, sep,
- =
                       time_string(mi->created, 0, false, &gc), sep, (unsig=
ned int)mi->created,
-                        sep, tls_username(mi->context=
=2Ec2=2Etls_multi, false),
+                    "%c%" PRIu32 "%c%s",
+     =
               sep, tls_common_name(mi->context=2Ec2=2Etls_multi, false), s=
ep,
+                    mroute_addr_print(&mi->real, &gc), sep,
+         =
           print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc), sep=
,
+                    print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_=
UNDEF, &gc), sep,
+                    mi->context=2Ec2=2Elink_read_bytes +=
 mi->context=2Ec2=2Edco_read_bytes, sep,
+                    mi->context=
=2Ec2=2Elink_write_bytes + mi->context=2Ec2=2Edco_write_bytes, sep,
+      =
              time_string(mi->created, 0, false, &gc), sep, (unsigned int)m=
i->created,
+                    sep, tls_username(mi->context=2Ec2=2Etls_m=
ulti, false),
 #ifdef ENABLE_MANAGEMENT
-                        sep, mi->c=
ontext=2Ec2=2Emda_context=2Ecid,
+                    sep, mi->context=2Ec2=
=2Emda_context=2Ecid,
 #else
-                        sep,
+               =
     sep,
 #endif
-                        sep, mi->context=2Ec2=2Etls_mult=
i ? mi->context=2Ec2=2Etls_multi->rx_peer_id : MAX_PEER_ID,
-              =
          sep, translate_cipher_name_to_openvpn(mi->context=2Eoptions=2Ecip=
hername));
-                }
-                gc_free(&gc);
+             =
       sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->rx=
_peer_id : MAX_PEER_ID,
+                    sep, translate_cipher_name_to_=
openvpn(mi->context=2Eoptions=2Eciphername));
             }
-            h=
ash_iterator_free(&hi);
-
-            status_printf(
-                so,
=
-                "HEADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal=
 Address%cLast Ref%cLast Ref (time_t)",
-                sep, sep, sep, sep=
, sep, sep);
-            hash_iterator_init(m->vhash, &hi);
-            w=
hile ((he =3D hash_iterator_next(&hi)))
-            {
-                str=
uct gc_arena gc =3D gc_new();
-                const struct multi_route *ro=
ute =3D (struct multi_route *)he->value;
-
-                if (multi_route=
_defined(m, route))
-                {
-                    const struct mu=
lti_instance *mi =3D route->instance;
-                    const struct mro=
ute_addr *ma =3D &route->addr;
-                    char flags[2] =3D { 0, =
0 };
-
-                    if (route->flags & MULTI_ROUTE_CACHE)
-        =
            {
-                        flags[0] =3D 'C';
-                 =
   }
-                    status_printf(so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%=
s%c%u", sep,
-                                  mroute_addr_print(ma, &gc),=
 flags, sep,
-                                  tls_common_name(mi->context=
=2Ec2=2Etls_multi, false), sep,
-                                  mroute_a=
ddr_print(&mi->real, &gc), sep,
-                                  time_str=
ing(route->last_reference, 0, false, &gc), sep,
-                          =
        (unsigned int)route->last_reference);
-                }
-         =
       gc_free(&gc);
-            }
-            hash_iterator_free(&hi);
-=

-            if (m->mbuf)
-            {
-                status_printf(so=
, "GLOBAL_STATS%cMax bcast/mcast queue length%c%d", sep, sep,
-            =
                  mbuf_maximum_queued(m->mbuf));
-            }
-
-        =
    status_printf(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
-         =
                 dco_enabled(&m->top=2Eoptions));
-            status_print=
f(so, "END");
+            gc_free(&gc);
         }
-        else
+
+      =
  status_printf(
+            so,
+            "HEADER%cROUTING_TABLE%cVirt=
ual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t)",
+    =
        sep, sep, sep, sep, sep, sep);
+        hash_iterator_init(m->vhash=
, &hi);
+        while ((he =3D hash_iterator_next(&hi)))
         {
-     =
       status_printf(so, "ERROR: bad status format version number");
+     =
       struct gc_arena gc =3D gc_new();
+            const struct multi_rou=
te *route =3D (struct multi_route *)he->value;
+
+            if (multi_rou=
te_defined(m, route))
+            {
+                const struct multi_in=
stance *mi =3D route->instance;
+                const struct mroute_addr *=
ma =3D &route->addr;
+                char flags[2] =3D { 0, 0 };
+
+      =
          if (route->flags & MULTI_ROUTE_CACHE)
+                {
+       =
             flags[0] =3D 'C';
+                }
+                status_p=
rintf(so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u", sep,
+                    =
          mroute_addr_print(ma, &gc), flags, sep,
+                        =
      tls_common_name(mi->context=2Ec2=2Etls_multi, false), sep,
+         =
                     mroute_addr_print(&mi->real, &gc), sep,
+             =
                 time_string(route->last_reference, 0, false, &gc), sep,
+ =
                             (unsigned int)route->last_reference);
+       =
     }
+            gc_free(&gc);
         }
+        hash_iterator_free(&h=
i);
+
+        if (m->mbuf)
+        {
+            status_printf(so, "GLOB=
AL_STATS%cMax bcast/mcast queue length%c%d", sep, sep,
+                   =
       mbuf_maximum_queued(m->mbuf));
+        }
+
+        status_printf(s=
o, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
+                      dco_en=
abled(&m->top=2Eoptions));
+        status_printf(so, "END");
+    }
+    e=
lse
+    {
+        status_printf(so, "ERROR: bad status format version num=
ber");
+    }
 
 #ifdef PACKET_TRUNCATION_CHECK
+    {
+        status_prin=
tf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encryp=
t Trunc,Post-decrypt Trunc");
+        hash_iterator_init(m->hash, &hi);
+ =
       while ((he =3D hash_iterator_next(&hi)))
         {
-            sta=
tus_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pr=
e-encrypt Trunc,Post-decrypt Trunc");
-            hash_iterator_init(m->ha=
sh, &hi);
-            while ((he =3D hash_iterator_next(&hi)))
-          =
  {
-                struct gc_arena gc =3D gc_new();
-                cons=
t struct multi_instance *mi =3D (struct multi_instance *)he->value;
+      =
      struct gc_arena gc =3D gc_new();
+            const struct multi_inst=
ance *mi =3D (struct multi_instance *)he->value;
 
-                if (!mi=
->halt)
-                {
-                    status_printf(so,
-        =
                          "ERRORS,%s," counter_format "," counter_format ",=
" counter_format
-                                  "," counter_format,
-  =
                                tls_common_name(mi->context=2Ec2=2Etls_mult=
i, false),
-                                  m->top=2Ec2=2En_trunc_tun_rea=
d, mi->context=2Ec2=2En_trunc_tun_write,
-                                 =
 mi->context=2Ec2=2En_trunc_pre_encrypt,
-                                 =
 mi->context=2Ec2=2En_trunc_post_decrypt);
-                }
-            =
    gc_free(&gc);
+            if (!mi->halt)
+            {
+             =
   status_printf(so,
+                              "ERRORS,%s," counter_fo=
rmat "," counter_format "," counter_format
+                              "=
," counter_format,
+                              tls_common_name(mi->conte=
xt=2Ec2=2Etls_multi, false),
+                              m->top=2Ec2=2En=
_trunc_tun_read, mi->context=2Ec2=2En_trunc_tun_write,
+                   =
           mi->context=2Ec2=2En_trunc_pre_encrypt,
+                       =
       mi->context=2Ec2=2En_trunc_post_decrypt);
             }
-          =
  hash_iterator_free(&hi);
+            gc_free(&gc);
         }
+        h=
ash_iterator_free(&hi);
+    }
 #endif /* ifdef PACKET_TRUNCATION_CHECK */
=
 
-        status_flush(so);
-        gc_free(&gc_top);
-    }
+    status_=
flush(so);
+    gc_free(&gc_top);
 
 #ifdef ENABLE_ASYNC_PUSH
     if (m->i=
notify_watchers)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2065?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief=
d88cd537fa301d47a0c80d6fa520053c092bb3
Gerrit-Change-Number: 2065
Gerrit-Pa=
tchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--ZzeaqBsRmjM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2065?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Use m-&gt;instances instead of m-&=
gt;hash to iterate clients<br><br>This simplifies the code a bit and also f=
ixes a problem introduced by<br>66f8cdb that connections in the early stage=
s of connection are not shown<br>in the status file (e=2Eg=2E telnet openvp=
n-server 1194)=2E<br><br>Since this removes an indentation area, it is best=
 to look at the changes<br>of this commit while ignoring white-space change=
s=2E<br><br>Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3<br>Signed-=
off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2065<br>Message-Id: &lt;20261102094418=2E30344-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg40550=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/open=
vpn/multi=2Ec<br>2 files changed, 173 insertions(+), 177 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</s=
pan><br><span>index d3b2e7c=2E=2E3e3b1c2 100644</span><br><span>--- a/src/o=
penvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><s=
pan>@@ -4390,12 +4390,14 @@</span><br><span>         }</span><br><span> </s=
pan><br><span>         /* iterate over peers and report counters for each c=
onnected peer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct hash_iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct hash_element *he;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        hash_iterator_init(multi-&gt;hash, &amp;hi);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        while ((he =3D hash=
_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (uint32_t i =3D 0; i &lt;=3D multi-&gt;max_peerid; i++)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            struct multi_instance *mi =3D (struct multi_instance *)he-&=
gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  struct multi_instance *mi =3D multi-&gt;instances[i];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (!mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                continue;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span>             struct context=
_2 *c2 =3D &amp;mi-&gt;context=2Ec2;</span><br><span> </span><br><span>    =
         if ((c2-&gt;mda_context=2Eflags &amp; (DAF_CONNECTION_ESTABLISHED =
| DAF_CONNECTION_CLOSED)) =3D=3D DAF_CONNECTION_ESTABLISHED)</span><br><spa=
n>@@ -4403,7 +4405,6 @@</span><br><span>                 man_bytecount_outp=
ut_server(c2-&gt;dco_read_bytes + c2-&gt;link_read_bytes, c2-&gt;dco_write_=
bytes + c2-&gt;link_write_bytes, &amp;c2-&gt;mda_context);</span><br><span>=
             }</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        hash_iterator_free(&amp;hi);</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/=
openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3f514d6=2E=
=2E77ebfae 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -809,210 +809,205 @@</spa=
n><br><span> static void</span><br><span> multi_print_status(struct multi_c=
ontext *m, struct status_output *so, const int version)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;hash)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
_top =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct hash_iterator hi;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct hash_element *he;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    status_reset(so);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_e=
nabled(&amp;m-&gt;top=2Eoptions))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc_top =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct ha=
sh_iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  const struct hash_element *he;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
atus_reset(so);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_enabled(&am=
p;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (dco_get_peer_stats_multi(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;d=
co, true) &lt; 0)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (dco_get_peer_stats_multi(&amp;m-&gt;=
top=2Ec1=2Etuntap-&gt;dco, true) &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (version =3D=3D=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * Status file version 1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;Op=
enVPN CLIENT LIST&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        status_printf(so, &quot;Updated,%s&quot;, time_string(0, 0, f=
alse, &amp;gc_top));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        status_printf(so, &quot;Common Name,Real Address,Bytes Received,By=
tes Sent,Connected Since&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            const struct multi_instance *mi =3D=
 m-&gt;instances[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (mi &amp;&amp; !mi-&gt;halt)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     status_printf(so, &quot;%s,%s,&quot; counter_format &quot;,&quot; coun=
ter_format &quot;,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                              tls_common_name(mi-&gt;context=2Ec2=
=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              mroute_addr_print(&amp;mi-&gt;real, &amp;gc=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
             mi-&gt;context=2Ec2=2Elink_read_bytes + mi-&gt;context=2Ec2=2E=
dco_read_bytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          mi-&gt;context=2Ec2=2Elink_write_bytes + mi-&gt;c=
ontext=2Ec2=2Edco_write_bytes,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                              time_string(mi-&gt;created, 0, fal=
se, &amp;gc));</span><br><span>             }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>   =
      }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (version =3D=3D 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        status_printf(so, &quot;ROUTING TABLE&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &=
quot;Virtual Address,Common Name,Real Address,Last Ref&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        hash_iterator_init(m-&gt=
;vhash, &amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-             * Status file=
 version 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            statu=
s_printf(so, &quot;OpenVPN CLIENT LIST&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            status_printf(so, &quot;Updated,%s&quo=
t;, time_string(0, 0, false, &amp;gc_top));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            status_printf(so, &quot;Common Name,Real =
Address,Bytes Received,Bytes Sent,Connected Since&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_init(m-&gt;ha=
sh, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                const struct =
multi_instance *mi =3D (struct multi_instance *)he-&gt;value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      const struct multi_route *route =3D (struct multi_route *)he-&gt;valu=
e;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (!mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (multi_route_defined(m, route))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const struct multi_instan=
ce *mi =3D route-&gt;instance;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                const struct mroute_addr *ma =3D &amp;route-&gt;=
addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  char flags[2] =3D { 0, 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)</span><br><span>       =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          status_printf(so, &quot;%s,%s,&quot; counter_format &quot;,&quot;=
 counter_format &quot;,%s&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                  tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                  mroute_addr_print(&amp;mi-&gt;real, =
&amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                      mi-&gt;context=2Ec2=2Elink_read_bytes + mi-&gt;contex=
t=2Ec2=2Edco_read_bytes,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                  mi-&gt;context=2Ec2=2Elink_write_bytes=
 + mi-&gt;context=2Ec2=2Edco_write_bytes,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                  time_string(mi-&gt;cr=
eated, 0, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    flags[0] =3D &#39;C&#39;;</span><br><span>     =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                status_printf(so, &quot;%s%s,%s,%s,%s&quot;, mroute_a=
ddr_print(ma, &amp;gc), flags,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                              tls_common_name(mi-&gt;context=2Ec=
2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                              mroute_addr_print(&amp;mi-&gt;real, &amp;g=
c),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
              time_string(route-&gt;last_reference, 0, false, &amp;gc));</s=
pan><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            hash_iterator_free(&amp;hi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            status_printf(so, &quot;ROUTING TABLE&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quo=
t;Virtual Address,Common Name,Real Address,Last Ref&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_init(m-&gt;=
vhash, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                const st=
ruct multi_route *route =3D (struct multi_route *)he-&gt;value;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (multi_route_defined(m, route))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    const str=
uct multi_instance *mi =3D route-&gt;instance;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    const struct mroute_addr *ma =
=3D &amp;route-&gt;addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    char flags[2] =3D { 0, 0 };</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
flags[0] =3D &#39;C&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    status_printf(so, &quot;%s%s,%s,%s,%s&quot;, mroute=
_addr_print(ma, &amp;gc), flags,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                  tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                  mroute_addr_print(&amp;mi-&gt;real, =
&amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                      time_string(route-&gt;last_reference, 0, false, &amp;=
gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash=
_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status=
_printf(so, &quot;GLOBAL STATS&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (m-&gt;mbuf)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                status_printf(so, &quot;Max bcast/mcast queu=
e length,%d&quot;, mbuf_maximum_queued(m-&gt;mbuf));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            status_printf(so, &quot;END&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
lse if (version =3D=3D 2 || version =3D=3D 3)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        hash_iterator_free(&amp;hi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        status_printf(so, &quot;GLOBAL STATS&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;=
mbuf)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            const char sep =3D (version =3D=3D 3) ? &#39;\t&#39;=
 : &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        status_printf(so, &quot;Max bcast/mcast queue length,%d&quot;, mbuf=
_maximum_queued(m-&gt;mbuf));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             * Status file version 2 and 3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            status_printf(so, &quot;TITLE%c%s&quo=
t;, sep, title_string);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            status_printf(so, &quot;TIME%c%s%c%u&quot;, sep, time_string(=
now, 0, false, &amp;gc_top), sep,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                          (unsigned int)now);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            status_printf(</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                so,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;HEADER%cCLIENT=
_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBy=
tes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUserna=
me%cClient ID%cPeer ID%cData Channel Cipher&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                sep, sep, sep, sep, sep, sep, =
sep, sep, sep, sep, sep, sep, sep);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            hash_iterator_init(m-&gt;hash, &amp;hi);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            while ((he =3D has=
h_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        status_printf(so, &quot;END&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (version =3D=3D 2 || version =3D=3D 3)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char sep =3D (version =3D=
=3D 3) ? &#39;\t&#39; : &#39;,&#39;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
Status file version 2 and 3</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        status_printf(so, &quot;TITLE%c%s&quot;, sep, title_string);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, =
&quot;TIME%c%s%c%u&quot;, sep, time_string(now, 0, false, &amp;gc_top), sep=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
    (unsigned int)now);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        status_printf(</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            so,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtua=
l Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Sinc=
e%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cip=
her&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (uint32_t i =3D 0; i &lt;=3D m-&g=
t;max_peerid; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 const struct multi_instance *mi =3D m-&gt;instances[i];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (mi &amp;&amp; !m=
i-&gt;halt)</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                struct gc_arena gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                const struc=
t multi_instance *mi =3D (struct multi_instance *)he-&gt;value;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (!mi-&gt;halt)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    status_printf(</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        so,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        &qu=
ot;CLIENT_LIST%c%s%c%s%c%s%c%s%c&quot; counter_format &quot;%c&quot; counte=
r_format</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           &quot;%c%s%c%u%c%s%c&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                status_printf(</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    so,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;CLIENT_LIST%c%s=
%c%s%c%s%c%s%c&quot; counter_format &quot;%c&quot; counter_format</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;%c%=
s%c%u%c%s%c&quot;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        &quot;%lu&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   &quot;%lu&quot;</span><br><span> #else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        &quot;&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    &quot;&quot;</span=
><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     &quot;%c%&quot; PRIu32 &quot;%c%s&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        sep, tls_co=
mmon_name(mi-&gt;context=2Ec2=2Etls_multi, false), sep,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        mroute_addr_print=
(&amp;mi-&gt;real, &amp;gc), sep,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        print_in_addr_t(mi-&gt;reporting_addr, =
IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        print_in6_addr(mi-&gt;reporting_addr_ip=
v6, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        mi-&gt;context=2Ec2=2Elink_read_byt=
es + mi-&gt;context=2Ec2=2Edco_read_bytes, sep,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        mi-&gt;context=2Ec2=2Elin=
k_write_bytes + mi-&gt;context=2Ec2=2Edco_write_bytes, sep,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        time_string(m=
i-&gt;created, 0, false, &amp;gc), sep, (unsigned int)mi-&gt;created,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        sep=
, tls_username(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    &quot;%c%&quot; PRI=
u32 &quot;%c%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    sep, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi,=
 false), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              mroute_addr_print(&amp;mi-&gt;real, &amp;gc), sep,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    print_in_a=
ddr_t(mi-&gt;reporting_addr, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    print_in6_ad=
dr(mi-&gt;reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;con=
text=2Ec2=2Elink_read_bytes + mi-&gt;context=2Ec2=2Edco_read_bytes, sep,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi=
-&gt;context=2Ec2=2Elink_write_bytes + mi-&gt;context=2Ec2=2Edco_write_byte=
s, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        time_string(mi-&gt;created, 0, false, &amp;gc), sep, (unsigned int)=
mi-&gt;created,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                sep, tls_username(mi-&gt;context=2Ec2=2Etls_multi, false),<=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        sep, mi-&gt;context=2Ec2=2Emda_=
context=2Ecid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               sep, mi-&gt;context=2Ec2=2Emda_context=2Ecid,</span><br><spa=
n> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                sep,</span><br><span> #endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        sep, mi-&gt;context=2Ec2=2Et=
ls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
sep, translate_cipher_name_to_openvpn(mi-&gt;context=2Eoptions=2Eciphername=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            sep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etl=
s_multi-&gt;rx_peer_id : MAX_PEER_ID,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    sep, translate_cipher_name_to_openvpn=
(mi-&gt;context=2Eoptions=2Eciphername));</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_iterato=
r_free(&amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            status_printf(=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                so,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;H=
EADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%=
cLast Ref (time_t)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                sep, sep, sep, sep, sep, sep);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            hash_iterator_init(m-&gt;vhash, &a=
mp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            wh=
ile ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                const struct multi_=
route *route =3D (struct multi_route *)he-&gt;value;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                if (multi_route_defined(m, route))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    const struct multi_=
instance *mi =3D route-&gt;instance;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    const struct mroute_addr *ma =3D &amp;ro=
ute-&gt;addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            char flags[2] =3D { 0, 0 };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        flags[0] =
=3D &#39;C&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               status_printf(so, &quot;ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u&=
quot;, sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                        mroute_addr_print(ma, &amp;gc), flags, sep,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
     tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false), sep,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
    mroute_addr_print(&amp;mi-&gt;real, &amp;gc), sep,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                  time_str=
ing(route-&gt;last_reference, 0, false, &amp;gc), sep,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                  (unsigne=
d int)route-&gt;last_reference);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            hash_iterator_free(&amp;hi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (m-&gt;mbuf)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                status_printf(so, &quot;GLOBAL_STATS%cMax bcast/mc=
ast queue length%c%d&quot;, sep, sep,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                              mbuf_maximum_queued(m-&gt;mbu=
f));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;GLOBAL_STA=
TS%cdco_enabled%c%d&quot;, sep, sep,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                          dco_enabled(&amp;m-&gt;top=2Eoptio=
ns));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stat=
us_printf(so, &quot;END&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            gc_free(&amp;gc);</span><br><span>         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        status_printf(</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            so,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;HEADER%cROUTING_TABLE%cVirtual Addres=
s%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t)&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            sep, sep, sep, sep=
, sep, sep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 hash_iterator_init(m-&gt;vhash, &amp;hi);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        while ((he =3D hash_iterator_next(&amp;hi)))=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            status_printf(so, &quot;ERROR: bad status format version =
number&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            const struct multi_route *route =3D (struct=
 multi_route *)he-&gt;value;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (multi_route_defined(m, route))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                const struct multi_instance *mi =3D route-&gt;in=
stance;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    const struct mroute_addr *ma =3D &amp;route-&gt;addr;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                char flags[2] =3D { 0=
, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (route-&gt;fl=
ags &amp; MULTI_ROUTE_CACHE)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    flags[0] =3D &#39;C&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                status_printf(so, &quot;R=
OUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u&quot;, sep,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                              mroute_addr_print(=
ma, &amp;gc), flags, sep,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                              tls_common_name(mi-&gt;context=2Ec2=2Et=
ls_multi, false), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                              mroute_addr_print(&amp;mi-&gt;real, &amp;g=
c), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                   time_string(route-&gt;last_reference, 0, false, &amp;gc)=
, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                 (unsigned int)route-&gt;last_reference);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><=
span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    hash_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (m-&gt;mbuf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
status_printf(so, &quot;GLOBAL_STATS%cMax bcast/mcast queue length%c%d&quot=
;, sep, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   mbuf_maximum_queued(m-&gt;mbuf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        status_printf(so, &quot;GLOBAL_STATS%cdco_enabled%c%d&quot;, s=
ep, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
           dco_enabled(&amp;m-&gt;top=2Eoptions));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;END&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        status_printf(so, &quot;ERROR: bad status format ve=
rsion number&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CHECK</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;HEAD=
ER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post=
-decrypt Trunc&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        hash_iterator_init(m-&gt;hash, &amp;hi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while ((he =3D hash_iterator_next=
(&amp;hi)))</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            status_printf(so, &quot;HEADER,ERRORS,Common N=
ame,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_=
iterator_init(m-&gt;hash, &amp;hi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            while ((he =3D hash_iterator_next(&amp;hi)))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         const struct multi_instance *mi =3D (struct multi_instance *)he-&g=
t;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            const struct multi_instance *mi =3D (struct multi=
_instance *)he-&gt;value;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                if (!mi-&gt;halt)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    status_printf(so,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
       &quot;ERRORS,%s,&quot; counter_format &quot;,&quot; counter_format &=
quot;,&quot; counter_format</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                  &quot;,&quot; counter_format,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
       tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
 m-&gt;top=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_trunc_tun_write=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
              mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                  mi-&gt=
;context=2Ec2=2En_trunc_post_decrypt);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!mi-&gt;halt)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                status_printf(so,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
&quot;ERRORS,%s,&quot; counter_format &quot;,&quot; counter_format &quot;,&=
quot; counter_format</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              &quot;,&quot; counter_format,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                              tls_=
common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              m-&gt;top=
=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_trunc_tun_write,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                              mi-&gt;context=2Ec2=
=2En_trunc_post_decrypt);</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_free(&amp;hi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free=
(&amp;gc);</span><br><span>         }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        hash_iterator_free(&amp;hi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif /* ifdef P=
ACKET_TRUNCATION_CHECK */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        status_flush(so);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        gc_free(&amp;gc_top);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    status_flush(so);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc_top);</span><br><span> </span><br=
><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     if (m-&gt;inotify_wat=
chers)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2065?usp=3Demail">change 2065</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Iefd88cd537fa301d47a0c80d6fa=
520053c092bb3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 206=
5 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--ZzeaqBsRmjM=--


--===============8842206781831307318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8842206781831307318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8842206781831307318==--


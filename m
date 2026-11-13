Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53628606BD39
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GS8XzT5n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AcuYW5XN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hUHVGCuA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TE07/UCD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LPZkPxHbbUOfzpGkwuTdY/EjRKP+lAkws47LwvyXeEc=; b=GS8XzT5nAkRT1Lv8GcEMblFkTe
	tPsP/DdKGegcYS3VgKLtvhzPoaP6OONdXr8Ad0TGDJhUPeuCxaVytWjxVZpk4Su0KTFwlVwVB7hIO
	TRGCLq+eXa1kle8e1C14slrOC93mNLS5KrVbTvs79e45GfMrsFZv+7vHreMywcwnZ1qs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRvKl-000000001Ng-0AVo;
	Fri, 13 Nov 2026 17:45:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRvKj-000000001Na-3TFJ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Pp7ocDQ0asOGUMjLYh8Ok7QPAARZgcRhQ08ot1EfWA=; b=AcuYW5XNkWrSpuM/jeAZPqWdpS
 pghqvDJGxkzor+a70gJ1Ur2Ves1mW+pbvev9yZvgk2O6b57ccKHDq2s6dY3jxFlZ2MdKkRbBaSlfT
 7uYEaXjQ/cSASCDbPnzuEilIQ1Xs5Dc+pieoCCB1m8mU9eR61k6sIoL0A8dry8wmatDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Pp7ocDQ0asOGUMjLYh8Ok7QPAARZgcRhQ08ot1EfWA=; b=hUHVGCuAV6DXeHSkuK7/4MdRba
 IHjCBUcRFmJ2k2+c3ICEHn2iVbpJuxnMfQtJ6vkA1y1Bw5RgR2Jl0jj7t5HjRJeZcnVHUwjSTUpD/
 jyprEdd/CZyVDvOxiuZh1wJ0+3J3ph5cGd40nVkdW1yni699movMUMtpOGRIZJFpQdNY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRvKg-000000008TF-31V7 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:45:05 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso17029425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794591896; x=1795196696; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9Pp7ocDQ0asOGUMjLYh8Ok7QPAARZgcRhQ08ot1EfWA=;
 b=TE07/UCDFfq8Xv3VeCEVMjrAqokUiQbfeP7C7+AhmONHFZvus2dvHj+bSd6M1z49Bv
 crTFEPXfUt+jumGbIFBYcRQK7Cf/GXrLem/BqKByocirEBvDnT+zR5fB8RndEH93haHh
 lgVKfSqc9IXyBcViUFbTLMKF8OQoa9juGZIJZQo1ZhI8xHJRsQSE79rRKgZYtLjPgK81
 G1RqhAeXoFZ7j/TEGVeiKryGTjAbpzlgcQ7dz+475zD0oym/45gagsvDgP4LMfK9D+GG
 U/mqba8BMEhi0/24/EdfXkKGEKW6qsfgO2NE2VZPXFQz265VJhu4TLec0h4wvChVcxxN
 9eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591896; x=1795196696;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9Pp7ocDQ0asOGUMjLYh8Ok7QPAARZgcRhQ08ot1EfWA=;
 b=JIFsM1gYbbA+VDh7kY5arSDSs8QR2eOuVviQp3n4fQJy8zeAy9zyFwwQAFz16w93vA
 EnWoAMacoGMACqrxW9rldzSLxBcFUcrf6GKxe0mHB5X3KTqhOYK9gAlHpQBfnCHqI42w
 oupQMyRVswikpYPcLC0HB1YLr1BSGAo7MzMqwsQ6iO2b4VIwub2qn2CF078g3PI4bY6r
 hJ7JiLVEl3v2NzXdf8cwJvlGsWDqIEGRKPvfn6agA5GgZeUh+rV3IjNzCr7J9uepHKkg
 i0ykOqH2YZWhU0PZOGJDnYi3QiecfSxdmA0J65HPrC5tUb8Wr2d6Kq/6sXnUOBpv1Ezt
 RRsQ==
X-Gm-Message-State: APuU4Z8bRvrnWvDyKOUm3S5TqQpwEStddaLUynUlPYiPF2AibVEeiSMy
 DGR3kIPCnzRSXiJNBXWcA3iiNWPYhVxBGBx/fAQ4mO0huhTHW+9kjurPnvaAaqGxaJdSP/C8w3X
 UwGsEkXYEzdcDtSVUFQrRWKxyKubp5WCa8kaUkJhZkcfgDRWCeiAXD48FyJzo57UEUgrc
X-Gm-Gg: AYBFou0G4iqcDdfgpU8JuP5xM23p0UZG7aW7CrJPacZ29vQcKnZ4Wq2qOGSoPMBkGpS
 vIMS87hxlnTbX5DNVbnOwfQ+5vPoxpPjCO41dHqXzlj2/f1grBgf2KS0vcqF/UU8Xf3JrFjPS6e
 tGZ7na5qAQp9VCP/oOWSR4UGDf/ytW694oh6wZW6nZ6Tq2rb3K4DOlmRHKF80VSLWyc9imU800F
 9ZJQ9oIWhlJ5Rvlaag4qcDkdPKe4r/2HKuhUFaQOCDj+2E72lFOT5VAgCyd7L0Q01ooPapHCilH
 9ENIxyoODparMCRsD0MNy2nBxrh/2d6d7KarvIJUZEkJUPbkKzZxcSvAj3yyNHeYVdUxXtuCgpI
 +rzwNJdHBaGupOIM7jfhzr+JclxQA+kfTkuF8DlR2xUFMfRwZET6jhQGD0Qbj+rpWbSfSINFWOp
 YjWdNnGfekp87t6PEClQC5w0wZ8lQZ0ZoNLYRnsPrg/Weoeq7hXQplQ/GGkmH+vZMjoW5+6ZbP2
 yyJBgvuKHQ8GgeisfqNnlksn0NY3SBaRUl5VUhEgy4sJfSoEcBfzMwNyFcl3Tz+Kh+B7Bid/nPO
 VwJAVdiEjG+SQcXmQNfaBOVbIQcW4QOJBkOlrUr/G/BJMPVCQc5ckHnoasbxXircF6cYP8/AqT3
 SPhLPbFEnEKyv2chEAbI1x1wJOc3IS8QQiS7ppZMjEoKtdZuNDqCSRL56/CDtPMHROX+GGNRB9f
 RSFOxl4syYmaePaj4=
X-Received: by 2002:a05:600c:1f96:b0:4ac:aae6:6401 with SMTP id
 5b1f17b1804b1-4bb55a4d990mr70953345e9.12.1794591895871; 
 Fri, 13 Nov 2026 09:44:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm171272085e9.6.2026.11.13.09.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:44:55 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 17:44:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 2a6784b2e2ae52b53379945fc5a88fb33a30142d
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1cdb13ca2bdaff21e4de94e96dea5be0ecb9a36c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRvKg-000000008TF-31V7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
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
Content-Type: multipart/mixed; boundary="===============7857166229779304725=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7857166229779304725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t7DF5J+6/1c="; charset=UTF-8

--t7DF5J+6/1c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Extract tls_pre_decrypt_e=
xtract_session_id and pre_decrypt_find_session
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_extract_session_=
id and pre_decrypt_find_session

These functions fulfil steps that can be e=
asily moved to their own
functions to make tls_pre_decrypt a bit more reada=
ble=2E

Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175
Messa=
ge-Id: <20261113104930=2E25197-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41246=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
ssl=2Ec
1 file changed, 76 insertions(+), 37 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2175/5

diff --git a=
/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index f91f226=2E=2E7721b55 10064=
4
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3765,6 +3765,76 @=
@
     return true;
 }
 
+/**
+ * Read the session form the packet buffer b=
uf and puts it into the
+ * parameter sid=2E
+ *
+ * @return true if the ex=
traction was successful, false otherwise
+ */
+static bool
+tls_pre_decrypt=
_extract_session_id(const struct link_socket_actual *from,
+               =
                    struct buffer buf, struct session_id *sid)
+{
+    /* s=
kip op code */
+    buf_advance(&buf, 1);
+    if (!session_id_read(sid, &b=
uf) || !session_id_defined(sid))
+    {
+        struct gc_arena gc =3D gc_=
new();
+        msg(D_TLS_ERRORS, "TLS Error: session-id not found in packe=
t from %s",
+            print_link_socket_actual(from, &gc));
+        gc_=
free(&gc);
+        return false;
+    }
+    return true;
+}
+
+/**
+ *  F=
ind session matching the session id in sid in multi=2Esession array
+ *
+ *=
 @return index of session in multi=2Esession array, TM_SIZE if not found
+ =
*         and -1 on error
+ */
+static int
+tls_pre_decrypt_find_session(st=
ruct tls_multi *multi, const struct link_socket_actual *from,
+            =
                 const struct session_id *sid)
+{
+    struct gc_arena gc =
=3D gc_new();
+    int i;
+    /* use session ID to match up packet with ap=
propriate tls_session object */
+    for (i =3D 0; i < TM_SIZE; ++i)
+    {=

+        struct tls_session *session =3D &multi->session[i];
+        stru=
ct key_state *ks =3D &session->key[KS_PRIMARY];
+
+        dmsg(
+         =
   D_TLS_DEBUG,
+            "TLS: initial packet test, i=3D%d state=3D%s, =
mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s",
+ =
           i, state_name(ks->state), session_id_print(&session->session_id,=
 &gc),
+            session_id_print(sid, &gc), print_link_socket_actual(fr=
om, &gc),
+            session_id_print(&ks->session_id_remote, &gc),
+    =
        print_link_socket_actual(&ks->remote_addr, &gc));
+
+        if (se=
ssion_id_equal(&ks->session_id_remote, sid))
+        /* found a match */
+=
        {
+            if (i =3D=3D TM_LAME_DUCK)
+            {
+         =
       msg(D_TLS_ERRORS, "TLS ERROR: received control packet with stale ses=
sion-id=3D%s",
+                    session_id_print(sid, &gc));
+         =
       i =3D -1;
+                goto done;
+            }
+            dm=
sg(D_TLS_DEBUG, "TLS: found match, session[%d], sid=3D%s", i,
+            =
     session_id_print(sid, &gc));
+            break;
+        }
+    }
+
+=
done:
+    gc_free(&gc);
+    return i;
+}
+
 /*
  *
  * When we are in TLS=
 mode, this is the first routine which sees
@@ -3820,7 +3890,6 @@
     /* c=
ontrol channel packet */
     bool do_burst =3D false;
     bool new_link =
=3D false;
-    struct session_id sid; /* remote session ID */
 
     /* ve=
rify legal opcode */
     if (!tls_pre_decrypt_verify_opcode(op, multi->opt=
=2Eserver, from))
@@ -3834,46 +3903,16 @@
     dmsg(D_TLS_DEBUG, "TLS: cont=
rol channel, op=3D%s, IP=3D%s", packet_opcode_name(op),
          print_lin=
k_socket_actual(from, &gc));
 
-    /* get remote session-id */
+    struct=
 session_id sid; /* remote session ID */
+    if (!tls_pre_decrypt_extract_=
session_id(from, *buf, &sid))
     {
-        struct buffer tmp =3D *buf;
-=
        buf_advance(&tmp, 1);
-        if (!session_id_read(&sid, &tmp) || =
!session_id_defined(&sid))
-        {
-            msg(D_TLS_ERRORS, "TLS E=
rror: session-id not found in packet from %s",
-                print_link_=
socket_actual(from, &gc));
-            goto error;
-        }
+        got=
o error;
     }
 
-    int i;
-    /* use session ID to match up packet wit=
h appropriate tls_session object */
-    for (i =3D 0; i < TM_SIZE; ++i)
+ =
   int i =3D tls_pre_decrypt_find_session(multi, from, &sid);
+    if (i =
=3D=3D -1)
     {
-        struct tls_session *session =3D &multi->session[=
i];
-        struct key_state *ks =3D &session->key[KS_PRIMARY];
-
-       =
 dmsg(
-            D_TLS_DEBUG,
-            "TLS: initial packet test, i=
=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, s=
tored-ip=3D%s",
-            i, state_name(ks->state), session_id_print(&se=
ssion->session_id, &gc),
-            session_id_print(&sid, &gc), print_li=
nk_socket_actual(from, &gc),
-            session_id_print(&ks->session_id_=
remote, &gc),
-            print_link_socket_actual(&ks->remote_addr, &gc))=
;
-
-        if (session_id_equal(&ks->session_id_remote, &sid))
-        /=
* found a match */
-        {
-            if (i =3D=3D TM_LAME_DUCK)
-    =
        {
-                msg(D_TLS_ERRORS, "TLS ERROR: received control p=
acket with stale session-id=3D%s",
-                    session_id_print(&s=
id, &gc));
-                goto error;
-            }
-            dmsg(D_=
TLS_DEBUG, "TLS: found match, session[%d], sid=3D%s", i,
-                 =
session_id_print(&sid, &gc));
-            break;
-        }
+        goto =
error;
     }
 
     /*

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2175?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Gerrit-Change-Number: 21=
75
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--t7DF5J+6/1c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
5?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ext=
ract tls_pre_decrypt_extract_session_id and pre_decrypt_find_session<br><br=
>These functions fulfil steps that can be easily moved to their own<br>func=
tions to make tls_pre_decrypt a bit more readable=2E<br><br>Change-Id: I230=
b3b2483e15477b179b277dc8f7c91c53fa0c0<br>Signed-off-by: Arne Schwabe &lt;ar=
ne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175<br>Mess=
age-Id: &lt;20261113104930=2E25197-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4=
1246=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 76 insertions(+), 37 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/75/2175/5</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index f91f226=2E=2E7721b55 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -3765,6 +3765,76 @@</span><br><span>     retu=
rn true;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Read the session form the packet buffer buf and puts it into t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * parameter sid=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the extraction=
 was successful, false otherwise</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_pre_dec=
rypt_extract_session_id(const struct link_socket_actual *from,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
   struct buffer buf, struct session_id *sid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* skip op code */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_advance(&amp;buf, 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!session_id_read(sid, &amp;buf) || !session_id=
_defined(sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(D_TLS_ERRORS, &quot;TLS Error: session-id not found in packet=
 from %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        print_link_socket_actual(from, &amp;gc));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Find session matching the se=
ssion id in sid in multi=2Esession array</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return index of session in multi=2Esession array, TM_SIZE if not fo=
und</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         and -=
1 on error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_find_session(struc=
t tls_multi *multi, const struct link_socket_actual *from,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                             const s=
truct session_id *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
use session ID to match up packet with appropriate tls_session object */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &l=
t; TM_SIZE; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tl=
s_session *session =3D &amp;multi-&gt;session[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct key_state *ks =3D &amp;session=
-&gt;key[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            D_TLS_DEBUG=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;=
TLS: initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-=
ip=3D%s, stored-sid=3D%s, stored-ip=3D%s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            i, state_name(ks-&gt;state), sessio=
n_id_print(&amp;session-&gt;session_id, &amp;gc),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            session_id_print(sid, &amp;gc), p=
rint_link_socket_actual(from, &amp;gc),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            session_id_print(&amp;ks-&gt;session_id_rem=
ote, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       print_link_socket_actual(&amp;ks-&gt;remote_addr, &amp;gc));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (session_id_equal(&amp;ks-&gt;sessi=
on_id_remote, sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* found a match */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (i =3D=3D TM_LAME_DUCK)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                msg(D_TLS_ERRORS, &quot;TLS ERROR: received cont=
rol packet with stale session-id=3D%s&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    session_id_print(sid, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
 =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  dmsg(D_TLS_DEBUG, &quot;TLS: found match, session[%d], sid=3D%s&quot;, i,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 se=
ssion_id_print(sid, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return i;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /*</span><br><span>  *</span><br><span>  * When we =
are in TLS mode, this is the first routine which sees</span><br><span>@@ -3=
820,7 +3890,6 @@</span><br><span>     /* control channel packet */</span><b=
r><span>     bool do_burst =3D false;</span><br><span>     bool new_link =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
session_id sid; /* remote session ID */</span><br><span> </span><br><span> =
    /* verify legal opcode */</span><br><span>     if (!tls_pre_decrypt_ver=
ify_opcode(op, multi-&gt;opt=2Eserver, from))</span><br><span>@@ -3834,46 +=
3903,16 @@</span><br><span>     dmsg(D_TLS_DEBUG, &quot;TLS: control channe=
l, op=3D%s, IP=3D%s&quot;, packet_opcode_name(op),</span><br><span>        =
  print_link_socket_actual(from, &amp;gc));</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* get remote session-id */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id s=
id; /* remote session ID */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!tls_pre_decrypt_extract_session_id(from, *buf, &amp;sid))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        struct buffer tmp =3D *buf;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        buf_advance(&amp;tmp, 1);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (!session_id_read(&amp;sid, &amp;tmp)=
 || !session_id_defined(&amp;sid))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(D_TLS_ERRORS, &quot;TLS Error: session-id not found in pac=
ket from %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             print_link_socket_actual(from, &amp;gc));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto error;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* use session ID =
to match up packet with appropriate tls_session object */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; TM_SIZE; ++i)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D tls_pr=
e_decrypt_find_session(multi, from, &amp;sid);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (i =3D=3D -1)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tls_session=
 *session =3D &amp;multi-&gt;session[i];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct key_state *ks =3D &amp;session-&gt;key[KS=
_PRIMARY];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            D_TLS_DEBUG,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            &quot;TLS: initial packet=
 test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=
=3D%s, stored-ip=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            i, state_name(ks-&gt;state), session_id_print(&amp;sessi=
on-&gt;session_id, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            session_id_print(&amp;sid, &amp;gc), print_link_socket_a=
ctual(from, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            session_id_print(&amp;ks-&gt;session_id_remote, &amp;gc),</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_link_sock=
et_actual(&amp;ks-&gt;remote_addr, &amp;gc));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (session_id_equal(&amp;ks-&gt;session_id_remote, &amp;sid))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* found a matc=
h */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (i =3D=3D TM_L=
AME_DUCK)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
D_TLS_ERRORS, &quot;TLS ERROR: received control packet with stale session-i=
d=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            session_id_print(&amp;sid, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                goto error;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            dmsg(D_TLS_DEBUG, &quot;TLS: found ma=
tch, session[%d], sid=3D%s&quot;, i,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                 session_id_print(&amp;sid, &amp;gc));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span>    =
 }</span><br><span> </span><br><span>     /*</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail"=
>change 2175</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
75?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2175 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--t7DF5J+6/1c=--


--===============7857166229779304725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7857166229779304725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7857166229779304725==--


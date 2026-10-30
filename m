Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB525606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gkgPZlXF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A/f2dkyv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SdmNfZJb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Byt+QIAa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3BN6I5PIc6Zfd30AT60oYjy2enrpXPxJaR+w9JxvS+Q=; b=gkgPZlXFJG6rEaahvXWcT0plZ5
	Mnoe/M1jrGAv5H2RM7d1jjlfI2h3PLAGNWkqaAGfViuw1Gh7roW6Py9bEHMZlfH6kLrfD9kCtDW0N
	Ka7Mxl9JoNI2uyl9Wk9cXAOyilvojAji6Z42zJxVO1riFGqoSjO8brGOCp3P0ALU54H4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrHQ-000000001il-2AD9;
	Fri, 30 Oct 2026 18:24:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrHP-000000001h4-25Iv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p3kYw7bENhD3BNEgIWSk7u6XPBEJgI/YSGX03TbaAHs=; b=A/f2dkyvC2OPILQ2VkckMN6z0b
 zUfrIjCSqP7BFBdZwGmv3j6/L/B9HcmUowo7AMWqDmUqozuFEB44dmjCi8Jg9qUGZGmROBvFSGTrh
 G8Q1lcBu5YArknuOlzjpTFsXrn+Zse+n7vnTH3Wg2AX/EGSOnUtaoRyYu3xYp8IfTwyM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p3kYw7bENhD3BNEgIWSk7u6XPBEJgI/YSGX03TbaAHs=; b=SdmNfZJbZF4qU6kipRapGEYDDc
 R4qQz0tWlIj3vJzi0L21nQMdJPuuhZZcUik9VqqjqCyBiygg4ZZ5Zywoi8vL5rckZAo5n0oqKq5Xz
 r1MDeOUFxjWMju+upi/digBriwvt0C/+fV7cZ1IXDAvyo6zXJJZ0CWc7g8msYODrYrX8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrH4-000000000wb-2OX8 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:24:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so8286585e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793384656; x=1793989456; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p3kYw7bENhD3BNEgIWSk7u6XPBEJgI/YSGX03TbaAHs=;
 b=Byt+QIAaEbRDW4kPCkMwVt0ms7vvUV/QSaVLh07RJf9sYdR9Td2RBCxUFupCWzVZnD
 jE75h7+jJlrxMLVtyIMG5UhECcLf1X2iBkALMfu3AWQvFThgxBIkxzIxZrwQkCEglhoY
 ojqrGwHps2TpuF/lLapJ/2MBPAwvMdSopq8czod7knQwK4cspBx5M27PaiX981OYMhoP
 sv+R1c+1Ax8aZWx+bYOTfLZr9ZwXqGwWANAcSYgk/X+v/G6EWdcsN4pIE6CRqDBNsG7R
 l0DrR++pltaGGdAkRGBLHCsrY9ZQmlQqdJGDZ60rZepCeNBZqRP2UxCB/Jvzr3cbRmz8
 mFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384656; x=1793989456;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p3kYw7bENhD3BNEgIWSk7u6XPBEJgI/YSGX03TbaAHs=;
 b=ScyA6/P26b2faiRU9O9BR1a8LhOwnOA9GNd8t1L+u0JZHiyyqbGMhszwNI3BnUC8e1
 JhvYWq3AEJOchqc7RR/dyYa+fkpoVk9nU4MhmAZfInYBkvJWLwop68tyMvprxvDTi7bs
 M9Zqz8cerMdiWMOuleWcWOy73lGxTGsJrxAFMArVsk6DDeqTrEGcQHE7nNql9w9t3Sip
 YSUQWf6rk+Ao9RAXlhVVBiA1ogY1pgfhYlU5cPZYyCUKewn4nfGdtZeJjdZcn3P5jx7f
 /FwXAJ7BZ1BwUOSRtfKVrE18/uN9AYwZfMCp/QZJLxo7GVha7hS4Al49F87C0pqXXsro
 XwUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxySuEOAe47KII7dfB25kiHGp108p70mvtPX3fk3R61oZQBMOmBizpnmzltfoO/B6rW4G1DIZLRgbIuQ8UM@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIrf6HMdIN7uXyDVUUFgb0u2lpqWaaA1Z35ejExdlOWrHtascYD
 mftpwKaM+aZDgpijnp+WPQq+xI4Jg2TW5Jdmgnf9WcePE0JzWCxB5QsAjeWu3gnNxNxOYRP/zfF
 +YBaJiTfc69MmvQh0aILML0ENyb+EUHNkVk9H7P+jfg4cUb/zHDZ9DHT4EMvIZrUo0FyZ
X-Gm-Gg: AYBFou3kMrpYzlJU3BfzLysRN2+tHh3rn3qLjGaonUHYa42qtpu5/v1qZR7eVN1HGaa
 uhFo5tixkyL7GzzvEleHh6N3aDzcLNptrFSM7sSJJb3oyJiWZUKyLycKckOwHF1uxUMtVPL9yly
 eRsNmGk1jJbmgANtAxHvJrU6R8DfmgHS10veyfX+mIEpn4rLDdcc/CkU5hodCmsk8wmG/JGLv2d
 AcdOVmD+PYWSXZ/wIPiYci5R8r23IIYxTwbsKrmnGV2raba4tDKt8jb90+d4oh1Wg/SpSupRfEr
 1jSr88K5HX/uHPaCeVvbLSaNWuvk6owRin7c0nagjrFRhm+tvdo2jY03UvgK4uABU98sIXblnyQ
 T23SkvDqeqP5Pz9kYlXQZbtUzc9GfZKcMbxhDgfU6C2h4AThzqgPypboMGSsjeAuqkCrd+IbspG
 ZQB8ag6HemWTKuohgKEwOKoogLtw1PXKJX+rnbyGsjZFBhzlljqz1JmHmYWc/1Lana1DXn0rMrv
 X4Ihb4BXd1Ia//JBxi6L34tHbsmRa8WP81nFiAHPNNSM+lHEmsbLx+/kOYxeLOjNpoPtZ7qKN0A
 eFlI/S4tVNNEsdLCdAt8umc/uw7TBpqP506k/Kx0aXwakRHkCYmXUzDplqgkR17NzhDhdiLL7xe
 oRBxUMC0HX1Nh92QVD2ROHEb6RWpv9YHixWkI4J71uR+mRvknFwSj1puh3M6db2geVR04wIn10X
 CsUbuv2TW6zyUJfiY=
X-Received: by 2002:a05:600c:4e43:b0:4ab:e27d:e241 with SMTP id
 5b1f17b1804b1-4ac180f28f7mr67770495e9.15.1793384655753; 
 Fri, 30 Oct 2026 11:24:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a762bc1sm31575465e9.4.2026.10.30.11.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:24:15 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:24:14 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
X-Gerrit-Change-Number: 2043
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2043?usp=email>
X-Gerrit-Commit: 99701b0cc3facfc45581a0dac9a45a2899a59292
In-Reply-To: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
References: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhYzYyOTkwM2Y0OWFkOWUwZTFkMTg5MWFjZjM1ZTIwMDBmMzFmNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c694acee3fda1d65d87b829685973ca065e9987-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrH4-000000000wb-2OX8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: move the
 link write functions to multi_io.c
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
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7017214285833744006=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7017214285833744006==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JSJrFd3VCCw="; charset=UTF-8

--JSJrFd3VCCw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2043?usp=3Demail )

Change subject: multi_io: move the link wri=
te functions to multi_io=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

multi_io: move the link write functions to multi_io=2Ec

W=
riting an instance's to_link was spread over three files: choosing the
inst=
ance in multi_process_outgoing_link_pre() and the actual write in
multi_pro=
cess_outgoing_link_dowork(), both static inline in multi=2Eh,
and the write=
-or-queue logic in mtcp=2Ec as
multi_tcp_process_outgoing_link() and
multi_=
tcp_process_outgoing_link_ready(), although they serve UDP
instances as wel=
l=2E

Move them to multi_io=2Ec next to their callers in multi_io_dispatch(=
),
as multi_io_write_link_pre(), multi_io_send_link(),
multi_io_write_link(=
) and multi_io_write_link_deferred()=2E
multi_io_send_link() stays exported=
 for the UDP write event handler in
mudp=2Ec=2E Drop the prototype of multi=
_tcp_link_out_deferred(), which has
no definition=2E

No functional change=
=2E

Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
Signed-off-by: Gi=
anmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2043
Message-Id: <20261027124326=2E413-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4=
0195=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M src/openv=
pn/multi=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
6 files =
changed, 107 insertions(+), 112 deletions(-)




diff --git a/src/openvpn/m=
tcp=2Ec b/src/openvpn/mtcp=2Ec
index 2b5c5b1=2E=2E2d0af06 100644
--- a/src/=
openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -126,69 +126,3 @@
          =
          &mi->tcp_rwflags);
     }
 }
-
-bool
-multi_tcp_process_outgoing_=
link_ready(struct multi_context *m, struct multi_instance *mi,
-           =
                           const unsigned int mpp_flags)
-{
-    struct mbu=
f_item item;
-    bool ret =3D true;
-    ASSERT(mi);
-
-    /* extract fro=
m queue */
-    if (mbuf_extract_item(mi->tcp_link_out_deferred, &item)) /*=
 ciphertext IP packet */
-    {
-        dmsg(D_MULTI_TCP, "MULTI TCP: tran=
smitting previously deferred packet");
-
-        ASSERT(mi =3D=3D item=2Ei=
nstance);
-        mi->context=2Ec2=2Eto_link =3D item=2Ebuffer->buf;
-    =
    ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);
-        =
mbuf_free_buf(item=2Ebuffer);
-    }
-    return ret;
-}
-
-bool
-multi_tcp=
_process_outgoing_link(struct multi_context *m, bool defer, const unsigned =
int mpp_flags)
-{
-    struct multi_instance *mi =3D multi_process_outgoing=
_link_pre(m);
-    bool ret =3D true;
-
-    if (mi)
-    {
-        if ((d=
efer && !proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=2Eproto))
=
-            || mbuf_defined(mi->tcp_link_out_deferred))
-        {
-      =
      /* save to queue */
-            struct buffer *buf =3D &mi->context=
=2Ec2=2Eto_link;
-            if (BLEN(buf) > 0)
-            {
-          =
      struct mbuf_buffer *mb =3D mbuf_alloc_buf(buf);
-                stru=
ct mbuf_item item;
-
-                set_prefix(mi);
-                dmsg=
(D_MULTI_TCP, "MULTI TCP: queuing deferred packet");
-                item=
=2Ebuffer =3D mb;
-                item=2Einstance =3D mi;
-               =
 mbuf_add_item(mi->tcp_link_out_deferred, &item);
-                mbuf_fre=
e_buf(mb);
-                buf_reset(buf);
-                ret =3D multi_=
process_post(m, mi, mpp_flags);
-                if (!ret)
-               =
 {
-                    mi =3D NULL;
-                }
-                cl=
ear_prefix();
-            }
-        }
-        else
-        {
-         =
   ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);
-         =
   if (!ret)
-            {
-                mi =3D NULL;
-            }
- =
       }
-    }
-    return ret;
-}
diff --git a/src/openvpn/mtcp=2Eh b/src=
/openvpn/mtcp=2Eh
index de9d7ba=2E=2E47c6308 100644
--- a/src/openvpn/mtcp=
=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -41,16 +41,8 @@
 
 void multi_tcp_set_gl=
obal_rw_flags(struct multi_context *m, struct multi_instance *mi);
 
-bool =
multi_tcp_process_outgoing_link(struct multi_context *m, bool defer,
-     =
                                const unsigned int mpp_flags);
-
-bool mult=
i_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_ins=
tance *mi,
-                                           const unsigned int m=
pp_flags);
-
 struct multi_instance *multi_create_instance_tcp(struct multi=
_context *m, struct link_socket *sock);
 
-void multi_tcp_link_out_deferred=
(struct multi_context *m, struct multi_instance *mi);
-
 void multi_tcp_del=
ete_event(struct multi_io *multi_io, event_t event);
 
 #endif /* ifndef MT=
CP_H */
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 201d=
756=2E=2E217b299 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -29,6 +29,7 @@
 #include "multi=2Eh"
 #include <inttypes=2Eh>
 #inc=
lude "forward=2Eh"
+#include "multi_io=2Eh"
 
 #include "memdbg=2Eh"
 #incl=
ude "ssl_pkt=2Eh"
@@ -470,7 +471,7 @@
 {
     if (m->pending)
     {
-     =
   multi_process_outgoing_link_dowork(m, m->pending, mpp_flags);
+        m=
ulti_io_send_link(m, m->pending, mpp_flags);
     }
 }
 
diff --git a/src/o=
penvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 2d4983c=2E=2E5aed191 100644
=
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -294,7 +294,7 @@=

  * may need updating and some follow-up action may be required=2E  This
 =
 * function controls the necessary postprocessing=2E  It is called by many
=
  * other functions that handle VPN tunnel related activity, such as \c
- *=
 multi_process_incoming_link(), \c multi_process_outgoing_link(), \c
+ * mu=
lti_process_incoming_link(), \c multi_io_write_link(), \c
  * multi_process=
_incoming_tun(), \c multi_io_write_tun(), and \c
  * multi_process_timeout(=
), among others=2E
  *
@@ -412,27 +412,6 @@
 #endif
 
 /*
- * Determine whi=
ch instance has pending output
- * and prepare the output for sending in
- =
* the to_link buffer=2E
- */
-static inline struct multi_instance *
-multi_=
process_outgoing_link_pre(struct multi_context *m)
-{
-    struct multi_ins=
tance *mi =3D NULL;
-
-    if (m->pending)
-    {
-        mi =3D m->pendin=
g;
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        mi =3D multi=
_get_queue(m->mbuf);
-    }
-    return mi;
-}
-
-/*
  * Per-client route q=
uota management
  */
 
@@ -629,18 +608,6 @@
     (OPT_P_INSTANCE | OPT_P_IN=
HERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \
      | OPT_=
P_COMP | OPT_P_SOCKFLAGS)
 
-static inline bool
-multi_process_outgoing_lin=
k_dowork(struct multi_context *m, struct multi_instance *mi,
-             =
                      const unsigned int mpp_flags)
-{
-    bool ret =3D tr=
ue;
-    set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->conte=
xt=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_process_post(m, mi, mpp_flag=
s);
-    clear_prefix();
-    return ret;
-}
-
 /**
  * Determines if the i=
fconfig_push_local address falls into the range of the local
  * IP address=
es of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
diff =
--git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 164b214=
=2E=2Eac730b4 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi=
_io=2Ec
@@ -346,6 +346,104 @@
     clear_prefix();
 }
 
+/*
+ * Determine w=
hich instance has pending output
+ * and prepare the output for sending in
=
+ * the to_link buffer=2E
+ */
+static struct multi_instance *
+multi_io_wr=
ite_link_pre(struct multi_context *m)
+{
+    struct multi_instance *mi =3D=
 NULL;
+
+    if (m->pending)
+    {
+        mi =3D m->pending;
+    }
+  =
  else if (mbuf_defined(m->mbuf))
+    {
+        mi =3D multi_get_queue(m-=
>mbuf);
+    }
+    return mi;
+}
+
+bool
+multi_io_send_link(struct multi_=
context *m, struct multi_instance *mi, const unsigned int mpp_flags)
+{
+  =
  bool ret =3D true;
+    set_prefix(mi);
+    process_outgoing_link(&mi->c=
ontext, mi->context=2Ec2=2Elink_sockets[0]);
+    ret =3D multi_process_pos=
t(m, mi, mpp_flags);
+    clear_prefix();
+    return ret;
+}
+
+static boo=
l
+multi_io_write_link_deferred(struct multi_context *m, struct multi_insta=
nce *mi,
+                             const unsigned int mpp_flags)
+{
+  =
  struct mbuf_item item;
+    bool ret =3D true;
+    ASSERT(mi);
+
+    /*=
 extract from queue */
+    if (mbuf_extract_item(mi->tcp_link_out_deferred=
, &item)) /* ciphertext IP packet */
+    {
+        dmsg(D_MULTI_TCP, "MUL=
TI TCP: transmitting previously deferred packet");
+
+        ASSERT(mi =3D=
=3D item=2Einstance);
+        mi->context=2Ec2=2Eto_link =3D item=2Ebuffer=
->buf;
+        ret =3D multi_io_send_link(m, mi, mpp_flags);
+        mbuf=
_free_buf(item=2Ebuffer);
+    }
+    return ret;
+}
+
+static bool
+multi_=
io_write_link(struct multi_context *m, bool defer, const unsigned int mpp_f=
lags)
+{
+    struct multi_instance *mi =3D multi_io_write_link_pre(m);
+  =
  bool ret =3D true;
+
+    if (mi)
+    {
+        if ((defer && !proto_is=
_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=2Eproto))
+            || m=
buf_defined(mi->tcp_link_out_deferred))
+        {
+            /* save to =
queue */
+            struct buffer *buf =3D &mi->context=2Ec2=2Eto_link;
+=
            if (BLEN(buf) > 0)
+            {
+                struct mbuf_=
buffer *mb =3D mbuf_alloc_buf(buf);
+                struct mbuf_item item;=

+
+                set_prefix(mi);
+                dmsg(D_MULTI_TCP, "MUL=
TI TCP: queuing deferred packet");
+                item=2Ebuffer =3D mb;
+=
                item=2Einstance =3D mi;
+                mbuf_add_item(mi->=
tcp_link_out_deferred, &item);
+                mbuf_free_buf(mb);
+       =
         buf_reset(buf);
+                ret =3D multi_process_post(m, mi,=
 mpp_flags);
+                if (!ret)
+                {
+               =
     mi =3D NULL;
+                }
+                clear_prefix();
+    =
        }
+        }
+        else
+        {
+            ret =3D multi_io=
_send_link(m, mi, mpp_flags);
+            if (!ret)
+            {
+      =
          mi =3D NULL;
+            }
+        }
+    }
+    return ret;
+}=

+
 static struct multi_instance *
 multi_io_dispatch(struct multi_context =
*m, struct multi_instance *mi, const int action)
 {
@@ -399,15 +497,15 @@
 =

         case TA_SOCKET_WRITE_READY:
             ASSERT(mi);
-           =
 multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);
+            mult=
i_io_write_link_deferred(m, mi, mpp_flags);
             break;
 
         =
case TA_SOCKET_WRITE:
-            multi_tcp_process_outgoing_link(m, false=
, mpp_flags);
+            multi_io_write_link(m, false, mpp_flags);
      =
       break;
 
         case TA_SOCKET_WRITE_DEFERRED:
-            multi_=
tcp_process_outgoing_link(m, true, mpp_flags);
+            multi_io_write_=
link(m, true, mpp_flags);
             break;
 
         case TA_INITIAL:
d=
iff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index 4299c=
ba=2E=2Ec7f8f89 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/mul=
ti_io=2Eh
@@ -72,4 +72,7 @@
 
 void multi_io_delete_event(struct multi_io *=
multi_io, event_t event);
 
+bool multi_io_send_link(struct multi_context *=
m, struct multi_instance *mi,
+                        const unsigned int m=
pp_flags);
+
 #endif /* ifndef MULTI_IO_H */

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
Gerrit-=
Change-Number: 2043
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <=
gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--JSJrFd3VCCw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2043?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi_io: move the link write func=
tions to multi_io=2Ec<br><br>Writing an instance&#39;s to_link was spread o=
ver three files: choosing the<br>instance in multi_process_outgoing_link_pr=
e() and the actual write in<br>multi_process_outgoing_link_dowork(), both s=
tatic inline in multi=2Eh,<br>and the write-or-queue logic in mtcp=2Ec as<b=
r>multi_tcp_process_outgoing_link() and<br>multi_tcp_process_outgoing_link_=
ready(), although they serve UDP<br>instances as well=2E<br><br>Move them t=
o multi_io=2Ec next to their callers in multi_io_dispatch(),<br>as multi_io=
_write_link_pre(), multi_io_send_link(),<br>multi_io_write_link() and multi=
_io_write_link_deferred()=2E<br>multi_io_send_link() stays exported for the=
 UDP write event handler in<br>mudp=2Ec=2E Drop the prototype of multi_tcp_=
link_out_deferred(), which has<br>no definition=2E<br><br>No functional cha=
nge=2E<br><br>Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de<br>Signe=
d-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2043<br>Message-Id: &lt;20261027124326=2E41=
3-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg40195=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mtcp=2Ec<=
br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=
=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>6 files=
 changed, 107 insertions(+), 112 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 2b5c5b1=
=2E=2E2d0af06 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><=
span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -126,69 +126,3 @@</span>=
<br><span>                    &amp;mi-&gt;tcp_rwflags);</span><br><span>   =
  }</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_process_outgoing_link_ready=
(struct multi_context *m, struct multi_instance *mi,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                      const=
 unsigned int mpp_flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mbuf_i=
tem item;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret=
 =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* extract from queue */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (mbuf_extract_item(mi-&g=
t;tcp_link_out_deferred, &amp;item)) /* ciphertext IP packet */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        dmsg(D_MULTI_TCP, &quot;MULTI TCP: transm=
itting previously deferred packet&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ASSERT(mi =3D=3D item=2Einstance);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=2Eto_link =3D item=2Ebuffer=
-&gt;buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =
=3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        mbuf_free_buf(item=2Ebuffer);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_process_outgoing=
_link(struct multi_context *m, bool defer, const unsigned int mpp_flags)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D multi_pro=
cess_outgoing_link_pre(m);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if ((defer &amp;&amp; !proto_is_d=
gram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            || mbuf_defined(mi-&gt;=
tcp_link_out_deferred))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* save to queue */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            struct buffer *buf =3D &amp;mi-&gt;context=2Ec2=2Eto_link;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) =
&gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct=
 mbuf_buffer *mb =3D mbuf_alloc_buf(buf);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                struct mbuf_item item;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                set_prefix(mi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                dmsg(D_MULTI_TCP, &quot;MULTI TCP=
: queuing deferred packet&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                item=2Ebuffer =3D mb;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                item=2Einstance =3D mi;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                mbuf_add_item=
(mi-&gt;tcp_link_out_deferred, &amp;item);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                mbuf_free_buf(mb);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                buf_reset(buf);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                ret =3D multi_p=
rocess_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                if (!ret)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    mi =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                clear_prefix();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
 =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (!ret)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                mi =3D NULL;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span>=
<br><span>index de9d7ba=2E=2E47c6308 100644</span><br><span>--- a/src/openv=
pn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -=
41,16 +41,8 @@</span><br><span> </span><br><span> void multi_tcp_set_global=
_rw_flags(struct multi_context *m, struct multi_instance *mi);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_p=
rocess_outgoing_link(struct multi_context *m, bool defer,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                     co=
nst unsigned int mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp=
_process_outgoing_link_ready(struct multi_context *m, struct multi_instance=
 *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                           const unsigned int mpp_flags);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct multi_instance=
 *multi_create_instance_tcp(struct multi_context *m, struct link_socket *so=
ck);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> void multi_tcp_delete_event(struct multi_io *multi_io, event_t even=
t);</span><br><span> </span><br><span> #endif /* ifndef MTCP_H */</span><br=
><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><=
span>index 201d756=2E=2E217b299 100644</span><br><span>--- a/src/openvpn/mu=
dp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -29,6 =
+29,7 @@</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span> #=
include &lt;inttypes=2Eh&gt;</span><br><span> #include &quot;forward=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;m=
ulti_io=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n>@@ -470,7 +471,7 @@</span><br><span> {</span><br><span>     if (m-&gt;pen=
ding)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        multi_process_outgoing_link_dowork(m, m-&gt;pending, mpp_fla=
gs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_i=
o_send_link(m, m-&gt;pending, mpp_flags);</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=
=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 2d4983c=2E=2E5aed191 100=
644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/o=
penvpn/multi=2Eh</span><br><span>@@ -294,7 +294,7 @@</span><br><span>  * ma=
y need updating and some follow-up action may be required=2E  This</span><b=
r><span>  * function controls the necessary postprocessing=2E  It is called=
 by many</span><br><span>  * other functions that handle VPN tunnel related=
 activity, such as \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * multi_process_incoming_link(), \c multi_process_outgoing_link(), \c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi_process_incomin=
g_link(), \c multi_io_write_link(), \c</span><br><span>  * multi_process_in=
coming_tun(), \c multi_io_write_tun(), and \c</span><br><span>  * multi_pro=
cess_timeout(), among others=2E</span><br><span>  *</span><br><span>@@ -412=
,27 +412,6 @@</span><br><span> #endif</span><br><span> </span><br><span> /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Determine which in=
stance has pending output</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * and prepare the output for sending in</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * the to_link buffer=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline struct multi_instance *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-multi_process_outgoing_link_pre(struct multi_contex=
t *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        mi =3D m-&gt;pending;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        mi =3D multi_get_queue(m-&gt;mbuf);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return mi;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Per=
-client route quota management</span><br><span>  */</span><br><span> </span=
><br><span>@@ -629,18 +608,6 @@</span><br><span>     (OPT_P_INSTANCE | OPT_=
P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \</span><b=
r><span>      | OPT_P_COMP | OPT_P_SOCKFLAGS)</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_process_outgoing_link_dowork(s=
truct multi_context *m, struct multi_instance *mi,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                   const unsig=
ned int mpp_flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set_prefix(mi);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_lin=
k(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_process_post(m, =
mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cl=
ear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><s=
pan>  * Determines if the ifconfig_push_local address falls into the range =
of the local</span><br><span>  * IP addresses of the VPN interface (ifconfi=
g_local with ifconfig_remote_netmask)</span><br><span>diff --git a/src/open=
vpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 164b214=
=2E=2Eac730b4 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><=
br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -346,6 +346,104 =
@@</span><br><span>     clear_prefix();</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Determine which instance has pen=
ding output</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and p=
repare the output for sending in</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * the to_link buffer=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static struct multi_instance *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+multi_io_write_link_pre(struct multi_context *m)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (m-&gt;pending)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        mi =3D m-&gt;pending;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        mi =3D multi_get_queue(m-&gt;mbuf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return mi;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_io_send_link(struct multi_=
context *m, struct multi_instance *mi, const unsigned int mpp_flags)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set_prefix(mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(&amp;mi-&gt;con=
text, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D multi_process_post(m, mi, mpp_flags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clear_prefix();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+multi_io_write_link_deferred(struct multi_context *m, struct multi_i=
nstance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                      const unsigned int mpp_flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct mbuf_item item;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* extract from queue */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (mbuf_extract_item(mi-&gt;tcp_link_out_deferred, &amp;it=
em)) /* ciphertext IP packet */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      dmsg(D_MULTI_TCP, &quot;MULTI TCP: transmitting previously deferred p=
acket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mi =3D=3D =
item=2Einstance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      mi-&gt;context=2Ec2=2Eto_link =3D item=2Ebuffer-&gt;buf;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ret =3D multi_io_send_li=
nk(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        mbuf_free_buf(item=2Ebuffer);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_io_write_link(struct multi_context =
*m, bool defer, const unsigned int mpp_flags)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct multi_instance *mi =3D multi_io_write_link_pre(m);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if ((defer &amp;&amp; !proto_is_dgram(mi-&gt;context=2E=
c2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            || mbuf_defined(mi-&gt;tcp_link_out_deferre=
d))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* save to que=
ue */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            st=
ruct buffer *buf =3D &amp;mi-&gt;context=2Ec2=2Eto_link;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(buf) &gt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                struct mbuf_bu=
ffer *mb =3D mbuf_alloc_buf(buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                struct mbuf_item item;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                set_prefix(mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                dmsg(D_MULTI_TCP, &quot;MULTI TC=
P: queuing deferred packet&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                item=2Ebuffer =3D mb;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                item=2Einstance =3D mi;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mbuf_=
add_item(mi-&gt;tcp_link_out_deferred, &amp;item);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                mbuf_free_buf(mb);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                buf_reset(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r=
et =3D multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (!ret)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    mi =3D NULL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                clear_prefix();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            ret =3D multi_io_send_link(m, mi, mpp_flags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!r=
et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                mi =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> static struct multi_instance *</span><br><spa=
n> multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, co=
nst int action)</span><br><span> {</span><br><span>@@ -399,15 +497,15 @@</s=
pan><br><span> </span><br><span>         case TA_SOCKET_WRITE_READY:</span>=
<br><span>             ASSERT(mi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            multi_tcp_process_outgoing_link_ready(m, mi, mpp_f=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti_io_write_link_deferred(m, mi, mpp_flags);</span><br><span>            =
 break;</span><br><span> </span><br><span>         case TA_SOCKET_WRITE:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_pr=
ocess_outgoing_link(m, false, mpp_flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            multi_io_write_link(m, false, mpp_flags);=
</span><br><span>             break;</span><br><span> </span><br><span>    =
     case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            multi_tcp_process_outgoing_link(m, true, mpp_flag=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i_io_write_link(m, true, mpp_flags);</span><br><span>             break;</s=
pan><br><span> </span><br><span>         case TA_INITIAL:</span><br><span>d=
iff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><=
span>index 4299cba=2E=2Ec7f8f89 100644</span><br><span>--- a/src/openvpn/mu=
lti_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@=
@ -72,4 +72,7 @@</span><br><span> </span><br><span> void multi_io_delete_ev=
ent(struct multi_io *multi_io, event_t event);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool multi_io_send_link(struct=
 multi_context *m, struct multi_instance *mi,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        const unsigned int mpp_fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #endif /* ifndef MULTI_IO_H */</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demail">change 20=
43</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Iac629903f49ad9e0e1d1891acf35e2000f31f5de </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2043 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De =
Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--JSJrFd3VCCw=--


--===============7017214285833744006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7017214285833744006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7017214285833744006==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A05606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N/MFe0bl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nG0JS3Pu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lqG5H3mJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V/QYLJ1I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=0eVTeyF5IWgdCP1z+Wz/trNRgGfdEysUhdGHzgdpV9M=; b=N/MFe0blwegXVBhSMEkMMqb0oU
	Csdkxbr/oBO1SSJPWAcPugDIKFjyeKONHCBERFhRMF0iIP1ABWLstxNBOCVTQzhoCE9/fNuGXNS9G
	AIgC73n7FRju0JbrDsA53s2YLlYor7eGN0LTx/yd2cXMsesQCEEdls7KBrnDZizA9aqk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdlj-000000001k3-0Bv6;
	Tue, 27 Oct 2026 09:46:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlh-000000001jv-3gs1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pl/FvaKOE8Z4vqSg0Mq7MiowOyPIHw5x1R5Folw6YXc=; b=nG0JS3Pu4ltph6wFwhvUFrvkQg
 xi5YIljnvaTXbr6W1NHSIYVRYINwbAQS/qB6lrnmLtj9lMkvSSr/Fip5epSq/9Sdh9nY8CA3/o+GC
 tbVT8VjcAXE+8zxEHLwLItjlCgwNPXM0sBle3YG2fwyJiAzfQX6hWgIDDsxtOYM9iOOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pl/FvaKOE8Z4vqSg0Mq7MiowOyPIHw5x1R5Folw6YXc=; b=lqG5H3mJn0BrN7Ta60rZ34u8Bg
 7EIS4YjV70fGaIpgSUUnLtXq1HFJXHmlCsZObKQn8ZdTxc+jLimd4qiWogSggIoarQ7STkBhGziLl
 oQulvu6cTRW/pI+udqCszpfzOqXPVEGLyifqlYF/HDdhLB+BvawnPPUVZJoasMLhnO+c=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlg-0000000021D-0WLE for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:57 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso25459695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094409; x=1793699209; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pl/FvaKOE8Z4vqSg0Mq7MiowOyPIHw5x1R5Folw6YXc=;
 b=V/QYLJ1IY9oy3vCQrnXPU5928agzJuT1OI1yNZe1ELuMKXy/wTxqtVcWz17XRxcdfV
 tl15e+9h+KaeNDPxv6DkCRi3j332u4GelwgkZRCa4WBj0RfqMF27wLdHb8vS/AskE8Zm
 AWUCC+Gu/IZtyMS+ikgsOWeizXmR7FBp7Y060HdQna04rXmvse4AeVkY4zcbJUtkUw64
 Cf4eI9/G9spR5CDdwupH/f4CUlhoTe1DuiABdNjjGoSUsHhHMvnRrym7myclyx2IeOSk
 +OVADlFLEHy6uEb1PtozxzzkEZokCc0r5FamgrFszFRKQ7ER3EplJTLwjQqudUwi8UeC
 id6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094409; x=1793699209;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pl/FvaKOE8Z4vqSg0Mq7MiowOyPIHw5x1R5Folw6YXc=;
 b=m+8xjGw48++TsMS2/YchBTXcuavfEKOX7/1Q/3JJAOpCdzjrQ/1Hj715EffBcW/l3+
 b1JaYEFyNF9Gk4eQgtRMtW/Kz107dNVD8DnljE7stGQkxAJM84i2EjpUVQ1OhGxb5TNV
 /NCNUP/FESRDMyDs8rF1Hx1vlr2fPWqRvjvX9yJ60T86PrIuuTF0vKkh7NPXKrxKjAIc
 Sr5YYBN1TkFhGZpyRVm8ug9QuhBx71rDN4C3OnVDEcAq2NC1riaT+82WaAgvZoBd3lzu
 74Zw36iwTp9GiRLuXTI1cLjmVPqGwConvr7LZ1yslMdjGC/vN/0zPGnxbmp6Jn/1sX1L
 90uQ==
X-Gm-Message-State: AFq9FYJvEyBeAJBi7ZSXftWQ7KZI5zPV5xgLI4ghKfIQwckvhexW5q8m
 S+EBNzy/+OPPAYHOsoFFNXRy4JoswbYMGnNlIIKEIbfyNBXx9VFLG4mXTBMOnjbNIC32NDBQISZ
 4Wfafs6oaWMJIcHUaJKGlSeGLEKWST+8YdgS8CXrsTiMM3GiqlqKXFM+8pP0qMZV0e8By
X-Gm-Gg: AYBFou0dcWcgizQjPkAcwKHBRlVKKkGyfSexDufHj/NVDyEOiFgc160fbOZdm3rV/xR
 MSCQ4HY7vlYiv5yDbNJ1iBoVVtSUa/ammQA6gPsPA9ZYwUiw0o3RmzaBri7GNwIfSd7/3jIS37D
 yiVQpG6wb+QE6udqXNf3So5eYon9cbFnEge0TFxZKgiPXwMdROJ1HsvTLCHiI/qxEBzzyw2vMdN
 +Di2/nQptzylxNWM6c9WdF4pi5QnpGeh4vrNsgIFr4lHD62XoL+hVLGmtFwppjKA6t64i0ZUXAk
 FwWSoMciVK+Fu8cofbb0E2ydXcSq5EWK00y5eQyty17ivnBQZ0ZP1Mx2D4FOW3PSs9m5fbZJ2cb
 6adu2s3TGI+wsbd5BUude42lPcVwgxbFHU+CQ1aSfb+0t0zCQhAzFtrNM0CvTgUhGTL8ozoRE+t
 gNKXVNXx8S7Ei1cmxzWOrGRzC5YV6WrC6fpG6PRlJ7WHfmOalsN61BneDM+c5bRKAFrNvB14/br
 B182Z9TiZvb4lz7kjPziADP8H8PZ+bhvifgo47YD8oxPkD5vAPBut5nlTxxz3a5iWnVS9Ift5kw
 NUwsB8NvETr/TW1Q7ts5pvpwJi8O7sVZns5MVyGW+EuCRE5hEtzQ/4jkGbtTegfEbcHanl12Ih+
 nahkfgB2LVcYMe4qqGDxCIdivVxf3iht89aH5CxKXsw==
X-Received: by 2002:a05:600c:8b66:b0:4a2:a8c:22b0 with SMTP id
 5b1f17b1804b1-4a35ac3b3d9mr169540265e9.1.1793094409312; 
 Tue, 27 Oct 2026 02:46:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm23763840f8f.32.2026.10.27.02.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:46:48 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:46:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
X-Gerrit-Change-Number: 2043
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2043?usp=email>
X-Gerrit-Commit: 557539c473eed85da762d2ee6d22a5aadb0ff15d
References: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhYzYyOTkwM2Y0OWFkOWUwZTFkMTg5MWFjZjM1ZTIwMDBmMzFmNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff9f84610a64d283e192dc0a025c4d253e848d00-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlg-0000000021D-0WLE
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8139343919716130839=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8139343919716130839==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zfDhDk0nR00="; charset=UTF-8

--zfDhDk0nR00=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2043?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: move the link write functions to multi_io=2Ec
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: mov=
e the link write functions to multi_io=2Ec

Writing an instance's to_link w=
as spread over three files: choosing the
instance in multi_process_outgoing=
_link_pre() and the actual write in
multi_process_outgoing_link_dowork(), b=
oth static inline in multi=2Eh,
and the write-or-queue logic in mtcp=2Ec as=

multi_tcp_process_outgoing_link() and
multi_tcp_process_outgoing_link_read=
y(), although they serve UDP
instances as well=2E

Move them to multi_io=2E=
c next to their callers in multi_io_dispatch(),
as multi_io_write_link_pre(=
), multi_io_send_link(),
multi_io_write_link() and multi_io_write_link_defe=
rred()=2E
multi_io_send_link() stays exported for the UDP write event handl=
er in
mudp=2Ec=2E Drop the prototype of multi_tcp_link_out_deferred(), whic=
h has
no definition=2E

No functional change=2E

Change-Id: Iac629903f49ad9=
e0e1d1891acf35e2000f31f5de
Signed-off-by: Gianmarco De Gregori <gianmarco@m=
andelbit=2Ecom>
---
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/ope=
nvpn/mudp=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
M src/open=
vpn/multi_io=2Eh
6 files changed, 107 insertions(+), 112 deletions(-)



  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2043/1
=

diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 2b5c5b1=2E=
=2E2d0af06 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ =
-126,69 +126,3 @@
                    &mi->tcp_rwflags);
     }
 }
-
-bool
=
-multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi,
-                                      const unsigned int m=
pp_flags)
-{
-    struct mbuf_item item;
-    bool ret =3D true;
-    ASSER=
T(mi);
-
-    /* extract from queue */
-    if (mbuf_extract_item(mi->tcp_l=
ink_out_deferred, &item)) /* ciphertext IP packet */
-    {
-        dmsg(D=
_MULTI_TCP, "MULTI TCP: transmitting previously deferred packet");
-
-     =
   ASSERT(mi =3D=3D item=2Einstance);
-        mi->context=2Ec2=2Eto_link =
=3D item=2Ebuffer->buf;
-        ret =3D multi_process_outgoing_link_dowork=
(m, mi, mpp_flags);
-        mbuf_free_buf(item=2Ebuffer);
-    }
-    retu=
rn ret;
-}
-
-bool
-multi_tcp_process_outgoing_link(struct multi_context *m=
, bool defer, const unsigned int mpp_flags)
-{
-    struct multi_instance *=
mi =3D multi_process_outgoing_link_pre(m);
-    bool ret =3D true;
-
-    i=
f (mi)
-    {
-        if ((defer && !proto_is_dgram(mi->context=2Ec2=2Elin=
k_sockets[0]->info=2Eproto))
-            || mbuf_defined(mi->tcp_link_out_=
deferred))
-        {
-            /* save to queue */
-            struct =
buffer *buf =3D &mi->context=2Ec2=2Eto_link;
-            if (BLEN(buf) > 0=
)
-            {
-                struct mbuf_buffer *mb =3D mbuf_alloc_buf=
(buf);
-                struct mbuf_item item;
-
-                set_prefi=
x(mi);
-                dmsg(D_MULTI_TCP, "MULTI TCP: queuing deferred pack=
et");
-                item=2Ebuffer =3D mb;
-                item=2Einstan=
ce =3D mi;
-                mbuf_add_item(mi->tcp_link_out_deferred, &item)=
;
-                mbuf_free_buf(mb);
-                buf_reset(buf);
-   =
             ret =3D multi_process_post(m, mi, mpp_flags);
-               =
 if (!ret)
-                {
-                    mi =3D NULL;
-          =
      }
-                clear_prefix();
-            }
-        }
-       =
 else
-        {
-            ret =3D multi_process_outgoing_link_dowork(m,=
 mi, mpp_flags);
-            if (!ret)
-            {
-                mi =
=3D NULL;
-            }
-        }
-    }
-    return ret;
-}
diff --git a=
/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index de9d7ba=2E=2E47c6308 100=
644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -41,16 +41,8 @=
@
 
 void multi_tcp_set_global_rw_flags(struct multi_context *m, struct mul=
ti_instance *mi);
 
-bool multi_tcp_process_outgoing_link(struct multi_cont=
ext *m, bool defer,
-                                     const unsigned in=
t mpp_flags);
-
-bool multi_tcp_process_outgoing_link_ready(struct multi_co=
ntext *m, struct multi_instance *mi,
-                                     =
      const unsigned int mpp_flags);
-
 struct multi_instance *multi_create=
_instance_tcp(struct multi_context *m, struct link_socket *sock);
 
-void m=
ulti_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *=
mi);
-
 void multi_tcp_delete_event(struct multi_io *multi_io, event_t even=
t);
 
 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec
index 201d756=2E=2E217b299 100644
--- a/src/openvpn/mudp=2E=
c
+++ b/src/openvpn/mudp=2Ec
@@ -29,6 +29,7 @@
 #include "multi=2Eh"
 #incl=
ude <inttypes=2Eh>
 #include "forward=2Eh"
+#include "multi_io=2Eh"
 
 #inc=
lude "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
@@ -470,7 +471,7 @@
 {
     if (m=
->pending)
     {
-        multi_process_outgoing_link_dowork(m, m->pending=
, mpp_flags);
+        multi_io_send_link(m, m->pending, mpp_flags);
     }=

 }
 
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 2d49=
83c=2E=2E5aed191 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=
=2Eh
@@ -294,7 +294,7 @@
  * may need updating and some follow-up action ma=
y be required=2E  This
  * function controls the necessary postprocessing=
=2E  It is called by many
  * other functions that handle VPN tunnel relate=
d activity, such as \c
- * multi_process_incoming_link(), \c multi_process_=
outgoing_link(), \c
+ * multi_process_incoming_link(), \c multi_io_write_li=
nk(), \c
  * multi_process_incoming_tun(), \c multi_io_write_tun(), and \c
=
  * multi_process_timeout(), among others=2E
  *
@@ -412,27 +412,6 @@
 #end=
if
 
 /*
- * Determine which instance has pending output
- * and prepare th=
e output for sending in
- * the to_link buffer=2E
- */
-static inline struc=
t multi_instance *
-multi_process_outgoing_link_pre(struct multi_context *m=
)
-{
-    struct multi_instance *mi =3D NULL;
-
-    if (m->pending)
-    {=

-        mi =3D m->pending;
-    }
-    else if (mbuf_defined(m->mbuf))
- =
   {
-        mi =3D multi_get_queue(m->mbuf);
-    }
-    return mi;
-}
-
=
-/*
  * Per-client route quota management
  */
 
@@ -629,18 +608,6 @@
     =
(OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG |=
 OPT_P_ECHO \
      | OPT_P_COMP | OPT_P_SOCKFLAGS)
 
-static inline bool
-=
multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_in=
stance *mi,
-                                   const unsigned int mpp_flag=
s)
-{
-    bool ret =3D true;
-    set_prefix(mi);
-    process_outgoing_li=
nk(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_pr=
ocess_post(m, mi, mpp_flags);
-    clear_prefix();
-    return ret;
-}
-
 /=
**
  * Determines if the ifconfig_push_local address falls into the range o=
f the local
  * IP addresses of the VPN interface (ifconfig_local with ifco=
nfig_remote_netmask)
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/mu=
lti_io=2Ec
index 164b214=2E=2Eac730b4 100644
--- a/src/openvpn/multi_io=2Ec=

+++ b/src/openvpn/multi_io=2Ec
@@ -346,6 +346,104 @@
     clear_prefix();
=
 }
 
+/*
+ * Determine which instance has pending output
+ * and prepare th=
e output for sending in
+ * the to_link buffer=2E
+ */
+static struct multi=
_instance *
+multi_io_write_link_pre(struct multi_context *m)
+{
+    struc=
t multi_instance *mi =3D NULL;
+
+    if (m->pending)
+    {
+        mi =
=3D m->pending;
+    }
+    else if (mbuf_defined(m->mbuf))
+    {
+       =
 mi =3D multi_get_queue(m->mbuf);
+    }
+    return mi;
+}
+
+bool
+multi_=
io_send_link(struct multi_context *m, struct multi_instance *mi, const unsi=
gned int mpp_flags)
+{
+    bool ret =3D true;
+    set_prefix(mi);
+    pr=
ocess_outgoing_link(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
+   =
 ret =3D multi_process_post(m, mi, mpp_flags);
+    clear_prefix();
+    re=
turn ret;
+}
+
+static bool
+multi_io_write_link_deferred(struct multi_cont=
ext *m, struct multi_instance *mi,
+                             const unsi=
gned int mpp_flags)
+{
+    struct mbuf_item item;
+    bool ret =3D true;
=
+    ASSERT(mi);
+
+    /* extract from queue */
+    if (mbuf_extract_item=
(mi->tcp_link_out_deferred, &item)) /* ciphertext IP packet */
+    {
+    =
    dmsg(D_MULTI_TCP, "MULTI TCP: transmitting previously deferred packet")=
;
+
+        ASSERT(mi =3D=3D item=2Einstance);
+        mi->context=2Ec2=
=2Eto_link =3D item=2Ebuffer->buf;
+        ret =3D multi_io_send_link(m, m=
i, mpp_flags);
+        mbuf_free_buf(item=2Ebuffer);
+    }
+    return re=
t;
+}
+
+static bool
+multi_io_write_link(struct multi_context *m, bool def=
er, const unsigned int mpp_flags)
+{
+    struct multi_instance *mi =3D mul=
ti_io_write_link_pre(m);
+    bool ret =3D true;
+
+    if (mi)
+    {
+   =
     if ((defer && !proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=
=2Eproto))
+            || mbuf_defined(mi->tcp_link_out_deferred))
+      =
  {
+            /* save to queue */
+            struct buffer *buf =3D &m=
i->context=2Ec2=2Eto_link;
+            if (BLEN(buf) > 0)
+            {
+=
                struct mbuf_buffer *mb =3D mbuf_alloc_buf(buf);
+          =
      struct mbuf_item item;
+
+                set_prefix(mi);
+          =
      dmsg(D_MULTI_TCP, "MULTI TCP: queuing deferred packet");
+           =
     item=2Ebuffer =3D mb;
+                item=2Einstance =3D mi;
+      =
          mbuf_add_item(mi->tcp_link_out_deferred, &item);
+               =
 mbuf_free_buf(mb);
+                buf_reset(buf);
+                ret =
=3D multi_process_post(m, mi, mpp_flags);
+                if (!ret)
+     =
           {
+                    mi =3D NULL;
+                }
+        =
        clear_prefix();
+            }
+        }
+        else
+        {
=
+            ret =3D multi_io_send_link(m, mi, mpp_flags);
+            if =
(!ret)
+            {
+                mi =3D NULL;
+            }
+       =
 }
+    }
+    return ret;
+}
+
 static struct multi_instance *
 multi_io_d=
ispatch(struct multi_context *m, struct multi_instance *mi, const int actio=
n)
 {
@@ -399,15 +497,15 @@
 
         case TA_SOCKET_WRITE_READY:
        =
     ASSERT(mi);
-            multi_tcp_process_outgoing_link_ready(m, mi, =
mpp_flags);
+            multi_io_write_link_deferred(m, mi, mpp_flags);
  =
           break;
 
         case TA_SOCKET_WRITE:
-            multi_tcp_p=
rocess_outgoing_link(m, false, mpp_flags);
+            multi_io_write_link=
(m, false, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_=
DEFERRED:
-            multi_tcp_process_outgoing_link(m, true, mpp_flags);=

+            multi_io_write_link(m, true, mpp_flags);
             break;
=
 
         case TA_INITIAL:
diff --git a/src/openvpn/multi_io=2Eh b/src/ope=
nvpn/multi_io=2Eh
index 4299cba=2E=2Ec7f8f89 100644
--- a/src/openvpn/multi=
_io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ -72,4 +72,7 @@
 
 void multi_io_d=
elete_event(struct multi_io *multi_io, event_t event);
 
+bool multi_io_sen=
d_link(struct multi_context *m, struct multi_instance *mi,
+               =
         const unsigned int mpp_flags);
+
 #endif /* ifndef MULTI_IO_H */

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac629903f49ad9e0=
e1d1891acf35e2000f31f5de
Gerrit-Change-Number: 2043
Gerrit-PatchSet: 1
Gerr=
it-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--zfDhDk0nR00=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: move the link write functions to multi_io=2Ec=
<br><br>Writing an instance&#39;s to_link was spread over three files: choo=
sing the<br>instance in multi_process_outgoing_link_pre() and the actual wr=
ite in<br>multi_process_outgoing_link_dowork(), both static inline in multi=
=2Eh,<br>and the write-or-queue logic in mtcp=2Ec as<br>multi_tcp_process_o=
utgoing_link() and<br>multi_tcp_process_outgoing_link_ready(), although the=
y serve UDP<br>instances as well=2E<br><br>Move them to multi_io=2Ec next t=
o their callers in multi_io_dispatch(),<br>as multi_io_write_link_pre(), mu=
lti_io_send_link(),<br>multi_io_write_link() and multi_io_write_link_deferr=
ed()=2E<br>multi_io_send_link() stays exported for the UDP write event hand=
ler in<br>mudp=2Ec=2E Drop the prototype of multi_tcp_link_out_deferred(), =
which has<br>no definition=2E<br><br>No functional change=2E<br><br>Change-=
Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de<br>Signed-off-by: Gianmarco D=
e Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/mtcp=2E=
c<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/mult=
i=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>6 file=
s changed, 107 insertions(+), 112 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2043/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><=
span>index 2b5c5b1=2E=2E2d0af06 100644</span><br><span>--- a/src/openvpn/mt=
cp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -126,6=
9 +126,3 @@</span><br><span>                    &amp;mi-&gt;tcp_rwflags);</=
span><br><span>     }</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_process_o=
utgoing_link_ready(struct multi_context *m, struct multi_instance *mi,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
            const unsigned int mpp_flags)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct mbuf_item item;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* extract from q=
ueue */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mbuf_e=
xtract_item(mi-&gt;tcp_link_out_deferred, &amp;item)) /* ciphertext IP pack=
et */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_MULTI_TCP, &quot;=
MULTI TCP: transmitting previously deferred packet&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ASSERT(mi =3D=3D item=2Einstance);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=2Eto_link =
=3D item=2Ebuffer-&gt;buf;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mbuf_free_buf(=
item=2Ebuffer);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_p=
rocess_outgoing_link(struct multi_context *m, bool defer, const unsigned in=
t mpp_flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi=
 =3D multi_process_outgoing_link_pre(m);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((defer &amp;&am=
p; !proto_is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || mbuf_d=
efined(mi-&gt;tcp_link_out_deferred))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /* save to queue */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            struct buffer *buf =3D &amp;mi-&gt;context=2Ec2=
=2Eto_link;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (BLEN(buf) &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          struct mbuf_buffer *mb =3D mbuf_alloc_buf(buf);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                struct mbuf_item item;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                set_prefix(mi);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                dmsg(D_MULTI_TCP,=
 &quot;MULTI TCP: queuing deferred packet&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                item=2Ebuffer =3D mb;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                item=2Einstance=
 =3D mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   mbuf_add_item(mi-&gt;tcp_link_out_deferred, &amp;item);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                mbuf_free_buf(mb);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_reset=
(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                if (!ret)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    mi =3D NULL;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                clear_prefix();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!ret)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                mi =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn=
/mtcp=2Eh</span><br><span>index de9d7ba=2E=2E47c6308 100644</span><br><span=
>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh</spa=
n><br><span>@@ -41,16 +41,8 @@</span><br><span> </span><br><span> void mult=
i_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *m=
i);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
              const unsigned int mpp_flags);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struc=
t multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                           const unsigned int mpp_flags);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struc=
t multi_instance *multi_create_instance_tcp(struct multi_context *m, struct=
 link_socket *sock);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void multi_tcp_link_out_deferred(struct multi_context *m, =
struct multi_instance *mi);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> void multi_tcp_delete_event(struct multi_io *multi_=
io, event_t event);</span><br><span> </span><br><span> #endif /* ifndef MTC=
P_H */</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 201d756=2E=2E217b299 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -29,6 +29,7 @@</span><br><span> #include &quot;multi=2Eh&quot;</s=
pan><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span> #include &quo=
t;forward=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;multi_io=2Eh&quot;</span><br><span> </span><br><span> #inclu=
de &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;=
</span><br><span>@@ -470,7 +471,7 @@</span><br><span> {</span><br><span>   =
  if (m-&gt;pending)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        multi_process_outgoing_link_dowork(m, m-&gt;p=
ending, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        multi_io_send_link(m, m-&gt;pending, mpp_flags);</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/=
openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 2d4983c=2E=
=2E5aed191 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><sp=
an>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -294,7 +294,7 @@</span><b=
r><span>  * may need updating and some follow-up action may be required=2E =
 This</span><br><span>  * function controls the necessary postprocessing=2E=
  It is called by many</span><br><span>  * other functions that handle VPN =
tunnel related activity, such as \c</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * multi_process_incoming_link(), \c multi_process_outgoing_l=
ink(), \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi_p=
rocess_incoming_link(), \c multi_io_write_link(), \c</span><br><span>  * mu=
lti_process_incoming_tun(), \c multi_io_write_tun(), and \c</span><br><span=
>  * multi_process_timeout(), among others=2E</span><br><span>  *</span><br=
><span>@@ -412,27 +412,6 @@</span><br><span> #endif</span><br><span> </span=
><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Dete=
rmine which instance has pending output</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * and prepare the output for sending in</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * the to_link buffer=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static inline struct multi_instance *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-multi_process_outgoing_link_pre(struc=
t multi_context *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_insta=
nce *mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        mi =3D m-&gt;pending;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        mi =3D multi_get_queue(m-&gt;mbuf);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return mi;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span>  * Per-client route quota management</span><br><span>  */</span><br><=
span> </span><br><span>@@ -629,18 +608,6 @@</span><br><span>     (OPT_P_INS=
TANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECH=
O \</span><br><span>      | OPT_P_COMP | OPT_P_SOCKFLAGS)</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_outgoing_l=
ink_dowork(struct multi_context *m, struct multi_instance *mi,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
 const unsigned int mpp_flags)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool re=
t =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set_pr=
efix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_=
outgoing_link(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_proc=
ess_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**<=
/span><br><span>  * Determines if the ifconfig_push_local address falls int=
o the range of the local</span><br><span>  * IP addresses of the VPN interf=
ace (ifconfig_local with ifconfig_remote_netmask)</span><br><span>diff --gi=
t a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>ind=
ex 164b214=2E=2Eac730b4 100644</span><br><span>--- a/src/openvpn/multi_io=
=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -346=
,6 +346,104 @@</span><br><span>     clear_prefix();</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Determine which inst=
ance has pending output</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * and prepare the output for sending in</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * the to_link buffer=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static struct multi_instance *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+multi_io_write_link_pre(struct multi_context *m)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;pending)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        mi =3D m-&gt;pending;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (mbuf_defined(m-&gt;mbuf))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        mi =3D multi_get_queue(m-&gt;mbuf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return mi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_send_link=
(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp=
_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    set_prefix(mi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(&=
amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ret =3D multi_process_post(m, m=
i, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
lear_prefix();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_io_write_link_deferred(struct multi_context *m, =
struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                             const unsigned int mpp_flags)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct mbuf_item item;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* extract from queue */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mbuf_extract_item(mi-&gt;tcp_link_out_defer=
red, &amp;item)) /* ciphertext IP packet */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        dmsg(D_MULTI_TCP, &quot;MULTI TCP: transmitting previousl=
y deferred packet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(mi =3D=3D item=2Einstance);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        mi-&gt;context=2Ec2=2Eto_link =3D item=2Ebuffer-&gt;buf;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D mult=
i_io_send_link(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        mbuf_free_buf(item=2Ebuffer);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_write_link(struct mu=
lti_context *m, bool defer, const unsigned int mpp_flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct multi_instance *mi =3D multi_io_write_link_p=
re(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if ((defer &amp;&amp; !proto_is_dgram(mi-&g=
t;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            || mbuf_defined(mi-&gt;tcp_li=
nk_out_deferred))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* save to queue */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            struct buffer *buf =3D &amp;mi-&gt;context=2Ec2=2Eto_link;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(buf=
) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
struct mbuf_buffer *mb =3D mbuf_alloc_buf(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                struct mbuf_item item;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                set_prefix(mi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                dmsg(D_MULTI_TCP, &=
quot;MULTI TCP: queuing deferred packet&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                item=2Ebuffer =3D mb;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                item=2Einstan=
ce =3D mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       mbuf_add_item(mi-&gt;tcp_link_out_deferred, &amp;item);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                mbuf_free_buf(mb=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                b=
uf_reset(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (!ret)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    mi =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                clear_p=
refix();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ret =3D multi_io_send_link(m, mi=
, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      mi =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static struct multi_instance *</spa=
n><br><span> multi_io_dispatch(struct multi_context *m, struct multi_instan=
ce *mi, const int action)</span><br><span> {</span><br><span>@@ -399,15 +49=
7,15 @@</span><br><span> </span><br><span>         case TA_SOCKET_WRITE_REA=
DY:</span><br><span>             ASSERT(mi);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            multi_tcp_process_outgoing_link_ready(m,=
 mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         multi_io_write_link_deferred(m, mi, mpp_flags);</span><br><span>  =
           break;</span><br><span> </span><br><span>         case TA_SOCKET=
_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mu=
lti_tcp_process_outgoing_link(m, false, mpp_flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi_io_write_link(m, false,=
 mpp_flags);</span><br><span>             break;</span><br><span> </span><b=
r><span>         case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            multi_tcp_process_outgoing_link(m, tr=
ue, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        multi_io_write_link(m, true, mpp_flags);</span><br><span>          =
   break;</span><br><span> </span><br><span>         case TA_INITIAL:</span=
><br><span>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh=
</span><br><span>index 4299cba=2E=2Ec7f8f89 100644</span><br><span>--- a/sr=
c/openvpn/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span=
><br><span>@@ -72,4 +72,7 @@</span><br><span> </span><br><span> void multi_=
io_delete_event(struct multi_io *multi_io, event_t event);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_io_send=
_link(struct multi_context *m, struct multi_instance *mi,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        const unsigne=
d int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #endif /* ifndef MULTI_IO_H */</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demai=
l">change 2043</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2043?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2043 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gi=
anmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--zfDhDk0nR00=--


--===============8139343919716130839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8139343919716130839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8139343919716130839==--


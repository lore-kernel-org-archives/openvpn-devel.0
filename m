Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC26606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AWuOGlL9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A1YXkSoe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FrLoK0PM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Eg368KyI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=84DaeYHRSgxgVioyeMpay23Cc60+BpR1acwMpI5OctU=; b=AWuOGlL9kL56Gq6lkHPcrvhyoL
	RXVNSn59DYNBL53qQ97TIsraSKbMye2Al/jaxOsrYk2+8cIobYgiBwteakoYdyBT9i7PmV3JKJMm9
	VetU/luxCYeNNuFSDE6JgDIPrPSDijAXC1BSDyWzL7WFcdEHGWdNRb/HiPygkvUEEZ4w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrHR-00000000744-0FD1;
	Fri, 30 Oct 2026 18:24:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrH6-0000000073m-2nl7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jCL2MJI2idKw6LPf5TVoJ3kKgFzjD5zEdScA1dc8zHw=; b=A1YXkSoeop6H8M5+LC9F+CitzI
 mGy4eVG80tRHDNgXyuW6GR+/i6WipFQXptHWBikmwH5EG1m5TulCcStYzXQYOIlYOcW/3OIpd7c2Q
 AN29nH0AIr8kvsa1owlQlk+h/TO92G+796UDIB00M5TKS9c+kYfiNHy2iZlM43LwuK5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jCL2MJI2idKw6LPf5TVoJ3kKgFzjD5zEdScA1dc8zHw=; b=FrLoK0PMLzU3qU6NP5Zln68rY8
 0G3h84SCmMMiWBvmQXXdGsRslvaGjkt/Z+Wi4mbvFmLIL3o4hXsmxiEZKf2vBjAGwD+uXQU7ousPc
 /QAMmL3AXOhcO2q8v84BKT+q9YpleF2D5txV2+aykFxFFvLyTAxFCyBa67+wkqv6HJvA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrH3-000000000wa-2VuE for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:24:23 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso10876995e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793384655; x=1793989455; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jCL2MJI2idKw6LPf5TVoJ3kKgFzjD5zEdScA1dc8zHw=;
 b=Eg368KyIvuB/O4pXBW2AtOOdCKLaS8J8XDAaS09wONWWI3xBbPMFY2x33gNm/qk23C
 iJJh+UiBteBay1dqL83uv/x5wKTTat0ijGyvF0vWKc8CU9OQiyF1NeqXy3IhLuT3h1U1
 nb5cg+SpehfbdrAQzIu7pS4/4EqRrs3hiGoYDlGJcygDbsZILY84UgjB2UHMDZ3eOf5M
 ke+omfRm+48Kh/JHJuApckSXFcDXI27mqz+KfRayA17Fl0KL8fN9B7JGMteTtMSsx4QM
 hQPA+0imqN/GbFrOhSBLKtllg16uSI7fMOlBGqBi6wQ3qXD98YozuogVS+LNCC8p2Dtl
 9GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384655; x=1793989455;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jCL2MJI2idKw6LPf5TVoJ3kKgFzjD5zEdScA1dc8zHw=;
 b=Jz7yFNy937ycsCho/mic0HjO/DKF+urcddC2xYlnG0RmcyaARaNTcTa8aIIFx4e7r4
 G+PUnSxABwLSjVvCin8wDnMlJN90fI2juqb+M+KLTmFa1PdNyz5RNoXnchv0sJQOxlHt
 b88r3+4QWcL/HBBTjspLMsCaniZAHRvRk9cCvIAPoPa3rp/QS46XeKihSY6M8/eqvq0H
 7Ehvxva3ehlR+P1w3dofPVr39gOXw551WscSn4yJ6eEqsopg1WAuE5HCWrnOV0uX9GTb
 chxMSaUwvVaqZkxN0XF9jtBURxEVnshao05QlFL1yLvBUdhdUi/2T39WvNF6IX68ef0E
 A/8g==
X-Gm-Message-State: AFq9FYKuWJtw+G5P7th0Chvc3NU6LhhBq5HVu7fOv8gD4TSsDInT1ZKn
 8+t+NYs64r87UdXOPkUId60HLbL6kZVZuBWT5LzV0tb+GGydAO1D8xbUX2jR0Cs8ug7HSM6TBBm
 Nb9WRYV73BZVKAZ7FO4r6vOZxeBoXTB3mmnhVq6CRlHrs7JZWJKiPWydCtZwH/Ye+tGoj
X-Gm-Gg: AYBFou2D2eKDfLBsMTeXBQu81gA/1T5Mk6CypKXOMV96+J6DFheaFVdCZLl/LXeLQu2
 zyp6k9AV3Noy+1b+5gGGDPzR8t2EzMduQ15T6DgL69csFkk8sQLG9CcAPNPbUouqTuFqsjyJrqj
 H4SZu+3CwNb4cQ9RwMu2iGA9RNk1YcUrZ9KFAmEWUKM10v6M3awDSm5EW+Kb9Pj2NFMcWseRwnG
 adNi9o8KBFHPECxMuaJOjIWSSASusi+v6JbwBG0ABTb7qklxOirQylOwcX/RN3wDcU2b7i09YjH
 dw2ZID3D3TH1CQQGmuYwOKxAXYpfuAPYUn+aKTfesQdRVMgRCsoRq9Rh1zlM/XsLL11mnNy2/LM
 Uv2Hs6k5w5Y9p4QcGspFoCs+XW3y6s3MTIdjgPc1U6UaxuVmeIT5F66bo1/IGASZGbpNTpC7Xyn
 d8ILcgXqIOtCek9wXGJP5BFi785Rrxrt/ldOuC2yJ+DH7cULOShAS/Yu3BT/0HdNxwcZ+yS6qWY
 Du2g3X9Bdo/Lqz5y1bM5duSEV+GAmWrDuAhG06mY9VjQpmuZXxIyguaw33IGUP/sIsThSDGuJKw
 RBs/87Lsd4Qu6yk02g/Xom4rP2cS1Jwk+EaZi7AP0PzNyu7QFz5t8avZszevqkAcJjqL1hVyp5d
 F05vHMZ8C0yWqLb4agLzmmb31F+gDEZBODNOtUUHN6ZumjwZE6TjwKFygH2tpJ3C8xXbPrSAawA
 jsbGGkCd7lTxRE64U=
X-Received: by 2002:a05:600c:4e8c:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4ac1793ff26mr70426415e9.15.1793384654775; 
 Fri, 30 Oct 2026 11:24:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm79906965e9.10.2026.10.30.11.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:24:14 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:24:12 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
X-Gerrit-Change-Number: 2043
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2043?usp=email>
X-Gerrit-Commit: 99701b0cc3facfc45581a0dac9a45a2899a59292
In-Reply-To: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
References: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhYzYyOTkwM2Y0OWFkOWUwZTFkMTg5MWFjZjM1ZTIwMDBmMzFmNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c694acee3fda1d65d87b829685973ca065e9987-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrH3-000000000wa-2VuE
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2771568905079376123=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2771568905079376123==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rmrzvERReAs="; charset=UTF-8

--rmrzvERReAs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2043?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: multi_io: move th=
e link write functions to multi_io=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: move the link write functions to multi_=
io=2Ec

Writing an instance's to_link was spread over three files: choosing=
 the
instance in multi_process_outgoing_link_pre() and the actual write in
=
multi_process_outgoing_link_dowork(), both static inline in multi=2Eh,
and =
the write-or-queue logic in mtcp=2Ec as
multi_tcp_process_outgoing_link() a=
nd
multi_tcp_process_outgoing_link_ready(), although they serve UDP
instanc=
es as well=2E

Move them to multi_io=2Ec next to their callers in multi_io_=
dispatch(),
as multi_io_write_link_pre(), multi_io_send_link(),
multi_io_wr=
ite_link() and multi_io_write_link_deferred()=2E
multi_io_send_link() stays=
 exported for the UDP write event handler in
mudp=2Ec=2E Drop the prototype=
 of multi_tcp_link_out_deferred(), which has
no definition=2E

No functiona=
l change=2E

Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
Signed-of=
f-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2043
Message-Id: <20261027124326=2E413-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40195=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M s=
rc/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
=
6 files changed, 107 insertions(+), 112 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/2043/2

diff --git a/src/=
openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 2b5c5b1=2E=2E2d0af06 100644
-=
-- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -126,69 +126,3 @@
 =
                   &mi->tcp_rwflags);
     }
 }
-
-bool
-multi_tcp_process_=
outgoing_link_ready(struct multi_context *m, struct multi_instance *mi,
-  =
                                    const unsigned int mpp_flags)
-{
-    s=
truct mbuf_item item;
-    bool ret =3D true;
-    ASSERT(mi);
-
-    /* ex=
tract from queue */
-    if (mbuf_extract_item(mi->tcp_link_out_deferred, &=
item)) /* ciphertext IP packet */
-    {
-        dmsg(D_MULTI_TCP, "MULTI =
TCP: transmitting previously deferred packet");
-
-        ASSERT(mi =3D=3D=
 item=2Einstance);
-        mi->context=2Ec2=2Eto_link =3D item=2Ebuffer->b=
uf;
-        ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);
=
-        mbuf_free_buf(item=2Ebuffer);
-    }
-    return ret;
-}
-
-bool
-=
multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const =
unsigned int mpp_flags)
-{
-    struct multi_instance *mi =3D multi_process=
_outgoing_link_pre(m);
-    bool ret =3D true;
-
-    if (mi)
-    {
-     =
   if ((defer && !proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=
=2Eproto))
-            || mbuf_defined(mi->tcp_link_out_deferred))
-      =
  {
-            /* save to queue */
-            struct buffer *buf =3D &m=
i->context=2Ec2=2Eto_link;
-            if (BLEN(buf) > 0)
-            {
-=
                struct mbuf_buffer *mb =3D mbuf_alloc_buf(buf);
-          =
      struct mbuf_item item;
-
-                set_prefix(mi);
-          =
      dmsg(D_MULTI_TCP, "MULTI TCP: queuing deferred packet");
-           =
     item=2Ebuffer =3D mb;
-                item=2Einstance =3D mi;
-      =
          mbuf_add_item(mi->tcp_link_out_deferred, &item);
-               =
 mbuf_free_buf(mb);
-                buf_reset(buf);
-                ret =
=3D multi_process_post(m, mi, mpp_flags);
-                if (!ret)
-     =
           {
-                    mi =3D NULL;
-                }
-        =
        clear_prefix();
-            }
-        }
-        else
-        {
=
-            ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);
=
-            if (!ret)
-            {
-                mi =3D NULL;
-      =
      }
-        }
-    }
-    return ret;
-}
diff --git a/src/openvpn/mtcp=
=2Eh b/src/openvpn/mtcp=2Eh
index de9d7ba=2E=2E47c6308 100644
--- a/src/ope=
nvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -41,16 +41,8 @@
 
 void multi_t=
cp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);=

 
-bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defe=
r,
-                                     const unsigned int mpp_flags);
-
-=
bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct =
multi_instance *mi,
-                                           const unsig=
ned int mpp_flags);
-
 struct multi_instance *multi_create_instance_tcp(str=
uct multi_context *m, struct link_socket *sock);
 
-void multi_tcp_link_out=
_deferred(struct multi_context *m, struct multi_instance *mi);
-
 void mult=
i_tcp_delete_event(struct multi_io *multi_io, event_t event);
 
 #endif /* =
ifndef MTCP_H */
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
i=
ndex 201d756=2E=2E217b299 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openv=
pn/mudp=2Ec
@@ -29,6 +29,7 @@
 #include "multi=2Eh"
 #include <inttypes=2Eh=
>
 #include "forward=2Eh"
+#include "multi_io=2Eh"
 
 #include "memdbg=2Eh"=

 #include "ssl_pkt=2Eh"
@@ -470,7 +471,7 @@
 {
     if (m->pending)
     {=

-        multi_process_outgoing_link_dowork(m, m->pending, mpp_flags);
+  =
      multi_io_send_link(m, m->pending, mpp_flags);
     }
 }
 
diff --git =
a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 2d4983c=2E=2E5aed191 =
100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -294,7 +2=
94,7 @@
  * may need updating and some follow-up action may be required=2E =
 This
  * function controls the necessary postprocessing=2E  It is called b=
y many
  * other functions that handle VPN tunnel related activity, such as=
 \c
- * multi_process_incoming_link(), \c multi_process_outgoing_link(), \c=

+ * multi_process_incoming_link(), \c multi_io_write_link(), \c
  * multi_=
process_incoming_tun(), \c multi_io_write_tun(), and \c
  * multi_process_t=
imeout(), among others=2E
  *
@@ -412,27 +412,6 @@
 #endif
 
 /*
- * Determ=
ine which instance has pending output
- * and prepare the output for sendin=
g in
- * the to_link buffer=2E
- */
-static inline struct multi_instance *
=
-multi_process_outgoing_link_pre(struct multi_context *m)
-{
-    struct mu=
lti_instance *mi =3D NULL;
-
-    if (m->pending)
-    {
-        mi =3D m-=
>pending;
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        mi =
=3D multi_get_queue(m->mbuf);
-    }
-    return mi;
-}
-
-/*
  * Per-clien=
t route quota management
  */
 
@@ -629,18 +608,6 @@
     (OPT_P_INSTANCE |=
 OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \
   =
   | OPT_P_COMP | OPT_P_SOCKFLAGS)
 
-static inline bool
-multi_process_out=
going_link_dowork(struct multi_context *m, struct multi_instance *mi,
-    =
                               const unsigned int mpp_flags)
-{
-    bool r=
et =3D true;
-    set_prefix(mi);
-    process_outgoing_link(&mi->context, =
mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_process_post(m, mi,=
 mpp_flags);
-    clear_prefix();
-    return ret;
-}
-
 /**
  * Determines=
 if the ifconfig_push_local address falls into the range of the local
  * I=
P addresses of the VPN interface (ifconfig_local with ifconfig_remote_netma=
sk)
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index =
164b214=2E=2Eac730b4 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvp=
n/multi_io=2Ec
@@ -346,6 +346,104 @@
     clear_prefix();
 }
 
+/*
+ * Dete=
rmine which instance has pending output
+ * and prepare the output for send=
ing in
+ * the to_link buffer=2E
+ */
+static struct multi_instance *
+mult=
i_io_write_link_pre(struct multi_context *m)
+{
+    struct multi_instance =
*mi =3D NULL;
+
+    if (m->pending)
+    {
+        mi =3D m->pending;
+  =
  }
+    else if (mbuf_defined(m->mbuf))
+    {
+        mi =3D multi_get_q=
ueue(m->mbuf);
+    }
+    return mi;
+}
+
+bool
+multi_io_send_link(struct=
 multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)=

+{
+    bool ret =3D true;
+    set_prefix(mi);
+    process_outgoing_link=
(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
+    ret =3D multi_proc=
ess_post(m, mi, mpp_flags);
+    clear_prefix();
+    return ret;
+}
+
+sta=
tic bool
+multi_io_write_link_deferred(struct multi_context *m, struct mult=
i_instance *mi,
+                             const unsigned int mpp_flags)=

+{
+    struct mbuf_item item;
+    bool ret =3D true;
+    ASSERT(mi);
+
=
+    /* extract from queue */
+    if (mbuf_extract_item(mi->tcp_link_out_d=
eferred, &item)) /* ciphertext IP packet */
+    {
+        dmsg(D_MULTI_TC=
P, "MULTI TCP: transmitting previously deferred packet");
+
+        ASSERT=
(mi =3D=3D item=2Einstance);
+        mi->context=2Ec2=2Eto_link =3D item=
=2Ebuffer->buf;
+        ret =3D multi_io_send_link(m, mi, mpp_flags);
+   =
     mbuf_free_buf(item=2Ebuffer);
+    }
+    return ret;
+}
+
+static boo=
l
+multi_io_write_link(struct multi_context *m, bool defer, const unsigned =
int mpp_flags)
+{
+    struct multi_instance *mi =3D multi_io_write_link_pr=
e(m);
+    bool ret =3D true;
+
+    if (mi)
+    {
+        if ((defer && =
!proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=2Eproto))
+       =
     || mbuf_defined(mi->tcp_link_out_deferred))
+        {
+            /*=
 save to queue */
+            struct buffer *buf =3D &mi->context=2Ec2=2Et=
o_link;
+            if (BLEN(buf) > 0)
+            {
+                str=
uct mbuf_buffer *mb =3D mbuf_alloc_buf(buf);
+                struct mbuf_i=
tem item;
+
+                set_prefix(mi);
+                dmsg(D_MULTI_=
TCP, "MULTI TCP: queuing deferred packet");
+                item=2Ebuffer =
=3D mb;
+                item=2Einstance =3D mi;
+                mbuf_add_=
item(mi->tcp_link_out_deferred, &item);
+                mbuf_free_buf(mb);=

+                buf_reset(buf);
+                ret =3D multi_process_po=
st(m, mi, mpp_flags);
+                if (!ret)
+                {
+      =
              mi =3D NULL;
+                }
+                clear_prefix=
();
+            }
+        }
+        else
+        {
+            ret =3D=
 multi_io_send_link(m, mi, mpp_flags);
+            if (!ret)
+            =
{
+                mi =3D NULL;
+            }
+        }
+    }
+    retur=
n ret;
+}
+
 static struct multi_instance *
 multi_io_dispatch(struct multi=
_context *m, struct multi_instance *mi, const int action)
 {
@@ -399,15 +49=
7,15 @@
 
         case TA_SOCKET_WRITE_READY:
             ASSERT(mi);
-  =
          multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);
+       =
     multi_io_write_link_deferred(m, mi, mpp_flags);
             break;
 
=
         case TA_SOCKET_WRITE:
-            multi_tcp_process_outgoing_link=
(m, false, mpp_flags);
+            multi_io_write_link(m, false, mpp_flags=
);
             break;
 
         case TA_SOCKET_WRITE_DEFERRED:
-         =
   multi_tcp_process_outgoing_link(m, true, mpp_flags);
+            multi_=
io_write_link(m, true, mpp_flags);
             break;
 
         case TA_I=
NITIAL:
diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
in=
dex 4299cba=2E=2Ec7f8f89 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/op=
envpn/multi_io=2Eh
@@ -72,4 +72,7 @@
 
 void multi_io_delete_event(struct m=
ulti_io *multi_io, event_t event);
 
+bool multi_io_send_link(struct multi_=
context *m, struct multi_instance *mi,
+                        const unsig=
ned int mpp_flags);
+
 #endif /* ifndef MULTI_IO_H */

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f3=
1f5de
Gerrit-Change-Number: 2043
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco=
 De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--rmrzvERReAs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2043?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi_io: move the link write functions to multi_io=2Ec<br><br>Writing=
 an instance&#39;s to_link was spread over three files: choosing the<br>ins=
tance in multi_process_outgoing_link_pre() and the actual write in<br>multi=
_process_outgoing_link_dowork(), both static inline in multi=2Eh,<br>and th=
e write-or-queue logic in mtcp=2Ec as<br>multi_tcp_process_outgoing_link() =
and<br>multi_tcp_process_outgoing_link_ready(), although they serve UDP<br>=
instances as well=2E<br><br>Move them to multi_io=2Ec next to their callers=
 in multi_io_dispatch(),<br>as multi_io_write_link_pre(), multi_io_send_lin=
k(),<br>multi_io_write_link() and multi_io_write_link_deferred()=2E<br>mult=
i_io_send_link() stays exported for the UDP write event handler in<br>mudp=
=2Ec=2E Drop the prototype of multi_tcp_link_out_deferred(), which has<br>n=
o definition=2E<br><br>No functional change=2E<br><br>Change-Id: Iac629903f=
49ad9e0e1d1891acf35e2000f31f5de<br>Signed-off-by: Gianmarco De Gregori &lt;=
gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/204=
3<br>Message-Id: &lt;20261027124326=2E413-1-gert@greenie=2Emuc=2Ede&gt;<br>=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg40195=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/=
openvpn/mudp=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2Ec<b=
r>M src/openvpn/multi_io=2Eh<br>6 files changed, 107 insertions(+), 112 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/43/2043/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtcp=
=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 2b5c5b1=2E=2E2d0af06 1006=
44</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mtcp=2Ec</span><br><span>@@ -126,69 +126,3 @@</span><br><span>        =
            &amp;mi-&gt;tcp_rwflags);</span><br><span>     }</span><br><spa=
n> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-multi_tcp_process_outgoing_link_ready(struct multi_cont=
ext *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                      const unsigned int mpp_f=
lags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct mbuf_item item;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* extract from queue */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (mbuf_extract_item(mi-&gt;tcp_link_out_defe=
rred, &amp;item)) /* ciphertext IP packet */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        dmsg(D_MULTI_TCP, &quot;MULTI TCP: transmitting previously d=
eferred packet&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(mi =
=3D=3D item=2Einstance);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        mi-&gt;context=2Ec2=2Eto_link =3D item=2Ebuffer-&gt;buf;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D multi_process=
_outgoing_link_dowork(m, mi, mpp_flags);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        mbuf_free_buf(item=2Ebuffer);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_tcp_process_outgoing_link(struct mult=
i_context *m, bool defer, const unsigned int mpp_flags)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct multi_instance *mi =3D multi_process_outgoing_link=
_pre(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (mi)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if ((defer &amp;&amp; !proto_is_dgram(mi-&gt;contex=
t=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            || mbuf_defined(mi-&gt;tcp_link_out_defer=
red))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* save to queue=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct=
 buffer *buf =3D &amp;mi-&gt;context=2Ec2=2Eto_link;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) &gt; 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                struct mbuf_buffer *mb =
=3D mbuf_alloc_buf(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                struct mbuf_item item;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                dmsg(D_MULTI_TCP, &quot;MULTI TCP: queuing deferre=
d packet&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           item=2Ebuffer =3D mb;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                item=2Einstance =3D mi;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                mbuf_add_item(mi-&gt;tcp_link_=
out_deferred, &amp;item);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                mbuf_free_buf(mb);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                buf_reset(buf);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                ret =3D multi_process_post(m, mi=
, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (!ret)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               clear_prefix();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D multi_proces=
s_outgoing_link_dowork(m, mi, mpp_flags);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (!ret)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                mi =3D NULL;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff =
--git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index d=
e9d7ba=2E=2E47c6308 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span=
><br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -41,16 +41,8 @@</s=
pan><br><span> </span><br><span> void multi_tcp_set_global_rw_flags(struct =
multi_context *m, struct multi_instance *mi);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_process_outgoing_l=
ink(struct multi_context *m, bool defer,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                     const unsigned int =
mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_process_outgoing=
_link_ready(struct multi_context *m, struct multi_instance *mi,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
          const unsigned int mpp_flags);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> struct multi_instance *multi_create_in=
stance_tcp(struct multi_context *m, struct link_socket *sock);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_l=
ink_out_deferred(struct multi_context *m, struct multi_instance *mi);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void mult=
i_tcp_delete_event(struct multi_io *multi_io, event_t event);</span><br><sp=
an> </span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff --git=
 a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 201d75=
6=2E=2E217b299 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br>=
<span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><b=
r><span> #include &quot;multi=2Eh&quot;</span><br><span> #include &lt;intty=
pes=2Eh&gt;</span><br><span> #include &quot;forward=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi_io=2Eh&quot;=
</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><=
br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span>@@ -470,7 +471,7=
 @@</span><br><span> {</span><br><span>     if (m-&gt;pending)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mul=
ti_process_outgoing_link_dowork(m, m-&gt;pending, mpp_flags);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi_io_send_link(m, m-&=
gt;pending, mpp_flags);</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/m=
ulti=2Eh</span><br><span>index 2d4983c=2E=2E5aed191 100644</span><br><span>=
--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</sp=
an><br><span>@@ -294,7 +294,7 @@</span><br><span>  * may need updating and =
some follow-up action may be required=2E  This</span><br><span>  * function=
 controls the necessary postprocessing=2E  It is called by many</span><br><=
span>  * other functions that handle VPN tunnel related activity, such as \=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * multi_process_inc=
oming_link(), \c multi_process_outgoing_link(), \c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * multi_process_incoming_link(), \c multi_i=
o_write_link(), \c</span><br><span>  * multi_process_incoming_tun(), \c mul=
ti_io_write_tun(), and \c</span><br><span>  * multi_process_timeout(), amon=
g others=2E</span><br><span>  *</span><br><span>@@ -412,27 +412,6 @@</span>=
<br><span> #endif</span><br><span> </span><br><span> /*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Determine which instance has pending o=
utput</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * and prepare t=
he output for sending in</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * the to_link buffer=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-multi_process_outgoing_link_pre(struct multi_context *m)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct multi_instance *mi =3D NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  mi =3D multi_get_queue(m-&gt;mbuf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span>  * Per-client route quota ma=
nagement</span><br><span>  */</span><br><span> </span><br><span>@@ -629,18 =
+608,6 @@</span><br><span>     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH=
 | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \</span><br><span>      | OPT_P_=
COMP | OPT_P_SOCKFLAGS)</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_process_outgoing_link_dowork(struct multi_context *m=
, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                   const unsigned int mpp_flags)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    set_prefix(mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_link(&amp;mi-&gt;conte=
xt, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ret =3D multi_process_post(m, mi, mpp_flags);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    clear_prefix();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Determines =
if the ifconfig_push_local address falls into the range of the local</span>=
<br><span>  * IP addresses of the VPN interface (ifconfig_local with ifconf=
ig_remote_netmask)</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/=
src/openvpn/multi_io=2Ec</span><br><span>index 164b214=2E=2Eac730b4 100644<=
/span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/op=
envpn/multi_io=2Ec</span><br><span>@@ -346,6 +346,104 @@</span><br><span>  =
   clear_prefix();</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Determine which instance has pending output</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * and prepare the output for=
 sending in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the t=
o_link buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi=
_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io=
_write_link_pre(struct multi_context *m)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct multi_instance *mi =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  mi =3D multi_get_queue(m-&gt;mbuf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_io_send_link(struct multi_context *m, struct mu=
lti_instance *mi, const unsigned int mpp_flags)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool ret =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    set_prefix(mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    process_outgoing_link(&amp;mi-&gt;context, mi-&gt;context=
=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    clear_prefix();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_wr=
ite_link_deferred(struct multi_context *m, struct multi_instance *mi,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
    const unsigned int mpp_flags)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct mbuf_item item;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extract fr=
om queue */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
mbuf_extract_item(mi-&gt;tcp_link_out_deferred, &amp;item)) /* ciphertext I=
P packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_MULTI_T=
CP, &quot;MULTI TCP: transmitting previously deferred packet&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(mi =3D=3D item=2Einstance);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=
=2Ec2=2Eto_link =3D item=2Ebuffer-&gt;buf;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ret =3D multi_io_send_link(m, mi, mpp_flags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbuf_free_=
buf(item=2Ebuffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+multi_io_write_link(struct multi_context *m, bool defer, const =
unsigned int mpp_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mul=
ti_instance *mi =3D multi_io_write_link_pre(m);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 ((defer &amp;&amp; !proto_is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&=
gt;info=2Eproto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          || mbuf_defined(mi-&gt;tcp_link_out_deferred))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* save to queue */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            struct buffer *buf =3D &=
amp;mi-&gt;context=2Ec2=2Eto_link;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (BLEN(buf) &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                struct mbuf_buffer *mb =3D mbuf_allo=
c_buf(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        struct mbuf_item item;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        set_prefix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                dmsg(D_MULTI_TCP, &quot;MULTI TCP: queuing deferred pac=
ket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        item=2Ebuffer =3D mb;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                item=2Einstance =3D mi;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                mbuf_add_item(mi-&gt;tcp_link=
_out_deferred, &amp;item);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                mbuf_free_buf(mb);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                buf_reset(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ret =3D multi_process_pos=
t(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                if (!ret)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    mi =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                clear_prefix();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ret =3D multi_io_send_link(m, mi, mpp_flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!ret)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                mi =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static struct multi_instance *</span><br><span> multi_io_dispatch(str=
uct multi_context *m, struct multi_instance *mi, const int action)</span><b=
r><span> {</span><br><span>@@ -399,15 +497,15 @@</span><br><span> </span><b=
r><span>         case TA_SOCKET_WRITE_READY:</span><br><span>             A=
SSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi_io_write_link_defer=
red(m, mi, mpp_flags);</span><br><span>             break;</span><br><span>=
 </span><br><span>         case TA_SOCKET_WRITE:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            multi_tcp_process_outgoing_link(m, f=
alse, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          multi_io_write_link(m, false, mpp_flags);</span><br><span>       =
      break;</span><br><span> </span><br><span>         case TA_SOCKET_WRIT=
E_DEFERRED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  multi_tcp_process_outgoing_link(m, true, mpp_flags);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            multi_io_write_link(m, true,=
 mpp_flags);</span><br><span>             break;</span><br><span> </span><b=
r><span>         case TA_INITIAL:</span><br><span>diff --git a/src/openvpn/=
multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index 4299cba=2E=2E=
c7f8f89 100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br><sp=
an>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -72,4 +72,7 @@</span><=
br><span> </span><br><span> void multi_io_delete_event(struct multi_io *mul=
ti_io, event_t event);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool multi_io_send_link(struct multi_context *m, struc=
t multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        const unsigned int mpp_flags);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef MUL=
TI_IO_H */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2043?usp=3Demail">change 2043</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac629903f49ad9e0e=
1d1891acf35e2000f31f5de </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2043 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarc=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--rmrzvERReAs=--


--===============2771568905079376123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2771568905079376123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2771568905079376123==--


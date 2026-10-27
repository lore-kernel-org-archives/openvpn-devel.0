Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23971606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W9RBQxIc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RtWT+0oL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QYNScRek;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WynJ/jnB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=iL0z6mjXjJI2UGA9H8sFd7MqAnWxjhj83HvkjQ0dOEw=; b=W9RBQxIcZYaxC2+1raYgSnob4p
	788fSqxuIRuuVhodknO526O7i0dG4kCmjExt18cZ5t303flahfZ5OVaQv21+JN/alY5DhZH5vIvzk
	V4uYftcFwo6H+ZtAKO1yuWw/6VEYiQI1DJRxR99JP80e2Jw2sp7dYuRCwnzO3we+x400=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdld-000000006XH-2lNx;
	Tue, 27 Oct 2026 09:46:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlc-000000006X9-30OC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M3OH79v3emRZg5f8newyhGNr3o4Zl2BetGIYc8RJWa4=; b=RtWT+0oLriGdmtlaAIx4U8Prav
 ltwPI9ZXoKJCdr0vQ48qAsz0b92RGd+hhJpt3HrFQJbgzhETsGXJ1Y3CQFXFI0U5LOpFeJ1D/WasN
 UyFRd5gFbKYYbnuyR+5QyHno1gPN7BLHC8pH1e6L/h5h2qRaejSawyWCquTgtzKrHjnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M3OH79v3emRZg5f8newyhGNr3o4Zl2BetGIYc8RJWa4=; b=QYNScRekUfReoZV0SbANb7tnNv
 x0C6/Bb69u43Hn1T2Ws51hGvY2/t1GDNnZFTxTJlJKkd2B9X4e+7o8Ci6kpeu9RVcU8rRMM8fA97z
 7ztEnJSeK+izH0qs23AcNC7ixGKb2XMgyXGnWxUtYA//yDnzFcvGXcoYo8fjl0LPu9wI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlZ-000000001Dl-1TLm for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:52 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so25404755e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094403; x=1793699203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M3OH79v3emRZg5f8newyhGNr3o4Zl2BetGIYc8RJWa4=;
 b=WynJ/jnBXokhcfT/3R49RcSxxB3YwIGacaRXpFmmPRAsI9I9fDfYV4Bhdpns1skxTU
 oEqSBwjMDgn5T9SKG/25T4ZNGoK/E6bYY50ewvmZ8TxBWISYX5VIXDy9NJgvP6GDox4j
 7L9DDp4KdaRL/AuwVpQ9TXwxp/QWnqWRF6+WyS4KVEuPZVxwX0z7JYyoDx1kaIu1bdxj
 zxvQjRehNObIHyYx80sZJCGYFVtPxL4TA57ZNEEumVizshTC6bX9vIV4AmCEUU4qX1yF
 Yb9XSgMDcZX3pblCz+hyGYEsCgVxdeYdLa+Mtoc5eq708+tpl05pPLzhVzyg1i4BgBgK
 XbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094403; x=1793699203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M3OH79v3emRZg5f8newyhGNr3o4Zl2BetGIYc8RJWa4=;
 b=N8ShJRNLP88Fb96n7Dnmj683XTGn9NOhd/ZFcdNDuh+kYSX0WrHYhglsghoklhECO5
 21Wp+vE2cNVfRZqtL6SSZM5JBByqfNSGWab+dfWaj5F+l6RR5kPr41jbYwiF/F21Q2y7
 GWup54eS9gL1nirDa0hlz7liPDFAsmMY4tR8pzXMVZGvovjOZk9B5hrVkKOOXNIlNnoB
 ouB0C9CdC/zquoSxKd+1/KcGhgkVtswhsptqE5ntqPWK8dmuRK7Kn9V0MA8xBiAE96nu
 VVkGlgT2GSjAimeHSDd8stk4vuSlzP+S3Sv85hvgNFHTY6WF4zlY5S6dCrR9l30Pakz4
 pQ8w==
X-Gm-Message-State: AFq9FYL+7JjwF4pz+j3zW4GDA+JlLy3oZ09NxKA9p7Zjt9HsXyKAUPeV
 /lrjHRUw4G1boBRVedYpZOkph/6Ig2wYIScAddDiE1/9fgOMIqGK1J7tGA9fUJM0kRos6xhssjM
 D5wethBSlvffK4RQPXOj6McsGfTtt/mQ10Z+ASIfUB7hX9Et9ToivsIPzhOUZCBz8HDBA8WDz6+
 e322NYEw==
X-Gm-Gg: AYBFou2aey2UC1MvNgQwElhLGj1VbOSdwDkLlCLewQi8LYv1qoDH55FynxUvb46+oIz
 KZnNeIJGxZGX3j7Mr8Ase0h6SEPPP3fJLgGywbN2v5E1VWlMq5+EwIO3ZnShWJ978WIaRe2CDKv
 /NP/Q9ev7bTFiSk0A23m5Om7H8j7SqHHBcPtUNPZhppj7mRt8YrH2Vr+mQ/OTe0B4uo0sET8rSW
 womkC6DKgQxYpT0VUI3pJSehwnvY0gq5LBhhPfzEti/FDdBhDy0Jbl98ZGjqV4JWYzGmtkdY5ra
 cVIk4HVdPA/X4snH6FTDzFtR+oR/jbRhGEYZwXhCYdIp9Fg2Koc5QoctE0Akq1eSoPJKpCSok4o
 TWcRcbDRQB4XCNcN8SWXozskt7TrZpH2otl2Kv+LEqj1IZYiclo0HaOQBWH+cgM5uYaUu3CGBBs
 i144OOg/4sE1P6LVAIFQd2J/dtewRkKCc/RbZF8JhRiVwYvE4RuBIwrccC6dGHmnimgehLqgxL/
 P6FkoLbWh0p7DHKiZMa5sFfCNDwNPPuMmNnr22csb+UkKIjcBOT5HgXK1+GSxqCh+uzSPhH1lnb
 wRjKegdPpe4r6RX1ckulVl2h6K072qUi0yD40gxONfLvgbcnQqUBeiBKsSeR3p9QdLu0MvLwmcG
 Or2OB831gnJJlYcla50+l2yNGD6JDWCruR1D2xHsya95Ve+n3xMh9B5bhO1p2TcE=
X-Received: by 2002:a05:600c:3b2a:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a35aca4e4emr171086815e9.13.1793094402592; 
 Tue, 27 Oct 2026 02:46:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm663805765e9.1.2026.10.27.02.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:46:41 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:46:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
X-Gerrit-Change-Number: 2042
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2042?usp=email>
X-Gerrit-Commit: 4d2c93730319150472232bc261bff896f4e3b340
References: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk4OTMwMzk3NWRkNTU5ZDdjYzA2NDg0YTk5ZjE1YzcwNjJkM2EzNDM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <658bcb84ac10c1898e9155ff0338df346f2d74b2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlZ-000000001Dl-1TLm
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: move the
 tun write functions to multi_io.c
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
Content-Type: multipart/mixed; boundary="===============0729753214884157174=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0729753214884157174==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p4xgsVXQMWs="; charset=UTF-8

--p4xgsVXQMWs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2042?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: move the tun write functions to multi_io=2Ec
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: mov=
e the tun write functions to multi_io=2Ec

multi_process_outgoing_tun() liv=
ed as a static inline in multi=2Eh and
multi_process_drop_outgoing_tun() in=
 multi=2Ec, while their only caller
is multi_io_dispatch()=2E Move both nex=
t to it, as static functions named
multi_io_write_tun() and multi_io_drop_t=
un(), so that writing to the
tun device is found where the state machine de=
cides to do it=2E

No functional change=2E

Change-Id: I89303975dd559d7cc06=
484a99f15c7062d3a3437
Signed-off-by: Gianmarco De Gregori <gianmarco@mandel=
bit=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvp=
n/multi_io=2Ec
3 files changed, 59 insertions(+), 61 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2042/1

dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2E=
2e804ff 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -=
3766,27 +3766,6 @@
 }
 
 /*
- * Drop a TUN/TAP outgoing packet=2E=2E
- */
-=
void
-multi_process_drop_outgoing_tun(struct multi_context *m, const unsign=
ed int mpp_flags)
-{
-    struct multi_instance *mi =3D m->pending;
-
-    =
ASSERT(mi);
-
-    set_prefix(mi);
-
-    msg(D_MULTI_ERRORS, "MULTI: Outgo=
ing TUN queue full, dropped packet len=3D%d",
-        mi->context=2Ec2=2Et=
o_tun=2Elen);
-
-    buf_reset(&mi->context=2Ec2=2Eto_tun);
-
-    multi_pr=
ocess_post(m, mi, mpp_flags);
-    clear_prefix();
-}
-
-/*
  * Per-client =
route quota management
  */
 
diff --git a/src/openvpn/multi=2Eh b/src/open=
vpn/multi=2Eh
index 5db7147=2E=2E2d4983c 100644
--- a/src/openvpn/multi=2Eh=

+++ b/src/openvpn/multi=2Eh
@@ -295,7 +295,7 @@
  * function controls the =
necessary postprocessing=2E  It is called by many
  * other functions that =
handle VPN tunnel related activity, such as \c
  * multi_process_incoming_l=
ink(), \c multi_process_outgoing_link(), \c
- * multi_process_incoming_tun(=
), \c multi_process_outgoing_tun(), and \c
+ * multi_process_incoming_tun()=
, \c multi_io_write_tun(), and \c
  * multi_process_timeout(), among others=
=2E
  *
  * @param m            - The single \c multi_context structure=2E
=
@@ -364,8 +364,6 @@
 bool multi_process_incoming_tun(struct multi_context *=
m, const unsigned int mpp_flags);
 
 
-void multi_process_drop_outgoing_tun=
(struct multi_context *m, const unsigned int mpp_flags);
-
 struct multi_in=
stance *multi_get_queue(struct mbuf_set *ms);
 
 void multi_ifconfig_pool_p=
ersist(struct multi_context *m, bool force);
@@ -627,41 +625,6 @@
 }
 
 
-/=
**
- * Send a packet over the virtual tun/tap network interface to its loca=
lly
- * reachable destination=2E
- * @ingroup internal_multiplexer
- *
- * =
This function calls \c process_outgoing_tun() to perform the actual
- * sen=
ding of the packet=2E  Afterwards, it calls \c multi_process_post() to
- * =
perform server-mode postprocessing=2E
- *
- * @param m            - The sin=
gle \c multi_context structure=2E
- * @param mpp_flags    - Fast I/O optimi=
zation flags=2E
- *
- * @return
- *  - True, if the \c multi_instance assoc=
iated with the packet sent was
- *    not closed due to a signal during pro=
cessing=2E
- *  - Falls, if the \c multi_instance was closed=2E
- */
-stati=
c inline bool
-multi_process_outgoing_tun(struct multi_context *m, const un=
signed int mpp_flags)
-{
-    struct multi_instance *mi =3D m->pending;
-  =
  bool ret =3D true;
-
-    ASSERT(mi);
-#ifdef MULTI_DEBUG_EVENT_LOOP
-   =
 printf("%s -> TUN len=3D%d\n", id(mi), mi->context=2Ec2=2Eto_tun=2Elen);
-=
#endif
-    set_prefix(mi);
-    vlan_process_outgoing_tun(m, mi);
-    pro=
cess_outgoing_tun(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
-    r=
et =3D multi_process_post(m, mi, mpp_flags);
-    clear_prefix();
-    retu=
rn ret;
-}
-
 #define CLIENT_CONNECT_OPT_MASK                              =
                              \
     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_=
P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \
      | OPT_P_COMP | OPT=
_P_SOCKFLAGS)
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=
=2Ec
index ebee86c=2E=2E164b214 100644
--- a/src/openvpn/multi_io=2Ec
+++ b=
/src/openvpn/multi_io=2Ec
@@ -290,6 +290,62 @@
     }
 }
 
+/**
+ * Send a =
packet over the virtual tun/tap network interface to its locally
+ * reacha=
ble destination=2E
+ * @ingroup internal_multiplexer
+ *
+ * This function =
calls \c process_outgoing_tun() to perform the actual
+ * sending of the pa=
cket=2E  Afterwards, it calls \c multi_process_post() to
+ * perform server=
-mode postprocessing=2E
+ *
+ * @param m            - The single \c multi_c=
ontext structure=2E
+ * @param mpp_flags    - Fast I/O optimization flags=
=2E
+ *
+ * @return
+ *  - True, if the \c multi_instance associated with t=
he packet sent was
+ *    not closed due to a signal during processing=2E
+=
 *  - Falls, if the \c multi_instance was closed=2E
+ */
+static bool
+mult=
i_io_write_tun(struct multi_context *m, const unsigned int mpp_flags)
+{
+ =
   struct multi_instance *mi =3D m->pending;
+    bool ret =3D true;
+
+   =
 ASSERT(mi);
+#ifdef MULTI_DEBUG_EVENT_LOOP
+    printf("%s -> TUN len=3D%d=
\n", id(mi), mi->context=2Ec2=2Eto_tun=2Elen);
+#endif
+    set_prefix(mi);=

+    vlan_process_outgoing_tun(m, mi);
+    process_outgoing_tun(&mi->cont=
ext, mi->context=2Ec2=2Elink_sockets[0]);
+    ret =3D multi_process_post(m=
, mi, mpp_flags);
+    clear_prefix();
+    return ret;
+}
+
+/*
+ * Drop a=
 TUN/TAP outgoing packet=2E=2E
+ */
+static void
+multi_io_drop_tun(struct =
multi_context *m, const unsigned int mpp_flags)
+{
+    struct multi_instan=
ce *mi =3D m->pending;
+
+    ASSERT(mi);
+
+    set_prefix(mi);
+
+    msg=
(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, dropped packet len=3D%d",=

+        mi->context=2Ec2=2Eto_tun=2Elen);
+
+    buf_reset(&mi->context=
=2Ec2=2Eto_tun);
+
+    multi_process_post(m, mi, mpp_flags);
+    clear_pr=
efix();
+}
+
 static struct multi_instance *
 multi_io_dispatch(struct mult=
i_context *m, struct multi_instance *mi, const int action)
 {
@@ -334,11 +3=
90,11 @@
             break;
 
         case TA_TUN_WRITE:
-            mul=
ti_process_outgoing_tun(m, mpp_flags);
+            multi_io_write_tun(m, m=
pp_flags);
             break;
 
         case TA_TUN_WRITE_TIMEOUT:
-     =
       multi_process_drop_outgoing_tun(m, mpp_flags);
+            multi_io=
_drop_tun(m, mpp_flags);
             break;
 
         case TA_SOCKET_WRIT=
E_READY:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/204=
2?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8930397=
5dd559d7cc06484a99f15c7062d3a3437
Gerrit-Change-Number: 2042
Gerrit-PatchSe=
t: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>

--p4xgsVXQMWs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: move the tun write functions to multi_io=2Ec<=
br><br>multi_process_outgoing_tun() lived as a static inline in multi=2Eh a=
nd<br>multi_process_drop_outgoing_tun() in multi=2Ec, while their only call=
er<br>is multi_io_dispatch()=2E Move both next to it, as static functions n=
amed<br>multi_io_write_tun() and multi_io_drop_tun(), so that writing to th=
e<br>tun device is found where the state machine decides to do it=2E<br><br=
>No functional change=2E<br><br>Change-Id: I89303975dd559d7cc06484a99f15c70=
62d3a3437<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2E=
com&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M s=
rc/openvpn/multi_io=2Ec<br>3 files changed, 59 insertions(+), 61 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/42/2042/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/=
src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2E2e804ff 100644</sp=
an><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/=
multi=2Ec</span><br><span>@@ -3766,27 +3766,6 @@</span><br><span> }</span><=
br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Drop a TUN/TAP outgoing packet=2E=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_pr=
ocess_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_fla=
gs)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-&g=
t;pending;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    set_prefix(mi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_MULTI_ERRORS, &quot;MULTI: Outgoing TUN queue full, dropped packet len=
=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
i-&gt;context=2Ec2=2Eto_tun=2Elen);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
_reset(&amp;mi-&gt;context=2Ec2=2Eto_tun);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    clear_prefix();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * =
Per-client route quota management</span><br><span>  */</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</s=
pan><br><span>index 5db7147=2E=2E2d4983c 100644</span><br><span>--- a/src/o=
penvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><spa=
n>@@ -295,7 +295,7 @@</span><br><span>  * function controls the necessary p=
ostprocessing=2E  It is called by many</span><br><span>  * other functions =
that handle VPN tunnel related activity, such as \c</span><br><span>  * mul=
ti_process_incoming_link(), \c multi_process_outgoing_link(), \c</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * multi_process_incoming_tun(),=
 \c multi_process_outgoing_tun(), and \c</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * multi_process_incoming_tun(), \c multi_io_write_tun=
(), and \c</span><br><span>  * multi_process_timeout(), among others=2E</sp=
an><br><span>  *</span><br><span>  * @param m            - The single \c mu=
lti_context structure=2E</span><br><span>@@ -364,8 +364,6 @@</span><br><spa=
n> bool multi_process_incoming_tun(struct multi_context *m, const unsigned =
int mpp_flags);</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void multi_process_drop_outgoing_tun(struct=
 multi_context *m, const unsigned int mpp_flags);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> struct multi_instance *multi_=
get_queue(struct mbuf_set *ms);</span><br><span> </span><br><span> void mul=
ti_ifconfig_pool_persist(struct multi_context *m, bool force);</span><br><s=
pan>@@ -627,41 +625,6 @@</span><br><span> }</span><br><span> </span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Send a packet over the virtual t=
un/tap network interface to its locally</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * reachable destination=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @ingroup internal_multiplexer</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * This function calls \c process_outgoing_tun() to perform=
 the actual</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * sending=
 of the packet=2E  Afterwards, it calls \c multi_process_post() to</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * perform server-mode postpro=
cessing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param m            - The s=
ingle \c multi_context structure=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @param mpp_flags    - Fast I/O optimization flags=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  - True, if the \c multi_instance associated with the =
packet sent was</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    =
not closed due to a signal during processing=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  - Falls, if the \c multi_instance was closed=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-multi_process_outgoing_tun(struct multi=
_context *m, const unsigned int mpp_flags)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct multi_instance *mi =3D m-&gt;pending;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    printf(&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;co=
ntext=2Ec2=2Eto_tun=2Elen);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set_p=
refix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    vlan_pr=
ocess_outgoing_tun(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    process_outgoing_tun(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Eli=
nk_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
t =3D multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    clear_prefix();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> #define CLIENT_CONNECT_OPT_MASK                                =
                            \</span><br><span>     (OPT_P_INSTANCE | OPT_P_=
INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \</span><br>=
<span>      | OPT_P_COMP | OPT_P_SOCKFLAGS)</span><br><span>diff --git a/sr=
c/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index ebe=
e86c=2E=2E164b214 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</sp=
an><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -290,6 +290,=
62 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Send a packet over the virtual tun/tap net=
work interface to its locally</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * reachable destination=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @ingroup internal_multiplexer</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * This function calls \c process_outgoing_tun() to perform t=
he actual</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sending=
 of the packet=2E  Afterwards, it calls \c multi_process_post() to</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * perform server-mode postp=
rocessing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m            -=
 The single \c multi_context structure=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param mpp_flags    - Fast I/O optimization flags=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  - True, if the \c multi_instance asso=
ciated with the packet sent was</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *    not closed due to a signal during processing=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  - Falls, if the \c multi_=
instance was closed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_write_tun(st=
ruct multi_context *m, const unsigned int mpp_flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct multi_instance *mi =3D m-&gt;pending;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;%s -&gt; TUN len=3D%d\n=
&quot;, id(mi), mi-&gt;context=2Ec2=2Eto_tun=2Elen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    set_prefix(mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    vlan_process_outgoing_tun(m, mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_tun(&amp;mi-&gt=
;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ret =3D multi_process_post(m, mi, mpp_fla=
gs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clear_prefi=
x();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Drop a TUN/TAP outgoing packet=2E=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mu=
lti_io_drop_tun(struct multi_context *m, const unsigned int mpp_flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D m-&gt;p=
ending;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    set_prefix(mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_MULTI_ERRORS, &quot;MULTI: Outgoing TUN queue full, dropped pac=
ket len=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        mi-&gt;context=2Ec2=2Eto_tun=2Elen);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_reset(&amp;mi-&gt;context=2Ec2=2Eto_tun);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    multi_process_post(m, mi, mpp_flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    clear_prefix();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static struct multi_instance *</span=
><br><span> multi_io_dispatch(struct multi_context *m, struct multi_instanc=
e *mi, const int action)</span><br><span> {</span><br><span>@@ -334,11 +390=
,11 @@</span><br><span>             break;</span><br><span> </span><br><spa=
n>         case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            multi_process_outgoing_tun(m, mpp_flags);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            multi_io_write_tun(m,=
 mpp_flags);</span><br><span>             break;</span><br><span> </span><b=
r><span>         case TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            multi_process_drop_outgoing_tun(m, mpp_fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mu=
lti_io_drop_tun(m, mpp_flags);</span><br><span>             break;</span><b=
r><span> </span><br><span>         case TA_SOCKET_WRITE_READY:</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2042?usp=3Demail">change 2042</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2042?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2042 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--p4xgsVXQMWs=--


--===============0729753214884157174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0729753214884157174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0729753214884157174==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E21606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R7DxY/lj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nBlJxzi5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BapeNPZp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=J04XVm+7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Vlkw7kosMEyFp65K0PECOhfvzGUpoWalRyZ9z7DZ1XY=; b=R7DxY/ljh8veaL2/MtpCZm987u
	RfCkdNtS03n81ULs/q4+NNZvcflX65SFTPBSVir8qLxcBqiLufSJhnf0QcdqlIjAfmj4+8niLC0WQ
	xG3li/bsXa6AfrQqyPsBVbM9+HaaOFabs8PtM6ugg3Lqf/UE9s4mtspQngxmUsa/canQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYUL-000000003jf-2EPj;
	Thu, 12 Nov 2026 17:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYUI-000000003jL-1vRP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gtL4+DdynO1t3tBE4s2i7DGjcubIzpuLeE10VVKQ8aw=; b=nBlJxzi5nyEX8QpqODbOxzsTwB
 RA4zVS+U0tdWQf4dEf8xe+lMSGTDHRDFQ1jRPBOOzpUoKVRT98QkIS3B9Rh7iThYb+WCawdQzztrJ
 QtEqYC7yB/H8kFDv6Y55pDaJ0obQ/BO9qwQuXi74GcVC0WgR/qfGCQbNx0Ljw2n94fGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gtL4+DdynO1t3tBE4s2i7DGjcubIzpuLeE10VVKQ8aw=; b=BapeNPZpc0DdyDoDH4E03fO+o7
 IFeAlx58BpUdvBxLZDUPO2x6w+qYuZPTsmgio+qQdfNpc5Ibw6xjEb2UDljmJ4D6mgFxnlHmhgtGR
 Fe6zZTWdbfcuFpMSugat/Pbd9siIes1BT2v8pgh/nvH0jqLPG/AzEXu7qb1w2EVj+514=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYTw-000000003C6-3k8w for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:21:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso391215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794504058; x=1795108858; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gtL4+DdynO1t3tBE4s2i7DGjcubIzpuLeE10VVKQ8aw=;
 b=J04XVm+7Av1fEL5Oqka6+UiZWYU4BpAEiaT+OcbTRKM9HAYunpbu1QBFh5Fnq230ZC
 5FPSTjo72FkRxKoOM8Oj7lZQeKD8I278a9qAC326b2vye593RwP6ErUw8DfQMyKF6o85
 YeFbgl5RznAwu56Vq6PU+vXE4Kg6U++WTlDZEV3ROnRfKFPCoO43UZxl7M3xojz70b6Z
 O57NFALEDsxVEkzmQ4zVCsCpqY9A4c4HsS+hvx1j67+0U/CJsBUi0KXBbm1L1/N0SOyx
 nDOwyiYkXCEq+edazdRjPm3QDlzgbJ6JjfhDfDGmjEtq4oWUcygkywJSGXN6FqK8pmXb
 B9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794504058; x=1795108858;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gtL4+DdynO1t3tBE4s2i7DGjcubIzpuLeE10VVKQ8aw=;
 b=OGgExBfO9yRIWiNThLYmCN+SQBwYClIycnJ0AwdPr7zTyqIAJ670s6nXV3E+r8xIdy
 kaFkNqAAF7jt3rOw3R9TW4gUxssJL6rQKaG7schYmXgBlgVpeRL3GhiaRf3Jpu0m7Fvs
 Pudekz8WtklgbKwt/1EpnXbbPujhjOkySgr1CqgfTtq/+HtcCs9+x4wsRZ8bcv9WH5Sd
 dWyK0VeaKNlJx1/VyQyOSQuTNlUEw0YLzRcWkSWxm6UtWt7dsqz1+v0miAP4gjtfaDT7
 jgdx53nDvpv3DbvFmQKINlCcBrhWpJ8SLJHLBl+D43rwOBh0WYiICJ5y7/LLgkkSWgiK
 +eKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFzTj8Xji3NPOCdQ6TpwYLtB6A+j4B3+7aJ4UyJPe7rV1tlrzQbrSCY7GB+buW9jJ+bD9knr/WUOiGfEipn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8QHl2vSjOwU2pUWgjPtZdmez4rurhkVrrneh12jPlGTFHGftkE
 NlezADLobWMTjyyRLpCRT1O2KU06NyH577sLW7VlMYh0k/UY/LNOpbilRb8bf/PZbV+qa/lE1p5
 cnpJgUgfXdKW2iONIIXsnur/F015yRr0h1gakY8hz9BalcaC7hRhfT5NRMEE5wP7M3q4g
X-Gm-Gg: AYBFou2XEx9T6Ly9oNen+MtK5b+VkBR9fGLYOgMoxyi5796CDJvhO6NSWxY7UQ/bFAw
 GUWy/itoAOKQgIU2lqU0NQ+0HENK0x6PhrhZ9m/nu+dwD7gLE9Pg89R5rvp7sQ0JIBzd50i3h36
 wQK2D85YyGe7i7giWzY7aw99tZs0Pk4uxoSSzEUF5AChbrWaBgFClWL6dsFACDIho38JcQaYMwb
 nxfQLO1PcvV53Jx3aGl5+mOKLKfX8nX/t0IddpuGlS+lg7W4N5jJ7QDdsQ54PuaqR8ANTqP2t8A
 H1tt+GaoFgEhyQlHGhezKS1PI/077X0vsl6pp7KGwY+/eVs93LaANGyXYLFp7W4DknsstlUZN0F
 uUFZlRRsRVQrxxKLfxUutcy/t3ji15teCC8AXwXtuPHawvkDtLt5cFWeOuusT++Ul1fip41eNJn
 nwsLWwWYmnkOiTZ215+bSEAt8YEGQe1kKw51NumXsbASqKWPWDGqUvsOHTVYXX7F40ap62O2dIt
 dt0GFhWyc1Oaaq9X6kBxKJiE7kTiimxpGpKLtZQmYq1OOraIdpPqNYeBDIdOoRwq4GAXYHoMBdo
 9dZnTgxfIKSxq0Kr0eyzvV/llXE97cJYVKtlCJm2LfZb1nwl9I7WwBD28dWZ1DsDf0g94CqaGaL
 3kqbuRdloHKcHzatPxkuPedeR48R7q66aVpjNv6jywybzAV2WBMMgv4b3DIwvo0a9dSlHfyIW0r
 69dcsdH92FIZl5bMrFxX8CYe9h33E766XnpR5x
X-Received: by 2002:a05:600c:6387:b0:4a1:fb23:68f0 with SMTP id
 5b1f17b1804b1-4ba0931ec63mr115608555e9.3.1794504058092; 
 Thu, 12 Nov 2026 09:20:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e33ae5bsm76158995e9.3.2026.11.12.09.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:20:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:20:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4b241185d75f61be9137220e18742c1e6912820f
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03387350f3fba987f985def5cdd673a3688bf10c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYTw-000000003C6-3k8w
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1072325979870628245=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1072325979870628245==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DGw1xfoD3ZI="; charset=UTF-8

--DGw1xfoD3ZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2130?usp=3Demail )

Change subject: Adjust ACC_MAX_MSG_LEN, fix=
 ACC in p2p mode and improve documentation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode=
 and improve documentation

We do not need to limit the maximum ACC message=
 length to just 1280=2E Also
improve the comments and documentation to be c=
learer=2E

Fix that the management notification about negotiated protocol i=
s not sent
when in p2p mode (or if a server has push-peer-info in its confi=
guration)

Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Signed-off-=
by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130
Me=
ssage-Id: <20261108151523=2E26265-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40902=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/manage=
ment-notes=2Etxt
M src/openvpn/acc=2Ec
M src/openvpn/acc=2Eh
M tests/unit_t=
ests/openvpn/test_acc=2Ec
4 files changed, 40 insertions(+), 15 deletions(-=
)




diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
=
index 6c798c0=2E=2Ea98b45f 100644
--- a/doc/management-notes=2Etxt
+++ b/do=
c/management-notes=2Etxt
@@ -1398,11 +1398,17 @@
     next message should b=
e concatenated to this message to form a complete
     message=2E
 
-    No=
te that the OpenVPN implementation operates here with the robustness
-    p=
rinciple ("be conservative in what you send, be liberal in what you
-    ac=
cept" - RFC 793 and others) and allows receiving messages longer than
-    =
maximum allowed message length=2E Implementations should be prepared to
-  =
  handle messages that are longer than the maximum allowed message length=
=2E
+    Note that fragment is basically a flag for allowing peers communic=
ating
+    over ACC to indicate if multiple ACC messages should be consider=
ed to
+    be a single message=2E If the ACC protocol is a stream based pro=
tocol
+    then all messages can be sent without fragment flag=2E
+
+    No=
te that the OpenVPN implementation allows receiving messages longer than
+ =
   announced maximum allowed message length=2E Implementations must be prep=
ared
+    to handle messages that are longer than the maximum allowed messa=
ge length=2E
+    Overlong messages are considered invalid and indicate tha=
t the peer is
+    misbehaving=2E Disconnecting/dropping the peer is consid=
ered a valid
+    response to such messages=2E
 
     OpenVPN does not veri=
fy that the message is valid base64=2E A peer that
     sends invalid base6=
4 payload will be passed to the management interface=2E
diff --git a/src/op=
envpn/acc=2Ec b/src/openvpn/acc=2Ec
index 455f56d=2E=2Ee9656a6 100644
--- a=
/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -190,10 +190,10 @@
     }=

 
     /* We do not check the length here=2E We make no promises to suppor=
t
-     * anything larger than our announced message length but according t=
o
-     * the robustness principle
-     * ("be conservative in what you se=
nd, be liberal in what you accept" - RFC 793 and others)
-     * we accept =
also longer messages */
+     * anything larger than our announced message =
length but we accept also
+     * longer messages if they manage to get thr=
ough all the other layers
+     * that restrict the message size like TLS_C=
HANNEL_BUF_SIZE=2E
+     */
 
     int payload_len;
     const char *payloa=
d_len_str =3D buf_extract_field(&buf, ',', &gc);
@@ -426,8 +426,20 @@
     =
multi->acc_negotiated_protocols =3D string_alloc(buf_str(&common_protocols)=
, NULL);
     multi->acc_max_message_length =3D max_acc_len;
 
-    setenv_=
str(session->opt->es, "acc_protocols", multi->acc_negotiated_protocols);
- =
   setenv_int(session->opt->es, "acc_message_len", multi->acc_max_message_l=
ength);
+    /* The normal case is that this is a server where we notify th=
e client
+     * capabilities via environment variables */
+    if (multi->=
opt=2Emode =3D=3D MODE_SERVER)
+    {
+        setenv_str(session->opt->es,=
 "acc_protocols", multi->acc_negotiated_protocols);
+        setenv_int(ses=
sion->opt->es, "acc_message_len", multi->acc_max_message_length);
+    }
+ =
   else
+    {
+        /* We can also end up here in p2p or if the server =
has --push-peer-info
+         * We do not set variables in that case to ke=
ep behavior consistent with
+         * the other paths on the client that =
also do not set variables */
+        notify_client_acc_protocols(multi);
+=
    }
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/acc=2Eh b/src/openvp=
n/acc=2Eh
index 9c99b11=2E=2Ed640898 100644
--- a/src/openvpn/acc=2Eh
+++ b=
/src/openvpn/acc=2Eh
@@ -29,7 +29,9 @@
 #include "openvpn=2Eh"
 
 #define A=
CC_MIN_MSG_LEN 64
-#define ACC_MAX_MSG_LEN 1280
+/* This is a conservative =
limit=2E The theoretical maximum
+ * is much closer to the TLS_CHANNEL_BUF_=
SIZE */
+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
 
 /**
  * Th=
is method parses an app custom control message and delivers it to the
diff =
--git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/te=
st_acc=2Ec
index 9364d12=2E=2Ebc103b4 100644
--- a/tests/unit_tests/openvpn=
/test_acc=2Ec
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -181,7 +181,11=
 @@
     int max_len =3D 0;
     const char *protocols =3D parse_acc_parame=
ters(info_acc_msg, " ", &max_len, true, &gc);
     assert_string_equal(prot=
ocols, "flower:happy");
-    assert_int_equal(max_len, 1280);
+
+    /* Che=
ck that the ACC_MAX_MSG_LEN is 1920 to ensure that the tests get
+     * ad=
justed if it changes */
+    assert_int_equal(ACC_MAX_MSG_LEN, 1920);
+    =
assert_int_equal(max_len, ACC_MAX_MSG_LEN);
 
     /* a client does not acc=
ept a length longer than it supports */
     protocols =3D parse_acc_parame=
ters(info_acc_msg, " ", &max_len, false, &gc);
@@ -247,14 +251,15 @@
     m=
ulti->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
     multi->sessi=
on[TM_ACTIVE]=2Eopt =3D &multi->opt;
     multi->opt=2Ees =3D env_set_creat=
e(&c->options=2Egc);
+    multi->opt=2Emode =3D MODE_SERVER;
 
     determi=
ne_common_acc_protocols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
 
-=
    assert_int_equal(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    =
assert_int_equal(multi->acc_max_message_length, 1400);
     assert_string_e=
qual(multi->acc_negotiated_protocols, "power:flower");
 
     assert_string=
_equal(env_set_get(multi->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpowe=
r:flower");
-    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_mess=
age_len"), "acc_message_len=3D1280");
+    assert_string_equal(env_set_get(=
multi->opt=2Ees, "acc_message_len"), "acc_message_len=3D1400");
 
     free=
(multi->acc_negotiated_protocols);
     gc_free(&c->options=2Egc);

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c95076=
1977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 7
Gerrit-Owner: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--DGw1xfoD3ZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Adjust ACC_MAX_MSG_LEN, fix ACC in=
 p2p mode and improve documentation<br><br>We do not need to limit the maxi=
mum ACC message length to just 1280=2E Also<br>improve the comments and doc=
umentation to be clearer=2E<br><br>Fix that the management notification abo=
ut negotiated protocol is not sent<br>when in p2p mode (or if a server has =
push-peer-info in its configuration)<br><br>Change-Id: I3a268fc602e916bf548=
53c950761977cf3d7f835<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg=
&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130<br>Message-Id: &lt;2026=
1108151523=2E26265-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40902=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/=
management-notes=2Etxt<br>M src/openvpn/acc=2Ec<br>M src/openvpn/acc=2Eh<br=
>M tests/unit_tests/openvpn/test_acc=2Ec<br>4 files changed, 40 insertions(=
+), 15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etx=
t b/doc/management-notes=2Etxt</span><br><span>index 6c798c0=2E=2Ea98b45f 1=
00644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ =
b/doc/management-notes=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@</span>=
<br><span>     next message should be concatenated to this message to form =
a complete</span><br><span>     message=2E</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    Note that the OpenVPN implementa=
tion operates here with the robustness</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    principle (&quot;be conservative in what you send, be =
liberal in what you</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  accept&quot; - RFC 793 and others) and allows receiving messages longer t=
han</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    maximum allowe=
d message length=2E Implementations should be prepared to</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    handle messages that are longer tha=
n the maximum allowed message length=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    Note that fragment is basically a flag for allowing=
 peers communicating</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    over ACC to indicate if multiple ACC messages should be considered to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    be a single mess=
age=2E If the ACC protocol is a stream based protocol</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    then all messages can be sent without=
 fragment flag=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Note that the Ope=
nVPN implementation allows receiving messages longer than</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    announced maximum allowed message=
 length=2E Implementations must be prepared</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    to handle messages that are longer than the max=
imum allowed message length=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    Overlong messages are considered invalid and indicate that t=
he peer is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    misbe=
having=2E Disconnecting/dropping the peer is considered a valid</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    response to such messages=
=2E</span><br><span> </span><br><span>     OpenVPN does not verify that the=
 message is valid base64=2E A peer that</span><br><span>     sends invalid =
base64 payload will be passed to the management interface=2E</span><br><spa=
n>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>in=
dex 455f56d=2E=2Ee9656a6 100644</span><br><span>--- a/src/openvpn/acc=2Ec</=
span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,10=
 @@</span><br><span>     }</span><br><span> </span><br><span>     /* We do =
not check the length here=2E We make no promises to support</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * anything larger than our annou=
nced message length but according to</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * the robustness principle</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * (&quot;be conservative in what you send, be=
 liberal in what you accept&quot; - RFC 793 and others)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * we accept also longer messages */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * anything larg=
er than our announced message length but we accept also</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * longer messages if they manage t=
o get through all the other layers</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * that restrict the message size like TLS_CHANNEL_BUF_S=
IZE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span> </span><br><span>     int payload_len;</span><br><span>     con=
st char *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;=
gc);</span><br><span>@@ -426,8 +426,20 @@</span><br><span>     multi-&gt;ac=
c_negotiated_protocols =3D string_alloc(buf_str(&amp;common_protocols), NUL=
L);</span><br><span>     multi-&gt;acc_max_message_length =3D max_acc_len;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc=
_negotiated_protocols);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    setenv_int(session-&gt;opt-&gt;es, &quot;acc_message_len&quot;, multi=
-&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* The normal case is that this is a server where we notify t=
he client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cap=
abilities via environment variables */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (multi-&gt;opt=2Emode =3D=3D MODE_SERVER)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        setenv_str(session-&gt;opt-&gt;es=
, &quot;acc_protocols&quot;, multi-&gt;acc_negotiated_protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_int(session-&g=
t;opt-&gt;es, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_length=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* We can also end up here in p2p or if the ser=
ver has --push-peer-info</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * We do not set variables in that case to keep behavior consi=
stent with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* the other paths on the client that also do not set variables */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        notify_client_acc_pro=
tocols(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> =
}</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</s=
pan><br><span>index 9c99b11=2E=2Ed640898 100644</span><br><span>--- a/src/o=
penvpn/acc=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@=
 -29,7 +29,9 @@</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br=
><span> </span><br><span> #define ACC_MIN_MSG_LEN 64</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* This is a conservative limit=2E=
 The theoretical maximum</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * is much closer to the TLS_CHANNEL_BUF_SIZE */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_=
SIZE - 128)</span><br><span> </span><br><span> /**</span><br><span>  * This=
 method parses an app custom control message and delivers it to the</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_te=
sts/openvpn/test_acc=2Ec</span><br><span>index 9364d12=2E=2Ebc103b4 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -181,7 +181=
,11 @@</span><br><span>     int max_len =3D 0;</span><br><span>     const c=
har *protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;m=
ax_len, true, &amp;gc);</span><br><span>     assert_string_equal(protocols,=
 &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    assert_int_equal(max_len, 1280);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Check that the ACC_MAX_MSG_LEN is 1920 to ensure that the tests =
get</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * adjusted =
if it changes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(ACC_MAX_MSG_LEN, 1920);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(max_len, ACC_MAX_MSG_LEN);</span=
><br><span> </span><br><span>     /* a client does not accept a length long=
er than it supports */</span><br><span>     protocols =3D parse_acc_paramet=
ers(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><=
span>@@ -247,14 +251,15 @@</span><br><span>     multi-&gt;opt=2Eacc_protoco=
ls =3D c-&gt;options=2Eacc_protocols;</span><br><span>     multi-&gt;sessio=
n[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</span><br><span>     multi-&gt;o=
pt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Emode =3D MODE_SERVER;=
</span><br><span> </span><br><span>     determine_common_acc_protocols(mult=
i, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(mult=
i-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_message_=
length, 1400);</span><br><span>     assert_string_equal(multi-&gt;acc_negot=
iated_protocols, &quot;power:flower&quot;);</span><br><span> </span><br><sp=
an>     assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_proto=
cols&quot;), &quot;acc_protocols=3Dpower:flower&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(env_set_get(multi=
-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=3D1280&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &q=
uot;acc_message_len=3D1400&quot;);</span><br><span> </span><br><span>     f=
ree(multi-&gt;acc_negotiated_protocols);</span><br><span>     gc_free(&amp;=
c-&gt;options=2Egc);</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">change 2130</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a268fc602e916b=
f54853c950761977cf3d7f835 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2130 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--DGw1xfoD3ZI=--


--===============1072325979870628245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1072325979870628245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1072325979870628245==--


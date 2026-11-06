Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985A606A32C
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nGWzRl6P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iLuiFPu3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AedLhqg+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E663aWvn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FBlQpoMvW8lPZ4PO85gsY9s6n1xdYwHGM5RGOVf79Xc=; b=nGWzRl6PYkiExuB69IfX0wTh6u
	+deLo/1Jrk8fLjPsQG7rXsTQpJPbtpXeX3Hsqj0uNKXuaGt19E0YK5PR+qQW3CMuJ2YfEIg2DRseN
	1IJ7uz9AGEBi3m6shgnuUUn+xBXlprSPI9eNNcCbqH7Q3w8f09NsyKBwpfRQ6xUG5sic=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPJOQ-000000001FX-38oQ;
	Fri, 06 Nov 2026 12:50:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPJOP-000000001FR-43KT
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tc2HI27NGtAOR9srfMvTzavcQskBB6XvH5GzcMK4Ehs=; b=iLuiFPu37z81cxaGl+0Hmm0N6H
 xq1Dgb9KeQDHYmymVRwk0U3SBkSY6GqODGzVAOfDJLGNYrgK+Wzwranwp9Lq+DJrM9dUib2gEaGfM
 z8c75RJw1OWZ4o8D+dp25mtKYy9RYl+eMqB0xUNZTdtgodVVZ6ScP2ooip8hQuXx/qZk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tc2HI27NGtAOR9srfMvTzavcQskBB6XvH5GzcMK4Ehs=; b=AedLhqg+7sVu32Qx9QxT1HEdLZ
 WOl55maYvstDfw5MgIAUp7HQ2GRVMoGa19M6Kq/5jS+quDd9lLcmQ0oStHiPpoMQzp0gsTTAd7H5s
 56EdGAEQNhZGkvJNBgvc+BtvvtBddExqEsth1PyFObF5KAD1N1xC4cOGJj2T4svOWA/k=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPJON-000000005hY-3WyK for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:50:05 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so4315365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 04:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793969397; x=1794574197; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tc2HI27NGtAOR9srfMvTzavcQskBB6XvH5GzcMK4Ehs=;
 b=E663aWvn6JBZ3rNMfOgImx+jca+RAub9G5Us+3MHSBOHEn+JESldhpmXGWHXFG4SBY
 x+xZCaKcJy3et5k9cAi/03bh65d0xAFWZH5YPP1p2maRJ8aYY/MFK9Pr7TWKP7w+xn3H
 5O1qyXcwRwYoU2SizVEtWfohXrXounQcPWfGxvxXwEJhI/KsWGTDatOZBfiBEJ31n3ds
 7W8f2jl7gvmBFlhgB1O+ZKwSDmBB0gysBoHNmdFqvyqUto6I5EQz2chHAqh7jg8WlxCL
 5X/BhKx8DkuLSeGSXuQlQukNjXePBl95yokO1FaDbkIZvX7oVs2YUftpBlZ3a1nHqEYb
 70dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793969397; x=1794574197;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tc2HI27NGtAOR9srfMvTzavcQskBB6XvH5GzcMK4Ehs=;
 b=LR+9cXsjCMufMaJJ9aRpaAVHR4i9Xvg9gviH0dynHC5Hxp/DusDCRRqDqSrD6hJdpW
 xnUBpvYbH2PRJz9jt4y561nKWfp0FXSjd3UMiaXb32sKG06ixlKvlgZON+0VxEEl6aVZ
 CTPJlMhqULM6IrsWuk/LB1KD/SVhagjDq0sJvdNDud6tge/07F2pEWDw8VRzvO/+y6kd
 urYjaAc/GqG7MBlvWZ4+Yj65ReuGGHV8o482IVHXbJBl2F99dLexdYukziEyQ9+2YLaj
 csO2BMQs8PiG9uvtpJLxEenqfShVywLe2sFcIAzJWFV0U/0K/LYjqBQNI7j0yRnNadv3
 4RiQ==
X-Gm-Message-State: APuU4Z9rMWqdpRjx3ZM6f4iXkVJxAcbgNA2Wi6vWNleFMTfIF/J30BGU
 HQ/3+KeOAwIRaHBWdHLBVheoJbXJXlzNG4oOhXkRnnw6fHMHjqvhciETTS9b7nWdy7ByThOITI8
 9mQJGIQFUKHnv99ecx91joLXwo/OE2FEVHcI+e0qM4+us9K754ztk5Uv5ESChhvxUPzIU60O+90
 bDETrbrA==
X-Gm-Gg: AYBFou1Eey1I90XOiPnEycb7sM+Gl/KktplKB4cTYSQeLLEjuOg6Wp4zFv4UEh61ZXY
 LjzX5Hb6OEth1thxmi8z6JoTAU/8RAfdLESehF4pMfQZ2X8hVZbqXUdpGmm/rZl1Gqj+8WAIY4G
 qtUHPbsziC/vU2yT6I5cdZUfrBk0e7pcYOhaDyuXYdV1fMSVCbtUozjh/2/8EOrFRvO49Y1lEYm
 wspYKqrNYhaRZm7oHGJaXnIRKX4cqPZzT75LuybQ1NKyCxfJOO2XLNBitW+AFYTSJf0+jwXDeS1
 hKMaDyGCRHuD9h+myPPMQRTCv3TmZlu8tU8bKKNvOiwQVrtGeA/pVKR41EtMVFBbRYk4SptQ2y7
 rIr0bRCgo35wlzNXr4ySFLx/Xhrkowx1LaXLk1AxiEmOWREfhNhlMjrr05Qm3HItIdtLyQF3Ehi
 Tg5Ct9Wqn2A0kbGLXEbZ8jeMtf/ypMoP4OXd50OlsCXNX/pXbO8UXvAFoLXb5jE5KuUtVlH7hgX
 9OrcuJUdqr3QAzqr/C46LLpDByz0mxcAtzGmbgwgOcPXTxgDtUtxlT02fVqcZSMN8LnWziMIUef
 ubMC2/iD0jhKKRPqGUXWaLBkEFu42h0kEpuF1tNaxNtDmXMtC7tFAPOJBpuPoGsshf5e6AzjuoJ
 fhJSUDLuCEmz4BAzzQ9UfAzDQTQFSExd0B3c2jQ5gIquXkO0q5bx4Hwx/zr/XBlcRsD9GMBrkFx
 9dhOUJz5KD2TMwxA==
X-Received: by 2002:a05:600c:1d06:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4b6df02925bmr42182455e9.14.1793969397012; 
 Fri, 06 Nov 2026 04:49:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e24012c3sm52969615e9.13.2026.11.06.04.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:49:56 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 12:49:54 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 7c11a0f64236ce99cfec2ad3dea9c08be68d76bc
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <748796546bc4885388880227513f42c574243ea3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPJON-000000005hY-3WyK
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6065774310759097358=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6065774310759097358==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5KlLGHrgU5A="; charset=UTF-8

--5KlLGHrgU5A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail

to look at the new patch set (#6)=2E

=
The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: Adjust ACC_MAX_MSG_LEN, fix ACC in p2=
p mode and improve documentation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve=
 documentation

We do not need to limit the maximum ACC message length to j=
ust 1280=2E Also
improve the comments and documentation to be clearer=2E

F=
ix that the management notification about negotiated protocol is not sent
w=
hen in p2p mode (or if a server has push-peer-info in its configuration)

C=
hange-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Signed-off-by: Arne Sch=
wabe <arne@rfc2549=2Eorg>
---
M doc/management-notes=2Etxt
M src/openvpn/ac=
c=2Ec
M src/openvpn/acc=2Eh
M tests/unit_tests/openvpn/test_acc=2Ec
4 files=
 changed, 40 insertions(+), 15 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/30/2130/6

diff --git a/doc/managemen=
t-notes=2Etxt b/doc/management-notes=2Etxt
index 6c798c0=2E=2Ea98b45f 10064=
4
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -139=
8,11 +1398,17 @@
     next message should be concatenated to this message t=
o form a complete
     message=2E
 
-    Note that the OpenVPN implementati=
on operates here with the robustness
-    principle ("be conservative in wh=
at you send, be liberal in what you
-    accept" - RFC 793 and others) and =
allows receiving messages longer than
-    maximum allowed message length=
=2E Implementations should be prepared to
-    handle messages that are lon=
ger than the maximum allowed message length=2E
+    Note that fragment is b=
asically a flag for allowing peers communicating
+    over ACC to indicate =
if multiple ACC messages should be considered to
+    be a single message=
=2E If the ACC protocol is a stream based protocol
+    then all messages c=
an be sent without fragment flag=2E
+
+    Note that the OpenVPN implementa=
tion allows receiving messages longer than
+    announced maximum allowed m=
essage length=2E Implementations must be prepared
+    to handle messages t=
hat are longer than the maximum allowed message length=2E
+    Overlong mes=
sages are considered invalid and indicate that the peer is
+    misbehaving=
=2E Disconnecting/dropping the peer is considered a valid
+    response to =
such messages=2E
 
     OpenVPN does not verify that the message is valid b=
ase64=2E A peer that
     sends invalid base64 payload will be passed to th=
e management interface=2E
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/ac=
c=2Ec
index 455f56d=2E=2Ee9656a6 100644
--- a/src/openvpn/acc=2Ec
+++ b/src=
/openvpn/acc=2Ec
@@ -190,10 +190,10 @@
     }
 
     /* We do not check the=
 length here=2E We make no promises to support
-     * anything larger than=
 our announced message length but according to
-     * the robustness princ=
iple
-     * ("be conservative in what you send, be liberal in what you acc=
ept" - RFC 793 and others)
-     * we accept also longer messages */
+     =
* anything larger than our announced message length but we accept also
+   =
  * longer messages if they manage to get through all the other layers
+   =
  * that restrict the message size like TLS_CHANNEL_BUF_SIZE=2E
+     */
 
=
     int payload_len;
     const char *payload_len_str =3D buf_extract_fiel=
d(&buf, ',', &gc);
@@ -426,8 +426,20 @@
     multi->acc_negotiated_protocol=
s =3D string_alloc(buf_str(&common_protocols), NULL);
     multi->acc_max_m=
essage_length =3D max_acc_len;
 
-    setenv_str(session->opt->es, "acc_pro=
tocols", multi->acc_negotiated_protocols);
-    setenv_int(session->opt->es=
, "acc_message_len", multi->acc_max_message_length);
+    /* The normal cas=
e is that this is a server where we notify the client
+     * capabilities =
via environment variables */
+    if (multi->opt=2Emode =3D=3D MODE_SERVER)=

+    {
+        setenv_str(session->opt->es, "acc_protocols", multi->acc_n=
egotiated_protocols);
+        setenv_int(session->opt->es, "acc_message_le=
n", multi->acc_max_message_length);
+    }
+    else
+    {
+        /* We =
can also end up here in p2p or if the server has --push-peer-info
+        =
 * We do not set variables in that case to keep behavior consistent with
+ =
        * the other paths on the client that also do not set variables */
+=
        notify_client_acc_protocols(multi);
+    }
 
     gc_free(&gc);
 }
=
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
index 9c99b11=2E=2Ed=
640898 100644
--- a/src/openvpn/acc=2Eh
+++ b/src/openvpn/acc=2Eh
@@ -29,7 =
+29,9 @@
 #include "openvpn=2Eh"
 
 #define ACC_MIN_MSG_LEN 64
-#define ACC=
_MAX_MSG_LEN 1280
+/* This is a conservative limit=2E The theoretical maxim=
um
+ * is much closer to the TLS_CHANNEL_BUF_SIZE */
+#define ACC_MAX_MSG_L=
EN (TLS_CHANNEL_BUF_SIZE - 128)
 
 /**
  * This method parses an app custom=
 control message and delivers it to the
diff --git a/tests/unit_tests/openv=
pn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
index 9364d12=2E=2E=
bc103b4 100644
--- a/tests/unit_tests/openvpn/test_acc=2Ec
+++ b/tests/unit=
_tests/openvpn/test_acc=2Ec
@@ -181,7 +181,11 @@
     int max_len =3D 0;
  =
   const char *protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, true, &gc);
     assert_string_equal(protocols, "flower:happy");
-    a=
ssert_int_equal(max_len, 1280);
+
+    /* Check that the ACC_MAX_MSG_LEN is=
 1920 to ensure that the tests get
+     * adjusted if it changes */
+    a=
ssert_int_equal(ACC_MAX_MSG_LEN, 1920);
+    assert_int_equal(max_len, ACC_=
MAX_MSG_LEN);
 
     /* a client does not accept a length longer than it su=
pports */
     protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, false, &gc);
@@ -247,14 +251,15 @@
     multi->opt=2Eacc_protocols =3D =
c->options=2Eacc_protocols;
     multi->session[TM_ACTIVE]=2Eopt =3D &multi=
->opt;
     multi->opt=2Ees =3D env_set_create(&c->options=2Egc);
+    mult=
i->opt=2Emode =3D MODE_SERVER;
 
     determine_common_acc_protocols(multi,=
 &c->c2=2Etls_multi->session[TM_ACTIVE]);
 
-    assert_int_equal(multi->ac=
c_max_message_length, ACC_MAX_MSG_LEN);
+    assert_int_equal(multi->acc_ma=
x_message_length, 1400);
     assert_string_equal(multi->acc_negotiated_pro=
tocols, "power:flower");
 
     assert_string_equal(env_set_get(multi->opt=
=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
-    assert_strin=
g_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_message_len=
=3D1280");
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_messa=
ge_len"), "acc_message_len=3D1400");
 
     free(multi->acc_negotiated_prot=
ocols);
     gc_free(&c->options=2Egc);

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
Gerrit-=
Change-Number: 2130
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>

--5KlLGHrgU5A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #6</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Adjust A=
CC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation<br><br>We do =
not need to limit the maximum ACC message length to just 1280=2E Also<br>im=
prove the comments and documentation to be clearer=2E<br><br>Fix that the m=
anagement notification about negotiated protocol is not sent<br>when in p2p=
 mode (or if a server has push-peer-info in its configuration)<br><br>Chang=
e-Id: I3a268fc602e916bf54853c950761977cf3d7f835<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/management-notes=2Etxt<br>M =
src/openvpn/acc=2Ec<br>M src/openvpn/acc=2Eh<br>M tests/unit_tests/openvpn/=
test_acc=2Ec<br>4 files changed, 40 insertions(+), 15 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/30/2130/6</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/ma=
nagement-notes=2Etxt</span><br><span>index 6c798c0=2E=2Ea98b45f 100644</spa=
n><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/mana=
gement-notes=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@</span><br><span>=
     next message should be concatenated to this message to form a complete=
</span><br><span>     message=2E</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    Note that the OpenVPN implementation opera=
tes here with the robustness</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    principle (&quot;be conservative in what you send, be liberal in=
 what you</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    accept&q=
uot; - RFC 793 and others) and allows receiving messages longer than</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    maximum allowed message =
length=2E Implementations should be prepared to</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    handle messages that are longer than the maxi=
mum allowed message length=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    Note that fragment is basically a flag for allowing peers com=
municating</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over =
ACC to indicate if multiple ACC messages should be considered to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    be a single message=2E If =
the ACC protocol is a stream based protocol</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    then all messages can be sent without fragment =
flag=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    Note that the OpenVPN imple=
mentation allows receiving messages longer than</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    announced maximum allowed message length=2E=
 Implementations must be prepared</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    to handle messages that are longer than the maximum allow=
ed message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    Overlong messages are considered invalid and indicate that the peer is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    misbehaving=2E =
Disconnecting/dropping the peer is considered a valid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    response to such messages=2E</span><b=
r><span> </span><br><span>     OpenVPN does not verify that the message is =
valid base64=2E A peer that</span><br><span>     sends invalid base64 paylo=
ad will be passed to the management interface=2E</span><br><span>diff --git=
 a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index 455f56d=
=2E=2Ee9656a6 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><s=
pan>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,10 @@</span><=
br><span>     }</span><br><span> </span><br><span>     /* We do not check t=
he length here=2E We make no promises to support</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * anything larger than our announced messag=
e length but according to</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * the robustness principle</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * (&quot;be conservative in what you send, be liberal in=
 what you accept&quot; - RFC 793 and others)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * we accept also longer messages */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * anything larger than our=
 announced message length but we accept also</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * longer messages if they manage to get throu=
gh all the other layers</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * that restrict the message size like TLS_CHANNEL_BUF_SIZE=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>=
 </span><br><span>     int payload_len;</span><br><span>     const char *pa=
yload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span>=
<br><span>@@ -426,8 +426,20 @@</span><br><span>     multi-&gt;acc_negotiate=
d_protocols =3D string_alloc(buf_str(&amp;common_protocols), NULL);</span><=
br><span>     multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(=
session-&gt;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc_negotiated=
_protocols);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    seten=
v_int(session-&gt;opt-&gt;es, &quot;acc_message_len&quot;, multi-&gt;acc_ma=
x_message_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* The normal case is that this is a server where we notify the client</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * capabilities v=
ia environment variables */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (multi-&gt;opt=2Emode =3D=3D MODE_SERVER)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        setenv_str(session-&gt;opt-&gt;es, &quot;acc=
_protocols&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        setenv_int(session-&gt;opt-&gt;e=
s, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_length);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* We can also end up here in p2p or if the server has --p=
ush-peer-info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * We do not set variables in that case to keep behavior consistent with<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the other=
 paths on the client that also do not set variables */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        notify_client_acc_protocols(mult=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><sp=
an>index 9c99b11=2E=2Ed640898 100644</span><br><span>--- a/src/openvpn/acc=
=2Eh</span><br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -29,7 +29=
,9 @@</span><br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> </=
span><br><span> #define ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* This is a conservative limit=2E The theore=
tical maximum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is =
much closer to the TLS_CHANNEL_BUF_SIZE */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)=
</span><br><span> </span><br><span> /**</span><br><span>  * This method par=
ses an app custom control message and delivers it to the</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn=
/test_acc=2Ec</span><br><span>index 9364d12=2E=2Ebc103b4 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -181,7 +181,11 @@</spa=
n><br><span>     int max_len =3D 0;</span><br><span>     const char *protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span>     assert_string_equal(protocols, &quot;flow=
er:happy&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_int_equal(max_len, 1280);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Check that the ACC_MAX_MSG_LEN is 1920 to ensure that the tests get</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * adjusted if it chang=
es */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(ACC_MAX_MSG_LEN, 1920);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(max_len, ACC_MAX_MSG_LEN);</span><br><span>=
 </span><br><span>     /* a client does not accept a length longer than it =
supports */</span><br><span>     protocols =3D parse_acc_parameters(info_ac=
c_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span>@@ -24=
7,14 +251,15 @@</span><br><span>     multi-&gt;opt=2Eacc_protocols =3D c-&g=
t;options=2Eacc_protocols;</span><br><span>     multi-&gt;session[TM_ACTIVE=
]=2Eopt =3D &amp;multi-&gt;opt;</span><br><span>     multi-&gt;opt=2Ees =3D=
 env_set_create(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    multi-&gt;opt=2Emode =3D MODE_SERVER;</span><br><=
span> </span><br><span>     determine_common_acc_protocols(multi, &amp;c-&g=
t;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(multi-&gt;acc_ma=
x_message_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_message_length, 1400=
);</span><br><span>     assert_string_equal(multi-&gt;acc_negotiated_protoc=
ols, &quot;power:flower&quot;);</span><br><span> </span><br><span>     asse=
rt_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;),=
 &quot;acc_protocols=3Dpower:flower&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_string_equal(env_set_get(multi-&gt;opt=2Ee=
s, &quot;acc_message_len&quot;), &quot;acc_message_len=3D1280&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(e=
nv_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_mess=
age_len=3D1400&quot;);</span><br><span> </span><br><span>     free(multi-&g=
t;acc_negotiated_protocols);</span><br><span>     gc_free(&amp;c-&gt;option=
s=2Egc);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c=
950761977cf3d7f835 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2130 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--5KlLGHrgU5A=--


--===============6065774310759097358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6065774310759097358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6065774310759097358==--


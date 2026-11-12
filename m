Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AC606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LiGV9PeK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BLpwxCY/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b1UqWnDb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WL4N62ZI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EH8IgX2VLyPqSCuBkbp1Iskw6wPrVR1/9IsowGZh6g0=; b=LiGV9PeKaERoopZARGc8moP61O
	fT15/VjcpVkWkEoE1GM5LxIZHdKL1a8NPZ9ZvhGqz9UlFAXTvKqgR1iCi5DqwRj/2nmiZnVaOk2qG
	PA0uEMhfOoih7E2+hh7S/4HHQ3HI3eN0tmw1qYpyHGPzBc8eZtDB3YTNlgcvuzhgiyf0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYUT-000000003gw-3Gi6;
	Thu, 12 Nov 2026 17:21:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYUI-000000003gP-1vO1
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mHCL4J521lw5zr7ZtJAyZrDKDeJ+xTxyUmtSUR2E7aU=; b=BLpwxCY/6bJIpF0i8NRc+fq9DA
 f4g/aUEjNQRaCts8DLKzJt2YKpdkIbYvCGtLcDlq7uluOHfTHve4x+CuaB4FIRhMqHZopCAKYti5U
 9azfbole+00I5tw3mFTKF2kY4xIxo498WWz6vcC4xoTLoyhiwq8aP9EA/3pwu7Kprtrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mHCL4J521lw5zr7ZtJAyZrDKDeJ+xTxyUmtSUR2E7aU=; b=b1UqWnDbVEaaGZuaCRyf50mcJb
 pVhKqlhDpYX98FnSSJ1Taqd0V1ArLEMIfvFlvk31uY/WyNAq+AqqVYBdJkXfPewdvaCWWs/jMxW+T
 8LS0/ftZ57q59kBygraqyTDLyI+0H0k/7hqXFFd6SUYb6EEDCQMzN5mYGj2cS5snAwic=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYTw-000000007Lf-0u5Q for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:21:06 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so399195e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794504057; x=1795108857; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mHCL4J521lw5zr7ZtJAyZrDKDeJ+xTxyUmtSUR2E7aU=;
 b=WL4N62ZIYgYm4MCukhuQcX9VhMDjwU/PlzFPGituFWbs8u7Axob6B3/23wHygCdoiz
 mYc2IC1rtZg+B1DvUc673RwTBBZ5fDnVVUI6SfOpwLZh1cgkGk3wsTvf5rdGYyidBPv/
 qft0stJJccndBWU2cl6qHg/IsCCd617EzAsCJJhU6Na+qX2Qkv/bBHjfnBvCTvBr6Wpa
 8KxXjWxtLZJb3KAQkorIu8RvqcdXbnpOYJi+Air/jOGulrlaJJoTfM37t9hBTmi7ZWAJ
 vhByqkovWNe6dNk5VK15imnN30TVkJzWmwwdDcs1OpwjPxf+fIlLsPJLhhPLVu2o6YNW
 CjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794504057; x=1795108857;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mHCL4J521lw5zr7ZtJAyZrDKDeJ+xTxyUmtSUR2E7aU=;
 b=jU///W0HIIo3p8xs2tWffRFGqvbZFyrPOJtjGsR835l+GAZLTERKPP2Al+jzAeLmg8
 GYJrcdz5bRt5zcXBZn23ddH09aLjkyeMtCMsd3Y4wGjqQEOe6WPrFUKDb9apYk1V8441
 Io3JTMxMneHsFWX40jdgvAy5q7qMRHI/bbDA07uvtUGFcmt6HyWiVk+cdSGrYLmx+jHp
 EkfgiHrnSKSmBFzd2tVs9Phk5G7p1pGyX6HTL4HvsDLG7IITzftnORxI6QwNOpTACN22
 f0JKYkLyXIGwErY22lbn8oJuH8FccXiZoF6FaitJji3y+3U9UmSpf2Emlgg2RDLSn0Ph
 Vnsg==
X-Gm-Message-State: APuU4Z8cKWzKIYUw5oYr6GKY294GJ07agRwy6g73gYbUvNOdyL2KpVqw
 8dZQUwbchJH9wBV4tILZASDL6JlBVCTPh5GOK9AdlDekeDnjJ/4pxvZzAcpSNzGhcLFR0MkJRMb
 KRTp1stjGORpIa805MMpyH3xD6+yj2o07AFutEXJgr+7lSuHgj+87AWxj6ERhbkxyQCBWHhlPLG
 CV/vxGJA==
X-Gm-Gg: AYBFou3Tnjb831iICYlQs4uPYCR+BcEjqOUG4vhijtI3koSc9m6AGeuALjfcDSWg0CJ
 Pb1EUOFQpIbnp7Kr1g+WSSOSJqZQGlY/XJrcWDSDBBVkPQ462kud9iZ8V5jKZfI/xLMCbVy97GE
 TBz1HTrknLj82wcAFsgvpIe2yo6TbGKMg78aT5H174E7OXiyvVt30haphwxtj0CSQeSnxdf2B7m
 mDN60+nzrNuqN3kCqGT/YgRjxL9HsLqMVek8b9WQ9VedlCiEB/GR++mZMNbUZweJqx477dBHnZC
 D+KR6BbArEHLPpDvEvws+I55255A4toPkCG6L2vj9VHrnf92cYEJ8EXoXDiFywUwgz8I2T1rY+8
 Yk9cDT2hLSIBrwYnehOuT3uB0+4NHu7abaBNAEFCWkFs5rA5kd68CLFa9znd0QjvZxUaDEuxa/h
 BWgfs4yyRsH0KpCxsJgUoQ1NRUCZAtUMmiIyCJXcWowIRXEnN/Ro/Vy/9FR5dEiwVJbG71gmP15
 Q0ZVBJ2D94ZJU7wG8Dwu+gd1ZAr6EzXz3TRodk7wPV72466ve0zcIdvn0p7VU8S9KU1ePS6G2HN
 wWogwMdADjIWB4cY4tfshU9ijK9dL3jVeeWiiXeaFyNK1dQf51wz5pMhN4eNG5dInvE3oi1af7m
 RfcArum9fhCijBZJZ85Y8CTMbmc4ujC6eVfd7a9G5NeWRGNbT4MpdT/ib5hFeeuQXAN8tFDrDhb
 ZHurqDdbnUN+O808I=
X-Received: by 2002:a05:600c:64c8:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4ba0939db68mr124765145e9.28.1794504057111; 
 Thu, 12 Nov 2026 09:20:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d66esm298467f8f.57.2026.11.12.09.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:20:56 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:20:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4b241185d75f61be9137220e18742c1e6912820f
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03387350f3fba987f985def5cdd673a3688bf10c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYTw-000000007Lf-0u5Q
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
Content-Type: multipart/mixed; boundary="===============0433664705559285052=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0433664705559285052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yP0tEK6P6w8="; charset=UTF-8

--yP0tEK6P6w8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#7) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Adjust ACC_MAX_MSG_LEN, f=
ix ACC in p2p mode and improve documentation
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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/2=
130/7

diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt=

index 6c798c0=2E=2Ea98b45f 100644
--- a/doc/management-notes=2Etxt
+++ b/d=
oc/management-notes=2Etxt
@@ -1398,11 +1398,17 @@
     next message should =
be concatenated to this message to form a complete
     message=2E
 
-    N=
ote that the OpenVPN implementation operates here with the robustness
-    =
principle ("be conservative in what you send, be liberal in what you
-    a=
ccept" - RFC 793 and others) and allows receiving messages longer than
-   =
 maximum allowed message length=2E Implementations should be prepared to
- =
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

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c=
950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 7
Gerrit-Own=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--yP0tEK6P6w8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #7</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/213=
0?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Adj=
ust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation<br><br>W=
e do not need to limit the maximum ACC message length to just 1280=2E Also<=
br>improve the comments and documentation to be clearer=2E<br><br>Fix that =
the management notification about negotiated protocol is not sent<br>when i=
n p2p mode (or if a server has push-peer-info in its configuration)<br><br>=
Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835<br>Signed-off-by: Arne=
 Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2130<br>Message-Id: &lt;20261108151523=2E26265-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg40902=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M doc/management-notes=2Etxt<br>M src/openvpn/acc=
=2Ec<br>M src/openvpn/acc=2Eh<br>M tests/unit_tests/openvpn/test_acc=2Ec<br=
>4 files changed, 40 insertions(+), 15 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/213=
0/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=
=2Etxt</span><br><span>index 6c798c0=2E=2Ea98b45f 100644</span><br><span>--=
- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=
=2Etxt</span><br><span>@@ -1398,11 +1398,17 @@</span><br><span>     next me=
ssage should be concatenated to this message to form a complete</span><br><=
span>     message=2E</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    Note that the OpenVPN implementation operates here wit=
h the robustness</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
rinciple (&quot;be conservative in what you send, be liberal in what you</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    accept&quot; - RFC 7=
93 and others) and allows receiving messages longer than</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    maximum allowed message length=2E Im=
plementations should be prepared to</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    handle messages that are longer than the maximum allowed =
message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  Note that fragment is basically a flag for allowing peers communicating</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    over ACC to indic=
ate if multiple ACC messages should be considered to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    be a single message=2E If the ACC pro=
tocol is a stream based protocol</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    then all messages can be sent without fragment flag=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    Note that the OpenVPN implementation =
allows receiving messages longer than</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    announced maximum allowed message length=2E Implement=
ations must be prepared</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    to handle messages that are longer than the maximum allowed message=
 length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Overl=
ong messages are considered invalid and indicate that the peer is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    misbehaving=2E Disconnect=
ing/dropping the peer is considered a valid</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    response to such messages=2E</span><br><span> <=
/span><br><span>     OpenVPN does not verify that the message is valid base=
64=2E A peer that</span><br><span>     sends invalid base64 payload will be=
 passed to the management interface=2E</span><br><span>diff --git a/src/ope=
nvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index 455f56d=2E=2Ee9656=
a6 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><span>+++ b/s=
rc/openvpn/acc=2Ec</span><br><span>@@ -190,10 +190,10 @@</span><br><span>  =
   }</span><br><span> </span><br><span>     /* We do not check the length h=
ere=2E We make no promises to support</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * anything larger than our announced message length bu=
t according to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
the robustness principle</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * (&quot;be conservative in what you send, be liberal in what you a=
ccept&quot; - RFC 793 and others)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * we accept also longer messages */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * anything larger than our announced=
 message length but we accept also</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * longer messages if they manage to get through all the=
 other layers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 that restrict the message size like TLS_CHANNEL_BUF_SIZE=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span> </span><b=
r><span>     int payload_len;</span><br><span>     const char *payload_len_=
str =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span>=
@@ -426,8 +426,20 @@</span><br><span>     multi-&gt;acc_negotiated_protocol=
s =3D string_alloc(buf_str(&amp;common_protocols), NULL);</span><br><span> =
    multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(session-&g=
t;opt-&gt;es, &quot;acc_protocols&quot;, multi-&gt;acc_negotiated_protocols=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_int(sess=
ion-&gt;opt-&gt;es, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_=
length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The =
normal case is that this is a server where we notify the client</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * capabilities via environ=
ment variables */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (multi-&gt;opt=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols=
&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        setenv_int(session-&gt;opt-&gt;es, &quot;a=
cc_message_len&quot;, multi-&gt;acc_max_message_length);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* We can also end up here in p2p or if the server has --push-peer-in=
fo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * We do =
not set variables in that case to keep behavior consistent with</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * the other paths on t=
he client that also do not set variables */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        notify_client_acc_protocols(multi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </sp=
an><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>diff=
 --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><br><span>index 9c=
99b11=2E=2Ed640898 100644</span><br><span>--- a/src/openvpn/acc=2Eh</span><=
br><span>+++ b/src/openvpn/acc=2Eh</span><br><span>@@ -29,7 +29,9 @@</span>=
<br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><sp=
an> #define ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* This is a conservative limit=2E The theoretical maximu=
m</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is much closer =
to the TLS_CHANNEL_BUF_SIZE */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)</span><br><=
span> </span><br><span> /**</span><br><span>  * This method parses an app c=
ustom control message and delivers it to the</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2E=
c</span><br><span>index 9364d12=2E=2Ebc103b4 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_acc=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_acc=2Ec</span><br><span>@@ -181,7 +181,11 @@</span><br><span>=
     int max_len =3D 0;</span><br><span>     const char *protocols =3D pars=
e_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);=
</span><br><span>     assert_string_equal(protocols, &quot;flower:happy&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_eq=
ual(max_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that t=
he ACC_MAX_MSG_LEN is 1920 to ensure that the tests get</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * adjusted if it changes */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ACC_M=
AX_MSG_LEN, 1920);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(max_len, ACC_MAX_MSG_LEN);</span><br><span> </span><br>=
<span>     /* a client does not accept a length longer than it supports */<=
/span><br><span>     protocols =3D parse_acc_parameters(info_acc_msg, &quot=
; &quot;, &amp;max_len, false, &amp;gc);</span><br><span>@@ -247,14 +251,15=
 @@</span><br><span>     multi-&gt;opt=2Eacc_protocols =3D c-&gt;options=2E=
acc_protocols;</span><br><span>     multi-&gt;session[TM_ACTIVE]=2Eopt =3D =
&amp;multi-&gt;opt;</span><br><span>     multi-&gt;opt=2Ees =3D env_set_cre=
ate(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    multi-&gt;opt=2Emode =3D MODE_SERVER;</span><br><span> </span=
><br><span>     determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_m=
ulti-&gt;session[TM_ACTIVE]);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    assert_int_equal(multi-&gt;acc_max_message_le=
ngth, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(multi-&gt;acc_max_message_length, 1400);</span><br=
><span>     assert_string_equal(multi-&gt;acc_negotiated_protocols, &quot;p=
ower:flower&quot;);</span><br><span> </span><br><span>     assert_string_eq=
ual(env_set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;acc_p=
rotocols=3Dpower:flower&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc=
_message_len&quot;), &quot;acc_message_len=3D1280&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_get(m=
ulti-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=3D14=
00&quot;);</span><br><span> </span><br><span>     free(multi-&gt;acc_negoti=
ated_protocols);</span><br><span>     gc_free(&amp;c-&gt;options=2Egc);</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3=
d7f835 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2130 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--yP0tEK6P6w8=--


--===============0433664705559285052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0433664705559285052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0433664705559285052==--


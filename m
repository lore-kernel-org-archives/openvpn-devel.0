Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972B606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XRI5KZZa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NQC4p5qW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AS9eArOV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fb1HkVzm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=XQAjduFQJvNgrN2PqdnAtksvpBg/LSi8YCzu3ZYqoDk=; b=XRI5KZZaMng7d/2dIDVA35+ApT
	l44qwMd82aQgvhRTpWdlEmyYMHA/E3/cudATQkezwZtY+W6nXIJcjagFCf3piOCDbHnYDZ7vG2Y/Z
	OFF7/AfXHmUmDYYhY8f4thPtgR2UDwXX+zB0UsV6aahuviC53jno4sACWuu97MiVoVQ0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVnhQ-000000004KO-0bLJ;
	Tue, 24 Nov 2026 10:24:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVnhO-000000004KF-0nxO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:24:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FiaLA6qHjSoS+Xtn60FSaS0qAqxy9aSVF24zxtGboQ4=; b=NQC4p5qWk1v2rGeYKCoH0WQkq8
 LbS9oQvCZZkE0bv9nksGmkypHiuY/tB0a4KwtIB2xr4dxWcyQsox4fk1GndTTVNtGACMuRcdu/Tje
 tlmQGD6erc2zByTHHolQX6Lf+ZdNZ6aEiR6eH8A2X7FoxXtERSoEqKYgf7v5LhZ4r2xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FiaLA6qHjSoS+Xtn60FSaS0qAqxy9aSVF24zxtGboQ4=; b=AS9eArOVvRiqbhiSI6ngtEvF5O
 6KYfRwCqMyV6RBvcOsu4VhsBcnO+Mg0I7ZnVfsM+vGQ9x3fr5JGa7Np0etT41l7PLViuUjc0ueHs9
 ofDsRPhsNp/Ywoo7hR2D7rXIPnlALxAmShkYUZ8rYVXOnr83JdQru2zxVj4xlKA5aArI=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVnhM-000000007c7-2Xph for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:24:30 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so24487535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795515862; x=1796120662; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FiaLA6qHjSoS+Xtn60FSaS0qAqxy9aSVF24zxtGboQ4=;
 b=fb1HkVzmKKm/vXb4IfIVFbMRpW7bIIHZLCYIuIF9a591VzoUtJ1HF00pjmPQ6B/8iM
 M1Ocz9rU3AjLY21GhFjWqWbLM8NE0qzBEVL758e8t2Jcs/HhCvD4HpbE5ZTcLdEgYmxI
 oQaG75D00TVMANqS+GAjnVhW+99ftulJ8MO3EDdeiaxtuaN7zPRC5UTl2cBSGGvICkJO
 nTCpC+khlzkTTQ6c4PLe2evjueT6qgKm5dOS7c/cYcyhsehq8C1zn8gVDazkrPBZn1xn
 lvxAoXSOiLdSi1Xcu51GbazupqeGY64/erkYgYVkIiV3jBDLR7V6pHz2+RLP1pQtaFdX
 vhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515862; x=1796120662;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FiaLA6qHjSoS+Xtn60FSaS0qAqxy9aSVF24zxtGboQ4=;
 b=qoM0IwcG90i35RP1gGqzKwCyAbKQ2jK/nBV9RkzwvdJQHuota++2JVZVBB1KZu2nS3
 zk5Hjil1t45PXZtvuhAuu/DWLZuvn+SymssCY98zK1TM8QkdK9fIHlw5l+h3Kz3dp/IV
 3MEih6uupJTMWb1hfGdHJL2GuXzfFrBdZz9U9YpIj9x1jEGeT+BN+sctRecyaK6WAhIF
 HZfAo/LViACDjm9dQvDFJaCCvb44Uj3f+7R9gXkZAeYeTVAAq8SXkqe06ZP78LBu50GA
 heoVnZl8snV9cnccztLBQUsfkEiGDBw3bFtw9QALf3Qlr7poUo+Mv8aYP2krUcxfznbX
 JY9A==
X-Gm-Message-State: APuU4Z+Npr7qes0YlAEYADzIWjLpv7Akfor/YI5qdyBGAHeBVnY8RodO
 xGMkSZy7TkaLDvyFcVmbS4V2lccMTAKJPBKLljov1uHYzKS5gJZE6o+I4OfKfxCtJc2JwsvZdCt
 dww/iFh83A/4Cc3rNyEq0b9J89gLvwr/zTsbOwv/LxcKsF+MnIOJVtZbYtmd02PM6o3BSB8GICo
 af6UK5zg==
X-Gm-Gg: AZFdTZeVs0jHshnUBwi67wbrNuqIAXDJr4K72It/vO/D1j3syVD4eWuzHpyb9VMLEW8
 M/oz38XADSWMM67P7OzAhMCJ0c5gpah4Pf/1MWXVgaVAzDZB8ruzpB06lO3BVP9gR3LL/7N6USm
 7wX8B+Z5UlYtgU4nodeJ+f4RQiGq4aMA40LVOBmQJ8zMC/wRfgRR3NSCWHnZl3VmM9d8d1yRCy2
 yTFrolswMQdvMZ2yV4lp4fDApKrACd4p7ql1I1TbVb+QJWE/GGMnIx3AC/6pnh7zJdcto0j2/cw
 Yvtgqt8aJTDPOyicMqMbApUwM3kBGr9+P0SUotqFkBDXArqzmFmaeRsGJwBjKqVg91faFL2k3f3
 MvZIbntAAq+PjDDLy4P4F5q2MFdKfSrB8/TozstUrUq34NLN7UOIOQkJVGBzqKljN0lDFlI8MG0
 /Mykyi2jUvgDfav1trJhhpZUFc2LP1UjNWk9ECpI2My33XTxxmNzA6rylE8+EfWsyeGb12IiC50
 wI20t2SYUU60bGJVtx1VmGjzSclErWh4Jial9rOMLHFzfj/L5iDClTpnB+P6ApQAW8fKSOzwOON
 oPoDQg8noWYD3ATvIGLYTCL6Vak4qZ+/wUiIlo/evHZIiOsueMLp1olPkreqPkkibYcXRGy2MEH
 ii0ovP8http7qwm1huyNcllbjJPGYfFMI/M0ub2/WRyQe0dleNaiF79gFkmmLt6R1yAc6f4Rrrj
 jlchnM1483i+5OqFWxSA1+QYfce8noADxgRrzS
X-Received: by 2002:a05:600c:4ec9:b0:4bb:6a5a:782d with SMTP id
 5b1f17b1804b1-4bb88925fcdmr295099215e9.17.1795515861906; 
 Tue, 24 Nov 2026 02:24:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm385838265e9.12.2026.11.24.02.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:24:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 10:24:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
X-Gerrit-Change-Number: 2333
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2333?usp=email>
X-Gerrit-Commit: ca6322667883fef5e13e2b800db5c3955d5f4bb8
References: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLklmYTA1YjlmZDA2ZTVkNTI4MThjOTFjNWIxNjBiNmRkMDZlYzcxMzk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77608b9ad22bc1ccd72680edc11d726f57c53fce-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVnhM-000000007c7-2Xph
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpn: make the
 context mode an enum
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2166994608194668062=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2166994608194668062==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vqKz5IqPITc="; charset=UTF-8

--vqKz5IqPITc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2333?usp=3Demail

to review the following change=2E
=


Change subject: openvpn: make the context mode an enum
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn: make the context mode =
an enum

Turn the CM_* defines into enum context_mode and use it for
struct=
 context=2Emode, so -Wswitch covers switches over it=2E

Drop the stale CM_=
THREAD mention from the comments=2E

Change-Id: Ifa05b9fd06e5d52818c91c5b16=
0b6dd06ec71396
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M=
 src/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
2 files changed, 15 inserti=
ons(+), 10 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/33/2333/1

diff --git a/src/openvpn/init=2Ec b/src/openv=
pn/init=2Ec
index 8b64944=2E=2E10a232c 100644
--- a/src/openvpn/init=2Ec
++=
+ b/src/openvpn/init=2Ec
@@ -2768,6 +2768,9 @@
         case CM_CHILD_TCP:
=
             sec =3D c->options=2Ece=2Econnect_retry_seconds;
             =
break;
+
+        default:
+            break;
     }
 
 #ifdef ENABLE_DEBU=
G
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index ad6b=
e88=2E=2Ef8ba760 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/ope=
nvpn=2Eh
@@ -430,6 +430,16 @@
 };
 
 
+/** Role of a context within the Ope=
nVPN process */
+enum context_mode
+{
+    CM_P2P,       /**< standalone po=
int-to-point session or client */
+    CM_TOP,       /**< top level of a mu=
lti-client or point-to-multipoint server */
+    CM_TOP_CLONE, /**< clone o=
f a CM_TOP context for one thread */
+    CM_CHILD_UDP, /**< child context =
of a CM_TOP */
+    CM_CHILD_TCP, /**< child context of a CM_TOP */
+};
+
 =
/**
  * Contains all state information for one tunnel=2E
  *
@@ -449,16 +45=
9,8 @@
     bool first_time;        /**< True on the first iteration of
   =
                           *   OpenVPN's main loop=2E */
 
-    /* context =
modes */
-#define CM_P2P       0           /* standalone point-to-point ses=
sion or client */
-#define CM_TOP       1           /* top level of a multi=
-client or point-to-multipoint server */
-#define CM_TOP_CLONE 2           =
/* clone of a CM_TOP context for one thread */
-#define CM_CHILD_UDP 3     =
      /* child context of a CM_TOP or CM_THREAD */
-#define CM_CHILD_TCP 4 =
          /* child context of a CM_TOP or CM_THREAD */
-    int mode;      =
              /**< Role of this context within the
-                       =
           *   OpenVPN process=2E  Valid values are \c
-                   =
               *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
-                   =
               *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP=2E */
+    enum con=
text_mode mode; /**< Role of this context within the
+                     =
        *   OpenVPN process=2E */
 
     struct multi_context *multi; /**< =
Pointer to the main P2MP context=2E
                                   *   =
Non-NULL only when mode =3D=3D CM_TOP=2E */

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
Gerr=
it-Change-Number: 2333
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--vqKz5IqPITc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpn: make the context mode an enum<br><br>Turn the =
CM_* defines into enum context_mode and use it for<br>struct context=2Emode=
, so -Wswitch covers switches over it=2E<br><br>Drop the stale CM_THREAD me=
ntion from the comments=2E<br><br>Change-Id: Ifa05b9fd06e5d52818c91c5b160b6=
dd06ec71396<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>2 files c=
hanged, 15 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2333/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>=
index 8b64944=2E=2E10a232c 100644</span><br><span>--- a/src/openvpn/init=2E=
c</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2768,6 +27=
68,9 @@</span><br><span>         case CM_CHILD_TCP:</span><br><span>       =
      sec =3D c-&gt;options=2Ece=2Econnect_retry_seconds;</span><br><span> =
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</spa=
n><br><span>     }</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</=
span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=
=2Eh</span><br><span>index ad6be88=2E=2Ef8ba760 100644</span><br><span>--- =
a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</sp=
an><br><span>@@ -430,6 +430,16 @@</span><br><span> };</span><br><span> </sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** R=
ole of a context within the OpenVPN process */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+enum context_mode</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CM_P2P,       /**&lt; standalone point-to-point session or clien=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_TOP,    =
   /**&lt; top level of a multi-client or point-to-multipoint server */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_TOP_CLONE, /**&l=
t; clone of a CM_TOP context for one thread */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CM_CHILD_UDP, /**&lt; child context of a CM_=
TOP */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_CHILD_=
TCP, /**&lt; child context of a CM_TOP */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /**</span><br><span>  * Contains all state informati=
on for one tunnel=2E</span><br><span>  *</span><br><span>@@ -449,16 +459,8 =
@@</span><br><span>     bool first_time;        /**&lt; True on the first i=
teration of</span><br><span>                              *   OpenVPN&#39;s=
 main loop=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* context modes */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define CM_P2P       0           /* standalone point-to-poin=
t session or client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define CM_TOP       1           /* top level of a multi-client or point-t=
o-multipoint server */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define CM_TOP_CLONE 2           /* clone of a CM_TOP context for one thre=
ad */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CM_CHILD=
_UDP 3           /* child context of a CM_TOP or CM_THREAD */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define CM_CHILD_TCP 4           /*=
 child context of a CM_TOP or CM_THREAD */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int mode;                    /**&lt; Role of this =
context within the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                               *   OpenVPN process=2E  Valid values are \c<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
            *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                  *   \c CM=
_CHILD_UDP, and \c CM_CHILD_TCP=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    enum context_mode mode; /**&lt; Role of this context =
within the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                    *   OpenVPN process=2E */</span><br><span> </span><br><=
span>     struct multi_context *multi; /**&lt; Pointer to the main P2MP con=
text=2E</span><br><span>                                   *   Non-NULL onl=
y when mode =3D=3D CM_TOP=2E */</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail">change 233=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2333 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--vqKz5IqPITc=--


--===============2166994608194668062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2166994608194668062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2166994608194668062==--


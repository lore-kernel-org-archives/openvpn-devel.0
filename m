Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02013606A32A
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i48W8/YN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jbIzPYOp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aoI6k4kD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A4Au40wN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6Eo5DfLV5LOWTgqrnfErAc8XkhTZg0DRPyKwvQmLTBQ=; b=i48W8/YNbbRRE4QK+V6pZlFCes
	Pga/VL3Hgcz8Nf4Elf5fCUzBPom6MCkNlXgggFFopvQ0Kxa0cGYFe5q6HALLlgwEKTt+rSmPK0WOH
	LlKF6tOKCN6HrUleL3iJPkSypXZKgJQD8T+knXxKoqqtKHxav0M1Q5CBEOzBcW9YJXr0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHZm-000000001ll-2vf9;
	Wed, 25 Nov 2026 18:18:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWHZk-000000001le-2EKQ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zQzxJ+AvTUxLVHEq0ZsGCNHpB0TH+SWVPXnDvfuwLQ=; b=jbIzPYOp8mT1kEI+/1iwBJsFh0
 I+O2kCesdaYzDtBDwQwb0J4qnzc8LRED49iRtV5iwD8taNwq4aBslUCTyypsxWMNVeglZcjGcR78f
 eQPZRDtqyoPx/tUz9m96VLoCemfNMAfCDlFB+lJeoiJgqvTfSkascUaUtiY+Vh+xQ67E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zQzxJ+AvTUxLVHEq0ZsGCNHpB0TH+SWVPXnDvfuwLQ=; b=aoI6k4kDhpIcE2sB7LXpUNGRYy
 0d7MiSXxODDHgmqu5NLO7T4vWuAbAKNMZprJr5JTM2DlP5rjQjbo7FEePRY1r1jBBJZrex7GkzxtP
 qczFfQ6UOnkDNq9UACi7VOTXhuIspxlujExqMWH5DZVK0UogsjJc6F+PPt4Q/VhVSR7Y=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWHZg-000000006u3-2hTN for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:18:36 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so52722855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795630706; x=1796235506; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9zQzxJ+AvTUxLVHEq0ZsGCNHpB0TH+SWVPXnDvfuwLQ=;
 b=A4Au40wNrTVpKOtY3fBwwFPC5A5YfWaE82KLuFP3HzXNQnnsm4la7T6xWS12Pzmiw1
 H489PdyAMsFI0WmIDfCLwHYvPC1vyy0fKuw4cFjWZ9Z+ZjBP+zRucCU80g4lL3NTqLJM
 1msoUDmgbnBFVeB92CiIESTwcsRhyL07M6MQ1QzUx9tM4RxkDHmDdba/zISrq3nc7fds
 XuAlBfWJY8gEFAnax4tI5g40ey8gsi6aiXZyDkbohgHeLEv6uQNIbeveoWgNfpCkzxWM
 CB1d4sEDASS5i6qjRbuf0vV1LnNELT6WTnSr91UxeinvpT6/KNVs2ur3zYDBEOkOG2Zn
 H4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630706; x=1796235506;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9zQzxJ+AvTUxLVHEq0ZsGCNHpB0TH+SWVPXnDvfuwLQ=;
 b=GZwEYOf55zPyqOs182M0O25TWYg9sfPOQESRZSW+Qz3iFa59THv/86B7Vv+U45OZTM
 gW98y7OvtC1uLbFMPwf/mwW+JP2Q2UN6jj4oVVcdGqsUvzkHHNdFnBokp5uWnq5vxWu3
 BAKNScoJJ9HiYm8ldDvzIyCOg2Zuas3pQSLLrNTOxjbZ5noZWP3vzKSmAuJPoZb9TnmY
 et3vRv6fuyAYArDWP3Gnm+C/znci7XpQ/iXeM1MGcnSGSEcK4wMyrFTHpAkPlXYcaQfH
 5TXguXyPscsqVIm54kO+x8mLYskwOTm8raiSkA9TfNOj1PXaLihRo5sfpcE6lDoWgVK/
 tvkg==
X-Gm-Message-State: APuU4Z+SbjhPRgA20YdEKULd9NX3lgeJ7l/ehV0ej+dwrVDuLT44yexI
 goGRQzeXGelJu4bvrG1Pj46wlC7/V2Zxpzna605U9msXVFKC9coz6/mN2HuYkEISBVOYs/sX4RN
 s0/sAwglqz86gYSACKH/QgtDcDd3gdx6s6uZA7X13gMuwhfIv/SLkrw7H9rWqwLzF6pO0
X-Gm-Gg: AZFdTZeHdUd9ghimV8z7tmehajubavUvKqZiRLDJcIAPMLi3vbtzTXmXtpA4i24ffXh
 hHgTnW7NkxaSe9cVH6ZAGf179nBlqyVEk+VqkaNZCCkDRBHzun+py+oJj85t2GgBge30FLM8kLt
 Lw2PV1wWMzbQBG/lVo6j8yc213rsUOe2BFSISzqFKYdfSqggQtb8/FQlimrIgqnHcY8X5NXvYB5
 Te2KynI2DdlF47ZcuExHYDMTNiBcCMl1UkQUYyI5w6h0bNrEQUSMvTLcMRneQ39Qc5765dZQvKT
 QFWd4VNtzcb+P5+XojMACLEwJ/f8ObmLuiycJ760gF/XI8hCr5s5cUPb0ElC5NYQspH1FtPwIsH
 KWVhCGEDJrdnPa4mQajXc60XlrwEEqQd2HTXedp7WCG+HE+4Pu2UUu1rF85MNgqrteafTotj5os
 qow7al4IdBhVpAKz8xChxdNVwn/FC+PEys1hSJHGcwmD/66vI/J4XtCvL/Gk0QtNv++RL4C4qch
 bRgoWYK7nXEmQepv8dO/NTRlGzahIAf0FezW0dnweT0YkSQ2C/9pfsdqlX+wEkP+lvwm30UvD1p
 pgtbyvQOkNT31RXA8Y3jXIJSClt2jyDpKLQ0OECd4bkM2xkEkbwPny7WZNGBacu+qv8D/ysNw29
 FHNPnjsVH8UI45EwjqW0xzLwp1x4AM6y2PZ49I27SyguKrtt8j4gK3VnVyGj5m5CiNsxi6JYtbZ
 DQtzUS3nhLO7gFwVfM
X-Received: by 2002:a05:600c:46d0:b0:4bb:7987:fbc4 with SMTP id
 5b1f17b1804b1-4bb88817eb2mr385063805e9.19.1795630705823; 
 Wed, 25 Nov 2026 10:18:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm534799555e9.15.2026.11.25.10.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:18:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 18:18:24 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
X-Gerrit-Change-Number: 2333
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2333?usp=email>
X-Gerrit-Commit: d16c9874876d4718be83284a7eaaa2051d18438f
In-Reply-To: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLklmYTA1YjlmZDA2ZTVkNTI4MThjOTFjNWIxNjBiNmRkMDZlYzcxMzk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <55195525a71f4dff73123138f5f263f78643449e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWHZg-000000006u3-2hTN
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8746913917724438342=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8746913917724438342==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8LKKHlq26CY="; charset=UTF-8

--8LKKHlq26CY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2333?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: openvpn: make the context=
 mode an enum
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


openvpn: make the context mode an enum

Turn the CM_* defines into enum c=
ontext_mode and use it for
struct context=2Emode, so -Wswitch covers switch=
es over it=2E

Drop the stale CM_THREAD mention from the comments=2E

Chang=
e-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
Signed-off-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333
Message-Id: <20=
261124122448=2E8407-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41882=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M s=
rc/openvpn/openvpn=2Eh
2 files changed, 19 insertions(+), 14 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2333=
/3

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 333b4e5=
=2E=2E49fcaf6 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -2768,6 +2768,9 @@
         case CM_CHILD_TCP:
             sec =3D c->o=
ptions=2Ece=2Econnect_retry_seconds;
             break;
+
+        default=
:
+            break;
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvp=
n/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index ad6be88=2E=2Ecbda2e3 100644
-=
-- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -430,6 +430,1=
6 @@
 };
 
 
+/** Role of a context within the OpenVPN process */
+enum con=
text_mode
+{
+    CM_P2P,       /**< standalone point-to-point session or c=
lient */
+    CM_TOP,       /**< top level of a multi-client or point-to-mu=
ltipoint server */
+    CM_TOP_CLONE, /**< clone of a CM_TOP context for on=
e thread */
+    CM_CHILD_UDP, /**< child context of a CM_TOP */
+    CM_CH=
ILD_TCP, /**< child context of a CM_TOP */
+};
+
 /**
  * Contains all stat=
e information for one tunnel=2E
  *
@@ -443,22 +453,14 @@
  */
 struct cont=
ext
 {
-    struct options options; /**< Options loaded from command line o=
r
-                             *   configuration file=2E */
+    struct op=
tions options;      /**< Options loaded from command line or
+             =
                     *   configuration file=2E */
 
-    bool first_time;  =
      /**< True on the first iteration of
-                             *  =
 OpenVPN's main loop=2E */
+    bool first_time;             /**< True on t=
he first iteration of
+                                  *   OpenVPN's main=
 loop=2E */
 
-    /* context modes */
-#define CM_P2P       0           /*=
 standalone point-to-point session or client */
-#define CM_TOP       1    =
       /* top level of a multi-client or point-to-multipoint server */
-#de=
fine CM_TOP_CLONE 2           /* clone of a CM_TOP context for one thread *=
/
-#define CM_CHILD_UDP 3           /* child context of a CM_TOP or CM_THRE=
AD */
-#define CM_CHILD_TCP 4           /* child context of a CM_TOP or CM_=
THREAD */
-    int mode;                    /**< Role of this context withi=
n the
-                                  *   OpenVPN process=2E  Valid valu=
es are \c
-                                  *   CM_P2P, \c CM_TOP, \c CM_T=
OP_CLONE,
-                                  *   \c CM_CHILD_UDP, and \c CM=
_CHILD_TCP=2E */
+    enum context_mode mode;      /**< Role of this contex=
t within the
+                                  *   OpenVPN process=2E */
 =

     struct multi_context *multi; /**< Pointer to the main P2MP context=2E=

                                   *   Non-NULL only when mode =3D=3D CM_T=
OP=2E */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/233=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa05b=
9fd06e5d52818c91c5b160b6dd06ec71396
Gerrit-Change-Number: 2333
Gerrit-Patch=
Set: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stip=
akov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--8LKKHlq26CY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2333?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpn: make the context mode an enum<br><br>Turn the CM_* defines into enum =
context_mode and use it for<br>struct context=2Emode, so -Wswitch covers sw=
itches over it=2E<br><br>Drop the stale CM_THREAD mention from the comments=
=2E<br><br>Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipa=
kov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2333<br>Message-Id: &lt;20261124122448=2E8407-1-gert@gre=
enie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg41882=2Ehtml<br>Signed-off-by: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/ope=
nvpn/openvpn=2Eh<br>2 files changed, 19 insertions(+), 14 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/33/2333/3</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/open=
vpn/init=2Ec</span><br><span>index 333b4e5=2E=2E49fcaf6 100644</span><br><s=
pan>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</=
span><br><span>@@ -2768,6 +2768,9 @@</span><br><span>         case CM_CHILD=
_TCP:</span><br><span>             sec =3D c-&gt;options=2Ece=2Econnect_ret=
ry_seconds;</span><br><span>             break;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            break;</span><br><span>     }</span><br><span> </span><br=
><span> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/openvp=
n=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index ad6be88=2E=2Ecbda2e3 =
100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/=
src/openvpn/openvpn=2Eh</span><br><span>@@ -430,6 +430,16 @@</span><br><spa=
n> };</span><br><span> </span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** Role of a context within the OpenVPN process */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum context_mode</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CM_P2P,       /**&lt; standalone poin=
t-to-point session or client */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    CM_TOP,       /**&lt; top level of a multi-client or point-=
to-multipoint server */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CM_TOP_CLONE, /**&lt; clone of a CM_TOP context for one thread */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_CHILD_UDP, /**=
&lt; child context of a CM_TOP */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CM_CHILD_TCP, /**&lt; child context of a CM_TOP */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Contains all state information for one tunnel=2E</span><br><span>  *</span=
><br><span>@@ -443,22 +453,14 @@</span><br><span>  */</span><br><span> stru=
ct context</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct options options; /**&lt; Options loaded from command lin=
e or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
            *   configuration file=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct options options;      /**&lt; Options loade=
d from command line or</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                  *   configuration file=2E */</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool firs=
t_time;        /**&lt; True on the first iteration of</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             *   OpenVPN&#3=
9;s main loop=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    bool first_time;             /**&lt; True on the first iteration of</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
           *   OpenVPN&#39;s main loop=2E */</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* context modes */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define CM_P2P       0          =
 /* standalone point-to-point session or client */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define CM_TOP       1           /* top level =
of a multi-client or point-to-multipoint server */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define CM_TOP_CLONE 2           /* clone of a=
 CM_TOP context for one thread */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define CM_CHILD_UDP 3           /* child context of a CM_TOP o=
r CM_THREAD */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 CM_CHILD_TCP 4           /* child context of a CM_TOP or CM_THREAD */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int mode;             =
       /**&lt; Role of this context within the</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                  *   OpenVPN proc=
ess=2E  Valid values are \c</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_CL=
ONE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                 *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    enum context_mode mode;    =
  /**&lt; Role of this context within the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                  *   OpenVPN process=
=2E */</span><br><span> </span><br><span>     struct multi_context *multi; =
/**&lt; Pointer to the main P2MP context=2E</span><br><span>               =
                    *   Non-NULL only when mode =3D=3D CM_TOP=2E */</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2333?usp=3Demail">change 2333</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2333?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71=
396 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2333 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--8LKKHlq26CY=--


--===============8746913917724438342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8746913917724438342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8746913917724438342==--


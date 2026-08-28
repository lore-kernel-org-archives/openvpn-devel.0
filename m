Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5CAC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZRJed8j+gfsX88uem5icDRUpvQV3iCKlrYiCI3xb/M=; b=moJ3lP9IcnNMPF0jyfl588wh5o
	mNgHEZ0FxWsznZWtY05sMYuHnOq5oNaytWtB0pyLFvS18PCWw3q4YpmYnX7OEVTHuIeaMyh2WAzfT
	huon5TjHAjc7R0Lrya1gar0w5tu6XbWzHcMH/XACc7O3h+mmB62ptu/pSCNIXqv4GL9E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztuB-0001Pi-Mx;
	Fri, 28 Aug 2026 10:33:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztu9-0001PQ-LV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vpcqpEBatU6Pp4uMK5Kqylu2/te0KY20Ecuwr2WVQqU=; b=kw51miRaKuz/Otz1vtXw8zPQug
 pmIa3lk0LjkpohQvyEzB6jDa5d362KcbMnR0ENzmOkNfiLKBMzyyQeSNNEga6HW/gb9ZdemYgVL5N
 b4+AFAHklPaZn/mUxXbPIZRpj+2qSE3De2pEsawbaOo6+gF1wT/t+ALZOlJWEgbj/AAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vpcqpEBatU6Pp4uMK5Kqylu2/te0KY20Ecuwr2WVQqU=; b=A
 7dBnY/HqBMPRxXbTV7pu3WIPOFLUunW11kcfFNIKiG5R/Ugkl+ZxOc7aZRo7mzmSnBaEatbDmC1gi
 o60HKpl065kgQIlzUWFAYjIjmL3KGoaRvjlARZtu5DxB4cMIEnbLsbHfDfFIfgBbbpqR/Ia5aa2Yr
 76O/XDA1FKtjvxCs=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztu9-00080v-Ou for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:33:50 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-482e5733a5aso509440f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787913223; x=1788518023; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vpcqpEBatU6Pp4uMK5Kqylu2/te0KY20Ecuwr2WVQqU=;
 b=H3kej9K5gvrY3xrkeRtdrh00vpf12TZAsAbdVvnj8fNrcLe6QTJvd8u3GNXG/r7B4n
 /zOiIkNThBFC1C26ZR3YOQG+yLwnZwDc2/I9rvkudWcoqNre5aQnqTOciQWP0i8gVR4n
 IFsR0GD4YDYx4qVjZUolAM6zfE1M97lj0WnQ0JDSTevaaT4jd811yPqlpIXUdsq6Q8AM
 ZQ0Qo8xCJZFvlX+MR5RrbsRKgymk4Qm7eTLCfGd9zMKSabRTQX7YM8SVyNrWmIUMRsCe
 mo98PD3Screh+cZHkYvhegutKUg3akhcnH7mf77XVVsNpEunTCCzB8G1JAMGIjujoioE
 Rg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787913223; x=1788518023;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vpcqpEBatU6Pp4uMK5Kqylu2/te0KY20Ecuwr2WVQqU=;
 b=HntW7slD8hXJgh3a+/5zrtsbRtmKYYzET4K9ogIn0ybA/3n4IiStQd9m1iwTo9VokA
 Tuu+bndaBo/tQWuX+420Zpwf6ldXwv9y0xjf+Y7rgp0rXDyIPSoKONPkeSuq0eikLmeW
 bDxa3Nwq6mMG+huC73Csd8CKS8ulo7Lya2lSaBS5AXJLFCHzcDFo3L+XubelCJNf4jph
 FyZdWWvDBwwbkHTh/fhd8v4We6eE9t2x1QZW/VfvS8OtL1LUDPKrvqmbqGdHCTomysnk
 ZUaP3uNBR/vLLrZuoAuK/amYGur0TgmPcTCb4gRa0fTXGxTz0S1jevOBIt1u5QiPZbkW
 J6LQ==
X-Gm-Message-State: AFuF++nFlPnTb5PRWJLKdFJQI+gW4ryg4f/YaWcBBCJZvRr/+4x9Q3r0
 MF3T8lxZb6r67HcXU6FaNIQ4WJ0AkEZDhJis8K6mUzSwu6sq7TblbkEtuUB+WXgtZC79j8pYu59
 4SZ5cIDVUjsgwSIZLuBSbREBr97l/TAfNGXVriWkUwlss32fyDb1n+varClsoRXeq6GzVyIlQME
 GceDtgMQ==
X-Gm-Gg: AR+sD111rmMJKuwWTB7JNmpqHL4kc3zokWotJA+qysuRb23L1G/swEgqIPbxr26V6UU
 c0ip3JRpk0gNWrUHIdC6tzcll4IOj/GVf4qnXQXOZowZfs2ZOngwiabdhdRjIcau4rj2c153stK
 DNi5irTDOYOZadDO3idrNFhcAPLnZnugcua+GRGOGMgOYukrcwoH/w20MwFK8MIBuMbgTCMB8q+
 uYrDYJ4h+3FDFUL0XHNjZblyt8iHeCIep4YR2vI6W8vUDCmm1A8URNPO3pc/l4f+JiXQ3btz86h
 DoyQkI6+l6OoD3i4xrN8+Xyl+cizoVcnf1e+ilHoyN/7de/4p4HRetxQBTxqov03Td3u/dp16ZI
 C0mz5ijMhastHzzc1yN388OyY4QovtTealH9qoTitMiqZhHLNqFK10vHSRWEJaZLn10FCM4c389
 GOw3845f6/uabMaWjkbQ6ECHUmRXiVdcyDDmeXXVW5PVigqyUHhuppOMc8EZSBPKaIDxeF0X4FN
 So50N1RDMZW0iiYlnT0CD4dR8AgWPxCiy1birTjs1ya8WgS/gyF6ghQH2gG/a1f1OYWKRnE/AZ6
 dOJon433IUZiO9SZUUWiE/JvTmB6FmHVpx8A8BK0fKbbV10ANNw=
X-Received: by 2002:a05:6000:2dc9:b0:47f:96e6:70a with SMTP id
 ffacd0b85a97d-482f79735c9mr8914801f8f.0.1787913222973; 
 Fri, 28 Aug 2026 03:33:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac4d0asm3168021f8f.10.2026.08.28.03.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:33:42 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:33:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0
X-Gerrit-Change-Number: 1857
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1857?usp=email>
X-Gerrit-Commit: 269da702816e8ee9bce595b2444aa9997a34fc5c
In-Reply-To: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MzJkZjZjNjkyNDliNDllOWI5YTNhOTA0ODAzOTA0ZDEzNDM4N2EwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <076142799cd5680068729e9f068628e823bff482-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztu9-00080v-Ou
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add mock support for
 management messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5131400302389747681=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5131400302389747681==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4dYkc3tFOsc="; charset=UTF-8

--4dYkc3tFOsc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Add mock support for management messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add mock support=
 for management messages

Change-Id: I432df6c69249b49e9b9a3a904803904d13438=
7a0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1857
Message-Id: <20260826185248=2E17995-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38745=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M tests/unit_tests/openvpn/mock_msg=2Ec
M tests/unit_tests/openv=
pn/mock_msg=2Eh
2 files changed, 11 insertions(+), 0 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/1857/9

diff=
 --git a/tests/unit_tests/openvpn/mock_msg=2Ec b/tests/unit_tests/openvpn/m=
ock_msg=2Ec
index 8176d2a=2E=2E3e73d19 100644
--- a/tests/unit_tests/openvp=
n/mock_msg=2Ec
+++ b/tests/unit_tests/openvpn/mock_msg=2Ec
@@ -43,6 +43,7 @=
@
 
 
 char mock_msg_buf[MOCK_MSG_BUF];
+char mock_managment_buf[MOCK_MSG_B=
UF];
 
 
 void
@@ -76,6 +77,14 @@
     {
         printf("FATAL ERROR:");
 =
    }
+
+    if (flags & M_MSG_VIRT_OUT)
+    {
+        CLEAR(mock_managme=
nt_buf);
+        vsnprintf(mock_managment_buf, sizeof(mock_managment_buf),=
 format, arglist);
+        return;
+    }
+
     CLEAR(mock_msg_buf);
    =
 vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
 
diff --g=
it a/tests/unit_tests/openvpn/mock_msg=2Eh b/tests/unit_tests/openvpn/mock_=
msg=2Eh
index da96b212=2E=2E41ce48f 100644
--- a/tests/unit_tests/openvpn/m=
ock_msg=2Eh
+++ b/tests/unit_tests/openvpn/mock_msg=2Eh
@@ -36,6 +36,8 @@
 =

 extern bool fatal_error_triggered;
 extern char mock_msg_buf[MOCK_MSG_BUF=
];
+extern char mock_managment_buf[MOCK_MSG_BUF];
+
 
 msglvl_t mock_get_de=
bug_level(void);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1857?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I432df6c69249b49e9b9a3a904803904d134387a0
Gerrit-Change-Number: 1857
Gerr=
it-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--4dYkc3tFOsc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Add mock support for=
 management messages<br><br>Change-Id: I432df6c69249b49e9b9a3a904803904d134=
387a0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857<br>Message-Id: &lt;20260826185248=
=2E17995-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38745=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_t=
ests/openvpn/mock_msg=2Ec<br>M tests/unit_tests/openvpn/mock_msg=2Eh<br>2 f=
iles changed, 11 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/1857/9</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/tests/unit_tests/openvpn/mock_msg=2Ec b/tests/unit_test=
s/openvpn/mock_msg=2Ec</span><br><span>index 8176d2a=2E=2E3e73d19 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span>@@ -43,6 +43,7 @=
@</span><br><span> </span><br><span> </span><br><span> char mock_msg_buf[MO=
CK_MSG_BUF];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char mo=
ck_managment_buf[MOCK_MSG_BUF];</span><br><span> </span><br><span> </span><=
br><span> void</span><br><span>@@ -76,6 +77,14 @@</span><br><span>     {</s=
pan><br><span>         printf(&quot;FATAL ERROR:&quot;);</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; M_MSG_VIRT_OUT=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(mock_managment_buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        vsnprintf=
(mock_managment_buf, sizeof(mock_managment_buf), format, arglist);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     CLEAR(mock_msg_buf);</sp=
an><br><span>     vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arg=
list);</span><br><span> </span><br><span>diff --git a/tests/unit_tests/open=
vpn/mock_msg=2Eh b/tests/unit_tests/openvpn/mock_msg=2Eh</span><br><span>in=
dex da96b212=2E=2E41ce48f 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/mock_msg=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg=
=2Eh</span><br><span>@@ -36,6 +36,8 @@</span><br><span> </span><br><span> e=
xtern bool fatal_error_triggered;</span><br><span> extern char mock_msg_buf=
[MOCK_MSG_BUF];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exte=
rn char mock_managment_buf[MOCK_MSG_BUF];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> </span><br><span> msglvl_t mock_get=
_debug_level(void);</span><br><span> </span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=
=3Demail">change 1857</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1857?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1857 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--4dYkc3tFOsc=--


--===============5131400302389747681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5131400302389747681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5131400302389747681==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9293606C3FB
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=haXTFf32;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W87qBXmj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XECHLMO0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LyM6wpsx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0MVyKVN0Kca2gx2pF4KiQ1mtv0g0sEY+H/oRefzg8sI=; b=haXTFf329/ufzU0SD1o6nWewcC
	kc0Cgw/utiyHrnYg8t1G53XFewRn94LOmoItjHKlaLT9voc0XFlttt9dix6DdwDwpgHvBRBL7sOiV
	NFxzv6BnQTOW6tCyYxrcGPMmVI5rClJ6PTF4aleL07jXEmuTCa4WHo9VT2AE+2EjPPsw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvw0-000000004dr-24cs;
	Mon, 02 Nov 2026 17:35:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNvvy-000000004dc-3j04
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vca/4d58ytVJSLgJKxZfpluetcxy4c++HnExXReTQ1w=; b=W87qBXmjibjV5eRVxCWNSiWwYl
 RM+m+6jlboj4xTgcGRsNC+JwZm8Npu5yeqPvTdv7kfe5KI8U9H6++et0nzw/mYqV6tmEu9HdQgiQS
 O1onqvBAXsm39zWW41uPQbeZGsJ/+tDDVl1hepAvBXgpSMNwDhr7JsvR7WdsppUrfC+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vca/4d58ytVJSLgJKxZfpluetcxy4c++HnExXReTQ1w=; b=XECHLMO0dvMnbwybxwQMP/2bhq
 LXsu4CTL+o7YDfYl7pA+/JYq14ZuwRkg6dhQLdyyf75fTNViJ8HRpUUXEJNjpaTQ8/M6cSK7zFepx
 lR2x9KMiL10xE9Zoxyt0mYdILzSD0gn2WXHWCSpfIfEz8w7hPj23lR9v5VHcNQPg4QHU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvvs-0000000077C-3fCc for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:35:02 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so33622665e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 09:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793640890; x=1794245690; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vca/4d58ytVJSLgJKxZfpluetcxy4c++HnExXReTQ1w=;
 b=LyM6wpsxr/YyENH95aiJhUnzKMS2GTIedNS91c873CAMAY0/gD1P+JtV0AL6Gss2IW
 S3BYKdZZmiLvvCiijE2JBDPwqXlUNQyjncVhVXOZpy4aYxTKG1ItkHxHyPwVZZukKz0j
 LODlyqhKEoB+Oq2z5PqaDMZqXk9RAbsJMlhHU7njzqwGkPV7CkRfEdwtWjl7wiZcWoc7
 /7colIb+OKUYHpv42PXvtVainNMJjSpfqMhQhr19Y7tof0ZNUAVVFnKrDefzTFxOlhrX
 AXj/OoK5BfVVXS0dc0ey3olHmeNo6pUeeb3agmKPCZpffDFEClCVWME9Ll0Wpc4G83WA
 Oe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640890; x=1794245690;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vca/4d58ytVJSLgJKxZfpluetcxy4c++HnExXReTQ1w=;
 b=g7Qxnk8/u8xMGfYanPylQTaFV3wz0+6/AT1KcOZFXpv73JZ1NU2/n/zGiGfSs27bO1
 oQFhwOtzm0HGWLb6oiar8OM8dOSFi2fi5vXzWBrZL085T6SSuLyK0U0eVVhCjhsQNwGt
 YwWoofaj4QQ7G1mcBTwmpgVQ30X1ooCf50wRy8sTcw8oU67S6WQnJ/S2AC5RCH1dD1OC
 E72j1HkRVbYKtswDYgo6mFN/EM5CgA6sF++/tXgzvbMyVMLVDL17UNZ9oawB0EFydgQ+
 g5zhaxzuAijKoszf6ibLbOeJdqnBoNmOt7Ggvm5Tz56pBLLd84Eyq7XE6Kb7IvKozQ5a
 VmzA==
X-Gm-Message-State: AFq9FYJsgEaB+UCF6Qqt4addBngHmIRWSVd3ypT0fArCbMYEkkx9Cz1i
 0/cInlHCVT5EeCa9V8FV3KYA+GoxfvMhKVbmqm8KRlEkVcyTcyzX7SqgjPYr4R41CPfqeT8hn5s
 dPXIbPG6ynA/ZL6h69BYFFYQZeOwYoGcQQE4KN6R/wkjSUT6XV3R0J+8r7KvT5HNhm0Bb
X-Gm-Gg: AYBFou2yUr8ShDvEUwyw2c4Qw5ZrzhwXz8ku+0d6NlOiCy3gDVy2QG1+xEeSAhnlQH8
 9JsEzMDpNmd4UYudcB3HatdOniX4YUyj88onmnFtSiwk/x4pBlA9xgzDecJmmO9ZzWCczXRHdsf
 5gouCIEfv9clpXngQa4qzXRFUqtawb0T9MPox5hL+8H7nF5YQ/U0KEuSEdVchNC36etyOTlEi5x
 X0VnG+wBvzvkwSMj2iQuhz5u0W7swE27ETS3MJEizRDkwMcKzPZkZCA44nyINYDoyLoOJwb/iNc
 yPT1J2np+GY+p8AlAxae1Plf8VUiIqK9IVJG8oRZk7luKMbNS6JaYU/1cAatrG5PdYm2UJ5bEf9
 MQf19hyazdz+CRg78GGWVng4n+JqYKIGduD5X/hQjrjaiwz/yr+pFL2EQ4i6X9Vl30p4RPEPJM7
 2kF5kZ8wBowcIu6dZ3xvAcU1JAEf/+iFshTrXo+pqZZjwJUgomxfLFaLHl0rmlnPJcfNM3x5fyY
 Bmt+j1i3WOilgYsZ4G8tan18xn4kVw/KkDg06kWJ1FUGu9Pku++VLAUecd8Z2rBportkAuU6XCY
 8eXXOJ1dbpCt7M+rRjSCSp4GpowXuHqwU0yoz7kyMCg5G5XuAVuStevW27orHkI7kPwk7bXjsrV
 6rg9PCOJ7yQ8Zlf3J0pLdZcEjYz0jtBUOR7fy/07Fm0Q63ve1B5bwsCfbvbERi9LUSsDv7fQsNf
 Vt9ek2szSgnwufdMxAQdpNw1dM9gu2GJi7qeY=
X-Received: by 2002:a05:600c:19d2:b0:4a6:4d6b:a840 with SMTP id
 5b1f17b1804b1-4ac1932a12fmr242072415e9.31.1793640890204; 
 Mon, 02 Nov 2026 09:34:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ad414e298bsm132163165e9.2.2026.11.02.09.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:34:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 17:34:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 4e3fd977fc79e61635162117fde2513ebfda93d8
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e5453949b5ec03899c81eb38fda99b621e1523ec-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvvs-0000000077C-3fCc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Content-Type: multipart/mixed; boundary="===============5040707999779728429=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5040707999779728429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="53YwlxmJFDk="; charset=UTF-8

--53YwlxmJFDk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2085?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: init: check paramete=
rs for NULL before strlen() in send_cc_message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: check parameters for NULL before s=
trlen() in send_cc_message

management_callback_send_cc_message() called st=
rlen(parameters) before
its own NULL check=2E Only count parameters and the=
 separator when set,
and drop the cppcheck suppression for it=2E

Change-Id=
: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Signed-off-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085
Message-Id: =
<20261102135736=2E27372-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40437=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-s=
uppressions=2Exml
M src/openvpn/init=2Ec
2 files changed, 5 insertions(+), =
7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/85/2085/5

diff --git a/dev-tools/cppcheck-suppressions=2Exml b/de=
v-tools/cppcheck-suppressions=2Exml
index 33337cf=2E=2E926ecde 100644
--- a=
/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppcheck-suppression=
s=2Exml
@@ -198,12 +198,6 @@
     <fileName>src/openvpn/dco_freebsd=2Ec</fi=
leName>
     <symbolName>buf</symbolName>
   </suppress>
-  <!-- IGN: strle=
n(NULL) is not nice code, but seems to work -->
-  <suppress>
-    <id>null=
PointerRedundantCheck</id>
-    <fileName>src/openvpn/init=2Ec</fileName>
-=
    <symbolName>parameters</symbolName>
-  </suppress>
   <!-- FP: cppcheck=
 doesn't understand ZeroMemory -->
   <suppress>
     <id>redundantAssignme=
nt</id>
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 24cf=
532=2E=2E6c87865 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -299,7 +299,11 @@
 management_callback_send_cc_message(void *arg, c=
onst char *command, const char *parameters)
 {
     struct context *c =3D (=
struct context *)arg;
-    size_t len =3D strlen(command) + 1 + strlen(para=
meters) + 1;
+    size_t len =3D strlen(command) + 1;
+    if (parameters)
=
+    {
+        len +=3D 1 + strlen(parameters);
+    }
     if (len > PUSH=
_BUNDLE_SIZE)
     {
         return false;

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Ge=
rrit-Change-Number: 2085
Gerrit-PatchSet: 5
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--53YwlxmJFDk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2085?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">init: check parameters for NULL before strlen() in send_cc_message<br><=
br>management_callback_send_cc_message() called strlen(parameters) before<b=
r>its own NULL check=2E Only count parameters and the separator when set,<b=
r>and drop the cppcheck suppression for it=2E<br><br>Change-Id: Ib9164e1c8f=
5e02a2253bbb3b2363a4f9f31c8bdb<br>Signed-off-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085<br>M=
essage-Id: &lt;20261102135736=2E27372-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg40437=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>M src/openvpn/init=
=2Ec<br>2 files changed, 5 insertions(+), 7 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/8=
5/2085/5</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-t=
ools/cppcheck-suppressions=2Exml</span><br><span>index 33337cf=2E=2E926ecde=
 100644</span><br><span>--- a/dev-tools/cppcheck-suppressions=2Exml</span><=
br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>@@ -19=
8,12 +198,6 @@</span><br><span>     &lt;fileName&gt;src/openvpn/dco_freebsd=
=2Ec&lt;/fileName&gt;</span><br><span>     &lt;symbolName&gt;buf&lt;/symbol=
Name&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  &lt;!-- IGN: strlen(NULL) is not nice code, but s=
eems to work --&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;id&gt;nullPointerRedundantCheck&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &lt;fileName&gt;src/openvpn/init=2Ec&lt;/fileNa=
me&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;symbolN=
ame&gt;parameters&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  &lt;/suppress&gt;</span><br><span>   &lt;!-- FP: cppcheck =
doesn&#39;t understand ZeroMemory --&gt;</span><br><span>   &lt;suppress&gt=
;</span><br><span>     &lt;id&gt;redundantAssignment&lt;/id&gt;</span><br><=
span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><sp=
an>index 24cf532=2E=2E6c87865 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -299,7 +=
299,11 @@</span><br><span> management_callback_send_cc_message(void *arg, c=
onst char *command, const char *parameters)</span><br><span> {</span><br><s=
pan>     struct context *c =3D (struct context *)arg;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strlen(command) + 1 + st=
rlen(parameters) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t len =3D strlen(command) + 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (parameters)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        len +=3D 1 + strlen(parameters);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span>     if (len &gt; PUSH_B=
UNDLE_SIZE)</span><br><span>     {</span><br><span>         return false;</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2085?usp=3Demail">change 2085</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4=
f9f31c8bdb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2085 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"=
display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--53YwlxmJFDk=--


--===============5040707999779728429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5040707999779728429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5040707999779728429==--


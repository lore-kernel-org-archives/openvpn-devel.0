Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF67CC61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RMkU4UnpBAd2+PAjru7G4XBEmQwLsGXCNBOTkgMk8NQ=; b=d3CviO3mxJoBWVh0V4/J4czyyd
	ohFwimSSiVZfNj9IK2y/LUPIzH3xoIPRjzfPpNe6KBAIPhc8doPx3FnnKqk9yUg2rBq79WlQ76b9Y
	pNfzn2v84ZYmE4FcEIeT7RJ0OQkO9dGLoepPz/jJOpgWCUeh+8jH0JTjJRb77Etsm5Vo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jJd-0003m6-8e;
	Sun, 30 Aug 2026 17:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0jJb-0003ly-Vz
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0CHFQG7SFe2tIVwtz4LLao9/6ikAL9exo/pKD+ZdDNk=; b=GUFVxwvBDd1H7mXSWDeZubMn8J
 dwCARotF2HznHsdJIAeGjtT00OMVjI8ccB+GHxTReujwh/FLVjxJW07IvG9J47/OelOr0C5Bhkf2n
 z08ha4xsTc/+ZAzCSOTZ7YrJls4aybj8/FbaA/V5U3g9+v5N2vsSkl8zeQfXfszNichU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0CHFQG7SFe2tIVwtz4LLao9/6ikAL9exo/pKD+ZdDNk=; b=W
 NoiUKew7gNzZ//fRHgpbxq/wCbc+indle6epHZd/3xsy8W4rw91NbEXPcg/L2AUk3QwKhYfuPkklA
 27V5Pzg55nYWy+5f0seHVK6GynSuFUCe3cDMQXhnfOmhUS0JJRfGt/6qRUIN2VNX664Rb2kVjSxdB
 PYtnAQwKpgAQ7Uac=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0jJb-0001b8-OX for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:27:32 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48436668d20so376670f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788110845; x=1788715645; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0CHFQG7SFe2tIVwtz4LLao9/6ikAL9exo/pKD+ZdDNk=;
 b=D4Jg4x0/MKUGk8h69Ero+zKr5HKkYAGMRXqUjAb12rxu5V30ScI8YjWnvDHu+2obg4
 MWfXqzxlOUBKWlEGQ/CwwB8a0041Qd58dL9sbjyQhzl76bNR+eVNXXvwuDO/AF8yJQaJ
 wnDs6pt3IxR7HTYtZwmRje5/0NugBeQ6kAnkDpoo/+caHZORRsDkeCmxwGk6tWyBBkci
 /ZUIaiCyjgBIV01+mmb8SAXXQKAWpRUj8f71Y4ZVUKVM69XAjScLdsz8atFaJFIlEsWh
 BnV4oIJKCf9zOmccq5xjHRwE/86Lv7MnP7Te/cZJg8vtvZkaBXV4hKpoEfHwkC2wlrNw
 zfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788110845; x=1788715645;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0CHFQG7SFe2tIVwtz4LLao9/6ikAL9exo/pKD+ZdDNk=;
 b=tJSPLv7NRL2S3yQGrvQxwqNw2SERflInX22CWKabzqZaoda7X7iDDzDM60j8IZHZPt
 pGnxjhmc27AneHlURTY9RxUNlwKa3J/TcKk7dSqn7GlBx0h++SuqmB9MjLoYyTAHGjSf
 f6srTCS0MewM2TKimpd+UO2k6I4CxzEDbeMshZ+Ma7V2rTgBph09RQkJ5RkwCIFpatrc
 QI6IML2bUIuWZ1TdAI5f05EOoiPlItS88A9Ru1+/53aiT0WCQ3BQbiB2rq+CY7RRcE+o
 pC0XnRGMZmTVudgx22MZS3cH+1cNC2OJdZusCSTFfodja+MdL6LG/OApgJC4K/62EzkM
 orSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoNcgpk3ZbUOYW2Y4BJmSWerQKVCdzkpB9stC1O0rGBB2eKwjfNp4BNMZ716zu5rpbaktH5vvKT7qqD2WS@lists.sourceforge.net
X-Gm-Message-State: AFuF++n38Zh8BO29W6WgDflL3RoXofBpoSuritlmWZPWJX1iBM7Y75VK
 xyi8ECpTsZOy2pa22O8F0elnqERmc8RBBDX2kxJNOM9t/QEANfHzZ/qZTT9gn3/AmD161VMjroE
 /aqzZTIydSnERP/FO3kuvDmDG2KmiWOESQb9vF1xe2Q48Ra+S8hwR28APAXr4duG4Zx3b
X-Gm-Gg: AYBFou0dGZKlHixeR8rWgGVlJU7VOBzXbtw4xYXF1ts2/k8bDELYWEgI6VKuyiHiRPe
 fhCBM1uN1AgbNWFMiMN9JElgozS7zLcAzVwfzBUmTx1U3yBBTwjBGVI5sQp1JpaxyABpxtpB7OQ
 UnAp3uAuWlZ48Zkb1/oWv2oC/Q2wmV4hAsrnlsG1lb15iqDHNz7a4uC201ddcZexhtiapp+bHzG
 nRdKWrVDP1mcemtEbPiCwgCJLIfOjik/BQYodliGsEAdk51y2hTm694dLRj8MCQZYFM1ICI7/kN
 T7k8A3JRxNZH5avKDm+MR7/jv/G4hmUIDeJ1DsPsRLwjgscactAZJ23NZmX1f10WJPAUZjt2F66
 KCQcuLbIoy/tITLcdqDBBMRjO/E3EoPpn/e3UdvyMfStuq37D/B+5Vn2TwE45qWLR2ki1q2JOO3
 /inXdyuGtnyyIBlc6nyYof51WVk8QC0zYWtRkxldUmt9QBTk66pfk3D/TMlAt2yWKL7nE7WvsYY
 oJRaxIrbicRGUT/2v7GUD46wwFClxxhosPOZhCcZS/cpyGeZYfQOqyAReKHa8yqK/062ukBi29I
 G7LT2LAIP2V22TA8bHNibYg56AIIRE9/pH+jQSoFH+IoFLJSCKAyCCTonoSA7Q==
X-Received: by 2002:a05:6000:70f:b0:484:3328:4a5c with SMTP id
 ffacd0b85a97d-48433284c41mr15068015f8f.28.1788110845105; 
 Sun, 30 Aug 2026 10:27:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2005esm17234836f8f.24.2026.08.30.10.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:27:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:27:24 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: af6a79c6a83739ca9542e52a02a3449a2f292758
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39aad91620f73ce5f6e77dead5d9c8b3dbe8f5b7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0jJb-0001b8-OX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 ability to filter by test group
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1874793292258725207=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1874793292258725207==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i+58lilEFtw="; charset=UTF-8

--i+58lilEFtw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1777?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Add ability to =
filter by test group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

t_client=2Esh=2Ein: Add ability to filter by test group

Since we g=
enerally set this up in a way that one test
group corresponds to one server=
, it can be useful to
filter by the group=2E E=2Eg=2E this allows one to po=
tentially
parallelize test runs against different servers=2E

Change-Id: I4=
ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777
Message-Id: <202=
60827170326=2E13161-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38757=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Erc-samp=
le
M tests/t_client=2Esh=2Ein
2 files changed, 33 insertions(+), 0 deletion=
s(-)




diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-samp=
le
index 4c87436=2E=2Edefa4aa 100644
--- a/tests/t_client=2Erc-sample
+++ b=
/tests/t_client=2Erc-sample
@@ -31,6 +31,21 @@
 #
 # tests to run (list suf=
fixes for config stanzas below)
 #
+# The general idea is to use one number=
 per server, so
+# e=2Eg=2E use 1 for all tests talking to a UDP server, us=
e
+# 2 for tests talking to a TCP server, and 3 for tests
+# talking to a P=
2P server=2E
+#
+# The indivdiual tests should then be indexed by using
+# =
letters=2E
+#
+# If you set TEST_RUN_GROUP=3D<number> then t_client=2Esh
+#=
 will only run tests starting with that number=2E So
+# e=2Eg=2E setting TE=
ST_RUN_GROUP=3D1 will run 1 and 1a, but
+# not 2=2E This can be used to exc=
ercise only a specific
+# server, or to run tests against separate servers =
in
+# parallel=2E
+#
 TEST_RUN_LIST=3D"1 2 2n"
 
 #
diff --git a/tests/t_cl=
ient=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index c3a9655=2E=2E0568007 100755=

--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -82,6 +82=
,21 @@
     exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$TEST_RUN_GROUP" ]; t=
hen
+    FILTERED_LIST=3D
+    for test in $TEST_RUN_LIST; do
+        grou=
p=3D$(echo $test | sed -E 's/^([0123456789]+)=2E*/\1/')
+        if [ "$gro=
up" =3D "$TEST_RUN_GROUP" ]; then
+            FILTERED_LIST=3D"$FILTERED_L=
IST $test"
+        fi
+    done
+    if [ -z "$FILTERED_LIST" ]; then
+   =
     echo "Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests=
 defined=2E  SKIP test=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
+=
    TEST_RUN_LIST=3D$FILTERED_LIST
+fi
+
 # Ensure PREFER_KSU is in a known=
 state
 PREFER_KSU=3D"${PREFER_KSU:-0}"
 
@@ -121,6 +136,9 @@
 fi
 
 LOGDIR=
=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S)
+if [ -n "$TEST_RUN_GROUP" ]=
; then
+    LOGDIR=3D"${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/=
$LOGDIR"
 if mkdir $LOGDIR; then
     :

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Gerrit-Change=
-Number: 1777
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--i+58lilEFtw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1777?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Add ability to filter =
by test group<br><br>Since we generally set this up in a way that one test<=
br>group corresponds to one server, it can be useful to<br>filter by the gr=
oup=2E E=2Eg=2E this allows one to potentially<br>parallelize test runs aga=
inst different servers=2E<br><br>Change-Id: I4ebeb8c1f0f942da9b2e25f18f8856=
6f8372fabf<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777<br>Message-Id: &lt;20260=
827170326=2E13161-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38757=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests=
/t_client=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>2 files changed, 33 =
insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=
=2Erc-sample b/tests/t_client=2Erc-sample</span><br><span>index 4c87436=2E=
=2Edefa4aa 100644</span><br><span>--- a/tests/t_client=2Erc-sample</span><b=
r><span>+++ b/tests/t_client=2Erc-sample</span><br><span>@@ -31,6 +31,21 @@=
</span><br><span> #</span><br><span> # tests to run (list suffixes for conf=
ig stanzas below)</span><br><span> #</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# The general idea is to use one number per server, so</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# e=2Eg=2E use 1 for al=
l tests talking to a UDP server, use</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# 2 for tests talking to a TCP server, and 3 for tests</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# talking to a P2P serv=
er=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# The indivdiual tests should th=
en be indexed by using</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# letters=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# If you set TEST_RUN_=
GROUP=3D&lt;number&gt; then t_client=2Esh</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# will only run tests starting with that number=2E So=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# e=2Eg=2E setting =
TEST_RUN_GROUP=3D1 will run 1 and 1a, but</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# not 2=2E This can be used to excercise only a speci=
fic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# server, or to =
run tests against separate servers in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# parallel=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#</span><br><span> TEST_RUN_LIST=3D&quot;1 2 2n&quot;</span><br=
><span> </span><br><span> #</span><br><span>diff --git a/tests/t_client=2Es=
h=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index c3a9655=2E=2E056800=
7 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++=
 b/tests/t_client=2Esh=2Ein</span><br><span>@@ -82,6 +82,21 @@</span><br><s=
pan>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n &quo=
t;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    FILTERED_LIST=3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for test in $TEST_RUN_LIST; do</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        group=3D$(echo $test | sed -E &#39;s/^(=
[0123456789]+)=2E*/\1/&#39;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if [ &quot;$group&quot; =3D &quot;$TEST_RUN_GROUP&quot; ];=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            FI=
LTERED_LIST=3D&quot;$FILTERED_LIST $test&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if [ -z &quot;$FILTERED_LIST&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        echo &quot;Filtered TEST_RUN_LIST=
 empty (group=3D$TEST_RUN_GROUP), no tests defined=2E  SKIP test=2E&quot; &=
gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ex=
it &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    TEST_RUN_LIST=3D$FILTERED_LIST</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> # Ensure PREFER_KSU is in a known state</span><br><span> P=
REFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;</span><br><span> </span><br><span>=
@@ -121,6 +136,9 @@</span><br><span> fi</span><br><span> </span><br><span> =
LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LOGDIR=3D&quo=
t;${LOGDIR}-${TEST_RUN_GROUP}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+fi</span><br><span> LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</=
span><br><span> if mkdir $LOGDIR; then</span><br><span>     :</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1777?usp=3Demail">change 1777</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f837=
2fabf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1777 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--i+58lilEFtw=--


--===============1874793292258725207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1874793292258725207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1874793292258725207==--


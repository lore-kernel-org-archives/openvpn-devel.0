Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCE3C61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8s7xD77EuyPXznSjSdip+jSmZMkWb9YhrfvxJiRnZg=; b=FuQBQiNC/x6N574RoHWIlvYqn+
	sh5J3cTnzV5hXg2/v6I+U21QE9rxL5w+/R/xKJzR4oiqGfOhjJC8zl15Z2VH2TPCut2hcD9Atztju
	fyNr0VU/wCVH3tXnBhwgahxLJSNoLiZjkatdFIVTkZecl6yQThg+zA6pP+PZllrXEFyQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jJd-0004oO-4q;
	Sun, 30 Aug 2026 17:27:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0jJc-0004oF-3G
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ClhqtTbCgGWYnpVOnBP1X7QLU6hHvZPt8oBATBt/UYc=; b=EgA2noNv8G0vyKgPDRPoiazb6V
 ok7QbRQuMUz49OPFh65VVEEkU0+XpkPNpV6HzNjRSZbfpxm/Lj77IhskBGP71Zg8kuUFvDWcDGt+2
 U6y3Mn+JBpOFAz9luWFJWWNtZIbaRwdw4zbzsBMXQRI1IPdgFg12d3nrni8Z5PH8gaf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ClhqtTbCgGWYnpVOnBP1X7QLU6hHvZPt8oBATBt/UYc=; b=E
 +Nclr6/YVL79por+9JTILhPovLTw7NP+F5OhCXi6HHU/un4vhbL+HUx2gzqLd1D+/RybGRKhnvfHt
 rO1MV1gme/zx7L73Vqv5L5gcpE6VsnecV4WiMtuVHyTqyX1JJwNcow6pR5GE80StICjcj5p/c06xj
 W0Eu6zzZEc6nCD5w=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0jJb-0004Np-2d for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:27:32 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1618491f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788110844; x=1788715644; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ClhqtTbCgGWYnpVOnBP1X7QLU6hHvZPt8oBATBt/UYc=;
 b=Au7xuO5HAh/nwHAPqPINNtDg6UcOv0ztQ8gX+9dvOe5sShOGPv1j0g4ABl+r8Q15hd
 x5aDYGZ95rdY1xaYhib2UjGQFhUrB/14q2Cx/iLa2o4KuyN7vQ3p4x9xQwMGhUt60lXf
 DelqXqPWrXz6CHjY4rzEUno/BgOPbBkqgTf5eTltmTZ0ipbO3J6UBbfmGzMC+3IlRUTg
 IZFb6ULflHHAaH8F11aynTPJbwSfALr9V/Oorf8638eSySk8mET0STNtE4cnCqmCRRH6
 5SE++EcH4ib7WTQWqKGdYPMOH+W9p0ngxL1oUg/S6mh+eEcoih/fpYfJ63mnGOUAJ2le
 Edtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788110844; x=1788715644;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ClhqtTbCgGWYnpVOnBP1X7QLU6hHvZPt8oBATBt/UYc=;
 b=FQCEvTl7zpfsGelsZOARMRt23yZlWsprG3iZIHOcZn2nPNKj+Hbc5np2RR9YgRGX8L
 2W6DjhvYY4hvm3qA+C/QV4C6yqVhOTLGaPOw+7C7ssp2/wy7W2nL7KCIW+vaBX7oh8aZ
 4eCv0GNfUZxP2McGGHQ8EK/4oSKeR+hpcysfCJMR7ETD3yZWZStVCQNeasaxxoN3AeZj
 baYZsgxia/1MV+rI1+JiJ0E/KBsip/rqsPlffiBJ/LNEUh2r/dOH4YylsO9UbndBjGlR
 67/06LjDhC1IRJa4JCHlMAWMDpZpu0BwvGfFuWw5Fhc3senGClBooWfuxhXgpswOlVXl
 iwuA==
X-Gm-Message-State: AFuF++nLGdrErc+qChOJ5JCKIEk8p26svBH5pdSONATpCoYicAk0NmGK
 LIwi3KJbSq/0PHCvjKJo64/e5hjD5qqWfpkjTH+hkBYV/+tSIkw9Rt6pAZDIUBFZWlFDS88PIGX
 /Chp/cZRx4JyvRyjR2YiN0RBbI+7tPciTaH25Mr7uaukbaeA7gUXQEtePnqwmuWsOL80xA0mk1v
 dBtSukxA==
X-Gm-Gg: AYBFou3oYyFCB4tgqzUeqjKCqa5ymZ0eMoit3m/+CHoyv+pIQeo6tws1u7a7gelnjPG
 Mqs+vGgNHqR9xNk98jtNjlh5iTT3/wFNSVAF4bx2nOUNYpqhyfcajn7vZUwM2ILlVUMHhoz1hyC
 5n7YKHjrSYfNJ+CT1ckztCYOB+yoSdEnDSNT1hb3zsbki6q46lXjVA4euN4uB0voy/tdIxTFKHe
 BVGS3Zo1zY+3SoWSWj4ZFZBgwINVfuCgeaTFBiBgLFNp9s5lA1v7CrRDpzMSeDj73ioldhOmBHz
 z0rGRwNIk8sR6n5AJjq/ExxjJ9Sa+TN7RLcWif8gamLgdEC5IpDsuPvi/orTI0Tu2DGJc88dlW2
 kTQ1g4CtnvPW0BkWKfbC0TMZltGE8LDP5alYtuGa2RRDue9ts3iEkMvAVBBZlgIfdpT9jXVHkyy
 1qmTHeYHh3ob9QYEn32wwRAkJjLsEPhTFDy+JDjjXi8nVofMPXzJlRzT0T9OSh0ENgrbllin4t8
 7QVZz1qYYTIa07bbmLyYti8rVgDUcbUW+NcnLclSGGAmFDbGou67YcLTZ5pLyfhEmn1ybXF61X9
 5DQyxTv13P66WvUbmSA6dcDE0b9431V8lS24Kt/NliHqOhYXH90=
X-Received: by 2002:a05:6000:4693:b0:482:f5f6:d253 with SMTP id
 ffacd0b85a97d-482f79b0528mr25644961f8f.12.1788110844257; 
 Sun, 30 Aug 2026 10:27:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm17990984f8f.25.2026.08.30.10.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:27:23 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:27:22 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: af6a79c6a83739ca9542e52a02a3449a2f292758
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39aad91620f73ce5f6e77dead5d9c8b3dbe8f5b7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0jJb-0004Np-2d
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8045973150486560986=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8045973150486560986==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w+mtLikUiPg="; charset=UTF-8

--w+mtLikUiPg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: t_client=2Esh=2Ein: Add ability to filter by t=
est group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
_client=2Esh=2Ein: Add ability to filter by test group

Since we generally =
set this up in a way that one test
group corresponds to one server, it can =
be useful to
filter by the group=2E E=2Eg=2E this allows one to potentially=

parallelize test runs against different servers=2E

Change-Id: I4ebeb8c1f0=
f942da9b2e25f18f88566f8372fabf
Signed-off-by: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777
Message-Id: <202608271703=
26=2E13161-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38757=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Erc-sample
M test=
s/t_client=2Esh=2Ein
2 files changed, 33 insertions(+), 0 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/8
=

diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index=
 4c87436=2E=2Edefa4aa 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t=
_client=2Erc-sample
@@ -31,6 +31,21 @@
 #
 # tests to run (list suffixes fo=
r config stanzas below)
 #
+# The general idea is to use one number per ser=
ver, so
+# e=2Eg=2E use 1 for all tests talking to a UDP server, use
+# 2 f=
or tests talking to a TCP server, and 3 for tests
+# talking to a P2P serve=
r=2E
+#
+# The indivdiual tests should then be indexed by using
+# letters=
=2E
+#
+# If you set TEST_RUN_GROUP=3D<number> then t_client=2Esh
+# will o=
nly run tests starting with that number=2E So
+# e=2Eg=2E setting TEST_RUN_=
GROUP=3D1 will run 1 and 1a, but
+# not 2=2E This can be used to excercise =
only a specific
+# server, or to run tests against separate servers in
+# p=
arallel=2E
+#
 TEST_RUN_LIST=3D"1 2 2n"
 
 #
diff --git a/tests/t_client=2E=
sh=2Ein b/tests/t_client=2Esh=2Ein
index c3a9655=2E=2E0568007 100755
--- a/=
tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -82,6 +82,21 @@
=
     exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$TEST_RUN_GROUP" ]; then
+  =
  FILTERED_LIST=3D
+    for test in $TEST_RUN_LIST; do
+        group=3D$(e=
cho $test | sed -E 's/^([0123456789]+)=2E*/\1/')
+        if [ "$group" =3D=
 "$TEST_RUN_GROUP" ]; then
+            FILTERED_LIST=3D"$FILTERED_LIST $te=
st"
+        fi
+    done
+    if [ -z "$FILTERED_LIST" ]; then
+        ec=
ho "Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests define=
d=2E  SKIP test=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
+    TES=
T_RUN_LIST=3D$FILTERED_LIST
+fi
+
 # Ensure PREFER_KSU is in a known state
=
 PREFER_KSU=3D"${PREFER_KSU:-0}"
 
@@ -121,6 +136,9 @@
 fi
 
 LOGDIR=3Dt_cl=
ient-$(hostname)-$(date +%Y%m%d-%H%M%S)
+if [ -n "$TEST_RUN_GROUP" ]; then
=
+    LOGDIR=3D"${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR=
"
 if mkdir $LOGDIR; then
     :

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1777?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Gerrit-Change-Num=
ber: 1777
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--w+mtLikUiPg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Add =
ability to filter by test group<br><br>Since we generally set this up in a =
way that one test<br>group corresponds to one server, it can be useful to<b=
r>filter by the group=2E E=2Eg=2E this allows one to potentially<br>paralle=
lize test runs against different servers=2E<br><br>Change-Id: I4ebeb8c1f0f9=
42da9b2e25f18f88566f8372fabf<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777<br>Mes=
sage-Id: &lt;20260827170326=2E13161-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
38757=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>---<br>M tests/t_client=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>2 =
files changed, 33 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/8<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sampl=
e</span><br><span>index 4c87436=2E=2Edefa4aa 100644</span><br><span>--- a/t=
ests/t_client=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sample<=
/span><br><span>@@ -31,6 +31,21 @@</span><br><span> #</span><br><span> # te=
sts to run (list suffixes for config stanzas below)</span><br><span> #</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# The general idea is to=
 use one number per server, so</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# e=2Eg=2E use 1 for all tests talking to a UDP server, use</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# 2 for tests talking to=
 a TCP server, and 3 for tests</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# talking to a P2P server=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# The indivdiual tests should then be indexed by using</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# letters=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# If you set TEST_RUN_GROUP=3D&lt;number&gt; then t_client=2Esh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# will only run tes=
ts starting with that number=2E So</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# e=2Eg=2E setting TEST_RUN_GROUP=3D1 will run 1 and 1a, but=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# not 2=2E This can=
 be used to excercise only a specific</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# server, or to run tests against separate servers in</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# parallel=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> TEST_RUN_L=
IST=3D&quot;1 2 2n&quot;</span><br><span> </span><br><span> #</span><br><sp=
an>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><=
br><span>index c3a9655=2E=2E0568007 100755</span><br><span>--- a/tests/t_cl=
ient=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><sp=
an>@@ -82,6 +82,21 @@</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&qu=
ot;</span><br><span> fi</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    FILTERED_LIST=3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for test in $TEST_RUN_LI=
ST; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        group=
=3D$(echo $test | sed -E &#39;s/^([0123456789]+)=2E*/\1/&#39;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$group&quot; =
=3D &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            FILTERED_LIST=3D&quot;$FILTERED_LIST $test&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$FILTERED_LIST&q=
uot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 echo &quot;Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no test=
s defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    TEST_RUN_LIST=3D$FILTERED_LIST</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Ensure PREFER_KSU is =
in a known state</span><br><span> PREFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;=
</span><br><span> </span><br><span>@@ -121,6 +136,9 @@</span><br><span> fi<=
/span><br><span> </span><br><span> LOGDIR=3Dt_client-$(hostname)-$(date +%Y=
%m%d-%H%M%S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n=
 &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    LOGDIR=3D&quot;${LOGDIR}-${TEST_RUN_GROUP}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span> LOGDI=
R_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span> if mkdir $LOGDIR; then</s=
pan><br><span>     :</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">change =
1777</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1777 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--w+mtLikUiPg=--


--===============8045973150486560986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8045973150486560986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8045973150486560986==--


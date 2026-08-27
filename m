Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B1BC61DC6
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJBKpyfSqKIo/UgPvcXCxd8pKtiCTTSqR08r8j5buuc=; b=HHm5d7FwkfnZSVMYvB39kTQ9og
	HHW/sbu4QCrd0yhFhmCBm6fZ9wH+fyzVw5tSUIVyvvXqYBf1W9toa2LQVZJoaZ/KtO+GaYXb9Dyuf
	cFP9Yy/8gIgtXVXgY5D1iKvbtyz5GZeZf+a1hzXhHLzwrd1NakOW30bPXDztn3F2KTLY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzYqT-0001sc-1h;
	Thu, 27 Aug 2026 12:04:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzYqR-0001s6-FV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jCCkVYruQa+GGZj+WKA8l4X6OOfonVLKZr/tTXNXX78=; b=fhGWUfWj7yTra8AmvuKcF4UFIi
 gWDm9YTADgbyCdgV1awis+wrF8hk9m3AmsZDWkYeh7buLPlFUZ4y4cOytLPC0jmOG/FHRqwQmnC81
 2Ji3Pa/nHYvLDHOmujp08grdtaav1KU5vTlk/vGJxgBLUFvC75FccTM2wzw8wulEJFHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jCCkVYruQa+GGZj+WKA8l4X6OOfonVLKZr/tTXNXX78=; b=J
 V56Jl9O6IPglOkrdi8IIds5wwM6S5dgDTLV2pyids1mlp15f9LnlMO9EgxHa53Aej5/5nVRsK7/I/
 mhL6QVxslGTdxJmW1toiGxTUvWADRr0G8M1RmFRIZPMMPhZMRe0m+VNKzbV4gALqIPdAcWU8vIMEP
 12wOHg0EsJeeCyZw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzYpv-0002bv-Ms for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:04:04 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1225404f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787832237; x=1788437037; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jCCkVYruQa+GGZj+WKA8l4X6OOfonVLKZr/tTXNXX78=;
 b=eay0sA7icjSND69htBEm+JMou32bVfVL9KXHPGYEU3KDxeBaOA8qkYAGlbSewAN6lK
 gusVxEX1vD8FeutNybNglIDpM/c+O55RmoUSAhBFTKxi9+hjVzP3p4gS6bNO3wdfSrXA
 RjC1a4e75JBCYuoqpKEJp4XcU+pMMKNCx8RQUx3Cya9IQu9ZtjTxF4dkoSlVRXSD7IoY
 W6D/KmGZ1acqlPALusGGrdZQYTEJnPvPNFObCeOORELzg8E/FGnfKDQ0kjnQN/oIObCZ
 ZaM2GrpQGxdSRv3aP8NcWPypm4bRxQuQNYQs2j/MQMZKH8laSBVG+aLepmg6Xt2hTJku
 FvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832237; x=1788437037;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jCCkVYruQa+GGZj+WKA8l4X6OOfonVLKZr/tTXNXX78=;
 b=KQUC9PogHUvQbk03+Q3tqpjec8YlRZBm8dOdThlCwreUkaJ7BdU92/cvIuFRKZzsWG
 ccaRpz0RdehdPd+GLxJcnokQAAztvxOZBS9l5Y+N6plZr7W64tGlr97BQwFXWdoJr+KH
 494UH1E9PaUG0FdzGgveQYLqmQNtFnVYEI3urqx2Ui0ZSgRcIkvfQesOWxlEUuk5zd1N
 5Nib6awKMubZ8Nt0a0YFhsx8VYpN4W3Bsw69sEl659GrWLu4BmKpQqnQsqTYjIUl0pqT
 WhWAk1kSn3XA3yAauT2B5NDYEtA6ygsphu+dqAh93CfpKY5Uy196vMp754RwzKO3w+nf
 j0hw==
X-Gm-Message-State: AFuF++n+cO+6FZWEay5QgKjYiLgmEFVZirhlSgtvMkpZSEs+VOhiVKL4
 mrUhf44c+u0IgnMn+MnSBIwpQ00P0wk5WSh+rQMY4g9hK+MElYcFDyD5c7qXeS4hSeV84OIp4tF
 saxnLwyphl/J2to8iWEERKpmy3aOLmdwSwJTUuJi0sWIPC1hnUSJr2Ytr1YnsrPIVUla9faKJkJ
 eOJ5HSDQ==
X-Gm-Gg: AR+sD12sVEAiA2/0geVJok1dOFlQo7fRvRzLticxhpWMmmnbq/rq+dgurByQAwIkIW8
 uISYJalyrmMzmgi21bXK8uDiLGG6PydeJdzkPN61+uiMQ4UQdAvF9NnGXjfsPfOFrxUDnMXam/e
 TUV+j+xYEn21NOHaJoK3bnQT8BpJI1/w+JKQZIsDSd9yL3YszKYxHob+90bAXA5qIYozMpX3hXk
 XN854ql7WydNsnviOEEQx/ITP0WRvnH8zwhFVDOe6KzcgKlEDH7SMZ24pgCWnbxK2b4gUAoGPTm
 OCDApdKmgyKtzxJLyGw7CFPxoZ+DkSISfZuVHW78UWyOc9ohSkm6Pr53oIqDbLLYhVzFDRuH2eQ
 UNohFhJiy6A2i1BfAK0rHv6PW0rN3hhRByze2SmX0RE1TQc2NyxVgqz+rk1QLlrDrI07AQbuuGs
 IF2qz8f5oMBDqTAFSSTE2095+bQv367iWqU6xjzcdCwQYYxmF2fIyCybPj4lr56EQgby26mJQx6
 My0DMuWfR13r9LSHk9thiVW/Dv2jFfLC4f2pE3FHw3h7soi3ccgNNQx25sWw4xIxbv9xQHGt1lt
 Vpdu1UEGbKDIBcEVUYppnyklnZ/zec/QRxE15Ls+Ch/rWeVeb9/R
X-Received: by 2002:a05:600c:3acf:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499dc6ea13emr187927925e9.1.1787832236972; 
 Thu, 27 Aug 2026 05:03:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28fe2ecsm8626032f8f.37.2026.08.27.05.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:03:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 12:03:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: 05ca42a73ef9a7584ed10f2077783c4ee287ee37
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b4e426e6e2c1af80d95c50a4f6903eae4dfffdad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzYpv-0002bv-Ms
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6197252361818049686=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6197252361818049686==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mKKqPRQ5CXU="; charset=UTF-8

--mKKqPRQ5CXU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

He=
llo cron2, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail

to look at=
 the new patch set (#7)=2E


Change subject: t_client=2Esh=2Ein: Add abilit=
y to filter by test group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

t_client=2Esh=2Ein: Add ability to filter by test group

Sinc=
e we generally set this up in a way that one test
group corresponds to one =
server, it can be useful to
filter by the group=2E E=2Eg=2E this allows one=
 to potentially
parallelize test runs against different servers=2E

Change-=
Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
---
M tests/t_client=2Erc-sample
M tests/t_cl=
ient=2Esh=2Ein
2 files changed, 33 insertions(+), 0 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/7

diff =
--git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index 4c874=
36=2E=2Edefa4aa 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_clien=
t=2Erc-sample
@@ -31,6 +31,21 @@
 #
 # tests to run (list suffixes for conf=
ig stanzas below)
 #
+# The general idea is to use one number per server, s=
o
+# e=2Eg=2E use 1 for all tests talking to a UDP server, use
+# 2 for tes=
ts talking to a TCP server, and 3 for tests
+# talking to a P2P server=2E
+=
#
+# The indivdiual tests should then be indexed by using
+# letters=2E
+#
=
+# If you set TEST_RUN_GROUP=3D<number> then t_client=2Esh
+# will only run=
 tests starting with that number=2E So
+# e=2Eg=2E setting TEST_RUN_GROUP=
=3D1 will run 1 and 1a, but
+# not 2=2E This can be used to excercise only =
a specific
+# server, or to run tests against separate servers in
+# parall=
el=2E
+#
 TEST_RUN_LIST=3D"1 2 2n"
 
 #
diff --git a/tests/t_client=2Esh=2E=
in b/tests/t_client=2Esh=2Ein
index c3a9655=2E=2E0568007 100755
--- a/tests=
/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -82,6 +82,21 @@
     =
exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$TEST_RUN_GROUP" ]; then
+    FIL=
TERED_LIST=3D
+    for test in $TEST_RUN_LIST; do
+        group=3D$(echo $=
test | sed -E 's/^([0123456789]+)=2E*/\1/')
+        if [ "$group" =3D "$TE=
ST_RUN_GROUP" ]; then
+            FILTERED_LIST=3D"$FILTERED_LIST $test"
+=
        fi
+    done
+    if [ -z "$FILTERED_LIST" ]; then
+        echo "F=
iltered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests defined=2E =
 SKIP test=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
+    TEST_RUN=
_LIST=3D$FILTERED_LIST
+fi
+
 # Ensure PREFER_KSU is in a known state
 PREF=
ER_KSU=3D"${PREFER_KSU:-0}"
 
@@ -121,6 +136,9 @@
 fi
 
 LOGDIR=3Dt_client-=
$(hostname)-$(date +%Y%m%d-%H%M%S)
+if [ -n "$TEST_RUN_GROUP" ]; then
+    =
LOGDIR=3D"${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
 if=
 mkdir $LOGDIR; then
     :

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1777?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Gerrit-Change-Number: =
1777
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention:=
 flichtenheld <frank@lichtenheld=2Ecom>

--mKKqPRQ5CXU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #7</strong> to this change=2E</p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">t_client=2Esh=2Ein: Add ability to filter by test group<=
br><br>Since we generally set this up in a way that one test<br>group corre=
sponds to one server, it can be useful to<br>filter by the group=2E E=2Eg=
=2E this allows one to potentially<br>parallelize test runs against differe=
nt servers=2E<br><br>Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<b=
r>M tests/t_client=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>2 files cha=
nged, 33 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/7</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample</span><=
br><span>index 4c87436=2E=2Edefa4aa 100644</span><br><span>--- a/tests/t_cl=
ient=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sample</span><br=
><span>@@ -31,6 +31,21 @@</span><br><span> #</span><br><span> # tests to ru=
n (list suffixes for config stanzas below)</span><br><span> #</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# The general idea is to use one =
number per server, so</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# e=2Eg=2E use 1 for all tests talking to a UDP server, use</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# 2 for tests talking to a TCP se=
rver, and 3 for tests</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# talking to a P2P server=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The i=
ndivdiual tests should then be indexed by using</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# letters=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# If you set TEST_RUN_GROUP=3D&lt;number&gt; then t_client=2Esh</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# will only run tests starti=
ng with that number=2E So</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# e=2Eg=2E setting TEST_RUN_GROUP=3D1 will run 1 and 1a, but</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# not 2=2E This can be used =
to excercise only a specific</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# server, or to run tests against separate servers in</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# parallel=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> TEST_RUN_LIST=3D&qu=
ot;1 2 2n&quot;</span><br><span> </span><br><span> #</span><br><span>diff -=
-git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>=
index c3a9655=2E=2E0568007 100755</span><br><span>--- a/tests/t_client=2Esh=
=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -82=
,6 +82,21 @@</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span=
><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    FILTERED_LIST=3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for test in $TEST_RUN_LIST; do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        group=3D$(echo=
 $test | sed -E &#39;s/^([0123456789]+)=2E*/\1/&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$group&quot; =3D &quot=
;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            FILTERED_LIST=3D&quot;$FILTERED_LIST $test&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$FILTERED_LIST&quot; ];=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &=
quot;Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests defin=
ed=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    TEST_RUN_LIST=3D$FILTERED_LIST</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> # Ensure PREFER_KSU is in a kno=
wn state</span><br><span> PREFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;</span><=
br><span> </span><br><span>@@ -121,6 +136,9 @@</span><br><span> fi</span><b=
r><span> </span><br><span> LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%=
M%S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n &quot;$=
TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    LOGDIR=3D&quot;${LOGDIR}-${TEST_RUN_GROUP}&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span> LOGDIR_ABS=3D=
&quot;$PWD/$LOGDIR&quot;</span><br><span> if mkdir $LOGDIR; then</span><br>=
<span>     :</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">change 1777</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebe=
b8c1f0f942da9b2e25f18f88566f8372fabf </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1777 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--mKKqPRQ5CXU=--


--===============6197252361818049686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6197252361818049686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6197252361818049686==--


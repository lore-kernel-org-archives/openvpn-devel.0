Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA1C5DF9B
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6snJxv1wQi97Ab++UWM+5h5mi6PTie3Mtk1S1bitQg=; b=I9Jf/6kH7ZETV8SUNgr2yVGjlf
	+8AcoXKQ0KhAvPIXeIvuZVJHgLATPNGPbJsaLyuTs0A0xRtVA8BXbGtqEKjUMMl3AVO4Xy2gzJel5
	fSG5Ba5a7seAti72aJ5lc2pscspN7iXJFautHt2HLMkAmAFQ1eiotSJtF0x/1REmpGYw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWGf-0002Bn-Ro;
	Mon, 24 Aug 2026 15:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWGN-0002BQ-BN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JHlIVgEITacQ/jFParzCaiNOG9XLthmfBX11bFsIATw=; b=NOXWkpXehWUf+BSw1I3voSaQTi
 RiQyf5UumgPgrYDGnbTs3pqNPJh1t+V6BiG8PUTKaBx9hKJuGBChSF9BOfDLFKpAT+2madpvWgodO
 xismLH5nb4NFA1gx+E0cCtIdAm7zYua5QPbN9Y2tbInAHaDa/GXgVirCD+DUF4GCuuDU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JHlIVgEITacQ/jFParzCaiNOG9XLthmfBX11bFsIATw=; b=m
 EaEuElVig0S1E45YJUhcLAy3MMxWvO7+nxMklyyX/Op6gZUIl07ReJVTeHskhw17uv7c9AaEA6fBZ
 W4BamAH6wooAApdj3ty5K5ul5GvZj+vVAEerE2w8B/NAbfHfS1ju6hYvowx6xWo5Ma+SPpBQBtfon
 cVc77rG0QgV84ap8=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWGH-00070P-Bf for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:01 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c214e625259so522696066b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787584011; x=1788188811; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JHlIVgEITacQ/jFParzCaiNOG9XLthmfBX11bFsIATw=;
 b=MBgPreC3muge8+55Jn5TouUywSqnrv5Q2VnaltDgmHaxVDqZslZ39CAWdpw9/nDOhT
 g05GQ5B4tgtDkia/I+djCIyGSbEGxKT4uY773eaMEUzhjEEX1aMlkPrNjLlAhqSdiH8D
 EJg9dpLifr+PM9gjV6e3ceb2eLcUkEwylTdeQaj3DklbFyGqEZaFFb79sBnGXwMi3keG
 O7pKzgt/yBs8DqyWjU3lxqFfNv1d08Xt4/iEwvWqtZiJ26hPClnxbEygAKs9CRHCqZKu
 dOp3JkbcvlySDQVrGlvC3D5sSxlIWE1vo8D2ow4b69B6W8unPsNVjKhKoKrY8XhTIhyi
 H5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584011; x=1788188811;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JHlIVgEITacQ/jFParzCaiNOG9XLthmfBX11bFsIATw=;
 b=DSAGtkGg0PM8cCQa6BOdTJ00anNrdyw03UhmHvS5+FCXh4nX4uhkJRW4tUw2iPhHaq
 1b4AmCcpa6Hvi4+866/NbARLD/b7EFOcCOakppIQ2UEpVkA2xkZRFcWugBXmLmpFQCGL
 3jhpBfPVNEFYtYkau4FamRZDZlMsS1g8Ku9M2XdcbTmieeFkLz31PIwOkSqfQeadIXCg
 Lre5KfnMa1xqJQ8VtgBenjYLQzjWjHt+HXrazdWggHmr2cslwbDaOn2wOPFb76kggwD4
 XDmYTmtg6Sn8GjmJL6I5S3G/FS1D5Apo74svr+EIXO8xl794nnNJrlB00wU/LSARA1uP
 Nwvw==
X-Gm-Message-State: AFuF++m7Nr75/CdCwijtWW/UKNvUCEe+f6762iAsnYODDzlL1ZUtuLGg
 xyn2ITrOd0vay0tH68ZaQDqGQpScJLVMenCmVcGREa6AT2IaF8xr5rem4yBS8jyH3niS2G7ksdd
 Ns1AIaoW9cb/o/xZLKBlGxqK2puUK1/H9RyUOBAoUTu9md3DEqLZaR9+YqG2ubTgLER4Q
X-Gm-Gg: AR+sD13k+QnrdqoZ50l4OqDduUPs3uYFLK/pBYfu0iceoqy61aHyR2LhUwbFHuxg3A7
 FvUt9a/L5jUIigSMwaRyYBEHrQEI5YG5GgzbzVv4n2Ksg/n0IOr4LrjSfv9PXFkmSS+s9Kqtwv/
 +SQ3KcI18Ounz+TCN2qZi/dpdfgIOch0Gt+NFmdja0PpMC/sVXiP7wtoRhBIf4qXKhWKRGdWMUE
 HrVi7ajz+/QZx0waoc9SXiU8i/MsRPDeSUzvig3HZHAGXdbfXZoJU8hymZpi2GGT804RSXLFwnI
 PNOF0albccNJ8Ilrwqzi6NE2GsSPL4Aw8AD62EuN3XQzVDP608jWSDZaMd8ummso2+ZwSv7sHu9
 eGrEE6Ry/H0CVis4DGSypGRnCY1WECiy/xwng5hwpBptCqHslSEAJTR9oDnbLuYRkUQOyTv8AEd
 A7RtVjIIWIONVkpDcMrQw2OaapeOQaHej4OYUUL+5uP0qQ1mAJ39KlWdK6tggEVnHMDtqQVQ6Wk
 yefBFnu0Aj+LAU95btbrbBvk9TCaKpTgCHIJXpXJU8N6qEcjDl5MWf9vQgDBMeGcgdzCl8WcyuY
 vBGqzgsogw8tIe2LTjWQJjW0yVImMZVsjMM2CfWxR/d1H1rSyvc=
X-Received: by 2002:a17:906:6a27:b0:c20:2eee:97be with SMTP id
 a640c23a62f3a-c246a33ed69mr2937901066b.7.1787584010360; 
 Mon, 24 Aug 2026 08:06:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962a3c13sm1380928966b.26.2026.08.24.08.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:06:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:06:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: 5662d359dba775927f5dda0f9d223890390d83d6
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42e078166f0dfc7f33f199bde3c962f8f1a46356-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWGH-00070P-Bf
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
Content-Type: multipart/mixed; boundary="===============6337694504149784641=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6337694504149784641==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0T4rnOIMspg="; charset=UTF-8

--0T4rnOIMspg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

He=
llo cron2, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail

to look at=
 the new patch set (#4)=2E

The following approvals got outdated and were r=
emoved:
Code-Review+2 by plaisthos

The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change subje=
ct: t_client=2Esh=2Ein: Add ability to filter by test group
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Add abil=
ity to filter by test group

Since we generally set this up in a way that o=
ne test
group corresponds to one server, it can be useful to
filter by the =
group=2E E=2Eg=2E this allows one to potentially
parallelize test runs agai=
nst different servers=2E

Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372f=
abf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/=
t_client=2Erc-sample
M tests/t_client=2Esh=2Ein
2 files changed, 33 inserti=
ons(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/77/1777/4

diff --git a/tests/t_client=2Erc-sample b/tests=
/t_client=2Erc-sample
index 4c87436=2E=2Edefa4aa 100644
--- a/tests/t_clien=
t=2Erc-sample
+++ b/tests/t_client=2Erc-sample
@@ -31,6 +31,21 @@
 #
 # tes=
ts to run (list suffixes for config stanzas below)
 #
+# The general idea i=
s to use one number per server, so
+# e=2Eg=2E use 1 for all tests talking =
to a UDP server, use
+# 2 for tests talking to a TCP server, and 3 for test=
s
+# talking to a P2P server=2E
+#
+# The indivdiual tests should then be i=
ndexed by using
+# letters=2E
+#
+# If you set TEST_RUN_GROUP=3D<number> th=
en t_client=2Esh
+# will only run tests starting with that number=2E So
+# =
e=2Eg=2E setting TEST_RUN_GROUP=3D1 will run 1 and 1a, but
+# not 2=2E This=
 can be used to excercise only a specific
+# server, or to run tests agains=
t separate servers in
+# parallel=2E
+#
 TEST_RUN_LIST=3D"1 2 2n"
 
 #
diff=
 --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index b466208=
=2E=2E6e19adb 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2E=
sh=2Ein
@@ -82,6 +82,21 @@
     exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$=
TEST_RUN_GROUP" ]; then
+    FILTERED_LIST=3D
+    for test in $TEST_RUN_LI=
ST; do
+        group=3D$(echo $test | sed 's/^\([0123456789]\+\)=2E*/\1/')=

+        if [ "$group" =3D "$TEST_RUN_GROUP" ]; then
+            FILTERED=
_LIST=3D"$FILTERED_LIST $test"
+        fi
+    done
+    if [ -z "$FILTERE=
D_LIST" ]; then
+        echo "Filtered TEST_RUN_LIST empty (group=3D$TEST_=
RUN_GROUP), no tests defined=2E  SKIP test=2E" >&2
+        exit "${TCLIENT=
_SKIP_RC}"
+    fi
+    TEST_RUN_LIST=3D$FILTERED_LIST
+fi
+
 # Ensure PREF=
ER_KSU is in a known state
 PREFER_KSU=3D"${PREFER_KSU:-0}"
 
@@ -121,6 +13=
6,9 @@
 fi
 
 LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S)
+if [ -n=
 "$TEST_RUN_GROUP" ]; then
+    LOGDIR=3D"${LOGDIR}-${TEST_RUN_GROUP}"
+fi
=
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
 if mkdir $LOGDIR; then
     :

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566=
f8372fabf
Gerrit-Change-Number: 1777
Gerrit-PatchSet: 4
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emu=
c=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--0T4rnOIMspg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+=
2 by plaisthos</p><p>The change is no longer submittable: Code-Review and c=
hecks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">t_client=2Es=
h=2Ein: Add ability to filter by test group<br><br>Since we generally set t=
his up in a way that one test<br>group corresponds to one server, it can be=
 useful to<br>filter by the group=2E E=2Eg=2E this allows one to potentiall=
y<br>parallelize test runs against different servers=2E<br><br>Change-Id: I=
4ebeb8c1f0f942da9b2e25f18f88566f8372fabf<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Erc-sample<br=
>M tests/t_client=2Esh=2Ein<br>2 files changed, 33 insertions(+), 0 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/77/1777/4</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Erc-s=
ample b/tests/t_client=2Erc-sample</span><br><span>index 4c87436=2E=2Edefa4=
aa 100644</span><br><span>--- a/tests/t_client=2Erc-sample</span><br><span>=
+++ b/tests/t_client=2Erc-sample</span><br><span>@@ -31,6 +31,21 @@</span><=
br><span> #</span><br><span> # tests to run (list suffixes for config stanz=
as below)</span><br><span> #</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# The general idea is to use one number per server, so</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# e=2Eg=2E use 1 for all tests =
talking to a UDP server, use</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# 2 for tests talking to a TCP server, and 3 for tests</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# talking to a P2P server=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# The indivdiual tests should then be in=
dexed by using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# let=
ters=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# If you set TEST_RUN_GROUP=3D=
&lt;number&gt; then t_client=2Esh</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# will only run tests starting with that number=2E So</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# e=2Eg=2E setting TEST_RUN=
_GROUP=3D1 will run 1 and 1a, but</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# not 2=2E This can be used to excercise only a specific</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# server, or to run test=
s against separate servers in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# parallel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span> TEST_RUN_LIST=3D&quot;1 2 2n&quot;</span><br><span> =
</span><br><span> #</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b=
/tests/t_client=2Esh=2Ein</span><br><span>index b466208=2E=2E6e19adb 100755=
</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests=
/t_client=2Esh=2Ein</span><br><span>@@ -82,6 +82,21 @@</span><br><span>    =
 exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n &quot;$TEST_=
RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    FILTERED_LIST=3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for test in $TEST_RUN_LIST; do</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        group=3D$(echo $test | sed &#39;s/^\([012345678=
9]\+\)=2E*/\1/&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if [ &quot;$group&quot; =3D &quot;$TEST_RUN_GROUP&quot; ]; then</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            FILTERED_L=
IST=3D&quot;$FILTERED_LIST $test&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if [ -z &quot;$FILTERED_LIST&quot; ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        echo &quot;Filtered TEST_RUN_LIST empty (=
group=3D$TEST_RUN_GROUP), no tests defined=2E  SKIP test=2E&quot; &gt;&amp;=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit &quot=
;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    TES=
T_RUN_LIST=3D$FILTERED_LIST</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> # Ensure PREFER_KSU is in a known state</span><br><span> PREFER_KS=
U=3D&quot;${PREFER_KSU:-0}&quot;</span><br><span> </span><br><span>@@ -121,=
6 +136,9 @@</span><br><span> fi</span><br><span> </span><br><span> LOGDIR=
=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    LOGDIR=3D&quot;${LOG=
DIR}-${TEST_RUN_GROUP}&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+fi</span><br><span> LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><b=
r><span> if mkdir $LOGDIR; then</span><br><span>     :</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1777?usp=3Demail">change 1777</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f83=
72fabf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1777 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></=
html>
--0T4rnOIMspg=--


--===============6337694504149784641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6337694504149784641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6337694504149784641==--


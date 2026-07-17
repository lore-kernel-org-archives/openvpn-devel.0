Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E160C4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RobBaiQh7aICdX1aLAoYVdXAibW6F1Jdgi4qGm+b6o8=; b=PFP22LoJngW5IgWP0/j5c1cqm8
	1cUf+JIEeuYU2hD84lXSgDJnKlFNTmpXV0kPXprfIVTiKNm1t0vnjiAloM3m2Zr0oxpGfC5tUZiOD
	c2D/z50vdF9K+5LA5n/TnDuFP56irhrNTOPV8r2nwAhzGoQwHX6EDoEJCoWjhmsu8J0M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkhUc-0001WY-Vh;
	Fri, 17 Jul 2026 12:16:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkhUa-0001WI-RR
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w1YDvuaaZSR2hPKkyoWjS5P3zxsoPRJlfIxRFyDpDRg=; b=gK5cgLdbsLy7gmBZieMBythhTi
 4BID3+IRAI3lk9lD3dMKVzjKkVX1kZs8ICJFRV63GVErjN6iXtk2beD5cslhTqXRVyx9dAcVw8M3N
 q5pyouSNHbl+VP6tjUqiXJrRFh9J1xwoif7cFHw7+koTbsg8ccDiHUiVu5O3lDZQMnoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w1YDvuaaZSR2hPKkyoWjS5P3zxsoPRJlfIxRFyDpDRg=; b=N
 bV3cK1pxVfPLShNTfWIfEqJv3rIllBE7hve8wK+Fu0jfNymJ0g9kHpwYcAhElEQXPW5fHUSSopdtG
 PC7iOT+69CjcGTK4hfZf+EyxJdaRfE2f3vmFre+8sALaU9yTR5TPqACETaYyu2R1kbNF2oun9BHbY
 n1Y+dICzGOBzA0Es=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkhUZ-0007No-U7 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:37 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so3203245e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784290584; x=1784895384; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w1YDvuaaZSR2hPKkyoWjS5P3zxsoPRJlfIxRFyDpDRg=;
 b=XdzY0eqiX7QNr6IOHM2k7VA8FXx3z/5UjJfsW11lF+1fbdvBDzne5UBohIzTVeExkj
 BAxmNMEQ9hbbi4i8I4Fh6DeXXisMcMn2uQOLnA+dm6jzLdP6+nfIGguciGZDEnJskKOF
 2sDjnT3L+8WzMndYP3Rm4IlfO/4Fng1/ws4l0uT5vH21yJAiv1RnG8d5gfQohLzU2X3X
 B+xJAGj5TUI8hJbCWNSjPbAXZYAT1a1BJ2grEnH8fNZqWmuwcPWXo8/r+NnbWJvFqcM6
 ULLBTRVg03jVrOYNj6FHY6LERSw70kgWn+yhjyi/5GeFb4CfEwqhPNi/5+EZVH0kjHQG
 +bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290584; x=1784895384;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w1YDvuaaZSR2hPKkyoWjS5P3zxsoPRJlfIxRFyDpDRg=;
 b=LMknxz3YIuJfZw1r7ZxRnzzYyjL3r78y/1fK8GsOdkmvulGvuajEdc5SXwbXy3m/LM
 nWlfzq1EgjFQrbrDhPIWcDO01BTdjoHOqB+ZToAU3u5lsb5n/b1dTkjxGB+dlrRopdMa
 c8bFkOrUgZA+TBjB2M4mCPenBT7Usqj0YuMND8tY0DDI3DhPJwGSihsqaqwAIr4nK8pR
 6rEFrh12GoU8tbSyO8Dwnmi4RQYXp1ZnooflloSwgdAxGQuU4EsEWMUNtuKIXvm4YZEv
 x+KfeZSauLo/7yjpn0lDlFgMBlq8ULEdgvRJXHYgkkFpFeioSFx3xY2DtK4LLSIdRKQY
 XCoQ==
X-Gm-Message-State: AOJu0YzyuzrEbZIfKEOOJ3ixFRnTKYSyiuTbwh9J70MSBUpkGZQQup6+
 si7AGdjtrWLrIlthaAdbUZdTmgvWyzQhQYfRacKeuQcIsONDJ1e0ARV1cy4/6AOKudafESw3ABE
 BOHyHQoKpgx2ahSV2qtI1UpNdDXeICbxZ3IXpKb6VGpd03cs8nKG3dy2JW+zlvE942XONoqn2MP
 /bMW+w7Q==
X-Gm-Gg: AfdE7ckKWfoD8DNlkewDdZzFrFgR0QVkqtG6m7qoh8A/1JAjlZ0jo0fGEkZlCAKcjbV
 rSgmj31rs0x19QxsTgI7KPQ6D49IvJhws33uvLO49UqMpsoE36vhrKWs/ctVpceckVZty0dEuvI
 eCMRWAka+u36eV4mVKRJZw5JEH/kr+NI8zf1+Nsilz6cHwNVpTrZVm++uIpTykuxFH99O4tYIou
 u/Yo/ldt6L5p0v/wkF/x6iB0v3eUZD1nG7LRCaU9Jn+btyjAmVve3kozf8gy7lE2TMDUZyaBQkU
 7k64NPJZJN3NGOz331UfYWeqpCI3gZT3SztYURROJtUYUisHmTJl0nflcdNtHHJkSRLUjZJqtQf
 3gz/xJIfO97vYEXohKOwCruCT7mbm98R+0FI1vKYisWoipjN3AfxfGrRhNGlH7wBkqh4PRNhHGt
 pAvbBI2BFwXGdOmR1n/oWGpGG6hplYPdm9HPjglczCggO7vDfAzk/uWRDBXkLPjo1pYoMchaJe/
 1aXskWqayQ2C5X/RDvTOSN4jJYi2wbdcDSbuh0gHkmCqmSu3PS4bZmqm3LsEHBVq1r5uxs5BGw+
 KZo=
X-Received: by 2002:a05:600c:350f:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4954a3db7e8mr26738735e9.11.1784290583855; 
 Fri, 17 Jul 2026 05:16:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954966a033sm37203775e9.0.2026.07.17.05.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:16:23 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 12:16:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: e9d2e11cdad68e465d53349af153a02609ae55f4
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e960e693140311a2ead0bf2efa83cd71353b47a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkhUZ-0007No-U7
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
Content-Type: multipart/mixed; boundary="===============4514658837804030541=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4514658837804030541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2VtT74/AcJI="; charset=UTF-8

--2VtT74/AcJI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

He=
llo cron2, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail

to look at=
 the new patch set (#2)=2E

The following approvals got outdated and were r=
emoved:
Code-Review-1 by cron2


Change subject: t_client=2Esh=2Ein: Add ab=
ility to filter by test group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Add ability to filter by test group

S=
ince we generally set this up in a way that one test
group corresponds to o=
ne server, it can be useful to
filter by the group=2E E=2Eg=2E this allows =
one to potentially
parallelize test runs against different servers=2E

Chan=
ge-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
---
M tests/t_client=2Erc-sample
M tests/t=
_client=2Esh=2Ein
2 files changed, 33 insertions(+), 0 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/2

di=
ff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index 00=
3dec4=2E=2E5534bf8 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_cl=
ient=2Erc-sample
@@ -27,6 +27,21 @@
 #
 # tests to run (list suffixes for c=
onfig stanzas below)
 #
+# The general idea is to use one number per server=
, so
+# e=2Eg=2E use 1 for all tests talking to a UDP server, use
+# 2 for =
tests talking to a TCP server, and 3 for tests
+# talking to a P2P server=
=2E
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
+# server to run tests against separate servers in
+# paral=
lel=2E
+#
 TEST_RUN_LIST=3D"1 2 2n"
 
 #
diff --git a/tests/t_client=2Esh=
=2Ein b/tests/t_client=2Esh=2Ein
index 6c9c8ae=2E=2E52f2a0d 100755
--- a/te=
sts/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -83,6 +83,21 @@
  =
   exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$TEST_RUN_GROUP" ]; then
+    =
FILTERED_LIST=3D
+    for test in $TEST_RUN_LIST; do
+        group=3D`echo=
 $test | sed 's/^\([0123456789]\+\)=2E*/\1/'`
+        if [ "$group" =3D "$=
TEST_RUN_GROUP" ]; then
+            FILTERED_LIST=3D"$FILTERED_LIST $test"=

+        fi;
+    done
+    if [ -z "$FILTERED_LIST" ]; then
+        echo=
 "Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests defined=
=2E  SKIP test=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
+    TEST=
_RUN_LIST=3D$FILTERED_LIST
+fi
+
 # Ensure PREFER_KSU is in a known state
 =
PREFER_KSU=3D"${PREFER_KSU:-0}"
 
@@ -126,6 +141,9 @@
 fi
 
 LOGDIR=3Dt_cli=
ent-`hostname`-`date +%Y%m%d-%H%M%S`
+if [ -n "$TEST_RUN_GROUP" ]; then
+  =
  LOGDIR=3D"${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
 =
if mkdir $LOGDIR
 then :

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1777?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Gerrit-Change-Number: 177=
7
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: fli=
chtenheld <frank@lichtenheld=2Ecom>

--2VtT74/AcJI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-=
1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">t_client=2Esh=2Ein: Add ability to filter by te=
st group<br><br>Since we generally set this up in a way that one test<br>gr=
oup corresponds to one server, it can be useful to<br>filter by the group=
=2E E=2Eg=2E this allows one to potentially<br>parallelize test runs agains=
t different servers=2E<br><br>Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8=
372fabf<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>---<br>M tests/t_client=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>2 =
files changed, 33 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sampl=
e</span><br><span>index 003dec4=2E=2E5534bf8 100644</span><br><span>--- a/t=
ests/t_client=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sample<=
/span><br><span>@@ -27,6 +27,21 @@</span><br><span> #</span><br><span> # te=
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
20, 100%, 40%);">+# server to run tests against separate servers in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# parallel=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> TEST_RUN_LIST=
=3D&quot;1 2 2n&quot;</span><br><span> </span><br><span> #</span><br><span>=
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br>=
<span>index 6c9c8ae=2E=2E52f2a0d 100755</span><br><span>--- a/tests/t_clien=
t=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>=
@@ -83,6 +83,21 @@</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;=
</span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    FILTERED_LIST=3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for test in $TEST_RUN_LIST;=
 do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        group=3D=
`echo $test | sed &#39;s/^\([0123456789]\+\)=2E*/\1/&#39;`</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$group&quot; =3D =
&quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            FILTERED_LIST=3D&quot;$FILTERED_LIST $test&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$FILTERED_LIST&quot=
; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ec=
ho &quot;Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests d=
efined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    TEST_RUN_LIST=3D$FILTERED_LIST</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Ensure PREFER_KSU is =
in a known state</span><br><span> PREFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;=
</span><br><span> </span><br><span>@@ -126,6 +141,9 @@</span><br><span> fi<=
/span><br><span> </span><br><span> LOGDIR=3Dt_client-`hostname`-`date +%Y%m=
%d-%H%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n &=
quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    LOGDIR=3D&quot;${LOGDIR}-${TEST_RUN_GROUP}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span> LOGDIR_=
ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span> if mkdir $LOGDIR</span><br>=
<span> then :</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">change 1777</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
ebeb8c1f0f942da9b2e25f18f88566f8372fabf </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1777 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--2VtT74/AcJI=--


--===============4514658837804030541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4514658837804030541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4514658837804030541==--


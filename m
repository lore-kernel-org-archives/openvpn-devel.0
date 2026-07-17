Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18911C4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=254ue86TF1lyWeX/io9ZIbZWv5Pl129yHXzPmHe8bOE=; b=gErkh4HzTk6Ke/YV7dPhgYbqv8
	7nUQ30NKEthy5HWxJsurETPtZPkYanDAhPJB+u1TUsYbHcAa7DdPp6lsXF3vGbDzUeeVHhq9K6w1q
	bO6/bNgOwwLf8JAMTw1bVPkUEUC3tiHdoBuDdGlEZCSmYer3BHLGtQvHm6jdIJ9xBD5w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkhXC-0001m1-N5;
	Fri, 17 Jul 2026 12:19:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkhXB-0001ln-Ai
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uPAApck7rrJ06tiN36WE5279qAx/gZiu+CCoK+LZXUY=; b=NTY9WrG7TgZcshFtkmgv6zZKPI
 5ds3WvlUhSvOpZBVEJWRS+KVQxKyjLuva6xkJJd5VNqzu1oG6+OF2MS65uJB2HuoD6ZbWNlz22T+/
 hLy0Xm+uRfip0lfDXR6tIZMtdmTjPk9UFfupW448Fro7edpBC6a6vT5RLP/wlKrI6eoM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uPAApck7rrJ06tiN36WE5279qAx/gZiu+CCoK+LZXUY=; b=U
 9Ef/kbAJlfXwuM/Fi/CLyMMyUNUJ8LvSy6MlGuW5fg2Rq99p1a58pce6BlhpDTY/omnE2bJ0+Gn2u
 RH36z/uMZM2EZQeAz8YMukPc1pOOTOqogh2JMkiYba+2Jpn/0rAJX91dIq94hQiDwMDoH6IqltIfw
 o4lzIhwRamCXLLQE=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkhXA-0007ZC-AL for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:19:18 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so5571843f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784290745; x=1784895545; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uPAApck7rrJ06tiN36WE5279qAx/gZiu+CCoK+LZXUY=;
 b=E98ax7dY/h9ucM4p9Fw+LlNuZ2Z4lqkJOyh7kTREACBqjIwuGakI2O61XupttTEYim
 opiy6Z0ArN04PSwrllZXoeZvng8fmPhzltVyysu9SecK/ZvO5cyKhgY74y8azAMgReFm
 Qvo0hgljmLRgEili4iP6F4qUlDmHdBNaIsV8kwu5Hq+VfGVgYumH6pWtZwXtdd/MiaLh
 2A/+ucj80OiOnvCzblXnfqRvKRngCHKfJ+JYLFOYEyZd20XQNaK16+2HAUWeZz++tp+5
 BNxEs9T7URT8Q7whN+2VRXMMaQ87+tN39RR9BN9czoT4yhz2rcpp1RM0J4brz0RRubtB
 s34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290745; x=1784895545;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uPAApck7rrJ06tiN36WE5279qAx/gZiu+CCoK+LZXUY=;
 b=lB9lZB/2+HR6+K4oc6vl6TPyBy6/WTClcH0QLvbbYRKd6qLEHjWE9UvCDIZ03Hi9n/
 +WNdEPcN8eaPn/TzSpZllZkzD3RjOl7t8IOM1oGEaovWG524cDoCW9NuZfziUZW/nN6H
 jU2kjMEB4I3l7baxqwFMfvGvo/cHk11vzAkaUS91qY5wUCD3wh3Bfunr3dAG+uwdf4eT
 bBIIu3JZ/8/yEa4XWuAdf5pbC6PuqVHJ9mx0/eyFSMomZ+skSW183CIZjS3fXsCyFyc1
 vIEcccVXSF1Zuh3oGwHIKtqBaAn0IKkzhzIesR1/JE8AZq5rMA3QZsIK2Z5oanssdqYD
 VHig==
X-Gm-Message-State: AOJu0YzRckqNcjfFwsCupwOcWgxcGyDdeafvpdNou6ufJ3bBpqduqw2Q
 Ycl3xeyUr3k/eNVqTPgr0/rKKyNuchTN6q54hvKQdKqeYkBCZoWFnsN5gXrM7qQg6SHzHBghREJ
 i4wJ3K/b3JLjf7zsRBbzoAa7NJjx3R235P4oTS60on8uTAGDjvKVUvPIGIpkzbFTeNr+6GIrhWN
 BDHwD9UA==
X-Gm-Gg: AfdE7clHe/Tfx7lF4sBOe+cyMR0WAvQwh5J+X1pQscfQJJn2a2lffxCWdXa0RCe1Osk
 jsUwo+dI08PlWEVBXUwWa2yKejl/m6NFILoVUZOAY+KgKGZ49fn0oNrn3MMeoSbQBE7PMQtdJzz
 g+dm/j2VcYiV56xkRDCkeMIWgDiXiESGGUBdr/jNTIsxVMR9amiq3H6JFF7lrINaKE3BchJuGSN
 07mC7W38tAkbX1gL9TfS+dKgzxU0JE5LfKTTQQC4HTK0Dx+3EKzu8hQrvxyCuwH6pV7V6bZ7GHU
 u6m6hT6q+PgDodNF6v4NUZFJOvE7J2bAwj/wsmqbNSQolMUz8h+LijXdg+4G4zrGZsB6O3eOvkA
 g1tQix3Ei0sLDbI8gTIhJDTznrCTe+iuk9suaoYZb4ZQWKDKJ6IEUANfxeeBQFnWIU9jFPEK0jX
 LGtBiKqwnJMCEhq/swtskPRdOi9nj+iFIyT37ZYidVl1XmDjtAHKcAw/dT54Jx92WheH+sKZSas
 Ecd8852hQrfAZQrK4/tj7O7ks0SynhumDtH0crw0maqzQDTmy+rtoLXN/ARltQAT27J
X-Received: by 2002:a05:6000:2303:b0:47f:5291:fae with SMTP id
 ffacd0b85a97d-47f6233bec9mr3300893f8f.51.1784290744424; 
 Fri, 17 Jul 2026 05:19:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm3824332f8f.11.2026.07.17.05.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:19:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 12:19:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: d6e876f91d5e85158a4e08b6018283753cf20f12
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c262fac5b657075c62a69aae2547a8ecbf34aeb4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkhXA-0007ZC-AL
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
Content-Type: multipart/mixed; boundary="===============2806578121983039837=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2806578121983039837==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PuQh8PmGMhg="; charset=UTF-8

--PuQh8PmGMhg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

He=
llo cron2, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail

to look at=
 the new patch set (#3)=2E


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
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/3

diff =
--git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index 003de=
c4=2E=2Ed07c376 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_clien=
t=2Erc-sample
@@ -27,6 +27,21 @@
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
index 6c9c8ae=2E=2E52f2a0d 100755
--- a/tests=
/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -83,6 +83,21 @@
     =
exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$TEST_RUN_GROUP" ]; then
+    FIL=
TERED_LIST=3D
+    for test in $TEST_RUN_LIST; do
+        group=3D`echo $t=
est | sed 's/^\([0123456789]\+\)=2E*/\1/'`
+        if [ "$group" =3D "$TES=
T_RUN_GROUP" ]; then
+            FILTERED_LIST=3D"$FILTERED_LIST $test"
+ =
       fi;
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
 
@@ -126,6 +141,9 @@
 fi
 
 LOGDIR=3Dt_client-=
`hostname`-`date +%Y%m%d-%H%M%S`
+if [ -n "$TEST_RUN_GROUP" ]; then
+    LO=
GDIR=3D"${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
 if m=
kdir $LOGDIR
 then :

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1777?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Gerrit-Change-Number: 1777
Ge=
rrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>

--PuQh8PmGMhg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D=
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
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/1777/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample</span><=
br><span>index 003dec4=2E=2Ed07c376 100644</span><br><span>--- a/tests/t_cl=
ient=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sample</span><br=
><span>@@ -27,6 +27,21 @@</span><br><span> #</span><br><span> # tests to ru=
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
index 6c9c8ae=2E=2E52f2a0d 100755</span><br><span>--- a/tests/t_client=2Esh=
=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -83=
,6 +83,21 @@</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span=
><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    FILTERED_LIST=3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for test in $TEST_RUN_LIST; do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        group=3D`echo =
$test | sed &#39;s/^\([0123456789]\+\)=2E*/\1/&#39;`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$group&quot; =3D &quot=
;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            FILTERED_LIST=3D&quot;$FILTERED_LIST $test&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
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
br><span> </span><br><span>@@ -126,6 +141,9 @@</span><br><span> fi</span><b=
r><span> </span><br><span> LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%=
S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n &quot;$TE=
ST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    LOGDIR=3D&quot;${LOGDIR}-${TEST_RUN_GROUP}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span> LOGDIR_ABS=3D&q=
uot;$PWD/$LOGDIR&quot;</span><br><span> if mkdir $LOGDIR</span><br><span> t=
hen :</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">change 1777</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebeb8c1f0f=
942da9b2e25f18f88566f8372fabf </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </=
div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--PuQh8PmGMhg=--


--===============2806578121983039837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2806578121983039837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2806578121983039837==--


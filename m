Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18249C44507
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=1V27U63TdpeXe4ky0OX5HDTzyB1InYXyjApbHj66ZWA=; b=EoHv0dtkVwDljJ
	WrkCLK+1QLI/Amg2BRLPza3vB3c34EnanvWd779OS0RId/rqfpmrFhQ2wAQICsu2es1gKmMCYUWlL
	+4frjRzxpwAncBn9oAR1OUl1ZfA1mMuOKrnw77Ma6a2Udo0gRiyxJUSQY8QS8QW4BmWXey2tcZgTb
	5DY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjFgn-0001Cr-7L;
	Mon, 13 Jul 2026 12:23:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjFgl-0001Ck-S1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 12:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QA+Bk/Gh69YrDyK+aAfVAl4E9ZPHILyMXlzgDgXO+XY=; b=LTyNzwV9JS2EeL3wzh/MJzLeI1
 vtYaOtH3enTBRnzU89TOsMY+3ZKnXUccb/L2J098QLIy4aSEnINmnQu5sBkkjYqNcm5kXi6CgQdL6
 05cxE8Q5ZXe9x2j032RFQHUYCvYc3b5fuNelCWdu4uz+avYOFqWo9/OJF+K50ZmlPLZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QA+Bk/Gh69YrDyK+aAfVAl4E9ZPHILyMXlzgDgXO+XY=; b=c
 OUT8C9t2uXiF5jLF18EdkYQnKsC3ZE7J58YAtABXc9cJDD0hWRRGTlvw1OZ7VA0+cxUNGeWJgSxeE
 GlT/oQDAUuVBGpVezksw9thC854PQOVV5AajJxmNqfD1X/bTkYA8D022ozrhlOuMUwVcrNtjfskPc
 A/Y6SyQwARuMhaA0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjFgl-0001nG-2U for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 12:23:12 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47d70879764so1931359f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783945384; x=1784550184; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QA+Bk/Gh69YrDyK+aAfVAl4E9ZPHILyMXlzgDgXO+XY=;
 b=IM+UMpdS1v7llVJ7Qrpq/OGc9mqY7h4KkdKxHoj6ddbNmp94lI/APiUslJLK0JO/VU
 DTnKH6EPauBYNJfwuBsCn+OGOFRT2e7vQJfUwCy4djqtFrD14njSS8QIUScvnJTujNAS
 VDWyJTFC1cbeUX9cc0bRxRAyxjOxvgTN9f0YZL3FOQ6uVnwlUMX6YL3crpfwqoSUMxHl
 cFfqbOZa+kqLAFMadFJ3+RMj1FTft40AtzO81FFWW4XTaMViJck8a/pCfLiYhYVGUKhQ
 A1IvfWnl9IlqUK6xzGewyvS6MfVjo+0pEP7Or4fGwpYpD+liYv0pxOCZP+1hSoVb5H15
 Txsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783945384; x=1784550184;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QA+Bk/Gh69YrDyK+aAfVAl4E9ZPHILyMXlzgDgXO+XY=;
 b=HMSs+UhGBCn9tsqoBu7PcScou3p2VkvrwjyaW7Da4YtEI4tjWL8kdPUfOVgDtHyr/i
 Mi+59jluERK0pImTAtXd6rTljxwrJQFEchgEIbZNYxNoi7Zwhvx2VL8qnTYua4iK3zdy
 5+oPX2ZnoYDx2Vz6vFMJS2s5GCL3iqhe3xeGGfPXkA7xSVFuBfl7Nlf5VsVnvwCEBo7X
 sCQeIloWV5I6UEHXMO4oCD/RNxnYj8iOZopWScD9o7RLttArDRdGvfKntA+PGyJRhduH
 xDbEobFyh4f731eqE/CMkUIgV151ds2GIE524Qc/3DAnubufKI4QzrzGBS5UCSP+awAp
 GNHA==
X-Gm-Message-State: AOJu0Yw/1VHXxTO9bJDMDfKCCWFADzojk9KZ9Bj1Z81ecCMUYzDd2Zw+
 A5UJmJX3Ae3qlEKZfsI1Fbo5acgMaJ1KyN4TOC8woN9pAgZNullzk2Gm8PgfrSxI4y562MH0gHH
 qb2A+hIs++Y8MMnd30wou8Atg/Le2dBx5OwksiOujf7Sf6PMoFZCM+4NLP7UfBGFxiBDVgfC3/s
 lxZ7He6w==
X-Gm-Gg: AfdE7cn9e4Wcw1LMMM5YD0j/ENq15fdmT91LxRrDHM8mNNX8f7Mt+1Fh8er+iT7tJk3
 ckXAKehkI4kYgDYRkeTnoJ1opSqDJ8LUOIw7FngosioaHscjIq91hXJBIFrKtiWoDdtLEAy7F3p
 E7jhmHSxszEcAA2O4iT3SO77r7X8ueXwjIUAFOQd6LGRpqlNX9DEBW0KhcEjDwpKhSnhzGdb0Gy
 3o4EqJH5B4zjjXis/1mqxjGUxYg4uqfP/CpxgxHHmVvFyw84U5aCrBF4h6c9gH2rADbh/nCD7pT
 6ucgMb9cqvT14sCxlzGD3sbfr7fMzTlFzb8ZzLAc5n+4ewz1oM0gdKClWEcIQgIkPkvNJk22lH0
 paeyE7l66nClvkMQ2aT7D2paX/lIkOpuKyU/J6bZd+bLdMfjGuaTkr8iO2Gy/rRDvRfhF97CbTb
 45gZeFgoh4cjsAuDhTCSGM2WqJMeK3H2PlAuDvw/dn09Way45L31uDClGXJJFDHvSiSi2MA8Qyb
 kjEOhScKpGGBKAvZnu/mTxkrUKuUFGa+3DOSte60HEDdJ+2eDn265mI5zdk4Uxeyuh/aJthQkdg
 3KHIAWjKmfcY/A==
X-Received: by 2002:a05:6000:2611:b0:46f:7d90:8125 with SMTP id
 ffacd0b85a97d-47f2dcb593emr9919041f8f.15.1783945384243; 
 Mon, 13 Jul 2026 05:23:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm85612374f8f.25.2026.07.13.05.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:23:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 12:23:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: 2c747537d1f04bced9b309cc9509e25ed1c4f30a
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a850e0d69507aab83b6d161539edef6a6b6fa85c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjFgl-0001nG-2U
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1406339520475542534=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1406339520475542534==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7eGylLQJ+Zo="; charset=UTF-8

--7eGylLQJ+Zo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1777?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Add ability to filter by test group
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein:=
 Add ability to filter by test group

Since we generally set this up in a w=
ay that one test
group corresponds to one server, it can be useful to
filte=
r by the group=2E E=2Eg=2E this allows one to potentially
parallelize test =
runs against different servers=2E

Change-Id: I4ebeb8c1f0f942da9b2e25f18f88=
566f8372fabf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---=

M tests/t_client=2Esh=2Ein
1 file changed, 18 insertions(+), 0 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/=
1777/1

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
in=
dex 1234215=2E=2E5bf9dbb 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/=
t_client=2Esh=2Ein
@@ -83,6 +83,21 @@
     exit "${TCLIENT_SKIP_RC}"
 fi
 
=
+if [ -n "$TEST_RUN_GROUP" ]; then
+    FILTERED_LIST=3D
+    for test in $=
TEST_RUN_LIST; do
+        group=3D`echo $test | sed 's/^\([0123456789]\+\)=
=2E*/\1/'`
+        if [ "$group" =3D "$TEST_RUN_GROUP" ]; then
+          =
  FILTERED_LIST=3D"$FILTERED_LIST $test"
+        fi;
+    done
+    if [ -=
z "$FILTERED_LIST" ]; then
+        echo "Filtered TEST_RUN_LIST empty (gro=
up=3D$TEST_RUN_GROUP), no tests defined=2E  SKIP test=2E" >&2
+        exit=
 "${TCLIENT_SKIP_RC}"
+    fi
+    TEST_RUN_LIST=3D$FILTERED_LIST
+fi
+
 # =
Ensure PREFER_KSU is in a known state
 PREFER_KSU=3D"${PREFER_KSU:-0}"
 
@@=
 -126,6 +141,9 @@
 fi
 
 LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`=

+if [ -n "$TEST_RUN_GROUP" ]; then
+    LOGDIR=3D"${LOGDIR}-${TEST_RUN_GRO=
UP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
 if mkdir $LOGDIR
 then :

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f885=
66f8372fabf
Gerrit-Change-Number: 1777
Gerrit-PatchSet: 1
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--7eGylLQJ+Zo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Add ability to filter by test group<br><br>Since w=
e generally set this up in a way that one test<br>group corresponds to one =
server, it can be useful to<br>filter by the group=2E E=2Eg=2E this allows =
one to potentially<br>parallelize test runs against different servers=2E<br=
><br>Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_clie=
nt=2Esh=2Ein<br>1 file changed, 18 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/77/1777/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_cl=
ient=2Esh=2Ein</span><br><span>index 1234215=2E=2E5bf9dbb 100755</span><br>=
<span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=
=2Esh=2Ein</span><br><span>@@ -83,6 +83,21 @@</span><br><span>     exit &qu=
ot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP=
&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    F=
ILTERED_LIST=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for test in $TEST_RUN_LIST; do</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        group=3D`echo $test | sed &#39;s/^\([0123456789]\+\)=2E*=
/\1/&#39;`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f [ &quot;$group&quot; =3D &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            FILTERED_LIST=3D&quo=
t;$FILTERED_LIST $test&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        fi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -=
z &quot;$FILTERED_LIST&quot; ]; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        echo &quot;Filtered TEST_RUN_LIST empty (group=3D$=
TEST_RUN_GROUP), no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        exit &quot;${TCLIEN=
T_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    TEST_RUN_LIS=
T=3D$FILTERED_LIST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
i</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
# Ensure PREFER_KSU is in a known state</span><br><span> PREFER_KSU=3D&quot=
;${PREFER_KSU:-0}&quot;</span><br><span> </span><br><span>@@ -126,6 +141,9 =
@@</span><br><span> fi</span><br><span> </span><br><span> LOGDIR=3Dt_client=
-`hostname`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    LOGDIR=3D&quot;${LOGDIR}-${TEST_R=
UN_GROUP}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</=
span><br><span> LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span> if m=
kdir $LOGDIR</span><br><span> then :</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=
=3Demail">change 1777</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1777?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1777 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--7eGylLQJ+Zo=--


--===============1406339520475542534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1406339520475542534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1406339520475542534==--


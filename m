Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B1C61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+k2iGrbri8yLS09xLGMd/Fc+2/itO4LTkiHbBBi3ZXY=; b=GsKrpWpWNbEUP3
	yhw1Ui/AL5S3tKUshKWBJj0yhrxxtc5XNxOFNvV3NaBUmUIF61cZoXZlb8UvnFr9kfqQ2fFRJPi3Z
	3f4FTijhzSGgSjLiwCZ8I9yEfcXLTMZy74VrqERxtrB4gFsM0oYJ+kd6lOwb6FYlyK2Mwr6F9URAj
	t1o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxr1-0003dJ-Tu;
	Fri, 28 Aug 2026 14:46:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzxqi-0003ct-F7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1INLPx6zRlrGjVWZMw87wNEcWMMoH35sUxpQKyTokKE=; b=LGzUe2sqzLfNcNqgfbtrD0AfxD
 nUsImVHDJRuddDjekPjhdlIqNgD8IiRjAt35flvvR9nyEhwYMXDMS7BhoK57cuFVGMP3MqKIEPB9D
 uPZk08ubWRohPPI8R73lmbISZhCP+AyUrs+YUgByskPr1WA1qAtU9bWIC11/fBYPGw1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1INLPx6zRlrGjVWZMw87wNEcWMMoH35sUxpQKyTokKE=; b=W
 XkBki+ntdeiIGvw6LVAx0jyq9+CdKDdCpMd6KbSQlx98+KnsoGCpiZI77NzTG6kPaWzUi5383m+Au
 lGPnzB9nBeSOhxUzHSaSRumENsBQiUIFhikuMmjgj6mdiixQqUQ+zfUIpzJaBfojHxDc+Bdg1puT8
 3NLU8gn7zYxWJijE=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzxqP-0005lR-N6 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:46:16 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so7435775e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787928359; x=1788533159; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1INLPx6zRlrGjVWZMw87wNEcWMMoH35sUxpQKyTokKE=;
 b=AZB75Y14HjPwuezX8YYU4uqaJUl2mSh60OHHyyb9q/wwFgYwjIwA3tMyzlNs2dd/ds
 QhonPjPpfaU6vfa4jg2PYq2+waHEbL/Awd7F/Wd6LWjjJGmJLLlZGHg5HITHmfNYSYNp
 WH38u0jJe3Pn6p2WeRjiiqaEMD5OLU3ZUiAzXBeTtigCmuoefHomrtV+rMC/0bsQmMeT
 L0vLc/NA2PW8XOc1HmxcoHfPh363fdJR90cdLGl9AJjoOMyMSBvvOZKaONmm7XecqK+g
 NjWsP9Wfz99o4kds+7VaLQ7KBmpL+oLAiKAXVi5inNS/a/lXvhswuoFBhtkmIfLe1udp
 ledQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928359; x=1788533159;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1INLPx6zRlrGjVWZMw87wNEcWMMoH35sUxpQKyTokKE=;
 b=mNFTAhGhc+g5XoH+6mgxfo2Q8qMoHLq8APSQD1pmZQEb9bXsdy/Mx5U5Ec1hLzJCU5
 Dmdd7FEeUw3XdWN9g6KZjApILnfb3gGn8UCiTv0Y3l6Q8pHf0189WRmzIEo+wOLlTNbi
 S5alZ9fYxy2nPAmVXS2MR5gFT1Do2ymuWLkX5FARPJUpjhmC7mtR9sEOGVwVjEpw2j9U
 cl8HeIkitAqga3bNpT86LdyBnRRbPKt/wo29Wr/e5Q3VvmwREi6Tv5RglR+WWdltmHKd
 xdBWUWin/hT+11UeT7iJ+coX0cJLOtTLT5MfozjHSLf3gZ1Et9crjClo3qb4y9M+JVY9
 2g/w==
X-Gm-Message-State: AFuF++leIciJtUktX4KmuWRVePlsGxkUHUK8JFMZ4Eu1LsLAzvGhPVl6
 QsgAwzcdgeNKKhTG2tvvUcxM0E7nfW7R4gN/V3TWXbl05VhyYAfu2aJSmRpAAn9nTK6jUeBQpoW
 ZuAJ9B40TapaZyrYRGedTKxCbJyOnayACTUZgDKQr6mDm8pO1gyTJbmEf0Oh69OgHjz54rmgm9F
 oXuSjuPg==
X-Gm-Gg: AR+sD10eTQCCw7CQS+ovTEu1jGV6Qmz3YMJcark5KizrK9F9HLBRvFiRSiDwkSEFQ8x
 AbNv756fPHdHFIbY1bO5YQTAUfJjLn4RXagPGTsqoOMT3bFKfzuw+lC/Ah6H5A7VdPPYYl+Mx8k
 taSXGrt1TxLkqWUokFgkyfUcrLLR+2S8B7hCTPi3xpud8+bUD1z9f34ImMNob0zi9+BpTgxyZSG
 Ln3xWc99W5f0ZKMuUyw8sWJQk1pJxzVHPiYnu3MwuIeass5oMQzDjVxR8DaLLCM9yOfDTTi9biY
 h2YIZcsEAd9uklzghNq2i3xz4ES9qGgZvdDLPEjUUTDDTvZpOH3/xFvtsq/BehI1wwe/4SfTSKt
 gZ3O+VoY3ofT3MjDgCltN2wiXR6XZ4O6JmxQQekdV+4NrBDt6cToqsSms8timar2IJqDw+5tG/C
 3Cu08+NxrXCRS1xlnELR7kYvLZ7ypL1svTxqBxBLe9i50ExGvSrn6Npf9CSDF0b7yUpVZLibBzG
 7kkcETgVnzR+GT19ZV2lZtNl2ZpbEotgb7H9XtLJBysymD4oWyMaX0fBptwHp+pY1N/cdFe63On
 X7HSySOVKiGhGW54JTRfPp9lI5JdDsMxhMaQG0GgazAKvXlssmC4jR1HgREf1w==
X-Received: by 2002:a7b:c30a:0:b0:49b:8c63:dfdf with SMTP id
 5b1f17b1804b1-49b91c5749fmr91445875e9.15.1787928359303; 
 Fri, 28 Aug 2026 07:45:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91728319sm67361815e9.12.2026.08.28.07.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:45:58 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 14:45:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 7b3fc92556d90c37f743d98ba1b7744caacaaae2
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47a7bb095de9a51d751dc9f9d0b1db18e0d408e5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzxqP-0005lR-N6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
Content-Type: multipart/mixed; boundary="===============0298724301792270025=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0298724301792270025==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R+J3haClPHM="; charset=UTF-8

--R+J3haClPHM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1882?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Check whether addresses are in "tentative" s=
tate
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_clien=
t=2Esh=2Ein: Check whether addresses are in "tentative" state

We see this =
sometimes with IPv6 addresses (especially
in t_server context)=2E Make sure=
 we wait until the
tentative state is removed=2E Otherwise we might get
spu=
rious failures on comparing state=2E

Change-Id: I07b373851175d865abdb1513f=
90655b3fa31d5fa
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
---
M tests/t_client=2Esh=2Ein
1 file changed, 17 insertions(+), 0 deletion=
s(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
82/1882/1

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein=

index 0568007=2E=2E017668b 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tes=
ts/t_client=2Esh=2Ein
@@ -264,6 +264,20 @@
 }
 
 # ------------------------=
----------------------------------
+# check ifconfig output on whether some=
 address is in "tentative" state
+# repeats calling get_ifconfig_route unti=
l it does not
+#  arg1: log file
+check_tentative_state()
+{
+    logfile=
=3D"$1"
+    while grep -q tentative $logfile; do
+        output "waiting =
for tentative state to end"
+        sleep 1
+        get_ifconfig_route >$=
logfile
+    done
+}
+
+# -------------------------------------------------=
---------
 # check ifconfig
 #  arg1: "4" or "6" -> for message
 #  arg2: I=
Pv4/IPv6 address that must show up in out of "get_ifconfig_route"
@@ -392,6=
 +406,7 @@
 
     output "save pre-openvpn ifconfig + route"
     get_ifcon=
fig_route >$LOGDIR/$SUF:ifconfig_route_pre=2Etxt
+    check_tentative_state=
 $LOGDIR/$SUF:ifconfig_route_pre=2Etxt
 
     output "\nrun pre-openvpn pin=
g tests - targets must not be reachable=2E=2E=2E"
     run_ping_tests 4 wan=
t_fail "$ping4_hosts"
@@ -498,6 +513,7 @@
     # compare whether anything c=
hanged in ifconfig/route setup?
     output "save ifconfig+route"
     get_=
ifconfig_route >$LOGDIR/$SUF:ifconfig_route=2Etxt
+    check_tentative_stat=
e $LOGDIR/$SUF:ifconfig_route=2Etxt
 
     if [ "$expect_ifconfig4" =3D "-"=
 ]; then
         output "skip ifconfig+route check"
@@ -535,6 +551,7 @@
 
=
     output "\nsave post-openvpn ifconfig + route=2E=2E=2E"
     get_ifconf=
ig_route >$LOGDIR/$SUF:ifconfig_route_post=2Etxt
+    check_tentative_state=
 $LOGDIR/$SUF:ifconfig_route_post=2Etxt
 
     output -n "compare pre- and =
post-openvpn ifconfig + route=2E=2E=2E"
     if diff $LOGDIR/$SUF:ifconfig_=
route_pre=2Etxt \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1882?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
07b373851175d865abdb1513f90655b3fa31d5fa
Gerrit-Change-Number: 1882
Gerrit-=
PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--R+J3haClPHM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Check whether addresses are in &quot;tentative&quo=
t; state<br><br>We see this sometimes with IPv6 addresses (especially<br>in=
 t_server context)=2E Make sure we wait until the<br>tentative state is rem=
oved=2E Otherwise we might get<br>spurious failures on comparing state=2E<b=
r><br>Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_cli=
ent=2Esh=2Ein<br>1 file changed, 17 insertions(+), 0 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/82/1882/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_c=
lient=2Esh=2Ein</span><br><span>index 0568007=2E=2E017668b 100755</span><br=
><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=
=2Esh=2Ein</span><br><span>@@ -264,6 +264,20 @@</span><br><span> }</span><b=
r><span> </span><br><span> # ----------------------------------------------=
------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# check=
 ifconfig output on whether some address is in &quot;tentative&quot; state<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# repeats calling ge=
t_ifconfig_route until it does not</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#  arg1: log file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_tentative_state()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   logfile=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    while grep -q tentative $logfile; do</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        output &quot;waiting for tentative sta=
te to end&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    sleep 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
get_ifconfig_route &gt;$logfile</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# ----------------------------------=
------------------------</span><br><span> # check ifconfig</span><br><span>=
 #  arg1: &quot;4&quot; or &quot;6&quot; -&gt; for message</span><br><span>=
 #  arg2: IPv4/IPv6 address that must show up in out of &quot;get_ifconfig_=
route&quot;</span><br><span>@@ -392,6 +406,7 @@</span><br><span> </span><br=
><span>     output &quot;save pre-openvpn ifconfig + route&quot;</span><br>=
<span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route_pre=2Etxt</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_tentative_sta=
te $LOGDIR/$SUF:ifconfig_route_pre=2Etxt</span><br><span> </span><br><span>=
     output &quot;\nrun pre-openvpn ping tests - targets must not be reacha=
ble=2E=2E=2E&quot;</span><br><span>     run_ping_tests 4 want_fail &quot;$p=
ing4_hosts&quot;</span><br><span>@@ -498,6 +513,7 @@</span><br><span>     #=
 compare whether anything changed in ifconfig/route setup?</span><br><span>=
     output &quot;save ifconfig+route&quot;</span><br><span>     get_ifconf=
ig_route &gt;$LOGDIR/$SUF:ifconfig_route=2Etxt</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    check_tentative_state $LOGDIR/$SUF:ifconfig_=
route=2Etxt</span><br><span> </span><br><span>     if [ &quot;$expect_ifcon=
fig4&quot; =3D &quot;-&quot; ]; then</span><br><span>         output &quot;=
skip ifconfig+route check&quot;</span><br><span>@@ -535,6 +551,7 @@</span><=
br><span> </span><br><span>     output &quot;\nsave post-openvpn ifconfig +=
 route=2E=2E=2E&quot;</span><br><span>     get_ifconfig_route &gt;$LOGDIR/$=
SUF:ifconfig_route_post=2Etxt</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    check_tentative_state $LOGDIR/$SUF:ifconfig_route_post=2Etxt<=
/span><br><span> </span><br><span>     output -n &quot;compare pre- and pos=
t-openvpn ifconfig + route=2E=2E=2E&quot;</span><br><span>     if diff $LOG=
DIR/$SUF:ifconfig_route_pre=2Etxt \</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=
=3Demail">change 1882</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1882?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1882 </div>
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
--R+J3haClPHM=--


--===============0298724301792270025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0298724301792270025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0298724301792270025==--


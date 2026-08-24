Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB6BC5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fnw8rzsgEn5RhUjdkn8yymQhgq3QiTPepHetRyVC4Ss=; b=kfA49hEWrmwgy9D1D6kmIi36os
	S0rTLaMX+DAZ3wVFVByCaPZyp6zgQeVa4BXv0SYY6Sj6uWxf5W1xe+f1ot2RGUCdyadsw+3qD5tk+
	EbwsIIKinO0fbJ9mhKrzgzL6bL1Z1gfWFw/GIx4Hqi6uwwiOAYPohomE08GxH0sU6kMM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWGg-0001Y7-Ii;
	Mon, 24 Aug 2026 15:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWGO-0001X0-4v
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6KVG9xEbsGhb3lVRtDPLSpYukDPfvil2GAC58jYznCY=; b=RULCyQf8E7wUirnt/QzyH4UmcH
 kA8iAV5SlAcTzvlv5/qWWrK1N8B35yhWqN3iAdBId9vZS9+dM7UuJgRrehrwvoy3cQGqGc9NoZIkc
 bbX1rrUERRdOkS523NwwelxYsJUXdlsC4HmNruuB/1+5jOp+2oq96pEnUNJd/8WOoeTc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6KVG9xEbsGhb3lVRtDPLSpYukDPfvil2GAC58jYznCY=; b=B
 hLJR3WDmV7CtIlj/r22iT6OzQ+mT5zqIHat+yZt7kWFjQj770tW5Qo/Bg5/gsjMzqvZr+P0dY4yS0
 G7tPLhX2Q0ihPpt3OAfZwbDY0jr1jwoNfMGZJ1ZInohWL8p3JtjnjAQnU/K9bq+WTmQUiLL6ED5sZ
 ipiWbbFCyVynnfvE=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWGF-00070L-Jr for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:06:58 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso734622566b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787584009; x=1788188809; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6KVG9xEbsGhb3lVRtDPLSpYukDPfvil2GAC58jYznCY=;
 b=BegaffsoPjqbsNvps0RA7jp/mXfHG4jRw+xbyFGEkLra2X7ZsR5ox7T1ESdVtn9EqQ
 GBcZ9NPButHxiaIpH3qrZV3/cY+LUNWCH4nTmFpv0KQQgIfsbliB4J2phHQIOJZ8wzQ2
 5kx/wMiMCtAd0/wsEvmXIqqQTSJi8GkENisCBCK5JaKVVQfaPmZ05kGlP9iqZqiV72bT
 7/DNGBN478YB7T1fq2Zj2GXNAgRl9NwFrkemcQF6O5ytCqhn8IsRd6ZZf+UZCwKACjNe
 vMyrnVWQX9sv9r5MX3jj3VT+uYeOf87x9ViTCadUjR1biuDgRmzoNLnp5L7lFKGYxw9S
 W5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584009; x=1788188809;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6KVG9xEbsGhb3lVRtDPLSpYukDPfvil2GAC58jYznCY=;
 b=SqSVZ6XqxtuJwOFiW+f4vYzs0DdDje/nrH+inIf1HFmxpkbOEghifDauvLkMcst4Cx
 2PyPSUZmYU7auuUxYa/jcKdAHPlxuphg3AxzV41f8d8SY8ZCo/vS/aHV6vbshvp43PCV
 ae+v8lxxlpGKGxAAe//65dTuxKCSY1W32ewh1qMVXAmER01KD5MZZLIDQjtcTuNQkor9
 H1/RB6Z6HpV1UyOAsrbc6Y6ujJVKHg3mHGbtOuNfo4uHYH6CPKn0it5w4vyMauiwfBpw
 qgHooBh0HLxvsdjQTJlLXSHMR7RBEyJegnaQ/vjMifjVVSJlnOmTKd/weUK7/IzW2dJG
 j0mA==
X-Gm-Message-State: AFuF++ml3keKjvN0/7JD0YmSck8jiiqVaKXm6xeaB3P8zyPBiT63wtu9
 skw8QSF9yFSbX4fcHPqf/v3yxjGeTBw3GeSOL7I1My2doWA/5AkgI7hreG2W3R8qbYOedydZjTD
 ONuYz1VnQvVskW7JINS2eMSSNha1inQJXTCwZ2nMWN9VoKjP90tROvbrziW9OnTqKXFWftGNyce
 4GeLVWIw==
X-Gm-Gg: AR+sD11dKe2L2EKYs4Hpb0nuGEDp7kadQN5SQ0bwt5RaKe5iiBX83kE4MMmvJrRXGzJ
 fBvRlw4CP7g8nZHQQDZ0ByEQBWOKu58j62EhwRZab1m9HEiwvFWNxn5nWul09AK180rF0XY3J2Y
 Pl8kHgoQC6Q4CvPYZKAbR6elMNjYNlVRQa5BK0WAduzL39Y4mvXs5Pf297PSP7NJcWSxQEcP83V
 O8lfUp2JWr4rUAQUr/9jsUm0/z5f4W1KeQsbyeFJZpMFAVIl8PwKqTt2ZeIBjzXMBTY+otJMAy7
 xU96W52lE2BlEGBY2xzlahf2gz+fO12hXadwsXbIHExDiQ+6bZfK1uvpFG2KCOjRsJH14kOIMOl
 jne2Z3LyOxGCfLdrBlqjXmDh/cOCxeddrLNgTNZTz/k+8Xn7ZQVMcYP3KLCD74wB2ABmlmMDgId
 1Sg1LjOZEeKyMjWDNHaoiR49ltawmzPsT/WrIF5xUEXsD9mpIHhS5Pe2Rg5g2R7X1K2ydHGyNdg
 02hK1e8UqobMCS5egZKdZs6PXElLbJLeo889wjzk8EE10enyU72ynQTixOOpq3XIDGFJZtZDqTz
 +TdLlUgynlJr7m4qT9nrPhOf/Pu5oCXGJ2sl2VEOBjc77INIJ64=
X-Received: by 2002:a17:907:3e1d:b0:c20:fd32:d9f5 with SMTP id
 a640c23a62f3a-c244d7d6f49mr3210192566b.13.1787584008886; 
 Mon, 24 Aug 2026 08:06:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b4f1sm1270033866b.3.2026.08.24.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:06:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:06:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: e849da62a3942039d9f8185a0e57bdaeaf413b51
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a06b924bc6828af6fdb7e103176a8602f52b2e92-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWGF-00070L-Jr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
Content-Type: multipart/mixed; boundary="===============6699360269553733923=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6699360269553733923==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LOPMLpcPDTo="; charset=UTF-8

--LOPMLpcPDTo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail

to look at the new patch=
 set (#3)=2E

The following approvals got outdated and were removed:
Code-R=
eview+2 by plaisthos

The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E


Change subject: t_client=
=2Esh=2Ein: Add utility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Add utility funct=
ion needs_openvpn()

This allows to skip tests on old versions of openvpn=
=2E
Makes it much easier to maintain a t_client=2Erc across
multiple versio=
ns=2E

Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
Signed-off-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_client=2Esh=2Ein
=
1 file changed, 22 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1763/3

diff --git a/tests/t=
_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 0ce8e02=2E=2Eb466208 100=
755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -22,14=
 +22,16 @@
 t_client_ips_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_=
ips=2Erc}"
 update_t_client_ips=3D"${update_t_client_ips:-${srcdir}/update_=
t_client_ips=2Esh}"
 
-if [ -r "${top_builddir}"/t_client=2Erc ]; then
-   =
 =2E "${top_builddir}"/t_client=2Erc
-elif [ -r "${srcdir}"/t_client=2Erc ]=
; then
-    =2E "${srcdir}"/t_client=2Erc
-else
-    echo "$0: cannot find =
't_client=2Erc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or sou=
rce directory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
-    exit "${TCLIENT_S=
KIP_RC}"
+if [ -z "${t_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t=
_client=2Erc ]; then
+        t_client_rc=3D"${top_builddir}"/t_client=2Erc=

+    elif [ -r "${srcdir}"/t_client=2Erc ]; then
+        t_client_rc=3D"$=
{srcdir}"/t_client=2Erc
+    else
+        echo "$0: cannot find 't_client=
=2Erc' in build dir ('${top_builddir}')" >&2
+        echo "$0: or source d=
irectory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
+        exit "${TCLIENT_SK=
IP_RC}"
+    fi
 fi
 
 # Check for external dependencies
@@ -63,6 +65,18 @@=

     exit 1
 fi
 
+openvpn_version=3D$(${openvpn} --version | head -n 1 | =
cut -f2 -d" " | sed -e 's/^2\=2E\([0123456789]\+\)=2E*$/2\1/')
+
+needs_ope=
nvpn()
+{
+    needs_version=3D$1
+
+    [ "$openvpn_version" -ge "$needs_v=
ersion" ]
+    return $?
+}
+
+=2E "${t_client_rc}"
+
 if [ -z "$TEST_RUN_L=
IST" ]; then
     echo "TEST_RUN_LIST empty, no tests defined=2E  SKIP test=
=2E" >&2
     exit "${TCLIENT_SKIP_RC}"

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
Gerrit-C=
hange-Number: 1763
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>

--LOPMLpcPDTo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+2 by pl=
aisthos</p><p>The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein:=
 Add utility function needs_openvpn()<br><br>This allows to skip tests on o=
ld versions of openvpn=2E<br>Makes it much easier to maintain a t_client=2E=
rc across<br>multiple versions=2E<br><br>Change-Id: I1905d9494336da4e91f194=
6d2ffd875720605b41<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file changed, 22 inse=
rtions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1763/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 0=
ce8e02=2E=2Eb466208 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</=
span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -22,14 +22=
,16 @@</span><br><span> t_client_ips_rc=3D&quot;${t_client_ips_rc:-${top_bu=
ilddir}/t_client_ips=2Erc}&quot;</span><br><span> update_t_client_ips=3D&qu=
ot;${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -r &qu=
ot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    =2E &quot;${top_builddir}&quot;/t_client=2Erc<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ -r &quot;${srcd=
ir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    =2E &quot;${srcdir}&quot;/t_client=2Erc</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    echo &quot;$0: cannot find &#39;t_client=2Erc&#39; in bu=
ild dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: or source directory (&#3=
9;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    exit &quot;${TCLIENT_SKIP_RC}&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;${t_clie=
nt_rc}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;${to=
p_builddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&qu=
ot;${srcdir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        echo &quot;$0: cannot find &#39;t_client=2Erc&#39; in build dir (=
&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        echo &quot;$0: or source directory (&#39;${=
srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><sp=
an> fi</span><br><span> </span><br><span> # Check for external dependencies=
</span><br><span>@@ -63,6 +65,18 @@</span><br><span>     exit 1</span><br><=
span> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+openvpn_version=3D$(${openvpn} --version | head -n 1 | cut -f2 -d&qu=
ot; &quot; | sed -e &#39;s/^2\=2E\([0123456789]\+\)=2E*$/2\1/&#39;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+needs_openvpn()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    needs_version=3D$1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ &qu=
ot;$openvpn_version&quot; -ge &quot;$needs_version&quot; ]</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return $?</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=2E=
 &quot;${t_client_rc}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> if [ -z &quot;$TEST_RUN_LIST&quot; ]; then</span>=
<br><span>     echo &quot;TEST_RUN_LIST empty, no tests defined=2E  SKIP te=
st=2E&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&q=
uot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">change 1763</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1905d9494336=
da4e91f1946d2ffd875720605b41 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--LOPMLpcPDTo=--


--===============6699360269553733923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6699360269553733923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6699360269553733923==--


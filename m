Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E38C43327
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0lTuYeb9Q6IpqbXTfsdEyalSjgx5VYPhE03Gx5XMxt8=; b=W/DL0M5aKNFOW3
	tOzfRZiCysu290AvFt4kB1gSiIEvg/CwM4fH4qB+UEYr8pmRsQFTVo1ExbhJVCCrc8tbi0f2/E3JI
	CW3yLKR8D6NxiuhpDU+RtTEGPchoZXA3yjgDcTV/bf9c1E7g/H4C5K0/nfxWtBY7bcYJ8//5tzrP1
	Wfw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wf0Xu-0002tv-U6;
	Wed, 01 Jul 2026 19:24:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wf0Xt-0002td-2l
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 19:24:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6VyuoeCvC4/wQr6Ep9RuvX60AtAnvIW2djmEI1rIY2A=; b=Iqton8Ou0rGDL/5jU8LbYGztdb
 ZAe/yr8NP56bE/bLz2gC7ff8Qj58MfzuLC0WLOawRf1D+5jV76dynsnAAEgxPDvr79KN+9glqqOHg
 spBhJPkzRCJyCIV4vGpHfO3EhgQVYwA5i2JzawBl0kDc9pRo6MpqKOTwEHTLG0gzZj+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6VyuoeCvC4/wQr6Ep9RuvX60AtAnvIW2djmEI1rIY2A=; b=m
 k7RcD3RLJvOTUFtqICQzPIjuwOV/gPIrth/Xqp+uE2e2jTIO9uCLrkKYd5DlR5HZ89Vn/6P1wEhfX
 w1XdbuV0UN/eBYviKN2u4GYSjyNMv79Nso2oBbmuwyXzOwXjD4Z+/Tu+sfW+XOLL3TPYWPdHW7wlj
 wF3QfDlrxEABhZZY=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wf0Xr-000065-Ou for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 19:24:29 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-472326ca506so801940f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782933857; x=1783538657; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6VyuoeCvC4/wQr6Ep9RuvX60AtAnvIW2djmEI1rIY2A=;
 b=fX86vVCRS4xAzJIOq7VzWq8mynq0vp7paB3J2HiioTekfb8uRt1MAD/FXGhF5qb0ZP
 dy2ZZs/+eBEaYptQyktm8ySRoL6+rngsaNyOIZO+dbccxiAQW+nwQSeG8ZLlTO7z0X2D
 NeVXSOwEACY53Fgvsm2oINfTu1zReqKehtTbI8fFr7J4996eigRJ8KusrEhYwz5Y0UE3
 xyrFeTWgAjzWskcOjUIHGikQDScx3DJvtKPuulkJfwGK10nVheZJd4T8NDXYIed3Okhj
 HHBGKnXfd1yQyWEc2dFh/7SrFiCUtsl7fd0PAVlzYCc+L17WCpHYrlBCkOGDSGTTca8S
 /eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782933857; x=1783538657;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VyuoeCvC4/wQr6Ep9RuvX60AtAnvIW2djmEI1rIY2A=;
 b=Jj8G+bClQQEUmkvn6C76Kgb4qBTXK23hVR3rNnXkwWgUaXP0RD+2SCH8Vz+LR5UB/s
 g3yr5fEBC1WVLCG6ed5Y82cybWQ/ZzYLKSFkeu4pkSA3Zugd5KAgJ/tIEwQfaZI29NCH
 JLF6qRhKB9fmkxqqzOEbXkErrQ4lzhmWld/mXqOnHo4fa32MlfAWQpOJFeLGn6i1dRmG
 ijIZzZhLUCAfeNhtW7TnT17u+gG4Hbv32GARd6ecqsuKuBG00csK59bMkBbWqydtSfHu
 ddohPBfDiPB8yoYe4D7/5i2bJ1Now4J4mlO5XQtaV5+pXehsufTvakITArlsFBa88i/H
 GFiQ==
X-Gm-Message-State: AOJu0YygCI/biKYRHKdltgLod1zORU2yDQP+dmPpIid9h8XGSr6phNSU
 /O8mq3lKV3TaClc1ZXw31mvM/ZsDs3tyOTL6k7M0siZGPzVf6rVje+gC+5WiqE8xWRNGWfCKEHz
 OR4eUCU1US7O2npem3gkShm8zNOEDNK0o52aNoNdfzs1KpdCrqBJsEFC7Cre+20dHvDp0UudMIG
 hKSkDfsA==
X-Gm-Gg: AfdE7cl4VLuW0KLSIypX8dJ6sDj4p4W2146GDAqM4EL54Q56eG99w8rmDJINZ2XlXsU
 tAz5pMPHwJOd8G6glqHfYLB8jid+Vum4IYLiFjvLDHH4KSHeN+fymiEdoqT2torpUkWkBY/iKGN
 yMogiBFEOiY4pcVx/Jo2oqOr7q/me/8u/PMuUKjPFr41jhBqOdOdKF98SzB7XJTx3A6oWEcm6rI
 L6zSSPiZTwMm74hPmcXwYXVdA4I0lFepp07hgJVbtusNft5UhrQsAoLzNBnV6Hu5BkPkcA4a1Rm
 Ha+ddmsE6kK8EZQuVZo0pKV/IvZHbgDLcRL6IVpK6N6MsniM6uJTYDA0b+UiCsoRUdTALYWfl7M
 jfE3AmpCC76ttmWKFOGJnKOgoH0khAFfnmaMulVNH9TN8NwRLTHMnne59/+kQeLNyCv0wVJm2pv
 i9Hkbh1Q5t1BaF5lj00w3co13W70uYG2xm8RulBhrxktls4flMlDam58WAU3dW2jSPt7kgbq6jw
 s/fI/selb9ijhuvrDbTGM8h8dF+vd9VVpg52WUPW+Nc9+7DDHCS8+5Qun4UXsg0Wt5A9PGEekYp
 n7mJfjldjljutg==
X-Received: by 2002:a05:6000:29c6:b0:476:504f:7a1 with SMTP id
 ffacd0b85a97d-47757e57eeamr3222531f8f.7.1782933856546; 
 Wed, 01 Jul 2026 12:24:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4b83sm2433392f8f.12.2026.07.01.12.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:24:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 19:24:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 5640441194916a0981eb3c51757444f96418bde8
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <944542f8740991583e57c1a2f7e5a114777bf47e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wf0Xr-000065-Ou
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
Content-Type: multipart/mixed; boundary="===============7229878582012714557=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7229878582012714557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ap8TLG/cpc8="; charset=UTF-8

--Ap8TLG/cpc8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1763?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Add utility function needs_openvpn()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein:=
 Add utility function needs_openvpn()

This allows to skip tests on old ver=
sions of openvpn=2E
Makes it much easier to maintain a t_client=2Erc across=

multiple versions=2E

Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_c=
lient=2Esh=2Ein
1 file changed, 21 insertions(+), 8 deletions(-)



  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1763/1

diff=
 --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 2459c08=
=2E=2E78c8bca 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2E=
sh=2Ein
@@ -22,14 +22,16 @@
 t_client_ips_rc=3D"${t_client_ips_rc:-${top_bu=
ilddir}/t_client_ips=2Erc}"
 update_t_client_ips=3D"${update_t_client_ips:-=
${srcdir}/update_t_client_ips=2Esh}"
 
-if [ -r "${top_builddir}"/t_client=
=2Erc ] ; then
-    =2E "${top_builddir}"/t_client=2Erc
-elif [ -r "${srcdi=
r}"/t_client=2Erc ] ; then
-    =2E "${srcdir}"/t_client=2Erc
-else
-    ec=
ho "$0: cannot find 't_client=2Erc' in build dir ('${top_builddir}')" >&2
-=
    echo "$0: or source directory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
- =
   exit "${TCLIENT_SKIP_RC}"
+if [ -z "${t_client_rc}" ]; then
+    if [ -r=
 "${top_builddir}"/t_client=2Erc ] ; then
+        t_client_rc=3D"${top_bui=
lddir}"/t_client=2Erc
+    elif [ -r "${srcdir}"/t_client=2Erc ] ; then
+  =
      t_client_rc=3D"${srcdir}"/t_client=2Erc
+    else
+        echo "$0: =
cannot find 't_client=2Erc' in build dir ('${top_builddir}')" >&2
+        =
echo "$0: or source directory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
+     =
   exit "${TCLIENT_SKIP_RC}"
+    fi
 fi
 
 # Check for external dependenci=
es
@@ -65,6 +67,17 @@
     exit 1
 fi
 
+openvpn_version=3D`${openvpn} --ve=
rsion | head -n 1 | cut -f2 -d" " | sed -e 's/^2\=2E\([0123456789]\+\)=2E*$=
/2\1/'`
+
+needs_openvpn() {
+    needs_version=3D$1
+
+    [ "$openvpn_ver=
sion" -ge "$needs_version" ]
+    return $?
+}
+
+=2E "${t_client_rc}"
+
 i=
f [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no tests d=
efined=2E  SKIP test=2E" >&2
     exit "${TCLIENT_SKIP_RC}"

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd87572=
0605b41
Gerrit-Change-Number: 1763
Gerrit-PatchSet: 1
Gerrit-Owner: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Ap8TLG/cpc8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Add utility function needs_openvpn()<br><br>This a=
llows to skip tests on old versions of openvpn=2E<br>Makes it much easier t=
o maintain a t_client=2Erc across<br>multiple versions=2E<br><br>Change-Id:=
 I1905d9494336da4e91f1946d2ffd875720605b41<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br=
>1 file changed, 21 insertions(+), 8 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/176=
3/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ei=
n</span><br><span>index 2459c08=2E=2E78c8bca 100755</span><br><span>--- a/t=
ests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</spa=
n><br><span>@@ -22,14 +22,16 @@</span><br><span> t_client_ips_rc=3D&quot;${=
t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}&quot;</span><br><span> =
update_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t_clien=
t_ips=2Esh}&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ] ; then</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_buil=
ddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ] ; then</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${srcdir}&quot;/t_client=
=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: cannot find &#=
39;t_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt;&a=
mp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0=
: or source directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&=
amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit &quot;$=
{TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+if [ -z &quot;${t_client_rc}&quot; ]; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if [ -r &quot;${top_builddir}&quot;/t_client=
=2Erc ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   t_client_rc=3D&quot;${top_builddir}&quot;/t_client=2Erc</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    elif [ -r &quot;${srcdir}&quot;/=
t_client=2Erc ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        t_client_rc=3D&quot;${srcdir}&quot;/t_client=2Erc</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        echo &quot;$0: cannot find &#39;t_cli=
ent=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;$0: =
or source directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&am=
p;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit &qu=
ot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    fi</span><br><span> fi</span><br><span> </span><br><span> # Che=
ck for external dependencies</span><br><span>@@ -65,6 +67,17 @@</span><br><=
span>     exit 1</span><br><span> fi</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+openvpn_version=3D`${openvpn} --version =
| head -n 1 | cut -f2 -d&quot; &quot; | sed -e &#39;s/^2\=2E\([0123456789]\=
+\)=2E*$/2\1/&#39;`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+needs_openvpn() {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    needs_version=3D$=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    [ &quot;$openvpn_version&quot; -g=
e &quot;$needs_version&quot; ]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return $?</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+=2E &quot;${t_client_rc}&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if =
[ -z &quot;$TEST_RUN_LIST&quot; ] ; then</span><br><span>     echo &quot;TE=
ST_RUN_LIST empty, no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span=
><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1763?usp=3Demail">change 1763</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1763?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1763 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--Ap8TLG/cpc8=--


--===============7229878582012714557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7229878582012714557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7229878582012714557==--


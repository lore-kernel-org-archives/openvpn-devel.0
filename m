Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A37C61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJh5mj1CgDuitQYwmsznxkkskp4xZTxoYEAzQ/4COKg=; b=HPR4x/Q2Tubw8hNUI/IuVBGmAC
	ZTl2ZNFr80KmzP71MF4x6aGuM02++OCs5uYV1IBQz8EwpWLgBmei1flBgEOEZiQON/4iDYQDGu4Mf
	BpkV4RoHSrOhffnqFfPfywSRNg6XXolMopHdLy04VvSIbrvWxON9AhWFiGQh8DUnExJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jAz-000562-PH;
	Sun, 30 Aug 2026 17:18:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0jAe-00055T-MA
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:18:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LFtJbQPrIFUSPhoC12I8KezZ4FWM8s2hJuvU0VYBU6g=; b=WC0Dj9g7rtIrdO85+QnwaQyKwW
 MPhYr87RCAgEpMs1THdHw7lj499uVACvy9bWp9M3tT8Ymy9EwEytZFjyhwuzNLTAZYFl1pdcEZ5YP
 ns/caiuFSPCFebMq7uXe/jWrgtmXoi3phftahQpP7XQ+0THGycgClngTur0clmK02jXk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LFtJbQPrIFUSPhoC12I8KezZ4FWM8s2hJuvU0VYBU6g=; b=P
 dpkubQQZZMwB6PMaeZxvwJX/Wll2TDpECaQ+Oc5fDyru4H0IMmOEDI2o2KN8xf+4xRrbEbYnHKGMl
 cxE37KDQAW0RSBqwdSsbAG5Wacjf/hOhX8lK4UyYzIdfRjTZFJpH9MFQCOsZiTQYiahWUZ0ueReLd
 7RiKOR97RdmsIcvs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0jAO-0001No-7F for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:18:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so19986475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788110274; x=1788715074; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LFtJbQPrIFUSPhoC12I8KezZ4FWM8s2hJuvU0VYBU6g=;
 b=GrumRKCBltE90l7rwCoR6qGGnf7edoHw5m4wVHpOk2N7jT086j7bGA98vunDxEht+6
 TnvfikFZOJlVeCItsZTzmVHNcl0iv8160g3iAuowzNrL3Kjo4NJWquPKIY9GjqENVmuz
 /Tj1JCMkAhBeBFjyvkPMPaLCO3M9jiBSDaSKcCedGk9cXx6yQy3aipO6PJ9zak7o3ujZ
 0cowrFGqNeU7impa5oAtQpRVLCg1DQ43T+gpTtmI02lAUVSh1luOR3VfEn9uZefs9HaS
 1wRiL0ZgOcd13Vgntigyh0VqmGzxjgM9zkchg7EY8iaSsbcBMBhwGNhdwfBbiYxDAhIa
 QPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788110274; x=1788715074;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LFtJbQPrIFUSPhoC12I8KezZ4FWM8s2hJuvU0VYBU6g=;
 b=G+8Gnhwdm3pu1RE/5iy/bsfLfKiN/EiZbZs4fiyVThe2g6xMJ6XQo3O8VrR+OsgGIF
 SPF8i4H1+NjFvF95C4XA/ArqyJXFAvVpqsrKa28IFsAbARh4wrFW0RJL6qWPu1nPvOGO
 g8QNfJ3rjI9f4smlnqURxrgeiR56UksfDvBsm4b9y2Y4S2RKbycST7P4EUUYgk4kcxlA
 gu3nuBIRjQbS4RyimyPxXDvA+rB7nf7I+Veay7IKKVYYeCx5wZptvs84LMICcKVteQei
 mffkjo7j3MQeOoY0v0zawXt/djA6TlvcjO7QJVdHm9BsX7a+mACb6EsXTZsrRtHz1egv
 s9Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHgKhoI4WGG5kBE3mzlQIWFoY47pqNILm4Jtbnx9jz3N+62nkVbccpW9Dk/FpaxZM6N1v4rvOpgdHWOjOv@lists.sourceforge.net
X-Gm-Message-State: AFuF++lDXFxQ3UxvOmg6HLXByYAlDLRjaegGOglevYulUNFJvAxsLnbh
 IKXuxOObC13d0DDf41P7lXuECTUwpRkt2K2rzJbgGhVce3165HUGHJT5XXYq1k3Jtkw9yrIJxd+
 PihURrfgpvwGYRx6Y0jsBcsU9gpPErTfb4aDRewRfhEs0nSVxNaI706kC22nRlJAhMI5i
X-Gm-Gg: AR+sD124zxFstUhDpnkLXREUfgr/4WBjgmVSMjNyJtA1U03emXF7q3nMILBy49cYP+8
 Zp2UjbapjYGU5ZYD8OduaBiX/1yf96Fx/Euyvi1MTkY/fV3HRBulO3M9qbmUzwTZC3BZ0h1EIjG
 h5x45sJAwIcqVqVE0brtpDv/XYQR0zAvbufYDVNRf0QgYU3aQIxr8bmCe+TCsfU5xWF7M1HJfPE
 l3TAeDUo6WN0iZIH5bFz/C0DhIoK6aAOLoy/70ctEE8ksJWd29CcliLBIxleGKXzsipyFu5k+hj
 9EkdSg/VK2X6VvZ8T8eorSFolZophw4cNWkASz9Xw7bYP5vqAtm84Lx0SOq1eSnEqobI1+N1i5p
 iqGm9ZzByO5I/OnpHOwtXzWB01vqHuv0TD0l449fCGH/QwoTWPew6SRJQTjJBrG8OVPopQeBSDT
 OI2jYzSMgBJQKIiOSD8k+VQ/CreuC9N0H0Lg2pJksJ6N4EfXylHYLB3tkb5T0XpbWoz/KZQx7W4
 c1dBW536OGuFf3s0G+NHqdymbvCGaGD9nO1JqIfjw8n7E+OlNoXmodFyJI3423y7f12Pir45sc7
 iYaPEWBws0HQyz9nWoRpfHfA0nbI34ekTcBldZ3tCA3VW/etEpk=
X-Received: by 2002:a05:600c:1d02:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49cd538b513mr65028985e9.4.1788110273596; 
 Sun, 30 Aug 2026 10:17:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b955e7906sm184190885e9.1.2026.08.30.10.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:17:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:17:52 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 8b392d642eb4c9b9135dc6a442d943159467e058
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <600c7a792bdf46d23e3ffc720fd5e961a11a91c3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0jAO-0001No-7F
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6932294178963676622=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6932294178963676622==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/M5MQqun/Ys="; charset=UTF-8

--/M5MQqun/Ys=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Add utility fun=
ction needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

t_client=2Esh=2Ein: Add utility function needs_openvpn()

This a=
llows to skip tests on old versions of openvpn=2E
Makes it much easier to m=
aintain a t_client=2Erc across
multiple versions=2E

Change-Id: I1905d94943=
36da4e91f1946d2ffd875720605b41
Signed-off-by: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763
Message-Id: <202608280953=
00=2E9652-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg38760=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Esh=2Ein
1 file ch=
anged, 22 insertions(+), 8 deletions(-)




diff --git a/tests/t_client=2Es=
h=2Ein b/tests/t_client=2Esh=2Ein
index 7c23020=2E=2Ec3a9655 100755
--- a/t=
ests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -22,14 +22,16 @@
=
 t_client_ips_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
=
 update_t_client_ips=3D"${update_t_client_ips:-${srcdir}/update_t_client_ip=
s=2Esh}"
 
-if [ -r "${top_builddir}"/t_client=2Erc ]; then
-    =2E "${top=
_builddir}"/t_client=2Erc
-elif [ -r "${srcdir}"/t_client=2Erc ]; then
-   =
 =2E "${srcdir}"/t_client=2Erc
-else
-    echo "$0: cannot find 't_client=
=2Erc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or source direc=
tory ('${srcdir}')=2E SKIPPING TEST=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
=
+if [ -z "${t_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t_client=
=2Erc ]; then
+        t_client_rc=3D"${top_builddir}"/t_client=2Erc
+    e=
lif [ -r "${srcdir}"/t_client=2Erc ]; then
+        t_client_rc=3D"${srcdir=
}"/t_client=2Erc
+    else
+        echo "$0: cannot find 't_client=2Erc' i=
n build dir ('${top_builddir}')" >&2
+        echo "$0: or source directory=
 ('${srcdir}')=2E SKIPPING TEST=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
=
+    fi
 fi
 
 # Check for external dependencies
@@ -63,6 +65,18 @@
     ex=
it 1
 fi
 
+openvpn_version=3D$(${openvpn} --version | head -n 1 | cut -f2 =
-d" " | sed -E 's/^2\=2E([0123456789]+)=2E*$/2\1/')
+
+needs_openvpn()
+{
+=
    needs_version=3D$1
+
+    [ "$openvpn_version" -ge "$needs_version" ]
+=
    return $?
+}
+
+=2E "${t_client_rc}"
+
 if [ -z "$TEST_RUN_LIST" ]; the=
n
     echo "TEST_RUN_LIST empty, no tests defined=2E  SKIP test=2E" >&2
  =
   exit "${TCLIENT_SKIP_RC}"

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1763?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I1905d9494336da4e91f1946d2ffd875720605b41
Gerrit-Change-Number: 1763=

Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--/M5MQqun/Ys=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1763?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Add utility function n=
eeds_openvpn()<br><br>This allows to skip tests on old versions of openvpn=
=2E<br>Makes it much easier to maintain a t_client=2Erc across<br>multiple =
versions=2E<br><br>Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1763<br>Message-Id: &lt;20260828095300=2E96=
52-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38760=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_client=2Esh=
=2Ein<br>1 file changed, 22 insertions(+), 8 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br>=
<span>index 7c23020=2E=2Ec3a9655 100755</span><br><span>--- a/tests/t_clien=
t=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>=
@@ -22,14 +22,16 @@</span><br><span> t_client_ips_rc=3D&quot;${t_client_ips=
_rc:-${top_builddir}/t_client_ips=2Erc}&quot;</span><br><span> update_t_cli=
ent_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}&=
quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_builddir}&quot;/t=
_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ -r=
 &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    =2E &quot;${srcdir}&quot;/t_client=2Erc</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    echo &quot;$0: cannot find &#39;t_client=2E=
rc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: or source di=
rectory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    exit &quot;${TCLIENT_SKIP_=
RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &q=
uot;${t_client_rc}&quot; ]; then</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=
=3D&quot;${top_builddir}&quot;/t_client=2Erc</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    elif [ -r &quot;${srcdir}&quot;/t_client=2Erc =
]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t_cl=
ient_rc=3D&quot;${srcdir}&quot;/t_client=2Erc</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        echo &quot;$0: cannot find &#39;t_client=2Erc&#39; i=
n build dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        echo &quot;$0: or source direc=
tory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        exit &quot;${TCLIENT_SK=
IP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi<=
/span><br><span> fi</span><br><span> </span><br><span> # Check for external=
 dependencies</span><br><span>@@ -63,6 +65,18 @@</span><br><span>     exit =
1</span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+openvpn_version=3D$(${openvpn} --version | head -n 1 | =
cut -f2 -d&quot; &quot; | sed -E &#39;s/^2\=2E([0123456789]+)=2E*$/2\1/&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+needs_openvpn()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    needs_version=3D$1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    [ &quot;$openvpn_version&quot; -ge &quot;$needs_version&quot; ]</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return $?</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+=2E &quot;${t_client_rc}&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> if [ -z &quot;$TEST_RUN_LIST&quot; ]; th=
en</span><br><span>     echo &quot;TEST_RUN_LIST empty, no tests defined=2E=
  SKIP test=2E&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_S=
KIP_RC}&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">change 1763</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1905d9=
494336da4e91f1946d2ffd875720605b41 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1763 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--/M5MQqun/Ys=--


--===============6932294178963676622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6932294178963676622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6932294178963676622==--


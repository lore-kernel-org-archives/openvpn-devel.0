Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5F3C61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5ke2VfRfeyh1ZxONQGwG9py2FI+T3CHszf20Y4Y1L4=; b=auWW/0QYldOzBZV3ryCeZ1X4Gw
	bCwWouRVhhMNw6jzoDtBqWFSgR8tRR3fbRiUicEgzph30oL6HBrgEM4muGB6IJ9QcJ1pvG5zgLlKf
	HGpsAk/iSMDNHSipyQcgowdM5hAPlQCddfdGhgYCqGm8TS+3/4Sf0yF0X5qu31ME/GYo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0j5C-0004MX-BV;
	Sun, 30 Aug 2026 17:12:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0j57-0004M7-VY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:12:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jWhSgK0k2cG7eHtX5HX8QeSK39FGItVinCLiL8XyLe8=; b=ajuIzQd4p1K5ncp3Q7JbMMv7ph
 47cJMM4kuphfkKjYuAlmzo3cCbjLfi0cQnobtLqx/z5NPiGk0za38AWDT2Ssl/PwtlRQAnMTys17A
 8JiijuJRnMVS5PrHFPswrzRnD35TMEu7H0GKHlwcrbAZ469s9hQvXiqf2mUysEykU4U4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jWhSgK0k2cG7eHtX5HX8QeSK39FGItVinCLiL8XyLe8=; b=U
 9Ztmq+EfQw3YGy+B6tDtMq2iqoSRpOjc8PqoJrjeAhWWE3XUP7pbzTLZmzg7na9fB3U5Vo+MIXgGN
 9pY8XhDZYdMZgvcnR7ImaBmiTI0adHMvrqKW1lqjYc7ULCXT1TwGJkwrTb9qVxlySjKzJGZxIcHug
 zDgTtS53KE0Vy9vM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0j4d-0001FY-EQ for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:12:05 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso25602975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788109917; x=1788714717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jWhSgK0k2cG7eHtX5HX8QeSK39FGItVinCLiL8XyLe8=;
 b=M6Aw+cAqvAccbcui3duKr5pLVcoMpJjKLU8hGazwBCY73WcvArEvcSDn5JcohH41B0
 7lHTvQI3kwCasRh6bSl/3D99LZBqPgPyDQZ/KC8a1ncbA2F+BCDcZh/lrjEqj20TaH6u
 UJ+9djm/tptXjqzF4FE09+Ez/H9uaXttdS0eM9ejX1/HqTrR/K4+LVsyJOPodGyS8tZf
 ew/xG6NSAGmZqXKladP0+WY9lBU365YLIuTYGwgqmqkk+7h03Ufkll1brFug6KNPL4eo
 tgFOtJh3XofkuukUEJBDOywWRNuNz7VYJ9qa/i1iDmhG7B0QuQ5kDKDMAPSax4VGXnL6
 dTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788109917; x=1788714717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jWhSgK0k2cG7eHtX5HX8QeSK39FGItVinCLiL8XyLe8=;
 b=FvmcHWXfOKEcjwij9DnxP7VT0hUOibSnNbNcO6H97oPr0xzdy/HZ72Jeclpri4tr2n
 v2MZFqTCtj2CoBkzRYdTjJX8KrMxhXr/mrNnizybs+y0LInVbQkdpPueoQn6yye2qL7x
 UpZ2GvtcOPN94EJcvLJjjgl+E1qW60F1aNNoa35Bcgi4nn6nc5J5X28yFxISDTx4qiOt
 Vn0qbE1jUqq0GWM76650QX8x8M6NlmQEu0F+BaRrA1mdR0/e8r5rYTimmNlVgCZda7IK
 Ra+cSO4v3tovlGjyFcrugm/1J4cWMHrXIXhskG6wn4U2QcnVUM+5ZeoulMRg/oPGvhNC
 hTyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF+vJSlqnm+wrLg3YNB+/a/yM98qB5J4WHmOW2UNOhhbirZLRoIAi3c2l4MT5jMpzlrYxjr1moFF9JSPaH@lists.sourceforge.net
X-Gm-Message-State: AFuF++nxM0VU6dSmoYVyRt1rieYVFTxCVmRQMYe6klCHr8KG7y2kULBl
 a4se2K8L0PcJyvXkZdxIyveKzNKldszMDERWIhLCRECZjlFNAhTf4BcJ1Uow18guWJp+ps0ZpMY
 k5LbNGCGp1cmhhARkDJkrwL7G+2oajbfpAuN5tf6MpEEWPc0ZS0MMEwX7CQR99OHhhzZwDB+ud7
 EtlERQJQ==
X-Gm-Gg: AR+sD12z8/81DCCRLQLqxI/kZmALJ7BCffokv3DoTzYg3laiWDobleRvxhXqp/IdrRQ
 nzutHEopTf1GDQ8EqqVCRKSh25TZZdW+YDEp1O8c7IY7fw11HrwNZPf0yJI/JOubqnDzwals3iU
 Nyua3gyz7eRvdVC65ZMwqHs2C8kBHogzmqXydCteQt6sfNmnaSS4ZJvp7yGJyGi/Mtrf2WwCLFd
 F0iU4csRErbbXBieDHDkWH4OOEJbDTVexhCR6gT2+u0t7k+z3xxaCABmjJKbp8pencg/k+VBq/S
 QdH7QuLEhXn6yHI0rKpTBWVMNQy3nnr+qXHL5auLAm5ANmBpTH8FKWUaL8Ii66mPHv4JJ1Mvbr+
 8ZWvhzLpN3mWGgE3a0o/pOZOjbBaBZPkr9uD8HmeVrIqOaJS8hG98daSM6MZhl4vNXmNS8SkOPr
 w2sEzzWcFdxMyqXZ1K0I6vcW10wdVddvF0qTJ/0iIrI8UY5kVrDqaMmhHLPjQOrTfJkqC6foi12
 zDWFZvS6Bs4bnUmnA55FUSp6EYzPbLBHyhV/mIMtjYzRhFMWfqULD/YarFnrMLbqYnKRkz7h1c3
 8ceJzdQIPmD3uHyM/od8EBZcNXrZ7OypgFcfv05hjgl+xh2akSk=
X-Received: by 2002:a05:600c:3145:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49b91c44f6cmr304954845e9.10.1788109916865; 
 Sun, 30 Aug 2026 10:11:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbad08d2sm19210760f8f.16.2026.08.30.10.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:11:56 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:11:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: dc162485236b70ecfe1be639dbd9db8244a85d54
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d7cf830c339118d3569275362be91297895ce14-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0j4d-0001FY-EQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Allow to override the location of t_client_ips.rc
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
Content-Type: multipart/mixed; boundary="===============1823326697193989445=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1823326697193989445==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LH31BF0pW08="; charset=UTF-8

--LH31BF0pW08=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1756?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Allow to overri=
de the location of t_client_ips=2Erc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Allow to override the locatio=
n of t_client_ips=2Erc

Makes it easier to use t_client=2Esh in other conte=
xts=2E

This is based on work by Gert Doering for the t_server
test infrast=
ructure=2E

Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Signed-off=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1756
Message-Id: <20260824180353=2E12076-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg38649=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 tests/t_client=2Erc-sample
M tests/t_client=2Esh=2Ein
M tests/update_t_cli=
ent_ips=2Esh
3 files changed, 12 insertions(+), 5 deletions(-)




diff --g=
it a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index 04714ef=
=2E=2E4c87436 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_client=
=2Erc-sample
@@ -18,8 +18,8 @@
 #FPING_EXTRA_ARGS=3D"-t 1000"
 
 # Load EXP=
ECT_IFCONFIG* parameters from cache
-if [ -r "${top_builddir}/t_client_ips=
=2Erc" ]; then
-    =2E "${top_builddir}/t_client_ips=2Erc"
+if [ -r "${t_c=
lient_ips_rc}" ]; then
+    =2E "${t_client_ips_rc}"
 else
     echo "NOTIC=
E: missing t_client_ips=2Erc will be auto-generated"
 fi
@@ -67,6 +67,12 @@=

 # PING6_HOSTS_x      =3D "these hosts musts ping when openvpn is up (IPv6=
 fping6)"
 # EXPECT_FAIL_x      =3D "instead of waiting for connection wait=
 for this error message"
 #
+# Note that the EXPECT_IFCONFIG{4,6} options a=
re not generally required, the
+# tests will remember the ip address they g=
ot on the first run in t_client_ips=2Erc
+# and will expect to get the same=
 address again=2E But it can be useful to hard-code
+# the IP when the serv=
er is expected to send a very specific address, e=2Eg=2E when
+# using ccd =
on the server-side or in a P2P scenario=2E
+#
 # hook test options:
 #
 # F=
PING_ARGS_x      =3D "arguments to append to the fping command line"
diff -=
-git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index dd7f743=2E=
=2E7c23020 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=
=2Ein
@@ -19,6 +19,9 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_b=
uilddir:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvp=
n}"
+t_client_ips_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Er=
c}"
+update_t_client_ips=3D"${update_t_client_ips:-${srcdir}/update_t_clien=
t_ips=2Esh}"
+
 if [ -r "${top_builddir}"/t_client=2Erc ]; then
     =2E "$=
{top_builddir}"/t_client=2Erc
 elif [ -r "${srcdir}"/t_client=2Erc ]; then
=
@@ -327,7 +330,7 @@
     # If EXCEPT_IFCONFIG* variables for this test are =
missing, run an --up
     # script to generate them dynamically=2E
     if =
[ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up=
=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-se=
curity 2 --up ${srcdir}/update_t_client_ips=2Esh"
+        up=3D"--setenv T=
ESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${updat=
e_t_client_ips}"
     else
         up=3D""
     fi
diff --git a/tests/upda=
te_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh
index 777a286=2E=2Ef0=
2dc7f 100755
--- a/tests/update_t_client_ips=2Esh
+++ b/tests/update_t_clie=
nt_ips=2Esh
@@ -3,8 +3,6 @@
 # This --up script caches the IPs handed out b=
y the test VPN server to a file
 # for later use=2E
 
-RC=3D"$TOP_BUILDDIR/=
t_client_ips=2Erc"
-
 grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/dev/null 2>&1=

 if [ $? -ne 0 ]; then
     echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_lo=
cal" >>$RC

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
56?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4a9a6bafb=
6bcb3fe331a92cfbb64be78f6aa33a
Gerrit-Change-Number: 1756
Gerrit-PatchSet: =
7
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--LH31BF0pW08=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1756?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Allow to override the =
location of t_client_ips=2Erc<br><br>Makes it easier to use t_client=2Esh i=
n other contexts=2E<br><br>This is based on work by Gert Doering for the t_=
server<br>test infrastructure=2E<br><br>Change-Id: Ia4a9a6bafb6bcb3fe331a92=
cfbb64be78f6aa33a<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756<br>Message-Id: &l=
t;20260824180353=2E12076-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38649=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M tests/t_client=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>M tests/upda=
te_t_client_ips=2Esh<br>3 files changed, 12 insertions(+), 5 deletions(-)<b=
r><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2E=
rc-sample</span><br><span>index 04714ef=2E=2E4c87436 100644</span><br><span=
>--- a/tests/t_client=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc=
-sample</span><br><span>@@ -18,8 +18,8 @@</span><br><span> #FPING_EXTRA_ARG=
S=3D&quot;-t 1000&quot;</span><br><span> </span><br><span> # Load EXPECT_IF=
CONFIG* parameters from cache</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-if [ -r &quot;${top_builddir}/t_client_ips=2Erc&quot; ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_builddi=
r}/t_client_ips=2Erc&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if [ -r &quot;${t_client_ips_rc}&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    =2E &quot;${t_client_ips_rc}&quot;</s=
pan><br><span> else</span><br><span>     echo &quot;NOTICE: missing t_clien=
t_ips=2Erc will be auto-generated&quot;</span><br><span> fi</span><br><span=
>@@ -67,6 +67,12 @@</span><br><span> # PING6_HOSTS_x      =3D &quot;these h=
osts musts ping when openvpn is up (IPv6 fping6)&quot;</span><br><span> # E=
XPECT_FAIL_x      =3D &quot;instead of waiting for connection wait for this=
 error message&quot;</span><br><span> #</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# Note that the EXPECT_IFCONFIG{4,6} options are not ge=
nerally required, the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# tests will remember the ip address they got on the first run in t_clien=
t_ips=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# and wil=
l expect to get the same address again=2E But it can be useful to hard-code=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# the IP when the s=
erver is expected to send a very specific address, e=2Eg=2E when</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# using ccd on the server-side=
 or in a P2P scenario=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#</span><br><span> # hook test options:</span><br><span> #</span><br><=
span> # FPING_ARGS_x      =3D &quot;arguments to append to the fping comman=
d line&quot;</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/=
t_client=2Esh=2Ein</span><br><span>index dd7f743=2E=2E7c23020 100755</span>=
<br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_clie=
nt=2Esh=2Ein</span><br><span>@@ -19,6 +19,9 @@</span><br><span> srcdir=3D&q=
uot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${top_buildd=
ir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_builddi=
r}/src/openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+t_client_ips_rc=3D&quot;${t_client_ips_rc:-${top_builddir}/t_clie=
nt_ips=2Erc}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
pdate_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t_client=
_ips=2Esh}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</s=
pan><br><span>     =2E &quot;${top_builddir}&quot;/t_client=2Erc</span><br>=
<span> elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><spa=
n>@@ -327,7 +330,7 @@</span><br><span>     # If EXCEPT_IFCONFIG* variables =
for this test are missing, run an --up</span><br><span>     # script to gen=
erate them dynamically=2E</span><br><span>     if [ -z &quot;$expect_ifconf=
ig4&quot; ] || [ -z &quot;$expect_ifconfig6&quot; ]; then</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        up=3D&quot;--setenv TESTNUM $SU=
F --setenv TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${srcdir}/=
update_t_client_ips=2Esh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        up=3D&quot;--setenv TESTNUM $SUF --setenv RC ${t_client_=
ips_rc} --script-security 2 --up ${update_t_client_ips}&quot;</span><br><sp=
an>     else</span><br><span>         up=3D&quot;&quot;</span><br><span>   =
  fi</span><br><span>diff --git a/tests/update_t_client_ips=2Esh b/tests/up=
date_t_client_ips=2Esh</span><br><span>index 777a286=2E=2Ef02dc7f 100755</s=
pan><br><span>--- a/tests/update_t_client_ips=2Esh</span><br><span>+++ b/te=
sts/update_t_client_ips=2Esh</span><br><span>@@ -3,8 +3,6 @@</span><br><spa=
n> # This --up script caches the IPs handed out by the test VPN server to a=
 file</span><br><span> # for later use=2E</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-RC=3D&quot;$TOP_BUILDDIR/t_client_ips=
=2Erc&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</sp=
an><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;EXPECT_=
IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt;$RC</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1756?usp=3Demail">change 1756</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1756?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa=
33a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1756 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--LH31BF0pW08=--


--===============1823326697193989445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1823326697193989445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1823326697193989445==--


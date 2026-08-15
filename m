Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CC4C5AD5A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G2t6TnvbrD9HWCzA2iYUd238gpWYJ7Ci71/bUrdiMRo=; b=MnMIHcpkIy56zFFrx5nVnE/zSc
	hiG1NDBYnqtruB0W47Xch3mMgzY22+lhyvJVkmLTlXw/EojZtRYXANdtBBX9cH3pbKKkAYXHB4TBQ
	M+A/u6TAicFsHZl1jB8Sj8stibZLLWhdXUV3lbzKMRjYvn6eQywVa8BAR51v6tbqNoGY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKUz-0000km-4N;
	Sat, 15 Aug 2026 19:56:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvKUk-0000kV-77
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kIo/wtyDmJx4GPWGm5IzHHompXkz4/IwWDR48WosUrg=; b=IQsnIerElsdeOWixxPJwNELtsO
 fjkKRBVaeYA0/xni9XLqcbdYlMA9/SvKBN0+6I3yJtY0wMBG2iwAi2TwhIApUbbAZ2jhylTcoPfn5
 wo0C3e9aHfREO2YhjJfYnS3S/A1Zet4LOd39rko+MfM74thjMFXG+sMycd2pmEWogSZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kIo/wtyDmJx4GPWGm5IzHHompXkz4/IwWDR48WosUrg=; b=C
 biRXTvXCObS+kL4t5jMZVLYzTfhzeEuR0teNmKmSwqJo0i74rTIi4nptLcyKvKh1Jixr3wQmRnv0e
 QDAbXNKZ/PW99eaD9P03vyIzfBiKJshUUZaTJLO7jZTt8v3bgcA7PcDdPZC2K7nbP07yPfpo0uUzP
 sw3p1MEfgYjtxqlI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvKUj-0003bK-TV for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:56:42 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so17484725e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786823795; x=1787428595; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kIo/wtyDmJx4GPWGm5IzHHompXkz4/IwWDR48WosUrg=;
 b=Gogelf7/HSIkKBiZrCe2NTwgunspv8/6F7qUNGtd76Sr8LEU4/yLGZUx7QDJwY3erz
 BNLE22DhfSIYwHEsBTHIkLxqYwhhbgkKOUR2Ntr8YlkLQa56U/mqWrE/WpXRLxrmDDy2
 xRwdgYKlB2xKtstGLxlQyyjQ/FJK6/wAReS9mrRh2s0b3UXwi/TCHyGAS5I/M5Z3aCbx
 z9POBYz8RVqbymaVccd/WYPnlFQaQxIethH6UZaKha46EbtQnFQnn6KeNLaOjv+G/xVK
 okvN+/S0J5J3k7q9wa8rIKW6r0RmaJO90TvLSlqchwMB4G0AWTciOfU8YNJ7eniPjcuV
 8zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823795; x=1787428595;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kIo/wtyDmJx4GPWGm5IzHHompXkz4/IwWDR48WosUrg=;
 b=IubB7eb50/Wk7kD3nkthVPKg9lEQqaaUNPahSq5EHxLv+B1BdcXTtvLXo3QN+hZYZQ
 BNqJi7FVgkuZE5PpatiTj3XlBrEPoYEyAbwat3mDkpOgrbTlrFIC7AxsRKphrzfPpWT+
 VPvY9KiIV/QSJQJ3GqH6gp3juKlOt3UO4Ok8AhnUciml+eikn+x2tKHmoJ7IAbMOJD5X
 JVmNkZLoVoKFaMieCycRe5Ip8DG7v8Aergg38LnKDSlzYaRru/ZkVKilJl6+JRv+D2Pp
 7cQFTd6jouZDDJt4WI6FIBBuiUrfwyMV4URsZUcg2EWOsMYMqzGJbT5I/mKJaBS13Fqi
 lXqA==
X-Gm-Message-State: AOJu0Yzgycr1XiWnx078yU0S3tjIRYEaLXpXga2rDp9RoXJ70Szve0q6
 doapB4ow/w5Wm0lAEQHgzltMZ6XhcoWLFuSxuTmn2eZJTao7tycBMjKRVpFqKkgGS6Y5SHYmUG0
 y3qakrlTGkeLCyaC1nj3BnfQvLilLeaJSicCVcucZ0JTZmBoj0h5+uFa86hb4pCBATeop
X-Gm-Gg: AR+sD13djpwNjgyPDo/ZOk/Smyymi5RVqtl4DqKUfTc5TTL0XK8k2pshlhoVVcIUsBL
 imxiDctqWl5+fSteEVuqP8T75+1IqgmdG+3KpqZdRQn+TaqOfO1LRoO39g3b51SCVmLKTw8SDvu
 2TwLp1kU787ZW/3WWQzmGz+FvFY+1IP7HMQE35WVrIpfB7VUC0ziqSeLZLpHVSZsGbfItLcU49E
 wsUWF/4W9/cWauXscPjC2miHtrMo83O4HthbivP8OckjNTzzUH+s0ZC0tLJI2LKTI47M+fBmddc
 0DAaeZZb1paseOS5qdREGrJl6TWJY4ISzE4jiH3ZOiit2bPm1nSaVyzMH5C4SN1fnSrzMylnvWC
 IWBka2bIf7xEs/Wrn03Bd2Gn9qXuQm4EM52UkfV7BHGvqz6g05RA5YS6LDtvqKxljhmwUFOfnwg
 IePfVKjyvd5ml7ouLziPhjmHHolfcPRFRqryot1arU3lfHIMtNRsRT5OSHI3XI4FILm9nLTdVKl
 9rh94v27nCwXz6E5A3scRQ0QvTdY7nINRMmzOiJtSS+FdDwuQrP/rOWSJmS9XSzRJqFi0h8LwUC
 ypfUtuKYii4cmjyryZRu6BunOhAWNQWwxbVBzjrVuMffB0esEMA=
X-Received: by 2002:a05:600c:3651:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4998797d3f9mr173892155e9.12.1786823794908; 
 Sat, 15 Aug 2026 12:56:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988aa2273sm156576155e9.0.2026.08.15.12.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:56:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 15 Aug 2026 19:56:32 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
X-Gerrit-Change-Number: 1562
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1562?usp=email>
X-Gerrit-Commit: 6f772b55f5ae4933b115b3e0cdd25e3c6718404c
In-Reply-To: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
References: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMDczNzUzMDAwLkllMGI5NGI1OTY2MzdkNjYwMzkyYmM0ZWRhNDhkMTZjZmVjZmViOTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3c911197028a429f070cb2783a94eb04a62da635-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvKUj-0003bK-TV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Avoid
 sign-compare warnings
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7911556852575917114=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7911556852575917114==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PFBT1l/k+CI="; charset=UTF-8

--PFBT1l/k+CI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: init: Avoid sign-compare warnings
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: Avoid sign-compare =
warnings

- Use BLENZ instead of buf_len where applicable
- Fix some compar=
isons with ce list length

Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfe=
b971
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1562
Message-Id: <20260815130856=2E20431-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38407=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 6 insertions(+), 16=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/62/1562/9

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=

index b8732dd=2E=2Ea90fe69 100644
--- a/src/openvpn/init=2Ec
+++ b/src/ope=
nvpn/init=2Ec
@@ -326,11 +326,6 @@
     return l->len;
 }
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC dia=
gnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 management_callbac=
k_remote_entry_get(void *arg, unsigned int index, char **remote)
 {
@@ -341=
,7 +336,7 @@
     struct connection_list *l =3D c->options=2Econnection_lis=
t;
     bool ret =3D true;
 
-    if (index < l->len)
+    if (l->len > 0 &=
& index < (unsigned int)l->len)
     {
         struct connection_entry *ce=
 =3D l->array[index];
         const char *proto =3D proto2ascii(ce->proto,=
 ce->af, false);
@@ -365,10 +360,6 @@
     return ret;
 }
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static=
 bool
 management_callback_remote_cmd(void *arg, const char **p)
 {
@@ -467=
,7 +458,6 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diag=
nostic push
 #pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC dia=
gnostic ignored "-Wsign-compare"
 #endif
 
 /*
@@ -639,8 +629,8 @@
     } w=
hile (!ce_defined);
 
     /* Check if this connection attempt would bring =
us over the limit */
-    if (c->options=2Econnect_retry_max > 0
-        &=
& c->options=2Eunsuccessful_attempts > (l->len * c->options=2Econnect_retry=
_max))
+    int max_attempts =3D l->len * c->options=2Econnect_retry_max;
+=
    if (max_attempts > 0 && c->options=2Eunsuccessful_attempts > (unsigned =
int)max_attempts)
     {
         msg(M_FATAL, "All connections have been c=
onnect-retry-max (%d) times unsuccessful, exiting",
             c->options=
=2Econnect_retry_max);
@@ -2167,7 +2157,7 @@
 static void
 add_delim_if_non=
_empty(struct buffer *buf, const char *header)
 {
-    if (buf_len(buf) > s=
trlen(header))
+    if (BLENZ(buf) > strlen(header))
     {
         buf_pr=
intf(buf, ", ");
     }
@@ -2256,7 +2246,7 @@
         buf_printf(&out, "se=
ssion-timeout %d", o->session_timeout);
     }
 
-    if (buf_len(&out) > s=
trlen(header))
+    if (BLENZ(&out) > strlen(header))
     {
         msg(D=
_HANDSHAKE, "%s", BSTR(&out));
     }
@@ -2293,7 +2283,7 @@
         }
    =
 }
 
-    if (buf_len(&out) > strlen(header))
+    if (BLENZ(&out) > strlen=
(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
     }

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0b94b596637d660392bc4=
eda48d16cfecfeb971
Gerrit-Change-Number: 1562
Gerrit-PatchSet: 9
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--PFBT1l/k+CI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">init: Avoid sign-compare=
 warnings<br><br>- Use BLENZ instead of buf_len where applicable<br>- Fix s=
ome comparisons with ce list length<br><br>Change-Id: Ie0b94b596637d660392b=
c4eda48d16cfecfeb971<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562<br>Message-Id:=
 &lt;20260815130856=2E20431-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38407=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/init=2Ec<br>1 file changed, 6 insertions(+), 16 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/62/1562/9</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/s=
rc/openvpn/init=2Ec</span><br><span>index b8732dd=2E=2Ea90fe69 100644</span=
><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/ini=
t=2Ec</span><br><span>@@ -326,11 +326,6 @@</span><br><span>     return l-&g=
t;len;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> static bool</span><br><span> management_callback_remote_entry=
_get(void *arg, unsigned int index, char **remote)</span><br><span> {</span=
><br><span>@@ -341,7 +336,7 @@</span><br><span>     struct connection_list =
*l =3D c-&gt;options=2Econnection_list;</span><br><span>     bool ret =3D t=
rue;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (index &lt; l-&gt;len)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (l-&gt;len &gt; 0 &amp;&amp; index &lt; (unsigned int)l-&=
gt;len)</span><br><span>     {</span><br><span>         struct connection_e=
ntry *ce =3D l-&gt;array[index];</span><br><span>         const char *proto=
 =3D proto2ascii(ce-&gt;proto, ce-&gt;af, false);</span><br><span>@@ -365,1=
0 +360,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> static bool</span><br><span> management_callback_remote_cmd(=
void *arg, const char **p)</span><br><span> {</span><br><span>@@ -467,7 +45=
8,6 @@</span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><=
br><span> #pragma GCC diagnostic push</span><br><span> #pragma GCC diagnost=
ic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</sp=
an><br><span> #endif</span><br><span> </span><br><span> /*</span><br><span>=
@@ -639,8 +629,8 @@</span><br><span>     } while (!ce_defined);</span><br><=
span> </span><br><span>     /* Check if this connection attempt would bring=
 us over the limit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (c-&gt;options=2Econnect_retry_max &gt; 0</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        &amp;&amp; c-&gt;options=2Eunsuccessful_=
attempts &gt; (l-&gt;len * c-&gt;options=2Econnect_retry_max))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int max_attempts =3D l-&gt;l=
en * c-&gt;options=2Econnect_retry_max;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (max_attempts &gt; 0 &amp;&amp; c-&gt;options=2E=
unsuccessful_attempts &gt; (unsigned int)max_attempts)</span><br><span>    =
 {</span><br><span>         msg(M_FATAL, &quot;All connections have been co=
nnect-retry-max (%d) times unsuccessful, exiting&quot;,</span><br><span>   =
          c-&gt;options=2Econnect_retry_max);</span><br><span>@@ -2167,7 +2=
157,7 @@</span><br><span> static void</span><br><span> add_delim_if_non_emp=
ty(struct buffer *buf, const char *header)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (buf_len(buf) &gt; strlen(he=
ader))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ=
(buf) &gt; strlen(header))</span><br><span>     {</span><br><span>         =
buf_printf(buf, &quot;, &quot;);</span><br><span>     }</span><br><span>@@ =
-2256,7 +2246,7 @@</span><br><span>         buf_printf(&amp;out, &quot;sess=
ion-timeout %d&quot;, o-&gt;session_timeout);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (bu=
f_len(&amp;out) &gt; strlen(header))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (BLENZ(&amp;out) &gt; strlen(header))</span><br><sp=
an>     {</span><br><span>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&a=
mp;out));</span><br><span>     }</span><br><span>@@ -2293,7 +2283,7 @@</spa=
n><br><span>         }</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (buf_len(&amp;out) &gt; st=
rlen(header))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><br><sp=
an>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><sp=
an>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Demail">change 1562</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0b94=
b596637d660392bc4eda48d16cfecfeb971 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1562 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--PFBT1l/k+CI=--


--===============7911556852575917114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7911556852575917114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7911556852575917114==--


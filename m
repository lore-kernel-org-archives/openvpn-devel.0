Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13970C79FAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QuHk1LSbP5SSDbSawFABzi8pXBrFfC7UQ7CvU5n2Dnc=; b=bqSY8oXoDnYfSs
	tmtYr1zRxMfGU8/D7KYHtwf5mwe15PhMvvZ2zBYh/tyBVbQQ1xpz5nTKeX5FebKFcI1tiDO1BZw9n
	KSl9bMyUk/yKf9H293lKXdXll7p8wvN2G0qpH9hOok+rJAsx0MXD4ulGuoib4xuFzDbILVIsidxat
	Tbk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3ylR-0005OL-Px;
	Tue, 08 Sep 2026 16:33:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ylP-0005OE-PQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q13Xa4aWAUR6gZPtMNtBByk9Q2W/poltgjqYtuGTvRE=; b=HaAW3+95CuI/kE4QPH2wkm8Dg0
 Qwapcg6sIDeb1E2xa7JboV+IZPHLIDI97J4CNsIovlZi4+DDK9SzFuBNMAPwVEa8ok7uD/TOr22sv
 MnL6vmUGYsesymtumRI2lTFSuoIpcoR7dvSPATDJ6b0NL4I4bAMgeG9+6Q2DHIXBxWO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q13Xa4aWAUR6gZPtMNtBByk9Q2W/poltgjqYtuGTvRE=; b=Y
 6v/CwiW03TQnr6lxFgToAv59Lgj9WFat/sRZxA/ZTK6hdgpPjY6mfYwmp5q8bLF7MW1lmFy+rbpE3
 j7RfzszoC5ZZ4Mc3verR9+AepmqPzw49m4i6iS+wPC/ZhTXBr2J9OLjHoNAYBNUa7CB39YFVJsadz
 Is4PbCTKqo1ZjFVE=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ylM-0008TA-CO for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:33:37 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so4587866f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788885210; x=1789490010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q13Xa4aWAUR6gZPtMNtBByk9Q2W/poltgjqYtuGTvRE=;
 b=f2uulNQ2mUWxRUmX2ulSyJiJkCsU+FBTPTQQussainVrjsYfAqrM+xQbHPu4OszJ9r
 JTaomLCciRSY74ZmDboT6CDbBlFO1KptnVrPZHK/tsmr6C5zU0y61HaU7xEO2bHNpDXK
 bg8BKvFSPrHzKw3FovQq3ZmxITocjaMVt2KrFTxq1kWDsNbyACtXnMyDupL+LXjfdKIn
 kQ+MGbqDYlKyYrY7HVQnrZpSEGu3JHWiLgZlvWcxYjqqDvbNHUQSd5Rj8Au15Hd8vcmv
 YVL/TC6Hflhgd708ORcCxQOLO9IYCN7J0113g8QfaBw/FB1Zeglc1+1+cAIlQLR53Vw3
 ilyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885210; x=1789490010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q13Xa4aWAUR6gZPtMNtBByk9Q2W/poltgjqYtuGTvRE=;
 b=BuAOMd0bDzOSBMQqnLnasuy8MQ2fFwXhxMaw8sXgcyRhWNAk67Te9bWSbGVIgmjwbg
 lYO+7HChRj4dSAUAI1qN53M+HsQnzxon4uqw4vkKEHPJAScKNdfBvN2Vnm5vCNPlTP6z
 g85wFt9oU/JPXPoLhmkGasXdzZnviGp+PTxRStrPGnyR2ISrmQYAz6+tU+CwvZDEb/D4
 JO4U6Q9UYABG6Al07Yu9p8rSk9Rvr743brykEAHcEqWXJj//ugCEqgQjUvpFwGBOl7ze
 kVZy196KkJREXw9lRO/TDpSUB6+apP0askR/heCDBFeg3u+xXX29NphsQvK/yZA8h9WL
 D+wg==
X-Gm-Message-State: AFuF++lukK+WJfSQ7B3BByszkdXH0xeyYocZcCwrsSfoXuo+u7wYtMaj
 KP0V+ULXcy++mIPiE29ZiP6mATcg8qP7sKJzMp/3iZ43EAdnkRRZjQINkRS5SXwKMbLL4Sg74BM
 XbR883RWDdrjlrcCJHHCsO9A8A1UicUlw3GJDguA78RilUucB1zakE/Kl9jz6Bul+FAoZ3/X95E
 1NjGunbA==
X-Gm-Gg: AYBFou1x99GmdX9FCYNLDS+pf0HdU/saE7gwgKqC6EYMI1AyL88fIg+7IHSBR4dG1lH
 jNJN46Ut/btF0XhVur7b15rdcw2lMwXNH1zbLP1/PAxmuLoZcdrug/7wD7nAAvtZVMKxSjwsw/V
 lholE/NdLtqLy/0OaBU3CZYGLxXjV8LMr4UkkpdRofUuQHZZvJEd5eLO2k6fq3v210tQYlp/jRe
 2bFsSj6613CISczlwn6RPjl2TOJJ+D0blsmQ88jtcKX6QeoUJBytXuVKnIriFyr3205gxL5dn9w
 sVZJYiU3z/Eqyv2hcLzFE7w/Y5i19kEY7c5JyJBrJ19DTg+5Ih5kt1baxzakiMjoReWV+6spagj
 MaBgNRhhWBsQyVCixtPx74ontwdrZCI8GVS1A9kop7jvar8s64YgjVttC1F0vifI8KN4RXYKvTO
 gjsNfJWRHriDO2KRpQhuMolmndVjd8l9JYrbz0q6f5PUOTaJ+yll/8O5qIBeZd8P9w6TgeIRS5p
 GA2vQsIP2RJN0NgjPgam15LIyf9WXtBMBek5fTdvf2t6sb4vpQdD9a6BTjhqZojKYnlnHKhO7ds
 DNCFaETMSM/cA6kxk4g6dfgLG8rXYoZtW39LLA2Y0KXh5jONynE=
X-Received: by 2002:a05:600c:6383:b0:49c:f4ff:e872 with SMTP id
 5b1f17b1804b1-49cf820507cmr271354815e9.5.1788885209642; 
 Tue, 08 Sep 2026 09:33:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1e728677sm13166105e9.2.2026.09.08.09.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:33:29 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 16:33:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1906
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1906?usp=email>
X-Gerrit-Commit: 52b30ac13a15b1577d77ec0a5e9dd258a4cf7bb3
References: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjA3MDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f0cf13f176a79a6ab8efb5496271e720eed7b2c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ylM-0008TA-CO
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: openvpnserv:
 don't allow '/' in config paths
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3363066161573876213=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3363066161573876213==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="70WiAT99qe0="; charset=UTF-8

--70WiAT99qe0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos, razvanc=2E

=
Hello plaisthos,

I'd like you to do a code review=2E
Please visit

    htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail

to review the foll=
owing change=2E


Change subject: openvpnserv: don't allow '/' in config pa=
ths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn=
serv: don't allow '/' in config paths

Do not allow forward slashes in user=
 provided config paths=2E The PathCch*
functions do not treat them as path =
separators, leading to "/=2E=2E/" not
being canonicalized=2E That, and the =
fact that Windows file APIs accept
forward slashes leads to possible direct=
ory traversal=2E

Discovered and reported by BreachX Zero Day Labs, using T=
yphon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Reported-by: V=
ivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Parikh <vivek=2E=
parikh@breachx=2Eai>
CVE: 2026-78043
Github: OpenVPN/openvpn-private-issues=
#162
Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Signed-off-by: He=
iko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885
=
Message-Id: <20260831184657=2E3332-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38855=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
(cherry picke=
d from commit eecebd88a38ffe1571d1a259da87f611b7b08e9c)
---
M src/openvpnse=
rv/validate=2Ec
1 file changed, 7 insertions(+), 2 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/06/1906/1

diff =
--git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec
index b=
0fb6b85=2E=2Ea59f9b1 100644
--- a/src/openvpnserv/validate=2Ec
+++ b/src/op=
envpnserv/validate=2Ec
@@ -72,8 +72,13 @@
     {
         return FALSE;
   =
  }
-    /* convert fname to full path */
-    if (PathIsRelativeW(fname) )=

+    /* do not accept forward slashes in paths, as PathCch* functions do n=
ot handle these */
+    if (wcschr(workdir, L'/') || wcschr(fname, L'/'))
+=
    {
+        return FALSE;
+    }
+    /* convert fname to full canonical=
 path */
+    if (PathIsRelativeW(fname))
     {
         openvpn_swprintf(=
tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
         config_file =3D =
tmp;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: I371aaf=
ba18d336bcfd3912e92c18301e39bf6087
Gerrit-Change-Number: 1906
Gerrit-PatchS=
et: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <h=
eiko@openvpn=2Enet>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--70WiAT99qe0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos, razvanc=2E </p>
<p>MaxF woul=
d like plaisthos to <strong>review</strong> this change=2E
</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail">View Change=
</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">openvpnserv: don&#39;t allow &#39;/&#39; in config pa=
ths<br><br>Do not allow forward slashes in user provided config paths=2E Th=
e PathCch*<br>functions do not treat them as path separators, leading to &q=
uot;/=2E=2E/&quot; not<br>being canonicalized=2E That, and the fact that Wi=
ndows file APIs accept<br>forward slashes leads to possible directory trave=
rsal=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typh=
on AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported=
-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek P=
arikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Github: Ope=
nVPN/openvpn-private-issues#162<br>Change-Id: I371aafba18d336bcfd3912e92c18=
301e39bf6087<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&=
gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885<br>Message-Id: &lt;20260=
831184657=2E3332-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38855=2Ehtml<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>(cherry picked =
from commit eecebd88a38ffe1571d1a259da87f611b7b08e9c)<br>---<br>M src/openv=
pnserv/validate=2Ec<br>1 file changed, 7 insertions(+), 2 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/06/1906/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/=
src/openvpnserv/validate=2Ec</span><br><span>index b0fb6b85=2E=2Ea59f9b1 10=
0644</span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++=
 b/src/openvpnserv/validate=2Ec</span><br><span>@@ -72,8 +72,13 @@</span><b=
r><span>     {</span><br><span>         return FALSE;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* convert fname=
 to full path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (PathIsRelativeW(fname) )</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* do not accept forward slashes in paths, as PathCch* function=
s do not handle these */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (wcschr(workdir, L&#39;/&#39;) || wcschr(fname, L&#39;/&#39;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* convert fname to full canonical path */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (PathIsRelat=
iveW(fname))</span><br><span>     {</span><br><span>         openvpn_swprin=
tf(tmp, _countof(tmp), L&quot;%ls\\%ls&quot;, workdir, fname);</span><br><s=
pan>         config_file =3D tmp;</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3De=
mail">change 1906</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1906?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1906 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cro=
n2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</=
body></html>
--70WiAT99qe0=--


--===============3363066161573876213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3363066161573876213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3363066161573876213==--


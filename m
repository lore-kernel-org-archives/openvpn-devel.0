Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EBAC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HSiedyFNs3lXXcdby7fofEPKiti3+Xxrr2htrt+JjJ0=; b=Y71P8ri9j6bP8YbkvytEVbifWt
	TVsbtZUewn17YtZerP2b5VKDxbLSNWOZmHeCWv6tDjm1dczU1wDULuldj3KBuVIslqiSI8EsZBN9T
	4uTGgUkSsKbMT9yzX3DlIJc3Amni0z8c3QLU49g0Bxl1fJzyqf07Ay+yZ4FKvVzb6C0Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfDtM-000739-VZ;
	Thu, 02 Jul 2026 09:39:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfDtM-000733-9Y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zEqyiXqB0SgmT5dOTfLNmMmUA82okPcsOFkeJ4/SIa8=; b=lkRMbOLqGCsXBHGhrFJmSPgl3m
 loA7NWh+SbTVuCh1MxM7wZdBuSZvwWO9WJsWuqD4tUk0Ekna3Ft9LgrG5Rei9BDd/TDEPxYFAOZSj
 s/3ezVNLVhkNAtoeGsfE+nnQGvLxZSDwV84L8ol/FGxH17WbNn8ns4XIQ3Rpb6kzq9hE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zEqyiXqB0SgmT5dOTfLNmMmUA82okPcsOFkeJ4/SIa8=; b=G
 ihEC8uB5I9ISDoxVRVosPVPzkxQYeSHoW4NOpTZuEYgvrq8Bt/TNKz8rOZdvtm6mFX/Vc9BWwTncg
 j8l0nD1THhlM3SgdWQnAz0yDCJNl7s2XV7dIJQz4mC6BiM6zHi5VbOoAE8v5IUF9oAqsEw49obENX
 VTLdcLIK5f4IULiY=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfDtL-0005n4-Ob for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:39:32 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so1043073f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782985161; x=1783589961; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zEqyiXqB0SgmT5dOTfLNmMmUA82okPcsOFkeJ4/SIa8=;
 b=E87yV/Mr5ForhoA42Ca4XAiF3oIMnA/ajM2CdO4KgcFcVsR8jnkg+Mmw5Q0IEUzdPD
 XLSpQMmdVHEvNIEyf/Q6YdDCeDSLadHTlRFBEbwpZezO9tIGblSRUrncDdeeY0RE442m
 zXQjEjGvkgBV9c5KTNfF68/8TmyfSVASPMgZRTdgkvv/eZtG65GGo6PaQ0VokmQykiox
 1Ss75VpAFEpl//NUFGw6FX2bBU9OU5Nt+M9APEdsA8tC++stOCQovk5i+J9Y6fG7NOCi
 keZoi1IxavvJ5kA4kEBfGgGqUpMrskfAroyS282BgCfVjqEDf951jy+4RESj46UuE/7P
 6O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985161; x=1783589961;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEqyiXqB0SgmT5dOTfLNmMmUA82okPcsOFkeJ4/SIa8=;
 b=Eod+dyKszEeH9Ov/pJ/9fi5NFI+Z/GtH4o9qzhJR7tvYKvvRQsMp+PGbsdKEjSvFfk
 sRrQfiOl3exsyblRI+w0j9xJ+puJe1OjLKnQG1TsXFqCKg/AtuC9EbjTzmaGMMdzbdIv
 V2DT1jV3sFcP8eS8FIqHwV98t3lYc0sHyOkSRjAzC+mgA8Av3VYtmRwkiyCsQm1ay2lg
 lDVXtwFJsfTgtX79FAcUZ+UMwtAMn6tBJbfNi88GmCcEu9jQ/JcsILYFycfkXlwl/KEl
 0eEU2asfwUqBXGm4p2oLRgiSojFWBnzkVnEle+9W6pU+dxQelxGT3t2US1FplS5P6pZf
 eAtA==
X-Gm-Message-State: AOJu0YxGPIKRhXd7+RxkyjoxwTI0xWPbnqVHaYv4YaXt6wWGoJXDYE6b
 SSshZ3Nx/hpXE05fiHNVqdjIf3tRCgeMFjH5gQET7hrS+z0Y9bdKpPVrql/LUYNbQsWeQPx9OVe
 xGuW1lmvGvS5WY4jU+quMvqsPxkre5AdghousgFsNLAQh+dSbJOt+2UyNt6cQu68w1Q3a
X-Gm-Gg: AfdE7cly9CPQWyGLqWXgP/cdzM1h3CBgoBpzzs7FSUHja4AVn7GMrQUtAcS9jkZff53
 jO4hd2nY3bZ71EKlrMvHucdqDK/NjNh4/211RS3MSlsZJx2WVDVUQ2i0I0ur0mk9HbqUVhQEDYw
 hJ4wvjtgs7qprf2bhdsmSQOZhkiF7rtmFOyl5apSbvShOYq8UVPoHNEq/00zLcbjOaf3ofTXTip
 puAp1I6S5xQoyuA7zOaP4TnoIXC5EMDgZ/KXRFG2u0mq1zve31gesSqovVx4wQYv13ii6JWzk4x
 g6sbPKnpL/uuBNjD5lo3qJFriMBOyZMYFKQfYUCA1ySF7xmZDgg+Fupyli8Ff64oO70hYDZEHMn
 rUj1v0QyRxaWn4LEz/KpAmJmX8MVJGRdpXQWBSv3RRQ9/xEt4mJGlyJOMuuca6L01Jj2F3AhcPY
 3rSa4xDnezRav8sOfn/4Im0lIub/cqc8iXxnS9x4LCnyQ99VeyDdixLbYJD4O+xVMdk1rsokFfp
 s7HG/s87c2mOsG9DpwnmBtpqIx/V6MoIeLOlr4maHXTD/q/yAm7Wo97z8w2SwsuEArdhdtMjy+J
 Wpc=
X-Received: by 2002:adf:ee52:0:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-477b4fb2bd3mr4773569f8f.34.1782985160633; 
 Thu, 02 Jul 2026 02:39:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94c829sm7033891f8f.24.2026.07.02.02.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:39:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 09:39:17 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
X-Gerrit-Change-Number: 1761
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1761?usp=email>
X-Gerrit-Commit: 7141f625c6114e08e40696464bfc36d5c5743683
In-Reply-To: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
References: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTIxNDk2MDAwLkliYTU3N2Q2NjJiMzg5ZGU1MzliODEwMzQ3MzVlNDM3MTk5Y2I0OTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <594c79781a6d3757a3e07550273641d46f19864e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfDtL-0005n4-Ob
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_tls_crypt: Fix
 issue with temp file name on big endian systems
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5783824320168702465=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5783824320168702465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dBV7kSgJwa4="; charset=UTF-8

--dBV7kSgJwa4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: test_tls_crypt: Fix issue with temp file nam=
e on big endian systems
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

test_tls_crypt: Fix issue with temp file name on big endian syst=
ems

Encountered by Fedora s390x build instances=2E

Change-Id: Iba577d662b=
389de539b81034735e437199cb495d
Signed-off-by: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761
Message-Id: <2026070207=
4746=2E3129-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg37454=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec
1 file changed, 7 insertions(+), 2 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/1761/2

diff --git=
 a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/t=
est_tls_crypt=2Ec
index 82b1dc8=2E=2E1d8ac25 100644
--- a/tests/unit_tests/=
openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2E=
c
@@ -722,8 +722,13 @@
 
     tls_options=2Etmp_dir =3D "/tmp";
 
-    /* S=
ince we override rand_bytes the tmpfile name is non-random as well */
-    =
const char *non_random_tmpfile =3D "/tmp/openvpn_tls_crypt_v2_metadata__706=
050403020100706050403020100=2Etmp";
+    /* Since we override rand_bytes th=
e tmpfile name is non-random as well=2E
+     * Build the expected name via=
 the same code path as
+     * platform_create_temp_file() */
+    char non=
_random_tmpfile[128];
+    snprintf(non_random_tmpfile, sizeof(non_random_t=
mpfile),
+             "%s/" PACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 "=
%08" PRIx64 "=2Etmp",
+             tls_options=2Etmp_dir, get_random(), ge=
t_random());
     unlink(non_random_tmpfile);
 
     expect_string(__wrap_b=
uffer_write_file, filename, non_random_tmpfile);

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
G=
errit-Change-Number: 1761
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--dBV7kSgJwa4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">test_tls_crypt: Fix is=
sue with temp file name on big endian systems<br><br>Encountered by Fedora =
s390x build instances=2E<br><br>Change-Id: Iba577d662b389de539b81034735e437=
199cb495d<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761<br>Message-Id: &lt;2026=
0702074746=2E3129-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37454=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests=
/unit_tests/openvpn/test_tls_crypt=2Ec<br>1 file changed, 7 insertions(+), =
2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/61/1761/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit=
_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>index 82b1dc8=2E=2E1d8ac25 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -722,8 +722,13 @@</=
span><br><span> </span><br><span>     tls_options=2Etmp_dir =3D &quot;/tmp&=
quot;;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* Since we override rand_bytes the tmpfile name is non-random as we=
ll */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *=
non_random_tmpfile =3D &quot;/tmp/openvpn_tls_crypt_v2_metadata__7060504030=
20100706050403020100=2Etmp&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* Since we override rand_bytes the tmpfile name is non-r=
andom as well=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * Build the expected name via the same code path as</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * platform_create_temp_file() */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char non_random_tmp=
file[128];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snpri=
ntf(non_random_tmpfile, sizeof(non_random_tmpfile),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             &quot;%s/&quot; PACKAGE &quo=
t;_tls_crypt_v2_metadata__%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2E=
tmp&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    tls_options=2Etmp_dir, get_random(), get_random());</span><br><span>   =
  unlink(non_random_tmpfile);</span><br><span> </span><br><span>     expect=
_string(__wrap_buffer_write_file, filename, non_random_tmpfile);</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1761?usp=3Demail">change 1761</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iba577d662b389de539b810347=
35e437199cb495d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--dBV7kSgJwa4=--


--===============5783824320168702465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5783824320168702465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5783824320168702465==--


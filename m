Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97606C61DB9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tPCM3c37H+A+eISuaW+JSH+KG+f6Fh+0nmq+HJeluPw=; b=e0DsjfmicMzJmJ
	wkX3tDV2Yw0gukgY44tgVOngZcmbGuIHZRB81hz3ReJFsJC5vXhQ+lAQL74IrwFhoAPonvprM3FrR
	4mz6VRubIgBn9pAiq/KmPXQUNbo6RJKQmFwVm9NZ8bjCtfi1SohFE39xcGCDUzJAqQk2gJMmhGjbt
	r0o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0lnu-00073X-O5;
	Sun, 30 Aug 2026 20:06:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0lnt-00073M-OE
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 20:06:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n7g5aN4zTgoHyq2XOS8OR9huYhCZNWAZvWHnSz/5Ie8=; b=hha1gnw6rRF6ZUgwXiAtWs/3Lz
 M1F+R7rZXm4A9xDiN0FsO9wAQL+44iZbpDO0GkuohQPUxx2835+cElxtKFur2aBNoHlZSFM2vWoEE
 3kUMv2IdK+iDZYnFRm0GuSt27fE+u0UixjBewdhAgRC3ioIo7aVjyaa8yIBSg/xp1gr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n7g5aN4zTgoHyq2XOS8OR9huYhCZNWAZvWHnSz/5Ie8=; b=R
 JhUaeL/jY5HVegawM9k6oSLJT4kMY6iwQ9PZ7zhwQQo6UTjADytCt36k09OgxJsoAGH+wa2hbLIkz
 4tZuHKQh6gsGWtuZvcliUIqA6QUiwGelaXEuN7cvUU9Q3d4CQuEiFMYZkSC5a8vAu/JIczpkLqTwb
 03dQvky0KJr0UwGo=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0lnt-0005J4-09 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 20:06:58 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso23307915e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788120410; x=1788725210; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n7g5aN4zTgoHyq2XOS8OR9huYhCZNWAZvWHnSz/5Ie8=;
 b=YQqrhzig2Bu2Y5zOq7ojIbvgkeF9rvOiO23ybk00MJORW5FxZ9BAUYkx924wH8g5ZO
 faFo8/dyvOoJunWc7HUj3s3Q5r5Z2ZhRPtDxrFGi56qYl/AtGA07wc9+dIqzilM/zIeU
 WSdaxs4q1rYxhlfKvPjyXPK+1v2WBkqKpZVEY++tkhKUuZhtwvluIKDITSPZRdr+s3Cu
 u53QzIh+ctlbNVTARxLhblAGIazUBFf4Pao0HoRnFaOtrdTq1z7uxgAEdh5ekRX8p+ao
 TUoFyMQt8jc2ce2C3sAjQgpCqQV39n3KU9KH6dW53uB04+KlwmoS5Nd+gJn/I+0UHjRp
 6RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788120410; x=1788725210;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n7g5aN4zTgoHyq2XOS8OR9huYhCZNWAZvWHnSz/5Ie8=;
 b=kLJKa65/qKMmhEHierr0Q94cfH55l/6rMnrRHsH4oyOQ9GOhTXeoZQdJKduMsV5uto
 QehFvaO7faA/Dng2BggmzjEkWR3SGvuVcgfgf2CVJd9eVhChM24DHbZLn8lAYbAEn2fZ
 DZhLc2D1OBF03qe6y4SRq92jcJ2PHrXoE75kfQG4Rz5R3Xzw6yhALExQNxTVLvMZq96L
 Vl3jxrobeOVADG44pdowoxKeiGTrFlUocMD+j0q9Hltl13QmXWBF0pNkVABLe+Zywic3
 q2mJXarGkJXc/FDhaHPYZn9FQl7KF6U6cSKjt1FAyj9FOIXePsdAboFQP2/OrMj0dred
 4oYQ==
X-Gm-Message-State: AFuF++k1PbfPiKdlPeGRbOnMqi2JEy0nvy1SAm80ec/Z1X0AU+U8PuU+
 NoeGf8bRsv0Gfzs6M5fHzGQuDgLggrinAqEjlKFtv4MitC6jTdPSI1sNCTp2DMIJv2nO3V3i9U5
 B8CqBkP5SAyNs2XJjSptHkWZxZEP5SoIaz6R39elS9T3pFBltybl6VKSShBBpIxP07RDcg2Xowo
 cdZ0GFBg==
X-Gm-Gg: AR+sD10UsNRunAaAup6LAiI6axGUPj/Nket4n3KImj3393hfFmE6TYVtzhZ4C5VvP8p
 FTg+NqObuZXJkHlPI4bxqKHwez94+Hw7Gt50oB/PvNA+syCg8pYZNtEjRxo7I54iH+49FrrqyAU
 4+X/VSuOOStpmRM32+kojsaJIcUx+gYcXguyE5Oevyr9Auo4VWNvpDrvlkqCpASQkFuZWLpA/ry
 +DWXzjNFs2JkMlfOfASOPRHmUjxxZqcv29OTOmgf9PVbMdh5spy9ZVqB//FzuK8+7Kn1BzQLXSY
 /E+lwEmqNiDcppsVJWBcD/S4BEYdCixg/dxjytIkSc/QrLMwdYBpWRgKbljd3h1nB4lfN1ywq0v
 oee58Tw76ZqtlJhKPqhsmHoRtRlb/YhjPyrhjBYTUw/lrpNVJizNd2wU+GCg1vH2cWrVzTFc9z9
 55yAyjQI5JE6OIU14YoIbjxRYnqlYVaYb0KSy2sXhXfmK/qHDPsyQ/H8awa1vVYNnpI6gkM70ZK
 B505PepXKPKYBau5MHRLEbYLydcopJeHEd2cF8mbrfjUZu8+fYmJG7OBc5IFe+gMGlMGY8BeWgI
 bfxh1XMf/S+wclvV1ulsQMGlJIn6QMxs6lF+uwhJ+sMeBjjd73Y=
X-Received: by 2002:a05:600c:8b35:b0:49c:d849:24cb with SMTP id
 5b1f17b1804b1-49cd8492589mr565595e9.6.1788120410187; 
 Sun, 30 Aug 2026 13:06:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb32ce2sm19752871f8f.33.2026.08.30.13.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:06:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 20:06:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1884
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1884?usp=email>
X-Gerrit-Commit: 38b64b3e3ca3389d31cf6854bf3536294800fe7f
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTIwNDA3MDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68fcbc6386b978467711a1721b57ae5042081442-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0lnt-0005J4-09
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dhcp: Fix off-by-one
 in write_dhcp_search_str() temp buffer guard
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4612203730323939725=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4612203730323939725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hs5XzFh3MnI="; charset=UTF-8

--hs5XzFh3MnI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1884?usp=3Demail

to review the following change=2E


Chang=
e subject: dhcp: Fix off-by-one in write_dhcp_search_str() temp buffer guar=
d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dhcp: Fix =
off-by-one in write_dhcp_search_str() temp buffer guard

Each search list e=
ntry consumes strlen(ptr) + 2 bytes of tmp_buf: one
leading label length by=
te, the domain characters, and one trailing NUL=2E
The guard only accounted=
 for strlen(ptr) + 1, so a sequence of entries
whose accumulated length lan=
ds exactly on the boundary passed the check
and then wrote tmp_buf[256], on=
e byte past the 256 byte array=2E

The existing "len > 255" check enforces =
the correct upper bound, but it
runs after that write has already happened=
=2E

The entries can be pushed by the server: --dhcp-option falls under
OPT=
_P_DHCPDNS, which pull_permission_mask() includes, and
validate_domain() im=
poses no length limit=2E

Reproduced under AddressSanitizer, which reports =
a one byte
stack-buffer-overflow at dhcp=2Ec:308=2E The added unit test cov=
ers the
boundary; it fails before this change and passes after it=2E The tw=
o
existing cases marked "maximum length" are unaffected, since a 253
charac=
ter domain still satisfies 253 + 0 + 2 <=3D 256=2E

This was reported indep=
endently by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=85n V=C4=83n=2E
Patch aut=
hor is Andre Kropp, recording the second report in the Reported-By:

CVE: 2=
026-81738
Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Signed-off-b=
y: Nexory <St4yl3r30@hotmail=2Ede>
Reported-By: Andre Kropp (Nexory)
Report=
ed-By: ChinhNguyen
---
M src/openvpn/dhcp=2Ec
M tests/unit_tests/openvpn/te=
st_dhcp=2Ec
2 files changed, 21 insertions(+), 1 deletion(-)



  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/1884/1

diff --g=
it a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index a54ab3f=2E=2E5cdcfcf=
 100644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -277,7 +27=
7,9 @@
     {
         const char *ptr =3D str_array[i];
 
-        if (str=
len(ptr) + len + 1 > sizeof(tmp_buf))
+        /* Each entry consumes strle=
n(ptr) + 2 bytes: one leading label length
+         * byte and one trailin=
g NUL=2E */
+        if (strlen(ptr) + len + 2 > sizeof(tmp_buf))
         =
{
             *error =3D true;
             msg(M_WARN, "write_dhcp_search=
_str: temp buffer overflow building DHCP options");
diff --git a/tests/unit=
_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index=
 104fc9a=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+=
++ b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -120,6 +120,24 @@
     asser=
t_memory_equal(BPTR(&out_buf), output_5, sizeof(output_5));
     assert_fal=
se(error);
 
+    /* Several entries whose accumulated length lands exactly=
 on the guard
+     * boundary=2E Each entry consumes strlen()+2 bytes of t=
mp_buf (one length
+     * prefix plus one trailing NUL), but the guard onl=
y accounts for
+     * strlen()+1, so the last entry writes one byte past t=
mp_buf[256]=2E
+     * Sizes: 4 x 50 leaves len =3D=3D 208, the final 47 ma=
kes
+     * 47 + 208 + 1 =3D=3D 256, which the guard still accepts=2E */
+#=
define D50 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+#define D4=
7 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+    const char *overfl=
ow_list[] =3D { D50, D50, D50, D50, D47 };
+    assert_int_equal(strlen(D50=
), 50);
+    assert_int_equal(strlen(D47), 47);
+    buf_clear(&out_buf);
+=
    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, overflow_list, 5, &=
error);
+    /* total is 257 > 255, so the option must be rejected -- the p=
oint of this
+     * case is that tmp_buf must not be written out of bounds=
 on the way=2E */
+    assert_true(error);
+    error =3D false;
+
     gc_=
free(&gc);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1884?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a=
886a1cac2d4725859dab2325cd362312ddc659
Gerrit-Change-Number: 1884
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>

--hs5XzFh3MnI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1884?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dh=
cp: Fix off-by-one in write_dhcp_search_str() temp buffer guard<br><br>Each=
 search list entry consumes strlen(ptr) + 2 bytes of tmp_buf: one<br>leadin=
g label length byte, the domain characters, and one trailing NUL=2E<br>The =
guard only accounted for strlen(ptr) + 1, so a sequence of entries<br>whose=
 accumulated length lands exactly on the boundary passed the check<br>and t=
hen wrote tmp_buf[256], one byte past the 256 byte array=2E<br><br>The exis=
ting &quot;len &gt; 255&quot; check enforces the correct upper bound, but i=
t<br>runs after that write has already happened=2E<br><br>The entries can b=
e pushed by the server: --dhcp-option falls under<br>OPT_P_DHCPDNS, which p=
ull_permission_mask() includes, and<br>validate_domain() imposes no length =
limit=2E<br><br>Reproduced under AddressSanitizer, which reports a one byte=
<br>stack-buffer-overflow at dhcp=2Ec:308=2E The added unit test covers the=
<br>boundary; it fails before this change and passes after it=2E The two<br=
>existing cases marked &quot;maximum length&quot; are unaffected, since a 2=
53<br>character domain still satisfies 253 + 0 + 2 &lt;=3D 256=2E<br><br>Th=
is was reported independently by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=85n =
V=C4=83n=2E<br>Patch author is Andre Kropp, recording the second report in =
the Reported-By:<br><br>CVE: 2026-81738<br>Change-Id: I6a886a1cac2d4725859d=
ab2325cd362312ddc659<br>Signed-off-by: Nexory &lt;St4yl3r30@hotmail=2Ede&gt=
;<br>Reported-By: Andre Kropp (Nexory)<br>Reported-By: ChinhNguyen<br>---<b=
r>M src/openvpn/dhcp=2Ec<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>2 f=
iles changed, 21 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/1884/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><s=
pan>index a54ab3f=2E=2E5cdcfcf 100644</span><br><span>--- a/src/openvpn/dhc=
p=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@ -277,7 =
+277,9 @@</span><br><span>     {</span><br><span>         const char *ptr =
=3D str_array[i];</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (strlen(ptr) + len + 1 &gt; sizeof(tmp_buf))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Each entry con=
sumes strlen(ptr) + 2 bytes: one leading label length</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * byte and one trailing NUL=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen=
(ptr) + len + 2 &gt; sizeof(tmp_buf))</span><br><span>         {</span><br>=
<span>             *error =3D true;</span><br><span>             msg(M_WARN=
, &quot;write_dhcp_search_str: temp buffer overflow building DHCP options&q=
uot;);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec =
b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index 104fc9a=2E=
=2E3a84e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_dhcp=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br=
><span>@@ -120,6 +120,24 @@</span><br><span>     assert_memory_equal(BPTR(&=
amp;out_buf), output_5, sizeof(output_5));</span><br><span>     assert_fals=
e(error);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Several entries whose accumulated length lands exactly on th=
e guard</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * bound=
ary=2E Each entry consumes strlen()+2 bytes of tmp_buf (one length</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * prefix plus one trail=
ing NUL), but the guard only accounts for</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * strlen()+1, so the last entry writes one byte =
past tmp_buf[256]=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * Sizes: 4 x 50 leaves len =3D=3D 208, the final 47 makes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * 47 + 208 + 1 =3D=3D 256,=
 which the guard still accepts=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define D50 &quot;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaa&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D47 &quot;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *overflow_l=
ist[] =3D { D50, D50, D50, D50, D47 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(strlen(D50), 50);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(strlen(D47), 47)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp=
;out_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    write=
_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, overflow_list, 5, &amp;e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* total =
is 257 &gt; 255, so the option must be rejected -- the point of this</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * case is that tmp_bu=
f must not be written out of bounds on the way=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(error);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    error =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     gc_free(&amp;g=
c);</span><br><span> }</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?=
usp=3Demail">change 1884</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1884?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1884 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--hs5XzFh3MnI=--


--===============4612203730323939725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4612203730323939725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4612203730323939725==--


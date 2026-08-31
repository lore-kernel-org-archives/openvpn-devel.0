Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4834FC624D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7OfuTqB5xuTOBr51lJXNDrEamZ+aaIHVs1CT5YzyXtQ=; b=F+GIkNYEvCqn2UCFuuQtD2jAc7
	QfP0Fr/0mfhijxUF4jI+FRx/Dktsg/6Tqd4f/1lBFMmaGlOZk9McNwWVPpDdnUcLEDgbfMPRRk4O/
	IQgwZYIuIxOHjd1xbdgPWQhY+fGjFtbdtArMz6DN3sSqDGF5ubNRFBzq8MwXrJl3sQHM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x12Am-0003fE-JT;
	Mon, 31 Aug 2026 13:35:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x12Ak-0003f8-UB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:35:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HS6FaPj6yrnqhGdBWsksKkJ53B3fUBdGsxAyDb+0Arc=; b=Ysp30D7YSmr6nLw8L7xfz9bfsi
 npCw+NcOD3hFh4QvUfaSaMI+0PialPPNhHSS4oNHxEtUIbpL9cj7clDxaaWjVtcuTvrHLJYQZvfjc
 3j/kU4yqfX5FlAcVQoGKp0Zo9xjRDzyKtTjlyU15Hc3yJWjLF/MhPIwWb0FVc3vy9uQk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HS6FaPj6yrnqhGdBWsksKkJ53B3fUBdGsxAyDb+0Arc=; b=Z
 Aw1wPgojlTibr1GWUsrpvUWznl62PzWrTg6dFcGFIG5XW27o+WdB3C5l4H2nKoxtOD1iJ1QvB1a3X
 b6t5NOwLuUS8UHlTzu49z69QrHMGvZzYAOaVrKNrwqQczJRfnLFf6msiDGMxOLyMNgDZMRAIWoSEu
 FXESJe335Sink9iY=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x12Aj-0003U7-Bm for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:35:39 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso34508035e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788183331; x=1788788131; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HS6FaPj6yrnqhGdBWsksKkJ53B3fUBdGsxAyDb+0Arc=;
 b=KnSEfuShEp1CxAodxnWeBvn8wFVcELHaQVVPvqdMwFHtBkLgmesNcwAv02C6F9iRed
 NMm2WnkwxRdbIaJdlufnGp0H/hVw2k3LaGkS9i7cXQs1hvaWkBEBOmocJE3loRXfBoPE
 8zwyRlWFPSf9Nv4XH9BV6lsm8DS5/MXCAZCK+wlq81V5NQlyT/dOlqmFbAWyhVuSGZEM
 DkPHyw2Y8C2jwBYKARw1bXiIlPnHGmrHv/6NBdVMgZX6Oy/txNh6gwOkHhInZnPt47CO
 YJVZuwlmzY67G7FXG+boAvYm0ZljoMLDhNx7IB9gplaAQD2D4GhKLHyTBU0xmqj7tDZl
 TC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788183331; x=1788788131;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HS6FaPj6yrnqhGdBWsksKkJ53B3fUBdGsxAyDb+0Arc=;
 b=E+CCCWPGtSlooVNeEtTMfqJDEh/2MU0y4A3aXx4XFNy2ZxGh5R3Fg1Hy+1qCpxo847
 ++HIWpCWxI6pj490eTiugy1qUtrXOYTifdHhATmBklQT8lH5idKryVazUjPEwIRwd1/s
 XTDmvlUc8pXQgTaSSi4Vpi2l5V8Yz+YhXvHcLsBTfcAXutfyWvHSGBAa6KRdI9FRN6KO
 fWKAUW2WrjbRaGInTv3iYyc0qpIgdX9pWOgjMnSfh6Ww9DWuJCW0qHsDg4xBASCLa6pB
 cEXkH/6Y6nn9PRfzX0JlfrL1FOVEN492z8jOjs/tS4P9EMOp583owqmEmQEID7a0vREa
 UUug==
X-Gm-Message-State: AFuF++nS2Dc6WSrJWN9U9hrY/5ehTq1vZGynTR7YuRCcxMa6kVDXJ4jV
 I0OIfJ2sCRLfqdVRPOJ/XXtCk6Xm6gT1vXFyOwNAKtAvVOLz9i64oHCc0ehQrtWNxZ0BEzeiu7k
 stOoF7/184j703hYV2HYXZE7G3KbVFdU3M5n64xFLlOTOl10Vg0Lor0ZsHyo16gFlJCTV
X-Gm-Gg: AR+sD11RlKZ1LyrbGXOIuhq7KU119FbTnbKXY6UXT1njRbw8LoGPyokKIsV/yFC0wN5
 FwNZrXxRFInzDzoxly5hXGpkCmyoOYNN9Y/N3dDTiDD37/mGgB6EZsvTf2Wl+0WWcDg7cwh0lHW
 NYHMTFx5ROwkk3AP1XGS6sb4k2VuCsKdq0eJ8V2/Q1YKDjNdTeJscBudz6JxMDzo7rJzLECeJ7W
 8w2YwsvsE7I1ISUJF8uHZl9s4esJKBFxQpkLUswXE5Wwt0SFtQSY/mEWnLz2IhdYmxeJ+VoDWZz
 1nKVWATUGnbFNvJ2Mc2T9TqLaDKWfozA5PI7IcDTvrcqlQkcHSDtpnoLHYmBoZo4DxEnVSJZg5d
 fvHfIaTdGAJKWlprHMMPJThIH3nHZ3SLkG9oRfOU4YIu9vQ68MqqraAip6y1X37Uul2BviYAtID
 xkgDKPm5zzV9p9o9lqCd7/D1HMqXuJ1A49jn1wU15u80kQlsUD5zf4YlpbR2SZk2xHVoeVzZLJz
 ynGAFJJf+nR94ezahzo1n1uPhs5aoyMx1RuV5Tu+hyLh0lzuLNOBLf6oZg73w6t6hZuhhckltWF
 B73OY+gg6YmJ60E/CXeNoUnjRfW3g6e5gxVotbVrn00uMeZaRMpy
X-Received: by 2002:a05:600c:64c6:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-49cdc558470mr11677875e9.11.1788183330590; 
 Mon, 31 Aug 2026 06:35:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm23495628f8f.36.2026.08.31.06.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:35:29 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 13:35:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1884
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1884?usp=email>
X-Gerrit-Commit: 1ece6fe6fd586501b486aac6932d424c167a3adb
In-Reply-To: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTIwNDA3MDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3543ceed88bac716f03b019b52c0ae6084c57983-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x12Aj-0003U7-Bm
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7634130078841279747=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7634130078841279747==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JQXCJbfrBhM="; charset=UTF-8

--JQXCJbfrBhM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

Hello plaisthos, razvanc, 
=

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1884?usp=3Demail

to look at the new patch set (#3)=
=2E

The following approvals got outdated and were removed:
Code-Review+2 b=
y cron2, Code-Review+2 by razvanc


Change subject: dhcp: Fix off-by-one in=
 write_dhcp_search_str() temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dhcp: Fix off-by-one in write_dhcp_search_s=
tr() temp buffer guard

Each search list entry consumes strlen(ptr) + 2 byt=
es of tmp_buf: one
leading label length byte, the domain characters, and on=
e trailing NUL=2E
The guard only accounted for strlen(ptr) + 1, so a sequen=
ce of entries
whose accumulated length lands exactly on the boundary passed=
 the check
and then wrote tmp_buf[256], one byte past the 256 byte array=2E=


The existing "len > 255" check enforces the correct upper bound, but it
r=
uns after that write has already happened=2E

The entries can be pushed by =
the server: --dhcp-option falls under
OPT_P_DHCPDNS, which pull_permission_=
mask() includes, and
validate_domain() imposes no length limit=2E

Reproduc=
ed under AddressSanitizer, which reports a one byte
stack-buffer-overflow a=
t dhcp=2Ec:308=2E The added unit test covers the
boundary; it fails before =
this change and passes after it=2E The two
existing cases marked "maximum l=
ength" are unaffected, since a 253
character domain still satisfies 253 + 0=
 + 2 <=3D 256=2E

This was reported independently by Andre Kropp and Ch=C3=
=ADnh Nguy=E1=BB=85n V=C4=83n=2E
Patch author is Andre Kropp, recording bot=
h reports in the Reported-By:

CVE: 2026-81738
Change-Id: I6a886a1cac2d4725=
859dab2325cd362312ddc659
Signed-off-by: Nexory <St4yl3r30@hotmail=2Ede>
Ack=
ed-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1884
Reported-By: Andre Kropp (Nexory)
Reported-By: ChinhNguyen
Message-Id=
: <20260831083449=2E12484-1-gert@greenie=2Emuc=2Ede>
Signed-off-by: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dhcp=2Ec
M tests/unit_tes=
ts/openvpn/test_dhcp=2Ec
2 files changed, 21 insertions(+), 1 deletion(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/1884=
/3

diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index a54ab3f=
=2E=2E5cdcfcf 100644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
=
@@ -277,7 +277,9 @@
     {
         const char *ptr =3D str_array[i];
 
-  =
      if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
+        /* Each entry c=
onsumes strlen(ptr) + 2 bytes: one leading label length
+         * byte an=
d one trailing NUL=2E */
+        if (strlen(ptr) + len + 2 > sizeof(tmp_bu=
f))
         {
             *error =3D true;
             msg(M_WARN, "writ=
e_dhcp_search_str: temp buffer overflow building DHCP options");
diff --git=
 a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_d=
hcp=2Ec
index 104fc9a=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/te=
st_dhcp=2Ec
+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -120,6 +120,24 =
@@
     assert_memory_equal(BPTR(&out_buf), output_5, sizeof(output_5));
  =
   assert_false(error);
 
+    /* Several entries whose accumulated length =
lands exactly on the guard
+     * boundary=2E Each entry consumes strlen()=
+2 bytes of tmp_buf (one length
+     * prefix plus one trailing NUL), but =
the guard only accounts for
+     * strlen()+1, so the last entry writes on=
e byte past tmp_buf[256]=2E
+     * Sizes: 4 x 50 leaves len =3D=3D 208, th=
e final 47 makes
+     * 47 + 208 + 1 =3D=3D 256, which the guard still acc=
epts=2E */
+#define D50 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
"
+#define D47 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+    const=
 char *overflow_list[] =3D { D50, D50, D50, D50, D47 };
+    assert_int_equ=
al(strlen(D50), 50);
+    assert_int_equal(strlen(D47), 47);
+    buf_clear=
(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, overfl=
ow_list, 5, &error);
+    /* total is 257 > 255, so the option must be reje=
cted -- the point of this
+     * case is that tmp_buf must not be written =
out of bounds on the way=2E */
+    assert_true(error);
+    error =3D fals=
e;
+
     gc_free(&gc);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1884?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Gerrit-Change-Number:=
 1884
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: cron2 <gert@greenie=2Emuc=2Ede>

--JQXCJbfrBhM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>cron2 <strong>uploaded patch set #3<=
/strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1884?usp=3Demail">View Change</a></p><p>The following approvals =
got outdated and were removed:
Code-Review+2 by cron2, Code-Review+2 by raz=
vanc</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">dhcp: Fix off-by-one in write_dhcp_search_str() temp =
buffer guard<br><br>Each search list entry consumes strlen(ptr) + 2 bytes o=
f tmp_buf: one<br>leading label length byte, the domain characters, and one=
 trailing NUL=2E<br>The guard only accounted for strlen(ptr) + 1, so a sequ=
ence of entries<br>whose accumulated length lands exactly on the boundary p=
assed the check<br>and then wrote tmp_buf[256], one byte past the 256 byte =
array=2E<br><br>The existing &quot;len &gt; 255&quot; check enforces the co=
rrect upper bound, but it<br>runs after that write has already happened=2E<=
br><br>The entries can be pushed by the server: --dhcp-option falls under<b=
r>OPT_P_DHCPDNS, which pull_permission_mask() includes, and<br>validate_dom=
ain() imposes no length limit=2E<br><br>Reproduced under AddressSanitizer, =
which reports a one byte<br>stack-buffer-overflow at dhcp=2Ec:308=2E The ad=
ded unit test covers the<br>boundary; it fails before this change and passe=
s after it=2E The two<br>existing cases marked &quot;maximum length&quot; a=
re unaffected, since a 253<br>character domain still satisfies 253 + 0 + 2 =
&lt;=3D 256=2E<br><br>This was reported independently by Andre Kropp and Ch=
=C3=ADnh Nguy=E1=BB=85n V=C4=83n=2E<br>Patch author is Andre Kropp, recordi=
ng both reports in the Reported-By:<br><br>CVE: 2026-81738<br>Change-Id: I6=
a886a1cac2d4725859dab2325cd362312ddc659<br>Signed-off-by: Nexory &lt;St4yl3=
r30@hotmail=2Ede&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884<br>Reported-By: Andre Kr=
opp (Nexory)<br>Reported-By: ChinhNguyen<br>Message-Id: &lt;20260831083449=
=2E12484-1-gert@greenie=2Emuc=2Ede&gt;<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dhcp=2Ec<br>M tests/unit=
_tests/openvpn/test_dhcp=2Ec<br>2 files changed, 21 insertions(+), 1 deleti=
on(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/84/1884/3</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dhcp=2Ec =
b/src/openvpn/dhcp=2Ec</span><br><span>index a54ab3f=2E=2E5cdcfcf 100644</s=
pan><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/=
dhcp=2Ec</span><br><span>@@ -277,7 +277,9 @@</span><br><span>     {</span><=
br><span>         const char *ptr =3D str_array[i];</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strlen(ptr) + l=
en + 1 &gt; sizeof(tmp_buf))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Each entry consumes strlen(ptr) + 2 bytes: one leading =
label length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * byte and one trailing NUL=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (strlen(ptr) + len + 2 &gt; sizeof(tmp_buf))</sp=
an><br><span>         {</span><br><span>             *error =3D true;</span=
><br><span>             msg(M_WARN, &quot;write_dhcp_search_str: temp buffe=
r overflow building DHCP options&quot;);</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec<=
/span><br><span>index 104fc9a=2E=2E3a84e1e 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_dhcp=2Ec</span><br><span>@@ -120,6 +120,24 @@</span><br><span>=
     assert_memory_equal(BPTR(&amp;out_buf), output_5, sizeof(output_5));</=
span><br><span>     assert_false(error);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Several entries whose accumul=
ated length lands exactly on the guard</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * boundary=2E Each entry consumes strlen()+2 bytes =
of tmp_buf (one length</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * prefix plus one trailing NUL), but the guard only accounts for</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * strlen()+1, so =
the last entry writes one byte past tmp_buf[256]=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Sizes: 4 x 50 leaves len =3D=3D 20=
8, the final 47 makes</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * 47 + 208 + 1 =3D=3D 256, which the guard still accepts=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D50 &quot;aaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D47 &quot;aaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaa&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *overflow_list[] =3D { D50, D50, D50, D50, D47 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(st=
rlen(D50), 50);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(strlen(D47), 47);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_clear(&amp;out_buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    write_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN=
_SEARCH, overflow_list, 5, &amp;error);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* total is 257 &gt; 255, so the option must be rej=
ected -- the point of this</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * case is that tmp_buf must not be written out of bounds on the=
 way=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
rror =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail">change 1884</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a886a1cac2d47258=
59dab2325cd362312ddc659 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1884 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--JQXCJbfrBhM=--


--===============7634130078841279747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7634130078841279747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7634130078841279747==--


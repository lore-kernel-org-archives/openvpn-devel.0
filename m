Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423B4C624CE
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsDVheUnErZolDXzSIB7z+csf+yU8PemF6aANRugPMw=; b=OLPB8j8rPJnck5YTReQvxbe+hP
	DbJVHT+WSEY/cVFD8/wuAdYJMOmDMCPsHIcxMTrsAfEgTjJq6qVLd4WS8v8U19J7NzCF5iKjCOTvA
	H6R/dUTcS3wAivVvFL3zX1QRnGvCCDQmANoIIIO8jPggLhWTvJD3nzEYKC6MGGm7VWPE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x12Ao-0003sn-5V;
	Mon, 31 Aug 2026 13:35:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x12Am-0003sh-M2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lS2FaNRjZz0Z6EVFKjrZNDUepzkLhtcRazZWjA28iws=; b=YZsx0WBiLArDkTjdZDsGk9Ts7I
 k2dOxPDQ1l+c+cqTHTWxXdc+CXEQ2vA23YN9ZvGMMxxoXBqxdTT3RGoJbBFxbtwF7Z0vSSVLaGb8+
 FUNiWkddnlH8SmSmSvZxNbncIuuQZ//fQJ7dbsuB9FcVZCe0HUK/4Q8WHVHD9swfFFAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lS2FaNRjZz0Z6EVFKjrZNDUepzkLhtcRazZWjA28iws=; b=N
 2HqvSp6k/QytBXNrH2bnTLxx9z88BxquNIpDMkm0AJPT7ODJJEjhaiG8dN1uyz5DQiSnnHNVgI59l
 oNnITpNRm4d2g//3aBioXxOjPgkPBf5jrcIvrI8dF642wolMZDmtsgKnOnlJJNpI2xYB79zNW26T5
 5LPQfwT8JgqkhF3o=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x12Al-0003UA-LK for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:35:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso48899675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788183333; x=1788788133; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lS2FaNRjZz0Z6EVFKjrZNDUepzkLhtcRazZWjA28iws=;
 b=KsIvBVQxxmUC+g3OCsXM0ogk4oAK++iAJ0UC2xA9pZnxl2RkR1KvAdJV86IesL3PH6
 cGETXN6z2vAkz9O3IvMi7M61l4GMeI+9nt2byBaqau9MkUitL0VkzOjICODJybS2aTlD
 oj8ERJbeTY24tcqCa8DlYJ4vBpkBaGbD6jqOHAgck+9V29kUxWkGY6YWa/C9t8jJfE9k
 MkJBji/QlklmkJgJew68mFfLwRiVSHm3LZslADgzvAHgv/8nIi6JAcfs+BvWTbVclQuM
 u0I3gEWCYOZdNf78+BkRax9xrEAQEFASQ14qVdg6xIvm4Fl0RPzbnaAw9HFEXM99DVdd
 Yrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788183333; x=1788788133;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lS2FaNRjZz0Z6EVFKjrZNDUepzkLhtcRazZWjA28iws=;
 b=rMc8CPoc9JHzvdudVbfy3FaEaYE5gNs4r1Mya3CundqYS8ZNvUR9Mrn86Mr7FC7k97
 A+ejHCjCTyPwcy8CfGg0dZaEQhoRlYBle9iUDIzkqZH3gpLwvHmi1Aia596Ned4c0Aoa
 ywN0iEotNKhVeIF+LM4l22cxF/ZvTjL6/jLdqJAAqab8EqHDQR4+m+u+Ni55LEbJhA9p
 itTpQKDlJayPpsu1PWYz0dE3P09vH6ISqmX+4mA8xxzv4Lgs3NDMHPlcnQY03wkeh11i
 PYkC20/Nc2lEmw649MhaN0ukYFZIeW8b1imhlmHQwr8TFqF0+NYg18oT6gPhbpb2vyN3
 iM3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ropg/fMz6fjtn4+CqHTrqBhCi6X84mWUOqTBfQKP7A8y6B/Kdr90p8gl7kmwMZzRSP2rLnaTuYoK/BiPO4f@lists.sourceforge.net
X-Gm-Message-State: AFuF++nKzs5TAIg+I6mAs9U2UhfmOGvzRaOscbCMNZt6+BEdr/cCnWeb
 f0/PXRQy4cntqS11eQIXS5IUTABgV3c30Q5cwxbftBFwkuinsejUCjKW3fFO5uI9aFwMH1o/VYv
 GtHCdC6bNUuofUEmA9UHdiB2au68KXo8EbMwFt9Bw9j8T7wR1shDhiLfHl7AOqv+RnHtG
X-Gm-Gg: AR+sD10fSHDvKbhIG6TWMjNLhTb2J/jt4uPWuQXE7I1HDCWSYKr/tyzT7ei0f5pI3uZ
 DBwuiztH2siDKI1o5/8nedwYVx6gu9YCMrPEQuw7g+8s7W7LEXCfs/G6tmPgSnP1JvcGif8cEES
 j2lAESv4KVWR1msp711N18i7RXGREWfjgrQDG2HWlNwaCaMG6sH868uShkEb1mUijvRsCMy0z7d
 ajS8+IHhEv0GojX7uR6djsecvdbPEg7J4sRjsCZmRXKg4IU5ubwZftqhWKGLCPvVxWe4xQI3SPS
 g0IS954+XiFHetPl+YSykj6pofRwNTGPVX5WGFaDOFoKpBWfZC7lO5hir4sVoyJYNBij+ZdCLgM
 WnXaYcF8vfSMkhZoq0WA74HVhx+iPIM/y30OdG8dEgnwu6zJbBHBOcXrRqHX4FNF5MmYmbGXLSt
 ucRRSPf0SOxwOA5YIepO2QHJotUDNodjIPcqy+pYZufdexhBwkr4dfG9i23e182vG8xkww0PLRb
 453edKMe/Z5vRXlHqt+6NKUItq882UtV89nhm3YfT+CMNMPCfGkre4p6EsPIJbLRnKv33zfYf6d
 5dZ11XK7Yv2QB/sR6OjjHI+NhFC53hnwaodycQQAX9zgu0VAoay1
X-Received: by 2002:a05:600c:a012:b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49cd81887aemr86765715e9.11.1788183331434; 
 Mon, 31 Aug 2026 06:35:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccae954f9sm219462255e9.13.2026.08.31.06.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:35:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 13:35:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1884
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1884?usp=email>
X-Gerrit-Commit: 1ece6fe6fd586501b486aac6932d424c167a3adb
In-Reply-To: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTIwNDA3MDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3543ceed88bac716f03b019b52c0ae6084c57983-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x12Al-0003UA-LK
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5212728796605225209=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5212728796605225209==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hXi4DYiuizQ="; charset=UTF-8

--hXi4DYiuizQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

cron2 has submitted this ch=
ange=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail )

Cha=
nge subject: dhcp: Fix off-by-one in write_dhcp_search_str() temp buffer gu=
ard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dhcp: F=
ix off-by-one in write_dhcp_search_str() temp buffer guard

Each search lis=
t entry consumes strlen(ptr) + 2 bytes of tmp_buf: one
leading label length=
 byte, the domain characters, and one trailing NUL=2E
The guard only accoun=
ted for strlen(ptr) + 1, so a sequence of entries
whose accumulated length =
lands exactly on the boundary passed the check
and then wrote tmp_buf[256],=
 one byte past the 256 byte array=2E

The existing "len > 255" check enforc=
es the correct upper bound, but it
runs after that write has already happen=
ed=2E

The entries can be pushed by the server: --dhcp-option falls under
O=
PT_P_DHCPDNS, which pull_permission_mask() includes, and
validate_domain() =
imposes no length limit=2E

Reproduced under AddressSanitizer, which report=
s a one byte
stack-buffer-overflow at dhcp=2Ec:308=2E The added unit test c=
overs the
boundary; it fails before this change and passes after it=2E The =
two
existing cases marked "maximum length" are unaffected, since a 253
char=
acter domain still satisfies 253 + 0 + 2 <=3D 256=2E

This was reported ind=
ependently by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=85n V=C4=83n=2E
Patch a=
uthor is Andre Kropp, recording both reports in the Reported-By:

CVE: 2026=
-81738
Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Signed-off-by: =
Nexory <St4yl3r30@hotmail=2Ede>
Acked-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884
Reported-By: Andre Kropp (Nexory)=

Reported-By: ChinhNguyen
Message-Id: <20260831083449=2E12484-1-gert@greeni=
e=2Emuc=2Ede>
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpn/dhcp=2Ec
M tests/unit_tests/openvpn/test_dhcp=2Ec
2 files change=
d, 21 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/dhcp=2Ec b/=
src/openvpn/dhcp=2Ec
index a54ab3f=2E=2E5cdcfcf 100644
--- a/src/openvpn/dh=
cp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -277,7 +277,9 @@
     {
         const=
 char *ptr =3D str_array[i];
 
-        if (strlen(ptr) + len + 1 > sizeof(=
tmp_buf))
+        /* Each entry consumes strlen(ptr) + 2 bytes: one leadin=
g label length
+         * byte and one trailing NUL=2E */
+        if (str=
len(ptr) + len + 2 > sizeof(tmp_buf))
         {
             *error =3D tr=
ue;
             msg(M_WARN, "write_dhcp_search_str: temp buffer overflow b=
uilding DHCP options");
diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec=
 b/tests/unit_tests/openvpn/test_dhcp=2Ec
index 104fc9a=2E=2E3a84e1e 100644=

--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+++ b/tests/unit_tests/openvp=
n/test_dhcp=2Ec
@@ -120,6 +120,24 @@
     assert_memory_equal(BPTR(&out_buf=
), output_5, sizeof(output_5));
     assert_false(error);
 
+    /* Several=
 entries whose accumulated length lands exactly on the guard
+     * bounda=
ry=2E Each entry consumes strlen()+2 bytes of tmp_buf (one length
+     * p=
refix plus one trailing NUL), but the guard only accounts for
+     * strle=
n()+1, so the last entry writes one byte past tmp_buf[256]=2E
+     * Sizes=
: 4 x 50 leaves len =3D=3D 208, the final 47 makes
+     * 47 + 208 + 1 =3D=
=3D 256, which the guard still accepts=2E */
+#define D50 "aaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+#define D47 "aaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaa"
+    const char *overflow_list[] =3D { D50, D50, D5=
0, D50, D47 };
+    assert_int_equal(strlen(D50), 50);
+    assert_int_equa=
l(strlen(D47), 47);
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&o=
ut_buf, DHCP_DOMAIN_SEARCH, overflow_list, 5, &error);
+    /* total is 257=
 > 255, so the option must be rejected -- the point of this
+     * case is=
 that tmp_buf must not be written out of bounds on the way=2E */
+    asser=
t_true(error);
+    error =3D false;
+
     gc_free(&gc);
 }
 

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd36231=
2ddc659
Gerrit-Change-Number: 1884
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: raz=
vanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>

--hXi4DYiuizQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>cron2 <strong>submitted</strong> thi=
s change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884=
?usp=3Demail">View Change</a></p><div style=3D"white-space:pre-wrap"></div>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dhcp: Fix off-by-one in write_dhcp_search_str() temp buffer g=
uard<br><br>Each search list entry consumes strlen(ptr) + 2 bytes of tmp_bu=
f: one<br>leading label length byte, the domain characters, and one trailin=
g NUL=2E<br>The guard only accounted for strlen(ptr) + 1, so a sequence of =
entries<br>whose accumulated length lands exactly on the boundary passed th=
e check<br>and then wrote tmp_buf[256], one byte past the 256 byte array=2E=
<br><br>The existing &quot;len &gt; 255&quot; check enforces the correct up=
per bound, but it<br>runs after that write has already happened=2E<br><br>T=
he entries can be pushed by the server: --dhcp-option falls under<br>OPT_P_=
DHCPDNS, which pull_permission_mask() includes, and<br>validate_domain() im=
poses no length limit=2E<br><br>Reproduced under AddressSanitizer, which re=
ports a one byte<br>stack-buffer-overflow at dhcp=2Ec:308=2E The added unit=
 test covers the<br>boundary; it fails before this change and passes after =
it=2E The two<br>existing cases marked &quot;maximum length&quot; are unaff=
ected, since a 253<br>character domain still satisfies 253 + 0 + 2 &lt;=3D =
256=2E<br><br>This was reported independently by Andre Kropp and Ch=C3=ADnh=
 Nguy=E1=BB=85n V=C4=83n=2E<br>Patch author is Andre Kropp, recording both =
reports in the Reported-By:<br><br>CVE: 2026-81738<br>Change-Id: I6a886a1ca=
c2d4725859dab2325cd362312ddc659<br>Signed-off-by: Nexory &lt;St4yl3r30@hotm=
ail=2Ede&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>A=
cked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884<br>Reported-By: Andre Kropp (Nex=
ory)<br>Reported-By: ChinhNguyen<br>Message-Id: &lt;20260831083449=2E12484-=
1-gert@greenie=2Emuc=2Ede&gt;<br>Signed-off-by: Gert Doering &lt;gert@green=
ie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dhcp=2Ec<br>M tests/unit_tests/op=
envpn/test_dhcp=2Ec<br>2 files changed, 21 insertions(+), 1 deletion(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</spa=
n><br><span>index a54ab3f=2E=2E5cdcfcf 100644</span><br><span>--- a/src/ope=
nvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@=
 -277,7 +277,9 @@</span><br><span>     {</span><br><span>         const cha=
r *ptr =3D str_array[i];</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (strlen(ptr) + len + 1 &gt; sizeof(tmp_buf)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Each en=
try consumes strlen(ptr) + 2 bytes: one leading label length</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * byte and one trailing N=
UL=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(strlen(ptr) + len + 2 &gt; sizeof(tmp_buf))</span><br><span>         {</sp=
an><br><span>             *error =3D true;</span><br><span>             msg=
(M_WARN, &quot;write_dhcp_search_str: temp buffer overflow building DHCP op=
tions&quot;);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_dh=
cp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index 104fc=
9a=2E=2E3a84e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</span=
><br><span>@@ -120,6 +120,24 @@</span><br><span>     assert_memory_equal(BP=
TR(&amp;out_buf), output_5, sizeof(output_5));</span><br><span>     assert_=
false(error);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Several entries whose accumulated length lands exactly o=
n the guard</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * b=
oundary=2E Each entry consumes strlen()+2 bytes of tmp_buf (one length</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * prefix plus one t=
railing NUL), but the guard only accounts for</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * strlen()+1, so the last entry writes one b=
yte past tmp_buf[256]=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * Sizes: 4 x 50 leaves len =3D=3D 208, the final 47 makes</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * 47 + 208 + 1 =3D=3D =
256, which the guard still accepts=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define D50 &quot;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaa&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define D47 &quot;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *overfl=
ow_list[] =3D { D50, D50, D50, D50, D47 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(strlen(D50), 50);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(strlen(D47),=
 47);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(=
&amp;out_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
rite_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, overflow_list, 5, &a=
mp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* to=
tal is 257 &gt; 255, so the option must be rejected -- the point of this</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * case is that tm=
p_buf must not be written out of bounds on the way=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    error =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     gc_free(&am=
p;gc);</span><br><span> }</span><br><span> </span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
84?usp=3Demail">change 1884</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1884?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1884 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>

</body></html>
--hXi4DYiuizQ=--


--===============5212728796605225209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5212728796605225209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5212728796605225209==--


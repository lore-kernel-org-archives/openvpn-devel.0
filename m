Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E73C61DFD
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KpI6fw8B9H+yEANMH7PwJv+aTzauN4kIOs9hyR5Qb0=; b=BYlAbxWqSwjY5kgNeEVmXEnTMg
	W9teiQ0KQPcGmL7WEr3pp9Uu1CF1LsvRlfmvb5/IywF3HnF7+9taw0LkvkgaCEim3IwnZiSCTIJ8M
	L9qeFfzELs7poN+vFpLMtZcw7z8wkH3n10htAsQSfXAfiTPKoaHAbhLFwVat1Eapsp1Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0xTb-00077P-QF;
	Mon, 31 Aug 2026 08:34:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0xTM-00075n-5Y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZJPSYNjF22aH8JScpodoP2IqVKSjqO++0RFOU7dhmEs=; b=M4KEufldnAflHj2Mjd3gxs2OJj
 Nxmz/OGhvn7/6z9T+yvP3dXV8FRdsJRK7YAS/hrFAWcqzMyh1UAq0uN5se7UC1qa+KRRBFnvbgtEu
 f1QqOGsu7GJYDTlsIDFEA4ye3S9TgVrtQuCnosH6cglwqEYigZ7aYF/Weu9bdZ8wI4LE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZJPSYNjF22aH8JScpodoP2IqVKSjqO++0RFOU7dhmEs=; b=S
 s8RFH4yDKn0/0HaG5ysCLByzLGBqnC7H5XTYRmEcS1XMp4pQVeV8ZGAk5KcSvZE/EZ7CmJF1wcim9
 nj6Rv+BGj6cFBh/bt/1Sp2OCxPt2ZD60vI3bB6Hovj36cwEMeUk37KedOqkeBddzF1mAxHizFlYXW
 lhNQ7GOsHxLTe50s=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0xTJ-0003kk-KM for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:34:32 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso22457195e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788165263; x=1788770063; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZJPSYNjF22aH8JScpodoP2IqVKSjqO++0RFOU7dhmEs=;
 b=ILM3qrs14kHahyWLsHR+Aby3r2UJcTy8BwSCBUsv68pS8UD7h3jQlGkWpiGRKyiPnO
 I80hxv3L7GDRavaHMnLMtwlGCh2yCnY+qrviTnU9KQ/1KZD8ehpFnsrIwwmzk6MVwaZv
 lUIc3+dih1gq1P9UOFPSapfCLFWsC/JupLIWR+KWrGm+tDevQif001NyQMQnJZkR2YpZ
 OljSE6mrArx2BLLGDEsXRbk76tA0FOgNHdiLr7PLunOrwEWep+1uu9npd7qqj9avNq/Q
 incRdzjByLcLZ2zurENBFHeSMaT/ifBvcjPN16o5DaUIn+Z44BjsyqiY8f9XSktRmD88
 TvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788165263; x=1788770063;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZJPSYNjF22aH8JScpodoP2IqVKSjqO++0RFOU7dhmEs=;
 b=OXFNIKh8aRFTLnD+P2JiyLk8nemyBDhtblEftvjjYeGIVfbh9c23HOQDJA2p19blqM
 xJM6fGW/1TNiGHRqdfRzTYzwBqv5pX9Uj+uE7LspXau3xtmD23XBDZSHnkxh6BNljfyB
 SD1td4HZrIy/MOa6qiT32biHSWygIXZf7QcLRYDUPmPDbmXYYIL6ribv8nRUjHBt2lW+
 umYktkyWbLwXSTbtHEyJ2bpermzjKPCIMW5+Kp0I8dFtY+2h+ZTCkYZ7nIMK1tsOECuC
 WayPWyEffzRMnRajI9b+nUMDrJvUEJyZOLPfRpEVGa7Bcc0o+lhellfKfe+YrjssFcMY
 dZLw==
X-Gm-Message-State: AFuF++k2Qfo1IzHdGzb1yST8m/CkBSmgWziZXqnUjXkzyLvUtYkxMyGm
 RqVSl/4OhNoyEqPS6nw8Y2ohUKlv0JrZCL4wFd7lq5bPswEfK+yQ0Gg3+50Ol+dv+uYsh3e2ibO
 zb5P+sM/B7OTabdbaMV7PNpaStO0OKmRgvUN/g8CK7np2pVWTNQ8DXLFvRBcpA17v2sI4
X-Gm-Gg: AR+sD11l5Xt8TYjlygOTvuhcn452QyJ085Lb+k7TugUdqRUJlC6o8aLWAwLRFk5l4GC
 BRhqPuYwLMYnP0uiTdXR3NeNPoubj4+KbOglHNk6NRtLB0OqjTF0fRSglna0DxT+vpXtPELUpJn
 kDJl68ASlrZd8zzr2VHI7pYbn2+wy4dNkVcAmU1v7LR+448akvCTIP8urY44IWWr9a1vsnNkDyr
 s3XNaBExdcLQWT9YXxZMJOMmmPtCzYU4HzqXAM+aRrzeltsolJbQkQptOelQt66g5kesaMwrnh5
 8zcQvWvaM2/2McijEQs/nZeKNXrrkcZ1swEWWJPmD2HQtNndB6LHCxcEEllbeGZ2nm95xARJono
 R+j37wx+Zqx5X/zQY/gd12ZGU8uWzJujAGfTyN0+b/bCljkx0jY83auqptpE+mfQ7kzgthWqmG6
 VVHl/wzH3Yc5CBwkv7cv52C254IzIXKSPoMei3l0KBjeuG0Mz2ibpmDEB2WRuKlYTUugAfiQfjg
 BJMEcn8HBt3JgUl2TqK5vg8yEXBxc2w1tmXX6YNOsXBY3wHc9Q8exudTEBY1YEczrkUrvs9xbnJ
 hW16l7qqZEzXDVjiEszozJWt8eHgQsiogdoLp6zMUfNbC0Iuba0=
X-Received: by 2002:a05:600c:528b:b0:49c:d818:8771 with SMTP id
 5b1f17b1804b1-49cd81887f8mr53224295e9.7.1788165262668; 
 Mon, 31 Aug 2026 01:34:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843310ab29sm13577824f8f.0.2026.08.31.01.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:34:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 08:34:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1884
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1884?usp=email>
X-Gerrit-Commit: 77f457a7dfea2bb62967dea5c43be238d4249be0
In-Reply-To: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTIwNDA3MDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3017e6609cae2b45c3dfccc87a9b41485e20625-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0xTJ-0003kk-KM
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
Content-Type: multipart/mixed; boundary="===============6484904801793098824=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6484904801793098824==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NcrpeaoiLsE="; charset=UTF-8

--NcrpeaoiLsE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1884?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: dhcp: Fix off-by-one in write_dhcp_search_str() temp buffe=
r guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dhcp=
: Fix off-by-one in write_dhcp_search_str() temp buffer guard

Each search =
list entry consumes strlen(ptr) + 2 bytes of tmp_buf: one
leading label len=
gth byte, the domain characters, and one trailing NUL=2E
The guard only acc=
ounted for strlen(ptr) + 1, so a sequence of entries
whose accumulated leng=
th lands exactly on the boundary passed the check
and then wrote tmp_buf[25=
6], one byte past the 256 byte array=2E

The existing "len > 255" check enf=
orces the correct upper bound, but it
runs after that write has already hap=
pened=2E

The entries can be pushed by the server: --dhcp-option falls unde=
r
OPT_P_DHCPDNS, which pull_permission_mask() includes, and
validate_domain=
() imposes no length limit=2E

Reproduced under AddressSanitizer, which rep=
orts a one byte
stack-buffer-overflow at dhcp=2Ec:308=2E The added unit tes=
t covers the
boundary; it fails before this change and passes after it=2E T=
he two
existing cases marked "maximum length" are unaffected, since a 253
c=
haracter domain still satisfies 253 + 0 + 2 <=3D 256=2E

This was reported =
independently by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=85n V=C4=83n=2E
Patc=
h author is Andre Kropp, recording both reports in the Reported-By:

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


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/1884/2

diff --gi=
t a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index a54ab3f=2E=2E5cdcfcf =
100644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -277,7 +277=
,9 @@
     {
         const char *ptr =3D str_array[i];
 
-        if (strl=
en(ptr) + len + 1 > sizeof(tmp_buf))
+        /* Each entry consumes strlen=
(ptr) + 2 bytes: one leading label length
+         * byte and one trailing=
 NUL=2E */
+        if (strlen(ptr) + len + 2 > sizeof(tmp_buf))
         {=

             *error =3D true;
             msg(M_WARN, "write_dhcp_search_=
str: temp buffer overflow building DHCP options");
diff --git a/tests/unit_=
tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index =
104fc9a=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
++=
+ b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -120,6 +120,24 @@
     assert=
_memory_equal(BPTR(&out_buf), output_5, sizeof(output_5));
     assert_fals=
e(error);
 
+    /* Several entries whose accumulated length lands exactly =
on the guard
+     * boundary=2E Each entry consumes strlen()+2 bytes of tm=
p_buf (one length
+     * prefix plus one trailing NUL), but the guard only=
 accounts for
+     * strlen()+1, so the last entry writes one byte past tm=
p_buf[256]=2E
+     * Sizes: 4 x 50 leaves len =3D=3D 208, the final 47 mak=
es
+     * 47 + 208 + 1 =3D=3D 256, which the guard still accepts=2E */
+#d=
efine D50 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+#define D47=
 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+    const char *overflo=
w_list[] =3D { D50, D50, D50, D50, D47 };
+    assert_int_equal(strlen(D50)=
, 50);
+    assert_int_equal(strlen(D47), 47);
+    buf_clear(&out_buf);
+ =
   write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, overflow_list, 5, &e=
rror);
+    /* total is 257 > 255, so the option must be rejected -- the po=
int of this
+     * case is that tmp_buf must not be written out of bounds =
on the way=2E */
+    assert_true(error);
+    error =3D false;
+
     gc_f=
ree(&gc);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1884?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6=
a886a1cac2d4725859dab2325cd362312ddc659
Gerrit-Change-Number: 1884
Gerrit-P=
atchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>

--NcrpeaoiLsE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1884?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">dhcp: Fix=
 off-by-one in write_dhcp_search_str() temp buffer guard<br><br>Each search=
 list entry consumes strlen(ptr) + 2 bytes of tmp_buf: one<br>leading label=
 length byte, the domain characters, and one trailing NUL=2E<br>The guard o=
nly accounted for strlen(ptr) + 1, so a sequence of entries<br>whose accumu=
lated length lands exactly on the boundary passed the check<br>and then wro=
te tmp_buf[256], one byte past the 256 byte array=2E<br><br>The existing &q=
uot;len &gt; 255&quot; check enforces the correct upper bound, but it<br>ru=
ns after that write has already happened=2E<br><br>The entries can be pushe=
d by the server: --dhcp-option falls under<br>OPT_P_DHCPDNS, which pull_per=
mission_mask() includes, and<br>validate_domain() imposes no length limit=
=2E<br><br>Reproduced under AddressSanitizer, which reports a one byte<br>s=
tack-buffer-overflow at dhcp=2Ec:308=2E The added unit test covers the<br>b=
oundary; it fails before this change and passes after it=2E The two<br>exis=
ting cases marked &quot;maximum length&quot; are unaffected, since a 253<br=
>character domain still satisfies 253 + 0 + 2 &lt;=3D 256=2E<br><br>This wa=
s reported independently by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=85n V=C4=
=83n=2E<br>Patch author is Andre Kropp, recording both reports in the Repor=
ted-By:<br><br>CVE: 2026-81738<br>Change-Id: I6a886a1cac2d4725859dab2325cd3=
62312ddc659<br>Signed-off-by: Nexory &lt;St4yl3r30@hotmail=2Ede&gt;<br>Repo=
rted-By: Andre Kropp (Nexory)<br>Reported-By: ChinhNguyen<br>---<br>M src/o=
penvpn/dhcp=2Ec<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>2 files chan=
ged, 21 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/1884/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index=
 a54ab3f=2E=2E5cdcfcf 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</sp=
an><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@ -277,7 +277,9 @@=
</span><br><span>     {</span><br><span>         const char *ptr =3D str_ar=
ray[i];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (strlen(ptr) + len + 1 &gt; sizeof(tmp_buf))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Each entry consumes strl=
en(ptr) + 2 bytes: one leading label length</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * byte and one trailing NUL=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(ptr) + le=
n + 2 &gt; sizeof(tmp_buf))</span><br><span>         {</span><br><span>    =
         *error =3D true;</span><br><span>             msg(M_WARN, &quot;wr=
ite_dhcp_search_str: temp buffer overflow building DHCP options&quot;);</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/un=
it_tests/openvpn/test_dhcp=2Ec</span><br><span>index 104fc9a=2E=2E3a84e1e 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_dhcp=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>@@ -12=
0,6 +120,24 @@</span><br><span>     assert_memory_equal(BPTR(&amp;out_buf),=
 output_5, sizeof(output_5));</span><br><span>     assert_false(error);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Several entries whose accumulated length lands exactly on the guard</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * boundary=2E Each e=
ntry consumes strlen()+2 bytes of tmp_buf (one length</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * prefix plus one trailing NUL), but=
 the guard only accounts for</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * strlen()+1, so the last entry writes one byte past tmp_buf[=
256]=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Sizes=
: 4 x 50 leaves len =3D=3D 208, the final 47 makes</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * 47 + 208 + 1 =3D=3D 256, which the gu=
ard still accepts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D50 &quot;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D47 &quo=
t;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *overflow_list[] =3D { D=
50, D50, D50, D50, D47 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(strlen(D50), 50);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(strlen(D47), 47);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;out_buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_search_=
str(&amp;out_buf, DHCP_DOMAIN_SEARCH, overflow_list, 5, &amp;error);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* total is 257 &gt; 2=
55, so the option must be rejected -- the point of this</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * case is that tmp_buf must not be=
 written out of bounds on the way=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    error =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     gc_free(&amp;gc);</span><br>=
<span> }</span><br><span> </span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail">c=
hange 1884</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I6a886a1cac2d4725859dab2325cd362312ddc659 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1884 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2=
 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--NcrpeaoiLsE=--


--===============6484904801793098824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6484904801793098824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6484904801793098824==--


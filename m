Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A90CA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9L6Vx5lA42x4iRLnVwNS6OCPfhij7LLzE0GT+Kqy2h4=; b=JcmHL10qDp0oZp/6zMO7hbDqTr
	tsGDQ9NpmZ1wzwx3AzUNVaZb5qW4FHvSkBvxH5V4cldOPB5PVOOpcFpTitW862tGWy2rfbCdKwREn
	hNOrozIlYRoHOLkbD9aCUzD5D3OazSKi5wXtGzCzn1y8CkKRiG4c+xYBi+2LYLlet04I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEqYx-0006Du-6f;
	Thu, 08 Oct 2026 16:01:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEqYv-0006Dn-Oe
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EQN85fhCbwwrrrocNFFivM9cs2kKEeLEAA3CnYReMIY=; b=aoeD3WZTYwErAG7gLU/R1MaAJV
 oq3/DvYFLxevmqLrDmlLvUunT9TZY7l8+B14LVMIlkasZLAlbZaqHsj5Tu86ceUtriYyOZK0WvnAN
 AXg9EORk6JsECUqTDJbPKGkymf2WKA+rFwcsnqBQa700zBGkH1FJiXnJLusQuHbfJKvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EQN85fhCbwwrrrocNFFivM9cs2kKEeLEAA3CnYReMIY=; b=n
 CKSF4VNYb6LVMGGpi6a4cwoAIwBnE37nCfoYGqC1gT3COWf85ORrui4Yp8NoHGfUXmSf1DJQgZePz
 rIlLKWqMUcdCxeez0/XYSFnKQ5Z2lSW1mM8RA3hmen5YHEGhqMO2Fs6Kk//0ZhKPzo2oG6SE9D6qT
 vifkBgdXO/Ux+Uak=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEqYu-0003oj-I1 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:01:42 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so32188265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791475294; x=1792080094; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EQN85fhCbwwrrrocNFFivM9cs2kKEeLEAA3CnYReMIY=;
 b=KBMy+Hys40PtebfcwMypnd1pHt+Y8bTAgFwGXxG0xVXTepU6RyqJyWaXzKjIlm0KSP
 /bcE2+71bcWyp+EDtS/7bk6c/PqmdSuJK3jqOpyw9i4jLTVSlEZ0r99aIJLV2K9ScsL0
 DKWz7m4XxB5JusZp42ApVH/NWRi6tg0NCJbDf1wkBZ6CL5UkyAzARmBjkqNjXqzpLTlv
 p1cK08hgYVMky1Zsr1bgF74NVNwok3HikTlgbAP1qjc69GLxp0+mCF4nWiOEhDXKibQS
 cWBHSE1GOeUeIVqtrKE/kJFQBzIPeRofTxz9XwIF8JknHtJ0uJ3hd+khIAYarwJpAiso
 8djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475294; x=1792080094;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EQN85fhCbwwrrrocNFFivM9cs2kKEeLEAA3CnYReMIY=;
 b=ZGObGJ5tBcGhOZ/rkiSLP0UwHTAcFz/5y+bD6DyBZCFHlS79mZeGEGjdCjSacZUDGF
 NEnMx1aMhrZFWRIa65wSCcsHJ10zmWlvrOw+/fCTNJWlt7StgrKN7jIXnOPsuvX0xQUn
 mlB+p6ivnK7k1sliOKFdE/RB9zSs/v8K0zypssvQTA9XQX3xeQKKPphn/LjMev4Q6+e7
 aqgHfRWztohQ753oftpC5ScMqEVS9ZoyD1gcz3OKa8AlJvxNgUbz3juCjaSdt8NRF1m6
 b2Q00fbd3+TF47CXXKP1y0CK7/DcfSb8eq+4Pw/8aTGMrnczXfwVsw0f9qiFWu2IIviu
 VByA==
X-Gm-Message-State: AFuF++mgE9nWO29z9Cwmxp3SqkwD+sHfIuE8/JfOGFTbbOldr/dCaee6
 bUJw3UQov6s4Q65nZQkg8jjgvlIOFNOJHmNlAVJjXT/cak+t2DA5v4aFgQPM18/Y1vhJwswSJBv
 EjyF968oPFN+YCL5QHBZNBcXKvS6Ubj53TGySYAWiIX1D3aQoXmLc5o0agj8IvJowZxTELSLVed
 T7cnmR7A==
X-Gm-Gg: AYBFou0d3reAXyW+TP4z/KgMaQX37+TLeTEjMabE1eDBY1rb0Zrx57P72OhdvTBAbH7
 dIiYFBRG/2o9K/yNvjKIA8zHnhBeNunOmDxVck8zJW+5e8oAQLwywdw1rF9+nxwISL3iwujpEyg
 P4SqMBnX7qLskNRxmzQ+ZWO8RY6oewljjkhBfysF8SyNFoR9FusH5+Iz011pVcaFrCzb49MsB6W
 3kb3gx2RIJ1Ya9EpumYd9TtuX53Qksjm9CFdF7oVtbXCnCKgbdAFq1YRY2eSwYeVeQItp+b6+C4
 hMd9+S2tf/pmMimr1iKo4S7kIIX01yG/+PYWmGVAuaD6Ir/Fgg1L+qir/CPDS5FG+PcpysqobLC
 Htgl9YOe8JJ/A7pHSD4/r7kc0z2TesH834G6bOOETjDUjpFltg+bxfbNLVlpLr/mvwdDiIeHFv+
 LFDtxeIOHB8BcDcxeM76ENNwCoOMe8flraqsbubXFCiyoPdtU6ULm9EGxm7zu0xaMPHsM9uOMQu
 0/rOoFT1cncUoUGmipjX/frNC9YPtxwgSSx9ZiP+WzEHqzZozDOuN7oQ+1GZHYfT8iNIoYxDe0I
 P7X/gQKY6UPiDvp0Wt8ydl6J5fcp+ulWJjyKrOKCmvkiA+/Ee3C5exKdK2WQ
X-Received: by 2002:a05:600c:34c5:b0:4a1:6ad5:257d with SMTP id
 5b1f17b1804b1-4a18065ec2fmr116246345e9.29.1791475293795; 
 Thu, 08 Oct 2026 09:01:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db653ce2dsm290091f8f.46.2026.10.08.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 09:01:33 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 16:01:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: 86829f5cd9d89561c5eae4bb556b27432bc11f79
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5f28e604081a7f6896b964b44b7bb11f5747d7e7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEqYu-0003oj-I1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2392095349813382153=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2392095349813382153==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M+c2AbCdEM4="; charset=UTF-8

--M+c2AbCdEM4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1987?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: buffer: Clean up rm_trailing_chars
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Clean up rm_tr=
ailing_chars

This is very weird code=2E We re-run strlen for
every char th=
at we delete, even though we actually
know which char to test next=2E Avoid=
 this=2E

Also add unit tests to make sure I did not break it=2E

Change-Id=
: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Signed-off-by: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M tests/unit_tests=
/openvpn/test_buffer=2Ec
2 files changed, 43 insertions(+), 14 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/19=
87/2

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 8f=
558b1=2E=2Ea90ddae 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/bu=
ffer=2Ec
@@ -592,21 +592,11 @@
 void
 rm_trailing_chars(char *str, const ch=
ar *what_to_delete)
 {
-    bool modified;
-    do
+    size_t len =3D strl=
en(str);
+    while (len > 0 && strchr(what_to_delete, str[len - 1]) !=3D N=
ULL)
     {
-        const size_t len =3D strlen(str);
-        modified =
=3D false;
-        if (len > 0)
-        {
-            char *cp =3D str +=
 (len - 1);
-            if (strchr(what_to_delete, *cp) !=3D NULL)
-      =
      {
-                *cp =3D '\0';
-                modified =3D true;
=
-            }
-        }
-    } while (modified);
+        str[--len] =3D =
'\0';
+    }
 }
 
 /*
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec=
 b/tests/unit_tests/openvpn/test_buffer=2Ec
index 2945e8a=2E=2Ebf486e0 1006=
44
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/op=
envpn/test_buffer=2Ec
@@ -435,6 +435,44 @@
 }
 
 void
+test_string_chomp(vo=
id **state)
+{
+    char string[10];
+
+    strcpy(string, "Foo\n");
+    c=
homp(string);
+    assert_string_equal(string, "Foo");
+
+    strcpy(string=
, "Foo\r\n\n\r");
+    chomp(string);
+    assert_string_equal(string, "Foo=
");
+
+    strcpy(string, "Foo");
+    chomp(string);
+    assert_string_eq=
ual(string, "Foo");
+
+    strcpy(string, "F\ro\no");
+    chomp(string);
+=
    assert_string_equal(string, "F\ro\no");
+
+    string[2] =3D '\0';
+   =
 chomp(string);
+    assert_string_equal(string, "F");
+
+    strcpy(string=
, "");
+    chomp(string);
+    assert_string_equal(string, "");
+
+    str=
cpy(string, "Foo");
+    rm_trailing_chars(string, "o");
+    assert_string=
_equal(string, "F");
+
+    strcpy(string, "Foo");
+    rm_trailing_chars(s=
tring, "oF");
+    assert_string_equal(string, "");
+}
+
+void
 test_buffer=
_chomp(void **state)
 {
     struct gc_arena gc =3D gc_new();
@@ -616,6 +65=
4,7 @@
         cmocka_unit_test(test_character_string_mod_buf),
         c=
mocka_unit_test(test_snprintf),
         cmocka_unit_test(test_checked_snpr=
intf),
+        cmocka_unit_test(test_string_chomp),
         cmocka_unit_t=
est(test_buffer_chomp),
         cmocka_unit_test(test_buffer_null_terminat=
e),
         cmocka_unit_test(test_buffer_null_predicates),

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb2=
7ddbfba3cdd
Gerrit-Change-Number: 1987
Gerrit-PatchSet: 2
Gerrit-Owner: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>

--M+c2AbCdEM4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">buf=
fer: Clean up rm_trailing_chars<br><br>This is very weird code=2E We re-run=
 strlen for<br>every char that we delete, even though we actually<br>know w=
hich char to test next=2E Avoid this=2E<br><br>Also add unit tests to make =
sure I did not break it=2E<br><br>Change-Id: I47e0741c75832a8f3fe161769feb2=
7ddbfba3cdd<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M tests/unit_tests/openvpn/test_=
buffer=2Ec<br>2 files changed, 43 insertions(+), 14 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/87/1987/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/=
buffer=2Ec</span><br><span>index 8f558b1=2E=2Ea90ddae 100644</span><br><spa=
n>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec=
</span><br><span>@@ -592,21 +592,11 @@</span><br><span> void</span><br><spa=
n> rm_trailing_chars(char *str, const char *what_to_delete)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool modified;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(str);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (len &gt; 0 =
&amp;&amp; strchr(what_to_delete, str[len - 1]) !=3D NULL)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const s=
ize_t len =3D strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        modified =3D false;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (len &gt; 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            char *cp =3D str + (len - 1);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (strchr(what_to_delete, *cp) !=3D NULL)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                *cp =3D &#39;=
\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   modified =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (modifie=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str[--le=
n] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span> }</span><br><span> </span><br><span> /*</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tes=
ts/openvpn/test_buffer=2Ec</span><br><span>index 2945e8a=2E=2Ebf486e0 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -43=
5,6 +435,44 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_string_chomp(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char string[10];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo\n&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(str=
ing, &quot;Foo&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(strin=
g, &quot;Foo\r\n\n\r&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    chomp(string);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(string, &quot;Foo&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(string, &quot;Fo=
o&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;F\ro=
\no&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chom=
p(string);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(string, &quot;F\ro\no&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    string[2] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    chomp(string);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(string, &quot;F&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    strcpy(string, &quot;&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(string, &quo=
t;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rm_trai=
ling_chars(string, &quot;o&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(string, &quot;F&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    rm_trailing_chars(string, &quo=
t;oF&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(string, &quot;&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan> test_buffer_chomp(void **state)</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span>@@ -616,6 +654,7 @@</spa=
n><br><span>         cmocka_unit_test(test_character_string_mod_buf),</span=
><br><span>         cmocka_unit_test(test_snprintf),</span><br><span>      =
   cmocka_unit_test(test_checked_snprintf),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_string_chomp),</span>=
<br><span>         cmocka_unit_test(test_buffer_chomp),</span><br><span>   =
      cmocka_unit_test(test_buffer_null_terminate),</span><br><span>       =
  cmocka_unit_test(test_buffer_null_predicates),</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Dem=
ail">change 1987</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1987?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1987 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--M+c2AbCdEM4=--


--===============2392095349813382153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2392095349813382153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2392095349813382153==--


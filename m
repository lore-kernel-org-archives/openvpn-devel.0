Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02334CA600C
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TaQTbnAW4xeUvngeJgJlErmXnVLSTKZRU+RHbxQRtvE=; b=I4U70COsfIZU38eLFD3OLK69gj
	jis9GGVEy7KDIikZmQaQuzw63yLHeBzstqnzwjfSwcfjgUXZ6dmGucdYOXzipUiWTxPEatidiP9OU
	WVYTLur2blhDr1mSEVQVr+nhL/9ZDNuhGmWpiwhyy/i939+pPta8XvDmVgGGuarApIuU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEtMr-00034g-VW;
	Thu, 08 Oct 2026 19:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEtMq-00034Z-BZ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 19:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=S1IkK1U0htMSJluPx8WeHxXG8100RiB5fw0ef+x6b6I=; b=DKwnS3lqp4y7CF0kYHBtay1ji5
 DXvxGrniC8tP7KwJ5+obnYdElD1KksPz0rLjLTScKoTQnzTtaT3Rw+UsZWiXytWy/WAbiOxfSsfuu
 MfLIchXBTQ+FSBXzU9U2yYcDjq7hYVcdNilmFZEBZiUW4DfUlxP8iSg5yzo54d5aUfR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S1IkK1U0htMSJluPx8WeHxXG8100RiB5fw0ef+x6b6I=; b=Z
 H+5dj5KA3ZwBf8ltl8z1jVFGR9oNPYX3iDuBuV42pyrquKVTPlKRblTCjQFYv/TSl/2CnFw1OT0GU
 7U9eU/s1dQ9cPj40UpucCMQWT3BV3lgzh5yWgVWGlHxY/CIR8Bl5l98wM49OaxoOPGBJrfqNnmLO3
 IcJ6eEQ2ERCqLDHI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEtMq-0003Dt-0R for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 19:01:24 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so25726265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791486077; x=1792090877; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S1IkK1U0htMSJluPx8WeHxXG8100RiB5fw0ef+x6b6I=;
 b=Jvox87cenwj7xt3S/ZkWqQrRbOwyZK0rxwM74431fvxHRrD+D2BWmQhTAWNl89Qmkh
 jHb7uTH7pkfz5iHke/6zpg8kLFGsm8fpbTeA9HtbOr083QkNouNlVdVgJjfbgKF76vgz
 QoLtUpoPOaXEDXXOIm13MwEe5axMHZQRWNdn7bSwQ0Jo8vUOgbhEvuNhn0jAjdgt1p/z
 k10D0HAIBuYDbqmf6sDZsIUsjmEeSQC13a01JaPivmBPdq5/XpTW4oiEw6hllKHAe3Nd
 3ut8tmzFVi41oc8QoK+S7a50gs6kz7aLkrF+Rlh3NUBq1rfaxRQuULZvq+0e+qthu0lf
 wo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486077; x=1792090877;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S1IkK1U0htMSJluPx8WeHxXG8100RiB5fw0ef+x6b6I=;
 b=WFKw9+fsaW8XxUmtp6sYY2KGFUM9XNBqSss3L7Bb/pSNWTKLPNVjNdHowo1b3KxGbw
 Rak2to9MuoRqp2C6nR8PhByQVL6bULbCrzaxRldv2thYyggOBxW2pIMHtOxg7qIijqW0
 P+bcV5ROPdMceBovvdd5cmsSaWw9q11NX/w/Azf6Xwz4yotD1euhxR8A2QUDHP9xuU5n
 tCRUlqf2qXyXgQCFRl9Yh25D9sn2Y/YJQMXvEw/Fx+BknhRyHKmyxSaOIHnvCJb+DbeQ
 5UjvXpBRAjmfjwvoBtpWZxAZIJILbJta+ogED024DeZFRw+JmQQbqAwznyuOBuaOzoln
 EiBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhHR7ShF24Qd4AGIDRGyvkKcvR+JprT8cyFH71OGRgUBoSGmU14nkYw3CgJb11vDiMuAR5HkkAKm7oIJ8+@lists.sourceforge.net
X-Gm-Message-State: AFuF++nCCJqS4N+7s/hxHuql69kxeKiGCH4zSPmpOLofjiHfu8c7lQ6y
 g2u8l0hVtsLZTqjkgbu5DoT6K4zlZBqerVlQyjEVq/hkK6owlOQT924Zz3G8mqZtcQbR62WfzkG
 pOgky4NcKgIU93RlLsQedjX/mroKwfOBWO/TwR/8f+4d1IDjad630IrElVYkckkmPrFVW
X-Gm-Gg: AYBFou04t/DkpKYus8v1a1r7K5SOVyQQlnt28QbkSY+6gvBbst5n3cZ5x/KEgfgLLVD
 7zhabd38niWR5Cbe8TT4wqzxWC8QV9PmjGYVuAFlat9VDeDJEHnRcdF1Uu1sV+aDMW2UIRh2EZh
 MLznK1kwrdKowMts/WmbpzvEXjU+6zPhdNTUZl75Fi+w/N9q6TMukRv1OHEtGA3rIK6XB6Mj1/G
 aJGW5P6LgXMqr6sRLLwfnwMEpqqeE0JPImiEvArIuZaJAmsxrT9V1MTFAIZmBTp3aYRd5qRR8/V
 ttMJzYwcbbCNkgwfOdV4pRCcNz3em9LKbwcsuVPiT0aZVLb6WvFH6+Re09ie09YuXIEF2SQCP0A
 7P2GRsFagHW0KSpZUFlKsP4ShxGTjPjW/cQmu7d9h4m/TlKuPTPnz8/3nUk4hC+/5vI3foQSNe5
 mkdU4Xfpcim1p8pGdFAQLA0FS9ajR2kT85gQfKQ7dIHOLu5E8g0HGDlNtodmTs17SvZxEOhKllM
 rkml6YXhhp8Iq6EBal6O8TC5M0Szjjs/P1LaxNww6erBZiltvMjtg6xZvSgDD88Rsr0ZHYY+Vji
 ohd2SNCfMklOvNd53d22NIspSmlFX2ctXWPQ0WZfrXK1NtKy9y6pHe1zsFwd
X-Received: by 2002:a05:600c:3ba2:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a18043dee1mr138855945e9.7.1791486077334; 
 Thu, 08 Oct 2026 12:01:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db650fd63sm989139f8f.18.2026.10.08.12.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 12:01:17 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 19:01:16 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: ec55ca56e7abe9c3824ca37c0f5939d758163db7
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6b60f5952678e313a8434e10ef34d90d7bc3002-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEtMq-0003Dt-0R
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5292054953216413168=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5292054953216413168==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iBeh/vXfUf4="; charset=UTF-8

--iBeh/vXfUf4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1987?usp=3Demail )

Change subject: buffer: Clean up rm_trailin=
g_chars
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buff=
er: Clean up rm_trailing_chars

This is very weird code=2E We re-run strlen=
 for
every char that we delete, even though we actually
know which char to =
test next=2E Avoid this=2E

Also add unit tests to make sure I did not brea=
k it=2E

Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Signed-off-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1987
Message-Id: <20261008161329=2E32304-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
39789=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/buffer=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
2 files cha=
nged, 43 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec
index 8f558b1=2E=2Ea90ddae 100644
--- a/src/o=
penvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -592,21 +592,11 @@
 void
=
 rm_trailing_chars(char *str, const char *what_to_delete)
 {
-    bool modi=
fied;
-    do
+    size_t len =3D strlen(str);
+    while (len > 0 && strch=
r(what_to_delete, str[len - 1]) !=3D NULL)
     {
-        const size_t len=
 =3D strlen(str);
-        modified =3D false;
-        if (len > 0)
-     =
   {
-            char *cp =3D str + (len - 1);
-            if (strchr(wha=
t_to_delete, *cp) !=3D NULL)
-            {
-                *cp =3D '\0';
=
-                modified =3D true;
-            }
-        }
-    } while =
(modified);
+        str[--len] =3D '\0';
+    }
 }
 
 /*
diff --git a/test=
s/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=
=2Ec
index 2945e8a=2E=2Ebf486e0 100644
--- a/tests/unit_tests/openvpn/test_=
buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -435,6 +435,44=
 @@
 }
 
 void
+test_string_chomp(void **state)
+{
+    char string[10];
+
=
+    strcpy(string, "Foo\n");
+    chomp(string);
+    assert_string_equal(=
string, "Foo");
+
+    strcpy(string, "Foo\r\n\n\r");
+    chomp(string);
+=
    assert_string_equal(string, "Foo");
+
+    strcpy(string, "Foo");
+    =
chomp(string);
+    assert_string_equal(string, "Foo");
+
+    strcpy(strin=
g, "F\ro\no");
+    chomp(string);
+    assert_string_equal(string, "F\ro\n=
o");
+
+    string[2] =3D '\0';
+    chomp(string);
+    assert_string_equa=
l(string, "F");
+
+    strcpy(string, "");
+    chomp(string);
+    assert_=
string_equal(string, "");
+
+    strcpy(string, "Foo");
+    rm_trailing_ch=
ars(string, "o");
+    assert_string_equal(string, "F");
+
+    strcpy(stri=
ng, "Foo");
+    rm_trailing_chars(string, "oF");
+    assert_string_equal(=
string, "");
+}
+
+void
 test_buffer_chomp(void **state)
 {
     struct gc_=
arena gc =3D gc_new();
@@ -616,6 +654,7 @@
         cmocka_unit_test(test_c=
haracter_string_mod_buf),
         cmocka_unit_test(test_snprintf),
       =
  cmocka_unit_test(test_checked_snprintf),
+        cmocka_unit_test(test_s=
tring_chomp),
         cmocka_unit_test(test_buffer_chomp),
         cmocka=
_unit_test(test_buffer_null_terminate),
         cmocka_unit_test(test_buff=
er_null_predicates),

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1987?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Gerrit-Change-Number: 1987
Gerri=
t-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--iBeh/vXfUf4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1987?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">buffer: Clean up rm_trailing_chars=
<br><br>This is very weird code=2E We re-run strlen for<br>every char that =
we delete, even though we actually<br>know which char to test next=2E Avoid=
 this=2E<br><br>Also add unit tests to make sure I did not break it=2E<br><=
br>Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1987<br>Message-Id: &lt;20261008161329=2E32304-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg39789=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M tests/u=
nit_tests/openvpn/test_buffer=2Ec<br>2 files changed, 43 insertions(+), 14 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/ope=
nvpn/buffer=2Ec</span><br><span>index 8f558b1=2E=2Ea90ddae 100644</span><br=
><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffe=
r=2Ec</span><br><span>@@ -592,21 +592,11 @@</span><br><span> void</span><br=
><span> rm_trailing_chars(char *str, const char *what_to_delete)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool modi=
fied;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(str=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (len &g=
t; 0 &amp;&amp; strchr(what_to_delete, str[len - 1]) !=3D NULL)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst size_t len =3D strlen(str);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        modified =3D false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (len &gt; 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            char *cp =3D str + (len - 1);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (strchr(what_to_delete, *cp) !=3D =
NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                *cp =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        modified =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (mo=
dified);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
[--len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> }</span><br><span> </span><br><span> /*</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/uni=
t_tests/openvpn/test_buffer=2Ec</span><br><span>index 2945e8a=2E=2Ebf486e0 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@=
@ -435,6 +435,44 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_string_chom=
p(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char string[10];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo\n&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(string, &quot;Foo&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(=
string, &quot;Foo\r\n\n\r&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    chomp(string);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(string, &quot;Foo&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(string, &qu=
ot;Foo&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot=
;F\ro\no&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 chomp(string);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(string, &quot;F\ro\no&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    string[2] =3D &#39;\0&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    chomp(string);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_string_equal(string, &quot;F&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(string,=
 &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quo=
t;Foo&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rm=
_trailing_chars(string, &quot;o&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(string, &quot;F&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    rm_trailing_chars(string,=
 &quot;oF&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(string, &quot;&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span> test_buffer_chomp(void **state)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -616,6 +654,7 @@=
</span><br><span>         cmocka_unit_test(test_character_string_mod_buf),<=
/span><br><span>         cmocka_unit_test(test_snprintf),</span><br><span> =
        cmocka_unit_test(test_checked_snprintf),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_string_chomp),</=
span><br><span>         cmocka_unit_test(test_buffer_chomp),</span><br><spa=
n>         cmocka_unit_test(test_buffer_null_terminate),</span><br><span>  =
       cmocka_unit_test(test_buffer_null_predicates),</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=
=3Demail">change 1987</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1987?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1987 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--iBeh/vXfUf4=--


--===============5292054953216413168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5292054953216413168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5292054953216413168==--


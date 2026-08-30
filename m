Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43701C61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7oPS1f380T2hswgwA5l7jkiGaKe0tC5HNP05cwmsLAU=; b=SHJo/iMK5hWSPExRAmUJ4PIh8s
	AshGvn97NylFjRtgW5ddd8oqiaFoTYPyWZJ6Kvnh++PD2bNfak4tHnpb1/eubkBIfqAOvQNdgluHw
	IvA6pL2T2T7x4bVt82C9UFxnCkh28CG2xxpUl6Uzbh4lQNIy54ptJx1C93+Qu//iFRwY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0ihD-0003ud-AS;
	Sun, 30 Aug 2026 16:47:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0ihC-0003uW-Es
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:47:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k0qzHY2xzlHRnJLEn+ZwjGIZ7jiyWbNmcRX8ScY++/w=; b=QKRDzVW3PHKPcYfv+lieSYmfDN
 9ULQy6ZNJUdJ5ykelpenxSyPTgAt+Y9C8yJYApqDR4GSpaQ1VoBta2fN/LOSa4x3D/TGo3MGU+u6P
 Gf1ka1GxhtMoiAydyLM60kprK1059yyg/psm9RpWjUikiTIb5NgpTXK/cAEXjyYZgzCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k0qzHY2xzlHRnJLEn+ZwjGIZ7jiyWbNmcRX8ScY++/w=; b=U
 8EnVKNtR1sBhPw99P4s8lALB+zETX93EuQq0xMbKupV9EAUbfp20QhDxtszduT138e4TlcvrurcWj
 dB+1w/XDfSsGrro1KjjGHtOetgqxoLCtWxJp+yBrh+l5VzPtFhl+Oo6Lff0ceMYWmN3kRRoZWM8Fk
 eq5paH8juGMb6BRg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0ihB-0003IJ-Pn for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:47:50 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495590dde14so24997275e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788108463; x=1788713263; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k0qzHY2xzlHRnJLEn+ZwjGIZ7jiyWbNmcRX8ScY++/w=;
 b=KLdZd3uN1cFTlNjES1Nkp+pmDR6Za0AN9NHD0ZoGd4xGZ1GiM7Zdf+7UNQM20zZ4aH
 alqu6ayeYGMvYBpn0wl1dV9njM+jhMlnCHxmFTOxuE5wXqV7Io8okpylHLEhBBNXtM9y
 5IDpagQnqvzq61t3dVDseDXRuw3uGY1oKNR+OCf1+E/hGJqmO3gMcuOutFSeBZjJTHjh
 VywV/asJzh6agUfyF0e2p0bC2n5jkKxLNTL2y6bO/tagp/NNJZA7M4dtfwp8DkFVP+d1
 mBEGy27LwPLJWv51jll+weUwvlCcnR6SXd16NDcrZwc4DP8Fd8mdGICuGxV21m30sFmk
 f3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788108463; x=1788713263;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k0qzHY2xzlHRnJLEn+ZwjGIZ7jiyWbNmcRX8ScY++/w=;
 b=c7WYKjaj0QYdDRT8I8PvbAzC7XF9SrJU/Yi/aMsuuZsHzBhjc9DxYNUpqG0EzQreHf
 L+yKlaV0gMkjAhX6G7A+5uZtAFFmo8NOjbBdh3bvCgfzb6zZGgAm4qNO6E9IS9FcRXhX
 wAmnOaCjssmKOIYEOgQ7ig/2/EEqIPknC9o0Jpl3beJVmZFKdZ6vXpyqHbr25P84tDWh
 87AQ8OfpllOb2xbb6WyjMIxVQ/M5/t4lQD3SX63glPqb5xsq4dlMKAyWQuB94t0Un8IZ
 Vchr9KPSyCuaR5I5ixte0NE1PJM+Ia3sb1CttlgvTVRJjMy8Ru+4c0GJ+vvZRNnfXio/
 Wm/g==
X-Gm-Message-State: AFuF++nuQPVC3tTmS0KH/j3iAL1Bu1/ZXOIGXrrFbMtYbGagSDpcKeCG
 hIlYsjspVWW/M/v5NOQ4Xd4Zol/4CAVUe6tYZ/0ES3vo+XKSgKugdhM+AS7jsd9yoRplgQMzMMS
 wJAnCScBT5P/ZNReloyEsnDlByqbLnIWMGyZGAk7qHzTopUvK9sPsXILcKc+mJOAev2XS
X-Gm-Gg: AR+sD10EDbuO6mGGbAhyaP3EWMY1eV9S7rAyZN+G0IpReQP/wwi7NrApfQvHYml5yEv
 0jAtoe8diQKhF7GoSsSRErekLsSlYr780G9XVypnzd6O+cjz27BVwoOk9fhkVX+dNPzK/PoYzUk
 s0xXINZx949BhRGiWVT4nNyEAGDK6q1mU2DHjOe3U5fScbn4Z/VMyseCV8RP2DOEZqNkLf7XLla
 UnkI1DSvpV9SbpL7fe/NnESuBXba9IYhDMRA3vgzdcy/zFGkqcYvdmwzzUJJAYm0DsNWwYxdYFp
 I3BG2cilr47b9QFh/Qmp/5u6/MYhmIFo582poxSw+QBkFSDCYsPx2CtPdoUDj5O8VcedG0jVC2R
 HDZs9yd4WIhDy+uS1eVDuv5qj/HaECDFVAG6iLlYZJyGovkv//mn3mFY4FKCmpLxv9Tv0dSB6ea
 Ba6h6Nf3YmnOSrQhZisaC6eqA80F+zC3UeDKYyM3Dw6smOVOUvShMQNen8pnK0OcUFSl2j/pQWi
 QvpVsDTd1ERornyPoJ4DtjabmAXQCCwBEqLqfC06ZtwPn97tMV+XtCU0HpCXyyyVpYKKByJrguZ
 ux63Hql9NCz/9GEgmf+WgaiEyebZoLX90d4W3t0Ca2Y7h1eetRQ=
X-Received: by 2002:a05:600c:3b1a:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49b91c2d8f3mr243597975e9.7.1788108463052; 
 Sun, 30 Aug 2026 09:47:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2005esm17062476f8f.24.2026.08.30.09.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:47:42 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 16:47:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 37527755efdcfd7d7b2d2092f6a5fda6143ae332
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc84139f1e9945c29ebb308e23b05cc16e2c84a3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0ihB-0003IJ-Pn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extract a field from a buffer
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
Content-Type: multipart/mixed; boundary="===============2486319800979920527=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2486319800979920527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RqiOVli+l3w="; charset=UTF-8

--RqiOVli+l3w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
razvanc


Change subject: Add helper method to extract a field from a buffe=
r
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add helper=
 method to extract a field from a buffer

Change-Id: Ifdd2122a3e60cdb11cc9d=
f67570ab5628bfcdeea
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1855
Message-Id: <20260828103517=2E13327-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38770=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tes=
ts/unit_tests/openvpn/test_buffer=2Ec
3 files changed, 65 insertions(+), 1 =
deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/55/1855/9

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=
=2Ec
index 046e231=2E=2E5ce2e39 100644
--- a/src/openvpn/buffer=2Ec
+++ b/s=
rc/openvpn/buffer=2Ec
@@ -1384,3 +1384,27 @@
     fclose(fp);
     return r=
et;
 }
+
+char *
+buf_extract_field(struct buffer *buf, char sep, struct gc=
_arena *gc)
+{
+    if (!buf_valid(buf))
+    {
+        return NULL;
+    =
}
+
+    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));
+ =
   if (!seppos)
+    {
+        return NULL;
+    }
+    size_t field_len =
=3D seppos - BPTR(buf);
+
+    char *field =3D gc_malloc(field_len + 1, fal=
se, gc);
+
+    memcpy(field, BPTR(buf), field_len);
+    field[field_len] =
=3D 0;
+
+    buf_advance(buf, field_len + 1);
+    return field;
+}
diff -=
-git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index bc5cffb=2E=2E4=
471697 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ =
-2243,4 +2243,14 @@
 /**@}*/
 /* End of Buffer Lists */
 
+/**
+ * Extract =
a field from buf that ends with the \c sep character=2E The
+ * returned st=
ring is allocated in the gc_arena=2E If the separator character
+ * is not =
found, the function returns the nullptr=2E
+ *
+ * The buffer is also forwa=
rded to the point after the separator character=2E
+ */
+char *
+buf_extrac=
t_field(struct buffer *buf, char sep, struct gc_arena *gc);
+
 #endif /* BU=
FFER_H */
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/uni=
t_tests/openvpn/test_buffer=2Ec
index ce38bbe=2E=2E7fb9162 100644
--- a/tes=
ts/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_b=
uffer=2Ec
@@ -456,6 +456,35 @@
     /* Check that our own method agrees */
=
     assert_true(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_CRLF));
   =
  assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+    gc_free(&gc);
=
+}
+
+static void
+test_buffer_extract_field(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(1000, &gc)=
;
+    assert_null(buf_extract_field(&buf, ',', &gc));
+
+    buf =3D alloc=
_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    const char *ret =3D=
 buf_extract_field(&buf, '5', &gc);
+    assert_string_equal(ret, "1234");
=
+    /* nothing left after the 5 */
+    assert_int_equal(buf_len(&buf), 0)=
;
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+ =
   ret =3D buf_extract_field(&buf, '4', &gc);
+    assert_string_equal(ret,=
 "123");
+
+    /* 5 should be left */
+    assert_int_equal(buf_len(&buf),=
 1);
+    assert_memory_equal(buf_bptr(&buf), "5", 1);
+
+    buf =3D alloc=
_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    assert_null(buf_ext=
ract_field(&buf, '6', &gc));
 
     gc_free(&gc);
 }
@@ -567,7 +596,8 @@
  =
       cmocka_unit_test(test_checked_snprintf),
         cmocka_unit_test(t=
est_buffer_chomp),
         cmocka_unit_test(test_buffer_null_terminate),
-=
        cmocka_unit_test(test_buffer_parse)
+        cmocka_unit_test(test_=
buffer_parse),
+        cmocka_unit_test(test_buffer_extract_field)
     };=

 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60cdb11c=
c9df67570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 9
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--RqiOVli+l3w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">Add helper method to extr=
act a field from a buffer<br><br>Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5=
628bfcdeea<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Ack=
ed-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855<br>Message-Id: &lt;20260828103517=
=2E13327-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38770=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_b=
uffer=2Ec<br>3 files changed, 65 insertions(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/55/1855/9</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buf=
fer=2Ec</span><br><span>index 046e231=2E=2E5ce2e39 100644</span><br><span>-=
-- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</s=
pan><br><span>@@ -1384,3 +1384,27 @@</span><br><span>     fclose(fp);</span=
><br><span>     return ret;</span><br><span> }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_e=
xtract_field(struct buffer *buf, char sep, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!buf_valid(buf))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8=
_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!seppos)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    size_t field_len =3D seppos - BPTR(buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char *field =3D gc_malloc(field_len + 1, false, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    memcpy(field, BPTR(buf), field_len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    field[field_len] =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, field_len + 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return field;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff=
 --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>in=
dex bc5cffb=2E=2E4471697 100644</span><br><span>--- a/src/openvpn/buffer=2E=
h</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -2243,4 +=
2243,14 @@</span><br><span> /**@}*/</span><br><span> /* End of Buffer Lists=
 */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extract a f=
ield from buf that ends with the \c sep character=2E The</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * returned string is allocated in the=
 gc_arena=2E If the separator character</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * is not found, the function returns the nullptr=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * The buffer is also forwarded to the =
point after the separator character=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_extrac=
t_field(struct buffer *buf, char sep, struct gc_arena *gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* BUFFER_=
H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec =
b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index ce38bbe=2E=
=2E7fb9162 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffe=
r=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span>=
<br><span>@@ -456,6 +456,35 @@</span><br><span>     /* Check that our own m=
ethod agrees */</span><br><span>     assert_true(string_check_buf(&amp;buf2=
, CC_PRINT | CC_NULL, CC_CRLF));</span><br><span>     assert_string_equal(B=
STR(&amp;buf2), &quot;CR_RESPONSE,MTIx&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_buffer_extr=
act_field(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(1000, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(buf_extract_field(&am=
p;buf, &#39;,&#39;, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =
=3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *ret =3D buf_extract_fi=
eld(&amp;buf, &#39;5&#39;, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(ret, &quot;1234&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing left after the =
5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(buf_len(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =
=3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D buf_extract_field(&amp;buf=
, &#39;4&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(ret, &quot;123&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* 5 should be left */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;buf), 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(buf_b=
ptr(&amp;buf), &quot;5&quot;, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_null(buf_extract_field(&=
amp;buf, &#39;6&#39;, &amp;gc));</span><br><span> </span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span>@@ -567,7 +596,8 @@</span=
><br><span>         cmocka_unit_test(test_checked_snprintf),</span><br><spa=
n>         cmocka_unit_test(test_buffer_chomp),</span><br><span>         cm=
ocka_unit_test(test_buffer_null_terminate),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        cmocka_unit_test(test_buffer_parse)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_buffer_parse),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_buffer_extract_field)</span><br><span>     };</sp=
an><br><span> </span><br><span>     return cmocka_run_group_tests_name(&quo=
t;buffer&quot;, tests, NULL, NULL);</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=
=3Demail">change 1855</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1855?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1855 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RqiOVli+l3w=--


--===============2486319800979920527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2486319800979920527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2486319800979920527==--


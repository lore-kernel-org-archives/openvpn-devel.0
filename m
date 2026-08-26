Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7157FC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuktP3ACyXpeyWed1wX0Kgh7ZOtuguNLzXyKgHXcLtM=; b=mf+TrgHYrhSOgnQmCHmyw+jwm6
	DnJLkiq9kmMaXHNqGNG0cJXmkRX5Gb+XESXBG4KOs3c72/J1KPsovSdbaILXraJ0fiGXTgcwTP4KJ
	h0/+fyeqVoqiqwrDyQeFO6Zfh3U0c96Py3xoscToSHFXyh0YBGoMiX1tjQMF3pzY1NPo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzCAr-0006s3-5v;
	Wed, 26 Aug 2026 11:52:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzCAp-0006ru-1c
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tVVSvHsyASLw5mFe8IiFhjkwV2zygUAVpq1YyDeDa5s=; b=nI7ODYE9Ik2224enSoA+iDdNdW
 TTVQJFviURDnk98jFD6lYl0ECDWKrW3cR+wp8K1JPVKUkbPx4hKcImLztL3YUXNcwor9XpGqJId+5
 er9lYDRFFEymMouE/bI4dsth4IudRZ5wUvKVMH0+puxH6a9wwUTqH13xkpA0lCrS+YAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tVVSvHsyASLw5mFe8IiFhjkwV2zygUAVpq1YyDeDa5s=; b=j
 ewDN4DNjMgBST/A7tyi4Bz57XHJ/4V/MTwwi/r8qYqcGkZjc+KEe62Vp+gvQPgutKc7F8LLtFuKli
 yVZcb/o6SfsSodJ5+MXegYHNBDHmhOEkolLlPu2FxzuWkKwiBdvrphG0SFPMZtOTIwuubgh9ZQeV0
 YTRXj4D9GZFApGeM=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzCAk-0001Lq-Fo for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:04 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so1516558a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787745116; x=1788349916; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tVVSvHsyASLw5mFe8IiFhjkwV2zygUAVpq1YyDeDa5s=;
 b=XlHBeS/BxKUJFuD48OAv4gnBAG0lhzHZz24Oiy0rNvWnC9BUklJ8Gki8Z3WRuDbCFe
 5XexZbYzfaHrUgnRa002EP0mfIyC/rRO7wAEP4MWP6ZeWdkHAI4sBkPDSLYCI2gFtDd3
 NleAn3Aku7uuhZa0AJkYLTnRCEaOUEIazsrPR2nohb5tWkD9/9HiRWX/+301hEMWH8Hh
 0686vQETKVvD9Sd7CZvULgqS7VDTaUpTSa42z/EED9tf/aFVnGktAXX8dEmJQj+p+T47
 dELmN0Gc90tCs+D/K3utN8qt3f8jKzB6uF9KjPJX6fd0KMZ9wQtLYiyyJheMt7Wqu85v
 Ourw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787745116; x=1788349916;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tVVSvHsyASLw5mFe8IiFhjkwV2zygUAVpq1YyDeDa5s=;
 b=q9crIEfuijJpUjn54Yeo6DTAftk1jnlY73yX14y+K7w7uIyVWaumssULTOlbObBIeE
 ZNdHVJS+RAiLvycqnwZI4U3/tXSuxkJrRV8qYNnJZXqanBA33th7vCIXK+We93srusLd
 Je/K2s+MrBOkvO6yd/QOpIsUpS2t7ptlpFtS8oARHrUDYZ0Em233yGoiqbVa1qZ8ArA/
 J0MQrwoXAStHx/j1NBmS0Z83hHY+RQRCqjrUxNslwKhfi4tDas9IO6uSDhk8nE8r6Rru
 JM2wWCiv6IS1o0LX/KZW+q+1CuVACjlIJN19JoqMQwH4Pl/zRl+i49Q/GDaEC+qI6t8z
 KD6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxW3c7aleA/u9O2q3+oD0enII50mVpznDvR1GDQhGyQaKgHqB3wTsPBWaZ6sWKaGYeUg/O+PkXWTLzh8Qb@lists.sourceforge.net
X-Gm-Message-State: AFuF++lYRUv4PXlHVDUTCQq5J18aUeRzZvCqD1S0d4UT5tqbMeE1LSns
 c4632m5ElBL+B7X/IPKNeEHvpm+lp1OsckYGRSuaXnbWyas8doevt4T/Li0lnbYS/P3vck0qnUv
 oHgDZL+5nvcRPp74XUrl7u5IfIteANRp9p+w6U4YzPDRfSFufCEqzpjqZ+kr1qQnpGYuyfSIJLL
 u4Z7znzA==
X-Gm-Gg: AR+sD11GjlASBKWykT5cFgz0QwLcNM++81FezH46cii9FvosUKst55PsDEfTzNMTntc
 1DZiq0adCFlzjURGdtsiVXyLtV93GYmBRC6E+4NjHTGNsKbT6I7Nv10StyMRw6Fkup+JlNFpDxE
 d+eSQmbpovn8gSdi9dhG3vlUUNoNx/IxhnET/pOq7t2xhmwLIA38kZoGLc+7FIUzu6mCNFQVulF
 O0TtEYl2xBVJk77cLTZqdmT6TCYmkULICwTjoIno2gydTmw+FP7g+oc9CK6y73DmqUEhjOn0pxv
 BfSUxjjRbzBjnWTvJ3j9+UZGXr1o7UCtV/J9iDHAf2aFrSRfa8pUbAQEpmadiuYcy/9sgb2y7FG
 UAT/I71eB4/QqAbwfl0ZzMJEVcgBEcabjNXSGzeQKoqro7wHqCFXBxm+yw6WlO02Yfj+sct7ceJ
 S4Y4aAGd+DKQDrzFpbcC5lLEM0ipuamUv6612wYrNxreGyktVa9yRhmOkEEx/h466QlsEjj3HAx
 8hEN6xdDn/3QtQ1zmeUod/vKTL9vqwxepYyBWwvLd2FpomvRvraWSgaWV7V7sep+/gedTohmZej
 49No2L5RQS/kAhZaNZHMOVzXPvQ2K7TJG7Hxpu89r1HbobZZiks=
X-Received: by 2002:a05:6402:304c:b0:6a5:d8f0:dc10 with SMTP id
 4fb4d7f45d1cf-6a5df63b144mr7425155a12.13.1787745115702; 
 Wed, 26 Aug 2026 04:51:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d21f8sm4311165a12.11.2026.08.26.04.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:51:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 11:51:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08677f114c3ac26073656d1be4ba3ce62e3583fa
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <858ffa49adaa03e9d662bb251702dcba3f4ae6a9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzCAk-0001Lq-Fo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extra a field from a buffer
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7267413976130842898=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7267413976130842898==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c2rdC5ery0w="; charset=UTF-8

--c2rdC5ery0w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, razvanc=2E

plaisthos has uplo=
aded a new patch set (#6)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
55?usp=3Demail )


Change subject: Add helper method to extra a field from =
a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add =
helper method to extra a field from a buffer

Change-Id: Ifdd2122a3e60cdb11=
cc9df67570ab5628bfcdeea
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
--=
-
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_tests/open=
vpn/test_buffer=2Ec
3 files changed, 59 insertions(+), 1 deletion(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855/6

d=
iff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 046e231=
=2E=2E3c5fe09 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=
=2Ec
@@ -1384,3 +1384,22 @@
     fclose(fp);
     return ret;
 }
+
+char *
=
+extract_field(struct buffer *buf, char sep, struct gc_arena *gc)
+{
+    c=
onst uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));
+    if (!se=
ppos)
+    {
+        return NULL;
+    }
+    size_t field_len =3D seppos =
- BPTR(buf);
+
+    char *field =3D gc_malloc(field_len + 1, false, gc);
+
=
+    strncpy(field, BSTR(buf), field_len);
+    field[field_len] =3D 0;
+
+=
    buf_advance(buf, (int)field_len + 1);
+    return field;
+}
\ No newlin=
e at end of file
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh
index bc5cffb=2E=2E0eae3cf 100644
--- a/src/openvpn/buffer=2Eh
+++ b/s=
rc/openvpn/buffer=2Eh
@@ -2243,4 +2243,13 @@
 /**@}*/
 /* End of Buffer Lis=
ts */
 
+/**
+ * Extract a field from buf that end with the \c sep characte=
r=2E The
+ * returned string is allocated in the gc_arena=2E If the separat=
or character
+ * is not found, the function returns the nullptr=2E
+ *
+ * =
The buffer is also forwarded to the point after the separator character=2E
=
+ */
+char *
+extract_field(struct buffer *buf, char sep, struct gc_arena *=
gc);
 #endif /* BUFFER_H */
diff --git a/tests/unit_tests/openvpn/test_buff=
er=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index ce38bbe=2E=2E062772=
c 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_te=
sts/openvpn/test_buffer=2Ec
@@ -456,6 +456,35 @@
     /* Check that our own=
 method agrees */
     assert_true(string_check_buf(&buf2, CC_PRINT | CC_NU=
LL, CC_CRLF));
     assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+=
    gc_free(&gc);
+}
+
+static void
+test_buffer_extract_field(void **state=
)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc=
_buf_gc(1000, &gc);
+    assert_null(extract_field(&buf, ',', &gc));
+
+   =
 buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    const=
 char *ret =3D extract_field(&buf, '5', &gc);
+    assert_string_equal(ret,=
 "1234");
+    /* nothing left after the 5 */
+    assert_int_equal(buf_len=
(&buf), 0);
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "1234=
5", 5);
+    ret =3D extract_field(&buf, '4', &gc);
+    assert_string_equa=
l(ret, "123");
+
+    /* 5 should be left */
+    assert_int_equal(buf_len(=
&buf), 1);
+    assert_memory_equal(buf_bptr(&buf), "5", 1);
+
+    buf =3D=
 alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    assert_null(e=
xtract_field(&buf, '6', &gc));
 
     gc_free(&gc);
 }
@@ -567,7 +596,8 @@
=
         cmocka_unit_test(test_checked_snprintf),
         cmocka_unit_test=
(test_buffer_chomp),
         cmocka_unit_test(test_buffer_null_terminate),=

-        cmocka_unit_test(test_buffer_parse)
+        cmocka_unit_test(tes=
t_buffer_parse),
+        cmocka_unit_test(test_buffer_extract_field)
     =
};
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60cd=
b11cc9df67570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 6
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eo=
rg>

--c2rdC5ery0w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, razvanc=2E </p>
<p>plaisthos <strong>uploaded =
patch set #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
Add helper method to extra a field from a buffer<br><br>Change-Id: Ifdd2122=
a3e60cdb11cc9df67570ab5628bfcdeea<br>Signed-off-by: Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=
=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files changed, 59 i=
nsertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855/6</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 046e=
231=2E=2E3c5fe09 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span>=
<br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -1384,3 +1384,22 =
@@</span><br><span>     fclose(fp);</span><br><span>     return ret;</span>=
<br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+extract_field(struct buffer *buf, char =
sep, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!seppos)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    size_t field_len =3D seppos - BPTR(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *field =3D gc_malloc(field_len + 1, false, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strncpy(field, BSTR(buf), field_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    field[field_len=
] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, (int)fiel=
d_len + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn field;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span>\ No newline at end of file</span><br><span>diff --git a/src/openvp=
n/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index bc5cffb=2E=2E0e=
ae3cf 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+=
++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -2243,4 +2243,13 @@</span><b=
r><span> /**@}*/</span><br><span> /* End of Buffer Lists */</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Extract a field from buf that =
end with the \c sep character=2E The</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * returned string is allocated in the gc_arena=2E If the =
separator character</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * is not found, the function returns the nullptr=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * The buffer is also forwarded to the point after the sep=
arator character=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+extract_field(struct buffer *=
buf, char sep, struct gc_arena *gc);</span><br><span> #endif /* BUFFER_H */=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/te=
sts/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index ce38bbe=2E=2E0=
62772c 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br>=
<span>@@ -456,6 +456,35 @@</span><br><span>     /* Check that our own metho=
d agrees */</span><br><span>     assert_true(string_check_buf(&amp;buf2, CC=
_PRINT | CC_NULL, CC_CRLF));</span><br><span>     assert_string_equal(BSTR(=
&amp;buf2), &quot;CR_RESPONSE,MTIx&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_buffer_extract_=
field(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf_gc(1000, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(extract_field(&amp;buf, &=
#39;,&#39;, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D allo=
c_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *ret =3D extract_field(&amp;buf=
, &#39;5&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(ret, &quot;1234&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* nothing left after the 5 */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_l=
en(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf=
_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ret =3D extract_field(&amp;buf, &#39;4&#39;, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(ret, &quot;123&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* 5 should be left */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(buf_len(&amp;buf), 1);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_memory_equal(buf_bptr(&amp;buf), &quo=
t;5&quot;, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc=
(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_null(extract_field(&amp;buf, &#39;6&#39;, &=
amp;gc));</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span>@@ -567,7 +596,8 @@</span><br><span>         cmo=
cka_unit_test(test_checked_snprintf),</span><br><span>         cmocka_unit_=
test(test_buffer_chomp),</span><br><span>         cmocka_unit_test(test_buf=
fer_null_terminate),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       cmocka_unit_test(test_buffer_parse)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buffer_parse),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_buffer_extract_field)</span><br><span>     };</span><br><span> </span><b=
r><span>     return cmocka_run_group_tests_name(&quot;buffer&quot;, tests, =
NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2=
122a3e60cdb11cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cro=
n2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--c2rdC5ery0w=--


--===============7267413976130842898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7267413976130842898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7267413976130842898==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FAFCA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hxQemElTF26JvygG8wU2q0mobclt1E5pRWkWlc6iuPo=; b=WPJv43quIQO6fR
	qtAGI1oYOMLYO8wYmBwODN7eVvly9pfJmRKXpu2VhHuBsVPRejed/YJt0wY8ehEXK5p5FXXNILjZv
	+U76NQzkBdC2taH9xXUYf5YZyTO2YNIgZjVju07hNBJDLdotFxDHR4S2Sr/gKkdTNoXhMLvFtVxS/
	8DA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDxy-0000vC-RC;
	Mon, 28 Sep 2026 16:12:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDxs-0000un-Fu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 16:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mnf4EAbxY7a7a64qbsNsykMZr+cVbVdGytKJi2i4NXY=; b=FqR/paV2HOBla8iPccnbaw2R9M
 XG4gdDmyuQD+BzWOjyh0LMSTSmmvWPLPrDyzukektcpiTZfnXcSmWwk9mycXhNdr9HFVaywguSyHp
 NOtOk19VOEzWVVCm0Gtk7Y/aT/a6VGxg0eVCdZAD+B36lRf5aPsWZDPhGZKzJut1+pvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mnf4EAbxY7a7a64qbsNsykMZr+cVbVdGytKJi2i4NXY=; b=l
 ZQx0E05cmqNEYv/gUDMVBraHxzP/RW8F2U+JsJjvJHpFifNSyGp5EPXlqzOrl9Dm7y4S6/QK+iIU4
 VBbS/PB52NW3/hULlY1q7RwodKx46uIEiXyEW4M/vSFX0QIirHZfU7lI88ObK6d/V82mJmP5Mn/Yg
 oGyXizfxnI//Upb8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDxp-0006cU-VM for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 16:12:29 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so24649445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790611939; x=1791216739; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mnf4EAbxY7a7a64qbsNsykMZr+cVbVdGytKJi2i4NXY=;
 b=E8D3XwjZiyOl+xglklfoXVoJLuOUyZwnGcVf+tdevYahfbFJ4fZupqMk20NFxIbKfx
 eyMVdxQ81sdEvzQnIerO/rqDs0Gis2NkvN8wB1fTBQeh7r6s6Tncgm/2KjPgDxuLN75D
 ljzVnAtSxofboLZ89GakiFCP58BQwnIMN64xrF+bu7eG6+0KXh4PZW0Eig6q30NWzyIf
 m8UVkdo9F9tDJRIZzrA49nnULdw+hI7RwmGUq5lsRjZ+8GBRtwbQzs2KU39ADGts0XFX
 p/3HGRp77aVyqfcXGvQr8MyIVYtpgQIMzWeKNimAusJzrbr4UROkupTqIkR57LyxaCsn
 Rjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611939; x=1791216739;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mnf4EAbxY7a7a64qbsNsykMZr+cVbVdGytKJi2i4NXY=;
 b=bhBTT8vN1hzgch6fOPeVDnLv0c6d2Fsd4nJfK3WRVzNcu3GsjuUns+qPWIvsxgy2EQ
 FK8zaCk9Ge5891opnNzRYI8le9hY3nppELNyhkiUScSPt5+9ZMXYeMSkBKqgG5XJpxo/
 MdLRVl8DpumJ2DY/enY6Y10THYHmy41K+8tTxCsbrUuvmANQPxwaYJsq1CmV2S2h2O2j
 amQPzhzF+rCJs75WigHmxAF3Cdlodj4Xm+9kiaasP0BLBpEwlBvnJ6fl21bUaB92qqCz
 FVD8sGabZ1aJg98OY0i9wPoJE5/ifw/gedppQr6xbBQtz59lpszjFbJIO7A6UuLHXfW4
 oOAg==
X-Gm-Message-State: AFuF++mL2AyAIJpz9U8GQKfr6lkpNFQ3w2wgqRfgCn6GSO1TtsRi0wj/
 XCPGao+myLQtCF9VM7rYDwSvh4JBHglLyBbJA/Ifd9Q3SFfAQJwnNKmywc/bbTZRJ1k9dosGree
 HL3rGHXrKXoXjF+HFbxeVN7/X/n/C2L93X/0l9KXUGgQrQ+53PdiCy6KekTyZ4RnKkAdvg38X1r
 frEPb2Uw==
X-Gm-Gg: AYBFou07i+58jm14VNP9Kx+/u3RWh+Iyna3kDfOookJmZOEgqoDtlE7t7veWZq/cpR0
 gHBqg/DS4K07KRHFdrLm6Bkqd/li9KK+9q1NINbgB2Ki5Ysvatzd4ZGmdNYYUUMRCJ65yrDVNA2
 p2zJBpcLEKG+hHehjEYxXQrCYih1DJVx11s48W0CwJ6TXWowO8hZwA5NE7GZR/S4Pw54ZBfbqYD
 eoo7B807VnykJIV1863k+TCqeCygXebj1kLHzP+gTVc3TQunHFx9LXguGzBpJkBn/hcSU0slhKp
 l/EJOwu78yMMxKl/iw4vTbXjeoIyTv3fPEvIkryYqKeGPpRhtyhXkTxaRTXcbsX+QMkbXzQEjZ8
 qHZFEZaHTrT1QlOwh03qn7kAR/HHksWHe6UtVWLflDq734gMvkncxjBG9Kx+4YMdLG1Lo9DMpH+
 kAnbN71Xkrdo9fKQDEKWfxVMEDyM4Wc86qjvTlaYDONGG/LOHRd3JosjF/zNEJajIlG3V0k51bt
 uY0CrvSeov6f46131ad4XtRFgU8AqjJfVaIp886rz4lZiJhoW8KfVwNGGXNSzcyffSwc77R6kAQ
 O3mK91Q5htlHO8Sz1YX9LnoF1sKwXPzPufqp8kJg5AWLL+2phuZ6eslradm5
X-Received: by 2002:a05:600c:354a:b0:49f:bd3c:bc1d with SMTP id
 5b1f17b1804b1-49fe66fd425mr235098555e9.24.1790611939160; 
 Mon, 28 Sep 2026 09:12:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0ea071sm1822685e9.9.2026.09.28.09.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 09:12:18 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 16:12:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: ee54ec4336d8a6fd39ebe77b38efef8eb4a56bec
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2cd7edca5af8f330e96dc24c87ed9359e7280185-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDxp-0006cU-VM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbuf: don't count
 dereferenced items in the queue length
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8149029231451304619=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8149029231451304619==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6tyNLDWikGs="; charset=UTF-8

--6tyNLDWikGs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1961?usp=3Demail

to review the following change=2E


Chang=
e subject: mbuf: don't count dereferenced items in the queue length
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mbuf: don't count d=
ereferenced items in the queue length

Items of a closed instance are clear=
ed in place, because head + len is
the ring's insertion point=2E  mbuf_extr=
act_item() reclaims such holes as
it walks past them, but nothing does once=
 no live item is left behind
them, so ms->len keeps counting slots that can=
 never be sent=2E

mbuf_defined() and mbuf_peek() then disagree about wheth=
er the queue
holds anything, and a ring made of nothing but holes still loo=
ks full
to mbuf_add_item(), which tries to make room by dropping the oldest=

packet and finds nothing it can drop=2E

A UDP socket hides this, as the I=
OW_MBUF write event reclaims the holes
on its way out; a TCP-only server ha=
s nothing that does=2E

Reclaim the holes once they reach the head, so that=
 ms->len only counts
what can still be sent=2E

Change-Id: I9579ab9a3f588a3=
841bb90c9a4b930b7690e0b71
Signed-off-by: Gianmarco De Gregori <gianmarco@ma=
ndelbit=2Ecom>
---
M src/openvpn/mbuf=2Ec
M tests/unit_tests/openvpn/test_m=
buf=2Ec
2 files changed, 112 insertions(+), 2 deletions(-)



  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/1961/1

diff --git=
 a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 7b790ed=2E=2E6678a5b 1=
00644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -85,6 +85,21=
 @@
     }
 }
 
+/*
+ * Dereferenced items cannot be removed from the middl=
e of the ring, so
+ * reclaim them once they reach the head: ms->len must o=
nly count items
+ * which can still be sent=2E
+ */
+static void
+mbuf_recl=
aim_head(struct mbuf_set *ms)
+{
+    while (ms->len && !ms->array[ms->head=
]=2Einstance)
+    {
+        ms->head =3D MBUF_INDEX(ms->head, 1, ms->capa=
city);
+        --ms->len;
+    }
+}
+
 void
 mbuf_add_item(struct mbuf_set=
 *ms, const struct mbuf_item *item)
 {
@@ -125,6 +140,7 @@
                =
 break;
             }
         }
+        mbuf_reclaim_head(ms);
     }
  =
   return ret;
 }
@@ -164,5 +180,6 @@
                 msg(D_MBUF, "MBUF: d=
ereferenced queued packet");
             }
         }
+        mbuf_reclai=
m_head(ms);
     }
 }
diff --git a/tests/unit_tests/openvpn/test_mbuf=2Ec b=
/tests/unit_tests/openvpn/test_mbuf=2Ec
index cba4da7=2E=2Ee20e941 100644
-=
-- a/tests/unit_tests/openvpn/test_mbuf=2Ec
+++ b/tests/unit_tests/openvpn/=
test_mbuf=2Ec
@@ -136,9 +136,9 @@
     mbuf_dereference_instance(ms, &mi2);=

     assert_int_equal(mbuf_buf->refcount, 2);
     assert_int_equal(mbuf_b=
uf2->refcount, 1);
-    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_=
equal(mbuf_len(ms), 1);
     assert_int_equal(mbuf_maximum_queued(ms), 4);
=
-    assert_int_equal(ms->head, 3);
+    assert_int_equal(ms->head, 1);
   =
  assert_ptr_equal(mbuf_peek(ms), &mi);
 
     mbuf_free(ms);
@@ -148,12 +1=
48,105 @@
     mbuf_free_buf(mbuf_buf2);
 }
 
+/* a queue holding nothing b=
ut dereferenced items is an empty queue */
+static void
+test_mbuf_derefere=
nce_reclaims_queue(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(=
4);
+    struct multi_instance mi =3D { 0 };
+    struct buffer buf =3D all=
oc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+  =
  struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi }=
;
+    free_buf(&buf);
+
+    for (int i =3D 0; i < 4; ++i)
+    {
+       =
 mbuf_add_item(ms, &item);
+    }
+    assert_int_equal(mbuf_len(ms), 4);
+=
    assert_int_equal(mbuf_buf->refcount, 5);
+
+    mbuf_dereference_instan=
ce(ms, &mi);
+
+    assert_int_equal(mbuf_len(ms), 0);
+    assert_false(mb=
uf_defined(ms));
+    assert_null(mbuf_peek(ms));
+    assert_int_equal(mbu=
f_buf->refcount, 1);
+
+    /* the queue is empty, so this must be queued a=
nd not dropped */
+    mbuf_add_item(ms, &item);
+    assert_int_equal(mbuf=
_len(ms), 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(m=
s);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* extracting the last live item mu=
st not leave a trailing hole behind */
+static void
+test_mbuf_extract_recl=
aims_tail(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(4);
+    =
struct multi_instance mi =3D { 0 };
+    struct multi_instance mi2 =3D { 0 =
};
+    struct buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_=
buf =3D mbuf_alloc_buf(&buf);
+    struct mbuf_item item =3D { =2Ebuffer =
=3D mbuf_buf, =2Einstance =3D &mi };
+    struct mbuf_item item2 =3D { =2Eb=
uffer =3D mbuf_buf, =2Einstance =3D &mi2 };
+    free_buf(&buf);
+
+    mbu=
f_add_item(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_dereferenc=
e_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 2); /* head is st=
ill live, nothing to reclaim */
+
+    struct mbuf_item out;
+    assert_tr=
ue(mbuf_extract_item(ms, &out));
+    assert_ptr_equal(out=2Einstance, &mi)=
;
+    mbuf_free_buf(out=2Ebuffer);
+
+    assert_int_equal(mbuf_len(ms), 0=
);
+    assert_false(mbuf_defined(ms));
+    assert_null(mbuf_peek(ms));
+
=
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* a ring "full" of=
 dereferenced items must not look full to mbuf_add_item() */
+static void
+=
test_mbuf_add_on_stale_full_queue(void **state)
+{
+    struct mbuf_set *ms=
 =3D mbuf_init(1);
+    struct multi_instance mi =3D { 0 };
+    struct mul=
ti_instance mi2 =3D { 0 };
+    struct buffer buf =3D alloc_buf(16);
+    s=
truct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    struct mbuf_item=
 item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi };
+    struct mbuf=
_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi2 };
+    free=
_buf(&buf);
+
+    assert_int_equal(ms->capacity, 1);
+    mbuf_add_item(ms=
, &item);
+    mbuf_dereference_instance(ms, &mi);
+
+    mbuf_add_item(ms,=
 &item2);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbu=
f_peek(ms), &mi2);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+=

 int
 main(void)
 {
     const struct CMUnitTest tests[] =3D {
         cm=
ocka_unit_test(test_mbuf_init),
         cmocka_unit_test(test_mbuf_add_rem=
ove),
+        cmocka_unit_test(test_mbuf_dereference_reclaims_queue),
+   =
     cmocka_unit_test(test_mbuf_extract_reclaims_tail),
+        cmocka_uni=
t_test(test_mbuf_add_on_stale_full_queue),
     };
 
     return cmocka_run=
_group_tests_name("mbuf", tests, NULL, NULL);

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
Gerr=
it-Change-Number: 1961
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--6tyNLDWikGs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>its_Giaan would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1961?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">mbuf: don&#39;t count dereferenced items in the queue length<br><br>Ite=
ms of a closed instance are cleared in place, because head + len is<br>the =
ring&#39;s insertion point=2E  mbuf_extract_item() reclaims such holes as<b=
r>it walks past them, but nothing does once no live item is left behind<br>=
them, so ms-&gt;len keeps counting slots that can never be sent=2E<br><br>m=
buf_defined() and mbuf_peek() then disagree about whether the queue<br>hold=
s anything, and a ring made of nothing but holes still looks full<br>to mbu=
f_add_item(), which tries to make room by dropping the oldest<br>packet and=
 finds nothing it can drop=2E<br><br>A UDP socket hides this, as the IOW_MB=
UF write event reclaims the holes<br>on its way out; a TCP-only server has =
nothing that does=2E<br><br>Reclaim the holes once they reach the head, so =
that ms-&gt;len only counts<br>what can still be sent=2E<br><br>Change-Id: =
I9579ab9a3f588a3841bb90c9a4b930b7690e0b71<br>Signed-off-by: Gianmarco De Gr=
egori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/mbuf=2Ec<br=
>M tests/unit_tests/openvpn/test_mbuf=2Ec<br>2 files changed, 112 insertion=
s(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/61/1961/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>index 7b790ed=2E=2E66=
78a5b 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++=
 b/src/openvpn/mbuf=2Ec</span><br><span>@@ -85,6 +85,21 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Dereferenced items cannot be removed from the middle of the ring,=
 so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reclaim them =
once they reach the head: ms-&gt;len must only count items</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * which can still be sent=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+mbuf_reclaim_head(struct mbuf_set *ms)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    while (ms-&gt;len &amp;&amp; !ms-&gt;array[m=
s-&gt;head]=2Einstance)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
-&gt;head =3D MBUF_INDEX(ms-&gt;head, 1, ms-&gt;capacity);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        --ms-&gt;len;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> void</span><br><span> mbuf_add_item(struct mbuf_=
set *ms, const struct mbuf_item *item)</span><br><span> {</span><br><span>@=
@ -125,6 +140,7 @@</span><br><span>                 break;</span><br><span>=
             }</span><br><span>         }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        mbuf_reclaim_head(ms);</span><br><span>     }=
</span><br><span>     return ret;</span><br><span> }</span><br><span>@@ -16=
4,5 +180,6 @@</span><br><span>                 msg(D_MBUF, &quot;MBUF: dere=
ferenced queued packet&quot;);</span><br><span>             }</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  mbuf_reclaim_head(ms);</span><br><span>     }</span><br><span> }</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_mbuf=2Ec b/tests/unit_te=
sts/openvpn/test_mbuf=2Ec</span><br><span>index cba4da7=2E=2Ee20e941 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_mbuf=2Ec</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_mbuf=2Ec</span><br><span>@@ -136,9 +=
136,9 @@</span><br><span>     mbuf_dereference_instance(ms, &amp;mi2);</spa=
n><br><span>     assert_int_equal(mbuf_buf-&gt;refcount, 2);</span><br><spa=
n>     assert_int_equal(mbuf_buf2-&gt;refcount, 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(mbuf_len(ms), 3);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbu=
f_len(ms), 1);</span><br><span>     assert_int_equal(mbuf_maximum_queued(ms=
), 4);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_=
equal(ms-&gt;head, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(ms-&gt;head, 1);</span><br><span>     assert_ptr_eq=
ual(mbuf_peek(ms), &amp;mi);</span><br><span> </span><br><span>     mbuf_fr=
ee(ms);</span><br><span>@@ -148,12 +148,105 @@</span><br><span>     mbuf_fr=
ee_buf(mbuf_buf2);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* a queue holding nothing but derefere=
nced items is an empty queue */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_mbuf_dereference_reclaims_queue(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(4);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r buf =3D alloc_buf(16);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item =
=3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 4; ++i)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        mbuf_add_item(ms, &amp;item);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 4);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_b=
uf-&gt;refcount, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereferen=
ce_instance(ms, &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(mbuf_len(ms), 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(mbuf_defined(ms));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_null(mbuf_peek(ms));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&gt;refcoun=
t, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* the queue is empty, so th=
is must be queued and not dropped */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf=
_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(m=
buf_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* extracting the last live item must not leave=
 a trailing hole behind */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_mbuf_extract_reclaims_tail(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct mbuf_set *ms =3D mbuf_init(4);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance =
mi2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf(16);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_=
item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item2 =
=3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi2 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_in=
stance(ms, &amp;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(mbuf_len(ms), 2); /* head is still live, nothing to =
reclaim */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item out;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(mbuf_e=
xtract_item(ms, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_ptr_equal(out=2Einstance, &amp;mi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(out=2Ebuffer);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(mbuf_defin=
ed(ms));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
null(mbuf_peek(ms));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(m=
buf_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* a ring &quot;full&quot; of dereferenced item=
s must not look full to mbuf_add_item() */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_mbuf_add_on_stale_full_queue(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct multi_instance mi2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf(16);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf=
_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &=
amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi2 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;capacit=
y, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_=
item(ms, &amp;item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mbuf_dereference_instance(ms, &amp;mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    mbuf_add_item(ms, &amp;item2);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms),=
 &amp;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span=
> main(void)</span><br><span> {</span><br><span>     const struct CMUnitTes=
t tests[] =3D {</span><br><span>         cmocka_unit_test(test_mbuf_init),<=
/span><br><span>         cmocka_unit_test(test_mbuf_add_remove),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
mbuf_dereference_reclaims_queue),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_mbuf_extract_reclaims_tail),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_mbuf_add_on_stale_full_queue),</span><br><span>     };</span><br><s=
pan> </span><br><span>     return cmocka_run_group_tests_name(&quot;mbuf&qu=
ot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail">change 1961</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9579ab9a3f5=
88a3841bb90c9a4b930b7690e0b71 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1961 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--6tyNLDWikGs=--


--===============8149029231451304619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8149029231451304619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8149029231451304619==--


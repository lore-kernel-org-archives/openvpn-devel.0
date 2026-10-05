Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FAACA5FF5
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orrTZ7yd2mSLquONKA9iHyUv/geeF3FMYU7wg7ffiv0=; b=YZSr5rDQkjN0oREoxKqRzSGaxn
	elWwwRuJIQjj1nn4aC53KKW94/m6hyOIYy8TsBr5v3yqy8xgf9shQg2jDgqA+W79dNcBbrafxOOFL
	ggdz8Niv+/ZmVCCeoWVgn0wtiXT2KPy6FNgk6a/W7eToqM1q55y1n9clsjpEi2odZOOA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDr55-0003SK-SS;
	Mon, 05 Oct 2026 22:22:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDr54-0003S5-E3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 22:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RNHJbi+FNBw5r/fKRDnu9GYTmJutG64XopkrvrmUM6g=; b=MnxaKpU++Eu3oS3GLQDfEOKHdw
 1Lo841Ho2YFpPKqFvxDNt9bH95lDQdjg7Mvbl7mSyg5BC/QE21RTPFn1Sx/mWl6p+FwaUJINK+M2S
 0tbxnB3C4T5OSG72FUn6ITCyWJEj3VufdZj2NP/DtttDksRF0B9JZ6kO/pQqAJPkrmBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RNHJbi+FNBw5r/fKRDnu9GYTmJutG64XopkrvrmUM6g=; b=E
 OAqVp8/xYSGS5XBEg1ndpSTHoHlwYoonb3SpmeZUIHFNsaYuhLUlkXs25JqI5d1BYuPN6ZboN+Icl
 S24ZvHSDDzJt32GnrUfHGk+VfqKQ6ANpL2ooHBAzSh0wKBxz4mvhf3OIhn2F9UgqBNu3M/q6Qk12C
 0+1x+J+fmxmYxVCA=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDr52-0002tI-Dr for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 22:22:47 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af5ae31d8so1684555f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791238958; x=1791843758; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RNHJbi+FNBw5r/fKRDnu9GYTmJutG64XopkrvrmUM6g=;
 b=IAOarO5ixVBi+IfD5WUfg6hrICrBG06hULkVDujVCVRmVjV8n0V/SrXJaeJMvregyV
 a/gC+TFG7ruWS2YKrMdU7zIqXgkCM5J0d35vC2khW83ZhTvxZeF+LbdGXkMXzwc+sX1V
 H0OzQSnF0v0RkOdZaCKxswp56COQ89Qn+TBPm1G/Tr16Src/cjjcMRETFYqHTgxsu1VY
 pYBLiIXI32UCc7C6fOXuOCDxqraoh6tQB3gpXJH3vqgIouimo/LOU/CLq8ySm2gLAiPi
 FL67y1lCVumIQ33r57ZpxXtOZ+G2sNj1guPZOhsP2SuP+Tsaobh2A2ksp2G6nuskn0l9
 6D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238958; x=1791843758;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RNHJbi+FNBw5r/fKRDnu9GYTmJutG64XopkrvrmUM6g=;
 b=y9/AceXnaLRq+eHYH6qieDgZcXFZDKU8P46RtdId33O8daYJD3ddvNTnoYV26maZsz
 VIeUyPaFHtHZTrFLel6M6PrrJ6fNnXv7A4YoPlplNtugw0UYVB1IPScSBnC3JGa3XGqp
 17Zcw4HW7C8ToAPFcN1ZAJkBWBBN2K9jrOMGHo6oWpAoS2banRbblmwOYEllS8c9fg69
 iZn/lrtlVjXyLGJdz5kfQRuPSw9YlANY+kAkkOeVgcRkW/VLYrG8fIgF1o4+F1ZZv7XQ
 rElpD0oYY/EjTMtlnybHlsC/TkzeoyClMfev1iN16C3GDpURF/FDI1ALao+5KfvPBxX6
 eJfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLDRfhRWiRZpWJY1vZnvSi6z2F5u2nbPq6s+2MuOJIeS2ZadX8DfHbD+BoMqelyA+wPVa6DAsRiOzaQ11y@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL7ptKkaY7Qc54+M5o9z+vusMxgU8zGk0KpG8LtStKnNePT6yfG
 SR9K9jRyua/8qBaaXQhLN3/uBAWHFNwraUwZQTFFzymTA3MjP1oIELXO/UEq1wiqqmyNGTk2cl/
 JIEnr2w0Dwio0vFdUX2c+Oyb0j2L8NgB3PwXmOqLZX8zcSIMbw540vPDMf09RqYB4wz7AroGx2J
 ZEtizy3g==
X-Gm-Gg: AYBFou3dLkyN012woJ3NPH6qLXWNYJCt2iUjamOhZhOuzaAaqykUciPDs4ygh85DXCe
 HWWrsVXo/krQz0ubC7Slw++sDOMse0UICyGRSCWhwE2xFzy4OaUn/utn1f2CWZQPpZ74RW2pJfZ
 +7cj/3XHW1hFQMGMoJ3cQtV8vRAeBiFZ+gRYj23DKvh0G1+eDlZNz+LZ66H7GJ0bewIWcbGKt+a
 kcRfKlX9s+z/t8qp4NeSNu5g4nEYOTy11n4uIJVHG7O/2cpV1hBVDpOONCqtG8WLpOLUPLJijM7
 tZ79g3BxVWTqxbQLDzTV17d/oCSd3u7zTRFCrcnHQ6G/FInehCqT4O6meRU7b/s0WyIVCEA6nKI
 nOPc4478IAHh/A3Q8mDshDW7jgohldTQE6rNZQW6uiFYkwY7TY3homaMHCazA1Xe0V4qt7tMH0d
 RIqpFL1VOcT0QjJbntv6+tJWHhphEAiYXoGGSDFHiiiQp3n5xScgNQpAE3DSUMLqAmf+LSor/yH
 jOdCrNWdzv//I7tsu23QzvkZt/1GfdAWPkEHRbc8n28iFlzFauc7CXaONzqoBfRF2jPQWlkB6PO
 P+MF1xSgNHWHn38zukKlRS3kfa5iVQzdcYaKhbX7l6h6MYdBjZcHVoyL03fXzg==
X-Received: by 2002:a05:6000:144c:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-48c1ec3ed97mr20872627f8f.57.1791238957730; 
 Mon, 05 Oct 2026 15:22:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229291fsm6710035f8f.27.2026.10.05.15.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:22:37 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 22:22:36 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: 10bc348ce70008bb150d37ad2ce4c5891117f299
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eb7141164efdd238552223676cfd36c6439aab0-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDr52-0002tI-Dr
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1645119203674993452=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1645119203674993452==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OzpHslwIUZQ="; charset=UTF-8

--OzpHslwIUZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1961?usp=3Demail )

Change subject: mbuf: don't count dereferen=
ced items in the queue length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

mbuf: don't count dereferenced items in the queue length

=
Items of a closed instance are cleared in place, because head + len is
the =
ring's insertion point=2E  mbuf_extract_item() reclaims such holes as
it wa=
lks past them, but nothing does once no live item is left behind
them, so m=
s->len keeps counting slots that can never be sent=2E

mbuf_defined() and m=
buf_peek() then disagree about whether the queue
holds anything, and a ring=
 made of nothing but holes still looks full
to mbuf_add_item(), which tries=
 to make room by dropping the oldest
packet and finds nothing it can drop=
=2E

A UDP socket hides this, as the IOW_MBUF write event reclaims the hole=
s
on its way out; a TCP-only server has nothing that does=2E

Reclaim the h=
oles once they reach the head, so a ring that holds no live
item at all can=
not keep looking full=2E  Holes sitting behind a live item
are still counte=
d, but an extract walking past them takes them along,
and mbuf_add_item() a=
lways has the live head left to evict=2E

Change-Id: I9579ab9a3f588a3841bb9=
0c9a4b930b7690e0b71
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbi=
t=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961
Message-Id: <20261005130215=2E2=
5812-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg39710=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mbuf=2Ec
M tests/unit_tests=
/openvpn/test_mbuf=2Ec
2 files changed, 158 insertions(+), 2 deletions(-)

=



diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 7b790ed=
=2E=2E5bb397f 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
=
@@ -85,6 +85,21 @@
     }
 }
 
+/*
+ * Dereferenced items cannot be removed=
 from the middle of the ring, so
+ * reclaim them once they reach the head:=
 a ring left without any live
+ * item must not keep looking full=2E
+ */
+=
static void
+mbuf_reclaim_head(struct mbuf_set *ms)
+{
+    while (ms->len =
&& !ms->array[ms->head]=2Einstance)
+    {
+        ms->head =3D MBUF_INDEX=
(ms->head, 1, ms->capacity);
+        --ms->len;
+    }
+}
+
 void
 mbuf_ad=
d_item(struct mbuf_set *ms, const struct mbuf_item *item)
 {
@@ -125,6 +140=
,7 @@
                 break;
             }
         }
+        mbuf_recla=
im_head(ms);
     }
     return ret;
 }
@@ -164,5 +180,6 @@
               =
  msg(D_MBUF, "MBUF: dereferenced queued packet");
             }
         =
}
+        mbuf_reclaim_head(ms);
     }
 }
diff --git a/tests/unit_tests/o=
penvpn/test_mbuf=2Ec b/tests/unit_tests/openvpn/test_mbuf=2Ec
index cba4da7=
=2E=2E61d438b 100644
--- a/tests/unit_tests/openvpn/test_mbuf=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_mbuf=2Ec
@@ -136,9 +136,9 @@
     mbuf_dereferen=
ce_instance(ms, &mi2);
     assert_int_equal(mbuf_buf->refcount, 2);
     a=
ssert_int_equal(mbuf_buf2->refcount, 1);
-    assert_int_equal(mbuf_len(ms)=
, 3);
+    assert_int_equal(mbuf_len(ms), 1);
     assert_int_equal(mbuf_ma=
ximum_queued(ms), 4);
-    assert_int_equal(ms->head, 3);
+    assert_int_e=
qual(ms->head, 1);
     assert_ptr_equal(mbuf_peek(ms), &mi);
 
     mbuf_f=
ree(ms);
@@ -148,12 +148,151 @@
     mbuf_free_buf(mbuf_buf2);
 }
 
+/* a q=
ueue holding nothing but dereferenced items is an empty queue */
+static vo=
id
+test_mbuf_dereference_reclaims_queue(void **state)
+{
+    struct mbuf_=
set *ms =3D mbuf_init(4);
+    struct multi_instance mi =3D { 0 };
+    str=
uct buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbu=
f_alloc_buf(&buf);
+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf,=
 =2Einstance =3D &mi };
+    free_buf(&buf);
+
+    for (int i =3D 0; i < 4=
; ++i)
+    {
+        mbuf_add_item(ms, &item);
+    }
+    assert_int_equ=
al(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_buf->refcount, 5);
+
+    m=
buf_dereference_instance(ms, &mi);
+
+    assert_int_equal(mbuf_len(ms), 0)=
;
+    assert_false(mbuf_defined(ms));
+    assert_null(mbuf_peek(ms));
+  =
  assert_int_equal(mbuf_buf->refcount, 1);
+
+    /* the queue is empty, so=
 this must be queued and not dropped */
+    mbuf_add_item(ms, &item);
+   =
 assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbuf_peek(ms), &m=
i);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* extracting=
 the last live item must not leave a trailing hole behind */
+static void
+=
test_mbuf_extract_reclaims_tail(void **state)
+{
+    struct mbuf_set *ms =
=3D mbuf_init(4);
+    struct multi_instance mi =3D { 0 };
+    struct mult=
i_instance mi2 =3D { 0 };
+    struct buffer buf =3D alloc_buf(16);
+    st=
ruct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    struct mbuf_item =
item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi };
+    struct mbuf_=
item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi2 };
+    free_=
buf(&buf);
+
+    mbuf_add_item(ms, &item);
+    mbuf_add_item(ms, &item2);=

+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(m=
s), 2); /* head is still live, nothing to reclaim */
+
+    struct mbuf_ite=
m out;
+    assert_true(mbuf_extract_item(ms, &out));
+    assert_ptr_equal=
(out=2Einstance, &mi);
+    mbuf_free_buf(out=2Ebuffer);
+
+    assert_int_=
equal(mbuf_len(ms), 0);
+    assert_false(mbuf_defined(ms));
+    assert_nu=
ll(mbuf_peek(ms));
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+=

+/* reclaiming stops at the first live item, it does not walk the whole ri=
ng */
+static void
+test_mbuf_extract_reclaims_up_to_live(void **state)
+{
=
+    struct mbuf_set *ms =3D mbuf_init(4);
+    struct multi_instance mi =
=3D { 0 };
+    struct multi_instance mi2 =3D { 0 };
+    struct buffer buf=
 =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&b=
uf);
+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =
=3D &mi };
+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Eins=
tance =3D &mi2 };
+    free_buf(&buf);
+
+    /* [mi][mi2][mi] -> dereferen=
cing mi2 leaves [mi][hole][mi] */
+    mbuf_add_item(ms, &item);
+    mbuf_=
add_item(ms, &item2);
+    mbuf_add_item(ms, &item);
+    mbuf_dereference_=
instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 3); /* head is live=
, nothing to reclaim yet */
+
+    /* extracting the head leaves the hole i=
n front: it must be reclaimed, and
+     * the walk must stop at the live i=
tem behind it */
+    struct mbuf_item out;
+    assert_true(mbuf_extract_i=
tem(ms, &out));
+    assert_ptr_equal(out=2Einstance, &mi);
+    mbuf_free_=
buf(out=2Ebuffer);
+
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_tr=
ue(mbuf_defined(ms));
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbu=
f_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* Holes behind a live item=
 are not reclaimed, so a full ring can still hold
+ * them=2E mbuf_add_item=
() must cope: it evicts the live head, which drags the
+ * holes with it, r=
ather than finding nothing to drop=2E */
+static void
+test_mbuf_add_on_ful=
l_queue_with_holes(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(=
4);
+    struct multi_instance mi =3D { 0 };
+    struct multi_instance mi2=
 =3D { 0 };
+    struct multi_instance mi3 =3D { 0 };
+    struct buffer bu=
f =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&=
buf);
+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =
=3D &mi };
+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Eins=
tance =3D &mi2 };
+    struct mbuf_item item3 =3D { =2Ebuffer =3D mbuf_buf,=
 =2Einstance =3D &mi3 };
+    free_buf(&buf);
+
+    /* [mi][mi2][mi2][mi2]=
 -> dereferencing mi2 leaves [mi][hole][hole][hole],
+     * which mbuf_rec=
laim_head() cannot touch: the head is still live */
+    mbuf_add_item(ms, =
&item);
+    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &item2);
+  =
  mbuf_add_item(ms, &item2);
+    mbuf_dereference_instance(ms, &mi2);
+   =
 assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_len(ms), ms-=
>capacity); /* still counts as full */
+
+    mbuf_add_item(ms, &item3);
+ =
   assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbuf_peek(ms), =
&mi3);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
 int
 main(=
void)
 {
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_te=
st(test_mbuf_init),
         cmocka_unit_test(test_mbuf_add_remove),
+     =
   cmocka_unit_test(test_mbuf_dereference_reclaims_queue),
+        cmocka_=
unit_test(test_mbuf_extract_reclaims_tail),
+        cmocka_unit_test(test_=
mbuf_extract_reclaims_up_to_live),
+        cmocka_unit_test(test_mbuf_add_=
on_full_queue_with_holes),
     };
 
     return cmocka_run_group_tests_nam=
e("mbuf", tests, NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1961?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
Gerrit-Change-Number: =
1961
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--OzpHslwIUZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1961?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">mbuf: don&#39;t count dereferenced=
 items in the queue length<br><br>Items of a closed instance are cleared in=
 place, because head + len is<br>the ring&#39;s insertion point=2E  mbuf_ex=
tract_item() reclaims such holes as<br>it walks past them, but nothing does=
 once no live item is left behind<br>them, so ms-&gt;len keeps counting slo=
ts that can never be sent=2E<br><br>mbuf_defined() and mbuf_peek() then dis=
agree about whether the queue<br>holds anything, and a ring made of nothing=
 but holes still looks full<br>to mbuf_add_item(), which tries to make room=
 by dropping the oldest<br>packet and finds nothing it can drop=2E<br><br>A=
 UDP socket hides this, as the IOW_MBUF write event reclaims the holes<br>o=
n its way out; a TCP-only server has nothing that does=2E<br><br>Reclaim th=
e holes once they reach the head, so a ring that holds no live<br>item at a=
ll cannot keep looking full=2E  Holes sitting behind a live item<br>are sti=
ll counted, but an extract walking past them takes them along,<br>and mbuf_=
add_item() always has the live head left to evict=2E<br><br>Change-Id: I957=
9ab9a3f588a3841bb90c9a4b930b7690e0b71<br>Signed-off-by: Gianmarco De Gregor=
i &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1961<br>Message-Id: &lt;20261005130215=2E25812-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg39710=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mbuf=2Ec<br>M tests/unit_tests/open=
vpn/test_mbuf=2Ec<br>2 files changed, 158 insertions(+), 2 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</spa=
n><br><span>index 7b790ed=2E=2E5bb397f 100644</span><br><span>--- a/src/ope=
nvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@=
 -85,6 +85,21 @@</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Dereferenced items cannot be rem=
oved from the middle of the ring, so</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * reclaim them once they reach the head: a ring left with=
out any live</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * item=
 must not keep looking full=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbuf_reclaim_=
head(struct mbuf_set *ms)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (m=
s-&gt;len &amp;&amp; !ms-&gt;array[ms-&gt;head]=2Einstance)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ms-&gt;head =3D MBUF_INDEX(ms-&gt;head, 1=
, ms-&gt;capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        --ms-&gt;len;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><=
br><span> mbuf_add_item(struct mbuf_set *ms, const struct mbuf_item *item)<=
/span><br><span> {</span><br><span>@@ -125,6 +140,7 @@</span><br><span>    =
             break;</span><br><span>             }</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbuf_recl=
aim_head(ms);</span><br><span>     }</span><br><span>     return ret;</span=
><br><span> }</span><br><span>@@ -164,5 +180,6 @@</span><br><span>         =
        msg(D_MBUF, &quot;MBUF: dereferenced queued packet&quot;);</span><b=
r><span>             }</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        mbuf_reclaim_head(ms);</span><br><spa=
n>     }</span><br><span> }</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_mbuf=2Ec b/tests/unit_tests/openvpn/test_mbuf=2Ec</span><br><sp=
an>index cba4da7=2E=2E61d438b 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_mbuf=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
mbuf=2Ec</span><br><span>@@ -136,9 +136,9 @@</span><br><span>     mbuf_dere=
ference_instance(ms, &amp;mi2);</span><br><span>     assert_int_equal(mbuf_=
buf-&gt;refcount, 2);</span><br><span>     assert_int_equal(mbuf_buf2-&gt;r=
efcount, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_int_equal(mbuf_len(ms), 3);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</span><br><span>     asser=
t_int_equal(mbuf_maximum_queued(ms), 4);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_int_equal(ms-&gt;head, 3);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 1);<=
/span><br><span>     assert_ptr_equal(mbuf_peek(ms), &amp;mi);</span><br><s=
pan> </span><br><span>     mbuf_free(ms);</span><br><span>@@ -148,12 +148,1=
51 @@</span><br><span>     mbuf_free_buf(mbuf_buf2);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a =
queue holding nothing but dereferenced items is an empty queue */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_mbuf_dereference_reclaims_queue(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =
=3D mbuf_init(4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer buf =3D alloc_buf(16);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D=
 mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =
=3D &amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ree_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0=
; i &lt; 4; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbuf_add_=
item(ms, &amp;item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(mbuf_len(ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(mbuf_buf-&gt;refcount, 5);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mbuf_dereference_instance(ms, &amp;mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(mbuf_defined(ms));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(mbuf=
_peek(ms));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(mbuf_buf-&gt;refcount, 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* the queue is empty, so this must be queued and not dropped */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &am=
p;item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_len(ms), 1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mbuf_free(ms);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* extracting =
the last live item must not leave a trailing hole behind */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_mbuf_extract_reclaims_tail(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_=
init(4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct multi_instance mi2 =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(16);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *=
mbuf_buf =3D mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =
=2Einstance =3D &amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance=
 =3D &amp;mi2 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(=
ms, &amp;item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
mbuf_add_item(ms, &amp;item2);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mbuf_dereference_instance(ms, &amp;mi2);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 2); =
/* head is still live, nothing to reclaim */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct mbuf_item out;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(mbuf_extract_item(ms, &amp;out));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(out=2Einstan=
ce, &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mb=
uf_free_buf(out=2Ebuffer);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_len(ms), 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(mbuf_defined(ms));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_null(mbuf_peek(ms));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mbuf_free(ms);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* reclaiming=
 stops at the first live item, it does not walk the whole ring */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_mbuf_extract_reclaims_up_to_live=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms=
 =3D mbuf_init(4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct multi_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct multi_instance mi2 =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
(16);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbu=
f_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct mbuf_item item =3D { =2Ebuffer =3D =
mbuf_buf, =2Einstance =3D &amp;mi };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =
=2Einstance =3D &amp;mi2 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
[mi][mi2][mi] -&gt; dereferencing mi2 leaves [mi][hole][mi] */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(=
ms, &amp;item2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 mbuf_add_item(ms, &amp;item);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mbuf_dereference_instance(ms, &amp;mi2);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 3); =
/* head is live, nothing to reclaim yet */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* extracting the head leaves the hole in front: it must be reclaim=
ed, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the w=
alk must stop at the live item behind it */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct mbuf_item out;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(mbuf_extract_item(ms, &amp;ou=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_=
equal(out=2Einstance, &amp;mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mbuf_free_buf(out=2Ebuffer);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(mbuf_len(ms), 1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(mbuf_defined(ms));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms),=
 &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Holes behind a live item are not reclaimed, so a full =
ring can still hold</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * them=2E mbuf_add_item() must cope: it evicts the live head, which drags =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * holes with it=
, rather than finding nothing to drop=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_mbuf_add_on_full_queue_with_holes(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(4);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_insta=
nce mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_instance mi2 =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct multi_instance mi3 =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
(16);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbu=
f_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct mbuf_item item =3D { =2Ebuffer =3D =
mbuf_buf, =2Einstance =3D &amp;mi };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =
=2Einstance =3D &amp;mi2 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct mbuf_item item3 =3D { =2Ebuffer =3D mbuf_buf, =2Einstanc=
e =3D &amp;mi3 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* [mi][mi2][=
mi2][mi2] -&gt; dereferencing mi2 leaves [mi][hole][hole][hole],</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * which mbuf_reclaim_head=
() cannot touch: the head is still live */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &=
amp;item2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf=
_add_item(ms, &amp;item2);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    mbuf_dereference_instance(ms, &amp;mi2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 4);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(m=
buf_len(ms), ms-&gt;capacity); /* still counts as full */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item3);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(m=
buf_peek(ms), &amp;mi3);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(=
ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_b=
uf(mbuf_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</s=
pan><br><span> main(void)</span><br><span> {</span><br><span>     const str=
uct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test(test=
_mbuf_init),</span><br><span>         cmocka_unit_test(test_mbuf_add_remove=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_mbuf_dereference_reclaims_queue),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mbuf_extract_recla=
ims_tail),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_mbuf_extract_reclaims_up_to_live),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mbuf_add_=
on_full_queue_with_holes),</span><br><span>     };</span><br><span> </span>=
<br><span>     return cmocka_run_group_tests_name(&quot;mbuf&quot;, tests, =
NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1961?usp=3Demail">change 1961</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I9579ab9a3f588a3841bb90=
c9a4b930b7690e0b71 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1961 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--OzpHslwIUZQ=--


--===============1645119203674993452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1645119203674993452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1645119203674993452==--


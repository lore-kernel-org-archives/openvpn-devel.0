Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1739CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwKXd3l3hI5//nd42Xvp9RbpEXg7hdOebHbGSGLjC5c=; b=RY2TASl5qu2zNhUExmjaoOscHF
	ErEdP0o5G6NLQf0Fkij8u6Maq8Cgh17JZ1/Zqmwc6D/ioMDitLYsxjs8NCDRZlSEYdRrE9j9I4ntu
	j7sDPghnF2ezLxzTeD5DbTbSKmgQjCKHgZ0yCKW9ty+cPm6/Fy0ZIx6S4HjQrgWkQhY8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDi7E-0007Un-3X;
	Mon, 05 Oct 2026 12:48:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDi74-0007Ud-Sv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nfw5qGM002DWNHZn9/dl43HXKuLJ2Hnv835T44APG6M=; b=QL7gyJAFWV3Nk52mK7NugfQ2kS
 WWxhhuox3nPWYUXxNg5+ZBuRrOX0XjZtiJeOpJWwfmD4ECu/a9QIV2PKq10BRcGL2u7yKA+/rOMrQ
 WVtDu6aOSgRi5eDWnF83nu1F+sdLwa5ggVcuBqlMQMFxAM1vQ01migNTO/wuDS5Rf8rY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nfw5qGM002DWNHZn9/dl43HXKuLJ2Hnv835T44APG6M=; b=g
 VHJdB1S43YZHKcG8v5d2y/+FuAnqTV5aZn0CgIhepV+6bIMCM8CkNAqSI8/RbYjEvP7oDpFYg8sxM
 BqqIrZm7mp2ushZX/sdUhpD8UUWj1Qb0dU6nlrJZ8QBGUua/5ExeA+tkBAlVoNdeXGJ8Eux+wGm8Z
 JB8Po2oGGKbjfhbg=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDi72-0007Gg-Aa for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:48:14 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01d89b23so842872f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791204485; x=1791809285; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nfw5qGM002DWNHZn9/dl43HXKuLJ2Hnv835T44APG6M=;
 b=Nfhxh/Pa3H/kCpXYCJzo2dgPOloERonRYXi5ZbJUQ1eC/ngLdJu1PMkba8qbHXYXrd
 AXbW2MIksVKZ7xq6teSNVi08HCzZzEi74yi9djmb7Kb5mAYjoQyGTbA2h1BBY1AlIbO2
 3vByoAu9wJlOrjIrOoK+Kn93JsK5W/VlgbWGwnY5HfCI7s1sn1vRyh6VooNGcioEJPYO
 VdPoXpvq+FXHOc+1X1k0BJvagPKZ16IoLzlRy3Hdq9Nk8Ie8IpaWTRaO2i6VkJCdiOOP
 zRQBN29KpqwhcFGV8ry5XWH+u6VKO+ouvcJmt4Jr7xzAgc/e/W/lbjs5bl/+IB6Gd5Mv
 pJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791204485; x=1791809285;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nfw5qGM002DWNHZn9/dl43HXKuLJ2Hnv835T44APG6M=;
 b=Yot39+jGWOUEbCFlE8HpYnk0e4Nvu0NNcWxN3mBxE/m+lSj+qG/qxigZCB9l8WYave
 FZSLbExzD9frMo2ss9v2IF70lrXTEVMizNI5E/oBdjqpRk88nHyvcEiCCOUOIqpJxOh7
 lyZpcCI8y4YP3er8h4Waz65R12zAH7HyvpCW7KniJsg4KwK43ak2sJfEfVdza4M6ZfCh
 yqQQjxq5iFEHcHEKaZihxT5DcZ90tfVBjrCPJRJNCpMq7PdbKepKLXTyxwUuIaoCFPxP
 vZbUNakOLarsY0zgndhnIwgM2LT2XRuib4p7F7mWA5+YNLIr5MMhX7fHjN+5ispGs+vF
 AjaA==
X-Gm-Message-State: AFq9FYLh4AidvlLFkYfjlhmGbknchcK1OxWoZVD+oDxJ7fbNlAiulonl
 hJfaSFBw5CDo6QeTRgBwmIXw8OEkVlVz+KhkIDvB7uEVIt1zt47h/ALMzVWrShMoXXGCbOnZl0O
 pXUGcLJFA+5gYaGYe55DTy2BBEcr6MoZrSBCMPzoRQXZQtDoqFJqVcAj4ua23/TJG1X/v
X-Gm-Gg: AYBFou304DtRNzf2jetNMtSqqEfx9eidC3bGCaNiMlnto8GV33liyj3yTHu7ZHzuw3p
 dpniSFSX40gdyOVJi3pvAu90FMSuH03xhBkjqAQSqaNYgZZBDxUurIJYekYklispxl01iEStZvh
 eVtGmoSjWxYsXqvXSaKZBSbaaHj7zubnOoKuZBzHEKWoL+dwTYSR7fX8UGGOeQnU8tSwENwCcY/
 JDJY+g0Wupqu2s8z3j+lIkpO+IqZdbx8ddVcJRfpsm63baA3GzDc93CsXH64b1QwXX5Ft5G2ghJ
 ogXoottKaTXo3UB8RRvEmew8cVxk9S80FUIgrJ47laeiYjwz2iC1P2KRvY5ICaeecgCg2rv4363
 KR+wPAxGbst6v4TKzraXBtv4I1XezQVAnxcjJNBH8XjFgmcOuoYoZ2+rCSCcgAaPJ5fktBFuT8A
 WjnlX6sv67OYCJJPeOvgduJ8nWg/puLoqml0OYo3BUBSk+gQb+lLtxkrp5EU1sW+KKc0QNYdk+C
 CQiSgYzYnnHKMbmkEbhUi11Bd6SKnLyLbMm5T3RFVy/tswHw62/XLjCcuwMbgWW27n22o7BnFex
 acTX/0fBJPGyg/D0aP2JCuH+1mb6V7H+6OYY2nTegDCQugHqpxbDvdmc1wO4JAsFe/KoPV0=
X-Received: by 2002:a05:6000:992:b0:48b:1db:b3d5 with SMTP id
 ffacd0b85a97d-48b1270eafamr16827311f8f.16.1791204484944; 
 Mon, 05 Oct 2026 05:48:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63904832sm2990660f8f.14.2026.10.05.05.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:48:04 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 12:48:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: d9769b4275aee5ef4cb47fba767b0327c795dcc3
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d390d0e64edc3aec77b10ea661d2e5d01f4a00a4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDi72-0007Gg-Aa
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0040746885501661746=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0040746885501661746==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tp1grGUqnUc="; charset=UTF-8

--tp1grGUqnUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori, plaisthos=2E

H=
ello plaisthos, 

I'd like you to reexamine a change=2E Please visit

    h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail

to look at the =
new patch set (#2)=2E


Change subject: mbuf: don't count dereferenced item=
s in the queue length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

mbuf: don't count dereferenced items in the queue length

Items =
of a closed instance are cleared in place, because head + len is
the ring's=
 insertion point=2E  mbuf_extract_item() reclaims such holes as
it walks pa=
st them, but nothing does once no live item is left behind
them, so ms->len=
 keeps counting slots that can never be sent=2E

mbuf_defined() and mbuf_pe=
ek() then disagree about whether the queue
holds anything, and a ring made =
of nothing but holes still looks full
to mbuf_add_item(), which tries to ma=
ke room by dropping the oldest
packet and finds nothing it can drop=2E

A U=
DP socket hides this, as the IOW_MBUF write event reclaims the holes
on its=
 way out; a TCP-only server has nothing that does=2E

Reclaim the holes onc=
e they reach the head, so a ring that holds no live
item at all cannot keep=
 looking full=2E  Holes sitting behind a live item
are still counted, but a=
n extract walking past them takes them along,
and mbuf_add_item() always ha=
s the live head left to evict=2E

Change-Id: I9579ab9a3f588a3841bb90c9a4b93=
0b7690e0b71
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>=

---
M src/openvpn/mbuf=2Ec
M tests/unit_tests/openvpn/test_mbuf=2Ec
2 file=
s changed, 158 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/61/1961/2

diff --git a/src/openvpn/=
mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 7b790ed=2E=2E5bb397f 100644
--- a/src=
/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -85,6 +85,21 @@
     }
 }
 =

+/*
+ * Dereferenced items cannot be removed from the middle of the ring, =
so
+ * reclaim them once they reach the head: a ring left without any live
=
+ * item must not keep looking full=2E
+ */
+static void
+mbuf_reclaim_head=
(struct mbuf_set *ms)
+{
+    while (ms->len && !ms->array[ms->head]=2Einst=
ance)
+    {
+        ms->head =3D MBUF_INDEX(ms->head, 1, ms->capacity);
+=
        --ms->len;
+    }
+}
+
 void
 mbuf_add_item(struct mbuf_set *ms, co=
nst struct mbuf_item *item)
 {
@@ -125,6 +140,7 @@
                 break;
=
             }
         }
+        mbuf_reclaim_head(ms);
     }
     retur=
n ret;
 }
@@ -164,5 +180,6 @@
                 msg(D_MBUF, "MBUF: dereferen=
ced queued packet");
             }
         }
+        mbuf_reclaim_head(m=
s);
     }
 }
diff --git a/tests/unit_tests/openvpn/test_mbuf=2Ec b/tests/u=
nit_tests/openvpn/test_mbuf=2Ec
index cba4da7=2E=2E61d438b 100644
--- a/tes=
ts/unit_tests/openvpn/test_mbuf=2Ec
+++ b/tests/unit_tests/openvpn/test_mbu=
f=2Ec
@@ -136,9 +136,9 @@
     mbuf_dereference_instance(ms, &mi2);
     as=
sert_int_equal(mbuf_buf->refcount, 2);
     assert_int_equal(mbuf_buf2->ref=
count, 1);
-    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mb=
uf_len(ms), 1);
     assert_int_equal(mbuf_maximum_queued(ms), 4);
-    ass=
ert_int_equal(ms->head, 3);
+    assert_int_equal(ms->head, 1);
     assert=
_ptr_equal(mbuf_peek(ms), &mi);
 
     mbuf_free(ms);
@@ -148,12 +148,151 @=
@
     mbuf_free_buf(mbuf_buf2);
 }
 
+/* a queue holding nothing but deref=
erenced items is an empty queue */
+static void
+test_mbuf_dereference_recl=
aims_queue(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(4);
+   =
 struct multi_instance mi =3D { 0 };
+    struct buffer buf =3D alloc_buf(1=
6);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    struct=
 mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi };
+    f=
ree_buf(&buf);
+
+    for (int i =3D 0; i < 4; ++i)
+    {
+        mbuf_ad=
d_item(ms, &item);
+    }
+    assert_int_equal(mbuf_len(ms), 4);
+    asse=
rt_int_equal(mbuf_buf->refcount, 5);
+
+    mbuf_dereference_instance(ms, &=
mi);
+
+    assert_int_equal(mbuf_len(ms), 0);
+    assert_false(mbuf_defin=
ed(ms));
+    assert_null(mbuf_peek(ms));
+    assert_int_equal(mbuf_buf->r=
efcount, 1);
+
+    /* the queue is empty, so this must be queued and not d=
ropped */
+    mbuf_add_item(ms, &item);
+    assert_int_equal(mbuf_len(ms)=
, 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(ms);
+   =
 mbuf_free_buf(mbuf_buf);
+}
+
+/* extracting the last live item must not l=
eave a trailing hole behind */
+static void
+test_mbuf_extract_reclaims_tai=
l(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(4);
+    struct m=
ulti_instance mi =3D { 0 };
+    struct multi_instance mi2 =3D { 0 };
+    =
struct buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D =
mbuf_alloc_buf(&buf);
+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_b=
uf, =2Einstance =3D &mi };
+    struct mbuf_item item2 =3D { =2Ebuffer =3D =
mbuf_buf, =2Einstance =3D &mi2 };
+    free_buf(&buf);
+
+    mbuf_add_item=
(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_dereference_instance=
(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 2); /* head is still live, =
nothing to reclaim */
+
+    struct mbuf_item out;
+    assert_true(mbuf_ex=
tract_item(ms, &out));
+    assert_ptr_equal(out=2Einstance, &mi);
+    mbu=
f_free_buf(out=2Ebuffer);
+
+    assert_int_equal(mbuf_len(ms), 0);
+    as=
sert_false(mbuf_defined(ms));
+    assert_null(mbuf_peek(ms));
+
+    mbuf_=
free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* reclaiming stops at the fi=
rst live item, it does not walk the whole ring */
+static void
+test_mbuf_e=
xtract_reclaims_up_to_live(void **state)
+{
+    struct mbuf_set *ms =3D mb=
uf_init(4);
+    struct multi_instance mi =3D { 0 };
+    struct multi_inst=
ance mi2 =3D { 0 };
+    struct buffer buf =3D alloc_buf(16);
+    struct m=
buf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    struct mbuf_item item =
=3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi };
+    struct mbuf_item =
item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi2 };
+    free_buf(&=
buf);
+
+    /* [mi][mi2][mi] -> dereferencing mi2 leaves [mi][hole][mi] */=

+    mbuf_add_item(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_a=
dd_item(ms, &item);
+    mbuf_dereference_instance(ms, &mi2);
+    assert_i=
nt_equal(mbuf_len(ms), 3); /* head is live, nothing to reclaim yet */
+
+  =
  /* extracting the head leaves the hole in front: it must be reclaimed, an=
d
+     * the walk must stop at the live item behind it */
+    struct mbuf=
_item out;
+    assert_true(mbuf_extract_item(ms, &out));
+    assert_ptr_e=
qual(out=2Einstance, &mi);
+    mbuf_free_buf(out=2Ebuffer);
+
+    assert_=
int_equal(mbuf_len(ms), 1);
+    assert_true(mbuf_defined(ms));
+    assert=
_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mb=
uf_buf);
+}
+
+/* Holes behind a live item are not reclaimed, so a full rin=
g can still hold
+ * them=2E mbuf_add_item() must cope: it evicts the live =
head, which drags the
+ * holes with it, rather than finding nothing to dro=
p=2E */
+static void
+test_mbuf_add_on_full_queue_with_holes(void **state)
=
+{
+    struct mbuf_set *ms =3D mbuf_init(4);
+    struct multi_instance mi=
 =3D { 0 };
+    struct multi_instance mi2 =3D { 0 };
+    struct multi_ins=
tance mi3 =3D { 0 };
+    struct buffer buf =3D alloc_buf(16);
+    struct =
mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    struct mbuf_item item =
=3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi };
+    struct mbuf_item =
item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi2 };
+    struct mbu=
f_item item3 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi3 };
+    fre=
e_buf(&buf);
+
+    /* [mi][mi2][mi2][mi2] -> dereferencing mi2 leaves [mi]=
[hole][hole][hole],
+     * which mbuf_reclaim_head() cannot touch: the hea=
d is still live */
+    mbuf_add_item(ms, &item);
+    mbuf_add_item(ms, &i=
tem2);
+    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &item2);
+   =
 mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 4=
);
+    assert_int_equal(mbuf_len(ms), ms->capacity); /* still counts as fu=
ll */
+
+    mbuf_add_item(ms, &item3);
+    assert_int_equal(mbuf_len(ms),=
 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi3);
+
+    mbuf_free(ms);
+   =
 mbuf_free_buf(mbuf_buf);
+}
+
 int
 main(void)
 {
     const struct CMUnit=
Test tests[] =3D {
         cmocka_unit_test(test_mbuf_init),
         cmoc=
ka_unit_test(test_mbuf_add_remove),
+        cmocka_unit_test(test_mbuf_der=
eference_reclaims_queue),
+        cmocka_unit_test(test_mbuf_extract_recla=
ims_tail),
+        cmocka_unit_test(test_mbuf_extract_reclaims_up_to_live)=
,
+        cmocka_unit_test(test_mbuf_add_on_full_queue_with_holes),
     }=
;
 
     return cmocka_run_group_tests_name("mbuf", tests, NULL, NULL);

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9579ab9a3f588a384=
1bb90c9a4b930b7690e0b71
Gerrit-Change-Number: 1961
Gerrit-PatchSet: 2
Gerri=
t-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--tp1grGUqnUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori, plaisthos=2E </p>
<p>Gianmarco =
De Gregori <strong>uploaded patch set #2</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail">View=
 Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">mbuf: don&#39;t count dereferenced items in th=
e queue length<br><br>Items of a closed instance are cleared in place, beca=
use head + len is<br>the ring&#39;s insertion point=2E  mbuf_extract_item()=
 reclaims such holes as<br>it walks past them, but nothing does once no liv=
e item is left behind<br>them, so ms-&gt;len keeps counting slots that can =
never be sent=2E<br><br>mbuf_defined() and mbuf_peek() then disagree about =
whether the queue<br>holds anything, and a ring made of nothing but holes s=
till looks full<br>to mbuf_add_item(), which tries to make room by dropping=
 the oldest<br>packet and finds nothing it can drop=2E<br><br>A UDP socket =
hides this, as the IOW_MBUF write event reclaims the holes<br>on its way ou=
t; a TCP-only server has nothing that does=2E<br><br>Reclaim the holes once=
 they reach the head, so a ring that holds no live<br>item at all cannot ke=
ep looking full=2E  Holes sitting behind a live item<br>are still counted, =
but an extract walking past them takes them along,<br>and mbuf_add_item() a=
lways has the live head left to evict=2E<br><br>Change-Id: I9579ab9a3f588a3=
841bb90c9a4b930b7690e0b71<br>Signed-off-by: Gianmarco De Gregori &lt;gianma=
rco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/mbuf=2Ec<br>M tests/unit_te=
sts/openvpn/test_mbuf=2Ec<br>2 files changed, 158 insertions(+), 2 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/61/1961/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mbuf=2Ec b=
/src/openvpn/mbuf=2Ec</span><br><span>index 7b790ed=2E=2E5bb397f 100644</sp=
an><br><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/m=
buf=2Ec</span><br><span>@@ -85,6 +85,21 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Derefe=
renced items cannot be removed from the middle of the ring, so</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * reclaim them once they reach =
the head: a ring left without any live</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * item must not keep looking full=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+mbuf_reclaim_head(struct mbuf_set *ms)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while (ms-&gt;len &amp;&amp; !ms-&gt;array[ms-&gt;head]=
=2Einstance)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms-&gt;head =
=3D MBUF_INDEX(ms-&gt;head, 1, ms-&gt;capacity);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        --ms-&gt;len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> void</span><br><span> mbuf_add_item(struct mbuf_set *ms, c=
onst struct mbuf_item *item)</span><br><span> {</span><br><span>@@ -125,6 +=
140,7 @@</span><br><span>                 break;</span><br><span>          =
   }</span><br><span>         }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        mbuf_reclaim_head(ms);</span><br><span>     }</span><br=
><span>     return ret;</span><br><span> }</span><br><span>@@ -164,5 +180,6=
 @@</span><br><span>                 msg(D_MBUF, &quot;MBUF: dereferenced q=
ueued packet&quot;);</span><br><span>             }</span><br><span>       =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbuf_rec=
laim_head(ms);</span><br><span>     }</span><br><span> }</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_mbuf=2Ec b/tests/unit_tests/openvp=
n/test_mbuf=2Ec</span><br><span>index cba4da7=2E=2E61d438b 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_mbuf=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_mbuf=2Ec</span><br><span>@@ -136,9 +136,9 @@</=
span><br><span>     mbuf_dereference_instance(ms, &amp;mi2);</span><br><spa=
n>     assert_int_equal(mbuf_buf-&gt;refcount, 2);</span><br><span>     ass=
ert_int_equal(mbuf_buf2-&gt;refcount, 1);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_int_equal(mbuf_len(ms), 3);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1=
);</span><br><span>     assert_int_equal(mbuf_maximum_queued(ms), 4);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(ms-&gt=
;head, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(ms-&gt;head, 1);</span><br><span>     assert_ptr_equal(mbuf_pee=
k(ms), &amp;mi);</span><br><span> </span><br><span>     mbuf_free(ms);</spa=
n><br><span>@@ -148,12 +148,151 @@</span><br><span>     mbuf_free_buf(mbuf_=
buf2);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* a queue holding nothing but dereferenced items i=
s an empty queue */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mbu=
f_dereference_reclaims_queue(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct mbuf_set *ms =3D mbuf_init(4);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf(16);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item =3D { =2Ebuff=
er =3D mbuf_buf, =2Einstance =3D &amp;mi };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (int i =3D 0; i &lt; 4; ++i)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        mbuf_add_item(ms, &amp;item);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 4);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&gt;refcou=
nt, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_instance(m=
s, &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_=
len(ms), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(mbuf_defined(ms));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_null(mbuf_peek(ms));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&gt;refcount, 1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* the queue is empty, so this must be qu=
eued and not dropped */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mbuf_add_item(ms, &amp;item);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &a=
mp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* extracting the last live item must not leave a trailing h=
ole behind */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mbuf_extr=
act_reclaims_tail(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct mbuf_set *ms =3D mbuf_init(4);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi2 =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf(16);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item =3D=
 { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item2 =3D { =2Ebuffe=
r =3D mbuf_buf, =2Einstance =3D &amp;mi2 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    mbuf_add_item(ms, &amp;item);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_instance(ms, &am=
p;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_len(ms), 2); /* head is still live, nothing to reclaim */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item out;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(mbuf_extract_item(m=
s, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_ptr_equal(out=2Einstance, &amp;mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mbuf_free_buf(out=2Ebuffer);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(mbuf_defined(ms));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(mbuf_pee=
k(ms));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* reclaiming stops at the first live item, it does not walk=
 the whole ring */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mbuf=
_extract_reclaims_up_to_live(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct mbuf_set *ms =3D mbuf_init(4);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi=
2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer buf =3D alloc_buf(16);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_it=
em item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item2 =3D=
 { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi2 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* [mi][mi2][mi] -&gt; dereferencing mi2 leaves [mi=
][hole][mi] */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
buf_add_item(ms, &amp;item);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    mbuf_add_item(ms, &amp;item2);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_instance(ms, &am=
p;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_len(ms), 3); /* head is live, nothing to reclaim yet */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* extracting the head leaves the hole i=
n front: it must be reclaimed, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * the walk must stop at the live item behind it */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item out=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(mb=
uf_extract_item(ms, &amp;out));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_ptr_equal(out=2Einstance, &amp;mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(out=2Ebuffer);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(mbuf_d=
efined(ms));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_ptr_equal(mbuf_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbuf_free(ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Holes behind a live item a=
re not reclaimed, so a full ring can still hold</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * them=2E mbuf_add_item() must cope: it evicts=
 the live head, which drags the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * holes with it, rather than finding nothing to drop=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_mbuf_add_on_full_queue_wit=
h_holes(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_=
set *ms =3D mbuf_init(4);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_instance mi =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct multi_instance mi2 =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi=
3 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer buf =3D alloc_buf(16);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&amp;buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_it=
em item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item2 =3D=
 { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi2 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item item3 =3D { =2Ebuff=
er =3D mbuf_buf, =2Einstance =3D &amp;mi3 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* [mi][mi2][mi2][mi2] -&gt; dereferencing mi2 leaves [mi][ho=
le][hole][hole],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * which mbuf_reclaim_head() cannot touch: the head is still live */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &am=
p;item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_ad=
d_item(ms, &amp;item2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mbuf_add_item(ms, &amp;item2);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_instance(ms, &amp;mi=
2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(mbuf_len(ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(mbuf_len(ms), ms-&gt;capacity); /* still counts as =
full */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item=
3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(mbuf_len(ms), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi3);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mbuf_free(ms);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> int</span><br><span> main(void)</span><br><span> {</span=
><br><span>     const struct CMUnitTest tests[] =3D {</span><br><span>     =
    cmocka_unit_test(test_mbuf_init),</span><br><span>         cmocka_unit_=
test(test_mbuf_add_remove),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_mbuf_dereference_reclaims_queue),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_mbuf_extract_reclaims_tail),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_mbuf_extract_reclaims_up_to_l=
ive),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_mbuf_add_on_full_queue_with_holes),</span><br><span>     };=
</span><br><span> </span><br><span>     return cmocka_run_group_tests_name(=
&quot;mbuf&quot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail">change=
 1961</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1961 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarc=
o De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori=
 &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</body></html>
--tp1grGUqnUc=--


--===============0040746885501661746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0040746885501661746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0040746885501661746==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13E6CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oc6tKOozJGINuQZB0sJn9VbyU+KoaOuZLRQjz6h5zdY=; b=StGlBeXQTOHwc1ApjDjpRIEFpk
	kgmdZAzxxuyVq9REoybbuNd+xzSHKdMdOZLl4dCcrMKyMkJfZHFZ6reNPpILrGuyYIP2FNOS072RW
	51kPCsCZWz/bWZwfBiuxMWyQ4czXKcN1ZUuQ+AmrFbjs6BTuFnTMnZlv5TUY+PNB5FO0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDr59-0005In-22;
	Mon, 05 Oct 2026 22:22:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDr57-0005Ig-HT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 22:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=C6iwDHmqe2Jg+EuNWv8GlGwhKEWwFm+3oKWqqLoa9B4=; b=as9vAlsfqns/+Hz157SqpoL8YM
 cYvB4v+9HqDHKexBYcQbeVxlBd2mGtUvETNPOROs9gyG6hjoSDTeJXIiFURIr7y9XZBqOPM6hst1h
 uYGTyyXmDMYEbSMxucuWE8OkIPvs0Lz4E5WIGi5BXVEBa1gi3hOajTXPUjJoiztZyNgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=C6iwDHmqe2Jg+EuNWv8GlGwhKEWwFm+3oKWqqLoa9B4=; b=h
 +ib3h5BZa2Kyqtmwl+pYl11WBhxc20H7rOczMWCZbSYlbx2CTaDvTTmEyW4dXvI7eK1Y5lVfh66Ad
 C/7ZvamcDcUATUaJa/k8/LRi7x7+BWqwkxm9hGn36xKoyOwxvmxbjuyNqrvTGyDraWMQMhCWhAL3+
 4Q2s4gtU/oFESSHI=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDr51-0003fM-T0 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 22:22:46 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so14985735e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791238957; x=1791843757; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C6iwDHmqe2Jg+EuNWv8GlGwhKEWwFm+3oKWqqLoa9B4=;
 b=Ba7ipJ9lIqKHRq2BLeIxxd8WH0kHe5DrwvXxY5DGZq/nIayglJaCy0L2It8AyQ9JV5
 ckEYitQYSIcITNOqaYX0u6eUkTjHfAvNmsgn5BIVbsAAnBlgNulUHg3Hfs9w9tJbgPyA
 Hat4utioETGUm6YjhUAgyLO9aOwzK9qfNMs1dC2JV5jEwpTEu7bZPM5Xprd/54UXRHyi
 DwkEFGrNJoWF319FJwPH/+L3AUbIs4fVZN1IBGnhMNinPFx5qctlwMS/yi+7AQ55FYgm
 loOqj4YwkNj53IjtX9y0RBW0RP4posiFs4xCyIrTpGWGQqvau5FoJZ7ERvIy8kk8CByD
 xChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238957; x=1791843757;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=C6iwDHmqe2Jg+EuNWv8GlGwhKEWwFm+3oKWqqLoa9B4=;
 b=y8QttLMOVPmRPpTLG+Z/t2CTZM7AJ0RzVduof/P56TZ+Ppdm39326Cb+8yjOvRXJwI
 gHmmDhx9VVRxjtT42aoGIHxUQ9V/h/ePvfPd5gtTJhHx8N5UYOMFNbw9lTfKaROJpz5G
 3cbJeO37Xjl/cNnI3/zQs+uUyK+Gp5srubXR03s4hJLq0CsK4GtIBr3L8QkW6h27ygqb
 DldR5TSLSBflrHk31njOYISAiw+lQwNsb7ym8Slfbj9dx+hhNQvJtGaEDWV7HSDDmePT
 8lTBtlDZT9vQLI30FIEPiYgzKctljVGAQhEovWQZWRw7exDFzHXH2+VHRhGkD3jloc8+
 xg+A==
X-Gm-Message-State: AFuF++npKM2oaZD12a4mqWVE0fI7DMG2axmJBD82lMNJfDI8TVGR1MO/
 uVaYy0Q/ENkWv5RXA+hSbkdIxzJVMAXTH6fl33q+hdM8+NPeTADB3VrfBt+8IbGqDK6SLzVbpBQ
 bNr/jbF4xQ8xEgQxbQVk0cKuQaTX/g1yDGrrOp4eoGjK7Y/VXIeRfsOtiTVp+zp6cM28l
X-Gm-Gg: AYBFou1PrI68kA/4VVETi22Uuf8FkUyRLvHdGcboKAP5VjSxhPp72ROOD8Z7e8G4G2N
 pc209VH4n3kDmXNW1wBXuv4dLBuzuW4dsnDX6+ASXV6+kwQjKdDSaF1U6T9r0Z54klJ2LmnrjeX
 O09cTpZwF2sfcQ0Ri2321m/CjAf3Tx4YSVo4JONGt9s2r9Kw3Wz7fN9f88vEIj5jSMiNgjmh8rK
 fVhZxz4pe758DxBWvOvMMYA38G8AWeadI58N9C/rHgYkGTA/hIcssbOE4IAt5AClt3w8jSBWr+N
 nKIoAmBFSN5qIKvackQFfsQSqK+5yBXtEf3vz6LNJ2g5a/s8xwuBH0t28IY8fncduK2wHZCwo/r
 cRT9A+xf471TLbIgac12vJPMCekwSTiaOQyWEzrcxeHZJ75vzLT2xgJ01XIpapmfKomv2rLhlzT
 3SuQu1DzJymwMj/d9UYtdlCHZQhK5zUb8wiWMILqhDYPllxJCsCKrJwQPYFN1hu79z9h+n6vfUt
 U5vFIsXVkQmTFE129KLpKldAfO0XjPc2dJoKxm+cXcN2pyUcWnrIsxivMcHUc1xedsDbKupFcjH
 2vZ8HLs+yfuYkm7O7YzdZFQ/+vUZQMWRH5FvitvG/TEAN5dCUTBiPoOsIOFhjg==
X-Received: by 2002:a05:600c:c16e:b0:4a0:13ea:2ec3 with SMTP id
 5b1f17b1804b1-4a02769ac74mr194737345e9.35.1791238956669; 
 Mon, 05 Oct 2026 15:22:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178cafaa5sm25507735e9.5.2026.10.05.15.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:22:34 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 22:22:33 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: 10bc348ce70008bb150d37ad2ce4c5891117f299
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eb7141164efdd238552223676cfd36c6439aab0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDr51-0003fM-T0
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4244342080596669717=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4244342080596669717==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wO8NbmX1nsk="; charset=UTF-8

--wO8NbmX1nsk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1961?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: mbuf: don't count=
 dereferenced items in the queue length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

mbuf: don't count dereferenced items in the qu=
eue length

Items of a closed instance are cleared in place, because head +=
 len is
the ring's insertion point=2E  mbuf_extract_item() reclaims such ho=
les as
it walks past them, but nothing does once no live item is left behin=
d
them, so ms->len keeps counting slots that can never be sent=2E

mbuf_def=
ined() and mbuf_peek() then disagree about whether the queue
holds anything=
, and a ring made of nothing but holes still looks full
to mbuf_add_item(),=
 which tries to make room by dropping the oldest
packet and finds nothing i=
t can drop=2E

A UDP socket hides this, as the IOW_MBUF write event reclaim=
s the holes
on its way out; a TCP-only server has nothing that does=2E

Rec=
laim the holes once they reach the head, so a ring that holds no live
item =
at all cannot keep looking full=2E  Holes sitting behind a live item
are st=
ill counted, but an extract walking past them takes them along,
and mbuf_ad=
d_item() always has the live head left to evict=2E

Change-Id: I9579ab9a3f5=
88a3841bb90c9a4b930b7690e0b71
Signed-off-by: Gianmarco De Gregori <gianmarc=
o@mandelbit=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961
Message-Id: <20261005=
130215=2E25812-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39710=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mbuf=2Ec
M test=
s/unit_tests/openvpn/test_mbuf=2Ec
2 files changed, 158 insertions(+), 2 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/61/1961/3

diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
in=
dex 7b790ed=2E=2E5bb397f 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvp=
n/mbuf=2Ec
@@ -85,6 +85,21 @@
     }
 }
 
+/*
+ * Dereferenced items cannot=
 be removed from the middle of the ring, so
+ * reclaim them once they reac=
h the head: a ring left without any live
+ * item must not keep looking ful=
l=2E
+ */
+static void
+mbuf_reclaim_head(struct mbuf_set *ms)
+{
+    whil=
e (ms->len && !ms->array[ms->head]=2Einstance)
+    {
+        ms->head =3D=
 MBUF_INDEX(ms->head, 1, ms->capacity);
+        --ms->len;
+    }
+}
+
 vo=
id
 mbuf_add_item(struct mbuf_set *ms, const struct mbuf_item *item)
 {
@@ =
-125,6 +140,7 @@
                 break;
             }
         }
+       =
 mbuf_reclaim_head(ms);
     }
     return ret;
 }
@@ -164,5 +180,6 @@
    =
             msg(D_MBUF, "MBUF: dereferenced queued packet");
             =
}
         }
+        mbuf_reclaim_head(ms);
     }
 }
diff --git a/tests/u=
nit_tests/openvpn/test_mbuf=2Ec b/tests/unit_tests/openvpn/test_mbuf=2Ec
in=
dex cba4da7=2E=2E61d438b 100644
--- a/tests/unit_tests/openvpn/test_mbuf=2E=
c
+++ b/tests/unit_tests/openvpn/test_mbuf=2Ec
@@ -136,9 +136,9 @@
     mbu=
f_dereference_instance(ms, &mi2);
     assert_int_equal(mbuf_buf->refcount,=
 2);
     assert_int_equal(mbuf_buf2->refcount, 1);
-    assert_int_equal(m=
buf_len(ms), 3);
+    assert_int_equal(mbuf_len(ms), 1);
     assert_int_eq=
ual(mbuf_maximum_queued(ms), 4);
-    assert_int_equal(ms->head, 3);
+    a=
ssert_int_equal(ms->head, 1);
     assert_ptr_equal(mbuf_peek(ms), &mi);
 
=
     mbuf_free(ms);
@@ -148,12 +148,151 @@
     mbuf_free_buf(mbuf_buf2);
 =
}
 
+/* a queue holding nothing but dereferenced items is an empty queue */=

+static void
+test_mbuf_dereference_reclaims_queue(void **state)
+{
+    s=
truct mbuf_set *ms =3D mbuf_init(4);
+    struct multi_instance mi =3D { 0 =
};
+    struct buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_=
buf =3D mbuf_alloc_buf(&buf);
+    struct mbuf_item item =3D { =2Ebuffer =
=3D mbuf_buf, =2Einstance =3D &mi };
+    free_buf(&buf);
+
+    for (int i=
 =3D 0; i < 4; ++i)
+    {
+        mbuf_add_item(ms, &item);
+    }
+    a=
ssert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_buf->refcount,=
 5);
+
+    mbuf_dereference_instance(ms, &mi);
+
+    assert_int_equal(mbu=
f_len(ms), 0);
+    assert_false(mbuf_defined(ms));
+    assert_null(mbuf_p=
eek(ms));
+    assert_int_equal(mbuf_buf->refcount, 1);
+
+    /* the queue=
 is empty, so this must be queued and not dropped */
+    mbuf_add_item(ms,=
 &item);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbuf=
_peek(ms), &mi);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+=
/* extracting the last live item must not leave a trailing hole behind */
+=
static void
+test_mbuf_extract_reclaims_tail(void **state)
+{
+    struct m=
buf_set *ms =3D mbuf_init(4);
+    struct multi_instance mi =3D { 0 };
+   =
 struct multi_instance mi2 =3D { 0 };
+    struct buffer buf =3D alloc_buf(=
16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    struc=
t mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi };
+    =
struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &mi2 }=
;
+    free_buf(&buf);
+
+    mbuf_add_item(ms, &item);
+    mbuf_add_item(=
ms, &item2);
+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equa=
l(mbuf_len(ms), 2); /* head is still live, nothing to reclaim */
+
+    str=
uct mbuf_item out;
+    assert_true(mbuf_extract_item(ms, &out));
+    asse=
rt_ptr_equal(out=2Einstance, &mi);
+    mbuf_free_buf(out=2Ebuffer);
+
+   =
 assert_int_equal(mbuf_len(ms), 0);
+    assert_false(mbuf_defined(ms));
+ =
   assert_null(mbuf_peek(ms));
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbu=
f_buf);
+}
+
+/* reclaiming stops at the first live item, it does not walk =
the whole ring */
+static void
+test_mbuf_extract_reclaims_up_to_live(void =
**state)
+{
+    struct mbuf_set *ms =3D mbuf_init(4);
+    struct multi_in=
stance mi =3D { 0 };
+    struct multi_instance mi2 =3D { 0 };
+    struct =
buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_al=
loc_buf(&buf);
+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2E=
instance =3D &mi };
+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_bu=
f, =2Einstance =3D &mi2 };
+    free_buf(&buf);
+
+    /* [mi][mi2][mi] -> =
dereferencing mi2 leaves [mi][hole][mi] */
+    mbuf_add_item(ms, &item);
+=
    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &item);
+    mbuf_der=
eference_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 3); /* hea=
d is live, nothing to reclaim yet */
+
+    /* extracting the head leaves t=
he hole in front: it must be reclaimed, and
+     * the walk must stop at t=
he live item behind it */
+    struct mbuf_item out;
+    assert_true(mbuf_=
extract_item(ms, &out));
+    assert_ptr_equal(out=2Einstance, &mi);
+    m=
buf_free_buf(out=2Ebuffer);
+
+    assert_int_equal(mbuf_len(ms), 1);
+    =
assert_true(mbuf_defined(ms));
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+=

+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* Holes behind a =
live item are not reclaimed, so a full ring can still hold
+ * them=2E mbuf=
_add_item() must cope: it evicts the live head, which drags the
+ * holes w=
ith it, rather than finding nothing to drop=2E */
+static void
+test_mbuf_a=
dd_on_full_queue_with_holes(void **state)
+{
+    struct mbuf_set *ms =3D m=
buf_init(4);
+    struct multi_instance mi =3D { 0 };
+    struct multi_ins=
tance mi2 =3D { 0 };
+    struct multi_instance mi3 =3D { 0 };
+    struct =
buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_al=
loc_buf(&buf);
+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2E=
instance =3D &mi };
+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_bu=
f, =2Einstance =3D &mi2 };
+    struct mbuf_item item3 =3D { =2Ebuffer =3D =
mbuf_buf, =2Einstance =3D &mi3 };
+    free_buf(&buf);
+
+    /* [mi][mi2][=
mi2][mi2] -> dereferencing mi2 leaves [mi][hole][hole][hole],
+     * which=
 mbuf_reclaim_head() cannot touch: the head is still live */
+    mbuf_add_=
item(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &it=
em2);
+    mbuf_add_item(ms, &item2);
+    mbuf_dereference_instance(ms, &m=
i2);
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_len=
(ms), ms->capacity); /* still counts as full */
+
+    mbuf_add_item(ms, &i=
tem3);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbuf_p=
eek(ms), &mi3);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
 i=
nt
 main(void)
 {
     const struct CMUnitTest tests[] =3D {
         cmock=
a_unit_test(test_mbuf_init),
         cmocka_unit_test(test_mbuf_add_remove=
),
+        cmocka_unit_test(test_mbuf_dereference_reclaims_queue),
+      =
  cmocka_unit_test(test_mbuf_extract_reclaims_tail),
+        cmocka_unit_t=
est(test_mbuf_extract_reclaims_up_to_live),
+        cmocka_unit_test(test_=
mbuf_add_on_full_queue_with_holes),
     };
 
     return cmocka_run_group_=
tests_name("mbuf", tests, NULL, NULL);

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
Gerrit-=
Change-Number: 1961
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <=
gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wO8NbmX1nsk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1961?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">mbuf: don&#39;t count dereferenced items in the queue length<br><br>It=
ems of a closed instance are cleared in place, because head + len is<br>the=
 ring&#39;s insertion point=2E  mbuf_extract_item() reclaims such holes as<=
br>it walks past them, but nothing does once no live item is left behind<br=
>them, so ms-&gt;len keeps counting slots that can never be sent=2E<br><br>=
mbuf_defined() and mbuf_peek() then disagree about whether the queue<br>hol=
ds anything, and a ring made of nothing but holes still looks full<br>to mb=
uf_add_item(), which tries to make room by dropping the oldest<br>packet an=
d finds nothing it can drop=2E<br><br>A UDP socket hides this, as the IOW_M=
BUF write event reclaims the holes<br>on its way out; a TCP-only server has=
 nothing that does=2E<br><br>Reclaim the holes once they reach the head, so=
 a ring that holds no live<br>item at all cannot keep looking full=2E  Hole=
s sitting behind a live item<br>are still counted, but an extract walking p=
ast them takes them along,<br>and mbuf_add_item() always has the live head =
left to evict=2E<br><br>Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b7=
1<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<=
br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961<br>Message-Id: &lt;202610051=
30215=2E25812-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39710=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/mbuf=2Ec<br>M tests/unit_tests/openvpn/test_mbuf=2Ec<br>2 files changed,=
 158 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/1961/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>index 7=
b790ed=2E=2E5bb397f 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</span=
><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@ -85,6 +85,21 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Dereferenced items cannot be removed from the middl=
e of the ring, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 reclaim them once they reach the head: a ring left without any live</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * item must not keep look=
ing full=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+mbuf_reclaim_head(struct mbuf_se=
t *ms)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    while (ms-&gt;len &amp;&amp=
; !ms-&gt;array[ms-&gt;head]=2Einstance)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ms-&gt;head =3D MBUF_INDEX(ms-&gt;head, 1, ms-&gt;capacity);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --ms-&gt;le=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> mbuf_add_=
item(struct mbuf_set *ms, const struct mbuf_item *item)</span><br><span> {<=
/span><br><span>@@ -125,6 +140,7 @@</span><br><span>                 break;=
</span><br><span>             }</span><br><span>         }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        mbuf_reclaim_head(ms);</span=
><br><span>     }</span><br><span>     return ret;</span><br><span> }</span=
><br><span>@@ -164,5 +180,6 @@</span><br><span>                 msg(D_MBUF,=
 &quot;MBUF: dereferenced queued packet&quot;);</span><br><span>           =
  }</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        mbuf_reclaim_head(ms);</span><br><span>     }</span><br>=
<span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_mbuf=2E=
c b/tests/unit_tests/openvpn/test_mbuf=2Ec</span><br><span>index cba4da7=2E=
=2E61d438b 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mbuf=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_mbuf=2Ec</span><br=
><span>@@ -136,9 +136,9 @@</span><br><span>     mbuf_dereference_instance(m=
s, &amp;mi2);</span><br><span>     assert_int_equal(mbuf_buf-&gt;refcount, =
2);</span><br><span>     assert_int_equal(mbuf_buf2-&gt;refcount, 1);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(mbuf_l=
en(ms), 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(mbuf_len(ms), 1);</span><br><span>     assert_int_equal(mbuf_m=
aximum_queued(ms), 4);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_int_equal(ms-&gt;head, 3);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 1);</span><br><span>  =
   assert_ptr_equal(mbuf_peek(ms), &amp;mi);</span><br><span> </span><br><s=
pan>     mbuf_free(ms);</span><br><span>@@ -148,12 +148,151 @@</span><br><s=
pan>     mbuf_free_buf(mbuf_buf2);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a queue holding noth=
ing but dereferenced items is an empty queue */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_mbuf_dereference_reclaims_queue(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(4);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_in=
stance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D alloc_buf(16);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 4; ++i)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        mbuf_add_item(ms, &amp;ite=
m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(=
ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_buf-&gt;refcount, 5);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  mbuf_dereference_instance(ms, &amp;mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(mbuf_len(ms), 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(mbuf_defined(ms));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(mbuf_peek(ms));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf=
_buf-&gt;refcount, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the queue=
 is empty, so this must be queued and not dropped */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_l=
en(ms), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_ptr_equal(mbuf_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   mbuf_free(ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* extracting the last live it=
em must not leave a trailing hole behind */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_mbuf_extract_reclaims_tail(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(4);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t multi_instance mi2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D alloc_buf(16);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf=
_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &=
amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi2 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms,=
 &amp;item2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mb=
uf_dereference_instance(ms, &amp;mi2);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 2); /* head is still =
live, nothing to reclaim */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
mbuf_item out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(mbuf_extract_item(ms, &amp;out));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_ptr_equal(out=2Einstance, &amp;mi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(out=
=2Ebuffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_l=
en(ms), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(mbuf_defined(ms));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_null(mbuf_peek(ms));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mbuf_free(ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* reclaiming stops at the f=
irst live item, it does not walk the whole ring */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_mbuf_extract_reclaims_up_to_live(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi=
_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct multi_instance mi2 =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(16);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_=
buf =3D mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Ein=
stance =3D &amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D =
&amp;mi2 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free=
_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* [mi][mi2][mi] -&=
gt; dereferencing mi2 leaves [mi][hole][mi] */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(m=
s, &amp;item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
buf_dereference_instance(ms, &amp;mi2);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 3); /* head is live,=
 nothing to reclaim yet */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extra=
cting the head leaves the hole in front: it must be reclaimed, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * the walk must stop at=
 the live item behind it */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct mbuf_item out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(mbuf_extract_item(ms, &amp;out));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(out=2Einst=
ance, &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
mbuf_free_buf(out=2Ebuffer);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(mbuf_len(ms), 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(mbuf_defined(ms));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Holes behind a live item are not reclaimed, so a full ring can still h=
old</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * them=2E mbuf_=
add_item() must cope: it evicts the live head, which drags the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * holes with it, rather than fi=
nding nothing to drop=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_mbuf_add_on_full_queue_with_holes(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct mbuf_set *ms =3D mbuf_init(4);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_=
instance mi2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct multi_instance mi3 =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(16);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_=
buf =3D mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct mbuf_item item =3D { =2Ebuffer =3D mbuf_buf, =2Ein=
stance =3D &amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct mbuf_item item2 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D =
&amp;mi2 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct mbuf_item item3 =3D { =2Ebuffer =3D mbuf_buf, =2Einstance =3D &amp;mi3 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* [mi][mi2][mi2][mi2] -&gt; =
dereferencing mi2 leaves [mi][hole][hole][hole],</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * which mbuf_reclaim_head() cannot touch:=
 the head is still live */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    mbuf_add_item(ms, &amp;item);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;item2);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &a=
mp;item2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_=
dereference_instance(ms, &amp;mi2);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 4);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), ms-&g=
t;capacity); /* still counts as full */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mbuf_add_item(ms, &amp;item3);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp=
;mi3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span>     const struct CMUnitTest te=
sts[] =3D {</span><br><span>         cmocka_unit_test(test_mbuf_init),</spa=
n><br><span>         cmocka_unit_test(test_mbuf_add_remove),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mbuf=
_dereference_reclaims_queue),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_mbuf_extract_reclaims_tail),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_mbuf_extract_reclaims_up_to_live),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_mbuf_add_on_full_queue_wit=
h_holes),</span><br><span>     };</span><br><span> </span><br><span>     re=
turn cmocka_run_group_tests_name(&quot;mbuf&quot;, tests, NULL, NULL);</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1961?usp=3Demail">change 1961</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1961?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b769=
0e0b71 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1961 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--wO8NbmX1nsk=--


--===============4244342080596669717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4244342080596669717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4244342080596669717==--

